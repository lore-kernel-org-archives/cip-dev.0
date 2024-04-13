Return-Path: <cedric.hombourger@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA48C4345F
	for <webhook@archiver.kernel.org>; Sat, 13 Apr 2024 10:02:07 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.web10.7892.1713002521678211146
 for <cip-dev@lists.cip-project.org>;
 Sat, 13 Apr 2024 03:02:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=cedric.hombourger@siemens.com header.s=fm1 header.b=fwZzEmaw;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1212295-20240413100157d7c2a9d6e2608f2dba-sjgk6e@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20240413100157d7c2a9d6e2608f2dba
        for <cip-dev@lists.cip-project.org>;
        Sat, 13 Apr 2024 12:01:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=cedric.hombourger@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=DPI1VCX/ZxB5v1rgW/0w2WGIcOzps8KGtKPuOpw8RUE=;
 b=fwZzEmawHecakWvH08DtjGZXFOvxoKy41naTV3Rxla12h2emSWzzSIlLiZTBK0usoOT6eB
 vku4EkfKrCqVnPoG/RgE9qdQNv+7w644le9DK/5D1Y66YfAFYsVVjKV78i31uoNem5APUPDw
 gglLEtdjFV0ysurEB06Ldv3nI7wKc=;
From: Cedric Hombourger <cedric.hombourger@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Cedric Hombourger <cedric.hombourger@siemens.com>
Subject: [PATCH v2 0/1] recipes-devtools: use DPKG_ARCH=all for arch-independent packages
Date: Sat, 13 Apr 2024 12:01:39 +0200
Message-Id: <20240413100140.2432650-1-cedric.hombourger@siemens.com>
In-Reply-To: <17C5CC2DB0C515DA.10043@lists.cip-project.org>
References: <17C5CC2DB0C515DA.10043@lists.cip-project.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1212295:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 13 Apr 2024 10:02:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15553

Changes since v1:
 * Add missing PV bump for swupdate-certificates-snakeoil
   Reported-by: Jan Kiszka

Cedric Hombourger (1):
  recipes-devtools: use DPKG_ARCH=all for arch-independent packages

 ...g-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} | 1 +
 .../{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb}           | 0
 recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc     | 1 +
 .../{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} | 0
 ...snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} | 0
 .../swupdate-certificates/swupdate-certificates-key.inc          | 1 +
 ...-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} | 0
 ...tes-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} | 0
 recipes-devtools/swupdate-certificates/swupdate-certificates.inc | 1 +
 ...swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} | 0
 10 files changed, 4 insertions(+)
 rename recipes-devtools/ebg-secure-boot-signer/{ebg-secure-boot-signer_0.1.bb => ebg-secure-boot-signer_0.2.bb} (96%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-key_0.1.bb => secure-boot-key_0.2.bb} (100%)
 rename recipes-devtools/secure-boot-secrets/{secure-boot-snakeoil_0.1.bb => secure-boot-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key-snakeoil_0.1.bb => swupdate-certificates-key-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-key_0.1.bb => swupdate-certificates-key_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates-snakeoil_0.1.bb => swupdate-certificates-snakeoil_0.2.bb} (100%)
 rename recipes-devtools/swupdate-certificates/{swupdate-certificates_0.1.bb => swupdate-certificates_0.2.bb} (100%)

-- 
2.34.1


