Return-Path: <SRS0=A4ae=CM=lists.cip-project.org=bounce+64572+5402+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAC4C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 16:00:58 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A03B208C7
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 16:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="kFpoVZoq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A03B208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5402+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Cua5YY4521723xmSGGT7mYZb; Thu, 03 Sep 2020 09:00:57 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.17513.1599148855608010585
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 09:00:55 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56085134"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2020 01:00:54 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 34ED04003875;
	Fri,  4 Sep 2020 01:00:53 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip] of: Add missing exports of node name compare functions
Date: Thu,  3 Sep 2020 17:00:52 +0100
Message-Id: <20200903160052.8806-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: mOT23RXtmgp52zWMTHKzbcvmx4520388AA=
Content-Type: multipart/mixed; boundary="geA5mE5qUtH9Fz4cyJ1c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599148857;
 bh=5YW4bwNmhIksmLIL1QFxLF5AxAgBfNLDWJOTAZ8mUG8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=kFpoVZoqSkdVf5BeF2fkAE5xR+NW/7Nhm3x1zGAv4PvQLoO4CoXX2+eN+y6j03phuGo
 oiuQjLElDPC9B/bQL4kwtIa0FsfpJ/ZeTUjb9vFf/wxJhdjc2qfmiuGGCLmICt/D4VPMm
 cgitSSIpvhHauxO8kp7w7Jz0vVkdh2eXflM=

--geA5mE5qUtH9Fz4cyJ1c

From: Rob Herring <robh@kernel.org>

commit 173ee3962959a1985a109f81539a403b5cd07ae7 upstream.

Commit f42b0e18f2e5 ("of: add node name compare helper functions")
failed to add the module exports to of_node_name_eq() and
of_node_name_prefix(). Add them now.

Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
Fixes build failure for multi_v7_defconfig
---
 drivers/of/base.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index b02f4b272e5b..4e6af7c6c792 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -67,6 +67,7 @@ bool of_node_name_eq(const struct device_node *np, const char *name)
 
 	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
 }
+EXPORT_SYMBOL(of_node_name_eq);
 
 bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 {
@@ -75,6 +76,7 @@ bool of_node_name_prefix(const struct device_node *np, const char *prefix)
 
 	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
 }
+EXPORT_SYMBOL(of_node_name_prefix);
 
 int of_n_addr_cells(struct device_node *np)
 {
-- 
2.17.1


--geA5mE5qUtH9Fz4cyJ1c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5402): https://lists.cip-project.org/g/cip-dev/message=
/5402
Mute This Topic: https://lists.cip-project.org/mt/76610346/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--geA5mE5qUtH9Fz4cyJ1c--
