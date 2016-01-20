//
//  HomeViewController.m
//  TaoTaoShopping
///Users/chenyongxiao/Desktop/TaoTaoShopping/TaoTaoShopping/ZBarSDK/zbar.h
//  Created by 晓 on 15/12/10.
//  Copyright © 2015年 陈泳晓. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeCustomHeaderView.h"
#import "RequetTool.h"
#import <UIImageView+AFNetworking.h>
#import "WebViewController.h"
#import "HomeCustomCollectionViewCell.h"
#import "DrawerView.h"
#import <MJRefresh.h>
#import "SubCollectViewController.h"

@interface HomeViewController ()<RequestDelegate,ImagesScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>

@end

static NSString *cell_id = @"HOME_CELL";
static NSString *header_id = @"HOME_HEADER";
@implementation HomeViewController
{
    //主tableview
    UITableView * _tableView;
    //装载透视图scrollview图片的数组
    NSMutableArray * _scrollArray;

    //头视图url数组
    NSArray * _headerUrlArray;
    
    //CollectionView
    UICollectionView * _collectionView;
    //是否第一次加载
    BOOL * _isNoFirst;
    //cell数据源
    NSMutableArray * _dataArray;
    //抽屉View
    DrawerView * _drawerView;
    //记录抽屉是否打开
    BOOL _isDrawer;
    //请求类
    RequetTool * _requestTool;
    //是否打开过抽屉
    BOOL _isD;
    
}
-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _dataArray = [NSMutableArray array];
    _scrollArray = [NSMutableArray array];
    
    //[self getLocalData];
    self.navigationItem.title = @"淘淘购";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    //抽屉按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"category-button"] forState:UIControlStateNormal];
    rightButton.frame = CGRectMake(0, 0, 40, 40);
    [rightButton addTarget:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    
    
    _requestTool = [[RequetTool alloc] init];
    _requestTool.delegate =self;
    
    [self createCollectionView];
    [_collectionView.header beginRefreshing];
    
    //抽屉VIew
    _drawerView = [[DrawerView alloc] initWithFrame:CGRectMake(WIDTH, 0, 0, HEIGHT)];
    _drawerView.tableView.delegate = self;
    _drawerView.tableView.dataSource =self;
    _drawerView.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:_drawerView];
    
    UIPanGestureRecognizer * _panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGesture:)];
    _panGesture.delegate = self;
    [self.view addGestureRecognizer:_panGesture];

    [self RequestData];
    _tableView.hidden = YES;
    
    //111111
    
    
    
    
}
//本地
-(void)getLocalData
{
    NSArray * scroll = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeScrollArray"];
    NSArray * data = [[NSUserDefaults standardUserDefaults] objectForKey:@"HomeDataArray"];
    for (NSDictionary * dict in scroll) {
        [_scrollArray addObject:dict];
        
    }
    for (NSDictionary * dict in data) {
        [_dataArray addObject:dict];
    }
}
#pragma mark UIGestureRecognizerDelegate

//手势抽屉
-(void)panGesture:(UIPanGestureRecognizer *)gesture
{
    _isD = YES;
    //获取手势在self.view的偏移量
    CGPoint piont = [gesture translationInView:self.view];
    
    //判断手势的结束状态
    if (gesture.state == UIGestureRecognizerStateEnded) {
        
        if (piont.x<= -75) {
            //开抽屉
            _collectionView.frame = CGRectMake(_collectionView.frame.origin.x, 0, WIDTH, HEIGHT);
            CGRect frame = self.navigationController.navigationBar.frame;
            self.navigationController.navigationBar.frame = CGRectMake(frame.origin.x, 0, WIDTH, 64);
            [UIView animateWithDuration:0.1 animations:^{
                _drawerView.frame = CGRectMake(WIDTH-150, 0, 150, HEIGHT);
                _collectionView.frame = CGRectMake(-150, 0, WIDTH, HEIGHT);
                self.navigationController.navigationBar.frame = CGRectMake(-150, 0, WIDTH, 64);
            }];
            _isDrawer = YES;
            
        }
        if (piont.x>=-75) {
            //关抽屉
            [UIView animateWithDuration:0.5 animations:^{
                _drawerView.frame = CGRectMake(WIDTH, 0, 150, HEIGHT);
                _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
                self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);
            }];
            _isDrawer = NO;
        }

    }else //随着手势滑动而滑动
    {
        
        if (_isDrawer == NO) {
            //初试状态为关，向左滑动
            if (piont.x>=-150&&piont.x<=0) {
                [UIView animateWithDuration:0 animations:^{
                    _drawerView.frame = CGRectMake(WIDTH+piont.x, 0, 150, HEIGHT);
                    _collectionView.frame = CGRectMake(piont.x, 0, WIDTH, HEIGHT);
                    self.navigationController.navigationBar.frame = CGRectMake(piont.x, 0, WIDTH, 64);
                }];        }

        }
        else
        {
            //初试状态为开,向右滑动
            if (piont.x>0&&piont.x<150) {
                [UIView animateWithDuration:0 animations:^{
                    _drawerView.frame = CGRectMake(WIDTH-150+piont.x, 0, 150, HEIGHT);
                    _collectionView.frame = CGRectMake(-150+piont.x, 0, WIDTH, HEIGHT);
                    self.navigationController.navigationBar.frame = CGRectMake(-150+piont.x, 0, WIDTH, 64);
                }];

            }
        }
    }
    
}



