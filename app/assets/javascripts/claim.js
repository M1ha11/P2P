document.getElementById('link-tag').onclick=function show(event) {
  event.preventDefault();
  document.getElementById('edit-tag-form').style.display = 'block';
};

document.getElementById('close-tag').onclick=function hide(event) {
  event.preventDefault();
  document.getElementById('edit-tag-form').style.display = 'none';
};
