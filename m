Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F866CCA47F
	for <webhook@archiver.kernel.org>; Fri,  3 Jun 2022 11:56:27 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.6378.1654257383157572484
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Jun 2022 04:56:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1
 header.b=LW8moQ++;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-2022060311561916ae63b294285c9134-5lpjty@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022060311561916ae63b294285c9134
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Jun 2022 13:56:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=zLiK62JmZDaiiiHbq71qckz1sYXQlxDq7kxlW1TN0Hs=;
 b=LW8moQ++Wr1rrULCwueLpA9GDbebvJtGAWQ3zmBfzb1CDS+d9l9mpSqRolnsrvtr3a7k/0
 HYtULZ5DRld94u41PPAer1zTwU29paWFhGMkFJ5Out6oGVq8zsHZMpAskDyIlZLJPJv6xV5U
 LN8cl2Ll0oCBDU3qLDveDzot35dso=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	adriaan.schmidt@siemens.com
Subject: [cip-dev][isar-cip-core][RFC 0/4] Adapt isar-cip-core to ISAR
 IMAGE_CMD_*
Date: Fri,  3 Jun 2022 13:56:14 +0200
Message-Id: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Jun 2022 11:56:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8485

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series adapt isar-cip-core to the IMAGE_CMD_* introduced in
ISAR commit [1]. See also ISAR API changelog[2].

This new feature remove the *.img from all wic images.

Also as new naming convention image recipes no longer end with `-img`.

The image types wic-swu-img and secure-wic-swu-img were removed.
Rename `squashfs-img` to squashfs according new naming scheme.

To use squashfs include:

    IMAGE_CLASSES += "squashfs"
    IMAGE_TYPEDEP_wic += "squashfs"


To create a verity based image to following line need to be added
to the local.conf or similar configuration:

    IMAGE_CLASSES += "verity"

The modifications for a read-only root file system are now part
of a bbclass which can be include directly into the image
recipe.

The modifications to generate a SWUpdate update package are
also no longer part of the image build process and in a seperate
bbclass. This class needs to be included in the image recipe.

Please check/test the interface changes for swupdate and read-only root
file system.

I tested qemu-amd64/qemu-arm64 with swupdate and secure boot.

Quirin

[1]: https://github.com/ilbers/isar/commit/f792fd0deed1ae1d9deb3ee28b1a1add96ecdf14
[2]: https://github.com/ilbers/isar/blob/next/RECIPE-API-CHANGELOG.md#changes-to-image-types

Quirin Gylstorff (4):
  ISAR update
  start-qemu.sh: adapt to new image names
  Adapt swupdate and verity to use new IMAGE_CMD_*
  scripts/deploy-cip-core: Adapt to new image names

 ...u-img.bbclass => read-only-rootfs.bbclass} | 11 +---
 classes/secure-wic-swu-img.bbclass            | 15 ------
 ...{squashfs-img.bbclass => squashfs.bbclass} | 15 ++----
 ...{swupdate-img.bbclass => swupdate.bbclass} |  8 +--
 .../{verity-img.bbclass => verity.bbclass}    | 51 +++++++++----------
 classes/wic-targz-img.bbclass                 | 15 ------
 conf/machine/bbb.conf                         |  2 +-
 conf/machine/hihope-rzg2m.conf                |  2 +-
 conf/machine/iwg20m.conf                      |  2 +-
 conf/machine/qemu-amd64.conf                  |  2 +-
 conf/machine/qemu-arm.conf                    |  2 +-
 conf/machine/qemu-arm64.conf                  |  2 +-
 conf/machine/simatic-ipc227e.conf             |  2 +-
 kas-cip.yml                                   |  2 +-
 kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
 kas/opt/efibootguard.yml                      |  2 +-
 kas/opt/swupdate.yml                          |  4 +-
 kas/opt/targz-img.yml                         |  2 +-
 recipes-core/images/files/sw-description.tmpl |  1 -
 recipes-core/images/swupdate.inc              |  6 ++-
 .../initramfs-verity-hook_0.1.bb              |  2 +-
 scripts/deploy-cip-core.sh                    |  8 +--
 start-qemu.sh                                 |  8 +--
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
 wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
 wic/x86-efibootguard.wks.in                   |  4 +-
 26 files changed, 69 insertions(+), 110 deletions(-)
 rename classes/{wic-swu-img.bbclass => read-only-rootfs.bbclass} (75%)
 delete mode 100644 classes/secure-wic-swu-img.bbclass
 rename classes/{squashfs-img.bbclass => squashfs.bbclass} (66%)
 rename classes/{swupdate-img.bbclass => swupdate.bbclass} (92%)
 rename classes/{verity-img.bbclass => verity.bbclass} (78%)
 delete mode 100644 classes/wic-targz-img.bbclass

-- 
2.35.1


