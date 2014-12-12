//
//  DGFlatProgressBarView.m
//  DGFlatProgressBarView
//
//  Created by Daniel Cohen Gindi on 12/12/14.
//  Copyright (c) 2013 danielgindi@gmail.com. All rights reserved.
//
//  https://github.com/danielgindi/DGFlatProgressBarView
//
//  The MIT License (MIT)
//
//  Copyright (c) 2014 Daniel Cohen Gindi (danielgindi@gmail.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "DGFlatProgressBarView.h"

@implementation DGFlatProgressBarView

- (void)initialize_DGFlatProgressBarView
{
    _direction = DGFlatProgressBarViewDirectionLeftToRight;
    _progress = 0.f;
    _trackTintColor = [UIColor lightGrayColor];
    _progressTintColor = [UIColor colorWithRed:0/255.f green:125/255.f blue:244/255.f alpha:1];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self initialize_DGFlatProgressBarView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initialize_DGFlatProgressBarView];
    }
    return self;
}

- (void)setDirection:(DGFlatProgressBarViewDirection)direction
{
    _direction = direction;
    [self setNeedsDisplay];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    [self setNeedsDisplay];
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    _trackTintColor = trackTintColor;
    [self setNeedsDisplay];
}

- (void)setProgress:(float)progress
{
    _progress = MAX(MIN(progress, 1.f), 0.f);
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (_trackTintColor)
    {
        CGContextSetFillColorWithColor(ctx, _trackTintColor.CGColor);
        CGContextFillRect(ctx, rect);
    }
    
    if (_progressTintColor && _progress > 0.f)
    {
        CGRect progressRect;
        switch (_direction)
        {
            default:
            case DGFlatProgressBarViewDirectionLeftToRight:
            case DGFlatProgressBarViewDirectionRightToLeft:
                progressRect = (CGRect){rect.origin.x, rect.origin.y, rect.size.width * _progress, rect.size.height};
                
                if (_direction == DGFlatProgressBarViewDirectionRightToLeft)
                {
                    progressRect.origin.x += rect.size.width - progressRect.size.width;
                }
                break;
            case DGFlatProgressBarViewDirectionTopToBottom:
            case DGFlatProgressBarViewDirectionBottomToTop:
                progressRect = (CGRect){rect.origin.x, rect.origin.y, rect.size.width, rect.size.height * _progress};
                
                if (_direction == DGFlatProgressBarViewDirectionBottomToTop)
                {
                    progressRect.origin.y += rect.size.height - progressRect.size.height;
                }
                break;
        }
        
        CGContextSetFillColorWithColor(ctx, _progressTintColor.CGColor);
        CGContextFillRect(ctx, progressRect);
    }
}

@end
