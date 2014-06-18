# ListTool

This gem may be used to manage lists of text strings (todos, for example) in your ruby application or in a console (to be honest, generally in a console).

## INSTALLATION

To install this gem write `gem install list-tool`

## IN RUBY APPLICATIONS

Require list-tool with `require 'list_tool'` command

#### Creation

    lister = Lister.new # creates empty list

    hash = {
      "default" => 0, # optional
      "lists" => [ 
        {
          "name" => "New list",
          "items" => [ {"text" => "item1"}, {"text" => "item2"} ]
        }
      ]
    }
    lister = Lister.from_hash(hash) # creates list from given hash
                                    # (for example, if you have already parsed json)

    lister = Lister.from_json( json_string ) # json document must have same
                                             # structure, as that hash above

#### Saving/loading data

    lister.load ( '/path/to/data.json' ) # reads data from json file
    lister.save( '/path/to/data.json' )  # saves it's data as json

#### General methods

    lister.lists # => { 'todolist' => 3, 'wishlist' => 2 }
                 # (digits for item quantitiy in a list)
    lister.list(list_index=nil) # => {name: 'list_name', items: ['item1', 'item2']}

For **#list** method, if list index is not specified, it will return contents of default list.

#### List management methods

    lister.add_list('name')
    lister.add_list( {'name'=>'todolist', 'items'=> [{'text'=>'item1'}])
    lister.rename_list(list_index, new_name)
    lister.delete_list(list_index)
    lister.clear_list(list_index)
    lister.set_default_list(list_index)
    lister.move_list(list_index, :up) # or :down. moves list in lists list

#### Item management methods

    lister.add_item(item_text, {list: 2}) # 2 is an example list index here
    lister.change_item(item_index, new_text, {list: 2})
    lister.delete_item(item_index, {list: 2})
    lister.move_item(item_index, :up, {list: 2})

You can omit {list: list_index} argument. In this case methods will affect default list.

#### Bonus classes

You may also want to use such classes as **ListTool::List**, **ListTool::Item** and **ListTool::ListerData**.

List class responds to all item management methods (**\*\_item**) and few others, like **#clear!**, **#rename**, **#each** (returns each Item) and **#to_json**

ListerData class responds to all list management methods (**\*\_list**) and also has **#to_json** and **#each** (returns each list) methods.

#### Errors

- all lister.\*_item methods return nil if list was not found.
- lister.list and lister.\*_list methods raise **ListTool::NoDefaultListError** if list index is not specified and default list is not set
- #save and #load methods may return **ListTool::FileAccessError** or **ListTool::FileNotFoundError**
- other errors are generally **ArgumentError** s

## IN CONSOLE

This gem provides console tool named '**clt**' ('console list tool'), which allows you to manage lists in console.

    USAGE: clt COMMAND [OPTIONS]

    COMMANDS:
        a,  add-item TEXT [LIST]      Add item with TEXT to given or default list
        r,  replace-item ITEM, TEXT   Set ITEM text to TEXT
        d,  del-item ITEM [LIST]      Delete ITEM from given or default list
        s,  show-items [LIST]         Print contents of default or given list
        al, add-list NAME             Create list with NAME
        rl, rename-list LIST, NAME    Set LIST name to NAME
        dl, del-list LIST             Delete given LIST
        sl, show-lists                Print list of existing lists
        u,  use LIST                  Set default list
       -h,  --help                    Print this message
       -v,  --version                 Print version

clt keeps it's data in **~/.clt/data.json**

## NOTES

Note that it is my first gem and also my first rspec experience.

## CONTACTS

You can contact me via email: vizvamitra@gmail.com

I'll be happy to get your feedback on this tool.

Dmitrii Krasnov
