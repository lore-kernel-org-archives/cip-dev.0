From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Thu, 21 Nov 2019 00:31:33 +0000
Subject: [cip-dev] [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog:
 renesas-wdt: Document r8a77470 support
In-Reply-To: <1574268440-33507-2-git-send-email-biju.das@bp.renesas.com>
References: <1574268440-33507-1-git-send-email-biju.das@bp.renesas.com>
 <1574268440-33507-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <OSAPR01MB3234AC76746DEECD0AF85A88924E0@OSAPR01MB3234.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi,

> -----Original Message-----
> From: Biju Das [mailto:biju.das at bp.renesas.com]
> Sent: Thursday, November 21, 2019 1:47 AM
> To: cip-dev at lists.cip-project.org; iwamatsu nobuhiro(?? ?? ???
> ?????) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: [PATCH 4.4.y-cip 1/6] dt-bindings: watchdog: renesas-wdt:
> Document r8a77470 support
> 
> commit 59600d045ff411da193a8b5a2999681801ecd430 upstream.
> 
> RZ/G1C (R8A77470) watchdog implementation is compatible with R-Car Gen2,
> therefore add relevant documentation.
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Reviewed-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Wim Van Sebroeck <wim@linux-watchdog.org>

Hmm, I can not apply this patch.
  https://patchwork.kernel.org/patch/11254441/mbox/
----
error: patch failed: Documentation/devicetree/bindings/watchdog/renesas-wdt.txt:7
----

Could you check on your environment?

Best regards,
  Nobuhiro
