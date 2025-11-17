Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F51CEBF61
	for <webhook@archiver.kernel.org>; Mon, 17 Nov 2025 13:17:33 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.15])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9052.1763385433194681776
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Nov 2025 05:17:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=QHk1nfDe;
 spf=temperror, err=temporary DNS error (domain: siemens.com, ip: 52.101.65.15, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DbWKRfF0+9HlkdxO1K/YCU65lB06oAz7hy2rltBr8g7ys3nk0xYouDUyRi44fiGqLHCIBjyK508q6/a9LA49QmYWT09eaPM2U7wOvErBKb3eyKgekjpBLXjPq+K7q6q6e7wgTNRGy+wjGnWhuTCOq5JoQUFHH2ryfOwKOB3MP109ew//PDVBhDg6imb8Py9YQb6gAFbOm8O1KF8qXybwi2Omsm8m5FfHzwp1HdomUD1sNcwA6V7+uDrZc73lHsKfYViWTNQLXogtyGh0nwiOSW2/lxsYbkp+T74J3f0mbxWt2lqibNOusTIQro263EVAAxToXUYCgC76aFCQGUPCJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVRM7lqLHg3ycUP9vW47KSnciBuw5KmwaaVdcgfqkL4=;
 b=B25YpFTz+5Ri3Nolg6Lazir+RHLOU9QSZ5/S/eF1f4LvxNl9BL0uwMzw49PcD7sKLFtvNYW9V0FdRFrKwlPV328J5HzsUy+Bb5ovk4iwadZUZ4aAWS8fPSwMomSuREls00zRC7znPAMQ8iZ5uEdFm81xSwueME0kIhp6FGcdcqY/AkfoEhvppx6dyXWIkLcEunWvKIw+peRz5bqwcIjINtNXAAYxMbgbj825G0YqNlD6Fb1zFpHq1H7S46mNulQWOae79TRexAhEplNenoqb9OBXuc96SkpDDTA9qLQRGDyfwI2VLkAoGURTcjWGJbnftpcyARTAIAvIVJpN1jYxDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVRM7lqLHg3ycUP9vW47KSnciBuw5KmwaaVdcgfqkL4=;
 b=QHk1nfDe7ToFFgDTnbeeqI9Qg96255Wa+kFXIMSaqaEXKnlv1/phelj1WC7PCBBaLrS/hRHq7kgZs2Dumu90hnVguTusC5Sl8wpaV9ji/jSu3gFTRYu1EcdnP0zSpQXSqVmcRN1yDke2NjObZ8ZLGCwM90e31M+GKtBLzb+fnwaUm5mmS1PD8ck/3sxqZz3tLIwG1EQOQijbFOI3Ez8D8KXwMELVlogojNtmiE2PupgBP6sbKwxGouIgjYpUkcI9vX10Gi1G4MOK0+Q31rVHUdv5ZQPw5JaQApEJXz0/txYSeN61S2j1ZrTnIfv9JMn0v2ndycmyx5rCh4R3o8CkVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7297.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:607::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 13:17:06 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 13:17:05 +0000
Message-ID: <6917d2e7-3445-46f8-b2f5-16e2054f232c@siemens.com>
Date: Mon, 17 Nov 2025 14:17:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Testing on hihope-rzg2m (was: Re: [cip-dev] Testing isar-cip-core on
 the iwg20d)
From: Jan Kiszka <jan.kiszka@siemens.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Chris Paterson <Chris.Paterson2@renesas.com>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <a0f4d994-2f70-4bad-b823-b3bf1a373fce@siemens.com>
 <5cd84b25-4709-4813-9d38-2652810874bf@siemens.com>
 <TY3PR01MB11346468D1012CFB886455D8286CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <52e217f0-5cbb-451d-ad56-4c30927b99f3@siemens.com>
 <TY3PR01MB11346CDEF02F029DD1B64560786CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <70790d7a-1ac9-4c7b-acc6-2ee4edc4a472@siemens.com>
 <1877EA27D24C204E.1114802@lists.cip-project.org>
 <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
 <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
 <TY3PR01MB113465454940A82FAC538AA8A86C9A@TY3PR01MB11346.jpnprd01.prod.outlook.com>
 <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <5d00d5d6-5b13-4ecb-bb9f-e3724d96e6da@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0434.namprd03.prod.outlook.com
 (2603:10b6:610:10e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: b561574d-7c0a-4ce6-a932-08de25db9a66
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VjArYUMzNHNvL1hhOVMyZDkyckZIOWU5MEt2elVaSEJPU0dJdzJpZ2E3QW9i?=
 =?utf-8?B?MDNmRjYvOTBSUzJWOUVEbGFQeFJkbjZNVXVHZkdySHZVUUk4Vk04TWFhVzJC?=
 =?utf-8?B?OTE5bUZVaWZkMHV1bnpFWVJQL1RHSC9iN0lTTm9yOEljNmRONmUwdTJWWXgw?=
 =?utf-8?B?aWthNm81eTlZMWRFTURRTVNSakd0N0ZCd2tsekp4aUo0WTZzbXdlU1RkSDdx?=
 =?utf-8?B?RHFGN0dCOEpJa0JiajZPT29DZElmd1FyK2J1QUVSUDl2em1IQkEzQi92OGZW?=
 =?utf-8?B?WUFwN2xTS2sxRnJsM21idEdIUUFGSlVYMzRQb2FhbXU4dXdnZHB5KzN2eWUy?=
 =?utf-8?B?bHgzQW1RZGtnNlo5dEsrMk5JeHVRR3NWQXBXaUM3cGt2UzA4cmJUdjAwN0Jp?=
 =?utf-8?B?VmRCTHJxWWs0L0tZUUxGYXliTEFpMUM3NUo2VG9QaGhzVnlGYnExeU9UYVg3?=
 =?utf-8?B?eXZLZEd4TlB6VWxITmkvZXFvR0xyTityeTg5S2djVUZMcy9RSlZDekUwUWU2?=
 =?utf-8?B?RjVvYlVvaklEbnowRkZJU1ZpZEt1VFA5SEV1aGFENHoybHRJN1lKeExGSFJl?=
 =?utf-8?B?RmVrNHErSStxZUUwZEhEeE1iTzJCd0tEN0kwTkdueGdLeEZWd3U2SHkyVFU3?=
 =?utf-8?B?SDg5R3BuUlZpQk1CdWQ4dzNlTVpNNisweUNhVUJMSVlES2NsZ1BselhTa29Q?=
 =?utf-8?B?OVBuSUdnanVRSnFKSXpZaEViemZzSWNBSzltR3A4b0srVUFYL0ZiR3dveElK?=
 =?utf-8?B?RXAvNDFaYTVpbFVnQnNKdXc2ZFlDemFld0hSaENUVFlhUEowaVROMERvMWIx?=
 =?utf-8?B?VGE5QUViVUJ6WU5MdWVYRmVyMWJ5alF3WW9aSmhnY3JFblEvOU0rOEd3bi8x?=
 =?utf-8?B?dGJZdVREalVVZ3Eya1ljbFlNdHRZY2NEV0dzUHlvWEpQYTUxUHdTbjdlYWV4?=
 =?utf-8?B?Z1lPZHpzY25mR0lTc1JEYktsSEtsNU02YjB5cTA0NXFPUERVaysrcWtiaWFM?=
 =?utf-8?B?ZFVXYWtGVXpHa05DNmlTQlFYQm1WM05wdmpIem41UnJtN0pHVzBNbitJc1gx?=
 =?utf-8?B?bGsrS1g0dFJXTkxUajg2WTcwTExHSEwyLzdiYUYvOGorVHZCdDd0SSttMEpQ?=
 =?utf-8?B?NDB0OTJEVzBRODcvRmM1VkR0cS9QSDhWYXFVaWdzajhqM0lwQmVRd1FCV2p3?=
 =?utf-8?B?ZGxLejBERHp6OU1Hd3ZXSEZxU205clVXdHRBdjFJVG90TS9LbzZ6bEZTaGUy?=
 =?utf-8?B?clYxRHBvSmlEd3ZlR0lUTzlRd2RPNDBEcDg1N1grcnpZWVNWcW9FTzEyek5P?=
 =?utf-8?B?bVl5alI2ZHFTUGhlWlFzdnd3T1M5R3NuTFRMVHAzbnRQVE8vYk5DMlNhdGJ5?=
 =?utf-8?B?M0dGa0xBSDk0K0NBei9MdkM5bkc4UG82blVoTTQzOE81UHhpU2ZyR1VSSEhY?=
 =?utf-8?B?VTlrc2trLzdPQUFudWFzemFuSEF3dTQ2SHp6dVR2TzNFcDVSNngvdkcrbVFa?=
 =?utf-8?B?NWZheUl1Zit1NW9qblc5NnJVeFp6dzh4ZjdDYmtQdXErVkhseWtmR2g4dmVJ?=
 =?utf-8?B?aHZIenl5WXhKdlBIaHZReldIU3hIVDZtc1NGNGpIRUxSTThnbVVaRjFQeDlp?=
 =?utf-8?B?aTFjUkMrZzM4SExwVmVaeVhDTTB0aFlBRkhENisyNVpxbUgwSDFPV2dhQ3NL?=
 =?utf-8?B?ZGdabDNvcGxCZ1JHcStqQTFlcGdmakhVUGwxUFY5K3JDVGNuNnFtWjF3N1Bt?=
 =?utf-8?B?bGg4c3Y2dG1zVmNBQ2ZPSlNzb2VJbGZFT2VjYzdRTFk2VVRFWWV3V25wMlJX?=
 =?utf-8?B?bXFWVXBSU2FGZzZJY3huUUxWQi9EQXZGNzk5ajlkUmJXaHp1T1A5cEwwcElx?=
 =?utf-8?B?NTdpRytQdW9YRU8zbWV2QWpmT29sbTdyYi9CNTdVZndleVhJYTAwWFlyUktL?=
 =?utf-8?Q?KkHGPbqtXq4t3QTeF3GIq5hSGzSJuB6g?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?N2hXNUUwNnYzOVc5KytHRkwvUWJmWjVjd3p5OFZWVGRrUjc1WjNxdS9pWk10?=
 =?utf-8?B?aHlETVlPajVDcjZnSmpCSmVOVkZsQVMyaWk2RUttRTliYk1iVXJqMXFGNlFz?=
 =?utf-8?B?bnNZTWFWZHhQZmZUNkFqbVFPcitqRUZFeFZnekpBU2Z2MWxwK09ZSDloc0dj?=
 =?utf-8?B?RmxoQkVXUkx3cmxPNFNiKytIbDFwQkMyNGJpbGxVTzNaaGNWY0h2bTA5RXhC?=
 =?utf-8?B?elpEQkZ6Rm9Wa3dKYk9DREh5ck1VbmEzSTMya2lFS3hQL0NxV1NSenNxOWZw?=
 =?utf-8?B?eSsxbzQ5TDU3dVJsM0Y1ZmhYNjBsamY4VmR5WDNXMlBibU5ieWJGL01BNVlW?=
 =?utf-8?B?NlFtcmpvK2tJWEVsMGVhQzR5TUszY01KN3NUTldCYzU3QWtpdEtkOEUvMGIy?=
 =?utf-8?B?bG92Q3BvNmFZaW4zOW5keEhiUDE3eUZmSml3MGt1Vm1tcUZpK3p0MnY2QXRV?=
 =?utf-8?B?cStPZjdxRUE5R1VzaURmZGFNL1owZzhnVDdVaTFUQnBaekpPaVp3SXo1a0xq?=
 =?utf-8?B?UFBMYmJFUWdBUjZHZndsVEtjMlFLKzZTWWVqaEhabENITjZKdGY1OWpKWWRx?=
 =?utf-8?B?TW9ScEs2Y3AwVW1NZUV3Sm1LbHhRZ1pFcCtjZkVpb285NUpHZ21VYnBiWkFH?=
 =?utf-8?B?dU1hZHc2Z0tuemRtcUNveEZHaWhxUDFsSWtocGNJLzFDdldDeTFramdQUTlF?=
 =?utf-8?B?RWtVS2x0QnhxbTF0TTVLSHIzM0ZpRnl5TUVWVktTcnFvTzM5WkxlMkdPeUJQ?=
 =?utf-8?B?ZHZTRW9xODVVdjdDaklXRFVZbk03ZnBvQ0RSOEpuOUJFZlVmV0I0MGZLcXB6?=
 =?utf-8?B?cTFEVzlSUHVHakM5OC9TK0pTNHRwdkpKQlhwQUlWNGpoRXFza3J3UnVjeWJT?=
 =?utf-8?B?SlduRmFZZ3c2REUzZTB2b3o1ZHJVQmhrU0xtaGhhc3JsMFVUYmlrT1VNck9J?=
 =?utf-8?B?ait0TWgramh6cmVXMWt4aUVQc0hLdDY2T25aOWZWN0g2UThwVTcwS0dTM1U3?=
 =?utf-8?B?OG52ekF5Z1FQZ21qbFFScUlXK0Z1QmpUZEorTURnSWFYbnZvOUJ1R2lmdE5T?=
 =?utf-8?B?bnU4WVREQjhBa1VaRVM4UG01Y1AxcWdiK213NHBUb0FIaTlPcWZiM2lHU1pK?=
 =?utf-8?B?ODEvYkpySk92UENLeE8rTzZ4RFB3OFo3SXJFTXBKaGowMWF5WllneDNjWEEy?=
 =?utf-8?B?UXI1aDVLK1V0WUdDcnVSQ0ZMdkk4M1BWTG5wSWRXMHUyV2pWRE5mOThwYzFz?=
 =?utf-8?B?NnBEQm1DVGZKMUFDWUlvaVZmWC8ybG1KZ2tseUdyUm80cEtqM1R0d251RWRw?=
 =?utf-8?B?VjFaZGVhRU5VS24vRDZCeENmRXJPdDlKWGFNcDZMcE1ySzIvNDZld1Y5czR6?=
 =?utf-8?B?WjRWbTlXTlhXR1BOL1BOT0xiVFRDS0VFTE5rN2lyak1mZFh3RXVaOUZpRWpL?=
 =?utf-8?B?NDVoWWF5NmZsWDJFSW1mU25zcHpSeDZ1aW96bEZQditVbVY2NEVUWmlZWGE4?=
 =?utf-8?B?TnRXeWVOVjJUelV2UHM3OVN3a0ZUUDRsYytQejd5UlRjMDNNcTNSTTF5U3g1?=
 =?utf-8?B?czMyaUJZWlA2VkxJNmlaR1E2Tit6L09hWTZ3VXE3bk1DVU5rdXR6QVBGSGZ6?=
 =?utf-8?B?Nnh5VlVid2VEZzd1ZFF3ZUZ1RytMUnUzVmdIZlVBbjF0SlphSmtjMUR3UEYv?=
 =?utf-8?B?SHFBRU9FY2xNTDBBUGpJOG9GMW5ndVM3cE1LN085YURpNW1NUlpTdGZoVlJI?=
 =?utf-8?B?VXNjeDA2UjQ5c0tTQXIvUFNaV2Y0UWdDZHRLNWdQRWl0aG80QzY1Q2FPWkFO?=
 =?utf-8?B?VFZSVjlCcEV1ei9oeWNTVS82a2lDVkl1UmpVUGhtanpmT2FPTmJmS29PaUJG?=
 =?utf-8?B?K3llaUd2MEU5SnV4MjNQQ2FGeTRjbG5NTENHaXFGU0YvRmR2Y0RKWlI2bVJ2?=
 =?utf-8?B?UkNsTktBb3gvZG5GOG9VZjVibElCNEJLclRib0h0MEQrU0pRL1NyM2tZSXZm?=
 =?utf-8?B?VXh3OXZuK0VjY0hnVTlZNkh0Q1Nrd3JLNDlBMjI2TEkzU1VIQ0hiSm84V25O?=
 =?utf-8?B?L0x2a3JKVXFqTk4xR1NqYmwzVGczd0cvUWZaQ0xrcFFMdElSWlJrNEFVUzNO?=
 =?utf-8?B?S2owQ2ZmYXZsWVdwY1BHWDBhcDV5cmNqTy9SN0hNMG5YSXp1MXdpZm9HdUlv?=
 =?utf-8?B?a3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b561574d-7c0a-4ce6-a932-08de25db9a66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 13:17:05.3638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EOsyGMZV5c1deMVnzc78lGt+tOorMOFC3KoL/mg8ow71h1o+r9eajv3K4OcxagyRxtRIMWw2v8XIws818RFvbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7297
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 17 Nov 2025 13:17:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20581

On 17.11.25 13:22, Jan Kiszka wrote:
> Now I have a somewhat similar issue on the HiHope V4 RZ/G2M I unpacked:
> 
> U-Boot 2020.10
> 
> Wanted to enable EFI booting, but U-Boot is likely too old for that. If
> you happen to have an image for that thing as well, that would be great.
> 

As that u-boot lacks distro-boot support (sigh), I had to emulate that 
manually. But then I got things booting on 6.12-cip 
(cip_merged_defconfig), though with quite a few warnings and delays:

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x411fd073]
[    0.000000] Linux version 6.12.57-cip12 (isar-users@googlegroups.com) (aarch64-linux-gnu-gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44) #1 SMP PREEMPT Thu, 01 Jan 1970 02:00:00 +0100

...

[   13.024542] rcar-dmac e6700000.dma-controller: deferred probe timeout, ignoring dependency
[   13.038397] rcar-dmac e7300000.dma-controller: deferred probe timeout, ignoring dependency
[   13.052628] rcar-dmac e7310000.dma-controller: deferred probe timeout, ignoring dependency
[   13.064733] rcar-dmac ec700000.dma-controller: deferred probe timeout, ignoring dependency
[   13.077303] rcar-dmac ec720000.dma-controller: deferred probe timeout, ignoring dependency
[   13.092359] ravb e6800000.ethernet: deferred probe timeout, ignoring dependency
[   13.114731] ravb e6800000.ethernet eth0: Base address at 0xe6800000, fc:28:99:92:7b:e0, IRQ 156.
[   13.120598] ravb e6800000.ethernet end0: renamed from eth0
[   13.126760] rcar-fcp fe950000.fcp: deferred probe timeout, ignoring dependency
[   13.136724] rcar-fcp fe96f000.fcp: deferred probe timeout, ignoring dependency
[   13.144522] rcar-fcp fea27000.fcp: deferred probe timeout, ignoring dependency
[   13.152098] rcar-fcp fea2f000.fcp: deferred probe timeout, ignoring dependency
[   13.159616] rcar-fcp fea37000.fcp: deferred probe timeout, ignoring dependency
[   13.167080] rcar-fcp fe9af000.fcp: deferred probe timeout, ignoring dependency
[   13.174931] rcar_fdp1 fe940000.fdp1: Device registered as /dev/video0
[   13.183082] renesas_sdhi_internal_dmac ee140000.mmc: deferred probe timeout, ignoring dependency
[   13.191916] renesas_sdhi_internal_dmac ee100000.mmc: deferred probe timeout, ignoring dependency
[   13.197162] rcar_sound ec500000.sound: probed
[   13.203497] renesas_sdhi_internal_dmac ee160000.mmc: deferred probe timeout, ignoring dependency
[   13.203741] renesas_sdhi_internal_dmac ee100000.mmc: Got CD GPIO
[   13.246866] [drm] Initialized rcar-du 1.0.0 for feb00000.display on minor 0
[   13.252404] renesas_sdhi_internal_dmac ee100000.mmc: mmc1 base at 0x00000000ee100000, max clock rate 200 MHz
[   13.253947] rcar-du feb00000.display: [drm] Device feb00000.display probed
[   13.267924] renesas_sdhi_internal_dmac ee160000.mmc: mmc0 base at 0x00000000ee160000, max clock rate 200 MHz
[   13.270655] rcar-du feb00000.display: [drm] Cannot find any crtc or sizes
[   13.287370] rcar-du feb00000.display: [drm] Cannot find any crtc or sizes
[   13.310449] mmc1: new high speed SDHC card at address 0001
[   13.315997] renesas_sdhi_internal_dmac ee140000.mmc: mmc2 base at 0x00000000ee140000, max clock rate 200 MHz
[   13.316522] mmcblk1: mmc1:0001 ASTC 7.36 GiB

But looking at https://lava.ciplatform.org/scheduler/job/1329386, this 
seems "normal"... Or are we using the merged defconfig for kernelci as 
well? Before rolling back to renesas_defconfig in isar-cip-core, some 
hint regarding the above would be nice. 

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

