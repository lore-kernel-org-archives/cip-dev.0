Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477FFC7EE23
	for <webhook@archiver.kernel.org>; Tue,  2 May 2023 15:38:08 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.1467.1683041884671857776
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 May 2023 08:38:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=VBIzIQr0;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20230502153802c5608b159e5128748e-k0ovkt@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230502153802c5608b159e5128748e
        for <cip-dev@lists.cip-project.org>;
        Tue, 02 May 2023 17:38:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=olexPfnGvi5UUgfptqM5cvHR3x1AqKu+kaXmkYJB/gY=;
 b=VBIzIQr0sFsxiqM8BsC7gI3Ii6zF6F+eFKv0eo8zt0O5mZSmtJxU6z2ilq9P3Sz/sWtVBZ
 cvl8MZCf/J9EjSwwHr/11CNIMSQgwCFc4xlBrXb1jPGIGkqFaJi9I3j8OU8ILh3h5gHVsnDj
 QcfKcK0TnPjYrlRfkRHgJoACFDAjk=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 7/7] doc/README.tpm2.encryption: Correct kas option
Date: Tue,  2 May 2023 17:37:59 +0200
Message-Id: <20230502153759.1284906-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
References: <20230502153759.1284906-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 May 2023 15:38:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11383

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

The kas option was renamed from kas/opt/tpm2.yml
 to kas/opt/encrypt-partitions.yml.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.tpm2.encryption.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/README.tpm2.encryption.md b/doc/README.tpm2.encryption.md
index 0df7f39..cb3f640 100644
--- a/doc/README.tpm2.encryption.md
+++ b/doc/README.tpm2.encryption.md
@@ -27,7 +27,7 @@ An example for qemu-amd64 can be build with by selecting the option after callin
 or by adding using the following command line build:
 
 ```
-./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/tpm.yml
+./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/encrypt-partitions.yml
 ```
 ## initramfs-crypt-hook configuration
 
-- 
2.39.2


