# {{TABLE NAME}} Model and Repository Classes Design Recipe

_Copy this recipe template to design and implement Model and Repository classes for a database table._

## 1. Design and create the Table

If the table is already created in the database, you can skip this step.

Otherwise, [follow this recipe to design and create the SQL schema for your table](./single_table_design_recipe_template.md).

*In this template, we'll use an example table `students`*

```
# EXAMPLE

Table: posts

Columns:
id | title | content | number_of_views |account_id
```

## 2. Create Test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
-- EXAMPLE
-- (file: spec/seeds_{table_name}.sql)

-- Write your SQL seed here. 

-- First, you'd need to truncate the table - this is so our table is emptied between each test run,
-- so we can start with a fresh state.
-- (RESTART IDENTITY resets the primary key)

TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.

-- Below this line there should only be `INSERT` statements.
-- Replace these statements with your own seed data.

INSERT INTO posts (title, content, number_of_views, account_id) VALUES ('traveling solo', 'it amazing', 200, 1);
INSERT INTO posts (title, content, number_of_views, account_id) VALUES ('south america 3 months', 'Colombia, Ecuador, Peru', 20, 1);

```

Run this SQL file on the database to truncate (empty) the table, and insert the seed data. Be mindful of the fact any existing records in the table will be deleted.

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. Define the class names

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)
class Post
end

# Repository class
# (in lib/Post_repository.rb)
class PostRepository
end
```

## 4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/student.rb)

class Post

  # Replace the attributes by your own columns.
  attr_accessor :id, :title, :content, :number_of_views
end

# The keyword attr_accessor is a special Ruby feature
# which allows us to set and get attributes on an object,
# here's an example:
#
# Post = Post.new
# Post.name = 'Jo'
# Post.name
```

*You may choose to test-drive this class, but unless it contains any more logic than the example above, it is probably not needed.*

## 5. Define the Repository Class interface

Your Repository class will need to implement methods for each "read" or "write" operation you'd like to run against the database.

Using comments, define the method signatures (arguments and return value) and what they do - write up the SQL queries that will be used by each method.

```ruby
# EXAMPLE
# Table name: Posts

# Repository class
# (in lib/Post_repository.rb)

class PostRepository

  # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT * FROM posts;
    
    # Returns an array of posts objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT * FROM posts WHERE id = $1;

    # Returns a single posts object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(post)
    # ' INSERT INTO posts VALUES($1, $2, $3, $4);'
    #return nothing just add a new record
 end

  # def update(student)
  # end

  def delete(id)
     # ' DELETE FROM posts WHERE id = $1;'
    #return nothing just delete a record
  end
end
```

## 6. Write Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all posts

repo = PostRepository.new

posts = repo.all

posts.length # =>  2

posts[0].id # =>  1
posts[0].title # =>  'traveling solo'
posts[0].content # =>  'it amazing'
posts[0].number_of_views # =>  200
posts[0].account_id # =>  1

# 2
# Get a single post

repo = PostRepository.new

post = repo.find(1)

post[0].id # =>  1
post[0].title # =>  'traveling solo'
post[0].content # =>  'it amazing'
post[0].number_of_views # =>  200
post[0].account_id # =>  2


# 3
# adda new post in the DB

repo = PostRepository.new

post = Post.new
post.title = 'traveling'
post.content = 'somewhere'
post.number_of_views = 2
post.account_id = 2

repo.create(post)

posts = repo.all

post.last.title #=>  'traveling'
post.last.content #=>  'somewhere'

# 4
# delete a record from the DB

repo = PostRepository.new

repo.all.length #=> 3

repo.delete(1)

repo.all.length #=> 2

```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_posts_table
  seed_sql = File.read('spec/seeds_post.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
  connection.exec(seed_sql)
end

describe PostRepository do
  before(:each) do 
    reset_posts_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._

<!-- BEGIN GENERATED SECTION DO NOT EDIT -->

---
