Return-Path: <SRS0=bNqC=CJ=lists.cip-project.org=bounce+64572+5330+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9CDC433E2
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 01:02:56 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D42EB20757
	for <cip-dev@archiver.kernel.org>; Mon, 31 Aug 2020 01:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="bMNNyAWP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D42EB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5330+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id GyTmYY4521723xfWf1wkiEh3; Sun, 30 Aug 2020 18:02:55 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web11.43646.1598835771889632340
 for <cip-dev@lists.cip-project.org>;
 Sun, 30 Aug 2020 18:02:54 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 07V12nVf025835; Mon, 31 Aug 2020 10:02:49 +0900
X-Iguazu-Qid: 2wGqzHwiyhM6YIU5tg
X-Iguazu-QSIG: v=2; s=0; t=1598835769; q=2wGqzHwiyhM6YIU5tg; m=3bEip78Rc36WzhwZC4/aWDKWuAJZx5LXnt5YOdbQ7eE=
X-Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	by relay.securemx.jp (mx-mr1112) id 07V12mRI039058;
	Mon, 31 Aug 2020 10:02:48 +0900
X-Received: from enc02.toshiba.co.jp ([61.202.160.51])
	by imx12.toshiba.co.jp  with ESMTP id 07V12mWr005404;
	Mon, 31 Aug 2020 10:02:48 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 07V12lWQ017066;
	Mon, 31 Aug 2020 10:02:47 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [isar-cip-core][PATCH] ci: Change to single job
Date: Mon, 31 Aug 2020 10:02:44 +0900
X-TSB-HOP: ON
Message-Id: <20200831010244.2629769-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Jsny7EOQBEjuKRANAfIy6AX1x4520388AA=
Content-Type: multipart/mixed; boundary="U3h0S8IFycHliUjv9yej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598835775;
 bh=IXphnzegZk/wwwemjPta7wPWlfXYEm94H5x4uC00btA=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=bMNNyAWPx/MF5ieG3sbIAGVqzkVE/QU6ZhWCNYHccfuxY+a952lVgUHMpheCCxEOPL6
 W3JmvVU3AsXGzarGphWkyxA8cfSF0A1Uibk4u2Ko8HHQZYIH/jdDyDJvO46RCrso+ISab
 LeBYqzWShIsikC3YQdcYqeTg03nzpvtTXNI=

--U3h0S8IFycHliUjv9yej
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


--U3h0S8IFycHliUjv9yej
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5330): https://lists.cip-project.org/g/cip-dev/message=
/5330
Mute This Topic: https://lists.cip-project.org/mt/76525805/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--U3h0S8IFycHliUjv9yej--
