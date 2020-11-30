Return-Path: <SRS0=hiud=FE=lists.cip-project.org=bounce+64572+5891+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HEADER_CTYPE_ONLY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2E2C64E7B
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:24 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ACC42084C
	for <cip-dev@archiver.kernel.org>; Mon, 30 Nov 2020 14:19:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Os/3YK20"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ACC42084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5891+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NrsEYY4521723xgsTs0Z0evB; Mon, 30 Nov 2020 06:19:22 -0800
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web12.60461.1606745961761183441
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Nov 2020 06:19:22 -0800
X-IronPort-AV: E=Sophos;i="5.78,381,1599490800"; 
   d="scan'208";a="64366335"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie5.idc.renesas.com with ESMTP; 30 Nov 2020 23:19:20 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 4740049708F6;
	Mon, 30 Nov 2020 23:19:19 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 01/11] base: soc: Early register bus when needed
Date: Mon, 30 Nov 2020 14:19:06 +0000
Message-Id: <20201130141916.8211-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20201130141916.8211-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: iWXQxZLvpkTCEW01sXWKJNP3x4520388AA=
Content-Type: multipart/mixed; boundary="NXyrr11gw8FpdsuQPVk4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1606745962;
 bh=l2/aLP6C7pM/m9lpuvUMZFU+oHufK6q6yo63Oo63UNE=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=Os/3YK2024mYBD/5tO14uOPbJUSTPcmYRl+p3JXijlCI+/khxeK/PHoUj6I7iYYd+oK
 w70FGBo4jrpxp3drMP8hlYoPl28W+3fH5lN0E1xLz9VIM49eQvg4eSVf7ibk1hxxIDJaM
 yi1REMG2CrpZNsqQRoSw1F0wVtDjmgrMjqU=

--NXyrr11gw8FpdsuQPVk4

From: Geert Uytterhoeven <geert+renesas@glider.be>

commit 1da1b3628df34a2a5e38b70c8551770aadce969d upstream.

If soc_device_register() is called before soc_bus_register(), it crashes
with a NULL pointer dereference.

soc_bus_register() is already a core_initcall(), but drivers/base/ is
entered later than e.g. drivers/pinctrl/ and drivers/soc/. Hence there
are several subsystems that may need to know SoC revision information,
while it's not so easy to initialize the SoC bus even earlier using an
initcall.

To fix this, let soc_device_register() register the bus early if that
hasn't happened yet.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/base/soc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/base/soc.c b/drivers/base/soc.c
index 84242e6b2897..c9fd0ee2ba50 100644
--- a/drivers/base/soc.c
+++ b/drivers/base/soc.c
@@ -114,6 +114,12 @@ struct soc_device *soc_device_register(struct soc_device_attribute *soc_dev_attr
 	struct soc_device *soc_dev;
 	int ret;
 
+	if (!soc_bus_type.p) {
+		ret = bus_register(&soc_bus_type);
+		if (ret)
+			goto out1;
+	}
+
 	soc_dev = kzalloc(sizeof(*soc_dev), GFP_KERNEL);
 	if (!soc_dev) {
 		ret = -ENOMEM;
@@ -159,6 +165,9 @@ EXPORT_SYMBOL_GPL(soc_device_unregister);
 
 static int __init soc_bus_register(void)
 {
+	if (soc_bus_type.p)
+		return 0;
+
 	return bus_register(&soc_bus_type);
 }
 core_initcall(soc_bus_register);
-- 
2.17.1


--NXyrr11gw8FpdsuQPVk4
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5891): https://lists.cip-project.org/g/cip-dev/message=
/5891
Mute This Topic: https://lists.cip-project.org/mt/78608800/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--NXyrr11gw8FpdsuQPVk4--
