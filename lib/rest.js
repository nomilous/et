// Generated by CoffeeScript 1.4.0
var Ebb;

if (!Ebb) {
  Ebb = {};
}

Ebb.Rest = (function() {

  function Rest() {}

  Rest.loadModel = function(plural, defn) {
    this.models[plural] = defn;
    if (defn.get instanceof Function) {
      if (defn.get.length === 1) {
        return this.routes.get[plural] = {
          route: "/" + plural + "/:id",
          callback: defn.get
        };
      } else {
        return console.error("model for " + plural + " defines get() without id");
      }
    } else {
      return console.warn("model for " + plural + " defines no get()");
    }
  };

  Rest.loadModels = function(models) {
    var defn, plural, _results;
    _results = [];
    for (plural in models) {
      defn = models[plural];
      _results.push(this.loadModel(plural, defn));
    }
    return _results;
  };

  Rest.declareRoutes = function(app) {
    var route, _results,
      _this = this;
    _results = [];
    for (route in this.routes.get) {
      console.log("assigning route GET " + this.routes.get[route].route);
      _results.push(app.get(this.routes.get[route].route, function(req, res) {
        return res.send(_this.routes.get[route].callback(req.params.id));
      }));
    }
    return _results;
  };

  Rest.config = function(opts) {
    var _base;
    if (opts == null) {
      opts = {};
    }
    this.models || (this.models = {});
    this.routes || (this.routes = {});
    (_base = this.routes).get || (_base.get = {});
    if (opts.models) {
      this.loadModels(opts.models);
    }
    if (opts.app) {
      this.declareRoutes(opts.app);
    }
    return function(req, res, next) {
      return next();
    };
  };

  return Rest;

})();

module.exports = Ebb.Rest;