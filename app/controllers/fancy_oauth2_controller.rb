class FancyOauth2Controller < ActionController::Base

  def callback
    code = params[:code]
    uri = FancyOauth2.callback_url_builder.call(request)
    token = FancyOauth2.client.auth_code.get_token(code, :redirect_uri => uri)
    if token.token
      @auth = {
        access_token: token.token, 
        expires_in: token.expires_in, 
        refresh_token: token.refresh_token
      }
      render 'callback_success', :layout => "fancy_oauth2_popup"
    else
      render 'callback_error', :layout => "fancy_oauth2_popup"
    end
  end

end
