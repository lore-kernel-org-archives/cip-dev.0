Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404BBCCF9F8
	for <webhook@archiver.kernel.org>; Wed, 12 Nov 2025 07:27:44 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.20])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8042.1762932453762386499
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Nov 2025 23:27:34 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=lEkB8PtJ;
 spf=pass (domain: siemens.com, ip: 40.107.130.20, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BA6Mp1y2TlKhO1CxEhP+wWah5spT3XbFYOW9kQAg9xEweYcQPbNczzK21RocHk0+XukO4030v8jKzUwu4o02fxjT0EmOM2JGkdDE+QhfdwhxTPpVRy68Er0bXzLpW1X0K9Y9s/XyZJqWUM8AdSeZ33EzNrIC6EGpPOlt1FfGAGehLO5bEKLOdDXabRV3J3z7Hz4R9J8qa4wPjEX9yWps7beRzmM8Skgqcu7vs7mFB65QF4bEll41zKf3viauBsUR5UpOyruM2GuzkBQ+KMeWq+mFbF6p9Ggzf3835PpovVOWw0eoXzWnIE/DjefVPMw5UnlnG5H3B1LOHih4BhN16Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8B79nwhQZt7beXjDM1UNjgpTuYsm72IBSGxtflOJdRc=;
 b=Lm7Wbpt5SbcUOy/W7QSoWgKKniFEdAMKFYZKRtstnjliXYvkVvWhYRl9uY4OmvCqF/YCso6mbHfVmLhPjWRmi4TvKzO5JybVQfZJGZaRwUN2DkcMBJM86t5mDKH3ojfoq4KnYXG2ArkMIAT/YzrDb3LaVg8jYjcnkt+IM2rAgoip8Hciby5UmaSY+dYOwCdYp9tZUpFNqIOrpBskNSS0+m6fIhyKeksrHcY7uVGejMfXbG6/fB/f6WChQEwxWT/L9eg2tbJ/BT0cYsW8BvNH24c/PeeUgnFpKQoSp2K2xuUKUQQG+NKyCkmgW5wBwWx3qQ5lRjbDWhgUjSrC7vsMTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8B79nwhQZt7beXjDM1UNjgpTuYsm72IBSGxtflOJdRc=;
 b=lEkB8PtJ5d6DcYNmiqeb9SUhdD2MV5WCpfNIwqUNcXLlarTb0UlKNMyp9j7v81OKFWz8lHecBWE+argh7Xo9ES2St9bvfHLtk21b8d1482iZasvBJWqxZWoyKRHh5Inu37QKPW7DOg810BP1ZAdeahzTKr4dxeiI0VPNqBsahF6VD43mMimK0VjA31XWRNoBau15EiWZYDiAKdSNWZC1z+GA03hXVg67PJPGA1ijbLw3sfPn8zisZC/XlY72LBmYOB1glW27IAj6o4e8eHhuAo8dxEHC2+B5LGuVhH0f3xycb3r3/kv3euprflpQ/5wJefee/hRgjeJ7ieCm2nM1+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8611.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 07:27:29 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 07:27:29 +0000
Message-ID: <f809b856-7fce-464f-8f99-f39f8211d179@siemens.com>
Date: Wed, 12 Nov 2025 08:27:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 4/5] ti-am62px-sk: Add support
 for secureboot
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251111164508.1707234-1-s-adivi@ti.com>
 <20251111164508.1707234-5-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251111164508.1707234-5-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8611:EE_
