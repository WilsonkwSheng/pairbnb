class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.references :user, index: true, foreign_key: true
      t.references :listing, index: true, foreign_key: true
      t.date :start_of_reservation_date
      t.date :end_of_reservation_date
      t.timestamps
    end 
  end
end