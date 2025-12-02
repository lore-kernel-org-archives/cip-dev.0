Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F36ACFD2F6
	for <webhook@archiver.kernel.org>; Tue,  2 Dec 2025 10:02:20 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.48])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.4588.1764669738155857374
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Dec 2025 02:02:18 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=i1H10u22;
 spf=pass (domain: siemens.com, ip: 40.107.162.48, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTjelzBP+VG/JXxU1AOEE1hpygwg4Nks9Ulwc5JQs7awhBVOeqt/kaNSb1q9gwov4Fn03jEJMHTA5zTXcOnuJ9TuY+f50UpxFxTDDAqzgU8GZsDfrPl+ADlmN55GwPpBTniwcGjoiMkVrNQIfjatQJPubOYHqF5a/6Rqr1Me+OkL825Q1Ip8JFGhMYFXhs9oX4WezvSuJ08m/5qy5B/fYwId3kWd1LtdsqxH/azRJ/0vX1MnE4jBuENTJe2sUmeUe32QfzTKW58zhheNxXB+56OHy0rnZVolaPPc3YDuN9aSn8jjDQbmblYpJQR8vW9HFlDnixS2ViB/8DAQb04nNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vs8Sc13OCZb1DIZf9pTQMu1IkS2CKI8R9T5TGrK/H08=;
 b=Lod0DvBrVgP9HH1be3nsOCGZBNrWzanCevOLvD0Mdi0C1Ex8MHuUJ/S9WuP1GdsbIHgQTM+t1zXmJlkAr/6R8Wc2qPYamMo+5KBBg2wncI/8uZhJxlqlwRPTLWoNEvSLL0aLMMvYaFgmACME17+R3hWWh5a9c8gEfh/FoUFRyCtBVmnrkxOMDgLAgla/ED9XnuAgDDR31CHLayN4Lvlib/iEpZAbV7V8sJDBiFYb1pdCHEBLUrlSo7BcIriPpIL60wfzdXH18Kwc+84cB6moyggHhZ6C2GQR5U+1t7lijKc4k+7Pv7ldYSsd4OWOkEZcSRJcSL/0qxt72++n0zCayA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vs8Sc13OCZb1DIZf9pTQMu1IkS2CKI8R9T5TGrK/H08=;
 b=i1H10u22VpwNnYmIw6yVrYzdMftJcZmCWHFvxU0n1ch0TAuyM7FkfL+pb0aRAeZpeLWBREiP3HxTc+bDG5rnLB6/7ThA5MauRDqU+7rq3FFd/uG5jid/BF7OzXcFvfBBy1as4giE/IW8WR6LjxOInmDcIhuuH/3ZXjUsxrM0iUBJHrzDmJaDHI5zIkeRXDiT0XfV4MvoghJ890yRumQoY2KqrRL1G4MWUq/bI9F/Kqtj2z/jqL7bBVfYCVeVl2OOsnJuA5qMLwh4STL1tGL/LB7IEfgnhAj0dAgKJEt6RMvSIHvrfpI5YXZJ76RHXrGs6vzS0Jid3vsvmNQewNMT0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAWPR10MB7895.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:366::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 10:02:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 10:02:13 +0000
Message-ID: <fa67857f-1f61-44fa-b43b-7823e78e3076@siemens.com>
Date: Tue, 2 Dec 2025 11:02:11 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH 08/14] Kconfig: Do not offer
 swupdate or security options without a kernel
