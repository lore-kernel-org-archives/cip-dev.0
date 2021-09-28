Return-Path: <SRS0=Wp5+=OS=lists.cip-project.org=bounce+64572+6758+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2396C433EF
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:54 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87DA160ED7
	for <cip-dev@archiver.kernel.org>; Tue, 28 Sep 2021 18:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 87DA160ED7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=siemens.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id sjZFYY4521723xujKOnWV5IP; Tue, 28 Sep 2021 11:49:54 -0700
X-Received: from gecko.sbs.de (gecko.sbs.de [194.138.37.40])
 by mx.groups.io with SMTP id smtpd.web11.760.1632854993278843682
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Sep 2021 11:49:53 -0700
X-Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
	by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 18SInopS021516
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Sep 2021 20:49:50 +0200
X-Received: from md2dvrtc.fritz.box ([139.22.32.51])
	by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 18SInmh0026555;
	Tue, 28 Sep 2021 20:49:49 +0200
From: "Quirin Gylstorff" <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org, dinesh.kumar@toshiba-tsip.com
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [cip-dev][isar-cip-core][PATCH 2/2] kas/opt/efibootguard: Move setting of IMAGE_TYPE
Date: Tue, 28 Sep 2021 20:49:48 +0200
Message-ID: <20210928184948.737071-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
References: <20210928184948.737071-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: rGzMRwH7I3M9LpSbHT6cDeQkx4520388AA=
Content-Type: multipart/mixed; boundary="ORJDEI5SI9nRyOViCXL9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1632854994;
 bh=/HV30vzoK+Mvupuc4FTQ4G1Fu3gBtiEYpoFTg2BAxRA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=mP9n0SfL8FvlW6d2A/QYlwReGIKkNxnqbDViz53YbSWfdMb+GWdcm52UqLxg3GNtUhn
 RA4ygjngm75YxLOg1mFpk4OzAc66KEOo4eUldLGcMb3Uc0GDEKlbsddM+wTmUJ8xbZo8J
 zzZys7ypASxLzWYLNu8H7bqgu2bFC6Vykvo=
Message-ID: <20210928184948.CyweMK8GgelNPuFVMaTF1OrJUCtJ1G-3X9DeSeSKkUE@z>

--ORJDEI5SI9nRyOViCXL9
Content-Transfer-Encoding: 8bit

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This seperates the image type from the boot loader.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/efibootguard.yml |  1 -
 kas/opt/wic-img.yml      | 19 +++++++++++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)
 create mode 100644 kas/opt/wic-img.yml

diff --git a/kas/opt/efibootguard.yml b/kas/opt/efibootguard.yml
index 705a76d..4e8be69 100644
--- a/kas/opt/efibootguard.yml
+++ b/kas/opt/efibootguard.yml
@@ -23,6 +23,5 @@ local_conf_header:
   efibootguard-wic: |
     WDOG_TIMEOUT ?= "60"
     WICVARS += "WDOG_TIMEOUT"
-    IMAGE_TYPE ?= "wic-img"
     WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks"
 
diff --git a/kas/opt/wic-img.yml b/kas/opt/wic-img.yml
new file mode 100644
index 0000000..2b02b42
--- /dev/null
+++ b/kas/opt/wic-img.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2021
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# This kas file set the IMAGE_TYPE to wic-img
+# The device specific WKS_FILE needs to be set seperately.
+
+header:
+  version: 10
+
+local_conf_header:
+  image-type: |
+    IMAGE_TYPE = "wic-img"
-- 
2.30.2


--ORJDEI5SI9nRyOViCXL9
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6758): https://lists.cip-project.org/g/cip-dev/message/=
6758
Mute This Topic: https://lists.cip-project.org/mt/85931981/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--ORJDEI5SI9nRyOViCXL9--
