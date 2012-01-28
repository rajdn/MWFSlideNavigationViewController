//
//  MWFSecondaryViewController.m
//  MWFSlideNavigationViewControllerDemo
//
//  Created by Meiwin Fu on 26/1/12.
//  Copyright (c) Meiwin Fu (blockthirty). All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "MWFDemoSecondaryViewController.h"
#import "MWFSlideNavigationViewController.h"

@implementation MWFDemoSecondaryViewController
@synthesize slideNoneButton = _slideNoneButton;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void) loadView {
    [super loadView];
    
    self.slideNoneButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideNoneButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideNoneButton setTitle:@"Close" forState:UIControlStateNormal];
    [self.slideNoneButton addTarget:self action:@selector(slideNone:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideNoneButton];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Demo Secondary";
    self.view.backgroundColor = [UIColor greenColor];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];

    CGSize s = self.view.bounds.size;
    self.slideNoneButton.frame = CGRectMake(20, 10, s.width-40, 50);
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.slideNoneButton = nil;
}

#pragma mark Actions
- (void) slideNone:(id)sender {

    // if viewController provided is not nil, it will be ignored
    [self.slideNavigationViewController slideForViewController:self 
                                                     direction:MWFSlideDirectionNone 
                                   portraitOrientationDistance:100 
                                  landscapeOrientationDistance:100];
}
@end
