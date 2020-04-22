class CreateLawProject < ActiveRecord::Migration[6.0]
  def change
    create_table :law_projects do |t|
      t.string :name
      t.string :description
      t.string :link

      t.timestamps
    end
  end
end
