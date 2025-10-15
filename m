Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C6FCCD18E
	for <webhook@archiver.kernel.org>; Wed, 15 Oct 2025 10:16:42 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.14])
 by mx.groups.io with SMTP id smtpd.web10.12530.1760523394868920579
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Oct 2025 03:16:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=r1oGn9Wi;
 spf=pass (domain: siemens.com, ip: 40.107.159.14, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqOZWcY/LDrX/rE3S/5FSwrxwZZ0VVMKNrDwuDk5q5fGWbSvHDTMeSxddGd/7DpCBnmwFgjfLvERD6Apdi/rc8kBMnNd87Yc0hrtBXWs7EikWSe21U2YeoZxF0EkDdn2JTir7a3iZzik6Wiih5fmVmQMldDirNFw8NxtTg8dxWDWxSZW+d4D6La5XC5LvyxhyZGVsiMaNQdiIQ2c4VgRUtMnDUHXH8fqZJMPw1RZDW935fMETW0oU1N9nrKnCPpqg5NVz/1Xz0ZU0ILzJU5jeLS5txnuXXGjVzBL2a2DSn2qNzTzO7OV4t6R3rfenVVknG1eM7hXE5XdMNEOu4X+3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhLYpNszv2oiDArjrsrBgW6nGFKTipEl2x7JllJ5yKs=;
 b=B3U+RemcED6QQj0Ne5HJKLJZYwM9tsHXQrXK2cjmqAGxvxFxHrEXlEiPqTCb33L68HHCrrgAAWQsRhFXjnsFHOaL/e8+sl3SURTMpfBD+3aPEK1jl6AAB5K4T/nIhrpogs+993UCSEY6I2YAszC63JK3nOAXW//0ma0CtNZw3rK+QL1/8zAX/rcb9OA+htiNpPLDtnORCj+KOgLRmuHHIvIiws4MdvuaOoFz3+bqM289JjdGDyrYWBfaQgDLtrzrnFPWffLVQUKF8XxhTXzz/WgGShfK/iy1DqegOggziJVjJn0vcI1QDoBafyA6vcH+l3gFE1KkQrAsa5/R3LILUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhLYpNszv2oiDArjrsrBgW6nGFKTipEl2x7JllJ5yKs=;
 b=r1oGn9WiwlOqFVN6FNfaIpBrZCtQxjk6S8mnIWvyLZx8gPqdf6gIZPoYJYTMwPnVbE0lRaJSsnjWLTbpKtgrBciFE5J67+7DrQKIjmqpBVi5a39YxdpPsbbEWFDIF4Rwk4LnDV3T8TB8RbKlSWzheqJ1n4Z8dk6LvQQTKlecX584cRT+s1kqpkN3c+sL0J1ebaqUiqq70lQzg4ESzuDi1tUU74V6a97yCGi/WQBmgaMab0TOjJqsh8hYwTLtsTTkAox52c2HhjXsZlmyeESaA0E436obSl/ukjUJb+5gEhGGB4o2iGRjGrZgZOBT3cAQaGxv4xvN7VBbtPtHJ67PWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by DU2PR10MB7648.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:490::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Wed, 15 Oct
 2025 10:16:29 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9228.009; Wed, 15 Oct 2025
 10:16:29 +0000
Message-ID: <160719b2-7915-48e3-9e63-eb08fa9d5c6b@siemens.com>
Date: Wed, 15 Oct 2025 12:16:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Jan Kiszka <jan.kiszka@siemens.com>, Adithya.Balakumar@toshiba-tsip.com,
 Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com,
 nobuhiro.iwamatsu.x90@mail.toshiba
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
 <dcc32fbe-2b53-40de-aca3-0bb0e9bdf481@siemens.com>
 <232ddcae-a297-4e7d-9898-f34edd3671f1@siemens.com>
 <TYWPR01MB110639A5228DE9FB8CAC93E4EC7EBA@TYWPR01MB11063.jpnprd01.prod.outlook.com>
 <0f2a5909-4746-452a-8f39-187eaa9e3cd1@siemens.com>
 <6fc52da1-ce17-412a-85b0-8e36187ed56e@siemens.com>
 <8bf58a7b-cea2-480f-bec6-bcba41d450dd@siemens.com>
 <TYCPR01MB96696580C7FDEB7E0CDC3782C4E8A@TYCPR01MB9669.jpnprd01.prod.outlook.com>
 <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <ce936062-26d5-4bee-8eb4-e2eadd1a37d0@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0285.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::19) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|DU2PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: d33ea955-8c24-4c1f-0822-08de0bd3e820
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RHE2QXFrT21BRTN2eENnbmdROGlGLzRJUVhiWm5WVWc3blNRaEJjMm1NWTJY?=
 =?utf-8?B?UE9Jd2xzNGJWbk9VU0NIa1BvcDRYa0FpZFN3WEcvWTdzbFN0V2FIVndRSWIr?=
 =?utf-8?B?QTdCV2tlREU5dHZ1MUpXSm9jOFhZOGMvMGV1TWEzWmlENXJRYkUvRGhscU1a?=
 =?utf-8?B?T1o3Vjd4aVY3akp4TEVyaXlUSlNpd0FlaStWV0VkOWtPeGFJNERlRGFBN3o1?=
 =?utf-8?B?WkgzZ0xjaDBGRmRaZEZsOTdicFFkUmRaWDN5cTgwZWNMV0lwUm9TeFVkS2xq?=
 =?utf-8?B?YVFPS2drWlVQUktIVVdDZHNaRy84bHZhK0lSNnpvNDJMS3dxYkZndjk2QXlB?=
 =?utf-8?B?amVqSUFON3k2cVc4RjlVRUhydGZMQjFMRkxMbDNjbEJUZWVQdXVhellacXVG?=
 =?utf-8?B?QW5oMGxySkg0Q2J4dUx5TStsRVB2MlhzSGh1NnlqeHkxU2txY0JkcTZCNDJv?=
 =?utf-8?B?QjJyQVNkdnNqWXdjSy9Wa2NsbG1SZ3MxZHp2TDFlUGMxUk16WHh3SVNEZTNo?=
 =?utf-8?B?QmxMVHJyK3pnR1B1dktTUlFaaEFCSXB2TXhPMFEzNFRPbWFKR1MzWVZLRDF0?=
 =?utf-8?B?ZUFhZkwwWEdKS2JJOFdHT1ZGTUg4SFJoR1ZyTGZFVEhUQ05kVFZXbTlYdXZ6?=
 =?utf-8?B?cWdnS0wvbGVNdkJmVklxOVd5cW96SjdHb2NxbjZTWE80WjNIdW8venErc2Jx?=
 =?utf-8?B?ZmhUelZROUY5dVZ6WCtXSWhGa1pvTWNTWDFLbHhsRlJ1dmN4L1Nxa1hBMkJj?=
 =?utf-8?B?UHlzV09CaFErMm9uNDlrOExzd0p1ZGhXZjZsaWZJcENOYkxCTURteEIvSmFN?=
 =?utf-8?B?QzdDZWNCV0tpTW8xVmFZenRoQmlESk5xM3JNU2dxMjZzREpjYzNXZVpqNUEv?=
 =?utf-8?B?NXlybGpXcFBqZjE5ZnJXWGhaOUYyQmZIcmdVTVlnQytaUFAzOUpTekg5My9p?=
 =?utf-8?B?cWJ0b2dQZjZFUThwaEwxUkFpK25qYmw5WmVERU9UdlMvZnNTR3VMbUw0WnZy?=
 =?utf-8?B?Sm04MndJdkxXZWZoUmpaMVF4REdHVlkxYWlUTlpXbmkySVBaK1ByUEdWYUxP?=
 =?utf-8?B?SjlaOUVxOGZqNTNqWk82Y3A0WURTYUNwTy8wWEdYVW5nQkFIL1NhME9pdys0?=
 =?utf-8?B?cTFhTzM2NXZtTlF5Q1FIY25pbDg1N3VVS2ljWkxpSDlreUF1cWhqT1N2YVA5?=
 =?utf-8?B?dE04UVVhR29KMXRyZHJ6RlRCVFZhVlZ6RHpheG03aVZ6YmdZQmZIaTNFR0Jn?=
 =?utf-8?B?VGpzdFovbVZwSjZFb0hSODBXcEhURzE4NFIwbE9LKzl3TVBJQTN3R0tSRm91?=
 =?utf-8?B?Tk9pQkRUQkVhTjY3TWx3enhzdXdDMk54Z21SbFdGY0pOaGlwNjg2SGZobHNE?=
 =?utf-8?B?aUhtaklmYTBLT0kxZmRURmhTNUdySDVET25QUVp1NXpKZkg5S3I5MDFteklS?=
 =?utf-8?B?QmFEWkxMUTVER1RndHh5b0xkSFdBMHhrb3F1M3ZFdXN3ajBZTmZBSUlCSW1O?=
 =?utf-8?B?U1ZwKzU5R3JxdFZ4SEZ4aXpxT2p1WWViU3d3Y3J5d3Vqczc1QXFNZTNLZmRm?=
 =?utf-8?B?aXQwMzdJOGh3aTRZZWU0SUFoQzc5SG1HUDRsRzhQSWtuZEJYZUcvQkI3MW1G?=
 =?utf-8?B?VzVWQmdQd0dpUDJDejd0cWpLYzNZZElrdm1ISFB6V3MvOGNLSDVTWXByV3Ny?=
 =?utf-8?B?VGI3L093Nmp0RVNQR29LWnN2K2s4eDZhQkQ3S21lSmNhSGRVMFBDQ1JUaFd2?=
 =?utf-8?B?cHZlNXduUDNFVTZRVCtrczB6M0ZOcTB0anIvcis2S1dpRFBPajZpZ212WWxI?=
 =?utf-8?B?K3ZLMDBzVE15OWVDTDYvRFpqUDdaTjNVeHZCMkRnZGlxQStUUzhaaEFpWTI2?=
 =?utf-8?B?TnhSL2hpbUU5ZlpRZWx3YzFIMWVaYlVIK1ZRa2pmeFpDa0E9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TkxKbjUwMUF2R2g3akxnUnVIYkt5NkFScTV0RnVwa09qTTl3bzhwQzZhSnRS?=
 =?utf-8?B?UE9LN3c2dFczQ1lMQzVFOTJFM2c3bytRSkVlaEl2YkRoUkU3MEl0a3VlbTcr?=
 =?utf-8?B?SWFINHFrSnVFT1o0Zmx6MFNZVXF4d2xPNDBZOElSU056STR3UmNQVFNWcW42?=
 =?utf-8?B?MTc1Qkp6MmhLdFpUcVlNVkJ2R2dYT1pMbFlIT0phdnovbmtDQlFYalM5VUN5?=
 =?utf-8?B?SlE3YUlZbXVlZlJPdWJqR21aejhWTklqOUVVbC8wZzJPd1Z4S1dHV29BSTZh?=
 =?utf-8?B?eS8rTmh5MDdFMTJGRmdqNDNBMkVVN095dysyV1dxTXdrWG5OKzZsMzNLWnpw?=
 =?utf-8?B?RW1DaTJMYmZwN0dUVjh6YVU4QXh3SHlhUUE4RXlmcDdibVdKMnROZENLZ2l6?=
 =?utf-8?B?TnlIRHU2NWNDSndMazdnSEZlcFJSaEFtdTI1TGh3bkkzODQyZTQyaW1UY0ZL?=
 =?utf-8?B?YW9OSnVVTVhpWWsxQnZHZDNXZlhDV0U5OWxMWm9ndW5ick5nR3dkVDRoejI5?=
 =?utf-8?B?MkFYWGVaa1dNd25rZVNSZWYxM2lvM2ZPNXJTbkdzVjN4S2hWVkdqZlBBSmNw?=
 =?utf-8?B?R0RqVFVwNnljRzRyUjRwTXRKWVhQaU9jVU1mYVFtQ01seS9BdnQ5VEhTL1J0?=
 =?utf-8?B?bVd4VHB3L3g4UVp1MWl5M3dxTWJOcFRLblNCd0JlZDVHbytNTHB3bWJxaGlH?=
 =?utf-8?B?bS9lNEE5NmFjWDQ3eE5iTXBnTkw2K2NYVkxnMUlSd25BNm9qdTVyOFhuVGwx?=
 =?utf-8?B?cGNRNEg4UXUrbUtNeUVOR3FvQlYvcysyV1pHWENoWGN2RXlGcUdHVkFQb2dk?=
 =?utf-8?B?d3owcElzWVlFMXp2TnR2enNOK0wwR3phU2FkV2Y3UitNNDRUSTZFLzE4TnZ5?=
 =?utf-8?B?WEFEaTJUcVQwZkFGTzVoVnhuWjE5QWY1RTl6MGlQRkhvSzBRZXNMQUNBME03?=
 =?utf-8?B?TEtmZUY4VzZQMjBNNHpDNkN2eitmM0V0RG1oQStyV3Q4dWl5SGlHSmw3NWQy?=
 =?utf-8?B?blpkNkpzZDZ6dndpME41UmhWR1R6U1QrNGh6TTNRN0NFT1BnNS9CdXhab1F3?=
 =?utf-8?B?Q3F1TUw2UFJYNzgxdUJaSkI4eklxU0pSTWZabEZVZGRMTUdsOUlzRCs4RjVx?=
 =?utf-8?B?ZWJmVXptTmdUQzQybjZKL21neGlZN0lUa1dHNjlRUXRFblUzZ2xHb09BMEJU?=
 =?utf-8?B?MWlmcDZMa3lNeEVNRHpNZGNRWGE0R0hpWTRrZGt1Ung1dHFkbGJEM09pU09i?=
 =?utf-8?B?dlRSRXRIWUgrcC90L3VNQ2k2MUpjMEFVTUZySzdzWEUvUGxnN3R1Y3Y4WURt?=
 =?utf-8?B?NTRaVEhiQ1FEb21BTUZpNm5FSEVscHhHdUd0NFNWb2N3ZDEzaVFrSWFFWmtB?=
 =?utf-8?B?b2FSRzdIa2RCdGgrTWNEemt0OWNTRjFpOXYzUkpGaHNERmZDU01sanlINXhF?=
 =?utf-8?B?YkM2YnByNWJQa2RNdmE2NUpQckQrWlVycGpPWnBLazMyRmN0WmdyeUR4Qi9B?=
 =?utf-8?B?N0plWFpGS2lOazFrVU5wYkdWc3JxN2xIRU9QNHhyM3BLMXRHRFc0RllzYlIz?=
 =?utf-8?B?eTY0ZVE1Z2JKd2tvcVJTSVdvNlYxR0c0aWVvc1RLVVVlNFVObHVKWjEvYWd0?=
 =?utf-8?B?YzFLOEg1OTBXdDVQVnR4bWhEZE5HMW44Zm5DT1FhazV3VlZuOGpFc2JrSlBJ?=
 =?utf-8?B?NE5ON1NzbW5BL3NER0piWkhmK09ScEkwUGtuYkZjQURXejhEKy9XOXJPYlVs?=
 =?utf-8?B?a1JlMlg1cEVTNFZaUTRzRXpaRHV5YUxLRjFmT3VYWHl4Z2NSMWNsUjB2dkFP?=
 =?utf-8?B?MGF5QkZwWXUvREUrbWZrZFF6cDBwd2JJek1HcUxMK2ZNTVJDQnJaZ29xQnhB?=
 =?utf-8?B?Z20vb29QN2NNNzM2a3MxTDVlVXUyalljbXNXSVh5NnBUZkV4SHpwczBkT3Ux?=
 =?utf-8?B?VVc4bDA4VzNjUUpVTS92a1QrUnpEdjBxVEsyZVpUdTRnWURnK005dE8wMzdk?=
 =?utf-8?B?WGZaRExNVDY2OXBKdUdqWHlwWlJNZlIxaTZ3WEJXNTFFbkxjb3hmYWRucXlN?=
 =?utf-8?B?c3FoZ2tTdCtDcFNSQ2xabnFOcDZEc0xNYUtTUk5PZmR4NW5aMUxvYVpVeHpK?=
 =?utf-8?B?UUJJV0VNSHFBM09LMUdxVGE4eE9RZXFQMlp4UUxrZmhWelc1NTZ0YmRteDZH?=
 =?utf-8?B?RUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d33ea955-8c24-4c1f-0822-08de0bd3e820
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 10:16:29.5334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 98CL0NwaBNjcEq5z7PkuOiWhaetxaw4HU1NEw/KJcRzqywv+fpwslhMbXYkLMKx2MWRJIyVFS8Yi4TSFh8E2Tmwm8ScRl17OcxdewtVs0/k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7648
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Oct 2025 10:16:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20179

