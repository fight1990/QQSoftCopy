//
//  PWSliderViewController.m
//  LeftAndRightSlider
//
//  Created by ZHENGBO on 15/1/7.
//  Copyright (c) 2015年 WeiPengwei. All rights reserved.
//

#import "PWSliderViewController.h"
#define DefaultContentOffset  250
#define DefaultLeapOffset 100
#define DefaultContentScale 0.6
#define DefaultDuration 0.15

//slideDirection_enum
typedef NS_ENUM(NSInteger, PMoveDirection){
    PMoveDirectionLeft = 0, //left
    PMoveDirectionRight //right
};

@interface PWSliderViewController ()<UIGestureRecognizerDelegate>  {

    UIView *leftView;
    UIView *rightView;
    UIView *mainView;
    
    BOOL leftIsNoNull;
    BOOL rightIsNoNull;
    
    UITapGestureRecognizer *tapGesture;
    UIPanGestureRecognizer *panGesture;
}

@end

@implementation PWSliderViewController

+ (PWSliderViewController*)sharedSliderViewController {

    static PWSliderViewController *sharedSliderViewController;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedSliderViewController = [[self alloc] init];
    });
    return sharedSliderViewController;
}
- (instancetype)init {

    self = [super init];
    if (self) {
        [self initialization];
    }
    
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialization];
    }
    return self;
}
- (void)initialization {
    leftIsNoNull = NO;
    _leftContentOffset =  DefaultContentOffset;
    _leftContentScale = DefaultContentScale;
    
    rightIsNoNull = NO;
    _rightContentOffset = DefaultContentOffset;
    _rightContentScale = DefaultContentScale;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initChildControllers:_leftViewController rightVC:_rightViewController mainVC:_centerViewController];
    
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    tapGesture.delegate=self;
    [self.view addGestureRecognizer:tapGesture];
    tapGesture.enabled = NO;
    
    panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [mainView addGestureRecognizer:panGesture];
}
- (void)initChildControllers:(UIViewController*)leftVC rightVC:(UIViewController*)rightVC mainVC:(UIViewController*)mainVC{
    if (leftVC) {
        leftIsNoNull = YES;
        leftView = [[UIView alloc]initWithFrame:self.view.bounds];
        [self.view addSubview:leftView];
        
        //[self addChildViewController:leftVC];
        leftVC.view.frame=CGRectMake(0, 0, leftVC.view.frame.size.width, leftVC.view.frame.size.height);
        [leftView addSubview:leftVC.view];
    }
    if (rightVC) {
        rightIsNoNull = YES;
        rightView = [[UIView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:rightView];
        
        //[self addChildViewController:rightVC];
        rightVC.view.frame=CGRectMake(0, 0, rightVC.view.frame.size.width, rightVC.view.frame.size.height);
        [rightView addSubview:rightVC.view];
    }
    
    mainView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:mainView];
    
    mainVC.view.frame=CGRectMake(0, 0, mainVC.view.frame.size.width, mainVC.view.frame.size.height);
    //[self addChildViewController:mainVC];
    [mainView addSubview:mainVC.view];
}
- (void)showMainViewController{
    [self closeSideBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)closeSideBar {
    [UIView animateWithDuration:DefaultDuration
                     animations:^{
                         mainView.transform = CGAffineTransformIdentity;
                     }
                     completion:^(BOOL finished) {
                         tapGesture.enabled = NO;
                     }];
}
- (void)showLeftViewController {
    if (leftIsNoNull) {
        
        CGAffineTransform conT = [self transformWithDirection:PMoveDirectionRight];
        
        [self.view sendSubviewToBack:rightView];
        [self configureViewShadowWithDirection:PMoveDirectionRight];
        
        [UIView animateWithDuration:DefaultDuration
                         animations:^{
                             mainView.transform = conT;
                         }
                         completion:^(BOOL finished) {
                             tapGesture.enabled = YES;
                         }];
    }
}

- (void)showRightViewController {
    if (rightIsNoNull) {
        
        CGAffineTransform conT = [self transformWithDirection:PMoveDirectionLeft];
        
        [self.view sendSubviewToBack:leftView];
        [self configureViewShadowWithDirection:PMoveDirectionLeft];
        
        [UIView animateWithDuration:DefaultDuration
                         animations:^{
                             mainView.transform = conT;
                         }
                         completion:^(BOOL finished) {
                             tapGesture.enabled = YES;
                         }];
    }
}
- (CGAffineTransform)transformWithDirection:(PMoveDirection)direction{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (direction) {
        case PMoveDirectionLeft:
            translateX = -_rightContentOffset;
            transcale = _rightContentScale;
            break;
        case PMoveDirectionRight:
            translateX = _leftContentOffset;
            transcale = _leftContentScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}
- (void)configureViewShadowWithDirection:(PMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction) {
        case PMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case PMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    mainView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);
    mainView.layer.shadowColor = [UIColor blackColor].CGColor;
    mainView.layer.shadowOpacity = 0.8f;
}
- (void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes {
    static CGFloat currentTranslateX;
    if (panGes.state == UIGestureRecognizerStateBegan) {
        currentTranslateX = mainView.transform.tx;
    }
    if (panGes.state == UIGestureRecognizerStateChanged) {
        CGFloat transX = [panGes translationInView:mainView].x;
        transX = transX + currentTranslateX;
        
        CGFloat sca;
        if (transX > 0) {
            if (leftIsNoNull) {
                [self.view sendSubviewToBack:rightView];
                [self configureViewShadowWithDirection:PMoveDirectionRight];
                
                if (mainView.frame.origin.x < _leftContentOffset) {
                    sca = 1 - (mainView.frame.origin.x/_leftContentOffset) * (1-_leftContentScale);
                }
                else {
                    sca = _leftContentScale;
                }
                CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
                CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
                CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
                mainView.transform = conT;
            }
        }
        else {    //transX < 0
            if (rightIsNoNull) {
                [self.view sendSubviewToBack:leftView];
                [self configureViewShadowWithDirection:PMoveDirectionLeft];
                
                if (mainView.frame.origin.x > -_rightContentOffset) {
                    sca = 1 - (-mainView.frame.origin.x/_rightContentOffset) * (1-_rightContentScale);
                }
                else {
                    sca = _rightContentScale;
                }
                CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
                CGAffineTransform transT = CGAffineTransformMakeTranslation(transX, 0);
                CGAffineTransform conT = CGAffineTransformConcat(transT, transS);
                mainView.transform = conT;
            }
        }
    }
    else if (panGes.state == UIGestureRecognizerStateEnded) {
        CGFloat panX = [panGes translationInView:mainView].x;
        CGFloat finalX = currentTranslateX + panX;
        if (finalX > DefaultLeapOffset) {
            if (leftIsNoNull) {
                CGAffineTransform conT = [self transformWithDirection:PMoveDirectionRight];
                [UIView beginAnimations:nil context:nil];
                mainView.transform = conT;
                [UIView commitAnimations];
                
                tapGesture.enabled = YES;
            }
            return;
        }
        if (finalX < -DefaultLeapOffset) {
            if (rightIsNoNull) {
                CGAffineTransform conT = [self transformWithDirection:PMoveDirectionLeft];
                [UIView beginAnimations:nil context:nil];
                mainView.transform = conT;
                [UIView commitAnimations];
                
                tapGesture.enabled = YES;
            }
            return;
        }
        else {
            CGAffineTransform oriT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            mainView.transform = oriT;
            [UIView commitAnimations];
            
            tapGesture.enabled = NO;
        }
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
- (void)dealloc {
    _leftViewController = nil;
    _rightViewController = nil;
    _centerViewController = nil;
    
    leftView = nil;
    rightView = nil;
    mainView = nil;
    
    tapGesture = nil;
    panGesture = nil;
    
}
@end
