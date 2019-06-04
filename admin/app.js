// app.js
var routerApp = angular.module('routerApp', ['ui.router', 'ngMaterial', 'ngMessages', 'textAngular']);

routerApp.config(function ($stateProvider, $urlRouterProvider) {

    $urlRouterProvider.otherwise('/home/');

    $stateProvider

        // HOME STATES AND NESTED VIEWS ========================================
        .state('home', {
            url: '/home/:jwttoken',
            templateUrl: 'templates/home.html',
            controller: 'adminCtrl'
            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                token: ['$stateParams',
                    function ($stateParams) { return $stateParams.jwttoken; }]
            }
        })

        .state('productos', {
            url: '/productos/:jwttoken',
            templateUrl: 'templates/productos.html',
            controller: 'adminCtrl'

            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                token: ['$stateParams',
                    function ($stateParams) { return $stateParams.jwttoken; }]
            }

        })

        .state('rubros', {
            url: '/rubros/:jwttoken',
            templateUrl: 'templates/rubro.html',
            controller: 'rubroCtrl'

            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                rubros: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getRubros($stateParams.jwttoken);
                }]
                ,
                productos: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getProductos($stateParams.jwttoken);
                }]
                ,
                niveles: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getNiveles($stateParams.jwttoken);
                }]
                ,
                lecheparve: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getLecheparve($stateParams.jwttoken);
                }]
                ,
                token: ['$stateParams',
                    function ($stateParams) { return $stateParams.jwttoken; }]
            }

        })

        .state('login', {
            url: '/login',
            templateUrl: 'templates/login.html'
        })

});

routerApp.factory('User', function ($http, $q, $state) {
    function _checkAuthentication(token) {
        console.log("checking authentication with token: " + token);
        $http({
            url: 'app_client.php?token=',
            method: "GET",
            params: { token: token }
        }).then(function (response) {
            var data = response.data;
            console.log(data);
            if (typeof (data.userId) === 'undefined') {
                console.log("no identificado, mando al login");
                $state.go('login');
            }
            else { return $q.when(response.data.userId); }

        })
            .catch(function (response) {
                console.error('error', response.status, response.data);
                $state.go('login');
            });
    }
    return {
        checkAuthentication: _checkAuthentication
    }

})

