Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB7FC5321C
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:14:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30484.1785158065588134612
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:14:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cSqbgXu3;
 spf=pass (domain: siemens.com, ip: 40.107.162.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FIyW4COkBClbKX7RbMMuA0BCkgWFUE/m7RD1r8qxUWXq7qhdM8T4o4sJIFB82x6LnWiowd+9vWFWn697+WJ89HDxjlhgGyhHpV1D6Nq9NHVulF4Yoj2TCDbrf3jgpeRU2pMpbkHI/zah/ijHuH9rGGVcANsHPD82FCeqWjcyzlmHt5IV7YM6yQazpkorLiDqvYfphjhrWVlGK44SXO1yyM15Kn2zFKok4NaY7I+eqNqItLdc+ZNN47djco148IsmVcw1d2HlRpeRWoH2RG3i/KTfS49fFgz0HFYMMH5J1TxrKuu+Q7In76lVS/qFDe/hp4TbWQaJzwz1A78Q4fT+4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0wzh/SJIzOoTd+4oswdmbZpdAUamWstHOl+WN4F86WM=;
 b=CYIZ92LNTAqf3Ss8ozlp8S9Z6UxC+t0t/PQLBI8ZFrI5xT0VKbuZVxfjfTaFIDH4CNNwrom/SM0Oc2bmTMEJTKXCI0p35Y3KBom419SERa/8XomOtRT6c5ZQFrxN9NTlPXLuVnYTHRSBTjfw1mPSaItajnyRfF7rKR5FTsOnyoO1mRHqoU15IJReOXLd6QBU5KbyDoe4urc580gWNTorkeieZYPX8NM8SKBfMkojvKpGXCqdtIbvNCQPzJrrIUPyA57xaOOz5WOitmGB4MX1qOeS2L8HKtSOKu85QdsC8DQGh8qBx+DstynFPIsvXDuQCnWR4OsKjaUbUIlnpdGNbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0wzh/SJIzOoTd+4oswdmbZpdAUamWstHOl+WN4F86WM=;
 b=cSqbgXu3ysM/DNFxUc+yCkHAFBR1zfu+pjUfrHOuJ4zFVWcjQpXq9aPREY5fbrkTmVhV5uQxJQu8yahL5UxcxPUCLvqEi54HV/GUUzIgmWELJu26p8XXba4NoE7tcYnLMABNV754Kpj/qXTmH5f5dUZewvkIHdzUtZWXJm69hoUZMo4zJsx7QltH+y5fcNJWYNURy0othe+DAMcF0pTrm39ioXrYroD73cHuhsock0TTCu2LauTxv4sqMpK2gJhsLiPyzRuZw0XhMiJ2Fc2Knh7168vGrshQamyLc7WwV4o4Yyqa1Ojgl3QNnuJzDiiQZLEm1W9PV6RsbcMgEFs5iA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB9835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:14:22 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:14:22 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 12/14] Add kas file for hardening configuration
