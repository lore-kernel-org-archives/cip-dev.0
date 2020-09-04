Return-Path: <SRS0=uaw+=CN=lists.cip-project.org=bounce+64572+5414+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9995DC433E2
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 06:59:07 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F7B20722
	for <cip-dev@archiver.kernel.org>; Fri,  4 Sep 2020 06:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="hfJL5iiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F7B20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5414+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 2cknYY4521723x6jKfACf5D3; Thu, 03 Sep 2020 23:59:06 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.32851.1599202745774213970
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 23:59:06 -0700
X-IronPort-AV: E=Sophos;i="5.76,388,1592838000"; 
   d="scan'208";a="56148330"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 04 Sep 2020 15:59:03 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 730AE40062DC;
	Fri,  4 Sep 2020 15:59:02 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip v2] of: Add missing exports of node name compare functions
Date: Fri,  4 Sep 2020 07:59:01 +0100
Message-Id: <20200904065901.11195-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: lyBRTfeV0bAvRpf5YKrXjUNWx4520388AA=
Content-Type: multipart/mixed; boundary="wnsSupHiLkdI2zICMF9X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599202746;
 bh=rTrUsC711vY/454vhpE+IfiZM72q18Bi7vq6uQjbhF4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=hfJL5iiGyfLhHCzeB3BGqN57KY0Y1HLiU0/RUGatbk3hEAZKKPiHX4hGE7/Bis7B5oa
 hS5lAqrXemK8SfzHhz9AdFcfCXMbrUVOL8O2MLgO3qdW7++LzDxg0LFywtXZAeDkpcj6T
 y5uggU+syZ8ZFa018gPTbbqRvj5Foerj/kE=

--wnsSupHiLkdI2zICMF9X

From: Rob Herring <robh@kernel.org>

commit 173ee3962959a1985a109f81539a403b5cd07ae7 upstream.

Commit f42b0e18f2e5 ("of: add node name compare helper functions")
failed to add the module exports to of_node_name_eq() and
of_node_name_prefix(). Add them now.

Fixes: f42b0e18f2e5 ("of: add node name compare helper functions")
Signed-off-by: Rob Herring <robh@kernel.org>
[PL: Fixes eeaa48eee492d ("drm: rcar-du: Support panels
connected directly to the DPAD outputs")]
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2
* Included fixes tag.
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


--wnsSupHiLkdI2zICMF9X
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5414): https://lists.cip-project.org/g/cip-dev/message=
/5414
Mute This Topic: https://lists.cip-project.org/mt/76624733/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--wnsSupHiLkdI2zICMF9X--
