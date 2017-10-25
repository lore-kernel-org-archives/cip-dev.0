From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 25 Oct 2017 17:14:57 +0900
Subject: [cip-dev] cip-dev Digest, Vol 17, Issue 22
In-Reply-To: <acf459a2e3ca4c3b8c23a4fa5c01225a@RVC-EX13-M01.rvc.renesas.com>
References: <mailman.97.1508846411.22291.cip-dev@lists.cip-project.org>
	<acf459a2e3ca4c3b8c23a4fa5c01225a@RVC-EX13-M01.rvc.renesas.com>
Message-ID: <002801d34d69$592e2ea0$0b8a8be0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Binh Thanh. Nguyen
> Sent: Tuesday, October 24, 2017 9:33 PM
> To: cip-dev at lists.cip-project.org
> Cc: O365-Toru Oishi
> Subject: Re: [cip-dev] cip-dev Digest, Vol 17, Issue 22
> 
> Hello Daniel,
> 
> > -----Original Message-----
> > From: cip-dev-bounces at lists.cip-project.org [mailto:cip-dev-
> > bounces at lists.cip-project.org] On Behalf Of cip-dev-request at lists.cip-
> > project.org
> > Sent: Tuesday, October 24, 2017 2:00 PM
> > To: cip-dev at lists.cip-project.org
> > Subject: cip-dev Digest, Vol 17, Issue 22
> >
> > Send cip-dev mailing list submissions to
> > 	cip-dev at lists.cip-project.org
> >
> > To subscribe or unsubscribe via the World Wide Web, visit
> > 	https://lists.cip-project.org/mailman/listinfo/cip-dev
> > or, via email, send a message with subject or body 'help' to
> > 	cip-dev-request at lists.cip-project.org
> >
> > You can reach the person managing the list at
> > 	cip-dev-owner at lists.cip-project.org
> >
> > When replying, please edit your Subject line so it is more specific than "Re:
> > Contents of cip-dev digest..."
> >
> >
> > Today's Topics:
> >
> >    1. Re: Status of cip-core (Daniel Sangorrin)
> >    2. B at D demos (Robert Marshall)
> >
> >
> > ----------------------------------------------------------------------
> >
> > Message: 1
> > Date: Tue, 24 Oct 2017 14:17:17 +0900
> > From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
> > To: "'Chris Paterson'" <Chris.Paterson2@renesas.com>,
> > 	<cip-dev@lists.cip-project.org>
> > Subject: Re: [cip-dev] Status of cip-core
> > Message-ID: <004001d34c87$5c8fcbe0$15af63a0$@toshiba.co.jp>
> > Content-Type: text/plain;	charset="UTF-8"
> >
> > Hello Chris,
> >
> > > -----Original Message-----
> > > From: Chris Paterson [mailto:Chris.Paterson2 at renesas.com]
> > > Sent: Tuesday, October 24, 2017 3:23 AM
> > > To: Daniel Sangorrin; cip-dev at lists.cip-project.org; 'Jan Kiszka'
> > > Subject: RE: [cip-dev] Status of cip-core
> > >
> > > Hello Daniel,
> > >
> > > Thank you for the update.
> > >
> > > > - modules.tgz is not generated for iwg20m (for bbb it is): I have to
> > > > investigate why but I think it is not a big problem since they are
> > > > included in the file system images. Probably the reason is just that
> > > > shmobile_defconfig has modules disabled.
> > >
> > > Correct :)
> >
> > I have noticed that the shmobile_defconfig from the official linux-cip repo is
> > quite different from the one at https://github.com/renesas-rz/renesas-cip.
> >
> > Previously I tested the official kernel using a ramdisk and it was successful so I
> > didn't notice the difference. But today I've tried to boot the official kernel
> > with the SD Card file system and it didn't work.
> >
> > One problem was that EXT3/4 wasn't enabled. I decided to use renesas-cip's
> > shmobile_defconfig to build the official linux-cip kernel. However, I got a build
> > error because https://gitlab.com/cip-project/linux-cip/blob/linux-4.4.y-
> > cip/drivers/usb/host/xhci-rcar.c
> > references a firmware called  "r8a779x_usb3_v1.dlmem" which wasn't
> > available on the official kernel. I could solve that either by copying the
> > firmware from renesas-cip or by commenting out the corresponding
> > configuration flags.
> >
> > I managed to build the official kernel but still I couldn't get it to boot from the
> > SD Card.
> > # By the way, I noticed that the mmc numbering also changed (mmcblk0p2
> > was working on renesas-cip kernel as the 2nd partition of the SD Card, but for
> > the official kernel that was a partition on the eMMC and the kernel could not
> > recognize mmcblk2p2).
> >
> > I wonder if this problem comes from the device tree. On the renesas-cip
> > repository there was a r8a7743-iwgm.dts file that worked fine, but on the
> > official repository the one with the closest name was r8a7743-iwg20d-q7.dts.
> > This one worked fine when I boot from a ramdisk but not when I boot from
> > the SD Card.
> 
> We are still working on upstream work on mainline and backport work on official cip-kernel.
> So, I think the official repo not work now for Renesas board.
> 
> >
> > Should I use renesas-cip kernel again?
> > I noticed that the new versions are been merged. I was using renesas-cip's
> > v4.4.69-cip4 but I can see a newer branch called  v4.4.83-cip8
> 
> The version 4.4.83-cip8 is not working now, we detected some issues and still working on it.
> The older versions work OK, please use them.

OK, I'll revert that change then.

Thanks,
Daniel


> 
> >
> > Thanks,
> > Daniel
> >
> >
> >
> >
> > ------------------------------
> >
> > Message: 2
> > Date: Tue, 24 Oct 2017 07:09:26 +0100
> > From: Robert Marshall <robert.marshall@codethink.co.uk>
> > To: cip dev <cip-dev@lists.cip-project.org>
> > Subject: [cip-dev] B at D demos
> > Message-ID: <8760b55b6x.fsf@ctlt579.codethink.co.uk>
> > Content-Type: text/plain
> >
> > Morning!
> >
> > I shall be running Board at Desk demos with the beaglebone black board this
> > afternoon at the CIP stand at ELCE between 15:00 and 16:30.
> >
> > Hope to see you there!
> >
> > Robert
> >
> >
> > ------------------------------
> >
> > _______________________________________________
> > cip-dev mailing list
> > cip-dev at lists.cip-project.org
> > https://lists.cip-project.org/mailman/listinfo/cip-dev
> >
> >
> > End of cip-dev Digest, Vol 17, Issue 22
> > ***************************************
> 
> Best regards,
> Binh Nguyen
> 
> _______________________________________________
> cip-dev mailing list
> cip-dev at lists.cip-project.org
> https://lists.cip-project.org/mailman/listinfo/cip-dev
