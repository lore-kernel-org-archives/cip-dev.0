From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 19 Dec 2019 07:41:16 +0000
Subject: [cip-dev] [PATCH 4.19.y-cip 03/39] soc: renesas: Add Renesas
 R8A774B1 config option
In-Reply-To: <20191218192806.GA15353@amd>
References: <1576668829-59767-1-git-send-email-biju.das@bp.renesas.com>
 <1576668829-59767-4-git-send-email-biju.das@bp.renesas.com>
 <20191218192806.GA15353@amd>
Message-ID: <OSBPR01MB2103CE29693260D1539A0D59B8520@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel,

Thanks for the feedback.

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, December 18, 2019 7:28 PM
> To: Biju Das <biju.das@bp.renesas.com>
> Cc: cip-dev at lists.cip-project.org; Nobuhiro Iwamatsu
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek <pavel@denx.de>;
> Chris Paterson <Chris.Paterson2@renesas.com>; Marian-Cristian Rotariu
> <marian-cristian.rotariu.rb@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Re: [PATCH 4.19.y-cip 03/39] soc: renesas: Add Renesas R8A774B1
> config option
> 
> Hi!
> 
> > Add configuration option for the RZ/G2N (R8A774B1) SoC.
> 
> Normally, config option should be close to the end of the series (having it in
> the begining can be surprising during the bisect, for example).

Enabling config option should be close to the end of the series. By adding config option in the early stage
allow us to verify each patch that we are adding is compiled properly.

Regards,
Biju

[>] 
> 
> > +++ b/arch/arm64/Kconfig.platforms
> > @@ -195,6 +195,12 @@ config ARCH_R8A774A1
> >  	help
> >  	  This enables support for the Renesas RZ/G2M SoC.
> >
> > +config ARCH_R8A774B1
> > +	bool "Renesas RZ/G2N SoC Platform"
> > +	depends on ARCH_RENESAS
> > +	help
> > +	  This enables support for the Renesas RZ/G2N SoC.
> > +
> >  config ARCH_R8A774C0
> >  	bool "Renesas RZ/G2E SoC Platform"
> >  	depends on ARCH_RENESAS
> 
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
