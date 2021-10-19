def drop_test_db
  p "Setting up test database..."
  connection = PG.connect(dbname: 'makersbnb_test')
  # Clear the tables
  connection.exec("TRUNCATE users;")
  connection.exec("TRUNCATE spaces;")
end
