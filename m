From: binh.nguyen.uw@rvc.renesas.com (Binh Thanh. Nguyen)
Date: Thu, 10 Aug 2017 20:53:26 +0700
Subject: [cip-dev] B@D support Renesas iwg20m board - issue
In-Reply-To: <87tw1jbjwa.fsf@ctlt579.codethink.co.uk>
References: <FD48CE4B67D3004BAA683CC1E3106E2D07BABEAB32@RVC-MBS-CL.rvc.renesas.com>
	<87tw1jbjwa.fsf@ctlt579.codethink.co.uk>
Message-ID: <FD48CE4B67D3004BAA683CC1E3106E2D07BB5C748C@RVC-MBS-CL.rvc.renesas.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hello Robert,

Thank you very much for your feedback.

> -----Original Message-----
> From: Robert Marshall [mailto:robert.marshall at codethink.co.uk]
> Sent: Monday, August 7, 2017 8:14 PM
> To: cip dev <cip-dev@lists.cip-project.org>
> Cc: Binh Thanh. Nguyen <binh.nguyen.uw@rvc.renesas.com>; O365-Toru
> Oishi <toru.oishi.zj@renesas.com>
> Subject: Re: [cip-dev] B at D support Renesas iwg20m board - issue
> 
> "Binh Thanh. Nguyen" <binh.nguyen.uw@rvc.renesas.com> writes:
> 
> > Hello all,
> >
> > I am trying to add support healthcheck for Renesas iwg20m board into
> > [1]. My current healthcheck is just simply boot up the board (no
> > deploy and test definition).
> > And I still meet one issue with that booting action. The issue is
> > whenever I run healthcheck, It always run soft-reboot and failed.
> > 'reboot' command is just supported after booting board. So if I booted
> > the board first, then run the healthcheck, it will pass.
> >
> > Anyone have advices for me?
> 
> Hi
> 
> I've seen errors on the soft reboot with the beagle bone black which go away
> the next time it is run. Have you tried this more than once - does it
> consistently fail?

Yes, at that moment, it consistently failed. 
Thanks for your reminding the healthcheck of BBB. I checked how BBB run healthcheck and found that I need to make a script similar to connectBBB.sh
I attach two patches (following three previous patches) to fix the soft reboot issue on Renesas board.
The patches are just for your reference , I will re-create full series of patches after finish all remained works + test.
Next steps is to add deploy  and test action into healthcheck. I will follow your recommend to use local kernel image built in VM

Best regards,
Binh Nguyen


> 
> Thanks for the patches
> 
> I've always run HC tests with the BB black on an already booted board, do you
> need to do any preparation to get the health check to run in this case?
> 
> Robert
> 
> >
> > Please find my patches to apply for [1] in attached files.
> >
> > [1]
> > https://gitlab.com/cip-project/cip-testing/board-at-desk-single-dev/
> >
> > Below is the log:
> >
> > start: 0 validate
> > device may need manual intervention to reboot validate duration: 0.00
> > start: 1 uboot-action (max 120s)
> > start: 1.1 uboot-prepare-kernel (max 120s) uboot-prepare-kernel
> > duration: 0.00
> > start: 1.2 uboot-from-media (max 120s) uboot-from-media duration: 0.00
> > start: 1.3 uboot-overlay (max 120s)
> > Parsed boot commands: setenv autoload no; setenv initrd_high
> > '0xffffffff'; setenv fdt_high '0xffffffff'; setenv bootargs
> > 'console=ttySC0,115200n8 vmalloc=384M root=/dev/mmcblk0p2 '; setenv
> > loadkernel 'fatload mmc 2:1 0x40007fc0 uImage'; setenv loadfdt
> > 'fatload mmc 2:1 0x40f00000 r8a7743-iwg20m.dtb'; setenv bootcmd 'run
> > loadkernel; run loadfdt; bootm 0x40007fc0 - 0x40f00000'; run bootcmd
> > uboot-overlay duration: 0.00
> > start: 1.4 connect-device (max 120s)
> > connect-device Connecting to device using 'telnet localhost 8020'
> > connect-device duration: 0.00
> > start: 1.5 uboot-retry (max 120s)
> > start: 1.5.1 reboot-device (max 120s)
> > start: 1.5.1.1 soft-reboot (max 120s)
> > reboot
> > reboot
> > reboot -n
> > reboot -n
> > reboot -n -f
> > reboot -n -f
> > soft-reboot: Wait for prompt Restarting system. 120 seconds Trying ::1...
> > Connected to localhost.
> > Escape character is '^]'.
> > ser2net port 8020 device /dev/ttyUSB0 [115200 N81] (Debian GNU/Linux)
> > case: soft-reboot
> > definition: lava
> > result: fail
> > level: 1.5.1.1
> > duration: 120.000326157
> > extra: ...
> > soft-reboot timed out after 120 seconds soft-reboot timed out after
> > 120 seconds uboot-retry failed: 1 of 2 attempts. 'soft-reboot timed
> > out after 120 seconds'
> > start: 1.5.1 reboot-device (max 120s)
> > start: 1.5.1.1 soft-reboot (max 120s)
> > ...
> >
> > Best regards,
> > Binh Nguyen
> >
> >
> >
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-scripts-connect-renesas-add-new-file.patch
Type: application/octet-stream
Size: 2225 bytes
Desc: 0001-scripts-connect-renesas-add-new-file.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170810/7cc78cf6/attachment.obj>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0002-configure_lava-renesas-iwg20m-fix-issue-soft-reboot-.patch
Type: application/octet-stream
Size: 1957 bytes
Desc: 0002-configure_lava-renesas-iwg20m-fix-issue-soft-reboot-.patch
URL: <http://lists.cip-project.org/pipermail/cip-dev/attachments/20170810/7cc78cf6/attachment-0001.obj>
