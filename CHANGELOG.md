# Changelog
  All notable changes to this project will be documented in this file.
  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
  and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## 0.2.3
### Changed
- Setup command now creates a .gitkeep file on /changelogs/releases folder

---
## 0.2.2
### Changed
- Setup command copies a template.yml with an example data.
- Required files to gemspec
- Setup generates a gitkeep file

---
## 0.2.1
### Removed
- Unnecessary code on bin

---
## 0.2.0
### Added
- Command Line Interface (CLI) through Thor
- Rubocop
- Changelog
- Contributing guide
- License
- Code of conduct
- CodeClimate
- CI through Travis

### Changed
- All commands now are called by `codelog` command
- Updated README.md

### Removed
- Separated command to create release without deleting unreleased files
- Separated command to delete unreleased files
- Separated command to update changelog without releasing new version

---
## 0.1.0
### Added
- Automated setup to create folder structure and template
- Automated Changelog generator
- Automated Release file generator
- Automated Change file generator
- Automated unreleased files deletion
- Command to full Changelog generation flow