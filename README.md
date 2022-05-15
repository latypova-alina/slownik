# Slownik Crawler

Slownik crowler is a crowler collecting forms, english translation and gifs for each of the word from polish dictionary taken from https://sjp.pl/.

- Word forms are taken from http://aztekium.pl
- English translation is taken from Cloud Translation API
- Gifs are taken from Giphy API based on english word translation
- All of the results are saved to DynamoDB

## Storage

Nouns and adjectives are stored in a structure described below:
```
{
  "word": {
    "S": "kot"
  },
  "en": {
    "S": "cat"
  },
  "gifs": {
    "L": [
      {
        "S": "https://giphy.com/gifs/cat-humour-funny-ICOgUNjpvO0PC"
      },
      {
        "S": "https://giphy.com/gifs/hallmarkecards-cute-hallmark-shoebox-BzyTuYCmvSORqs1ABM"
      },
      {
        "S": "https://giphy.com/gifs/emote-catjam-jpbnoe3UIa8TU8LM13"
      }
    ]
  },
  "przypadki": {
    "M": {
      "Biernik": {
        "S": "Kot"
      },
      "Celownik": {
        "S": "Kotowi"
      },
      "Dopełniacz": {
        "S": "Kota"
      },
      "Mianownik": {
        "S": "Kot"
      },
      "Miejscownik": {
        "S": "Kocie"
      },
      "Narzędnik": {
        "S": "Kotem"
      },
      "Wołacz": {
        "S": "Kocie"
      }
    }
  }
}
```
<img width="1065" alt="Screen Shot 2022-05-16 at 00 17 13" src="https://user-images.githubusercontent.com/10632692/168497225-faed02d5-c0c7-4750-9254-80c56b45d422.png">

Verbs are stored with pronouns and times:
```
{
  "word": {
    "S": "chodzić"
  },
  "en": {
    "S": "go"
  },
  "gifs": {
    "L": [
      {
        "S": "https://giphy.com/gifs/thefastsaga-fast-and-furious-tokyo-drift-toz7qXlLyHy9n8KfKO"
      },
      {
        "S": "https://giphy.com/gifs/cbc-dragons-den-manjit-minhas-l3mZcxZKIQemTeT9S"
      },
      {
        "S": "https://giphy.com/gifs/TeamUSA-sports-usa-teamusa-Ot4U0KHw2fdvxJZ4jh"
      }
    ]
  },
  "odmiana": {
    "M": {
      "Ja": {
        "M": {
          "Czas przeszły": {
            "L": [
              {
                "S": "chodziłem"
              },
              {
                "S": "chodziłam"
              }
            ]
          },
          "Czas przyszły": {
            "L": [
              {
                "S": "będę chodził"
              },
              {
                "S": "będę chodziła"
              }
            ]
          },
          "Czas teraźniejszy": {
            "L": [
              {
                "S": "chodzę"
              }
            ]
          }
        }
      },
      "My": {
        "M": {
          "Czas przeszły": {
            "L": [
              {
                "S": "chodziliśmy"
              },
              {
                "S": "chodziłyśmy"
              }
            ]
          },
          ...
      ...
    }
  }
}
```

<img width="633" alt="Screen Shot 2022-05-16 at 00 46 51" src="https://user-images.githubusercontent.com/10632692/168497243-d00ee3c0-7c69-4085-a539-1fa4ecf521f4.png">

To run the script do the following:
1) ```cp .env.test .env```
2) `bundle install`
2) Fill in all the credentials in .env file
    `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` are located in `Security Credentials` menu in you AWS account
    `TRANSLATE_PROJECT` is a name of your project in Translate Googleapis credentials
    `TRANSLATE_CREDENTIALS` is a path to json file taken from Googleapis credentials
    `GIF_API_KEY` is a key taken from Giphy API credentials
3) Run `bin/setup_db` to create a table in DynamoDB
4) Run `bin/clear_words` to run the script which removes unneeded words from the dictionary and creates a file `lib/resouces/cleared_words.txt`
5) Run `bin/store_words`. That will ask you for an initial amount of Translate requests, you can type  in `0` if you don't have any. You can see your amounnt of Translate requests on your Googleapis dasboard. That will help to count a correct offset for the `store_words` script. That's necessary in case the script was interrupted so that you don't rewrite the existing words. <img width="1133" alt="Screen Shot 2022-05-16 at 00 30 39" src="https://user-images.githubusercontent.com/10632692/168496845-004daf51-c9e9-4f25-9853-6e8b42d45929.png">
If you know exactly the line the script was interrupted, you can comment [this line](offset_line) and substitude it with `offset = <line_number> / THREADS_AMOUNT`


## Troubleshooting
In case the `bin/` scripts are not executed, try to make them executable by running `chmod +x bin/setup_db`

[v]: <https://github.com/latypova-alina/slownik/blob/master/bin/store_words#L42>
