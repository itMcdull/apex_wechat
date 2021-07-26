module.exports =
/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, { enumerable: true, get: getter });
/******/ 		}
/******/ 	};
/******/
/******/ 	// define __esModule on exports
/******/ 	__webpack_require__.r = function(exports) {
/******/ 		if(typeof Symbol !== 'undefined' && Symbol.toStringTag) {
/******/ 			Object.defineProperty(exports, Symbol.toStringTag, { value: 'Module' });
/******/ 		}
/******/ 		Object.defineProperty(exports, '__esModule', { value: true });
/******/ 	};
/******/
/******/ 	// create a fake namespace object
/******/ 	// mode & 1: value is a module id, require it
/******/ 	// mode & 2: merge all properties of value into the ns
/******/ 	// mode & 4: return value when already ns object
/******/ 	// mode & 8|1: behave like require
/******/ 	__webpack_require__.t = function(value, mode) {
/******/ 		if(mode & 1) value = __webpack_require__(value);
/******/ 		if(mode & 8) return value;
/******/ 		if((mode & 4) && typeof value === 'object' && value && value.__esModule) return value;
/******/ 		var ns = Object.create(null);
/******/ 		__webpack_require__.r(ns);
/******/ 		Object.defineProperty(ns, 'default', { enumerable: true, value: value });
/******/ 		if(mode & 2 && typeof value != 'string') for(var key in value) __webpack_require__.d(ns, key, function(key) { return value[key]; }.bind(null, key));
/******/ 		return ns;
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */,
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

var _Element = function () {
    function _Element(hashCode, controller, tag) {
        _classCallCheck(this, _Element);

        this.hashCode = hashCode;
        this.controller = controller;
        this.tag = tag;
        this.currentStyle = {};
        this.attributes = {};
        this.nodes = [];
        this.nodesHash = [];
        global.miniDomEventHandlers = _Element.eventHandlers;
        global.devicePixelRatio = wx.getSystemInfoSync().pixelRatio;
    }

    _Element.prototype.cloneNode = function cloneNode() {
        var deep = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : false;

        var clonedElement = this.controller.document.createElement(this.tag);
        clonedElement.setStyle(this.currentStyle);
        for (var key in this.attributes) {
            clonedElement.setAttribute(key, this.attributes[key]);
        }
        if (deep) {
            this.nodes.forEach(function (it) {
                clonedElement.appendChild(it.cloneNode(true));
            });
        }
        return clonedElement;
    };

    _Element.prototype.setStyle = function setStyle(style) {
        var changed = false;
        for (var key in style) {
            if (this.currentStyle[key] !== style[key]) {
                this.currentStyle[key] = style[key];
                changed = true;
            }
        }
        if (changed) {
            var cssText = "";
            for (var _key in this.currentStyle) {
                var value = this.currentStyle[_key];
                cssText += this.toCSSKey(_key) + ":" + value + ";";
            }
            this.controller.pushCommand(this.hashCode + ".style", cssText);
        }
    };

    _Element.prototype.setAttribute = function setAttribute(name, value) {
        this.attributes[name] = value;
        this.controller.pushCommand(this.hashCode + "." + name, value);
    };

    _Element.prototype.insertBefore = function insertBefore(newChild, refChild) {
        var refIndex = refChild ? this.nodes.indexOf(refChild) : -1;
        if (refIndex >= 0) {
            if (newChild.parent) {
                newChild.parent.removeChild(newChild);
            }
            newChild.parent = this;
            this.nodes.splice(refIndex, 0, newChild);
            this.nodesHash.splice(refIndex, 0, newChild.hashCode);
            this.controller.pushCommand(this.hashCode + ".nodes", this.nodesHash);
        } else {
            this.appendChild(newChild);
        }
    };

    _Element.prototype.appendChild = function appendChild(child) {
        if (child.parent) {
            child.parent.removeChild(child);
        }
        child.parent = this;
        this.nodes.push(child);
        this.nodesHash.push(child.hashCode);
        return this.controller.pushCommand(this.hashCode + ".nodes", this.nodesHash);
    };

    _Element.prototype.removeChild = function removeChild(child) {
        var refIndex = this.nodes.indexOf(child);
        if (refIndex >= 0) {
            child.parent = undefined;
            this.nodes.splice(refIndex, 1);
            this.nodesHash.splice(refIndex, 1);
            this.controller.pushCommand(this.hashCode + ".nodes", this.nodesHash);
        }
    };

    _Element.prototype.remove = function remove() {
        if (this.parent) {
            this.parent.removeChild(this);
        }
    };

    _Element.prototype.getBoundingClientRect = function getBoundingClientRect() {
        var _this = this;

        return new Promise(function (res) {
            wx.createSelectorQuery().in(_this.controller.componentInstance.selectComponent("#renderer")).select("#d_" + _this.hashCode).boundingClientRect(function (result) {
                res(result);
            }).exec();
        });
    };

    _Element.prototype.toCSSKey = function toCSSKey(str) {
        var snakeCase = str.replace(/[A-Z]/g, function (letter) {
            return "-" + letter.toLowerCase();
        });
        if (snakeCase.startsWith("webkit")) {
            snakeCase = "-" + snakeCase;
        }
        return snakeCase;
    };

    _createClass(_Element, [{
        key: "firstChild",
        get: function get() {
            return this.nodes[0];
        }
    }, {
        key: "clientWidth",
        get: function get() {
            return wx.getSystemInfoSync().windowWidth;
        }
    }, {
        key: "clientHeight",
        get: function get() {
            return wx.getSystemInfoSync().windowHeight;
        }
    }, {
        key: "windowPaddingTop",
        get: function get() {
            return wx.getSystemInfoSync().statusBarHeight;
        }
    }, {
        key: "windowPaddingBottom",
        get: function get() {
            var _a, _b;
            return (_b = (_a = wx.getSystemInfoSync().safeArea) === null || _a === void 0 ? void 0 : _a.bottom) !== null && _b !== void 0 ? _b : 0;
        }
    }, {
        key: "devicePixelRatio",
        get: function get() {
            return wx.getSystemInfoSync().pixelRatio;
        }
    }, {
        key: "onclick",
        set: function set(value) {
            _Element.eventHandlers[this.hashCode + ".onclick"] = value;
            this.controller.pushCommand(this.hashCode + ".onclick", value ? this.hashCode : undefined);
        }
    }]);

    return _Element;
}();

_Element.eventHandlers = {};

var _Document = function () {
    function _Document(controller) {
        _classCallCheck(this, _Document);

        this.controller = controller;
        this.body = new _Element("body", this.controller, "div");
    }

    _Document.prototype.createElement = function createElement(tag) {
        var hashCode = _Document.nextElementHashCode.toString();
        _Document.nextElementHashCode++;
        this.controller.pushCommand(hashCode, { id: hashCode, tag: tag });
        return new _Element(hashCode, this.controller, tag);
    };

    return _Document;
}();

_Document.nextElementHashCode = 0;

var MiniDom = function () {
    function MiniDom() {
        _classCallCheck(this, MiniDom);

        this.document = new _Document(this);
        this.commands = [];
        this.commandPromises = [];
        this.needsSetData = false;
    }

    MiniDom.prototype.markNeedsSetData = function markNeedsSetData() {
        var _this2 = this;

        if (this.needsSetData) return;
        this.needsSetData = true;
        wx.nextTick(function () {
            var data = {};
            _this2.commands.forEach(function (command) {
                data["dom." + command.key] = command.value;
            });
            _this2.setData(data);
            _this2.commandPromises.forEach(function (it) {
                return it(null);
            });
            _this2.commands = [];
            _this2.commandPromises = [];
            _this2.needsSetData = false;
        });
    };

    MiniDom.prototype.pushCommand = function pushCommand(key, value) {
        var _this3 = this;

        this.commands.push({ key: key, value: value });
        this.markNeedsSetData();
        return new Promise(function (res) {
            _this3.commandPromises.push(res);
        });
    };

    return MiniDom;
}();

Component({
    properties: {
        style: { type: String }
    },
    data: {
        dom: { body: { id: "body", tag: "div", style: "", nodes: [] } }
    },
    lifetimes: {
        attached: function attached() {
            this.miniDom = new MiniDom();
            this.miniDom.componentInstance = this;
            this.miniDom.setData = this.setData.bind(this);
        }
    }
});

/***/ })
/******/ ]);
//# sourceMappingURL=index.js.map