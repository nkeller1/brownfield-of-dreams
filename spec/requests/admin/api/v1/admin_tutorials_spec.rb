require 'rails_helper'

RSpec.describe 'Admin can access API endpoints' do
  it 'Admin can access tutorial index' do
    admin = create(:user, role: :admin)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    tutorial = create(:tutorial)

    create(:video, tutorial: tutorial)
    create(:video, tutorial: tutorial)

    put admin_api_v1_path(tutorial)
  end
end
