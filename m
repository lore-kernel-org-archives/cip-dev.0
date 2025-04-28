Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E713C369D5
	for <webhook@archiver.kernel.org>; Mon, 28 Apr 2025 12:01:49 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.65.31])
 by mx.groups.io with SMTP id smtpd.web11.46365.1745841700989894735
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Apr 2025 05:01:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Kq2QxWM3;
 spf=pass (domain: siemens.com, ip: 52.101.65.31, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SgS7Mx2xjhX6uKKgfT9G+5xEzxJ+bJX4K+Hlyzr8Car2paYcBEpqJeT7dOLMP2mhut11p7nOFGOT3uuYKjG0THer1jR9f8gPX8Goj8sIpiVUyKGCpkQ3L8YQcMkGpHz/CTJ1zF/uhag+gKcpVFGGmf+8fC7IQJWV2kn37hbe2q1ND3l8V6N3Vgav1oqqAywNK2nAKVZHh1qB/2iNV5lNGwASTDTJP1mNmf6m2nbV6ejiwve7olASktef9lZLHE5VtJWDbNjclG37SjequymmfBzDex/DWa/BqyQxNLGuGcJBnfij9Wg8lfN83W7/Qh6Z5FkT7OiK9A22kKygy+oeHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R15dd3VBRQLhwQsKr/x+tiJ7FhGl271p1PRDNL6TRH8=;
 b=ug5xOMhSMa1YV5v2P41VHJl3Jit28fITz9asQM2jaLPOefVcjFkQShPr7k5sJ2J/iTHwHYXwC90CTX9DuuCfh5BcNjAZa6tMVa9jdFGqv24TdT45Lio1NFsBSm86Vss3hAyF/5d09PKQ0bzzzMJXUjaWNdjbqOVDFKKPZn2TqMEbiKHbi1jPvr4xKRCbR3TYeIzKCWVOpHk8TRdYy7vJqThWUq04aXt1gJYM77QQrWGZciOhvIN7uxWKpms8kra63jb5S9WfHYLRDOYnyMez3+ZEqJwggmIFxWRngS2RF4CMcJu0dibi7qgmFYm58VJrSTU+aqDhuL83y/e1AU96iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R15dd3VBRQLhwQsKr/x+tiJ7FhGl271p1PRDNL6TRH8=;
 b=Kq2QxWM3FsCPEUF2Hk6dz1wLjMtl/+lIpU1RDtC+LxVyHJy8MRKabfVIBNCcJaEIvyW5BvZP2zPHZywdVbSV1jysVFZLC32dH2JHHpcTVLgkF/KUFtchR8zt048DcbCxx0NFOmF4JK6P5w6nvwIAByyDdm+sqLj+J0dJFMq8P/hn9Gyh2uxPEFkB934RgxtVD0si/y53b3ePQRybvmLTzXdv6xNZ+olaEKBdP59ebrXsUqIOx+4tZQxtbnGMz8TRkiYfOcwXvcdjvMf2UPn8CdByniR4Vnkeg079ysKitLAD27UDX3Va1ds1BkD/A6zGaf20NM5cs6G2ATVAZN5AjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:306::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 12:01:38 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 12:01:38 +0000
Message-ID: <eb95a2ac-f002-4e9a-88c6-aa901be15850@siemens.com>
Date: Mon, 28 Apr 2025 14:01:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] wic: Allow to set the binary name
 of the unfied-kernel-image
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250428114201.3210740-1-Quirin.Gylstorff@siemens.com>
 <dcbe3ee5-7b4d-465a-9742-9660ce673aec@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <dcbe3ee5-7b4d-465a-9742-9660ce673aec@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7953:EE_
