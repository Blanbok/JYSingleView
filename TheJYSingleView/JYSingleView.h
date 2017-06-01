//
//  JYSingleView.h
//  JYSingleView
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 juyuanGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import <Masonry/Masonry.h>
#import <objc/runtime.h>

@class JYSingleModel;
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,JYSingleLineType){
    JYSingleLineTypeNone = 0,
    JYSingleLineTypeTop = 1,
    JYSingleLineTypeBottom = 2,
};

@interface JYSingleView : UIControl

- (instancetype)initWithModel:(JYSingleModel*)model;

@property (nonnull,nonatomic,strong,readonly) JYSingleModel *model;


/**
 default type model
 */
@property (nonnull,nonatomic,strong) JYSingleModel *defaultModel;

@end

#pragma mark-singleModel
@interface JYSingleModel : NSObject

/**
 Standardize line drawing position
 */
@property (nonatomic,assign) NSInteger lineType;

@property (nonatomic,assign) CGFloat lineWidth;

@property (nonatomic,assign) UIEdgeInsets lineInset;

@property (nonnull,nonatomic,strong) UIColor *lineColor;

#pragma mark-title label on the left side of the view
@property (nonnull,nonatomic,copy)      NSString *title;

@property (nonnull,nonatomic,strong)    UIColor *textColor_title;

@property (nonnull,nonatomic,strong)    UIFont *font_title;

/**
 init set
 */
@property (nonatomic,assign) UIEdgeInsets inset_title;

#pragma mark-text label on the right side of the view
@property (nonnull,nonatomic,copy)      NSString *text;

@property (nonnull,nonatomic,strong)    UIColor *textColor_text;

@property (nonnull,nonatomic,strong)    UIFont *font_text;

/**
 init set
 */
@property (nonatomic,assign) UIEdgeInsets inset_text;

#pragma mark-imageView on the right side of the view
@property (nonnull,nonatomic,copy)      NSString *icon_next;

@property (nonatomic,assign) UIEdgeInsets inset_iconNext;

#pragma mark-imageView on the left side of the view
@property (nonnull,nonatomic,copy)      NSString *icon_head;

@property (nonatomic,assign) UIEdgeInsets inset_iconHead;

@end


NS_ASSUME_NONNULL_END

