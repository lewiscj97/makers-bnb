# Some example SQL queries
## Getting all spaces associated with a specific user:

```
SELECT * FROM spaces
JOIN users ON spaces.user_id = users.id
WHERE user.id = 23;
```

