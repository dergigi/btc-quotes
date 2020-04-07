require "application_system_test_case"

class QuotesTest < ApplicationSystemTestCase
  setup do
    @quote = quotes(:one)
  end

  test "visiting the index" do
    visit quotes_url
    assert_selector "h1", text: "Quotes"
  end

  test "creating a Quote" do
    visit quotes_url
    click_on "New Quote"

    check "Audio" if @quote.audio
    fill_in "Author", with: @quote.author
    fill_in "Body", with: @quote.body
    fill_in "Date", with: @quote.date
    fill_in "Source", with: @quote.source
    click_on "Create Quote"

    assert_text "Quote was successfully created"
    click_on "Back"
  end

  test "updating a Quote" do
    visit quotes_url
    click_on "Edit", match: :first

    check "Audio" if @quote.audio
    fill_in "Author", with: @quote.author
    fill_in "Body", with: @quote.body
    fill_in "Date", with: @quote.date
    fill_in "Source", with: @quote.source
    click_on "Update Quote"

    assert_text "Quote was successfully updated"
    click_on "Back"
  end

  test "destroying a Quote" do
    visit quotes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Quote was successfully destroyed"
  end
end
