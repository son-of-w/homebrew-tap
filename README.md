# Homebrew tap for son

[son](https://github.com/son-of-w/son) is one memory for every AI agent: a local store of decisions, patterns, facts and todos.

## Install

```sh
brew install son-of-w/tap/son
```

Then run `son init` to set up your agents.

## Upgrade

```sh
brew upgrade son
```

Then run `son init` again.

## Remove

Run `son uninstall` first: it takes son out of your agents' files. Then:

```sh
brew uninstall son
```

Your memory in `~/.son-of-w` stays until you delete it.

The formula in `Formula/son.rb` is written by the release workflow of `son-of-w/son`. Do not edit it by hand. Report problems at https://github.com/son-of-w/son/issues.
