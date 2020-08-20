Return-Path: <SRS0=plCM=B6=lists.cip-project.org=bounce+64572+5158+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98049C433DF
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:24:54 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBD8C22BED
	for <cip-dev@archiver.kernel.org>; Thu, 20 Aug 2020 08:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="EhCBiSOg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBD8C22BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5158+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id Q5CxYY4521723xqLuu37hj8d; Thu, 20 Aug 2020 01:24:53 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web12.105817.1597911890781720913
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Aug 2020 01:24:52 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 07K8Oml7030256; Thu, 20 Aug 2020 17:24:48 +0900
X-Iguazu-Qid: 34tKqQuZ1S15EyHSYX
X-Iguazu-QSIG: v=2; s=0; t=1597911888; q=34tKqQuZ1S15EyHSYX; m=o+JwWHOdTrZ8mEXqFEonfyWfx+Getgr3KL29lZLKdPg=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 07K8Olsx024711;
	Thu, 20 Aug 2020 17:24:48 +0900
X-Received: from enc01.localdomain ([106.186.93.100])
	by imx2.toshiba.co.jp  with ESMTP id 07K8OlPx024713;
	Thu, 20 Aug 2020 17:24:47 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.localdomain  with ESMTP id 07K8Olnm018543;
	Thu, 20 Aug 2020 17:24:47 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH 1/2] ci: Rewrite using extends
Date: Thu, 20 Aug 2020 17:24:33 +0900
X-TSB-HOP: ON
Message-Id: <20200820082434.1302460-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: v596oZwyxIwbnvNaZHejLcARx4520388AA=
Content-Type: multipart/mixed; boundary="iH2hnv4CDRsOkYYyKR6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1597911893;
 bh=COpPcYtPptPsQWanrh9lFEPYyKTqv3OyN4/QixuLe4M=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=EhCBiSOg8AjZlFCiBl2Af0oF/mr7TVWTDu3Z4Ee7Mpmd50V4F4KZcp9/padx6eSZtS1
 npaIlhOmFAdTo3LcZYxcE894ETHPFVFbtNrHX3ieeFtd59n8DDPdCxVE/idD9lVmg5lNv
 1gZPBZh56XqJgNObIuulUpT4M3dx0wiX/fA=

--iH2hnv4CDRsOkYYyKR6n
Content-Transfer-Encoding: 8bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml             | 70 +++++++++++++++++++++++++++++---------
 scripts/deploy-cip-core.sh |  8 +++--
 2 files changed, 60 insertions(+), 18 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 3fe7af2..e23345f 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,10 +2,17 @@ image: kasproject/kas-isar:1.1
 
 variables:
   GIT_STRATEGY: clone
+  release: buster
+  extention: base
+  use_rt: enable
+  targz: enable
+  dtb: none
 
-all:
-  stage: build
-  script:
+stages:
+  - build
+
+default:
+  before_script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
     - export ftp_proxy=$FTP_PROXY
@@ -13,20 +20,51 @@ all:
     - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
     - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
 
-    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster simatic-ipc227e
-
+.build_base:
+  stage: build
+  variables:
+    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
+  script:
     - sudo rm -rf build/tmp
-    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster bbb am335x-boneblack.dtb
+    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
+    - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
+    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
+    - kas build ${base_yaml}
+    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
 
-    - sudo rm -rf build/tmp
-    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster iwg20m r8a7743-iwg20d-q7-dbcm-ca.dtb
+# base image
+build:simatic-ipc227e-base:
+  extends:
+    - .build_base
+  variables:
+    target: simatic-ipc227e
 
-    - sudo rm -rf build/tmp
-    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
-    - scripts/deploy-cip-core.sh buster hihope-rzg2m renesas/r8a774a1-hihope-rzg2m-ex.dtb
+build:bbb-base:
+  extends:
+    - .build_base
+  variables:
+    target: bbb
+    dtb: am335x-boneblack.dtb
 
-    - sudo rm -rf build/tmp
-    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
+build:iwg20m-base:
+  extends:
+    - .build_base
+  variables:
+    target: iwg20m
+    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
+
+build:hihope-rzg2m-base:
+  extends:
+    - .build_base
+  variables:
+    target: rzg2m
+    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+
+build:qemu-amd64-base:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extention: security
+    use_rt: disable
+    targz: disable
diff --git a/scripts/deploy-cip-core.sh b/scripts/deploy-cip-core.sh
index 4c8d4c9..5b7eab9 100755
--- a/scripts/deploy-cip-core.sh
+++ b/scripts/deploy-cip-core.sh
@@ -16,9 +16,13 @@ fi
 
 RELEASE=$1
 TARGET=$2
-DTB=$3
+EXTENSION=$3
+DTB=$4
 
 BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET
+if [ "${EXTENSION}" != "base" ] ; then
+	BASE_PATH=build/tmp/deploy/images/$TARGET/cip-core-image-cip-core-$RELEASE-$TARGET-$EXTENSION
+fi
 
 echo "Compressing cip-core-image-cip-core-$RELEASE-$TARGET.wic.img..."
 xz -9 -k $BASE_PATH.wic.img
@@ -38,6 +42,6 @@ fi
 aws s3 cp --no-progress $KERNEL_IMAGE s3://download.cip-project.org/cip-core/$TARGET/
 aws s3 cp --no-progress $BASE_PATH-initrd.img s3://download.cip-project.org/cip-core/$TARGET/
 
-if [ -n "$DTB" ]; then
+if [ "$DTB" != "none" ]; then
 	aws s3 cp --no-progress build/tmp/work/cip-core-*/linux-cip*/*/linux-cip-*/debian/linux-image-cip*/usr/lib/linux-image-*/$DTB s3://download.cip-project.org/cip-core/$TARGET/
 fi
-- 
2.27.0


--iH2hnv4CDRsOkYYyKR6n
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5158): https://lists.cip-project.org/g/cip-dev/message=
/5158
Mute This Topic: https://lists.cip-project.org/mt/76304024/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--iH2hnv4CDRsOkYYyKR6n--
