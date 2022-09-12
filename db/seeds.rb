# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AmusementPark.destroy_all
Ride.destroy_all

@six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
@universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

@hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
@scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
@ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 7, open: false)
@jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

@john = Mechanic.create!(name: 'John Smith', years_experience: 12)
@sam = Mechanic.create!(name: 'Sam Samson', years_experience: 10)
@tom = Mechanic.create!(name: 'Tom Tomson', years_experience: 5)
@kim = Mechanic.create!(name: 'Kim Kimson', years_experience: 20)

RideMechanic.create!(mechanic_id: @john.id, ride_id: @hurler.id)
RideMechanic.create!(mechanic_id: @sam.id, ride_id: @hurler.id)
RideMechanic.create!(mechanic_id: @sam.id, ride_id: @ferris.id)
RideMechanic.create!(mechanic_id: @tom.id, ride_id: @ferris.id)
RideMechanic.create!(mechanic_id: @kim.id, ride_id: @jaws.id)
RideMechanic.create!(mechanic_id: @kim.id, ride_id: @scrambler.id)
