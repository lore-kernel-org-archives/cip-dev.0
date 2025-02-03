Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D99C02196
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 11:56:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.86147.1738583799660804874
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 03:56:40 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.134, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 513Bubnq835578; Mon, 3 Feb 2025 20:56:37 +0900
X-Iguazu-Qid: 2yAbuzQy0YtzT6qWyO
X-Iguazu-QSIG: v=2; s=0; t=1738583797; q=2yAbuzQy0YtzT6qWyO; m=pUptw+YNbLbZ9FVXlqTjAFFeJhr3/P+y+174KQzMqpk=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 513Bua8c880620
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Feb 2025 20:56:36 +0900
From: Sai.Sathujoda@toshiba-tsip.com
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com
Cc: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>,
        dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
Subject: [isar-cip-core v1 0/3] Make LTP installation path configurable
Date: Mon,  3 Feb 2025 17:23:18 +0530
X-TSB-HOP2: ON
Message-Id: <20250203115321.3589084-1-Sai.Sathujoda@toshiba-tsip.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Feb 2025 11:56:34.0650 (UTC) FILETIME=[AC2AF3A0:01DB7632]
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 11:56:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17726

From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>

This series of patches makes the LTP installation path configurable so
that pure test targets can have /opt/ltp path as default. The path shall
be changed only in case of security image due to it's read-only rootfs.

sai ashrith sathujoda (3):
  security.yml: Set new LTP installation path in case of security
    target.
  rules.tmpl: Make ltp rules file as template to make installation path
    configurable
  ltp.inc: Set default ltp install path and include template files and
    variables

 kas/opt/security.yml                                | 2 ++
 recipes-core/ltp/files/debian/{rules => rules.tmpl} | 2 +-
 recipes-core/ltp/ltp.inc                            | 4 ++++
 3 files changed, 7 insertions(+), 1 deletion(-)
 rename recipes-core/ltp/files/debian/{rules => rules.tmpl} (80%)

-- 
2.30.2