-(void)rightButtonClick
{
    _isD = YES;
    _isDrawer = !_isDrawer;
    if (_isDrawer) {
        _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);

        [UIView animateWithDuration:0.5 animations:^{
            _drawerView.frame = CGRectMake(WIDTH-150, 0, 150, HEIGHT);
            _collectionView.frame = CGRectMake(-150, 0, WIDTH, HEIGHT);
            self.navigationController.navigationBar.frame = CGRectMake(-150, 0, WIDTH, 64);
        }];
        
    }else
    {
        [UIView animateWithDuration:0.5 animations:^{
            _drawerView.frame = CGRectMake(WIDTH, 0, 150, HEIGHT);
            _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);
        }];

    }
    
}


-(void)createCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake((WIDTH-15)/2-7, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //调行间距
    [flowLayout setMinimumLineSpacing:5];
    //调列间距
    [flowLayout setMinimumInteritemSpacing:5];
    [flowLayout setSectionInset:UIEdgeInsetsMake(0, 10, 0, 10)];
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH , HEIGHT) collectionViewLayout:flowLayout];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate =self;
    _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self RequestData];
    }];
    [_collectionView registerClass:[HomeCustomHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_id];
    [_collectionView registerClass:[HomeCustomCollectionViewCell class] forCellWithReuseIdentifier:cell_id];
    [self.view addSubview:_collectionView];


}

#pragma mark Request

-(void)RequestData
{
    
    [_requestTool requestWithUrlString:@"http://cloud.repaiapp.com/yunying/spzt.php?id=9&app_id=2402388976&app_oid=98a723d3f348b24c85251584250c379e586a851c&app_version=2.1&app_channel=appstore&sche=fenjiujiu" andName:@"scroll"];
    [_requestTool requestWithUrlString:@"http://zhekou.repai.com/lws/wangyu/index.php?control=babynews&model=index3&app_id=2402388976&app_oid=98a723d3f348b24c85251584250c379e586a851c&app_version=1.1&app_channel=appstore&cid=0" andName:@"cell"];
    
}

-(void)getDataWithDictionary:(NSDictionary *)dataDict  andName:(NSString *)name
{
    if ([name isEqualToString:@"scroll"]) {
        [_scrollArray removeAllObjects];
        NSArray *arr = dataDict[@"data"];
        for (NSDictionary * dict in arr) {
            [_scrollArray addObject:dict];
        }
    }
    if ([name isEqualToString:@"cell"]) {
        [_dataArray removeAllObjects];
        NSArray * arr = dataDict[@"list"];
        for (NSDictionary * dict in arr) {
            [_dataArray addObject:dict];
        }
    }
    [_collectionView.mj_header endRefreshing];
    NSUserDefaults * users = [NSUserDefaults standardUserDefaults];
    [users setObject:_scrollArray forKey:@"HomeScrollArray"];
    [users setObject:_dataArray forKey:@"HomeDataArray"];
    [users synchronize];
    
    [_collectionView reloadData];
    
    
}



