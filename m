Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DC3CFD376
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4093.1764667288213210483
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=CnqA1nqw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20251202092120e419d8517800020782-whyad1@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20251202092120e419d8517800020782
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NQyUQVsCVTUYr4jJ4/ucE2petgBIRwC/tNQ3FImiwPA=;
 b=CnqA1nqwkak1ENOmwOFVI5FeAV7yLIDlXwlgYmnYyvkrAOSRj1+Gk5jdqy7ijEslHiWTtu
 pVkL4QfJ8OphlkDXXEI9JoKMHkg8FQvg2APlNc2yrD2kMR/pUfrvWUR0fR8vaizxm+udJtMQ
 z81EjfOqCEC9ZIUNIOidLkCUKDbqE607WWiQxDk04sWsFLkeqtLkfgzw4saxKXFVh3TZ/wMj
 fXYRwzt/rI1oVQYeaa0TM9ZnAX9Utt7/4V1oYhxvt2Jt+29RoYYan+lK9IBkI3E9SgmHG8RH
 aPCj9D+HN2dmelaoW2SyXZ2apdb95BV8ZOwmlvsksuxOt/iIXSSI0i2A==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 03/14] ci: Select qemu-amd64 OVMF according to target release
Date: Tue,  2 Dec 2025 10:21:08 +0100
Message-ID: <bc7e8e9334be773c8b4a99430dd8c406d7beb88a.1764667279.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1764667279.git.jan.kiszka@siemens.com>
References: <cover.1764667279.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 09:21:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20788

From: Jan Kiszka <jan.kiszka@siemens.com>

Perform the OVMF binary and key vars selection according to the Debian
release of the test image so that we can also check non-bookworm
versions.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index f7da99c3..a2d2e080 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -33,7 +33,7 @@ if [ -z "$SUBMIT_ONLY" ]; then SUBMIT_ONLY=false; fi
 
 # Create a dictionary to handle image arguments based on architecture
 declare -A image_args
-image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/usr/share/OVMF/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
+image_args[qemu-amd64]="-cpu qemu64 -machine q35,accel=tcg -smp 4 -global ICH9-LPC.noreboot=off -device ide-hd,drive=disk -drive if=pflash,format=raw,unit=0,readonly=on,file=/root/keys/${RELEASE}-ovmf/OVMF_CODE_4M.secboot.fd -device virtio-net-pci,netdev=net -drive if=pflash,format=raw,file=/root/keys/${RELEASE}-ovmf/OVMF_VARS_4M.snakeoil.fd  -global ICH9-LPC.disable_s3=1 -global isa-fdc.driveA= -device tpm-tis,tpmdev=tpm0"
 image_args[qemu-arm64]="-cpu cortex-a57 -machine virt -smp 4 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 image_args[qemu-arm]="-cpu cortex-a15 -machine virt -smp 2 -device virtio-serial-device -device virtconsole,chardev=con -chardev vc,id=con -device virtio-blk-device,drive=disk -device virtio-net-device,netdev=net -device tpm-tis-device,tpmdev=tpm0"
 
@@ -183,8 +183,7 @@ create_job_qemu () {
 		else
 			KEYS_DISTRO=trixie
 		fi
-		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_CODE_4M.secboot.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
-		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+		sed -i "s@${RELEASE}-ovmf@${KEYS_DISTRO}-ovmf@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
 	fi
 
 	# Target is recieved from gitlab job in form of qemu-"architecture"
-- 
2.51.0


