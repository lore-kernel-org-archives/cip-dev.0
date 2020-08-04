Return-Path: <SRS0=Qx1m=BO=lists.cip-project.org=bounce+64572+5098+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AF3EC433E3
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79292086A
	for <cip-dev@archiver.kernel.org>; Tue,  4 Aug 2020 13:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="VUEARiM6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79292086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5098+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id PcQuYY4521723xATywCtv7Us; Tue, 04 Aug 2020 06:53:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web11.5723.1596549234753447863
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Aug 2020 06:53:55 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 074DrqRs031921; Tue, 4 Aug 2020 22:53:53 +0900
X-Iguazu-Qid: 34tMXyHqtwZnVSxMvI
X-Iguazu-QSIG: v=2; s=0; t=1596549232; q=34tMXyHqtwZnVSxMvI; m=mAYsaP77WB/oOl2+/uzzImHFzne0zpjtwCkru2g5tKU=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 074DrpGn028380;
	Tue, 4 Aug 2020 22:53:52 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 074Drpne019140
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:51 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 074Drp0B020812
	for <cip-dev@lists.cip-project.org>; Tue, 4 Aug 2020 22:53:51 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 3/3] testing: Add test.yml
Date: Tue,  4 Aug 2020 22:53:42 +0900
X-TSB-HOP: ON
Message-Id: <20200804135342.446609-3-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200804135342.446609-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200804135342.446609-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 4zu6CF2UDxVOjCZcxz9M3trIx4520388AA=
Content-Type: multipart/mixed; boundary="8f8pLw8UC6MvnX4TF1Ho"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596549235;
 bh=0ADNh8nhk/3snOBTebDOZY38RIeW/gx08hPepNWT/lU=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=VUEARiM64hzK8lJY7DePUw4IC6UvHiUZS/k97Zgd2u8atZs2nG9mqSsJU+R5YdSZEr5
 8PrySEoBf84kqs+wP5CC0fSsqyvw0nxswBSH+RanJAH3lEzEL5Myl5wRyxp+x5oel8DAO
 P1sgr4x4jF9vck9XSfzjG5QMvQQ9jh4R5EA=

--8f8pLw8UC6MvnX4TF1Ho
Content-Transfer-Encoding: 8bit

Add YAML to add the test application to cip-core-image, and create the
cip-core-image-test image.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 kas/opt/test.yml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
 create mode 100644 kas/opt/test.yml

diff --git a/kas/opt/test.yml b/kas/opt/test.yml
new file mode 100644
index 0000000..c9eeb83
--- /dev/null
+++ b/kas/opt/test.yml
@@ -0,0 +1,15 @@
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
+
+header:
+  version: 8
+
+target: cip-core-image-test
-- 
2.27.0


--8f8pLw8UC6MvnX4TF1Ho
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5098): https://lists.cip-project.org/g/cip-dev/message=
/5098
Mute This Topic: https://lists.cip-project.org/mt/75987095/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8f8pLw8UC6MvnX4TF1Ho--
