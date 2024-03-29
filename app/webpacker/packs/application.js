/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

$(function(){
  console.log('Hello World from Webpacker')
})

import Rails from 'rails-ujs';
import Inputmask from 'inputmask'
import jQuery from 'jquery'
import 'inputmask/dist/inputmask/jquery.inputmask';
import $ from 'jquery'
import 'bootstrap/dist/js/bootstrap';
import Turbolinks from 'turbolinks';
import '../src/js/city_shadow';
import '../src/js/masks';

Rails.start();
Turbolinks.start();
