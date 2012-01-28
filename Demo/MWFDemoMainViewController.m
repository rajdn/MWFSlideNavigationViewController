//
//  MWFDemoMainViewController.m
//  MWFSlideNavigationViewControllerDemo
//
//  Created by Meiwin Fu on 24/1/12.
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

#import "MWFDemoMainViewController.h"
#import "MWFDemoSecondaryViewController.h"
#import "NSObject+DelayedBlock.h"

@implementation MWFDemoMainViewController
@synthesize slideUpButton = _slideUpButton;
@synthesize slideLeftButton = _slideLeftButton;
@synthesize slideDownButton = _slideDownButton;
@synthesize slideRightButton = _slideRightButton;

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

    self.slideUpButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideUpButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideUpButton setTitle:@"Slide Up" forState:UIControlStateNormal];
    [self.slideUpButton addTarget:self action:@selector(slideUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideUpButton];

    self.slideLeftButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideLeftButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideLeftButton setTitle:@"Slide Left" forState:UIControlStateNormal];
    [self.slideLeftButton addTarget:self action:@selector(slideLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideLeftButton];

    self.slideDownButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideDownButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideDownButton setTitle:@"Slide Down" forState:UIControlStateNormal];
    [self.slideDownButton addTarget:self action:@selector(slideDown:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideDownButton];

    self.slideRightButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.slideRightButton.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.slideRightButton setTitle:@"Slide Right" forState:UIControlStateNormal];
    [self.slideRightButton addTarget:self action:@selector(slideRight:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.slideRightButton];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Demo Main";
    self.view.backgroundColor = [UIColor redColor];

    CGSize s = self.view.bounds.size;
    self.slideUpButton.frame = CGRectMake(20, 10, s.width-40, 50);
    self.slideLeftButton.frame = CGRectMake(20, 70, s.width-40, 50);
    self.slideDownButton.frame = CGRectMake(20, 130, s.width-40, 50);
    self.slideRightButton.frame = CGRectMake(20, 190, s.width-40, 50);
    
    self.slideNavigationViewController.delegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.slideUpButton = nil;
    self.slideLeftButton = nil;
    self.slideDownButton = nil;
    self.slideRightButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

#pragma mark Actions
- (void) _slide:(MWFSlideDirection)direction {
    MWFDemoSecondaryViewController * secCtl = [[MWFDemoSecondaryViewController alloc] init];
    UINavigationController * navCtl = [[UINavigationController alloc] initWithRootViewController:secCtl];
    [self.slideNavigationViewController slideForViewController:navCtl 
                                                     direction:direction 
                                   portraitOrientationDistance:180 
                                  landscapeOrientationDistance:100];
}
- (void) slideUp:(id)sender {
    [self _slide:MWFSlideDirectionUp];
}
- (void) slideLeft:(id)sender {
    [self _slide:MWFSlideDirectionLeft];
}
- (void) slideDown:(id)sender {
    [self _slide:MWFSlideDirectionDown];
}
- (void) slideRight:(id)sender {
    [self _slide:MWFSlideDirectionRight];
}
- (void) close:(id)sender {
    [self _slide:MWFSlideDirectionNone];
}
#pragma mark MWFSlideNavigationViewControllerDelegate
#define VIEWTAG_OVERLAY 1100
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller willPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {

    if (slideDirection == MWFSlideDirectionNone) {
        
        UIView * overlay = [self.navigationController.view viewWithTag:VIEWTAG_OVERLAY];
        [overlay removeFromSuperview];
        
    } else {
        
        UIView * overlay = [[UIView alloc] initWithFrame:self.navigationController.view.bounds];
        overlay.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        overlay.tag = VIEWTAG_OVERLAY;
        UITapGestureRecognizer * gr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(close:)];
        [overlay addGestureRecognizer:gr];
        [self.navigationController.view addSubview:overlay];
        
    }
}
/*
- (void) slideNavigationViewController:(MWFSlideNavigationViewController *)controller didPerformSlideFor:(UIViewController *)targetController withSlideDirection:(MWFSlideDirection)slideDirection distance:(CGFloat)distance orientation:(UIInterfaceOrientation)orientation {
    
    if (slideDirection == MWFSlideDirectionNone) {
        self.navigationController.view.userInteractionEnabled = YES;
    } else {
        self.navigationController.view.userInteractionEnabled = NO;
    }
}
*/
@end
