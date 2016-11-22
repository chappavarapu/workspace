(function() {
  'use strict';

  angular.module('LunchCheck', [])
  .controller('LunchCheckController', LunchCheckController);

  LunchCheckController.$inject = ['$scope'];

  function LunchCheckController($scope) {
    $scope.items = '';
    $scope.message = '';

    $scope.checkItems = function(items) {
      var items = items.trim();

      if(items) {
        var arrayOfItems = itemsToArray(items);
        $scope.message = getMessage(arrayOfItems.length);
      }
      else {
        $scope.message = 'Please enter data first';
      }
    }
  }

  function getMessage(numItems) {
    if(numItems > 3) {
      return 'Too much!';
    }
    else {
      return 'Enjoy!';
    }
  }

  function itemsToArray(items) {
    return items.split(',');
  }

})();
