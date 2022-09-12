require 'rails_helper'

RSpec.describe 'mechanic index page' do
  before :each do
    @john = Mechanic.create!(name: 'John Smith', years_experience: 12)
    @sam = Mechanic.create!(name: 'Sam Samson', years_experience: 10)
    @tom = Mechanic.create!(name: 'Tom Tomson', years_experience: 5)
    @kim = Mechanic.create!(name: 'Kim Kimson', years_experience: 20)
  end

  describe 'as a User' do
    describe 'I visit a mechanics index page' do
      it 'I see a header that says all mechanics' do

        visit "/mechanics"

        expect(page).to have_content("All Mechanics")
      end

      it 'I see a list of names of all the mechanics and their years experience' do

        visit "/mechanics"

        expect(page).to have_content(@john.name)
        expect(page).to have_content(@sam.name)
        expect(page).to have_content(@tom.name)
        expect(page).to have_content(@kim.name)
        expect(page).to have_content(@john.years_experience)
        expect(page).to have_content(@sam.years_experience)
        expect(page).to have_content(@tom.years_experience)
        expect(page).to have_content(@kim.years_experience)

      end

      it 'I see the average years of experience across all mechanics' do

        visit "/mechanics"

        expect(page).to have_content("Average Years of Experience: 11.75")
      end
    end
  end
end
