Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B52D29C42
	for <webhook@archiver.kernel.org>; Mon, 19 Jan 2026 16:25:22 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.38511.1768839920294137774
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Jan 2026 08:25:20 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=VIcvfSbb;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-1330684-20260119162517d906ccd80a000207d4-utvaye@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260119162517d906ccd80a000207d4
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Jan 2026 17:25:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=BKmS7LKtefHd1gUDW5NKcrerbrWU3+VNlgvPR9O2iIc=;
 b=VIcvfSbbI/v5+0hWnt4sbHT7I/1PIEVZzYlBL5mpspYx5faFQ7I2mSXTQWtplzQU/8xZCG
 eDG9Tn4Md0M8C4IXTjQL4HGALKfXjFde6ystuXvKsJJ8aNVciNl2fiC6uLg3fFaecVchmHy1
 9uI3C3CstcdHDC47C3/BDNdUBWjeKOB8mqu6kTNLw59fgmBLJo4pT3f/ytQMpIhSw1N/HJFz
 UJ5OZIQbvncj6+12WgqJwfMSNozZdV+W7SNdOqk1W/2IojV2zeHyUuQQmsal9X+AnvisICbm
 V+LwP/mJPLgyUknD6v/w3Df8hFosidaSSHghqPKZnqguY/ERoG6WXWew==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] swupdate: Enforce signature verification
Date: Mon, 19 Jan 2026 17:24:42 +0100
Message-ID: <20260119162444.672037-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Jan 2026 16:25:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21675

From: Alexander Heinisch <alexander.heinisch@siemens.com>

The self built versions of swupdate (used by default in distros < trixie)
do not enforce signature verification.

```
$ sudo swupdate -n -v -i demo.swu
[DEBUG] : SWUPDATE running :  [read_settings_file] : Reading config file /etc/swupdate.cfg
[DEBUG] : SWUPDATE running :  [read_module_settings] : Reading config settings for module globals
[TRACE] : SWUPDATE running :  [swupdate_dgst_init] : public key / cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set SIGALG
```

This patch series enables signature verification by default for swupdate.
The series is split into two patches:
1) Build swupdate with signature check enabled.
   This simply fixes the provided demo build configuration in the kas file
   (+ ./kas-container menu).

2) Enforce signing and verification for swupdate by default.
    This patch modifies the swupdate configuration files to enforce signature
    verification by default, which may break downstreams relying on unsigned
    swupdate images. However, the diverged default config for signing and
    verification of swu files is probably not desired anyways.


Alexander Heinisch (2):
  swupdate: Build swupdate with signature check enabled.
  swupdate: Enforce signing and verification for swupdate by default.

 classes-recipe/swupdate.bbclass    | 2 +-
 kas/opt/swupdate.yml               | 1 +
 recipes-core/images/swupdate.inc   | 2 +-
 recipes-core/swupdate/swupdate.inc | 1 +
 4 files changed, 4 insertions(+), 2 deletions(-)

--
2.47.3


