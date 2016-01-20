//
//  SpecialListTableViewCell.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/15.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "SpecialListTableViewCell.h"

@implementation SpecialListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        //图片
        self.titelImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 130)];
        self.titelImageView.image = [UIImage imageNamed:@"upload"];
        [self.contentView addSubview:self.titelImageView];
        
        //天
        self.dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 140, 30, 20)];
        self.dayLabel.text = @"20";
        [self.contentView addSubview:self.dayLabel];
        
        //日期线
        UIImageView * lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(45, 130, 20, 70)];
        lineImageView.image = [UIImage imageNamed:@"time_line_bg"];
        [self.contentView addSubview:lineImageView];
        
        //星期
        self.weekLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 133, 50, 20)];
        self.weekLabel.font = [UIFont systemFontOfSize:12];
        self.weekLabel.text = @"星期四";
        [self.contentView addSubview:self.weekLabel];
        
        //日期
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 160, 70, 20)];
        self.dateLabel.font = [UIFont systemFontOfSize:12];
        self.dateLabel.text = @"2015-8-20";
        [self.contentView addSubview:self.dateLabel];
        
        //大标题
        self.bigTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(150, 140, 200, 20)];
        self.bigTitleLabel.text = @"内衣拯救女大单";
        self.bigTitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.bigTitleLabel];
        
        //小标题
        self.littleTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 183, 200, 10)];
        self.littleTitleLabel.font = [UIFont systemFontOfSize:12];
        self.littleTitleLabel.textColor = [UIColor lightGrayColor];
        self.littleTitleLabel.text = @"内衣拯救女大单";
        [self.contentView addSubview:self.littleTitleLabel];
        
        
    
        
        
        
        
        
    }
    
    
    return self;
}

@end
