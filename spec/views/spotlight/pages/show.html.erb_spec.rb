require 'spec_helper'

module Spotlight
  describe "spotlight/pages/show" do
    let(:exhibit) { stub_model(Exhibit) }
    let(:page) {
      stub_model(FeaturePage,
        :exhibit => exhibit,
        :title => "Title",
        :content => "{}"
      )
    }
    before(:each) do
      view.stub(:current_exhibit).and_return(exhibit)
      @page = assign(:page, page)
      stub_template "spotlight/pages/_sidebar.html.erb" => "Sidebar"
      
    end

    it "should render the title as a heading" do
      render
      expect(rendered).to have_css(".page-title", text: @page.title)
    end
    it "should not render an empty heading" do
      page.stub(title: nil)
      render
      expect(rendered).to_not have_css(".page-title")
    end
    
    it "should inject the page title into the html title" do
      expect(view).to receive(:set_html_page_title)
      render
    end
    
    it "should not include the page title" do
      page.stub(:should_display_title? => false)
      expect(view).to_not receive(:set_html_page_title)
      render
    end

    it "renders attributes in <p>" do
      render
      rendered.should match(/Title/)
    end

    it "should render the sidebar" do
      page.display_sidebar = true
      render
      expect(rendered).to match("Sidebar")
    end

    it "should not render the sidebar if the page has it disabled" do
      page.stub(display_sidebar?: false)
      render
      expect(rendered).to_not match("Sidebar")
    end
  end
end
