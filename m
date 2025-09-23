Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F5CAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:54:21 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.36])
 by mx.groups.io with SMTP id smtpd.web11.13913.1758624857882433773
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:54:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pg/a24Yl;
 spf=pass (domain: siemens.com, ip: 40.107.162.36, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9lQcvTywsBYz/pECBo3TaoC5/XDUnJvPvr09mJaiCH4IK7ilaNs+2SowGD5qwzvssXjtKQsHIRNgfhx72UwzmaCPNLaDjVfRWwElXPCCWDe1T5oSIhTkgTSbPhG5gsPKaTfaeR4i7ENICsD6bVzYZs5FjfQBy+iPLzY1TMFQcJI9CrINOyxBabIoftmRvVWcvKZNK3Xi+npGs3QSc8N/de4i069A1c/biTzjXbrs9eewsRwo4FD5TQvk9CublC+s//QEQPhnRxdLwazMMLYpmSgo6uE98PwPRZtjGDLUZdmfZ0WKJmnMY2ofKkNezQR2eyh7UAdkSNFGyhbtnZtjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhudyaJ3bi9xToQO3+pHyowOYY351TVJ7kDP8Lh5V9U=;
 b=WVeTgQfUEIL+U87S4WKCGhM4JHcOxcPKrVW96ffTHKfJWTcF7D62JsTF9CJU58F3h87XzVcNmiGWFijgQHDPEf0M97aoPeO8YeqjnZ+xyPrND8sPoT+eRmr5LSJB5u4fBwien0apt7vJ0mcN7h+Cu4Git5dVIHrJ19359rwSKjiKSp82uFFxABs9SZTyncDNcBj+bJ5s+1FhI7og7NpPUQiw23aYvx9rG4q9CDtI6dx1bIDQYD1rNVa9U0GdFkVBrLyXWEaUtqqZquwDHl82bpnCw3lKLm1EEtl/g99UhSHi5GIAmITDcnP/8EwcK41TyuRKBQZgb3oy9I+4zR86KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhudyaJ3bi9xToQO3+pHyowOYY351TVJ7kDP8Lh5V9U=;
 b=pg/a24YlGApEZNjV2FbAUql/tHOtSncmNhxGUIqupATmWeZl18GSn/ht85zR75lotln3Crm6fdnkmCmIk8ukSDNvn6sBDk8JGBgSIpMuuFfOvJDyQRAFVj8bA7n/i//R7oXjdb6mm8zgbad+zA7+QWmoRp1BJ4EYrhIvFjbllWK7LZTEVFcq1bZLsr181lWZRlYDfm5Lwr/1j8B5+Uhe+QyE1IejtJULhGuEkP6RfnQjTqeT/kNbJvDSUfbAOhbUUsxBLYh0UGVmJciZbvpw3hVzHXFrQp+fOtmNBw1icQMyIcqezrshn5x8O0ZayBHxwR3s00ekRH6dKuhNT7lFKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by FRWPR10MB9508.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:d10:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Tue, 23 Sep
 2025 10:54:14 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:54:14 +0000
Message-ID: <b936b7c7-291c-4289-81e5-fe3cddfa1361@siemens.com>
Date: Tue, 23 Sep 2025 12:54:09 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 5/7] Kconfig: add option for
 factory-reset
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
 <20250923100734.319688-6-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250923100734.319688-6-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:610:4e::36) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|FRWPR10MB9508:EE_
