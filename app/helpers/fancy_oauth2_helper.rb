module FancyOauth2Helper

  def fancy_oauth2_tag(field, values, options = {})
    values ||= {}
    url = FancyOauth2.authorize_url(options, request)
    klass = "auth-link"
    klass += " success" if values[:access_token].present?
    msg = t("fancy_oauth2.auth_link", :default => 'Click to (re)authenticate')
    content_tag :div, :class => "fancy-oauth2" do
      [].tap do |out|
        out << link_to(msg, url, :class => klass)
        out << hidden_field_tag("#{field}[access_token]", values[:access_token], :class => 'access-token')
        out << hidden_field_tag("#{field}[expires_in]", values[:expires_in], :class => 'expires-in')
        out << hidden_field_tag("#{field}[refresh_token]", values[:refresh_token], :class => 'refresh-token')
      end.join("\n").html_safe
    end
  end

end
