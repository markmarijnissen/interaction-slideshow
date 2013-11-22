# filter takes an array of strings or regexes
filter = (tests) -> 
  (file) -> 
    for test in tests 
      if typeof test is "string" and test is file 
        return true 
      else if test.test(file)
        return true 
    return false

# route all files to right css/js
slidesAppFilter = filter([/^src\/slides/])
controllerAppFilter = filter([/^src\/controller/])
viewerAppFilter = filter([/^src\/viewer/])
libFilter = filter([/^bower_components/,/^src\/tools/])

exports.config =
  paths:
    public: 'dist/dev'
    watched: ['src','static']

  conventions:
    assets: /^static\//

  # turn of module wrapping
  modules:
    definition: false
    wrapper: false
  
  # join apps together
  files:
    javascripts:
      joinTo: 
        'controller/controller.app.js':controllerAppFilter
        'slides/slides.app.js': slidesAppFilter
        'viewer/viewer.app.js':viewerAppFilter
        'lib.js': libFilter
      order:
        before: [
            'bower_components/jquery/jquery.js'
            'bower_components/reveal.js/js/reveal.js'
            'bower_components/angular/angular.js'
            'bower_components/angular-fire/angularFire.js'
            'bower_components/angular-gestures/gestures.min.js'
            'src/tools/views-module.coffee'
            'src/tools/angular-revealjs.coffee'
          ]  

    stylesheets:
      joinTo: 
        'lib.css':libFilter
        'controller/controller.app.css': controllerAppFilter
        'slides/slides.app.css':slidesAppFilter
        'viewer/viewer.app.css':viewerAppFilter
    
    templates:
      joinTo: 
        'controller/controller.views.js':controllerAppFilter
        'slides/slides.views.js':slidesAppFilter
        'viewer/viewer.views.js':viewerAppFilter

   # app module
   angularTemplate:
     moduleName: 'views'

   # config for different releases
   keyword:
    map:
      target: 'DEV'

  overrides:
    production:
      paths: public: 'dist/www'
      server: port: 3334
