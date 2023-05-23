Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66971C7EE23
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 18:51:02 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web11.14352.1684819145635821671
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 22:19:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=Lflfmr6f;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-72506-2023052305190343cd6ebd80ae5e2885-djdgyd@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2023052305190343cd6ebd80ae5e2885
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 May 2023 07:19:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=z38tQrSB0RTxg21Rg6g8oaRQomvSY/mGcfm8yebZHfk=;
 b=Lflfmr6flg0CG9P5+QmpfamhebXwTnOF/JzZVlLcO0FAs5ofEg01JyJQgct1+rYwGa5fxL
 3YNE540iM2OFTAG1uj4iXDPi5gSD3M5rwnHpgu5SpfoKh7W7Q2TThfW0q5uDhjpOHl5xQrn9
 kewpHoximUQesALe/ty+n48CEEdrw=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	meng.ding@siemens.com,
	chengshu.mou@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/3] fix(start-efishell): argument passing to qemu
Date: Tue, 23 May 2023 13:18:44 +0800
Message-Id: <20230523051846.1007400-2-felix.moessbauer@siemens.com>
In-Reply-To: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
References: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 18:51:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11622

In commit 0129baec findings by shellcheck have been adressed. However,
this broke the QEMU arguments, as these do not allow to pass quoted
strings. By that, the deployment of secoure boot keys was broken.

To avoid similar issues in the future, we revert the code, disable the
shellcheck warning and add a note on the reason. In addition, the
format / driver of the disk is specified explicitly to avoid a warning
during startup.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 scripts/start-efishell.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/scripts/start-efishell.sh b/scripts/start-efishell.sh
index 5ec85e0..fff8a6a 100755
--- a/scripts/start-efishell.sh
+++ b/scripts/start-efishell.sh
@@ -5,11 +5,14 @@ set -e
 ovmf_code=${OVMF_CODE:-/usr/share/OVMF/OVMF_CODE_4M.secboot.fd}
 ovmf_vars=${OVMF_VARS:-./OVMF_VARS_4M.fd}
 DISK=$1
+
+# QEMU is very picky about how arguments are passed (strings must not be quoted).
+# shellcheck disable=SC2086
 qemu-system-x86_64 -enable-kvm -M q35 -nographic \
                    -cpu host,hv_relaxed,hv_vapic,hv-spinlocks=0xfff -smp 2 -m 2G -no-hpet \
                    -global ICH9-LPC.disable_s3=1 \
                    -global isa-fdc.driveA= \
                    -boot menu=on \
-                   -drive if=pflash,format=raw,unit=0,readonly=on,file="${ovmf_code}" \
-                   -drive if=pflash,format=raw,file="${ovmf_vars}" \
-                   -drive file=fat:rw:"$DISK"
+                   -drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
+                   -drive if=pflash,format=raw,file=${ovmf_vars} \
+                   -drive file=fat:rw:$DISK,driver=vvfat
-- 
2.39.2


