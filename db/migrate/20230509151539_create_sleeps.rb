class CreateSleeps < ActiveRecord::Migration[7.0]
  def change
    create_table :sleeps do |t|
      t.references :user, null: false, foreign_key: true
      t.timestamp :sleep_at
      t.timestamp :wake_at
      t.integer :duration, default: 0
    end
  end
end
