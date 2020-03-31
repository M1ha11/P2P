// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var date = document.getElementById('card_expire_date');
date.onkeyup = slash;

var num = document.getElementById('card_card_number');
num.onkeyup = space_in_number;

function slash() {
  if (this.value.length === 2) {
    this.value = this.value + '/';
  }
}

function space_in_number() {
  this.value = this.value.replace(/[^\d]/g, '').replace(/(.{4})/g, '$1 ').trim();
}