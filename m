Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17E6C25B06
	for <webhook@archiver.kernel.org>; Sun, 14 Aug 2022 12:47:44 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web08.4614.1660481260435072092
 for <cip-dev@lists.cip-project.org>;
 Sun, 14 Aug 2022 05:47:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=Xog6sqlE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-20220814124737fa33c59f45bb851c59-afm54z@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 20220814124737fa33c59f45bb851c59
        for <cip-dev@lists.cip-project.org>;
        Sun, 14 Aug 2022 14:47:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=jQ9T3obJVu6BMXTv3cgWxUyVoRoLau9BJqnly5bkOv0=;
 b=Xog6sqlER/3dyZhvCDN26I/anmfgGU/oMLO99HiSjR0DKwAbtjxyKf4K2wjYtwjRZchHIL
 Y0arGvNCPsWHHOtMjHmZaJZgTuTgUBeWeTR3jmRJOYKp3Uj/HVumnBEdzYhzMpwoPvBqYm6D
 4pHggdiwWz4pFNke890325aCdYPjA=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Shivanand.Kunijadar@toshiba-tsip.com
Subject: [isar-cip-core][PATCH 3/4] linux-cip: Update cip-kernel-config
 revision
Date: Sun, 14 Aug 2022 15:47:32 +0300
Message-Id: 
 <a4ae875b51cb66fc4511d903cf2c3295188202e0.1660481252.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1660481252.git.jan.kiszka@siemens.com>
References: <cover.1660481252.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 14 Aug 2022 12:47:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9209

From: Jan Kiszka <jan.kiszka@siemens.com>

This brings updates for Renesas configs on 5.10 and prepares for using
the defconfigs from that repo also for BBB.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-kernel/linux/linux-cip-common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/linux/linux-cip-common.inc
index b612efa..8d8a8e2 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -25,6 +25,6 @@ SRC_URI_append = " ${@ "git://gitlab.com/cip-project/cip-kernel/cip-kernel-confi
 
 SRC_URI_append_bbb = "file://${KERNEL_DEFCONFIG}"
 
-SRCREV_cip-kernel-config ?= "6509d11f52b7df71b8b2228c1bccd7913e4a33b8"
+SRCREV_cip-kernel-config ?= "59f7903d120e529cc26b8e5fd7b13c3bbb632e15"
 
 S = "${WORKDIR}/linux-cip-${PV}"
-- 
2.35.3


