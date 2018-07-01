![CodeLog logo](https://raw.githubusercontent.com/codus/codelog/master/codelog.png)

[![Gem Version](https://badge.fury.io/rb/codelog.svg)](https://badge.fury.io/rb/codelog)
[![Build Status](https://travis-ci.org/codus/codelog.svg?branch=master)](https://travis-ci.org/codus/codelog)
[![Maintainability](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/maintainability)](https://codeclimate.com/github/codus/codelog/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/test_coverage)](https://codeclimate.com/github/codus/codelog/test_coverage)

A gem to help big teams to manage their chagelogs.

When many people are developing changes to compose one product release, there can be some conflicts on merging the changes added to the Changelog. These conflicts can be badly resolved by git, which could cause lost of important release notes.

This gem provides a simple way to manage changelogs, avoiding these conflicts and missplaced informations. Changes are handled as if they were "migrations" and built when releasing a version, allowing a more precise knowledge of what changes were made to what version.

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

### Creating a new change file

After the initial setup every time a change is made, the developer should run the following command in the project root path:

``` bash
$ codelog new <NAME>
```

This will generate a change file, in `YAML` format, on `changelogs/unreleased/` from the `template.yml`, named with a timestamp value followed by the given `NAME`, converted to snake case, or the default name(`change`).

The new change file should be filled with information about the implemented change, all unused topics should be erased and the file committed.

Additionally, you can pass some extra options to the `new` command. Type `codelog help new` in your console for more information.

### Releasing a version

Once all changes were merged and the release is ready to be packed, all that must be done is to run the following command:

``` bash
$ codelog release [VERSION] <RELEASE_DATE>
```
Where the `VERSION` is mandatory and represents the number of the next version of the system. An additional parameter `RELEASE_DATE` can be used, and if so, the release date of the version will be that value. You can configure the format of this parameter in the configuration file, under `changelogs/codelog.yml`.

No conflicts to resolve. All changes documented.

It will execute 3 steps:

- Generates a new release file at `changelogs/releases/` by merging all change files at `changelogs/unreleased/`
- Deletes the change files at `changelogs/unreleased/` because they now compose the new release. If it was not deleted, the change would appear repeated in the next release.
- Updates the `CHANGELOG.md` file by merging all the releases at `changelogs/releases/`.

If you don't want to specify the release version manually, you can use the `bump` command:
```bash
$ codelog bump [major|minor|patch] <RELEASE_DATE>
```
Where the first mandatory parameter is the desired release type, i.e: If you don't have any release, `codelog bump patch` will release the 0.0.1 version.

### Preview a Release

Sometimes, you just want to check the developed changes or preview how the next release will look like. To do so, you can pass the `[-p|--preview]` option on the `release` and `bump` commands. For instance, the following:

``` bash
$ codelog release 1.0.0 --preview
```
Will display a preview of your changes on your console as if the version **1.0.0** has been released.

## Configuring

Since version 0.3.0, there are a few configurations that are possible. You can choose:
- The name of the Changelog file.
- The header of the Changelog file.
- The format of the version and date on the releases.
- Whether to show the release date or not.
- The enter format for the release date.

In case you were using version 0.2.0, you will have to run:

```bash
$ codelog setup
```

## Contributing

Issue reports and pull requests are welcome on GitHub at https://github.com/codus/codelog. Read our [Contributing guide] for instructions on how to do it.

## Supported Ruby Versions

- Ruby 2.1.10+
- JRuby 9.1.14.0+

## License

This software was released under MIT License. Read [License] for further informations.

Copyright 2018 Codus. http://www.codus.com.br

You are not granted rights or licenses to the trademarks of Codus, including without limitation the Codelog name or logo.

[Contributing guide]: https://github.com/codus/codelog/blob/master/CONTRIBUTING.md
[License]: https://github.com/codus/codelog/blob/master/LICENSE
