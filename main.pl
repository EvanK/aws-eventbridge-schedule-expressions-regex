use strict;
use warnings;

# main regular expression, extended over multiple lines and heavily commented
our $expanded = qr`

^
# a single full rate expression
# rates are pretty simple, a number and a unit of time broken by any amount of whitespace
(?:
    # note that we are escaping literal parentheses by enclosing in a character class, to avoid backslash escaping
    # (backslash escapes can get tricky when embedding regex into a string or json document)
    rate[(]
        (?:
            # a single unit of time 
            (?:
                1
                [ ]+
                (hour|minute|day)
            )
            |
            # OR multiples of same units of time
            (?:
                [0-9]+
                [ ]+
                (hours|minutes|days)
            )
        )
    [)]
)
|
# OR single full cron() expression
# Each FIELD in the cron expression is broken up by whitespace: (minutes hours daysOfMonth months daysOfWeek years)
# At its smallest component, each field is made up of multiple single UNITs
#   (eg a year "2024", month "7" or "JUL", day of week "1" or "SUN", etc)
#   or the ANY wildcard "*"
# From the top down, each field is made up one or more unit EXPRESSIONs, broken up by commas: 2022/3,2026,2029-2030
# Each unit expression is subsequently made up of either:
# - a range of two individual units, broken by a hyphen: 2029-2030
# - an increment of a unit, broken by a slash (where the increment itself is any integer): 2022/3
# So a perfectly valid field might look like: 2021,2022/3,2026,2029-2030,2032
# - "2021" "2026" and "2032" are all single units
# - "2022/3" is an INCREMENT of every third year starting from 2022 (so 2025, then 2028, then 2031, etc)
# - "2029-2031" is a RANGE starting from 2029 and ending at 2031
(?:
    cron[(]
        #### top-level minutes field
        # field, any number of expressions broken by literal comma
        (?:
            ### first unit expression, either range of two units or increment of a single unit
            ## first single minute unit
            (?:
                # number between 0-59
                (?:
                    # single digit num from 0-9 OR double digit num whose first digit is 0 through 5
                    [0-5]?
                    [0-9]
                )
                |
                # OR asterisk wildcard (aka, "any value for this unit")
                [*]
            )
            ## end first single minute unit
            # optional second unit (range) or increment
            (?:
                # range, a literal dash followed by ANOTHER single unit
                (?:
                    [-]
                    ## second single minute unit
                    (?:
                        # number between 0-59
                        (?:
                            # single digit num from 0-9 OR double digit num whose first digit is 0 through 5
                            [0-5]?
                            [0-9]
                        )
                        |
                        # OR asterisk wildcard (aka, "any value for this unit")
                        [*]
                    )
                    ## end second single minute unit
                )
                |
                # OR increment, a literal slash followed by integer increment value
                (?:
                    [/]
                    [0-9]+
                )
            )?
            ### end first unit expression
            (?:
                [,]
                ### second unit expression, either range of two units or increment of a single unit
                ## first single minute unit
                (?:
                    # number between 0-59
                    (?:
                        # single digit num from 0-9 OR double digit num whose first digit is 0 through 5
                        [0-5]?
                        [0-9]
                    )
                    |
                    # OR asterisk wildcard (aka, "any value for this unit")
                    [*]
                )
                ## end first single minute unit
                # optional second unit (range) or increment
                (?:
                    # range, a literal dash followed by ANOTHER single unit
                    (?:
                        [-]
                        ## second single minute unit
                        (?:
                            # number between 0-59
                            (?:
                                # single digit num from 0-9 OR double digit num whose first digit is 0 through 5
                                [0-5]?
                                [0-9]
                            )
                            |
                            # OR asterisk wildcard (aka, "any value for this unit")
                            [*]
                        )
                        ## end second single minute unit
                    )
                    |
                    # OR increment, a literal slash followed by an integer increment value
                    (?:
                        [/]
                        [0-9]+
                    )
                )?
                ### end second unit expression
            )*
        )
        #### end top-level minutes field

        # one or more delimiting whitespace
        [ ]+

        #### top-level hours field
        # field, any number of expressions broken by literal comma
        (?:
            ### first unit expression, either range of two units or increment of a single unit
            ## first single hour unit
            (?:
                # number between 0-23
                (?:
                    # single digit num from 0-9 OR double digit num whose first digit is 0 through 2
                    [0-2]?
                    [0-9]
                )
                |
                # OR asterisk wildcard
                [*]
            )
            ## end first single hour unit
            # optional second unit (range) or increment
            (?:
                # range, a literal dash followed by ANOTHER single unit
                (?:
                    [-]
                    ## second single hour unit
                    (?:
                        # number between 0-23
                        (?:
                            # single digit num from 0-9 OR double digit num whose first digit is 0 through 2
                            [0-2]?
                            [0-9]
                        )
                        |
                        # OR asterisk wildcard
                        [*]
                    )
                    ## end second single hour unit
                )
                |
                # OR increment, a literal slash followed by integer increment value
                (?:
                    [/]
                    [0-9]+
                )
            )?
            ### end first unit expression
            (?:
                [,]
                ### second unit expression, either range of two units or increment of a single unit
                ## first single hour unit
                (?:
                    # number between 0-23
                    (?:
                        # single digit num from 0-9 OR double digit num whose first digit is 0 through 2
                        [0-2]?
                        [0-9]
                    )
                    |
                    # OR asterisk wildcard
                    [*]
                )
                ## end first single hour unit
                # optional second unit (range) or increment
                (?:
                    # range, a literal dash followed by ANOTHER single unit
                    (?:
                        [-]
                        ## second single hour unit
                        (?:
                            # number between 0-23
                            (?:
                                # single digit num from 0-9 OR double digit num whose first digit is 0 through 2
                                [0-2]?
                                [0-9]
                            )
                            |
                            # OR asterisk wildcard
                            [*]
                        )
                        ## end second single hour unit
                    )
                    |
                    # OR increment, a literal slash followed by integer increment value
                    (?:
                        [/]
                        [0-9]+
                    )
                )?
                ### end second unit expression
            )*
        )
        #### end top-level hours field

        # one or more delimiting whitespace
        [ ]+

        # combined nest of (ostensibly top-level) day of month, month, day of week fields
        # this ensures EITHER day of week OR of month MUST be literal question-mark
        (?:
            # first parent case...
            (?:
                # literal question-mark for days of month field
                [?]

                # one or more delimiting whitespace
                [ ]+

                #### top-level months field
                # field, any number of expressions broken by literal comma
                (?:
                    ### first unit expression, either range of two units or increment of a single unit
                    ## first single month unit
                    (?:
                        # number (roughly) between 1-12
                        (?:
                            # single digit num from 0-9 OR double digit num whose first digit is 1
                            [1]?
                            [0-9]
                        )
                        |
                        # OR month short name
                        (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                        |
                        # OR asterisk wildcard
                        [*]
                    )
                    ## end first single month unit
                    # optional second unit (range) or increment
                    (?:
                        # range, a literal dash followed by ANOTHER single unit (optionally followed by an ignored increment)
                        (?:
                            [-]
                            ## second single month unit
                            (?:
                                # number (roughly) between 1-12
                                (?:
                                    # single digit num from 0-9 OR double digit num whose first digit is 1
                                    [1]?
                                    [0-9]
                                )
                                |
                                # OR month short name
                                (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                                |
                                # OR asterisk wildcard
                                [*]
                            )
                            ## end second single month unit
                            # optional (ignored) increment, immediately following said range
                            (?:
                                [/]
                                [0-9]+
                            )?
                        )
                        |
                        # OR increment, a literal slash followed by integer increment value
                        (?:
                            [/]
                            [0-9]+
                        )
                    )?
                    ### end unit expression
                    (?:
                        [,]
                        ### second unit expression, either range of two units or increment of a single unit
                        ## first single month unit
                        (?:
                            # number (roughly) between 1-12
                            (?:
                                # single digit num from 0-9 OR double digit num whose first digit is 1
                                [1]?
                                [0-9]
                            )
                            |
                            # OR month short name
                            (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                            |
                            # OR asterisk wildcard
                            [*]
                        )
                        ## end first single month unit
                        # optional second unit (range) or increment
                        (?:
                            # range, a literal dash followed by ANOTHER single unit (optionally followed by an ignored increment)
                            (?:
                                [-]
                                ## second single month unit
                                (?:
                                    # number (roughly) between 1-12
                                    (?:
                                        # single digit num from 0-9 OR double digit num whose first digit is 1
                                        [1]?
                                        [0-9]
                                    )
                                    |
                                    # OR month short name
                                    (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                                    |
                                    # OR asterisk wildcard
                                    [*]
                                )
                                ## end second single month unit
                                # optional (ignored) increment, immediately following said range
                                (?:
                                    [/]
                                    [0-9]+
                                )?
                            )
                            |
                            # OR increment, a literal slash followed by integer increment value
                            (?:
                                [/]
                                [0-9]+
                            )
                        )?
                        ### end unit expression
                    )*
                )
                #### end top-level months field

                # one or more delimiting whitespace
                [ ]+

                #### top-level days of week field
                # field, one of two special cases...
                (?:
                    # hash wildcard, mutually exclusive to unit expressions
                    (?:
                        ## special case single day of week unit (without L or asterisk wildcards)
                        (?:
                            # number between 1-7
                            [1-7]
                            |
                            # OR day of week short name
                            (?:SUN|MON|TUE|WED|THU|FRI|SAT)
                        )
                        ## end special case single day of week unit
                        # literal hash delimiter
                        [#]
                        # instance of above day of week WITHIN the month
                        [0-5]
                    )
                    |
                    # OR any number of expressions broken by literal comma
                    (?:
                        ### first unit expression, either range of two units or increment of a single unit
                        ## first single day of week unit
                        (?:
                            (?:
                                (?:
                                    # number between 1-7
                                    [1-7]
                                    |
                                    # OR day of week short name
                                    (?:SUN|MON|TUE|WED|THU|FRI|SAT)
                                )
                                # followed by zero or one wildcard of L (last specified day of week within the month)
                                L?
                            )
                            |
                            # OR standalone wildcard of L (last day in week) or asterisk
                            [L*]
                        )
                        ## end first single day of week unit
                        # optional second unit (range) or increment
                        (?:
                            # range, a literal dash followed by ANOTHER single unit
                            (?:
                                [-]
                                ## single second day of week unit
                                (?:
                                    (?:
                                        (?:
                                            # number between 1-7
                                            [1-7]
                                            |
                                            # OR day of week short name
                                            (?:SUN|MON|TUE|WED|THU|FRI|SAT)
                                        )
                                        # followed by zero or one wildcard of L (last specified day of week within the month)
                                        L?
                                    )
                                    |
                                    # OR standalone wildcard of L (last day in week) or asterisk
                                    [L*]
                                )
                                ## end second single day of week unit
                            )
                            |
                            # OR increment, a literal slash followed by integer increment value
                            (?:
                                [/]
                                [0-9]+
                            )
                        )?
                        ### end unit expression
                        (?:
                            [,]
                            ### second unit expression, either range of two units or increment of a single unit
                            ## first single day of week unit
                            (?:
                                (?:
                                    (?:
                                        # number between 1-7
                                        [1-7]
                                        |
                                        # OR day of week short name
                                        (?:SUN|MON|TUE|WED|THU|FRI|SAT)
                                    )
                                    # followed by zero or one wildcard of L (last specified day of week within the month)
                                    L?
                                )
                                |
                                # OR standalone wildcard of L (last day in week) or asterisk
                                [L*]
                            )
                            ## end first single day of week unit
                            # optional second unit (range) or increment
                            (?:
                                # range, a literal dash followed by ANOTHER single unit
                                (?:
                                    [-]
                                    ## single second day of week unit
                                    (?:
                                        (?:
                                            (?:
                                                # number between 1-7
                                                [1-7]
                                                |
                                                # OR day of week short name
                                                (?:SUN|MON|TUE|WED|THU|FRI|SAT)
                                            )
                                            # followed by zero or one wildcard of L (last specified day of week within the month)
                                            L?
                                        )
                                        |
                                        # OR standalone wildcard of L (last day in week) or asterisk
                                        [L*]
                                    )
                                    ## end second single day of week unit
                                )
                                |
                                # OR increment, a literal slash followed by integer increment value
                                (?:
                                    [/]
                                    [0-9]+
                                )
                            )?
                            ### end unit expression
                        )*
                    )
                )
                #### end top-level days of week field
            )
            |
            # OR second parent case...
            (?:
                #### top-level days of month field
                # field, any number of expressions broken by literal comma
                (?:
                    ### first unit expression, either range of two units or increment of a single unit
                    ## first single day of month unit
                    (?:
                        (?:
                            # number (roughly) between 1-31
                            (?:
                                # single digit num from 0-9 OR double digit num whose first digit is between 1 and 3
                                [1-3]?
                                [0-9]
                            )
                            # followed by zero or one W wildcard (weekday)
                            W?
                        )
                        |
                        # OR ordered combo of L and W wildcards (last weekday of month)
                        LW
                        |
                        # OR standalone wildcard of L (last day of month) or asterisk (any)
                        [L*]
                    )
                    ## end single day of month unit
                    # optional second unit (range) or increment
                    (?:
                        # range, a literal dash followed by ANOTHER single unit
                        (?:
                            [-]
                            ## second single day of month unit
                            (?:
                                (?:
                                    # number (roughly) between 1-31
                                    (?:
                                        # single digit num from 0-9 OR double digit num whose first digit is between 1 and 3
                                        [1-3]?
                                        [0-9]
                                    )
                                    # followed by zero or one W wildcard (weekday)
                                    W?
                                )
                                |
                                # OR ordered combo of L and W wildcards (last weekday of month)
                                LW
                                |
                                # OR standalone wildcard of L (last day of month) or asterisk (any)
                                [L*]
                            )
                            ## end second single day of month unit
                        )
                        |
                        # OR increment, a literal slash followed by integer increment value
                        (?:
                            [/]
                            [0-9]+
                        )
                    )?
                    ### end first unit expression
                    (?:
                        [,]
                        ### second unit expression, either range of two units or increment of a single unit
                        ## first single day of month unit
                        (?:
                            (?:
                                # number (roughly) between 1-31
                                (?:
                                    # single digit num from 0-9 OR double digit num whose first digit is between 1 and 3
                                    [1-3]?
                                    [0-9]
                                )
                                # followed by zero or one W wildcard (weekday)
                                W?
                            )
                            |
                            # OR ordered combo of L and W wildcards (last weekday of month)
                            LW
                            |
                            # OR standalone wildcard of L (last day of month) or asterisk (any)
                            [L*]
                        )
                        ## end single day of month unit
                        # optional second unit (range) or increment
                        (?:
                            # range, a literal dash followed by ANOTHER single unit
                            (?:
                                [-]
                                ## second single day of month unit
                                (?:
                                    (?:
                                        # number (roughly) between 1-31
                                        (?:
                                            # single digit num from 0-9 OR double digit num whose first digit is between 1 and 3
                                            [1-3]?
                                            [0-9]
                                        )
                                        # followed by zero or one W wildcard (weekday)
                                        W?
                                    )
                                    |
                                    # OR ordered combo of L and W wildcards (last weekday of month)
                                    LW
                                    |
                                    # OR standalone wildcard of L (last day of month) or asterisk (any)
                                    [L*]
                                )
                                ## end second single day of month unit
                            )
                            |
                            # OR increment, a literal slash followed by integer increment value
                            (?:
                                [/]
                                [0-9]+
                            )
                        )?
                        ### end second unit expression
                    )*
                )
                #### end top-level days of month field

                # one or more delimiting whitespace
                [ ]+

                #### top-level months field
                # field, any number of expressions broken by literal comma
                (?:
                    ### first unit expression, either range of two units or increment of a single unit
                    ## first single month unit
                    (?:
                        # number (roughly) between 1-12
                        (?:
                            # single digit num from 0-9 OR double digit num whose first digit is 1
                            [1]?
                            [0-9]
                        )
                        |
                        # OR month short name
                        (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                        |
                        # OR asterisk wildcard
                        [*]
                    )
                    ## end first single month unit
                    # optional second unit (range) or increment
                    (?:
                        # range, a literal dash followed by ANOTHER single unit (optionally followed by an ignored increment)
                        (?:
                            [-]
                            ## second single month unit
                            (?:
                                # number (roughly) between 1-12
                                (?:
                                    # single digit num from 0-9 OR double digit num whose first digit is 1
                                    [1]?
                                    [0-9]
                                )
                                |
                                # OR month short name
                                (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                                |
                                # OR asterisk wildcard
                                [*]
                            )
                            ## end second single month unit
                            # optional (ignored) increment, immediately following said range
                            (?:
                                [/]
                                [0-9]+
                            )?
                        )
                        |
                        # OR increment, a literal slash followed by integer increment value
                        (?:
                            [/]
                            [0-9]+
                        )
                    )?
                    ### end unit expression
                    (?:
                        [,]
                        ### second unit expression, either range of two units or increment of a single unit
                        ## first single month unit
                        (?:
                            # number (roughly) between 1-12
                            (?:
                                # single digit num from 0-9 OR double digit num whose first digit is 1
                                [1]?
                                [0-9]
                            )
                            |
                            # OR month short name
                            (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                            |
                            # OR asterisk wildcard
                            [*]
                        )
                        ## end first single month unit
                        # optional second unit (range) or increment
                        (?:
                            # range, a literal dash followed by ANOTHER single unit (optionally followed by an ignored increment)
                            (?:
                                [-]
                                ## second single month unit
                                (?:
                                    # number (roughly) between 1-12
                                    (?:
                                        # single digit num from 0-9 OR double digit num whose first digit is 1
                                        [1]?
                                        [0-9]
                                    )
                                    |
                                    # OR month short name
                                    (?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)
                                    |
                                    # OR asterisk wildcard
                                    [*]
                                )
                                ## end second single month unit
                                # optional (ignored) increment, immediately following said range
                                (?:
                                    [/]
                                    [0-9]+
                                )?
                            )
                            |
                            # OR increment, a literal slash followed by integer increment value
                            (?:
                                [/]
                                [0-9]+
                            )
                        )?
                        ### end unit expression
                    )*
                )
                #### end top-level months field

                # one or more delimiting whitespace
                [ ]+

                # literal question-mark for day of week
                [?]
            )
        )

        # one or more delimiting whitespace
        [ ]+

        #### top-level years field
        # field, any number of expressions broken by literal comma
        (?:
            ### first unit expression, either range of two units or increment of a single unit
            ## first single year unit
            (?:
                # number (roughly) between 1970-2199
                (?:
                    # four digit num whose first digit is 1 through 2
                    [12]
                    [0-9]{3}
                )
                |
                # OR asterisk wildcard
                [*]
            )
            ## end first single year unit
            # optional second unit (range) or increment
            (?:
                # range, a literal dash followed by ANOTHER single unit
                (?:
                    [-]
                    ## second single year unit
                    (?:
                        # number (roughly) between 1970-2199
                        (?:
                            # four digit num whose first digit is 1 through 2
                            [12]
                            [0-9]{3}
                        )
                        |
                        # OR asterisk wildcard
                        [*]
                    )
                    ## end second single year unit
                )
                |
                # OR increment, a literal slash followed by integer increment value
                (?:
                    [/]
                    [0-9]+
                )
            )?
            ### end first unit expression
            (?:
                [,]
                ### second unit expression, either range of two units or increment of a single unit
                ## first single year unit
                (?:
                    # number (roughly) between 1970-2199
                    (?:
                        # four digit num whose first digit is 1 through 2
                        [12]
                        [0-9]{3}
                    )
                    |
                    # OR asterisk wildcard
                    [*]
                )
                ## end first single year unit
                # optional second unit (range) or increment
                (?:
                    # range, a literal dash followed by ANOTHER single unit
                    (?:
                        [-]
                        ## second single year unit
                        (?:
                            # number (roughly) between 1970-2199
                            (?:
                                # four digit num whose first digit is 1 through 2
                                [12]
                                [0-9]{3}
                            )
                            |
                            # OR asterisk wildcard
                            [*]
                        )
                        ## end second single year unti
                    )
                    |
                    # OR increment, a literal slash followed by integer increment value
                    (?:
                        [/]
                        [0-9]+
                    )
                )?
                ### end second unit expression
            )*
        )
        #### end top-level years field
    [)]
)
$

`x;


