require 'rails_helper'

describe 'An Admin can edit a tutorial' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  vcr_options = { record: :new_episodes }
  scenario 'by adding a video', :js, vcr: vcr_options do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_tutorial_path(tutorial)

    click_on 'Add Video'

    within('#new-video-form') do
      fill_in 'video_title', with: 'How to tie your shoes.'
      fill_in 'video_description', with: 'Over, under, around and through, Meet Mr. Bunny Rabbit, pull and through.'
      fill_in 'video_video_id', with: 'J7ikFUlkP_k'
      click_on 'Create Video'
    end

    expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

    within(first('.video')) do
      expect(page).to have_content('How to tie your shoes.')
    end
  end

  scenario 'by trying to add a bad video', :js, vcr: vcr_options do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit edit_admin_tutorial_path(tutorial)

    click_on 'Add Video'

    within('#new-video-form') do
      fill_in 'video_title', with: 'How to tie your shoes.'
      fill_in 'video_description', with: ''
      fill_in 'video_video_id', with: 'aaaaa'
      click_on 'Create Video'
    end

    expect(page).to have_content('Unable to create video.')
  end

  scenario 'can edit a video' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    tutorial = create(:tutorial)

    video_1 = create(:video, tutorial: tutorial)
    create(:video, tutorial: tutorial)

    visit edit_admin_video_path(video_1)
  end
end
