require 'rails_helper'

describe 'Links routing' do
  it 'matches /links/new' do
    expect(get: '/links/new').to route_to(
      controller: 'links',
      action: 'new'
    )
  end

  it 'matches POST /links' do
    expect(post: '/links').to route_to(
      controller: 'links',
      action: 'create'
    )
  end

  it 'matches /links/:id' do
    id = '1'
    expect(get: "/links/#{id}").to route_to(
      controller: 'links',
      action: 'show',
      id: id
    )
  end

  it 'matches /:token' do
    token = Link.generate_token
    expect(get: "/#{token}").to route_to(
      controller: 'links',
      action: 'forward',
      token: token
    )
  end

  it 'matches /' do
    expect(get: '/').to route_to(
      controller: 'links',
      action: 'new'
    )
  end
end