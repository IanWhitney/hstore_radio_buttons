class CreateHstoreRadioData < ActiveRecord::Migration
  def self.up
    create_table :hstore_radio_data do |t|
      t.belongs_to :model, :polymorphic => true
      t.hstore    :hstore_data

      t.timestamps
    end
  end

  def self.down
    drop_table :hstore_radio_data
  end
end
