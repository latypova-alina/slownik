#Data

The `data` folder consists of a script for cleaning the original dictionary and resources which will be produced in a result of clearing the vocabulary.

The original dictionary is taken from here - https://sjp.pl/sl/ort/

You can clear the dictionary by running the script:

```sh
cd clear_words
ruby run.rb
```

That will create(rewrite) a file in resources folder `cleared_words.txt` consisting the words which will be used as a base for **Slownik** dictionary.
