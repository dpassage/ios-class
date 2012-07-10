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
@synthesize variables;
@synthesize display;

- (IBAction)digitPressed:(UIButton *)sender {
}

- (IBAction)plusMinusPressed {
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
- (IBAction)testA {
}
- (IBAction)testB {
}
- (IBAction)testC {
}
- (IBAction)testD {
}

- (void)viewDidUnload {
    [self setTicker:nil];
    [self setVariables:nil];
    [super viewDidUnload];
}
@end
