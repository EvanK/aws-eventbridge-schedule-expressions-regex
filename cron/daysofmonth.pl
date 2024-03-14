# full field
/
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
/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
### end unit expression
/x;

# single unit
/
## single day of month unit
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
/x;
