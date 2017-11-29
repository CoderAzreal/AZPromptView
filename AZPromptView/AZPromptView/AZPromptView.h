//
//  AZPromptView.h
//  AZPromptView
//
//  Created by tianfengyu on 14/07/2017.
//  Copyright © 2017 Azreal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZPromptView : UIView

+ (void)show:(NSString *)text;
+ (void)show:(NSString *)text hideKeyboardView:(UIView *)hideKeyboardView;

@end
