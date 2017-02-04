//
//  GPDetailViewController.m
//  GPText
//
//  Created by dandan on 16/9/14.
//  Copyright © 2016年 dandan. All rights reserved.
//

#import "GPDetailViewController.h"
#import "GPContentView.h"
#import "GPContent.h"

@interface GPDetailViewController ()
@property (weak, nonatomic) IBOutlet GPContentView *contentStrView;

@end

@implementation GPDetailViewController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(linkDidSelected:) name:GPLinkDidSelectedNotification object:nil];
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)linkDidSelected:(NSNotification *)note
{
    NSString *linkText = note.userInfo[GPLinkText];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:linkText]];
}
#pragma mark - 加载数据
- (void)loadData
{
    NSString *dataStr = @"[来]http://www.jianshu.com/users/3e324b24a2a8/latest_articles[来]钱塘江浩浩江水，日日夜夜无穷无休的从临安牛家村边绕过，http://www.jianshu.com/users/3e324b24a2a8/latest_articles东流入海。江畔一排数十株乌柏树，叶子似火烧般红，正是八月天时。村前村后的野草刚起始变黄，一抹斜阳映照之下，更增了几分萧索。http://www.jianshu.com/users/3e324b24a2a8/latest_articles两株大松树下围着一堆村民，[泪][泪][泪][泪][泪][泪][泪]男男女女和十几个小孩，正自聚精会神的听着一个瘦削的老者说话。那说话人五十来岁年纪，[泪][泪][泪][泪][泪][泪][泪]一件青布长袍早洗得褪成了蓝灰色。http://www.jianshu.com/users/3e324b24a2a8/latest_articles[害羞][害羞][害羞]只听他两片梨花木板碰了几下，左手中竹棒在一面小羯鼓上敲起得得连声。唱道：小桃无主自开花，烟草茫茫带晚鸦。[害羞][害羞][害羞]几处败垣围故井，[害羞]向来一一是人家 [害羞][害羞][害羞]http://www.jianshu.com/users/3e324b24a2a8/latest_articles[害羞][害羞]";
    GPContent *content = [GPContent shopWithStr:dataStr];
    
    self.contentStrView.attributedText = content.arrtext;
}







@end
