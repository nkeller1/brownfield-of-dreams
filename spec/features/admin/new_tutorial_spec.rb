require 'rails_helper'

feature "An admin can visit the new tutorial page" do
  it "has a new tutorial page" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    expect(find_field('Title'))
    expect(find_field('Description'))
    expect(find_field('Thumbnail'))
    expect(page).to have_button('Save')
  end
end
