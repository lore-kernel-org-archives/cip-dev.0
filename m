From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 20 Sep 2017 15:39:59 +0900
Subject: [cip-dev] B@D support Renesas iwg20m board - issue
In-Reply-To: <FD48CE4B67D3004BAA683CC1E3106E2D07BDAC2D49@RVC-MBS-CL.rvc.renesas.com>
References: <FD48CE4B67D3004BAA683CC1E3106E2D07BABEAB32@RVC-MBS-CL.rvc.renesas.com>	<87tw1jbjwa.fsf@ctlt579.codethink.co.uk>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BB5C748C@RVC-MBS-CL.rvc.renesas.com>
	<000701d32abf$74cb3170$5e619450$@toshiba.co.jp>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BD7458BF@RVC-MBS-CL.rvc.renesas.com>
	<005e01d32b67$81b2c940$85185bc0$@toshiba.co.jp>
	<FD48CE4B67D3004BAA683CC1E3106E2D07BDAC2D49@RVC-MBS-CL.rvc.renesas.com>
Message-ID: <008e01d331db$47a6f800$d6f4e800$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Binh,

> -----Original Message-----
> From: Binh Thanh. Nguyen [mailto:binh.nguyen.uw at rvc.renesas.com]
> Sent: Friday, September 15, 2017 8:46 PM
> To: Daniel Sangorrin; 'cip dev'
> Cc: O365-Toru Oishi
> Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
> 
> Hello Daniel,
> 
> Sorry for late reply. I got few days off for some reasons.
> 
> > -----Original Message-----
> > From: Daniel Sangorrin [mailto:daniel.sangorrin at toshiba.co.jp]
> > Sent: Tuesday, September 12, 2017 8:36 AM
> > To: Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; 'cip dev' <cip-
> > dev at lists.cip-project.org>
> > Cc: O365-Toru Oishi <toru.oishi.zj@renesas.com>
> > Subject: RE: [cip-dev] B at D support Renesas iwg20m board - issue
> >
> > Hi Binh,
> >
> > > -----Original Message-----
> > > From: Binh Thanh. Nguyen [mailto:binh.nguyen.uw at rvc.renesas.com]
> > > Sent: Monday, September 11, 2017 8:00 PM
> > > > Any updates on this topic?
> > > I have no update. I was busy with other tasks with high priority. I will
> > manage to back to this task from next week.
> > > I will let you know if there is any update.
> >
> > OK, I'm working on it now. There were several problems with your patches
> > and we are upgrading to LAVA 2017.7.
> > Before you start please let me know so we don't overlap.
> 
> It is great to know that. Thank you for your work on Renesas board.
> I will back to this task next week, if possible please let me know your status, anything need my support please let me know.

I am preparing the board to boot from the network (tftp), both the kernel and the Project-X file system (a ramdisk).
Currently the kernel boots fine, but no login console appears.
# Note, the same file system installed on the SD Card has no problems

This are a few things I had to modify:
- kernel configuration
   CONFIG_BLK_DEV_RAM=y
   CONFIG_BLK_DEV_RAM_COUNT=8
   CONFIG_BLK_DEV_RAM_SIZE=102400

- ramdisk
    # mkdir ramdisk
    # cd ramdisk/
    # tar xvf ../iwg20m/core-image-minimal-iwg20m.tar.gz
    # ln -s /sbin/init .
    # find . | cpio --create --format='newc' > /tmp/newinitrd
    # gzip /tmp/newinitrd
    # mkimage  -A arm -T ramdisk -C gzip -d /tmp/newinitrd.gz uRamdisk
    # mv uRamdisk /var/lib/tftpboot/

- u-boot settings
      iWave-G20M > setenv ramdisk_addr 0x41000000
      iWave-G20M > setenv ramdisk_file uRamdisk
      iWave-G20M > setenv bootm_low 0x44000000
      iWave-G20M > setenv bootm_size 0x3000000
      iWave-G20M > setenv bootargs_ramdisk setenv bootargs ${bootargs_base} root=/dev/ram rootwait rw
      iWave-G20M > setenv bootcmd_tftpboot 'run bootargs_ramdisk;run fdt_check;tftpboot ${loadaddr} ${kernel};tftpboot ${fdt_addr} ${fdt_file};tftpboot ${ramdisk_addr} ${ramdisk_file};bootm ${loadaddr} ${ramdisk_addr} ${fdt_addr}'
      iWave-G20M > saveenv
      iWave-G20M > run bootcmd_tftpboot

I send you the bootlog attached as well.

If you have any hint about the possible solution please let me know.

Thanks,
Daniel
 
