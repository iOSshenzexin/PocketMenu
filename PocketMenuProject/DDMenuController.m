//
//  DDMenuController.m
//  DDMenuController

#import "DDMenuController.h"

#define kMenuOverlayWidth 65.0f
#define kMenuBounceOffset 4.0f
#define kMenuBounceDuration .2f
#define kMenuSlideDuration .2f


@interface DDMenuController (Internal)
- (void)showRootController:(BOOL)animated;
- (void)showLeftController:(BOOL)animated;
- (void)showShadow:(BOOL)val;
@end

@implementation DDMenuController

@synthesize delegate;

@synthesize leftController=_left;

@synthesize tap=_tap;
@synthesize pan=_pan;

- (id)initWithRootViewController:(UIViewController*)controller {
    if ((self = [super initWithRootViewController:controller])) {
    }
    return self;
}


#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if (!_tap) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [self.view addGestureRecognizer:tap];
        [tap setEnabled:NO];
        _tap = tap;
    }
    
    if (!_pan) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        pan.delegate = (id<UIGestureRecognizerDelegate>)self;
        [self.view addGestureRecognizer:pan];
        _pan = pan;
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
    _tap = nil;
    _pan = nil;
}


#pragma mark - UINavigationController push overide  

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (!_menuFlags.showingLeftView) {
        [super pushViewController:viewController animated:animated];
        return;
    }
    if (_menuFlags.showingLeftView) {
       // [self showRootController:YES];
        // hide the menu, push the view, then slide back
        CGRect frame = self.view.frame;
        frame.origin.x = self.view.bounds.size.width;
       // [super pushViewController:viewController animated:YES];
        [UIView animateWithDuration:.2 animations:^ {
            self.view.frame = frame;        
        } completion:^(BOOL finished) {
            [super pushViewController:viewController animated:NO];
            [self showRootController:YES];
        }];
    }
}


#pragma mark - GestureRecognizers
- (void)pan:(UIPanGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        _panOriginX = self.view.frame.origin.x;
        _panVelocity = CGPointMake(0.0f, 0.0f);
        [self showShadow:YES];
        if([gesture velocityInView:self.view].x > 0) {
          // 从左往右
            _panDirection = DDMenuPanDirectionRight;
        } else {
            //从右往左
            _panDirection = DDMenuPanDirectionLeft;
        }
    }
    
    if (gesture.state == UIGestureRecognizerStateChanged) {
        
        CGPoint velocity = [gesture velocityInView:self.view];
        if((velocity.x*_panVelocity.x + velocity.y*_panVelocity.y) < 0) {
            _panDirection = DDMenuPanDirectionRight;
        }
        
        _panVelocity = velocity;        
        CGPoint translation = [gesture translationInView:self.view];
        CGRect frame = self.view.frame;
        frame.origin.x = _panOriginX + translation.x;
        
        if (frame.origin.x > 0.0f && !_menuFlags.showingLeftView) {
            if (_menuFlags.canShowLeft) {
                _menuFlags.showingLeftView = YES;
                [self.view.superview insertSubview:self.leftController.view belowSubview:self.view];
            } else {
                frame.origin.x = 0.0f; // ignore right view if it's not set
            }
        }
        self.view.frame = frame;
    } else if (gesture.state == UIGestureRecognizerStateEnded || gesture.state == UIGestureRecognizerStateCancelled) {
        //  Finishing moving to left, right or root view with current pan velocity
        [self.view setUserInteractionEnabled:NO];
        
        DDMenuPanCompletion completion = DDMenuPanCompletionRoot; // by default animate back to the root
        
        if (_panDirection == DDMenuPanDirectionRight && _menuFlags.showingLeftView) {
            completion = DDMenuPanCompletionLeft;
           // completion = DDMenuPanCompletionRight;
        }
        
        CGPoint velocity = [gesture velocityInView:self.view];    
        if (velocity.x < 0.0f) {
            velocity.x *= -1.0f;
        }
        BOOL bounce = (velocity.x > 800);
        CGFloat originX = self.view.frame.origin.x;
        CGFloat width = self.view.frame.size.width;
        CGFloat span = (width - kMenuOverlayWidth);
        CGFloat duration = kMenuSlideDuration; // default duration with 0 velocity
        
        if (bounce) {
            duration = (span / velocity.x); // bouncing we'll use the current velocity to determine duration
        } else {
            duration = ((span - originX) / span) * duration; // user just moved a little, use the defult duration, otherwise it would be too slow
        }
        
        [CATransaction begin];
        [CATransaction setCompletionBlock:^{
            if (completion == DDMenuPanCompletionLeft) {
                [self showLeftController:NO];
            }
            else {
                [self showRootController:YES];
            }
            [self.view.layer removeAllAnimations];
            [self.view setUserInteractionEnabled:YES];
        }];
        
        CGPoint pos = self.view.layer.position;
        CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        
        NSMutableArray *keyTimes = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *values = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        NSMutableArray *timingFunctions = [[NSMutableArray alloc] initWithCapacity:bounce ? 3 : 2];
        
        [values addObject:[NSValue valueWithCGPoint:pos]];
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
        [keyTimes addObject:[NSNumber numberWithFloat:0.0f]];
        if (bounce) {
            duration += kMenuBounceDuration;
            [keyTimes addObject:[NSNumber numberWithFloat:1.0f - ( kMenuBounceDuration / duration)]];
            if (completion == DDMenuPanCompletionLeft) {
                
                [values addObject:[NSValue valueWithCGPoint:CGPointMake(((width/2) + span) + kMenuBounceOffset, pos.y)]];
                
            } else if(completion == DDMenuPanCompletionRoot && DDMenuPanCompletionRight){
                // depending on which way we're panning add a bounce offset
                if (_panDirection == DDMenuPanDirectionLeft) {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) - kMenuBounceOffset, pos.y)]];
                }
                else if(completion == DDMenuPanCompletionRoot && DDMenuPanDirectionRight) {
                    [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + kMenuBounceOffset, pos.y)]];
                }
                
            }
            
            [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            
        }
        if (completion == DDMenuPanCompletionLeft) {
            [values addObject:[NSValue valueWithCGPoint:CGPointMake((width/2) + span, pos.y)]];
        }
        else if(completion == DDMenuPanCompletionRoot && DDMenuPanDirectionRight){
            [values addObject:[NSValue valueWithCGPoint:CGPointMake(width/2, pos.y)]];
        }
        
        [timingFunctions addObject:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
        [keyTimes addObject:[NSNumber numberWithFloat:1.0f]];
        
        animation.timingFunctions = timingFunctions;
        animation.keyTimes = keyTimes;
       // animation.calculationMode = @"cubic";
        animation.values = values;
        animation.duration = duration;   
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [self.view.layer addAnimation:animation forKey:nil];
        [CATransaction commit];   
    }
}

