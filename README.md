                                    |     |              |_)
      _` |  __|  __|  _ \ __ `__ \  __ \  |  _` |    __| | |
     (   |\__ \\__ \  __/ |   |   | |   | | (   |   (    | |
    \__,_|____/____/\___|_|  _|  _|_.__/ _|\__,_|  \___|_|_|                                                        

## Installation

    gem install assembla_cli

## Alternative Installation

    git clone git@github.com:azendal/assembla_cli.git
    cd assembla_cli
    bundle
    gem build assembla_cli.gemspec
    gem i assembla_cli-0.0.1.gem

## Configuration

    echo -e "<username>\n<password>" >> ~/.assembla_cli

## Project configuration
    
    cd /path/to/project
    touch .assemblarc

    #sample configuration
    {
      "space"     : "space",
      "report_id" : "12341",
      "zebra_colors" : {
        "color1" : "black_background",
        "color2" : "blue_background"
      }
    }

## Use

    assembla
    assembla> change_space 'Space'
    
    assembla(Space)> change_report
    +--------+-------------------------------+
    | id     | name                          |
    +--------+-------------------------------+
    | 12     | By Person - Open              |
    | 32     | My Open tickets               |
    +--------+-------------------------------+
    select report number> 32

    assembla(Space)> my_tickets
    +--------+-------------+------------+-------------------+----------------------------------------+
    | NUMBER | PRIORITY    | MILESTONE  | STATUS            | SUMMARY                                |
    +--------+-------------+------------+-------------------+----------------------------------------+
    | 5      | Highest (1) | Release    | Working           | Add some feature                       |
    | 1      | Normal (3)  | Release    | New               | Improve some other feature             |
    | 2      | Normal (3)  | Release    | New               | Remove unused method x                 |
    | 7      | High (2)    | Refactor   | New               | Abstract method x into a factory       |
    +--------+-------------+------------+-------------------+----------------------------------------+
    
    assembla(Space)> ticket 5
    assembla(Space)> comment "will be fixed soon"
    assembla(Space)> status 'test'

    assembla(Space)> ticket 1

## Full configured use

    $ assembla
    assembla(Space)> my_tickets
    +--------+-------------+------------+-------------------+----------------------------------------+
    | NUMBER | PRIORITY    | MILESTONE  | STATUS            | SUMMARY                                |
    +--------+-------------+------------+-------------------+----------------------------------------+
    | 5      | Highest (1) | Release    | Working           | Add some feature                       |
    | 1      | Normal (3)  | Release    | New               | Improve some other feature             |
    | 2      | Normal (3)  | Release    | New               | Remove unused method x                 |
    | 7      | High (2)    | Refactor   | New               | Abstract method x into a factory       |
    +--------+-------------+------------+-------------------+----------------------------------------+

## Getting help

    assembla> commands
    assembla> h
