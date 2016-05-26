do ->
  wua = ->
    $('.visible-windows-block').css 'display', 'block'
    $('.visible-windows-inline').css 'display', 'inline'
    $('.hidden-windows').hide()
    return

  mua = ->
    $('.visible-macintosh-block').css 'display', 'block'
    $('.visible-macintosh-inline').css 'display', 'inline'
    $('.hidden-macintosh').hide()
    return

  lua = ->
    $('.visible-linux-block').css 'display', 'block'
    $('.visible-linux-inline').css 'display', 'inline'
    $('.hidden-linux').hide()
    return

  moua = ->
    $('.visible-mobile-block').css 'display', 'block'
    $('.visible-mobile-inline').css 'display', 'inline'
    $('.hidden-mobile').hide()
    return

  rmf1 = ->
    $('#btn1').removeClass 'focus'
    return

  rmf2 = ->
    $('#btn2').removeClass 'focus'
    return

  rmf3 = ->
    $('#btn3').removeClass 'focus'
    return

  wbtn = ->
    $('.visible-macintosh-block,.visible-linux-block,.visible-macintosh-inline,.visible-linux-inline').hide()
    wua()
    rmf2()
    rmf3()
    $('#btn1').addClass 'focus'
    return

  mbtn = ->
    $('.visible-windows-block,.visible-linux-block,.visible-windows-inline,.visible-linux-inline').hide()
    mua()
    rmf1()
    rmf3()
    $('#btn2').addClass 'focus'
    return

  lbtn = ->
    $('.visible-windows-block,.visible-macintosh-block,.visible-windows-inline,.visible-macintosh-inline').hide()
    lua()
    rmf1()
    rmf2()
    $('#btn3').addClass 'focus'
    return

  mobtn = ->
    if navigator.userAgent.indexOf('iPhone') > 0 or navigator.userAgent.indexOf('iPad') > 0 or navigator.userAgent.indexOf('iPod') > 0 or navigator.userAgent.indexOf('Android') > 0 or navigator.userAgent.indexOf('Windows Phone') > 0
      wbtn()
    return

  if navigator.userAgent.indexOf('Windows NT') > 0
    wua()
  if navigator.userAgent.indexOf('Macintosh') > 0
    mua()
  if navigator.userAgent.indexOf('Linux') > 0 and navigator.userAgent.indexOf('Android') < 0
    lua()
  if navigator.userAgent.indexOf('iPhone') > 0 or navigator.userAgent.indexOf('iPad') > 0 or navigator.userAgent.indexOf('iPod') > 0 or navigator.userAgent.indexOf('Android') > 0 or navigator.userAgent.indexOf('Windows Phone') > 0
    moua()
    $('#dlbtn').attr 'disabled', ''
