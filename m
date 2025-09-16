Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9363CAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 15:11:26 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.59])
 by mx.groups.io with SMTP id smtpd.web11.956.1758035476757764702
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 08:11:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CZbt9ac1;
 spf=pass (domain: siemens.com, ip: 52.101.72.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AMXgPlTDifC65NNV+YYysiWtChYTwGrd7Zd5FW0HfPPWHXEw+eYbWWC9WMoASttxcdqc1s5W8MODsnkXBSQDf3cVrsECaS0hn3Otm7p6A059NAbzAXxIlxsCiOpYdhDovGwnc2u6v8OcxiXnPAcvpLNK7ZNLyPlWlrmm4YbAf/jEQjyeVNMpzjwMthEuAuCYL1cUwqXqfGP0eR7WIlkF/VlHggxUH0hoR7Akuv4prIMpWbx8ZKYefbpxA1GVeNspXvq1eg9W3W1uUGzTicFQVler5emXFvLq2W4nqXKgMMIrec18uWyP+yotG2U6dik2gzMPSOLdZezwcP0Mth70pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCA2YjJ7XVHUkloWcE1I33EQthrQd9vKpzqAUaerNx0=;
 b=SyEL7GDGOg87y+SbiqTktDs6Ng2OrO+5EGFRoNSJKRfNIRiUoM/wjt9op5eeXeOc8RHNpTh6BOYolHCB+f034txLas4MIPWTkv9ZU3jSmKnJM27mPJzH0m29Rinfo7kOpYCb6TEEwQtySwTj5iQ31LBKjibz5FqULSIsQ7zVa6DkQERadH2PImCffSJ/TVeuhGR2WtCcEYANuvqnsHdbq4qO16EUJj44es+4v4XIjucgU4RRLmClgKbGihMTdvhL3Pm7YvtIsN32EWypiLLn0mYq0C+6+6ZWx/+QcHVRz2kvKispv599DzzDynMTVmqh8ukzEPNU9QFiMdXkHCMaLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCA2YjJ7XVHUkloWcE1I33EQthrQd9vKpzqAUaerNx0=;
 b=CZbt9ac1NWZPBwJwlRdkJfyP48t6s/Ouu5tc6kTLIDAvvGS+GxDOqsjTQ7cCNfCTbBZzZOtbN/CLp9MA4xHshogYpu0ffu2yN77bxr5IgB2rqytvpQ5Rmd9fHtobGpCqKkmvjJ49ePPOmKMPl3tx30viwjyOK5Ns03+LIFyMYlf1x0VxyTDqulk7iFLuxoWvKQuTfPdjEx0zFvmAXMYqvGcIZbwgu0tVNCklGy41EljNFhSPaEv4WUBTjyW3EKnJE1isAphvYVTqQQbZkTsbythueQaWDP0fPCw97u3OLA951XQmJ7hAQBSkMOJXSM9Tp6MZY/yZbuHaghM4qW3EcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by PA2PR10MB9039.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:424::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Tue, 16 Sep
 2025 15:11:12 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.9115.018; Tue, 16 Sep 2025
 15:11:12 +0000
Message-ID: <cd0fa7c6-dcf7-4caf-af60-2931ff4acb4b@siemens.com>
Date: Tue, 16 Sep 2025 17:11:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] erofs: Set UUID and
 SOURCE_DATE_EPOCH with empty exclude dir
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250916120952.1771209-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250916120952.1771209-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:610:b3::6) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|PA2PR10MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: 936afd36-58af-4bd1-c484-08ddf53345ad
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVRXVCtMVDRYQlVIdlRWbnMvM3VkTXl5SUp0S1dIQUg4SzcyL2hleGhiQUtZ?=
 =?utf-8?B?dHl2SjkydkRxbE1FZGQrL2lXdzdERmtlY0tFaFNteEh4cGxNNUh4czduUGdx?=
 =?utf-8?B?MWVmcmhNUnhYTzNib2ZOYTJiT3B2K1laQlFFcjFFWEFwelVCVTB4Uys3Nkhj?=
 =?utf-8?B?Y2VVNlhQa0V1aGRFSXlmb2xYWWFWamZQWGtZNlMvNEF1WkJtcUNRYUJRUzVu?=
 =?utf-8?B?bWI2THJoeDVWdldJd2tFb2dYM3pNakZMWHRMUzM3Qkx0cVZzZkJjQUtWWks0?=
 =?utf-8?B?WEoyZHFmMWlZdFppbkRvdWxVTHdOeWZkS1pIZTFXN0R6RUFldmZ5eXo5dTlX?=
 =?utf-8?B?ajB5U3F5ckdmK0F0Sk1pTm9DVEJtMTl5OEowL1VEbEVJNUExQmVVa01tNDdB?=
 =?utf-8?B?UzQ3azV2M0J6dHB0YkJWUkx3emlOSnVNNGZ1TnZNVVM4ckxxMmMvenQrOWU1?=
 =?utf-8?B?STJXL3VGU0Y4UHRaTlkwajRnemQ0OFR5TDJ5bkNmcEN6ZkhqanUwdjlscWNn?=
 =?utf-8?B?QnNMYU5idlBJV0VCa2tKVWpDVGFwZTFNMHFLNjU1SmpVUCsvUFAwelc1V1N6?=
 =?utf-8?B?VkhHVllhYW5qZlRaTVdaYU16NDU0T1NMUWt5ZzVVWFh3VXNJaUJoWEphUVNn?=
 =?utf-8?B?ZnFmc3ZVdGRMakU0RysrYUlEN253MGZMdDRTR2Q5WVhNcTBteWNNcTQ1RWRu?=
 =?utf-8?B?ckxtVjdOWW15RU5JNjcwalNWR1d6SjF1Vlp2R2hSSTVOQnZRcGJzOVdGRUxS?=
 =?utf-8?B?elNSV2xxa3RnRUNZalhNTGpNd0ZsK1ZxRWFJZm9MWnJLUGdhdWg1ZFdRRjkw?=
 =?utf-8?B?Vm1vaHFtUTJ1RUFFU1VYWDFXZ1I2T21PUTJLVGRNeU8yMC9XaklXUThJdUlw?=
 =?utf-8?B?TmNrYkVra2lYQTUraStQdlcyMlVva3VKVlMzWi9UNHVnOVRCeTN0R1Y0WE5C?=
 =?utf-8?B?RGp1dXYwakdGeDdVc3AwRzV2eHgyRU5hcElzbk5ISlVWYlVYRHlSWW15K2sv?=
 =?utf-8?B?K3dvaGJPcWtvTjMwZWV3QXh5M1MzbVI3VXB0cjd0Z1puSkp1OUdzdUlPbHVw?=
 =?utf-8?B?b2hBeGhxNGZXZ2h4dWthSjJmRmkvdHlidDZybWdCWUVzTmZsajE5OXZqd1ZN?=
 =?utf-8?B?a0VEbGovZHl0RCthUjB0UW5uMHNXZzRSRkxlNFBqeFpYWEF0RTRVWk5QRElU?=
 =?utf-8?B?MU92cmtFdHhJeDd0SGNDY3kxL2U0OGpaQjlBTk0vUGlUQTJEd1hMVlFFN3hy?=
 =?utf-8?B?SzlQZC9pS3ZqT1cwRmdqeTA5M2xmMllFY1YwdzZBMml5aWhsajllbC9VTjJY?=
 =?utf-8?B?VkZzekErVHBrVDQzUXJicDF3enNJald2NXU3Z3hmaUo2UWNjcVFFMXVUMWhy?=
 =?utf-8?B?Q28rZ3o0YUtLVkNZRG9tbFNWZmdPendiMEplTXhmN2Y3dmVMNXFxdTUxV3pJ?=
 =?utf-8?B?L3dwU1JsME1LWkdyK3BGQW1Ka0RPbC9tQTh5YlJuUmtPQXZhNzNIdTJJSkR1?=
 =?utf-8?B?MWxOQ2x2L2hReXIwNUNzTEZxNUNFTGNENklyUytNRnZHVXdrTUhYckZRd1Av?=
 =?utf-8?B?c2Nnb1c2QXIyWXBWUUMxV0VBQllKaTYzd280cFcwMDZHSHROcDNzSmRxUXpi?=
 =?utf-8?B?MzczLy9nczVzelhaTk8vc1dpaXBIeG5jemNOUEhndDB0azBaQ0dJaGZqRk5r?=
 =?utf-8?B?L0NKVEI5dHFsWVJiZkowUHpCWDNxSUVsV3FaTkUxNVRhMVYvdTRMaVMyVERJ?=
 =?utf-8?B?d3QvUS9OSkIzQjF1SkJEbWcwZkhHVkdQK0FZZGpXS2lrVzNzd2ZRRnFnZ3hm?=
 =?utf-8?B?RzdsWlI3bGZpS09uSC91YW1ER0xtTitCOGpVV3h1ZmRHbHNNRmlBNHhVeENT?=
 =?utf-8?B?Z3dmK0VTOGNIU1BzZlFyNmJ3UEcxTkhHTXpneGEyWUhSSlA5bUpjaXFXZnNH?=
 =?utf-8?Q?DhcfW/ud3QE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N0xqRkp5ZytVRXo3Lzd0Y2lhS0VNMzRSdlhoWEE5NWhFaHVUTU1XRVlxclNQ?=
 =?utf-8?B?SUVpMW81Z0JXZGtOdExMSjhibXUzWlU3MUdVdE9KL1o4K2ExbXRhYk95M2F5?=
 =?utf-8?B?bWYydW1IbUl1WkluTndxUlpoVlhBUDFpN0lsa25MY2RZSUlkcFpnWUJsd3M2?=
 =?utf-8?B?OVUxOGpocCt5VnpuYk1xRzNqTFYrT3lxMDhvbVFMbVJpU1NNb29WaVFRclhs?=
 =?utf-8?B?VVNmanp1d21jWHQ4L2ZTVW1Qd0tRTjZwSldXTWpXVktMVGZxOGZ4dlMxV3JS?=
 =?utf-8?B?dW11dERJdi9ua1lRd3l3K215bUpyVG9TcE01aGVZS3llNUVjMVd3MkhveTFo?=
 =?utf-8?B?Z0tIM1lYSlZyMUY0a1BJVi9xMGV3dHpuYUlxSngzdDQvVVVBQWV5UDRHdUw5?=
 =?utf-8?B?aitCSld5L205RUsxMndRTDVMYmhMNitaQnVLbEs4RWFSb2R6S2g5NnFIcnBo?=
 =?utf-8?B?QXRvcVFuRkRCL3BCcDBQbnlLZ3h1SGN2NU9LNXZadThjaUw5Mkh0Y0tkaFlT?=
 =?utf-8?B?eFYzMkNVejk4djFSQjJpd054bmNmWWk5L2ZmRy8ybFdqOWJzVStBVnhvWEdx?=
 =?utf-8?B?dlZvVmRuN09ZVFI4czFpOUg0cGlYa1VJOVNHdFhEd0tPZ3ZZUXJHVnZmbkcv?=
 =?utf-8?B?S3hseFpBNlFOT3FheFAxS2RBdjVGVkhYdjRja3kxcCszMkNDQVg4SmFCY3FI?=
 =?utf-8?B?dHhBY3hXK1liSkowaEwvSXlRSVkydzNycncxbUdJRzQvamREdTN3WmJYM2tp?=
 =?utf-8?B?RzJvQ2p1NFcvcTRwMzAxeWkrazdmNmRpUTJwUlNTR3Jkd2o3QkloeGtQenph?=
 =?utf-8?B?YlVvV1crbXhocUwzejgzQ3hxVjJIRDBRdGF2TlhYMnIxRCtZNFMyeHpuczhR?=
 =?utf-8?B?b1dpZW5WMUxxOGFWa0NobE1hU1FuVGRXbkUrNnllQU5MdEwwWkZZZ2V3bmwx?=
 =?utf-8?B?SzhMcHI5eG9zSGxac2xEbU5mVzl1V0ZRNmtFSDBjNnh6YlJ4NzZNeGdWVG8r?=
 =?utf-8?B?M2xoa0ZmcWpjWm03KzdGclRmR0lXYmJEa0FtdUpTdU0vNnpuMFlJSENQTkU2?=
 =?utf-8?B?TW9RV2YwYnRvZ3dlenVMRFRvVjAzSERsM05pOHZ2Q0gyaXZvWUpENm1JS1k5?=
 =?utf-8?B?Q01uNzA4aGZ5enFLdTNuWXlCZkhsWEVrMy9nZUhEMlRnblhQTWV3d1dZR21N?=
 =?utf-8?B?M3ZjVFY2RHNoQUlWOGZqd2VGSUpUekd1YWNLZVV1MExsdWdsY3haSHY0aHd5?=
 =?utf-8?B?MFZweFRMa1Nwd2NvM3UyR0p4bFExbmRsOHlpSkFvOWxUZjZzZWhJVG5wQ28v?=
 =?utf-8?B?aHl6ZXdIeWxXYmhjRENYb1IwcUg2bGlIalVIeitDTWg4QUNwaTRCUkw2NmxK?=
 =?utf-8?B?bVUrUVlmZXdrVjc4WDFONEpMUFZ1Rm5hTGxoWnMraG1UOGpic2wzZ0FiL0Rq?=
 =?utf-8?B?Mk8xUXUxZ1IvaEhTdHlkMWQvbDk4LzdJbEczdUtCVHpIVnlMVnRMM3VvNysx?=
 =?utf-8?B?Wk5hcWNpZTZKclpZcmhpamNRNkVYZnBnNk9mdG5raXhpdTQyUjlBTFkrWTdT?=
 =?utf-8?B?K1JCZzRINzVqM1c2Z3RrcDU0WGFweDhDMHdNeEwvMTFIOFBLRUdXbWxnbmhT?=
 =?utf-8?B?M1BKU3pnWWZHcWxQdEl3MWFpYVF5cmhPRnhKMTUzZDRmQytxaHkyRzhDMVh5?=
 =?utf-8?B?VHliazBwODNxeVBjZlpmSVR3K2NIZDlOMEF5Wm5weVJTcy9oNnNZWExUcVRk?=
 =?utf-8?B?LzlUYjRhUkFJZzY2d1R6dlhubk13R1pKenduTW0vRlE0V0FOQ2x0Q0M0WGpV?=
 =?utf-8?B?eU91K0E3bDhhZmpPYWtka2lvRFBrZ3ZHTVdYVk9IVkgwUDdMaUdqZE55a29o?=
 =?utf-8?B?VnpXaU9aZDZ5ZmxGZnE2bGNOU2VPMTY3QzltNkNBa2RjTS9xbFpYRjkyZytF?=
 =?utf-8?B?UVBya1g3VENnaE5Nd0YwVFpQeEkvU1BrM2VIU2VQd0kyczNiVGhOMEc2MW85?=
 =?utf-8?B?dmNJeGsrZTZubllXNDRMUDc2T3lOQklGcmFseVVWSDlGcVFRd2lEU1NqUXpw?=
 =?utf-8?B?MUY3K056VWRJczBHTlJDaDNGVXZHS21yT1o3UmsvSFpYaDlHNkkxazQxOWFm?=
 =?utf-8?B?Mkt5TXpyQm1UQVJUODNKUFNZU09ycXNITjEwY0xWbjNuanowS3ptLzRVcTQy?=
 =?utf-8?B?b0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 936afd36-58af-4bd1-c484-08ddf53345ad
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 15:11:12.0018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rllWswE+MS4kOuTQTTOt35ro+UQwiHktzTO3w2ur94S6hc1ou+LWqy7TYNZ0VOAC2d6LF/a6Dd1s/4qdaB6mTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB9039
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 15:11:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20060

