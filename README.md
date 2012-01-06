## use cases

    > assembla

    > tickets //returns a table with my tickets

    #number priority status title
    123     high     new    just another bug
    321     low      test   an easy fix

    > select(123) //sets ticket 123 as the current ticket
    > open(123) //opens the ticket 123 in the browser for analysis

    > status //lists the possible statusses for the ticket
    #  label
    0  invalid
    1  new
    2  test
    3  fixed

    > status 2 //sets the current ticket to test
    > ticket //shows the current ticket summary
    > comment "some comment or reason i already fixed this before ...."

    > exit //well it exits :P

## Install

    bundle
    gem build assembla_cli.gemspec
    gem i assembla_cli-0.0.1.gem

# Use

    $ assembla
    $ assempla Space?> space-name
    $ assembla> milestones
    $ assembla> exit
