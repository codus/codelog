# Codelog

[![Maintainability](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/maintainability)](https://codeclimate.com/github/codus/codelog/maintainability) [![Test Coverage](https://api.codeclimate.com/v1/badges/6f5885536c6b5c82f304/test_coverage)](https://codeclimate.com/github/codus/codelog/test_coverage)

This gem provides a simple way to manage changelogs, avoiding conflicts and missplaced informations. Changes are handled as if they were "migrations" and built when the version is closed, allowing a more precise knowledge of what changes were made to what version.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'codelog'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install codelog

## Setup

After the installation run the following command to generate the `changelogs` folder structure and the `template.yml` file:

``` bash
codelog setup
```

The `template.yml` file will be used to create a new entry that will compose the next version changes file when it get closed.
You should populate this template with the desired sections to compose the next versions changes to be added in the `CHANGELOG.md` file.
The template can be as the following example:

```yaml
"Features":
  - New implemented features
"Improvements":
  - Changes to previously implemented code aiming to make it better
"Fixes":
  - Changes to broken code
"Deploy notes":
  - Changes that should impact the deploy process and what should be made before it
```
## Usage

After the initial setup every time a change is made, the user should run `create_change_file` in the project root path.

This will generate a file on `changelogs/unreleased/` named with a timestamp value followed by `_change.yml`.

The generated file should be filled with the relevant data to the implementation, all unused topics should be erased and the file committed.

When closing a version you should run those 3 commands to correctly generate the changelog file and maintain the consistence:

``` bash
create_version_changelog {x.y.z}
# To create a partial changes file for the specific release under changelogs/releases/
remove_change_files
# To remove the change files that are now compiled in the partial changelog
create_full_changelog
# To generate the CHANGELOG.md file in the project root containing all version changes
```

There is an alias that runs all those 3 commands at once:
``` bash
generate_changelog {x.y.z}
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/luisbevilacqua/changelog.