On 16.09.25 14:09, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> if EROFS_EXCLUDE_DIR is empty then SOURCE_DATE and UUID are not
> set. These variables should not be depend on EROFS_EXCLUDE_DIR
> as the are necessary for reproducible erofs builds.
> 

Good catch!

> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/erofs.bbclass | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/classes/erofs.bbclass b/classes/erofs.bbclass
> index 2743bd1..debf097 100644
> --- a/classes/erofs.bbclass
> +++ b/classes/erofs.bbclass
> @@ -17,21 +17,20 @@ EROFS_CREATION_ARGS ?= "-z lz4hc,12"
>  
>  python __anonymous() {
>      exclude_directories = d.getVar('EROFS_EXCLUDE_DIRS').split()
> -    if len(exclude_directories) == 0:
> -        return
>      args = ""
> -    # Use regex to exclude only content of the directory.
> -    # This allows to use the directory as a mount point.
> -    for dir in exclude_directories:
> -        args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
> -    d.appendVar('EROFS_CREATION_ARGS', args)
> +    if len(exclude_directories) > 0:
> +        # Use regex to exclude only content of the directory.
> +        # This allows to use the directory as a mount point.
> +        for dir in exclude_directories:
> +            args += " --exclude-regex '^{dir}/.*' ".format(dir=dir)
> +        d.appendVar('EROFS_CREATION_ARGS', args)
>  
>      import uuid
>  
>      sde_time = int(d.getVar('SOURCE_DATE_EPOCH'))
>      erofs_uuid = uuid.UUID(int=sde_time)
>  
> -    args = "-U " + str(erofs_uuid)
> +    args = " -U " + str(erofs_uuid)

Hmm, I think you wanted to write "+=" here, and that is also why you
added the space, right?

>      d.appendVar('EROFS_CREATION_ARGS', args)
>  }
>  

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

