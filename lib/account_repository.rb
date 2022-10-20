require_relative './account'

class AccountRepository
    
    def all
        accounts = []
        sql = 'SELECT * FROM accounts;'
        data = DatabaseConnection.exec_params(sql, [])
        data.each do |record|
            accounts << account_object(record)
        end
        return accounts
    end

    def find(id)
        sql = 'SELECT * FROM accounts WHERE id = $1;'
        params = [id]
        data = DatabaseConnection.exec_params(sql, params)[0]
        return account_object(data)
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

    private

    def account_object(hash)
        account = Account.new
        account.email_address = hash['email_address']
        account.username = hash['username']
        account.id = hash['id'].to_i
        return account
    end
end