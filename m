Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4364CCF9E0
	for <webhook@archiver.kernel.org>; Fri, 24 Oct 2025 10:12:59 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.27])
 by mx.groups.io with SMTP id smtpd.web10.6698.1761300769269613421
 for <cip-dev@lists.cip-project.org>;
 Fri, 24 Oct 2025 03:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=sp7i50SC;
 spf=pass (domain: siemens.com, ip: 52.101.84.27, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vl02WVi151EXys4sU0WNKXrUabCc+cZ6plHOY/0joRrYFrw6qMQHPRVWk8o59NmXv2QSqcXhgobfibR7ywHbGtnD0KgwjW4UUthZQU9aQUyREVSrbJ7tcpFe/ScC5mEbHMf92vb4xGhQJ1T+yssoGXaA9evVQ+u2W3mpQTVyBboO+5eZUIQabgCXTB5blSxdiAX2Pp8tAU4Of5rUTslDyPdjBULvK1wQ2XJVNMkGBAUs7Ht96ZGJUDtvc9X2s8qblN2e08V0auFrx5tj7zl9g6n9cVbNpWoCPmlzFiOiqF4Pzl/Rqac02LKGpu4FP8T2svwLq0GkiUQkGBkMS5vn2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Fm2uPpE89LsyujPDE5QU+4JnJ7cYASEK0WH5eqjoRM=;
 b=kBq0hYmHLNawj+f+oWwGP7XF97r7JsqYl6yOAb7tnl7ZZkSs3vRrW5Zrqdz/t7hOfa+apVkwQNTJsEL+BVubckVscdZEXtCHhdb6QjmofHB45r0VQ8ascAZxc7HF6F2MRNZ5LGhReXcNsM0tL1Y/ZQLNDbEAxphK93YGcHPWlAr2X5hJ4uHMLWoocSxsbYu5P6TtGQXb1pZYcGxkgMuSTumC5WJkNtYdjtFrUyTyK6kiNusuJjEozNhvQ1+2eFSlymu96RvxGy8R13p+DqbCIIT+rSPAkK6a4PNqx07xWASEYbHRQ6IiVAACeZaZFGBrhHOUHCmDMewHKZ0fnSRkYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Fm2uPpE89LsyujPDE5QU+4JnJ7cYASEK0WH5eqjoRM=;
 b=sp7i50SCZT0zAO/D3CB47TLWx8MP2bxqtGxOr3r9bp7y+RN8PRzGexOnRMdZW3rFEu2cO2K3HvYVW+Os6DCR8tFVh5ZRhpUxNKcDQKdQfhTPGsgM9ak/reXLASrs71LqmFhDokU3UtUn+64zCKsvwDLiysGWukNRYl1q+1/aNpNzGLQywzZdUjuXDNvxO/NZ2SC9p29ExEx3ztycoNGtdc/ZW57C9kSzBQYuNSyeOEwI+r3hqa+ZPVPoJeHvxS2OuVNxrMKLqny/BYiJ7brVlmgA9901Jtq/V9lInvaprNF8RpIn2DgiN0n/OTQUKxEVil6d67zoYu+15lDC2gJwkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB8524.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:239::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 10:12:46 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 10:12:46 +0000
Message-ID: <0c733d9c-4dc0-4eb8-b2b5-a200b7135d48@siemens.com>
Date: Fri, 24 Oct 2025 12:12:45 +0200
User-Agent: Mozilla Thunderbird
Subject: [isar-cip-core][PATCH 2/2] read-only-rootfs: Use single sudo session
 for multiple commands
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>
References: <70896e59-d6ca-41b7-b06d-bac4238d95f5@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <70896e59-d6ca-41b7-b06d-bac4238d95f5@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0339.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 68d9da5d-56f4-4977-19d8-08de12e5e0c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cUdTcWtRbi9mVVphczNYZ3Y3M0Nkb0dUVEFMWUdCdmRXWGw1Ynpvb0VmN3l1?=
 =?utf-8?B?aGt1NElpVTNpWllHL09rKzloNFplZ0FDZWJmR1gxRFkwemRBc0p2NUhtbTMw?=
 =?utf-8?B?b0NNblVqVkdjaWo0Y3NSclRCSlA3RXZqajN0OGptVWcydC85a2wxSmhPU0xC?=
 =?utf-8?B?Nm00MStCbU9WanZnUEZrNEZEV0NiNmh2SGxzTks4OTZESnBZMG5ySFl1L2lF?=
 =?utf-8?B?QzI1QlV0b0JtZ0I1RU40a3JyOE5GNDNNNUtkLzFhWWhYWGZIVEc2K3ZwYWRO?=
 =?utf-8?B?M2hsOUp1NHNNcFVSUjg1dWRLTG4wZ1NaRHpnZFUrS0tzZHRzSVZLMUs2Z1pK?=
 =?utf-8?B?eDh6Y3Q3dXNJbHErdHFkd2RrZzdpTXN3eVZMRG5FN3NLbEpSWXE0bDlqdUxT?=
 =?utf-8?B?SmZOajRhRFRnczk4REpMaURkV0VsSEFZaTdIQitpU09XbkVDTlY2OTVpT0Vy?=
 =?utf-8?B?QWIzMDdMR1JiOEk3UmpmODZOcGdETys3c3BKajQ1Nkg0Uk42Q082dnQ4U0R5?=
 =?utf-8?B?ekFZekxzTGpRYTkreTIyUmZLUWsvNUxxZ3YycjhXTkpCV2lSTVBnZGk1SzJ3?=
 =?utf-8?B?UXFuM1ZPQkg2bHBvRFV0U3V4TG9yd3Q0aXdOSWZZZ2R2cmdJbnUyUnljNTZW?=
 =?utf-8?B?eGZNdUtSdjlxanBpR01uemVDRFo5bEhDOFQvTEgvM21sQXp3d0cvSWFCY1pS?=
 =?utf-8?B?VDlXN1B3QWJjbTVTOVNTZXBmYXc5OXl5L3ZpWm9MNkdBTE5IMUJtb3plSU1L?=
 =?utf-8?B?NTNocHluY0ZnODdjZ2pTdzl3VVJ1Nng2ZHhjOUsyaUVjSnJvVjdaYmxiYmNq?=
 =?utf-8?B?bmJwYXljeFdzQ28xQ29wYm11ZEtwem9wbEJjYjlrV0MzYUtZMFhoWndEbXd3?=
 =?utf-8?B?SXcwZEtPaWpPN2tMKy9VQWp1ZFk2ajkzczFGZnBhRUdpTHNnRmlQQXh1ZHdK?=
 =?utf-8?B?d2k4Wk9RRmREMDhIWDZqTmcyUHFXek9wZmtiVE8xbktsNzhCQXRERDNqYkk2?=
 =?utf-8?B?UU82K1Rub0RFL2pXZUJYVHQ2LzNGWEhSYUxkcERWZE14cW9icW1NOWJEWFpC?=
 =?utf-8?B?M0RLNG93NEFQVkNwZ0oxMFc2VGt1THQzT3JzekJ4SnV1LzFOYzEvNWd3ZEE0?=
 =?utf-8?B?S0NVZ3FpRnpQdmpFYm1iYUVIMlk3SHFHYlJ4NzhuT2FnVi9KdDJoNEdHZ3Jp?=
 =?utf-8?B?Z1Q2Z0VXWmdNaEJXQUxjckpkbThtV0xuS1NKbWZhekRzL3VUNWRUSUh6MVB1?=
 =?utf-8?B?cEw1VnIrd3ltbStZd0tvc3hwNlRrbjhKMjM1QkU1b0h6K1pWdTJKNERZWE1T?=
 =?utf-8?B?V3Z1T2tnZUNlQlZ3dEtQQ2lROEZVQ0YvaFZVMmRyYlFka25iQWZTcDFqSm1L?=
 =?utf-8?B?UDNkWlZuY2s4L3E2VSs1MlBBT1lzbHFwTmtpeTBIcVlYWDZyNXRlalpnQ0J1?=
 =?utf-8?B?dk9EQnNsNkZ2Q2NCU01Qc0s3VHUwOGowdlRWbDY3MVFXQVU0bXVzdlArdzZy?=
 =?utf-8?B?Z20vcXNhWDlQOEN5L1d6dVRjWkU5OTdkN2pYTlJHYko3a2dueEZCaUcwK25k?=
 =?utf-8?B?MWwyMlpsdUZ5YUJ6Z1dkd3lHQUVVRG0vWVR0dVcyNHRvNk5rOFFGaVpCL2ZG?=
 =?utf-8?B?MHd5RnYwa0pIVDVUU09RK25Kck5iQlYwajJhV1dJMG9JVWJVWXJMRGpkMkJO?=
 =?utf-8?B?S0lmMDFJQllnKzVaRW0vSDdVWmJ1N0NOcU1lOCtQSzNVMUkwZUNmVFcrVEhM?=
 =?utf-8?B?ME9idVl3aFd5NmVaYlVBMS9tM3U4ejkyMWhWNzZZTmVrV0t4ZW0rVGJxbVh5?=
 =?utf-8?B?azdtamgwV0ZYa1ZFbVJleXcxbkxMMGJsUjZmR1pySUkrSysxUUppZ2V2VU5Z?=
 =?utf-8?B?K2pzSktld0wxQUJQUmJ4MGlPVkhtdE12VkJZcHdHdlhva0FZMmRrVEgvZFF2?=
 =?utf-8?Q?pkFW4m9cz/FDRthtHMJaL7NYmQ0i2gq9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N1NFWmowbUtHVFI3QS8zWjlOa2FUYkVPTCsrK2ZvZ29BbVJjNGNPMW5oaEMv?=
 =?utf-8?B?TEdNSlRtRzg1TjlRbXdkYlNTdGs3NHVYSnpXc0E1RTBEZWltS0VPMGlaaFVP?=
 =?utf-8?B?UlZwc1NtK1hvb1o2VGg3QUc5c3NFeHJmYSt6T3BsUStsSWFkZXdhSHVObTg3?=
 =?utf-8?B?TE44WXVsUkhLcExZb0hiSkd2V2FldGdmeVRhNVVrM04rb3JlL1BmNGpsbzRJ?=
 =?utf-8?B?cExabGRxOTJYdk9ENzVtMEJ5Zm9GNzhtMEd2Qmd4VkdJVCs3dVg4MUdHd0RM?=
 =?utf-8?B?N0FBS3I0aWx1QVhndFJHRHNkbXlZczlyNlpqLzVsRWg4NVFrRnZwc2RZbStx?=
 =?utf-8?B?cnJPaEc3UFdrOG5jbTBVYW14b0M3L3lYZitJRnlZVGFoazEweUFzYXdsVEpK?=
 =?utf-8?B?N1EzbHRhd2ppck1USU9TVnZzR05FNDg1d1NyQU1iZ09OY1F1bUp1YUlLeHFK?=
 =?utf-8?B?TnR5ZXFLTSs5cEF0UGZaSG9TZ1pEZ1BFdlpBWDR2L2xVZmZEb0hSRDZOcUJw?=
 =?utf-8?B?THAyU2dZV24zeHhFQUc0U2h3OHR4MGdHSnR6Zko0S094WmJyUVdEbHcvaUMv?=
 =?utf-8?B?MXl3L0hmWm1NQjZhendZUE01Q0l1MjNlQUw3QXlySkl0cW5qQ2dsMHdHdnpz?=
 =?utf-8?B?M3lrMC94c3h6Q3M0NmMxSUZidDRUaENLWHZrUHRJNUVnNzc1amtWT3d3b0dE?=
 =?utf-8?B?VzBoZG1ySFU3Tm1CTVg4TmpTdEZBcWVROE92VGpRRWRadmM4Y0FrZVhRYllv?=
 =?utf-8?B?ekhIM3p5d1BYK1lhK2lzSWtRVEI2cTB5dmVWaW1Xbkw1Smt4aXVYbUlCTmU1?=
 =?utf-8?B?VWUrTU1jenRqQzd4NTNOdUc2aGFRODNHRllKM1J6cjVKemliNGF4dG4rM2dN?=
 =?utf-8?B?UzdicFJlSDFCVzd0eHZCbXJwSU1aZlBNTDMrWjg4YXM1YnRMQmx4bjNYT3cr?=
 =?utf-8?B?dXQ1SUFocjNMQWpMMEQzK3FMM3IvMnpldlNpUExFd05UNkt2c1ZwNWhYcXJx?=
 =?utf-8?B?SHlIVU5IaEhwQ3RNZGE0UVRPcmZ0dUIyalpZVDliTW50akpKbWNoZWhnVXZQ?=
 =?utf-8?B?cVlyQUM3cXpLcFF4aGJQUXZhVm1PdGhBRUZvKzNDcSt5SHpBTzI2Q1pjNGx2?=
 =?utf-8?B?enlicVNiUVFFYWx1Vmxnb2tOOWVmMk1Mb2oxTXRHbU5xTy9TcEtoNWU3ZXNh?=
 =?utf-8?B?V1NxTCtvNC9pZGo0Umk4YWttbytOaXFyMG82dG1ZU0d5QWlOekEyWHZ3RlNM?=
 =?utf-8?B?bkJYTnNMWm9NbXY2MkI3NFovdW9oRFFSdWhuWUlhWHhHVzBJM0N3SjRXOVVw?=
 =?utf-8?B?L2xYY3BLM0M0RkkzNWNmT3I1eUhybHB5a0xyVXN6bGttekM4WDQ3bEVPQ2tn?=
 =?utf-8?B?U2I2QjZIYTBOYkNyRk1EV1M3R0xiQ3JmanJLeEhiYmlydTZ0MnJwU3pjemVr?=
 =?utf-8?B?aXdTK2xUL2E5UGxyazg4RWdEVHk0b2ZHUVo2a29jTlk1eHdmUzBiRytabnFD?=
 =?utf-8?B?dFk1RXNCSDZmYlJlVDNmYnJDQnI0aEVYdlNJN2docG5pZ0FpNTZ5SjIwSXp6?=
 =?utf-8?B?NHhvaFlaUkpHdzVuL2dYY2lORk1UOTJqM1pHT1FWN0JKVmd6bVcyb3hUa3VT?=
 =?utf-8?B?MUJYRWt2RWR3Uk1MeTdPQW1hV3JKYUhiUWhJWDJLVkNXblhocHhpL3RJYW5U?=
 =?utf-8?B?NE1ES2kxazl0QzI3K0N5aHhBbzkxYkpleDVBZkNwK3E4dWRETE5PeHRvTGVV?=
 =?utf-8?B?TmhJSHlWMXUxS2dRc09yYW8yVG1ESlVqcFd2aUZCVjhmdVVyMlVPTS9zWEdt?=
 =?utf-8?B?RWlwMG1tN2R1SUN2MmlWN3RXYSt6QlJrNUtTNFFWMjBoZHpyV3JBc29SSmVJ?=
 =?utf-8?B?UVhvMTZXV3h0UjcvdXRpdzQ4NjVEUEQ3bEFSaFhTVVRIRzJHWkJCOVBwWjZB?=
 =?utf-8?B?eENnWXpWWDIwR3h1OEJneUlJLzVHM2szOCs1cExVRUZlQjh4QVpFeTRla0FJ?=
 =?utf-8?B?R0ppc3ZLQ0pwdnp4V0xqQWZEM2R6a1lmRHlDR011bXp6Ym5BYUxwa1UyZ2Zk?=
 =?utf-8?B?KzEwNGoweExveEJIRDhzWkZ0R2NzSGRPUWhVK0dsSEZXUERWOW9PT2dJU0lk?=
 =?utf-8?B?T0wxdFpGdGlRSDBSN0lJM2k5V2hjd3pUNWd0cWNJcUFOYVV0bnJvQzlqeFA5?=
 =?utf-8?B?QUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68d9da5d-56f4-4977-19d8-08de12e5e0c8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 10:12:46.2562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yTL6k4/CXa1LaMf6LSk4VGGwsZmI+33Y3N9ZbKmAyMJXMDDmfXGuL1CGIWb+cCz3W6ULTS+S2/+W07m36gaaeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8524
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 24 Oct 2025 10:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20218

From: Jan Kiszka <jan.kiszka@siemens.com>

Slightly more efficient than invoking sudo over and over again.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/read-only-rootfs.bbclass | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
index 6a21e9e3..054f2725 100644
--- a/classes/read-only-rootfs.bbclass
+++ b/classes/read-only-rootfs.bbclass
@@ -49,13 +49,17 @@ ROOTFS_POSTPROCESS_COMMAND:append = " copy_home_to_immutable_data"
 ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part = " copy_home_to_immutable_data"
 copy_home_to_immutable_data() {
     IMMUTABLE_HOME_DIR="${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
-    sudo mkdir -p "$IMMUTABLE_HOME_DIR"
-    sudo rm -rf "$IMMUTABLE_HOME_DIR/home"
-    sudo mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
-    # as the rootfs is read-only we need to create the link
-    # between /var/home and /home during creation.
-    sudo ln -s var/home ${IMAGE_ROOTFS}/home
-    sudo mkdir -p ${IMAGE_ROOTFS}/var/home
+    sudo -s <<EOSUDO
+        set -e
+        mkdir -p "$IMMUTABLE_HOME_DIR"
+        rm -rf "$IMMUTABLE_HOME_DIR/home"
+        mv ${ROOTFSDIR}/home "$IMMUTABLE_HOME_DIR/"
+
+        # as the rootfs is read-only we need to create the link
+        # between /var/home and /home during creation.
+        ln -s var/home ${IMAGE_ROOTFS}/home
+        mkdir -p ${IMAGE_ROOTFS}/var/home
+EOSUDO
 }
 
 RO_ROOTFS_EXCLUDE_DIRS ??= ""
-- 
2.51.0

