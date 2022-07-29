Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB80C3F6B0
	for <webhook@archiver.kernel.org>; Fri, 29 Jul 2022 08:39:42 +0000 (UTC)
Received: from mta-65-226.siemens.flowmailer.net
 (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.web10.5746.1659083975510836927
 for <cip-dev@lists.cip-project.org>;
 Fri, 29 Jul 2022 01:39:36 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=Quirin.Gylstorff@siemens.com header.s=fm2
 header.b=MVPvMF4q;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226,
 mailfrom: fm-51332-202207290839322bc5e7a6f08886d2ab-sknfcb@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id
 202207290839322bc5e7a6f08886d2ab
        for <cip-dev@lists.cip-project.org>;
        Fri, 29 Jul 2022 10:39:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=Quirin.Gylstorff@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
 bh=i7kJSrwGf7LPUwN4HmiwScWiBSwkMaATpp/wEurQoJc=;
 b=MVPvMF4qvkktRWDoa/M2nALeFHlK0QQOJvt0FbIro9tRyeXpRYeur0O3JUuFwnCKODBZc8
 ZLbPndz9UgS2NSa68qoMfMKPIMTS2kr1d6/Gi8mJUIyUp0yWh3VbfJXLbDgHI01dHkn9r9Ah
 p7g3JVLnp5nrqo2QkYRxqwhSe0mw0=;
From: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org
Subject: [cip-dev][isar-cip-core][PATCH 0/4] Add support for ISAR with sbuild
Date: Fri, 29 Jul 2022 10:39:27 +0200
Message-Id: <20220729083931.419731-1-Quirin.Gylstorff@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-51332:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 29 Jul 2022 08:39:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8971

From: Quirin Gylstorff <quirin.gylstorff@siemens.com>

This patch series integrates ISAR with the Sbuild feature.

Quirin Gylstorff (4):
  Update ISAR for sbuild integration
  scripts/deploy-cip-core.sh: Use dtb from deploy dir
  recipes-devtools/ovmf-binaries: Adapt to sbuild environment
  kas-cip: Add patch for linux-cip with CONFIG_MODULES=n

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


