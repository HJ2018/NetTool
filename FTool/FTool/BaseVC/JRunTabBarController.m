
#import "JRunTabBarController.h"
#import "JRunNavController.h"
#import "VCModel.h"
#import <objc/message.h>
#import "UIImage+Category.h"
#import "NSObject+MJParse.h"


@interface JRunTabBarController ()

@end

@implementation JRunTabBarController

//+(void)load
//{
//    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
//    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
//    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
//    
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
//    selectedAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
//    
//    UITabBarItem *item = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
//    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
//    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
//    
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

+(JRunTabBarController *)creatTabBarJsonName:(NSString *)fileName customTabbar:(NSString *)tabBarName{
    
    JRunTabBarController *vc =[self new];
    for (VCModel *model in [VCModel MTMJParse:[JRunTabBarController readLocalFileWithName:fileName]]) {
        [vc addChilvc:objc_msgSend(objc_getClass([model.vcName UTF8String]) , sel_registerName([@"new" UTF8String])) title:model.title image:model.imageName selectImage:model.imageNameClick navColor:model.navColor StoryboardNmae:model.StoryboardNmae StoryboarID:model.StoryboarID];
    }
    if (tabBarName.length > 0) {
        [vc setValue:objc_msgSend(objc_getClass([tabBarName UTF8String]) , sel_registerName([@"new" UTF8String])) forKeyPath:@"tabBar"];
    }

    return vc;
}

+ (NSArray *)readLocalFileWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

-(void)addChilvc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage navColor:(NSString *)navColor StoryboardNmae:(NSString *)Storyboardname StoryboarID:(NSString *)NmaeId;
{
    
    if (Storyboardname.length > 0) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:Storyboardname bundle:[NSBundle mainBundle]];
        vc = [storyboard instantiateViewControllerWithIdentifier:NmaeId];
    }
    vc.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectImage];
    JRunNavController *nav = [[JRunNavController alloc]initWithRootViewController:vc];
    nav.navigationBar.barStyle = UIBarStyleBlack;
    [nav.navigationBar setShadowImage:[[UIImage alloc] init]];
    if ([navColor isEqualToString:@"clearColor"]) {
        
         [nav.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
    }else if(navColor.length > 0 && ![navColor isEqualToString:@"clearColor"]){
       
        [nav.navigationBar setBackgroundImage:[UIImage imageWithColor:(UIColor *) objc_msgSend(objc_getClass([@"UIColor" UTF8String]) , sel_registerName([navColor UTF8String]))] forBarMetrics:UIBarMetricsDefault];
    }
  
    [self addChildViewController:nav];
    
}





@end
