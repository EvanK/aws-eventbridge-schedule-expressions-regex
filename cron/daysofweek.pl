# SPECIAL CASE hash wildcard is mutually exclusive to unit expressions,
# so specifically compatible with ONLY ONE single unit
# meaning no multiple comma delimited values "SUN,MON,TUE#1"
# and no ranges "SUN-MON#2" "SUN#2-MON"
# and no increments "SUN/1#3" "SUN#3/1"
# when hash is NOT present, any and all unit expressions are usable

# full field
/
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
/x;

# unit expression
/
### unit expression, either range of two units or increment of a single unit
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
/x;

# single unit
/
## single day of week unit
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
## end single day of week unit
/x;
