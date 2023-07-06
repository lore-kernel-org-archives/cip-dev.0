Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23E56C001B0
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 08:04:39 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.16606.1688630672289522790
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jul 2023 01:04:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm1 header.b=YiJgQ3cA;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202307060804293a1699ac0c1f230c12-6lfkbi@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202307060804293a1699ac0c1f230c12
        for <cip-dev@lists.cip-project.org>;
        Thu, 06 Jul 2023 10:04:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ZvCBCA9cfZKCy1lckfma6qXTKqlh5kDDZ697Z/vLLgE=;
 b=YiJgQ3cAHb4FxCr5B7TA+dSwx5gie8nyhenmVPrmy5mDWCSq0ZWMz4VomawZSpZCOiLiI7
 H7XJtwDZSWxiXPyvzB+u80qIokshERinP6gOIZ92Byp7hJl9IxJ1LSuxDU6PE4OKpf5AI0fs
 k9zTpchdHfrys0phKi5f65+DB8no0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Service watchdog in initramfs-crypto-hook, harden watchdog settings
Date: Thu,  6 Jul 2023 10:04:25 +0200
Message-Id: <cover.1688630668.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 08:04:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12255

See patches for details.

Aside that, we still have an issue with the iTCO in 5.10 and older due
to a missing commit, see [1]. If upstream rejects stable as target, I
will propose the patches for -cip.

Jan

[1] https://lore.kernel.org/linux-watchdog/251a6e29-4ba1-73ed-d714-f35a2d3ee4b3@siemens.com/T/#t

Jan Kiszka (3):
  initramfs-crypt-hook: Remove needless differences between clevis and
    systemd scripts
  initramfs-crypt-hook: Service watchdog while setting up the crypto
    partitions
  x86: Harden watchdog settings

 .../files/encrypt_partition.clevis.script     | 22 +++++++++--
 .../files/encrypt_partition.env.tmpl          |  2 +
 .../files/encrypt_partition.systemd.hook      |  2 +
 .../files/encrypt_partition.systemd.script    | 39 +++++++++++++------
 .../initramfs-crypt-hook_0.1.bb               |  7 +++-
 wic/qemu-amd64-efibootguard-secureboot.wks.in |  2 +-
 wic/x86-efibootguard.wks.in                   |  2 +-
 7 files changed, 59 insertions(+), 17 deletions(-)

-- 
2.35.3


