From: nobuhiro1.iwamatsu@toshiba.co.jp (nobuhiro1.iwamatsu at toshiba.co.jp)
Date: Wed, 10 Apr 2019 23:14:24 +0000
Subject: [cip-dev] [PATCH 1/9] arm64: dts: renesas: r8a774c0: Add
 secondary	CA53 CPU core
In-Reply-To: <1553246370-60751-2-git-send-email-biju.das@bp.renesas.com>
References: <1553246370-60751-2-git-send-email-biju.das@bp.renesas.com>
Message-ID: <TYAPR01MB418999A8DD8304553CBF0204922E0@TYAPR01MB4189.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi, Diju.

> -----Original Message-----
> From: cip-dev-bounces at lists.cip-project.org
> [mailto:cip-dev-bounces at lists.cip-project.org] On Behalf Of Biju Das
> Sent: Friday, March 22, 2019 6:19 PM
> To: cip-dev at lists.cip-project.org
> Cc: Biju Das <biju.das@bp.renesas.com>
> Subject: [cip-dev] [PATCH 1/9] arm64: dts: renesas: r8a774c0: Add
> secondary CA53 CPU core
> 
> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> 
> Add a device node for the second Cortex-A53 CPU core on the Renesas RZ/G2E
> (a.k.a r8a774c0) SoC, and adjust the interrupt delivery masks for the
> ARM Generic Interrupt Controller and Architectured Timer.

I think that 'Architected Timer' is correct, not 'Architectured Timer'.
If my point is correct, I will fix and apply the commit message.

Other patches are looks good to me.

Best regards,
  Nobuhiro
