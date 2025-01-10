Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC124E7719C
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 06:29:27 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.86])
 by mx.groups.io with SMTP id smtpd.web11.13129.1736490554524246581
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Jan 2025 22:29:14 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=h+kEsFX3;
 spf=pass (domain: siemens.com, ip: 40.107.104.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2PQ/ipjU3DB18Njahry71YJQ6PXeEvw0YL84UoEGGlD3KdeJepBo4TDbULCOiKdOCWjI03Nuva1kjStpX4HeK/+/vw89lewnXhP/LV+qQW54wT35TdZ93SdWT8h8ZzUsT9PYZ6/7l1W47if1u7oPXTyZ0LRCc5wPaJK42liBgT/SYtqdfwkP21SKs/pkMUAmIpRh50gcMWJhwjysARpoXgnLtDsqkvL+QYjfAbLchY3ScYo8AaZ4j0griBydPoB4V5w4yVUtVeoIQXYgCE9WvfeNWLJRzon8PnS9xifCBqGD2xVBdgmWljhPvSS5VeUOo9/Fbdbc7ZR2voEPGDNpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roXOcA05+S8DHQ3H8Jne2OB0FrVUhuxZvEP8CFfHNMQ=;
 b=b1CAjdhXwJkBAMah3FGQUjTBci6jDdlwh550f/ybrJM2+3pPkhlAA4fGYQkFfpXKSoUwE0PvUrbuSaufFgB4klOz24Ye0UzQaobP5xH3tG1qzR5H/vAQqv+vOpGnYHb7YrTYqGi6vBsl0NddjCJ8IRlB4JjVp9yPKwMh/p7ybK40O7nFagGxEcUGQxvxkvBmg027lr356YwzRUCXzBc2LHg0aaUvKeztu5G16tjsQSMrdcO06m6TiAU1n0PDnzJ49FzESDkoVuVnpavd/zWiD6rxOFg14EIPaTI/jlfE1gGdpIqRAlbG+eNzFQgvubOqo8RbTn5DOmzLc1Ru+wgKUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roXOcA05+S8DHQ3H8Jne2OB0FrVUhuxZvEP8CFfHNMQ=;
 b=h+kEsFX3CApyK1mc1z09WXnXZ8+kWl4nzhtamGQaJkDZ6b3BLsaBg52ymr8JGbRdS47Yhc7jKmuFQldrTeefhlWUG25QxJoSIwlCbNE9HctGZVCjvSnzdUANjgMSVFiqAo/0eD26BHVhumH17+8yIMr8EXx/RMI3uofs2xUgFLeSF6ur5FuOP0nAsDPVHViy5KzW7AYMZMl5GoJrKHSY0xmURWm49h0LMG14wqBF6SKoCk6YsmWciokKhe49iCsPZVHi9Y0N8HxSL6Dp0+iyovXk7ZncCBM64zcHIfX6gt7oqJTRkFhh1ruOYNr5fcDjhXnAH7LciQJ6ySk5MsW6jg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DU4PR10MB8950.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:564::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 06:29:11 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 06:29:11 +0000
Message-ID: <cb7a71ce-1922-40a5-a2ac-8947585f85f4@siemens.com>
Date: Fri, 10 Jan 2025 07:29:09 +0100
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH] ci: Disable currently broken deployment to
 KernelCI
