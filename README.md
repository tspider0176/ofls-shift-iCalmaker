## iCal auto-creator from excel
Create \*.ics file automatically from excel(\*.xlsx) file containing Shift info.

### env
```sh
ruby -v
->ruby 2.2.3p173 (2015-08-18 revision 51636) [x86_64-darwin15] 
```

### init
```
bundle install
```

### run
```sh
ruby run.rb [*.xlsx] [name] [from] [to]
```

ex.
```sh
ruby run.rb shift.xlsx 山田 2017-10-10 2017-10-18
```
For above condition, this app read shift information of 山田 from 2017-10-10 to 2017-10-18 on excel.

After execution, `events.ics` will be outputted to project root dir.

### func
* Send ical file with Gmail
Create auth file on project root directory and write your authentication information to it.

```sh
$ echo "USERNAME=\"[Your gmail address]\", PASSWORD=\"[Your app password]\"" > auth
```
