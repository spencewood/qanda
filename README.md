## Questions and Answers

Generates a "questions" and "answers" file based on a word list file. Answers will contain fragments of four characters represented exactly once across all words in the words file. The answers file will list the corresponding words from the word file that the fragment matches came from. Each fragment and word will be on individual lines in their respective files.

### Run

The qanda.rb library contains all logic for the word parser and file generator. To run, use the command line tool: generate.rb

```
$ ./generate.rb
```

### Options

Available command line options:

```
$ ./generate.rb --help

Usage: generate.rb [options]
        --word-file FILE             FILE with word list to parse. Will default to "words".
    -i, --ignore-case                Convert fragments to lowercase to avoid duplicate case matches.
    -a, --skip-apos                  Skip adding any fragments with an apostrophe.
    -n, --skip-num                   Skip adding any fragments with numbers.
```

### Tests

Specs are in the spec folder. Make sure to update your bundle and run rspec.

```
$ bundle install
$ rspec
```