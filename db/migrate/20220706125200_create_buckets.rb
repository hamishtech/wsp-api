class CreateBuckets < ActiveRecord::Migration[7.0]
  def change
    create_table :buckets do |t|
      t.string :name
      t.string :icon
      t.references :space, null: false, foreign_key: true

      t.timestamps
    end
  end
end
