var app = angular.module('app',[]);
	app.controller('controllerName', ['$scope', function ($scope) {	      
	    $scope.mail = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
	    
	    $scope.re = /^[a-zA-Z0-9]\w{5,13}$/;
	    $scope.compare = function (repass) {
	        $scope.isconfirm = $scope.password != repass ? true : false;
	    }
	}]);
	app.directive('uiCelular', function () {
	    return {
	        require: 'ngModel',
	        link: function (scope, element, attrs,ctrl) {
	
	            var _formatCelular = function (celular) {
	                celular = celular.replace(/[^0-9]+/g, "");
	                if(celular.length > 2){
	                    celular = "(" + celular.substring(0,2) + ")" + celular.substring(2);
	                }
	                if(celular.length > 8){
	                    celular = celular.substring(0,9) + "-" + celular.substring(9, 13);
	                }
	                return celular;
	            }
	
	            element.bind('keyup', function () {
	                ctrl.$setViewValue(_formatCelular(ctrl.$viewValue));
	                ctrl.$render();
	            });
	        }
	    };
	});
	app.directive('uiTelefone', function () {
	    return {
	        require: 'ngModel',
	        link: function (scope, element, attrs,ctrl) {
	
	            var _formatTelefone = function (telefone) {
	                telefone = telefone.replace(/[^0-9]+/g, "");
	                if(telefone.length > 2){
	                    telefone = "(" + telefone.substring(0,2) + ")" + telefone.substring(2);
	                }
	                if(telefone.length > 8){
	                    telefone = telefone.substring(0,8) + "-" + telefone.substring(8, 12);
	                }
	                return telefone;
	            }
	
	            element.bind('keyup', function () {
	                ctrl.$setViewValue(_formatTelefone(ctrl.$viewValue));
	                ctrl.$render();
	            });
	        }
	    };
	});
	app.directive('uiCep', function () {
		   return {
		    require: 'ngModel',
		    link: function (scope, element, attrs,ctrl) {

	        var _formatCep = function (cep) {
			 cep = cep.replace(/[^0-9]+/g, "");
			 if(cep.length > 2){
			  cep = cep.substring(0,2) + "." + cep.substring(2);
			 }
			 if(cep.length > 6){
			  cep = cep.substring(0,6) + "-" + cep.substring(6, 9);
			 }
			  return cep;
			 }
	         element.bind('keyup', function () {
	          ctrl.$setViewValue(_formatCep(ctrl.$viewValue));
	          ctrl.$render();
	         });
			}
		   };
		  });