routerApp.factory('apiService', function ($http, $q, $state) {

    //var apiUrl = "/jwt/api/";
    var apiUrl = "/mobiriseAK/admin/api/";


    // API DE RUBROS

    function _getRubros(token) {
        console.log("getting rubros with token: " + token);
        return $http({
            url: apiUrl + "categorias.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _deleteRubro(token, id) {
        console.log("deleting rubro with id: " + id + "and token: " + token);
        return $http({
            url: apiUrl + "categorias.php",
            method: "DELETE",
            params: { token: token, id: id }
        });
    }

    function _postRubro(token, rubro) {
        console.log("posting rubro token: " + token);
        var data = {
            token: token,
            id: rubro.id,
            nombre: rubro.nombre,
            descripcion: rubro.descripcion
        };
        return $http({
            method: 'POST',
            url: apiUrl + "categorias.php",
            params: { token: token },
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            transformRequest: function (obj) {
                var str = [];
                for (var p in obj)
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data: data,
            timeout: 4000
        });
        
    }


    // API DE PRODUCTOS

    function _getProductos(token) {
        console.log("getting productos with token: " + token);
        return $http({
            url: apiUrl + "products.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _deleteProducto(token, id) {
        console.log("deletting producto with id: " + id);
        return $http({
            url: apiUrl + "products.php",
            method: "DELETE",
            params: { token: token, id: id }
        });
    }

    function _postProducto(token, producto) {
        console.log("posting producto token: " + token);
        var data = {
            token: token,
            id: producto.id,
            marca: producto.marca,
            imagen: producto.imagen,
            rubroId: producto.rubroId,
            nivelId: producto.codigoId,
            lecheparveId: producto.lecheparveId,
            descripcion: producto.descripcion
        };
        return $http({
            method: 'POST',
            url: apiUrl + "products.php",
            params: { token: token },
            headers: { 'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8' },
            transformRequest: function (obj) {
                var str = [];
                for (var p in obj)
                    str.push(encodeURIComponent(p) + "=" + encodeURIComponent(obj[p]));
                return str.join("&");
            },
            data: data,
            timeout: 4000
        });
    }



    // API DE NIVEL
    function _getNiveles(token) {
        console.log("getting nivel with token: " + token);
        return $http({
            url: apiUrl + "nivel.php",
            method: "GET",
            params: { token: token }
        });
    }

    // API LECHEPARVE
    function _getLecheparve(token) {
        console.log("getting lecheparve with token: " + token);
        return $http({
            url: apiUrl + "lecheparve.php",
            method: "GET",
            params: { token: token }
        });
    }



    return {
        // RUBROS
        getRubros: _getRubros,
        deleteRubro: _deleteRubro,
        postRubro: _postRubro,

        // PRODUCTOS
        getProductos: _getProductos,
        deleteProducto: _deleteProducto,
        postProducto: _postProducto,

        // NIVEL
        getNiveles: _getNiveles,

        // LECHEPARVE
        getLecheparve: _getLecheparve
    }

})

routerApp.controller('adminCtrl', ['$scope', '$location', '$http', 'token', function ($scope, $location, $http, token) {

    console.log("adminCtrl");

    $scope.htmlVariable = "";
    $scope.params.token = token;
    // console.log($scope.params.token);
    // var jwturl = 'LE HAGO UNA PEGADA A: app_client.php?token=' + token;
    // console.log(jwturl);
    // $http({
    //     url: 'app_client.php?token=',
    //     method: "GET",
    //     params: { token: token }
    // }).then(function (response) {
    //     var data = response.data;
    //     console.log(data);
    //     if (typeof (data.userId) !== 'undefined') { console.log("exitos"); }
    // })
    //     .catch(function (response) {
    //         console.error('error', response.status, response.data);
    //     })
    //     .finally(function () {

    //     });

}]);

routerApp.controller('mainCtrl', ['$scope', '$location', '$http', '$sce', '$timeout', "$mdSidenav", function ($scope, $location, $http, $sce, $timeout, $mdSidenav) {
    console.log("mainCtrl");
    $scope.params = {};
    $scope.toggleLeft = buildDelayedToggler('left');
    $scope.toggleRight = buildToggler('right');
    $scope.isOpenRight = function () {
        return $mdSidenav('right').isOpen();
    };

    /**
     * Supplies a function that will continue to operate until the
     * time is up.
     */
    function debounce(func, wait, context) {
        var timer;

        return function debounced() {
            var context = $scope,
                args = Array.prototype.slice.call(arguments);
            $timeout.cancel(timer);
            timer = $timeout(function () {
                timer = undefined;
                func.apply(context, args);
            }, wait || 10);
        };
    }

    /**
     * Build handler to open/close a SideNav; when animation finishes
     * report completion in console
     */
    function buildDelayedToggler(navID) {
        return debounce(function () {
            // Component lookup should always be available since we are not using `ng-if`
            $mdSidenav(navID)
                .toggle();
        }, 200);
    }

    function buildToggler(navID) {
        return function () {
            // Component lookup should always be available since we are not using `ng-if`
            $mdSidenav(navID)
                .toggle();
        };
    }
    $scope.close = function () {
        // Component lookup should always be available since we are not using `ng-if`
        $mdSidenav('right').close()
            .then(function () { });
    };

}]);

routerApp.controller('rubroCtrl', ['$scope', '$location', '$http', 'apiService', 'token', 'rubros', 'productos', 'niveles', 'lecheparve', '$sce', '$mdDialog', function ($scope, $location, $http, apiService, token, rubros, productos, niveles, lecheparve, $sce, $mdDialog) {
    console.log("rubroCtrl");
    $scope.params.token = token;
    console.log(token);
    $scope.rubros = rubros.data;
    $scope.productos = productos.data;
    $scope.niveles = niveles.data;
    $scope.lecheparve = lecheparve.data;
    console.log($scope.rubros);
    console.log($scope.productos);
    console.log($scope.niveles);
    console.log($scope.lecheparve);

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

    $scope.prodctoEnRubro = function (productoRubroId, rubroId) {
        return (productoRubroId == rubroId);
    };

    $scope.renderHtml = function (html_code) {
        return $sce.trustAsHtml(html_code);
    };


    $scope.updateList = function () {
        setTimeout(function () {
            $scope.$apply(function () {
                var response = apiService.getRubros($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.rubros = data;
                    console.log($scope.rubros);
                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

                var response = apiService.getProductos($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.productos = data;
                    console.log($scope.productos);
                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

            });
        }, 1000);
    }

    $scope.showConfirmDeleteRubro = function (ev, rubro) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
            .title('Seguro que quiere eliminar el rubro "' + rubro.nombre + '"  y TODOS SUS PRODUCTOS ?')
            .ariaLabel('Lucky day')
            .targetEvent(ev)
            .ok('Eliminar')
            .cancel('cancelar');
        $mdDialog.show(confirm).then(function () {
            apiService.deleteRubro($scope.params.token, rubro.id);
            $scope.updateList();
        }, function () {
            // alert("no eliinar");
        });
    };

    $scope.showConfirmDeleteProducto = function (ev, producto) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
            .title('Seguro que quiere eliminar el producto "' + producto.descripcion + '" ?')
            .ariaLabel('Lucky day')
            .targetEvent(ev)
            .ok('Eliminar')
            .cancel('cancelar');
        $mdDialog.show(confirm).then(function () {
            apiService.deleteProducto($scope.params.token, producto.id);
            setTimeout(function () {
                $scope.$apply(function () {
                    var response = apiService.getProductos($scope.params.token);
                    response.success(function (data, status, headers, config) {
                        $scope.productos = data;
                        console.log($scope.productos);
                    });
                    response.error(function (data, status, headers, config) {
                        alert("ERROR");
                    });
                });
            }, 1000);
        }, function () {
            // alert("no eliinar");
        });
    };


    $scope.newProductDialog = function (rubro) {
        var newproduct = {};
        newproduct.rubroId = rubro.id;
        $scope.editProductoDialog(newproduct);
    };

    $scope.editProductoDialog = function (producto) {
        $mdDialog.show({
            locals: { producto: producto, niveles: $scope.niveles, lecheparve: $scope.lecheparve, rubros: $scope.rubros, token: $scope.params.token },
            clickOutsideToClose: false,
            controllerAs: 'ctrl',
            templateUrl: 'templates/dialogs/producto-dialog.html',
            controller: mdProductoDialogCtrl,
            fullscreen: true,
        })
            .then(function () {
                $scope.updateList();
            });
    };

    var mdProductoDialogCtrl = function ($scope, producto, niveles, lecheparve, rubros, token) {
        console.log("ProductoDialogCtrl");
        $scope.niveles = niveles;
        $scope.lecheparve = lecheparve;
        $scope.rubros = rubros;
        $scope.token = token;
        console.log(lecheparve);

        $scope.producto = producto;
        $scope.dialogTitle = "Editar Producto";

        $scope.closeDialog = function () {
            $scope.producto = {};
            $mdDialog.hide();
        };

        $scope.saveProducto = function (producto) {
            $scope.prod = producto;
            $scope.prod.imagen = "";
            console.log($scope.prod);
            console.log(apiService.postProducto($scope.token, $scope.prod));
            $mdDialog.hide();

        };
    };

    $scope.newRubroDialog = function () {
        var newRubro = {};
        newRubro.id="";
        $scope.editRubroDialog(newRubro);
    };

    $scope.editRubroDialog = function (rubro) {
        $mdDialog.show({
            locals: { rubro: rubro, token: $scope.params.token },
            clickOutsideToClose: false,
            controllerAs: 'ctrl',
            templateUrl: 'templates/dialogs/rubro-dialog.html',
            controller: mdRubroDialogCtrl,
            fullscreen: true,
        })
        .then( function(){
            console.log("updating list");

            $scope.updateList();
        });
    };

    var mdRubroDialogCtrl = function ($scope, rubro, token) {
        console.log("RubroDialogCtrl");
        $scope.rubro = rubro;
        $scope.token = token;
        console.log(rubro);
        console.log(token);

        $scope.rubro = rubro;
        $scope.dialogTitle = "Editar Rubro";


        $scope.closeDialog = function () {
            $scope.rubro = {};
            $mdDialog.hide();
        };

        $scope.saveRubro = function (rubro) {
            $scope.rubr = rubro;
            $scope.rubr.descripcion = mysql_real_escape_string($scope.rubr.descripcion);
            console.log($scope.rubr);
            console.log(apiService.postRubro($scope.token, $scope.rubr));
            $mdDialog.hide();

        };
    };

    function mysql_real_escape_string (str) {
        return str.replace(/[\0\x08\x09\x1a\n\r"'\\\%]/g, function (char) {
            switch (char) {
                case "\0":
                    return "\\0";
                case "\x08":
                    return "\\b";
                case "\x09":
                    return "\\t";
                case "\x1a":
                    return "\\z";
                case "\n":
                    return "\\n";
                case "\r":
                    return "\\r";
                case "\"":
                case "'":
                case "\\":
                case "%":
                    return "\\"+char; // prepends a backslash to backslash, percent,
                                      // and double/single quotes
            }
        });
    }
}]);

