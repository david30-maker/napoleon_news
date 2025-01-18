import "@hotwired/turbo-rails";
import "controllers";
import "bootstrap";
import "@popperjs/core";
import "trix";
import "@rails/actiontext";
import Rails from "@rails/ujs";
Rails.start();
import "timestamp_formatter";


document.addEventListener("DOMContentLoaded", () => {
  // Find all figure elements with images
  const figures = document.querySelectorAll("figure");

  figures.forEach(figure => {
    const img = figure.querySelector("img");
    const figCaption = figure.querySelector("figcaption");

    if (img && figCaption) {
      // Update the alt attribute of the image with the figcaption text
      img.alt = figCaption.textContent.trim();
    }
  });
});