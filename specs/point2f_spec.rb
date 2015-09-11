require_relative 'spec_helpers'

describe Point2f do
  it 'shoud instantiate a (0,0) value when passing no args' do
    expect(Point2f.new).to eq(Point2f.new(0,0))
  end

end
