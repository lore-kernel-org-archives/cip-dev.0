Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60203C30658
	for <webhook@archiver.kernel.org>; Sat, 29 Jun 2024 06:28:08 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.1304.1719642478747292305
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 23:27:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=vlyH9Lqt;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-294854-202406290627551f8c5d8cf5b8ec37b3-hujpfk@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 202406290627551f8c5d8cf5b8ec37b3
        for <cip-dev@lists.cip-project.org>;
        Sat, 29 Jun 2024 08:27:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=SVWChFuOgKLqLKjZ86rrkme2KpBu/xwC1F/ag4Xu0HM=;
 b=vlyH9Lqt3i4mRHyNY/NHbPRsrkkaAkiSrQM0FE3wcptn8N9WEUm6eIVOKGPtBvqj+Hegs7
 fFYPQIdzct7Y1VIegsF3AO0XTUXsCOCBX8Tf1hdpcO/zum16W/R1SrnYM0ApNtZveKtxf/wG
 FqlbjAknGwYMaP2s1hIiBWn/ZHL+0=;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Sai Ashrith Sathujoda <sai.sathujoda@toshiba-tsip.com>
Subject: [isar-cip-core][PATCH 0/4] ci: add LAVA live output, fix and clean up submission script
Date: Sat, 29 Jun 2024 08:27:50 +0200
Message-ID: <cover.1719642474.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 29 Jun 2024 06:28:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16348

See patches for details, look at the output here:

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines/1353479619

Jan

Jan Kiszka (4):
  ci: submit_lava: Fix reporting of submission errors
  ci: submit_lava: Fix access to LAVA API
  ci: Show live output of LAVA jobs
  ci: submit_lava: Reduce validate_jobs to handle only a single one

 scripts/submit_lava.sh | 196 ++++++-----------------------------------
 1 file changed, 27 insertions(+), 169 deletions(-)

-- 
2.43.0


