1. Update columns in database:

`Profile table`

Change to json column: `languages` `religion` `bodytype` `ethnicity`
Remove `english_level` column

`Seekings table`

Change to json column: `bodytype` `religion` `ethnicity`

```
Update `profiles` Set `ethnicity` = NULL
Update `seekings` Set `ethnicity` = NULL
```

2. un comment seeking code in register controller


3. Does not exist:

    1. `profiles` table `occupation`, `ethnicity`, columns
    2. `seekings` table
