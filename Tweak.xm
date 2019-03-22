#import "Foldr.h"

%hook SBFloatyFolderScrollView
-(SBFloatyFolderScrollView *)initWithFrame:(CGRect)frame
{

  SBFloatyFolderScrollView *orig = %orig;
  UITapGestureRecognizer *closeGesture =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(foldrCloseFolder:)];
  [orig addGestureRecognizer:closeGesture];
  return orig;
}

%new
-(void)foldrCloseFolder:(id)sender{
  UIViewController *parentVC = [self _viewControllerForAncestor];
  if([parentVC isKindOfClass:[objc_getClass("SBFolderController") class]] ){
    SBFolderController *sbfc = (SBFolderController *)parentVC;

    [(SBFloatyFolderView *)sbfc.containerView _handleOutsideTap:nil];
  }
}
%end

%hook SBIconView
-(void)tapGestureDidChange:(id)sender{
  %orig;

  if([self respondsToSelector:@selector(_viewControllerForAncestor)]){
    UIViewController *parentVC = [self _viewControllerForAncestor];
    if(parentVC && [parentVC isKindOfClass:[objc_getClass("SBFolderController") class]] ){
      SBFolderController *sbfc = (SBFolderController *)parentVC;
      if(sbfc && [sbfc.containerView isKindOfClass:[objc_getClass("SBFloatyFolderView") class]])
        [(SBFloatyFolderView *)sbfc.containerView _handleOutsideTap:nil];
    }
  }
}
%end
