(function() {
  'use strict';

  angular
    .module('public')
    .controller('MyInfoController', MyInfoController);

  MyInfoController.$inject = ['SessionService', 'ApiPath'];

  function MyInfoController(SessionService, ApiPath) {
    var myInfoCtrl = this;

    myInfoCtrl.basePath = ApiPath;
    myInfoCtrl.user = SessionService.getObject('userinfo', '{}');
    myInfoCtrl.notSignedUp = angular.equals({}, myInfoCtrl.user);
  }
})();
