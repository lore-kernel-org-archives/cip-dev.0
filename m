Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD835D78337
	for <webhook@archiver.kernel.org>; Mon,  2 Dec 2024 14:51:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.174653.1733151094835637345
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Dec 2024 06:51:35 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=RDPXl+VX;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202412021451307065c1521d16ec5f67-6gpbmg@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202412021451307065c1521d16ec5f67
        for <cip-dev@lists.cip-project.org>;
        Mon, 02 Dec 2024 15:51:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=7hOrchbnXlMxSPyVG4kxyNwO9WCEr9pmPYbVBrskxIs=;
 b=RDPXl+VXKdreiiAkY1kZvqokzhYJY3daXOPh3X6gi2rTnVuMLKxU/buvV97d9IAQJp3tDm
 xWnaUMrIh4s2zf7rpylt9XJUNDU9c/ovddbENAp+jAhH7NFa0saXKVIKtZdaYHeWSsveRLen
 yMg/qxC8kKZqyxd3HShqJZhEa0n4rDjG/dIelixYxvOgPm2xmnhMzEktvfByT8ZRaXySfnA/
 dyKkpmobDAZtI1Z9zjp2L4UTKYiN2AaeUY9CNMn22m/bcoKL3HtA67bnRR2mvdDTkwTG/CQn
 wPSNHkvbsApoNFHyBpR6YB3X7ckeY26O8/Rm3XXlJglklieP9dYGZAMg==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Alexander Heinisch <alexander.heinisch@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 00/10] Various initramfs hook improvements
Date: Mon,  2 Dec 2024 15:51:03 +0100
Message-ID: <cover.1733151072.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 02 Dec 2024 14:51:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17310

This uses the new initramfs hook generator of isar to simplify our own
hook recipes.

It furthermore brings support for expanding the last partition before
encrypting it. This needs to be done as part of the initramfs-crypt-hook
because we only know there which device and which partition to use.

Finally, this improves the security of the disk encryption keys by
preventing access to them after initramfs usage. Thus, the main Linux is
now no longer able to leak the keys during an attack.

Jan

Jan Kiszka (10):
  Update isar revision
  initramfs-abrootfs-hook: Convert to hook.inc
  initramfs-crypt-hook: Convert awk statement into simple variable
    evaluation
  initramfs-crypt-hook: Convert to hook.inc
  initramfs-erofs/squashfs-hook: Convert to hook.inc
  initramfs-overlay-hook: Convert to hook.inc
  initramfs-verity-hook: Drop dead verity.conf-hook artifact
  initramfs-verity-hook: Convert to hook.inc
  initramfs-crypt-hook: Add support for expanding encrypted partition
  initramfs-crypt-hook: invalidate PCR7 after unlocking partitions

 kas-cip.yml                                   |   2 +-
 kas/opt/expand-on-first-boot.yml              |   3 +
 .../files/abrootfs.hook                       |  24 -----
 .../initramfs-abrootfs-hook/files/hook        |   5 +
 .../{abrootfs.script => local-top-complete}   |   0
 ..._0.1.bb => initramfs-abrootfs-hook_0.2.bb} |  25 ++---
 ...pt_partition.clevis.bullseye_or_later.hook |  34 ------
 .../encrypt_partition.clevis.buster.hook      |  29 -----
 .../files/encrypt_partition.clevis.hook       |  88 ---------------
 .../files/encrypt_partition.systemd.hook      |  68 ------------
 .../initramfs-crypt-hook/files/hook           |  11 ++
 ...artitions.script => local-bottom-complete} |   0
 ...pt_partition.script => local-top-complete} |  68 +++++++++++-
 .../initramfs-crypt-hook_0.4.bb               |  96 -----------------
 .../initramfs-crypt-hook_0.5.bb               | 101 ++++++++++++++++++
 .../initramfs-erofs-hook/files/erofs.hook     |  25 -----
 .../initramfs-erofs-hook_0.1.bb               |  24 -----
 .../initramfs-erofs-hook_0.2.bb               |  14 +++
 ...{overlay.script.tmpl => local-bottom.tmpl} |  23 +---
 .../initramfs-overlay-hook/files/overlay.hook |  34 ------
 ...k_0.1.bb => initramfs-overlay-hook_0.2.bb} |  20 ++--
 .../initramfs-squashfs-hook_0.1.bb            |  24 -----
 .../initramfs-squashfs-hook_0.2.bb            |  14 +++
 .../initramfs-verity-hook/files/hook          |   5 +
 ...ty.script.tmpl => local-top-complete.tmpl} |   0
 .../files/verity.conf-hook                    |   1 -
 .../initramfs-verity-hook/files/verity.hook   |  23 ----
 ...ok_0.1.bb => initramfs-verity-hook_0.2.bb} |  24 ++---
 28 files changed, 250 insertions(+), 535 deletions(-)
 delete mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/abrootfs.hook
 create mode 100644 recipes-initramfs/initramfs-abrootfs-hook/files/hook
 rename recipes-initramfs/initramfs-abrootfs-hook/files/{abrootfs.script => local-top-complete} (100%)
 rename recipes-initramfs/initramfs-abrootfs-hook/{initramfs-abrootfs-hook_0.1.bb => initramfs-abrootfs-hook_0.2.bb} (61%)
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.bullseye_or_later.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.buster.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.clevis.hook
 delete mode 100755 recipes-initramfs/initramfs-crypt-hook/files/encrypt_partition.systemd.hook
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/files/hook
 rename recipes-initramfs/initramfs-crypt-hook/files/{mount_crypt_partitions.script => local-bottom-complete} (100%)
 rename recipes-initramfs/initramfs-crypt-hook/files/{encrypt_partition.script => local-top-complete} (71%)
 delete mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.4.bb
 create mode 100644 recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-hook_0.5.bb
 delete mode 100644 recipes-initramfs/initramfs-erofs-hook/files/erofs.hook
 delete mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-erofs-hook/initramfs-erofs-hook_0.2.bb
 rename recipes-initramfs/initramfs-overlay-hook/files/{overlay.script.tmpl => local-bottom.tmpl} (91%)
 delete mode 100644 recipes-initramfs/initramfs-overlay-hook/files/overlay.hook
 rename recipes-initramfs/initramfs-overlay-hook/{initramfs-overlay-hook_0.1.bb => initramfs-overlay-hook_0.2.bb} (71%)
 delete mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.1.bb
 create mode 100644 recipes-initramfs/initramfs-squashfs-hook/initramfs-squashfs-hook_0.2.bb
 create mode 100644 recipes-initramfs/initramfs-verity-hook/files/hook
 rename recipes-initramfs/initramfs-verity-hook/files/{verity.script.tmpl => local-top-complete.tmpl} (100%)
 delete mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.conf-hook
 delete mode 100644 recipes-initramfs/initramfs-verity-hook/files/verity.hook
 rename recipes-initramfs/initramfs-verity-hook/{initramfs-verity-hook_0.1.bb => initramfs-verity-hook_0.2.bb} (65%)

-- 
2.43.0


