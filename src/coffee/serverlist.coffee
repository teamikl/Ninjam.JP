###
  Copyright (c) 2016 Ikkei Shimomura(tea)
  Licensed under the MIT license : https://opensource.org/licenses/mit-license.php
###

getName = (a) ->
  a.name

isNotBot = (a) ->
  !a.match(/^(ninbot|Jambot)$/)

updateServerList = ->
  $.get 'http://ninbot.com/app/servers.php', (b) ->
    b = JSON.parse(b.responseText.replace(/<[^>]*>/g, ''))
    if typeof b.servers != 'undefined'
      a = $('#tableBody').empty()
      $(b.servers).each (c, e) ->
        d = $('<tr>').css(display: 'none').append($('<td>').text(e.name)).append($('<td>').text(e.users.map(getName).filter(isNotBot).join(' / ')))
        a.append d
        d.fadeIn 'normal'
        return
    return
  return

setInterval updateServerList, 30000
updateServerList()
