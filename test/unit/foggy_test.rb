require 'test_helper'
require 'auth_helper'

describe "Foggy" do
  let(:auth_v3) do
    {
      :url      => "http://localhost:5000",
      :user     => "admin",
      :password => "secret",
      :project  => "admin",
      :domain   => "default"
    }
  end

  it "#networking" do
    stub_request(:post, "http://localhost:5000/v3/auth/tokens").
      with(:body => "{\"auth\":{\"identity\":{\"methods\":[\"password\"],\"password\":{\"user\":{\"name\":\"admin\",\"domain\":{\"id\":\"default\"},\"password\":\"secret\"}}},\"scope\":{\"project\":{\"name\":\"admin\",\"domain\":{\"id\":\"default\"}}}}}",
      :headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => JSON.dump(auth_response_v3("networking", "neutron")), :headers => {"x-subject-token"=>"token_data"})

    stub_request(:get, "http://localhost/v2.0/networks").
      with(:headers => {'Accept'=>'application/json', 'Content-Type'=>'application/json', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "[]", :headers => {})

    cloud = Foggy::Cloud.new(:auth => auth_v3)
binding.pry
    cloud.networking.must_be_kind_of Foggy::Networking
    cloud.networking.networks.must_be_kind_of Foggy::Networking::Networks
    cloud.networking.networks.all.must_equal ([])
  end
end
