Return-Path: <SRS0=YM3o=BO=lists.cip-project.org=bounce+64572+5096+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC73C433E0
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:55 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08DB32086A
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="YG9Z8nCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08DB32086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5096+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KuuCYY4521723xELWyZ4tsel; Tue, 04 Aug 2020 06:53:54 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web10.5721.1596549233047353267
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:53:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 074DrpuT019175; Tue, 4 Aug 2020 22:53:51 +0900
X-Iguazu-Qid: 34tMd2lTgEqalaZDV2
X-Iguazu-QSIG: v=2; s=0; t=1596549231; q=34tMd2lTgEqalaZDV2; m=wzultSnxbz2nZSEKkwk18bZuMYbSCjJTIbYt8EGf55U=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1513) id 074DrojO031817;
	Tue, 4 Aug 2020 22:53:50 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 074DroCh019134
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:50 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 074DroC9020803
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:50 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 1/3] cip-core-image-test: Add recipe
Date: Tue,  4 Aug 2020 22:53:40 +0900
X-TSB-HOP: ON
Message-Id: <20200804135342.446609-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: A5d3dbiUaNbZM5hO4wKnA6Ohx4520388AA=
Content-Type: multipart/mixed; boundary="L7MFWq6Pv1PX7MAT5k2n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596549234;
 bh=VsbNlDTxSm6IcwmaeyI1Jj0rWLWvakEvPKcGOcYLAcM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=YG9Z8nCdvVDvAh/ucG2TpO11qIvF/qCOP+SJCGhJhY7c8bPTppurlbK5DfQj3bdruPH
 8ySzR3g3Y350XmZM/FY2pdvAdgclZWxfaSymKtVAOK/DEWVWmipAr+fUui8p3AXLOZmqX
 wsR8eAghG3r97Cv2TOi6bgA4UrJkOViirHw=

--L7MFWq6Pv1PX7MAT5k2n
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


--L7MFWq6Pv1PX7MAT5k2n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5096): https://lists.cip-project.org/g/cip-dev/message=
/5096
Mute This Topic: https://lists.cip-project.org/mt/75987091/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--L7MFWq6Pv1PX7MAT5k2n--
