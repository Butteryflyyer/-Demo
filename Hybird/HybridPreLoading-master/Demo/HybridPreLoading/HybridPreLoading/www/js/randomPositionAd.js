/**
 * Created by 吴彦欣 on 2015/2/9.
 * Modify on 2015/03/27
 *
 *
 * 随机显示一个图标在页面的某个位置，点击跳转到一个页面
 * 需要配置下面的iconUrl、targetUrl和closeUrl（可不添加关闭按钮）
 * 这3个url中如果地址含有‘=’和‘&’符号，分别用‘$'和‘@’符号代替
 * 如     iconUrl=http://xxx.com?xxx=yyy&yyy=xxx
 * 改为   iconUrl=http://xxx.com?xxx$yyy@yyy$xxx
 *
 * var opt = {
 *          pos: 'random', //默认随机位置显示，right：靠右显示 left:靠左显示,custom:z载入随机，操作页面后靠右显示
            iconUrl : 'http://img.3gcdn.cn/index/2015/02/09/icon_love_letter.png',
            iconWidth : 40,
            iconHeight : 40,
            targetUrl : 'http://news.3g.cn/news/2015ValentinesDay.php',
            closeIcon ： 'http://close.png', //默认没有关闭图标
            closeIconH: 40, //默认和iconWidth一致
            closeIconW: 40, //默认和iconHeight一致
            container : 'body' //容器选择器 eg. #iamId
        };

 * 使用方法：在要插入的页面添加以下代码
 * <script src="randomPositionAd.js?iconUrl=http://img.3gcdn.cn/index/2015/03/27/menghuan2.jpg
 * &targetUrl=http://da.3g.cn/s.php?idf$5.1555.10443.104435@waped$9@rd$332
 * &closeIcon=http://img.3gcdn.cn/index/2015/03/27/mh2_btn_close.png
 * &pos=right&iconWidth=25&iconHeight=100&closeIconW=25&closeIconH=25"></script>
 * 注意：'&'符号前不能有空格
 *
 * 注意：压缩为.min.js时应注意修改112行var jsFileName = "randomPositionAd.js";
 *      改为var jsFileName = "randomPositionAd.min.js";这样才能获取到参数
 */

(function($){

    var RandomAD = function(opt){
        opt = $.extend({
            pos: 'random',
            iconWidth : 25,
            iconHeight : 25,
            closeIconH: 25,
            closeIconW: 25,
            topPercent: 0.6180339887,
            container : 'body' //容器选择器 eg. #iamId
        }, opt);

        /**
         * 获取标签
         * @param id 随机ID
         * @param style 坐标
         * @returns {string} 标签字符串
         */
        this.getTag = function(id, style){
            return '<a id='+id+' href="'+opt.targetUrl+'" style="position:fixed; z-index:1000;'+style+'"><img style="width:'+
                opt.iconWidth+'px;height:'+opt.iconHeight+'px" src="'+opt.iconUrl+'"/></a>';
        };

        this.getCloseTag = function(id, style){
            return '<a id='+id+' style="position:fixed; z-index:1000;'+style+'"><img style="width:'+opt.closeIconW+
                'px;height:'+opt.closeIconH+'px" src="'+opt.closeIcon+'"/></a>';
        };

        /**
         * 添加一个广告在某个位置
         * @param maxWidth 最大可用宽度
         * @param maxHeight 最大可用高度
         */
        this.addTag = function(maxWidth, maxHeight){
            var randomId = 'randomAd_'+Math.floor(Math.random()*10000);
            var style = '';
            var top =maxHeight * opt.topPercent;
            var left = 0;
            var right = 0;
            if(opt.pos === 'random'){
                left = Math.floor(Math.random() * (maxWidth - opt.iconWidth) + 1);
                top = Math.floor(Math.random() * (maxHeight - opt.iconHeight) + 1);
                style = 'left:'+left+'px;top:'+top+'px';
            }
            else if(opt.pos === 'right'){
//                style = 'right:'+right+'px;top:'+top+'px';
                style = 'right:'+right+'px;top:260px';
            }
            else if(opt.pos === 'left'){
//                style = 'left:'+left+'px;top:'+top+'px';
                style = 'left:'+left+'px;top:260px';
            }else if(opt.pos=='custom'){
                left = Math.floor(Math.random() * (maxWidth - opt.iconWidth) + 1);
                top = Math.floor(Math.random() * (maxHeight - opt.iconHeight) + 1);
                style = 'left:'+left+'px;top:'+top+'px';
                var oldScrollT=$(window).scrollTop();
                $(window).bind("scroll",function(){
                    if(Math.abs($(window).scrollTop()-oldScrollT)>150){
                        $("#"+randomId).css({top:(maxHeight*0.3)+'px',left:(maxWidth-opt.iconWidth)+'px'});
                        $("#"+randomId + '_close').css({top:(maxHeight*0.3-opt.closeIconH)+'px',left:(maxWidth-opt.iconWidth)+'px'});
                        $(window).unbind("scroll");
                    }
                })
            }
            $(opt.container).append(this.getTag(randomId, style));

            //添加关闭按钮
            if(opt.closeIcon){
                top -= opt.closeIconH;
                if(opt.pos === 'right'){
//                    style = 'right:'+right+'px;top:'+top+'px';
                      style = 'right:'+right+'px;top:260px';
                }else{
//                    style = 'left:'+left+'px;top:'+top+'px';
                    style = 'left:'+left+'px;top:260px';
                }
                var closeId = randomId + '_close';
                $(opt.container).append(this.getCloseTag(closeId, style));
                $('#'+closeId).click(function(){
                    $('#'+randomId).hide();
                    $('#'+closeId).hide();
                });
            }
        };

    };

    /**
     * 获取<script src='xx.js?{param}></script>
     * .js?后面的参数并包装成param对象
     * @returns {{}}
     */
    var getUrlParam = function(){
        var param = {};
        var jsFileName = "randomPositionAd.js";
        var rName = new RegExp(jsFileName+"(\\?(.*))?$");
        var jss=document.getElementsByTagName('script');
        for (var i = 0;i < jss.length; i++){
            var j = jss[i];
            if (j.src&&j.src.match(rName)){
                var oo = j.src.match(rName)[2];
                if (oo&&(t = oo.match(/([^&=]+)=([^=&]+)/g))){
                    for (var l = 0; l < t.length; l++){
                        r = t[l];
                        var tt = r.match(/([^&=]+)=([^=&]+)/);
                        if (tt)
                            param[tt[1]] = tt[2];
                    }
                }
            }
        }
        param.targetUrl && (param.targetUrl = param.targetUrl.replace(/\$/g, '=').replace(/@/g, '&'));
        param.iconUrl && (param.iconUrl = param.iconUrl.replace(/\$/g, '=').replace(/@/g, '&'));
        param.closeIcon && (param.closeIcon = param.closeIcon.replace(/\$/g, '=').replace(/@/g, '&'));
        return param;
    };


    $(function(){
        var param = getUrlParam();
        var MAX_WIDTH = document.body.offsetWidth;
        var MAX_HEIGHT = document.documentElement.clientHeight;
        var AD = new RandomAD(param);
        AD.addTag(MAX_WIDTH, MAX_HEIGHT);
    });
})($);
