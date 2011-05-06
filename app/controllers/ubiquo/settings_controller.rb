class Ubiquo::SettingsController < UbiquoController

  #ubiquo_config_call :setting_access_control, {:context => :ubiquo_setting}
  
  # GET /settings
  # GET /settings.xml
  # GET /settings.json
  def index
    
    @contexts = Ubiquo::Settings.overridable? ? uhook_index : {}
    
    respond_to do |format|
      format.html # index.html.erb  
      format.xml  {
        render :xml => @contexts
      }
    end
  end
  
  def destroy
    @setting = Setting.find(params[:id])
    if @setting.destroy
      flash[:notice] = t("ubiquo.setting.destroyed")
    else
      flash[:error] = t("ubiquo.setting.destroy_error")
    end
    respond_to do |format|
      format.html { redirect_to(ubiquo_settings_url) }
      format.xml  { head :ok }
    end
  end

  # POST /settings
  # POST /settings.xml
  def create
    result = @result = uhook_create_setting

    respond_to do |format|
      if result[:valids].present?
        flash[:notice] = "#{result[:valids].length} #{t("ubiquo.setting.created")}"
        flash[:notice] += " - #{result[:errors].length} #{t("ubiquo.setting.errors")}" if result[:errors].present?
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      elsif result[:errors].present?
        flash[:error] = t("ubiquo.setting.create_error")
        flash[:error] += " - #{result[:errors].length} #{t("ubiquo.setting.errors")}"
        format.xml  { render :xml => result[:errors], :status => :unprocessable_entity }
      end
      format.html { redirect_to(ubiquo_settings_url) }
    end
  end

  private

  def load_setting
    @setting = Setting.find(params[:id])
  end
end
