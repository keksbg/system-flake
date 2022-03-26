{ config, ...}: {
    services.zfs = {
	trim.enable = true;
	autoScrub.enable = true;
	autoScrub.pools = [ "rpool" ];
	autoSnapshot = {
	    enable = true;
            hourly = 8;
	    frequent = 4;
	    monthly = 1;
	};
    };
}