X-MS-Office365-Filtering-Correlation-Id: ba990b5d-6987-46a9-7171-08dd864c6e22
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?QW5DTWFWSzdLYnZMQnI2N0RQREE0ODMvVFNqTWZ6RnR2R2xCVXY1RDgyblNX?=
 =?utf-8?B?VjU5MTdwTkdUSFFFOW1nMi8ya1JaRThDYWZyaldpNlRza0w3eEdpMDhQSm10?=
 =?utf-8?B?TGV0S2NFVi9RMVF2Ukt2TnZ3QXpxSC9nRzdBSVFhUnpyTitJanFXcVlLMmFw?=
 =?utf-8?B?UmgxNnMwWXdOS2h6R0Nla3JXQWVwY2xFZzU5NGQ2elF6WFBVMTdxVWVIVE1n?=
 =?utf-8?B?RVhaSFFBcFFBNFU1RjNWSE9yUGZjNjU1dWFqVmhOeGlTcFNRbjM3V0RvVDVO?=
 =?utf-8?B?QWlXNE4wbml6MWlCL2hoL0FkUnZWT0xPdVlJK21WRFlodDZMVXB1S2tGZFhP?=
 =?utf-8?B?aXFReHh6RTRSdFBtbDc3SmJKaGNraHhLWTd3MDhtUklzOW5DZjdZQTlBUnlB?=
 =?utf-8?B?Zk1XanYyL0RBVnpXUHBUK2hyOWo5Q212K0N5MDBWeHRLdGkyc1VRTlZmNHFT?=
 =?utf-8?B?V1RvaDJGMDMvSm9RTUlmdkhhL3RpUDFvaW1HYThUV1dWYlFPNW4yYnA5dDdL?=
 =?utf-8?B?L3RQTFpiWEhwUEhSWm9wTDYvY0F4cytLNjBkb2RJOGFVY1NIT3lTayt3L1la?=
 =?utf-8?B?MkhIQWpOektBZDh5Ti9YWFlkbjhhTXhxZWdnS2M1T3hyQ3lobi9vdHRydmtP?=
 =?utf-8?B?MlU5MlAzbjJ6dTJLTk1RNGZwUEJCWHRFZEgzNlFYSlJubFJZYmtqVnVUV0Ni?=
 =?utf-8?B?NmVCV3o4b1FwSDl4NGJEcGtWM0VYZ2dFMnZqZGdMVTQvekV0VmJKWmhqNWdv?=
 =?utf-8?B?ekpja2RzWWF6ZnZ0cXpReStTTFhaUUhLSGwxZkowM2J0QnQvNHJNT1U5WXNP?=
 =?utf-8?B?YVJvMUk2NmVQRUwweXhNdVFSUFFMQXUwendrK2szdHdoc3FIdjVvd3ZQcE93?=
 =?utf-8?B?anMvSXRqQVlLT0NHRjhLeFV6OU80ZFQvcTRPSXVNdDNOQkZLdDhtZFJOMWF3?=
 =?utf-8?B?V29QRGFHUXNra2QzNlJwcE9qUThTZlJuaVlBays2bkNFdmZhc3g1WHVBOU0y?=
 =?utf-8?B?dm9tL0ZBdHhWOXM4Y1A4TDU2WWFMbStieTJQMSs1NW9xRkp4c2IzdGVnd2tz?=
 =?utf-8?B?aVJscm1ZU3ZqY0MwYjJGZzFoZE1EYU1hVktTaEtFcEhVTCtmdXVLYVp1NEc2?=
 =?utf-8?B?cWtiM3JUV0dtM2dBWGRrZlo5elNoeTFkeWw0eEdEQmlNYkN4MFlKZ28vcm5n?=
 =?utf-8?B?SjJLUTJXZ1IvOFk5VnZvaVN0cGlqL2p1akVZekZOMDdIK1creEZiTlVTdm91?=
 =?utf-8?B?ZkFUYjNLcmVoNzgxUTFvOVpOMFJ6Rk1yVVFsVUVJQk5JbXlSZnlKeVRXcWpY?=
 =?utf-8?B?ZElhQ3ZoelpxZ3lTYitzNHUrZlZrYjloaHhuWUJ3M2RWZG5EczBuKzlMaUJt?=
 =?utf-8?B?eTFrd21kT1E2V0JVajdoaUQ0UmU1bFRxRjZCU2VXc25GeXhPck9tbWVmMit4?=
 =?utf-8?B?RisrS2NwUkdzbHZrTDR2TkYwNTlqUUlpbXRvaDJOWlNGeHdmYkUxOWFBdjVx?=
 =?utf-8?B?ZG5yWEhIclFOSC9lcThCTXdKL2JScEd4azdwa1pJaVFLbld2U3hkeGpzVG9L?=
 =?utf-8?B?WDJJOTRjVEVLWDV1RHE5eDYycUU4dWw4QmkyQlZ0QzVTQnVkY2JVY2ZlS00v?=
 =?utf-8?B?Z0lUWkNVcXBNaXNEUkVUbjhsODMzejRQSENUU1FrbmZiaXRROE4zYUdiNEhm?=
 =?utf-8?B?VWRLenNHRmIwWlp2SWI3ZGlnelRBQWxjbkYzV09saSs0MVJ3SEMvNGdLb2px?=
 =?utf-8?B?dTd1U3Z6OFg3OUxqdUIxNlkxdkRqZklkZTlYQ3FEWVV4Yjh4WGJCS1RhdTBF?=
 =?utf-8?B?QitEbXpyZ2IveEtNazdkMVY5YnpWc1FUZzVKMWI0VVI0UWVxRkpjTWVqQ24r?=
 =?utf-8?B?L0dGRzJ0eDkxNUZFOUR0RVZQeHZXUWFhaGJpU3ZReTJ3QWZiU01XTHNHYVJU?=
 =?utf-8?Q?qwrJklLJ9Hc=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WHh5b1lna1lCa2xWUENVcXR2ZFNFdnhxSzBGNllvMm8rbHN3bVRpRmJJWElG?=
 =?utf-8?B?T0QxWVRwUnh3bXZoY1NBenQ2am5ydnVTOHI4N1R0TmJRZkxiYlZ2K3RxRGs1?=
 =?utf-8?B?aWoyUzhmb3hrQTV1cDdIdEpDWStiZ3hoeDhhMGx0S05CWjR2Nnkwamo1MXlY?=
 =?utf-8?B?QWVDZENhSkIwK3h4bWdPOWMvK1QxdFhaZFYrUFhPdHR5SXpWRkIxNVd4OUM3?=
 =?utf-8?B?cWdObEJqb09EWkFEblZVdURITXYySEt5Tkx3VU9LMm5qVnVhRktJSnJBa21R?=
 =?utf-8?B?SmVqM2ZnSi9vVGJEOFkxa0xTT09PUmZudW53YUtscUVWeUhtQXEycjhYNEo4?=
 =?utf-8?B?UHh5b01yTW9CcHpvc3BBWEdRSnh0ZkxwalBxVDRiRU8xSTRmSGhBc3RrQmRK?=
 =?utf-8?B?MmFDUUxTVnp4NzIxTktNKy9PZ0hEV0hkUVhPNTh1RW5QVkNMMWh4QmNoVjJK?=
 =?utf-8?B?T0RsdFZXOW00VFY4NUVSRDE3Ukx4UlJyZjNYdGZudDVEajF3ejJBVzdYVWg1?=
 =?utf-8?B?NHYrZTZnUklOUHR2ODFIYkkwZ3dBUXBQOWZ6RUpTTkhDK0M4Zkl0VDk1RnMw?=
 =?utf-8?B?ZHRwcjR0dGVnaUFnR1d1QmtVV3YyL3Z0eHBaZFRmVjhBV2R1SmlqWXJubmQ4?=
 =?utf-8?B?YUFRWmhmVlQ3dWlocS9naFUxWHlrNEwrME5iRUIyZXRRVSt1UTd0S2N0b0hq?=
 =?utf-8?B?b1Q0SldjMjJBL0RubW5iRENXR2Zlcmt3djhJUzZzdU5RMWFVcjZhQlJvT2Fo?=
 =?utf-8?B?ZlhHamZaU3pDRXlTRW1rZkVTRU8xVWtCQWVxTE9xWWE1OTRVOWw1OG0vdXlO?=
 =?utf-8?B?ZWhIalhVQXpXZFBnbFdQa2NYbXcyU3RWZmZoeHUreWM3SEZOVG85YjhYU3pS?=
 =?utf-8?B?bGVOZ2Fza2x4aXFoZ0U0bXMxdzlYSlRyelhLclUybWlKMkJqdE5nakpva0lm?=
 =?utf-8?B?KzZBL1lPYkNnTStBTVQ0Vm9DbDZuNkxDb1lQNDhkdU91dXZxQVF2QVpGSXMw?=
 =?utf-8?B?MVp0RFBNSWg5QlJIQjJWRU1TWDd4bGk1RVlxb3pjZFZoenBpcktMYm9BWUlp?=
 =?utf-8?B?MkZoZlNQUzBFOGlOYkxWSSs3OS9kV21EQ3MyQUVmcHUrWHJpbmdIWlRZdnNx?=
 =?utf-8?B?ZlZKSlBuWThTRWVUTUIrdzJpT2dvNjlZdUpaaWl3SjRkczFDNTcvaUFtVm1I?=
 =?utf-8?B?L1hkOFgyTGFjcjh5a0JSQ3NSY1poTEo1YlF6SzdzaFZlUzFVVXkyUWZJK2tJ?=
 =?utf-8?B?WDg4OE1WTkdKZVdYSFhYck91elhQVkluZ1RxRSs0dm54TkhJVmNPVnlVU05X?=
 =?utf-8?B?ZUZ0eWdqeFJzaXRqdVZVM05Rc2tjVDBPZWxNbjZnNU5CU0J1djZJbyswYWtQ?=
 =?utf-8?B?ZzREU2gySXh4Y1doNDJ1OUM1NmNSV0NRUVVvb1NjcG04am9IR1E3c29ZbE1q?=
 =?utf-8?B?OTVJSHRsUUlRQ01KZGFLZnFFc1J0UTZueFVkU01qai9nbTZoNWVaOUYrNVcx?=
 =?utf-8?B?R3ZXUTlEUHQ2QmtxNWtDM0lRd3ZJNURHWGVFeEdFNTcrRkwvSWZiMkRVUGkw?=
 =?utf-8?B?U3dJaGhKNWFRQm5NcnhVVFlEVFZYUURBdy9BOHFaN2x1RXF6Z0xYUER3Z1NK?=
 =?utf-8?B?ZTRMajN0VUtjd2lLaGo5S0syd0tzbEJIWWZ6SkZIOFdhejV0L0J3STRIdU9o?=
 =?utf-8?B?azVHTXZrZkpOVzFJelY4aVhJYnNiOVc1MjIxcTlUV2lCOEQzdnNtTm1xNVV6?=
 =?utf-8?B?a1RTQ0VmMDREV1E0aU02RElhak03MUxpRnFLSWY0dEg2azRIOHNnWWZBRTd6?=
 =?utf-8?B?M2tkYzJ0UjhzVUhZN0w3RUxTM2g3MWdmdkYzeVgxTkRxMW9NdERVUWhTcVIw?=
 =?utf-8?B?aUpYZUY5MWIybEFheDBrc01WYjFLd3p5SjdtMThyeTREVjIwTnFFVlBBNjB1?=
 =?utf-8?B?VktUZ3BpSkV4eEMzU05LdW1Jbzc3REhuc055b3dlMkxmaDNDNWNHYU9HYUl6?=
 =?utf-8?B?TkN4VWV3L0tuVFp2dTczc3VRVkdrNUhlcndHVlJPY2RLanpYbjh5clkrYUJo?=
 =?utf-8?B?OWVtSDVDOFJJZThHM3I2QUNPeVpyVy9YMHVVd3lvQ1hidFgySFRpRWo3aldh?=
 =?utf-8?B?c2o4VUhTN3pxaWRRUngwUXlaZWRWWmFJTkR2UEtDNVNIaENETFpkVGU0TEJ4?=
 =?utf-8?B?ZUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba990b5d-6987-46a9-7171-08dd864c6e22
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 12:01:38.1807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D4Q/Dxy2yhL6y2PT2Rw/GulbZ07D/eiZGoqCeaYVbMIC0ndUAAT06sR4acNWKRoZcQKQHkcEwXJwKaK1JkKNaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Apr 2025 12:01:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18700

On 28.04.25 14:00, Jan Kiszka wrote:
> On 28.04.25 13:41, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This allows in case of a unified kernel(UKI) image based installer
>> to differ between the installer UKI and the target UKI.
>>
>> It also allows the build of multiple images for the same target
>> architecture or update file.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>  scripts/lib/wic/plugins/source/efibootguard-boot.py | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/scripts/lib/wic/plugins/source/efibootguard-boot.py b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> index 8b1097f..310d2cb 100644
>> --- a/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> +++ b/scripts/lib/wic/plugins/source/efibootguard-boot.py
>> @@ -178,7 +178,7 @@ class EfibootguardBootPlugin(SourcePlugin):
>>              .format(rootfs_path=rootfs_path,
>>                      libpath=libarch,
>>                      efiarch=efiarch)
>> -        uefi_kernel_name = "linux.efi"
>> +        uefi_kernel_name = get_bitbake_var('UNIFIED_KERNEL_IMAGE_NAME') or 'linux.efi'
> 
> Is variable name anything we should sync with other plugins or OE?
> 

And what about extending WICVARS?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

