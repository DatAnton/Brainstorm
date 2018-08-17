class CreateAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :answers do |t|
      t.string :text
      t.references :challenge, foreign_key: true
      t.integer :impact
      t.integer :cost
      t.boolean :selected

      t.timestamps
    end
  end
end
