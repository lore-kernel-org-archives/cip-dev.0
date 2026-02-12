Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D40EEA855
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 21:40:27 +0000 (UTC)
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.56714.1770932418223498853
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 13:40:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=GszJRza/;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-20260212214014a6061d136000020721-8_1ats@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20260212214014a6061d136000020721
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Feb 2026 22:40:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=gplm513lA3Mzcp2bthivJCpUlajrHtmL7ZbZK1p2lcA=;
 b=GszJRza/09YB12CIOTgwR0X59K7RWZAYrmFootIE1XulwdbXpqVYYAWsYhLiqYSmYMyzQC
 jegu0fXxd0F+ZTIDI2/S2jhf8AyNXsfAACrFXwmm16kfT4nIa9YnYa8eSL5T5C/Qh/j8fTIl
 XGYyq3aRc3Lx1dclg8JsMgc64nMzk5PPrRntArogNZ6/WkDwxDnWqnDEuFemJY5DO6EzKmD5
 Y9rvZbRGcwIXdlSWwXiUPGxePyzKOvaFhe21CPnRy/m1yx8wZD7xRajtLWxzhugl0/pVffTy
 Hrk5FmJJ7oW+1VkLWs29W1FgGjvcoRY9JF4OXYKVjWIcxgl4xgwIiunw==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/1] swupdate: Enforce signature verification
Date: Thu, 12 Feb 2026 22:40:02 +0100
Message-ID: <20260212214003.734787-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 21:40:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21865

From: Alexander Heinisch <alexander.heinisch@siemens.com>

The self built versions of swupdate (used by default in distros < trixie)
do not enforce signature verification.

```
$ sudo swupdate -n -v -i demo.swu
[DEBUG] : SWUPDATE running :  [read_settings_file] : Reading config file /etc/swupdate.cfg
[DEBUG] : SWUPDATE running :  [read_module_settings] : Reading config settings for module globals
[TRACE] : SWUPDATE running :  [swupdate_dgst_init] : public key / cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set SIGALG
```

This patch modifies the swupdate configuration files to enforce signature
verification by default, which may break downstreams relying on unsigned
swupdate images. However, the diverged default config for signing and
verification of swu files is probably not desired anyways.

---

Changes in V3:
 - Reverted default value of SWU_SIGNED to empty string in swupdate.bbclass,
   which allows to control signing behaviour using CIP_IMAGE_OPTIONS.
 - The dependency on swupdate-certificates in case of signing is enabled
   is also handled in swupdate.inc via CIP_IMAGE_OPTIONS only.

Changes in V2:
 - Dropped patch introducing duplicate config in kas/opt/swupdate.yml


Alexander Heinisch (1):
  swupdate: Enforce signing and verification for swupdate by default.

 classes-recipe/swupdate.bbclass    | 4 ++--
 recipes-core/swupdate/swupdate.inc | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--
2.47.3