Date: Mon, 27 Jul 2026 15:13:06 +0200
Message-ID: <20260727131414.76760-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727131414.76760-1-quirin.gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260727131414.76760-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 08083572-5414-480e-ff1e-08deebe0f937
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	0TDsMurnG9VcjJk3/PNcj2fnyqc9IxpJhkDr8gIjHwxu25omk0hsb9OYUDZrRqqUAz4O/OWfzFiEuh3pPdOISs3zwgmCkT19kAsrpMrqLie9RbPTnOmdx8CGzanAP0qkOyOlqpY2ZMwzbxgVhat5YfOZFEMeH5So4RQhTkulxO4e+ASoJh8VNBxpus3Cq/Yery8RcRDqzGm1iuKkGt4jnfeVMaVm2FUGSgBaIefKqEWyJGi8NJWd1SXWkmAcuLRLeXnhHlNl1HRx7phlOE87e4zNHYYqzzICvETCgCMlkGVGDclWBd4jXCR5X2fuBbmt6fZC/VI17yU/CHLTL+Mgvy7ylm1qQhAfx9VycgAD4YyGNwx+2He2Szbhe54SGmgpm6B3m32g2yVCIhoPq1lHOQow+139QpkN6ZflRHR4VGTKxkFMPG/s2gTMb4CDv4tOPgwPFIcPj+5OEGCnH1MoMhLkaxpnu3j1QIv2BBXqgHJzfa7x7mSb7WWqixIoui7ZtnI68V3Kz8v3Rb+qll8ynxKi0KECTdfW3TLH3Q73DyM73mv/JwAdkkmpvpyg86iH6z7PT7dS2/akuCVjCSVCYOO5KyphlOH/0sDbtqmexElxr/WsaXN4DwtOGmQ/YMyqolNeWXYgH8sqJCWlz3QAZoMsHqaQ6aGijHk2/K6QYEE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M8ju7srwncE0FDqpkxnLrAKenuFzftoW9FETcxIgRrYWC+mPgxVvV/nyXGGg?=
 =?us-ascii?Q?ox7UoHdINqkA8LeWrTpwR+Sz/OySD1uXD/VyZULKAVbLGrTt4A27EpbJK32Q?=
 =?us-ascii?Q?pC2KDHzO6pEkC844V//5vymIzl8yPp3WRXZ4VnMKpOQ1Qe84Fm3GKQbMS7gT?=
 =?us-ascii?Q?+/VEFh+nd19g1wbYVrnFQhG5G+uY1K+87XPqZQjNEq7SxvzSeA3jUsWfrOmy?=
 =?us-ascii?Q?9GKGWf2aC8vUjTdwXOfsnuq/IXVgKpnlbyuuorWCiKAT7gBSevexe7tV5lsb?=
 =?us-ascii?Q?KbZzdXQBobG24jktMdG3ufNVDLppf2NCGjoozumqf2KAaqhE4BdflcamnAsv?=
 =?us-ascii?Q?AJmW1jQimGnLvQVOcvsGwOXClvM9xowPaRvKlerpCMnEXY72aWT9aGjyLcO9?=
 =?us-ascii?Q?/dslV0LsxCchpufFP59WU4hsmGBQGltGBMeEFheA0zR695mSMxPkTAG9FtoN?=
 =?us-ascii?Q?ZEZQRe5PhX2VYjrcWEdZCg+4u2J+iRCvYBJMUYVplTJMwYf02T4n18U/A/7G?=
 =?us-ascii?Q?u8yoVfx8qIeRza2n9pENu9UbPjxHhEaK5lgOvqYoEcP6fsmGEPNANgbmSJkp?=
 =?us-ascii?Q?YyToy/vLzIQitdAgIVBEGM7IGjigIpZxwOD6t1nthMigJwXArGLWQt00OgCo?=
 =?us-ascii?Q?cOhP/qIuhfLOwXnVvg95PQI++x/aQsSLajiQWG1JOjLAfDtRGZmWc7BnwBDg?=
 =?us-ascii?Q?iwW+JEbDaREpT7v/gFJGviskWP+TCSFvgUy3s1pwP/qSzZBgRd46DOht4tIv?=
 =?us-ascii?Q?/EyDXEWcmnbwPlrXe0xw1TbmpEJRkqJrLkzh3rg75lUoLUu8CkMPxfVEkNCU?=
 =?us-ascii?Q?VsnyffyxmUWX43fYSp3nmsGW5qhkmOdCSAm9eEPBitYPyavg7/92ueVexMki?=
 =?us-ascii?Q?E5/m02ipEQFciyarpY2C5Uvsv21sKVrypT3+ezurbhSh5l5UzpIcYdxBPiWs?=
 =?us-ascii?Q?f/ff6fg95Oi+iYtn63P01wAG3uFXslOjlgSIM7mV6HxZKjPzZdBoAtw1GvVu?=
 =?us-ascii?Q?m7cTdWYPP0OL4UJz0yKTDoiTo9QG08jgHvD3eiVmzQ4hHWrU2iiWJ6LgpD8a?=
 =?us-ascii?Q?7s0ZuXo5O3uGoBKBWsNAS+2wgT6sw/oK9nL/VWOlmiFUSUgt/EbzEvQ8fYcj?=
 =?us-ascii?Q?p8ekwiYGrPWsGUS7p3OaPbyarPspamx9XSFvoevz2uFb9DKaBFkr4k0A1Iyj?=
 =?us-ascii?Q?MmDcAHOsmkNJVFm/7UXCg/BHdvhJKXeIcbDyPwLWHrX0KaVxIwP2yjzSfjAl?=
 =?us-ascii?Q?YFUNyqIlwZuKKhO6Z13IcWntAZcxoA7Ylq84y7aGzptXEp4cvqRrTE3R3dMo?=
 =?us-ascii?Q?82De9dSzatk6Nsjhrq6WlM5IMv+PqDphaNRXufMtaTq3spNnf8g+s6J9Eq8E?=
 =?us-ascii?Q?sS2GsunxS30tn5pj5zKN6f8wA+RBLV9klKZfPERucNlOcNtzaQkltfu+ldY3?=
 =?us-ascii?Q?2bWUigUdPSmsyml8Z/MfHp1gpB87r3pRrvo/lqmkxkeKLcnWguhURHXLUNaw?=
 =?us-ascii?Q?dIou9++bKp8FgLmzFxJs+EKnea/nl4Ezm3VzZ3PMYQC7gF/jUQarNow8yzU2?=
 =?us-ascii?Q?nqE+Z2892yUT8szZpe81XNQ/Nm8C4pPnkPNjSaU87l3fBSgn4bBZyv/dVz2G?=
 =?us-ascii?Q?2/aGdk4f6L9SqXQq8EmaDOlvtpwpvLOK1uwhhbpeFQzCuheh6jkZCcSyLfSl?=
 =?us-ascii?Q?rFBMnEzwwrXlf+hwFoYlmPbw1JoXZzXjbC8+5RKn1whXf6R2s/QlSwEkOAT6?=
 =?us-ascii?Q?qEXwdhACKYKDhxni823zIfFpVyxG0ec=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08083572-5414-480e-ff1e-08deebe0f937
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:14:22.1422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HYD32tf/nhfjiMJbcrbHlvQ3jyVon10cxNMG/gfzKeviFwo+2EXhMKPmn6yNAaUwxXRPZTW/PVHAVlyzpqeg/plNaUVg2arGB3rMxFNupIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23764

From: Clara Kowalsky <clara.kowalsky@siemens.com>

Signed-off-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas/opt/cis-validation.yml | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 kas/opt/cis-validation.yml

diff --git a/kas/opt/cis-validation.yml b/kas/opt/cis-validation.yml
new file mode 100644
index 0000000..0f15747
--- /dev/null
+++ b/kas/opt/cis-validation.yml
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
2.53.0


