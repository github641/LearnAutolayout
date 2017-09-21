//
//  MASExampleLabelView.m
//  Masonry iOS Examples
//
//  Created by Jonas Budelmann on 24/10/13.
//  Copyright (c) 2013 Jonas Budelmann. All rights reserved.
//

#import "MASExampleLabelView.h"

static UIEdgeInsets const kPadding = {10, 10, 10, 10};

@interface MASExampleLabelView ()
@property (nonatomic, strong) UILabel *shortLabel;
@property (nonatomic, strong)UILabel *longLabel;

@end

@implementation MASExampleLabelView

- (id)init {
    self = [super init];
    if (!self) return nil;

    self.shortLabel = UILabel.new;
    self.shortLabel.numberOfLines = 1;
    self.shortLabel.textColor = [UIColor purpleColor];
    /* lzy170921注:StringDrawing.h 和NSParagraphStyle都有，但是表达的东西类似：
     
     
     NSLineBreakModeCharacterWrap,//以字符为单位换行，以字符为单位截断。
     NSLineBreakByCharWrapping;以字符为显示单位显示，后面部分省略不显示。
     NSLineBreakByClipping;剪切与文本宽度相同的内容长度，后半部分被删除。
     NSLineBreakByTruncatingHead;前面部分文字以……方式省略，显示尾部文字内容。
     NSLineBreakByTruncatingMiddle;中间的内容以……方式省略，显示头尾的文字内容。
     NSLineBreakByTruncatingTail;结尾部分的内容
     以……方式省略，显示头的文字内容。
     label.lineBreakMode = NSLineBreakByWordWrapping;以单词为显示单位显示，后面部分省略不显示。
     
     作者：猪队友小L
     链接：http://www.jianshu.com/p/de9429b7c68e
     來源：简书
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     
     // NSParagraphStyle
     typedef NS_ENUM(NSInteger, NSLineBreakMode) {
     NSLineBreakByWordWrapping = 0,     	// Wrap at word boundaries, default
     NSLineBreakByCharWrapping,		// Wrap at character boundaries
     NSLineBreakByClipping,		// Simply clip
     NSLineBreakByTruncatingHead,	// Truncate at head of line: "...wxyz"
     NSLineBreakByTruncatingTail,	// Truncate at tail of line: "abcd..."
     NSLineBreakByTruncatingMiddle	// Truncate middle of line:  "ab...yz"
     } NS_ENUM_AVAILABLE(10_0, 6_0);
     */
    self.shortLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.shortLabel.text = @"Bacon";
    [self addSubview:self.shortLabel];
    
    
    
    self.longLabel = UILabel.new;
    self.longLabel.numberOfLines = 8;
    self.longLabel.textColor = [UIColor darkGrayColor];
    self.longLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    
    self.longLabel.text = @"Bacon ipsum dolor sit amet spare ribs fatback kielbasa salami, tri-tip jowl pastrami flank short loin rump sirloin. Tenderloin frankfurter chicken biltong rump chuck filet mignon pork t-bone flank ham hock.";
    [self addSubview:self.longLabel];
    
    [self.longLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.left).insets(kPadding);
        make.top.equalTo(self.top).insets(kPadding);
    }];
    
    [self.shortLabel mas_makeConstraints:^(MASConstraintMaker *make){
        make.top.equalTo(self.longLabel.lastBaseline);
        make.right.equalTo(self.right).insets(kPadding);
    }];

    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // for multiline UILabel's you need set the preferredMaxLayoutWidth
    // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point
    // stay tuned for new easier way todo this coming soon to Masonry

    CGFloat width = CGRectGetMinX(self.shortLabel.frame) - kPadding.left;
    NSLog(@"%s self.shortLabel.frame:%@", __func__, NSStringFromCGRect(self.shortLabel.frame));
    NSLog(@"%s width:%f", __func__, width);
    
    width -= CGRectGetMinX(self.longLabel.frame);
    NSLog(@"%s self.longLabel.frame:%@", __func__, NSStringFromCGRect(self.longLabel.frame));
    
    NSLog(@"%s width:%f", __func__, width);

    self.longLabel.preferredMaxLayoutWidth = width;
    
    // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
    [super layoutSubviews];
    
}

@end
