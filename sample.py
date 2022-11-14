#!/usr/bin/env python
# coding: utf-8

"""
Example of using sub-parser, sub-commands and sub-sub-commands :-)

https://gist.github.com/jirihnidek/3f5d36636198e852280f619847d22d9e
"""

import argparse


def main(args):
    """
    Just do something
    """
    print(args)


if __name__ == '__main__':
    # create the top-level parser
    parser = argparse.ArgumentParser(prog='PROG')
    parser.add_argument('--foo', action='store_true', help='foo is great option')

    # create sub-parser
    sub_parsers = parser.add_subparsers(help='sub-command help')

    # create the parser for the "ahoy" sub-command
    parser_ahoy = sub_parsers.add_parser('ahoy', help='ahoy is cool sub-command')
    parser_ahoy.add_argument('--bar', type=int, help='bar is useful option')
    
    # create the parser for the "booo" sub-command
    parser_booo = sub_parsers.add_parser('booo', help='booo is also cool sub-command')
    parser_booo.add_argument('--baz', choices='XYZ', help='baz is another option')
    parser_booo.add_argument('--zaz', action='store_const', const=True, help='zaz is French singer')

    # create the parse for the "cool" sub-command
    parser_cool = sub_parsers.add_parser('cool', help='cools is sub-command with sub-commands')
    parser_cool.add_argument('--sas', type=str, help='sas are bad asses')

    # create sub-parser for sub-command cool
    cool_sub_parsers = parser_cool.add_subparsers(help='sub-sub-command help')

    # create sub-command "crazy" for sub-command cool
    parser_crazy = cool_sub_parsers.add_parser('crazy', help='it is crazy sub-sub-command')
    parser_crazy.add_argument('--fool', action='store_const', const=True, help='it is foolish option')

    parser_normal = cool_sub_parsers.add_parser('normal', help='it is normal sub-sub-command')
    parser_normal.add_argument('--common', action='store_const', const=True, help='it is common option')

    args = parser.parse_args()

    main(args)
    