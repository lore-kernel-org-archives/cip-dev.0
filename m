Received: from mta-65-228.siemens.flowmailer.net (mta-65-228.siemens.flowmailer.net [185.136.65.228])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.6288.1792499388181726267
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Oct 2026 05:29:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=alexander.heinisch@siemens.com header.s=fm2 header.b=U3okzqkp;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.65.228, mailfrom: fm-1330684-20261020122944b99b8a06e6000207a2-ugtniv@rts-flowmailer.siemens.com)
Received: by mta-65-228.siemens.flowmailer.net with ESMTPSA id 20261020122944b99b8a06e6000207a2
        for <cip-dev@lists.cip-project.org>;
        Tue, 20 Oct 2026 14:29:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.heinisch@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=qCJlfDa00bBJCBM26mdGnz6Tf1PnmZVsVkp2oRO/aVQ=;
 b=U3okzqkpQtOZM9n/WBUzMWf7UJDifxsb6GRxQn79ikK0zcN3L1a7c265WbaPs2Yhw4gw7K
 KOj8oBkqjr7j7qE51TC6Ooq4aB1S1GOpr+FpaRtR1GA+wn6V5LLHZtwV6BYZMjInDFZRqFTF
 k89pPb/8IILaSwgxyiUHrHT612gBVcsZg7nCDp1k/N4VMhi+Gh+W4Ig8gKZhmx0Iwd801Dbw
 0lOqV4j+gE0yw9g7er1qUCu99kTAeE55Te2R7zE103CByjcmoayT4pHr3fjMZ/4+OjgJWtTo
 uBy1N43h84qWUquxV1kPoDMPzlS3ab+cdvJB1o7PHDuhgCIaWkYTo2QA==;
From: alexander.heinisch@siemens.com
To: cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com,
	Alexander Heinisch <alexander.heinisch@siemens.com>
Subject: [isar-cip-core][PATCH 0/2] Split swupdate signing and verification configuration
Date: Tue, 20 Oct 2026 14:29:30 +0200
Message-ID: <20261020122932.470811-1-alexander.heinisch@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1330684:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 20 Oct 2026 12:29:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24498
Content-Type: text/plain; charset="utf-8"

From: Alexander Heinisch <alexander.heinisch@siemens.com>

This allows downstreams to sign artifacts out of tree (excluding
signing done by swu-IMAGER) while still enforcing signature
verification at runtime.

The patchset splits SWU_SIGNED into separate configuration switches
for signing and verification that allows for independent control of each,
while keeping the default behavior consistent with the previous SWU_SIGNED
setting.

Alexander Heinisch (2):
  swupdate: Separate config switches for swu signing and verifiction
  docs: Removed obsolete IMAGE_INSTALL from README.swupdate.md

 classes-recipe/swupdate.bbclass    |  3 ++-
 doc/README.swupdate.md             |  1 -
 recipes-core/images/swupdate.inc   | 12 +++++++-----
 recipes-core/swupdate/swupdate.inc |  3 ++-
 4 files changed, 11 insertions(+), 8 deletions(-)

-- 
2.47.3

