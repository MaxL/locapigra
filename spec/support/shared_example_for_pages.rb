# Shared Example: Page
#   Each page should have certain elements 
#   that need to be always be visible
shared_examples 'a page' do

  it 'has navigation' do
    expect(page).to have_selector(:css, "nav.navbar")
  end

  it 'has a footer' do
    expect(page).to have_selector(:css, "footer.container-fluid")
  end

  it 'has an imprint link' do
    expect(page).to have_xpath("//a[contains(.,'imprint')]")
  end

  it 'has a terms link' do
    expect(page).to have_xpath("//a[contains(.,'terms')]")
  end

  it 'has a privacy link' do
    expect(page).to have_xpath("//a[contains(.,'protection')]")
  end

end