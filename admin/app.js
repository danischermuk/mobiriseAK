// app.js
var routerApp = angular.module('routerApp', ['ui.router', 'ngMaterial', 'ngMessages', 'summernote']);

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

        .state('alertas', {
            url: '/alertas/:jwttoken',
            templateUrl: 'templates/alertas.html',
            controller: 'alertasCtrl'

            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                token: ['$stateParams',
                    function ($stateParams) { return $stateParams.jwttoken; }]
                ,
                alertas: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getAlertas($stateParams.jwttoken);
                }]
            }

        })

        .state('guiakosher', {
            url: '/guiakosher/:jwttoken',
            templateUrl: 'templates/guiakosher.html',
            controller: 'guiaKosherCtrl'

            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                token: ['$stateParams',
                    function ($stateParams) { return $stateParams.jwttoken; }]
                ,
                texto: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getTextoGuiaKosher($stateParams.jwttoken);
                }]
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

        .state('establecimientos', {
            url: '/establecimientos/:jwttoken',
            templateUrl: 'templates/establecimientos.html',
            controller: 'establecimientosCtrl'

            , resolve: {
                user: ['User', '$stateParams', function (User, $stateParams) {
                    return User.checkAuthentication($stateParams.jwttoken);
                }]
                ,
                establecimientos: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getEstablecimientos($stateParams.jwttoken);
                }]
                ,
                tipoEstablecimientos: ['apiService', '$stateParams', function (apiService, $stateParams) {
                    return apiService.getTipoEstablecimiento($stateParams.jwttoken);
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
    var apiUrl = "../admin/api/";


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
            descripcion: producto.descripcion,
            publicar: producto.publicar,
            sintacc: producto.sintacc,
            barcode: producto.barcode
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


    // ALERTAS
    function _getAlertas(token) {
        console.log("getting alertas with token: " + token);
        return $http({
            url: apiUrl + "alertas.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _deleteAlerta(token, id) {
        console.log("deletting producto with id: " + id);
        return $http({
            url: apiUrl + "alertas.php",
            method: "DELETE",
            params: { token: token, id: id }
        });
    }

    function _postAlerta(token, alerta) {
        console.log("posting alerta token: " + token);
        var data = {
            token: token,
            id: alerta.id,
            nombre: alerta.nombre,
            descripcion: alerta.descripcion,
            mostrar: alerta.mostrar
        };
        return $http({
            method: 'POST',
            url: apiUrl + "alertas.php",
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

    // API DE ESTABLECIMIENTOS

    function _getEstablecimientos(token) {
        console.log("getting establecimientos with token: " + token);
        return $http({
            url: apiUrl + "establecimientos.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _deleteEstablecimiento(token, id) {
        console.log("deletting establecimiento with id: " + id);
        return $http({
            url: apiUrl + "establecimientos.php",
            method: "DELETE",
            params: { token: token, id: id }
        });
    }

    function _postEstablecimiento(token, establecimiento) {
        console.log("posting establecimiento token: " + token);
        var data = {
            token: token,
            id: establecimiento.id,
            nombre: establecimiento.nombre,
            direccion: establecimiento.direccion,
            telefono: establecimiento.telefono,
            certificado: establecimiento.certificado,
            vigente: establecimiento.vigente,
            logo: establecimiento.logo,
            rubroId: establecimiento.rubroId
        };
        return $http({
            method: 'POST',
            url: apiUrl + "establecimientos.php",
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


    // API TIPO ESTABLECIMIENTOS
    function _getTipoEstablecimiento(token) {
        console.log("getting tipoestablecimientos with token: " + token);
        return $http({
            url: apiUrl + "tipoestablecimiento.php",
            method: "GET",
            params: { token: token }
        });
    }

    // TEXTOS
    function _getTextos(token) {
        console.log("getting textos with token: " + token);
        return $http({
            url: apiUrl + "textos.php",
            method: "GET",
            params: { token: token }
        });
    }

    function _getTextoGuiaKosher(token) {
        console.log("getting textos with token: " + token);
        return $http({
            url: apiUrl + "textos.php?name=guiakosher",
            method: "GET",
            params: { token: token }
        });
    }



    function _getTextoBiografiaRabOpp(token) {
        console.log("getting textos with token: " + token);
        return $http({
            url: apiUrl + "textos.php?name=biografiaRabOpp",
            method: "GET",
            params: { token: token }
        });
    }

    function _getTextoNuestraMision(token) {
        console.log("getting textos with token: " + token);
        return $http({
            url: apiUrl + "textos.php?name=nuestraMision",
            method: "GET",
            params: { token: token }
        });
    }

    function _deleteTexto(token, id) {
        console.log("deletting textos with id: " + id);
        return $http({
            url: apiUrl + "textos.php",
            method: "DELETE",
            params: { token: token, id: id }
        });
    }

    function _postTexto(token, texto) {
        console.log("posting textos token: " + token);
        var data = {
            token: token,
            id: texto.id,
            nombre: texto.nombre,
            descripcion: texto.descripcion
        };
        return $http({
            method: 'POST',
            url: apiUrl + "textos.php",
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
        getLecheparve: _getLecheparve,

        // ALERTAS
        getAlertas: _getAlertas,
        deleteAlerta: _deleteAlerta,
        postAlerta: _postAlerta,

        // ESTABLECIMIENTOS
        getEstablecimientos: _getEstablecimientos,
        deleteEstablecimiento: _deleteEstablecimiento,
        postEstablecimiento: _postEstablecimiento,

        // TIPO ESTABLECIMIENTOS
        getTipoEstablecimiento: _getTipoEstablecimiento,

        // TEXTOS
        getTextos: _getTextos,
        getTextoGuiaKosher: _getTextoGuiaKosher,
        getTextoBiografiaRabOpp: _getTextoBiografiaRabOpp,
        getTextoNuestraMision: _getTextoNuestraMision,
        postTexto: _postTexto,
        deleteTexto: _deleteTexto

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


routerApp.controller('alertasCtrl', ['$scope', '$location', '$http', '$sce', 'token', 'alertas', 'apiService', '$mdDialog', function ($scope, $location, $http, $sce, token, alertas, apiService, $mdDialog) {

    console.log("alertasCtrl");

    $scope.htmlVariable = "";
    $scope.params.token = token;
    $scope.alertas = alertas.data;
    console.log($scope.alertas);

    $scope.renderHtml = function (html_code) {
        return $sce.trustAsHtml(html_code);
    };


    $scope.newAlertaDialog = function () {
        var newAlerta = {};
        newAlerta.id = "";
        $scope.editAlertaDialog(newAlerta);
    };

    $scope.editAlertaDialog = function (alerta) {
        $mdDialog.show({
            locals: { alerta: angular.copy(alerta), token: $scope.params.token },
            clickOutsideToClose: false,
            controllerAs: 'ctrl',
            templateUrl: 'templates/dialogs/alerta-dialog.html',
            controller: mdAlertaDialogCtrl,
            fullscreen: true,
        })
            .then(function () {
                console.log("updating list");

                $scope.updateAlertas();
            });
    };


    $scope.showConfirmDeleteAlerta = function (ev, alerta) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
            .title('Seguro que quiere la Alerta "' + alerta.nombre + '" ?')
            .targetEvent(ev)
            .ok('Eliminar')
            .cancel('cancelar');
        $mdDialog.show(confirm).then(function () {
            apiService.deleteAlerta($scope.params.token, alerta.id);
            $scope.updateAlertas();
        }, function () {
            // alert("no eliinar");
        });
    };
    $scope.updateAlertas = function () {
        setTimeout(function () {
            $scope.$apply(function () {
                var response = apiService.getAlertas($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.alertas = data;
                    console.log($scope.alertas);

                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

            });
        }, 1000);
    }

    var mdAlertaDialogCtrl = function ($scope, alerta, token) {
        console.log("AlertaDialogCtrl");
        $scope.alerta = alerta;
        $scope.token = token;
        console.log(alerta);
        console.log(token);

        $scope.alerta = alerta;
        $scope.dialogTitle = "Editar Alerta";


        $scope.closeDialog = function () {
            $scope.alerta = {};
            $mdDialog.hide();
        };

        $scope.saveAlerta = function (alerta) {
            $scope.alert = alerta;
            $scope.alert.descripcion = mysql_real_escape_string($scope.alert.descripcion);
            console.log($scope.alert);
            console.log(apiService.postAlerta($scope.token, $scope.alert));
            $mdDialog.hide();

        };
    };

    function mysql_real_escape_string(str) {
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
                    return "\\" + char; // prepends a backslash to backslash, percent,
                // and double/single quotes
                case "%":
                    return char;
            }
        });
    }

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

    //-----------------------------------------------------------------------------------------------
    $scope.makeSuperLista = function (Rubros, Productos) {
        var superLista = angular.copy(Rubros);
        console.log(Rubros);
        for (var y = 0; y < superLista.length; y++) {
            superLista[y].productos = Productos.filter(function (producto) {
                return producto.rubroId == superLista[y].id;
            });
        }
        return superLista;
    }
    $scope.superLista = $scope.makeSuperLista($scope.rubros, $scope.productos);
    console.log($scope.superLista);

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

        var fullItem = item.descripcion + ' ' + item.rubro + ' ' + item.marca + ' ' + item.codigoNombre;
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

        if ($scope.rubFromProdSearch.has(item.id))
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

    $scope.foundRubro = function (rubro) {
        return $scope.rubSet.has(rubro.id);
    }

    $scope.foundProducto = function (producto) {
        return $scope.prodSet.has(producto.id);
    }

    $scope.renderHtml = function (html_code) {
        return $sce.trustAsHtml(html_code);
    };

    $scope.clickRubro = function (rubro) {
        console.log(rubro.nombre);
        $scope.query = rubro.nombre;
    };

    $scope.$watch('query', function (newValue, oldValue) {

        $scope.prodSearch = $scope.productos.filter($scope.ignoreAccentsProducto);
        $scope.rubFromProdSearch = new Set($scope.prodSearch.map(x => x.rubroId));
        $scope.prodSet = new Set($scope.prodSearch.map(x => x.id));
        $scope.rubSearch = $scope.rubros.filter($scope.ignoreAccentsRubro);
        $scope.rubSet = new Set($scope.rubSearch.map(x => x.id));
        // console.log($scope.prodSearch);
        // console.log($scope.rubSearch);
    });
    //-----------------------------------------------------------------------------------------------

    $scope.prodctoEnRubro = function (productoRubroId, rubroId) {
        return (productoRubroId == rubroId);
    };

    $scope.updateList = function () {
        setTimeout(function () {
            $scope.$apply(function () {
                var response = apiService.getRubros($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.rubros = data;
                    // console.log($scope.rubros);
                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

                var response = apiService.getProductos($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.productos = data;
                    // console.log($scope.productos);
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
                        // console.log($scope.productos);
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
            locals: { producto: angular.copy(producto), niveles: $scope.niveles, lecheparve: $scope.lecheparve, rubros: $scope.rubros, token: $scope.params.token },
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
        // console.log(lecheparve);

        $scope.producto = producto;
        $scope.dialogTitle = "Editar Producto";
        $scope.image_source = "../images/" + producto.imagen;

        $scope.uploadLogo = function () {
            if ($scope.files[0] != undefined) {
                console.log("uploading logo");
                $scope.producto.imagen = $scope.files[0];
                $http({
                    method: 'POST',
                    url: 'api/upload.php?token=' + $scope.token,
                    processData: false,
                    transformRequest: function (data) {
                        var formData = new FormData();
                        formData.append("image", $scope.producto.imagen);
                        return formData;
                    },
                    data: $scope.form,
                    headers: {
                        'Content-Type': undefined
                    }
                }).success(function (data) {
                    $scope.prod.imagen = data;
                }).error(function (data) {
                    $scope.prod.imagen = "";
                }).finally(function (data) {
                    console.log($scope.prod);
                    console.log(apiService.postProducto($scope.token, $scope.prod));
                    $mdDialog.hide();
                });
            }
            else {
                console.log($scope.prod);
                console.log(apiService.postProducto($scope.token, $scope.prod));
                $mdDialog.hide();
            }
            console.log($scope.prod);
        };

        

        $scope.form = [];
        $scope.files = [];

        $scope.uploadedFile = function (element) {
            $scope.currentFile = element.files[0];
            var reader = new FileReader();


            reader.onload = function (event) {
                $scope.image_source = event.target.result
                $scope.$apply(function ($scope) {
                    $scope.files = element.files;
                });
            }
            reader.readAsDataURL(element.files[0]);
        }

        $scope.closeDialog = function () {
            $scope.producto = {};
            $mdDialog.hide();
        };

        $scope.saveProducto = function (producto) {
            $scope.prod = producto;
            $scope.uploadLogo();
        };
    };

    $scope.newRubroDialog = function () {
        var newRubro = {};
        newRubro.id = "";
        $scope.editRubroDialog(newRubro);
    };

    $scope.editRubroDialog = function (rubro) {
        $mdDialog.show({
            locals: { rubro: angular.copy(rubro), token: $scope.params.token },
            clickOutsideToClose: false,
            controllerAs: 'ctrl',
            templateUrl: 'templates/dialogs/rubro-dialog.html',
            controller: mdRubroDialogCtrl,
            fullscreen: true,
            skipHide: true,
            multiple: true,

        })
            .then(function () {
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

    function mysql_real_escape_string(str) {
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
                    return "\\" + char; // prepends a backslash to backslash, percent,
                // and double/single quotes
                case "%":
                    return char;
            }
        });
    }
}]);


routerApp.controller('establecimientosCtrl', ['$scope', '$location', '$http', 'apiService', 'token', 'establecimientos', 'tipoEstablecimientos', '$sce', '$mdDialog', function ($scope, $location, $http, apiService, token, establecimientos, tipoEstablecimientos, $sce, $mdDialog) {
    console.log("establecimientoCtrl");
    $scope.params.token = token;
    console.log(token);
    $scope.establecimientos = establecimientos.data;
    $scope.tipoEstablecimientos = tipoEstablecimientos.data;

    console.log($scope.establecimientos);
    console.log($scope.tipoEstablecimientos);

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

    $scope.ignoreAccentsEstablecimiento = function (item) {
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


    $scope.updateList = function () {
        setTimeout(function () {
            $scope.$apply(function () {
                var response = apiService.getEstablecimientos($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.establecimientos = data;
                    console.log($scope.establecimientos);
                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

                var response = apiService.getTipoEstablecimiento($scope.params.token);
                response.success(function (data, status, headers, config) {
                    $scope.tipoEstablecimientos = data;
                    console.log($scope.tipoEstablecimientos);
                });
                response.error(function (data, status, headers, config) {
                    alert("ERROR");
                });

            });
        }, 1000);
    }


    $scope.showConfirmDeleteEstablecimiento = function (ev, establecimiento) {
        // Appending dialog to document.body to cover sidenav in docs app
        var confirm = $mdDialog.confirm()
            .title('Seguro que quiere eliminar el establecimiento "' + establecimiento.nombre + '" ?')
            .ariaLabel('Lucky day')
            .targetEvent(ev)
            .ok('Eliminar')
            .cancel('cancelar');
        $mdDialog.show(confirm).then(function () {
            apiService.deleteEstablecimiento($scope.params.token, establecimiento.id);
            setTimeout(function () {
                $scope.$apply(function () {
                    $scope.updateList();
                });
            }, 500);
        }, function () {
            // alert("no eliinar");
        });
    };


    $scope.newEstablecimientoDialog = function (rubro) {
        var newEstablecimiento = {};
        newEstablecimiento.telefono = "";
        newEstablecimiento.logo = "";
        newEstablecimiento.certificado = "";
        $scope.editEstablecimientoDialog(newEstablecimiento);
    };

    $scope.editEstablecimientoDialog = function (establecimiento) {
        $mdDialog.show({
            locals: { establecimiento: angular.copy(establecimiento), tipoEstablecimientos: $scope.tipoEstablecimientos, token: $scope.params.token },
            clickOutsideToClose: false,
            controllerAs: 'ctrl',
            templateUrl: 'templates/dialogs/establecimiento-dialog.html',
            controller: mdEstablecimientoDialogCtrl,
            fullscreen: true,
        })
            .then(function () {
                $scope.updateList();
            });
    };

    var mdEstablecimientoDialogCtrl = function ($scope, establecimiento, tipoEstablecimientos, token) {
        console.log("EstablecimientoDialogCtrl");
        $scope.establecimiento = establecimiento;
        $scope.tipoEstablecimientos = tipoEstablecimientos;
        $scope.token = token;
        console.log($scope.establecimiento);
        console.log($scope.tipoEstablecimientos);
        $scope.dialogTitle = "Editar Establecimiento";
        $scope.image_source = "../images/" + establecimiento.logo;


        $scope.closeDialog = function () {
            $scope.establecimiento = {};
            $mdDialog.hide();
        };

        $scope.uploadCertificado = function () {
            console.log("uploading certificado");
            var fd = new FormData();
            var files = document.getElementById('file').files[0];
            fd.append('file', files);
            // AJAX request
            $http({
                method: 'post',
                url: 'api/upload.php?token=' + $scope.token,
                data: fd,
                headers: { 'Content-Type': undefined },
            }).success(function (data) {
                // Store response data
                $scope.est.certificado = data;

            }).error(function (data) {
                $scope.est.certificado = "";
            }).finally(function () {
                $scope.uploadLogo();
            });
        };


        $scope.uploadLogo = function () {
            if ($scope.files[0] != undefined) {
                console.log("uploading logo");
                $scope.establecimiento.logo = $scope.files[0];
                $http({
                    method: 'POST',
                    url: 'api/upload.php?token=' + $scope.token,
                    processData: false,
                    transformRequest: function (data) {
                        var formData = new FormData();
                        formData.append("image", $scope.establecimiento.logo);
                        return formData;
                    },
                    data: $scope.form,
                    headers: {
                        'Content-Type': undefined
                    }
                }).success(function (data) {
                    $scope.est.logo = data;
                }).error(function (data) {
                    $scope.est.logo = "";
                }).finally(function (data) {
                    console.log($scope.est);
                    console.log(apiService.postEstablecimiento($scope.token, $scope.est));
                    $mdDialog.hide();
                });
            }
            else {
                console.log($scope.est);
                console.log(apiService.postEstablecimiento($scope.token, $scope.est));
                $mdDialog.hide();
            }
        };

        $scope.saveEstablecimiento = function (establecimiento) {
            $scope.est = establecimiento;
            if (document.getElementById('file').files[0] != undefined) {
                $scope.uploadCertificado();
            }
            else {
                $scope.uploadLogo();
            }
        };

        $scope.form = [];
        $scope.files = [];





        $scope.uploadedFile = function (element) {
            $scope.currentFile = element.files[0];
            var reader = new FileReader();


            reader.onload = function (event) {
                $scope.image_source = event.target.result
                $scope.$apply(function ($scope) {
                    $scope.files = element.files;
                });
            }
            reader.readAsDataURL(element.files[0]);
        }
    };

}]);

routerApp.controller('guiaKosherCtrl', ['$scope', '$location', '$http', '$sce', 'token', 'texto', 'apiService', function ($scope, $location, $http, $sce, token, texto, apiService) {

    console.log("guiaKosherCtrl");

    $scope.params.token = token;
    $scope.texto = texto.data[0];
    console.log($scope.token);
    console.log($scope.texto);





    $scope.saveGuiaKosher = function (texto) {
        $scope.text = texto;
        $scope.text.descripcion = mysql_real_escape_string($scope.text.descripcion);
        console.log($scope.text);
        apiService.postTexto($scope.params.token, $scope.text).then(function () {
            window.location.reload();
        });
    };


    function mysql_real_escape_string(str) {
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
                    return "\\" + char; // prepends a backslash to backslash, percent,
                // and double/single quotes
                case "%":
                    return char;
            }
        });
    }
}]);
