Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F82C61DC6
	for <webhook@archiver.kernel.org>; Wed, 26 Aug 2026 15:21:11 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15250.1787757661103910872
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 08:21:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=LCBRJg+n;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-294854-20260826152059bc322768d3000207a7-fvmhwd@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 20260826152059bc322768d3000207a7
        for <cip-dev@lists.cip-project.org>;
        Wed, 26 Aug 2026 17:20:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=mJAgUGmhDn2uMzMKHSknyzmqmaTB68QAerD/TqIp6ho=;
 b=LCBRJg+n2eDespNlSgPLO5fZSCPKuGoUja1/iTCz/33cpwtABUzHXenHSs5LtrhNj56LM6
 wEQnWnK0u7w6ETgNUFnc84PJj/CLcyRpa+B/tGog+jLqgp8oiRXTvHDVkIdePSAz+I0FKAtP
 ELByY35Ub9niuGGUnKEZcQ/DMM5DQ4rODoxVidveMcmYHcuARC9JKIRpuCKOSAAxgkSzHAYu
 FSociQ1dNgi32/1l/QP3I+WcCJBL7ElAvNaS7mthJOyU7BFwY/NhK39dRcAWN6anh6xs4Dj1
 kObh513Euxhlu/JGvjuuFB4t0IrRHg0wBKKu+2D32DZAF4KIJJB056ng==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 6/7] u-boot: Drop obsolete config workaround
Date: Wed, 26 Aug 2026 17:20:54 +0200
Message-ID: <bd86113c61ac396462018aabb7e331424a32e565.1787757655.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1787757655.git.jan.kiszka@siemens.com>
References: <cover.1787757655.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Aug 2026 15:21:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24027

From: Jan Kiszka <jan.kiszka@siemens.com>

We moved to a newer U-Boot version meanwhile which resolved that issue.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg | 2 --
 1 file changed, 2 deletions(-)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg b/recipes-bsp/u-boot/files/secure-boot.cfg
index 7b09a53e..15a2bdf3 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg
@@ -17,5 +17,3 @@ CONFIG_FS_FAT=y
 CONFIG_EFI_SECURE_BOOT=y
 # overruled by CONFIG_EFI_MM_COMM_TEE where available
 CONFIG_EFI_VARIABLES_PRESEED=y
-# workaround for v2025.07
-CONFIG_CMD_DHCP=y
-- 
2.47.3


