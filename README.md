### from excel
Create \*.ics file automatically from excel(\*.xlsx) file containing Shift info.

#### init
```
bundle install
```

#### run
```
ruby calmake.rb [*.xlsx] [name] [from] [to]
```

ex.
```
ruby calmake.rb shift.xlsx 山田 2017-10-10 2017-10-18
```
For above condition, this app read shift information of 山田 from 2017-10-10 to 2017-10-18 from excel.
