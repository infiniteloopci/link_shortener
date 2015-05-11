require 'rails_helper'

feature 'Generating short link', js: true do
  scenario 'User shortens link', js: true do
    visit '/'
    within('#new_link') do
      fill_in 'podaj adres który chcesz skrócić', :with => 'http://foo.pl'
    end
    click_button 'skróć'
    expect(page).to have_content 'Twój link został skrócony'
  end

  scenario 'User tries to shorten invalid link', js: true do
    visit '/'
    within('#new_link') do
      fill_in 'podaj adres który chcesz skrócić', :with => 'foo.pl'
    end
    click_button 'skróć'
    expect(page).to have_content 'Podany adres jest nieprawidłowy'
  end

  scenario 'User follows shortened link', js: true do
    visit '/'
    within('#new_link') do
      fill_in 'podaj adres który chcesz skrócić', :with => 'http://localhost/'
    end
    click_button 'skróć'
    visit page.find('dd#result-link').find('a')[:href]
    expect(current_url).to eq 'http://localhost/'
  end
end
