

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
            templateUrl: 'views/consumidores.html',
            controller: 'consumersCtrl',
            resolve: {
                alertas: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getAlertas();
                }]
            }

        })

        .state('guia', {
            url: '/guia',
            templateUrl: 'views/guiakosher.html',
            controller: 'guiaKosherCtrl',
            resolve: {
                guiaKosher: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getGuiaKosher();
                }]
            }
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
                    return apiService.getRubros();
                }]
                ,
                productos: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getProductos();
                }]
            }

        })

});

akApp.factory('apiService', function ($http) {

    //var apiUrl = "/jwt/api/";
    var apiUrl = "api/";



    function _getRubros() {
        console.log("getting rubros");
        return $http({
            url: apiUrl + "categorias.php",
            method: "GET"
        });
    }

    function _getProductos() {
        console.log("getting productos");
        return $http({
            url: apiUrl + "products.php",
            method: "GET"
        });
    }

    function _getAlertas() {
        console.log("getting alertas");
        return $http({
            url: apiUrl + "alertas.php",
            method: "GET"
        });
    }

    function _getGuiaKosher() {
        console.log("getting guia kosher");
        return $http({
            url: apiUrl + "textos.php?name=guiakosher",
            method: "GET"
        });
    }



    return {

        getRubros: _getRubros,
        getProductos: _getProductos,
        getAlertas: _getAlertas,
        getGuiaKosher: _getGuiaKosher
 
    }

})


akApp.controller('consumersCtrl', ['$scope', '$http', '$sce', 'alertas', '$timeout', function ($scope, $http, $sce, alertas, $timeout) {
    console.log("consumersCtrl");

    console.log(alertas.data);
    $scope.alertas =  alertas.data;

    $scope.renderHtml = function (html_code) {
        var html_code2 = html_code + "<script> $(document).ready(function () { $(\"img\").addClass(\"img-responsive\"); }); </script>";
        return $sce.trustAsHtml(html_code2);
    };
    
        
    
    

}]);



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


akApp.controller('guiaKosherCtrl', ['$scope', '$http', '$sce', 'guiaKosher', function ($scope, $http, $sce, guiaKosher) {
    console.log("guiaKosherCtrl");
    console.log(guiaKosher.data[0]);
    $scope.guiaKosher = guiaKosher.data[0];

    $scope.renderHtml = function (html_code) {
        var html_code2 = html_code + "<script> $(document).ready(function () { $(\"img\").addClass(\"img-responsive\"); }); </script>";
        return $sce.trustAsHtml(html_code2);
    };
}]);