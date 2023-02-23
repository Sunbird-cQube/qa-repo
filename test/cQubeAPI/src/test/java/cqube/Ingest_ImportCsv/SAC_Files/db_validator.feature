
# Import the jdbc library
# Note: You will need to have the library installed in your classpath
# You can download it from https://mvnrepository.com/artifact/org.postgresql/postgresql
# You will also need to install the JDBC driver for PostgreSQL
# You can download it from https://jdbc.postgresql.org/
* library 'classpath:karate-jdbc.jar'

# Define the JDBC connection details
* def driver = 'org.postgresql.Driver'
* def url = 'jdbc:postgresql://host:port/database'
* def username = 'user'
* def password = 'password'

# Connect to the database
* def conn = karate.jdbc.getConnection(driver, url, username, password)

# Use the connection to run a SQL query
* def query = 'SELECT * FROM table'
* def result = karate.jdbc.query(conn, query)

# Close the database connection
* karate.jdbc.close(conn)

# Verify the result
* assert result.size() > 0