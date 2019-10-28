From: biju.das@bp.renesas.com (Biju Das)
Date: Mon, 28 Oct 2019 17:46:59 +0000
Subject: [cip-dev] Regarding RZ/G1CeMMC backporting patches
Message-ID: <OSBPR01MB2103831ABFCEAE5F3CA232E7B8660@OSBPR01MB2103.jpnprd01.prod.outlook.com>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

Hi All,

RZ/G1C eMMC IP is different from other RZ/G1 SoC's. It is having an internal DMA for data transfer which is similar to R-Car Gen3.

Support for internal DMAC is added in 4.14 kernel and support for RZ/G1C added on 4.20 kernel.

I have backported the relevant patches(86 patches)  to 4.4 kernel and shared at [1].
[1]. https://gitlab.com/bijud/emmc

Please review this patches and share your opinion, so that I can send it to cip patchwork

Regards,
Biju
