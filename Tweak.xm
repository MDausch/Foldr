#import "Foldr.h"

%hook SBFloatyFolderScrollView
-(SBFloatyFolderScrollView *)initWithFrame:(CGRect)frame
{
  //Gets the original instance of the view
  SBFloatyFolderScrollView *orig = %orig;

  //Creates a tap gesture recognizer, that will close the folder
  UITapGestureRecognizer *closeGesture =
  [[UITapGestureRecognizer alloc] initWithTarget:self
                                          action:@selector(foldrCloseFolder:)];

  //Add our gesture to the scroll view
  [orig addGestureRecognizer:closeGesture];

  //Return the modified view
  return orig;
}


//We need a new method to handle our logic in
%new
-(void)foldrCloseFolder:(id)sender
{
  //Access the views view controller
  UIViewController *parentVC = [self _viewControllerForAncestor];

  //Double check to make sure we're in a folder
  if([parentVC isKindOfClass:[objc_getClass("SBFolderController") class]] ){

    //Get the content view (the folder)
    SBFolderController *sbfc = (SBFolderController *)parentVC;

    //Make sure the view isnt nil, and that its container is a folder
    if(sbfc && [sbfc.containerView isKindOfClass:[objc_getClass("SBFloatyFolderView") class]])
      //"Tap" the close method for folders
      [(SBFloatyFolderView *)sbfc.containerView _handleOutsideTap:nil];
  }
}
%end


%hook SBIconView
//Called on tapping an icon
-(void)tapGestureDidChange:(id)sender
{
  %orig;

  UIViewController *parentVC = [self _viewControllerForAncestor];
  if(parentVC && [parentVC isKindOfClass:[objc_getClass("SBFolderController") class]] ){
    SBFolderController *sbfc = (SBFolderController *)parentVC;
    if(sbfc && [sbfc.containerView isKindOfClass:[objc_getClass("SBFloatyFolderView") class]])
      [(SBFloatyFolderView *)sbfc.containerView _handleOutsideTap:nil];
  }
}
%end
