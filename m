Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB4C6C352AA
	for <webhook@archiver.kernel.org>; Tue,  4 Oct 2022 16:48:28 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web09.13318.1664902101744116780
 for <cip-dev@lists.cip-project.org>;
 Tue, 04 Oct 2022 09:48:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=L/fO0gue;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20221004164822ab5321f58387e1bef4-46ywdd@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20221004164822ab5321f58387e1bef4
        for <cip-dev@lists.cip-project.org>;
        Tue, 04 Oct 2022 18:48:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=NX5vEuVmBoYzQWEBVC+QZUm1ooxSjshHzSEAyoC3lP0=;
 b=L/fO0gueRc1vPW5ZTN1+t3o0GP0mfyhbFJSHMX+J5uxBy6Dut1Tl5gJlUzczGSZo/YnpXO
 +brUge2FWC6ljaCU4rocIfDQF6oyWqUTplG4gHtaHaOt7Kaq5g/r/oAtCYaR0fEE51ZlsKAZ
 l3o/Wk1Ighd4fqvTPcnxW64BnfqRc=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Subject: [isar-cip-core][PATCH 11/12] customizations: Mask hvc0 console under
 qemu-riscv64
Date: Tue,  4 Oct 2022 18:48:17 +0200
Message-Id: 
 <7dccbac7b8d8b7af7f991c18335b94b0c236a2d8.1664902098.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1664902098.git.jan.kiszka@siemens.com>
References: <cover.1664902098.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 04 Oct 2022 16:48:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9626

From: Jan Kiszka <jan.kiszka@siemens.com>

RISC-V kernels tend to come with a virtual console via SBI. Under QEMU,
this is redundant to the serial console that Linux support as well,
giving two prompts on the UART. Disable the virtual on via systemd.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/customizations.bb | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/recipes-core/customizations/customizations.bb b/recipes-core/customizations/customizations.bb
index 96e88ddb..c057d576 100644
--- a/recipes-core/customizations/customizations.bb
+++ b/recipes-core/customizations/customizations.bb
@@ -12,3 +12,11 @@
 require common.inc
 
 DESCRIPTION = "CIP Core image demo & customizations"
+
+do_prepare_build_prepend_qemu-riscv64() {
+	if ! grep -q serial-getty@hvc0.service ${WORKDIR}/postinst; then
+		# suppress SBI console - overlaps with serial console
+		echo >> ${WORKDIR}/postinst
+		echo "systemctl mask serial-getty@hvc0.service" >> ${WORKDIR}/postinst
+	fi
+}
-- 
2.35.3


