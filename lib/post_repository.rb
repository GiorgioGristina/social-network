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
        posts << post_object(record)
      end
      return posts
      # Returns an array of posts objects.
    end
  
    # Gets a single record by its ID
    # One argument: the id (number)
    def find(id)
      # Executes the SQL query:
      # SELECT * FROM posts WHERE id = $1;
        sql = 'SELECT * FROM posts WHERE id = $1'
        params = [id]
        data = DatabaseConnection.exec_params(sql, params)[0]
        post_object(data)
    end
  
    def create(post)
        sql = 'INSERT INTO posts(title, content, number_of_views, account_id) VALUES($1, $2, $3, $4);'
        params = [post.title, post.content, post.number_of_views, post.account_id]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end
  
    def delete(id)
        sql = 'DELETE FROM posts WHERE id = $1;'
        params = [id]
        DatabaseConnection.exec_params(sql, params)
    end

    private

    def post_object(hash)
        post = Post.new
        post.id = hash['id'].to_i
        post.title = hash['title']
        post.content = hash['content']
        post.number_of_views = hash['number_of_views'].to_i
        post.account_id = hash['account_id'].to_i
        return post
    end
  end