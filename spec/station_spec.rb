require 'station'

describe Station do

  subject {Station.new("Old Street",1)}

  it 'knows the name of the station' do
    expect(subject.name).to eq("Old Street")
  end

  it 'knows the zone of the station' do
    expect(subject.zone).to eq(1)
  end

end
