From: biju.das@bp.renesas.com (Biju Das)
Date: Fri, 1 Nov 2019 14:29:04 +0000
Subject: [cip-dev] Regarding RZ/G1CeMMC backporting patches
In-Reply-To: <OSBPR01MB2103831ABFCEAE5F3CA232E7B8660@OSBPR01MB2103.jpnprd01.prod.outlook.com>
References: <OSBPR01MB2103831ABFCEAE5F3CA232E7B8660@OSBPR01MB2103.jpnprd01.prod.outlook.com>
Message-ID: <OSBPR01MB21034BD9CB1174161784FE47B8620@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi Pavel & Nobuhiro-San ,

Do you want me to send the patches instead of [1]? Please let me know.

[1]. https://gitlab.com/bijud/emmc

Regards,
Biju

> -----Original Message-----
> From: Biju Das
> Sent: Monday, October 28, 2019 5:47 PM
> To: cip-dev at lists.cip-project.org; Pavel Machek <pavel@denx.de>; Nobuhiro
> Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>; Fabrizio Castro
> <fabrizio.castro@bp.renesas.com>
> Subject: Regarding RZ/G1CeMMC backporting patches
> 
> Hi All,
> 
> RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an internal
> DMA for data transfer which is similar to R-Car Gen3.
> 
> Support for internal DMAC is added in 4.14 kernel and support for RZ/G1C
> added on 4.20 kernel.
> 
> I have backported the relevant patches(86 patches)  to 4.4 kernel and shared
> at [1].
> [1]. https://gitlab.com/bijud/emmc
> 
> Please review this patches and share your opinion, so that I can send it to cip
> patchwork
> 
> Regards,
> Biju
