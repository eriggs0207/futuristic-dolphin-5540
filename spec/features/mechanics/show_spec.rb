require 'rails_helper'

RSpec.describe 'mechanic show page' do
  before :each do
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
    RideMechanic.create!(mechanic_id: @tom.id, ride_id: @jaws.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @jaws.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @scrambler.id)
    RideMechanic.create!(mechanic_id: @kim.id, ride_id: @ferris.id)
  end

  describe 'as a User' do
    describe 'I visit a mechanics show page' do
      it 'I see their name, years of experience, and the names of rides they’re working on' do

        visit "/mechanics/#{@john.id}"

        expect(page).to have_content(@john.name)
        expect(page).to have_content(@john.years_experience)
        expect(page).to_not have_content(@tom.years_experience)
        expect(page).to_not have_content(@scrambler.name)
        expect(page).to have_content(@hurler.name)
        expect(page).to_not have_content(@ferris.name)

        visit "/mechanics/#{@kim.id}"

        expect(page).to have_content(@kim.name)
        expect(page).to have_content(@kim.years_experience)
        expect(page).to_not have_content(@tom.years_experience)
        expect(page).to_not have_content(@hurler.name)
        expect(page).to have_content(@scrambler.name)
        expect(page).to have_content(@jaws.name)
        expect(page).to_not have_content(@ferris.name)
      end

      it 'I only see rides that are open' do

        visit "/mechanics/#{@sam.id}"

        expect(page).to have_content(@hurler.name)
        expect(page).to_not have_content(@jaws.name)
        expect(page).to_not have_content(@ferris.name)

        visit "/mechanics/#{@kim.id}"

        expect(page).to have_content(@scrambler.name)
        expect(page).to have_content(@jaws.name)
        expect(page).to_not have_content(@ferris.name)
      end  
    end
  end
end
