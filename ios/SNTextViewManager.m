//
//  SNTextViewManager.m
//  SNTextView
//
//  Created by mo on 9/25/17.
//  Copyright © 2017 standardnotes. All rights reserved.
//

#import "SNTextViewManager.h"
#import "SNTextView.h"
#import <React/RCTFont.h>

@implementation SNTextViewManager
{
    SNTextView *_textView;
}

RCT_EXPORT_MODULE()
RCT_EXPORT_VIEW_PROPERTY(text, NSString)
RCT_EXPORT_VIEW_PROPERTY(onChangeText, RCTBubblingEventBlock)
RCT_REMAP_VIEW_PROPERTY(keyboardDismissMode, keyboardDismissMode, UIScrollViewKeyboardDismissMode)
RCT_REMAP_VIEW_PROPERTY(keyboardAppearance, keyboardAppearance, UIKeyboardAppearance)
RCT_REMAP_VIEW_PROPERTY(editable, editable, BOOL)
RCT_REMAP_VIEW_PROPERTY(color, textColor, UIColor)
RCT_REMAP_VIEW_PROPERTY(selectionColor, tintColor, UIColor)
RCT_EXPORT_VIEW_PROPERTY(paddingTop, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(paddingRight, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(paddingBottom, CGFloat)
RCT_EXPORT_VIEW_PROPERTY(paddingLeft, CGFloat)

- (UIView *)view
{
    _textView = [[SNTextView alloc] init];
    _textView.delegate = self;

    return _textView;
}

RCT_EXPORT_METHOD(blur:(nonnull NSNumber *)node)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_textView resignFirstResponder];
    });
}

RCT_EXPORT_METHOD(focus:(nonnull NSNumber *)node)
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_textView becomeFirstResponder];
    });
}

RCT_CUSTOM_VIEW_PROPERTY(fontSize, NSNumber, SNTextView)
{
    view.font = [RCTFont updateFont:view.font withSize:json ?: @(defaultView.font.pointSize)];
}
RCT_CUSTOM_VIEW_PROPERTY(fontWeight, NSString, __unused SNTextView)
{
    view.font = [RCTFont updateFont:view.font withWeight:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontStyle, NSString, __unused SNTextView)
{
    view.font = [RCTFont updateFont:view.font withStyle:json]; // defaults to normal
}
RCT_CUSTOM_VIEW_PROPERTY(fontFamily, NSString, SNTextView)
{
    view.font = [RCTFont updateFont:view.font withFamily:json ?: defaultView.font.familyName];
}

# pragma Text View Delegate

- (void)textViewDidBeginEditing:(UITextView *)textView {

}

- (void)textViewDidChange:(SNTextView *)textView
{
    textView.onChangeText(@{@"text" : textView.text});
}

@end
