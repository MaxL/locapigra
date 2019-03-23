describe Comic do

  describe 'Instance Methods' do

    before(:each) { @comic = FactoryBot.build(:comic)}

    subject { @comic }

    it { should respond_to(:name) }

    it "#name returns a string" do
      expect(@comic.name).to be_a(String)
    end

  end

  describe ' Class Methods' do

    before(:each) { @comic = FactoryBot.create(:comic)}

    it ".all returns a list of comics" do
      expect(Comic.all.count).not_to eq 0
    end

  end
  

  # Validations

  it "should be valid" do
    comic = FactoryBot.build(:comic)
    expect(comic).to be_valid
  end

  it "should not be valid when name is blank" do
    comic = FactoryBot.build(:comic, name: nil)
    expect(comic).to_not be_valid
  end

end
