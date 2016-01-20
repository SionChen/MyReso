//
//  SubCollectViewController.m
//  TaoTaoShopping
//
//  Created by 晓 on 15/12/13.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "SubCollectViewController.h"
#import <UIImageView+AFNetworking.h>
#import "HomeCustomCollectionViewCell.h"
#import "RequetTool.h"
#import <MJRefresh.h>
#import "WebViewController.h"

@interface SubCollectViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,RequestDelegate>

@end
static NSString * cell_id = @"SUB_CELL";


@implementation SubCollectViewController
{
    
    
    //collectionView
    UICollectionView * _collectionView;
    
    //数据源
    NSMutableArray * _dataArray;
    
    //请求类
    RequetTool * _requestTool;
    
    //加载图
    UIImageView * _loadImageView;
    
    NSTimer * _timer;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back1"] style:UIBarButtonItemStylePlain target:self action:@selector(barBackButton)];
    self.navigationItem.leftBarButtonItem.imageInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    _dataArray = [NSMutableArray array];
    
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate = self;
    [NSTimer scheduledTimerWithTimeInterval:0.005 target:self selector:@selector(startAnimation) userInfo:nil repeats:YES];
    
    
    [self getCollectionView];
    [self getHeader];
    [self createLoadView];
    
    [_collectionView.header beginRefreshing];
    [self getData];

}

-(void)startAnimation
{
    [UIView animateWithDuration:0.5 animations:^{
        _loadImageView.transform =  CGAffineTransformRotate(_loadImageView.transform, M_PI_4/4);
    }];
}
-(void)createLoadView
{
    _loadImageView = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-40)/2, 200, 40, 40)];
    _loadImageView.image = [UIImage imageNamed:@"newLoading"];
    [self.view addSubview:_loadImageView];
    
}

#pragma mark getData
-(void)getData
{
    //_loadImageView.hidden = NO;
    [_requestTool requestWithUrlString:self.urlString andName:@"MainCollection"];
}


-(void)getDataWithDictionary:(NSDictionary *)dataDict andName:(NSString *)name
{
    
    [_dataArray removeAllObjects];
    NSArray * arr = dataDict[@"list"];
    if ([self.headTitle isEqualToString:@"试试手气"]) {
        arr = dataDict[@"data"];
    }
    for (NSDictionary * dict in arr) {
        [_dataArray addObject:dict];
    }
    //结束刷新
    [_collectionView.mj_header endRefreshing];
    //隐藏刷新图片
    _loadImageView.hidden = YES;
    NSLog(@"%d",[dataDict[@"list"] count]);
    NSLog(@"count :%d",_dataArray.count);
    NSLog(@"%@",dataDict);
    [_collectionView reloadData];
}

-(void)getCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-15)/2-7, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 3, WIDTH , HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];

    [_collectionView registerClass:[HomeCustomCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
    [self.view addSubview:_collectionView];

}

#pragma mark UICollectionDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }
    
    return 0;
}
-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    
    if (_dataArray.count>indexPath.row) {
        NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:dict[@"pic_url"]]];
        cell.orPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"origin_price"]];
        cell.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"now_price"]];
        cell.mainLabel.text = dict[@"title"];
        [cell.collectButton setTitle:[NSString stringWithFormat:@"%@",dict[@"total_love_number"]] forState:UIControlStateNormal];
        if ([self.headTitle isEqualToString:@"明日抢"]) {
            cell.collectButton.hidden = YES;
            cell.similarButton.hidden = YES;
        }
        
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * webVC = [[WebViewController alloc] initWithUrlString:[NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?id=%@&sche=fenjiujiu",[_dataArray objectAtIndex:indexPath.row][@"num_iid"]]];
    //webVC.isDrawer = _isD;
    [self.navigationController pushViewController:webVC animated:YES];
    
    NSLog(@"collectionView :%d",indexPath.row);
}



-(void)barBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getHeader
{
    //自定义头视图
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 110, 44)];
    headerView.backgroundColor = [UIColor clearColor];
    
    //头视图的图片
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 7, 30, 30)];
    //设置图片圆形
    imageView.layer.cornerRadius =imageView.frame.size.width/2;
    imageView.clipsToBounds = YES;

    //imageView.backgroundColor = [UIColor whiteColor];
    if (self.headerImage) {
        imageView.image = self.headerImage;
    }
    [headerView addSubview:imageView];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(45, 11, 70, 20)];
    label.text = self.headTitle;
    [headerView addSubview:label];
    
    [self.navigationItem setTitleView:headerView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
