Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC6DC25B78
	for <webhook@archiver.kernel.org>; Tue, 28 May 2024 08:21:21 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.71])
 by mx.groups.io with SMTP id smtpd.web11.17342.1716884473544920247
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 May 2024 01:21:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iGGL4BjZ;
 spf=pass (domain: siemens.com, ip: 40.107.105.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFvpu/gc+Ta0IdjRw0i0LUkUnhPLAz/ApuGZ86TtIZAcQP+FQfjOEybURPiwCUS0KUNaNO7H3K1z9FMQ6YxR1xzzLONxryzJ064Vqc8qS1f1nhjHpq+cNfjH+qm2YlcZO1BkaBXbOmUaOvSpaj73OPDtAar41UvoewM1LpNiGhU2PK2RsEHsuXjdHZ9nFDLs2SArtRdy9z/51F4Lk45BltweMXQDrlnclbUSyvgM4zmocLP8Tf3+nloOZ6ngovHmnGJjp0DQI2kxO60rZBRCJEGM3i5MSi5cVHqyhD1OhYDWAKCKiHA3q2ieiBo/ZhTCJt/PkAmM93ipHXGWswjfLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKiPtDeu48knbr2iWhyxJlNcg/pmnX538Xf+yZHps9c=;
 b=ZUn056Oy0DCeRorW8+/NjAXxW8S8b1JSalizyUeTiNpG0o5h16NFZRc8HVawZSf/RrNvAFvCSQEAIY0T5gNyN3i8fZ9E3+D7fV1CriyTDxsiKwGwzJZocJDlQbQd6/Tzk4Q1RDJwfpAglBaIdhlWDtvgl6c2hMsppsMZtLSw1JoC0k8L8AMIKoy1SLQYRL5RxTKZsZY0c+uS/MprENcKznbylSFRTHf1KC2OC2yY0HVTL5mAXyOD9zld5bGcNhezyGYRcn/b6FQgxR72oP/WMMgxKJnTWQf5wvi5cSeJzx7RbYLC+AYrBhnBG7O6xKWOZmZB38GEY3jCCWvCnBDW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKiPtDeu48knbr2iWhyxJlNcg/pmnX538Xf+yZHps9c=;
 b=iGGL4BjZ4u2Tcv9vOhqYOAFmJlnLNFgzilrL1R4ywt2cZYLINwqTqkfsVIjZb0tPyznAWbIuKqtfbzeWDIRzoRofdXLRyWOdMx8fpr8sAsbhpSWGgpzqg8GcdMsgmfQPeQ167F2x00eNE1xv5XcJNz+FY3dXyvqgp1i7x2BMpGoY8YVBqd6S7OdfAve7n9nEc6PyjUuuEgLFV0Yl3np+qqraVDDBqeL+pdADyyFOurkWpAV19evE9V3jHjnxD8IOTcmlPTkIX0j/5zkgA8bazDhCJpTW1dRqfJ6K0UunD96W1H4oSrmtywwV1IeeIWC5hK73GJmnhQYTmM0HaS0fCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB4112.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Tue, 28 May
 2024 08:21:08 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 08:21:07 +0000
Message-ID: <223c22e8-5e4f-4a5d-bfe2-037cbd1ee8d7@siemens.com>
Date: Tue, 28 May 2024 10:21:06 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] Update isar revision
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0272.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 67dabea1-7615-4d5d-9bc1-08dc7eef1ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QnVhT2xWMnp1R1Z2WVE0YnNteE14ZktEYlhydVBFREYrczJxdm9OTU1ncHlx?=
 =?utf-8?B?THc4TGdEU3BubUplblB0eWVDZ01ZZlJpWCt4di8xZ2hKSjV5bjZzQXFlMUdL?=
 =?utf-8?B?WENZT3I2TC9pek9QVkVJTmVSS3dFaTBhQ3lmdUFUQnk1VVBIbUx0N3ZyQ1NU?=
 =?utf-8?B?TzVqVHIxTkF6a2J1dTZmcGd1cHUwVDVIZmd6MHgzSVlnOEJJM1hTUFl1QzhQ?=
 =?utf-8?B?bm56UVFjL0VNN21Ham41ZU1KSjFjNzI0a3B1MTdjQWwrVFhiQngwVDhFTVFV?=
 =?utf-8?B?cFNudHVIaHVydkxDaWNwUkNZZFZQOUg3VVNNQ1ptSmxhaGVCbEMwUHFJd2Zt?=
 =?utf-8?B?WGJhdDVKZURwRkdJeVlsRDdoU3dxM1BrSnNVZXJVeFZJOHJCMzFjQi9YSC9n?=
 =?utf-8?B?NlJUWTlNMng3dTdGTjhYSHNiK1pGVXJwSUdDUUpydi95MnEzV0VlRDFPQjR6?=
 =?utf-8?B?MllKWnFYcW9ZMWtkYmNKQTkxNjFTZTBIUGtJOStlU2RKTTBJcXcrT2QweUc0?=
 =?utf-8?B?QTMvUVBDbWpBVElkb0NIMHAvTXFOSXo0L0thVTVCV0hOYVBxa0FLZzhnL1cw?=
 =?utf-8?B?dzh1aVNXRE9aR1ZLWitZeUhrRytVSjdyTm0wZXRUNTU1LzlSb1ptbXU3NzFS?=
 =?utf-8?B?aThEVFV4TEwvcG5SN3BtcncwN1ovTi84UGF5NXJ3Q0dYZFBHcXNWR2hHVEtw?=
 =?utf-8?B?QlFmMGhKSlB5TVp0T09iVjY5UEVOaDhDdXFqbHUrQVV5NVd2WnExWFpEMEZa?=
 =?utf-8?B?S0N4Ly9aNVpVNjJzUGpIWVFFMkVNa3V2N2JvYk5mSytaV251Ujc5R3NxYm9T?=
 =?utf-8?B?U09nU0dvMVBaVGQ3TGhlcUdnSmxBalBCRFU0S1EvalU2UW45UUVlNDhKQTVH?=
 =?utf-8?B?VzRsdGVHUzBGT0QycTFQQzNzcVlqekxmS0ZnV0ZkbnhjT2hmeWE1dm5rYUJj?=
 =?utf-8?B?SHB4cGJIbGlqZkV2NmpOeTY1SlVFQjlIT2NVNU1oVmZydGEzcU9KLzJGRDJh?=
 =?utf-8?B?K0hZK2ZNMUQ3SERIUytOUnYramN5ZGZpdk01a1gxVDd4Umlta1lncHJQeTlG?=
 =?utf-8?B?ZUxYWmMxV0dPejRnZVFCdFg4LzhMQkI0YTFST093WU5sWjhXSjFINmo3QUp5?=
 =?utf-8?B?RmJVUnI1bUx4cWt1eVh3eWkrNUVBQlNGRkVxYVB0aFJFTkt2TmhMWmNEb0dz?=
 =?utf-8?B?WkMzMy9nMTRvMlpwOEpGbGsyQ3R0Ry9sM1RDWmM5cW1UNDN1ejlJbjNiZ25D?=
 =?utf-8?B?aWtRWURkQ2daeHVaY0htc0ZjTTg2REpKZGlsTGR4NE5vSnBLcnhTaVVMeVho?=
 =?utf-8?B?MmVoNnBER0s3UFV6ODZ3YWs1bVJ5VWNieVIveG41dlpFdm1QTFZ5ZzNLc1NP?=
 =?utf-8?B?RlVRZmZybnBWTEVBWUhzR0ZCSXI2L0FnYUJSTHVQc0I0SU5hSWtENzRZMFkw?=
 =?utf-8?B?TUdyTnowMW4zK3hhekl5bzNJTU5HUTVqYUF4eS9NRDhUTWlhVjR6ZzVWazdu?=
 =?utf-8?B?aEJpUTJoVzNqMStMR2g5RjFlZmdzaWVLYXNnTHBmTXpDUmJrMmhsQmdBdDdz?=
 =?utf-8?B?a2UrVnprbjFkaGxNWUNTdmhQbnBUTzZhK0RmZ3VDc0pxbVVZR3FYdHB3YW0y?=
 =?utf-8?Q?PJSdPU6O4PhMAsDgrFVimhSRvr1tRGhcpYsPdWYTvsSM=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ZngxVzVuaTdLVzd2TXRzb095RHY2WEluYzJuZ01BN2tzV09CQkUxaE5TNFZs?=
 =?utf-8?B?aHM1NmhwYkcyODM5RWh2eFAvcVllTkIxUFFnNHVQaGRHTTVuMTJYbjhYcXQx?=
 =?utf-8?B?MmVNazFSL0dFODZHbkkxVE54NC9rNWYydEk4MUJhQ3dXUzkrdzhBdWhxRTg0?=
 =?utf-8?B?U0hwYkdzUWt5VUpzNEtKRXlldUFFSkZ4aUcyQUs3VTczb2JEb3ppVVVrcGJ5?=
 =?utf-8?B?NllmYzFrNlRObFVLakdMSGJ6RmJ0OGN0c1doaGUrR3NlOU9SOE9UTEhqZFJQ?=
 =?utf-8?B?b21oam0yTGc3dFlFTFNnRTFwRXJ0eU1mL0NsNERuYzBuejJqVmZJbTBMVEJX?=
 =?utf-8?B?cE55QmFPS3BDcVlaUllqUDlMa3c4cFh6TjNMdkNsT3M5MDBKUmtJOVBDeFkv?=
 =?utf-8?B?eDdSWnJVS3p2aWl1UUhhMyszdlZFckFwM3BoQnp5RnYyNGxzeEh3dExpSlNm?=
 =?utf-8?B?OTdzNHhDWkZsbUU4UDNJbUZKQ0R3YUJFa08wbytQZEFvajZsVm1BOVBrUy9p?=
 =?utf-8?B?aW5GQndYcHpYNm5qRCtld1MraDFmSlJHWDcwaU1ybGRkL0s1OVY2T2lzVmUv?=
 =?utf-8?B?czI1cFkwOUlVdUMvMEZidXNsM2MrZDJhNDRUckZVV0tGLzdXNDIyWTdyVGVj?=
 =?utf-8?B?TkFTck5ockFrS2JmeFEway9UNU82TFN5Z2J6ZHdORllGV1RLZVl4YnBjLzcz?=
 =?utf-8?B?ZnY3NjdQRWRTWncrWFg1TkZ4Z0tIemtqSXNXVUNmL0NQTitIVS9ab0ZmMVkr?=
 =?utf-8?B?THNCQTVJZm1lQ0x6Zm5tMTc1alk5UFJSd3hqSDJzNThlYTVFdURtVUpka09D?=
 =?utf-8?B?NnJyaVNFb2tDNWNhcXBFSnQwelhDWmkvQnZKU29tMExOQ0c5UEh2UVZBdnV6?=
 =?utf-8?B?MTFUdWdQLzBSQkd3cnB0cUxOODdlRkUwWDZmZG1LdzQ2eHlrTGFndUYyNE9Y?=
 =?utf-8?B?ZzUxd090eThOU29pOFJVdmxJVkJOMVhHemdyRENvaEFRaDhMbXA2U1ZSb25s?=
 =?utf-8?B?WGpDWWx4bXhsbnVwYUZjVmhNUy9CdlZQOVBDMW5JOTl6Y0NXUHE5MTVjOEZE?=
 =?utf-8?B?aHMxa3U0dHgwa3h4QXJIUVZwTnY5aHltek9xVjBaL3hqUEFvemh6YWxMa1hX?=
 =?utf-8?B?TGlXOGtuQjdPNjlPN1dtbHY3UklpaENIamF5L09FWmVZUVlUTTNvZGEyek9O?=
 =?utf-8?B?MHpsKzJzbXhvMGtCbmRjMVlWTlR4US9BaVZlb2hwTU1mUndUSldIYktDazlr?=
 =?utf-8?B?bWVCMnFLWDRWeGw4TDJYaHkwaFk4cFVWektxTEttT3licTNKTnB6VEJtWE1h?=
 =?utf-8?B?Nk1IcGM4OTZTalBnNFdaMjdacnNPREdKaWMzYTlRY2FQWWY1cE5oWVdWOFpT?=
 =?utf-8?B?UEpiMi9DQm5ZMUdsbGZheVR0a1luY1greWF0MTZoTStGeUdWWW9zK0ZlNVUy?=
 =?utf-8?B?bnZBd0NPb0tGT3JNazZmRE1qOUVoeTN1bGFYYWE3bmxjUXlldW01U20yQzBW?=
 =?utf-8?B?Z0N0a2RjRGdBK0tTaVZjTlJQZVIyVkZHdEtJa1BYbkhPRzZtMlBhQjVJT3Vr?=
 =?utf-8?B?Y0g5Smt3aXUzUjhsVzJjNGhleFVnMHdPRm1HWDZqbnNVOXFZL1pacFRzK3ZF?=
 =?utf-8?B?QnNEeGdPLzZ3RURnMG91SkpjOW5vRXM2R0JXZzhvcTBxTUozNmtTUE1qbzVu?=
 =?utf-8?B?a3dHMStUc25tdWdmYUpqZlFLcngwcmd2RnhNSkZ2UE82OWcwQ1BTTW54Wm8y?=
 =?utf-8?B?YVE3SUZmaFh6bWI5emdITm5wUGhCNklaTUN0VGNIYXVUR0RQNC9yNWpZVis5?=
 =?utf-8?B?ZkRNdDZlSi9QeG1TTFNNak54empuVkI3Y29wdzNBalJTMTlIZmdGQURhL3V0?=
 =?utf-8?B?M3NiQU1VbDQrTWJVdkNablc4U2VhWFo4dGhoUi9kU3EvclI1RjBzOTRBeDk3?=
 =?utf-8?B?TVhQdGcyaG5iZlpscENNYWtIcmdLV2VtaE42U0lIbjFMVDdPWUxhWmhZcS83?=
 =?utf-8?B?TjRwcjNhYlh4dVhoYTdEQkVNekM5UDdreEFWZ2VscXNYcEk4L3l5VlFOc0kv?=
 =?utf-8?B?eStmekowQXZQN0ZWK2ZxTnQvZnNDamFQMk1UcTYzWExrNlZvZ0R3ZFQyZVVm?=
 =?utf-8?B?Y1dLWnZieFlYeVpzaWEwVDBiMEZlR0kzUjNWYXJlWWhvWjhPb3RId1p2VUZt?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67dabea1-7615-4d5d-9bc1-08dc7eef1ff8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2024 08:21:07.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o1Z0YaV3ky0RICRdtkHCzYpWF5IrmzSB0X1IKWhmFez0TUSI81RUChtfxs5r83K/pq/LaPHUVcDi8kkovqvRig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4112
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 May 2024 08:21:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15960

From: Jan Kiszka <jan.kiszka@siemens.com>

This specifically brings fixes and improvements for custom kernel
builds and a newer wic version which helps with image reproducibility.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 kas-cip.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 52e53061..9e49366c 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -1,7 +1,7 @@
 #
 # CIP Core, generic profile
 #
-# Copyright (c) Siemens AG, 2019-2023
+# Copyright (c) Siemens AG, 2019-2024
 #
 # Authors:
 #  Jan Kiszka <jan.kiszka@siemens.com>
@@ -22,7 +22,7 @@ repos:
 
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 3d863aad5e12c7bef382cb6fb3f1f5e18b236156
+    commit: da3804874dfdf825b9053d56a1e441ff21d4417b
     layers:
       meta:
 
-- 
2.43.0

