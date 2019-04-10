From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 10 Apr 2019 00:55:42 +0000
Subject: [cip-dev] [PATCH 4.19.y 09/17] arm64: dts: renesas: r8a774c0:
 Add CMT device nodes
In-Reply-To: <20190409205554.GD3845141@pollux.denx.de>
References: <1554112696-20706-1-git-send-email-fabrizio.castro@bp.renesas.com>
	<1554112696-20706-10-git-send-email-fabrizio.castro@bp.renesas.com>,
	<20190409205554.GD3845141@pollux.denx.de>
Message-ID: <TYAPR01MB4189070F5913AF8DCE1D95FE922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, all.

> > From: Biju Das <biju.das@bp.renesas.com>
> >
> > commit fa930bb65cf930c48efc01cc90f928a8db99fa94 upstream.
> >
> > This patch adds CMT{0|1|2|3} device nodes for r8a774c0 SoC.
>
> I could not apply this, as arch/arm64/boot/dts/renesas/r8a774c0.dtsi does
> not exist in my tree.

This was depended patch in charge.
I already applied and push to linux-4.19.y-cip branch.

Best regards,
  Nobuhiro

________________________________________
???: cip-dev-bounces at lists.cip-project.org <cip-dev-bounces@lists.cip-project.org> ? Pavel Machek <pavel@denx.de> ??????
????: 2019?4?10? 5:55
??: Fabrizio Castro
CC: cip-dev at lists.cip-project.org; Biju Das
??: Re: [cip-dev] [PATCH 4.19.y 09/17] arm64: dts: renesas: r8a774c0: Add CMT device nodes

Hi!

> From: Biju Das <biju.das@bp.renesas.com>
>
> commit fa930bb65cf930c48efc01cc90f928a8db99fa94 upstream.
>
> This patch adds CMT{0|1|2|3} device nodes for r8a774c0 SoC.

I could not apply this, as arch/arm64/boot/dts/renesas/r8a774c0.dtsi does
not exist in my tree.

Plus, you are pushing spdx comment changes. I guess it is ok if it makes your
life easier, but...

--
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

_______________________________________________
cip-dev mailing list
cip-dev at lists.cip-project.org
https://lists.cip-project.org/mailman/listinfo/cip-dev