Content-Language: en-US
Cc: Arisu Tachibana <arisu.tachibana@miraclelinux.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0024.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::16) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DU4PR10MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: fe184a42-de96-461e-fc7b-08dd31401832
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RExldTlMS0tzWkRPZ2FvVlEyMjBlMCswcFdhdkREM01kbG12QnhXRE01ajY3?=
 =?utf-8?B?Ulh0Vy9jVEY5a3RRYmprMkpDSzVNK3NkakZqY3JyQkF1bG9RSWwvRStWUmc0?=
 =?utf-8?B?TnVPd0k3L3RWb2ZPZVVGYnFWNjdKUVBzQmVoZ3dSYkxiSW5OU2N0N3FuS0VT?=
 =?utf-8?B?TkR0Wng0alNFSW5IVUVHNmRUUVdTOC9NTFUycms2YUJIa0NRSHg3WUZiM3No?=
 =?utf-8?B?N01jWVhzUGYvTnpQOUN6NE96RTBDNEhwWTA4K3E4K0dmbEw0OXFOQmZ0RVpy?=
 =?utf-8?B?UUtHVlFyVnBIcXpFWnpuTEJ4azE4WGdkbW5kd3JSbnVGM0tXSXFOeldTTGJW?=
 =?utf-8?B?cElHVk5NM3RHUDh1c2JZVFF5M3lOeGJ1NFQzd3RWTEJBKzlWWlFxc2FRQkVD?=
 =?utf-8?B?Mk5rbmdJZWw3S01jUUIrSEVrRmpmV1dyNElQR0FGVDUxTkpONFpSMjZoaW5B?=
 =?utf-8?B?MXJRL1ZYcnZmSElEVlJDVUhEVCtJdlBmRG1QeU1XS3k2VFkxSmNRREJTZ2JT?=
 =?utf-8?B?dVNoZ281TTM2VDRnSlIvU09CYk1iM1VYMVpkbWhWOCt6Ykc1bURzTnNyMlg1?=
 =?utf-8?B?OCtKeGYvVWFiQzQ1dzN3TmhHczhZaXZaWUFKekRQa1BsSnRzWVlLRHE0TG5X?=
 =?utf-8?B?aUYrRndJMDNxRkxtVnc3dENqRzVVMGRDSzBjdm1iaHFhN1EyY1ZaYTNXanJH?=
 =?utf-8?B?WTlBeGhpSjN4czd6aHFuekxTaDdhSThmdVF1azN3ZlJITk1DSk50dUg2K2Ra?=
 =?utf-8?B?SVgzODlhTjFIN05KY2t3bFhKRnh3WTEvOVNYUVV1K2V1bkFZY1hSU2RXNGpC?=
 =?utf-8?B?MWNOczUxN0djUFdUaFVyaHZEenkrZ0pQZ0dxbDU4UEE0SnFhcS90OXpnWjBo?=
 =?utf-8?B?TXl4dyt3RnBWMFI4SVg2ZTJEV25IQU0rSHI3dXJjcDU4Z2NSdTk5dzd6NW5m?=
 =?utf-8?B?WmdRVjIvVmsvcG9iQ0ZHYTZJM2ZqNi9OcEVUVFNOQzRIeTluRWtNQzRJQ0Yw?=
 =?utf-8?B?bTEvQlltL29HT2dyeEJDZnU0eUJhYnJNNTVlWlVDY085WGdMNXJxVUZmOFh3?=
 =?utf-8?B?SlB4aVJVL054eFRQUmxGYTJGRnJHVUIvNWJIVlluRFdUbTliQ0hIZWtNcXJn?=
 =?utf-8?B?UFVneHFPYXh2bUlRMUFvZ0tSM3JjY2w0UTFuRmR0Nll2QjNOS2ovSlNpMm8x?=
 =?utf-8?B?dkNhaXlVVW5aNGp6ZUpIYldtYlF5ZWdreEQrcjN6bmpQZDVZek1SSnVWdmJF?=
 =?utf-8?B?WE9lbWtOb2RMKzVQcUNtQ3BoWHlEMDBWSnpCRWF4R1lXYW1HVFFVNnZTVGlJ?=
 =?utf-8?B?Y3pXL1FRdmlZTW1VblU5djBiTzZOTVZYN2hubVZZd1ZyajlNZlAyWnV6ZUlj?=
 =?utf-8?B?TzV4NllUSjBmaEtjKzltSWdLMzlTemV5NTY2V1BFV1Vab1IrVWRyaHpRSi9y?=
 =?utf-8?B?R3NUM2hPUHNEQWdQNllkWTVRTFl6eklnbGR0N2wvWTJDSEFjTWdIQmhEUUtF?=
 =?utf-8?B?NzdmcVBOamt5NDZJWXZRdVBBWUdGRTJRRGIyOEwxZ042N2dwcTJRMm5LMTRS?=
 =?utf-8?B?MW01Y0dxY2VwemdvLzlKTTV6VGZYVDNzeXg5VkxvcjFaQkZseGxtWnlZMEk3?=
 =?utf-8?B?TDgyNlhieDU3T0FCMXJZQ1NjTnEzNWw3UTVzckZrMEFCNlNtb3NxSmpxcUNq?=
 =?utf-8?B?M29xdk0rYlY2NmZ1aEJJRUF0VGZhSXFCRDBVSlR3d042QWk3eXA4aWFTNkNm?=
 =?utf-8?B?cXV1eVhYVzlBdkZNK3RLVmViREhLKzJHSm9oS01qSE1TWHZLZDZyQ0N1ZUlv?=
 =?utf-8?B?ZFhBTm1rRjYyaE9KaGJCaUh5Um5Zak1sbU9jU0ZFdjIrL3dqb29MRGo1MEYr?=
 =?utf-8?Q?dilepIbLWYaqN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Q2FXWFJNOUlKak54MlZUZS9aMnk2SzNUSDNBWGJBOEJkNW82UmowdElLTGpp?=
 =?utf-8?B?MlV4WlUyakkwckYrMW0vb09ob0NyS3FVaTFnTktRVS9aMzlSNitKVTdCZ3VK?=
 =?utf-8?B?ZDBxKzRWMlIzN252eEJET3R6VmtFajRPQU5rbGcvUlk0Tmc3VWx3cDZELzFt?=
 =?utf-8?B?aW9Zb3BCSHlqdnF4Y0RhdmpONGpuT1VFbDMxcGtnSDZnSGtqdHZ6RUtCOS9x?=
 =?utf-8?B?RkVpSHRodkI4Z1NHem1JUlgvZGVsQ0hKNzNvSnNMQnh0WjRGaEJIY0FzS1Iv?=
 =?utf-8?B?SElUcldLaDlKTDQxMy9DNk9xdCtXOHZmRDh2anVHMkpaMkp4S0tPL3hoMW5P?=
 =?utf-8?B?U2VZZ2dYY1ZnYnVXdWpGOWhzbVdnWGlBcW1NS1p6K0lrc0VyVnZzcFBoNzVv?=
 =?utf-8?B?ek9hK296ZGhReU5oaitOcDZiVUl0VXVLVlUrZjlRUGZEZ1Brdm5KcFpmZE0w?=
 =?utf-8?B?K2FJTUptMTlWUndJZW44dTR4U0tKVDBUdW9Tc1E3WDBEUjBaQmpteTNNRDBn?=
 =?utf-8?B?VGt5NlpJS0lUOXpVR0VEVUdvMVVycmMvbzVqc216TUc1KzlMdjd0dDd2K1F3?=
 =?utf-8?B?MEFJdGZMZkhsZ1owMGJCQ21MLy9iWjhxK3VycGp4OWsvU3RMWGlBcnM1YjJQ?=
 =?utf-8?B?aXJoNStBUkF4RTB1eWpNUEFUeVU5OUJJUXdVaVBaY1J4OE5yeGJQVFZwVnly?=
 =?utf-8?B?RnJWUENybW5kNVpqaTJaTUlWUStxb2tMODdGZGwrVGhrMGRUdVJpZWg1RGNE?=
 =?utf-8?B?REdRT0pCNy84akljSXF6TlRlL3FMcEFnQlNjaGF3Qnk3RmJ2SVFtQnkvZ0Ew?=
 =?utf-8?B?eVF1WUNDTGRUL1dMVVZ0ZWxIYXlXSnBYNkZ6UmZac0VMODg4WEdjd1k5cjBV?=
 =?utf-8?B?ZDBWWjE0cnFKZ3RqQVVBblFVYTRtcWhPV1dnUlJJTENWYUpqbktVbkprNDcx?=
 =?utf-8?B?SWhNYk1ib01BdFh4S2FZMmVUTGxnVkZSSVc0bG53RVdrZk43N3poSEkvSzdl?=
 =?utf-8?B?OTB2TjVadjR6aFEveEdieWV0Zjd3TkNTckpJa1NyN1FWSG1PVDQya0g1Vk13?=
 =?utf-8?B?VisveWFZeUpwS3V2WFhQNmwzQW55L3BsT0V3RU1vSFo4WHRGNmVPZS9RUi9n?=
 =?utf-8?B?KytyZE0wRGpyekZIWFZWRUN5SXRIeWpNdjdTMFlrQ0QwdGczSEtTTWx1MW9K?=
 =?utf-8?B?UlR4R2ZBM1RvWHVBOHlzN3hsSWVrOXprUUNaaURyZXhrNnFHclhRMEw4QXJr?=
 =?utf-8?B?OVp0NnRxSXNEQzZvbDZiZGgxNTdQTVNtZmFEVGk4cTlvWFJSa0xGeURMelRP?=
 =?utf-8?B?M1NpQ3dib1lnaGtXYlhCWEdWeUxWTXdaUVUwbks5OUY2eVdvS01HZmxpdXlS?=
 =?utf-8?B?MFdtaEx5THltWGViVC9NamhKZlNCYnA5Nzc2TlQ5cXFqRUo5cTA3YzlYZnRE?=
 =?utf-8?B?WXNjZ0VYdTlON2h3ZUhxbEE4WUZMQmtJQmRoVjBkb3NnMWl2WGk3QmIxTGNB?=
 =?utf-8?B?T2hCV1lCd09qdG1IbHJiVUhjWXMvYUJNLzhyV0J5dTZHVUhaRnFHWlhMNHdW?=
 =?utf-8?B?TUJvVTB6TERLaGl4bkdEaWtSamVRZVArSEZCTm55TllZQ3U1MEtmVnVFdDVD?=
 =?utf-8?B?RFZiVFFmVHBwR2JwQVFFOVlISndTRDgvOUhNWmN1ZG9lUGJHdzc1U1BOdFJq?=
 =?utf-8?B?cUp2UEdUQjRJc1FCZ3EvMEFpWkNqWTY0dGJsd1RUa3J3VFVBcXM1NU45Q3FX?=
 =?utf-8?B?eFlnWEVKL0VEYTMxZ1d0Y2trWkd2QVpVckhtVFlxRXQvU2U5MUo2NE5LeVBH?=
 =?utf-8?B?R1NqcXZIWmczVWQycUNHUzlldDJkeHZJeU1nQXd5b0V0ajNyVndtNFZkT1hS?=
 =?utf-8?B?QzJiNVU2enpodHlzREc2Y3ZIdUVlWVYydlRQbW9PQms1aDN4Nm96dHRqQnVa?=
 =?utf-8?B?SlRJUUc5RGFjb05qOXlpbUMzZXhsM2ErZ0FSa0JvekRURzJhb0VuMmdsbnZr?=
 =?utf-8?B?M0JSNSs1UDZLbzNhclVJcEJpaFdjbjFYWEJGSlNESU5YSEVqZy90akJlbUgw?=
 =?utf-8?B?bnpCcjFWcnE0SHdRZ2t1NUpZQitRYzdoMk5ubXZsb0VTQ0xvcVNqWWl1YU1k?=
 =?utf-8?B?c3g3eWRNT1F3UVo1SEhmd05pOW50SDI5eVk2SGRMdzlRV2duNnpXZ2RxU0Nj?=
 =?utf-8?B?VlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe184a42-de96-461e-fc7b-08dd31401832
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 06:29:11.1646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oQPUwMSew4c/vn38PJeo6Xgo+CVtMWtqahlMtwM5T2yWogDDMQrJzKqWql2H9NgAIomFifSlHquxhWZF8AwSMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8950
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 06:29:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17521

From: Jan Kiszka <jan.kiszka@siemens.com>

The upload API of KernelCI is being reworked and will only become
available again in some weeks. Using the new one then will likely
require further changes on our side. Let's simply disable deployment
until the new API is available.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 6f824102..d4bd283d 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -126,7 +126,7 @@ build:qemu-amd64-base-kernelci:
     extension: kernelci
     use_rt: disable
     deploy: disable
-    deploy_kernelci: enable
+    #deploy_kernelci: enable
 
 build:qemu-arm64-base:
   extends:
@@ -145,7 +145,7 @@ build:qemu-arm64-base-kernelci:
     extension: kernelci
     use_rt: disable
     deploy: disable
-    deploy_kernelci: enable
+    #deploy_kernelci: enable
 
 build:qemu-arm-base:
   extends:
@@ -164,7 +164,7 @@ build:qemu-arm-base-kernelci:
     extension: kernelci
     use_rt: disable
     deploy: disable
-    deploy_kernelci: enable
+    #deploy_kernelci: enable
 
 # test
 build:x86-uefi-test:
-- 
2.43.0

