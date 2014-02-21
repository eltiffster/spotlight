FactoryGirl.define do
  factory :custom_field, class: Spotlight::CustomField do
    exhibit Spotlight::Exhibit.default
    field "field_name_tesim"
    configuration({ "label" => "Some Field" })
  end
end
  
