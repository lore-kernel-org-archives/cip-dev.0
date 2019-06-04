From: daniel.sangorrin@toshiba.co.jp (daniel.sangorrin at toshiba.co.jp)
Date: Tue, 4 Jun 2019 06:37:03 +0000
Subject: [cip-dev] [isar-cip-core] porting isar-cip-core to iwg20m
In-Reply-To: <7f7466fb-a307-076d-8ea4-8913fc02fbe9@siemens.com>
References: <TY2PR01MB332320DC786A54F33FF95C9FD0150@TY2PR01MB3323.jpnprd01.prod.outlook.com>
	<7f7466fb-a307-076d-8ea4-8913fc02fbe9@siemens.com>
Message-ID: <TY2PR01MB33236A6D098DB4C08EE047A4D0150@TY2PR01MB3323.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Thanks Jan!
I will check your points and try to complete the porting.

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Tuesday, June 4, 2019 3:28 PM
> To: sangorrin daniel(????? ???? ????????) <daniel.sangorrin@toshiba.co.jp>;
> cip-dev at lists.cip-project.org
> Cc: isar-users at googlegroups.com
> Subject: Re: [isar-cip-core] porting isar-cip-core to iwg20m
> 
> On 04.06.19 08:15, daniel.sangorrin at toshiba.co.jp wrote:
> > Hi Jan,
> >
> > I am trying to port isar-cip-core to the iwg20m board.
> >
> > So far I managed to create a WIC SDCard image with 2 partitions:
> > - boot: an VFAT partition to store the uImage and devicetree
> > - root: the root filesystem
> > [Note] u-boot.bin is installed on an SPI memory with a JTAG debugger, so it's not in the image.
> >
> > I would appreciate your help with a couple of problems:
> >
> > - The kernel is built correctly, but I need to transform it into an uImage. I guess I can install u-boot-tools and
> do a mkimage in some postinstall script, but isn't this supposed to be automatized?
> 
> Why is that transformation needed or desired?
> 
> > For example, in meta-debian, I just need to define KERNEL_IMAGETYPE=uImage and the
> UBOOT_ENTRYPOINT. The rest is done for me.
> >
> > - In case, I want to build u-boot (not strictly necessary but it would be good to have it), do I have to create a
> whole recipe including debian rules like in the jailhouse-images repository [1]!?
> 
> Nope, just use u-boot-custom.inc, see
> meta-isar/recipes-bsp/u-boot/u-boot_2018.09.bb for an example.
> 
> > In meta-debian, I just need to define a few variables (git repo, config, entrypoint) and the u-boot packages will
> be created automatically. Those scripts may be needed for very detailed customization (e.g. Trusted firmware),
> but the common case should be automatized.
> > [1] https://github.com/siemens/jailhouse-images/tree/master/recipes-bsp/u-boot
> >
> > - What is the correct way to specify the device tree for the kernel?
> > I added DTB_FILE="mydt.dtb" to my machine config, and then added that to IMAGE_BOOT_FILES. That
> worked, but is that the correct way to do it? There is no documentation about this.
> >
> > - For the kernel configuration, I want to use shmobile_defconfig (already in the kernel source) plus a few extra
> configurations that I have on another file. Is that possible? So far I had to concatenate my configurations to
> shmobile_defconfig which is redundant.
> 
> We probably need to tune the recipes a bit, including in isar, to pick up an
> existing defconfig != "defconfig" - though that is now the default, only ARMv7
> still has board-specific defconfigs.
> 
> >
> > - How can I install the kernel into the boot partition?
> > Currently, the kernel binary and symbols are deployed into the the /boot folder of the "root" partition instead
> of the "boot" partition. I would like the /boot folder to be deployed into the FAT partition. And maybe also get fstab
> filled automatically.
> 
> You want U-Boot distro boot. The kernel will then be picked up from the rootfs,
> and you do not need to move it manually. See other boards, e.g. the bananapi in
> upstream isar.
> 
> Jan
> 
> >
> > I send the actual code/metadata separately on another e-mail.
> > https://lists.cip-project.org/pipermail/cip-dev/2019-June/002409.html
> >
> > Thanks,
> > Daniel
> >
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
