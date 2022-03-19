{ config, ... }:
let
    mkMount = uuid: type: {
        device = "/dev/disk/by-uuid/${uuid}";
	fsType = type;
	options = [ "defaults" "noatime" ];
    };
in
{
    fileSystems = {

    };
}
