require 'rails_helper'

RSpec.describe Ride, type: :model do
  describe 'relationships' do
    it { should belong_to(:amusement_park) }
    it { should have_many :ride_mechanics}
    it {should have_many(:mechanics).through(:ride_mechanics)}
  end

  before :each do
    @six_flags = AmusementPark.create!(name: 'Six Flags', admission_cost: 75)
    @universal = AmusementPark.create!(name: 'Universal Studios', admission_cost: 80)

    @hurler = @six_flags.rides.create!(name: 'The Hurler', thrill_rating: 7, open: true)
    @scrambler = @six_flags.rides.create!(name: 'The Scrambler', thrill_rating: 4, open: true)
    @ferris = @six_flags.rides.create!(name: 'Ferris Wheel', thrill_rating: 8, open: false)
    @jaws = @universal.rides.create!(name: 'Jaws', thrill_rating: 5, open: true)

    @john = Mechanic.create!(name: 'John Smith', years_experience: 12)
    @sam = Mechanic.create!(name: 'Sam Samson', years_experience: 10)
    @tom = Mechanic.create!(name: 'Tom Tomson', years_experience: 5)
    @kim = Mechanic.create!(name: 'Kim Kimson', years_experience: 20)

    RideMechanic.create!(mechanic_id: @john.id, ride_id: @hurler.id)
    RideMechanic.create!(mechanic_id: @sam.id, ride_id: @hurler.id)
    RideMechanic.create!(mechanic_id: @sam.id, ride_id: @ferris.id)
    RideMechanic.create!(mechanic_id: @tom.id, ride_id: @jaws.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @jaws.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @scrambler.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @ferris.id)
  end

  describe "class methods" do
    it '#thrill_rating_order' do
      expect(Ride.thrill_rating_order).to eq([@ferris, @hurler, @jaws, @scrambler])
    end
  end
end
