require 'booking'

class BookingRepository
  def create(booking)
    sql = "INSERT INTO bookings (name, date, booked, user_id, listing_id) VALUES ($1, $2, $3, $4, $5);"
    sql_params = [booking.name, booking.date, booking.booked, booking.user_id, booking.listing_id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find(id)
    sql = "SELECT id, name, date, booked, user_id, listing_id FROM bookings WHERE id = $1;"

    result_set = DatabaseConnection.exec_params(sql, [id])
    
    record = result_set[0]

    return record_to_booking_object(record)
  end

  def accept(id)
    sql = "UPDATE bookings SET booked = 'yes' WHERE id = $1;"
    DatabaseConnection.exec_params(sql, [id])
    return nil
  end

  def decline(id)
    sql = "UPDATE bookings SET booked = 'no' WHERE id = $1;"
    DatabaseConnection.exec_params(sql, [id])
    return nil
  end


  private 

  def record_to_booking_object(record)
    booking = Booking.new

    booking.id = record["id"]
    booking.name = record["name"]
    booking.date = record["date"]
    booking.booked = record["booked"]
    booking.user_id = record["user_id"]
    booking.listing_id = record["listing_id"]

    return booking
  end
end