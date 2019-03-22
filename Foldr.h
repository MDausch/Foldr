#import <Foundation/Foundation.h>
#import <UIKit/UiKit.h>
#import <objc/runtime.h>


@interface SBFolderView : UIView
@end

@interface SBFloatyFolderView : SBFolderView
-(void)_handleOutsideTap:(id)arg1 ;
@end


@interface SBFolderController : UIViewController
@property (nonatomic,readonly) UIView * containerView;
@end

@interface SBFloatyFolderScrollView : UIScrollView
-(void)foldrCloseFolder:(id)selector;
-(id)_viewControllerForAncestor;
@end

@interface SBIconView : UIView
-(id)_viewControllerForAncestor;
@end
