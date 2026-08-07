Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27FD3C5AC7A
	for <webhook@archiver.kernel.org>; Fri,  7 Aug 2026 15:45:17 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.45553.1786117509547905458
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Aug 2026 08:45:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=ZSFCNdW/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-20260807154507b432a9605200020784-rdvtxn@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 20260807154507b432a9605200020784
        for <cip-dev@lists.cip-project.org>;
        Fri, 07 Aug 2026 17:45:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=frymdwzF3PGUmHH8O5EriT+3XZvgo8NlDa2AXjSP4qc=;
 b=ZSFCNdW/GjU8jioYGmLRHGyyDP7PBxT/ymscDhk9vrj0k5Ixbv0QvVole49U5GwKYP9Abt
 WjvL4sCXwSbWkHTGQfdqk0Ez0Ecs5bF8i3c+4oyRpJLT3lLgt4LgomXvGYlBzmWPvXyXEeRE
 qvuE345lnWL9jrXsDoF85+3D0xw5/dxYtr0LtfGms91uTpEiNWeOZl02S0iF7ciumm4tm7tW
 dMZqYqdZMHV0xwY6IYhro2AgEpd9s9Rcnxo6QNsXiev/LDvXe/Zus05HGb0V+/zFv1GC/nr0
 SWdQzJ3a4sEas3VggFrDqZuMLLpj1i7Sn9Eme7++Zgy3Q0ZrLAdHo0QQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 2/2] Kconfig: Do not offer factory reset with full disk encryption enabled.
Date: Fri,  7 Aug 2026 17:44:39 +0200
Message-ID: <20260807154439.625212-3-alexander.heinisch@siemens.com>
In-Reply-To: <20260807154439.625212-1-alexander.heinisch@siemens.com>
References: <20260807154439.625212-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Aug 2026 15:45:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23877

From: Alexander Heinisch <alexander.heinisch@siemens.com>

By default factory reset clears the tpm. Therefore, keys needed to
decrypt the immutable A/B rootfs in full disk encryption setups
cannot be retrieved anymore. Thus, the boot fails and the device
cannot be recovered.

Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
---
 Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Kconfig b/Kconfig
index abf9aaf..55911da 100644
--- a/Kconfig
+++ b/Kconfig
@@ -359,7 +359,7 @@ config SEPARATE_HOME_PARTITION
 
 config FACTORY_RESET
 	bool "Enable factory reset"
-	depends on IMAGE_SWUPDATE && (HAS_EFIVARS || !(IMAGE_FULL_ENCRYPTION || IMAGE_DATA_ENCRYPTION))
+	depends on IMAGE_SWUPDATE && (HAS_EFIVARS || !IMAGE_DATA_ENCRYPTION) && !IMAGE_FULL_ENCRYPTION
 	help
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.md.
-- 
2.47.3


