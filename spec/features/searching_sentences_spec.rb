RSpec.describe 'Searching a sentence', js: true do
  describe 'without records', type: :feature do
    it 'should have disabled buttons' do
      visit root_path
      expect(page).to have_button('Search', disabled: true)
      expect(page).to have_button('Clear', disabled: true)
      within('table.table tbody') do
        expect(page).to have_xpath(".//tr", count: 1)
      end
      expect(page).to have_content 'No questions found'
    end
  end

  describe 'with a real sentence', type: :feature do
    it 'and one record' do
      visit root_path
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my subscription'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      expect(page).to have_content 'How do I cancel my subscription searched'
      within('table.table tbody') do
        expect(page).to have_xpath(".//tr", count: 1)
      end
      expect(page).to have_button('Search', disabled: true)
      expect(page).to have_button('Clear', disabled: false)
    end

    it 'and more than one record' do
      visit root_path
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my subscription'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      expect(page).to have_content 'How do I cancel my subscription searched'
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my account'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      expect(page).to have_content 'How do I cancel my account searched'
      within('table.table tbody') do
        expect(page).to have_xpath(".//tr", count: 2)
      end
      expect(page).to have_button('Search', disabled: true)
      expect(page).to have_button('Clear', disabled: false)
    end

    it 'twice' do
      visit root_path
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my subscription'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      expect(page).to have_content 'How do I cancel my subscription searched'
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my subscription'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      expect(page).to have_content 'How do I cancel my subscription searched'
      expect(page).to have_content 'How do I cancel my subscription 2'
      within('table.table tbody') do
        expect(page).to have_xpath(".//tr", count: 1)
      end
      expect(page).to have_button('Search', disabled: true)
      expect(page).to have_button('Clear', disabled: false)
    end
  end

  describe 'confirm clear all records', type: :feature do
    it 'should works fine' do
      visit root_path
      within('#search_form') do
        fill_in 'sentence', with: 'How do I cancel my subscription'
        find('#sentence').send_keys :tab
      end
      click_on 'Search'
      page.accept_confirm do
        click_on 'Clear'
      end
      expect(page).to have_content 'The statistics are clear'
      expect(page).to have_content 'No questions found'
    end
  end
end
