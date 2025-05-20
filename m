Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66168C54756
	for <webhook@archiver.kernel.org>; Wed, 21 May 2025 01:03:12 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.19419.1747743793909422527
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 May 2025 05:23:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=christoph.steiger@siemens.com header.s=fm1 header.b=C/VZsqwj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1328957-202505201223109c5e2aabacb3767d07-az058_@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 202505201223109c5e2aabacb3767d07
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 May 2025 14:23:10 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=christoph.steiger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=SgEH8XZnSbRh/CdhVXsi32R3eP9+RcImkTNZAUumUzw=;
 b=C/VZsqwjyRHy+GZ1KKDFAdDrBBkTgyDBrdBUmYPm5w9HY8v5LgaVqTdaXo9ZBX8S5ZZ3x9
 YJPpXrYMm2MLpFxYbfjGqoXYtba2MyUwqYaMcFwfyH+RLHyGCYMoL+80u7CSJyvDQTDe+MyL
 OGn/AKHtSEhujmRgGXOqaMtsZmBdFgm7ZHXE+1LFsW8hkQDLy8rNoEnakvjhcAZUXDZTlB4+
 tMfimKnaUe8UDL2BxF9IklGrR/iI4S52S0qzTE2ZL4Q1CI4BO7D7iC1EYYcKKahqYAxbE/+Q
 iWj9YjjJ66YwSL31g/Z0zR7qalyF8B+ewy/c8W1JZbF/F/a2lNPv9MHQ==;
From: Christoph Steiger <christoph.steiger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Adrian Hunter <adrian.hunter@intel.com>,
	Christoph Steiger <christoph.steiger@siemens.com>
Subject: [PATCH 4.19.y-cip 1/1] mmc: sdhci: Do not lock spinlock around mmc_gpio_get_ro()
Date: Tue, 20 May 2025 14:23:09 +0200
Message-Id: <20250520122309.180558-2-christoph.steiger@siemens.com>
In-Reply-To: <20250520122309.180558-1-christoph.steiger@siemens.com>
References: <20250520122309.180558-1-christoph.steiger@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1328957:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 May 2025 01:03:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18930

From: Adrian Hunter <adrian.hunter@intel.com>

[ Upstream commit ab069ce125965a5e282f7b53b86aee76ab32975c ]

sdhci_check_ro() can call mmc_gpio_get_ro() while holding the sdhci
host->lock spinlock. That would be a problem if the GPIO access done by
mmc_gpio_get_ro() needed to sleep.

However, host->lock is not needed anyway. The mmc core ensures that
host operations do not race with each other, and asynchronous callbacks
like the interrupt handler, software timeouts, completion work etc,
cannot affect sdhci_check_ro().

So remove the locking.

This patch inadvertedly also fixes another similar problem in
sdhci_check_ro(): mmc_gpio_get_ro() might be called from
host->ops->get_ro() which causes the same SAC bug. This is the case for
a couple of drivers e.g. sdhci-esdhc-imx. Thus we want to have this fix
even if 6d5cd068ee59 is introduced later.

Fixes: 6d5cd068ee59 ("mmc: sdhci: use WP GPIO in sdhci_check_ro()")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20240614080051.4005-3-adrian.hunter@intel.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[ added last paragraph ]
Signed-off-by: Christoph Steiger <christoph.steiger@siemens.com>
---
 drivers/mmc/host/sdhci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index b7afbeeca08a..287865d90e05 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1968,11 +1968,8 @@ static int sdhci_get_cd(struct mmc_host *mmc)
 
 static int sdhci_check_ro(struct sdhci_host *host)
 {
-	unsigned long flags;
 	int is_readonly;
 
-	spin_lock_irqsave(&host->lock, flags);
-
 	if (host->flags & SDHCI_DEVICE_DEAD)
 		is_readonly = 0;
 	else if (host->ops->get_ro)
@@ -1981,8 +1978,6 @@ static int sdhci_check_ro(struct sdhci_host *host)
 		is_readonly = !(sdhci_readl(host, SDHCI_PRESENT_STATE)
 				& SDHCI_WRITE_PROTECT);
 
-	spin_unlock_irqrestore(&host->lock, flags);
-
 	/* This quirk needs to be replaced by a callback-function later */
 	return host->quirks & SDHCI_QUIRK_INVERTED_WRITE_PROTECT ?
 		!is_readonly : is_readonly;
-- 
2.39.5


