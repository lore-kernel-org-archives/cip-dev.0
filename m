Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E33C02196
	for <webhook@archiver.kernel.org>; Fri,  7 Feb 2025 09:37:11 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.63])
 by mx.groups.io with SMTP id smtpd.web11.65716.1738921026916222560
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Feb 2025 01:37:07 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vDr7ABlr;
 spf=pass (domain: siemens.com, ip: 40.107.22.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdPq+5PGMt3s8VGhQ4fbnAL7S8BhZ6BaF7MWqARm92jianedVSKb7JJgd9ZmKre/11428A5qfT+u9/2XE1x4Z+43Ybq263z7dWpFo30ssrktB/RMDB31YzibOsfCkMCz6Elx3cJPxPpgiUIt2FcTG0T3IomuA5IZVJkzEb3oBrIjHixxNPEpupEeydZcYwkmfOQ/w6ZlItMmBLqeqpk/SrmLDiJI15ShlO/iQuzH3yEkmD/DVxbpt1O0xfJsjLPBA9+dIgCpf8zS7atxAiPI+OGYksd7j1DWlXklMm71gQOG3Udb+OVvy2oGLZxe6ugZOO8fuQm50d/7U/NWIQsIoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8kWGVkST3LJaWYecrh14/oyy/yMH4J0XUJnDSx+tN0=;
 b=O2VYV2JwH1J4dKp4TUKZ8XaCrUX4cqqs3SQPDOQB5OY33+Llbwkl9gaNa0UKHVxbCk68mkbpw7Qvqy6C9kVWisFK9zTh+Jt6pkMK190Ex00PDPYnXxbdP1iEmTjbw1rJusmrf1mjNzuHTl9wUPAJwn9m1YSdH9au/NTL53FaHg9TGYKxugzI5lZJqV0DS9SIIAMX7FhenQgVUYCfOpCKCv+B18a6tTB2xNYn/JX2oEoJO7rbrZA7Hb4lu0oN6t6QrFq7jqQVNMyyiwzKsIMBLj7uurVLlmoKMDHbHZ53z/geKGZ0dQecYO4qkoBLhV+sds/lZpr1uYCNzFgHp2yxRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8kWGVkST3LJaWYecrh14/oyy/yMH4J0XUJnDSx+tN0=;
 b=vDr7ABlrXIT6c1jLF8kZMUbyezWEB9rsRUyCe8Yz4GVpMuoglbruycBIrP+1pLbJkNo6PVOJcsGZHjlDocDpbtSc1kaUoMtWx/pJa9t3NOI0pc3vy93QSVnmLCg8OGAbR4VRu6ga18X3p2yd9wkEhWqzdL6WMYfgMzM9k9BdsrvIwCbrOHnTMRre3STdMizZkE7Pc6zDmO5ryiAfHcuSY/kBjBwjifnEx2fLthX4P3RwKVZbikfaFNlCesjq2oPyn8PEibxtc36aIcEITvzeXoHQJo8J7xylo29rGYvwiQ/F7otjwWkbBMSlHMETpcI7UVqztV7Hn08DQDmRksa49Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PA2PR10MB8618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:41b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.9; Fri, 7 Feb
 2025 09:37:03 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.005; Fri, 7 Feb 2025
 09:37:03 +0000
Message-ID: <f830f7a5-dfc5-4949-be13-4183bde0f4a1@siemens.com>
Date: Fri, 7 Feb 2025 10:37:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] README.security-testing.md: Update steps to
 verify IEC layer on security image
