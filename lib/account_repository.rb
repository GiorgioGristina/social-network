require_relative './account'

class AccountRepository
    
    def all
        accounts = []
        sql = 'SELECT * FROM accounts;'
        data = DatabaseConnection.exec_params(sql, [])
        data.each do |record|
            account = Account.new
            account.email_address = record['email_address']
            account.username = record['username']
            account.id = record['id'].to_i
            accounts << account
        end
        return accounts
    end

    def find(id)
        sql = 'SELECT * FROM accounts WHERE id = $1;'
        params = [id]
        data = DatabaseConnection.exec_params(sql, params)[0]
        account = Account.new
        account.email_address = data['email_address']
        account.username = data['username']
        account.id = data['id'].to_i
        
        return account
    end

    def create(account)
        sql = 'INSERT INTO accounts(email_address, username) VALUES($1, $2)'
        params = [account.email_address, account.username]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end

    def delete(id)
        sql = 'DELETE FROM accounts WHERE id = $1'
        params = [id]
        DatabaseConnection.exec_params(sql, params)

        return nil
    end
end