From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Thu, 16 Jan 2020 19:37:56 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 10/12] arm64: dts: renesas:
 r8a774c0: cat874: Add definition for 12V regulator
In-Reply-To: <20200116152953.GB27135@duo.ucw.cz>
References: <1579187482-4626-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1579187482-4626-11-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200116152953.GB27135@duo.ucw.cz>
Message-ID: <OSBPR01MB516024B157C1A58CB0B9E925AA360@OSBPR01MB5160.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thank you for the review.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 16 January 2020 15:30
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 10/12] arm64: dts: renesas: r8a774c0: cat874:
> Add definition for 12V regulator
>
> Hi!
>
> > From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> >
> > commit 7fc009cbd7d11d6b27ba5443dbfa80a0513829e4 upstream.
> >
> > Power rail "D12.0V" comes straight from the power barrel connector,
> > and it's used in both main board and sub board.
>
> Given that line is always on, always constant, and not referenced anywhere,
> does it need to be described in the dts?
>
> Will it be used in future?
>
Yes the regulator will be used in future. (we plan to add support for lvds panel, the regulator will be used by the backlight)

Cheers,
--Prabhakar

> Best regards,
> Pavel
>
> > @@ -65,6 +65,15 @@
> >  reg = <0x0 0x48000000 0x0 0x78000000>;
> >  };
> >
> > +reg_12p0v: regulator-12p0v {
> > +compatible = "regulator-fixed";
> > +regulator-name = "D12.0V";
> > +regulator-min-microvolt = <12000000>;
> > +regulator-max-microvolt = <12000000>;
> > +regulator-boot-on;
> > +regulator-always-on;
> > +};
> > +
> >  sound: sound {
> >  compatible = "simple-audio-card";
> >
> > --
> > 2.7.4
> >
>
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
