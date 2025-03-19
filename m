Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D64C35FFF
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:28:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.135])
 by mx.groups.io with SMTP id smtpd.web10.3802.1742376476648954250
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:27:57 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.135, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1801) id 52J9RtDE172105; Wed, 19 Mar 2025 18:27:55 +0900
X-Iguazu-Qid: 2yAbuzQy1lVXuJA75K
X-Iguazu-QSIG: v=2; s=0; t=1742376474; q=2yAbuzQy1lVXuJA75K; m=jqynB/O2Adf4iV45jMr4kvCT23RJJ+irlQduVsZ4mU8=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 52J9RsUB571351
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Mar 2025 18:27:54 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 2/2] submit_lava.sh: Set number of CPUs to 2 in QEMU start command for arm tests
Date: Wed, 19 Mar 2025 14:54:39 +0530
X-TSB-HOP2: ON
Message-Id: <20250319092440.1328092-2-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250319092440.1328092-1-Sai.Sathujoda@toshiba-tsip.com>
References: <20250319092440.1328092-1-Sai.Sathujoda@toshiba-tsip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Mar 2025 09:27:51.0545 (UTC) FILETIME=[2FC22E90:01DB98B1]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:28:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18245

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

Since CONFIG_NR_CPUS is set to 2 for arm_defconfig, value of smp is
set to 2 in QEMU start command to avoid the following kernel warning
during boot.

[ 0.000000] DT /cpu 3 nodes greater than max cores 2, capping them

For amd64, arm64, the smp value is not altered.

Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
---
 scripts/submit_lava.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index a9bb011..9da083a 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -29,9 +29,9 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
 # Create a dictionary to handle image arguments based on architecture
 declare -A image_args
-image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg  -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
-image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
-image_args[qemu-arm]="-cpu cortex-a15 -machine virt -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,readonly=on,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
+image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
+image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
 set_up (){
 	echo "Installing dependencies to run this script..."
-- 
2.30.2



