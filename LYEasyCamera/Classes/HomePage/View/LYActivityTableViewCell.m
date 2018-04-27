//
//  LYActivityTableViewCell.m
//  LYEasyCamera
//
//  Created by CNFOL_iOS on 2018/4/27.
//  Copyright © 2018年 LYOUNG_iOS. All rights reserved.
//

#import "LYActivityTableViewCell.h"
#import "LYHomePageViewModel.h"
#import "LYActivityItemModel.h"

@interface LYActivityTableViewCell()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *categoryLab;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *addressLab;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation LYActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)bindViewModel:(id)viewModel withParams:(NSDictionary *)params
{
    LYHomePageViewModel *vModel = (LYHomePageViewModel *)viewModel;
    LYActivityItemModel *item = vModel.activityData[[params[DataIndex] integerValue]];
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:nil];
    self.categoryLab.text = item.category_name;
    self.titleLab.text = item.title;

    //时间
    NSRange beginRange = NSMakeRange (0, 10);
    NSString *beginTime = [item.begin_time substringWithRange:beginRange];
    NSRange endRange = NSMakeRange (0, 10);
    NSString *endTime = [item.end_time substringWithRange:endRange];
    NSString *timeString = [NSString stringWithFormat:@"时间: %@ ~ %@",beginTime,endTime];
    self.timeLab.text = timeString;
    
    NSMutableParagraphStyle *paragraphStyle2 = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle2 setLineSpacing:2];

    //地址
    NSString *finallyString = [item.address stringByReplacingOccurrencesOfString:item.loc_name withString:@""];
    NSString *addressString = [NSString stringWithFormat:@"地点:%@",finallyString];
    
    NSMutableAttributedString *attAddress = [[NSMutableAttributedString alloc] initWithString:addressString];
    [attAddress addAttribute:NSParagraphStyleAttributeName value:paragraphStyle2 range:NSMakeRange(0, [addressString length])];
    self.addressLab.attributedText = attAddress;
    
    self.addressLab.lineBreakMode = NSLineBreakByTruncatingTail;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    int magin = LYStatusCellMargin;
    int padding = 10;
    
    CGFloat w = SCREEN_WIDTH - 2*padding - magin - 80;
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 120));
        make.top.mas_equalTo(@(magin));
        make.left.mas_equalTo(@(padding));
    }];
    
    [self.categoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconView);
        make.left.equalTo(self.iconView.mas_right).offset(magin);
        make.width.mas_equalTo(@(w));
        make.height.mas_equalTo(@(20));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.categoryLab);
        make.top.mas_equalTo(self.categoryLab.mas_bottom).offset(padding);
        make.height.mas_equalTo(@20);
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.height.with.right.equalTo(self.categoryLab);
        make.top.equalTo(self.titleLab.mas_bottom).offset(padding);
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.with.right.equalTo(self.categoryLab);
        make.top.equalTo(self.timeLab.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-magin).with.priority(40);
    }];
    
    int offSet =  - 0.8;
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 1));
        make.left.mas_equalTo(@0);
        make.top.equalTo(self.contentView.mas_bottom).offset(offSet);
    }];
}

- (UIImageView *)iconView
{
    return LY_LAZY(_iconView, ({
        UIImageView *icon = [[UIImageView alloc] init];
        [self.contentView addSubview:icon];
        icon;
    }));
}
- (UILabel *)categoryLab
{
    return LY_LAZY(_categoryLab, ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = LYSystemFont(13);
        [self.contentView addSubview:label];
        label;
    }));
}
- (UILabel *)titleLab
{
    return LY_LAZY(_titleLab, ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor blackColor];
        label.font = LYSystemFont(17);
        [self.contentView addSubview:label];
        label;
    }));
}

- (UILabel *)timeLab
{
    return LY_LAZY(_timeLab, ({
        UILabel *label = [[UILabel alloc] init];
        label.textColor = [UIColor lightGrayColor];
        label.font = LYSystemFont(13);
        [self.contentView addSubview:label];
        label;
    }));
}
- (UILabel *)addressLab
{
    return LY_LAZY(_addressLab, ({
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 0;
        label.textColor = [UIColor lightGrayColor];
        label.font = LYSystemFont(13);
        [label sizeToFit];
        [self.contentView addSubview:label];
        label;
    }));
}
- (UIView *)lineView
{
    return LY_LAZY(_lineView, ({
        UIView *view = [[UIView alloc] init];
        view.backgroundColor =  LYColorWithHexStr(@"#F0F0F0");
        [self.contentView addSubview:view];
        view;
    }));
}

@end
