Return-Path: <SRS0=ZwDa=BA=lists.cip-project.org=bounce+64572+4950+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E032C433DF
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 12:42:50 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174ED20717
	for <cip-dev@archiver.kernel.org>; Tue, 21 Jul 2020 12:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="LF7AE62N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174ED20717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+4950+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id VsGbYY4521723x6eICeH50Kj; Tue, 21 Jul 2020 05:42:49 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.17993.1595335367147434136
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jul 2020 05:42:48 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 06LCgihQ010585; Tue, 21 Jul 2020 21:42:44 +0900
X-Iguazu-Qid: 34ts1iCWMdGnsfmGPZ
X-Iguazu-QSIG: v=2; s=0; t=1595335364; q=34ts1iCWMdGnsfmGPZ; m=SxUsIlu8fTPu3d77F4uneQA7SlWIvSBBXvaO/7ntfJQ=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1511) id 06LCghTa014873;
	Tue, 21 Jul 2020 21:42:43 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 06LCghD4026708
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2020 21:42:43 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 06LCghSI007734
	for <cip-dev@lists.cip-project.org>; Tue, 21 Jul 2020 21:42:43 +0900
From: "Daniel Sangorrin" <daniel.sangorrin@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Subject: [cip-dev] [isar-cip-core] tests: put all tests into a opt layer
Date: Tue, 21 Jul 2020 21:42:42 +0900
X-TSB-HOP: ON
Message-Id: <20200721124242.1479495-1-daniel.sangorrin@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: nVz6oMEi5et7oS6o3bPoVpjsx4520388AA=
Content-Type: multipart/mixed; boundary="PwgZuyBukdLE0xpTyRvW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1595335369;
 bh=TjWp5iSFUU0WPDwoU0diFrjqAU4mCNfKySFbjZJkAb0=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=LF7AE62NYFy6XI41yjC/dtrxF5rz9xv3lnbe8sdDib85zGJ2DY0Fuv6c3ptuC9Kk6q+
 mQLzIb/0MJORSsvt5IZzHwfhD8Mo8NhfXBi4PYS3YnELDcHy5LWJBtSuZXC1K0TRrj6o7
 4teLXy/hnPYSVH5NKchftcm/zODeHeKFbkg=

--PwgZuyBukdLE0xpTyRvW
Content-Transfer-Encoding: 8bit

having an opt-tests layer makes it easier to see what
tests are installed, and allows creating images without
them as well

Signed-off-by: Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
---
 .gitlab-ci.yml                                |  8 ++++----
 README.md                                     |  4 ++++
 opt-tests.yml                                 | 19 +++++++++++++++++++
 recipes-core/customizations/customizations.bb |  5 ++---
 recipes-core/images/cip-core-image.bb         |  3 +--
 5 files changed, 30 insertions(+), 9 deletions(-)
 create mode 100644 opt-tests.yml

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f1dc91..90eec1f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -13,17 +13,17 @@ all:
     - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
     - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
 
-    - kas build kas.yml:board-simatic-ipc227e.yml:opt-rt.yml:opt-targz-img.yml
+    - kas build kas.yml:board-simatic-ipc227e.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
     - scripts/deploy-cip-core.sh buster simatic-ipc227e
 
     - sudo rm -rf build/tmp
-    - kas build kas.yml:board-bbb.yml:opt-rt.yml:opt-targz-img.yml
+    - kas build kas.yml:board-bbb.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
     - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
 
     - sudo rm -rf build/tmp
-    - kas build kas.yml:board-iwg20m.yml:opt-rt.yml:opt-targz-img.yml
+    - kas build kas.yml:board-iwg20m.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
     - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
 
     - sudo rm -rf build/tmp
-    - kas build kas.yml:board-rzg2m.yml:opt-rt.yml:opt-targz-img.yml
+    - kas build kas.yml:board-rzg2m.yml:opt-tests.yml:opt-rt.yml:opt-targz-img.yml
     - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
diff --git a/README.md b/README.md
index bbad1a0..7339396 100644
--- a/README.md
+++ b/README.md
@@ -25,6 +25,10 @@ this:
 
 This image can be run using `start-qemu.sh x86`.
 
+If you want to include the testing layer add ':opt-tests.yml' like this
+
+    ./kas-docker --isar build kas.yml:board-qemu-amd64.yml:opt-tests.yml
+
 The BeagleBone Black target is selected by `... kas.yml:board-bbb.yml`. In
 order to build the image with the PREEMPT-RT kernel, append `:opt-rt.yml` to
 the above. Append ':opt-4.4.yml' to use the kernel version 4.4 instead of 4.19.
diff --git a/opt-tests.yml b/opt-tests.yml
new file mode 100644
index 0000000..a1f431d
--- /dev/null
+++ b/opt-tests.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Toshiba corp., 2020
+#
+# Authors:
+#  Daniel Sangorrin <daniel.sangorrin@toshiba.co.jp>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 8
+
+local_conf_header:
+  tests: |
+    IMAGE_INSTALL += "ltp-full"
+    IMAGE_PREINSTALL += "rt-tests stress-ng"
+
diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 38881fb..cbd6daf 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -11,7 +11,7 @@
 
 inherit dpkg-raw
 
-DESCRIPTION = "CIP Core image demo & test customizations"
+DESCRIPTION = "CIP Core image demo customizations"
 
 SRC_URI = " \
     file://postinst \
@@ -21,8 +21,7 @@ SRC_URI = " \
 DEPENDS += "sshd-regen-keys"
 
 DEBIAN_DEPENDS = " \
-    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys, \
-    rt-tests, stress-ng"
+    ifupdown, isc-dhcp-client, net-tools, iputils-ping, ssh, sshd-regen-keys"
 
 do_install() {
 	install -v -d ${D}/etc/network/interfaces.d
diff --git a/recipes-core/images/cip-core-image.bb b/recipes-core/images/cip-core-image.bb
index 9ee4b25..188c714 100644
--- a/recipes-core/images/cip-core-image.bb
+++ b/recipes-core/images/cip-core-image.bb
@@ -15,5 +15,4 @@ ISAR_RELEASE_CMD = "git -C ${LAYERDIR_cip-core} describe --tags --dirty --always
 DESCRIPTION = "CIP Core image"
 
 IMAGE_INSTALL += "customizations"
-# for cip-testing
-IMAGE_INSTALL += "ltp-full"
+
-- 
2.25.1


--PwgZuyBukdLE0xpTyRvW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#4950): https://lists.cip-project.org/g/cip-dev/message=
/4950
Mute This Topic: https://lists.cip-project.org/mt/75702560/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--PwgZuyBukdLE0xpTyRvW--
