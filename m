Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F4DC61CE2
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:50 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.1])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.13127.1787564863403657251
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jJaZh9Ol;
 spf=pass (domain: siemens.com, ip: 52.101.66.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2BYmicaCF+0QATkC0htqq4IO8M0w7yFRRRZAOfrdcd/EJzT4qEy1PLeE1OeL6tjiMUj2AHLwgLtFPPBiOa2g+hL0Cb3oVqAZB2I3pSV6TJE1LTD0JcrsU7ClZOnX4mydO8w7008cG8jqyg0hqW1c0BWtVJHdYfWWbtmVU0e55UAcn3EPJAwv2A91kZY0O2WP1PYQ/yK3yTqEBbKmsHk3sQZG2288mEWlO8WWhOKDXyrRhIX5VNSbAEHMvAw4HCImvl0CUG0EH25pCbVluHruhfS4fmPcjd5gcR+PczYzAupvshJU7MVCteL1llVr0vT45uonmiFnbVewaVFXmNLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+MkcKN05lLgIPa8CER/M6UVcURSlASZfM5btvC+txM=;
 b=h/FkT1qNn0Z1337uqaCijWhs+XjIOfBaHkrGWhYM06S+On1SyHiQrqXe8xVZ4zJpBfeVO2GunACSCUd3xd0CbauK3IAkXPdwSvMKnffr9/3KGzLl9gw1Z7FCytZjXecfbGSbqb26OMMSg/RrgEUo33XXL5zD9rYCRZE3QDjjOemyWagtec7ONuTwAcJ4K3XZmlU6yn4wzpQZkvy2dWmT2ekyVvLaWzxp2RCsm6Ujmf6cG/TG6lKnfbvlhXN2oEIvE2SBT4QI/O7KuRROR4rV7O6H/5B9hpLLz0ikiCL0IwCZK6q5Dnu7W6/fgil9vGchngu/d3esv5fmDg+W37LO0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+MkcKN05lLgIPa8CER/M6UVcURSlASZfM5btvC+txM=;
 b=jJaZh9OljvuvYUnUyWMltSum8qMdZtxHO/zg6ZiBdHOrucqbAnJZlWdnjhxdp0FlZJQAHbxbMHy/81E9CioYK2HRYGiF12cVcLWGuTScLH4r7R86g6vKbtqOUOcG19djFSNamh8lfzse65UPoMjVcvR3UsbIDroefFSfXvCXC1thftoAmdAh2QbvyH+MCHXKoFp7ar7KWE0viZyWM7wHIUnWFpqs9sc67n3biXnAo8ijVrUR2cz6yZszLLhLYZ4cN2i9HajJqlYefXwwqY6QBM+pLsB/w53idYvwrFCBBTgnUcPGJu1owR/lASU0Ncz3vXGWWkd26CO5FwXwiEITqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB8PR10MB3738.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:118::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:39 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:39 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 11/12] Add kas file for hardening configuration
