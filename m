Return-Path: <SRS0=++T8=JF=lists.cip-project.org=bounce+64572+6350+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D849EC433B4
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:32:41 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 374E9610C7
	for <cip-dev@archiver.kernel.org>; Thu,  8 Apr 2021 02:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 374E9610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6350+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 5E3tYY4521723x7YmMq0lReZ; Wed, 07 Apr 2021 19:32:40 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web08.2600.1617849160018314310
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Apr 2021 19:32:40 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 1382WbAD022503; Thu, 8 Apr 2021 11:32:37 +0900
X-Iguazu-Qid: 34ts1PSq8stx9mNBUm
X-Iguazu-QSIG: v=2; s=0; t=1617849157; q=34ts1PSq8stx9mNBUm; m=SXCUZm/4GkbAha9cob8weqcF23Ak8KgUWYwcNgmcphs=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1512) id 1382WbSO035473
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 8 Apr 2021 11:32:37 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 1C98F10007B;
	Thu,  8 Apr 2021 11:32:37 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 1382Wa1b031337;
	Thu, 8 Apr 2021 11:32:36 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: Jan Kiszka <jan.kiszka@siemens.com>
Cc: cip-dev@lists.cip-project.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH 1/2] [isar-cip-core] Add support qemu-arm64
Date: Thu,  8 Apr 2021 11:32:29 +0900
X-TSB-HOP: ON
Message-Id: <20210408023230.388313-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sHIJhUeWLRsvlOOaXF5rX90Vx4520388AA=
Content-Type: multipart/mixed; boundary="3ikNAbzmvMFdEyH0kRDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1617849160;
 bh=SODy8pDgrt8I1FWevq+wQZEl21oY0pj0rfw3WTeHvv8=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=lNrYc0rNydhq2NuUPwn/sjZqSxYJ0EUXWBPq9zESlw9UGeyf6WuPNw5HwOxhN+Gb+dr
 z8+QAf+094uv8S4JX7lBF/kh3XO1P4zD3OWmpoGhQvvnnu7EMBJZrJaIXYTHh+h5cMGHG
 z0x4jq7uuzhwBWZQkDUQY8+g4kHUP24+Lf0=

--3ikNAbzmvMFdEyH0kRDt
Content-Transfer-Encoding: 8bit

This adds configuration files to support QEMU/arm64.
This is intended to be used for a test image of LAVA of CIP.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml               | 19 +++++++++++++++++++
 conf/machine/qemu-arm64.conf | 13 +++++++++++++
 kas/board/qemu-arm64.yml     | 16 ++++++++++++++++
 3 files changed, 48 insertions(+)
 create mode 100644 conf/machine/qemu-arm64.conf
 create mode 100644 kas/board/qemu-arm64.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 8802af1..01d9609 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -74,6 +74,16 @@ build:qemu-amd64-base:
     targz: enable
     deploy: disable
 
+build:qemu-arm64-base:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extention: security
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+
 # test
 build:simatic-ipc227e-test:
   extends:
@@ -105,3 +115,12 @@ build:hihope-rzg2m-test:
     target: hihope-rzg2m
     extention: test
     dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+
+build:qemu-arm64-test:
+  extends:
+    - .build_base
+  variables:
+    target:  qemu-arm64
+    extention: test
+    wic_targz: disable
+    targz: enable
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
new file mode 100644
index 0000000..eb34703
--- /dev/null
+++ b/conf/machine/qemu-arm64.conf
@@ -0,0 +1,13 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2019
+#
+# SPDX-License-Identifier: MIT
+#
+
+DISTRO_ARCH = "arm64"
+
+IMAGE_TYPE ?= "ext4-img"
+USE_CIP_KERNEL_CONFIG = "1"
+KERNEL_DEFCONFIG ?= "cip-kernel-config/4.19.y-cip/arm64/qemu_arm64_defconfig"
diff --git a/kas/board/qemu-arm64.yml b/kas/board/qemu-arm64.yml
new file mode 100644
index 0000000..823964d
--- /dev/null
+++ b/kas/board/qemu-arm64.yml
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
+machine: qemu-arm64
-- 
2.30.0.rc2


--3ikNAbzmvMFdEyH0kRDt
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6350): https://lists.cip-project.org/g/cip-dev/message=
/6350
Mute This Topic: https://lists.cip-project.org/mt/81933307/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--3ikNAbzmvMFdEyH0kRDt--
