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
end