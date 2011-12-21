#= require partials/uri-parser

class FancyOauth2Handler
    constructor: (@field)->
        @popup = null
        @popup_name = "Fancy OAuth2"
        if $("#fancy-oauth2-dark-cloak").length == 0
            $("html body").append('<div id="fancy-oauth2-dark-cloak" style="display:none"> <!-- cloak --> </div>')

    showPopup: ->
        url = @field.find("a.auth-link").attr("href")
        $('#fancy-oauth2-dark-cloak').fadeIn()
        @popup = window.open(url, @popup_name, 'left=100,top=100,height=600,width=700')
        this.onTimer()  # just to focus the window and schedule the timer

    hidePopup: ->
        $('#fancy-oauth2-dark-cloak').fadeOut()
        @popup.window.close() if @popup?
        @popup = null

    updateAuthLink: (auth) ->
        console.log "updateAuthLink: " + auth
        if auth? and auth.access_token?
            @field.find("input.access-token").attr("value", auth.access_token)
            @field.find("input.expires-in").attr("value", auth.expires_in)
            @field.find("input.refresh-token").attr("value", auth.refresh_token)
            @field.find("a.auth-link").addClass("success")
        else
            # resetting fancy_oauth2 field to "failed" state
            @field.find("input").attr("value", null)
            @field.find("a.auth-link").removeClass("success")


    onTimer: => 
        if @popup?
            # checking for oauth2 results div
            result = try
                $("#auth-token", @popup.document)
            catch e
                null
            if result? && result.length > 0 # negotoation finished
                this.updateAuthLink result.data("auth")
                this.hidePopup()
        # need another iteration?
        if @popup 
            if @popup.closed
                $('#fancy-oauth2-dark-cloak').fadeOut()
            else
                @popup.window.focus() if window.focus
                setTimeout(this.onTimer, 300)


jQuery -> 
    $(".fancy-oauth2 a.auth-link").live "click", ->
        #window.active_fancy_oauth2 = $(this).parent()
        #$.fancybox {href: $(this).attr("href"), type: "iframe"}
        handler = new FancyOauth2Handler($(this).parent())
        handler.showPopup()
        return false

