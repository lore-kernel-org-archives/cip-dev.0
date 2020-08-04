Return-Path: <SRS0=DJYt=BO=lists.cip-project.org=bounce+64572+5093+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE4BC433E0
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA0C2075D
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="nJ4Q71d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA0C2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5093+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WCRoYY4521723xfYgJMXk7r9; Tue, 04 Aug 2020 06:47:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.5604.1596548858868915504
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:47:40 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 074Dlanc017681; Tue, 4 Aug 2020 22:47:36 +0900
X-Iguazu-Qid: 2wGqu78fiiC5scmPDM
X-Iguazu-QSIG: v=2; s=0; t=1596548855; q=2wGqu78fiiC5scmPDM; m=qIBe2ZI8zqW8rIDaLY8VtaFxXtPaY8y/f7qmRXfQylU=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1111) id 074DlYGS039063;
	Tue, 4 Aug 2020 22:47:35 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 074DlYJo026579
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:47:34 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 074DlYVf006600
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:47:34 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 1/3] cip-core-image-test: Add recipe
Date: Tue,  4 Aug 2020 22:47:26 +0900
X-TSB-HOP: ON
Message-Id: <20200804134728.445732-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 5JLD9neRQYAQLplMxZ4eFCDfx4520388AA=
Content-Type: multipart/mixed; boundary="rj4tlxnPFxBCgV9G1iQ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596548861;
 bh=831I74ePT15T1wRL8y1fd2eNbWE88rUvQMa4CD9cm1k=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=nJ4Q71d5T06CstvwYUP/Ay6EwJldfzzYHd1Jkig+xXrj37dW7y1UtvOechh1YKD+RzZ
 yQb9hBYnva7mDybu3wc8/AvFE+EgJTHiqIoOr44eBOFxqPEI/4BMBRd/ikUV2avvZpxpa
 D8CtkLhpFIy4LgcPhW/h5yAh2/ESdg65dF0=

--rj4tlxnPFxBCgV9G1iQ9
Content-Transfer-Encoding: 8bit

This recipe provides an image for testing.
If use this, it will create an image containing LTP(ltp-full), rt-tests and stress-ng.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 recipes-core/images/cip-core-image-test.bb | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 recipes-core/images/cip-core-image-test.bb

diff --git a/recipes-core/images/cip-core-image-test.bb b/recipes-core/images/cip-core-image-test.bb
new file mode 100644
index 0000000..e2b15fc
--- /dev/null
+++ b/recipes-core/images/cip-core-image-test.bb
@@ -0,0 +1,18 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+#
+inherit dpkg-raw
+require cip-core-image.bb
+
+DESCRIPTION = "CIP Core image including test packages"
+
+IMAGE_INSTALL += "ltp-full"
+DEBIAN_DEPENDS += "rt-tests, stress-ng"
-- 
2.27.0


--rj4tlxnPFxBCgV9G1iQ9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5093): https://lists.cip-project.org/g/cip-dev/message=
/5093
Mute This Topic: https://lists.cip-project.org/mt/75986990/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--rj4tlxnPFxBCgV9G1iQ9--
