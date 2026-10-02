Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A240DCA5FD6
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:19:55 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:19:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Q0V5FXCh;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3YjHAtNMpXFhY/on39lL6g2GeRauJewk8FN5qj5V9bbXwTu84QfUONWVFNvLLKqo9hT7SlOqEgSwF8bo/i+RWXWgsmQ+Ow6nlnyf6uqoLDWlWeKlVuJOFsmX5e8Ayf71CmynpsRvCWXuYlkaA+af8Fd50h/6WwwJfM7XplgvW4C/n/CSuqKR2RQxArzqrAr7za2uzBNxeqjbxHedEy7HZxxRN2jtFqF+lbPDDbh/YYMh72j0bnUyUFXzmV9J92xWusy4ASsgh2TCZ/O0/CDLVofQ3uQfkjqUeC2301gtnY0TPQG/P4e+PhiYNyzog+TiNZ4YQ/Kx4A2az5+Q54ksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uuUpWovNg3Uhk9VyBFEkYVMydUzQbM3ZfUIw1rYvqMg=;
 b=ogjyyQNTy//NZ67BiFWbbIpHLfM4jVYMb93MD+I53LNBG9k5zwTlrbD4Sm7p8Q9odo3rDH+2Ia6Ax/dayelovKJwdTekBZnh2y/o3sXMy4nIWxZdH606tNmFM8/w5iRoajq5or7MYNLlKbX6+XiZ0niKPZr2qXWvsjQyG5om9kthZqCcl2pXYvDHaVv8MQGG2LDcPLyqq8155Mb4D5vFsZqtj0rac8ZReOFVto0hoExj8PwumlRWrD0Ntpm6jMpjjeNv7cQeFybJEU+t7ewycKRf1RBn5zB7sEH0trxD+FXRqfHkk1syzznldR0CO7VRUnHVgkcyYO4u40NWlXf1iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uuUpWovNg3Uhk9VyBFEkYVMydUzQbM3ZfUIw1rYvqMg=;
 b=Q0V5FXCh9k/oq8Ghv7vx/nr7AYmuW4Pdi+4MU9eSzkJaBM2zEINOWRji7xbbUJs06OkQSoaSgSOomji7b2e+2Rz83BMbOrRBRxmrOlPq7gK/TZMcJDSHlwe6OGUw2hMgqd2mbRiGFGcxPkh1U1ZEscboJBPhSQV06k2l4aaelyNoJw7YSvPrJpkhXNUtmr3aXBqAXDPkkRz0GEpXyeFKS0YgO7gI9vbpefU/JKOcOwKz8g7h1pV1YqlZeTGx+Ngb7HFCIvxsUsztTg8lX44WxAValFxbmptCJV/2uzi1lZNnYy2nvKcvHUO+PygB0TGs3DUuirMFcNYe0mlpYxuZxg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:48 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 01/11] Update Isar to next
