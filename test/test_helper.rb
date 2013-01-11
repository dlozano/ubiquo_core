require File.dirname(__FILE__) + "/../../../../test/test_helper.rb"

if ActiveRecord::Base.connection.class.to_s == "ActiveRecord::ConnectionAdapters::PostgreSQLAdapter"
  ActiveRecord::Base.connection.client_min_messages = "ERROR"
end

require File.dirname(__FILE__) + '/relation_helper'
require 'rake' # For cron job testing


def enable_settings_override
  Ubiquo::Settings[:ubiquo][:settings_overridable] = true
end

def disable_settings_override
  Ubiquo::Settings[:ubiquo][:settings_overridable] = false
end

module SettingsTestHelper

  def setup
    save_current_settings
  end

  def teardown
    clear_settings
  end

  protected

  def clear_settings
    UbiquoSetting.delete_all
    Ubiquo::Settings.settings[:ubiquo] = @old_configuration.clone
    Ubiquo::Settings.settings.reject! { |k, v| !@initial_contexts.include?(k)}
  end

  def save_current_settings
    @initial_contexts =  Ubiquo::Settings.settings.keys
    @old_configuration = Ubiquo::Settings.settings[Ubiquo::Settings.default_context].clone
  end
end