X-MS-Office365-Filtering-Correlation-Id: c97649ae-504b-4c7e-3d4c-08de21bcefe0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?YWFBblBaYzZCWS9NMGxLakpEYmVBc09pSEpTZEdkUlM3Z0RZZHdDa0ZWWWFa?=
 =?utf-8?B?Zk1GQlhGc2s0SmVCRWZWTGx1UDEzbXh4YUNyaXVVdG9ja0l2ZVRaUjJURmto?=
 =?utf-8?B?ZXAyaTByMjBnQnNmR2Z4VTRxMlZNQlVabW9VeEFSd285TUF2YkRBUFV3U1Qz?=
 =?utf-8?B?b2EwSTdQcUJPZWpWRVkwbHJIUnBwYyt4TEROWmtPRUpBbnZGenVZWnZBait6?=
 =?utf-8?B?Z3F5OFl2UW5DOHY4Ky9UaWUyOXdUWFBuUmlmUHFYMFhCZzBBa1p5aDlWTTdZ?=
 =?utf-8?B?cDZSTEVsc3dpc3VuUHlWUHFVSUlicHdFSmxIZ21pc21hUWlGRmkzQ3VqMVR2?=
 =?utf-8?B?a0xNOFVBM0dtNUZFWGZhUEFYUXFBNHJPREJqUGcvRytUQlcxdHM4Rjd4akJM?=
 =?utf-8?B?TXRPMmlLRzBOYzRnc2pXcWNITmpUbWxPOHlhT1h5V2x4ODhSUE1zRHJoYjBZ?=
 =?utf-8?B?TDg3MWFWdHhMaC9MUHZpYXRaU0xaSVcrMzh3YjlvdENrNlUxUnEzOUNEdzR5?=
 =?utf-8?B?eTFZa1luaW1ZZmNoVzlPR2dVQTdJYVhiUWNCem1LQUVXalN4aTY0S3pSSEpJ?=
 =?utf-8?B?N3RmZHV2T0dOMFhDQ2hpYmRqdHRBZGlCN0hyODFybUQ0MGdsalhORjVOTW9O?=
 =?utf-8?B?YjlBemoxK0VVVkN5VklWZU5tNTVVUDZKWTZQQ0wxVFBDdGhyenZOYkY5a2cv?=
 =?utf-8?B?ci8rbzZWeFU0Y0twMHJ1Z3Qwcit3U1Y2WDVSeWZ2RXhmbzZvSEhKeUUrRkt6?=
 =?utf-8?B?bnR1MU5SNVhIbEdrbFBwWHdiQ2diQmxPLzR6NU5XN3FpeENOc2RaZmZ4YmFT?=
 =?utf-8?B?OTgwRWRyWFZ5TmtwZ3dCMmt1M04rY3YyQjJ2NXRiL0N0YVd1YzRCNkFvQjlv?=
 =?utf-8?B?VU90WVp6cmxhVU8zNnRJb0cyZm13NDg3VDVidW4xVlFpdkt2QVB2TzltQWJ6?=
 =?utf-8?B?VzMzaVFETnIzLy9CZXpReEhHeS8zZmJQU3FvRnVpREZHQ1R6Q1p5S05qZWtB?=
 =?utf-8?B?NGJ3Ulp2RVZCcy9ucTRPTDFqNHBMKzkyUExEQ3c4THV2Zm5TSEZxa1pYc0lL?=
 =?utf-8?B?b1E0aHV0R1A1cFg3QTJlWGlKVGNqV1hFS1QvMkZmTG9NY2hnemZYNjF1Y295?=
 =?utf-8?B?ZlVPWk5tZGxXLzBkVVlrdEF3ODJlZHhVdGRaZWFPVjFuY3M5N3QyWk51L0lj?=
 =?utf-8?B?bERlSmU1RTdjL2pOT01GY3BXc1hucnpGY2ZJZW9vRHY2TFNvRlZFSW9kNDRl?=
 =?utf-8?B?YXBOVjByTDdyMEhwQ0tiMHRRNXNHZlpqL0puYjFWL3V4K2k2Ny9DdFoycU14?=
 =?utf-8?B?b3c0TGdWc3F2Um1CaDBsRFgzejMwMVEyOUtlN1hiS2V6TXZXTDdEVWxJaStE?=
 =?utf-8?B?ZEpXSFk3TFdQTWUyVmhlb0hkdW5kd0t6cVJQUGw3MzQzdVp4VXpqU2hyeWJN?=
 =?utf-8?B?TlI1MmhYbFJVZHdwZmRYRmpDYjV2MVNqdEJ1VjV2THFkcTJtL3pwaHhsdW1q?=
 =?utf-8?B?Zkx5NkNWOWVpTzlVOUwvTDhST055N0p0dzZVUUlvMUNQY3VRSnFoK3NiQkRm?=
 =?utf-8?B?WmxwOUZLNnVicW9xQzNCSGVEakhXdUFyYWpNZGo0WmJqTHVleS9qVitqbVV1?=
 =?utf-8?B?cHQxOUsva3N5elhvZk9xWW82amEzUzR1YkY0aFc2b2x0citodFBOL2xtOEtn?=
 =?utf-8?B?bnIya3JVZnFkVmVPMU5JT1hkSkNjR09waG1HaDZoZVdBODZEL0JDS0prL0E4?=
 =?utf-8?B?VFhiYXh0NVVMMGJFWEY0U3JSaDBoOEF1N1ppYnpZY1R5akY3TUY2UkVCTlNP?=
 =?utf-8?B?elJBK1M1QSsxUHRSNTRjMnZuRjR0aFJ2SVd1cHR5enhBdUo1bWRuMnJwUUI2?=
 =?utf-8?B?MmRKVVpHTWU1a1FIdWVCYVFERElPQ0JOZU5hNE9MYklhQmdacGhFVzdueTFQ?=
 =?utf-8?Q?W+DiMcEi2wgG2fvFrM5So2eYkd5zztig?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VmZ6S3k5bGQwREpCc1VoWG50S1VzNERWV0ZEdEpwZ2ZTTStjK2NLRWhsMGJO?=
 =?utf-8?B?emtJaDZFRWpHdEs5VWdKU0F4blVKYXNpTDNOejE3cDRmc2U2R3dscUtjeDBB?=
 =?utf-8?B?SHZwZE14bkdOQ2FFcGxzMytNSGR3TXE5dWdiclVzcTFlSFNsOHl2dFF0SkJa?=
 =?utf-8?B?QjJHMGIrdFJ2SzQxeUNlYm1LLytlM2VDZDRETGN5ckRMbzVxaXROU1FxQ3Rk?=
 =?utf-8?B?N3JmTk1nU1hhdTlVNXdKZTNGYVNJckJtV2Foek1tRlVObkxXWFpBdGJ0T1JV?=
 =?utf-8?B?TlZTWktLcEEyWE1XMEM2QkI4a1lmRE5VNkhVS3l2NlRiR3pETXhjWUhFOHp3?=
 =?utf-8?B?alJJSHdsNUZLR3dRUVFyZzV3SDEyZjUycGlhYWtWbUF5VUVEdGUvOTNESmRv?=
 =?utf-8?B?RCtvRGJ4Yk1ZWGhBcTdmWDdaQU5jTU9ZbGNYSFBkajR0YjBSSkcyS1NTNTZv?=
 =?utf-8?B?dk8yK0N1dlBVQzQ3WGU0aVd2NkpJMGNJZU5MTlY3Zi9QQUFqVmNNVWcrSG9L?=
 =?utf-8?B?ZzhJK3A0RGJkNytjcFZMZTdOYks1SkRjUFhlUVhYRkpXS09IR3FaZGxzckdH?=
 =?utf-8?B?cDFqRUlkV3NkaUQ5OTlmeEdlM2cwOXQ0dUtMYjRaYndtaHp6THgvbkZ6eFFM?=
 =?utf-8?B?bTZFOE1qRE1pUy8xOU91UWovS1RzelFiK2RWRmhEazFJZVhGMjFGMzBYT2lY?=
 =?utf-8?B?ZWxZYmtKZ2lNRGM4WlRXR2YzWlZNd01oODZnR1REbEEwM3pOSG56K3I4UVpX?=
 =?utf-8?B?Mk8ya3I4Y2R1bDhxSmJ2Y0N3MVRDUzEyNzg1M3dpZG5JdDV2b09kQlFCNEd6?=
 =?utf-8?B?Sng0dkhqWENoemFJbDRCSWd5TWhHZXZQeGRLR1VnTXl5Q2NWZzFjeXRIQmhz?=
 =?utf-8?B?Y1h2SVBTdjV0anByL1EzQWJPWHY5TmdtQmk5dHNlYmxaSFpMd1QreXU4VUh3?=
 =?utf-8?B?WkxnZ0xGM29BMUxkZ3pWMU9mMDNObVdISSt2VUp0aVByODNoU29xdDdONjQr?=
 =?utf-8?B?eGFBZ08valEyZWphamdOUmhCbFFsUHpQdkswakQrQnlqVFFGZVduQjZYbWt1?=
 =?utf-8?B?cVA0U2lQdXJYZDVIRHNUUHMzd3BLVGU2UmtINnQvQXpXY3pRUWZtSS9GdVRl?=
 =?utf-8?B?alVNS1JGU2Q4VXlvUHJDbVY0RmJkZUVqUXhtaDVON09WMDJnN3IyYVJWemlq?=
 =?utf-8?B?cVh4WnpiT1Q4SFF2KzZxZEhMbFRqVmdyT3NzeTZLYU1OSTZhSGZlWmRhQzFJ?=
 =?utf-8?B?REExa1FkUW5kMGk0enJHZUJvMFBWTDMrZjVpTTBTSGdpMFZQN1pLdzBUVVY5?=
 =?utf-8?B?ZHB3cHkrVDVaNnFRQkpGTWp0Q3lSbVpSSWNKYy9RS0VOYnFBQUJHVnBUYTdV?=
 =?utf-8?B?T0xtRE5mQVhiOUF2L1R0eGdpRkdxUHN0TVdDQmQ0RmZCRWxVK1pyRytPL1JC?=
 =?utf-8?B?a2kxMklkT3JtWlkybWhwZSt0K2VwYlo0U08rdzVwcWJWNERkbTN2U3lKOCth?=
 =?utf-8?B?YU82V2t2TzVCZWtjWmZKZExMUzJkeUp3WVFwbXNCL2xDM056VFlDUG5iMVMr?=
 =?utf-8?B?T3hkTzR3OCswcGQ4L25jMHo5aER5eEJBck9mZlJnUEhaRytrRmhSOGM5SjJK?=
 =?utf-8?B?WVJxald5cmtVVEh2RmFsY3BhbTJGZSszeU53VG9WbmE5VlZ5cGlxNWJ1aWVw?=
 =?utf-8?B?dStBYXdPNEhWVUYrSU4xeHMzbDdMODZlalR0bUF0NGY5MHlsS0V2SjJpQm05?=
 =?utf-8?B?c0pxQ3NOWit5aDRGbzlKdXo5RHlxbExOWE1VRU45N1h2VlFaUnROY3d4SlRk?=
 =?utf-8?B?YSthUnE2azk2aEpwdFFrcFBlUUhaRUNuZ3RxM1R4NHpQZFl0VGF2OVVrdlN3?=
 =?utf-8?B?TjZWVFRYYkcxTHFWcU02YndxYXZKOGJYeUh0Tlh5dmNYdWpWQkk5cGZ0NFlS?=
 =?utf-8?B?SnhhU081NmQvL3JxWnl0UDRpTFh1dlJNWVMvMHlqK0dUUEswM3pzUXh4Y0U4?=
 =?utf-8?B?ckpEQUlKWGpjUWpDUnBHVGdYaDRpR2NSY3BSb3RKam5sVXRESnVxaGZ1TGdC?=
 =?utf-8?B?ZGVEMS9ReEM2eDdSaUdqdm83RE1lSC8rZmJNSnNpZTg2aS9DVGlJMHAwZTlj?=
 =?utf-8?B?cUY5MEp2blQxNG5CeEZITGdFQy9hWXZkOHltSk4vWkw0eGk4VHNNREN5cG1z?=
 =?utf-8?B?UVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c97649ae-504b-4c7e-3d4c-08de21bcefe0
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:27:29.6966
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pg7fNuDgHS0mPbK7Gl6KNBOHtItMGVpOxwEwcd+UmF4xfMZHVUgUnVJSOZrkfvL60QReeBZWCTCWIyOKuMZ2ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 12 Nov 2025 07:27:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20512

