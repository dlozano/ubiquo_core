require File.dirname(__FILE__) + "/../../../test_helper.rb"

class Ubiquo::Helpers::CoreUbiquoHelpersTest < ActionView::TestCase

  test 'ubiquo_image_path prepends ubiquo by default' do
    assert_equal 'ubiquo/image.png', ubiquo_image_path('image.png')
  end

  test 'ubiquo_image_path uses :ubiquo_path value' do
    Ubiquo::Config.set(:ubiquo_path, 'new_path')
    assert_equal 'new_path/image.png', ubiquo_image_path('image.png')
  end

  test 'ubiquo_image_tag is a wrapper for image_tag using ubiquo_image_path' do
    options = {:key => :value}
    self.expects(:ubiquo_image_path).with('image.png').returns('image_path')
    self.expects(:image_tag).with('image_path', options).returns('image_tag')
    assert_equal 'image_tag', ubiquo_image_tag('image.png', options)
  end

  test 'ubiquo_boolean_image should return a span with class and value' do
    result = HTML::Document.new(ubiquo_boolean_image(true))
    assert_select result.root, "span[class=state_true]", 'true'
  end

  test 'ubiquo_sidebar_box should return a sidebarbox div with header and content' do
    sidebar_box = ubiquo_sidebar_box('title', :class => 'test') { "body" }
    result = HTML::Document.new sidebar_box
    assert_select result.root, "div[class=sidebar_box test] > h3 > div[class=header]", "title"
    assert_select result.root, "div[class=sidebar_box test] > div[class=content]", "body"
  end

end
