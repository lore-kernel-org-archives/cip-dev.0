From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Fri, 12 Apr 2019 00:31:49 +0000
Subject: [cip-dev] [PATCH 1/4] pinctrl: sh-pfc: Reduce kernel size
	for	narrow VIN channels
In-Reply-To: <1553250528-42395-2-git-send-email-biju.das@bp.renesas.com>
References: <1553250528-42395-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TYAPR01MB4189D8B8056D6E211787EC8192280@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Biju.

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Friday, March 22, 2019 7:29 PM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 1/4] pinctrl: sh-pfc: Reduce kernel size for
> narrow VIN channels
> 
> From: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> Some VIN channels support less than 24 lanes.  As union vin_data always
> consumes space for 24 lanes, this wastes memory.
> 
> Hence introduce new smaller unions vin_data12 and vin_data16, to
> accommodate VIN channels with only 12 or 16 lanes.
> 
> This reduces the static pin controller driver size by 320 bytes for R-Car
> V2H, and by 96 bytes for R-Car E2.

I applied this series, thanks.

Best regards,
  Nobuhiro
