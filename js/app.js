

var akApp = angular.module('akApp', ['ui.router']);

akApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/');

    $stateProvider

        // HOME STATES AND NESTED VIEWS ========================================
        .state('home', {
            url: '/',
            templateUrl: 'views/home.html'
        })

        .state('empresas', {
            url: '/empresas',
            templateUrl: 'views/empresas.html'
        })

        .state('consumidores', {
            url: '/consumidores',
            templateUrl: 'views/consumidores.html'
        })

        .state('contacto', {
            url: '/contacto',
            templateUrl: 'views/contacto.html'
        })

        .state('listakosher', {
            url: '/listakosher',
            templateUrl: 'views/listakosher.html',
            controller: 'listaCtrl',
            resolve: {
                rubros: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getRubros($stateParams.jwttoken);
                }]
                ,
                productos: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getProductos($stateParams.jwttoken);
                }]
            }

        })

});

akApp.factory('apiService', function ($http, $q, $state) {

    //var apiUrl = "/jwt/api/";
    var apiUrl = "api/";


    // API DE RUBROS

    function _getRubros(token) {
        console.log("getting rubros with token: " + token);
        return $http({
            url: apiUrl + "categorias.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _getProductos(token) {
        console.log("getting productos with token: " + token);
        return $http({
            url: apiUrl + "products.php",
            method: "GET",
            params: { token: token }
        });
    }


    return {

        getRubros: _getRubros,
        getProductos: _getProductos,
 
    }

})

akApp.controller('listaCtrl', ['$scope', '$http', '$sce', 'productos', 'rubros', function ($scope, $http, $sce, productos, rubros) {
    console.log("listaCtrl");
    console.log(productos);
    console.log(rubros);

    $scope.$watch('query', function(newValue, oldValue) {
        console.log(newValue);
    });

    $scope.productos = productos.data;
    $scope.rubros = rubros.data;
    console.log($scope.productos);
    console.log($scope.rubros);
    $scope.query = "";
    $scope.trustAsHtml = $sce.trustAsHtml;

    function removeAccents(value) {
        return value
            .replace(/á/g, 'a')
            .replace(/é/g, 'e')
            .replace(/í/g, 'i')
            .replace(/ó/g, 'o')
            .replace(/ú/g, 'u')
            .replace(/Á/g, 'A')
            .replace(/É/g, 'E')
            .replace(/Í/g, 'I')
            .replace(/Ó/g, 'O')
            .replace(/Ú/g, 'U')
            .replace(/ñ/g, 'n')
            .replace(/Ñ/g, 'N');

    }

    $scope.ignoreAccentsProducto = function (item) {
        if (!$scope.query)
            return true;

        var fullItem = item.descripcion + ' ' + item.rubro + ' ' + item.marca+ ' ' + item.codigoNombre;
        var text = removeAccents(fullItem.toLowerCase());
        var search = removeAccents($scope.query.toLowerCase());
        var searchTextSplit = search.split(' ');
        
        for (var y = 0; y < searchTextSplit.length; y++) {
            if (text.indexOf(searchTextSplit[y]) == -1) {
                return false;
            }
        }
        return true;
    };

    $scope.ignoreAccentsRubro = function (item) {
        if (!$scope.query)
            return true;

        var fullItem = item.nombre;
        var text = removeAccents(fullItem.toLowerCase());
        var search = removeAccents($scope.query.toLowerCase());
        var searchTextSplit = search.split(' ');
        var count = 0;
        for (var y = 0; y < searchTextSplit.length; y++) {
            if (text.indexOf(searchTextSplit[y]) !== -1) {
                count++;
            }
        }
        if (count == searchTextSplit.length)
            return true;
        else
            return false;
    };

    $scope.renderHtml = function (html_code) {
        return $sce.trustAsHtml(html_code);
    };

    $scope.clickRubro = function (rubro) {
        console.log(rubro.nombre);
        $scope.query = rubro.nombre;
    };
}]);