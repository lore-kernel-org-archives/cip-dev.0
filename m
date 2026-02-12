Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FB5ECD6EA
	for <webhook@archiver.kernel.org>; Thu, 12 Feb 2026 13:01:54 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.44450.1770901311022827845
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Feb 2026 05:01:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=Y4jDBX+m;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1330684-20260212130147481477fedf000207ab-_ksvpb@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20260212130147481477fedf000207ab
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Feb 2026 14:01:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=c6UKxX+mjROw8kJ7E6NKvjqE1xzgCyC+f9kDtmwvmTU=;
 b=Y4jDBX+m7zbwlslVXe0kjq/FgiB4nEhrI9lMM2hjYW5eMZGm0tNpJkOic0KV1KnCddKCgt
 U9bsNAkLQa77RgmL+Wd9YfBKaf2NQzUDgMKel53EyETopMoyhHkrytAPZd1m/FeYWPi8PdkF
 BAFMcAeWoHscACTWZKSnhxNmKuZsBl4gkcgozAvjrwgkIg+249Lvy2+YhBIxCeu/pfPWZmOQ
 x+aCxfTrdYF/veet+4QkMR/hSDfCXvdlryG7T5kVZYLJVjz8nWLyLWTfnJpx22TcsfnTRvXP
 4Gt8wS6knWO3SQhS+/lM7uRKZZqumUJU+Hh21cvnTMEWwvCqkhy3/27A==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/1] swupdate: Enforce signature verification
Date: Thu, 12 Feb 2026 14:01:40 +0100
Message-ID: <20260212130141.709378-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Feb 2026 13:01:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21862

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

Changes in V2:
 - Dropped patch introducing duplicate config in kas/opt/swupdate.yml

Alexander Heinisch (1):
  swupdate: Enforce signing and verification for swupdate by default.

 classes-recipe/swupdate.bbclass    | 2 +-
 recipes-core/images/swupdate.inc   | 2 +-
 recipes-core/swupdate/swupdate.inc | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

--
2.47.3