Date: Fri,  2 Oct 2026 13:18:48 +0200
Message-ID: <20261002111938.3600786-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 94dff19d-c085-456c-e706-08df207710ba
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	dPCaUfIitJZHFMsxac6VFYgttOp8nbG9HoPM4fR0TTmc7xG+DPUFXUFzK37JrFDxSF39mekmQkwQ1qmUieyDrICQjmpXJcTzPK2DsKUag2Ut8TN+uwdYDsbPT4UBJAUKdmUTW2TS6jHJWBSSx5jTgdORvXgvSMNuHbt1KdAN+W8lScN5qMNgB4brYt/IJiaCCcYg9KNLYKYPIpyFxp+H/q0BXCffmy8mX1GbVJtD3CN5CQsf7Ym3muDPlPiSR/YU8aDAsFOiJ6OeEC54oCyzhMTM/Pph7+MlzcxT8kiJ5BuS/wc7MJnwIbJ4sKfp6sgz4/Chqa6dR3yjBHXGQYeqZZjS6iDCvKPEA5dIVh169wkwlSznaqAu1WuDzghuYd8s467w+TItdpL6+YvzNOl8Rfk0jCOhdoJs3SWyNAaHETgnpdVt3qn+Y53+3SfDnTU5rFNTfKKfzszV860aFOQtZffV0D1kFJ6PV2dTLhRB4zVqLVuin2HgHKgdk+ekZwC8s4dp3bRyk73GHFVoC/+q9+7P5dP+c/HLlK5HQwwcJyqWS3QzQKHd+9/hiSCcys19lrTbhGwwFiYP9wkIVpxJzWE3j9dOxI4IMyxZRqMkeH+NocwrOVU6K6P+VGBOB4hxQdPtsPnfHgMs+iN7GLBbi1BZ6zwjPEqy7Ys629n0Ba0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v7xbA6pIMk3nDfAG28SpVN1+4gS3RnFA2nbHsC1O0lL61DN1v4+6j2FWdLFu?=
 =?us-ascii?Q?U9ZB7bHuir5sYAUb/1pvzq+OkwG+eeBmqk2TXZ42q8Pte9ERqMnrpzZMj1QQ?=
 =?us-ascii?Q?RgD1ZEKYY0GD4BiJHXvzYpgN9Z/PvF5JdcT1AE+hSTcLNg/OrtVMAV8/s9w4?=
 =?us-ascii?Q?UZ+/fyU3NXFftIssCvdp0xIKJZCLqflaHeyI05eYEJDpv8XZyEIjtdw56E2X?=
 =?us-ascii?Q?PqBfBGFKI7l1hKXSWzHpkgS5qJIzsC4UT0H06tglBfKfCRv1qHG2S/QNtoqs?=
 =?us-ascii?Q?3zHt5Bs2kKZv/p+aDObu6itgG5ahwIbcNVcCQQ6KJ2vk3Ks5xlvIqqqTUTdI?=
 =?us-ascii?Q?YIlwU4BW6dZRMxr4HHT3XuS8B26aTASYaOcewTzkoUQPUi316Ez2B5iDSEeO?=
 =?us-ascii?Q?Sv1PLtWAlfITYVrOZDOSqFGasi7Wri0jVWsniwI7Ufb8qeBKT1XCZmgB7N9Q?=
 =?us-ascii?Q?0DV8c0em6EicOA9DuuG+nGkR1EpGr+L4FqlUNIoB0EL22QelUAOgN+eE7A4z?=
 =?us-ascii?Q?oWAs9sTZx8aKZjM0T0IPyaNpJPIVQKpukMo8TCq5WHSEsUszq+BYUMZZYFl7?=
 =?us-ascii?Q?sdW4QbfNk5wrrUw4h7q0QBaXGqLtieEHCSl+NcASxEwB0agtS1bzws6oRKta?=
 =?us-ascii?Q?rtOwSsXbf/aAiL9FyOguw11cFzZFoDk26U00x5ODlcbECUrwCbBD6WsZZPXk?=
 =?us-ascii?Q?u8TI9ULuhv2hdsLaty0TmM4z4MLljhNPugtHk3tRmNQ8Kuw4hzcS0zN4IelP?=
 =?us-ascii?Q?lVpawR/FRitbuovBT/b0otrblT+vM8bnOdJ4EnnBwW2mYA3jOX38e2X/PJTo?=
 =?us-ascii?Q?xkKM2FPgL9QOuXdLZWhi/9kD4A6/zh9fpL0SBLwJQxST7QauHB+8z25RudDQ?=
 =?us-ascii?Q?uJEYDVGHiN92Wb9cAp6QvkXX8MR6Ir4BhdObzOGmv0amEhB1AHrbJWeQSnkr?=
 =?us-ascii?Q?WdX1GEb9KduJZnlyLVOZgZ8JUbKHZ8gSiW3wJoGoTr/tuQqm+ot1v0D3I+u3?=
 =?us-ascii?Q?V6YVCJTodNlUp7qj4MYsAGHeYI5xTQjMzw8qCW5CnajDhbOOXI69L7KXVZzg?=
 =?us-ascii?Q?7vYOVnRs/X+4CT34E03+E8//f07t5+RdaVKz86dxvYCqk5gYCbVOLbKR4kuu?=
 =?us-ascii?Q?CB2vbm4kmWYrvWOeJGzJpwfeZXyMpG2FVQvuKbjlwwGzzvNZKYv+ceR/JVKp?=
 =?us-ascii?Q?OsdPHc9032wMBddoXFEjasggOrOzWW7ng2vAcaUDsDzVyJFBFtCqGvnk9CsN?=
 =?us-ascii?Q?YcT8mOT9aKq95zISveHHHgpN/PzfrDNj9bta4hJvii49DCMorA7uAZmsaUoG?=
 =?us-ascii?Q?rqCH2xL+AnZAHUrdJRU27ARuClQ9rys9HcrP6a5aUhrBNEe/NDEKne+X3m5t?=
 =?us-ascii?Q?y93xkxUuYOtWYlKHVwx0SN+LEjPwfbcTHrJGkd7fZmkk9eHVi02PvF2WCi6c?=
 =?us-ascii?Q?pzn41ZWpTooFQ1wWUstCPibdgGPlHGUhBDPMOqPTeCWZhcPr5azjiSVgasTQ?=
 =?us-ascii?Q?vT9x++HXZEkPK5W/9xGFAlaDTj2kdUZWKSa9M+emvoEnJZvHmUpyfeysK6ek?=
 =?us-ascii?Q?DjT6+0EGho0Ryc40REJx3hA3VeSZcJO977FfBEQWomPK68eX9dVsDMHZhtON?=
 =?us-ascii?Q?wB1TzL+uCUhJTFwDWrSQRNVE+yMCd7Us3UsW2Csj9fpipyCzQXlSw2SUOHm3?=
 =?us-ascii?Q?7RH8SlyiTYDticKMkH2SpxCA44f4+heNLSzU+/+NJvh1FRNnU3i6DHcWknTa?=
 =?us-ascii?Q?psk7+hnETb7XxBoWrL3w/CCp+I8qM8U=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94dff19d-c085-456c-e706-08df207710ba
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:46.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2sYm1AUdn5M5mHdQQp4kkf+uqW7pAzlCJZDHyEr565qPE0JNVaI9p1emPeiQ1du+Dfchfjbv8YqjKrKQLWNiG77a8LYf1Z05T+tzdlBIWQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:19:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24404

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 818944d8..d618a6ed 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,16 +22,9 @@ repos:
=20
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 1d8791f5ea178bc31ba2ff3c211ef5030f542c13
+    commit: bbb81cd0eec51f224123efedcd7cd7c9f610a7e7
     layers:
       meta:
-    patches:
-      p1:
-        repo: cip-core
-        path: isar-patches/0001-isar-mounts-mount-run-as-tmpfs-for-systemd=
-execution.patch
-      p2:
-        repo: cip-core
-        path: isar-patches/0002-image-postproc-extension-fix-machine-id-fi=
le-being-w.patch
=20
 bblayers_conf_header:
   standard: |
--=20
2.55.0


