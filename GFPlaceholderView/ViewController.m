//
//  ViewController.m
//  GFPlaceholderView
//
//  Created by Giovanni Filaferro on 28/12/14.
//  Copyright (c) 2014 Giovanni Filaferro. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    GFPlaceholderView *placeholder;
    BOOL toggle;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"Toggle" style:UIBarButtonItemStylePlain target:self action:@selector(toggle:)];
    self.navigationItem.rightBarButtonItem = right;
    
    placeholder = [[GFPlaceholderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [placeholder showLoadingView];
    [self.view addSubview:placeholder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toggle:(id)sender {
    if (toggle) {
        [placeholder showLoadingView];
    }
    else {
        [placeholder showViewWithTitle:@"Title" andSubtitle:@"Description can be loooooong!"];
    }
    toggle = !toggle;
}

@end
