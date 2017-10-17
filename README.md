### iCal auto-creation from excel
Create \*.ics file automatically from excel(\*.xlsx) file containing Shift info.

#### init
```
bundle install
```

#### run
```sh
ruby run.rb [*.xlsx] [name] [from] [to]
```

ex.
```sh
ruby run.rb shift.xlsx 山田 2017-10-10 2017-10-18
```
For above condition, this app read shift information of 山田 from 2017-10-10 to 2017-10-18 on excel.

After execution, `events.ics` will output on project root dir.

#### Send ical file with Gmail
Create auth file on project root directory.
Write your authentication information to the file.

```sh
$ echo "USERNAME="[Your gmail address]", PASSWORD="[Your app password]"" > auth
```
