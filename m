Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BBDC636F8
	for <webhook@archiver.kernel.org>; Mon, 25 Apr 2022 19:26:14 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.28182.1650887392190697861
 for <cip-dev@lists.cip-project.org>;
 Mon, 25 Apr 2022 04:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=mUwHwuEA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225,
 mailfrom: fm-294854-202204251149504430f4354ceb766806-bl_xrg@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 202204251149504430f4354ceb766806
        for <cip-dev@lists.cip-project.org>;
        Mon, 25 Apr 2022 13:49:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=6pEaCCfervH66LL/3I46tdB9XiTbqtuDkrvQZLDOuMk=;
 b=mUwHwuEAYx49aoNxjTS0rp4HfoKsBiNQ/l4MK6zSMMwzOfagLz9gyAd/raFQVagI0btdjC
 37QgbhCWKycpOpvUuTrUtxU4opB+FTmn6WdPX+v2Wa90BZ/NDorhcQKTPkdBP1KiKNmTNp6+
 zouqaExssrBFnr54BHCr705y4dogs=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Christian Storm <christian.storm@siemens.com>
Subject: [isar-cip-core][PATCH v3 5/7] customizations: Relocate /root under
 /home
Date: Mon, 25 Apr 2022 13:49:42 +0200
Message-Id: 
 <8442f4a07a1f382dea9930aaf2045ff40ed2ca57.1650887383.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1650887383.git.jan.kiszka@siemens.com>
References: <cover.1650887383.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 25 Apr 2022 19:26:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8200

From: Jan Kiszka <jan.kiszka@siemens.com>

This is needed for read-only rootfs setups. We could also update the
account settings, but establishing a link comes with less surprises.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 recipes-core/customizations/files/postinst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/recipes-core/customizations/files/postinst b/recipes-core/customizations/files/postinst
index 9b553da..6ca309a 100644
--- a/recipes-core/customizations/files/postinst
+++ b/recipes-core/customizations/files/postinst
@@ -17,3 +17,7 @@ echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
 HOSTNAME=demo
 echo "$HOSTNAME" > /etc/hostname
 echo "127.0.0.1 $HOSTNAME" >> /etc/hosts
+
+# needed for read-only rootfs with writable /home
+mv /root /home/
+ln -s /home/root /root
-- 
2.34.1


