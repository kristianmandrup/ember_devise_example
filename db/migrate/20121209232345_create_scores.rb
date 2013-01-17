class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.date :when
      t.text :what
      t.references :user

      t.timestamps
    end
  end
end
