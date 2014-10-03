def add_instructor(array, instructor)
  array << instructor
end

def be_friends_with(friends, friend)
  # more lines:
  # play_date = []
  # friends.each do |f|
  #   play_date << f
  # end
  # play_date << friend

  # with the dup method:
  friends.dup << friend
end