//
//  ActionSheetView.m
//  ShareView
//
//  Created by 紫川秀 on 2018/10/16.
//  Copyright © 2018年 Woodsoo. All rights reserved.
//



#import "ActionSheetView.h"
#import "VerButton.h"
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS
#import <Masonry.h>

#define ACTIONSHEET_BACKGROUNDCOLOR             [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:1]
#define WINDOW_COLOR                            [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4]
#define ANIMATE_DURATION                        0.25f

#define ActionSheetW [[UIScreen mainScreen] bounds].size.width
#define ActionSheetH [[UIScreen mainScreen] bounds].size.height

@interface ActionSheetView () <UIScrollViewDelegate>

@property (nonatomic,assign) CGFloat LXActionSheetHeight;
@property (nonatomic,strong) NSArray *shareBtnTitleArray;
@property (nonatomic,strong) NSArray *shareBtnImgArray;

@property (nonatomic,strong) UIView *backGroundView;
@property (nonatomic,strong) UIView *topsheetView;
@property (nonatomic,strong) UIButton *cancelBtn;

//头部提示文字Label
@property (nonatomic,strong) UILabel *proL;

@property (nonatomic,copy) NSString *protext;

@property (nonatomic,assign) ShowType showtype;
@property (nonatomic, strong)NSMutableArray * btnMutableArray;

//分享model
@property (nonatomic, strong) ShareModel* shareModel;

@end

@implementation ActionSheetView

- (id)initWithShareHeadOprationWith:(NSArray *)titleArray andImageArry:(NSArray *)imageArr andProTitle:(NSString *)protitle and:(ShowType)type andHomepageModel: (ShareModel *) model
{
    self = [super init];
    if (self) {
        self.shareBtnImgArray = imageArr;
        self.shareBtnTitleArray = titleArray;
        _protext = protitle;
        _showtype = type;
        _shareModel = model;
        
        self.frame = CGRectMake(0, 0, ActionSheetW, ActionSheetH);
        self.backgroundColor = WINDOW_COLOR;
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
        [self addGestureRecognizer:tapGesture];
        
        if (ShowTypeIsShareStyle == type) {
            [self loadUiConfig];
        }else if(ShowTypeIsActionSheetStyle == type){
            [self loadActionSheetUi];
        }else if(ShowTypeIsScrollShareStyle == type){
            [self loadScrollViewShareView];
        }
        
    }
    return self;
}

- (void)setCancelBtnColor:(UIColor *)cancelBtnColor
{
    [_cancelBtn setTitleColor:cancelBtnColor forState:UIControlStateNormal];
}
- (void)setProStr:(NSString *)proStr
{
    _proL.text = proStr;
}

- (void)setOtherBtnColor:(UIColor *)otherBtnColor
{
    for (id res in _backGroundView.subviews) {
        if ([res isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)res;
            if (button.tag>=100) {
                [button setTitleColor:otherBtnColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)setOtherBtnFont:(NSInteger)otherBtnFont
{
    for (id res in _backGroundView.subviews) {
        if ([res isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)res;
            if (button.tag>=100) {
                button.titleLabel.font = [UIFont systemFontOfSize:otherBtnFont];
            }
        }
    }
}

-(void)setProFont:(NSInteger)proFont
{
    _proL.font = [UIFont systemFontOfSize:proFont];
}

- (void)setCancelBtnFont:(NSInteger)cancelBtnFont
{
    _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:cancelBtnFont];
}

- (void)setDuration:(CGFloat)duration
{
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:duration];
}

- (void)loadActionSheetUi
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.cancelBtn];
    if (_protext.length) {
        [_backGroundView addSubview:self.proL];
    }
    
    for (NSInteger i = 0; i<_shareBtnTitleArray.count; i++) {
        VerButton *button = [VerButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, CGRectGetHeight(_proL.frame)+50*i, CGRectGetWidth(_backGroundView.frame), 50);
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithRed:(229)/255.0 green:(58)/255.0 blue:(64)/255.0 alpha:1.0] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.tag = 100+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backGroundView addSubview:button];
        if (i == _shareBtnTitleArray.count-1) {
            [button setTitleColor:[UIColor colorWithRed:(229)/255.0 green:(58)/255.0 blue:(64)/255.0 alpha:1.0] forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
        }
    }
    
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(0, ActionSheetH-(_shareBtnTitleArray.count*50+50)-7-(_protext.length==0?0:45), ActionSheetW, _shareBtnTitleArray.count*50+50+7+(_protext.length==0?0:45));
    }];
    
}