X-MS-Office365-Filtering-Correlation-Id: a13356f6-2540-4a86-5a33-08ddfa8f8933
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dmVMS0NxanRibmkrZTBKcS95VG1ORlBwTXR4MWd1MWQ2NWFIeGZwa1NmZ2pK?=
 =?utf-8?B?ZGJOSW1DUTNhcUtaUjhJT0pSNGtSdXpPNnBPVVRiK3FnVmpZeElpVS9wZklX?=
 =?utf-8?B?b29KcnIyZEtQU0pXbmdCcGZMMm9ad3VFRHdjbGF0V3hNQ2VXS0JibmRxK1Bp?=
 =?utf-8?B?QWFKSU5za1E4amFCYjRUL3hHZnh4R3NQOFAwR2pZVlQ5ZjZTT1JsOWR0NVFO?=
 =?utf-8?B?ZGMzeDdyMFlYWDE4WFBUZHA3NFFUdUtLWnQ5Ui9ZSm5qUUJWaG1VZmszcXZG?=
 =?utf-8?B?L0t1ZDFTa2pXOWNKWkFOQ0F1WkQycFRSQ245NUtUU0h0aGZVWXN6RitYakNF?=
 =?utf-8?B?NFJmQXNKTnl3UHdoVHhVWC9qT0JPcEY4WDJ4aWFkVWVIcnN0cmNsemFsYmwr?=
 =?utf-8?B?UEtwWnpKWHRTTlYyM3BGTDhrbjRMaVFJUjgwZWJJQTFTTGlHSUg4Y0RhQmo1?=
 =?utf-8?B?clJRWE93Ynd3TURXNDRjRyt1aVN5OTdnTFZoNEFEUWVUYzhjT0p1bUY3SGgy?=
 =?utf-8?B?eXEwMFlVOEZMV1J5alpXVklMRUg1akVtb2crVTRVUEFCUW1MVXRVSnZQdjQw?=
 =?utf-8?B?UVkwSmZzUEtaNUFKN29BZDAzalRFNzdUSFV1azRHOEtJY1JDenRCWnRGZW1h?=
 =?utf-8?B?ZHZwb1FQQmtrS2ZBc080SXUwcXBkOHRSbk1aMEFDeVB5cDhoMXhBdGQ0SElq?=
 =?utf-8?B?YmQ0ZFlCbWRmbmt5YXVvall4NUYzcHpPVkYxZ3JjL1lIUlFvNlJCUHEvK1E4?=
 =?utf-8?B?d3YvOW5DYjFCRytJM3hldFpadkd5REpnMTh2T1hxSmdjTE4wbDVCdGk0YWdw?=
 =?utf-8?B?QWtWOHBtZ2E1eFVBQzB0MVZKenlRRERhbHJPSzFYSzRZTmtreU4rTnNRbEdE?=
 =?utf-8?B?cDBINk1iSi8vQmRVQUtGVU40T1A3Q3d6dmd0akx1dEp1dmV5YXVIbXBFNXBS?=
 =?utf-8?B?UGhSMVdpZ2dKTHVaWWFuK01KWHVjbzF3cGJqbnhucHBhMlBUNytTcmkrUGJO?=
 =?utf-8?B?eHpJUTZaMjQyTUNycmR4dDF3RFhJSmJsZ2lEeWEydlBYYWkvOTBzUmVVSmtQ?=
 =?utf-8?B?ZExLOEJXVHM1b3Bodk9zeENnZWYrS25vMlJhaU9iQnBKaXdrM1E3aFNHQjV6?=
 =?utf-8?B?blZ1L2dIVHZSbVI3K1ZsSXoxR01Gb3VXZThLQTZockkvSWRTUDZ0K3lXWTVC?=
 =?utf-8?B?TFRSUWdYazNOcW1sRFJ3REF6cGR0UVN3WGszYzBiem5MdEp1eUFlWUdmZitN?=
 =?utf-8?B?NEZwYU4zZDRUZEpWZ1ZmRS9nOFRSOXJKQ3dZMFRQdkJQc01ZaWNwblYvNGgr?=
 =?utf-8?B?aTdFSXpzSUMxc09PRnpCZ3FXY3pCdHhxd2dlUTBsQUtaQVVzQTI3ejRJK3Iy?=
 =?utf-8?B?aUVENTJUMXJuRnY3K0tKeklIYWtPS1NKOE9pNmtGMXV0NTFlcCtRVEFueklq?=
 =?utf-8?B?Y2p2TTh0N3hzTk9mQ1lIOG10NVVET2h3a1FMQUtqTmhOT0hRYTZxRWhLd244?=
 =?utf-8?B?OHFNeHVUbmlkMjBLVkdSQ2p0TWxqL2JNN1VTcGJGRVpTbGtxa2pyTDhTbHE5?=
 =?utf-8?B?VnpzQmFMRWpwM1p2UTQxazRIZnRqdGhWRklyU2tRclVCTVBGTU1uOXpad1Ju?=
 =?utf-8?B?b0RUNXBQUVcwNFBOSHR5MWRUSkh3N2ZUNlBndUFhWEhBNU5vaVV6SkNLaG90?=
 =?utf-8?B?WFlPenlObm5xTno0RG5rblRwcWNkb0R4NzNSTi8relZPZ1h4bk9aMGk0Vnp4?=
 =?utf-8?B?WmRvT2UwV0dkQ1NweW5HZ1EvL01LdWpsaFZod1krdHVKYWhkVHVOUDFUSWti?=
 =?utf-8?B?ZFI2dGhIdTdiTVFzVk9zbmZQTHNVblJPbHExNzQ3Y0xsb29QdHVFb1pNaWZM?=
 =?utf-8?B?aEZQajQwOW4zZmE5dTZMSDJ1bTFUc0xXWnd0a2g0SkdpU2xZbDNlYW4yK0kr?=
 =?utf-8?Q?dennEmlBFCA=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?M1RETG0rNFM5dXdWN0JQYStDOEhpelRiLzRlM0FPSytvenpBTFczdzlrMjE5?=
 =?utf-8?B?U1gzVzlQVVNxc3NwaW41c0pEQXpmbVpYbW0yMVUvcUJmUUZmOFA4Y2pmdllm?=
 =?utf-8?B?QUJNNjdYZE91c3RjUzljQ0l1QW0wU0U0eForbHM4Z3ZtdVg3dFM4NTVIbCsr?=
 =?utf-8?B?S25IYzM3bDJCdEJlZXdhdUlGNW9tVEtaUlFieVVHU0dqMkdicUppdkJpUzVS?=
 =?utf-8?B?ekxUTFdzellwQldTaTFhRXBZamxHSFptSmlnb2l1WDAxQ3pRdjlhYWl5R0kv?=
 =?utf-8?B?OW1vcFNGcXpjMEY4Wkg5RWhFdUZmTlVoSVJRVzZvRVd5UWxoTEF1V2t1YXpw?=
 =?utf-8?B?UmN6Rkd2bWNNUmIvQnhCc1JQMWZkaC9Kc29vbVJOR0hGTmZPOUQ3Um9kTlZF?=
 =?utf-8?B?bkd2c1NJMURVSzhjQW5ZOVhEQ0tqc0ZxRE4xeWttZWRISk1qbTliNXFBMWFy?=
 =?utf-8?B?U3QvTDRkbnJ1Q2pZa25KbXA0NWlHa1hrR2h1N090andWTlN5emc2dHRtcVBr?=
 =?utf-8?B?QXZpUnN0TjB5MDg0b0ptU2svV2VDcG9kU0RPc3FaRFBld04zYXBFYTNCZFpR?=
 =?utf-8?B?K0dDcTZJdlpBUDZjdlBBZy9MbklMcTZkYzBYLysvRmJQa0dCVE9QcTRUeXR2?=
 =?utf-8?B?aWtyT1BrajBPZlJxaCs4eGMyUnltMTR1WS9rQXpVYzkra2JucVMvWVc1L3ox?=
 =?utf-8?B?Q1lNWVdCaC84T0hSeVdPUXVHb1ppYTI2UkRNa3lRMURyUndIdDRzRzVzRWJu?=
 =?utf-8?B?OWFsS2JFQ2tpSUJqUWJUb2dCcTZZUTBDNVhpTVBHazIvZHZYS3F4clVFeFRi?=
 =?utf-8?B?TlBSNFp1NmhoNkR6TlQ0cFB4RUtCOHZISzArZmxtZjNoaTROQk9tNzNiZ3d0?=
 =?utf-8?B?Z0o5V3hmOFlxWTN0d25kdDNiVVU5UCtzcjJIaE1zMm5FZjNGMGFEbmU1cGFo?=
 =?utf-8?B?SSsycWZxMVR1bytzVUZLOFJoc3ZmbEFZcjRrZFp3Lys2ZjVhWU9EQnptZ0JD?=
 =?utf-8?B?VThMYVRIQ0tKM3BuU2F6d2F4YUlieWFzSHRWU21ob1FSTk5lVlhiYUsyWXE3?=
 =?utf-8?B?WFE3ZmkwK2hjQlRDWGd0NVJDbmVwT2NLNXlVNEc1QUQ3bGtZQmVoVFhnVWhO?=
 =?utf-8?B?RityZlY2YURhcGl3OVdKVkVNdkhiRjUwNDAwZWZTSWh4dHFhTHMyTENXUTFz?=
 =?utf-8?B?TDBHRHZhN1R5VUlCV25ReGxpNStZSFdTSzBNaXJvRGFlckQxbHR2NysvaVVX?=
 =?utf-8?B?dGE0SzlGK1poMnNldVRKUU5iTC9ZaEJZQkJGTm1CWnR6S1dGalhTYUNXWTBB?=
 =?utf-8?B?S0l6cFNONUMySCtTZFZVaWd6bFNXdzllMldVQlZOc3FscTVVcUwwc1dDZmdN?=
 =?utf-8?B?S2Nsb3JDcDNTVXE2U1NpaloxT25vVmZSMXI1TEIvdFhDSHJ2dmRCcmhncGhJ?=
 =?utf-8?B?RFpEdWlNY0NmSStUbm5XNkdraDNsZ0VIdGpKOXJraEFkL2xBV2piWHNRdHRa?=
 =?utf-8?B?MFl4TDgwcE01YjhkVVI4K3hnTkZkUzRVaWVDWWVYM0VobVBSakhzWGgwNWk0?=
 =?utf-8?B?Q3hNWlVVWU1KV2E5Ty9FUDJUaURSbDdPTzRpdzJ2Q2xnUHhEODJGUUl6c0FI?=
 =?utf-8?B?TGVOM2Z1MDlOajA0NWkrZDVPZUVsQ3BOWTMvRksxQkpoVEtMbkpGWnFtNzlX?=
 =?utf-8?B?dG9iZHBLTGlqSlJHUkF6OHd1bUg3R0hxV1VjQWtSRkc0QnZuZGtzU2xKL0o3?=
 =?utf-8?B?WFhzOUtZdk52V05qeHhoOHJqUmpxc0hjbzlnSXYxQ0Izb2xybS9iSmljMHI4?=
 =?utf-8?B?Nm9oSzA3cFB5Y2RPY0d5aGNRQnFWTEpCbGZ4YU5ySzU2b3FkaUN1U2ljV0Jx?=
 =?utf-8?B?dFdZSHJteStZQ2ZNWUlaY2tyZkVIK2cxWUt0ZGZNRkhvbncvQVpmWmoxVTJu?=
 =?utf-8?B?TmtGeis1dkp5Q0N3VUJxU1lJVkE2U1BPTC9sSWVlWDVUTERBK0pOZkJOQlN6?=
 =?utf-8?B?YlFha2lHVjZ6c3QzdzY0KzlhOGVxWVQzajVFaXZWNG13cmN3QnEyZmVZMkVx?=
 =?utf-8?B?eDhiR1orREhKVU1QTzU1b3c3RHdFM3pzTTFNdEhORG9Wa1BNSWs1TTd5bGRw?=
 =?utf-8?Q?/n33CexCEfMs9OWUt8m8VIGlh?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a13356f6-2540-4a86-5a33-08ddfa8f8933
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:54:14.7877
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LK80ioKSoxcX/kNmy8g1wuyw/MejhICUZ1JRkOYgSiiCwojvi5ADxybNSvNCfRYML46We43b22PoUcoQ6qSVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR10MB9508
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:54:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20103

On 23.09.25 12:02, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> A full disk image is necessary to provide the necessary infrastructure
> (bootloader or boot partition) to execute a factory-reset. In isar-cip-core
> this is only possible with the efibootguard based images.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  Kconfig                                         | 11 +++++++++++
>  kas/opt/factory-reset.yml                       | 17 +++++++++++++++++
>  recipes-core/images/cip-core-image.bb           |  2 ++
>  .../cip-core-initramfs/cip-core-initramfs.bb    |  3 ++-
>  4 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 kas/opt/factory-reset.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 3ba6131..c18acec 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -281,6 +281,13 @@ config SEPARATE_HOME_PARTITION
>  	  This adds a separate home partition to the build image instead of moving
>  	  home to the var partition.
>  
> +config FACTORY_RESET
> +	bool "Enable factory reset"
> +	depends on IMAGE_SWUPDATE

Missing dependency on supported combinations: If the target does not
support the efi reset-helper and has encryption on, this cannot be enabled.

> +	help
> +	  This adds the necessary packages to execute a factory reset of the persistent
> +	  partition.

"...to request a factory reset...". Simply enabling this will not
execute any reset. Maybe point the readme for further details.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

