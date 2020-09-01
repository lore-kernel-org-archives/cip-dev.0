Return-Path: <SRS0=zYBc=CK=lists.cip-project.org=bounce+64572+5345+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D6DC433E2
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:32 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2251F208DB
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="m0T8LGpx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2251F208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5345+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id EpFjYY4521723xXBzKi8E9wV; Mon, 31 Aug 2020 23:13:31 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.6931.1598940809031685385
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 23:13:30 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 0816DR93017480; Tue, 1 Sep 2020 15:13:27 +0900
X-Iguazu-Qid: 34tMXyHquhcZ6v80qW
X-Iguazu-QSIG: v=2; s=0; t=1598940806; q=34tMXyHquhcZ6v80qW; m=BR9LFQ5V/jFYE/FShm2+oe/nmRoVeVYD3N5faKNLqcY=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 0816DQfN017545;
	Tue, 1 Sep 2020 15:13:26 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0816DPSV001934;
	Tue, 1 Sep 2020 15:13:25 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0816DMBU026918;
	Tue, 1 Sep 2020 15:13:25 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [linux-cip-ci][PATCH 1/3] lava_templates: Add support de0-nano-soc for deby
Date: Tue,  1 Sep 2020 15:13:12 +0900
X-TSB-HOP: ON
Message-Id: <20200901061314.2749466-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: Fq7XOGCk1luNgCePWBFjRIBhx4520388AA=
Content-Type: multipart/mixed; boundary="Wr61EF3Suf0mQrB5s9LH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598940811;
 bh=LYbs90A3s9kJ48/C29oK7GTVyj2pJMDB1bUr8FNDGsQ=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=m0T8LGpxbmggGMRgreq+AvNwGExRgZtjXiQ1t5d+7K2T/RXGuh4ZDMYLjP3tvLG8/gW
 8cPgxiMAUojSC39I4hCvdVQ2gM9HrosWzcuQY7TNWUc6fvQ1sxI7rYvJ3xN++1RLCD5jT
 bWuaNZm5rTpBGwdtbB1pD7KCDSEHe3n70d4=

--Wr61EF3Suf0mQrB5s9LH
Content-Transfer-Encoding: 8bit

Add ltp and boot/smc test YAML files for de0-nano-soc with deby.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../action_deby-buster-ltp_de0-nano-soc.yaml      | 15 +++++++++++++++
 .../action_deby-buster_de0-nano-soc.yaml          | 15 +++++++++++++++
 .../boot_deby-buster-ltp_de0-nano-soc.yaml        |  1 +
 lava_templates/boot_deby-buster_de0-nano-soc.yaml | 12 ++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 lava_templates/action_deby-buster-ltp_de0-nano-soc.yaml
 create mode 100644 lava_templates/action_deby-buster_de0-nano-soc.yaml
 create mode 120000 lava_templates/boot_deby-buster-ltp_de0-nano-soc.yaml
 create mode 100644 lava_templates/boot_deby-buster_de0-nano-soc.yaml

diff --git a/lava_templates/action_deby-buster-ltp_de0-nano-soc.yaml b/lava_templates/action_deby-buster-ltp_de0-nano-soc.yaml
new file mode 100644
index 0000000..215750a
--- /dev/null
+++ b/lava_templates/action_deby-buster-ltp_de0-nano-soc.yaml
@@ -0,0 +1,15 @@
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: zimage
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-minimal-ltp-de0-nano-soc.tar.bz2
+      compression: bz2
+    dtb:
+      url: DTB_URL
diff --git a/lava_templates/action_deby-buster_de0-nano-soc.yaml b/lava_templates/action_deby-buster_de0-nano-soc.yaml
new file mode 100644
index 0000000..215750a
--- /dev/null
+++ b/lava_templates/action_deby-buster_de0-nano-soc.yaml
@@ -0,0 +1,15 @@
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: zimage
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-minimal-ltp-de0-nano-soc.tar.bz2
+      compression: bz2
+    dtb:
+      url: DTB_URL
diff --git a/lava_templates/boot_deby-buster-ltp_de0-nano-soc.yaml b/lava_templates/boot_deby-buster-ltp_de0-nano-soc.yaml
new file mode 120000
index 0000000..42fb694
--- /dev/null
+++ b/lava_templates/boot_deby-buster-ltp_de0-nano-soc.yaml
@@ -0,0 +1 @@
+boot_deby-buster_de0-nano-soc.yaml
\ No newline at end of file
diff --git a/lava_templates/boot_deby-buster_de0-nano-soc.yaml b/lava_templates/boot_deby-buster_de0-nano-soc.yaml
new file mode 100644
index 0000000..85debd4
--- /dev/null
+++ b/lava_templates/boot_deby-buster_de0-nano-soc.yaml
@@ -0,0 +1,12 @@
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: "de0-nano-soc login:"
+      username: root
+    prompts:
+      - "# "
+    method: u-boot
+    commands: nfs
+    timeout:
+      minutes: 5
+
-- 
2.27.0


--Wr61EF3Suf0mQrB5s9LH
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5345): https://lists.cip-project.org/g/cip-dev/message=
/5345
Mute This Topic: https://lists.cip-project.org/mt/76551100/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--Wr61EF3Suf0mQrB5s9LH--
