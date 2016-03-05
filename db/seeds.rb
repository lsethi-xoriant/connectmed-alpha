# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
  sunday = Date.today+1
  time = Time.new(sunday.year,sunday.month,sunday.day, 13, 0);

  for i in 0..3
    Slot.create(time: time+i*60*30, date:sunday, hour: (time+i*60*30).hour, minute: (time+i*60*30).min,is_open:true)
  end
