# How to contribute to CodeLog

We at Codus welcome all kinds of contributions. By participating you agree to follow our [code of conduct].

If you find an issue, have an idea for a new feature or any improvement, we would like to hear from you. You can report these as issues or submit pull requests. In order to help us maintain an organized process, please read the following guidelines before submiting any of those.

## Reporting Issues

Before reporting new issues, please verify if there are existing issues for the same problem by searching at [issues].

To help us attend you quickly, please make sure to give a clear name to the issue and to describe it with all relevant information. Giving examples can help us understand your suggestion or, in case of issues, reproduce the problem.

## Sending Pull Requests

First check the Network at Insights tab to see if there are anyone already working on the same feature/fix you want to submit.

Then look at [issues] to see if there are any related issues that your feature/fix should consider. If there are none, please create one describing your implementations intent. You should always mention a related issue in the pull request description.

While writing code, follow the code conventions that you find in the existing code. It make it easier to read. Try to write short, clear and objective commit messages too. You can squash your commits and improve your commit messages once your done.

Also make sure to add good tests to your new code. Only refactoring of tested features and documentation do not need new tests. These way your changes will be documented and future changes will not break what you added.

### Step-by-step

- Fork the repository.
- Commit and push until your are proud of what you have done.
- Execute the full test suite to ensure all is passing.
- Make sure your code does not produce RuboCop offenses.
- Squash commits if necessary.
- If what you are submit is a noteworthy change, then create a [change] for us to add to the release notes. If you are not sure, create a change anyway.
- Push to your repository.
- Open a pull request to the master of the gem's repository.
- Give your pull request a good description. Do not forget to mention a related issue.

## Running Tests

Once you cloned the gem at your local machine you should run the following command at its root folder:

``` bash
$ bundle
```

After that, you can run the tests suite also at the root folder by:

``` bash
$ rspec
```

## Adding entry to Changelog

As we can add more than one pull request in a release, we ask you to simply add a change file living us to generate the release file and update the changelog. You can do it by following the following steps:

- Run `codelog new`.
- Describe your changes in the generated change file following the template.
- Commit it too.

Not every change should be a entry in the changelog. Only the ones that impact end users.
We use and recommend the changelog format proposed at [Keep a Changelog].

[code of conduct]: https://github.com/codus/codelog/blob/master/CODE_OF_CONDUCT.md
[issues]: https://github.com/codus/codelog/issues
[change]: #adding-entry-to-changelog
[Keep a Changelog]: http://keepachangelog.com/en/1.0.0/