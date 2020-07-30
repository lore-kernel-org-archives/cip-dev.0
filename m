Return-Path: <SRS0=9hDZ=BJ=lists.cip-project.org=bounce+64572+5066+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6824C433E4
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:10:27 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 786392082E
	for <cip-dev@archiver.kernel.org>; Thu, 30 Jul 2020 09:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="ojz3Z5l6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 786392082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5066+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id yfjdYY4521723xm8yQOCBcHc; Thu, 30 Jul 2020 02:10:27 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web12.4601.1596100225080621544
 for <cip-dev@lists.cip-project.org>;
 Thu, 30 Jul 2020 02:10:26 -0700
IronPort-SDR: pdR6J9m3JOdMWzQu+McIYF2wni45MN3VBZJBGKL7Gm+HCXatO0li80+BLeqLtzyiKwCuguqhNn
 RtujOGDZoTpg==
X-IronPort-AV: E=Sophos;i="5.75,413,1589221800"; 
   d="scan'208";a="5250311"
X-Received: from unknown (HELO TOSBLRMBX0519.TOSHIBA-TSIP.COM) ([10.116.85.29])
  by peak.toshiba-tesi.com with ESMTP; 30 Jul 2020 15:15:16 +0530
X-Received: from TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) by
 TOSBLRMBX0519.TOSHIBA-TSIP.COM (10.116.85.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 30 Jul 2020 14:39:27 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0219.TOSHIBA-TSIP.COM (172.28.80.119) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Thu, 30 Jul 2020 14:39:26 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [isar-cip-core 1/2] opt: Add kas option file for security image
Date: Thu, 30 Jul 2020 14:40:21 +0530
Message-ID: <20200730091022.602-2-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200730091022.602-1-venkata.pyla@toshiba-tsip.com>
References: <20200730091022.602-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 3MJ0uIuFFOy9tcRBFjzjmRAbx4520388AA=
Content-Type: multipart/mixed; boundary="ZulxmCdrsPG8ajlcbUIS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1596100227;
 bh=WNManACMUTfvO633jAeWo9SNVpIIKKU2F7nh0IkhiKc=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=ojz3Z5l6xAN0lsRxA6t9rRXZEFoDoX49dlKeBU6/ldRdyDZAedu7PkzIV+7lIvFqK6f
 BwFSYH8eV4Wr/7+64LmHW3dzJR9u8bsqLmJMLRjKHFq+km4zsCyRszuIWnt8RtAj+hm7j
 rPH/sNy5zQtkm8OLq+WGxM1MzS/9YHf/L90=

--ZulxmCdrsPG8ajlcbUIS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

Signed-off-by: Venkata Pyla <venkata.pyla@toshiba-tsip.com>
---
 README.md            |  2 +-
 kas/opt/security.yml | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/security.yml

diff --git a/README.md b/README.md
index 26fbbef..250dbad 100644
--- a/README.md
+++ b/README.md
@@ -39,7 +39,7 @@ card, run
 ## Building Security target images
 Building images for QEMU x86-64bit machine
 
-    ./kas-docker --isar build --target cip-core-image-security kas.yml:board-qemu-amd64.yml
+    ./kas-docker --isar build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
 
 Run the generated securiy images on QEMU (x86-64bit)
 
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
new file mode 100644
index 0000000..237cbeb
--- /dev/null
+++ b/kas/opt/security.yml
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba Corporation, 2020
+#
+# Authors:
+#  Venkata Pyla <venkata.pyla@toshiba-tsip.com>
+#
+# SPDX-License-Identifier: MIT
+#
+header:
+  version: 8
+
+target: cip-core-image-security
-- 
2.20.1

The information contained in this e-mail message and in any
attachments/annexure/appendices is confidential to the 
recipient and may contain privileged information. 
If you are not the intended recipient, please notify the
sender and delete the message along with any 
attachments/annexure/appendices. You should not disclose,
copy or otherwise use the information contained in the
message or any annexure. Any views expressed in this e-mail 
are those of the individual sender except where the sender 
specifically states them to be the views of 
Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.

Although this transmission and any attachments are believed to be
free of any virus or other defect that might affect any computer 
system into which it is received and opened, it is the responsibility
of the recipient to ensure that it is virus free and no responsibility 
is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
damage arising in any way from its use.


--ZulxmCdrsPG8ajlcbUIS
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5066): https://lists.cip-project.org/g/cip-dev/message=
/5066
Mute This Topic: https://lists.cip-project.org/mt/75882938/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--ZulxmCdrsPG8ajlcbUIS--
