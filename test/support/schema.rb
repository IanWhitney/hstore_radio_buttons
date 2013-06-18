ActiveRecord::Base.establish_connection(
  :adapter  => 'sqlite3',
  :database => File.expand_path('../../test.db', __FILE__)
)

class CreateSchema < ActiveRecord::Migration
  def self.up
    create_table :people, :force => true do |t|
      t.timestamps
    end

    create_table :versions, :force => true do |t|
      t.belongs_to :model, :polymorphic => true
      t.text    :hstore_data

      t.timestamps
    end
  end
end
