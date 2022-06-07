Return-Path: <Vijaikumar_Kanagarajan@mentor.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB66C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 13:50:51 +0000 (UTC)
Received: from esa3.mentor.iphmx.com (esa3.mentor.iphmx.com [68.232.137.180])
 by mx.groups.io with SMTP id smtpd.web12.12755.1654609849668491510
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 06:50:49 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: mentor.com, ip: 68.232.137.180, mailfrom: vijaikumar_kanagarajan@mentor.com)
X-IronPort-AV: E=Sophos;i="5.91,284,1647331200";
   d="scan'208";a="76783566"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa3.mentor.iphmx.com with ESMTP; 07 Jun 2022 05:50:47 -0800
IronPort-SDR: 
 bX9PWTNC7qGhHFSQpPBjd+t/RJnnurHxnkaoV+dfh86VuCjPAtkCnc9kvL5fBQSKndism4xV6s
 iWMxwJDraVBhPg7GaaP9WMGIleJLjYO8NxxKhneiVMC0apFdIEUXqbENWQ+IDibasXryxtLJO5
 7QZVPF32v/RBY6yvXEajVicCwCQs5rrLCqLKzXfX0RTXdiH59RupuTYrIboWVUFnuJU4vD+JKG
 CMumr80GfRxub7ztgNUQYnCBc35HQBuvEPUqggJL8Dcd3OzkDMS4c+F4N4f/Ln9+C2Ii8CBVFT
 xdE=
From: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
To: <jan.kiszka@siemens.com>, <quirin.gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
CC: Vijai Kumar K <Vijaikumar_Kanagarajan@mentor.com>
Subject: [isar-cip-core][PATCH 0/3] Update ltp
Date: Tue, 7 Jun 2022 19:20:13 +0530
Message-ID: <20220607135016.1856603-1-Vijaikumar_Kanagarajan@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: svr-orw-mbx-15.mgc.mentorg.com (147.34.90.215) To
 svr-orw-mbx-12.mgc.mentorg.com (147.34.90.212)
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 13:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8508

The series does the following

P1 - Updates ltp to the latest one and adds pkg-config as dependency
P2 - Introduce ltp.inc file to support downstream customizations
P3 - Disable make tests. This is not supported in cross compilation.


Thanks,
Vijai Kumar K

Vijai Kumar K (3):
  recipes-core/ltp: Update to the latest ltp version
  recipes-core/ltp: refactor ltp recipe
  recipes-core/ltp: Disable autotest

 recipes-core/ltp/files/debian/control              |  2 +-
 recipes-core/ltp/files/debian/rules                |  2 ++
 recipes-core/ltp/ltp-full_20220527.bb              | 14 ++++++++++++++
 recipes-core/ltp/{ltp-full_20190930.bb => ltp.inc} |  6 ++----
 4 files changed, 19 insertions(+), 5 deletions(-)
 create mode 100644 recipes-core/ltp/ltp-full_20220527.bb
 rename recipes-core/ltp/{ltp-full_20190930.bb => ltp.inc} (61%)

-- 
2.25.1


