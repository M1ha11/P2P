document.getElementById('link-tag').onclick=function show(event) {
  event.preventDefault();
  document.getElementById('edit-tag-form').style.display = 'block';
};

document.getElementById('close-tag').onclick=function hide(event) {
  event.preventDefault();
  document.getElementById('edit-tag-form').style.display = 'none';
};

document.getElementById('remove-tag').onclick=function show(event) {
  event.preventDefault();
  document.getElementById('remove-tag-form').style.display = 'block';
};

document.getElementById('close-rem').onclick=function hide(event) {
  event.preventDefault();
  document.getElementById('remove-tag-form').style.display = 'none';
};

document.getElementById('open-full-stat').onclick=function show(event) {
  event.preventDefault();
  $('#full_'+$(this).attr('data')).toggle();
};

document.getElementById('close-full-stat').onclick=function hide(event) {
  event.preventDefault();
  document.getElementById('hidden-full-stat').style.display = 'none';
};