To: Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org
References: <cover.1764667279.git.jan.kiszka@siemens.com>
 <6b42744057af96e3f1c00918aeed3c5ad2e9202b.1764667279.git.jan.kiszka@siemens.com>
 <DENN2WDIIV2G.1W0RTBCWK231A@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <DENN2WDIIV2G.1W0RTBCWK231A@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAWPR10MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: fedc96e3-79c3-4a79-b8a5-08de3189dd9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cGpwZ1BBTFczYkpleUc2bmlJQ3JiL0JLaGo4Q3ZaZ2tLS0RVQVIzQmE3RUx6?=
 =?utf-8?B?eGFaWkU0MUtMWkYwS3lpbXRhMEM2N2l6Ukp2ZDFDN3ExTC91aE1WbHJwc3R4?=
 =?utf-8?B?cmNpaFFuWHI4L0w2UysrRjk1cUF0ZFZZazZMaE1nL0FpbHp1VHVvTEpSRVlI?=
 =?utf-8?B?RUJoRFdvUENkQy9DUXlQNEZGaEZBRnZyWFZkaGJod3htNm1BdkFBeTVKNTRG?=
 =?utf-8?B?QzBrMFRwMzNTQ3lqVnNtMGVVM0FCNFRrSURGN1VESHBHUjEvUkdxVFN1cmli?=
 =?utf-8?B?RW9iNTBmZ2t5ZkU3Y3I4MFlyR1pLeGNzTjdhbXVBeW9IMTNvQUhWQjdiZVlp?=
 =?utf-8?B?WEFYcGNrUUhVWVVMak8zZU5yaWdSSGVhL1BNeElDTHU3dXRwWEdYOFd5aWpK?=
 =?utf-8?B?TzBwdDhyRFZnWHVpK2xycm4zY0lIcTB2bHZXVWFUNVNESStjVG81UW9yQWZN?=
 =?utf-8?B?WXpEOSszODdjSE90S0s4b2thZDZUaWdhbE9xNDRkcHFtakVMbC8yem9idUlC?=
 =?utf-8?B?cUc4Z1ZYcS9pSlRPTDFXUlJYMXBGcHBSQTZCdzhCT2VGWWV1UmVCMVNpcG4z?=
 =?utf-8?B?MjJ6YzRwK2gxR0p0Sm9RVzVKTlhtOUdVVzBTSEo3bHlocm1IcmlNSkFWVVpV?=
 =?utf-8?B?T3Z3MW9mVHpyRGFRQndUNnFlZnY2ZVFsWlExMzFyK2ZrM2sxbFBpYVlKbnNJ?=
 =?utf-8?B?c2tueVFabk55Z1dndFlkSTFjaFlMZWdVTlRYL3VpcC9qaStYV1hQNVcyTWlX?=
 =?utf-8?B?b3p1NVdPaEFSUFFNN0MxdlZubmVhb1p6NmxsZnFBT1NaSUQwYVpmYUxwY3Mw?=
 =?utf-8?B?U2gwR0p1K3BsMm9RL2huSDlMWmJBZ2lCbTRXNzBtMFovRzFzZ1B2KytCM0xG?=
 =?utf-8?B?clk4Z3JYT2lDV3FPTU5qcThyMVJXOXM4UGxFMHJqbGs5N2pwdnVDLzZ4WGMr?=
 =?utf-8?B?SFBMZGlDM0w3U2JSSHlhZ1RIRWZhekJ5d1hzUWpRM0gyOTlzZG5BQldvQTVR?=
 =?utf-8?B?dEFnWUREVlVQcmdsWG51VDAzUkJKeUgzQWwrbXJjVzdac3hBSStMbHZ0YnVa?=
 =?utf-8?B?Vm4yYThQc1I2VDVpZ1Y0NUYyVmg4U3cvNnhmRW1XbHVQOTBBWmF6UE1oTDlD?=
 =?utf-8?B?b0wySElYRG9OQWlSRmtXUlZDYVNXeU9oRE1qV2lVb1NwYnBTZVd3enpuUiti?=
 =?utf-8?B?QmgvbjVsSWk5OGhzUjNyWVFmbmRuM1o5cWRJVTFPWkZxaVVGSkVUVGk4OHdB?=
 =?utf-8?B?ZTMyeDBBQkJzWnZSYWVqTWxsVWNXN1ErTFNpQ2lqeEJaOUZ2c2lGTkxmREsy?=
 =?utf-8?B?bmNScmdFQUVuckE1cWFWUkxEREViNEs2eXEvUE0wMXRITGVJY0w1MHVFeTFJ?=
 =?utf-8?B?SE5pYjkvTCtkcVNJclN2ZFB0bXd6ckdqM3NvVUVUanl4VS9YdU5tbVhSR1ZR?=
 =?utf-8?B?ZSs5TzhsNnc1MUw3aW1PNjdnNE9iREkrLzR6UXJReDExM2pHeFFBb1pNWkg2?=
 =?utf-8?B?Zmc1eUg2MTEvbm0xK1I4dWozelpXUFFYNXVrTFZmeUlyR1RsUHpka25WUzJo?=
 =?utf-8?B?UlAxTWVQbzNNd2IraXpoc0hmeWdlRndVS3ZZQzZ0NnNvbWowTWNqTmJWNlh2?=
 =?utf-8?B?aTFTa0NlQklUdmZ3VjFtS2FySmpmUFV5dWZlR2hTa1hDZ2xqU2VGZHV0TUhB?=
 =?utf-8?B?UlNyQ2hUZFhTMFV2aitmZjR1V3QxYTdGUlhIWjBvdUw5WGZHVy9WQXZJSnA1?=
 =?utf-8?B?V2lmTEhYVnhTVmRIUm5SRDJPTWdma2NKa2JWOFpWSnpMdkh6T2pQVE1oWSt6?=
 =?utf-8?B?bEUyb2tGbkF6alFsa3JsRHdHVmxsZFJTVXQ4TjdLdE1XeDBnYmJKVm1oMFdG?=
 =?utf-8?B?ekVReUJqRnZhQnFlTitPMm55UDl4YXI0TzZ3eXhwcFVrNVJkRTlWVEIwakp5?=
 =?utf-8?Q?FzDnJvgqCzaMSjLaR5o7NPE0plNmngtK?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dm44d2JMeFNkeWt6ekhxZDhzbXJBS0tmNWpJSllmTEM2ZnhTL1JxanJOWHps?=
 =?utf-8?B?cWJkTTA4K29VSE9UaFd1Ym1hSDZlbFpBRXkvOUdUbzFMVlBpYytWVDNlbDJI?=
 =?utf-8?B?UXlOZEZMYWg3L1B4b3RjSnNFd05abW5rTW5nQW91ZXU4SGRDNmcwcXZtZC9h?=
 =?utf-8?B?TUVaRG56MVBoNVAvV2w5WlpmZ3JndTh0eGZhcFoyUTdSbVpKZ080RnNxaGg5?=
 =?utf-8?B?Yzg2MjFmU3cydDdidE9MTElVU3I5OFVaNmQ0SHRkaFZFSTZTMTRPclBYbUlZ?=
 =?utf-8?B?RzlwbmMwcm9CRFUvVzBkcnI4UDVZQW03VWh3UjBNODdvMDV1T2FHSjVLODU4?=
 =?utf-8?B?aE5ob2daRHJQSXNSZnFhTE5NVEdkeE1ybUJ0a0dkOHlOS1hmRldGd1pmMG1E?=
 =?utf-8?B?bDFJd205MDFIajdjbUJOaGREaFJXanJsU1JEMnpWZkorRWVidnFBZHNFbmdB?=
 =?utf-8?B?UnhxeWRoWDh3cEpocjhwbGZ2czZHTXBUaWxIOTJOMzhWSGs2dWNiQnVLaGxl?=
 =?utf-8?B?SXl5bTFVdW54UTJoajEyY2FmVWZGbHgzR0J5cVhJSnNqZGNOSkVDa1Qvd3Aw?=
 =?utf-8?B?WTBYc1RqVGMxZ1AzblNqTjcxNHA2WGw3S1pjNWdNVlQ4V1hSK05DbCtoQ1N6?=
 =?utf-8?B?TU44REROSThIcVc0K0pCRXNNSXZyRXorR3NSSDNRYmFqZjZCWXg2d3ZKRENm?=
 =?utf-8?B?SGxDenBhMjN5eno4RFA3cTNnTWZUdC9FTVc1VG9Hdjl1RitUV1hZRjRyZjFr?=
 =?utf-8?B?RGtmNDB1dWcwcUsrM2hUNEJxMW90VXk2bllzL0F2WVN5VTlqYUNONnNzWlJM?=
 =?utf-8?B?cHFaaUwyWE9EMWRKKzVvQ0grRjFrT0dNV25rUStkM1FKM2NsOU9QbmtGVXZv?=
 =?utf-8?B?eWMxU0xpTEFYZUt0QlBCZTlOMXlTYjQrR3RoSnh4UStPVGNMcjBkenVtUE9L?=
 =?utf-8?B?RSt2d082NEhzQU0yTExaM0JGZ3h6WUdLVVhjZnBZQWQ2T0IwZmU3Mnp0eHRX?=
 =?utf-8?B?cUxXMUQ5eVJ2MThXUDkvTU93dkFwMjdsVnR3dDJiU0ZReDdSemg1NmhZbUJU?=
 =?utf-8?B?OHV4TFI1VkluWFFZeE5pQ0VkRW40SUdHTFFUZ0YvYjV2dTVYcFozano0bE5t?=
 =?utf-8?B?YzgrdWh4MGdPNlZrMkJBSWplM0ZPbUhZNGNybk1JbXFDa0FpZG4xLzYrWlRM?=
 =?utf-8?B?cTM3bnA1bHJySGhNMUlPWWp3RG00WExrMVowbWFBdjZxZ21SenYrYy84WFp0?=
 =?utf-8?B?MzJzWUplcW16bHlOUXNPelhRZWg0b3g5b3F3Q0x3K3d5Tm1lTm5SUldRS1k2?=
 =?utf-8?B?Q0Ruam5sYi8xMU9IdE1HeUlKY0xwdWd3SDFXL2t6VlgwcExKdlpSL0hCVllx?=
 =?utf-8?B?dlF2OVhUWTRobVF0MWRNVytzVGpja0sySEVnbGEwS282QzNFVTI3NGtna0NL?=
 =?utf-8?B?VkdyNU5VVFgveE5BSW9ObUpvYzlma0c3K25ZSDBHaVYvYXJncXdSQnM2WWdj?=
 =?utf-8?B?em9xakYxcVFqK05SWU0zVHJtenE1bXIvRGM5dWh5VURiUE9HZGlUTEZ3MUpR?=
 =?utf-8?B?S2hwVUJXOWhreXZpeFBnLzJsTE5ZUXlYcXJnREJoMWQ1VGd4Qkp5ZnJvazhD?=
 =?utf-8?B?TlQ3akdodjFCSDBTTlZETlhiWXlwdktRNXdUMkpsVCt2a3hrYnVlR09zM1hw?=
 =?utf-8?B?UDJJM0wyN1lZNktkTHBuRjhmL2lydEpJNHFRUkRmeFduOS9wT0J0UmkxVVB2?=
 =?utf-8?B?cm1qRWU0c1JpRThPU2hGRzZ0Wkk4Snd0dlBqa3ZkK0MvRm9CSXFUNHNSQXdh?=
 =?utf-8?B?SnpVcHV6ekhjVllFMkJOcEJQNmFnaVl0bjAyM1ZLUWd6OVRISUczSEVGUEtz?=
 =?utf-8?B?NE16SWdDYmN3VEZYTlBCTGdMV1N3TlBVSWIyaC9Fa3owK0w1K3NYajVmVFBQ?=
 =?utf-8?B?RGZaWnhjemNBRHhBYThKSXVTREdmcFhrTkJxTjlZV1ZNRjE4SUdMOFlna2tm?=
 =?utf-8?B?WWw1aEZ1WFZLbEFGWlNybi9MVU5mUlRxZzlTSVc3cFY3NnNnUFMvWG1DYXZT?=
 =?utf-8?B?LzNFWmFhWG1MdStHcW10THlDeXB5NFpVSmJQaXdMbk9GM29WM3QyZHZvZVBR?=
 =?utf-8?B?ZVcrN0tVZThGalluZVhBeTdKOEt5dGRHRGUyakxoRGlCUjB4OSsySENsWDY2?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fedc96e3-79c3-4a79-b8a5-08de3189dd9e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 10:02:13.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zCMgw2Ky1FKzqD4gHYecnaye3ZCmaKL7IXQQ9p0tVnAjoX2ROwtTYhGdkJGWc46S+53nl4Vhpoqx5EUgl/80Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7895
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Dec 2025 10:02:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20807

On 02.12.25 10:55, Florian Bezdeka wrote:
> On Tue Dec 2, 2025 at 10:21 AM CET, Jan Kiszka via lists.cip-project.org wrote:
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> Those variants only make sense for full images with a kernel.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>>  Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Kconfig b/Kconfig
>> index deb6044d..f8a93c2d 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -258,7 +258,7 @@ config KAS_INCLUDE_TESTING
>>  	string
>>  	default "kas/opt/test.yml" if IMAGE_TESTING
>>  
>> -if !KERNEL_4_4 && !KERNEL_4_19
>> +if !KERNEL_4_4 && !KERNEL_4_19 &&!NO_KERNEL
>                                    ^^^
> Missing space.
> 

Thanks, fixed locally.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