> >
> > > > I have two questions:
> > > >
> > > > 1) Is there any reason for renesas-iwg20m.jinja2 not to extend base-
> > > > uboot.jinja2 as in beaglebone-black.jinja2? Why is it extending
> > > > base.jinja2 and then duplicating code from base-uboot.jinja2?
> > > Beaglebone-black.jinja2 does not extend base-uboot.jinja2, I think you
> > > are checking the Beaglebone-black.jinja2 in board-at-desk- single-dev.
> > > But As I check, we are using the available beaglebone-black.jinja2 from lava-
> > server. You can check it after starting VM and check the file /etc/lava-
> > server/dispatcher-config/device-types/beaglebone-black.jinja2.
> > > I also copied and modify that beaglebone-black.jinja2 as it is faster to
> > develop for Renesas board.
> >
> > Yes, I was looking into the one in board-at-desk which is the same as the one
> > in lava-server for new versions of LAVA (including  LAVA 2017.7).
> > https://gitlab.com/cip-project/cip-testing/board-at-desk-single-
> > dev/blob/master/device-types/beaglebone-black.jinja2
> > https://git.linaro.org/lava/lava-
> > server.git/tree/lava_scheduler_app/tests/device-types/beaglebone-
> > black.jinja2
> >
> > Was there any reason not to do the same with iwg20m? It looks much easier
> > to override a few variables than creating a complete template.
> 
> There was no special reason when I started to add file jinja2 for iwg20m board.
> I was using board at desk v0.9.1, and the beaglebone-black.jinja2 in my VM look like an old version before this commit
> https://github.com/Linaro/lava-server/commit/46a055a3bd42194075977947c7399ad9119c8920
> You can create new jinja2 file not rely on the file I created.
> 
> >
> > > > 2) Why are you using the connect-renesas/connect-BBB.sh scripts
> > > > instead of 'telnet localhost 8020'? LAVA already supports autologin.
> > > After first time boot board, If I run healthcheck without script
> > > connect-renesas.sh, it will keep issuing 'reboot' command at the login
> > prompt.
> > > Autologin only works from second time run healthcheck, when already
> > logged in.
> > > I was not able to make it auto login at the first time run
> > > healthcheck, If you have a solution that not need connect-renesas.sh script,
> > please share me.
> >
> > I'm using the power_off_command and power_on_command to connect with
> > a PDU (power distribution unit). Probably the reboot command appears
> > because you have not set these commands or do not have a PDU. I'm not sure
> > why it needs to be these way, I will ask to the mailing list in the future.
> > Ref: https://validation.linaro.org/static/docs/v2/lava-scheduler-device-
> > dictionary.html
> 
> Thank you for sharing information.
> 
> Best regards,
> Binh Nguyen
> 
> 
> >
> > Thanks,
> > Daniel
> > > > > -----Original Message-----
> > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Binh
> > > > > Thanh. Nguyen
> > > > > Sent: Thursday, August 10, 2017 10:53 PM
> > > > > To: cip dev
> > > > > Cc: O365-Toru Oishi
> > > > > Subject: Re: [cip-dev] B at D support Renesas iwg20m board - issue
> > > > >
> > > > > Hello Robert,
> > > > >
> > > > > Thank you very much for your feedback.
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
> > > > > > Sent: Monday, August 7, 2017 8:14 PM
> > > > > > To: cip dev <cip-dev@lists.cip-project.org>
> > > > > > Cc: Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>;
> > > > > > O365-Toru Oishi <toru.oishi.zj@renesas.com>
> > > > > > Subject: Re: [cip-dev] B at D support Renesas iwg20m board - issue
> > > > > >
> > > > > > "Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:
> > > > > >
> > > > > > > Hello all,
> > > > > > >
> > > > > > > I am trying to add support healthcheck for Renesas iwg20m
> > > > > > > board into [1]. My current healthcheck is just simply boot up
> > > > > > > the board (no deploy and test definition).
> > > > > > > And I still meet one issue with that booting action. The issue
> > > > > > > is whenever I run healthcheck, It always run soft-reboot and failed.
> > > > > > > 'reboot' command is just supported after booting board. So if
> > > > > > > I booted the board first, then run the healthcheck, it will pass.
> > > > > > >
> > > > > > > Anyone have advices for me?
> > > > > >
> > > > > > Hi
> > > > > >
> > > > > > I've seen errors on the soft reboot with the beagle bone black
> > > > > > which go away the next time it is run. Have you tried this more
> > > > > > than once
> > > > > > - does it consistently fail?
> > > > >
> > > > > Yes, at that moment, it consistently failed.
> > > > > Thanks for your reminding the healthcheck of BBB. I checked how
> > > > > BBB run healthcheck and found that I need to make a script similar
> > > > > to connectBBB.sh I attach two patches (following three previous
> > > > > patches) to fix
> > > > the soft reboot issue on Renesas board.
> > > > > The patches are just for your reference , I will re-create full
> > > > > series of patches
> > > > after finish all remained works + test.
> > > > > Next steps is to add deploy  and test action into healthcheck. I
> > > > > will follow your recommend to use local kernel image built in VM
> > > > >
> > > > > Best regards,
> > > > > Binh Nguyen
> > > > >
> > > > >
> > > > > >
> > > > > > Thanks for the patches
> > > > > >
> > > > > > I've always run HC tests with the BB black on an already booted
> > > > > > board, do you need to do any preparation to get the health check
> > > > > > to run in
> > > > this case?
> > > > > >
> > > > > > Robert
> > > > > >
> > > > > > >
> > > > > > > Please find my patches to apply for [1] in attached files.
> > > > > > >
> > > > > > > [1]
> > > > > > > https://gitlab.com/cip-project/cip-testing/board-at-desk-singl
> > > > > > > e-de
> > > > > > > v/
> > > > > > >
> > > > > > > Below is the log:
> > > > > > >
> > > > > > > start: 0 validate
> > > > > > > device may need manual intervention to reboot validate duration:
> > > > > > > 0.00
> > > > > > > start: 1 uboot-action (max 120s)
> > > > > > > start: 1.1 uboot-prepare-kernel (max 120s)
> > > > > > > uboot-prepare-kernel
> > > > > > > duration: 0.00
> > > > > > > start: 1.2 uboot-from-media (max 120s) uboot-from-media duration:
> > > > > > > 0.00
> > > > > > > start: 1.3 uboot-overlay (max 120s) Parsed boot commands:
> > > > > > > setenv autoload no; setenv initrd_high '0xffffffff'; setenv
> > > > > > > fdt_high '0xffffffff'; setenv bootargs
> > > > > > > 'console=ttySC0,115200n8 vmalloc=384M root=/dev/mmcblk0p2 ';
> > > > > > > setenv loadkernel 'fatload mmc 2:1 0x40007fc0 uImage'; setenv
> > > > > > > loadfdt 'fatload mmc 2:1 0x40f00000 r8a7743-iwg20m.dtb';
> > > > > > > setenv bootcmd 'run loadkernel; run loadfdt; bootm 0x40007fc0
> > > > > > > - 0x40f00000'; run bootcmd uboot-overlay duration: 0.00
> > > > > > > start: 1.4 connect-device (max 120s) connect-device Connecting
> > > > > > > to device using 'telnet localhost 8020'
> > > > > > > connect-device duration: 0.00
> > > > > > > start: 1.5 uboot-retry (max 120s)
> > > > > > > start: 1.5.1 reboot-device (max 120s)
> > > > > > > start: 1.5.1.1 soft-reboot (max 120s) reboot reboot reboot -n
> > > > > > > reboot -n reboot -n -f reboot -n -f
> > > > > > > soft-reboot: Wait for prompt Restarting system. 120 seconds Trying
> > ::1...
> > > > > > > Connected to localhost.
> > > > > > > Escape character is '^]'.
> > > > > > > ser2net port 8020 device /dev/ttyUSB0 [115200 N81] (Debian
> > > > > > > GNU/Linux)
> > > > > > > case: soft-reboot
> > > > > > > definition: lava
> > > > > > > result: fail
> > > > > > > level: 1.5.1.1
> > > > > > > duration: 120.000326157
> > > > > > > extra: ...
> > > > > > > soft-reboot timed out after 120 seconds soft-reboot timed out
> > > > > > > after
> > > > > > > 120 seconds uboot-retry failed: 1 of 2 attempts. 'soft-reboot
> > > > > > > timed out after 120 seconds'
> > > > > > > start: 1.5.1 reboot-device (max 120s)
> > > > > > > start: 1.5.1.1 soft-reboot (max 120s) ...
> > > > > > >
> > > > > > > Best regards,
> > > > > > > Binh Nguyen
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > _______________________________________________
> > > > > > > cip-dev mailing list
> > > > > > > cip-dev at lists.cip-project.org
> > > > > > > https://lists.cip-project.org/mailman/listinfo/cip-dev
> > > >
> > >
> > > Kind regards,
> > > Binh Nguyen
> > >
> > >
> > >
> >
> >

-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: iwg20m-ramdisk-bootlog-nologin.txt
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170920/d5e37e70/attachment-0001.txt>
