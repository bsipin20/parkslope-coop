
Rspec.describe AppendNewPrices do
  it 'tests job updates db' do
    AppendNewPrices.perform
    binding.pry
  end
end

