require 'account_repository'

def reset_accounts_table
    seed_sql = File.read('spec/seeds_account.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
    connection.exec(seed_sql)
end

RSpec.describe AccountRepository do

    before(:each) do 
        reset_accounts_table
    end


    it "return a list of all the account present in the DB" do
                
        repo = AccountRepository.new

        accounts = repo.all

        accounts.length # =>  2


        expect(accounts[0].id).to eq(1) # =>  1
        expect(accounts[0].email_address).to eq('giorgio,gristina91@gmail.com') # =>  'giorgio,gristina91@gmail.com'
        expect(accounts[0].username).to eq('giorgio') # => 'giorgio'

    end

    it "return the record with id 1" do
                
        repo = AccountRepository.new

        account = repo.find(1)

        expect(account.id).to eq(1) # =>  1
        expect(account.email_address).to eq('giorgio,gristina91@gmail.com') # =>  'giorgio,gristina91@gmail.com'
        expect(account.username).to eq('giorgio') # => 'giorgio'

    end

    it "it will add a record in the DB with id 3" do
                
        repo = AccountRepository.new

        account = Account.new
        account.email_address = "marco@gmail.com"
        account.username = "marco"

        repo.create(account)

        accounts = repo.all

        expect(accounts.last.email_address).to eq("marco@gmail.com")
        expect(accounts.last.username).to eq("marco")

    end

    it "it will delete the record with id 1" do
                
        repo = AccountRepository.new

        repo.delete(1)
        
        accounts = repo.all
        
        accounts.length #=> 2
       

        expect(accounts.length).to eq(1)
       

    end
end