//加载九宫格UI
- (void)loadUiConfig
{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.topsheetView];
    [_backGroundView addSubview:self.cancelBtn];
    
    _LXActionSheetHeight = CGRectGetHeight(_proL.frame)+7;
    
    for (NSInteger i = 0; i<_shareBtnImgArray.count; i++)
    {
        ActionButton *button = [ActionButton buttonWithType:UIButtonTypeCustom];
        if (_shareBtnImgArray.count%3 == 0) {
            button.frame = CGRectMake(_backGroundView.bounds.size.width/3*(i%3), _LXActionSheetHeight+(i/3)*76, _backGroundView.bounds.size.width/3, 70);
        }
        else
        {
            button.frame = CGRectMake(_backGroundView.bounds.size.width/4*(i%4), _LXActionSheetHeight+(i/4)*76, _backGroundView.bounds.size.width/4, 70);
        }
        
        [button setTitle:_shareBtnTitleArray[i] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_shareBtnImgArray[i]] forState:UIControlStateNormal];
        button.tag = 200+i;
        [button addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.topsheetView addSubview:button];
    }
    
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(7, ActionSheetH-CGRectGetHeight(_backGroundView.frame), ActionSheetW-14, CGRectGetHeight(_backGroundView.frame));
    }];
    
}

//加载分层分享按钮
- (void) loadScrollViewShareView{
    [self addSubview:self.backGroundView];
    [_backGroundView addSubview:self.topsheetView];
    [_backGroundView addSubview:self.cancelBtn];
    
    
    _btnMutableArray = [NSMutableArray array];
    
    for (int i = 0; i < self.shareBtnTitleArray.count ; i++) {
        NSArray* indexArry = self.shareBtnTitleArray[i];
        NSArray* imgIndex = self.shareBtnImgArray[i];
        //构造标题scrollview
        UIScrollView* titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, (90 * i) +15, [UIScreen mainScreen].bounds.size.width, 80)];
        titleScrollView.backgroundColor = [UIColor colorWithRed:235/255 green:235/255 blue:235/255 alpha:0.0];
        // 是否支持滑动最顶端
        titleScrollView.scrollsToTop = NO;
        titleScrollView.delegate = self;
        // 设置内容大小
        titleScrollView.showsHorizontalScrollIndicator = NO;
        titleScrollView.contentSize = CGSizeMake( 85*indexArry.count + 5, 64);
        [_topsheetView addSubview:titleScrollView];
        
        UIView *themeFunctionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 85*indexArry.count + 5, 80)];
        themeFunctionView.backgroundColor = [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(235)/255.0 alpha:1.0];
        [titleScrollView addSubview:themeFunctionView];
        
        for (int j = 0; j < indexArry.count; j++) {
            ActionButton *subFunctionButton = [ActionButton buttonWithType:UIButtonTypeCustom];
            [subFunctionButton setTitle:indexArry[j] forState:UIControlStateNormal];
            [subFunctionButton setImage:[UIImage imageNamed:imgIndex[j]] forState:UIControlStateNormal];
            [themeFunctionView addSubview:subFunctionButton];
            //            subFunctionButton.tag = i;
            int tag = i*10 + j + 300 + 1;
            subFunctionButton.tag = tag;
            [subFunctionButton mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.top.mas_equalTo(themeFunctionView).offset(5);
                make.left.mas_equalTo(themeFunctionView.left).offset(j*80);
                make.width.mas_equalTo(64);
                
            }];
            
            [subFunctionButton addTarget:self action:@selector(BtnClick:) forControlEvents:UIControlEventTouchUpInside];
            
            //添加到对应的数组
            [_btnMutableArray addObject:subFunctionButton];
            
        }
    }
    
    
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        _backGroundView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height -CGRectGetHeight(_backGroundView.frame),  [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(_backGroundView.frame));
    }];
    
}


