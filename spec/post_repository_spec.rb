require 'post_repository'

def reset_posts_table
    seed_sql = File.read('spec/seeds_post.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
end

RSpec.describe PostRepository do
    before(:each) do 
        reset_posts_table
    end

    it "return a list of all the account present in the DB" do
                
        repo = PostRepository.new

        posts = repo.all

        posts.length # =>  2


        expect(posts[0].id).to eq(1) 
        expect(posts[0].title).to eq('traveling solo') 
        expect(posts[0].content).to eq('it amazing') 
        expect(posts[0].number_of_views).to eq(200) 
        expect(posts[0].account_id).to eq(2) 

    end

    it "return the record with id 1" do
                
        repo = PostRepository.new

        post = repo.find(1)

        expect(post.id).to eq(1) 
        expect(post.title).to eq('traveling solo') 
        expect(post.content).to eq('it amazing') 
        expect(post.number_of_views).to eq(200) 
        expect(post.account_id).to eq(2) 


    end

    it "add a new post to the DB" do
                
        repo = PostRepository.new

        post = Post.new
        post.title = 'traveling'
        post.content = 'somewhere'
        post.number_of_views = 2
        post.account_id = 2

        expect(repo.all.length).to eq(2) 

        repo.create(post)    
      
        expect(repo.all.length).to eq(3) 

        expect(repo.all.last.title).to eq('traveling') 
        expect(repo.all.last.content).to eq('somewhere') 
      

    end

    it "delete a post with id 1" do
                
            
        repo = PostRepository.new

        
        expect(repo.all.length).to eq(2)
        repo.delete(1)

        expect(repo.all.length).to eq(1)

    end
end