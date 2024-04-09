Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFE1CD129C
	for <webhook@archiver.kernel.org>; Tue,  9 Apr 2024 13:06:50 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.135728.1712668003619983950
 for <cip-dev@lists.cip-project.org>;
 Tue, 09 Apr 2024 06:06:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=KzdmoGAr;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-51332-202404091306412426775a395b2cd044-2poob8@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202404091306412426775a395b2cd044
        for <cip-dev@lists.cip-project.org>;
        Tue, 09 Apr 2024 15:06:41 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=gyOHq8aO6lkSZ5WPPxkF9fxmpmxTcYVIVUHlHQ1sdJ4=;
 b=KzdmoGArZVDmTEkhBw2St6vJhDWOzr3Lw3tJe+ffJC7Z7bYtSx4mE4TNRuc/ODgLc0L9PV
 J6nsL+EgRTlYNfhj/kTuRBkuB242OXbfCRA4UqGzSx3o+wb1cDnBl/RyhoRHSxKkF3u00wI1
 +P4HVlaufqjjst7/tQDfKKtsc/gks=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	johnxw@amazon.com
Subject: [cip-dev][isar-cip-core][PATCH v3 11/15] initramfs-crypt-hook: Increase version
Date: Tue,  9 Apr 2024 15:05:28 +0200
Message-ID: <20240409130638.559398-12-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
References: <20240409130638.559398-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Apr 2024 13:06:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15523

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


