class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors, if_not_exists: true do |t|
      t.string :name

      t.timestamps
    end
  end
end
