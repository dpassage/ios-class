//
//  CalculatorViewController.m
//  Calculator-objc
//
//  Created by David Paschich on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorViewController.h"

@interface CalculatorViewController ()
@end

@implementation CalculatorViewController
@synthesize ticker;
@synthesize display;

- (IBAction)digitPressed:(UIButton *)sender {
}

- (IBAction)plusMinusPressed {
}

- (IBAction)graphPressed {
}

- (IBAction)decimalPressed {
}

- (IBAction)enterPressed {
}

- (IBAction)backspacePressed {
}

- (IBAction)operationPressed:(UIButton *)sender {
}

- (IBAction)clearPressed {
}
- (IBAction)variablePressed:(UIButton *)sender {
}

- (void)viewDidUnload {
    [self setTicker:nil];
    [super viewDidUnload];
}
@end
