//
//  ViewController.m
//  JYSingleView
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 juyuanGroup. All rights reserved.
//

#import "ViewController.h"
#import "JYSingleView.h"
#import <Masonry/Masonry.h>

@interface ViewController ()
@property (nonnull, nonatomic,strong) JYSingleView *singleView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    JYSingleModel *model = [[JYSingleModel alloc]init];
    model.title = @"请开始你的表演";
    model.text = @"第一步";
    model.textColor_title = [UIColor blackColor];
    model.textColor_text = [UIColor redColor];
    
    
    self->_singleView = [[JYSingleView alloc]initWithModel:model];
    [self.view addSubview:self->_singleView];
    [self->_singleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.centerY.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
