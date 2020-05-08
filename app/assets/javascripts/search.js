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
      display: `${search_result.amount} {search_result.currency}`,
      templates: {
        empty: [
          '<div class="empty-typehead">',
            'Unable to find',
          '</div>'
        ].join('\n'),
        suggestion: function(search_result) {
          return (
            `<a href="${search_result.url}" class="auto-lnk">
              <p class="hint">Credit on ${search_result.amount} ${search_result.currency}</p>
            </a>`
          );
        }
      }
    }
  )
});

// $('#search-form').submit(function(event) {
//   event.preventDefault();
//   var q = $(this).find('input[name="q"]').val(),
//   $.ajax({
//     url: '/search?q=%'+ q,
//     type: 'GET',

//   }).done(function(response){
//     $('body').html(response)
//   })
// });