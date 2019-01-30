/*!
 * Cropper v0.7.6-beta
 * https://github.com/fengyuanchen/cropper
 *
 * Copyright 2014 Fengyuan Chen
 * Released under the MIT license
 */

!(function(a) {
  "function" == typeof define && define.amd
    ? define(["jquery"], a)
    : a("object" == typeof exports ? require("jquery") : jQuery);
})(function(a) {
  "use strict";
  var b = a(window),
    c = a(document),
    d = window.location,
    e = !0,
    f = !1,
    g = null,
    h = 0 / 0,
    i = 1 / 0,
    j = "undefined",
    k = "directive",
    l = ".cropper",
    m = /^(e|n|w|s|ne|nw|sw|se|all|crop|move|zoom)$/,
    n = /^(x|y|width|height)$/,
    o = /^(naturalWidth|naturalHeight|width|height|aspectRatio|ratio|rotate)$/,
    p = "cropper-modal",
    q = "cropper-hidden",
    r = "cropper-invisible",
    s = "cropper-move",
    t = "cropper-crop",
    u = "cropper-disabled",
    v = "mousedown touchstart",
    w = "mousemove touchmove",
    x = "mouseup mouseleave touchend touchleave touchcancel",
    y = "wheel mousewheel DOMMouseScroll",
    z = "resize" + l,
    A = "dblclick",
    B = "build" + l,
    C = "built" + l,
    D = "dragstart" + l,
    E = "dragmove" + l,
    F = "dragend" + l,
    G = function(a) {
      return "number" == typeof a;
    },
    H = function(b, c) {
      (this.element = b),
        (this.$element = a(b)),
        (this.defaults = a.extend({}, H.DEFAULTS, a.isPlainObject(c) ? c : {})),
        (this.$original = g),
        (this.ready = f),
        (this.built = f),
        (this.cropped = f),
        (this.rotated = f),
        (this.disabled = f),
        (this.replaced = f),
        this.init();
    },
    I = Math.round,
    J = Math.sqrt,
    K = Math.min,
    L = Math.max,
    M = Math.abs,
    N = Math.sin,
    O = Math.cos,
    P = parseFloat;
  (H.prototype = {
    constructor: H,
    support: { canvas: a.isFunction(a("<canvas>")[0].getContext) },
    init: function() {
      var b = this.defaults;
      a.each(b, function(a, c) {
        switch (a) {
          case "aspectRatio":
            b[a] = M(P(c)) || h;
            break;
          case "autoCropArea":
            b[a] = M(P(c)) || 0.8;
            break;
          case "minWidth":
          case "minHeight":
            b[a] = M(P(c)) || 0;
            break;
          case "maxWidth":
          case "maxHeight":
            b[a] = M(P(c)) || i;
        }
      }),
        (this.image = { rotate: 0 }),
        this.load();
    },
    load: function() {
      var b,
        c,
        d = this,
        f = this.$element,
        g = this.element,
        h = this.image,
        i = "";
      f.is("img")
        ? (c = f.prop("src"))
        : f.is("canvas") && this.support.canvas && (c = g.toDataURL()),
        c &&
          (this.replaced && (h.rotate = 0),
          this.defaults.checkImageOrigin &&
            (f.prop("crossOrigin") || this.isCrossOriginURL(c)) &&
            (i = " crossOrigin"),
          (this.$clone = b = a("<img" + i + ' src="' + c + '">')),
          b.one("load", function() {
            (h.naturalWidth = this.naturalWidth || b.width()),
              (h.naturalHeight = this.naturalHeight || b.height()),
              (h.aspectRatio = h.naturalWidth / h.naturalHeight),
              (d.url = c),
              (d.ready = e),
              d.build();
          }),
          b.addClass(r).prependTo("body"));
    },
    isCrossOriginURL: function(a) {
      var b = a.match(/^(https?:)\/\/([^\:\/\?#]+):?(\d*)/i);
      return !b ||
        (b[1] === d.protocol && b[2] === d.hostname && b[3] === d.port)
        ? f
        : e;
    },
    build: function() {
      var b,
        d,
        f = this.$element,
        g = this.defaults;
      this.ready &&
        (this.built && this.unbuild(),
        f.one(B, g.build),
        (b = a.Event(B)),
        f.trigger(b),
        b.isDefaultPrevented() ||
          ((this.$cropper = d = a(H.TEMPLATE)),
          f.addClass(q),
          this.$clone.removeClass(r).prependTo(d),
          this.rotated ||
            ((this.$original = this.$clone.clone()),
            this.$original.addClass(q).prependTo(this.$cropper),
            (this.originalImage = a.extend({}, this.image))),
          (this.$container = f.parent()),
          this.$container.append(d),
          (this.$canvas = d.find(".cropper-canvas")),
          (this.$dragger = d.find(".cropper-dragger")),
          (this.$viewer = d.find(".cropper-viewer")),
          g.autoCrop ? (this.cropped = e) : this.$dragger.addClass(q),
          g.dragCrop && this.setDragMode("crop"),
          g.modal && this.$canvas.addClass(p),
          !g.dashed && this.$dragger.find(".cropper-dashed").addClass(q),
          !g.movable && this.$dragger.find(".cropper-face").data(k, "move"),
          !g.resizable &&
            this.$dragger.find(".cropper-line, .cropper-point").addClass(q),
          (this.$scope = g.multiple ? this.$cropper : c),
          this.addListeners(),
          this.initPreview(),
          (this.built = e),
          this.update(),
          f.one(C, g.built),
          f.trigger(C)));
    },
    unbuild: function() {
      this.built &&
        ((this.built = f),
        this.removeListeners(),
        this.$preview.empty(),
        (this.$preview = g),
        (this.$dragger = g),
        (this.$canvas = g),
        (this.$container = g),
        this.$cropper.remove(),
        (this.$cropper = g));
    },
    update: function(a) {
      this.initContainer(),
        this.initCropper(),
        this.initImage(),
        this.initDragger(),
        a
          ? (this.setData(a, e), this.setDragMode("crop"))
          : this.setData(this.defaults.data);
    },
    resize: function() {
      clearTimeout(this.resizing),
        (this.resizing = setTimeout(
          a.proxy(this.update, this, this.getData()),
          200
        ));
    },
    preview: function() {
      var b = this.image,
        c = this.dragger,
        d = b.width,
        e = b.height,
        f = c.left - b.left,
        g = c.top - b.top;
      this.$viewer
        .find("img")
        .css({
          width: I(d),
          height: I(e),
          marginLeft: -I(f),
          marginTop: -I(g)
        }),
        this.$preview.each(function() {
          var b = a(this),
            h = b.width() / c.width;
          b.find("img").css({
            width: I(d * h),
            height: I(e * h),
            marginLeft: -I(f * h),
            marginTop: -I(g * h)
          });
        });
    },
    addListeners: function() {
      var c = this.defaults;
      this.$element
        .on(D, c.dragstart)
        .on(E, c.dragmove)
        .on(F, c.dragend),
        this.$cropper
          .on(v, (this._dragstart = a.proxy(this.dragstart, this)))
          .on(A, (this._dblclick = a.proxy(this.dblclick, this))),
        c.zoomable &&
          this.$cropper.on(y, (this._wheel = a.proxy(this.wheel, this))),
        this.$scope
          .on(w, (this._dragmove = a.proxy(this.dragmove, this)))
          .on(x, (this._dragend = a.proxy(this.dragend, this))),
        b.on(z, (this._resize = a.proxy(this.resize, this)));
    },
    removeListeners: function() {
      var a = this.defaults;
      this.$element
        .off(D, a.dragstart)
        .off(E, a.dragmove)
        .off(F, a.dragend),
        this.$cropper.off(v, this._dragstart).off(A, this._dblclick),
        a.zoomable && this.$cropper.off(y, this._wheel),
        this.$scope.off(w, this._dragmove).off(x, this._dragend),
        b.off(z, this._resize);
    },
    initPreview: function() {
      var b = '<img src="' + this.url + '">';
      (this.$preview = a(this.defaults.preview)),
        this.$viewer.html(b),
        this.$preview
          .html(b)
          .find("img")
          .css(
            "cssText",
            "min-width:0!important;min-height:0!important;max-width:none!important;max-height:none!important;"
          );
    },
    initContainer: function() {
      var a = this.$container;
      this.container = { width: L(a.width(), 300), height: L(a.height(), 150) };
    },
    initCropper: function() {
      var a,
        b = this.container,
        c = this.image;
      (c.naturalWidth * b.height) / c.naturalHeight - b.width >= 0
        ? ((a = { width: b.width, height: b.width / c.aspectRatio, left: 0 }),
          (a.top = (b.height - a.height) / 2))
        : ((a = { width: b.height * c.aspectRatio, height: b.height, top: 0 }),
          (a.left = (b.width - a.width) / 2)),
        this.$cropper.css({
          width: I(a.width),
          height: I(a.height),
          left: I(a.left),
          top: I(a.top)
        }),
        (this.cropper = a);
    },
    initImage: function() {
      var b = this.image,
        c = this.cropper,
        d = {
          _width: c.width,
          _height: c.height,
          width: c.width,
          height: c.height,
          left: 0,
          top: 0,
          ratio: c.width / b.naturalWidth
        };
      (this.defaultImage = a.extend({}, b, d)),
        b._width !== c.width || b._height !== c.height
          ? a.extend(b, d)
          : ((b = a.extend({}, d, b)),
            this.replaced && ((this.replaced = f), (b.ratio = d.ratio))),
        (this.image = b),
        this.renderImage();
    },
    renderImage: function(a) {
      var b = this.image;
      "zoom" === a &&
        ((b.left -= (b.width - b.oldWidth) / 2),
        (b.top -= (b.height - b.oldHeight) / 2)),
        (b.left = K(L(b.left, b._width - b.width), 0)),
        (b.top = K(L(b.top, b._height - b.height), 0)),
        this.$clone.css({
          width: I(b.width),
          height: I(b.height),
          marginLeft: I(b.left),
          marginTop: I(b.top)
        }),
        a && (this.defaults.done(this.getData()), this.preview());
    },
    initDragger: function() {
      var b,
        c = this.defaults,
        d = this.cropper,
        e = c.aspectRatio || this.image.aspectRatio,
        f = this.image.ratio;
      (b =
        d.height * e - d.width >= 0
          ? {
              height: d.width / e,
              width: d.width,
              left: 0,
              top: (d.height - d.width / e) / 2,
              maxWidth: d.width,
              maxHeight: d.width / e
            }
          : {
              height: d.height,
              width: d.height * e,
              left: (d.width - d.height * e) / 2,
              top: 0,
              maxWidth: d.height * e,
              maxHeight: d.height
            }),
        (b.minWidth = 0),
        (b.minHeight = 0),
        c.aspectRatio
          ? (isFinite(c.maxWidth)
              ? ((b.maxWidth = K(b.maxWidth, c.maxWidth * f)),
                (b.maxHeight = b.maxWidth / e))
              : isFinite(c.maxHeight) &&
                ((b.maxHeight = K(b.maxHeight, c.maxHeight * f)),
                (b.maxWidth = b.maxHeight * e)),
            c.minWidth > 0
              ? ((b.minWidth = L(0, c.minWidth * f)),
                (b.minHeight = b.minWidth / e))
              : c.minHeight > 0 &&
                ((b.minHeight = L(0, c.minHeight * f)),
                (b.minWidth = b.minHeight * e)))
          : ((b.maxWidth = K(b.maxWidth, c.maxWidth * f)),
            (b.maxHeight = K(b.maxHeight, c.maxHeight * f)),
            (b.minWidth = L(0, c.minWidth * f)),
            (b.minHeight = L(0, c.minHeight * f))),
        (b.minWidth = K(b.maxWidth, b.minWidth)),
        (b.minHeight = K(b.maxHeight, b.minHeight)),
        (b.height *= c.autoCropArea),
        (b.width *= c.autoCropArea),
        (b.left = (d.width - b.width) / 2),
        (b.top = (d.height - b.height) / 2),
        (b.oldLeft = b.left),
        (b.oldTop = b.top),
        (this.defaultDragger = b),
        (this.dragger = a.extend({}, b));
    },
    renderDragger: function() {
      var a = this.dragger,
        b = this.cropper;
      a.width > a.maxWidth
        ? ((a.width = a.maxWidth), (a.left = a.oldLeft))
        : a.width < a.minWidth &&
          ((a.width = a.minWidth), (a.left = a.oldLeft)),
        a.height > a.maxHeight
          ? ((a.height = a.maxHeight), (a.top = a.oldTop))
          : a.height < a.minHeight &&
            ((a.height = a.minHeight), (a.top = a.oldTop)),
        (a.left = K(L(a.left, 0), b.width - a.width)),
        (a.top = K(L(a.top, 0), b.height - a.height)),
        (a.oldLeft = a.left),
        (a.oldTop = a.top),
        (this.dragger = a),
        this.disabled || this.defaults.done(this.getData()),
        this.$dragger.css({
          width: I(a.width),
          height: I(a.height),
          left: I(a.left),
          top: I(a.top)
        }),
        this.preview();
    },
    reset: function(b) {
      this.cropped &&
        (b && (this.defaults.data = {}),
        (this.image = a.extend({}, this.defaultImage)),
        this.renderImage(),
        (this.dragger = a.extend({}, this.defaultDragger)),
        this.setData(this.defaults.data));
    },
    clear: function() {
      this.cropped &&
        ((this.cropped = f),
        this.setData({ x: 0, y: 0, width: 0, height: 0 }),
        this.$canvas.removeClass(p),
        this.$dragger.addClass(q));
    },
    destroy: function() {
      var a = this.$element;
      this.ready &&
        (this.unbuild(),
        a.removeClass(q).removeData("cropper"),
        this.rotated && a.attr("src", this.$original.attr("src")));
    },
    replace: function(b, c) {
      var d,
        g = this,
        h = this.$element,
        i = this.element;
      b &&
        b !== this.url &&
        b !== h.attr("src") &&
        (c || ((this.rotated = f), (this.replaced = e)),
        h.is("img")
          ? (h.attr("src", b), this.load())
          : h.is("canvas") &&
            this.support.canvas &&
            ((d = i.getContext("2d")),
            a('<img src="' + b + '">').one("load", function() {
              (i.width = this.width),
                (i.height = this.height),
                d.clearRect(0, 0, i.width, i.height),
                d.drawImage(this, 0, 0),
                g.load();
            })));
    },
    setData: function(b, c) {
      var d = this.cropper,
        e = this.dragger,
        f = this.image,
        h = this.defaults.aspectRatio;
      this.built &&
        typeof b !== j &&
        ((b === g || a.isEmptyObject(b)) &&
          (e = a.extend({}, this.defaultDragger)),
        a.isPlainObject(b) &&
          !a.isEmptyObject(b) &&
          (c || (this.defaults.data = b),
          (b = this.transformData(b)),
          G(b.x) && b.x <= d.width - f.left && (e.left = b.x + f.left),
          G(b.y) && b.y <= d.height - f.top && (e.top = b.y + f.top),
          h
            ? G(b.width) && b.width <= e.maxWidth && b.width >= e.minWidth
              ? ((e.width = b.width), (e.height = e.width / h))
              : G(b.height) &&
                b.height <= e.maxHeight &&
                b.height >= e.minHeight &&
                ((e.height = b.height), (e.width = e.height * h))
            : (G(b.width) &&
                b.width <= e.maxWidth &&
                b.width >= e.minWidth &&
                (e.width = b.width),
              G(b.height) &&
                b.height <= e.maxHeight &&
                b.height >= e.minHeight &&
                (e.height = b.height))),
        (this.dragger = e),
        this.renderDragger());
    },
    getData: function(a) {
      var b = this.dragger,
        c = this.image,
        d = {};
      return (
        this.built &&
          ((d = {
            x: b.left - c.left,
            y: b.top - c.top,
            width: b.width,
            height: b.height
          }),
          (d = this.transformData(d, e, a))),
        d
      );
    },
    transformData: function(b, c, d) {
      var e = this.image.ratio,
        f = {};
      return (
        a.each(b, function(a, b) {
          (b = P(b)),
            n.test(a) &&
              !isNaN(b) &&
              (f[a] = c ? (d ? I(b / e) : b / e) : b * e);
        }),
        f
      );
    },
    setAspectRatio: function(a) {
      var b = "auto" === a;
      (a = P(a)),
        (b || (!isNaN(a) && a > 0)) &&
          ((this.defaults.aspectRatio = b ? h : a),
          this.built && (this.initDragger(), this.renderDragger()));
    },
    getImageData: function() {
      var b = {};
      return (
        this.ready &&
          a.each(this.image, function(a, c) {
            o.test(a) && (b[a] = c);
          }),
        b
      );
    },
    getDataURL: function(b, c, d) {
      var e,
        f = a("<canvas>")[0],
        g = this.getData(),
        h = "";
      return (
        a.isPlainObject(b) || ((d = c), (c = b), (b = {})),
        (b = a.extend({ width: g.width, height: g.height }, b)),
        this.cropped &&
          this.support.canvas &&
          ((f.width = b.width),
          (f.height = b.height),
          (e = f.getContext("2d")),
          "image/jpeg" === c &&
            ((e.fillStyle = "#fff"), e.fillRect(0, 0, b.width, b.height)),
          e.drawImage(
            this.$clone[0],
            g.x,
            g.y,
            g.width,
            g.height,
            0,
            0,
            b.width,
            b.height
          ),
          (h = f.toDataURL(c, d))),
        h
      );
    },
    setDragMode: function(a) {
      var b = this.$canvas,
        c = this.defaults,
        d = f,
        g = f;
      if (this.built && !this.disabled) {
        switch (a) {
          case "crop":
            c.dragCrop && ((d = e), b.data(k, a));
            break;
          case "move":
            (g = e), b.data(k, a);
            break;
          default:
            b.removeData(k);
        }
        b.toggleClass(t, d).toggleClass(s, g);
      }
    },
    enable: function() {
      this.built && ((this.disabled = f), this.$cropper.removeClass(u));
    },
    disable: function() {
      this.built && ((this.disabled = e), this.$cropper.addClass(u));
    },
    rotate: function(a) {
      var b = this.image;
      (a = P(a) || 0),
        this.built &&
          0 !== a &&
          !this.disabled &&
          this.defaults.rotatable &&
          this.support.canvas &&
          ((this.rotated = e),
          (a = b.rotate = (b.rotate + a) % 360),
          this.replace(this.getRotatedDataURL(a), !0));
    },
    getRotatedDataURL: function(b) {
      var c = a("<canvas>")[0],
        d = c.getContext("2d"),
        e = (b * Math.PI) / 180,
        f = M(b) % 180,
        g = f > 90 ? 180 - f : f,
        h = (g * Math.PI) / 180,
        i = this.originalImage,
        j = i.naturalWidth,
        k = i.naturalHeight,
        l = M(j * O(h) + k * N(h)),
        m = M(j * N(h) + k * O(h));
      return (
        (c.width = l),
        (c.height = m),
        d.save(),
        d.translate(l / 2, m / 2),
        d.rotate(e),
        d.drawImage(this.$original[0], -j / 2, -k / 2, j, k),
        d.restore(),
        c.toDataURL()
      );
    },
    zoom: function(a) {
      var b,
        c,
        d,
        e = this.image;
      (a = P(a)),
        this.built &&
          a &&
          !this.disabled &&
          this.defaults.zoomable &&
          ((b = e.width * (1 + a)),
          (c = e.height * (1 + a)),
          (d = b / e._width),
          d > 10 ||
            (1 > d && ((b = e._width), (c = e._height)),
            this.setDragMode(1 >= d ? "crop" : "move"),
            (e.oldWidth = e.width),
            (e.oldHeight = e.height),
            (e.width = b),
            (e.height = c),
            (e.ratio = e.width / e.naturalWidth),
            this.renderImage("zoom")));
    },
    dblclick: function() {
      this.disabled ||
        this.setDragMode(this.$canvas.hasClass(t) ? "move" : "crop");
    },
    wheel: function(a) {
      var b,
        c = a.originalEvent,
        d = 117.25,
        e = 5,
        f = 166.66665649414062,
        g = 0.1;
      this.disabled ||
        (a.preventDefault(),
        c.deltaY
          ? ((b = c.deltaY),
            (b = b % e === 0 ? b / e : b % d === 0 ? b / d : b / f))
          : (b = c.wheelDelta
              ? -c.wheelDelta / 120
              : c.detail
              ? c.detail / 3
              : 0),
        this.zoom(b * g));
    },
    dragstart: function(b) {
      var c,
        d,
        g,
        h = b.originalEvent.touches,
        i = b;
      if (!this.disabled) {
        if (h) {
          if (((g = h.length), g > 1)) {
            if (!this.defaults.zoomable || 2 !== g) return;
            (i = h[1]),
              (this.startX2 = i.pageX),
              (this.startY2 = i.pageY),
              (c = "zoom");
          }
          i = h[0];
        }
        if (((c = c || a(i.target).data(k)), m.test(c))) {
          if (
            (b.preventDefault(),
            (d = a.Event(D)),
            this.$element.trigger(d),
            d.isDefaultPrevented())
          )
            return;
          (this.directive = c),
            (this.cropping = f),
            (this.startX = i.pageX),
            (this.startY = i.pageY),
            "crop" === c && ((this.cropping = e), this.$canvas.addClass(p));
        }
      }
    },
    dragmove: function(b) {
      var c,
        d,
        e = b.originalEvent.touches,
        f = b;
      if (!this.disabled) {
        if (e) {
          if (((d = e.length), d > 1)) {
            if (!this.defaults.zoomable || 2 !== d) return;
            (f = e[1]), (this.endX2 = f.pageX), (this.endY2 = f.pageY);
          }
          f = e[0];
        }
        if (this.directive) {
          if (
            (b.preventDefault(),
            (c = a.Event(E)),
            this.$element.trigger(c),
            c.isDefaultPrevented())
          )
            return;
          (this.endX = f.pageX), (this.endY = f.pageY), this.dragging();
        }
      }
    },
    dragend: function(b) {
      var c;
      if (!this.disabled && this.directive) {
        if (
          (b.preventDefault(),
          (c = a.Event(F)),
          this.$element.trigger(c),
          c.isDefaultPrevented())
        )
          return;
        this.cropping &&
          ((this.cropping = f),
          this.$canvas.toggleClass(p, this.cropped && this.defaults.modal)),
          (this.directive = "");
      }
    },
    dragging: function() {
      var a,
        b = this.directive,
        c = this.image,
        d = this.cropper,
        g = d.width,
        h = d.height,
        i = this.dragger,
        j = i.width,
        k = i.height,
        l = i.left,
        m = i.top,
        n = l + j,
        o = m + k,
        p = e,
        r = this.defaults,
        s = r.aspectRatio,
        t = { x: this.endX - this.startX, y: this.endY - this.startY };
      switch ((s && ((t.X = t.y * s), (t.Y = t.x / s)), b)) {
        case "all":
          (l += t.x), (m += t.y);
          break;
        case "e":
          if (t.x >= 0 && (n >= g || (s && (0 >= m || o >= h)))) {
            p = f;
            break;
          }
          (j += t.x),
            s && ((k = j / s), (m -= t.Y / 2)),
            0 > j && ((b = "w"), (j = 0));
          break;
        case "n":
          if (t.y <= 0 && (0 >= m || (s && (0 >= l || n >= g)))) {
            p = f;
            break;
          }
          (k -= t.y),
            (m += t.y),
            s && ((j = k * s), (l += t.X / 2)),
            0 > k && ((b = "s"), (k = 0));
          break;
        case "w":
          if (t.x <= 0 && (0 >= l || (s && (0 >= m || o >= h)))) {
            p = f;
            break;
          }
          (j -= t.x),
            (l += t.x),
            s && ((k = j / s), (m += t.Y / 2)),
            0 > j && ((b = "e"), (j = 0));
          break;
        case "s":
          if (t.y >= 0 && (o >= h || (s && (0 >= l || n >= g)))) {
            p = f;
            break;
          }
          (k += t.y),
            s && ((j = k * s), (l -= t.X / 2)),
            0 > k && ((b = "n"), (k = 0));
          break;
        case "ne":
          if (s) {
            if (t.y <= 0 && (0 >= m || n >= g)) {
              p = f;
              break;
            }
            (k -= t.y), (m += t.y), (j = k * s);
          } else
            t.x >= 0
              ? g > n
                ? (j += t.x)
                : t.y <= 0 && 0 >= m && (p = f)
              : (j += t.x),
              t.y <= 0
                ? m > 0 && ((k -= t.y), (m += t.y))
                : ((k -= t.y), (m += t.y));
          0 > k && ((b = "sw"), (k = 0), (j = 0));
          break;
        case "nw":
          if (s) {
            if (t.y <= 0 && (0 >= m || 0 >= l)) {
              p = f;
              break;
            }
            (k -= t.y), (m += t.y), (j = k * s), (l += t.X);
          } else
            t.x <= 0
              ? l > 0
                ? ((j -= t.x), (l += t.x))
                : t.y <= 0 && 0 >= m && (p = f)
              : ((j -= t.x), (l += t.x)),
              t.y <= 0
                ? m > 0 && ((k -= t.y), (m += t.y))
                : ((k -= t.y), (m += t.y));
          0 > k && ((b = "se"), (k = 0), (j = 0));
          break;
        case "sw":
          if (s) {
            if (t.x <= 0 && (0 >= l || o >= h)) {
              p = f;
              break;
            }
            (j -= t.x), (l += t.x), (k = j / s);
          } else
            t.x <= 0
              ? l > 0
                ? ((j -= t.x), (l += t.x))
                : t.y >= 0 && o >= h && (p = f)
              : ((j -= t.x), (l += t.x)),
              t.y >= 0 ? h > o && (k += t.y) : (k += t.y);
          0 > j && ((b = "ne"), (k = 0), (j = 0));
          break;
        case "se":
          if (s) {
            if (t.x >= 0 && (n >= g || o >= h)) {
              p = f;
              break;
            }
            (j += t.x), (k = j / s);
          } else
            t.x >= 0
              ? g > n
                ? (j += t.x)
                : t.y >= 0 && o >= h && (p = f)
              : (j += t.x),
              t.y >= 0 ? h > o && (k += t.y) : (k += t.y);
          0 > j && ((b = "nw"), (k = 0), (j = 0));
          break;
        case "move":
          (c.left += t.x), (c.top += t.y), this.renderImage("move"), (p = f);
          break;
        case "zoom":
          r.zoomable &&
            (this.zoom(
              (function(a, b, c, d, e, f) {
                return (J(e * e + f * f) - J(c * c + d * d)) / J(a * a + b * b);
              })(
                c.width,
                c.height,
                M(this.startX - this.startX2),
                M(this.startY - this.startY2),
                M(this.endX - this.endX2),
                M(this.endY - this.endY2)
              )
            ),
            (this.endX2 = this.startX2),
            (this.endY2 = this.startY2));
          break;
        case "crop":
          t.x &&
            t.y &&
            ((a = this.$cropper.offset()),
            (l = this.startX - a.left),
            (m = this.startY - a.top),
            (j = i.minWidth),
            (k = i.minHeight),
            t.x > 0
              ? t.y > 0
                ? (b = "se")
                : ((b = "ne"), (m -= k))
              : t.y > 0
              ? ((b = "sw"), (l -= j))
              : ((b = "nw"), (l -= j), (m -= k)),
            this.cropped || ((this.cropped = e), this.$dragger.removeClass(q)));
      }
      p &&
        ((i.width = j),
        (i.height = k),
        (i.left = l),
        (i.top = m),
        (this.directive = b),
        this.renderDragger()),
        (this.startX = this.endX),
        (this.startY = this.endY);
    }
  }),
    (H.TEMPLATE = (function(a, b) {
      return (
        (b = b.split(",")),
        a.replace(/\d+/g, function(a) {
          return b[a];
        })
      );
    })(
      '<0 6="5-container"><0 6="5-canvas"></0><0 6="5-dragger"><1 6="5-viewer"></1><1 6="5-8 8-h"></1><1 6="5-8 8-v"></1><1 6="5-face" 3-2="all"></1><1 6="5-7 7-e" 3-2="e"></1><1 6="5-7 7-n" 3-2="n"></1><1 6="5-7 7-w" 3-2="w"></1><1 6="5-7 7-s" 3-2="s"></1><1 6="5-4 4-e" 3-2="e"></1><1 6="5-4 4-n" 3-2="n"></1><1 6="5-4 4-w" 3-2="w"></1><1 6="5-4 4-s" 3-2="s"></1><1 6="5-4 4-ne" 3-2="ne"></1><1 6="5-4 4-nw" 3-2="nw"></1><1 6="5-4 4-sw" 3-2="sw"></1><1 6="5-4 4-se" 3-2="se"></1></0></0>',
      "div,span,directive,data,point,cropper,class,line,dashed"
    )),
    (H.DEFAULTS = {
      aspectRatio: "auto",
      autoCropArea: 0.8,
      data: {},
      done: a.noop,
      preview: "",
      multiple: f,
      autoCrop: e,
      dragCrop: e,
      dashed: e,
      modal: e,
      movable: e,
      resizable: e,
      zoomable: e,
      rotatable: e,
      checkImageOrigin: e,
      minWidth: 0,
      minHeight: 0,
      maxWidth: i,
      maxHeight: i,
      build: g,
      built: g,
      dragstart: g,
      dragmove: g,
      dragend: g
    }),
    (H.setDefaults = function(b) {
      a.extend(H.DEFAULTS, b);
    }),
    (H.other = a.fn.cropper),
    (a.fn.cropper = function(b) {
      var c,
        d = [].slice.call(arguments, 1);
      return (
        this.each(function() {
          var e,
            f = a(this),
            g = f.data("cropper");
          g || f.data("cropper", (g = new H(this, b))),
            "string" == typeof b &&
              a.isFunction((e = g[b])) &&
              (c = e.apply(g, d));
        }),
        typeof c !== j ? c : this
      );
    }),
    (a.fn.cropper.Constructor = H),
    (a.fn.cropper.setDefaults = H.setDefaults),
    (a.fn.cropper.noConflict = function() {
      return (a.fn.cropper = H.other), this;
    });
});