To: Sai.Sathujoda@toshiba-tsip.com, cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20250205133415.72913-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250205133415.72913-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ba::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PA2PR10MB8618:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e49afb2-b109-45b0-d10a-08dd475afa64
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|13003099007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?TEVVU2FJVkJFTTRUL1I1OHVxaFUzeFhha2lWeHlpcUFrL1RsQTZXSGlMVGtm?=
 =?utf-8?B?ZTJzblRpMU1sMXNKV0kwZGtmUG5CcklxdURHSDBmZGtNNWpwVHdTWVF3NFV4?=
 =?utf-8?B?QTdSK2xoVEI1UEthY1pWdUE5Z2RtdmM1ZWNzbzhHMzBXM2w4cVpVYnhnN0Jy?=
 =?utf-8?B?RlVMYnNkTlpoKytKYVQ3MDRDOXVpSHdtZTBVVUxlTFlpKzVUdllsVFFnNUFp?=
 =?utf-8?B?TGJVaU5vRWZSRGRjNW00TUpSenk1VXd5RDlUdHB3ek5mMUVwdUZzU08wNTlk?=
 =?utf-8?B?TXFkSXhZb2M4aDF2RWJVZzErWmc1ZjROYTF4UXlDcVJVeHk5Z2xCVWdqTUl4?=
 =?utf-8?B?Z3ltNGtrN01nZmhZSnhIOEhtc2pTV0lCZWZFWjJHa2JwZkxMNjk5cmt1eERv?=
 =?utf-8?B?djVSV1JWQmxlMG53Um9TY1AzNmNsV25taTkyU1hmRnN0Ym0rM0Jab29sR3Bv?=
 =?utf-8?B?Z2RhR29Vakd2TDdrSzcwYStuUThMOERuSEJ2L0NsNHU0b2dJMTZoUldtcTNM?=
 =?utf-8?B?QkoyOTQ3VVNPcXZpZUExQ29Tcm5WMmFMM0VRZDNCQkpTb1p6bGk1a2IzMENC?=
 =?utf-8?B?eVYrVU1VMDNGZFp5Q3Z6RWxvK0J4UTFTa1AvTDBOMlVGTWtOdDdJb3pjdEFQ?=
 =?utf-8?B?U0RnaGpUUnBjMVJSN3hhZncxZWpYTm4rdkd3aVJXNUEzWG5KRjByUGx4L2NF?=
 =?utf-8?B?YmhEeWdxMXdOQ09rZkQraWNTcjMwOTEySkJzaG1CVS81aHhhTUY3Nk5WanJh?=
 =?utf-8?B?YmMzTXdKeVRJeEpDL01IZkRpQ2tpSWlZcXgyTW1xZGNyeVROSTBXWUFYVWgy?=
 =?utf-8?B?b1BwWXJzcVBDd0lTcmVsRmFVV0VuNERiV1pWM01kREtpOW5oeFA2V1hlaSta?=
 =?utf-8?B?dDV3N2RLQk93RU15eTVBZGlJaGlITWVpUHpHYlJpMDdaMmlXRzNVdjdhVTBD?=
 =?utf-8?B?TURHMDY5NXlYVlg1d3lFRmF1MFdvVFo3ZTcyMzZHQ1lVY2RBVmxacmQvMkFD?=
 =?utf-8?B?dEJwSThWY0d6RXJPTDFIbVdRYll4VVd5b0V5a3RIUFJEbVBpbTJjMnZzNEpx?=
 =?utf-8?B?T3gwaWdUbTRmUWdaWUlQK3hDdFJiWjBPRGJvcmI0SlFDaUVHdVhTdDdnbkVz?=
 =?utf-8?B?NWprRlBMK291VWJwUUpIOTFXV0VyeW00aXR6TGF1WUIzKzRVK3lQQ21pbmda?=
 =?utf-8?B?NEFvNlN4aWNaS2o5dllVbXRaMjNvM0liVGd3ZDMybGN4a2xnMU55U0kvT2Vz?=
 =?utf-8?B?N2ljVzU3ZFNtdlZiWmRscXJuajQ2YlZETXhENUlJVDRIbnF1UWw4YmNEcXl4?=
 =?utf-8?B?d1k5K3c1QnVuMnJDWlVZN29ZVzdxbDRrQjg1czBOeTI2NmZJUGYrWlpxdG42?=
 =?utf-8?B?c1BRUHBVcTVITCsxMmJhMlpmUGVSL1dGVmdmVzZTMHoyZlpBVEZYN3ZCRndT?=
 =?utf-8?B?Mi9wOGp1c2hxT1pzcXBsejR1bTdmbWs1b29LYzFMS0FhNGx3Z0dYVGZRVDNH?=
 =?utf-8?B?dmV0ZDZpOG15Z2hNcmgyWGVONW5qRTNHU1lwNEl1T09yeEtFLzlMeklmS2dS?=
 =?utf-8?B?Y0EzWjduWkZKM1dCS0Q3U25DeUtuQ3cwQndBZjIxdmF2K0xYNjBLTGoyZjZR?=
 =?utf-8?B?YzVocHh0MGxpNWkrQUwraDVLUTY5RHFVL0lvTjNMWW95aElYMkJOL0ZOc0NW?=
 =?utf-8?B?d2lKNmg5VnhqWVNwQUlyRTVJMytGYU5HcXI3UDFnRlNhZ21aSmVRSFRsM3BL?=
 =?utf-8?B?MVo0UHNiQXdhbEFlR3E1QVJJaTdNdmsrcHNvRlArQVlQQVpJM1RpQ1ZrdGhw?=
 =?utf-8?B?cUtYYk5jblpQc3phZ1dpYVJibmlka29xcjZqYnFGeDloRkFPRnc4cnB3K0xR?=
 =?utf-8?Q?VuTLAEI7OzmF6?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WUNoK1VaK3FaSjlYM01uanFNTnVNaXhGKy95Qk01eUkzS2xoeU1ETkN3Qk42?=
 =?utf-8?B?Uzd1elZ0ZWh5N05zSEpkSnM3aWlqWFNDUlBjcXRIVlhxSHU4Rlc5eUxET21a?=
 =?utf-8?B?bzVPZW9OSWNkR3kzdHpCMERVTFRlRFhwMnZ4dE5nQWNkdjhBRno0UVYreU9l?=
 =?utf-8?B?TVV2OXJZOHYxL1ltcnpPOXNyWDNCeGRZeUtKTWpod3BKVU9hVXNGT2hMeXJW?=
 =?utf-8?B?SnhTWTJiWEZzYmhKZ0pqMFVQTlo2Nm5UUE9JbW16UjJXUGxrMFcrU24vSmVY?=
 =?utf-8?B?RUFzNTd2Y1BtZVZYVm1UQlZ6NUtrcTAxN0pyeTd3d3JlMVhvdzB5ZG55UnJt?=
 =?utf-8?B?R1oraTZNcCt4ZkplbURvWlNJakFvQkh1azZLSnpyVTd6cCtjTlZtdFpDbkpX?=
 =?utf-8?B?NnlXdWtJbXFJVmsrNWpqdDhacGNnaHFCU1ZiWnp2REVuS092U01lQlkvRnVj?=
 =?utf-8?B?N2w1U0RxRGdJZmNsVU03dU9FcXVXMFJqZlNtRnE1bWJnR2JGRjZvQ3lGNkJq?=
 =?utf-8?B?UFlkTEozcC84MjQ4dk5Cb0JLOFZEZFJUTmJLeHEyRC9zRGd3akxoNVoxMWsx?=
 =?utf-8?B?ZkJzRGZSZlBhcUxBSlhvZ2I1TnhvWUNtRXlXSlhRVS8wTFVXcHAwL21vMmVx?=
 =?utf-8?B?MXM3V3U4bkJXUXdqM0trNGtjaHptOS9vRnQveGtXbGw0QWxyMGxSeUQvZTh4?=
 =?utf-8?B?ZG5LTWJ0U2pMY2RMWlE1Y1RJRjgwMWpWTnV4SllnL3EyUFVlVkVLNE9ZNzc4?=
 =?utf-8?B?Z2FjYnlTczM3WmlnSzh2eDhxc0N5MmNwWkJGYWhkYWNDNEJBNFM4Mkk2dFp3?=
 =?utf-8?B?Z3V2NHRpNXJqRU91eSswb1llMkdvMThkNDUzdG5RZEVkVmVGVGl3Wm8wQUt6?=
 =?utf-8?B?ZkpXM0JidkNza3JRZmlRYWw5WFB0Z3R6Uk9KTTByMkRoQWh2bXFZOENUaU5a?=
 =?utf-8?B?bmFNR0I5cjZheDVlalVyVzg3QVV5WjZGaFp1WVo1VERuc3JMRXRtdVNMdGdv?=
 =?utf-8?B?NlovUXEwcVNFR0NSVlFzQVgvcWIyb3FZMG0vR2piRkFRSzh3ZTM1Nk00T1ly?=
 =?utf-8?B?TUtwaVFzYzZDazBmdUZNZTlkUEJqTFlqTHBJOUJFOWxOSE8yNmNGZmVNZWp3?=
 =?utf-8?B?SnRINHJNNFNka0pDS2tzVWZ0eHdEaWVrc0QyaThab09ZZXRIWHdtQk8rb1ZN?=
 =?utf-8?B?K0hnL0MxZU4vY1h3YlpyV094MlIvaTJZVmM4Q3RoQWRsTXc0MTg1VFN0U0Vw?=
 =?utf-8?B?d2VpdVF6L00reHl3VnhtSHl4WjBxdEYwV0hENFZHM09pUDB3bG5nOHY0a2VW?=
 =?utf-8?B?L0kzTllVUnVadXlUa3NEa2Q5RXJZUlJmbnhMK0xwYy9Ma205WlNaM3N5cnRH?=
 =?utf-8?B?WVYyYVIxTkxTRVh4VTdyQ01uWWFXRkt4dmIvSmMxRTNvREVXODVFWVk5T3c4?=
 =?utf-8?B?aFM0RWx0RW95UkpmUG1VdzFNZWpnS1dUS3pXWnlEeHBlcllJaGRxdXQwZ1hM?=
 =?utf-8?B?NFR3RmRHT015TVVRZE5uYWx5SEJSZldxVS82SVNIK0k3QXRYZ0NqYlRhRU9W?=
 =?utf-8?B?SHN5ay83dEJGWkVTWjBWbzZNSVBZUk96ZGY0aThZR0hNLzdyQXBjRHorODZr?=
 =?utf-8?B?a2Z5QjEwS1o2eFE4UEpndjZ4ZFMxMS90SDR2dU8zQSt0RHJqWHNTeVg4UTdC?=
 =?utf-8?B?NUlYZHFnbFM3bko3M3lmTE02NzM5MkxjQUxIT2ZCRUZDbHhtNGkwN3lNK3lV?=
 =?utf-8?B?SVREZXJYdVhHdVh5RVB3QSs5eFJLV1JkNnBBN2dSU29NNFZ0cjNHR3pMNzhx?=
 =?utf-8?B?MitjZWVDWldIUnZad3kyWFRzenhPWnI0eDhlUWVTZjNNYkxycTI4Mk54cmNQ?=
 =?utf-8?B?UHExSHNiL29zZFZhUGxHaVBQMWFWeGdDclJnN09GMnpFRGdPYTIzbytObzBM?=
 =?utf-8?B?N2IydHRSWDZtTEtpSWc5SVZ3a1BGai9FZjI2cjhvN2p4emNwTjh1bXBFNXNo?=
 =?utf-8?B?VjZoRGJjVDVjYXVoYktIcW1odmVaSjFwL0NzUlQ2QnlPTEpNSExEdnltNis1?=
 =?utf-8?B?Z3JnWENlMSttL0dNOGxqK2Nud2g3REpIdStqYkNBdllwdzcyUkxHUTNVQm0r?=
 =?utf-8?Q?KEQuQFUp40/zuLl+SXz8dyJwM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e49afb2-b109-45b0-d10a-08dd475afa64
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 09:37:03.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Mo3T6qPcqJzUk23y7bv6USdjXRXP8I+kQ7HuLBFcImJ2CMDXne8jj8kU/dPSdG5kaHuid/wl1L0pQ8pp09v5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR10MB8618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Feb 2025 09:37:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17767

