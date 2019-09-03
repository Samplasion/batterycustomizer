static UIColor *hexToColor(NSString *hexString, NSString *fb) {
  unsigned rgbValue = 0;
  NSString *stringToProcess = hexString;
  if ([hexString length] == 0) stringToProcess = fb;
  NSScanner *scanner = [NSScanner scannerWithString:stringToProcess];
  if ([stringToProcess rangeOfString:@"#"].location == 0) [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

@interface PSTableCell : UITableViewCell
@end
@interface PSControlTableCell : PSTableCell
- (UIControl *)control;
@end
@interface PSSwitchTableCell : PSControlTableCell
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier;
@end

@interface BCPSwitchTableCell : PSSwitchTableCell
@end

@implementation BCPSwitchTableCell

-(id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier { //init method
	self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier]; //call the super init method
	if (self) {
		[((UISwitch *)[self control]) setOnTintColor:hexToColor(@"#C44040", nil)]; //change the switch color
	}
	return self;
}

@end