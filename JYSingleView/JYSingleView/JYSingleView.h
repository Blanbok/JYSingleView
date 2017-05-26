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
    JYSingleLineTypeTop = 1,
    JYSingleLineTypeBottom = 2,
};

@interface JYSingleView : UIView

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


/**
 click singleView

 @param tap tap gesture
 */
- (void)JY_clickSingleViewTap:(UITapGestureRecognizer*)tap;

@end

@implementation JYSingleModel
- (instancetype _Nonnull)init
{
    if (self = [super init]) {
        self->_title = @"标题";
        self->_text = @"详情";
        
        self->_textColor_title  = [UIColor blackColor];
        self->_font_title       = [UIFont systemFontOfSize:14];
        self->_inset_title      = UIEdgeInsetsMake(0, 15, 0, 0);
        
        self->_textColor_text   = [UIColor blackColor];
        self->_font_text        = [UIFont systemFontOfSize:14];
        self->_inset_text       = UIEdgeInsetsMake(0, 0, 0, 15);
        
    }
    return self;
}

- (instancetype)initWithModel:(JYSingleModel*)model
{
    if (self = [super init]) {
        ///The number of storage properties
        unsigned int propertyCount = 0;
        ///The properties of the current class are obtained by running
        objc_property_t *propertys = class_copyPropertyList([self class], &propertyCount);
        
        //Put the properties in the array
        for (int i = 0; i < propertyCount; i ++) {
            ///Take the first property
            objc_property_t property = propertys[i];
            
            const char * propertyName = property_getName(property);
            NSString *name = [NSString stringWithUTF8String:propertyName];
            [self setValue:[model valueForKey:name] forKey:name];
            
        }
        free(propertys);
    }
    return self;
}

- (void)JY_clickSingleViewTap:(UITapGestureRecognizer *)tap
{
    
}

NS_ASSUME_NONNULL_END
@end
