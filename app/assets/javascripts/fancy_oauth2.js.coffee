#= require partials/uri-parser

class FancyOauth2Handler
    constructor: (@field)->
        @popup = null
        @popup_name = "fancy_oauth2"
        $('#fancy-oauth2-dark-cloak').live "click", =>
            console.log "reveal the popup"
            this.showPopup()
        if $("#fancy-oauth2-dark-cloak").length == 0
            $("html body").append('<div id="fancy-oauth2-dark-cloak" style="display:none"> <!-- cloak --> </div>')

    showPopup: ->
        url = @field.find("a.auth-link").attr("href")
        $('#fancy-oauth2-dark-cloak').fadeIn()
        @popup = window.open(url, @popup_name, 'left=100,top=100,height=600,width=700')
        @popup.focus() if window.focus
        this.onTimer()  # just to focus the window and schedule the timer

    hidePopup: ->
        $('#fancy-oauth2-dark-cloak').fadeOut()
        @popup.window.close() if @popup?
        @popup = null

    updateAuthLink: (auth) ->
        console.log "updateAuthLink: " + auth
        if auth
            @field.find("input.token").attr("value", auth)
            @field.find("a.auth-link").addClass("success")
        else
            # resetting fancy_oauth2 field to "not authorized" state
            @field.find("input.token").attr("value", null)
            @field.find("a.auth-link").removeClass("success")
        @field.change()
        


    onTimer: => 
        if @popup?
            # checking for oauth2 results div
            result = try
                $("#fancy-oauth2-token", @popup.document)
            catch e
                null
            if result? && result.length > 0 # negotiation finished
                this.updateAuthLink result.find("input[name=token]").attr("value")
                console.log result.data("error") if result.data("error")
                this.hidePopup()
        if @popup # then we need another iteration
            if @popup.closed  # cancelled by the user
                $('#fancy-oauth2-dark-cloak').fadeOut()
                @popup = null
            else
                setTimeout(this.onTimer, 300)


jQuery -> 
    $(".fancy-oauth2 a.auth-link").live "click", ->
        handler = new FancyOauth2Handler($(this).parent())
        handler.showPopup()
        return false

