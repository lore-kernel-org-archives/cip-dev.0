Return-Path: <SRS0=2nZz=BH=lists.cip-project.org=bounce+64572+5034+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HEADER_CTYPE_ONLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76D4C433EB
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BCC206D7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Jul 2020 11:52:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="XKfNll7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BCC206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5034+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id hWduYY4521723xYyDPFLob9A; Tue, 28 Jul 2020 04:52:28 -0700
X-Received: from relmlie6.idc.renesas.com (relmlie6.idc.renesas.com [210.160.252.172])
 by mx.groups.io with SMTP id smtpd.web12.9579.1595933019852967366
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2020 03:43:40 -0700
X-IronPort-AV: E=Sophos;i="5.75,406,1589209200"; 
   d="scan'208";a="53033314"
X-Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 28 Jul 2020 19:43:39 +0900
X-Received: from localhost.localdomain (unknown [172.29.51.253])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id D279040062A4;
	Tue, 28 Jul 2020 19:43:37 +0900 (JST)
From: Biju Das <biju.das.jz@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
Cc: Chris Paterson <chris.paterson2@renesas.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [cip-dev] [PATCH 4.4.y-cip 3/9] dt-bindings: display: Add bindings for EDT panel
Date: Tue, 28 Jul 2020 11:43:24 +0100
Message-Id: <20200728104330.6182-4-biju.das.jz@bp.renesas.com>
In-Reply-To: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
References: <20200728104330.6182-1-biju.das.jz@bp.renesas.com>
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xnr5wkHpId3VYdw98hgIEzQEx4520388AA=
Content-Type: multipart/mixed; boundary="pwlBjbKpazWo6CBS1PHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595937148;
 bh=379ei607BWYCUolVbXAwE79tU03lvm9RsZhYaqFYJCk=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=XKfNll7HKPUiXkK5CC6ie4r15OSb3q5G5WXi69xJ60cuqxSQFy9vjwRoR0zwa/Vxmka
 ua9ApSld7y5HwQS8+qE6Rmfo79As1qdDBN9YOxUx3zHCywmxm/md7OxemAc3+A68966e6
 iB+JC+JhzVWRTMCM6vclHH/PN4w/8ZyBlPY=

--pwlBjbKpazWo6CBS1PHY

Document the Emerging Display Technology Corp. (EDT) ETM043080DH6-GP
display, which is a 480x272 4.3" TFT display with capacitive touchscreen.

This patch is based on the upstream commit c752affbadb05b619
("dt-bindings: display: Add bindings for EDT panel").

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 .../bindings/display/panel/edt,etm043080dh6gp.txt        | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/edt,etm043080dh6gp.txt

diff --git a/Documentation/devicetree/bindings/display/panel/edt,etm043080dh6gp.txt b/Documentation/devicetree/bindings/display/panel/edt,etm043080dh6gp.txt
new file mode 100644
index 000000000000..c837e0bfb1a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/edt,etm043080dh6gp.txt
@@ -0,0 +1,9 @@
+Emerging Display Technology Corp. ETM043080DH6-GP 4.3" WQVGA TFT LCD panel
+
+Required properties:
+- compatible: should be "edt,etm043080dh6gp"
+
+ETM043080DH6-GP is 480x272 TFT Display with capacitive touchscreen.
+
+This binding is compatible with the simple-panel binding, which is specified
+in simple-panel.txt in this directory.
-- 
2.17.1


--pwlBjbKpazWo6CBS1PHY
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5034): https://lists.cip-project.org/g/cip-dev/message=
/5034
Mute This Topic: https://lists.cip-project.org/mt/75842039/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--pwlBjbKpazWo6CBS1PHY--
