Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9674.1793361356719810317
 for <cip-dev@lists.cip-project.org>;
 Fri, 30 Oct 2026 04:55:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=VXtP3Qlv;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.226, mailfrom: fm-1330684-20261030115552bf35a5d2e7000207c4-aakaq1@rts-flowmailer.siemens.com)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20261030115552bf35a5d2e7000207c4
        for <cip-dev@lists.cip-project.org>;
        Fri, 30 Oct 2026 12:55:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=ASY3kVhEb3Bz2JYmjWPyhQ9UnYh8RNdgg86mOZH976o=;
 b=VXtP3QlvYT+Onrq/n3G3F30PXUSuZlKJR9FUQu6rzJ4l7+ESN/P9nyD748YV2N4MQ3WI9s
 fZciowQPeyvkG3FBBg0SDLTBu8GL+qm3j7G8/YBhuV1sEUs/hDWYlIvzHB9HEqLTGms4HVyF
 wHNWyRArPiOurR+3juSZyYjBEtOVZd35vAbvv38yGTzQNIqcq+QRMHXRehbaVzdOGrKOuacm
 xfycCMzWzmECTFEc2CiKrb1jad+IJYYouZuwpYm/r9U4ArmV24PADZFdPeGuj/Z0qwuiIqrX
 m65GcFMPmrVm/jTMM8b7Ndb+8fknPyuEtmYfMoANPwly1eM5rNpd5dig==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH v2 0/4] Add out of tree signing for swu files
Date: Fri, 30 Oct 2026 12:55:39 +0100
Message-ID: <20261030115543.111644-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 30 Oct 2026 11:56:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24587
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

Changes since V1:

  - Fixed indentation to tab
  - Fixed (single) trailing whitespace
  - Added out-of-tree signing to README.signing.md

Alexander Heinisch (4):
  sign-swu-cms: Refactor signing script to be reusable for out of build
    signing.
  swupdate: Add out of tree signing script for swu files.
  README.signing: Fixing typos.
  README.signing: Added section on out-of-tree signing for updates.

 doc/README.signing.md                         |  44 +++++-
 .../swupdate-signer/files/sign-swu-cms        |  86 ++++++++++--
 scripts/sign-swu.sh                           | 128 ++++++++++++++++++
 3 files changed, 246 insertions(+), 12 deletions(-)
 mode change 100644 => 100755 recipes-devtools/swupdate-signer/files/sign-swu-cms
 create mode 100755 scripts/sign-swu.sh

-- 
2.47.3

