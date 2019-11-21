From: biju.das@bp.renesas.com (Biju Das)
Date: Thu, 21 Nov 2019 07:47:06 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog:
 renesas-wdt: Document r8a77470 support
In-Reply-To: <OSAPR01MB3234AC76746DEECD0AF85A88924E0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
 <1574268440-33507-2-git-send-email-biju.das@bp.renesas.com>
 <OSAPR01MB3234AC76746DEECD0AF85A88924E0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB2103C8FC9537DF4BDED1BDF1B84E0@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Nobuhiro-San,

Thanks for the feedback.

> -----Original Message-----
> From: nobuhiro1.iwamatsu at toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Thursday, November 21, 2019 12:32 AM
> To: Biju Das <biju.das@bp.renesas.com>; cip-dev at lists.cip-project.org;
> pavel at denx.de
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: RE: [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog: renesas-wdt:
> Document r8a77470 support
> 
> Hi,
> 
> > -----Original Message-----
> > From: Biju Das [mailto:biju.das at bp.renesas.com]
> > Sent: Thursday, November 21, 2019 1:47 AM
> > To: cip-dev at lists.cip-project.org; iwamatsu nobuhiro(?? ?? ???
> > ?????) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> > <pavel@denx.de>
> > Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> > <biju.das@bp.renesas.com>; Fabrizio Castro
> > <fabrizio.castro@bp.renesas.com>
> > Subject: [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog: renesas-wdt:
> > Document r8a77470 support
> >
> > commit 59600d045ff411da193a8b5a2999681801ecd430 upstream.
> >
> > RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car
> > Gen2, therefore add relevant documentation.
> >
> > Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> > Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>
> 
> Hmm, I can not apply this patch.
>   https://patchwork.kernel.org/patch/11254441/mbox/
> ----
> error: patch failed: Documentation/devicetree/bindings/watchdog/renesas-
> wdt.txt:7
> ----
> 
> Could you check on your environment?

It could be related to r8a7744 dependency. I have rebased this patches on top of latest 4.4.y-cip branch and 
Looks ok.

git rebase remotes/origin/linux-4.4.y-cip
First, rewinding head to replay your work on top of it...
Applying: dt-bindings: watchdog: renesas-wdt: Document r8a77470 support
Using index info to reconstruct a base tree...
M	Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
Falling back to patching base and 3-way merge...
Auto-merging Documentation/devicetree/bindings/watchdog/renesas-wdt.txt
Applying: ARM: dts: r8a77470: Add watchdog support to SoC dtsi
Applying: ARM: dts: iwg23s-sbc: Enable watchdog support
Applying: dt-bindings: timer: renesas, cmt: Document r8a77470 CMT support
Applying: ARM: dts: r8a77470: Add CMT SoC specific support
Applying: ARM: dts: iwg23s-sbc: Enable cmt0

I will send this merged patch soon.

Regards,
Biju
