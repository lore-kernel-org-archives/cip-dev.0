Return-Path: <SRS0=eedf=CM=lists.cip-project.org=bounce+64572+5397+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AD3C433E9
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:10 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5767F206EB
	for <cip-dev@archiver.kernel.org>; Thu,  3 Sep 2020 14:43:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LhJ6sC7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5767F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5397+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id e1GVYY4521723xRSMjD6IVGn; Thu, 03 Sep 2020 07:43:10 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web10.15612.1599144189502243808
 for <cip-dev@lists.cip-project.org>;
 Thu, 03 Sep 2020 07:43:09 -0700
X-IronPort-AV: E=Sophos;i="5.76,387,1592838000"; 
   d="scan'208";a="56081308"
X-Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2020 23:43:08 +0900
X-Received: from localhost.localdomain (unknown [10.226.36.204])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 3115842D18DA;
	Thu,  3 Sep 2020 23:43:07 +0900 (JST)
From: "Lad Prabhakar" <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 2/6] sh_eth: Add compatible string for R8A7742 SoC
Date: Thu,  3 Sep 2020 15:42:59 +0100
Message-Id: <20200903144303.13275-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200903144303.13275-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 8xl6uvN5iy2cbpkjrOD67jqyx4520388AA=
Content-Type: multipart/mixed; boundary="vRB7QMh4mAoTE7WXLVYG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599144190;
 bh=6mwM2voyKeP2gcBDV9FY37KDUmxqpmjSpcUJ83tLwS4=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=LhJ6sC7HS5JdD8D5KlNVdA2pWDJMRIpgUCqyVK5InLzH59XUzrwsXDm5jMN35HsYiWB
 L/ceKQUG0/Uv3lbTH7RhFvkAWmC2FCOcOtKg6sFK7LYqzmqKELV2ZNZ3wmvSY4VRFmTZH
 jnpdDOZmdCL3DPIgWvMoWiGNXU3yf/JbJlM=

--vRB7QMh4mAoTE7WXLVYG

Add "renesas,ether-r8a7742" to compatible list of sh_eth driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/net/ethernet/renesas/sh_eth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/renesas/sh_eth.c b/drivers/net/ethernet/renesas/sh_eth.c
index 15866e372b8c..ecccf5220fd4 100644
--- a/drivers/net/ethernet/renesas/sh_eth.c
+++ b/drivers/net/ethernet/renesas/sh_eth.c
@@ -3065,6 +3065,7 @@ static struct sh_eth_plat_data *sh_eth_parse_dt(struct device *dev)
 
 static const struct of_device_id sh_eth_match_table[] = {
 	{ .compatible = "renesas,gether-r8a7740", .data = &r8a7740_data },
+	{ .compatible = "renesas,ether-r8a7742", .data = &r8a779x_data },
 	{ .compatible = "renesas,ether-r8a7743", .data = &r8a779x_data },
 	{ .compatible = "renesas,ether-r8a7745", .data = &r8a779x_data },
 	{ .compatible = "renesas,ether-r8a7778", .data = &r8a777x_data },
-- 
2.17.1


--vRB7QMh4mAoTE7WXLVYG
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5397): https://lists.cip-project.org/g/cip-dev/message=
/5397
Mute This Topic: https://lists.cip-project.org/mt/76608369/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--vRB7QMh4mAoTE7WXLVYG--
