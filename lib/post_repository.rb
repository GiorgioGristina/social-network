require_relative './post'
class PostRepository

    # Selecting all records
    # No arguments
    def all
      # Executes the SQL query:
      # SELECT * FROM posts;
      posts = []
      sql = 'SELECT * FROM posts'
      result = DatabaseConnection.exec_params(sql, [])
      result.each do |record|
        p record
        post = Post.new
        post.id = record['id'].to_i
        post.title = record['title']
        post.content = record['content']
        post.number_of_views = record['number_of_views'].to_i
        post.account_id = record['account_id'].to_i
        posts << post
      end
      return posts
      # Returns an array of posts objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT id, name, cohort_name FROM postss WHERE id = $1;
  
      # Returns a single posts object.
    end
  
    # Add more methods below for each operation you'd like to implement.
  
    # def create(student)
    # end
  
    # def update(student)
    # end
  
    # def delete(student)
    # end
  end