Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CF7C63797
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 08:25:28 +0000 (UTC)
Received: from mta-64-225.siemens.flowmailer.net (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by mx.groups.io with SMTP id smtpd.web10.6134.1675412721369144482
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 00:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=GqE19hYF;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.225, mailfrom: fm-51332-2023020308251750e56be804a4903fb9-cy2axy@rts-flowmailer.siemens.com)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id 2023020308251750e56be804a4903fb9
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Feb 2023 09:25:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=povNjcpWxgytLEZVuXQ8AAymWZcP9jKF0c+Fy6MC+3c=;
 b=GqE19hYFWKJuabIN5q0AGP+ByBgUePGJWAzVaMWJ2UZ9/tCMW0CEW5JnhuntbR8syMRbRs
 rbhReUZbuN6ccWzzED82a+0jtzSOwOwdh8LXEgsMgZ4Ue8JgwWksJMutRcz8Uhr3n+EzkKj7
 ACJX5KjhStSLbDLdeNVyl2vRzSE8U=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/2] Use cip prefix and snapshot prefix for sid lists
Date: Fri,  3 Feb 2023 09:25:14 +0100
Message-Id: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 08:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10580

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

Changes v2:
 - split renameing into two patches to avoid wrong patch
 - add missing newline

Quirin Gylstorff (2):
  conf/distro: Use cip prefix and snapshot postfix for sid lists
  conf/distro: Rename debian-sid.list to cip-debian-sid-snapshot.list

 conf/distro/cip-core-sid-ports.conf                             | 2 ++
 ...debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} | 0
 conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list}   | 0
 3 files changed, 2 insertions(+)
 rename conf/distro/{debian-sid-ports.list => cip-debian-sid-ports-snapshot.list} (100%)
 rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)

-- 
2.39.1


