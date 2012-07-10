//
//  CalculatorViewController.h
//  Calculator-objc
//
//  Created by David Paschich on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalculatorViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *display;
@property (weak, nonatomic) IBOutlet UILabel *ticker;
@property (weak, nonatomic) IBOutlet UILabel *variables;

- (IBAction)digitPressed:(UIButton *)sender;
- (IBAction)plusMinusPressed;
@end
