Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A21B8C3ABBC
	for <webhook@archiver.kernel.org>; Mon, 12 May 2025 10:56:24 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.88])
 by mx.groups.io with SMTP id smtpd.web10.47414.1747047380827011136
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 May 2025 03:56:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bNwZrhad;
 spf=pass (domain: siemens.com, ip: 40.107.105.88, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edkCfW4x3Tv+8VnG1I7522D4OetRnUB+23YKRIN7CjkrnW8Dcp08Qvw4dkp4I7k1BwvnCSpIdt60yG3egNz6k/nH2D/PMe/q8R0wNT9C7UTNNVdDy1Fa4FQV+CB29RzgYRGRHV58PmNTDeLBtW/UOXXxz3xVZKm4W/W4yaf75xkeCwW01Nacal8Bk4GO/RpavTxgmH0knwZkeGBSt6kLVBv9PIDnhyLKBt6fLJDYmfR4iBnj+jpXuwaxMxIEU7g1GUc5Hvm0Fm3qII6y1dkPkbf8DnKdFtC6kKIxug2u4ZRDCusDz0LPFaYtvq8KrrfPZzi2SoCzOtyvVa29Iq0KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB55Bjrtd/XTm5AlzOPEN0rWK+UHG2GwagjaK8RIWdw=;
 b=O/cP3cPZ406aBkCwmyMHKzJN/hIEhVSTmuB/wL0YPTP+AcmfOisDiUQ/fkb0cKTKYiHGdvGc9PqG1JRjxoT9qtd+E3VqdKJFozDBeeUBOP1LiPedePsJvsJUq/ipzoWSij8X1rj1DLvz6zC8Oi79Namxr5BNoMg9e3PztXqxf8D7XA6m3VRM7N1FhkzU10ZLOHYnTyjQyqLR1Mrr63kp3dglcWq7K77DtqBgzWEr+ce4P+ttDSYyqTPZZqJuIz4iQrDMC0LjwBvttTmxoNFH/+GpwEldj07tg2oepm/vu7F3al1SKx+AbDJ4Hv5Yxn99ejHG/UNdV6jy3ZG2bB+oeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB55Bjrtd/XTm5AlzOPEN0rWK+UHG2GwagjaK8RIWdw=;
 b=bNwZrhadTXDlhaUpzj9mLj3/L5/VGChYWH0fIhwsPwwtfHSitFR55XhGr9wAfCDWE8j5WHwTLyxsla/mpEe7GUPhGe4ZjdJMs0IzCTWqpBdB4dlzPLnstle48kUVzyu4ZeYxvxWIlzuyO0PJGU0DsZnZfKYGWknSOuXVjSn7+4oR7asUNUPjb5BDYC/gsSKUfyLDXyQu8M4rz7ch/ro+tfwFDMIKI8ZFiJU17HULycw9XpGKqWW9JegkcPLyG5b1ReAP06JPczksc17aFtarYLXPC+Rk9OGhlSfqly9G5an/qfDKEO80lVkdk8Sx6OmvsQ41GmWoo5qI6VY7ib/4fA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB6714.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.27; Mon, 12 May
 2025 10:56:18 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%5]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 10:56:18 +0000
Message-ID: <41869980-3d6a-4547-9403-66a970ccd483@siemens.com>
Date: Mon, 12 May 2025 12:56:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Support for TI AM62P SK in isar-cip-core: U-Boot and Kernel
 Version Plans
To: "Adivi, Sai Sree Kartheek" <s-adivi@ti.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Cc: "Raghavendra, Vignesh" <vigneshr@ti.com>,
 "Khasim, Syed Mohammed" <khasim@ti.com>