Date: Mon, 24 Aug 2026 11:46:48 +0200
Message-ID: <20260824094721.2636375-12-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB8PR10MB3738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6938a1c4-2af1-4170-04b7-08df01c4bc16
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|55112099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	jz6gAZ60tT+mREVBTb2orvtYxBqmA0LIx8c8eH4FwUyvApra57KbpcLDZjDXLnLFX8CmSXsd/McpBb9tBHnHwYEuKHlS4QW/6L5UD5V8MMi3lVNs62CV1aiYDey6ecYEybQhxTyvjehcS1ndG1HEIOVDcMWBKYBA328ZXVqqBAX045whDupT8YrZj0ZXKKA4FczSnXgOHEpFynC8HpD7FjdEy4opLyXOTkOWve49PAWn+oiehT2rqo27EBYXmosijbhIopyqzcgpK9Jwbz0JQA1jj+JtaPzFpOzCXlQTwvNziKCkGqtUWE9+Ng1KXinjzMu1Fp/fgNx7WF3jp58KLaYKuBvx6IjEE0QaA4Y0RYUTLXWdmQ39XpMK8WEpROj0R3nswD0QISu7PTwoWIs6OyMRGrHSzlqbgT14hXu4PBIV/dud9tGnbrf+6ZWpP5zWwbkZTGDbj/9dlm0OFrDuYkC9GoqM+QcfE57zFpysG/ncl6/z9DdicLdY8KRfIb2f4Beog5AVANYxjYs5V4ID2zYyYIAqx18X2Y+6lcVJqNtqakxawQtLP2QxVfXcTzWsKjcfeW14KrLn9D1IXtOXWKwygmDRp2jzcwJrpRZDogMB6LauSRHZi0+4f68KFr+rOFTtN8xsbAH7OS+Y1jyIP5HUrQY600n49rz9UipLNwk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(55112099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LqJ9WQY0koB8wLiS9NvQEXqw1ZkB6t7Lgo5mee3xjVXvmV3K2SLuTJqPoK4H?=
 =?us-ascii?Q?Bk1fZMCzI2by/WHKeQghQVti7gtl1bstzux1RyjVVHEI1O1qzt+zsF345MTG?=
 =?us-ascii?Q?lt+8wP0r3WUJXHmtBxm8H3Tc2WmMiz2bcrH2XRgLrvNq+IpjrKD9ijCDRobM?=
 =?us-ascii?Q?6YdH3fLyZEfofCHCxUE2crGt3Ve9wwUnt0skK0a/OPwG7JIaoPwIQbX0+DBK?=
 =?us-ascii?Q?dm3+MKGXxd6sn/VfsY5bQ9DUQfNYWbj8f2nJPUdLdHsIppySpUUTmnpNDK93?=
 =?us-ascii?Q?z2AYsvvZdfcNhTl3J1bZdzExESsFBmvT1fqPjby5TYuEaTNCk+7fqHMZqMbD?=
 =?us-ascii?Q?J4TiGxHltQwM04+Je9Xu9vfsTwXVb26JfczeYBsy2CfRIzu8f4FVfAd26Xh3?=
 =?us-ascii?Q?eaBTBtWI8JsHI//FyViSnfDYXywlm8SwJjbocPGAzNLRfsAc/S1XjWKt1G7w?=
 =?us-ascii?Q?tTgy2eZED1mqMQ42P8JUbK5pN2IYjSxtaRooQn4aw6ER8jBq3l4sqW5DPUYq?=
 =?us-ascii?Q?HynuzitVHKF7GXqlBVi67O/LAW5HBW1/GT9rutWCzanR6XI4CNXBuW/gNn9h?=
 =?us-ascii?Q?vWAr3OtNEbGctgx/u1f+et3ILTtoQVIgCVGYGqo5KKxH3DJuxotoVZfr0H5I?=
 =?us-ascii?Q?RryC0UZ5AhDUY6/MaJHaQZm0z0OeelINgJwtsO1XldXZ8b17EtBzzTDYFxuX?=
 =?us-ascii?Q?KvfPCsAWpdSfsvZogofiKAct+MidbkHTc8qebTpoMRIOkavm2FHeGaWiL9Xi?=
 =?us-ascii?Q?aaJ3lPha4RzK/hxwoDk/yhdoZjWv24jbK31xnVh8IWpaUgalZRvLEs9qh8A7?=
 =?us-ascii?Q?/xiTjND5XSdG/cPZgiCUhJeXUrtFy9Ft93POWzmxUKHgZb7GEh8Al080ZO9F?=
 =?us-ascii?Q?SMsIHGcQbVLvpgHp4YnDbdetwIH2SVKmrEPAxTijz0bdMbnsWYmKEeDcy2Tp?=
 =?us-ascii?Q?2Jy7KQA+9h8OLfwj+H7AkXmydflZm++qDbsg8DaY6c4OW0AaKS9Fk/SWdk2J?=
 =?us-ascii?Q?14i6qu+6+p3cTL5WnHeMsGhUUV+y6T7nLMPHxrDJwFhtg0OD22qNxNofLTGR?=
 =?us-ascii?Q?bpqg8GNGaLRxcj5YYYb5f3/eY2IzT03cqDLJ34GJd1zVWWr6iPAhqcLBybem?=
 =?us-ascii?Q?43qoY35NH/8Ri+kl+YKz+K7lBP9sXoGoAOoQEfikDgeSnrKzWeUQeZxSz+Qq?=
 =?us-ascii?Q?CNl8uCi5Pq8Uxs1qanJkf2wx8l7zMS+I1EvsJc2zkU8ldmAA3GJlx0cchm2o?=
 =?us-ascii?Q?pzEt1XOG50Aevanlgs1Rg/TChtKg3aPBxYtrGB385vgUIuwYa2Yk3K0qLx7j?=
 =?us-ascii?Q?KHoSyblkFvFZGmebCkchcQ1osfOOhO0PBVh/nUnpzDQord3whXeQenOmHcCq?=
 =?us-ascii?Q?Nd70U481PBXBYGwiq45q1uB/GSERw6zGkb/DMPcbRywaJeSNURvi9PnTYMSZ?=
 =?us-ascii?Q?cJIs81pQvCq98X1v3tKQPENmdWa5pkHCHCZokV3kDNjLOB4ynkB5eZIeABFD?=
 =?us-ascii?Q?0LnDio6xrSNunNhPsVoq6b5CkRCHQsU52O6Q08JoOZFI1PE9BlNQssRELUOG?=
 =?us-ascii?Q?FPPW+w518br8+wbg0sOodHbObC0ABK36DvR1bXUuUS90JqoDxyy/kN0fF/29?=
 =?us-ascii?Q?RWAzX1TtEqdzL+IM55pvJfh9cC7+mkIOb3KxNMx8r0/pDf9zjCoWhJbDYB8r?=
 =?us-ascii?Q?9SDOrTugsVqCMYbVM5RRzpMKkwW/c4miTvAup4zuA+BWKUcU6hcYZyBj6vtM?=
 =?us-ascii?Q?O7qaDcfpLHp5uVui7uDV25/VhIJJOBU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6938a1c4-2af1-4170-04b7-08df01c4bc16
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:39.2306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3c8beDdRQLbPmw8Aji/VGtRpvLAiJS5QAhA9jzpTMyxN9xUxHNS23kwUng7osJmAyzOuJzP/r0Dc6Dtsoman8xE3NO4pJFI0jKOdSkq87f4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3738
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23991

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/cis-hardening.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 kas/opt/cis-hardening.yml

diff --git a/kas/opt/cis-hardening.yml b/kas/opt/cis-hardening.yml
new file mode 100644
index 00000000..0f157470
--- /dev/null
+++ b/kas/opt/cis-hardening.yml
@@ -0,0 +1,19 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+header:
+  version: 14
+
+local_conf_header:
+  enable-hardening: |
+    CIP_CIS_HARDENING =3D "1"
+  enable-validation: |
+    CIP_CIS_HARDENING_VALIDATION =3D "1"
--=20
2.55.0


