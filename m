Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21B2C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 20:32:08 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.74])
 by mx.groups.io with SMTP id smtpd.web10.4784.1718742723074344110
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jun 2024 13:32:03 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xfa8Q5Yr;
 spf=pass (domain: siemens.com, ip: 40.107.249.74, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7YzbSWcB/W1R94puBcze55Ca4K8EWUkSjKmaz6uwupmiPTYepl3KlowPEdWSXUplUVNACfInp9slCHf9GxYOeTZdZJQY+RsLu4QS2kTV+l7aYeYpEKoum1BpdvcignvKMDqMkCS/pu0AHCdCt5xanPlhFvyi794JfPg1qO3FtQgsqWfxbearABcq4wkRgwqWyjP/Bezy8TNI0qU82rGzx8plivsd/68Bbb3g6NN34JttX4MxJdJPrd1TkX95SXGU2rTLrE+Bw32j/iMhO4SdxahnTAki+31mowfGXamJ9kzkP3gYyspvv2FmHsQS6RsQzacmFX/4Rtt9hpaSPjBNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RV9SuOjC8NbvX5HENoFp38ZE0Lp8KHMHZp888pALF6o=;
 b=XVpTWRSPnayLf/765t9//goYnKO9g5pJGT86flgTvC+yjvrLt4ZsNcCq0e9u8orgB5huTU64Z8KdPPXditzT5Bx42XfRnzNy2q4YvMo29S4bM4xZmjWweEN6nYVnRE4Y1zDnUJsPEVZ/rLKBl2iJZyyRxis/OUTjg9mUfI8azVF1TVqBfacxyMirbTQwY1D0QEx9wld/JM3eqsOuYDKzfEsQ2TcCQRUV9h0AJlWJiO9jyGZEwINk63/FW28zr10mApwiWnfQvJErdsH3JJPpWXcmVDVRKDBYBOsEfmEZ0fQRF1iTgGgZI9siTeUUjLD+ypRkdNZsdjVul8MW9I8vUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RV9SuOjC8NbvX5HENoFp38ZE0Lp8KHMHZp888pALF6o=;
 b=Xfa8Q5YrDbPcrQAUgeDQb6bwGThZxsDYVITs+EoNnxXr4OnMSMz/1onPys15angHAv2LRN8u2BV/J3c4gV576Z8kTw0Ts06/4Gx4N+PwlT1ltYJOCY6R0eJ1qSMXQVIbu+BTtjYg1lJS2zso8+wfMQeHY5m5wou0isvb3zznuhv2VDrZwc8hPwP94tISxzA4aDbzZgNSQWP1uXvlVidBcfaNKpsJg3wzyZlkl6XUASd/RF/loVNqWLu+6lF9kABV1/BQAnptv/PcaIlvSKVVy+uKPbjC6F1yolQuvUBftkpuTgMPgSu9jO4nGT7r50Y+tVk0Fash++GOGwkN9Sj8zQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 20:32:00 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%7]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 20:31:58 +0000
