jQuery -> 
    if $.fancybox?
        $(".fancy-oauth2 a.auth-link").live "click", ->
            window.active_fancy_oauth2 = $(this).parent()
            $.fancybox {href: $(this).attr("href"), type: "iframe"}
            false

    if $("#fancy-oauth2-callback-window-content").length > 0
        auth = $("#fancy-oauth2-callback-window-content #auth-token").data("auth")
        div = parent.window.active_fancy_oauth2
        console.log "fancy_oauth2.js - no active fancy oauth2 div" unless div?
        if auth? and auth.access_token?
            div.find("input.access-token").attr("value", auth.access_token)
            div.find("input.expires-in").attr("value", auth.expires_in)
            div.find("input.refresh-token").attr("value", auth.refresh_token)
            div.find("a.auth-link").addClass("success")
        else
            div.find("a.auth-link").removeClass("success")
        





