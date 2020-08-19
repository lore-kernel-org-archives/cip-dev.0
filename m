Return-Path: <SRS0=fvh+=B5=lists.cip-project.org=bounce+64572+5136+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6373AC433E1
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:25 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA99A2083B
	for <cip-dev@archiver.kernel.org>; Wed, 19 Aug 2020 04:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="sLOGdynV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA99A2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5136+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id LwvIYY4521723xNNmmNL02vs; Tue, 18 Aug 2020 21:42:24 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web10.82966.1597812141269477257
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Aug 2020 21:42:23 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 07J4gJqq026319; Wed, 19 Aug 2020 13:42:19 +0900
X-Iguazu-Qid: 2wGqzHwiyNDgSFeyn2
X-Iguazu-QSIG: v=2; s=0; t=1597812139; q=2wGqzHwiyNDgSFeyn2; m=60MmG97Hyk2H5g+YFqF5sjK0mb+AoUxLH6SkXP5BWno=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1113) id 07J4gIMs023770;
	Wed, 19 Aug 2020 13:42:19 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07J4gHK9026341;
	Wed, 19 Aug 2020 13:42:17 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07J4gHFL008512;
	Wed, 19 Aug 2020 13:42:17 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH v2 3/3] testing: Add test.yml
Date: Wed, 19 Aug 2020 13:42:01 +0900
X-TSB-HOP: ON
Message-Id: <20200819044201.1255803-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200819044201.1255803-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: VsPPdKj6GZ3ww2t9z7Xab7Kox4520388AA=
Content-Type: multipart/mixed; boundary="DFoZD8Y8wmDsnODM719Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597812144;
 bh=sJi4S2GB0anjsOv9iC0xZvH56slguFFOPHzGEED83jM=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=sLOGdynVJtWtxPe1TyrvTcwQ7JH4X258JfQs5AmzsZARQLduErOTUS8nL2lDbOn6CL+
 A1eA5nAxaLOuGm0P/ZNOhtCT7nY/+r3iEWdEDAEMUe2rv2uFhaM893nAeIc3T/st0VVby
 5WDLTk4o21bj23IQ+l7DYnX5dzGVJmK6+xE=

--DFoZD8Y8wmDsnODM719Y
Content-Transfer-Encoding: 8bit

Add YAML to add the test application to each images.
The following test applications will be added.
 - ltp
 - rt-tests
 - stress-ng

And this appends '-test' to the generated image filename.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 kas/opt/test.yml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 kas/opt/test.yml

diff --git a/kas/opt/test.yml b/kas/opt/test.yml
new file mode 100644
index 0000000..75b257d
--- /dev/null
+++ b/kas/opt/test.yml
@@ -0,0 +1,20 @@
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  testing: |
+    IMAGE_INSTALL += "ltp-full"
+    IMAGE_PREINSTALL += "rt-tests stress-ng"
+    DESCRIPTION_append = " with test packages"
+    IMAGE_FULLNAME_append = "-test"
+
-- 
2.27.0


--DFoZD8Y8wmDsnODM719Y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5136): https://lists.cip-project.org/g/cip-dev/message=
/5136
Mute This Topic: https://lists.cip-project.org/mt/76280651/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--DFoZD8Y8wmDsnODM719Y--
