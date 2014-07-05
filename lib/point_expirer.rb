class PointExpirer
  
  def expire(date)
    
    expire_date = date - 1.year
    
    awarded_after_due_date = 0

    User.all.each do |user|

    	last_expired_line_item = user.point_line_items.where(["created_at <= ? AND points > 0", expire_date]).last.id
    	active_line_items = user.point_line_items.where(["created_at > ? AND points > 0", expire_date])

	    active_line_items.each do |item|
	    	awarded_after_due_date += item.points
	    end

	    points_to_take = total_balance - awarded_after_due_date

			user.point_line_items.create(points: - points_to_take, source: "Points ##{last_expired_line_item} expired", created_at: date)

    end

  end

  def total_balance
  	total_balance = 0
    PointLineItem.all.each do |item|
   		total_balance += item.points
    end
    total_balance
  end

end