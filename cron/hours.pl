# full field
/
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

/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
### end unit expression
/x;

# single unit
/
## single hour unit
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
## end single hour unit
/x;
