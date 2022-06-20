# expsが返すハッシュオブジェクトはparamに取り込まれます
#
# Props
#   param config, args を含んだParamが使用できる
require 'active_record'
module ImportCoItems
  module Exp
    def initialize
      super
      connection
    end

    def cond(condition, values)
      ActiveRecord::Base.sanitize_sql_array([condition, *values])
    end

    def connection
      ActiveRecord::Base.configurations = { edi: param.database }
      ActiveRecord::Base.establish_connection(:edi)
    end

    def all(table, condition=nil)
      ActiveRecord::Base.connection.select_all("SELECT * FROM #{table} #{ "WHERE #{condition}" if condition }").map(&:symbolize_keys)
    end

    def last(table, condition=nil)
      ActiveRecord::Base.connection.select_all("SELECT * FROM #{table} #{ "WHERE #{condition}" if condition } ORDER BY id desc LIMIT 1").first.symbolize_keys
    end

    def find(table, condition)
      ActiveRecord::Base.connection.select_one("SELECT * FROM #{table} WHERE #{condition}").symbolize_keys
    end

    def user
      find(:edi_users, "id = #{param.user_id}")
    end

    def send_client
      find(:edi_clients, "id = #{user[:client_id]}")
    end

    def last_contract_order
      last(:contract_orders, "send_client_id = #{send_client[:id]}")
    end

    def start_contract_order_id
      last_contract_order[:id] + 1
    end

    def client_business_masters
      all(:edi_client_business_masters, cond('client_id = ?', send_client[:id]))
    end

    def client_category_masters
      all(:edi_client_category_masters, cond('client_id = ?', send_client[:id]))
    end

    def exps
      {
        user:,
        send_client:,
        last_contract_order:,
        start_contract_order_id:,
        client_business_masters:,
        client_category_masters:,
      }
    end
  end
end
