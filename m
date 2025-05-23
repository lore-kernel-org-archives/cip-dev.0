Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 248C8C54F32
	for <webhook@archiver.kernel.org>; Fri, 23 May 2025 14:48:01 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.50113.1748011672410073899
 for <cip-dev@lists.cip-project.org>;
 Fri, 23 May 2025 07:47:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=QP90IQ/4;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-294854-202505231447496d8276eb3e45be571f-unlwlc@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 202505231447496d8276eb3e45be571f
        for <cip-dev@lists.cip-project.org>;
        Fri, 23 May 2025 16:47:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=JdhqhpIJ8VelsVvpuPU9pJti2XraMHzFTVjQIJoNX2E=;
 b=QP90IQ/4XV3Q4NlrpbZvPmvlXgKrqckfGeIdySboDGyBmtHlR/X30psQe8+BsyPOVfawL7
 6lQfNg361UFG4Ri36nRbC8gKAPR4rt61iBCcCGWZhrJF0yZeDc0G0gjE7Ng67n1QKm9sSPw2
 vkwoISjGeCv/7khmWNCdEzk2/KkH7bCGr6yNHksqqCBAEp8OI1v9PaE5IiWb6WzoqFM+kvsO
 CsGqU3RJC7BUqNLfWHN6h2lmTIDUAfxRu0PFk1oZ36IVy601juKJ+DB9I7UzEVnBKOQ6cVZ7
 zYHBh5IeO2VcYnOu4xRIB4e4uCq1NVCTB+1WUw0u6JUsnTFdqx1XeUoQ==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Sree Kartheek Adivi <s-adivi@ti.com>
Subject: [isar-cip-core][PATCH v2 5/5] linux-cip: Update to 4.19.325-cip120-rt42
Date: Fri, 23 May 2025 16:47:47 +0200
Message-ID: <08665ab0b75a37c3e764cb5898ec6c317c53e069.1748011667.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1748011667.git.jan.kiszka@siemens.com>
References: <cover.1748011667.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 23 May 2025 14:48:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18948

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ....325-cip118-rt41.bb => linux-cip-rt_4.19.325-cip120-rt42.bb} | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 rename recipes-kernel/linux/{linux-cip-rt_4.19.325-cip118-rt41.bb => linux-cip-rt_4.19.325-cip120-rt42.bb} (68%)

diff --git a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip120-rt42.bb
similarity index 68%
rename from recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
rename to recipes-kernel/linux/linux-cip-rt_4.19.325-cip120-rt42.bb
index 8c32f39c..6f1351f2 100644
--- a/recipes-kernel/linux/linux-cip-rt_4.19.325-cip118-rt41.bb
+++ b/recipes-kernel/linux/linux-cip-rt_4.19.325-cip120-rt42.bb
@@ -11,4 +11,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "ac71b31b34e89e7d6daf98a202806037e44203d5d79bc74da5c57f5c24ccf946"
+SRC_URI[sha256sum] = "6ed1623cdc2a47131736848e2ba8b4674f9daa33dfb98feff8b062b275009dac"
-- 
2.43.0


