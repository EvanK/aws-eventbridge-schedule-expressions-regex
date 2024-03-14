# full field
/
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
/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
### end unit expression
/x;

# single unit
/
## single year unit
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
## end single year unit
/x;
