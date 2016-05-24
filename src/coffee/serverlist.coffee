### Copyright (c) 2016 Ikkei Shimomura(tea)
  Licensed under the MIT license : https://opensource.org/licenses/mit-license.php  ###

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

jQuery.ajax = ((e) ->
  g = location.protocol
  a = location.hostname
  c = RegExp(g + '//' + a)
  b = 'http' + (if /^https/.test(g) then 's' else '') + '://query.yahooapis.com/v1/public/yql?callback=?'
  f = 'select * from html where url="{URL}" and xpath="*"'

  d = (h) ->
    !c.test(h) and /:\/\//.test(h)

  (i) ->
    h = i.url
    if /get/i.test(i.type) and !/json/i.test(i.dataType) and d(h)
      i.url = b
      i.dataType = 'json'
      i.data =
        q: f.replace('{URL}', h + (if i.data then (if /\?/.test(h) then '&' else '?') + jQuery.param(i.data) else ''))
        format: 'xml'
      if !i.success and i.complete
        i.success = i.complete
        delete i.complete
      i.success = ((j) ->
        (k) ->
          if j
            j.call this, { responseText: (k.results[0] or '').replace(/<script[^>]+?\/>|<script(.|\s)*?\/script>/gi, '') }, 'success'
          return
      )(i.success)
    e.apply this, arguments
)(jQuery.ajax)
setInterval updateServerList, 30000
updateServerList()
