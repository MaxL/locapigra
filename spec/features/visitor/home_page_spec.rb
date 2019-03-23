# Feature: Home Page
#   As a visitor
#   I want to visit a home page
#   So I can learn more about the website
feature 'Home Page' do

  before { visit root_path }

  it_behaves_like 'a page'

  # Scenario: Visit the Home Page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I should see "Hey we are AIK and LEE"
  scenario 'Visit the Home Page' do
    expect(page).to have_content 'Hey we are AIK and LEE'
  end

  # Scenario: See Fireworks animation
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I should see the "fireworks" canvas element
  scenario 'See fireworks' do
    expect(page).to have_selector(:css, "canvas.fireworks")
  end

  # Scenario: See latest blog post
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I should see the latest blog post from tumblr
  scenario 'See latest blog post' do
    expect(page).to have_selector(:css, ".post")
  end

end