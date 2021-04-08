Return-Path: <SRS0=vRjF=JF=lists.cip-project.org=bounce+64572+6351+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FE6C433ED
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:32:47 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD0DA61074
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:32:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD0DA61074
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6351+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id WzvgYY4521723xhOSoA71tyz; Wed, 07 Apr 2021 19:32:46 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web09.2651.1617849165862359790
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 19:32:46 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 1382WhFs020072; Thu, 8 Apr 2021 11:32:43 +0900
X-Iguazu-Qid: 2wHHbBTw9hdzxHTKk5
X-Iguazu-QSIG: v=2; s=0; t=1617849163; q=2wHHbBTw9hdzxHTKk5; m=JREGrg7pYSRaWbXUy0cTjmv5V52vPA13lFQ84DRd89k=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1113) id 1382WgBd018167
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 8 Apr 2021 11:32:42 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 8DED610007B;
	Thu,  8 Apr 2021 11:32:42 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1382WgWk031392;
	Thu, 8 Apr 2021 11:32:42 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 2/2] [isar-cip-core] Add support qemu-arm
Date: Thu,  8 Apr 2021 11:32:30 +0900
X-TSB-HOP: ON
Message-Id: <20210408023230.388313-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20210408023230.388313-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20210408023230.388313-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: qdzu005ZJ6RHdFUn4K6fK3lix4520388AA=
Content-Type: multipart/mixed; boundary="MyUK7qzRb5K4ZER3XJSD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617849166;
 bh=nVj6KjxbdguK2DtOOY2cUezyW2nVFJlIsY9zWDzS4BY=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=uApYYVI+17CjmMBNR5oMESs2LKyvKaD9GcFOFqqeGFe3vJiCntm0ZoQx+nsKYqQKtsY
 +PSTUxFG/0D6WnkRbYcEDFrRCoQOrCGF8pVth+6ZNQ61+bQQZ+ZRw9onOgJSE4Pb4XRew
 nLfck5n+VGBxq+NZ4d7GUq639R8/vOZvgcE=

--MyUK7qzRb5K4ZER3XJSD
Content-Transfer-Encoding: 8bit

This adds configuration files to support QEMU/arm.
This is intended to be used for a test image of LAVA of CIP.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml             | 19 +++++++++++++++++++
 conf/machine/qemu-arm.conf | 14 ++++++++++++++
 kas/board/qemu-arm.yml     | 16 ++++++++++++++++
 3 files changed, 49 insertions(+)
 create mode 100644 conf/machine/qemu-arm.conf
 create mode 100644 kas/board/qemu-arm.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 01d9609..b53d9cc 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -84,6 +84,16 @@ build:qemu-arm64-base:
     wic_targz: disable
     targz: enable
 
+build:qemu-arm-base:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm
+    extention: security
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+
 # test
 build:simatic-ipc227e-test:
   extends:
@@ -124,3 +134,12 @@ build:qemu-arm64-test:
     extention: test
     wic_targz: disable
     targz: enable
+
+build:qemu-arm-test:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm
+    extention: test
+    wic_targz: disable
+    targz: enable
diff --git a/conf/machine/qemu-arm.conf b/conf/machine/qemu-arm.conf
new file mode 100644
index 0000000..81a22c1
--- /dev/null
+++ b/conf/machine/qemu-arm.conf
@@ -0,0 +1,14 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) TOSHIBA CORPORATION, 2021
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "armhf"
+
+IMAGE_TYPE ?= "ext4-img"
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm/qemu_arm_defconfig"
diff --git a/kas/board/qemu-arm.yml b/kas/board/qemu-arm.yml
new file mode 100644
index 0000000..9bf9728
--- /dev/null
+++ b/kas/board/qemu-arm.yml
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+# Copyright (c) TOSHIBA CORPORATION, 2021
+#
+# Authors:
+#  Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 10
+
+machine: qemu-arm
-- 
2.30.0.rc2


--MyUK7qzRb5K4ZER3XJSD
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6351): https://lists.cip-project.org/g/cip-dev/message=
/6351
Mute This Topic: https://lists.cip-project.org/mt/81933310/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--MyUK7qzRb5K4ZER3XJSD--
