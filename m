Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9948C27C79
	for <webhook@archiver.kernel.org>; Thu, 13 Jun 2024 09:16:41 +0000 (UTC)
Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.web10.3876.1718270199932161533
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Jun 2024 02:16:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2 header.b=tD/ACxPK;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-51332-2024061309163613611de61d400a9805-pteqfl@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 2024061309163613611de61d400a9805
        for <cip-dev@lists.cip-project.org>;
        Thu, 13 Jun 2024 11:16:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=ScaOYzGXjShnZqN9K7Y89FISsUqnE03ffTpvq6K73C4=;
 b=tD/ACxPK9TMCG8gxluRwPnUu+KGrya3/oFC+MQ6DutNwAwEHCGdHQ9238Fl2NvgKkB32en
 YDHC103x5jzMLejm1qVD8VJwSvoF3tdbVblxTLC8qyg0TV874u8QYIqQwmUNUz6LpeTLnbIN
 eqPlMvLyFizUOPg6vdn09tKCYsyQ4=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v4 0/2] wic ebg plugins support
Date: Thu, 13 Jun 2024 11:16:17 +0200
Message-ID: <20240613091636.1156475-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Jun 2024 09:16:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16197

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This refactors the wic plugins for efibootguard to take the wks
parameter `--size` and `--fixed-size` correct into account.

It will also fix the following sporadic build error by increasing the
boot partition sizes.
```
 INFO: sign with script /usr/bin/sign_secure_image.sh
 ERROR: _exec_cmd: export PATH=//sbin://usr/sbin://usr/bin://usr/bin/None://bin:None:$PATH;mcopy -i /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/BOOT0.2.img -s /tmp/cip-core-image-security-cip-core-bookworm-qemu-arm64.wic/tmp.wic.yo_hrfgu/disk/BOOT0.2/* ::/ returned '1' instead of 0
 output: Disk full
```

Changes v4:
 - use the fixed-size partition parameter instead of size for the
   ebg-sysparts.inc files and increase the size of the partitions
Changes v3:
 - remove unnecesary setting of FAT-Size(-F) and sector size(-S 512)
   the sector size default is 512 and as FAT size should be caluclate
   according to the partition size.
Changes v2:
 - replace size calculation with part.prepare_rootfs_msdos

Quirin Gylstorff (2):
  wic/plugins/efibootguard*: Take --size and --fixed-size into account
  wic/ebg*sysparts.inc increase the size of the boot partitions

 .../wic/plugins/source/efibootguard-boot.py   | 34 ++++---------------
 .../wic/plugins/source/efibootguard-efi.py    | 30 ++--------------
 wic/ebg-signed-sysparts.inc                   |  6 ++--
 wic/ebg-sysparts.inc                          |  6 ++--
 4 files changed, 15 insertions(+), 61 deletions(-)

-- 
2.43.0


