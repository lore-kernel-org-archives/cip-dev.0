Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52F2CC61DB9
	for <webhook@archiver.kernel.org>; Thu, 27 Aug 2026 06:23:06 +0000 (UTC)
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30487.1787811781576285793
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Aug 2026 23:23:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=jan.kiszka@siemens.com header.s=fm2 header.b=An7z//CM;
 spf=pass (domain: rts-flowmailer.siemens.com, ip: 185.136.64.226, mailfrom: fm-294854-20260827062258c760f1da2100020721-r2op8c@rts-flowmailer.siemens.com)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 20260827062258c760f1da2100020721
        for <cip-dev@lists.cip-project.org>;
        Thu, 27 Aug 2026 08:22:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=jan.kiszka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=AbIdFQpmAjQTLq2ie30OsRNbm5rwSt0KGapvjtcY5Wc=;
 b=An7z//CMa2JjHWahO/4AOBoyTlQK+Iiv1+y49/q8L8fS/V5m2gTj7xw/zAFB4kNS7LS7RV
 Sy6FKuNNwtthL0ZldZI1BA3jo3D+9SIhCjYY9gXNwwIOW3WkJ5KVlhGjcM8CPSIN1TG1743k
 M2hmtsxtECxcZLul0QuHvwkbz3DTG9ehCcFRf7F30TTTX+Xl15pVLpUzKtEpPd1jCuN1lqoK
 8q+P5PP/jmPyK0Kd2u/FXQQP7FaWV21GgkILmtnqxNUYhUKFhNDIlePN1zrqc0Q+u91gt9yE
 5QuomVipbFTUNQLRxwMMVODEpyU2pFlvtjHzWch02UCK+72Rw418dGYA==;
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Felix Moessbauer <felix.moessbauer@siemens.com>,
	Quirin Gylstorff <quirin.gylstorff@siemens.com>,
	Michael Adler <michael.adler@siemens.com>
Subject: [isar-cip-core][PATCH v3 0/5] Rootless builds, again
Date: Thu, 27 Aug 2026 08:22:52 +0200
Message-ID: <cover.1787811777.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-294854:519-21489:flowmailer
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Aug 2026 06:23:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24034

After fixing (hopefully) all remaining issues in Isar, kas, and our
gitlab-cloud-ci, we should now be ready to merge this.

Changes to v2:
 - update to kas 5.5
 - bump Isar once more, plus not-yet-merged patch
 - run rootless builds against rootless runner

Jan


CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>

Jan Kiszka (2):
  Update Isar revision
  ci: Select rootless runner

Quirin Gylstorff (3):
  update to kas 5.5
  switch to isar-rootless
  update README.md for rootless build

 .gitlab-ci.yml                                |  10 +-
 .reproducible-check-ci.yml                    |   5 +-
 Kconfig                                       |   2 +-
 README.md                                     |   7 +-
 ...map-nobody-nogroup-as-dedicated-bloc.patch |  68 ++++
 kas-cip.yml                                   |   8 +-
 kas-container                                 | 329 ++++++++++--------
 7 files changed, 269 insertions(+), 160 deletions(-)
 create mode 100644 isar-patches/0001-rootless-always-map-nobody-nogroup-as-dedicated-bloc.patch

-- 
2.47.3


