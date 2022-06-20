# exps(extra parameters)が返すハッシュオブジェクトはparamに取り込まれます
#
# Props
#   param config, args を含んだParamが使用できる
require 'active_record'

module ImportCo
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

    def last(table, condition=nil)
      ActiveRecord::Base.connection.select_all("SELECT * FROM #{table} #{ "WHERE #{condition}" if condition } ORDER BY id desc LIMIT 1").first.symbolize_keys
    end

    def find(table, condition)
      ActiveRecord::Base.connection.select_one("SELECT * FROM #{table} WHERE #{condition}").symbolize_keys
    end

    def user
      find(:edi_users, "id = #{param.user_id}")
    end

    def receive_user
      find(:edi_users, "client_id=#{receive_client[:id]}")
    end

    def send_client
      find(:edi_clients, "id = #{user[:client_id]}")
    end

    def contract
      find(:edi_contracts, "client_id = #{send_client[:id]}")
    end

    def contract_setting
      find(:contract_settings, cond("contract_id= ? and send_client_id = ? and default_contract_setting_flg = 1", [contract[:id], send_client[:id]]))
    end

    def receive_client
      find(:edi_clients, "id = #{contract[:to_id]}")
    end

    def last_contract_order
      last(:contract_orders, "send_client_id = #{send_client[:id]}")
    end

    def start_id
      last_contract_order[:id] + 1
    end

    def contract_order_types
      %w[材料発注 工務発注 材/工発注]
    end

    def order
      find(:edi_orders, "client_id = #{send_client[:id]}")
    end

    def price
      param.unit_price * param.quantity * param.item_count
    end

    def price_with_tax
      param.unit_price_with_tax * param.quantity * param.item_count
    end

    def tax_price
      param.unit_tax_price * param.quantity * param.item_count
    end

    def exps
      {
        user:,
        receive_user:,
        send_client:,
        contract:,
        contract_setting:,
        receive_client:,
        last_contract_order:,
        start_id:,
        contract_order_types:,
        order:,
        price:,
        price_with_tax:,
        tax_price:,
      }
    end
  end
end
