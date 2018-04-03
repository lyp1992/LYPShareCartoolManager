#import <UIKit/UIKit.h>

@interface SVStatusHUD : UIView{    
}
@property BOOL bShowOnTop;

+ (void)showWithStatus:(NSString*)string;
+ (void)showWithStatusOnTop:(NSString*)string;
+ (void)showStatusWithActivityIndirutionView:(NSString *)string;
+(void)hideShowView;

@end
