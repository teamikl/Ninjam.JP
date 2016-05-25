###
  Copyright (c) 2016 Ikkei Shimomura(tea)
  Licensed under the MIT license : https://opensource.org/licenses/mit-license.php
###

do ->
  td = (x) -> $('<td>').text x
  getName = (x) -> x.name
  isNotBot = (x) -> !x.match /^(ninbot|Jambot)$/
  updateServerList = ->
    $.get 'http://ninbot.com/app/servers.php', (contents) ->
      data = JSON.parse(contents.responseText.replace(/<[^>]*>/g, ''))
      if data.servers?
        tbody = $('#tableBody').empty()
        $(data.servers).each (_, x) ->
          tr = $('<tr>')
            .hide()
            .append td x.name
            .append td x.users.map(getName).filter(isNotBot).join ' / '
            .fadeIn 'normal'
          tbody.append tr
  updateServerList()
  setInterval updateServerList, 30000
