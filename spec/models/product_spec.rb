describe Product do

  describe 'Instance Methods' do

    before(:each) { @product = FactoryBot.build(:product) }

    subject { @product }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
    it { should respond_to(:meta_title) }
    it { should respond_to(:meta_description) }
    it { should respond_to(:cover_image) }

    it "#name returns a string" do
      expect(@product.name).to be_a(String)
    end

  end

  describe 'Class Methods' do

    before(:each) { @product = FactoryBot.create(:product)}

    it ".all returns a list of products" do
      expect(Product.all.count).not_to eq 0
    end

  end

  it "should be valid" do
    product = FactoryBot.build(:product)
    expect(product).to be_valid
  end

  it "should not be valid when name is blank" do
    product = FactoryBot.build(:product, name: nil)
    expect(product).to_not be_valid
  end

end
