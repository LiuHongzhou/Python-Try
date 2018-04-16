from config import config
from flask import Flask
from flask_bootstrap import Bootstrap
from flask_qiniustorage import Qiniu
from flask_admin import Admin
from flask_cache import Cache
import flask_restless
from flask_sqlalchemy import SQLAlchemy
from flask_jwt import JWT


bootstrap = Bootstrap()
qiniu = Qiniu()
admin = Admin()
cache = Cache()
db = SQLAlchemy()
apiManager = flask_restless.APIManager()
jwt = JWT()


def app_creat(config_name):
    from moduleLogin import authenticate, identity
    from API import creatAPI
    app = Flask(__name__, instance_relative_config=True)
    app.config.from_object(config[config_name])
    app.config.from_pyfile("localConfig.py")
    bootstrap.init_app(app)
    qiniu.init_app(app)
    admin.init_app(app)
    cache.init_app(app)
    db.__init__(app)
    apiManager.__init__(app, flask_sqlalchemy_db=db)
    jwt.__init__(app, authenticate, identity)
    creatAPI(apiManager, app.config.get("API_PREFIX"))

    return app
