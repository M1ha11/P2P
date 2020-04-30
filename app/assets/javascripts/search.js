$(document).on('turbolinks:load',function () {
  search_result = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/autocomplete?q=%QUERY',
      wildcard: '%QUERY'
    }
  })
  $('#autocomplete').typeahead(null,
    {
      source: search_result,
      templates: {
        empty: [
          '<div class="empty-typehead">',
            'Unable to find claim',
          '</div>'
        ].join('\n'),
        suggestion: function(search_result) {
          return ('<p class="hint">' + search_result.amount + ' ' + search_result.currency +'</p>');
        }
      }
    }
  )
})
