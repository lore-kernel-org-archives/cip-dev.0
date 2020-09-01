Return-Path: <SRS0=Q28p=CK=lists.cip-project.org=bounce+64572+5346+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9A7C433E2
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:42 +0000 (UTC)
Received: from web01.groups.io (web01.groups.io [66.175.222.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A3E32098B
	for <cip-dev@archiver.kernel.org>; Tue,  1 Sep 2020 06:13:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.cip-project.org header.i=@lists.cip-project.org header.b="FAxfyvNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A3E32098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5346+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id KZWBYY4521723xOVREKngKWF; Mon, 31 Aug 2020 23:13:41 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web10.6933.1598940820901747560
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Aug 2020 23:13:41 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 0816DcdY029789; Tue, 1 Sep 2020 15:13:39 +0900
X-Iguazu-Qid: 34tMJPQphvG3rXMsJL
X-Iguazu-QSIG: v=2; s=0; t=1598940818; q=34tMJPQphvG3rXMsJL; m=PzSh2cPf6oqKqQ5rNQrDQEaGV0+6gpGx8R69zX2kO/A=
X-Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
	by relay.securemx.jp (mx-mr1512) id 0816Db6U018099;
	Tue, 1 Sep 2020 15:13:38 +0900
X-Received: from enc03.toshiba.co.jp ([106.186.93.13])
	by imx2.toshiba.co.jp  with ESMTP id 0816DbeT002031;
	Tue, 1 Sep 2020 15:13:37 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc03.toshiba.co.jp  with ESMTP id 0816DbW5027132;
	Tue, 1 Sep 2020 15:13:37 +0900
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org
Cc: chris.paterson2@renesas.com,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [cip-dev] [linux-cip-ci][PATCH 2/3] lava_templates: Add support zynqmp-zcu102
Date: Tue,  1 Sep 2020 15:13:13 +0900
X-TSB-HOP: ON
Message-Id: <20200901061314.2749466-2-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: <20200901061314.2749466-1-nobuhiro1.iwamatsu@toshiba.co.jp>
References: <20200901061314.2749466-1-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: 285x5YXcBTwr3DAQxNADIrFnx4520388AA=
Content-Type: multipart/mixed; boundary="9MTlPUHpYsaP4JMvEbSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1598940821;
 bh=lBMAyGYSBZ+VhlIzJZ9kK0RFjsPu1NqJ1CYi9WL7s/Y=;
 h=Cc:Content-Type:Date:From:Reply-To:Subject:To;
 b=FAxfyvNbM9hefSzKKT73EZ/VcC76QR9Olz3gS1oAp+9aN6SMM2mbYLwFVg3CEFs3PQz
 N6uZeqZ48d/nZMqk1m9kix7VEFEYas9akLRVSTh+DDQcNeLZlEcN8bcPhfQynqyNB/tPC
 /2aL/egjARb+L2Y0rxqC7waPQgkH6fhiBS8=

--9MTlPUHpYsaP4JMvEbSp
Content-Transfer-Encoding: 8bit

Add ltp and boot/smc test YAML files for zynqmp-zcu102 with deby.

Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 .../action_deby-buster-ltp_zynqmp-zcu102.yaml    | 16 ++++++++++++++++
 .../action_deby-buster_zynqmp-zcu102.yaml        | 16 ++++++++++++++++
 .../boot_deby-buster-ltp_zynqmp-zcu102.yaml      |  1 +
 .../boot_deby-buster_zynqmp-zcu102.yaml          | 12 ++++++++++++
 4 files changed, 45 insertions(+)
 create mode 100644 lava_templates/action_deby-buster-ltp_zynqmp-zcu102.yaml
 create mode 100644 lava_templates/action_deby-buster_zynqmp-zcu102.yaml
 create mode 120000 lava_templates/boot_deby-buster-ltp_zynqmp-zcu102.yaml
 create mode 100644 lava_templates/boot_deby-buster_zynqmp-zcu102.yaml

diff --git a/lava_templates/action_deby-buster-ltp_zynqmp-zcu102.yaml b/lava_templates/action_deby-buster-ltp_zynqmp-zcu102.yaml
new file mode 100644
index 0000000..bca9892
--- /dev/null
+++ b/lava_templates/action_deby-buster-ltp_zynqmp-zcu102.yaml
@@ -0,0 +1,16 @@
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: image
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-minimal-ltp-zcu102-zynqmp.tar.bz2
+      compression: bz2
+    dtb:
+      url: DTB_URL
+
diff --git a/lava_templates/action_deby-buster_zynqmp-zcu102.yaml b/lava_templates/action_deby-buster_zynqmp-zcu102.yaml
new file mode 100644
index 0000000..3d2cce0
--- /dev/null
+++ b/lava_templates/action_deby-buster_zynqmp-zcu102.yaml
@@ -0,0 +1,16 @@
+# ACTION_BLOCK
+actions:
+- deploy:
+    timeout:
+      minutes: 10
+    to: tftp
+    os: oe
+    kernel:
+      url: KERNEL_URL
+      type: image
+    nfsrootfs:
+      url: https://s3-us-west-2.amazonaws.com/download.cip-project.org/ciptesting/cip-lava/rfs/core-image-minimal-zcu102-zynqmp.tar.bz2
+      compression: bz2
+    dtb:
+      url: DTB_URL
+
diff --git a/lava_templates/boot_deby-buster-ltp_zynqmp-zcu102.yaml b/lava_templates/boot_deby-buster-ltp_zynqmp-zcu102.yaml
new file mode 120000
index 0000000..67c02c5
--- /dev/null
+++ b/lava_templates/boot_deby-buster-ltp_zynqmp-zcu102.yaml
@@ -0,0 +1 @@
+boot_deby-buster_zynqmp-zcu102.yaml
\ No newline at end of file
diff --git a/lava_templates/boot_deby-buster_zynqmp-zcu102.yaml b/lava_templates/boot_deby-buster_zynqmp-zcu102.yaml
new file mode 100644
index 0000000..db223b4
--- /dev/null
+++ b/lava_templates/boot_deby-buster_zynqmp-zcu102.yaml
@@ -0,0 +1,12 @@
+# BOOT_BLOCK
+- boot:
+    auto_login:
+      login_prompt: 'zcu102-zynqmp login:'
+      username: root
+    prompts:
+      - '# '
+    method: u-boot
+    commands: nfs
+    timeout:
+      minutes: 5
+
-- 
2.27.0


--9MTlPUHpYsaP4JMvEbSp
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.

View/Reply Online (#5346): https://lists.cip-project.org/g/cip-dev/message=
/5346
Mute This Topic: https://lists.cip-project.org/mt/76551105/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy  [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-

--9MTlPUHpYsaP4JMvEbSp--
