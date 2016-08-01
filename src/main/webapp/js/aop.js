Function.prototype.before = function (b) {
    if (typeof b !== "function") {
        throw new Error("befornFn not a function!");
    }
    var c = this;
    return function () {
        var a = b.apply(this, arguments);
        if (a !== false) {
            this.afterExecute = true;
            return c.apply(this, arguments);
        } else if (a === false) {
            this.afterExecute = false;
        }
    };
};

Function.prototype.after = function (b) {
    if (typeof b !== "function") {
        throw new Error("afterFn not a function!");
    }
    var c = this;
    return function () {
        var a = c.apply(this, arguments);
        if (this.afterExecute === true) {
            b.apply(this, arguments);
            return a;
        }
    };
};

Function.prototype.around = function (a) {
    if (typeof a !== "function") {
        throw new Error("aroundFn not a function!");
    }
    var b = this;
    return function () {
        a.call(this, b);
    };
};