# above expression condensed into single line without comments
# (note the /x flag will ignore the leading and trailing newlines regardless)
our $collapsed = qr`

^(?:rate[(](?:(?:1[ ]+(hour|minute|day))|(?:[0-9]+[ ]+(hours|minutes|days)))[)])|(?:cron[(](?:(?:(?:[0-5]?[0-9])|[*])(?:(?:[-](?:(?:[0-5]?[0-9])|[*]))|(?:[/][0-9]+))?(?:[,](?:(?:[0-5]?[0-9])|[*])(?:(?:[-](?:(?:[0-5]?[0-9])|[*]))|(?:[/][0-9]+))?)*)[ ]+(?:(?:(?:[0-2]?[0-9])|[*])(?:(?:[-](?:(?:[0-2]?[0-9])|[*]))|(?:[/][0-9]+))?(?:[,](?:(?:[0-2]?[0-9])|[*])(?:(?:[-](?:(?:[0-2]?[0-9])|[*]))|(?:[/][0-9]+))?)*)[ ]+(?:(?:[?][ ]+(?:(?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:(?:[-](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:[/][0-9]+)?)|(?:[/][0-9]+))?(?:[,](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:(?:[-](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:[/][0-9]+)?)|(?:[/][0-9]+))?)*)[ ]+(?:(?:(?:[1-7]|(?:SUN|MON|TUE|WED|THU|FRI|SAT))[#][0-5])|(?:(?:(?:(?:[1-7]|(?:SUN|MON|TUE|WED|THU|FRI|SAT))L?)|[L*])(?:(?:[-](?:(?:(?:[1-7]|(?:SUN|MON|TUE|WED|THU|FRI|SAT))L?)|[L*]))|(?:[/][0-9]+))?(?:[,](?:(?:(?:[1-7]|(?:SUN|MON|TUE|WED|THU|FRI|SAT))L?)|[L*])(?:(?:[-](?:(?:(?:[1-7]|(?:SUN|MON|TUE|WED|THU|FRI|SAT))L?)|[L*]))|(?:[/][0-9]+))?)*)))|(?:(?:(?:(?:(?:[1-3]?[0-9])W?)|LW|[L*])(?:(?:[-](?:(?:(?:[1-3]?[0-9])W?)|LW|[L*]))|(?:[/][0-9]+))?(?:[,](?:(?:(?:[1-3]?[0-9])W?)|LW|[L*])(?:(?:[-](?:(?:(?:[1-3]?[0-9])W?)|LW|[L*]))|(?:[/][0-9]+))?)*)[ ]+(?:(?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:(?:[-](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:[/][0-9]+)?)|(?:[/][0-9]+))?(?:[,](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:(?:[-](?:(?:[1]?[0-9])|(?:JAN|FEB|MAR|APR|MAY|JUN|JUL|AUG|SEP|OCT|NOV|DEC)|[*])(?:[/][0-9]+)?)|(?:[/][0-9]+))?)*)[ ]+[?]))[ ]+(?:(?:(?:[12][0-9]{3})|[*])(?:(?:[-](?:(?:[12][0-9]{3})|[*]))|(?:[/][0-9]+))?(?:[,](?:(?:[12][0-9]{3})|[*])(?:(?:[-](?:(?:[12][0-9]{3})|[*]))|(?:[/][0-9]+))?)*)[)])$

`x;
