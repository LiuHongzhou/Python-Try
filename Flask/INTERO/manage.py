# -*- coding:utf-8 -*-
from app.AppInit import app_creat


App = app_creat("Development")


@App.route("/")
def helloworld():
    return "Hello world!"


@App.route("/user/<string:tag>")
def hello(tag):
    if tag is None:
        return "Hello world!"
    else:
        return "Hello " + tag


@App.route("/lhz")
def hello_lhz():
    return "Hello, Liu Honghzou..."


if __name__ == "__main__":
    App.run()
