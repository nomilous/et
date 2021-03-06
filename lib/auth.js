// Generated by CoffeeScript 1.4.0
var Connect, EtAuth, LocalStrategy, passport;

Connect = require('connect');

passport = require('passport');

LocalStrategy = require('passport-local').Strategy;

EtAuth = (function() {

  function EtAuth() {}

  EtAuth.enableAuth = function(et, opts) {
    var userModel;
    console.log('enabling auth');
    opts.auth || (opts.auth = {});
    if (!opts.auth.validate) {
      userModel = et.model.models.users;
      if (!(userModel.validate instanceof Function)) {
        console.warn("WARNING: user.validate(user, pass) undefined");
        opts.auth.validate = function(username, password) {
          return false;
        };
      } else if (userModel.validate.length < 2) {
        console.warn("WARNING: user.validate() takes insufficient arguments");
        opts.auth.validate = function(username, password) {
          return false;
        };
      } else {
        if (userModel.get instanceof Function) {
          console.warn("WARNING: user.get(id) without ROLES");
        }
        opts.auth.validate = function(username, password) {
          return userModel.validate(username, password);
        };
      }
    }
    this.validate = opts.auth.validate;
    passport.use(new LocalStrategy(function(username, password, done) {
      var user;
      if (!(user = opts.auth.validate(username, password))) {
        return done(null, false, {
          message: 'Invalid username or password.'
        });
      }
      return done(null, user);
    }));
    passport.serializeUser(function(user, done) {
      console.log('Passport serializing', user, 'to session');
      return done(null, user.id);
    });
    passport.deserializeUser(function(id, done) {
      var err;
      console.log('Passport deserialize', id, 'from session');
      err = null;
      return done(err, {
        id: id,
        user: 'still considering this'
      });
    });
    return opts.app.configure(function() {
      opts.app.use(Connect.logger('dev'));
      opts.app.use(Connect.bodyParser());
      opts.app.use(passport.initialize());
      opts.app.use(passport.session());
      return opts.app.post('/login', passport.authenticate('local'), function(req, res) {
        return res.send(req.user);
      });
    });
  };

  EtAuth.config = function(et, opts) {
    if (opts == null) {
      opts = {};
    }
    this.enabled = opts.auth !== false;
    if (this.enabled) {
      if (et.session === void 0 || !et.session.enabled) {
        console.log("auth requires session");
        this.enabled = false;
      }
      if (et.model === void 0 || !et.model.models.users) {
        if (!(opts.auth && opts.auth.validate)) {
          console.log("auth requires user model or validate() override");
          this.enabled = false;
        }
      }
      if (this.enabled && opts.app) {
        this.enableAuth(et, opts);
      }
    }
    return function(req, res, next) {
      return next();
    };
  };

  return EtAuth;

})();

module.exports = EtAuth;
