//
// GFPlaceholderView.h
// Version 1.0
//
// Copyright (c) 2014 - 2015 Giovanni Filaferro ( http://www.nanotek.it/ ). All Rights Reserved.
//
// Permission is hereby granted, free of charge, to any person
// obtaining a copy of this software and associated documentation
// files (the "Software"), to deal in the Software without
// restriction, including without limitation the rights to use,
// copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the
// Software is furnished to do so, subject to the following
// conditions:
//
// The above copyright notice and this permission notice shall be
// included in all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
// EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
// OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
// NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
// HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
// WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
// OTHER DEALINGS IN THE SOFTWARE.

#import "GFPlaceholderView.h"

#define kGRAY_COLOR [UIColor colorWithRed:0.56 green:0.56 blue:0.58 alpha:1]

@interface GFPlaceholderView () {
    UILabel *titleLabel;
    UITextView *descriptionTextView;
    
    UILabel *loadingLabel;
    UIActivityIndicatorView *activityIndicator;
}

@end

@implementation GFPlaceholderView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self commonInit];
}

#pragma mark - My Methods
- (void)commonInit {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    self.backgroundColor = [UIColor whiteColor];
    
    CGFloat activityHeight = 30;
    loadingLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [loadingLabel setText:@"Loading..."];
    [loadingLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [loadingLabel setTextColor:kGRAY_COLOR];
    [loadingLabel sizeToFit];
    CGRect loadingRect = loadingLabel.frame;
    loadingRect.origin.y = (self.frame.size.height-loadingRect.size.height)/2;
    loadingRect.origin.x = (self.frame.size.width-loadingRect.size.width)/2 + activityHeight/2;
    loadingLabel.frame = loadingRect;
    loadingLabel.alpha = 0.0f;
    [self addSubview:loadingLabel];
    
    activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [activityIndicator setTintColor:kGRAY_COLOR];
    activityIndicator.alpha = 0.0f;
    [activityIndicator setFrame:CGRectMake(loadingRect.origin.x-activityHeight, (self.frame.size.height-activityHeight)/2, activityHeight, activityHeight)];
    [activityIndicator startAnimating];
    [self addSubview:activityIndicator];
    
//    Placeholder View
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, self.frame.size.height/2-20, self.frame.size.width-50, 20)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setTextColor:kGRAY_COLOR];
    [titleLabel setFont:[UIFont systemFontOfSize:22.0f]];
    titleLabel.alpha = 0.0f;
    [self addSubview:titleLabel];
    
    descriptionTextView = [[UITextView alloc] initWithFrame:CGRectMake(20, titleLabel.frame.size.height+titleLabel.frame.origin.y, self.frame.size.width-40, 10)];
    [descriptionTextView setTextColor:[kGRAY_COLOR colorWithAlphaComponent:0.7f]];
    [descriptionTextView setFont:[UIFont systemFontOfSize:16.0f]];
    [descriptionTextView setUserInteractionEnabled:NO];
    [descriptionTextView setBackgroundColor:[UIColor clearColor]];
    [descriptionTextView setTextAlignment:NSTextAlignmentCenter];
    [descriptionTextView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    CGFloat fixedWidth = descriptionTextView.frame.size.width;
    CGSize newSize = [descriptionTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = descriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    descriptionTextView.frame = newFrame;
    
    [self addSubview:descriptionTextView];
    [descriptionTextView layoutIfNeeded];
    
}

- (void)showLoadingView {
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
        loadingLabel.alpha = 1.0f;
        activityIndicator.alpha = 1.0f;
        [activityIndicator startAnimating];
        
        descriptionTextView.alpha = 0.0f;
        titleLabel.alpha = 0.0f;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)showViewWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle {
    titleLabel.text = title;
    descriptionTextView.text = subtitle;
    
    CGFloat fixedWidth = descriptionTextView.frame.size.width;
    CGSize newSize = [descriptionTextView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
    CGRect newFrame = descriptionTextView.frame;
    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
    descriptionTextView.frame = newFrame;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 1.0f;
        loadingLabel.alpha = 0.0f;
        activityIndicator.alpha = 0.0f;
        [activityIndicator stopAnimating];
        
        descriptionTextView.alpha = 1.0f;
        titleLabel.alpha = 1.0f;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0.0f;
        [activityIndicator stopAnimating];
    } completion:^(BOOL finished) {
        
    }];
}

@end
