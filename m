Return-Path: <SRS0=XejX=EM=lists.cip-project.org=bounce+64572+5760+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5169BC388F2
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C7502087E
	for <cip-dev@archiver.kernel.org>; Fri,  6 Nov 2020 09:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FZZd30vL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C7502087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5760+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Y4JIYY4521723xIErrAoUrcf; Fri, 06 Nov 2020 01:52:01 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web08.9517.1604656315663802830
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Nov 2020 01:52:00 -0800
X-IronPort-AV: E=Sophos;i="5.77,456,1596466800"; 
   d="scan'208";a="61866354"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2020 18:52:00 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2A2C8426662F;
	Fri,  6 Nov 2020 18:51:58 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 5/8] ata: sata_rcar: Fix DMA boundary mask
Date: Fri,  6 Nov 2020 09:51:48 +0000
Message-Id: <20201106095151.25880-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201106095151.25880-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: JXb72zz0t2qDB7HFPa1lwZrbx4520388AA=
Content-Type: multipart/mixed; boundary="9zZRH4NWgCkXSYYzoxHJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1604656321;
 bh=8ggSB6uRkwdm72ZaVIntn4vZJjmyBmJ0PceGl7Kv0Qg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FZZd30vLe4mcQM/bncPRFMhUhKhIPTZa38Udn6P312ZZdQYgwzpMAXaNJWxocC/8ldE
 PQbr2Imq45fE9tLXalWFnlRMbnYavzgRvw0gYk7a5T/CJb1qFsDhDEEUd3tU+v0SHs9I5
 bcSjZEQZXD2EKf2aErSQijb4tffYyz45P4I=

--9zZRH4NWgCkXSYYzoxHJ

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit df9c590986fdb6db9d5636d6cd93bc919c01b451 upstream.

Before commit 9495b7e92f716ab2 ("driver core: platform: Initialize
dma_parms for platform devices"), the R-Car SATA device didn't have DMA
parameters.  Hence the DMA boundary mask supplied by its driver was
silently ignored, as __scsi_init_queue() doesn't check the return value
of dma_set_seg_boundary(), and the default value of 0xffffffff was used.

Now the device has gained DMA parameters, the driver-supplied value is
used, and the following warning is printed on Salvator-XS:

    DMA-API: sata_rcar ee300000.sata: mapping sg segment across boundary [start=0x00000000ffffe000] [end=0x00000000ffffefff] [boundary=0x000000001ffffffe]
    WARNING: CPU: 5 PID: 38 at kernel/dma/debug.c:1233 debug_dma_map_sg+0x298/0x300

(the range of start/end values depend on whether IOMMU support is
 enabled or not)

The issue here is that SATA_RCAR_DMA_BOUNDARY doesn't have bit 0 set, so
any typical end value, which is odd, will trigger the check.

Fix this by increasing the DMA boundary value by 1.

This also fixes the following WRITE DMA EXT timeout issue:

    # dd if=/dev/urandom of=/mnt/de1/file1-1024M bs=1M count=1024
    ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
    ata1.00: failed command: WRITE DMA EXT
    ata1.00: cmd 35/00:00:00:e6:0c/00:0a:00:00:00/e0 tag 0 dma 1310720 out
    res 40/00:01:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
    ata1.00: status: { DRDY }

as seen by Shimoda-san since commit 429120f3df2dba2b ("block: fix
splitting segments on boundary masks").

Fixes: 8bfbeed58665dbbf ("sata_rcar: correct 'sata_rcar_sht'")
Fixes: 9495b7e92f716ab2 ("driver core: platform: Initialize dma_parms for platform devices")
Fixes: 429120f3df2dba2b ("block: fix splitting segments on boundary masks")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/ata/sata_rcar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_rcar.c b/drivers/ata/sata_rcar.c
index a3fee38a3635..8f43669ca29e 100644
--- a/drivers/ata/sata_rcar.c
+++ b/drivers/ata/sata_rcar.c
@@ -122,7 +122,7 @@
 /* Descriptor table word 0 bit (when DTA32M = 1) */
 #define SATA_RCAR_DTEND			BIT(0)
 
-#define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFEUL
+#define SATA_RCAR_DMA_BOUNDARY		0x1FFFFFFFUL
 
 /* Gen2 Physical Layer Control Registers */
 #define RCAR_GEN2_PHY_CTL1_REG		0x1704
-- 
2.17.1


--9zZRH4NWgCkXSYYzoxHJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5760): https://lists.cip-project.org/g/cip-dev/message=
/5760
Mute This Topic: https://lists.cip-project.org/mt/78070984/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--9zZRH4NWgCkXSYYzoxHJ--
