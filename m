Return-Path: <SRS0=M+qp=CQ=lists.cip-project.org=bounce+64572+5418+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BAEC43461
	for <cip-dev@archiver.kernel.org>; Mon,  7 Sep 2020 04:18:04 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EB521775
	for <cip-dev@archiver.kernel.org>; Mon,  7 Sep 2020 04:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="AOv2C16s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EB521775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5418+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id zlaGYY4521723xa7F2yU3E4t; Sun, 06 Sep 2020 21:18:03 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web11.34447.1599452280601606761
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Sep 2020 21:18:02 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 0874Hwdg004300; Mon, 7 Sep 2020 13:17:58 +0900
X-Iguazu-Qid: 34tKSwRU9BvZ4QfznR
X-Iguazu-QSIG: v=2; s=0; t=1599452277; q=34tKSwRU9BvZ4QfznR; m=wJsOQVK7XNiJ0KVTbR2zZwYh6kUsJmsWQBGqg1GLUmI=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1510) id 0874Hv6h009890;
	Mon, 7 Sep 2020 13:17:57 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0874Hvw8010480;
	Mon, 7 Sep 2020 13:17:57 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0874HuEH030030;
	Mon, 7 Sep 2020 13:17:56 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: Chris.Paterson2@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [PATCH] linux-4.19.y*: Add test for Xilinx ZYNQMP zcu102 board
Date: Mon,  7 Sep 2020 13:17:53 +0900
X-TSB-HOP: ON
Message-Id: <20200907041753.3052716-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: IQkH9nI7SHTbGB40lVIlpsZJx4520388AA=
Content-Type: multipart/mixed; boundary="7Ow5bFz7YyDmdpdmfRcm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1599452283;
 bh=bHpb+LJYBeHLPkIuR+8mHCot/jT5OKDnfv3PoBXXvIs=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=AOv2C16s2o2Ip0reypV0R6Eoi2dJ1puvJ1iqjTD64KLBhb3DCZj2NkYb58zo6Xda2V0
 ffZ/F3J2tciz7ea4f44iz8WqJ9z6gXcPAw21g0KbyY/BfSO0nUcd/1B45yYDrTZh5kMnd
 D2BSbzkI4lfryRruPKctRAgvYC25ViPiuys=

--7Ow5bFz7YyDmdpdmfRcm
Content-Transfer-Encoding: 8bit

Add test target for Cybertrust supported ZYNQMP zcu102 board.
boot and smc test are executed automatically, but LTP is set to be
executed manually because this board is not official yet.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 trees/linux-4.19.y-cip.yml | 25 +++++++++++++++++++++++++
 trees/linux-4.19.y.yml     | 10 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/trees/linux-4.19.y-cip.yml b/trees/linux-4.19.y-cip.yml
index 7efc3f5..236e4bf 100644
--- a/trees/linux-4.19.y-cip.yml
+++ b/trees/linux-4.19.y-cip.yml
@@ -203,6 +203,16 @@ test:x86_siemens_ipc227e_defconfig:
     DEVICES: x86
     TESTS: boot smc
 
+test:arm64_ctj_zynqmp_defconfig:
+  extends: .test
+  needs: ["build:arm64_ctj_zynqmp_defconfig"]
+  variables:
+    BUILD_ARCH: arm64
+    CONFIG: ctj_zynqmp_defconfig
+    DEVICES: zynqmp-zcu102
+    DTBS: zynqmp-zcu102-rev1.0.dtb
+    TESTS: boot smc
+
 ###############################
 # Test: RT CIP configurations #
 ###############################
@@ -274,6 +284,21 @@ test:x86_cip_qemu_defconfig_release:
     - /^.*linux-4.19.y-cip-rt-rc$/
     - /^.*linux-rc$
 
+test:arm64_ctj_zynqmp_defconfig_trail:
+  when: manual
+  extends: .test
+  needs: ["build:arm64_ctj_zynqmp_defconfig"]
+  variables:
+    BUILD_ARCH: arm64
+    CONFIG: ctj_zynqmp_defconfig
+    DEVICES: zynqmp-zcu102
+    DTBS: zynqmp-zcu102-rev1.0.dtb
+    TESTS: ltp
+  only:
+    - /^.*linux-4.19.y-cip-rc$/
+    - /^.*linux-4.19.y-cip-rt-rc$/
+    - /^.*linux-rc$/
+
 ########################################################
 # Verify: Check rebase branches & tags for differences #
 ########################################################
diff --git a/trees/linux-4.19.y.yml b/trees/linux-4.19.y.yml
index 630f5ac..0d7403f 100644
--- a/trees/linux-4.19.y.yml
+++ b/trees/linux-4.19.y.yml
@@ -185,6 +185,16 @@ test:x86_siemens_ipc227e_defconfig:
     DEVICES: x86
     TESTS: boot smc
 
+test:arm64_ctj_zynqmp_defconfig:
+  extends: .test
+  needs: ["build:arm64_ctj_zynqmp_defconfig"]
+  variables:
+    BUILD_ARCH: arm64
+    CONFIG: ctj_zynqmp_defconfig
+    DEVICES: zynqmp-zcu102
+    DTBS: zynqmp-zcu102-rev1.0.dtb
+    TESTS: boot smc
+
 ################################
 # Test: Non-CIP configurations #
 ################################
-- 
2.27.0


--7Ow5bFz7YyDmdpdmfRcm
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5418): https://lists.cip-project.org/g/cip-dev/message=
/5418
Mute This Topic: https://lists.cip-project.org/mt/76680488/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--7Ow5bFz7YyDmdpdmfRcm--
