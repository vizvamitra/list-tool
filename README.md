# ListTool

This gem may be used to manage lists of text strings (todos, for example) in your app or in console

## In app

In your app do this:

    require 'list-tool'

    ...

    lister = Lister.new

I'll describe later how to work with it

## In console

Also gem provides console tool named 'clt' ('console list tool'), which allows you to manage lists in console.

    USAGE: clt COMMAND [OPTIONS]

    COMMANDS:
        a,  add-item TEXT [LIST]  Add item with TEXT to given or default list
        r,  replace-item ITEM, TEXT Set ITEM text to TEXT
        d,  del-item ITEM [LIST]  Delete ITEM from given or default list
        s,  show-items [LIST]   Print contents of default or given list
        al, add-list NAME   Create list with NAME
        rl, rename-list LIST, NAME  Set LIST name to NAME
        dl, del-list LIST   Delete given LIST
        sl, show-lists    Print list of existing lists
        u,  use LIST      Set default list
       -h,  --help      Print this message
       -v,  --version     Print version

clt keeps it's data file in ~/.clt

## Notes

Note that this is my first gem and also my first rspec experiance.

## Contacts

You can contact me via email: vizvamitra@gmail.com