References: <3574c4cc-2ab7-4e97-945c-24c959891eb6@email.android.com>
 <3a67fc32-2eba-4d2f-b4ed-c7e929d52d76@siemens.com>
 <edf08b49-384b-4b17-ae5a-8462e18cc52f@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <edf08b49-384b-4b17-ae5a-8462e18cc52f@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0042.namprd03.prod.outlook.com
 (2603:10b6:408:e7::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 88916036-5139-479d-d0bb-08dd91439f72
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bDU1Ylc0TGgxcHFyWjRJdUpwbFpjTjNZV2l0U0pVU3dYQm9FTSs0dU9DajRX?=
 =?utf-8?B?Q2ZOMkpIWWtXT0VYbFFIZVlKS1lEWFVaekp1b3ViYkErb0tMM005QWVFcnBV?=
 =?utf-8?B?WU5ONk9uRkdIdVNrcUZPUFVzRldXcTZtZEdhVkFsSmQ5b0xRYlhLS2NSdXdD?=
 =?utf-8?B?UnFXek1wS3ZMdUJHSnJJbFJISzI4cHhNZDVDTGtTSmtDSHBNdXMzV05KRVh1?=
 =?utf-8?B?Y2NNeVlpQUllbmJkNTBjMjBDOE1RRkE3YTFlTGY1SnhnUUExSGxOa0d3cXhT?=
 =?utf-8?B?T3MyY1B2MUtpajlobEpJcFoweW1hOFB6MG54aHdIcjFXa2M4eVArSnVtTjhM?=
 =?utf-8?B?KzZxNkw1OUJKMXJyWjlSMkhUUUJ2Y0R2Z1JJUVV1TVdUdVFMNExqUXVyM3ZD?=
 =?utf-8?B?bkZpSVpjYlk5M1N5ZlhrcUZ3clJwN2VnR1YyVk5UalVtb3ZNcmEvV05BQVRZ?=
 =?utf-8?B?QWFFeHZueTFYWkZESFBvZGdhQkRhSzBwdi92MHdTUGE4UUNXZ1h5RWIvRlM1?=
 =?utf-8?B?RDEvZXhZSXcvaW1ocUtiODM4L2EzU3BSRVFwNTZPcGpOcGpscTlmK0l4K2dx?=
 =?utf-8?B?MXRldk5VR05KeEpncFEzd0RVOGJXRW1FRG5kQ2tGdVpHb091bVpQd3JxS3Zv?=
 =?utf-8?B?QkVCTHd5NmJyeDFUaStlakt5SEUwbFI0SU5TMFpSNjBWbndZTWFsVUdYNGUx?=
 =?utf-8?B?V2NhajVlaFZxSjVBeFZXZmtiZmVha3BDT1dtNTUxalNPMDU1SS9memRHYWRB?=
 =?utf-8?B?L05MZnpmNjRPcTBnZEo1MiszVUtSYmFHQ3cwZ3hySFdXcEFySHEwR05JeUpB?=
 =?utf-8?B?ckhINXB3ZzJmY0lIWCtQR0dnaVZpRkdTaGhjZm1rd21oYVp1R29JY1d4c1RP?=
 =?utf-8?B?WjVIUHQ0WW81U1gvQXdXSWNUSHhvNDE1OU5OMjZqM0YzQ0Rubi9xRFdCY3J0?=
 =?utf-8?B?Y0F3bjZ1bjRTUzBOZTNKNWFLVjVEVGxXQVJwdXh5a3pwZGJhUkpLRUdPOEkr?=
 =?utf-8?B?Ylo0MTE2RzJaM2tlQU5rekkzbk5iNjU2NVdwM0pKSHl2YWYvcjJQdmxkcWNl?=
 =?utf-8?B?cmdTNnhWOFFIQk9oWXIyUHZaOXpJdnU3VWlmdjNjeStrRzE0N0dNSTFUMWdC?=
 =?utf-8?B?SjlQS3lQa1l3TzdQTENrNlhPSEhhYU1OZG9ralpBY1dlWWhhZlM5TGE1MFM3?=
 =?utf-8?B?b2pBNzRHUHl5RGhVZWlMOE1RRngyaFRYSElWTDZON0N1Z1Rpb2VWME9jTC9Y?=
 =?utf-8?B?dGs5TlMvSHZxWVRVWU5zdVU4NG41UkxvREM4SFRhTmhTeGJFYXdad082M2dY?=
 =?utf-8?B?RkVhcTJlTURjaDh1Q0pRc1BINUZMRWo2YjhRZXNWN2hsOWMwbm1jZlhSR1hM?=
 =?utf-8?B?b1A2OU1nS2ZqWUM4ekpsNVdXcWdtQlFYWW95ZXpjUWRqeSt6OWJENVlvbUlG?=
 =?utf-8?B?SmpJTElLOG9DT2pXVkJvUGdEcFhjY2c4UUdUM2N1eHNJcGtJVk9JR0NOOWpU?=
 =?utf-8?B?SG9MdVhDLzhPeHVraTlnVkZhcS9kZklGMVlHeHhQK21mcUd6NUNmWjRjYS9Z?=
 =?utf-8?B?MG84S0IvdHJVN3RxM3VoNm5WZGpuUlpaWFhOWnQ4UG9hWjdMVDBPb1VlY0Y0?=
 =?utf-8?B?d2xUb0ZHRVFyM2ZJZWt4VWczSlFtM21FOGY0c212TDZXNXVYaHVMbGdtWUE1?=
 =?utf-8?B?SytSVUYyaUhtZ1F4d3UxdGFFc0xqZmhrcHFkbmJRUjJjaVVxRUtKWHNGSEJE?=
 =?utf-8?B?QXJLaENtWmJvUlNUWE9WQ0JBVHJuTDcxTnpxcnE4YW1LZk4vaXEwK21oT2ZT?=
 =?utf-8?B?RHN6YUo3RTd1U2RHMUVZUUhieG5FTEtDRDdzM3Y4cEdELzU4OUxMZmlTQXpp?=
 =?utf-8?B?dHNGWU5iZDhTRzIyUFQ3VHZpVFpKeUljZWgzbHhtTWNEbEl1Mml1MXF5UkJK?=
 =?utf-8?Q?NeMQoclVZSk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cDRoUGs3VDVCWmRQeSticExBeWRoeWJRVVVLRklpb2VjZFJMRUJOSzNOOU9G?=
 =?utf-8?B?L0Npdk5XdUpmdGZqRzFKbDRqTlJYVmlaUXJLYmpwanN6U29Wa2Yvd2FPQmZZ?=
 =?utf-8?B?WlFhbGROUWtaejNwUjFJa2JERDlwK0NPVU1tNGN5aWtLbUQxUTRRdHhtM1pV?=
 =?utf-8?B?RXoyTk0xQVNPbStHUFo2YzNnUE1wTkhYZmhvV2N4WFNVaEVzakdJRkdaU2xS?=
 =?utf-8?B?YlFZSWVzOWw2aVNjd3o4NkZuK0tLREpqSU9nWkxBN2c4OFRSNzQzQXpvakZV?=
 =?utf-8?B?cjNIMnZXa0paeXZUenRZRm11d3h4TEF5YVRSZUt5L1ZnSmI4cnFuT3hCT3ox?=
 =?utf-8?B?YkNFQ29odDE2OTFBUCsvUjY4Sk1PVU40emlTVTUrTVJ6YkI2K3RRT0ZGdERQ?=
 =?utf-8?B?VEhHRDlsM3l1ZUt6ZHNvdURiYkJ4dGxuUklLSm5aNDFzejhOWlBodG5Kamsv?=
 =?utf-8?B?UStJSmlQOTJFV0FOT2FPaThOVGNnY0xnNjErSnY4cFNzU1JFZEQyOVRNWDBC?=
 =?utf-8?B?dlpSUUViNTdMMWpuUUZlSXY2azJpZWxmNm1nR2toejNYbHdnWGNIcElYY05n?=
 =?utf-8?B?M2xLaFYweW93MmJkVENIYThjc3pSZHc4aTc1aldIS1NkcFc0bEQwMXpXMzlE?=
 =?utf-8?B?ak5iQWxmUWVCdHM2UlJlZDNUbnp1THhiemY1SmVvdGpEQ0RnV3FJM3FTbmFk?=
 =?utf-8?B?d01lRHBNelhicjlTaE9BQm8yRUJ5TjdHMnQyUThXb0h5ZHpLc3F3Ri82ajJY?=
 =?utf-8?B?SWJjZTVxaU5md1V2emtManpOeTJkckhlbnQ5WXdzOStlQWI0V0Q5VWFFb2tl?=
 =?utf-8?B?bUxYZzJWTjFBSDNPbmYvSlhNd05WOEx1alk5WkFyWG9FMlZYblZQc2JHaVlP?=
 =?utf-8?B?S1d2SnlIR0xwZ2ZCTVpGWFIyUUlnRk9Ebmp0Yk9JUDVWRUdlay8zSlZ0ZlRI?=
 =?utf-8?B?clBxZU5JdHBRUXdXTjhFZDZJcFptOUtMbUlWdzB3VEhITmtZTHc1RXRSSG1L?=
 =?utf-8?B?V2ZZRW9yWkEvQUVzVVJCMVBwM2NSR01FK0NJQk9GV2p0NWNmSVBaRTBHQ0tC?=
 =?utf-8?B?ajNUZ24yZ1p5NUZiYnlnNzkva3pqVlI0YS9TazhEZFdyc1h3U0JRZGZ1UG5L?=
 =?utf-8?B?ZlJ4UjhiNkVWVWo4RlAzUThJbjNmaGZQWlhXek5yd1BHVGh2cGkzMGFKcC9o?=
 =?utf-8?B?dWZhbTB4RTZRVUFXUUFxRVRxcCt5UHdYUXdQMmpjSGNZMTgrZWZIeThPTmx4?=
 =?utf-8?B?MVQwM3FvZkg2RHRta1l5UkErN1F5ZklVb0hXcnlhSWpUdmJXUDErVWZoVGRT?=
 =?utf-8?B?M3pkUnI0YzEzUlNZVlkxY0FoeUJrYmM3QytCQ2kyNzFmcjRPck9ZK2lQYTNs?=
 =?utf-8?B?MGpSN1h2QXVvTmZBTkp2ZlZzM3cvdEFmYjg3YlJCaDBsbHhML2VJZDFQcVBy?=
 =?utf-8?B?R2lkRXltREFUQ3BPUVpNd3p6RXc2V0hNVW10Ri9HdnliL0VNcWZCMGtreWF0?=
 =?utf-8?B?ci8wSWxzZ1ZrSm9kaDM4NTE3MXFGazdlUDdzNDcrWjcvVW00S3pVWHMrOEEr?=
 =?utf-8?B?ZjUzWUVVb3pHTEsyWXhod01HbXJLY1J5elhCN1Erb1o3dnRFWWNjdEF3WkJO?=
 =?utf-8?B?T0ZwWXpvNnhqL1g4Y0djU2VlWERGRncwTitKUTJ5cXZEOU1lNHJKYzYxQ1Y5?=
 =?utf-8?B?VkE0NHpRaUZ5Y2o1N3Vybk80ZU1UWWczanlvT2VtQUovSFZLa0xiMjM4c21O?=
 =?utf-8?B?eG5oeVVzZTRkMlM2L1ZpOHg1UnRsOEN5QnMwZ2tpL2c3VW9DbUJBeXdvTDdm?=
 =?utf-8?B?aUU2R2FpTkwveHRsR2tBS1Bybk54Z1lNRHBMRzM0SE5rUXF0QjlQeTFFL0F4?=
 =?utf-8?B?SXBBdU8rMEorc21hUFEvVUxQMStwcEpwM3RoakpZcmJTZEdhWkRhQmhCbitV?=
 =?utf-8?B?UWwzdEJpQlpWYnE4NXRiTlJXTnVQQmh4ZUNHczdsOE8yZEN2MldxRm5yc0ps?=
 =?utf-8?B?bXAzYm1PdE5nbTJINzRXWE5xNlprYVlTbWRWcVF6U2NJQjM0U3NxZEcxOFA3?=
 =?utf-8?B?RVUyVFo3SWFOdnJ1QXkwemVyYnRGbytlT3ZMZ1J1WlAxd044dEo1WnpYa0d2?=
 =?utf-8?Q?uuGin/fQLqkalBG6PqCzDVLGW?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88916036-5139-479d-d0bb-08dd91439f72
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 10:56:18.2606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9is3ss1LO/rN5gHTsEFA3uCeM9SSgCCUnuK43ym7kTmwVygaz57s83shhFTih56DZuQmy5dhn/2zyJqgE/Rc0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6714
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 May 2025 10:56:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18896

On 12.05.25 12:50, Adivi, Sai Sree Kartheek wrote:
> 
> 
> On 5/12/2025 12:20 PM, Jan Kiszka wrote:
>> On 11.05.25 19:37, Adivi, Sai Sree Kartheek wrote:
>>> Dear CIP Developers,
>>>
>>> I am planning to add support for the TI AM62P SK platform to the isar-
>>> cip-core project. However, I have a couple of questions regarding
>>> version alignments for both U-Boot and the Linux Kernel:
>>>
>>> 1. U-Boot:
>>> Currently, isar-cip-core uses U-Boot 2024.01 across all supported
>>> platforms. The TI AM62P SK platform is supported only from U-Boot
>>> version 2025.01 onwards.
>>>
>>> What is the current plan or timeline for updating isar-cip-core to U-
>>> Boot 2025.01?
>>>
>>
>> This is demand-driven, specifically as the U-Boot recipes are only
>> helpers for the demo/test images, not part of CIP's regular support.
>>
>>> Alternatively, would it be acceptable to introduce U-Boot 2025.01 only
>>> for TI AM62P SK while retaining 2024.01 for other platforms?
>>
>> Only if really needed. Default is updating them all. U-Boot has no
>> stable lines, so this is generally recommended anyway.
> 
> Jan, Thanks for the inputs. For u-boot, I'll proceed with a recipe for
> 2025.01 specifically for TI AM62P SK for now. That said, I'm curious to
> hear thoughts from everyone else on updating all platforms to 2025.01,
> as a consistent version might be easier to maintain.
> 

Only bbb and qemu are using U-Boot in isar-cip-core, so please update
them as well as I don't want to pile up legacy versions in upstream. We
will support with testing if you do not have BeagleBone Black in reach
;). If we should actually run into update issue, we can still decide to
split by then.

>>
>>>
>>> 2. Linux Kernel:
>>> I noticed that a branch for 6.12.y-cip has been created. Since TI AM62P
>>> SK support is not available in the current 6.1.y-cip kernel, we would
>>> prefer to use the 6.12 baseline rather than backporting support to
>>> 6.1.y-cip.
>>>
>>> Is there a plan/timeline for integrating the 6.12.y-cip kernel into
>>> isar-cip-core?
>>>
>>
>> Once it has been tagged, but that should happen rather soon. We
>> currently do not have any cip kernel recipe to track latest branch
>> heads. Adding such an option would not be a big deal (see e.g.
>> xenomai-images), but no one asked for it so far. Would you see benefits
>> in having such a recipe also in the future?
> 
> IMO, having a recipe that tracks the latest branch head (eg. 6.12.y-cip)
> could be helpful especially during bring-up of newer platforms like
> AM62P before the tags are available. It might be worth considering.

Then let's try to model that. Could become a kas/opt/cip-head.yml (and
an checkbox in the menu) so that it switches all cip kernels to their
respective branch heads. If you need support, let me know.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

