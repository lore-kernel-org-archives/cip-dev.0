Return-Path: <SRS0=lEoD=BH=lists.cip-project.org=bounce+64572+5037+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E58C433EC
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6242070B
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="f/MrrPvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6242070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5037+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id eNnqYY4521723x4qNwS1Sz7I; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [210.160.252.171])
 by mx.groups.io with SMTP id smtpd.web10.9634.1595933018234767330
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:38 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53245244"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:37 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E639140041B6;
	Tue, 28 Jul 2020 19:43:35 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/9] of: add node name compare helper functions
Date: Tue, 28 Jul 2020 11:43:23 +0100
Message-Id: <20200728104330.6182-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rLc5ErxAgYta4IhyB7BRD0utx4520388AA=
Content-Type: multipart/mixed; boundary="dPbYWSRKBggTQEmtqzWH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=9AyCsPvd+lOTXPDum44gvNawJfGKEQvZwblZu+5vbt0=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=f/MrrPvPDTj0NO6tVyMVbXrvIKIJWxKXhWg9JnVmYoVIpYPQnOIuE7jCR7UhEMBF192
 UIjUgvml9Ii0lGSZ8dI3ebNPiSZkw8Cxxl8sKhahaPkkdKdfx7p87dypi9UQzd+H5A1KC
 Y+NyJGdjOCAwr10r53PLm46G+W9N0+/VVAU=

--dPbYWSRKBggTQEmtqzWH

From: Rob Herring <robh@kernel.org>

commit f42b0e18f2e5cf34f73ef1b6327b49040b307a33 upstream.

In preparation to remove device_node.name pointer, add helper functions
for node name comparisons which are a common pattern throughout the kernel.

Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Rob Herring <robh@kernel.org>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/of/base.c  | 22 ++++++++++++++++++++++
 include/linux/of.h | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 164eb1306661..b02f4b272e5b 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -54,6 +54,28 @@ DEFINE_MUTEX(of_mutex);
  */
 DEFINE_RAW_SPINLOCK(devtree_lock);
 
+bool of_node_name_eq(const struct device_node *np, const char *name)
+{
+	const char *node_name;
+	size_t len;
+
+	if (!np)
+		return false;
+
+	node_name = kbasename(np->full_name);
+	len = strchrnul(node_name, '@') - node_name;
+
+	return (strlen(name) == len) && (strncmp(node_name, name, len) == 0);
+}
+
+bool of_node_name_prefix(const struct device_node *np, const char *prefix)
+{
+	if (!np)
+		return false;
+
+	return strncmp(kbasename(np->full_name), prefix, strlen(prefix)) == 0;
+}
+
 int of_n_addr_cells(struct device_node *np)
 {
 	const __be32 *ip;
diff --git a/include/linux/of.h b/include/linux/of.h
index a09b9fb8e67d..1bef273a1909 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -231,6 +231,9 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)
 
+extern bool of_node_name_eq(const struct device_node *np, const char *name);
+extern bool of_node_name_prefix(const struct device_node *np, const char *prefix);
+
 static inline const char *of_node_full_name(const struct device_node *np)
 {
 	return np ? np->full_name : "<no-node>";
@@ -397,6 +400,16 @@ static inline struct device_node *to_of_node(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+static inline bool of_node_name_eq(const struct device_node *np, const char *name)
+{
+	return false;
+}
+
+static inline bool of_node_name_prefix(const struct device_node *np, const char *prefix)
+{
+	return false;
+}
+
 static inline const char* of_node_full_name(const struct device_node *np)
 {
 	return "<no-node>";
-- 
2.17.1


--dPbYWSRKBggTQEmtqzWH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5037): https://lists.cip-project.org/g/cip-dev/message=
/5037
Mute This Topic: https://lists.cip-project.org/mt/75842042/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--dPbYWSRKBggTQEmtqzWH--
