angular.module('revealjs',[])
.directive 'revealjs',
	['$window','$rootScope'
	($window,$rootScope) ->
		scope: 
			options: '&revealjs'
		link: ($scope,elem,attrs) -> 
			$rootScope.reveal = true;
			elem.addClass('reveal')
			elem.find('iframe.fullscreen').attr({
					width: $window.innerWidth
					height: $window.innerHeight
				})
			window.elem = elem
			if(!$scope.options.fitToParent) 
				elem.css('position','absolute')
			Reveal.initialize($scope.options())
	]		

