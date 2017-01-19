require('UIImage, MinePageManager,UITableView,NSIndexPath,UIImageView,UITableViewCell,QDWTgCell,UILabel,UIColor,UIFont');
require('UIScreen');
require('UIView');


defineClass("QDWMineViewController : BaseViewController,<UITableViewDataSource>", {
            
            QDWRealValue:function(value){
            
              return  (value)/375 * UIScreen.mainScreen().bounds().width;
            
            },
            
            
            tableView_cellForRowAtIndexPath: function(tableView, indexPath) {
            
            var cell = tableView.dequeueReusableCellWithIdentifier("tg");
       
            if (0 == indexPath.row()) {
            cell.iconImageView().setImage(UIImage.imageNamed("资金账户"));
            cell.titleLabel().setText("资金账户");
            cell.lineView().setHidden(false);
            if (self.userInfo().mineMessage().hasbank().isEqual("0")) {
            cell.cardLabel().setText("未绑卡");
            } else if (self.userInfo().mineMessage().hasbank().isEqual("1") && self.userInfo().mineMessage().auditstatus().isEqual("2") || self.userInfo().mineMessage().hasbank().isEqual("1") && self.userInfo().mineMessage().auditstatus().isEqual("5")) {
            cell.cardLabel().setText("未通过");
            } else {
            cell.cardLabel().setText("");
            }
            } else if (1 == indexPath.row()) {
            cell.titleLabel().setText("我的单子");
            cell.iconImageView().setImage(UIImage.imageNamed("我的单子"));
            cell.cardLabel().setHidden(true);
            } else if (2 == indexPath.row()) {
            cell.titleLabel().setText("我的消息");
            cell.iconImageView().setImage(UIImage.imageNamed("我的消息"));
            cell.smallCircleView().setHidden(!MinePageManager.shareManager().unReadNewsCount());
            cell.cardLabel().setHidden(true);
            } else if (3 == indexPath.row()) {
            cell.titleLabel().setText("邀请好友");
            cell.iconImageView().setImage(UIImage.imageNamed("邀请好友"));
            cell.cardLabel().setHidden(true);
            
            var ScreenWidth = UIScreen.mainScreen().bounds().width;
            
            var arr = cell.subviews().toJS();
            
       
            for(var i = 0;i < arr.length;i++){
            
            
            
            if (arr[i].tag() == 1001) {
            arr[i].removeFromSuperview();
            }
            
            }
            
            
            var YaoQingRightLabel;
            
            var Y = self.QDWRealValue(13);
            
            YaoQingRightLabel = UILabel.alloc().initWithFrame({x:ScreenWidth-80,y:Y,width:80,height:20});
            YaoQingRightLabel.setText("邀请有礼");

            YaoQingRightLabel.setTag(1001);
            
            YaoQingRightLabel.setTextColor(UIColor.redColor());
            YaoQingRightLabel.setFont(UIFont.systemFontOfSize(13));
        
            
            cell.addSubview(YaoQingRightLabel);
            
            
            
            
         
            
            } else if (4 == indexPath.row()) {
            cell.titleLabel().setText("我的中奖记录");
            cell.iconImageView().setImage(UIImage.imageNamed("我的中奖记录"));
            cell.cardLabel().setHidden(true);
            } else if (5 == indexPath.row()) {
            cell.titleLabel().setText("设置");
            cell.iconImageView().setImage(UIImage.imageNamed("设置"));
            cell.cardLabel().setHidden(true);
            }
            return cell;
            }
            }, {});


