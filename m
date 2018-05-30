From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 19:22:44 +0100
Subject: [cip-dev] [RFC PATCH 7/7] ARM: shmobile: defconfig: Enable
 missing support based on DTSes
In-Reply-To: <OSBPR01MB21037C5E4BED34BDD0001814B86C0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
	<1527177910-65275-8-git-send-email-biju.das@bp.renesas.com>
	<1527703495.2289.27.camel@codethink.co.uk>
	<OSBPR01MB21037C5E4BED34BDD0001814B86C0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <1527704564.2289.29.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Wed, 2018-05-30 at 18:16 +0000, Biju Das wrote:
> Hi Ben,
> 
> Thanks for the feedback.
> 
> > -----Original Message-----
> > From: Ben Hutchings [mailto:ben.hutchings at codethink.co.uk]
> > Sent: 30 May 2018 19:05
> > To: Biju Das <biju.das@bp.renesas.com>
> > Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>; cip-dev at lists.cip-project.org
> > Subject: Re: [RFC PATCH 7/7] ARM: shmobile: defconfig: Enable missing
> > support based on DTSes
> > 
> > On Thu, 2018-05-24 at 17:05 +0100, Biju Das wrote:
> > > From: Geert Uytterhoeven <geert+renesas@glider.be>
> > > 
> > > Enable all missing support, extracted from the various Renesas ARM
> > > DTSes using linux-config-from-dt.
> > > 
> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > Signed-off-by: Simon Horman <horms+renesas@verge.net.au> (cherry
> > > picked from commit 6161cc147277e7537d73a45d732a7112997c20f6)
> > > (enabled only USB-DMAC apart from previously enabled CAN and
> > > ?CAN_RCAR)
> > 
> > Why not apply the whole of the commit (that hasn't already been applied)???I
> > understand that we don't need all these things enabled for the reference
> > hardware, but this is meant to be a generic configuration for all SH-Mobile
> > and R-Car systems.
> 
> We are enabling the config options which are??tested.
> Initially we have??tested CAN driver with this patch. At that point, we found that USB DMAC driver
> is broken with network gadget configuration. Now we found a patch series which fixes USB DMAC driver issue.
> So we can enable USB DMAC driver as well.

OK, that makes sense.

> But the following IP's are not present in RZ/G1M and RZ/G1E platform.
> So currently we don't know the impact, if we enable the same.
> 
> CONFIG_I2C_EMEV2=y
> CONFIG_VIDEO_RENESAS_JPU=y
> CONFIG_RTC_DRV_DA9063=y
[...]

The impact should be none, for those platforms. :-)

I'm happy with this patch series.  Patch 6 should go to 4.4-stable, but
I can also apply it to 4.4-cip without waiting for that.

Ben.

-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
