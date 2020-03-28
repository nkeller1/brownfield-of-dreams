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

  it "can create a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in 'tutorial_title', with: "Cool Tutorial"
    fill_in 'tutorial_description', with: "This is really cool."
    fill_in 'tutorial_thumbnail', with: "https://img.youtube.com/vi/XewbmK0kmpI/maxresdefault.jpg"

    click_on "Save"

    new_tutorial = Tutorial.last

    expect(current_path).to eq("/admin/tutorials/#{new_tutorial.id}")
    expect(page).to have_content("Cool Tutorial")
    expect(page).to have_content("This is really cool.")
    expect(page).to have_content("Successfully created tutorial.")
  end

  it "can errors if a field is missing when creating a new tutorial" do
    admin = create(:admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit "/admin/tutorials/new"

    fill_in 'tutorial_title', with: "Cool Tutorial"
    fill_in 'tutorial_description', with: ""
    fill_in 'tutorial_thumbnail', with: "https://img.youtube.com/vi/XewbmK0kmpI/maxresdefault.jpg"

    click_on "Save"

    expect(current_path).to eq("/admin/tutorials/new")
    expect(page).to have_content("Description can't be blank")
  end
end
