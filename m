Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A15AC83F1A
	for <webhook@archiver.kernel.org>; Fri, 11 Jul 2025 04:46:35 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.6])
 by mx.groups.io with SMTP id smtpd.web10.6551.1752209184852610052
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Jul 2025 21:46:26 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=HHBPn7FM;
 spf=pass (domain: siemens.com, ip: 52.101.70.6, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wer6lCLj6LFSaAVZhKYXOhyU7A3vm3GhV4wGCP1vu9ZaVmzRdF8t4bxnDNGZSQm90dufG4MnM3tkiMGQAVoMhX4WM7n57jnaY0sRNM/eMH0pz3IYV4HCRll+CZPsf5mYcIBrdsRs3DIShUe2ShEf6C33zyZ91oy/+TZ3ea+c76dJfnIlzoc3rTDTjVviWYe2395CTau7XVB/RStT18GLt2CXSvfry7poqjo6PzYAHjHGWxl7ZQFZiVH1zEc2xa2o6xt7cDOAzq2e2wwbWAUyQBy/1uYtYUlMRMa1S3OWt9LJO9BO2A3+UHYmZkbPEg0khnCW4nxR7nQVQLxX9L6+4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1BeJD3yiORcg1WAKRxTfnX/1CJWGQ1EqD/tQfSKN/Ys=;
 b=ABbTtlbjOkXAS60YWPPgxlziDjZ9ueYVNb8WHfGw4vO+hJF47na6Kvh/z+BK7zabp/QS7DUz98bWW51MHw2lFZSWnScJZupUylvi8c/gPUbATQ7Dj4MWBGiw0iSWGLBH7g/dEwBVkVUaS+ukTsVWW+hmHqKW79M1eG7FX9gBsGBF5bIs7Vxy6EgyzNLE+UPov+Px2RCJ5HgocPOYpSRca2SyVfKn7o4awOxmfajK5a6DrchV00gMvvlNp5vMuNtRKsUHP4b13RL095ByFXvcOnqWi7Vi8x0HZ3DgioheaKn7vafkuDrED1GJBjlHNZ/kiV5dgTKfUFfSuUXTrlaRXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1BeJD3yiORcg1WAKRxTfnX/1CJWGQ1EqD/tQfSKN/Ys=;
 b=HHBPn7FMCOLJQZKNVqK/6pB/2GP7C1BcMQ/MjKueSZoeZqauLjGt4DaSdudwx/y4wrzyuU0T+qr+ZkQcdvuXHHNpFVctx9q9xlVcvjff/wBCdRimM9G8Z+BhuqX0Bsq1D5IRMVCFNodfGTcmqDWD1W5GZNAo3/8gBP1TZQlKzJ292IbvtoTWTnEHxRvj/RU3tdc5DQ3mMmwM04yYWykodbQBUHScItKedcA2YL69ivtS3UF8IjXfKes13IvT1GNe5hCz1Uvo2UR+VrCE251xZwhZAN3UDbUg6UAGUH/JOXjev+IjAsgPx3oODx22uprUoty6x4iz2Zc8kQUgsKPAFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7912.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 04:46:22 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.8922.023; Fri, 11 Jul 2025
 04:46:22 +0000
Message-ID: <90db1d9c-4d89-4d92-8373-6e95f6db0b92@siemens.com>
Date: Fri, 11 Jul 2025 06:46:21 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] linux-cip: Update to 6.1.141-cip43-rt23 and
 6.12.36-cip4
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0432.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7912:EE_
X-MS-Office365-Filtering-Correlation-Id: c4c7b0ca-1387-403e-f2ab-08ddc035e24e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cVBMeXdzL09EWW9CM0F1T0ppZjBxQjNpRXJmdUpwa0tTMytqTy9nVmZlQU8z?=
 =?utf-8?B?akhGeWNIVnRKMmRodktNSGtnSTJKajJQOU5KVnBNMXJpNjRaOGNZc2FnRVZG?=
 =?utf-8?B?S0llYmJHNnpsWHY2UFNFcWl5UGx2SUE1ZE8wRXdPTkdYRG1udlJJK21DYjZs?=
 =?utf-8?B?MjRNRXNQcHZXQ0hpeHhINVVBNEJSUFBGcTBMUDhXM0U0QlFaZmhKQ1lEaFVS?=
 =?utf-8?B?dy9qYjdReEFFVVgrbEI5ZzI1ZXhnbm9RK3dWTHIrTUdsTXNnZTltL2xycWFs?=
 =?utf-8?B?K1hUWlM2ZDFMTjRZZ2VvbzhJbytZWEVGRnBTcTRrVzFFR0I4NkF4Vm83Q0lr?=
 =?utf-8?B?cXdjNEsrc0loN0ZFdnlpcUVtM1F2bk8ySk5SdHFtMm4xMUtXSWxkeXBDcGhw?=
 =?utf-8?B?aTdNZUx0bGYxeE03djVSekJlZGxpRGw1STBtWG9ZTmxyWUIzZUtEQ3BkSjFL?=
 =?utf-8?B?VUtHZ1FVWDZHWk1sbW1QUzFYU3ZZcUE0ZnFMSmIvdVkrK2VmWElmZG5KT3Q4?=
 =?utf-8?B?YkNERXorZVFQVno5UFZtYUc5QnlDZkpNcE5MWnlNTjZwcEVKYlVyekRBNDVP?=
 =?utf-8?B?V3lIN2xZSGwzQXNSc3ZueFlRN1FkTEZJRjFkbE1xMjdDYjkyZjg5U1VzWmtW?=
 =?utf-8?B?Z01jSVVXS3p0S05JYlhRUUZMVFFvdFVIN1lpcmRRMVlqWXR5Nm9pbGR0Q2RC?=
 =?utf-8?B?YU5tTW4rVXpXRU1rTXpqNmRmeDNVcGZrN0EzeitKMElzR0JzQ002b3JiT2pE?=
 =?utf-8?B?Ykt2WXVRL1FXQ3ZwM2Myam8xeVI1bVEyMGo3QnBMVkdMMVA1T1BpczYxZW9U?=
 =?utf-8?B?MTZzTTc4VUpTRi9OUC9GMGxtNnBZSUhSK2M4RWx4Vi9kTlRVMVhad0pETUJE?=
 =?utf-8?B?d2xwY1ZYMlVOeE5YYjNXREFYMFp3S1pCeDROb3lkTDdtVndpTkJmVG5KL3Vx?=
 =?utf-8?B?MERvcXEwZkoxNjVwZFZDZlpiaURneGxXN1hpL09CcTZnWnllUDlpN05PL0w1?=
 =?utf-8?B?bUtXcmZpMHVYTG1ibStNaG9tbGI3akFLdWRPMzRSYW14YW1oblpCQ2podlJn?=
 =?utf-8?B?SThKRm9TNWUzTnZlVTlON0o1a0JJQlFUQlVxTHRkYmxxT1ljdWZPRXRKdXhJ?=
 =?utf-8?B?cjRuUWtPSm5OMkdyb1lkTXlYdlRhZEdkSmdUVlU3MmE1alZsN2lWY1Vkd2kx?=
 =?utf-8?B?S0tpMzZDUUxiUkk2NFVrWG9mUFVuakdONzUvMHk3MUxhOWZJRFo5L3lOZWsx?=
 =?utf-8?B?b0lqMjZhZFdFVC9kNjJkODhNSDRWZVdMd2EwallMeG4zckhRR2l4cTNRTFJy?=
 =?utf-8?B?bnBHY2M2dU1yL0JxSkIzN1BPOFczVlZRMXpGWExOSThRZGNLMkRMblB6V2ZY?=
 =?utf-8?B?d2Q2YjdMVGxaaTVGeS9qRGtHSHpwSk14N1V5ODNlRzVTeUI1VkpEZXdRQ2lO?=
 =?utf-8?B?a21tN29WOXYya0NsYlNNOTFMWmRlWE9pMFFBaDNXU3F3QlhOLzEzdk1oSUtB?=
 =?utf-8?B?blUvSzFYSHIzTkM2dkN3VTl3dDAwakw4d3cvcXZBZkdQSjR5SlN4VnBGajY3?=
 =?utf-8?B?SlFjVWtadUw2WFJkWktLd3NTYWw3cWU1WWtPMHpzWFlkd1o5d2dKOGszankx?=
 =?utf-8?B?WENQM3gzRVB1YjVlODc3OGpwR1dBQnpLdGxRVU5FcHFYMGlDU1FVMzVsejNk?=
 =?utf-8?B?UWExZmFzaDlVTU5DbDNlbTNZYXByOVdnUUlXOW9ySFVJMnNQZDhDMjVPYXRH?=
 =?utf-8?B?KzBucGZOcitRZW9WQ0NsaEZCalV2dVRCTW4xSjlsTHNVTC9ieHdxNGRRelRq?=
 =?utf-8?B?ZGIrcU9EVngwVVlmaWR2bnNKNVUxOWFMcVp4Ty9uVXRsTHBOdzVWQk4rampp?=
 =?utf-8?B?UDB4R2tMN2VrNnBwWGlPOTh0UFFHWk1KeXRJemg2WWpIaG5CdkVKdUJoMzJP?=
 =?utf-8?Q?kEsixiyUze0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q0d5Nk1wVEI2eWNmM1I0RUFMTWlUYWk3YVRPcU9aL05rSjRlRUY1dlhyM2Q2?=
 =?utf-8?B?V2FXUDU4aUdKazhiUzFDSmcrbVJSUENyK2x2VVZxVytRNUJXU0JHTS9uUzFr?=
 =?utf-8?B?K1FLT0ZzNDRuandKSk1DblNXL3ZQT2xLV1JiRHhobTBFYUY4czZKTmEzb091?=
 =?utf-8?B?WGZDam1NTTZlUVkzUmtkSmQvaVFsa3JMbVVnQUkxZVZuY1dmUzdsZDNneEla?=
 =?utf-8?B?QkNTT2Nscng3ejJnKzBOOGN3TTVkYzBOcWdUU3A0cjRKa2xvYk5rd2RtVWha?=
 =?utf-8?B?bXlJWW50Qk9tMXNGV1RVeWtVdzdsVkRnTWVUaHUzckh4RXM1d0pLVmx6VHBK?=
 =?utf-8?B?K0kveDJKeXVkN3BabFhsaEpmR2JsOSt3bW81SlF4dlZ0Tkc1UHB0enVTVDRC?=
 =?utf-8?B?a3EwcS9YU0grYXFoWWkrVXpid2dHWWtaRExiV1J1Yk5PREp1TENTdDRwQ24r?=
 =?utf-8?B?Y2JhZHFQeE5YckZZUFF4RjQvYWIrb2xYSmtnLyt1QkRJZVp0U3pRTHFZaDJy?=
 =?utf-8?B?NDNVRzBGTjV0MUVnVDVGQ21mT3p0b3g5cWZKaElYeVBCbkhXVmpwYmg0YVBv?=
 =?utf-8?B?bmdzVDRUM09vSTdJTXJxYzRtK0FBd1g2NXJxczQyaHBmQ0NFclJhRDNJRm8x?=
 =?utf-8?B?aDNYL201YlFhYUZGbi9ONjZIZ1MwbXdvUTU0Kzc5bmRkdE93YnI4amxNTzMr?=
 =?utf-8?B?R2p1R2tJSWdyQnhuTXd3TWkzQ1g5Ny83WHFPbGhWanVONlNLZGdaSHZib3Qz?=
 =?utf-8?B?TUJWKzZ1TS9OUkxMY2NkNEtzMDZRUU1yZVpyL0JKVzc0UUIyV1B6elNFbHpi?=
 =?utf-8?B?SUhGUlIveUZDR2haektnbzVFbUEvZGNYbEY0b1ZTWWpvTVZZeG83S1owOWtT?=
 =?utf-8?B?bDFGRnY0N0pzSGx3aUhqVlFOQXhMMVR5ZGdnckxOTDFsUTBGM3BjOWhWMW5N?=
 =?utf-8?B?OTFTazR0UVNxWXRXRlFJb2FraStKUjdyQWZzNlV3U2t2eXphM1ExeHpTalNE?=
 =?utf-8?B?ME5BUWJibVZNY1ZZNFg5OFpKK1lXZ2RMOEdxSDZnb0tqeHhKVTFNdWpJbmpn?=
 =?utf-8?B?MVBvakE0aENPYWtiR0NOS3NaU2RHUk1sajRGaDlVUXNuYWl4cXhQZThXMnNq?=
 =?utf-8?B?UVZUckxPM0tpNVgxUG05ZC9oNXc5ZnY3U3hmdEpEcC8ydEJSbFB6S2VsL05V?=
 =?utf-8?B?b2E2elVlTTJiNmhCSE9VWFBhS1J6dUNLMXBpSzkrUUpFODBsZ3d1c0JPdjNp?=
 =?utf-8?B?TDhRcVZOSkhGS3R6MFF6d0UvS2ZwNENJWlN3ZWtGcFpiMVVjc2hJTjhVNEJM?=
 =?utf-8?B?R3lCM3czN2VlbDBiVm1ITjZaTlFrVTF3YVYra0wyWXYyUDdCTjJRQTB1UFZy?=
 =?utf-8?B?aEl4VlNBRGpJQ1hCeVRmaDZMcTJJbWVvOXlVTDl3dXFhR0lqaGU2T2o0UDZM?=
 =?utf-8?B?MzRnWmdobEp0TWY5WmFKNWpEelMyZ0t2N2xqeFBLMXduNGpKNjNHUTVMT2ZD?=
 =?utf-8?B?RDFkWkxYUTRTU3FxTHBSTWhlTk9KRC84eDVjSXRQYVpwYnhDaUpLVW45aUk2?=
 =?utf-8?B?YVlEODFuakJmdWJHVjI5eWt1emx5OXdwUFdpU2FoSk5YbXZLTEhIdTltbWFx?=
 =?utf-8?B?ZzBJYnJyR1hYdWZZbFhjc1ZjaUpRdlhkQ2VBTEI0SFBQMWI1YU5iMmxUdFNp?=
 =?utf-8?B?aHV5d0ZTT0JWOGtXVmRNTTFmUnRYTEVLOWpvSm9yVWQ4NndaYTRka1psRjFz?=
 =?utf-8?B?dkV0NVBEWk9UaXkrTW85bVMwZmVBczh4RHE3RVl5L2ZoVmY4RVJiNVRJTkFq?=
 =?utf-8?B?emVWVzRCaE9LK1l6WXltc2JQK0tBR01QelZ0MHNDSDVhdnVmK2cxeGo5ZlM0?=
 =?utf-8?B?Z0tVVkgrQVRoUUJwcUJQOUJDR3JjTmJZMC9LOTdoWFE0Q2w1Q3dncHFySFUz?=
 =?utf-8?B?SWQ1WnRJeXpqZGVCWmdoUHBTTEpxTnRHVlREYkoybDRWM2VEMlhzVmJxUzh6?=
 =?utf-8?B?L3VFbWhvYkdlYW4xb3NDNHlraWVzN2tpMlpxYlc1R2h0bEdRVmdpYkF1Z3do?=
 =?utf-8?B?UmRmckVON01pOEdTQmlBZ2twY3FiQUdaVDVuZ2didXg5elNKWUZ5SE03RC8x?=
 =?utf-8?Q?u5ajEUlX/2nYqFeP1RUsdThKS?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4c7b0ca-1387-403e-f2ab-08ddc035e24e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:46:22.0917
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hd3BpzFJxinOynmnJo6jcooFWx2XXA/Z+YIv9LbbbiDJvd4OjcfuGefsuxQKime4rjlo30r6zNGQ5hZVY6KTog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7912
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Jul 2025 04:46:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19395

