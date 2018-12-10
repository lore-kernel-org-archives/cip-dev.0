From: nobuhiro.iwamatsu@miraclelinux.com (Nobuhiro Iwamatsu)
Date: Mon, 10 Dec 2018 19:11:53 +0900
Subject: [cip-dev] [PATCH 4.4-cip] ARM: dts: socfpga: Rename
 socfpga_cyclone5_de0_{sockit, nano_soc}
In-Reply-To: <cd5adbaf-b6bf-1cbd-4809-ac151a253663@siemens.com>
References: <78551c79-2a5b-a261-a15c-4b89ba1c05f4@siemens.com>
	<CAGDrK-akah1YCRWR=Qj9_=1meoUn3kKXmF+FHGTPqP+rw==qwA@mail.gmail.com>
	<cd5adbaf-b6bf-1cbd-4809-ac151a253663@siemens.com>
Message-ID: <CAGDrK-aaW-Jc4EzmC7Qvr_pTG2Lw1JqrCJ18BhxS=DUBthXPAw@mail.gmail.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Jan.

2018?12?10?(?) 18:23 Jan Kiszka <jan.kiszka@siemens.com>:
>
> On 10.12.18 10:13, Nobuhiro Iwamatsu wrote:
> > Hi, Jan.
> >
> > I don't think this is a necessary patch for the CIP kernel.
> > Could you tell me why you need this patch?
>
> It was discussed to use this board as reference. In that case, we should align
> DTB naming between upstream U-boot and kernel, like upstream does. That's
> important for distro boot, which we do with Isar/Debian. Otherwise, our CIP core
> layer will have to carry this patch against the CIP kernel - well...

Thanks for the explanation.

I thought that this fix was necessary as a reference board for CIP.
However, because we don't know the reason from commit message,
Could you add brief explanation to commit message, and resend?

Best regards,
  Nobuhiro

>
> Jan
>
> >
> > Best regards,
> >    Nobuhiro
> >
> > 2018?12?9?(?) 18:57 Jan Kiszka <jan.kiszka@siemens.com>:
> >>
> >> From: Marek Vasut <marex@denx.de>
> >>
> >> Rename DT source for DE0 Nano SoC . The board name is really DE0-Nano-SoC
> >> or Atlas SoC, and it is not to be confused with SoCkit board, which is a
> >> different one. Rename the DT source file to match the board name and to
> >> avoid this possible mixup with another different board.
> >>
> >> Upstream commit 202eb5481421040e115526b75317b5ca72584806
> >>
> >> Signed-off-by: Marek Vasut <marex@denx.de>
> >> Cc: Dinh Nguyen <dinguyen@kernel.org>
> >> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >> ---
> >>   arch/arm/boot/dts/Makefile                                              | 2 +-
> >>   ...ocfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} | 0
> >>   2 files changed, 1 insertion(+), 1 deletion(-)
> >>   rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts => socfpga_cyclone5_de0_nano_soc.dts} (100%)
> >>
> >> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> >> index e0a0deaacd48..9871a7f0f92a 100644
> >> --- a/arch/arm/boot/dts/Makefile
> >> +++ b/arch/arm/boot/dts/Makefile
> >> @@ -562,7 +562,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
> >>          socfpga_arria5_socdk.dtb \
> >>          socfpga_arria10_socdk_sdmmc.dtb \
> >>          socfpga_cyclone5_socdk.dtb \
> >> -       socfpga_cyclone5_de0_sockit.dtb \
> >> +       socfpga_cyclone5_de0_nano_soc.dtb \
> >>          socfpga_cyclone5_sockit.dtb \
> >>          socfpga_cyclone5_socrates.dtb \
> >>          socfpga_vt.dtb
> >> diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> >> similarity index 100%
> >> rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> >> rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> >> --
> >> 2.16.4
> >> _______________________________________________
> >> cip-dev mailing list
> >> cip-dev at lists.cip-project.org
> >> https://lists.cip-project.org/mailman/listinfo/cip-dev
>
> --
> Siemens AG, Corporate Technology, CT RDA IOT SES-DE
> Corporate Competence Center Embedded Linux