On 05.02.25 14:34, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> 
> Signed-off-by: sai ashrith sathujoda <sai.sathujoda@toshiba-tsip.com>
> ---
>  doc/README.security-testing.md | 28 +++++++++-------------------
>  1 file changed, 9 insertions(+), 19 deletions(-)
> 
> diff --git a/doc/README.security-testing.md b/doc/README.security-testing.md
> index c9540be..213fc82 100644
> --- a/doc/README.security-testing.md
> +++ b/doc/README.security-testing.md
> @@ -1,34 +1,24 @@
>  # CIP security testing
>  This document explains how to verify basic implementations of [CIP security requirements](https://gitlab.com/cip-project/cip-documents/-/blob/master/security/security_requirements.md) in the isar-cip-core security image using [cip-security-tests](https://gitlab.com/cip-project/cip-testing/cip-security-tests).
>  
> -# Pre-requisite
> +# Pre-requisites
>  - Necessary debian packages to implement CIP security requirements, include them in the recipe [cip-core-image-security.bb](recipes-core/images/cip-core-image-security.bb)
>  
>  - Pre configurations in the image, should be added in the `postinst` script of security-customizations [security-customizations/files/postinst](recipes-core/security-customizations/files/postinst)
>  
> -- To run `cip-security-tests` the image should need additional package `sshpass` and rootfs size should need atleast 5GB, add the below configuration in kas/opt/security.yml file
> -    ```
> -    local_conf_header:
> -        security_testing: |
> -            IMAGE_PREINSTALL:append=" sshpass"
> -            ROOTFS_EXTRA="5120"
> -    ```
> -
> -
>  # Build CIP security Linux image
>  Clone isar-cip-core repository
>  ```
>  host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>  host$ cd isar-cip-core
>  ```
> -Build Security Linux image by selecting necessary options
> +Build Security Linux image by selecting necessary options. The board, Kernel version and Debian release options chosen below are shown as an example.
>  ```
>  host$ ./kas-container menu
>      Select QEMU AMD64 (x86-64) as Target Board
> -    Select Kernel 5.10.x-cip as Kernel Options
> +    Select Kernel 5.10.x-cip as CIP Kernel version
>      Select bullseye (11) as Debian Release
> -    Select Flashable image as Image formats
> -    Select Security extensions Options
> +    Select Security extensions Option under Image features
>  Save & Build
>  ```
>  # Boot the Linux image
> @@ -41,22 +31,22 @@ host$ ./start-qemu.sh x86
>  ```
>  host$ git clone https://gitlab.com/cip-project/cip-testing/cip-security-tests
>  ```
> -- Add test user in Linux image to use while scp the `cip-security-tests`
> +- Add test user in Linux image to scp and run the `cip-security-tests`
>  ```
>  image$ adduser test
>  ```
>  - Copy `cip-security-tests` to Linux image using scp command
>  ```
> -host$  scp -r -P 22222 TCs/ test@127.0.0.1:/home/test/
> +host$ scp -r -P 22222 cip-security-tests/ test@127.0.0.1:/home/test/
>  ```
>  
> -# Run the test in Linux image
> +# Run the tests in Linux image
>  - Go to following directory and execute IEC Layer test
>  ```
> -image$ cd /home/test/TCs/cip-security-tests/iec-security-tests/singlenode-testcases/
> +image$ cd /home/test/cip-security-tests/iec-security-tests/singlenode-testcases/
>  image$ ./run_all.sh
>  ```
> -`run_all.sh` generates the test result in file `result_file.txt`, and output look like below.
> +`run_all.sh` generates the test result in file `result_file.txt`, and the output looks like below.
>  ```
>  TC_CR1.1-RE1_1+pass+11
>  TC_CR1.11_1+pass+22

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

