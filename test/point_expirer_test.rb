require 'test_helper'

class PointExpirerTest < ActiveSupport::TestCase
  
  def setup
  	@user = User.create(username: 'Aleksandr Ponomarenko')
	  @user.point_line_items.create([
	  	{points: 25, source: 'Joined Loyalty Program', created_at: '2013-1-1'}, 
	  	{points: 410, source: 'Placed an order', created_at: '2013-2-10'}, 
	  	{points: -250, source: 'Redeemed with an order', created_at: '2013-2-15'}, 
	  	{points: 10, source: 'Wrote a review', created_at: '2013-2-18'}, 
	  	{points: 570, source: 'Placed an order', created_at: '2013-3-12'}, 
	  	{points: -500, source: 'Redeemed with an order', created_at: '2013-4-15'}, 
	  	{points: 130, source: 'Made a purchase', created_at: '2013-6-27'}
	  	])
	  @p = PointExpirer.new
  end
  
  test "count total balance" do
    assert @p.total_balance == 395
  end

  test "expire points" do
  	@p.expire('2014-03-13'.to_date)
  	last_record = @user.point_line_items.last
  	p last_record
  	assert last_record.points == -265
  end

end
