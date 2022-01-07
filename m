Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8057C433EF
	for <webhook@archiver.kernel.org>; Fri,  7 Jan 2022 11:32:51 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.77])
 by mx.groups.io with SMTP id smtpd.web08.5356.1641555169875895724
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Jan 2022 03:32:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vtB3305q;
 spf=pass (domain: siemens.com, ip: 40.107.6.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oB960DUvBaslt5EbUO3b3EX2I77vcM1qE7fqZsHa6vCkbt39PdcqmgUGxpj8tnPa6SJW0VOQQTe4xZQqd0V6Q9/nMAXRvy9PNdObJHV9molNsAfNOgcHvxlMGga3qZ87n1AQH3iFQdjKyP1ahmd3SJOOBQh/XFCqhCwBvARbdXqt1oGFnL5Y1QUiaz1pSRvzCTi+DGyOPPRd532GVndxdMUbwLMvu21rlq5uMoius88/w/X6977WSTTqbdkogSY3JkMcXeCHK4Nvcy2mk5x5ciiciKsokU1TfNmYa/rB4oaV+WsNt+k2clCG/LZFHP+7mifqIHpMMLBa4ajVch+xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PitL5pyDpVV8FpGgz6a6ltTLYXhpWTgfOFJT1ee1uZw=;
 b=cj9SHsByXXuiZCyGLPyk622XQrTzg0y4fPvuCkzbWg1369jwC1J6T6h92vGXhHAYX1lkuVItOmOq1K2J7VUMVAkEiUir6kD1dVRnloaumWJJmkTg25A/b8nDD05zHnXr2gFt3EV7fQdqc4FiRZU1pYgB0XcOA1rhLgvO54pPkyZbhWTbzm4UEwA8bcfnky/NUaqtyrboAJPtRRvBUJxsN7q1eHDXs4/cDRohAqaCXabiX/XnlJHmIx01UCYG/k4s5KHttHJHdY86vmvi1gbRHOz/aIjaog7aS0BnaqGYW5PgTHjmjWSyOK6lVI4N2oqoXQRZUSWBljBCCuHDmde0yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PitL5pyDpVV8FpGgz6a6ltTLYXhpWTgfOFJT1ee1uZw=;
 b=vtB3305qxhmTC95oftgniBCcRCzP7yUz+x8Bk0P4B9xjH85POF3kzsnCEO21SphS6PvWbXwl479X9xGUKvfQi7NBiyX7bwJP7Is27m2Pft0YSwktKs2mZNxdA4KhOb6Y0qrjUXrE9ZiyHebX3v7XcrDb9ANpAByO2+uIyYfNIdc4yK6nMZPF7FvaHJKlQAxr+CPH+QAQ8ul7VbJVRKolaOZXPL2v/CwZBCO/WHu6pQj0hbBKkQm1eYCB7Z4XwfVftCyW7I6Ua79rByUR+bVkJKM4lrAyr2aguD6m/Bx9CKe5AM8DYpmyHsE7EksPly8+CzZ+Yj8nxDiUhaFi5bs5NA==
Received: from AM6PR02CA0009.eurprd02.prod.outlook.com (2603:10a6:20b:6e::22)
 by AM7PR10MB3239.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:10b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Fri, 7 Jan
 2022 11:32:46 +0000
Received: from VE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:6e:cafe::9) by AM6PR02CA0009.outlook.office365.com
 (2603:10a6:20b:6e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Fri, 7 Jan 2022 11:32:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT064.mail.protection.outlook.com (10.152.3.34) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Fri, 7 Jan 2022 11:32:46 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 7 Jan 2022 12:32:45 +0100
Received: from [167.87.0.113] (167.87.0.113) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 7 Jan
 2022 12:32:45 +0100
Message-ID: <b5989cfc-6d12-348e-1bf1-7033937832c1@siemens.com>
Date: Fri, 7 Jan 2022 12:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] ci: Drop trailing semicolons from script
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: "alice.ferrazzi@miraclelinux.com" <alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.113]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cec38de2-ac39-4269-e58c-08d9d1d16d3a
X-MS-TrafficTypeDiagnostic: AM7PR10MB3239:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB32390BB540760303479E3DEC954D9@AM7PR10MB3239.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	gYIPetBkuN/XVtUYrBLlX/C2UT/E57XyrIT7YoR8lUfEXQgWZbKi6SNFk/0jr/GYQeXveHuc28O8hAKZYdED2pTpfDDfqN2RHG2P7WCincW6/WnLNHghzYTHyPsXmPpaNCLkBkar3B04G8PtlTR2494lEedOaQamnOw/Q2s4fNiKYhr4DJGwWLK0LQjTJrsGqjhaE9NGn+2ro7JNmDxeXU4EAXJX36Nlyl2xRa0pVU0wy3qj0vb8dLW0UBC1HpeZN7rfE+NA7MiMo2d501BwYZ+KHk1ifX+Evr0PfqSDGuKLCujs92IMJzWNwNXbEBpO5c2OGVDIYtjnnYIcdubGG4h/HPINTA4WvNWhnkNTvEkKbGqzAaqhsKzXV7YSSiuW9Ldk7R+L+KK0ZXHGqQO6SfOuWn09jkjSQjpJzpAnb0cAXFU0Tkiriqtudv7KanIVJt+EiCXwFCz2BytjxU1r30GaSnYZzQWizjku55n1Ejp663y4zP6cba2R1IFTWr9GXJlXYKtAKvR/6a40q7ufr7Pz1z4ZCGvbiUjUWLl6wPLrDik8JEm1Bf2ggTBI8kn6JLu+3Lbqu9muT26p2m31+uRsutBAEtIT7R48WA/Z1oxP5Knt289lT8xgkD4Zr040IuFQzsQBGVHoZUKKgfcCnYUzxoVTcCpz0p5kiqQredymyvcFazQfTPs74J137P12llBW2bIj9GZDG8DRn4HBhBjglBGa0Kux3Id53iiWJTby3JO2TKJh6EE7bF+ubnfZ7CDWy+EYrax8lN+ul1ryXkBZNJN8TB6MRJehHeb1ejWmCRGTpwUf3GGiZLgEfBNRsN185gKBR7iFJP+yVwiOiwtj9JQVTWIJaM0PDuDfu9M=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(956004)(2616005)(508600001)(26005)(36860700001)(336012)(31686004)(186003)(16526019)(70586007)(44832011)(70206006)(2906002)(47076005)(83380400001)(86362001)(40460700001)(31696002)(4326008)(82310400004)(8936002)(16576012)(8676002)(82960400001)(356005)(81166007)(316002)(5660300002)(36756003)(6706004)(6916009)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2022 11:32:46.0043
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cec38de2-ac39-4269-e58c-08d9d1d16d3a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT064.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3239
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Jan 2022 11:32:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7346

From: Jan Kiszka <jan.kiszka@siemens.com>

Not needed.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e7db8c1..e9cbc60 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -30,11 +30,11 @@ default:
     base_yaml: "kas-cip.yml:kas/board/${target}.yml"
   script:
     - sudo rm -rf build/tmp
-    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi;
-    - if [ "${extension}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi;
-    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi;
-    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi;
-    - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
+    - if [ "${use_rt}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/rt.yml"; fi
+    - if [ "${extension}" != "base" ]; then base_yaml="${base_yaml}:kas/opt/${extension}.yml"; fi
+    - if [ "${wic_targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/wic-targz-img.yml"; fi
+    - if [ "${targz}" = "enable" ]; then base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
+    - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
-- 
2.31.1

