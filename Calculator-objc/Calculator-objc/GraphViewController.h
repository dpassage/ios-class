//
//  GraphViewController.h
//  Calculator-objc
//
//  Created by David Paschich on 7/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GraphView.h"

@interface GraphViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *graphLabel;
@property (weak, nonatomic) IBOutlet GraphView *graph;
@end
