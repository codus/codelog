# Codelog
[![Build Status](https://travis-ci.org/codus/codelog.svg?branch=master)](https://travis-ci.org/codus/codelog)
[![Maintainability](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/maintainability)](https://codeclimate.com/github/codus/codelog/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/test_coverage)](https://codeclimate.com/github/codus/codelog/test_coverage)

This gem provides a simple way to manage changelogs, avoiding conflicts and missplaced informations. Changes are handled as if they were "migrations" and built when releasing a version, allowing a more precise knowledge of what changes were made to what version.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codelog'
```

And then execute:

``` bash
$ bundle
```

Or install it yourself as:

``` bash
$ gem install codelog
```

## Setup

After the installation run the following command to generate the `changelogs` folder structure and the `template.yml` file:

``` bash
$ codelog setup
```

The `template.yml` file will be used to create a new change file. Change files from `unreleased` folder will compose the next release file when generated.
You should populate this template with the sections and topic examples desired for describe the current release that will be later added in the `CHANGELOG.md` file.
The template can be as the following example:

```yaml
"Added":
  - New features implemented

"Changed":
  - Changes to existing feature

"Deprecated":
  - Features that are soon to be removed

"Removed":
  - Features that were removed

"Fixed":
  - Changes to broken code

"Security":
  - Changes that fix vulnerabilities

"Deploy notes":
  - Changes that should impact the deploy process and what should be made before it
```

## Usage

After the initial setup every time a change is made, the user should run the following command in the project root path:

``` bash
$ codelog new
```

This will generate a change file on `changelogs/unreleased/` from the `template.yml` named with a timestamp value followed by `_change.yml`.

The new change file should be filled with informations about the implemented change, all unused topics should be erased and the file committed.

When closing a version you should run the following command:

``` bash
$ codelog generate -v {x.y.z}
```

It will execute 3 complamentary actions:

- Generate a new release file at `changelogs/releases/` by merging all change files at `changelogs/unreleased/`
- Deletes the change files at `changelogs/unreleased/` because they now compose the new release. If it was not deleted, the change would appear repeated in the next release.
- Updates the `CHANGELOG.md` file by merging all the releases at `changelogs/releases/`.

You can also run the `generate` parcialy using the other command options. To see all the options, consult the manual with the following command:

``` bash
$ codelog help generate
```

## Contributing

Issue reports and pull requests are welcome on GitHub at https://github.com/codus/codelog. Read our [Contributing guide] for instructions on how to do it.

## License

This software was released under MIT License. Read [License] for further informations.

[Contributing guide]: https://github.com/codus/codelog/blob/master/CONTRIBUTING.md
[License]: https://github.com/codus/codelog/blob/master/LICENSE