- (void)BtnClick:(UIButton *)btn
{
    [self tappedCancel];
    //分行显示
    if (btn.tag > 300) {
        _btnClick(btn.tag - 300);
        return;
    }
    
    if (btn.tag < 200) {
        _btnClick(btn.tag - 100);
    }else{
        _btnClick(btn.tag - 200);
    }
}

- (void)tappedCancel
{
    [UIView animateWithDuration:ANIMATE_DURATION animations:^{
        [self.backGroundView setFrame:CGRectMake(0, ActionSheetH, ActionSheetW, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

- (void)noTap{
    
}

#pragma mark -------- getter
- (UIView *)backGroundView
{
    if (_backGroundView == nil) {
        _backGroundView = [[UIView alloc] init];
        
        if (_showtype == ShowTypeIsShareStyle) {
            if (_shareBtnImgArray.count<5) {
                _backGroundView.frame = CGRectMake(7, ActionSheetH, ActionSheetW-14, 64+(_protext.length==0?0:45)+76+14);
            }else
            {
                NSInteger index;
                if (_shareBtnTitleArray.count%4 ==0) {
                    index =_shareBtnTitleArray.count/4;
                }
                else
                {
                    index = _shareBtnTitleArray.count/4 + 1;
                }
                _backGroundView.frame = CGRectMake(7, ActionSheetH, ActionSheetW-14, 64+(_protext.length==0?0:45)+76*index+14);
            }
        }
        else if (_showtype == ShowTypeIsActionSheetStyle){
            _backGroundView.frame = CGRectMake(0, ActionSheetH, ActionSheetW, _shareBtnTitleArray.count*50+50+7+(_protext.length==0?0:45));
            _backGroundView.backgroundColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
            
        }else if(_showtype == ShowTypeIsScrollShareStyle){
            _backGroundView.frame = CGRectMake(0, ActionSheetH, ActionSheetW, 260);
        }
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noTap)];
        [_backGroundView addGestureRecognizer:tapGesture];
    }
    return _backGroundView;
}

//存放按钮的地方
- (UIView *)topsheetView{
    
    if (_topsheetView == nil) {
        _topsheetView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), CGRectGetHeight(_backGroundView.frame)-64)];
        _topsheetView.backgroundColor = [UIColor colorWithRed:(235)/255.0 green:(235)/255.0 blue:(235)/255.0 alpha:1.0];;
        //        _topsheetView.layer.cornerRadius = 4;
        _topsheetView.clipsToBounds = YES;
        
        //        if (_protext.length) {
        //            [_topsheetView addSubview:self.proL];
        //        }
    }
    return _topsheetView;
}

- (UILabel *)proL
{
    if (_proL == nil) {
        _proL = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(_backGroundView.frame), 45)];
        _proL.text = @"分享至";
        _proL.textColor = [UIColor grayColor];
        _proL.backgroundColor = [UIColor whiteColor];
        _proL.textAlignment = NSTextAlignmentCenter;
    }
    return _proL;
}

- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (_showtype == ShowTypeIsShareStyle) {
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-57, CGRectGetWidth(_backGroundView.frame), 50);
            _cancelBtn.layer.cornerRadius = 4;
            _cancelBtn.clipsToBounds = YES;
        }
        else{
            _cancelBtn.frame = CGRectMake(0, CGRectGetHeight(_backGroundView.frame)-50, CGRectGetWidth(_backGroundView.frame), 50);
        }
        
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn.backgroundColor = [UIColor whiteColor];
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn addTarget:self action:@selector(tappedCancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

@end
