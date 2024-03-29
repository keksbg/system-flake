{ buildLinux
, callPackage
, inputs
, kernelPatches
, lib
, pkgs
, ...
} @ args:

let
  sources = callPackage ./sources.nix { inherit inputs; };
in
buildLinux (args // {
  inherit (sources) src kernelPatches;
  version = "${sources.version}-tkg-Lava";
  isZen = true;
  # stdenv = pkgs.llvmPackages_13.stdenv;
  # TODO:
  # some stuff is set in pkgs/os-specific/linux/kernel/common-config.nix
  # but i have no idea how to change it
  structuredExtraConfig = with lib.kernel; builtins.mapAttrs (_: value: lib.mkForce value) {
    LOCALVERSION = freeform "-tkg-Lava";
    ZENIFY = yes;
    MHASWELL = yes;
    WINESYNC = module;

    # tickless timers
    HZ_PERIODIC = no;
    NO_HZ = yes;
    NO_HZ_COMMON = yes;
    NO_HZ_FULL = yes;
    NO_HZ_FULL_NODEF = yes;
    NO_HZ_IDLE = no;
    CONTEXT_TRACKING = yes;
    CONTEXT_TRACKING_FORCE = no;
    HZ_500 = yes;
    HZ_500_NODEF = yes;

    # preempt
    PREEMPT = yes;
    PREEMPT_COUNT = yes;
    PREEMPT_VOLUNTARY = no;
    PREEMPTION = yes;
    PREEMPT_DYNAMIC = yes;

    # scheduler
    SCHED_ALT = yes;
    SCHED_BMQ = yes;
    FAIR_GROUP_SCHED = no;
    CFS_BANDWIDTH = no;

    # disable numa
    NUMA = no;
    AMD_NUMA = no;
    ACPI_NUMA = no;
    X86_64_ACPI_NUMA = no;
    NODES_SPAN_OTHER_NODES = no;
    NUMA_EMU = no;
    NODES_SHIFT = no;
    NEED_MULTIPLE_NODES = no;
    USE_PERCPU_NUMA_NODE_ID = no;

    # disable ftrace
    FUNCTION_TRACER = no;
    FUNCTION_GRAPH_TRACER = no;

    # disable misc debugging
    SLUB_DEBUG = no;
    PM_DEBUG = no;
    PM_ADVANCED_DEBUG = no;
    PM_SLEEP_DEBUG = no;
    ACPI_DEBUG = no;
    SCHED_DEBUG = no;
    LATENCYTOP = no;
    DEBUG_PREEMPT = no;
    DEBUG_INFO_BTF = no;

    CONFIG_LRU_CACHE = module;
  };
  ignoreConfigErrors = true;
} // (args.argsOverride or { }))
