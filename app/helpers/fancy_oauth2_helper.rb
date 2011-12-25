module FancyOauth2Helper

  def fancy_oauth2_tag(field, value = nil, options = {})
    url = FancyOauth2.authorize_url(options, request)
    klass = "auth-link"
    klass += " success" if value.present?
    msg = t("fancy_oauth2.auth_link", :default => 'Click to (re)authenticate')
    content_tag :div, :class => "fancy-oauth2" do
      [].tap do |out|
        out << link_to(msg, url, :class => klass)
        out << hidden_field_tag(field, value, :class => 'token')
      end.join("\n").html_safe
    end
  end

end
