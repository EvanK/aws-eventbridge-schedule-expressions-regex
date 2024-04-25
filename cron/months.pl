# full field
/
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
/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
/x;

# single unit
/
## single month unit
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
## end single month unit
/x;
