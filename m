Return-Path: <ncaidin@linuxfoundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CC8C7EE2D
	for <webhook@archiver.kernel.org>; Tue, 23 May 2023 18:51:02 +0000 (UTC)
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
 by mx.groups.io with SMTP id smtpd.web10.14466.1684819143904694418
 for <cip-dev@lists.cip-project.org>;
 Mon, 22 May 2023 22:19:05 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=felix.moessbauer@siemens.com header.s=fm1 header.b=fKFiHvdp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.228, mailfrom: fm-72506-202305230519005a548db1b345d31e4a-3lppme@rts-flowmailer.siemens.com)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202305230519005a548db1b345d31e4a
        for <cip-dev@lists.cip-project.org>;
        Tue, 23 May 2023 07:19:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=felix.moessbauer@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=WFAkQ8KbRKtz6YajX4a35TD69cNKNqiDc+5zsBLqnz0=;
 b=fKFiHvdpB2kJiu9O/VI8JP2EiqCkdgI3UESQ2BlvbABbt+GYHOxcXZ3B59n+7shbz3rtzQ
 FSrWg2QkaRet3TNbWGBXZbFz6h+gMId+5Y2wdNuKqmzeXJ3Ym9NXqrdQxj3NE8CHdLMo0X8E
 hKWXIzAPmJMh+RoGbSrdgEgONntKA=;
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	meng.ding@siemens.com,
	chengshu.mou@siemens.com,
	quirin.gylstorff@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 0/3] Various fixes in SB workflow and docs
Date: Tue, 23 May 2023 13:18:43 +0800
Message-Id: <20230523051846.1007400-1-felix.moessbauer@siemens.com>
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-72506:519-21489:flowmailer
Content-Transfer-Encoding: 8bit
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 May 2023 18:51:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11621

This series makes the provided example in README.secureboot.md working again.
However, there are still some aspects which need to be fixed in the future:

- Combination with SSTATE_CACHE: This might break the verity rootfs signature
- rebuild with different keys: The generated linux.efi is not updated
  and also the old linux.efi is put into the image. By that, the created image
  cannot be bootet.

Best regards,
Felix Moessbauer
Siemens Ltd. China

Felix Moessbauer (3):
  fix(start-efishell): argument passing to qemu
  docs(secureboot): fix logical issues in example
  docs(secureboot): make markdown better readable

 doc/README.secureboot.md  | 74 ++++++++++++++++++++++++++-------------
 scripts/start-efishell.sh |  9 +++--
 2 files changed, 56 insertions(+), 27 deletions(-)

-- 
2.39.2


