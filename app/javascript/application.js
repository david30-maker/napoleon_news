import Rails from "@rails/ujs";
Rails.start();


// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";
import "@popperjs/core";

// require("trix");
// require("@rails/actiontext");

import "trix";
import "@rails/actiontext";


document.addEventListener('turbo:load', () => {
    const carouselElement = document.querySelector('.after-nav-2');
    if (carouselElement) {
      carouselElement.style.marginTop = '0';
    }
  });