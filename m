Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AF8C3ABA3
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 11:33:38 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web11.45912.1745840009973901765
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 04:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=V/U6u87N;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-2025042811332600d161c0e1df0552ea-y9cc1z@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2025042811332600d161c0e1df0552ea
        for <cip-dev@lists.cip-project.org>;
        Mon, 28 Apr 2025 13:33:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=zbnHJJJ5smcJ6Zrez8qsGYMnR+gDJPT7Tp2VTGEPYSw=;
 b=V/U6u87Nw6zxeI8EVWvU8328ZKWlNfoVIvZ8pkalqi1R6rTjKLuh2M02oRluMOyob1iIL3
 nAsbvS4fQABk0hiQKY0MXjq/UfBOjq4sK+P5lUN3AGhmHnjVC7AMf9KXkmIC3Ma0rdCu6veD
 afSv3qT/38ZMrYzn/FoHpZU9Mk719v4Lm/uhbkfgnwOtUzT25/MM4L9/O0tCXfMWAGtwW1Ev
 3DAsP1Z7GXaX0sDjRiCghYIDEHxPj7O48WoY2+DmdVk+9smuc0b9nEIX2ZnycMmfQ49JNM6y
 EP6zogBKOma2FXk2NhQpGKpH5U4STg2S3T91n6c0H2i1COYWaFH5BSzw==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v3 0/4] Use kernel commandline for
Date: Mon, 28 Apr 2025 13:32:42 +0200
Message-ID: <20250428113325.3208873-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 11:33:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18695

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Take Felix work and add the missing abrootfs recipe.

This change allows to reduce the amount of initramfs builds as the
variable part is now consumed by the wic process.

This allows to use:
 - one initramfs for multiple images.

Changes in v3:
 - incorporate `wic(ebg): reduce search to generate the verity environment` in
 `wic(ebg): add support to add verity env to cmdline`
 - Move common parts for env file reading to new function _generate_kernel_opts_from_file 

Changes in v2:
 - fix some typos in commit message
 - use `IMAGE_BASENAME` to search for the initramfs
 - add missing abrootfs

Felix Moessbauer (2):
  wic(ebg): add support to add verity env to cmdline
  port verity env handling to new kernel cmdline infrastructure

Quirin Gylstorff (2):
  wic(ebg): add support to abrootfs env to cmdline
  port abrootfs env handling to new kernel cmdline infrastructure

 kas/opt/security.yml                          |  1 -
 .../initramfs-abrootfs-hook/files/hook        |  5 --
 .../files/local-top-complete                  | 21 +++++++-
 .../initramfs-abrootfs-hook_0.2.bb            | 21 +-------
 .../initramfs-verity-hook/files/hook          |  1 -
 .../files/local-top-complete.tmpl             | 41 ++++++++++++++-
 .../initramfs-verity-hook_0.2.bb              | 24 +--------
 .../wic/plugins/source/efibootguard-boot.py   | 51 +++++++++++++++++++
 wic/ebg-signed-sysparts.inc                   |  4 +-
 wic/ebg-sysparts.inc                          |  4 +-
 10 files changed, 117 insertions(+), 56 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook

-- 
2.47.0


