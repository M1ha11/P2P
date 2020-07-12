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
      display: `${search_result}`,
      templates: {
        empty: [
          '<div class="empty-typehead">',
            'Unable to find',
          '</div>'
        ].join('\n'),
        suggestion: function(search_result) {
          if (search_result.model_name == 'Claim'){
            return (
              `<a href="${search_result.url}" class="auto-lnk">
                <p class="hint">${search_result.title} ${search_result.amount} ${search_result.currency}</p>
              </a>`
            );
          } else if (search_result.model_name == 'Tag') {
            return (
              `<a href="${search_result.url}" class="auto-lnk">
                <p class="hint">${search_result.name}</p>
              </a>`
            );
          }
        }
      }
    }
  )
});