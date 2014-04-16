require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/sbin'
  end
end

describe "Elasticsearch Server" do

  describe service('elasticsearch') do
    it { should be_running }
  end

  describe port(9200) do
    it { should be_listening }
  end

end