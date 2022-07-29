Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34D47C19F29
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 10:04:43 +0000 (UTC)
Received: from mta-64-227.siemens.flowmailer.net
 (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.web10.6269.1659089075225422061
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 03:04:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=btaUH7GC;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227,
 mailfrom: fm-51332-2022072910043222e8273607f7028c22-baef_u@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id
 2022072910043222e8273607f7028c22
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 12:04:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=G5QG4l/ekarYI28sJ1J8NMyPNdz3B3juXyuq3PWxRhg=;
 b=btaUH7GCWty0tGrt8RSwyOzYh2sdHyfQlHY7Et77Q8tjJ8MDY/lRllEa16elyu6iiGZEi4
 2KmhgehvmQCtrydNRfqPBhvsYgpGveCjEM2/YHtKbsHeuipdqeKhnujYFqgK3t/kjVLr04bX
 /cyu5UfR5DKyAhPsVCO54kPalzkK0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH v2 0/4]  Add support for ISAR with
 sbuild
Date: Fri, 29 Jul 2022 12:04:27 +0200
Message-Id: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 10:04:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8981

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series integrates ISAR with the Sbuild feature.

Changes in V2:
 - reoder patches

Quirin Gylstorff (4):
  scripts/deploy-cip-core.sh: Use dtb from deploy dir
  recipes-devtools/ovmf-binaries: Adapt to sbuild environment
  kas-cip: Add patch for linux-cip with CONFIG_MODULES=n
  Update ISAR for sbuild integration

 .gitlab-ci.yml                                |  6 ++--
 conf/machine/bbb.conf                         |  1 +
 ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 +++++++++++++++++++
 kas-cip.yml                                   |  6 +++-
 .../ovmf-binaries/files/control.tmpl          | 11 -------
 recipes-devtools/ovmf-binaries/files/rules    | 17 ++++++++++
 .../ovmf-binaries/ovmf-binaries_0.1.bb        | 18 ++++++----
 scripts/deploy-cip-core.sh                    |  2 +-
 8 files changed, 71 insertions(+), 23 deletions(-)
 create mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
 delete mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
 create mode 100644 recipes-devtools/ovmf-binaries/files/rules

-- 
2.35.1


