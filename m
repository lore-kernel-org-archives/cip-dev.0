From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Fri, 7 Feb 2020 13:19:28 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 20/35] arm64: dts: renesas:
 hihope-rzg2-ex: Add LVDS support
In-Reply-To: <20200207131003.GB5989@duo.ucw.cz>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1580935141-1173-21-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200207131003.GB5989@duo.ucw.cz>
Message-ID: <TY2PR01MB516208502340F6322B6B5825AA1C0@TY2PR01MB5162.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 07 February 2020 13:10
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 20/35] arm64: dts: renesas: hihope-rzg2-ex:
> Add LVDS support
>
> Hi!
>
> > +&lvds0 {
> > +/*
> > + * Please include the LVDS panel .dtsi file and uncomment the below
> line
> > + * to enable LVDS panel connected to RZ/G2[MN] boards.
> > + */
> > +
> > +/* status = "okay"; */
> > +
> > +ports {
> > +port at 1 {
> > +lvds_connector: endpoint {
> > +};
> > +};
> > +};
> > +};
>
> Mainline does this so I applied it, but I don't believe you want boards to
> modify the dtsi -- it will get problematic if you want to support two different
> boards with different LVDS panels in one source code.
>
Agreed, ideally that must go into board specific file.

Cheers,
--Prabhakar

> Best regards,
> Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
