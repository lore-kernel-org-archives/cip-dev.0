Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3849.1793213069853595227
 for <cip-dev@lists.cip-project.org>;
 Wed, 28 Oct 2026 11:44:30 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=DZSO31Ra;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.225, mailfrom: fm-1330684-202610281844263794c7c429000207c7-zhmq3l@rts-flowmailer.siemens.com)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202610281844263794c7c429000207c7
        for <cip-dev@lists.cip-project.org>;
        Wed, 28 Oct 2026 19:44:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=85wNk50qezem2xoK4bCSnKUpsyi5LjRxt3yny9JqZzk=;
 b=DZSO31RawKQTpiFfM8iwT18HdOs8mIUEXWtq64CiX2RAtXa0wrE3o0wpLv1j2VlsOqMYWo
 X33GwJUeOI7BSv+72Zdj7P97x+ZAJSrWG+KIjylRqIifSXeGCswtFmov6aHpkf8DITcYm+mN
 fnFpVpLb0NBAQX5SOId2NniclkTtMZKI+3h+mO46tEtik2JopGh0ak3Ryt1sNsoK9DWur6Lx
 wdBamW21gQqtTEg+FIWvNkY/YzUkOp5JlfWRr6Noddhsp5vU70oQ0UoWn4wMTejVEokwBk6m
 f09aQZfvtMM9muDailcgxlZmZCs00sQ1kaB8/dt11klV774HATGPKDIA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] Add out of tree signing for swu files
Date: Wed, 28 Oct 2026 19:44:01 +0100
Message-ID: <20261028184403.301959-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 28 Oct 2026 18:44:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24557
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

  Following up a request from [1] I added scripts to sign existing SWU files out of tree.
  A rework of the existing sign-swu-cms was needed to allow reuse in out of tree signing.

  The script interface is:
      sign-swu.sh [OPTIONS] SWU_FILE [-- SIGNER_SCRIPT [SIGNER_ARGS...]]

  where the SIGNER_SCRIPT interface follows:
      SIGNER_SCRIPT [SIGNER_ARGS...] SIGNEE SIGNED

  SIGNEE and SIGNED are provided by sign-swu.sh

  1: https://lists.cip-project.org/g/cip-dev/message/24534

Alexander Heinisch (2):
  sign-swu-cms: Refactor signing script to be reusable for out of build
    signing.
  swupdate: Add out of tree signing script for swu files.

 .../swupdate-signer/files/sign-swu-cms        |  99 +++++++++++---
 scripts/sign-swu.sh                           | 128 ++++++++++++++++++
 2 files changed, 210 insertions(+), 17 deletions(-)
 mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
 create mode 100755 scripts/sign-swu.sh

-- 
2.47.3

