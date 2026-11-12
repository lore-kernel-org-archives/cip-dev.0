Received: from mta-64-227.siemens.flowmailer.net (mta-64-227.siemens.flowmailer.net [185.136.64.227])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13329.1794490704734396099
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Nov 2026 05:38:26 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm1 header.b=kDn1e4oH;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.227, mailfrom: fm-1330684-2026111213382007560c71e900020711-oojopb@rts-flowmailer.siemens.com)
Received: by mta-64-227.siemens.flowmailer.net with ESMTPSA id 2026111213382007560c71e900020711
        for <cip-dev@lists.cip-project.org>;
        Thu, 12 Nov 2026 14:38:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=kZyi5cQ+6SFFpws6/MBF30CyHwwlD27vq5EdOQ2VMDc=;
 b=kDn1e4oH2oM4DY24Pd5R1Ab3+QY+13CUsA8e60g5EGfzSrfOlsJwT1H+wmeBszR9fIfd0c
 qv+3WJwp+h2S70guCnSI9GeqxGYDMlgZ8ZhBMKGMI9UfOQIw9JcyUllEh8TIQaBb8W9M0UbE
 liIpNHGonrRFofsVK/u1fqVgDvN22DGBFdCfAokMMUebH2enBKL4qn73D+n1EFaiWRNDm3eE
 c2VeCdsQ+VqY1n9KfwQYL3P3VKOwFKeDn0p7dpZae1yDdEx22h+PYQbxLoEiansgFAnjnXx2
 sokNG/uyC8G7D1cfBK9e1+2zm311WRHu68ClssV5LcEO52BGW3MWLsAQ==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/3] Add out of tree signing for swu files
Date: Thu, 12 Nov 2026 14:38:16 +0100
Message-ID: <20261112133819.251598-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 13:38:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24783
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

Changes in V3:
  - Made scripts posix compliant and changed shebang to /bin/sh

Changes in V2:

  - Fixed indentation to tab
  - Fixed (single) trailing whitespace
  - Added out-of-tree signing to README.signing.md

Alexander Heinisch (3):
  sign-swu-cms: Refactor signing script to be reusable for out of build
    signing.
  swupdate: Add out of tree signing script for swu files.
  README.signing: Added section on out-of-tree signing for updates.

 doc/README.signing.md                         |  42 ++++++
 .../swupdate-signer/files/sign-swu-cms        |  84 +++++++++--
 scripts/sign-swu.sh                           | 132 ++++++++++++++++++
 3 files changed, 248 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
 create mode 100755 scripts/sign-swu.sh

-- 
2.47.3

