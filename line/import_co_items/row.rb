# param:  Param.instance
# cursor: row index
# id:     serial number from start_id
module ImportCoItems
  module Row
    def columns
      [
        column(header: "発注明細管理ID", key: :send_item_num, render: -> {
          [
            cursor/param.item_count + param.start_contract_order_id,
            (cursor % param.item_count) + 1
          ].join("_")
        }),
        column(header: "発注管理ID", key: :send_number, render: -> { [param.send_number_prefix, (cursor/param.item_count + param.start_contract_order_id)].join("_")}),
        column(header: "工事場所", key: :work_location, render: -> { param.client_business_masters.sample[:name] }),
        column(header: "工事種類", key: :work_type, render: -> { param.client_category_masters.sample[:name] }),
        column(header: "発注明細名", key: :item_name, render: -> { Faker::Games::Zelda.item }),
        column(header: "品番", key: :item_number, render: -> { "" }),
        column(header: "仕様", key: :item_spec, render: -> { "" }),
        column(header: "寸法", key: :item_size, render: -> { "" }),
        column(header: "数量", key: :item_quantity, render: -> { param.quantity }),
        column(header: "単位", key: :item_unimt, render: -> { "式" }),
        column(header: "単価（税抜）", key: :unit_price, render: -> { param.unit_price }),
        column(header: "単価（税込）", key: :unit_price_with_tax, render: -> { param.unit_price_with_tax }),
        column(header: "単価（税額）", key: :unit_tax_price, render: -> { param.unit_tax_price }),
        column(header: "金額（税抜）", key: :total_price, render: -> { param.total_price }),
        column(header: "金額（税込）", key: :total_price_with_tax, render: -> { param.total_price_with_tax }),
        column(header: "金額（税額）", key: :total_tax_price, render: -> { param.total_tax_price }),
        column(header: "課税フラグ", key: :taxation_flg, render: -> { true }),
        column(header: "直接入力フラグ", key: :edit_flg, render: -> { true }),
        column(header: "項目グループ", key: :item_type, render: -> { param.group }),
      ]
    end
  end
end
