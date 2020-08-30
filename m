Return-Path: <SRS0=aAKt=CI=lists.cip-project.org=bounce+64572+5329+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D6CC433E2
	for <cip-dev@archiver.kernel.org>; Sun, 30 Aug 2020 23:31:40 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00E720BED
	for <cip-dev@archiver.kernel.org>; Sun, 30 Aug 2020 23:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="B6Alchgv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00E720BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5329+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id wGwaYY4521723xKRbFVfKvyH; Sun, 30 Aug 2020 16:31:39 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.42753.1598830296913058530
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 16:31:38 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 07UNVY89027874; Mon, 31 Aug 2020 08:31:34 +0900
X-Iguazu-Qid: 34tMd2lTgxia303UCR
X-Iguazu-QSIG: v=2; s=0; t=1598830294; q=34tMd2lTgxia303UCR; m=ofX72TCRjmUBxPs2HiIKhdzVe4JPkbsi8/lNhnDxQ40=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1510) id 07UNVXnY010917;
	Mon, 31 Aug 2020 08:31:33 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07UNVXbc009973;
	Mon, 31 Aug 2020 08:31:33 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07UNVWVt027707;
	Mon, 31 Aug 2020 08:31:33 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH] ci: Change to single job
Date: Mon, 31 Aug 2020 08:31:30 +0900
X-TSB-HOP: ON
Message-Id: <20200830233130.2618199-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 7j6BFIyLxPyV0hmw02vfGX8kx4520388AA=
Content-Type: multipart/mixed; boundary="8Fj6EfwHcEE0BqzDIJpq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598830299;
 bh=hI4JXX5pS3F/N1l3NJykQoeyLV7XURdvkRKr6mz8Leg=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=B6AlchgvmiV39UoIUTalaDVxEFz4WnhBFlCVzieB0vCz+wZ3gYqNqI/woF9IjM2dJsk
 KoNM3NIB1d1jr1ClqtmbpCeEbvVsm1bP03AHrwalkgx++Zj6ifXX9BSG2Y4tHaNS3+gl6
 psFNMoiGfJaWO60SC9cpRQkXOtdm5T/+mcs=

--8Fj6EfwHcEE0BqzDIJpq
Content-Transfer-Encoding: 8bit

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .gitlab-ci.yml | 122 +++++++++++++------------------------------------
 1 file changed, 32 insertions(+), 90 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 802dbcd..5bd4774 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -2,17 +2,10 @@ image: kasproject/kas-isar:1.1
 
 variables:
   GIT_STRATEGY: clone
-  release: buster
-  extention: base
-  use_rt: enable
-  targz: enable
-  dtb: none
 
-stages:
-  - build
-
-default:
-  before_script:
+all:
+  stage: build
+  script:
     - export http_proxy=$HTTP_PROXY
     - export https_proxy=$HTTPS_PROXY
     - export ftp_proxy=$FTP_PROXY
@@ -20,83 +13,32 @@ default:
     - export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
     - export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
 
-.build_base:
-  stage: build
-  variables:
-    base_yaml: "kas-cip.yml:kas/board/${target}.yml"
-  script:
-    - sudo rm -rf build/tmp
-    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
-    - if [ "${extention}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extention}.yml"; fi;
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
-    - kas build ${base_yaml}
-    - scripts/deploy-cip-core.sh ${release} ${target} ${extention} ${dtb}
-
-# base image
-build:simatic-ipc227e-base:
-  extends:
-    - .build_base
-  variables:
-    target: simatic-ipc227e
-
-build:bbb-base:
-  extends:
-    - .build_base
-  variables:
-    target: bbb
-    dtb: am335x-boneblack.dtb
-
-build:iwg20m-base:
-  extends:
-    - .build_base
-  variables:
-    target: iwg20m
-    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-
-build:hihope-rzg2m-base:
-  extends:
-    - .build_base
-  variables:
-    target: rzg2m
-    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
-
-build:qemu-amd64-base:
-  extends:
-    - .build_base
-  variables:
-    target: qemu-amd64
-    extention: security
-    use_rt: disable
-    targz: disable
-
-# test
-build:simatic-ipc227e-test:
-  extends:
-    - .build_base
-  variables:
-    target: simatic-ipc227e
-    extention: test
-
-build:bbb-test:
-  extends:
-    - .build_base
-  variables:
-    target: bbb
-    extention: test
-    dtb: am335x-boneblack.dtb
-
-build:iwg20m-test:
-  extends:
-    - .build_base
-  variables:
-    target: iwg20m
-    extention: test
-    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
-
-build:hihope-rzg2m-test:
-  extends:
-    - .build_base
-  variables:
-    target: rzg2m
-    extention: test
-    dtb: renesas/r8a774a1-hihope-rzg2m-ex.dtb
+    # simatic-ipc227e
+    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster simatic-ipc227e base none
+    # bbb
+    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster bbb base am335x-boneblack.dtb
+    # iwg20m
+    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster iwg20m base r8a7743-iwg20d-q7-dbcm-ca.dtb
+    # rzg2m
+    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster rzg2m base renesas/r8a774a1-hihope-rzg2m-ex.dtb
+
+    # qemu-amd64 / security
+    - kas build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/security.yml
+    - scripts/deploy-cip-core.sh buster qemu-amd64 security base
+
+    # simatic-ipc227e / test
+    - kas build kas-cip.yml:kas/board/simatic-ipc227e.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster simatic-ipc227e test none
+    # bbb / test
+    - kas build kas-cip.yml:kas/board/bbb.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster bbb test am335x-boneblack.dtb
+    # iwg20m / test
+    - kas build kas-cip.yml:kas/board/iwg20m.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster iwg20m test r8a7743-iwg20d-q7-dbcm-ca.dtb
+    # rzg2m / test
+    - kas build kas-cip.yml:kas/board/rzg2m.yml:kas/opt/rt.yml:kas/opt/test.yml:kas/opt/targz-img.yml
+    - scripts/deploy-cip-core.sh buster rzg2m test renesas/r8a774a1-hihope-rzg2m-ex.dtb
-- 
2.27.0


--8Fj6EfwHcEE0BqzDIJpq
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5329): https://lists.cip-project.org/g/cip-dev/message=
/5329
Mute This Topic: https://lists.cip-project.org/mt/76524627/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--8Fj6EfwHcEE0BqzDIJpq--
