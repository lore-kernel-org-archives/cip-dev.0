From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Tue, 28 Mar 2017 10:28:50 +0900
Subject: [cip-dev] Kernel feature support
In-Reply-To: <1489070021.2949.73.camel@codethink.co.uk>
References: <1489070021.2949.73.camel@codethink.co.uk>
Message-ID: <002201d2a762$a7c058c0$f7410a40$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Ben,

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Ben Hutchings
> Sent: Thursday, March 09, 2017 11:34 PM
> To: cip-dev at lists.cip-project.org
> Subject: [cip-dev] Kernel feature support
> 
> We've previously agreed that not all kernel features (drivers,
> filesystems, network protocols, etc.) can be supported in an SLTS
> branch.  I'd like to start working out what the supported features
> should be for the 4.4 branch.
> 
> Are members able to share their kernel .config files, showing which
> features are enabled? 

Please find attached to this e-mail four kernel v4.4 configurations for different architectures and platforms. Some of these kernels contain vendor patches and the PREEMPT RT patch. Also, please note that they were created with 'make ARCH=xxx savedefconfig'.

> Or would you prefer to specify your needs at a
> slightly higher level?

I prepared a list of kernel config options that I consider the most important among the configs we are using. You can find them in the file config-cip (included in the attached zip file) which is reproduced below:

General setup
  CONFIG_POSIX_MQUEUE
  CONFIG_HZ_PERIODIC
  CONFIG_HIGH_RES_TIMERS
  CONFIG_IKCONFIG
  CONFIG_IKCONFIG_PROC
  CONFIG_CGROUPS
  CONFIG_CPUSETS
  CONFIG_NAMESPACES
  CONFIG_SCHED_AUTOGROUP
  CONFIG_BLK_DEV_INITRD
  CONFIG_RD_GZIP
  CONFIG_SHMEM
  CONFIG_SYSCTL_SYSCALL
  CONFIG_KPROBES

Processor type and features
  CONFIG_SMP
  CONFIG_EFI
  CONFIG_HOTPLUG_CPU
  CONFIG_CRASH_DUMP

System type
  CONFIG_ARCH_TEGRA
  CONFIG_ARCH_ZYNQ

Filesystems
  CONFIG_EXT4_FS
  CONFIG_INOTIFY_USER
  CONFIG_OVERLAY_FS
  CONFIG_VFAT_FS
  CONFIG_PROC_FS
  CONFIG_SYSFS
  CONFIG_TMPFS
  CONFIG_SQUASHFS
  CONFIG_JFFS2_FS

Networking support
  CONFIG_INET
  CONFIG_VLAN_8021Q
  CONFIG_IPV6

Device drivers
  CONFIG_UIO
  CONFIG_UIO_PDRV_GENIRQ
  CONFIG_USB_EHCI_HCD
  CONFIG_USB_XHCI_HCD
  CONFIG_USB_STORAGE
  CONFIG_USB_HID
  CONFIG_USB_NET_DRIVERS
  CONFIG_FB
  CONFIG_TUN
  CONFIG_DEVTMPFS
  CONFIG_DEVTMPFS_MOUNT
  CONFIG_GPIOLIB
  CONFIG_GPIO_SYSFS
  CONFIG_GPIOLIB_IRQCHIP
  CONFIG_BLK_DEV_RAM
  CONFIG_MTD
  CONFIG_MTD_BLOCK
  CONFIG_MTD_NAND
  CONFIG_I2C
  CONFIG_SPI
  CONFIG_MMC
  CONFIG_MMC_SDHCI
  CONFIG_INPUT_EVDEV
  CONFIG_PPS
  CONFIG_E1000E
  CONFIG_I40E
  CONFIG_IGB

Kernel hacking
  CONFIG_FTRACE
  CONFIG_FUNCTION_TRACER
  CONFIG_PRINTK_TIME
  CONFIG_PANIC_ON_OOPS

Some of these kernel config options may be out of scope or too broad. I just provide them for reference.
We may send you more information in the future.

Best regards,
Daniel

--
IoT Technology center
Toshiba Corp. Industrial ICT solutions, 
Daniel SANGORRIN
	


-------------- next part --------------
A non-text attachment was scrubbed...
Name: cip-configs.zip
Type: application/octet-stream
Size: 7544 bytes
Desc: not available
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170328/95188efc/attachment.obj>
