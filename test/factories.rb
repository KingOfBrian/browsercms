# m is for model, I felt the need to document that for some reason

Factory.define :category, :class => Cms::Category do |m|
  m.association :category_type
  m.sequence(:name) {|n| "TestCategory#{n}"}
end

Factory.define :category_type, :class => Cms::CategoryType do |m|
  m.sequence(:name) {|n| "TestCategoryType#{n}"}
end

Factory.define :connector, :class => Cms::Connector do |m|
  m.association :page
  m.page_version 1
  m.container "main"
  m.association :connectable, :factory => :html_block
  m.connectable_version 1
end

Factory.define :file_block, :class => Cms::FileBlock do |m|
  m.sequence(:name) {|n| "TestFileBlock#{n}"}
end

Factory.define :group, :class => Cms::Group do |m|
  m.sequence(:name) {|n| "TestGroup#{n}" }
end

Factory.define :group_type, :class => Cms::GroupType do |m|
  m.sequence(:name) {|n| "TestGroupType#{n}" }
end

Factory.define :html_block, :class => Cms::HtmlBlock do |m|
  m.name "About Us"
  m.content "<h1>About Us</h1>\n<p>Lorem ipsum dolor sit amet...</p>"
end

Factory.define :image_block, :class => Cms::ImageBlock do |m|
  m.sequence(:name) {|n| "TestImageBlock#{n}"}
end

Factory.define :link, :class => Cms::Link do |m|
  m.sequence(:name) {|n| "Link #{n}"}
end

Factory.define :page, :class => Cms::Page do |m|
  m.sequence(:name) {|n| "Page #{n}" }
  m.path {|a| "/#{a.name.gsub(/\s/,'_').downcase}" }
  m.template_file_name "default.html.erb"
  m.association :section
end

Factory.define :page_partial, :class => Cms::PagePartial do |m|
  m.sequence(:name) {|n| "_page_partial_#{n}" }
  m.format "html"
  m.handler "erb"
end

Factory.define :page_routes, :class => Cms::PageRoute do |m|
  m.sequence(:pattern) {|n| "/page_route_#{n}"}
  m.association :page
end

Factory.define :page_template, :class => Cms::PageTemplate do |m|
  m.sequence(:name) {|n| "page_template_#{n}" }
  m.format "html"
  m.handler "erb"
  m.body %q{<html>
  <head>
    <title>
      <%= page_title %>
    </title>
    <%= yield :html_head %>
  </head>
  <body>
    <%= cms_toolbar %>
    <%= container :main %>
  </body>
</html>}
end

Factory.define :permission, :class => Cms::Permission do |m|
  m.sequence(:name) {|n| "TestPermission#{n}" }
end

Factory.define :section, :class => Cms::Section do |m|
  m.name "Test"
  m.path "/"
  m.parent { Cms::Section.root.first }
end

Factory.define :site, :class => Cms::Site do |m|
  m.sequence(:name) {|n| "Test #{n}"}
  m.domain {|a| "#{a.name.gsub(/\s/,"_").downcase}.com" }
end

Factory.define :task, :class => Cms::Task do |m|
  m.association :assigned_by, :factory => :user
  m.association :assigned_to, :factory => :user
  m.association :page
end

Factory.define :user, :class => Cms::User do |m|
  m.first_name "Test"
  m.last_name "User"
  m.sequence(:login) {|n| "test_#{n}" }
  m.email {|a| "#{a.login}@example.com" }
  m.password "password"
  m.password_confirmation {|a| a.password }
end
