// #pragma Definitions

#define settingsPath [NSHomeDirectory() stringByAppendingPathComponent:@"/Library/Preferences/com.samplasion.batterycustomizerprefs.plist"]
static void LOG(NSString *logged) {
  NSLog(@"[BatteryCustomizer] %@", logged);
}

NSMutableDictionary *prefs;
bool enabled;
bool chargingIndicator;
bool levelIndicator;
UIColor *batteryFill;
UIColor *batteryBody;
UIColor *batteryPin;
UIColor *percentageColor;

// #pragma Functions

static UIColor *hexToColor(NSString *hexString, NSString *fb) {
  unsigned rgbValue = 0;
  NSString *stringToProcess = hexString;
  if ([hexString length] == 0) stringToProcess = fb;
  NSScanner *scanner = [NSScanner scannerWithString:stringToProcess];
  if ([stringToProcess rangeOfString:@"#"].location == 0) [scanner setScanLocation:1]; // bypass '#' character
  [scanner scanHexInt:&rgbValue];
  return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

static void loadPrefs() {
  prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:settingsPath];
  enabled = [[prefs objectForKey:@"enabled"] boolValue];
  chargingIndicator = [[prefs objectForKey:@"chargingindicator"] boolValue];
  levelIndicator = [[prefs objectForKey:@"levelindicator"] boolValue];
  batteryFill = hexToColor([prefs objectForKey:@"batteryfill"], @"#e54040");
  batteryBody = hexToColor([prefs objectForKey:@"batterybody"], @"#ffff00");
  batteryPin = hexToColor([prefs objectForKey:@"batterypin"], @"#ffff00");
  percentageColor = hexToColor([prefs objectForKey:@"percentage"], @"#ff0000");
  [prefs release];
}

// #pragma Interfaces

@interface _UIStatusBarStringView : UILabel {}

@end

// #pragma Hooks

%hook _UIBatteryView

// #pragma - Full battery fill color
- (void)setFillColor:(UIColor *)color {
  if (enabled) {
    LOG(@"Fill");
    %orig(batteryFill);
  } else {
    %orig;
  }
}

// #pragma - Battery percentage shown in battery
- (void)setShowsPercentage:(BOOL)shows {
  if (enabled) {
    LOG(@"Inside Percentage");
    %orig(levelIndicator);
  } else {
    %orig;
  }
}

// #pragma - Battery pin color
- (void)setPinColor:(UIColor *)color {
  if (enabled) {
    LOG(@"Pin");
    %orig(batteryPin);
  } else {
    %orig;
  }
}

// #pragma - Battery body color
- (void)setBodyColor:(UIColor *)color {
  if (enabled) {
    LOG(@"Body");
    %orig(batteryBody);
  } else {
    %orig;
  }
}

// #pragma - Charging indicator
- (void)setShowsInlineChargingIndicator:(BOOL)shows {
  if (enabled) {
    LOG(@"Indicator");
    %orig(chargingIndicator);
  } else {
    %orig;
  }
}
%end

// #pragma - External battery percentage
%hook _UIStatusBarStringView

-(void)setTextColor:(UIColor *)color {
  if (enabled && [self.text hasSuffix:@"%"]) {
    LOG(@"Outside Percentage");
    %orig(percentageColor);
  } else {
    %orig;
  }
}

%end

%ctor {
  LOG(@"Started, loading preferences...");
  loadPrefs();
  LOG(@"Loaded preferences");
}
