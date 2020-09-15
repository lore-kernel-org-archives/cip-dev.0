Return-Path: <SRS0=6i44=CY=lists.cip-project.org=bounce+64572+5453+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65ECC43461
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:22:53 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D0222B49
	for <cip-dev@archiver.kernel.org>; Tue, 15 Sep 2020 14:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="Pi3M4ALV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D0222B49
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=toshiba-tsip.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5453+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id umJ2YY4521723xZncBJlpMPC; Tue, 15 Sep 2020 07:22:53 -0700
X-Received: from peak.toshiba-tesi.com (peak.toshiba-tesi.com [])
 by mx.groups.io with SMTP id smtpd.web10.14564.1600179768333343159
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Sep 2020 07:22:52 -0700
IronPort-SDR: JD7+T9GYbXBAlL428vjnHvn3UEKZG5HGWq7ylM3XE+piPQQkPqrjP7S4XoMA9Nfb9iJxHGc/V5
 UnsftuhsIbWw==
X-IronPort-AV: E=Sophos;i="5.76,430,1592850600"; 
   d="scan'208";a="6248123"
X-Received: from unknown (HELO TOSBLRMBX0119.TOSHIBA-TSIP.COM) ([172.28.80.118])
  by peak.toshiba-tesi.com with ESMTP; 15 Sep 2020 20:33:42 +0530
X-Received: from TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) by
 TOSBLRMBX0119.TOSHIBA-TSIP.COM (172.28.80.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 15 Sep 2020 19:52:50 +0530
X-Received: from pvenkat.TOSHIBA-TSIP.COM (172.28.80.121) by
 TOSBLRMBX0319.TOSHIBA-TSIP.COM (172.28.80.120) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 15 Sep 2020 19:52:46 +0530
From: "Venkata Pyla" <venkata.pyla@toshiba-tsip.com>
To: <daniel.sangorrin@toshiba.co.jp>
CC: venkata pyla <venkata.pyla@toshiba-tsip.com>,
	<cip-dev@lists.cip-project.org>
Subject: [cip-dev] [cip-core:deby 1/3] cip-security: Create new layer for cip security
Date: Tue, 15 Sep 2020 19:53:42 +0530
Message-ID: <20200915142345.179-2-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
References: <20200915142345.179-1-venkata.pyla@toshiba-tsip.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: FMt0WOuxVFIjic1bkOKGMAVux4520388AA=
Content-Type: multipart/mixed; boundary="A5dxNf4mHYkLSWVbGNXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1600179773;
 bh=vSezoPakSuJV7KlPgFGjpEjUBPHfYI0yLyGrzJeTl3g=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=Pi3M4ALVeEwmTROGsKyJM6JfV5lj+7v2bHhcpe1aPaSlD+tDY6fj9Onv9Xbb/d1Bz6f
 yCaeuqoWrNijbtJLfdjXqKWTqa43lXdeqIuAufEe1baLx6KPVNJnSVqHebRsuACmYajEj
 4GHJ5H+xVjM8F0wHMf8689ecy4eGi2L7lmY=

--A5dxNf4mHYkLSWVbGNXf
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

From: venkata pyla <venkata.pyla@toshiba-tsip.com>

This layer enables security packages and default configurations
required to evaluate IEC62443-4-2 assessment

Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
---
 README.md                         |  5 +++++
 kas/opt/security.yml              | 32 +++++++++++++++++++++++++++++++
 meta-cip-security/conf/layer.conf | 18 +++++++++++++++++
 3 files changed, 55 insertions(+)
 create mode 100644 kas/opt/security.yml
 create mode 100644 meta-cip-security/conf/layer.conf

diff --git a/README.md b/README.md
index f90e040..f59dd0c 100644
--- a/README.md
+++ b/README.md
@@ -88,3 +88,8 @@ LTP test image for QEMU arm64 / hihope-rzg2m
 
     $ ./scripts/kas-build.sh kas/board/qemuarm64.yml:kas/opt/deby.yml:kas/opt/dhcp.yml:kas/opt/ltp.yml
 
+Create Security image for QEMU x86-64
+-------------------------------------
+
+    $ ./scripts/kas-build.sh kas/board/qemux86-64.yml:kas/opt/deby.yml:kas/opt/security.yml
+
diff --git a/kas/opt/security.yml b/kas/opt/security.yml
new file mode 100644
index 0000000..e84290c
--- /dev/null
+++ b/kas/opt/security.yml
@@ -0,0 +1,32 @@
+#
+# CIP Core tiny profile with Security
+# packages and configuration
+#
+# Copyright (c) 2019 TOSHIBA Corp.
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+    version: 8
+
+repos:
+    meta-cip-security:
+       layers:
+          meta-cip-security:
+
+local_conf_header:
+  security: |
+    DISTRO_FEATURES_append += " pam"
+    CORE_IMAGE_EXTRA_INSTALL += " \
+                                 aide aide-common \
+                                 openssl openssl-bin \
+                                 openssh openssh-misc \
+                                 chrony chronyc \
+                                 libpam pam-plugin-cracklib pam-plugin-tally2 \
+                                 syslog-ng \
+                                 acl \
+                                 sudo \
+                                 auditd \
+                                 util-linux \
+                                 "
diff --git a/meta-cip-security/conf/layer.conf b/meta-cip-security/conf/layer.conf
new file mode 100644
index 0000000..b015436
--- /dev/null
+++ b/meta-cip-security/conf/layer.conf
@@ -0,0 +1,18 @@
+# We have a conf and classes directory, add to BBPATH
+BBPATH =. "${LAYERDIR}:"
+
+# We have recipes-* directories, add to BBFILES
+BBFILES += "${LAYERDIR}/recipes-*/*/*.bb \
+            ${LAYERDIR}/recipes-*/*/*.bbappend"
+
+BBFILE_COLLECTIONS += "cip-security"
+BBFILE_PATTERN_cip-security = "^${LAYERDIR}/"
+BBFILE_PRIORITY_cip-security = "11"
+
+# This should only be incremented on significant changes that will
+# cause compatibility issues with other layers
+LAYERVERSION_cip-security = "1"
+
+LAYERDEPENDS_cip-security = "debian"
+
+LAYERSERIES_COMPAT_cip-security = "warrior"
-- 
2.27.0.windows.1

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


--A5dxNf4mHYkLSWVbGNXf
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5453): https://lists.cip-project.org/g/cip-dev/message=
/5453
Mute This Topic: https://lists.cip-project.org/mt/76865927/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--A5dxNf4mHYkLSWVbGNXf--
