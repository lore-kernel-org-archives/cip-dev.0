Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C3DC47DA2
	for <webhook@archiver.kernel.org>; Thu, 11 Jan 2024 20:00:26 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.2403.1705003220101024642
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Jan 2024 12:00:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=Dgt8dADE;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240111200018cc29d7e62844b5b01f-ivkydh@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240111200018cc29d7e62844b5b01f
        for <cip-dev@lists.cip-project.org>;
        Thu, 11 Jan 2024 21:00:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=r3Pj9a+WZZuJUjaM2aQt+VHELdoCELUCCYMEUS9cc1E=;
 b=Dgt8dADEUgf/5ly3BjqZjExU24ybB6T/qGiM5P1zIquHdoxiI14XpYfjqY5ICf1sb3ymTk
 jNcdN0wBaSK5UCJkIC1L26gcWXk9b008qgKZd2IylZNmhDuA3u5yX+P1G83VBAzPuDx1IBGN
 K0bHtPm2Qp/2q4CuA9UjyIApHO7e4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 7/7] doc/README.swupdate.md: add new section for bootloader updates
Date: Thu, 11 Jan 2024 20:59:51 +0100
Message-ID: <20240111200015.190376-8-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
References: <20240111200015.190376-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Jan 2024 20:00:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14339

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 doc/README.swupdate.md | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
index 00359c7..1c94699 100644
--- a/doc/README.swupdate.md
+++ b/doc/README.swupdate.md
@@ -7,6 +7,19 @@ Start with cloning the isar-cip-core repository:
 ```
 host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
 ```
+## SWUpdate Efibootguard update
+
+:warning: **If the efibootguard binary is corrupted the system can no longer boot**
+
+If you build a CIP Core image with SWUpdate support an additional swu will
+be generated. This swu ends on `*-ebg.swu` and contains a sw-description to
+update only efibootguard. SWUpdate will copy the file to a temporary location
+and rename the binary in place to reduce the time the system can be destroyed
+by a power failure. As FAT partitions have **no** atomic operations a small error
+window is still possible.
+
+If the variable `SWU_EBG_UPDATE` is set to `"1"` the update is also stored in
+the `*.swu` file.
 
 # Building and testing the CIP Core image
 
-- 
2.43.0


