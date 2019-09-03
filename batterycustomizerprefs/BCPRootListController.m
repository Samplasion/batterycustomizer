#include "BCPRootListController.h"
#include "BCPSwitchTableCell.m"

#define SHARED_APP [UIApplication sharedApplication]

@implementation BCPRootListController

-(NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

-(void)save {
    [self.view endEditing:YES];
}

-(void)github {
    [SHARED_APP openURL:[NSURL URLWithString:@"https://github.com/Samplasion/BatteryCustomizer"]];
}

-(void)twitter {
  if([SHARED_APP canOpenURL:[NSURL URLWithString:@"twitter://"]]){
    [SHARED_APP openURL:[NSURL URLWithString:@"twitter://user?user_id=939144478622875648"]];
  }else{
    [SHARED_APP openURL:[NSURL URLWithString:@"https://www.twitter.com/Samplasion"]];
  }
}

-(void)respring {
	[self save];

	pid_t pid;
    const char* args[] = {"killall", "backboardd", NULL};
    posix_spawn(&pid, "/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
}

@end