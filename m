Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C7BAD48990
	for <webhook@archiver.kernel.org>; Fri, 16 Jan 2026 11:49:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4373.1768564148094585960
 for <cip-dev@lists.cip-project.org>;
 Fri, 16 Jan 2026 03:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 60GBn6fY4093769; Fri, 16 Jan 2026 20:49:06 +0900
X-Iguazu-Qid: 2yAbkFyyIK7OvMonjc
X-Iguazu-QSIG: v=2; s=0; t=1768564146; q=2yAbkFyyIK7OvMonjc; m=DrF2WFQ6OhfX1DXuclRQCdFn2xYMGlcAWkfivMo5JqA=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dsymy1dlVzyPQ; Fri, 16 Jan 2026 20:49:06 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp,
        michael.adler@siemens.com
Subject: [isar-cip-core][PATCH v5 4/4] doc/README.swupdate.md: Add section for software update with wfx
Date: Fri, 16 Jan 2026 07:03:47 -0500
X-TSB-HOP2: ON
Message-Id: <20260116120347.1733494-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260116120347.1733494-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 16 Jan 2026 11:49:00.0840 (UTC) FILETIME=[1B044A80:01DC86DE]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 16 Jan 2026 11:49:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21633

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 113 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b68b5b7..8b756cd 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -464,6 +464,119 @@ Any http server (service) can be used to host the .zck file as long as the http
 
 Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
 
+# Software update with wfx
+
+**NOTE**: In the following sections, `WFX_HOST` refers to the IP address or DNS-resolvable name of your `wfx` server. Please substitute `WFX_HOST` with the appropriate value wherever it appears.
+
+Set the `WFX_URL` to `http://WFX_HOST:8080/api/wfx/v1` via the `Kconfig` menu.
+
+Install `wfxctl` and `wfx` in the host:
+The instructions below assume that `wfxctl` and `wfx` are running on a `x86-64` host. Binaries for other architectures are also available for [download](https://github.com/siemens/wfx/releases).
+```
+## Install wfxctl
+host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfxctl_0.4.1_linux_x86_64.deb
+host$ dpkg -i wfxctl_0.4.1_linux-x86_64.deb
+
+## Install wfx
+host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfx_0.4.1_linux_x86_64.deb
+host$ dpkg -i wfx_0.4.1_linux-x86_64.deb
+```
+
+
+Build an image which will later serve as update package:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml
+```
+
+Save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu into a separate folder
+
+```
+host$ mkdir -p /tmp/artifacts
+host$ cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu /tmp/artifacts
+```
+
+Next, rebuild the image, switching to the RT kernel as modification:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml:kas/opt/trixie.yml
+```
+
+Now start the image which will contain the RT kernel:
+```
+host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+
+Check the machine-id in `/etc/machine-id`. SWUpdate is launched with this `id` as the `client-id` and is later used to create `wfx` job for the client:
+```
+root@demo cat /etc/machine-id
+049adc79659044f8887c83b3203c84f1
+```
+
+Start `wfx` server in the host:
+```
+host$ wfx --simple-fileserver /tmp/artifacts
+```
+Alternatively, `wfx` can also be run as a [docker container](https://github.com/siemens/wfx/blob/a6ecb60bb47eaf1f95a2b65b4190538a246d79d1/docs/installation.md#build-and-installation).
+
+Create `wfx.workflow.dau.direct` wofkflow:
+```
+host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workflow/dau/wfx.workflow.dau.direct.yml | wfxctl workflow create -
+```
+
+Create a wfx job that updates the device. Set `client-id` with the `id` from `/etc/machine-id` in qemu:
+```
+host$ cat <<EOF | envsubst | wfxctl job create --client-id '049adc79659044f8887c83b3203c84f1' --workflow wfx.workflow.dau.direct -
+{
+  "version": "1.0",
+  "type": ["firmware"],
+  "artifacts": [
+    {
+      "name": "Example Device Firmware Artifact",
+      "version": "1.1",
+      "uri": "http://${WFX_HOST}:8080/download/cip-core-image-cip-core-trixie-qemu-amd64.swu"
+    }
+  ]
+}
+EOF
+```
+
+Wait for the next swupdate polling round (every 20 seconds) to see how swupdate downloads and applies the update.
+```
+root@demo journalctl -u swupdate -f
+
+// truncated output
+swupdate.sh[432]: [TRACE] : SWUPDATE running :  [start_suricatta] : Suricatta awakened.
+swupdate.sh[432]: [DEBUG] : SWUPDATE running :  [notify_helper] : Suricatta querying "http://WFX_HOST:8080/api/wfx/v1/jobs?clientId=049adc79659044f8887c83b3203c84f1&group=OPEN"
+```
+
+Once the update is successfully installed, the device automatically reboots. After reboot, suricatta automatically updates the bootloader state.
+```
+root@demo bg_printenv
+
+----------------------------
+ Config Partition #0 Values:
+in_progress:      no
+revision:         2
+kernel:           C:BOOT0:linux.efi
+kernelargs:
+watchdog timeout: 120 seconds
+ustate:           0 (OK)
+
+user variables:
+
+
+
+----------------------------
+ Config Partition #1 Values:
+in_progress:      no
+revision:         3
+kernel:           C:BOOT1:linux.efi
+kernelargs:
+watchdog timeout: 120 seconds
+ustate:           0 (OK)
+
+user variables:
+```
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.5



