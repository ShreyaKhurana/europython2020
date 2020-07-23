# europython2020
Talk contents for EuroPython 2020

You may want to check the [Fairseq documentation] (https://github.com/pytorch/fairseq/tree/master/fairseq) first. We'll use their bash scripts to preprocess (prepare-iwslt14.sh, preprocess.sh), train (train.sh) and evaluate (evaluate.sh)

Once you get a model trained for some epochs, store the best model checkpoint in this directory `checkpoints/`

Then update your .dockerignore file as necesssary. And run the following commands:
```
docker build -t mock_app:latest .
docker run -d -p 8002:8002 --name mock mock_app:latest
```

You can now call your model using http: 

`curl http://localhost:8002/translate?q=Mein+name+ist+shreya`
