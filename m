Return-Path: <SRS0=PxJM=IH=lists.cip-project.org=bounce+64572+6223+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A92C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:11 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D516E64FF3
	for <cip-dev@archiver.kernel.org>; Tue,  9 Mar 2021 16:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D516E64FF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6223+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id IF1hYY4521723xvmUBC9AUg6; Tue, 09 Mar 2021 08:37:10 -0800
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web11.11727.1615307829143333394
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Mar 2021 08:37:09 -0800
X-IronPort-AV: E=Sophos;i="5.81,234,1610377200"; 
   d="scan'208";a="74342222"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 10 Mar 2021 01:37:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 9C19340A2DC7;
	Wed, 10 Mar 2021 01:37:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 07/40] media: rcar-vin: fix wrong return value in rvin_set_channel_routing()
Date: Tue,  9 Mar 2021 16:36:23 +0000
Message-Id: <20210309163656.20944-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20210309163656.20944-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Lyjp7KSq8wWd98lOUpaBNnqlx4520388AA=
Content-Type: multipart/mixed; boundary="GirVWh4bo1sNsD00cFRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1615307830;
 bh=n/gkZT6+WTgPY1GtfTLDg7oh51YKOG6AebF9fbtArx0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=loy2I5FaP24HX287dYLsFGOktXZlJcM+WtJxPRpRWswj1D2bxX/8TLetG3Qr/AFqTWQ
 QzRSies18nioKwFvqpWJH1OtgzVlITdtzQKDHT7PTvxuKoTXj6zhM4IMA/xJqzN6LY9ko
 xPdr2OrHKZNWewDQNcl7iNNYp2Ht7gSYqIw=

--GirVWh4bo1sNsD00cFRy
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

commit 8d19d5d03b4d09177b0ae87f964eb751e6f51b7b upstream.

If the operation in rvin_set_channel_routing() is successful the 'ret'
variable contains the runtime PM use count for the VIN master device.
The intention is not to return the use count to the caller but to return
0 on success else none zero.

Fix this by always returning 0 if the operation is successful.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/media/platform/rcar-vin/rcar-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/rcar-vin/rcar-dma.c b/drivers/media/platform/rcar-vin/rcar-dma.c
index 70a8cc433a03..e51620c6cc40 100644
--- a/drivers/media/platform/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/rcar-vin/rcar-dma.c
@@ -1343,5 +1343,5 @@ int rvin_set_channel_routing(struct rvin_dev *vin, u8 chsel)
 
 	pm_runtime_put(vin->dev);
 
-	return ret;
+	return 0;
 }
-- 
2.17.1


--GirVWh4bo1sNsD00cFRy
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6223): https://lists.cip-project.org/g/cip-dev/message=
/6223
Mute This Topic: https://lists.cip-project.org/mt/81205348/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--GirVWh4bo1sNsD00cFRy--
