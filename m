Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05481C369D8
	for <webhook@archiver.kernel.org>; Tue, 22 Apr 2025 14:51:07 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.41949.1745333458388214364
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Apr 2025 07:50:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=T/HoJPXL;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-20250422145055f56b7f4534434d98c7-z5mwmb@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20250422145055f56b7f4534434d98c7
        for <cip-dev@lists.cip-project.org>;
        Tue, 22 Apr 2025 16:50:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=BV+7hs+JgQI7kEqmB/PXjFNoADbnREiYfz110ldo7Cc=;
 b=T/HoJPXLVU6Lw83R1imFLTlk3xHJAzWHSE5aqOXVfIXlQ9aKL7lpVghjCE67I6XrQTXKH/
 S1Omq7A8iS8Y6yv/arvBsZUVTDB/seEorYm0qKHGSBhc8QA1v28lyZj/zi9D46Xra/nmJjoF
 IlstE1SeZMH3dDdM7Bp57WCwUEWXseZ1KUE+wLkmQpxeC9/pIiwY8lWFC6KOxDsXWNNtBLbx
 Yno9dq6U9oTV7Qzj2sNvVPSQYDzuAXGdwu73JR0jNk/x4+Qqsvs/WOp4QZnUjvd/d3WzMc9y
 MBeHvgyMPei0i8PZHOo1YWZQaufOnh1rsSyH4tZpahy6jau3sEQB5jqA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 0/5] Use kernel commandline for
Date: Tue, 22 Apr 2025 16:35:21 +0200
Message-ID: <20250422145055.1095348-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Apr 2025 14:51:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18562

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Take Felix work and add the missing abrootfs recipe.

This change allows to reduce the amount of initramfs builds as the
variable part is now consumed by the wic process.

This allows to use:
 - one initramfs for multiple images.


Changes in v2:
 - fix some typos in commit message
 - use `IMAGE_BASENAME` to search for the initramfs
 - add missing abrootfs

Felix Moessbauer (2):
  wic(ebg): add support to add verity env to cmdline
  port verity env handling to new kernel cmdline infrastructure

Quirin Gylstorff (3):
  wic(ebg): add support to abrootfs env to cmdline
  wic(ebg): reduce search to generate the verity environment
  port abrootfs env handling to new kernel cmdline infrastructure

 kas/opt/security.yml                          |  1 -
 .../initramfs-abrootfs-hook/files/hook        |  5 --
 .../files/local-top-complete                  | 21 ++++++-
 .../initramfs-abrootfs-hook_0.2.bb            | 21 +------
 .../initramfs-verity-hook/files/hook          |  1 -
 .../files/local-top-complete.tmpl             | 41 +++++++++++++-
 .../initramfs-verity-hook_0.2.bb              | 24 +-------
 .../wic/plugins/source/efibootguard-boot.py   | 55 +++++++++++++++++++
 wic/ebg-signed-sysparts.inc                   |  4 +-
 wic/ebg-sysparts.inc                          |  4 +-
 10 files changed, 121 insertions(+), 56 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook

-- 
2.47.0


