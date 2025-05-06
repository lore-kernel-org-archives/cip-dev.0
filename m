Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A31C3ABC0
	for <webhook@archiver.kernel.org>; Tue,  6 May 2025 12:08:14 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web11.74573.1746533291150690777
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 May 2025 05:08:11 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=c2JUOivj;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-20250506120807dcdb54e5b489541398-vyorp9@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 20250506120807dcdb54e5b489541398
        for <cip-dev@lists.cip-project.org>;
        Tue, 06 May 2025 14:08:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=QloN8zvyRamZU7BE4UZE799R3fb/QpxziBxC3m/6Kmc=;
 b=c2JUOivjlkhATxex8EmRxlHdt0lo5pt2v9han1V84opcl7hyK400oN3/IvY2mJWKP20Hcq
 N5Py1JbDl9AnOETXpR9XA2T0t+tDbmC1lZtggrOXcVnk4NvOoYzedwdmODnFzw+XOLNjQbNQ
 MeY9C4IypBrOrpi5VEvyeNIG37mgnD4vWLuy+RdCTARPNwq6lXTgCmKK78QmsuEp0ltlWO2d
 kdLO1M7uhP91qK+vxB36E1yTQTz84PpD01TuwxtiS+L9C273jRA4XGEgjhHG9EvkRlURJruU
 ckSdyWmGHa67E5D70TIlncqNdW+DE4jXD5doNBIuxvgst0zagwMxXeJA==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][RFC v2 0/6] Add factory-reset
Date: Tue,  6 May 2025 14:07:42 +0200
Message-ID: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 May 2025 12:08:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18766

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>


This adds an new hooks for factory-reset to the
initramfs. This hook will

- format the disk.
- In case of a encrypted disk factory reset the TPM is cleared(all keys
  are deleted)

In case of an encrypted file system the marker hook needs to be stored
in a readable location, e.g. one of the boot partitions or the efi
partition.

Changes v2:
 - make marker check a separate script
 - change data-reset to factory-reset hook

Quirin Gylstorff (6):
  add factory-reset initramfs hook
  add factory-reset-helper to set the marker file
  encrypt-data.yml: Add factory-reset information to encrypt-data
  cip-core-image: add factory-reset helper
  add factory-reset to initramfs
  Add settings for factory-reset with a separate home partition

 kas/opt/encrypt-data.yml                      |  3 +
 kas/opt/separate-home-partition.yml           |  3 +
 recipes-core/images/cip-core-image.bb         |  2 +-
 .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
 .../files/detect-marker-file                  | 33 +++++++++
 .../initramfs-factory-reset-hook/files/hook   |  7 ++
 .../files/local-top-complete                  | 67 +++++++++++++++++++
 .../files/reset-env.tmpl                      |  4 ++
 .../initramfs-factory-reset-hook_0.1.bb       | 52 ++++++++++++++
 .../factory-reset-helper_0.1.bb               | 34 ++++++++++
 .../files/set-factory-reset-marker.sh.tmpl    | 28 ++++++++
 11 files changed, 233 insertions(+), 1 deletion(-)
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
 create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
 create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl

-- 
2.47.0


