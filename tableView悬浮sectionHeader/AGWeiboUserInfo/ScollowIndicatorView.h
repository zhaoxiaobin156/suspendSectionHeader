//
//  ScollowIndicatorView.h
//  scrollHeadView
//
//  Created by Ios on 17/7/18.
//  Copyright © 2017年 qidongTech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger ,lineType){
    lineTypeNone,
    lineTypeSingle
};


@protocol ScollowIndicatorViewDelegate <NSObject>
//传出选中按钮的tag
-(void)scollowIndicatorViewPassSelectedIndex:(NSInteger )index;

@end


@interface ScollowIndicatorView : UIView
@property(nonatomic,strong)NSArray *mut;
@property(nonatomic,weak)id<ScollowIndicatorViewDelegate>delegate;

@property(nonatomic,assign)NSInteger contentOffSetNum;//传给控件内部，决定选中哪个按钮





//底部是否加线
@property(nonatomic,assign)lineType MBline;
@end
