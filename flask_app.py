import sys
import time
import logging
from datetime import datetime

from flask import Flask
from flask import Response
from flask import jsonify
from flask import make_response
from flask import request

from fairseq.models.transformer import TransformerModel

logging.basicConfig(
    format='%(asctime)s | %(levelname)s | %(name)s | %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',
    level=logging.INFO,
    stream=sys.stdout,
)
logger = logging.getLogger(__name__)


app = Flask(__name__)

model = TransformerModel.from_pretrained(
        'checkpoints',
        'checkpoint_best.pt',
        data_name_or_path='data-bin/iwslt14.tokenized.de-en',
        bpe='subword_nmt',
        bpe_codes='iwslt14.tokenized.de-en/code',
        remove_bpe=True,
        source_lang='de',
        target_lang='en',
        beam=30,
        nbest=1,
        cpu=True
)

@app.route('/health', methods=['GET'])
def health():
    try:
        model.translate('danke', verbose=True)
        return Response('OK', status=200)
    except:
        logger.exception('Error in /health')
        return Response('ERROR', status=500)


@app.route('/translate', methods=['GET'])
def translate():

    timers = {'total': -time.time()}
    logger.info(str(datetime.now()) + ' received parameters: ' + str(request.args))

    query = request.args.get('q', '').strip().lower()

    if not query:
        raise BadRequest('Query is empty.')

    res = model.translate(query, verbose=True)
    rv = {'result': res}
    timers['total'] += time.time()
    resp = make_response(jsonify(rv))
    return resp

if __name__ == "__main__":
    app.run(debug=False, host='0.0.0.0', port=5003, use_reloader=True, threaded=False)
