Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF30C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:39:41 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.84])
 by mx.groups.io with SMTP id smtpd.web08.1053.1643305179235040782
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:39:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ul49AgKu;
 spf=pass (domain: siemens.com, ip: 40.107.22.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qp+s+FDZh+XqamWLtncxJDm0uwyzWfUWCJuSaKSCN2K08rvGBAFDpWu9KHmZlAy+fM+eXRMfUeV00nSWzPNGuIv8BoIuN7AzB7bqy9ADwLzNdJW4jHJd15dh+CK6AApaDIDb/w+pj117vBWMF5ubcr+Vp4bDAnFQiKxO2wwd+8kULZpQIUCHASI/64bkcjFyI2cEDI33v56OQiDbHuCYI86IZWhhViuO699Hl6ZdO2zwCmP/3BE17gbndgbl0SVtdMdnTISnUNhV2C0+f4vOXiJEGq/2N+KlwMvTtKWYglMAoehKUmu2l2b6HL9v41LOF8MbVa/G6i99ujGF3BTtoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u2XVvRaseOx+q10lBOL3IDJuFSJVzcXT3EFJTfBywQ4=;
 b=Z7h8ztlatjDLY2V0LuzpMW/yYbTGla4oKn01AF+obP8F0CsFyhsz9nqVxham9DQ4SJNUJW40MSdb1p6fN/QPgJ+8FiVlsLps7VsrtRyGbV/5WDpdfx3Y29Pq04YZFe3hiTM0SFlY8JDpduyOYHk8uyH27WNmZk8T4gR0yBISeYU22GYTFi6s3Xa4Q9Ek7zQi371owgIGUXyr4AxnDKNHfZoGH2SZsvHVA5XxNYNlg/W4JqrSN5YC9bje96BxIvkmviMEkJLBxNG1JPpdZt5p/e4h/kZti1T73lrwRcH+9cBlkpnxLcTs6RbhnoIm18tY6CY5q180Ady380ccsa6Ygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u2XVvRaseOx+q10lBOL3IDJuFSJVzcXT3EFJTfBywQ4=;
 b=ul49AgKukrwqWtYQ6VUc5qpJT64MLBjKDYnP7Jkn7Up6XJSuFitFoZaMyvLXSTiZx1kvWVLsFQ/nng0p8bIXTohhoEfmMw/YfcvoKANgsOPRUDivNBwry5AIbOrbTbWt+9FiQpT+Hd1VBK+InGi5v68v5KUXfsuNciw6lKTmX14Dcgq+whtX0cAQnph9maSNE8/GozYil3//eFsya8MIeyZqcFxgbO2dNU8+W+9TBH+6KVzZXDu16h5KVYZrA0V3tDo4XK0kamdd6gYclxo2HCeA87XA/KrkDLKklqwWax4oXYpXqKu7bgG63nB7CeNR9LwEDoewasQxSfmEndcg9w==
Received: from AS8PR04CA0060.eurprd04.prod.outlook.com (2603:10a6:20b:312::35)
 by VI1PR10MB3517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 17:39:36 +0000
Received: from VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:312:cafe::74) by AS8PR04CA0060.outlook.office365.com
 (2603:10a6:20b:312::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:39:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT052.mail.protection.outlook.com (10.152.3.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:39:35 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:39:35 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 18:39:34 +0100
Message-ID: <c78b1bbc-622a-6a35-b49e-3d2fa4e07102@siemens.com>
Date: Thu, 27 Jan 2022 18:39:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] Add contribution guide
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a8c7bd93-a769-46d8-04a9-08d9e1bbfc50
X-MS-TrafficTypeDiagnostic: VI1PR10MB3517:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB351766C38E357ADE5258439895219@VI1PR10MB3517.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PLEo8zGNUZEgGZGXezm0utXObxLwIsYh58h1STNYylhcCeDmjVOH4lfX3/J3A5HkrjC111ZwAnRBPaGXICLQbuiAQqPa/8/qNNpc6q8uoGwh4kfp6cmDCMFvP3P2wxI2LWHO1PVh393GBzUpHPACH5Mi1mNGfwjUl3DVuSg18Zfe+k0hGja1lJ4BVVJ8hcbI5t3wsRq4lsBkfsMUB+Jjg3yis30xJM+Xdfg8Q64DevcnbFwa3veKcSq65NUIVA88jamtQA2W6aNW4/+L2MUJ+LUD/yu3kSv8hz6Bq8m0mDWxNTY+vVcH+a1v7R0iUrsA9a2hFxdvS6wf8iBzi7gtX2gecUe4R5QfJW6ueD6LkZ+8VImf4ezVqNjxGN2EEm+aMYXAoIjJzsgm7Jx5ujsJoApW9tlxQNAd3fvmmTWQ9p0guLpcrhuFk7Qm9cEBfx8PSrxX2yA/+pepi7s9UBgjBUljfPDEUjfFNjZTx7yb55J+/TCLnI5HjV229M3jRwMtlngN22ylNogAegTVOVwQnsjMWHtO9isDzZ1qEz40QaHUHmulrEZ1diLXyGX2GygeXLZtmEQEj4WsgDKblOIe8rZcPKqWA6yho4uIzc40V3oATvvvH1lu77vHc0fOUiQLqEr75Su4Qz6ek2UgaYkXj0VyBuGU5i3iqFqFcd+XqKFkZ9IfCX1AlAZbEouiltJu5cNi0nHgaNwWbdX4dOv+WYD6eMTN1BAIynWX/2vDRNSfma7L5igBGe/0bZ4WRVLujZ8H8HT4MZPZuTKfjmDa9o5+zxezf6W2PqVa26z75lESxk+CGy2FhdSCTH850miDEk+/rM0S1EwX6KgWPcGwcEWRTog/rJLU65Sn9Mctkok=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(26005)(186003)(16526019)(508600001)(44832011)(86362001)(336012)(36860700001)(956004)(966005)(40460700003)(83380400001)(47076005)(31686004)(2906002)(31696002)(70206006)(70586007)(82310400004)(5660300002)(8936002)(36756003)(6706004)(6916009)(8676002)(16576012)(316002)(82960400001)(356005)(81166007)(3940600001)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:39:35.6934
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a8c7bd93-a769-46d8-04a9-08d9e1bbfc50
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3517
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:39:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7515

From: Jan Kiszka <jan.kiszka@siemens.com>

Derived from kas, which once derived from Jailhouse, adjusted to this
project.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
  CONTRIBUTING.md | 106 ++++++++++++++++++++++++++++++++++++++++++++++++
  README.md       |   2 +
  2 files changed, 108 insertions(+)
  create mode 100644 CONTRIBUTING.md

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
new file mode 100644
index 0000000..81d09e2
--- /dev/null
+++ b/CONTRIBUTING.md
@@ -0,0 +1,106 @@
+Contributing to isar-cip-core
+=============================
+
+Contributions to isar-cip-core are always welcome. This document explains
+the general requirements on contributions and the recommended preparation
+steps. It also sketches the typical integration process of patches.
+
+
+Contribution Checklist
+----------------------
+
+- use git to manage your changes [*recomended*]
+
+- add the required copyright header to each new file introduced, see
+  [licensing information](README.md#license) [**required**]
+
+- structure patches logically, in small steps [**required**]
+    - one separable functionality/fix/refactoring = one patch
+    - do not mix those there in a single patch
+    - after each patch, the tree still has to build and work, i.e. do not add
+      even temporary breakages inside a patch series (helps when tracking down
+      bugs)
+    - use `git rebase -i` to restructure a patch series
+
+- base patches on top of latest master or - if there are dependencies - on next
+  (note: next is an integration branch that may change non-linearly)
+
+- test patches sufficiently (obvious, but...) [**required**]
+    - no regressions are caused in affected code
+    - the world is still spinning
+
+- add signed-off to all patches [**required**]
+    - to certify the "Developer's Certificate of Origin", see below
+    - check with your employer when not working on your own!
+
+- post patches to mailing list (cip-dev@lists.cip-project.org) [**required**]
+    - use `git format-patch/send-email` if possible
+    - prefix patches with `[isar-cip-core]`, e.g. via
+      `git format-patch --prefix="isar-cip-core][PATCH" ...`
+    - send patches inline, do not append them
+    - no HTML emails!
+    - CC people who you think should look at the patches, e.g.
+      - someone who wrote a change that is fixed or reverted by you now
+      - who commented on related changes in the recent past
+      - who otherwise has expertise and is interested in the topic
+
+- post follow-up version(s) if feedback requires this
+
+- send reminder if nothing happened after about a week
+
+
+Developer's Certificate of Origin 1.1
+-------------------------------------
+
+When signing-off a patch for this project like this
+
+    Signed-off-by: Random J Developer <random@developer.example.org>
+
+using your real name (no pseudonyms or anonymous contributions), you declare the
+following:
+
+    By making a contribution to this project, I certify that:
+
+        (a) The contribution was created in whole or in part by me and I
+            have the right to submit it under the open source license
+            indicated in the file; or
+
+        (b) The contribution is based upon previous work that, to the best
+            of my knowledge, is covered under an appropriate open source
+            license and I have the right under that license to submit that
+            work with modifications, whether created in whole or in part
+            by me, under the same open source license (unless I am
+            permitted to submit under a different license), as indicated
+            in the file; or
+
+        (c) The contribution was provided directly to me by some other
+            person who certified (a), (b) or (c) and I have not modified
+            it.
+
+        (d) I understand and agree that this project and the contribution
+            are public and that a record of the contribution (including all
+            personal information I submit with it, including my sign-off) is
+            maintained indefinitely and may be redistributed consistent with
+            this project or the open source license(s) involved.
+
+
+Contribution Integration Process
+--------------------------------
+
+1. patch reviews performed on mailing list
+    * at least by maintainers, but everyone is invited
+    * feedback has to consider design, functionality and style
+    * simpler and clearer code preferred, even if original code works fine
+
+2. accepted patches merged into next branch
+
+3. further testing done by community, including CI build tests and code
+   analyzer runs
+
+4. if no new problems or discussions showed up, acceptance into master
+    * grace period for master: about 3 days
+    * urgent fixes may be applied sooner
+
+gitlab facilities are not used for the review process so that people can follow
+all changes and related discussions at a single stop, the mailing list. This
+may change in the future if gitlab should improve their email integration.
diff --git a/README.md b/README.md
index c379c96..f7cb86e 100644
--- a/README.md
+++ b/README.md
@@ -74,6 +74,8 @@ Continuous integration:
  
    - https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipelines
  
+Please see [CONTRIBUTING.md](CONTRIBUTING.md) for the contribution process.
+
   
  ## License
  
-- 
2.31.1

