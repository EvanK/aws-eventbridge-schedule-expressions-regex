# AWS EventBridge Schedule Expression Validation with Regular Expressions

As this is intended for use in CloudFormation templates (as an `AllowedPattern`), we are aiming for compatibility with [Java's regular expression syntax](https://docs.oracle.com/javase/6/docs/api/java/util/regex/Pattern.html).

However, due to the massive complexity and sheer scope of the overall expression we are maintiaining here, it will be broken up into various pieces for the `cron()` portion and versioned as native Perl regex.

The most recent working version of this pattern is also available (with unit tests!) on [Regex101](https://regex101.com/r/YHscM3/2).

## Project Structure

The complete pattern can be found in `main.pl`, in two different forms and assigned to two different global variables:

- `$expanded` - here, the complete pattern is broken out across multiple lines and commented heavily (using the `/x` flag) for readability
- `$collapsed` - here, any non-leading and non-trailing comments and whitespace have been removed, making it fit for copy and paste elsewhere

Due to the complexity of the `cron()` matching, each individual _field_ of the cron format has been broken out into its own file under the `cron` directory:

```
./cron
├── daysofmonth.pl
├── daysofweek.pl
├── hours.pl
├── minutes.pl
├── months.pl
└── years.pl
```

These individual field patterns are then merged back into the main pattern manually.

## Testing

Currently, several valid `rate` and `cron` patterns are recorded as "positive" test cases as well as several invalid patterns as "negative" cases in tab delimited files under the `tests` directory.

You can test them against the latest complete patterns (again, housed in `main.pl`) by running the test script:

```shell
perl test.pl
# outputs TAP formatted results...
```

## Building

The current multiline pattern can be condensed into a single line format (and compared against the currently versioned collapsed pattern) by running the build script:

> Note: you may need to install the `Text::Diff` CPAN module in order for this script to run successfully

```shell
perl build.pl
# prints a diff if anything in the main pattern has changed
# subsequently prints the condensed pattern to stdout
```
