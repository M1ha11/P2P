$(document).on('turbolinks:load',function () {
  var search_result = new Bloodhound({
    datumTokenizer: Bloodhound.tokenizers.whitespace,
    queryTokenizer: Bloodhound.tokenizers.whitespace,
    remote: {
      url: '/search?q=%QUERY',
      wildcard: '%QUERY'
    }
  });
  $('#autocomplete').typeahead(null,
    {
      source: search_result,
      limit: 10,
      templates: {
        empty: [
          '<div class="empty-typehead">',
            'Unable to find claim',
          '</div>'
        ].join('\n'),
        suggestion: function(search_result) {
          return (
            '<a href="/claims/' + search_result.id + '"><p class="hint">' + search_result.amount + ' ' + search_result.currency +'</p></a>'
          );
        }
      }
    }
  )
})
