(function() {
  'use strict';

  angular.module('ShoppingListCheckOff', [])
    .controller('ToBuyController', ToBuyController)
    .controller('AlreadyBoughtController', AlreadyBoughtController)
    .service('ShoppingListCheckOffService', ShoppingListCheckOffService);

  ToBuyController.$inject = ['ShoppingListCheckOffService'];
  AlreadyBoughtController.$inject = ['ShoppingListCheckOffService'];

  function ToBuyController(ShoppingListCheckOffService) {
    var tobuy = this;

    tobuy.items = ShoppingListCheckOffService.getToBuyItems();
    //console.log(tobuy.items);
    tobuy.buyItem = function (itemIndex) {
      ShoppingListCheckOffService.buyItem(itemIndex);
    };
  }

  function AlreadyBoughtController(ShoppingListCheckOffService) {
    var bought = this;

    bought.items = ShoppingListCheckOffService.getBoughtItems();
  }

  function ShoppingListCheckOffService() {
    var service = this;

    var toBuyItems = [
      {
        name: 'Cookies',
        quantity: 15
      },
      {
        name: 'Sodas',
        quantity: 10
      },
      {
        name: 'Chips',
        quantity: 5
      },
      {
        name: 'Candy bars',
        quantity: 15
      },
      {
        name: 'Drinks',
        quantity: 7
      },
      {
        name: 'Milk',
        quantity: 10
      }
    ];

    var boughtItems = [];

    service.buyItem = function (itemIndex) {
      var item = toBuyItems.splice(itemIndex, 1)[0];
      boughtItems.push(item);
    };

    service.getToBuyItems = function () {
      //console.log(toBuyItems);
      return toBuyItems;
    };

    service.getBoughtItems = function functionName() {
      return boughtItems;
    };
  }
})();
