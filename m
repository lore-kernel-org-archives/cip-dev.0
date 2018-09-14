From: takuo.koguchi.sw@hitachi.com (=?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=)
Date: Fri, 14 Sep 2018 10:45:18 +0000
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <TYAPR01MB2160616915C67118BF018AB0D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
	<TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<fd6af125-0a28-d4a5-85cc-13e94778c7be@siemens.com>
	<TYAPR01MB21605130719706B6F02E8F78D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<2426c261-d153-24e3-4ce3-6cbf8f52d7c7@siemens.com>
	<TYAPR01MB216052195F4D0BADFC698B29D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<5f005779-cbd2-430d-73a7-394696ff108a@siemens.com>
	<TYAPR01MB2160616915C67118BF018AB0D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
Message-ID: <TYAPR01MB216020E4806DE9DD3777D83ED7190@TYAPR01MB2160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Jan,

Have you been making progress with this?
I have confirmed that;
(1) linux-4.13 and linux-4.14 works on my board without any modification to the denali driver.
(2) linux-4.15 to linux-4.19-rc3 need a single extra line. I do not know a better fix.

If you have an update, I would like to try it on my board.

Best regard,

Takuo

---------------------------------
From: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
Date: Fri, 14 Sep 2018 18:38:43 +0900
Subject: [PATCH] MTD NAND Denali fix for Cyclonev

Reading back DMA_ENABLE register just after enabling it, this is removed
by commit: [586a2c52909df453ed1b6239283744b0851ccf81]
mtd: nand: denali: squash denali_enable_dma() helper into caller

Without this denali_wait_for_irq timeout for INTR__DMA_CMD_COMP.

Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
---
 drivers/mtd/nand/raw/denali.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/raw/denali.c b/drivers/mtd/nand/raw/denali.c
index 67b2065..4ba997b 100644
--- a/drivers/mtd/nand/raw/denali.c
+++ b/drivers/mtd/nand/raw/denali.c
@@ -596,6 +596,7 @@ static int denali_dma_xfer(struct denali_nand_info *denali, void *buf,
 	}
 
 	iowrite32(DMA_ENABLE__FLAG, denali->reg + DMA_ENABLE);
+	ioread32(denali->reg + DMA_ENABLE);
 
 	denali_reset_irq(denali);
 	denali->setup_dma(denali, dma_addr, page, write);
-- 
2.1.4


