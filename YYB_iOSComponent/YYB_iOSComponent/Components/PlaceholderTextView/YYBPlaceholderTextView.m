//
//  YYBPlaceholderTextView.m
//  YYB_iOSComponent
//
//  Created by Sniper on 2018/8/6.
//  Copyright © 2018年 Univease Co., Ltd All rights reserved.
//

#import "YYBPlaceholderTextView.h"

@implementation YYBPlaceholderTextView

- (instancetype)init {
    self = [super init];
    if (!self) return nil;
    
    self.placeHolderTextAlignment = NSTextAlignmentLeft;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    return self;
}

- (void)textDidChanged:(UITextView *)textView {
    [self setNeedsDisplay];
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    _placeHolder = placeHolder;
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if (!self.placeHolder) {
        return;
    }
    
    if (self.text.length > 0) {
        return;
    }
    
    NSDictionary *placeholderAttribute = @{NSForegroundColorAttributeName:[[UIColor blackColor] colorWithAlphaComponent:0.4f],
                                           NSFontAttributeName:[UIFont systemFontOfSize:15]};
    if (self.placeHolderTextAttributes) {
        placeholderAttribute = self.placeHolderTextAttributes;
    }
    
    CGSize placeholderSize = [self.placeHolder boundingRectWithSize:CGSizeMake(CGRectGetWidth(self.frame) - self.textContainerInset.left - self.textContainerInset.right, MAXFLOAT)
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:placeholderAttribute
                                                            context:nil].size;
    CGRect frame = CGRectZero;
    switch (self.placeHolderTextAlignment) {
        case NSTextAlignmentCenter:{
            frame = CGRectMake((CGRectGetWidth(self.frame) - placeholderSize.width) / 2,
                               self.textContainerInset.top,
                               placeholderSize.width,
                               placeholderSize.height);
        }
            break;
        case NSTextAlignmentLeft:{
            frame = CGRectMake(self.textContainerInset.left + 3,
                               self.textContainerInset.top,
                               placeholderSize.width,
                               placeholderSize.height);
        }
            break;
        case NSTextAlignmentRight:{
            frame = CGRectMake(CGRectGetWidth(self.frame) - self.textContainerInset.left - placeholderSize.width,
                               self.textContainerInset.top,
                               placeholderSize.width,
                               placeholderSize.height);
        }
            break;
        default:
            break;
    }
    
    [self.placeHolder drawInRect:frame
                  withAttributes:placeholderAttribute];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
