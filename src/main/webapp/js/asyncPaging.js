var Pagination = (function () {
    var Pagination = function (param) {
        this.selector = param.selector;
        this.uri = param.uri;
        this.container = $(this.selector).get(0);
        this.containerTagName = this.container.tagName.toLowerCase();
        this.pagingTag = this.containerTagName === "div" ? "div" : "li";
        this[this.responseDataResolverConf.pageSize] = param.pageSize || 10;
        this.turningBtnConnt = param.turningBtnConnt || 10;
        this.offset = param.offset || 4;
        this.requestSuccessCallback = param.requestSuccessCallback || null;
        this.responseDataResolverConf = param.responseDataResolverConf || {};
        this.responseDataResolverConf = {
            pageIndex: this.responseDataResolverConf.pageIndex || "pageIndex",
            pageSize: this.responseDataResolverConf.pageSize || "pageSize",
            totalCount: this.responseDataResolverConf.totalCount || "totalCount"
        };
        this.requestData = {};
        this.requestData[this.responseDataResolverConf.pageSize] = this[this.responseDataResolverConf.pageSize];

        this.clsConf = {
            active: param.activeClass || "active",
            textTurningBtn: param.textTurningClass || "text-turning-btn",
            numTurningBtn: param.numTurningClass || "num-turning-btn",
            loading: param.loadingClass || "loading"
        };
        this.showConf = {
            firstLastBtn: this.isBoolean(param.showFirstLastBtn) ? param.showFirstLastBtn : false,
            prevNextBtn: this.isBoolean(param.showPrevNextBtn) ? param.showPrevNextBtn : true
        };

        this.turningConf = {
            "conf": ["first", "prev", "next", "last"],
            "first": param.firstBtnText || "首页",
            "prev": param.prevBtnText || "上一页",
            "next": param.nextBtnText || "下一页",
            "last": param.lastBtnText || "尾页"
        }

        this.loading = document.getElementById(this.clsConf.loading);
        this.init();
    };

    ["String", "Number", "Array", "Boolean", "Undefined", "Null", "Function"].forEach(function (type) {
        Pagination.prototype["is" + type] = function (value) {
            return Object.prototype.toString.call(value) == "[object " + type + "]"
        };
    });

    Pagination.prototype.init = function () {
        this[this.responseDataResolverConf.pageIndex] = 1;

        this.gotoPage(this[this.responseDataResolverConf.pageIndex])
    };

    Pagination.prototype.gotoPage = function (targetIndex) {
        this[this.responseDataResolverConf.pageIndex] = targetIndex;

        this.bindRequestData();
        this.sendRequestData();
    };

    Pagination.prototype.clear = function () {
        this.container.innerHTML = "";
        this.pagingElements = [];
        for (var index in this.turningConf.conf) {
            var key = this.turningConf.conf[index];

            this[key + "Ele"] = null;
        }
    };

    Pagination.prototype.sendRequestData = function () {
        var __self = this;

        this.requestFinish = false;

        if (this.loading)
            $(this.loading).show();

        $.ajax({
            url: __self.uri,
            type: "post",
            data: __self.requestData,
            dataType: "json",
            success: function (json) {
                __self.requestFinish = true;
                __self.responseData = json;
                __self.clear();
                __self.generatorPaging();
                __self.bindEvent();
                __self.bindData();
                if (__self.requestSuccessCallback)
                    __self.requestSuccessCallback.apply(__self, arguments);

                $(__self.loading).hide();
            },
            error: function () {
                __self.requestFinish = true;

                if (this.loading)
                    $(__self.loading).hide();

                throw new Error("获取分页数据失败！");
            }
        });
    };

    Pagination.prototype.generatorPaging = function () {
        var curEle = null;

        this.resolverResponseData();

        var generatorTurningPageBtn = function () {
            if (this.totalPage <= 1) {
                return;
            }
            else {
                var targetTurningValue =
                    this.isFirstPage() ? this.turningConf.conf.slice(2)
                        : (this.isLastPage() ? this.turningConf.conf.slice(0, 2) : this.turningConf.conf);

                if (!this.showConf.firstLastBtn) {
                    targetTurningValue = targetTurningValue.filter(function (value) {
                        return value !== "first" && value !== "last";
                    });
                }
                if (!this.showConf.prevNextBtn) {
                    targetTurningValue = targetTurningValue.filter(function (value) {
                        return value !== "prev" && value !== "next";
                    });
                }

                for (var index in targetTurningValue) {
                    var key = targetTurningValue[index];
                    var targetValue = this.turningConf[key];

                    curEle = this.createElement(this.pagingTag, targetValue, [
                        key,
                        this.clsConf.textTurningBtn
                    ]);

                    this[key + "Ele"] = curEle;
                }
            }
        };

        var generatorNumberPageBtn = function () {
            if (this.totalPage == 1) {
                return;
            }
            else {
                var startIndex = 1;
                var endIndex = null;

                if (this.totalPage <= 10) {
                    endIndex = this.totalPage;
                }
                else if (this[this.responseDataResolverConf.pageIndex] <= this.offset) {
                    endIndex = this.turningBtnConnt;
                }
                // 到最后turningBtnConnt-offset页时
                else if (this[this.responseDataResolverConf.pageIndex] > (this.totalPage - this.turningBtnConnt + this.offset)) {
                    startIndex = this.totalPage - this.turningBtnConnt + 1;
                    endIndex = this.totalPage;
                }
                else if (this[this.responseDataResolverConf.pageIndex] > this.offset) {
                    var offsetStartIndex = this[this.responseDataResolverConf.pageIndex] - this.offset;
                    var tempOffsetEndIndex = (offsetStartIndex + this.turningBtnConnt);
                    var offsetEndIndex = tempOffsetEndIndex >= this.totalPage ? this.totalPage : tempOffsetEndIndex;

                    startIndex = offsetStartIndex;
                    endIndex = offsetEndIndex - 1;
                }

                for (var i = startIndex, index = 0; i <= endIndex; i++ , index++) {
                    curEle = this.createElement(this.pagingTag, i, this.clsConf.numTurningBtn);

                    if (this[this.responseDataResolverConf.pageIndex] == i) {
                        curEle.classList.add(this.clsConf.active);
                    }

                    this.pagingElements[index] = curEle;
                }
            }
        };

        generatorTurningPageBtn.call(this);
        generatorNumberPageBtn.call(this);
    };

    Pagination.prototype.bindEvent = function () {
        var __self = this;

        if (this.firstEle)
            this.firstEle.onclick = function () {
                if (__self.requestFinish) {
                    __self.pageTurning.first.call(__self);
                }
            };
        if (this.prevEle)
            this.prevEle.onclick = function () {
                if (__self.requestFinish) {
                    __self.pageTurning.prev.call(__self);
                }
            };

        for (var i = 0, len = this.pagingElements.length; i < len; ++i) {
            var curEle = this.pagingElements[i];

            (function (curEle) {
                if (!curEle.classList.contains("active")) {
                    curEle.onclick = function () {
                        if (__self.requestFinish) {
                            var targetIndex = curEle.textContent;

                            __self.gotoPage(targetIndex);
                        }
                    };
                }

                this.container.appendChild(curEle);
            }).call(this, curEle);
        }

        if (this.nextEle)
            this.nextEle.onclick = function () {
                if (__self.requestFinish) {
                    __self.pageTurning.next.call(__self);
                }
            };
        if (this.lastEle)
            this.lastEle.onclick = function () {
                if (__self.requestFinish) {
                    __self.pageTurning.last.call(__self);
                }
            };
    };

    Pagination.prototype.bindData = function () {
        if (this.firstEle)
            this.container.appendChild(this.firstEle);
        if (this.prevEle)
            this.container.appendChild(this.prevEle);

        for (var i = 0, len = this.pagingElements.length; i < len; ++i) {
            var curEle = this.pagingElements[i];

            this.container.appendChild(curEle);
        }

        if (this.nextEle)
            this.container.appendChild(this.nextEle);
        if (this.lastEle)
            this.container.appendChild(this.lastEle);
    };

    Pagination.prototype.bindRequestData = function (callback) {
        this.requestData.pageIndex = this[this.responseDataResolverConf.pageIndex];

        if (this.isFunction(callback)) {
            callback(this.requestData);
        }
    };

    Pagination.prototype.resolverResponseData = function () {
        this[this.responseDataResolverConf.pageSize] = this.responseData[this.responseDataResolverConf.pageSize];
        this[this.responseDataResolverConf.totalCount] = this.responseData[this.responseDataResolverConf.totalCount];
        this.totalPage = this.calculateTotalPage();
    }

    Pagination.prototype.calculateTotalPage = function () {
        var totalPage = Math.ceil(this[this.responseDataResolverConf.totalCount] / this[this.responseDataResolverConf.pageSize]);

        return totalPage;
    };

    Pagination.prototype.pageTurning = {
        first: function () {
            this.gotoPage(1);
        },
        prev: function () {
            var targetIndex = parseInt(this[this.responseDataResolverConf.pageIndex]) - 1;

            this.gotoPage(targetIndex > 0 ? targetIndex : 1);
        },
        next: function () {
            var targetIndex = parseInt(this[this.responseDataResolverConf.pageIndex]) + 1;

            this.gotoPage(targetIndex <= this.totalPage ? targetIndex : this.totalPage);
        },
        last: function () {
            this.gotoPage(this.totalPage)
        }
    };

    Pagination.prototype.isFirstPage = function () {
        return this[this.responseDataResolverConf.pageIndex] == 1;
    };

    Pagination.prototype.isLastPage = function () {
        return this[this.responseDataResolverConf.pageIndex] == this.totalPage;
    };

    Pagination.prototype.createElement = function (elementName, elementContent, classes, callback) {
        var element = document.createElement(elementName);

        element.textContent = elementContent ? elementContent : null;

        if (this.isString(classes)) {
            element.classList.add(classes);
        }
        else if (this.isArray(classes)) {
            for (var key in classes) {
                element.classList.add(classes[key]);
            }
        }

        if (this.isFunction(callback)) {
            callback(element);
        }

        return element;
    };

    return Pagination;
})();