Message-ID: <d3c6d33f-4e7e-44a9-9fa6-cfd308e645b4@siemens.com>
Date: Tue, 18 Jun 2024 22:31:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] swupdate: fix reboot progress
 with wfx
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240618155914.1458889-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Cc: Christian Storm <christian.storm@siemens.com>,
 "Schaffner, Tobias (T CED SES-DE)" <tobias.schaffner@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240618155914.1458889-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0132.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: f64db099-f90e-4e43-d934-08dc8fd5b3c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NlJtaWhBQkEraDlLcXhnNmRKTGxjbFY5Z29XQWZTMUtyd1VqdlEzM2dDTkR4?=
 =?utf-8?B?WUFYYmVCcnNlUnA1MFVrVk4vbjd3YWZic1RFa0JjSGRlbkVTN3NpeGt2QzNS?=
 =?utf-8?B?MmNoMXF4OEduaU1hVWtVWXMya3o4VjdpNTFhVk5YcXkvWlFNd3ZiV29UVC9E?=
 =?utf-8?B?cDRtQTk0RVdRdi9zUWh4NjNkWllUQ2Q0dFNxaUFWNFdCNGEwWkxHQmZiVm1O?=
 =?utf-8?B?UmFHbzBzaFlqRDJtUUxZdTcrTjhkbFU5S2hsZitwVFl0L0VOQ1VmNjQ1SERr?=
 =?utf-8?B?UGc3SnJqQmhaUVMzVkpvZUxwN0lhNW9tU0s5K0ViQ2FucmFYQUdzQUJIVFZ3?=
 =?utf-8?B?MnBQQ045MkhnbDBZSlNFM2lUZEwwOTc0eUduVExyL1dLemd0a1NwZFEzbmQw?=
 =?utf-8?B?cTk1dVBGZENiQWRQRnhZNzRyMFY4Qk16dXIvVzJWRFFJZUJpNTVvRkgwQndD?=
 =?utf-8?B?MzkvZG9Da2NHTGptdlJDM01qKzJXbVZqMXlJK0xicERPaDJ3RFJOU1BXZk40?=
 =?utf-8?B?SGVXRmVIRXFpek1tYjRXdk1qaFJYSEN5aTY2Z1JHODJmb0haOGN2ZHo3OTB0?=
 =?utf-8?B?eWJKNFZRVFpkdDF3Qmw4NDcvNXJxMStNT2dCWFBHMGJWcUlhbFVqQytlalht?=
 =?utf-8?B?UzUwZmo3emJuLzBTbFk2MHJGRkIrcHhMWkFSWWZDS3RyMHpqU1RKSXduT24w?=
 =?utf-8?B?c2R1TFo0NWJhbk5xaG9NS01TR0d6am13YzlsUTN1bUdXeUJzYXFFdWk5Q2xt?=
 =?utf-8?B?ajB4SWZDWHkvWjh6NEFOZkVZdTZGNWVHMDg0bTgxUlNMRE45TVlvL0FmM2Rj?=
 =?utf-8?B?TklOem43QWZIcG9CelA1cUt2dGFkRFh4YkN1aVM1UzBCNWk2QS9BL2JDM2pX?=
 =?utf-8?B?OVRpNHBNcGpQUHVkT25yN25VMGRnNmQ0bXh6RjlrcU5KS3V5NGlsa1JnUytX?=
 =?utf-8?B?Vm1OeENxbWNiOS9BYTUyU2p0K05VdXRrWHZoWXVHTjVwSXhaTUxIQmtKK1pS?=
 =?utf-8?B?dytKaFV2VVZLSUJNWkxHMm5yUEdDOEhnYk9WeWRWMlNSNURvNTB5NWdVcFFC?=
 =?utf-8?B?Q2FCTVVaRnVFcDMyRXNIcGRUOG54ZDVMR1U4cndpTE5PQ3RKeUR5Y2pvTUJO?=
 =?utf-8?B?YWtVR3oyZWM1M1R3ckpVTDhZN2xZdktSeHRmZ3h3Qks1ZFZlRVdSYWNHL3g4?=
 =?utf-8?B?TDlORlFnazBVZEdtQUNTaVAyaDVROUlmY1BXZTJuS01QOE9DTnQ5ZEg5ckZI?=
 =?utf-8?B?YXpRUHVORGY4aHpWVHVnQWlBYURJeDZCV3c0dUt5ampCMWFuRUVTN3lXZjM1?=
 =?utf-8?B?VExIc0c5Y3B4NkNzK0FnTG04UDg2elU3WWY5L3dMTERnaUNaNkgzcTMyOFVI?=
 =?utf-8?B?SThTUHN6bklSbnJ3RUhPd2pucFNiUlVNckIxMm5mRUJnY0NKWFQvdTBqU1kw?=
 =?utf-8?B?YmJxMlZLS0p5YWRYZEo2NSs5ejhON3V3MWIzOEZXcGFZdnRsMUh4dkVta1pt?=
 =?utf-8?B?cC9KZU5rU3J6RFhleXNuZ3lmWWV4Z09Jb2lrWkNkcVpwYnJ1cDBJY0dTNW9q?=
 =?utf-8?B?OHpob1pNNmVLRkxiSVRIWUxZZ3pqS2dFR2pOQ3R4MVNwczU4WjJPSnh6TERQ?=
 =?utf-8?B?L1ZQdnF3WXJ4Ti9DQkdjdlJxdS9CTldGaEZRdi82OVhPMkZNY2pHc2t5Q0NJ?=
 =?utf-8?Q?+Urwhe0wlpeahH4ECpZd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WWNFZmEzRHR4NHQxMWN2dENKbG56dENHS3ZKYWFTZjAwR0RtRWxRK2ZibExh?=
 =?utf-8?B?OW4zUlhhK3FQNW9yMWxvZHhKbmtWMDZ5bXQzaTVpd1BZSndTdG1VZUpvWEtV?=
 =?utf-8?B?dEtUK3o5RVJ3K0ZFYXRlKys2MzhrVklwcVhkdTZuQTVPYjIzaE1NMGtzM1Av?=
 =?utf-8?B?a0hML0l0K1I5SmVocWg1dVFXOXEvOEZxQ0NhbXVyTk9mcTExL0lGNXcwMXNh?=
 =?utf-8?B?TERIcmhlMWR4QlJ4Z0lqWW9mUlZiV3RqeHgwbzhXb2xHbDJtcHdJeHNSZXNx?=
 =?utf-8?B?SmNYdm92Mkw3aTF0ZU9TTlJ1UTFWTUZ1ZXVORi8rdDhnOFhYejYvTEl3azUw?=
 =?utf-8?B?ek44OUEzZUJRQWdWMGEwTm5ScFNoTXovVVMzVWgyMXRLbTNlcnlxdHVycUhR?=
 =?utf-8?B?dTlHcThCMEF3bS82N2ZKb3lYdXJRbm9PSGtCYkpsZk91QnluMFVuTFlIYzVX?=
 =?utf-8?B?S2JONC9Rb2RodUY5eHRSc1NIemZSaStIRUVMMVk3SWNFWGVxN2VQc1dpdXdz?=
 =?utf-8?B?aU5lcmVrVDFjK0hvVjMzaGFnZ0kzeVdzemgya202UnREbkJsWWVJd25ldGVp?=
 =?utf-8?B?T3BkejNvTlA4Y054K0hBQ2NxcEY5eEV6TVVHdEZxNmxHQkN4YUEzQmhmcHlQ?=
 =?utf-8?B?NGtWQUdVRTdPMVkxTGhCQ0RXb2orZjQ0LzJVVzRTV1NVTktqZVZMd2xkdDRT?=
 =?utf-8?B?a1JUVXZTVVBJOXUwS25ld1A5UUgyaktSbWV5NEQxeW5UNVo3cFQyZHRkOHp1?=
 =?utf-8?B?U1ZQZWRQdDhNWHg3SjVIRlY0UkFzM2VZQXdaU09ORHVnN1hvQWNYdE5FTjly?=
 =?utf-8?B?cGE4dzdnYmpJb0RpZkFQRGk2TFQyYVBvaG01N1ZpMWdjcTY5YXlkdlBuanMw?=
 =?utf-8?B?WlJFNnlOY2RLcXlHaHJDTW1QL2R0eTAwQytycUdINkJOSWJjKzNWaWUvZFlR?=
 =?utf-8?B?MjBzVE5xTVdMbm9TVnlWSk11TjRXeDNCZzdJMlM2dU9vQ3BEUEhpOU9PaGNy?=
 =?utf-8?B?bEFXYVJNcUdIUkgzaVIwVi9wajhzTkhDdGo5Q2VLb0U2MnZQU0ozWVFlWWRT?=
 =?utf-8?B?L28zYVYvbXJLYkVUR0NCb0svS05UWnpFWDJ3TnQ1VHhqaWVqcVBKOFBROUVI?=
 =?utf-8?B?UGdoOVpMbWI2aFlJVWp0aEZ5NGUzbWNJR1gwWDBOeGRjWDBXMzhGYnhMUTd6?=
 =?utf-8?B?WHZyUUpkanFtdC9Ddkp2cW9Pejc3dHYwZWlVeHFjM1Fwdmxydy95eDlqdGF5?=
 =?utf-8?B?UEtyZUQ0N1V6VUVWbzRLdzBwS3BBSVlzdWR1QTh4M2drNWh6WUJwTVhZbXlT?=
 =?utf-8?B?bUVyUDhEdHBtcjVGWnZWV0REaXZIK3NTTkVKTFZid0pNRUkxcnRvQUhURm9u?=
 =?utf-8?B?eVYyaUg4akVJMmhERC95V1VPcWUrTk91c1NobDNUT1RwZ3FpaXZNU0lhd2JL?=
 =?utf-8?B?OHZmbU5hQXM4Q0hueTZtSHZDdzRETDdBSTByeCsvNURmUzVhUEFBSHZmZkl5?=
 =?utf-8?B?a25CWkEwYy91eGZZaVd6Yk5nSGEwMDhlYWxUdFpvc1c2M1JjbjFvbjc4cEtq?=
 =?utf-8?B?ZmNYTVl2Zk9XUEJBbkJlZDZ1aWE2MWdSalFMNHRFVHhZUU9oRTNlZ3FKRWZK?=
 =?utf-8?B?Um8xMkYrQjhveVZENi9iMjZiTDhrSHFJZzZ5dDdEZWhHMlNEWGZYSVBuVC9v?=
 =?utf-8?B?ZlVJb2J5SFZlbFRyUDFSVnZmY2N0YVBkZEYrbWwvbVFkalhhVmlUZXhVMVI4?=
 =?utf-8?B?WUZES2t4aVp5RmthZEFrRTNvMDJyQy9ROTNvT0hrMWdtZHFSTzVqQ0tqQ2dx?=
 =?utf-8?B?eE1xU00vQVZ3M082STg3M1huMDBRdjRIWm1QRFFxUkRPZTA5UUNjR2laUSt6?=
 =?utf-8?B?YnhYT2VmSTNjaWp0QXMzV0JJbmJuWmZBRXEyendHLzAzVGowUVNSdkRYRHVs?=
 =?utf-8?B?TlpNb0ZuN2xiWnFNMzAxVGtLMzNBcmZERWROSEhnZG5NL2NjZ3JZUS9mZ0ZY?=
 =?utf-8?B?UVE5aDBvek5pR0FrTVQ0dmo3S3U4NjYwRTZQc21ic2ZYZkUzblRCb0hhSVNz?=
 =?utf-8?B?am9vZ2I0VzRZT3FBV0VUbW5UaVE0UXBhRU5qLzlaL05hak1aMWxIQ1ZwaXNn?=
 =?utf-8?B?bTFhaTRkRlZCT0h2RGlMY29ZVW1neUpkWGNLb2lQZE81K3UydjN1Mm53b3ZG?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f64db099-f90e-4e43-d934-08dc8fd5b3c2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 20:31:58.7600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SDdrGATPslqyRGdG0/5xD8EPzWe+zsFPKwT0qqVRl6OuaejayQcgbhtDm3gGxzc5Ts5nx0Rntnzv5Ap9si6YmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 20:32:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16288

