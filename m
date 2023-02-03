Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C94C636CC
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 10:51:49 +0000 (UTC)
Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
 by mx.groups.io with SMTP id smtpd.web10.7810.1675421506258279148
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 02:51:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=mVvtEY+J;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.227, mailfrom: fm-51332-20230203105143c1362d4e66d66d5b0a-mtjmr3@rts-flowmailer.siemens.com)
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20230203105143c1362d4e66d66d5b0a
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Feb 2023 11:51:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=VAV2zVZ38U83jav1RKZgXLyFbUZ+qz1Pv1/RLgRRgpU=;
 b=mVvtEY+J/Oxt4/K/r4NVDnDaOOKbNzwgnIZDApYtMM7SfnBN2AHRN3oUo18q2me8dUvK/9
 MYq5B8ioTuL3dUImqSNXyjjyCDeKoPXMkUEiiZ6+4MMx5Pxw/DIaHLeJsYTy6nlJ2/41UtZs
 9MeeoD/Ij0EUTzD3J4I6Ed8xHdEjs=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v3 0/2] Use cip prefix and snapshot prefix for sid lists
Date: Fri,  3 Feb 2023 11:51:40 +0100
Message-Id: <20230203105142.367778-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 10:51:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10585

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This fixes the error "Override of sid distro config breaks mirrors" reported by Felix Moessbauer:
```
the distro "debian-sid" and "debian-sid-ports" is currently specified
both in ISAR and in isar-cip-core. While in ISAR standard debian
mirrors are used, cip-core pins that to a specific release on
snapshots.debian.org.

This breaks use-cases where local mirrors shall be used, as these do
not support snapshots. Also, this "infects" other layers that actually
want to use sid "as-is".
```

Changes v3:
 - delete debian-sid.list as it is not used.
 - add missing newline

Changes v2:
 - split renameing into two patches to avoid wrong patch
 - add missing newline

Quirin Gylstorff (2):
  conf/distro: Use cip prefix and snapshot postfix for sid lists
  conf/distro: Delete debian-sid.list

 conf/distro/cip-core-sid-ports.conf                             | 2 ++
 ...debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
 conf/distro/debian-sid.list                                     | 2 --
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)
 delete mode 100644 conf/distro/debian-sid.list

-- 
2.39.1


