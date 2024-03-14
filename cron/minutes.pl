# full field
/
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
/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
### end unit expression
/x;

# single unit
/
## single minute unit
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
## end single minute unit
/x;
