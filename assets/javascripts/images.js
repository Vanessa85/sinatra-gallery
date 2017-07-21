!function(window, document, undefined) {
  'use strict';

  let inputFile = document.querySelector('input[name=image_file]');
  let imagePreview = document.getElementById('image_preview');

  function previewImage(event) {
    let file = event.target.files[0];

    if (file) {
      let reader = new FileReader();
      reader.onloadend = function(event) {
        imagePreview.src = reader.result;
      };
      reader.readAsDataURL(file);
    }
  }
  
  if (inputFile) {
    inputFile.addEventListener('change', previewImage);
  }

}(window, document);
