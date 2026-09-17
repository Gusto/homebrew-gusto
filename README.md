# Homebrew with Gusto

This is a collection of homebrew formulas that we use at Gusto, we maintain these because:
* We have to slightly adjust what's available upstream
* We have to lock to a version no longer available upstream
* We have to distribute tools without generally available packaging

## Apple Silicon

Every formula here must produce a binary that runs natively on `arm64`. Prefer
formulae that build from source, ship a universal binary, or run on a VM such as
the JVM.

Be careful with formulae that unpack a prebuilt vendor `.pkg` or tarball. Homebrew
will link an x86_64-only payload without complaint, and the failure only shows up
at runtime as `bad CPU type in executable`. `brew audit` does catch this via its
mismatched-binary check, so do not silence that check with an
`audit_exceptions/mismatched_binary_allowlist.json` entry -- fix the formula instead.

Known exception: `Casks/gusto-wkhtmltopdf.rb` is x86_64-only because upstream
archived the project without ever shipping an arm64 build. It requires Rosetta 2
and is deprecated pending replacement of the dependency.

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
