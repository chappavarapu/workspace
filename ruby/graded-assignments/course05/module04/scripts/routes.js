(function() {
  'use strict';

  angular.module('MenuApp')
    .config(RoutesConfig)

  RoutesConfig.$inject = ['$stateProvider', '$urlRouterProvider'];

  function RoutesConfig($stateProvider, $urlRouterProvider) {
    $urlRouterProvider.otherwise('/');

    $stateProvider
      .state('home', {
        url: '/',
        templateUrl: 'home/home.html'
      })
      .state('categories', {
        url: '/categories',
        templateUrl: 'categories/categories.html',
        controller: 'CategoriesController as menuCategories',
        resolve: {
          categories: ['MenuDataService', function(MenuDataService) {
            return MenuDataService.getAllCategories();
          }]
        }
      })
      .state('items', {
        url: '/items?category',
        templateUrl: 'items/items.html',
        controller: 'ItemsController as menuItems',
        resolve: {
          items: ['$stateParams', 'MenuDataService', function($stateParams, MenuDataService) {
            return MenuDataService.getItemsForCategory($stateParams.category);
          }],
          category: ['$stateParams', function($stateParams) {
            return $stateParams.category;
          }]
        }
      });
  }
})();
