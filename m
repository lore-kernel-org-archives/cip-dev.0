Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFF5D1170B
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4095.1764667289339425387
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=dgg0MHFM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202512020921202f5a7cfb2100020706-qswa0r@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202512020921202f5a7cfb2100020706
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=iHipUsoDtWp5+iCUEHxtEiqxiGUxZdZgNOOxqpJtrU4=;
 b=dgg0MHFM3DT0RB+KXVO4VDJOpW1xXBuuWC117gEdtDAwmBG85wB2OWQD4FWejkvfccAL3k
 zWLpwYe8j7pLga8OTRJOGy8SOraK/rwmnLf7RYMVoVf9vhFQyOH0ivyJNr62s5wjLa/J5L/K
 wwRq54qelJnW0m4TN4THb1A1S2sOxnZP3E3vcJ4CYQnACx9zicurUlQ+fqY+1ud5ylo4fGSE
 HSYVroCkqZe9Urva4r4VToFmis3n6d1WdB6f1IV2wzR1+trLgrOjRGyf44Mo2L0y50rUGzXK
 SxYEoeDFtdX3gMdqN06fsHUwzQgNbceHlpsbwpqiveoGaQiyNJdNT/xw==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 04/14] ci: Raise qemu x86 CPU model
Date: Tue,  2 Dec 2025 10:21:09 +0100
Message-ID: <cc93d81b9b6b5cc6c4ae3631bdee8d9f54a6be1a.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20789

From: Jan Kiszka <jan.kiszka@siemens.com>

For running the x64 6.12-cip kernel, we need a more advanced CPU model
in qemu. A lot of features found in recent CPUs are not supported under
tcg, but Haswell minus unsupported flags work fine so far. Not the final
solution, also because we use kvm locally already.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index a2d2e080..c00b59ad 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -33,7 +33,7 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
 # Create a dictionary to handle image arguments based on architecture
 declare -A image_args
-image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/root/keys/${RELEASE}-ovmf/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/root/keys/${RELEASE}-ovmf/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
+image_args[qemu-amd64]="-cpu Haswell,-pcid,-x2apic,-tsc-deadline,-hle,-invpcid,-rtm -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/root/keys/${RELEASE}-ovmf/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/root/keys/${RELEASE}-ovmf/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
 image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
-- 
2.51.0


