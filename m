From: prabhakar.mahadev-lad.rj@bp.renesas.com (Prabhakar Mahadev Lad)
Date: Fri, 7 Feb 2020 13:14:25 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 24/35] arm64: dts: renesas:
 r8a774b1: Add Sound and Audio DMAC device nodes
In-Reply-To: <20200207131108.GC5989@duo.ucw.cz>
References: <1580935141-1173-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1580935141-1173-25-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20200207131108.GC5989@duo.ucw.cz>
Message-ID: <TY2PR01MB5162FBBF03174CF309FA57CCAA1C0@TY2PR01MB5162.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: 07 February 2020 13:11
> To: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 24/35] arm64: dts: renesas: r8a774b1: Add
> Sound and Audio DMAC device nodes
>
> Hi!
>
> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > commit 067eca6dc61ad3d05ba919cd5a10affc0647e19c upstream.
> >
> > Based on a similar patch of the R8A7796 device tree by Kuninori
> > Morimoto <kuninori.morimoto.gx@renesas.com>.
>
> > @@ -1236,24 +1236,478 @@
> >  };
> >
> >  rcar_sound: sound at ec500000 {
> > +/*
> > + * #sound-dai-cells is required
> > + *
> > + * Single DAI : #sound-dai-cells = <0>;
> <&rcar_sound>;
> > + * Multi  DAI : #sound-dai-cells = <1>;
> <&rcar_sound N>;
> > + */
> > +/*
> > + * #clock-cells is required for audio_clkout0/1/2/3
> > + *
> > + * clkout: #clock-cells = <0>;
> <&rcar_sound>;
> > + * clkout0/1/2/3: #clock-cells = <1>;
> <&rcar_sound N>;
> > + */
> > +compatible =  "renesas,rcar_sound-r8a774b1",
> > +"renesas,rcar_sound-gen3";
>
> There is extra space after "=".
>
My bad shall I create a separate patch fixing it ?

Cheers,
--Prabhakar

> Best regards,
> Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


Renesas Electronics Europe GmbH, Geschaeftsfuehrer/President: Carsten Jauch, Sitz der Gesellschaft/Registered office: Duesseldorf, Arcadiastrasse 10, 40472 Duesseldorf, Germany, Handelsregister/Commercial Register: Duesseldorf, HRB 3708 USt-IDNr./Tax identification no.: DE 119353406 WEEE-Reg.-Nr./WEEE reg. no.: DE 14978647
