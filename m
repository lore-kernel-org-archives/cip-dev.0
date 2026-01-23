Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB42D74EF2
	for <webhook@archiver.kernel.org>; Fri, 23 Jan 2026 15:30:29 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.690.1769182228127021319
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 Jan 2026 07:30:28 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 60NFUPml256737; Sat, 24 Jan 2026 00:30:26 +0900
X-Iguazu-Qid: 2rWhaDm0Crnq0efV3J
X-Iguazu-QSIG: v=2; s=0; t=1769182225; q=2rWhaDm0Crnq0efV3J; m=Q4wSU9kl2MGFv4xVaqnmZHWYut2u5nZzUJ5do9WHE1I=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dyMM54XvVz1xnZ; Sat, 24 Jan 2026 00:30:25 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        akunuri.sahithi@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core][PATCH v6 4/4] doc/README.swupdate.md: Add section for software update with wfx
Date: Fri, 23 Jan 2026 10:44:57 -0500
X-TSB-HOP2: ON
Message-Id: <20260123154458.2479542-5-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20260123154458.2479542-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 23 Jan 2026 15:30:18.0783 (UTC) FILETIME=[2E2DDAF0:01DC8C7D]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 Jan 2026 15:30:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21706

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 131 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b68b5b7..f308d7e 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -464,6 +464,137 @@ Any http server (service) can be used to host the .zck file as long as the http
 
 Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
 
+# Software update with wfx
+
+**NOTE**: In the following sections, `WFX_HOST` refers to the IP address or DNS-resolvable name of your `wfx` server. Please substitute `WFX_HOST` with the appropriate value wherever it appears.
+
+Set the `WFX backend URL` to `http://WFX_HOST:8080/api/wfx/v1` via the `Kconfig` menu.
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
+Build an image using the Kconfig menu which will later serve as update package. Set `WFX backend URL`.
+```
+    -> "Target Board"
+      -> "QEMU AMD64 (x86-64)"
+    -> "CIP kernel version"
+      -> "Kernel 6.12.x-cip"
+    -> "Debian Release"
+      -> "trixie (13)"
+    -> "SWUpdate support for root partition"
+      -> "WFX backend URL"
+      -> "Update type"
+        -> "Complete Update"
+```
+
+Save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu into a separate folder
+
+```
+host$ mkdir -p /tmp/artifacts
+host$ cp build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-trixie-qemu-amd64.swu /tmp/artifacts
+```
+
+Next, rebuild the image using the Kconfig menu, switching to the RT kernel as modification:
+```
+    -> "Target Board"
+      -> "QEMU AMD64 (x86-64)"
+    -> "CIP kernel version"
+      -> "Kernel 6.12.x-cip"
+    -> "Real-time CIP kernel"
+    -> "Debian Release"
+      -> "trixie (13)"
+    -> "SWUpdate support for root partition"
+      -> "WFX backend URL"
+      -> "Update type"
+        -> "Complete Update"
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



