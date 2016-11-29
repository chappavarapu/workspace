(function() {
  'use strict';

  angular.module('data')
    .service('MenuDataService', MenuDataService);

  MenuDataService.$inject = ['$http', 'API'];

  function MenuDataService($http, API) {
    var menuData = this;

    menuData.getAllCategories = function() {
      return $http.get(API.url + API.endpoint.categories)
        .then(function(response) {
          return response.data;
        });
    }

    menuData.getItemsForCategory = function(categoryShortName) {
      return $http.get(API.url + API.endpoint.items, { params: { category: categoryShortName } })
        .then(function(response) {
          return response.data.menu_items;
        });
    }

  }

})();
