Return-Path: <sari.sercan@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00F7F8FA69
	for <webhook@archiver.kernel.org>; Tue, 21 Apr 2026 12:07:04 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.25694.1776773213552122542
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Apr 2026 05:06:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=sari.sercan@siemens.com header.s=fm2 header.b=eBviTsJM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1334722-20260421120647d8588db34100020735-atf560@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260421120647d8588db34100020735
        for <cip-dev@lists.cip-project.org>;
        Tue, 21 Apr 2026 14:06:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=sari.sercan@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ljiUdS4ZHOTDDLrlUpi8tw32SrQdV2lS2InTi/lIe6o=;
 b=eBviTsJMVz+xFWH3kIUBklQ56J1hA6CEvDc+dxn1jgYdy10VEIsWMkpOn8xS9x98PxooEZ
 nBqjpzt/eCTOUF1u3j89FhUKl3Jrp7/ygsgw6HV8mAnFKj/U7q1f+7eMnkWr/3Dl9nEONE1X
 9gpkWn7ZpMguJHlMQvM9cP9ArUdKoheuQ3Teel5enBL4DOBez7h7qexCOIZwFSfHzY/bvPIy
 2F7+S/Gmc4BhfQsvlPF46uN3BvQsdmDAKscGLbh1b++k0HoXSPpIVeya3F45v8jhVXvkXkeX
 dxfqCAeIgXmFtFNWJHATU7KiyakFcAVn80zKkIsFe+2ZxPTSb4kR7d0A==;
From: Sercan Sari <sari.sercan@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sercan Sari <sari.sercan@siemens.com>
Subject: [isar-cip-core][PATCH v2] encrypt_partition: evict stale TPM2 SRK handle before enrollment
Date: Tue, 21 Apr 2026 14:05:50 +0200
Message-Id: <20260421120550.3746353-1-sari.sercan@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1334722:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Apr 2026 12:07:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22773

Since systemd v254, systemd-cryptenroll persists
its TPM2 Storage Root Key (SRK) as a persistent handle at 0x81000001.
Debian 13 (trixie) ships systemd >= v255 and is affected.

If the disk was re-installed while the TPM retained its state,
the stale handle causes systemd-cryptenroll to fail with:

  Failed to seal to TPM2: State not recoverable

Fix this by checking for the handle via tpm2_getcap and
evicting it before enrollment.

Signed-off-by: Sercan Sari <sari.sercan@siemens.com>
---
 .../files/encrypt_partition.systemd.script               | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
index 1b7c83b..94346a8 100644
--- a/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
+++ b/recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.script
@@ -26,6 +26,15 @@ enroll_tpm2_token() {
 	#tpm_key_algorithm="$4"
 	#pcr_bank_hash_type="$5"
 
+	# systemd-cryptenroll persists its TPM2 SRK at handle 0x81000001
+	# evict any stale handle before enrollment to avoid
+	# "Failed to seal to TPM2: State not recoverable".
+	if tpm2_getcap handles-persistent 2>/dev/null | grep -q "0x81000001"; then
+		if ! tpm2_evictcontrol -C o -c 0x81000001; then
+			panic "Failed to evict stale TPM2 handle 0x81000001!"
+		fi
+	fi
+
 	# check systemd version and export password if necessary
 	if [ -x /usr/bin/systemd-cryptenroll ]; then
 		systemd_version=$(systemd-cryptenroll --version | \
-- 
2.39.5


