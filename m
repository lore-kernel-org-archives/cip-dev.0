Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170D0CD1282
	for <webhook@archiver.kernel.org>; Fri, 22 Mar 2024 10:06:20 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.9597.1711101970934025681
 for <cip-dev@lists.cip-project.org>;
 Fri, 22 Mar 2024 03:06:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=dUjlIWPB;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20240322100608c6078c07275c216993-mgqaeu@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20240322100608c6078c07275c216993
        for <cip-dev@lists.cip-project.org>;
        Fri, 22 Mar 2024 11:06:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gyOHq8aO6lkSZ5WPPxkF9fxmpmxTcYVIVUHlHQ1sdJ4=;
 b=dUjlIWPBusHNHnKizJuY7HAXsLJj/dRkWJv83uZfbHf+8R4zxjCEnLxQpiUry88cf8IZGP
 B13knD6OhfIIl6EEMvasyWBaXEUJodoCNxSdiEmJVcV3OtIS2f12/5oo5+y7yLwUVjjzQgeG
 BnxOKxxPjy1EaVU5nB/WdXKUaw6xs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v2 11/13] initramfs-crypt-hook: Increase version
Date: Fri, 22 Mar 2024 11:05:21 +0100
Message-ID: <20240322100605.4129226-12-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
References: <20240322100605.4129226-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 22 Mar 2024 10:06:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15407

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This package had significate changes

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../{initramfs-crypt-hook_0.1.bb => initramfs-crypt-hook_0.2.bb}  | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename recipes-initramfs/initramfs-crypt-hook/{initramfs-crypt-hook_0.1.bb => initramfs-crypt-hook_0.2.bb} (100%)

diff --git a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
similarity index 100%
rename from recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.1.bb
rename to recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.2.bb
-- 
2.43.0


