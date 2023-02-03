Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1BE5C636CC
	for <webhook@archiver.kernel.org>; Fri,  3 Feb 2023 08:25:28 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.6133.1675412721061105027
 for <cip-dev@lists.cip-project.org>;
 Fri, 03 Feb 2023 00:25:22 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=ThH6aAuH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-51332-20230203082518b471894fe5b1c04b74-kmixe5@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230203082518b471894fe5b1c04b74
        for <cip-dev@lists.cip-project.org>;
        Fri, 03 Feb 2023 09:25:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References:In-Reply-To;
 bh=rx1yuuGyeSrZuPiiqrkbUPsM50dnK6TMhvfvxzRVY4A=;
 b=ThH6aAuHMiUHKVEFph+veeutLb32gl2rHWIsN3HrPj3sgCtsGOBq7JrC9tdEJwug5HXp4L
 xqki4ooUnel9fbU9sLy4s+ZpLfKxapihESrWjOL9x/0Wwgs2MNWHeNyqiKMWKnvqiysIiu50
 coBwTwpZxKQYCPcGnSu02sTvRlhIE=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/2] conf/distro: Rename debian-sid.list to cip-debian-sid-snapshot.list
Date: Fri,  3 Feb 2023 09:25:16 +0100
Message-Id: <20230203082516.27690-3-Quirin.Gylstorff@siemens.com>
In-Reply-To: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
References: <20230203082516.27690-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 03 Feb 2023 08:25:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10579

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This is done to avoid infecting other layers with the snapshot version.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename conf/distro/{debian-sid.list => cip-debian-sid-snapshot.list} (100%)

diff --git a/conf/distro/debian-sid.list b/conf/distro/cip-debian-sid-snapshot.list
similarity index 100%
rename from conf/distro/debian-sid.list
rename to conf/distro/cip-debian-sid-snapshot.list
-- 
2.39.1


