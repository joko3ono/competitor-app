class CreateCompetitors < ActiveRecord::Migration[5.1]
  def change
    create_table :competitors do |t|
      t.references :domain, foreign_key: true
      t.string :name
      t.string :business
      t.integer :position

      t.timestamps
    end
  end
end
