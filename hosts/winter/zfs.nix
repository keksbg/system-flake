{ config, ...}: {
    services.zfs = {
	trim.enable = true;
	autoScrub.enable = true;
	autoScrub.pools = [ "rpool" ];
	autoSnapshot = {
	    enable = true;
	    frequent = 4;
	    monthly = 1;
	};
    };
}