---------------------------------
> -----Original Message-----
> From: ???? / KOGUCHI?TAKUO
> Sent: Thursday, July 12, 2018 3:37 PM
> To: 'Jan Kiszka' <jan.kiszka@siemens.com>; Marek Vasut <marex@denx.de>
> Cc: Henning Schild <henning.schild@siemens.com>; cip-dev <cip-dev@lists.cip-project.org>
> Subject: RE: [!]Re: Altera CIP branch vs. Denali NAND driver
> 
> Jan,
> 
> > Yeah, I wouldn't be surprised if I missed some patch that makes a
> > difference on your board. But upstream 4.14+ works fine for you, right?
> Oops, I should have done it before hand!
> I tried 4.17.0-rc2 on my cyclone5 board just now.
> It was better than denali-cip-backport but it did not work either. It found Bad block table
> but
> >timeout while waiting for irq 0x4
> >nand_bbt: error reading BBT
> and cannot mount the file system on it.
> 
> I will have to investigating this shortly...
> 
> Takuo
> 
> 
> > -----Original Message-----
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > Sent: Thursday, July 12, 2018 2:36 PM
> > To: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>; Marek Vasut <marex@denx.de>
> > Cc: Henning Schild <henning.schild@siemens.com>; cip-dev <cip-dev@lists.cip-project.org>
> > Subject: [!]Re: Altera CIP branch vs. Denali NAND driver
> >
> > On 2018-07-12 03:47, ???? / KOGUCHI?TAKUO wrote:
> > > Jan,
> > > I have tried to build denali-cip-backport and spent some time. It does not work yet on
> > my boards.
> > > I saw "nand: timed out while waiting for chip to become ready" several times and the
> probe
> > function failed.
> > > Sorry to say, I will not able to continue this effort for now.
> > > When I would make a progress, I will let you know.
> > >
> >
> > Yeah, I wouldn't be surprised if I missed some patch that makes a
> > difference on your board. But upstream 4.14+ works fine for you, right?
> >
> > Thanks for trying out nevertheless!
> >
> > Jan
> >
> > > Best Regards,
> > >
> > > Takuo
> > >
> > >> -----Original Message-----
> > >> From: Jan Kiszka <jan.kiszka@siemens.com>
> > >> Sent: Friday, July 06, 2018 8:21 PM
> > >> To: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>; Marek Vasut
> > <marex@denx.de>
> > >> Cc: Henning Schild <henning.schild@siemens.com>; cip-dev
> > <cip-dev@lists.cip-project.org>
> > >> Subject: [!]Re: Altera CIP branch vs. Denali NAND driver
> > >>
> > >> On 2018-07-06 10:53, ???? / KOGUCHI?TAKUO wrote:
> > >>> Hi Jan,
> > >>>
> > >>>> -----Original Message-----
> > >>>> From: Jan Kiszka <jan.kiszka@siemens.com>
> > >>>> Sent: Friday, July 06, 2018 5:06 PM
> > >>>>> (2) Bootloader needs to set SPARE_AREA_SKIP_BYTES properly, which is used by
> > >> denali_hw_init.
> > >>>> (I do not remember the actual value off the top of my head). Without this, it resulted
> > >> in
> > >>>> ECC errors as far as I remember.
> > >>>>
> > >>>> We are using upstream U-boot (Marek sorted out the BSP U-boot
> > >>>> differences for us). I suppose you were using the Altera's version,
> > >>>> right? Marek, any comment on this tuning?
> > >>> Yes. I am using u-boot which came with Altera SoCSDK for the custom boards.
> > >>>
> > >>>>
> > >>>>>
> > >>>>> Regarding to Denali Driver backport, "ignores other NAND drivers" is not a  good
> idea
> > >> even
> > >>>> for the playground, though I am not quite sure.
> > >>>>
> > >>>> I know, but this is related to the fact that the backport started as
> > >>>> proof-of-concept and targets that single device only so far. This would
> > >>>> have to be resolved when we wanted broader use, but it only makes sense
> > >>>> if there is interest.
> > >>>>
> > >>> At lease I am interested.
> > >>
> > >> That's a good start! To help the discussion, I just pushed our
> > >> work-in-progress branch here:
> > >>
> > >>
> >
> https://clicktime.symantec.com/a/1/F8dAar5oXXL8ThwUCaqkcZWZ4mzqV2UK6LFuZQ8TuME=?d=EXT8h
> > >>
> >
> pgpr56TSRvXnP65tXaLN2CmPa-z5_-z-jES6Avk7IHyojYPdGlFS55ZRmMK3wgYGo6wDmN5xCrI8DyPN0X5kLeM
> > >>
> >
> irO_Aq3Yk6V0A5dp7VJNu2I0P-6Fv0f0VQ8cgamsxMALkTpiaihP39xTkygbp0CEvtis80ATkWGXpYLqsbPZ92t
> > >>
> >
> jlqKb8zYq28fZzg5m2JU5EEFU7uyN5GISKV03Msk8EBE883MXcBV5HS3sQZ87_-uBu0lRIvjdjai5s1UWLxlgb9
> > >>
> >
> kjj51qXxSOGkoRuYsPHD_aaP-FSs5yOj1DCMS8moiRA2M8JWJYjL9mTCv9ebr3wau_UEtuMoXGGIVqQVoEwOWFL
> > >>
> >
> qUf-wX9qa2ad1QUhQ0JLBk86NNP8a4rPNMTZRkYUw%3D%3D&u=http%3A%2F%2Fgit.kiszka.org%2F%3Fp%3D
> > >> linux.git%3Ba%3Dshortlog%3Bh%3Drefs%2Fheads%2Fdenali-cip-backport
> > >>
> > >> Jan
> > >>
> > >> --
> > >> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > >> Corporate Competence Center Embedded Linux
> >
> >
> > --
> > Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> > Corporate Competence Center Embedded Linux
