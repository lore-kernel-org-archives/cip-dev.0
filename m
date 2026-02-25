Return-Path: <alexander.heinisch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55489FD376D
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 15:52:44 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.48365.1772034757875604459
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 07:52:39 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=hsAs9o3b;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-1330684-20260225155234b33af77477000207ec-cdupee@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20260225155234b33af77477000207ec
        for <cip-dev@lists.cip-project.org>;
        Wed, 25 Feb 2026 16:52:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZBey7SsXTmkfm5g6Oxj+rwi7JNpWHGF/R22EDOyp/x8=;
 b=hsAs9o3brQfks1CQys4nNIrPEZEMK1MhWa7uCBP17ltTbp0Q3cH8WZ73OomuNVKFUSVFKN
 r4l8QdSYkX08zyXAh46+rNxJTpbNIj2K9yioNokInM6bd9s1ghUwg/ut0kwlv5lWfp34DkQ/
 WmoWotk1zLVMcuiNlO9zlJmU+2VTVVcNow0JNEdd2JNS17+AXdWJ+t+/lrtdggaRexEDa2a5
 tiM0SU9OPUpJNBNlwK9uuuuJVjOpM+2GUGvbx/DG8B5un2kap1LJ2fLwPb1xXQugffm9GiCw
 G6PAF/Vso+/bfPhLZvC8ArnbyBZIzNfjWnNFHQoTkC8PlrEdM/s+Nq4g==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com,
	jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v4 0/2] swupdate: Enforce signature verification
Date: Wed, 25 Feb 2026 16:52:24 +0100
Message-ID: <20260225155226.534978-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 15:52:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21983

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

Changes in V4:
  - Split the patch into two commits, one for enforcing signature verification
    and one to fix unintended modification of the image in swupdate class.

Changes in V3:
 - Reverted default value of SWU_SIGNED to empty string in swupdate.bbclass,
   which allows to control signing behaviour using CIP_IMAGE_OPTIONS.
 - The dependency on swupdate-certificates in case of signing is enabled
   is also handled in swupdate.inc via CIP_IMAGE_OPTIONS only.

Changes in V2:
 - Dropped patch introducing duplicate config in kas/opt/swupdate.yml

Alexander Heinisch (2):
  swupdate: Enforce signing and verification for swupdate by default.
  swupdate: Fix unintended modification of the image in swupdate class

 classes-recipe/swupdate.bbclass    | 4 ++--
 recipes-core/swupdate/swupdate.inc | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

--
2.47.3


