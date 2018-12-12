From: daniel.sangorrin@toshiba.co.jp (Daniel Sangorrin)
Date: Wed, 12 Dec 2018 11:53:30 +0900
Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
	socfpga_cyclone5_de0_{sockit, nano_soc}
In-Reply-To: <OSBPR01MB21510D18D0A32CD521CEDFB0D7A60@OSBPR01MB2151.jpnprd01.prod.outlook.com>
References: <b9e891af-405c-57b4-ae67-d61b2d989f7a@siemens.com>
	<003701d490e8$a71990f0$f54cb2d0$@toshiba.co.jp>
	<OSBPR01MB215170074543B773296B5B6ED7A60@OSBPR01MB2151.jpnprd01.prod.outlook.com>
	<OSBPR01MB21510D18D0A32CD521CEDFB0D7A60@OSBPR01MB2151.jpnprd01.prod.outlook.com>
Message-ID: <004c01d491c5$dd125ce0$973716a0$@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Koguchi-san, Jan-san:

Thank you for the clarification.
I think I will leave CIP core v1 as it is, pointing to Koguchi-san's repository.
For CIP core v2 (meta-debian v2) I will use CIP kernel v2 (4.19) once it is released.

Thanks,
Daniel

> -----Original Message-----
> From: ???? / KOGUCHI?TAKUO <takuo.koguchi.sw@hitachi.com>
> Sent: Tuesday, December 11, 2018 3:29 PM
> To: 'Daniel Sangorrin' <daniel.sangorrin@toshiba.co.jp>; 'Jan Kiszka'
> <jan.kiszka@siemens.com>
> Cc: 'cip-dev' <cip-dev@lists.cip-project.org>
> Subject: RE: RE: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
> socfpga_cyclone5_de0_{sockit, nano_soc}
> 
> Daniel-san,
> 
> > I just created socfpga-4.4-cip-rebase branch on the separate repository and
> found there still
> > remain 155 patches on top of linux-4.4.y-cip branch. I suppose most of those
> patches do not
> > exist in the upstream kernel.
> 
> I do not mean upstream kernel has all those issues. Some of them have been solved
> in different ways.
> 
> Takuo Koguchi
> 
> 
> 
> > -----Original Message-----
> > From: ???? / KOGUCHI?TAKUO
> > Sent: Tuesday, December 11, 2018 3:14 PM
> > To: 'Daniel Sangorrin' <daniel.sangorrin@toshiba.co.jp>; 'Jan Kiszka'
> > <jan.kiszka@siemens.com>
> > Cc: 'cip-dev' <cip-dev@lists.cip-project.org>
> > Subject: RE: [!]RE: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
> > socfpga_cyclone5_de0_{sockit, nano_soc}
> >
> > Daniel-san,
> >
> > > * What is the current status of the CIP kernel compared to that separate
> repository?
> > The separate repository (linux-cip-cyclonev.git, branch: socfpga-4.4-cip) has
> > socfpga-4.4.154-cip28 tag and up-to-date.
> > > * Is any of you planning to backport patches to the CIP kernel 4.4?
> > I just created socfpga-4.4-cip-rebase branch on the separate repository and
> found there still
> > remain 155 patches on top of linux-4.4.y-cip branch. I suppose most of those
> patches do not
> > exist in the upstream kernel.
> >
> > Takuo Koguchi
> >
> > > -----Original Message-----
> > > From: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
> > > Sent: Tuesday, December 11, 2018 9:30 AM
> > > To: 'Jan Kiszka' <jan.kiszka@siemens.com>; ???? / KOGUCHI?TAKUO
> > > <takuo.koguchi.sw@hitachi.com>
> > > Cc: 'cip-dev' <cip-dev@lists.cip-project.org>
> > > Subject: [!]RE: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
> > > socfpga_cyclone5_de0_{sockit, nano_soc}
> > >
> > > Koguchi-san, Jan-san:
> > >
> > > The Deby reference implementation of CIP core contains the
> meta-cip-cyclonev layer. This
> > layer
> > > is still using a separate repository (linux-cip-cyclonev.git, branch:
> socfpga-4.4-cip)
> > > created by Koguchi-san.
> > >
> > > * What is the current status of the CIP kernel compared to that separate
> repository?
> > > * Is any of you planning to backport patches to the CIP kernel 4.4?
> > >
> > > Thanks,
> > > Daniel
> > >
> > > > -----Original Message-----
> > > > From: cip-dev-bounces at lists.cip-project.org
> > > > <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
> > > > Sent: Monday, December 10, 2018 7:25 PM
> > > > To: cip-dev <cip-dev@lists.cip-project.org>
> > > > Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
> > > > socfpga_cyclone5_de0_{sockit, nano_soc}
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: cip-dev-bounces at lists.cip-project.org
> > > > > <cip-dev-bounces@lists.cip-project.org> On Behalf Of Jan Kiszka
> > > > > Sent: Monday, December 10, 2018 7:25 PM
> > > > > To: cip-dev <cip-dev@lists.cip-project.org>
> > > > > Subject: [cip-dev] [PATCH 4.4-cip v2] ARM: dts: socfpga: Rename
> > > > > socfpga_cyclone5_de0_{sockit, nano_soc}
> > > > >
> > > > > From: Marek Vasut <marex@denx.de>
> > > > >
> > > > > Rename DT source for DE0 Nano SoC . The board name is really
> DE0-Nano-SoC
> > > > > or Atlas SoC, and it is not to be confused with SoCkit board, which is a
> > > > > different one. Rename the DT source file to match the board name and to
> > > > > avoid this possible mixup with another different board.
> > > > >
> > > > > Upstream commit 202eb5481421040e115526b75317b5ca72584806
> > > > >
> > > > > This commit is needed because it aligns the device tree name of U-Boot
> > > > > and kernel which helps distro boot procedures (fdtfile as set by U-Boot
> > > > > will match the kernel-provided dtb).
> > > > >
> > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > > Cc: Dinh Nguyen <dinguyen@kernel.org>
> > > > > Cc: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > >  - enhance upstream commit log with reason to adopt the patch
> > > > >
> > > > >  arch/arm/boot/dts/Makefile
> | 2 +-
> > > > >  ...ocfpga_cyclone5_de0_sockit.dts =>
> socfpga_cyclone5_de0_nano_soc.dts}
> > > > | 0
> > > > >  2 files changed, 1 insertion(+), 1 deletion(-)
> > > > >  rename arch/arm/boot/dts/{socfpga_cyclone5_de0_sockit.dts =>
> > > > > socfpga_cyclone5_de0_nano_soc.dts} (100%)
> > > > >
> > > > > diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> > > > > index e0a0deaacd48..9871a7f0f92a 100644
> > > > > --- a/arch/arm/boot/dts/Makefile
> > > > > +++ b/arch/arm/boot/dts/Makefile
> > > > > @@ -562,7 +562,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
> > > > >  	socfpga_arria5_socdk.dtb \
> > > > >  	socfpga_arria10_socdk_sdmmc.dtb \
> > > > >  	socfpga_cyclone5_socdk.dtb \
> > > > > -	socfpga_cyclone5_de0_sockit.dtb \
> > > > > +	socfpga_cyclone5_de0_nano_soc.dtb \
> > > > >  	socfpga_cyclone5_sockit.dtb \
> > > > >  	socfpga_cyclone5_socrates.dtb \
> > > > >  	socfpga_vt.dtb
> > > > > diff --git a/arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> > > > > b/arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> > > > > similarity index 100%
> > > > > rename from arch/arm/boot/dts/socfpga_cyclone5_de0_sockit.dts
> > > > > rename to arch/arm/boot/dts/socfpga_cyclone5_de0_nano_soc.dts
> > > > > --
> > > > > 2.16.4
> > > > > _______________________________________________
> > > > > cip-dev mailing list
> > > > > cip-dev at lists.cip-project.org
> > > > >
> > >
> >
> https://clicktime.symantec.com/a/1/T_nCixo-5H94-nBPxFGBiLqEHOCQAjuYJkQU
> 4Z1FrD8=?d=_LC007
> > >
> >
> UK9I-qeCSodui8tJhJTjv7ZTqN0HR5J8u86PSov8apwyy5m-7KkRTOc_kBhLxcHoY
> OPBDvxqlzWbXxmvXOfNBqUL
> > >
> >
> Hc8T64OWhm95V8-UhFB0oj9lUHFXXe8b8mzNtUEBh8pJ-EVgiZrWjVphag98Jpfb
> 0XUN09yteaK2ztkIe3CCr7ls
> > >
> >
> TeBmYOckLJedJf0K5Ys7kxVPQZZUMv7zogY26pdRv3nCZGj19LVOq3RBZS5Spmrg
> LyUL-ryJI4TvPwtVgxpjsFI0
> > >
> >
> duuJXYmwLB7Wxa3MR0gyQwvjHb3OQjy2GOrvVg7z0TTZEMOpdpgjyzh54EN77G
> boPMrD7OAzpe2UAlhjqz5FhSm-
> > >
> >
> irDks18tCTAE2dnVFpOKBoqBArzFzk2ipLsKzes80cvXuThbYgx8jKvMWtD6Kmj-K_L
> GPCDb-5a3WkVINt7rUG0N
> > >
> >
> tI4hFuwZSdk4r7MWb_xIHg8sCTygSB&u=https%3A%2F%2Flists.cip-project.org
> %2Fmailman%2Flistinf
> > > o%2Fcip-dev
