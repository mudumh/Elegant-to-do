//
//  SHCSelectThemeViewController.m
//  ClearStyle
//
//  Created by Harsha Vardhan on 6/30/13.
//  Copyright (c) 2013 RookSoft Pte. Ltd. All rights reserved.
//

#import "SHCSelectThemeViewController.h"
#import "FUIButton.h"
#import "SHCToDoStore.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import "UINavigationBar+FlatUI.h"
#import <QuartzCore/QuartzCore.h>

@interface SHCSelectThemeViewController ()

@property (weak, nonatomic) IBOutlet FUIButton *backButoon;



@property(weak,nonatomic) UIColor * buttonColor;
@property(weak,nonatomic) UIColor * navigationbarColor;


@end

@implementation SHCSelectThemeViewController
{

    CAGradientLayer* _gradientLayer;
}
@synthesize navigationBar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
         self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tableviewBackground.png"]];
        [self configureThemes];
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated
{
    
    [self configureThemes];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellTheme"];
    [super viewWillAppear:YES];
}

-(void)configureThemes
{
    
    [self setButtonColor:[[[SHCToDoStore sharedStore] loadThemeProps] buttonColor]];
    
    [self setNavigationbarColor:[[[SHCToDoStore sharedStore] loadThemeProps] navigationBarColor]];
    self.backButoon.buttonColor = [self buttonColor];
    self.backButoon.shadowColor = [self buttonColor];
    self.backButoon.shadowHeight = 3.0f;
    self.backButoon.cornerRadius = 6.0f;
    self.backButoon.titleLabel.font = [UIFont fontWithName:@"GillSans-Italic" size:16];
    [self.backButoon setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [self.backButoon setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
        
    
    
    [self.navigationBar configureFlatNavigationBarWithColor:[self navigationbarColor]];

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)carrotButtonPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor carrotColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor carrotColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor carrotColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)greenSeaPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor greenSeaColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor greenSeaColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor greenSeaColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)asphaltPressed {
    
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor wetAsphaltColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor wetAsphaltColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor midnightBlueColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)blackandwhitePressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[[UIColor blackColor ] colorWithAlphaComponent:0.7]];
        
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor blackColor]];
    
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1.0]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
    
}

- (IBAction)backButtonPressed {
[[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)wisteriaButtonPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor wisteriaColor]];

    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor wisteriaColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor wisteriaColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)alazarinPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor alizarinColor]];
    
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor alizarinColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor alizarinColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor whiteColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (IBAction)sunFlowerButtonPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor sunflowerColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor sunflowerColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor blackColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor sunflowerColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(IBAction)silverPressed
{
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor silverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor silverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor blackColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor silverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];


}

- (IBAction)emeraldButtonPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor emerlandColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor emerlandColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor blackColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor emerlandColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
    

}

-(void)tequilaPressed
{
    UIColor* tequila =    [UIColor colorWithRed:144/255.0 green:101/255.0 blue:121/255.0 alpha:1];
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor: tequila];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor: tequila];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor blackColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:tequila];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
    
    
}

-(void)greenYellowPressed
{

    UIColor *greenYellow = [UIColor colorWithRed:151/255.0 green:179/255.0 blue:146/255.0 alpha:1];
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:greenYellow];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor: greenYellow];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor blackColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor: greenYellow];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];

}
- (IBAction)peterRiverPressed {
    
    [[[SHCToDoStore sharedStore] themeModel] setButtonColor:[UIColor peterRiverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setCellbackgroundColor:[UIColor peterRiverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setFontColor:[UIColor whiteColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarColor:[UIColor peterRiverColor]];
    [[[SHCToDoStore sharedStore] themeModel] setNavigationBarTitleColor:[UIColor blackColor]];
    [[SHCToDoStore sharedStore] saveChangesForTheme];
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:nil];
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellTheme"];

 
    
    return cell;


}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section


{
    return 12;

}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIFont * marion = [UIFont fontWithName:@"Marion-Italic" size:18];
    cell.textLabel.font = marion;
    
    _gradientLayer = [CAGradientLayer layer];
    _gradientLayer.frame = cell.bounds;
    _gradientLayer.colors = @[(id)[[UIColor colorWithWhite:1.0f alpha:0.2f] CGColor],
                              (id)[[UIColor colorWithWhite:1.0f alpha:0.1f] CGColor],
                              (id)[[UIColor clearColor] CGColor],
                              (id)[[UIColor colorWithWhite:0.0f alpha:0.1f] CGColor]];
    _gradientLayer.locations = @[@0.00f, @0.01f, @0.95f, @1.00f];
     [cell.layer insertSublayer:_gradientLayer atIndex:0];

    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text= @"Green Sea";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor greenSeaColor];
            break;
        case 1:
            
            cell.textLabel.text= @"Wet asphalt";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor wetAsphaltColor];
            break;
            
        case 2:
            cell.textLabel.text= @"Black and White";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor blackColor];
            break;
            
        case 3:
            cell.textLabel.text= @"Carrot";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor carrotColor];
            break;
            
            
        case 4:
            cell.textLabel.text= @"Wisteria";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor wisteriaColor];
            break;
            
        case 5:
            cell.textLabel.text= @"Sunflower";
            cell.textLabel.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor sunflowerColor];
            break;
            
        case 6:
            
            cell.textLabel.text= @"Emerald";
            cell.textLabel.textColor = [UIColor blackColor];
            
            cell.backgroundColor = [UIColor emerlandColor];
            break;
            
        case 7:
            cell.textLabel.text= @"Peter River";
            cell.textLabel.textColor = [UIColor blackColor];
            cell.backgroundColor = [UIColor peterRiverColor];
            break;
            
            
        case 8:
            cell.textLabel.text= @"Alizarin";
            cell.textLabel.textColor = [UIColor whiteColor];
            cell.backgroundColor = [UIColor alizarinColor];
            break;
        case 9:
            cell.textLabel.text= @"Green Yellow";
            cell.textLabel.textColor =[UIColor blackColor];
            cell.backgroundColor = [UIColor colorWithRed:151/255.0 green:179/255.0 blue:146/255.0 alpha:1];
            break;
            
        case 10:
            cell.textLabel.text= @"Silver";
            cell.textLabel.textColor =[UIColor blackColor];
            cell.backgroundColor = [UIColor silverColor];
            break;
            
        case 11:
            cell.textLabel.text= @"Tequila";
            cell.textLabel.textColor =[UIColor blackColor];
            cell.backgroundColor = [UIColor colorWithRed:144/255.0 green:101/255.0 blue:121/255.0 alpha:1];
            break;
            
        default:
            break;
    }
    


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch ([indexPath row]) {
        case 0:
            [self greenSeaPressed];
            break;
        case 1:
            
            [self asphaltPressed];
            break;
        case 2:
            [self blackandwhitePressed];
            break;
            
        case 3:
            [self carrotButtonPressed];
            break;
            
            
        case 4:
            [self wisteriaButtonPressed];
            break;
            
        case 5:
            [self sunFlowerButtonPressed];
            break;
            
        case 6:
            [self emeraldButtonPressed];
            break;
            
        case 7:
            [self peterRiverPressed];
            break;
        case 8:
            [self alazarinPressed];
            break;
            
        case 9 :
            [self greenYellowPressed];
            break;
            
        case 10 :
            [self silverPressed];
            break;
            
        case 11 :
            [self tequilaPressed];
            break;
        default:
            break;
    }


}

@end