- (void)tap:(UITapGestureRecognizer*)gesture {
    [gesture setEnabled:NO];
    [self showRootController:YES];
}


#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    // Check for horizontal pan gesture
    if (gestureRecognizer == _pan) {
        UIPanGestureRecognizer *panGesture = (UIPanGestureRecognizer*)gestureRecognizer;
        CGPoint translation = [panGesture translationInView:self.view];
        //禁止右侧滑动视图的出现.
        if (translation.x <= 0 && [panGesture locationInView:self.view].x > 65  ) {
            return NO;
        }
        return YES;
    }
    return YES;
}


#pragma Internal Nav Handling 

- (void)showShadow:(BOOL)val {
    self.view.layer.shadowOpacity = val ? 1.0f : 0.0f;
    if (val) {
        self.view.layer.cornerRadius = 4.0f;
        self.view.layer.shadowOffset = CGSizeZero;
        self.view.layer.shadowRadius = 4.0f;
        self.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.view.bounds].CGPath;
    }
}

- (void)showRootController:(BOOL)animated {
    
    [_tap setEnabled:NO];
    
    CGRect frame = self.view.frame;
    frame.origin.x = 0.0f;
    if (!animated) {
        self.view.frame = frame;
        return;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self.view.frame = frame;
        
    } completion:^(BOOL finished) {
        
        if (self.leftController && self.leftController.view.superview) {
            [self.leftController.view removeFromSuperview];
        }
        _menuFlags.showingLeftView = NO;

        [self showShadow:NO];
    }];
}

- (void)showLeftController:(BOOL)animated {
    if (!_menuFlags.canShowLeft) return;
    
    if (_menuFlags.respondsToWillShowViewController) {
        [self.delegate menuController:self willShowViewController:self.leftController];
    }
    _menuFlags.showingLeftView = YES;
    [self showShadow:YES];

    UIView *view = self.leftController.view;
    view.frame = [[UIScreen mainScreen] bounds];
    [self.view.superview insertSubview:view belowSubview:self.view];
    
    CGRect frame = self.view.frame;
    frame.origin.x = (CGRectGetMaxX(view.frame) - kMenuOverlayWidth);
    
    if (!animated) {
        self.view.frame = frame;
        [_tap setEnabled:YES];
        return;
    }
    
    [UIView animateWithDuration:.3 animations:^{
        self.view.frame = frame;
    } completion:^(BOOL finished) {
        [_tap setEnabled:YES];
    }];
    
}


#pragma mark Setters

- (void)setDelegate:(id<DDMenuControllerDelegate>)val {
    [super setDelegate:(id<UINavigationControllerDelegate>)val];
    _menuFlags.respondsToWillShowViewController = [(id)self.delegate respondsToSelector:@selector(menuController:willShowViewController:)];
    
}

- (void)setLeftController:(UIViewController *)leftController {
    _left = leftController;
    NSAssert([self.viewControllers count] > 0, @"Must have a root controller set.");
    UIViewController *controller = [self.viewControllers objectAtIndex:0];
    if (_left) {
        UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showLeft:)];
        controller.navigationItem.leftBarButtonItem = button;
        _menuFlags.canShowLeft = YES;
    } else {
        controller.navigationItem.leftBarButtonItem = nil;
        _menuFlags.canShowLeft = NO;
    }
}

#pragma mark - Actions

- (void)showLeft:(id)sender {
    [self showLeftController:YES];
}

@end
