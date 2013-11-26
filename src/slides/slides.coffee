angular.module('slides',['views','revealjs','angular-gestures'])

.value('firebaseUrl','http://madebymark.firebaseio.com/demo')

.run([
  '$rootScope','firebaseUrl',
  ($rootScope,firebaseUrl) ->
    slideIndexRef = new Firebase(firebaseUrl+'/index')
    update = -> 
      i = Reveal.getIndices()
      slideIndexRef.set({h: i.h, v: i.v, f: i.f || 0})
    
    slideIndexRef.on 'value',(snapshot) ->
      value = snapshot.val()
      Reveal.slide(value.h,value.v,value.f)

    $rootScope.$watch 'reveal', (reveal) ->
      if reveal is true
        Reveal.addEventListener 'slidechanged', update
        Reveal.addEventListener 'fragmentshown', update
        Reveal.addEventListener 'fragmenthidden', update
  ])

.controller('slidesCtrl', 
  ['$scope','firebaseUrl',
  ($scope,firebaseUrl) ->
    themeRef = new Firebase(firebaseUrl+'/theme')
    themeRef.on 'value', (snapshot) ->
      setTheme(snapshot.val())

    $scope.themes = "beige default moon night serif simple sky solarized".split(' ')

    $scope.setTheme = (theme) ->
      setTheme(theme)
      themeRef.set(theme)

    $scope.options = { controls: no, history: yes, backgroundTransition: 'slide', margin: 0 }
  ])