Hi,

On 10/15/25 12:08, Jan Kiszka wrote:
> On 15.10.25 10:53, Adithya.Balakumar@toshiba-tsip.com wrote:
>> Hi Jan,
>>
>> Sorry to jump in here.
>>
>>> We may have a kernel configuration issue here - or a real CIP kernel
>>> regression. Going back a month to a passing test, we got this back then:
>>

these are the modules the debian kernel has loaded initially:
crc64                  20480  1 crc64_rocksoft
crc_t10dif             20480  1 t10_pi
crct10dif_generic      16384  0
mmc_block              57344  0
ahci                   49152  0
libahci                49152  1 ahci
sdhci_pci              81920  0
xhci_pci               24576  0
crct10dif_pclmul       16384  1
crct10dif_common       16384  3 
crct10dif_generic,crc_t10dif,crct10dif_pclmul
cqhci                  32768  1 sdhci_pci
i2c_kempld             16384  0
xhci_hcd              315392  1 xhci_pci
gpio_kempld            16384  0
libata                401408  2 libahci,ahci
crc32_pclmul           16384  0
igb                   270336  0
sdhci                  81920  1 sdhci_pci
usbcore               348160  4 xhci_hcd,usb_storage,xhci_pci,uas
i2c_i801               36864  0
kempld_core            16384  2 gpio_kempld,i2c_kempld
i2c_algo_bit           16384  1 igb
scsi_mod              286720  5 sd_mod,usb_storage,uas,libata,sg
crc32c_intel           24576  5
lpc_ich                28672  0
mmc_core              217088  4 sdhci,cqhci,mmc_block,sdhci_pci
i2c_smbus              20480  1 i2c_i801
usb_common             16384  2 xhci_hcd,usbcore
dca                    16384  1 igb
video                  65536  0
scsi_common            16384  5 scsi_mod,usb_storage,uas,libata,sg
fan                    20480  0
wmi                    36864  1 video
i2c_scmi               20480  0

See also https://lava.ciplatform.org/scheduler/job/1316606#L1301.

Quirin


>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>>> [3] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/
>> jobs/11344068159#L1724 <https://gitlab.com/cip-project/cip-core/isar-
>> cip-core/-/jobs/11344068159#L1724>
>>
>> What you are referring to in [3] is a qemu-amd64-IEC job (not M-COM).
>> QEMU IEC test jobs have always been quicker and are even now.
>>
>>> "The time taken to execute TC_CR1.9_1 is 28 seconds" [3]
>>
>> As far as I recall, I don't remember the IEC tests run this quick on the
>> LAVA M-COM. Apologies if I am mistaken.
>>
> 
> Right, I looked at the wrong log:
> 
> "The time taken to execute TC_CR1.9_1 is 304 seconds"
> (https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11344068162)
> 
> Still a bit faster than it is now (448 s).
> 
> Jan
> 


