Return-Path: <SRS0=rhKa=B7=lists.cip-project.org=bounce+64572+5214+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 953CBC433E5
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6730F207C3
	for <cip-dev@archiver.kernel.org>; Fri, 21 Aug 2020 14:17:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LrJ0ZZN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6730F207C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5214+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id c9zMYY4521723xyDLiX4OyWJ; Fri, 21 Aug 2020 07:17:59 -0700
X-Received: from relmlie5.idc.renesas.com (relmlie5.idc.renesas.com [])
 by mx.groups.io with SMTP id smtpd.web10.135295.1598019427382928687
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2020 07:17:09 -0700
X-IronPort-AV: E=Sophos;i="5.76,335,1592838000"; 
   d="scan'208";a="55184977"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 21 Aug 2020 23:17:08 +0900
X-Received: from localhost.localdomain (unknown [172.29.52.2])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 3D65C40065C6;
	Fri, 21 Aug 2020 23:17:07 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.19.y-cip 2/7] iommu/ipmmu-vmsa: Hook up R8A774E1 DT matching code
Date: Fri, 21 Aug 2020 15:16:57 +0100
Message-Id: <20200821141702.3977-3-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
References: <20200821141702.3977-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: V6QEE6jqfIDzQzIsSTmyvFQSx4520388AA=
Content-Type: multipart/mixed; boundary="qHQaGmAeZdJMCJiagwrK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598019479;
 bh=TYvcX9jIq1YL3TzJ7RByyB+KE+ar6IvdCwdBjWMriU8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LrJ0ZZN1MzVSVV7Y7GM8AlksX6q9Zj+PV6uX/wLIvoxnCo4F8tTPaiI4oa/hRsH+Wkf
 usMHuhe39u5oENRh7iYRc3cwkOuR+2N4eILBWtCY655zCQUmf8G5sJcrmSaic60RgwDCT
 TacqgQe24OUMxN8WUelC3riA0Xt5Ayc4yMQ=

--qHQaGmAeZdJMCJiagwrK

From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>

commit 4b2aa7a6f9b793cadbda898476c8a16d374f1b3a upstream.

Add support for RZ/G2H (R8A774E1) SoC IPMMUs.

Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/1594722055-9298-2-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ea4d19da9865..dfc90ca3f0fe 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -761,6 +761,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 	{ .soc_id = "r8a774a1", },
 	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
+	{ .soc_id = "r8a774e1", },
 	{ .soc_id = "r8a7795", },
 	{ .soc_id = "r8a7796", },
 	{ .soc_id = "r8a77965", },
@@ -772,6 +773,7 @@ static const struct soc_device_attribute soc_rcar_gen3[] = {
 static const struct soc_device_attribute soc_rcar_gen3_whitelist[] = {
 	{ .soc_id = "r8a774b1", },
 	{ .soc_id = "r8a774c0", },
+	{ .soc_id = "r8a774e1", },
 	{ .soc_id = "r8a7795", .revision = "ES3.*" },
 	{ .soc_id = "r8a77965", },
 	{ .soc_id = "r8a77990", },
@@ -975,6 +977,9 @@ static const struct of_device_id ipmmu_of_ids[] = {
 	}, {
 		.compatible = "renesas,ipmmu-r8a774c0",
 		.data = &ipmmu_features_rcar_gen3,
+	}, {
+		.compatible = "renesas,ipmmu-r8a774e1",
+		.data = &ipmmu_features_rcar_gen3,
 	}, {
 		.compatible = "renesas,ipmmu-r8a7795",
 		.data = &ipmmu_features_rcar_gen3,
-- 
2.17.1


--qHQaGmAeZdJMCJiagwrK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5214): https://lists.cip-project.org/g/cip-dev/message=
/5214
Mute This Topic: https://lists.cip-project.org/mt/76329797/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--qHQaGmAeZdJMCJiagwrK--
