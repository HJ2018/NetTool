#import "JRunNavController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface JRunNavController ()

@property(nonatomic ,assign)BOOL isPan;

@end

@implementation JRunNavController

+(void)load{
    
    UINavigationBar *navBar =[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    
     [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName : UIColor.blackColor,NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.fd_viewControllerBasedNavigationBarAppearanceEnabled = YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    if (self.childViewControllers.count > 0 ) {
        
    
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn setTitle:@"返回" forState:(UIControlStateNormal)];
        [btn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
        viewController.hidesBottomBarWhenPushed = YES;

    }
    [super pushViewController:viewController animated:animated];
    
}
- (void)back
{
    [self popViewControllerAnimated:YES];
}

@end
