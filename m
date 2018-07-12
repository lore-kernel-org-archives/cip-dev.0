From: takuo.koguchi.sw@hitachi.com (=?utf-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=)
Date: Thu, 12 Jul 2018 01:47:03 +0000
Subject: [cip-dev] Altera CIP branch vs. Denali NAND driver
In-Reply-To: <2426c261-d153-24e3-4ce3-6cbf8f52d7c7@siemens.com>
References: <95cf4467-b48b-6a80-931c-a7f664048c6d@siemens.com>
	<TYAPR01MB2160D07D4F9524CBF5A860D0D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<fd6af125-0a28-d4a5-85cc-13e94778c7be@siemens.com>
	<TYAPR01MB21605130719706B6F02E8F78D7470@TYAPR01MB2160.jpnprd01.prod.outlook.com>
	<2426c261-d153-24e3-4ce3-6cbf8f52d7c7@siemens.com>
Message-ID: <TYAPR01MB216052195F4D0BADFC698B29D7590@TYAPR01MB2160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Jan,
I have tried to build denali-cip-backport and spent some time. It does not work yet on my boards.
I saw "nand: timed out while waiting for chip to become ready" several times and the probe function failed.
Sorry to say, I will not able to continue this effort for now.
When I would make a progress, I will let you know.

Best Regards,

Takuo

> -----Original Message-----
> From: Jan Kiszka <jan.kiszka@siemens.com>
> Sent: Friday, July 06, 2018 8:21 PM
> To: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>; Marek Vasut <marex@denx.de>
> Cc: Henning Schild <henning.schild@siemens.com>; cip-dev <cip-dev@lists.cip-project.org>
> Subject: [!]Re: Altera CIP branch vs. Denali NAND driver
> 
> On 2018-07-06 10:53, ???? / KOGUCHI?TAKUO wrote:
> > Hi Jan,
> >
> >> -----Original Message-----
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >> Sent: Friday, July 06, 2018 5:06 PM
> >>> (2) Bootloader needs to set SPARE_AREA_SKIP_BYTES properly, which is used by
> denali_hw_init.
> >> (I do not remember the actual value off the top of my head). Without this, it resulted
> in
> >> ECC errors as far as I remember.
> >>
> >> We are using upstream U-boot (Marek sorted out the BSP U-boot
> >> differences for us). I suppose you were using the Altera's version,
> >> right? Marek, any comment on this tuning?
> > Yes. I am using u-boot which came with Altera SoCSDK for the custom boards.
> >
> >>
> >>>
> >>> Regarding to Denali Driver backport, "ignores other NAND drivers" is not a  good idea
> even
> >> for the playground, though I am not quite sure.
> >>
> >> I know, but this is related to the fact that the backport started as
> >> proof-of-concept and targets that single device only so far. This would
> >> have to be resolved when we wanted broader use, but it only makes sense
> >> if there is interest.
> >>
> > At lease I am interested.
> 
> That's a good start! To help the discussion, I just pushed our
> work-in-progress branch here:
> 
> https://clicktime.symantec.com/a/1/F8dAar5oXXL8ThwUCaqkcZWZ4mzqV2UK6LFuZQ8TuME=?d=EXT8h
> pgpr56TSRvXnP65tXaLN2CmPa-z5_-z-jES6Avk7IHyojYPdGlFS55ZRmMK3wgYGo6wDmN5xCrI8DyPN0X5kLeM
> irO_Aq3Yk6V0A5dp7VJNu2I0P-6Fv0f0VQ8cgamsxMALkTpiaihP39xTkygbp0CEvtis80ATkWGXpYLqsbPZ92t
> jlqKb8zYq28fZzg5m2JU5EEFU7uyN5GISKV03Msk8EBE883MXcBV5HS3sQZ87_-uBu0lRIvjdjai5s1UWLxlgb9
> kjj51qXxSOGkoRuYsPHD_aaP-FSs5yOj1DCMS8moiRA2M8JWJYjL9mTCv9ebr3wau_UEtuMoXGGIVqQVoEwOWFL
> qUf-wX9qa2ad1QUhQ0JLBk86NNP8a4rPNMTZRkYUw%3D%3D&u=http%3A%2F%2Fgit.kiszka.org%2F%3Fp%3D
> linux.git%3Ba%3Dshortlog%3Bh%3Drefs%2Fheads%2Fdenali-cip-backport
> 
> Jan
> 
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
