require 'spec_helper'

describe V1::PositionsController do
  before do
    @position = FactoryGirl.create :position
    get "/v1/positions", format: :json
  end

  it 'return position information' do
    position = JSON.parse(response.body, symbolize_names: true).first
    expect(position[:name]).to eql @position.name
  end

  it 'response code' do
    expect(response).to have_http_status(200)
  end
end