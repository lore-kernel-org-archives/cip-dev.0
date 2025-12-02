Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1D9D11702
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 09:21:38 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3929.1764667288214899232
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 01:21:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=OS9kNiUm;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-20251202092120e3cef3c52600020729-xwdgop@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20251202092120e3cef3c52600020729
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 Dec 2025 10:21:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=ZbLSxkjD8z++1p214TvZK3Llp0DE7F7Awa9oGemm9S4=;
 b=OS9kNiUm/IKufHQLRZtsTBgkN+5tK7VK37ePoEywtqef0YqDsuIFMyenuYS84HzvT8WcLu
 6FlaEucJMMZGAbkXA2U/U/5ZMBVUemA1/UX0TvuLG8HMn5B/9tiU6mwHY0s1z68eS9gxvzlk
 91ERF8QAFjIHDpxzN2yVe40CJjWF7WSalVB5AHMezuOf6H5UBmLCoBTljO8FeZxokAE0blCT
 QvGaRds5n5k9m/ut5CnYg19+gDP9SOVZPmBRs/hQa2zbvfCm6jFPN2WG08OEk1rrTHMJ5HPw
 8hFM2lwTzuR+U8zzs6gq3WFxEsOe0gdLdhyba4qRFK8zktrlBhZxCgiQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 02/14] ci: Prepare for running non-bookworm secure boot tests
Date: Tue,  2 Dec 2025 10:21:07 +0100
Message-ID: <db363a65607faf0a2906abc2905fa24364b01496.1764667279.git.jan.kiszka@siemens.com>
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
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20795

From: Jan Kiszka <jan.kiszka@siemens.com>

Do no hard-code the release which provides alternative keys for the
mismatch test. This allows for testing trixie as well.

While at it, consolidate over OVMF_CODE_4M.secboot.fd which is actually
identical to OVMF_CODE_4M.snakeoil.fd and is used elsewhere already.
Will allow to deploy less with the lava-worker container.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/submit_lava.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/submit_lava.sh b/scripts/submit_lava.sh
index ea733748..f7da99c3 100755
--- a/scripts/submit_lava.sh
+++ b/scripts/submit_lava.sh
@@ -178,8 +178,13 @@ create_job_qemu () {
 	sed -i -e "s@#architecture#@${2}@g" -e "s@#imageargs#@${image_args[$2]}@g" "${job_dir}"/*.yml
 
 	if [ "$1" = "secure-boot-mismatch-keys" ]; then
-		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/trixie-ovmf/OVMF_CODE_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
-		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/trixie-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+		if [ "${RELEASE}" = "trixie" ]; then
+			KEYS_DISTRO=bookworm
+		else
+			KEYS_DISTRO=trixie
+		fi
+		sed -i "s@/usr/share/OVMF/OVMF_CODE_4M.secboot.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_CODE_4M.secboot.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
+		sed -i "s@/usr/share/OVMF/OVMF_VARS_4M.snakeoil.fd@/root/keys/${KEYS_DISTRO}-ovmf/OVMF_VARS_4M.snakeoil.fd@g" "${job_dir}/${1}_mismatch_keys_${2}.yml"
 	fi
 
 	# Target is recieved from gitlab job in form of qemu-"architecture"
-- 
2.51.0


