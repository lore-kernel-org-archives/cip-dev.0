Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C57C25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 14:49:12 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.23981.1716907747134903251
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 07:49:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=tZBzbQHU;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240528144904b7e8838e0a7680fed4-7_bw23@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240528144904b7e8838e0a7680fed4
        for <cip-dev@lists.cip-project.org>;
        Tue, 28 May 2024 16:49:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=AyuQBcQA0GHsRWqxDKDNvgIyaKsPEdzaJU37jtPxpSI=;
 b=tZBzbQHUf5VKDvY4jMkpZbXFTLjSg3g08YMzmQ8lkYBkoHXhQfOVC+ygk5QC1e2srMGb8+
 ldbC+LeFXSqIqgwoPFsfZkmLPHM4lBWZR4zSk/JAB0Ke6GXC/3bCu/A3aWZWQYWSq+1bv4Md
 CT1h9E6EpzvQ286kFU5zZcoxUl7vM=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH 1/3] Move security-customizations to recipes-security
Date: Tue, 28 May 2024 16:42:43 +0200
Message-ID: <20240528144903.922587-2-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
References: <20240528144903.922587-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 14:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15964

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This increase the readability and organizes the the cip-core layer.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../security-customizations/files/postinst                        | 0
 .../security-customizations/files/ssh-pam-remote.conf             | 0
 .../security-customizations/files/ssh-remote-session-term.conf    | 0
 .../security-customizations/security-customizations.bb            | 0
 4 files changed, 0 insertions(+), 0 deletions(-)
 rename {recipes-core => recipes-security}/security-customizations/files/postinst (100%)
 rename {recipes-core => recipes-security}/security-customizations/files/ssh-pam-remote.conf (100%)
 rename {recipes-core => recipes-security}/security-customizations/files/ssh-remote-session-term.conf (100%)
 rename {recipes-core => recipes-security}/security-customizations/security-customizations.bb (100%)

diff --git a/recipes-core/security-customizations/files/postinst b/recipes-security/security-customizations/files/postinst
similarity index 100%
rename from recipes-core/security-customizations/files/postinst
rename to recipes-security/security-customizations/files/postinst
diff --git a/recipes-core/security-customizations/files/ssh-pam-remote.conf b/recipes-security/security-customizations/files/ssh-pam-remote.conf
similarity index 100%
rename from recipes-core/security-customizations/files/ssh-pam-remote.conf
rename to recipes-security/security-customizations/files/ssh-pam-remote.conf
diff --git a/recipes-core/security-customizations/files/ssh-remote-session-term.conf b/recipes-security/security-customizations/files/ssh-remote-session-term.conf
similarity index 100%
rename from recipes-core/security-customizations/files/ssh-remote-session-term.conf
rename to recipes-security/security-customizations/files/ssh-remote-session-term.conf
diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-security/security-customizations/security-customizations.bb
similarity index 100%
rename from recipes-core/security-customizations/security-customizations.bb
rename to recipes-security/security-customizations/security-customizations.bb
-- 
2.43.0


