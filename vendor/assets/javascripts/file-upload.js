//= require bootstrap-fileinput/js/fileinput.min
//= require bootstrap-fileinput/js/locales/pt-BR.js

$("input.file").fileinput({
  'type': 'file',
  'previewFileType':'any',
  'showUploadedThumbs':false,
  'showUpload': false,
  'showPreview': false,
  'language': 'pt-BR'
});
