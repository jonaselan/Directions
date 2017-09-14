class CreateAttemptLoginFaileds < ActiveRecord::Migration[5.0]
  def change
    create_table :attempt_login_faileds do |t|
      t.string :ip
      t.string :user_email
      t.integer :count, default: 0
      t.datetime :attempt_time
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