On 11.11.25 17:45, Sai Sree Kartheek Adivi wrote:
> - Update u-boot rules to prepare secureboot vars
> - Add wks file for use with secureboot
> - Update Kconfig to enable secureboot
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  1 +
>  recipes-bsp/u-boot/files/rules-ti.tmpl        | 16 +++++++++++++
>  ...i-am62px-sk-efibootguard-secureboot.wks.in | 23 +++++++++++++++++++
>  3 files changed, 40 insertions(+)
>  create mode 100644 wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> 
> diff --git a/Kconfig b/Kconfig
> index adacf6a..3fd1efe 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -112,6 +112,7 @@ config TARGET_TI_AM62PX_SK
>  	bool "Texas Instruments AM62Px SK"
>  	select ARCH_ARM64
>  	select HAS_SWUPDATE
> +	select HAS_SECURE_BOOT
>  
>  endchoice
>  
> diff --git a/recipes-bsp/u-boot/files/rules-ti.tmpl b/recipes-bsp/u-boot/files/rules-ti.tmpl
> index 58e954f..26665eb 100644
> --- a/recipes-bsp/u-boot/files/rules-ti.tmpl
> +++ b/recipes-bsp/u-boot/files/rules-ti.tmpl
> @@ -12,6 +12,22 @@ SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
>  endif
>  
>  override_dh_auto_build:
> +	if [ -e /usr/share/secure-boot-secrets/secure-boot.pem ]; then \
> +		openssl x509 -in /usr/share/secure-boot-secrets/secure-boot.pem -out secure-boot.der -outform der; \
> +		rm -f secure-boot.esl; \
> +		\
> +		if [ -x /usr/bin/efisecdb ]; then \
> +			efisecdb -g 32db313c-f7d4-42a6-9a49-e32870001c63 -a -c secure-boot.der -o secure-boot.esl; \
> +		else \
> +			efisiglist -a -c secure-boot.der -o secure-boot.esl; \
> +		fi; \
> +		\
> +		rm -f ubootefi.var; \
> +		tools/efivar.py set -i ubootefi.var -n PK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n KEK -d secure-boot.esl -t file; \
> +		tools/efivar.py set -i ubootefi.var -n db -d secure-boot.esl -t file; \
> +	fi

This is only needed if there is no StMM support available. I think your
target always fulfills the requirements for that, doesn't it? If so, I
think we can skip static UEFI keys.

> +
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm ${U_BOOT_R5_CONFIG}
>  	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=${BINMAN_INDIRS}
>  
> diff --git a/wic/ti-am62px-sk-efibootguard-secureboot.wks.in b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> new file mode 100644
> index 0000000..52fcb09
> --- /dev/null
> +++ b/wic/ti-am62px-sk-efibootguard-secureboot.wks.in
> @@ -0,0 +1,23 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +# Boot partition containing Bootloader binaries
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +
> +include ebg-signed-sysparts.inc
> +
> +# ABROOTFS partitions
> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_A}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systema
> +part --source empty --align 1024 --fixed-size 1G --uuid "${ABROOTFS_PART_UUID_B}" --part-type 0FC63DAF-8483-4772-8E79-3D69D8477DE4 --part-name systemb
> +
> +# var and optional home are extra partitions
> +part /var --fstype=ext4 --label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56-0242ac120002 --uuid 423f0a2e-b9b3-4615-85be-2a4261fa32d9
> +${WIC_HOME_PARTITION}
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw console=ttyS2,115200n8"

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

