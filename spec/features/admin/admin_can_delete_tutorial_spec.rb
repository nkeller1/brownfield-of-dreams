require 'rails_helper'

feature "An admin can delete a tutorial" do
  scenario "and it should no longer exist" do
    admin = create(:admin)
    create_list(:tutorial, 2)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 2)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect(page).to have_css('.admin-tutorial-card', count: 1)
  end

  scenario "and its videos no longer exist" do
    admin = create(:admin)
    tutorial = create(:tutorial)

    video = create(:video, tutorial: tutorial )
    # require "pry"; binding.pry
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/dashboard"

    expect(page).to have_css('.admin-tutorial-card', count: 1)

    within(first('.admin-tutorial-card')) do
      click_link 'Delete'
    end

    expect { Video.find(video.id) }.to raise_exception(ActiveRecord::RecordNotFound)
  end
end