From: Jan Kiszka <jan.kiszka@siemens.com>

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 ...6.1.134-cip41-rt22.bb => linux-cip-rt_6.1.141-cip43-rt23.bb} | 2 +-
 recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb               | 1 -
 recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb               | 1 +
 .../{linux-cip_6.12.34-cip3.bb => linux-cip_6.12.36-cip4.bb}    | 2 +-
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename recipes-kernel/linux/{linux-cip-rt_6.1.134-cip41-rt22.bb => linux-cip-rt_6.1.141-cip43-rt23.bb} (59%)
 delete mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
 create mode 120000 recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
 rename recipes-kernel/linux/{linux-cip_6.12.34-cip3.bb => linux-cip_6.12.36-cip4.bb} (59%)

diff --git a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb b/recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
rename to recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb
index f4cc8d2a..0dbe34be 100644
--- a/recipes-kernel/linux/linux-cip-rt_6.1.134-cip41-rt22.bb
+++ b/recipes-kernel/linux/linux-cip-rt_6.1.141-cip43-rt23.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "8582da7b30925237cf4905988aefe0a8de23bb4e7546e6ebb998419ee121fa7e"
+SRC_URI[sha256sum] = "41eaf5a2f74b849626659246e868bf4b2d570b4e26e395eddc48258a787d2724"
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb b/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
deleted file mode 120000
index 86637754..00000000
--- a/recipes-kernel/linux/linux-cip-rt_6.12.34-cip3.bb
+++ /dev/null
@@ -1 +0,0 @@
-linux-cip_6.12.34-cip3.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb b/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
new file mode 120000
index 00000000..95381382
--- /dev/null
+++ b/recipes-kernel/linux/linux-cip-rt_6.12.36-cip4.bb
@@ -0,0 +1 @@
+linux-cip_6.12.36-cip4.bb
\ No newline at end of file
diff --git a/recipes-kernel/linux/linux-cip_6.12.34-cip3.bb b/recipes-kernel/linux/linux-cip_6.12.36-cip4.bb
similarity index 59%
rename from recipes-kernel/linux/linux-cip_6.12.34-cip3.bb
rename to recipes-kernel/linux/linux-cip_6.12.36-cip4.bb
index 81a0d4cd..387994a2 100644
--- a/recipes-kernel/linux/linux-cip_6.12.34-cip3.bb
+++ b/recipes-kernel/linux/linux-cip_6.12.36-cip4.bb
@@ -7,4 +7,4 @@
 
 require linux-cip-release.inc
 
-SRC_URI[sha256sum] = "7d4aa1af336bf2044514ca90177c690afd3117bb567ac9f048c6ba18341220f9"
+SRC_URI[sha256sum] = "1959ac4de3f63bed87332dad655b8b76be0a8295e8a3c04216ae8f4562fd0bb6"
-- 
2.43.0

