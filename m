From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Fri, 21 Jul 2017 14:18:50 +0100
Subject: [cip-dev] Kernel feature support - architecture options and drivers
Message-ID: <1500643130.12197.123.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Sorry for the delay in reviewing feature support.  I previously reviewed
filesystems and networking options, and this covers most of the rest.  I
will send one more mail after this covering the remaining options.

# x86

a.out support (CONFIG_IA32_AOUT) is enabled in plathome_obsvx but is
only needed for programs built before about 1995!  Please disable it.

Vsyscall emulation (CONFIG_LEGACY_VSYSCALL_EMULATE) should be disabled
as it's only needed by older C libraries.  Please select
CONFIG_LEGACY_VSYSCALL_NONE instead.

The modify_ldt syscall (CONFIG_MODIFY_LDT_SYSCALL) and 16-bit code
support (CONFIG_X86_16BIT) should be disabled; they're only needed to
run WINE.

Intel Quark support (CONFIG_X86_INTEL_QUARK) is enabled in the
siemens_iot2000 config.  Are you really using Quark SoCs?

X32 syscall support (CONFIG_X86_X32) adds some attack surface that is
not well-tested.  Several of the configurations (plathome_obsvx1,
siemens_server and toshiba) enable this.  Do you need it?

KVM old-style device assignment (CONFIG_KVM_DEVICE_ASSIGNMENT) is
deprecated and the feature has been removed upstream in 4.12, so it is
definitely not supportable.  Only the plathome_obsvx1 config has this
enabled.  Please disable it.  If you are actually using this feature, it
should be replaced by VFIO.

i7300_idle (CONFIG_I7300_IDLE) has been removed upstream, but is enabled
in the plathome_obsvx1, siemens_server and toshiba configs).  This is
only useful for the Intel i7300 chipset, so it should be fine to disable
it.

Several drivers (CONFIG_HP_WIRELESS, CONFIG_INTEL_RST,
CONFIG_INTEL_SMARTCONNECT) appear to only be useful for laptops, but are
enabled in the siemens_server config.  Please consider disabling them.

SFI (CONFIG_SFI) seems to only be useful for Intel smartphone platforms,
but is enabled in the siemens_server config.  Please disable it.

# Storage drivers

nbd (CONFIG_BLK_DEV_NBD) was not in good shape in 4.4, but is enabled in
plathome_obsvx1.config and 
siemens_iot2000.  Do you need it?

dm-cache (CONFIG_DM_CACHE) is marked as experimental in 4.4 and has
changed a lot upstream, which will make it hard to maintain.  The
siemens_server config has it enabled.  Do you need it?

dm-switch (CONFIG_DM_SWITCH) is marked as experimental in 4.4, but is
enabled in the siemens_server config.  Do you need it?

MD multipath (CONFIG_MD_MULTIPATH) is "not under active development",
and should be replaced with dm-multipath.  It is enabled in the
plathome_obsvx1, siemens_iot2000, and siemens_server configs.  Do you
need it?

Many old SCSI drivers (CONFIG_BLK_DEV_3W_XXXX_RAID, CONFIG_SCSI_3W_9XXX,
CONFIG_SCSI_3W_SAS, CONFIG_SCSI_ACARD, CONFIG_SCSI_ADVANSYS,
CONFIG_SCSI_AM53C974, CONFIG_SCSI_BUSLOGIC, CONFIG_SCSI_DC395x,
CONFIG_SCSI_DMX3191D, CONFIG_SCSI_DPT_I2O, CONFIG_SCSI_EATA,
CONFIG_SCSI_GDTH, CONFIG_SCSI_IMM, CONFIG_SCSI_INIA100,
CONFIG_SCSI_INITIO, CONFIG_SCSI_IPS, CONFIG_SCSI_MVUMI,
CONFIG_SCSI_PMCRAID, CONFIG_SCSI_PPA, CONFIG_SCSI_QLOGIC_1280,
CONFIG_SCSI_SYM53C8XX_2, CONFIG_SCSI_WD719X, CONFIG_SCSI_AIC79XX,
CONFIG_SCSI_AIC7XXX, CONFIG_SCSI_AIC94XX, CONFIG_SCSI_ESAS2R,
CONFIG_MEGARAID_LEGACY, CONFIG_SCSI_MVSAS, CONFIG_SCSI_QLA_ISCSI) are
enabled in siemens_server config and I very much doubt you need any of
these.  Please disable them.

# Graphics drivers

gma500 (CONFIG_DRM_GMA{3600,500,600}) is not maintained upstream and
will be unsupportable, but is enabled in the plathome_obsvx1 config.  Do
you need it?

nouveau (CONFIG_DRM_NOUVEAU) is enabled in the hitachi_omap config.  I'm
not sure how this could be useful in an OMAP system, and I don't expect
the driver to be supportable.  Please disable it.

# Network drivers

