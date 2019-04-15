From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Mon, 15 Apr 2019 00:29:09 +0000
Subject: [cip-dev] [PATCH 4.19.y] arm64: renesas: Enable GPIOLIB to
	allow	GPIO driver selection
In-Reply-To: <1554450896-62824-1-git-send-email-biju.das@bp.renesas.com>
References: <1554450896-62824-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TYAPR01MB418966ED45F834FE16705724922B0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Biju.

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Friday, April 5, 2019 4:55 PM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 4.19.y] arm64: renesas: Enable GPIOLIB to allow
> GPIO driver selection
> 
> From: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> 
> The R-Car GPIO driver cannot be enabled when Renesas SoC's ARCH configs
> (ARCH_RENESAS, ARCH_R8A7795, ARCH_R8A7796 and ARCH_R8A77965) are
> enabled only.
> 
> As GPIOs are a critical resource for proper operation on Renesas platforms,
> this patch selects GPIOLIB, just like is done for other SoC vendors, and
> on Renesas arm32 SoCs.
> 
> Reported-by: Alexandru Gheorghe <Alexandru_Gheorghe@mentor.com>
> Signed-off-by: Takeshi Kihara <takeshi.kihara.df@renesas.com>
> [geert: Improve patch description]
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> 
> (cherry picked from commit 9374eee32b666c92cf821a98eb3aeaa0bf4d5dd5)
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>

I applied this patch, thanks.

Best regards,
  Nobuhiro