On 18.06.24 17:56, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This back ports the fixes for the wfx progress handler to avoid a
> second reboot on the device, see [1]
> 
> [1]: https://groups.google.com/g/swupdate/c/wJ6g5lajuYw
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  ...d-suricatta.ipc.progress_cause-table.patch | 30 +++++++++++
>  ...ress-Fix-reboot-mode-message-parsing.patch | 52 +++++++++++++++++++
>  recipes-core/swupdate/swupdate_2023.12.bb     |  3 +-
>  3 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
>  create mode 100644 recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
> 
> diff --git a/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
> new file mode 100644
> index 0000000..69873cb
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2023.12/0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch
> @@ -0,0 +1,30 @@
> +From 3ac2b34958a31c3694a78f840201373cfaff6c10 Mon Sep 17 00:00:00 2001
> +From: "Storm, Christian" <christian.storm@siemens.com>
> +Date: Mon, 3 Jun 2024 20:16:56 +0000
> +Subject: [PATCH 1/2] suricatta/lua: Add suricatta.ipc.progress_cause table
> +
> +Reported-by: Adithya Balakumar <adithya190298@gmail.com>
> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
> +---
> + suricatta/server_lua.c | 5 +++++
> + 1 file changed, 5 insertions(+)
> +
> +diff --git a/suricatta/server_lua.c b/suricatta/server_lua.c
> +index 7ac5e972..2641a037 100644
> +--- a/suricatta/server_lua.c
> ++++ b/suricatta/server_lua.c
> +@@ -1592,6 +1592,11 @@ static int suricatta_lua_module(lua_State *L)
> + 	push_to_table(L, "SUBPROCESS", SUBPROCESS);
> + 	push_to_table(L, "PROGRESS", PROGRESS);
> + 	lua_settable(L, -3);
> ++	lua_pushstring(L, "progress_cause");
> ++	lua_newtable(L);
> ++	push_to_table(L, "CAUSE_NONE", CAUSE_NONE);
> ++	push_to_table(L, "CAUSE_REBOOT_MODE", CAUSE_REBOOT_MODE);
> ++	lua_settable(L, -3);
> + 	lua_settable(L, -3);
> + 
> + 	lua_pushstring(L, "status");
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
> new file mode 100644
> index 0000000..9719057
> --- /dev/null
> +++ b/recipes-core/swupdate/files/2023.12/0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch
> @@ -0,0 +1,52 @@
> +From c65f5435eec2a0c51f6f0c356451c2091b2f3fdc Mon Sep 17 00:00:00 2001
> +From: "Storm, Christian" <christian.storm@siemens.com>
> +Date: Wed, 5 Jun 2024 06:35:24 +0000
> +Subject: [PATCH 2/2] swupdate-progress: Fix reboot-mode message parsing
> +
> +The incoming msg.info reads, e.g.,
> +{"0": {"1": { "reboot-mode" : "no-reboot"}}}
> +and sscanf() also needs to parse/read over the enclosing
> +{"0": <...>}
> +part, though discarding it.
> +
> +While at it, use static buffer allocation as the BSDs don't have %m
> +
> +Signed-off-by: Christian Storm <christian.storm@siemens.com>
> +---
> + tools/swupdate-progress.c | 7 +++----
> + 1 file changed, 3 insertions(+), 4 deletions(-)
> +
> +diff --git a/tools/swupdate-progress.c b/tools/swupdate-progress.c
> +index 584910d4..14040757 100644
> +--- a/tools/swupdate-progress.c
> ++++ b/tools/swupdate-progress.c
> +@@ -339,7 +339,7 @@ int main(int argc, char **argv)
> + 		 * Be sure that string in message are Null terminated
> + 		 */
> + 		if (msg.infolen > 0) {
> +-			char *reboot_mode;
> ++			char reboot_mode[20] = { 0 };
> + 			int n, cause;
> + 
> + 			if (msg.infolen >= sizeof(msg.info) - 1) {
> +@@ -354,15 +354,14 @@ int main(int argc, char **argv)
> + 			 * will be added, JSON lib should be linked.
> + 			 * NOTE: Until then, the exact string format is imperative!
> + 			 */
> +-			n = sscanf(msg.info, "{\"%d\": { \"reboot-mode\" : \"%m[-a-z]\"}}",
> +-				   &cause, &reboot_mode);
> ++			n = sscanf(msg.info, "{\"%*d\": {\"%d\": { \"reboot-mode\" : \"%19[-a-z]\"}}}",
> ++				   &cause, reboot_mode);
> + 			if (n == 2) {
> + 				if (cause == CAUSE_REBOOT_MODE) {
> + 					if (!strcmp(reboot_mode, "no-reboot")) {
> + 						disable_reboot = true;
> + 					}
> + 				}
> +-				free(reboot_mode);
> + 			}
> + 		}
> + 		msg.cur_image[sizeof(msg.cur_image) - 1] = '\0';
> +-- 
> +2.43.0
> +
> diff --git a/recipes-core/swupdate/swupdate_2023.12.bb b/recipes-core/swupdate/swupdate_2023.12.bb
> index 1c140b0..cc01a98 100644
> --- a/recipes-core/swupdate/swupdate_2023.12.bb
> +++ b/recipes-core/swupdate/swupdate_2023.12.bb
> @@ -27,7 +27,8 @@ SRCREV = "6ccd44a8539ebb880bf0dac408d5db5de7e2de99"
>  # patches
>  SRC_URI += "file://0001-d-rules-Add-seperate-build_profile-option-for-delta-.patch"
>  SRC_URI += "file://0002-d-swupdate-www.install-Fix-path-for-debian-bullseye.patch"
> -
> +SRC_URI += "file://0001-suricatta-lua-Add-suricatta.ipc.progress_cause-table.patch"
> +SRC_URI += "file://0002-swupdate-progress-Fix-reboot-mode-message-parsing.patch"
>  # suricatta wfx requires suricatta lua and the dependency
>  # is not set automatically
>  DEB_BUILD_PROFILES += "pkg.swupdate.suricattalua"

We only support wfx with SWUpdate 2023.12, not with the other versions
we have recipes for, right?

Jan

-- 
Siemens AG, Technology
Linux Expert Center