Many old Ethernet drivers (CONFIG_TYPHOON, CONFIG_VORTEX,
CONFIG_NE2K_PCI, CONFIG_DNET, CONFIG_ETHOC, CONFIG_FEALNX, CONFIG_JME,
CONFIG_ADAPTEC_STARFIRE, CONFIG_AMD8111_ETH, CONFIG_PCNET32,
CONFIG_ATL1, CONFIG_ATL1C, CONFIG_ATL1E, CONFIG_ATL2, CONFIG_B44,
CONFIG_BCMGENET, CONFIG_CHELSIO_T1, CONFIG_DE2104X, CONFIG_DE4X5,
CONFIG_DM9102, CONFIG_NET_TULIP, CONFIG_ULI526X, CONFIG_WINBOND_840,
CONFIG_DL2K, CONFIG_SUNDANCE, CONFIG_HP100, CONFIG_SKY2, CONFIG_KS8842,
CONFIG_KSZ884X_PCI, CONFIG_ENC28J60, CONFIG_MYRI10GE, CONFIG_NATSEMI,
CONFIG_NS83820, CONFIG_S2IO, CONFIG_VXGE, CONFIG_FORCEDETH,
CONFIG_HAMACHI, CONFIG_YELLOWFIN, CONFIG_NETXEN_NIC, CONFIG_QLA3XXX,
CONFIG_QLGE, CONFIG_R6040, CONFIG_8139CP, CONFIG_8139TOO, CONFIG_ATP,
CONFIG_SC92031, CONFIG_SIS190, CONFIG_SIS900, CONFIG_EPIC100,
CONFIG_SMSC9420, CONFIG_CASSINI, CONFIG_HAPPYMEAL, CONFIG_NIU,
CONFIG_TEHUTI, CONFIG_TLAN, CONFIG_VIA_RHINE, CONFIG_VIA_VELOCITY,
CONFIG_WIZNET_W5100, CONFIG_WIZNET_W5300) are enabled in siemens_server
config and I very much doubt you need any of these.  samsung-sxgbe
(CONFIG_SXGBE_ETH) is also enabled, but this hardware only exists in
Samsung SoCs.  Please disable them.

e100 (CONFIG_E100) and e1000 (CONFIG_E1000) drivers are enabled in
several configs (hitachi_omap, plathome_obsvx1, siemens_server) but are
not maintained upstream.  (Don't confuse e1000 with e1000e, which is for
PCI Express and is still maintained.)  Please disable them.

sungem (CONFIG_SUNGEM) is enabled in the siemens_server and toshiba
powerpc configs, but I doubt that this driver is needed.  Please
consider disabling it.

USB-attached network drivers (CONFIG_USB_USBNET) are enabled in several
configs (hitachi_omap, toshiba_tegra, plathome_obsvx1) but few of them
seem to be properly maintained upstream.  Do you need them?

i2400m-usb (CONFIG_WIMAX_I2400M_USB) is enabled in plathome_obsvx1, but
is unmaintained upstream.  Do you need it?  (I also noted previously
that wimax in general is dead.)

Wifi drivers may be hard to support in the long term due to changes in
the softMAC (mac80211) driver API.  However I will assume that they are
needed for some applications.

The ipw2x00 drivers (CONFIG_IPW2100, CONFIG_IPW2200) are not maintained
and only found in some old x86 systems, but is enabled in the
plathome_obsvx1 config.  Please disable them.

zd1211rw (CONFIG_ZD1211RW) seems to be unmaintained but is enabled in
the plathome_obsvx1 config.  Please disable it.

r8172u (CONFIG_R8712U) is in drivers/staging (and has been for nearly 7
years!) and is therefore unlikely to be supportable, but is enabled in
the siemens_iot2000 config.  Do you need it?

# USB drivers

fotg210-hcd (CONFIG_USB_FOTG210_HCD) is a platform driver that doesn't
look usable on x86, but is enabled in the siemens_server config.  Please
disable it.

uhci-hcd (CONFIG_USB_UHCI_HCD) is for obsolete hardware (so far as I
know) but is enabled in the plathome_obsvx1, siemens_server and toshiba
x86 configs.  Please disable it.

ehset (CONFIG_USB_EHSET_TEST_FIXTURE) and usb3503
(CONFIG_USB_HSIC_USB3503) are unlikely to be needed but are enabled in
the siemens_server config.  Please consider disabling them.

# Misc drivers

OProfile (CONFIG_OPROFILE) seems to be barely maintained and redundant
with perf, but all the configs still enable it (mostly because it's
enabled in upstream defconfigs).  Please consider disabling it.

KVM (CONFIG_VIRTUALIZATION) adds a large attack surface (guest-to-host)
and is likely to be hard to maintain in the long term.  Several of the
configurations (hitachi_omap, plathome_obsvx1, siemens_iot2000,
siemens_server) enable this.  Do you need it?

/dev/kmem (CONFIG_DEVKMEM) is only rarely needed for kernel debugging,
but is enabled in many configs.  Please disable it.

/dev/mem (CONFIG_DEVMEM) is needed by some userland drivers, though UIO
provides a cleaner way to do this.  Please check whether you can disable
it.

Chrome platform support (CONFIG_CHROME_PLATFORMS) is enabled in the
siemens_server config.  Assuming you don't need to support these
platforms, please disable it.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
