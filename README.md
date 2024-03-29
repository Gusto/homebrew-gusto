# Homebrew with Gusto

This is a collection of homebrew formulas that we use at Gusto, we maintain these because:
* We have to slightly adjust what's available upstream
* We have to lock to a version no longer available upstream
* We have to distribute tools without generally available packaging

## How do I install these formulae?

From the command line:

```shell
brew tap gusto/gusto git@github.com:Gusto/homebrew-gusto.git
brew install <formula>
```

From a `Brewfile`:

```ruby
tap "gusto/gusto", "git@github.com:Gusto/homebrew-gusto.git"

brew "<formula>"
```

## How to develop locally

Create symlink to Taps directory
```
ln -s /path/to/local/homebrew-gusto `brew --repo`/Library/Taps/gusto/homebrew-gustotest
```

Install local formula
```
brew install gusto/gustotest/<formula>
```


## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