#pragma mark UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_dataArray.count>0) {
        return _dataArray.count;
    }
    
    return 4;
}
-(UICollectionViewCell * )collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeCustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cell_id forIndexPath:indexPath];
    
    if (_dataArray.count>indexPath.row) {
        NSDictionary * dict = [_dataArray objectAtIndex:indexPath.row];
        
        [cell.titleImageView setImageWithURL:[NSURL URLWithString:dict[@"pic_url"]] placeholderImage:[UIImage imageNamed:@"upload"]];
        cell.orPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"origin_price"]];
        cell.nowPriceLabel.text = [NSString stringWithFormat:@"￥%@",dict[@"now_price"]];
        cell.mainLabel.text = dict[@"title"];
        [cell.collectButton setTitle:[NSString stringWithFormat:@"%@",dict[@"total_love_number"]] forState:UIControlStateNormal];
        
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WebViewController * webVC = [[WebViewController alloc] initWithUrlString:[NSString stringWithFormat:@"http://h5.m.taobao.com/awp/core/detail.htm?id=%@&sche=fenjiujiu",[_dataArray objectAtIndex:indexPath.row][@"num_iid"]]];
    webVC.isDrawer = _isD;
    [self.navigationController pushViewController:webVC animated:YES];
    
    NSLog(@"collectionView :%d",indexPath.row);
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    HomeCustomHeaderView * headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:header_id forIndexPath:indexPath];
    
    _headerUrlArray = headerView.urlArray;
        //NSLog(@"%@   ***%@",headerView.controlArray,_headerUrlArray);
        headerView.scrollView.delegate = self;
        [headerView.scrollView reloadData];
        headerView.block = ^(NSInteger index){
            if (index<4) {
                WebViewController * webVC = [[WebViewController alloc] initWithUrlString:[_headerUrlArray objectAtIndex:index]];
                webVC.isDrawer = _isD;
                //self.navigationController.navigationBar.frame = CGRectMake(0,20, WIDTH, 44);
                [self.navigationController pushViewController:webVC animated:YES];
            }
            else
            {
                //这里写最后四个按钮的响应事件
                SubCollectViewController * svc = [[SubCollectViewController alloc] init];
                svc.isDrawer = _isD;
                switch (index) {
                    case 4:
                        svc.headTitle = @"都在买";
                        svc.urlString = @"http://zhekou.repai.com/lws/model/paiming.php?lei=jkj";
                        break;
                    case 5:
                        svc.headTitle = @"值得买";
                        svc.urlString = @"http://jkjby.yijia.com/jkjby/view/tmzk19_9_api.php?cid=0";
                        break;
                    case 6:
                        svc.headTitle = @"明日抢";
                        svc.urlString = @"http://jkjby.yijia.com/jkjby/view/tomorrow_api.php?app_id=2402388976&app_oid=98a723d3f348b24c85251584250c379e586a851c&app_version=1.1&app_channel=appstore";
                        break;
                    case 7:
                        svc.headTitle = @"试试手气";
                        svc.urlString = @"http://m.repai.com/search/search_items_api/query/%E6%89%8B%E6%9C%BA%E5%A3%B3/offset/0/limit/130/price_start/0/price_end/80/appkey/100022/app_id/2402388976";
                        break;
                    default:
                        break;
                }
                [self.navigationController pushViewController:svc animated:YES];
            }
            
        };

    
    return headerView;
}
#pragma mark UICollectionViewDelegateFlowLayout

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    return CGSizeMake(WIDTH, 260);
}

#pragma mark ImagesScrollViewDelegate
- (NSInteger)numberOfImagesInImagesScrollView:(ImagesScrollView *)imagesScrollView
{
    if (_scrollArray.count>0) {
        return _scrollArray.count;
    }
    
    return 0;
}
- (NSString *)imagesScrollView:(ImagesScrollView *)imagesScrollView imageUrlStringWithIndex:(NSInteger)index
{
    if (_scrollArray.count>0) {
        return [_scrollArray objectAtIndex:index][@"iphoneimg"];
    }
        
    
    return nil;
}
-(void)imagesScrollView:(ImagesScrollView *)imagesScrollView didSelectIndex:(NSInteger)index
{
    WebViewController * webVC = [[WebViewController alloc] initWithUrlString:[_scrollArray objectAtIndex:index][@"link"]];
    webVC.isDrawer = _isD;
    [self.navigationController pushViewController:webVC animated:YES];
}


#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 11;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL" ];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    if (indexPath.row%2==0) {
        cell.backgroundView= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"classBac"]];
    }else
    {
        cell.backgroundColor = [UIColor whiteColor];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.imageView setImageWithURL:[NSURL URLWithString:[_drawerView.urlArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"ok"]];
    cell.textLabel.text = [_drawerView.nameArray objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (HEIGHT-110)/11;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView * headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 150, 64)];
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 35, 90, 20)];
    titleLabel.text = @"商品类目";
    [headerView addSubview:titleLabel];

    return headerView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [UIView animateWithDuration:0.5 animations:^{
            _drawerView.frame = CGRectMake(WIDTH, 0, 150, HEIGHT);
            _collectionView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
            self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);
        }];
        _isDrawer = NO;

    }else
    {
        SubCollectViewController * svc = [[SubCollectViewController alloc] init];
        svc.isDrawer = _isD;
        _drawerView.frame = CGRectMake(WIDTH, 0, 150, HEIGHT);
        _collectionView.frame = CGRectMake(0, -20, WIDTH, HEIGHT);
        self.navigationController.navigationBar.frame = CGRectMake(0, 0, WIDTH, 64);
        
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        
        svc.headTitle =  cell.textLabel.text;
        svc.urlString = [NSString stringWithFormat:@"http://zhekou.repai.com/lws/wangyu/index.php?control=babynews&model=index3&app_id=2402388976&app_oid=98a723d3f348b24c85251584250c379e586a851c&app_version=1.1&app_channel=appstore&cid=%d",indexPath.row];
        svc.headerImage = cell.imageView.image;
        [self.navigationController pushViewController:svc animated:YES];

        
    }
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
