require File.dirname(__FILE__) + "/../../test_helper.rb"

class Ubiquo::SettingsTest < ActiveSupport::TestCase
  include Ubiquo::Extensions::ConfigCaller
  include SettingsTestHelper

  include Ubiquo::UbiquoSettingsHelper

  def test_should_render_custom_view_for_each_setting
    expects(:render).with do |*args|
      args.first == '/ubiquo/ubiquo_settings/helper_test/test_custom_view' &&
      args.last.values.first.kind_of?(UbiquoStringSetting) &&
      args.last.keys.first == :ubiquo_setting
    end.once.returns(true)
    render_template_type(UbiquoStringSetting.new(:context => 'helper_test', :key => 'test_custom_view'))
  end

  def test_should_render_custom_view_for_setting_type
    expects(:render).with do |*args|
      args.first == '/ubiquo/ubiquo_settings/helper_test/test_custom_view' &&
      args.last.values.first.kind_of?(UbiquoStringSetting) &&
      args.last.keys.first == :ubiquo_setting
    end.once.returns(false)

    expects(:render).with do |*args|
      args.first == '/ubiquo/ubiquo_settings/string' &&
      args.last.values.first.kind_of?(UbiquoStringSetting) &&
      args.last.keys.first == :ubiquo_setting
    end.once.returns(true)

    render_template_type(UbiquoStringSetting.new(:context => 'helper_test', :key => 'test_custom_view'))
  end


end

