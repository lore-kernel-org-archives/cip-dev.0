From: ben.hutchings@codethink.co.uk (Ben Hutchings)
Date: Wed, 30 May 2018 18:44:17 +0100
Subject: [cip-dev] [RFC PATCH 0/7] 'SKB reserve' quirk setup to u_ether
In-Reply-To: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
References: <1527177910-65275-1-git-send-email-biju.das@bp.renesas.com>
Message-ID: <1527702257.2289.24.camel@codethink.co.uk>
To: cip-dev@lists.cip-project.org
List-Id: cip-dev.lists.cip-project.org

On Thu, 2018-05-24 at 17:05 +0100, Biju Das wrote:
> Hi All,
> 
> Some platforms (e.g. USB-DMAC on R-Car and RZ/G1 SoCs) has memory
> alignment restriction. If memory alignment is not match, the usb
> peripheral driver decides not to use the DMA controller.
> Then, the performance is not good.
> 
> Patch 1-4 --> basically add support only for NCM network model.
> 
> Patch 5--> supports for all network models.
> 
> Patch 6-->fixes cpulock up condition on the USB DMAC driver
> 
> Patch 7--> enables USB DMAC
> 
> Renesas USB DMAC driver is not enabled in 4.4 stable kernel.
> So not planning to send the patch set to stable kernel.

The USB DMAC driver is present, so I think patch 6 should go to 4.4-
stable.  For the rest, I agree they can be added to 4.4-cip only.

Ben.

> Cheers,
> Biju
> 
> Dmitry Osipenko (1):
> ? usb: gadget: f_ncm/u_ether: Move 'SKB reserve' quirk setup to u_ether
> 
> Geert Uytterhoeven (1):
> ? ARM: shmobile: defconfig: Enable missing support based on DTSes
> 
> Yoshihiro Shimoda (5):
> ? usb: gadget: add a new quirk to avoid skb_reserve in u_ether.c
> ? usb: gadget: u_ether: add a flag to avoid skb_reserve() calling
> ? usb: gadget: f_ncm: add support for no_skb_reserve
> ? usb: renesas_usbhs: set quirk_avoids_skb_reserve if USB-DMAC is used
> ? dmaengine: usb-dmac: fix endless loop in usb_dmac_chan_terminate_all()
> 
> ?arch/arm/configs/shmobile_defconfig????|??1 +
> ?drivers/dma/sh/usb-dmac.c??????????????|??4 ++--
> ?drivers/usb/gadget/function/u_ether.c??|??5 ++++-
> ?drivers/usb/renesas_usbhs/mod_gadget.c |??2 ++
> ?include/linux/usb/gadget.h?????????????| 13 +++++++++++++
> ?5 files changed, 22 insertions(+), 3 deletions(-)
> 
-- 
Ben Hutchings, Software Developer                ?        Codethink Ltd
https://www.codethink.co.uk/                 Dale House, 35 Dale Street
                                     Manchester, M1 2HF, United Kingdom
We respect your privacy.?? See https://www.codethink.co.uk/privacy.html
