class CreateBanks < ActiveRecord::Migration[8.0]
  def change
    create_table :banks do |t|
      t.string :code
      t.string :bank_type
      t.boolean :isFpx
      t.boolean :isObw
      t.boolean :active

      t.timestamps
    end
  end
end
