Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530FDCCF9F2
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 12:09:08 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.6783.1761653341211982641
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 05:09:01 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.158, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1122) id 59SC8x4Z1515248; Tue, 28 Oct 2025 21:08:59 +0900
X-Iguazu-Qid: 2rWhTMh0biBGc6Ngav
X-Iguazu-QSIG: v=2; s=0; t=1761653339; q=2rWhTMh0biBGc6Ngav; m=wDz8l+LlZKHKq5+GZILULoyssppe1ehMPm5D+TGwYms=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cwq0q37SNz4vyk; Tue, 28 Oct 2025 21:08:59 +0900 (JST)
From: Adithya.Balakumar@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>,
        shivanand.kunijadar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
        kazuhiro3.hayashi@toshiba.co.jp, akunuri.sahithi@toshiba-tsip.com
Subject: [isar-cip-core][RFC v3 5/5] doc/README.swupdate.md: Add section for software update with wfx
Date: Tue, 28 Oct 2025 08:20:42 -0400
X-TSB-HOP2: ON
Message-Id: <20251028122042.2355451-6-Adithya.Balakumar@toshiba-tsip.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
References: <20251028122042.2355451-1-Adithya.Balakumar@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 28 Oct 2025 12:08:53.0487 (UTC) FILETIME=[A0D7C7F0:01DC4803]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 12:09:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20259

From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>

Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
---
 doc/README.swupdate.md | 124 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index b68b5b7..5e01b02 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -464,6 +464,130 @@ Any http server (service) can be used to host the .zck file as long as the http
 
 Follow the steps mentioned in the section [SWUpdate verification](#swupdate-verification) for verification.
 
+# Software update with wfx
+
+**NOTE**: In the following sections, please replace `WFX_HOST_IP` with the IP address of the `wfx` server.
+
+Set the `WFX_URL` to `http://WFX_HOST_IP:8080/api/wfx/v1` in `kas/opt/wfx.yml`
+
+Install `wfxctl` in the host:
+```
+host$ mkdir -p wfx
+host$ curl -LO https://github.com/siemens/wfx/releases/download/v0.4.1/wfxctl-0.4.1-linux-x86_64.tar.zst
+host$ tar --use-compress-program=unzstd -xvf wfxctl-0.4.1-linux-x86_64.tar.zst -C wfx
+host$ rm wfxctl-0.4.1-linux-x86_64.tar.zst
+```
+
+Build an image which will later serve as update package:
+```
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/trixie.yml:kas/opt/wfx.yml
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
+host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml:kas/opt/trixie.yml:kas/opt/wfx.yml
+```
+
+Now start the image which will contain the RT kernel:
+```
+host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
+```
+
+Check a generated client `id`. This `id` is later used to create `wfx` job for the client:
+```
+root@demo cat /etc/swupdate.cfg
+
+// trucated output
+suricatta :
+{
+    id = "d93f5e37a20f447cab0c4110202f1c97";
+    url = "http://WFX_HOST_IP:8080/api/wfx/v1";
+    polldelay = 20;
+};
+```
+
+Start a docker container running the `wfx` server:
+```
+docker run -d -it --rm \
+  -p 8080:8080 \
+  -p 8081:8081 \
+  -v /tmp/artifacts:/var/artifacts \
+  --entrypoint wfx \
+  ghcr.io/siemens/wfx:v0.4.1 \
+    --client-port 8080 \
+    --mgmt-port 8081 \
+    --mgmt-host 0.0.0.0 \
+    --simple-fileserver /var/artifacts
+```
+
+Create `wfx.workflow.dau.direct` wofkflow:
+```
+host$ curl -L https://raw.githubusercontent.com/siemens/wfx/refs/heads/main/workflow/dau/wfx.workflow.dau.direct.yml -o wfx/wfx.workflow.dau.direct.yml
+host$ ./wfx/wfxctl --client-port '8080' workflow create wfx/wfx.workflow.dau.direct.yml
+```
+
+Create a wfx job that updates the device. Replace `WFX_HOST_IP` with the IP address of the `wfx` server and `client-id` with the `id` in `/etc/swupdate.cfg` in qemu:
+```
+host$ cat <<EOF | envsubst | ./wfx/wfxctl job create --client-id 'd93f5e37a20f447cab0c4110202f1c97' --workflow wfx.workflow.dau.direct -
+{
+  "version": "1.0",
+  "type": ["firmware"],
+  "artifacts": [
+    {
+      "name": "Example Device Firmware Artifact",
+      "version": "1.1",
+      "uri": "http://${WFX_HOST_IP}:8080/download/cip-core-image-cip-core-trixie-qemu-amd64.swu"
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
+// trucated output
+swupdate.sh[432]: [TRACE] : SWUPDATE running :  [start_suricatta] : Suricatta awakened.
+swupdate.sh[432]: [DEBUG] : SWUPDATE running :  [notify_helper] : Suricatta querying "http://WFX_HOST_IP:8080/api/wfx/v1/jobs?clientId=56d08a92-b08e-9211-e8e0-45ddce7a4c04&group=OPEN"
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
+watchdog timeout: 60 seconds
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
+watchdog timeout: 60 seconds
+ustate:           0 (OK)
+
+user variables:
+```
+
 # Building and testing the CIP Core image for BBB
 
 Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
-- 
2.39.5



