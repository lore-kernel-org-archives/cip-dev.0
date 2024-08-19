Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 631E7C3DA4A
	for <webhook@archiver.kernel.org>; Mon, 19 Aug 2024 12:51:47 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.209513.1724071903153208439
 for <cip-dev@lists.cip-project.org>;
 Mon, 19 Aug 2024 05:51:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm1 header.b=d2Ay8Goi;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-51332-2024081912513967f9afa80b8e837025-xefgat@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2024081912513967f9afa80b8e837025
        for <cip-dev@lists.cip-project.org>;
        Mon, 19 Aug 2024 14:51:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=Ya/jrS7lvTby42RfXnlhaHNfrRBilifGUGL6JT+7HGY=;
 b=d2Ay8GoilRyfloCFaEZ12JG6U6xbK+qQoIRvLVHPNRfyje3h+sA7+EYMdWBT3ye4E3vypx
 5st3QMPQqd85l7ORDOeSsvN/+tmwffqOZk8Ly84E/oqP63uMTroedKB7E0DeE5eoVE3N8zZq
 neZnMP6Ua5qVaL6IoaPC/d0Aje41L6jATgb2Vm0ZWWlQicAjz4C0LVFqqmZn9Ztzercg25eN
 bfBWznLJbR9+nr6beJ6lccVL5CHU95FuJ1te2v2a5EBn2NuIfnuE2qabkExR7NZsaYRmrnDx
 h2q2wzTE/AauX6IrtNycJoAMFS+FGfMsuKJw6Uevvc5lfEzRTiPoUCgg==;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	dinesh.kumar@toshiba-tsip.com,
	kazuhiro3.hayashi@toshiba.co.jp,
	Sai.Sathujoda@toshiba-tsip.com,
	florian.bezdeka@siemens.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 0/2] fixes overlay with
Date: Mon, 19 Aug 2024 14:51:24 +0200
Message-ID: <20240819125138.1543399-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 19 Aug 2024 12:51:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16804

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This series checks for a e2fsck return value greater than 1 to avoid
recovery in case of a repaired file system[1].
Also it remove the interactive mode in case the recovery script is
triggered.

This fixes issue
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/113.

[1]: https://man7.org/linux/man-pages/man8/e2fsck.8.html#EXIT_CODE

Quirin Gylstorff (2):
  fix: Check return code value of e2fsck
  fix: force mke2fs in overlay recovery action

 .../initramfs-overlay-hook/files/overlay.script.tmpl        | 6 +++++-
 .../files/overlay_recovery_action.script                    | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.43.0


