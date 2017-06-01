//
//  JYSingleView.m
//  JYSingleView
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 juyuanGroup. All rights reserved.
//
#import "JYSingleView.h"
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

@end

@interface JYSingleView ()

@property (nonnull,nonatomic,strong) UILabel *label_title;

@property (nonnull,nonatomic,strong) UILabel *label_text;

@property (nonnull,nonatomic,strong) UIImageView *imageView_iconNext;

@property (nonnull,nonatomic,strong) UIImageView *imageView_head;

@property (nonnull,nonatomic,strong) CAShapeLayer *layer_line;

@end
@implementation JYSingleView
- (instancetype)initWithModel:(JYSingleModel *)model
{
    if (self = [super initWithFrame:CGRectZero]) {
        self->_model = model;
        [self commInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self->_model = self.defaultModel;
        [self commInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self->_model = self.defaultModel;
        
        [self commInit];
    }
    return self;
}

- (void)commInit
{
    [self theSubViewAdd];
    [self theInteractionEvents];
}

- (void)theSubViewAdd
{
    [self theLabelTitleAdd];
    [self theLabelTextAdd];
    [self theLayerLineAdd];
}

- (void)theInteractionEvents
{
    
    RAC(self.label_title,text)      = RACObserve(self.model, title);
    RAC(self.label_title,textColor) = RACObserve(self.model, textColor_title);
    RAC(self.label_title,font)      = RACObserve(self.model, font_title);
    
    RAC(self.label_text,text)       = RACObserve(self.model, text);
    RAC(self.label_text,textColor)  = RACObserve(self.model, textColor_text);
    RAC(self.label_text,font)       = RACObserve(self.model, font_text);
    
    
/// layer line
        @weakify(self);
    [RACObserve(self, bounds)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.layer_line.frame = self.bounds;
        [self drawLine];
    }];
    
    [[RACSignal combineLatest:@[RACObserve(self.model, lineType),RACObserve(self.model, lineInset),RACObserve(self.model, lineWidth),RACObserve(self.model, lineColor)]]subscribeNext:^(RACTuple * _Nullable x) {
        @strongify(self);
        self.layer_line.strokeColor = self.model.lineColor.CGColor;
        self.layer_line.lineWidth   = self.model.lineWidth;
        
        [self drawLine];
    }];
    
///label title
    [RACObserve(self.model, title)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.label_title.text = self.model.title;
        [self.label_title sizeToFit];
        [self.label_title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(self.label_title.bounds.size.width);
        }];
    }];
    
    [RACObserve(self.model, inset_title)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.label_title mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.model.inset_title.left);
            make.centerY.mas_equalTo(self.model.inset_title.bottom-self.model.inset_title.top);
            make.right.lessThanOrEqualTo(self.label_text.mas_left).offset(-self.model.inset_title.right);
            make.width.mas_equalTo(self.label_title.bounds.size.width);
        }];
    }];

///label text
    [RACObserve(self.model, inset_text)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [self.label_text mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.model.inset_text.right);
            make.centerY.mas_equalTo(self.model.inset_text.bottom-self.model.inset_text.top);
        }];
    }];
    
/// imageView next
    [RACObserve(self.model, icon_next)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.model.icon_next == nil||[UIImage imageNamed:self.model.icon_next] == nil) {
            return ;
        }
        self.imageView_iconNext.image = [UIImage imageNamed:self.model.icon_next];
    }];
    
    [RACObserve(self.model, inset_iconNext)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (UIEdgeInsetsEqualToEdgeInsets(self.model.inset_iconNext, UIEdgeInsetsZero)) {
            return ;
        }
        [self.imageView_iconNext mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-self.model.inset_iconNext.right);
            make.centerY.mas_equalTo(self.model.inset_iconNext.bottom-self.model.inset_iconNext.top);
        }];
        
    }];
    
/// imageView head
    [RACObserve(self.model, icon_head)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.model.icon_head == nil||[UIImage imageNamed:self.model.icon_head] == nil) {
            return ;
        }
        self.imageView_head.image = [UIImage imageNamed:self.model.icon_head];
    }];
    
    [RACObserve(self.model, inset_iconHead)subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (UIEdgeInsetsEqualToEdgeInsets(self.model.inset_iconHead, UIEdgeInsetsZero)) {
            return ;
        }
        [self.imageView_head mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.model.inset_iconHead.left);
            make.centerY.mas_equalTo(self.model.inset_iconHead.bottom-self.model.inset_iconHead.top);
        }];
        
    }];
    
}


- (void)view:(UIView*)view AddLayoutAttribute:(NSLayoutAttribute)layoutAttribute Space:(CGFloat)space
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:layoutAttribute relatedBy:NSLayoutRelationEqual toItem:self attribute:layoutAttribute multiplier:1.0f constant:space]];
}

#pragma mark-subView
- (void)theLabelTitleAdd
{
    self->_label_title = [[UILabel alloc]init];
    self->_label_title.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->_label_title];
}

- (void)theLabelTextAdd
{
    self->_label_text = [[UILabel alloc]init];
    self->_label_text.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self->_label_text];
}

- (void)theLayerLineAdd
{
    self->_layer_line = [CAShapeLayer layer];
    self->_layer_line.lineCap = kCALineCapRound;
    self->_layer_line.lineJoin = kCALineJoinRound;
    [self.layer addSublayer:self->_layer_line];
}

- (void)drawLine
{
    UIBezierPath *bezier = [UIBezierPath bezierPath];
    if (self.model.lineType == JYSingleLineTypeTop||self.model.lineType == (JYSingleLineTypeTop|JYSingleLineTypeBottom)) {
        [bezier moveToPoint:CGPointMake(self.model.lineInset.left, self.model.lineInset.top)];
        [bezier addLineToPoint:CGPointMake(self.bounds.size.width-self.model.lineInset.right, self.model.lineInset.top)];
    }
    
    if (self.model.lineType == JYSingleLineTypeBottom||self.model.lineType == (JYSingleLineTypeTop|JYSingleLineTypeBottom)) {
        [bezier moveToPoint:CGPointMake(self.model.lineInset.left, self.bounds.size.height- self.model.lineInset.bottom)];
        [bezier addLineToPoint:CGPointMake(self.bounds.size.width-self.model.lineInset.right, self.bounds.size.height-self.model.lineInset.bottom)];
    }
    
    self.layer_line.path = bezier.CGPath;
}

#pragma mark-lazyload
- (UIImageView *)imageView_iconNext
{
    if (self->_imageView_iconNext == nil) {
        self->_imageView_iconNext = [[UIImageView alloc]init];
        [self addSubview:self->_imageView_iconNext];
    }
    return self->_imageView_iconNext;
}

- (UIImageView *)imageView_head
{
    if (self->_imageView_head == nil) {
        self->_imageView_head = [[UIImageView alloc]init];
        [self addSubview:self->_imageView_head];
    }
    return self->_imageView_head;
}


- (JYSingleModel *)defaultModel
{
    static JYSingleModel *defaultModel = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        defaultModel = [[JYSingleModel alloc]init];
    });
    return defaultModel;
}

@end
