Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EDF1CE8D4F
	for <webhook@archiver.kernel.org>; Fri, 14 Nov 2025 16:15:25 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2058.1763136916688764037
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 08:15:17 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cW9/agz0;
 spf=pass (domain: siemens.com, ip: 52.101.84.61, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iFs1hzsMpAYbH/tF8FKGbOQTfAT1kJKRnkhaKmNhcRsECcxd8icFDkA9MJXUPSksQepcAdUP4eDZuY4nSFCS74TGV5HV5nkYKh36Wd+ie0eAojxwdBCqoJPti777hFkshsdbGHNlcOVjabRU1DxJO6IGN9DYV4sg6OE74ipABDePCK6tYmWcqERZ7LA4WD+H8YNKQazi1TBYTgFQDWa9seLXMPZOVRJOdC3ggWn0jJULlHOOHQi60k5FbxX4CXK9umRPrsVc+HfiMrnLr+De5AjFaidKDuLhDqDUsLo9CBtt6GXw19kKNW5SuhUbRyYL0ARUkfG6sTQBx/ioJTILkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v9j52mYBDTp2NrgJM/6t2aeng6PJh1FLN/YWGi5qZlk=;
 b=w8NHqO9Tl4Wn25rBeub24cBB//IF5r5u4LoU1oaIKpqkh8jet1wFqZF0U1HiwnzINxhPrIPKq9Pr+NdPFF4U+beg/eXwN0ot6vzzsJ5HDoVl6t6l0g12+Fqb1d+jzjNRb9xII+BZeToh3Lj9rDFK7lnAexar9nIIZx5OocKKp8iiU4oATo+eHGmIAXZAN3lONeQ6gdg5QkEDh3UP0eZck6xnjU6iXzbDtHy93xO/V6I7wJA62OwS7QMDTHTHvvc6EGs+HntVeKgqctTLc1Q5Gs2Uyj4/BpppEIkreuOO29FlMCUASg7gL/1y5IFsKBIUwBNew067c+L06DcGBHDLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v9j52mYBDTp2NrgJM/6t2aeng6PJh1FLN/YWGi5qZlk=;
 b=cW9/agz0i9wno2+CvG9pmXCg5BilZ6ogd/z/P3WUrDERsItcCa5UPa8WohhKSiDvCBzHN/HtLoG9OXE+bOXz2xlTwbeqCLKJAPedAGGy0+d9HIHAOC6ZOhY/ftqbIxY4GttnWlnT4Yq5PYoI57/hbUa32LqaSn0cTvsey3wNLS+SFtYZYIferfZuoxj7S1GMjwOWasgkr2lI18BxTHvN9Gkqlcx6xmanZx3dzKTu3Sx9TOcYyfjoiHLCgrkmbFtHad+Ynd0SUOaNovUA5e130TxBjbUD9SxziCLHc34P7Hf9OWgBNetmRcSiffGEHV3JxARBE+tCvVCyCEZeKKan1g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:78::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 16:15:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 16:15:13 +0000
Message-ID: <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
Date: Fri, 14 Nov 2025 17:15:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
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
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB1134685CE8A4BD38F73A0C1D386CAA@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::6) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: 276f26b1-2a31-4602-a50f-08de2398fdb4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cTBDV3hpK1FIQ3hXMmJQZGNpeHpKUzV4bWlGb2FCZEsyYW9WdEI2UlpzbDU3?=
 =?utf-8?B?YlN4OFFmTmtXQ3ZkNTFRcWxJUzNWTWY2aDdsYk1ucFVhYkJMbThQM1c4MXc5?=
 =?utf-8?B?YkdVSzF5cGQ1a2Y5cVpnemx6bkRaUlQvRzhXNENVemZueGxvWXc1YUdXRmFZ?=
 =?utf-8?B?UkRUOHpRN3RlUWFwNzJGdHdxK1BNS2FyQXFWZ3hIODVKcm9DR2Y1VFRRa2pt?=
 =?utf-8?B?dDRDRXk2WG5EREo5eDUzdm5XazRjR2I5aDJSUmxHLzhoMW9NemtMbkFKN1JC?=
 =?utf-8?B?a04xS2lOMnNMcVVkWi9kTXI4TGlMTFN6NlpDTWt6WEloSkNGUzRpR1FFWFNo?=
 =?utf-8?B?UkJzN1REWjBIb3JJb0FYb3gwcWZQTEhlWG5LRmRzNFo2Y1pxTTYycUY0R1du?=
 =?utf-8?B?UmloTnR4THF2VWZiM2FBanovT1A0Z2VxVStIVms2eENhRkJ5VFpPZm9ucUNn?=
 =?utf-8?B?N0dUajZ0WnhoRkxzeHRJSk42cE9UZTRJdDI5cEFpeThnYXM0QU5KaTBTR2s4?=
 =?utf-8?B?QWlzc3MwS1BrTnZUU0ovcng1elF3d0hDNDlURGJ6aGRHbmNSTk5NSFd3cnlT?=
 =?utf-8?B?UW1Fb3pYWThGWFc5dlUxTldGNTFYa3BpOVVReE5KTTRITStlQjJvdEc5dlVq?=
 =?utf-8?B?ek50dzlVWnFSSkJmUERMMTRldjRrdTdPazdaU0lwVmVhbEtSYS8xc1IxN1Nq?=
 =?utf-8?B?TWtGTS94cW90SXFvRkJFdDFWc3BwLzVYTlZ3OVJ4aUZIc1E5KzVXVDZnZDdi?=
 =?utf-8?B?MjgrWVY2SWRGendjSkdxejlXQlM0NUZ2RS9tc2tjUFB5TnNvYmpVZFRMbElX?=
 =?utf-8?B?eEpaYXRLNFo0bUk4TytHR0ltUVB2UGFIdHlIT1hiSUZIZ01CR1o5VnBlRXkz?=
 =?utf-8?B?SmkvaWNHNExnZ1J4OGFMRENtYnZZTDBkNVpiYkxsRlA3Y2Fkc1hKTXVzRStH?=
 =?utf-8?B?aWthbjY4d2N3ZlRDSVBBMXNBdVNubFpWU21xTS9HUitocUVQZmFqSzFKMHhn?=
 =?utf-8?B?dkF1azhvL2QzWDZ4RnNHQTlaUFpWbERVL294a0VieEFaMjhkTTBUVk9mandQ?=
 =?utf-8?B?cDFUMVpBT2tzK29EQ0xIMzR0dFMwcUh2R3ZVWXRRVWhaMTZhR1JGWnV4czJ6?=
 =?utf-8?B?bmJVQlloTFd5SDZtREQ3YXRzM3Zpa3FlcGxrODhtQ29GdWo5RjhKL0tZS0I1?=
 =?utf-8?B?MFg3TEVqcVdRTWRENGdEeDkvUlhJd1ErT3JHcmRsRWRWdmp5L0hJL2xzZHJV?=
 =?utf-8?B?OHJlUS90eFB3eE5ESTNJV2wxRTVVVlhPOGFNMktOVEtZM0Y3LzhwOVBNZFdI?=
 =?utf-8?B?M1lRY21MUGlWbWV0ZjBEeW1wODIrcnY5TzVHN0g0TDZ6dUJyV1R3ejB2ZVJL?=
 =?utf-8?B?ZWpSaTVuOTNPeEVvcnBOV1JLMktLOEJRZ2R2QUFjcllQZVgxY1hCWDJ1M0gz?=
 =?utf-8?B?bVc1SUU3T21LVVUrTkRqYll4SXpKMVQ0L3c2cEtSMHg4TzJjbVBhclJmb29P?=
 =?utf-8?B?aUlGQ1ZDSzM5dlhDRm1FY1pmOWkyeXBWajRiWWw3QWZGS2FLSWRyOTJTRXR3?=
 =?utf-8?B?Z1lmdzFLWndML05JL1Z0cHNpaXNIZlB6VUMvTjNwL2JnbForMmdxVUtyQU42?=
 =?utf-8?B?Y016V2NhaG42SXV4S0tQSXdTQ3FadzNpRXFsRzJTVlN5NGthK3BRYkR2ejlJ?=
 =?utf-8?B?b3JpN211QUozb0w2eStqSXhrKzdoQlNPMUorcW1uMWc3enVYRU85eTlLcXFw?=
 =?utf-8?B?dVB5TXNIMHZTY3NaaHBWYW1Sa2V3R0hBNlFQV3ZsVEVVRC9pYTI5N2VjaWE5?=
 =?utf-8?B?aXJyZURDbFdiOGlPMzlzMHBvd2lBK0YrWktyS2VHamVlTGdBR2dSaHZ0NDNU?=
 =?utf-8?B?Znl5NC9mSmFDdmN3UTg3eG9WTU1ISXlBVzc5Wm9aUEJjWEpIZ3BPNWltTzJL?=
 =?utf-8?B?TkVhdGwzNUx4SnFZT3lVblBmWU91TlFwOGdmZ2x5Ly9uRVBjUmpnbFNiYXdq?=
 =?utf-8?B?akpBYzg5TW5nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?STcvc0FhT0J0NzJ5c2JmckVKZzhnQ3E3Vkg3R25XM3pVMWxsNURab0ZOSVZD?=
 =?utf-8?B?NjJiK2YrUGp3b1g5TTFKK0pRbXNtTU41RUk5VXZiclZoOWpKalRMUmZvMWVQ?=
 =?utf-8?B?eUt5WkdqUWt4M2NxQmtjYW1pZERESm1adUpKRzJFUmRnZFg5YXFmdEpWUDd5?=
 =?utf-8?B?bE40ZXdaS3d1K1V4TUs0QXU1eFRheGhqSmZBUWdtUFNFblpIZWJmQnhlZml0?=
 =?utf-8?B?NFpXRi96NmF3U2JyMHVCMURTQXBFUjdCYUhXZTRVaTlyR0xDR1NSTkRoUDhj?=
 =?utf-8?B?VCtCTlBVTzhtazhqYUlFT1lTaS9uY2RRQWt0N2RraWZEN3gzbDdrTEZHZXQr?=
 =?utf-8?B?alZ1YUs5N1Z6UUh6WHRsbWtqMGFaS1hPSWQycTNkNlhjZGNqNzR0bS9jM3RG?=
 =?utf-8?B?alk3NDdGUUlEaGxzUUwzZ2ZCaXBVTnlTL3VHaEtUdlI1cUJsM3MzZW55Nm92?=
 =?utf-8?B?eHBRM3FadC9PMWljUHZnVmJzQXI3TTBqSElIQ0E3M1ZBZm1VVUpiWmlLTEU2?=
 =?utf-8?B?UE54REdQNTFNWDFyQlIxVERNcHphU25OOXVxRWdEMFdtVDZrQVkyYVN6YnhQ?=
 =?utf-8?B?M21pZzdxcGZmVm5FVmJCKy9aWjNXcWpjWThTKzhGTzYyaC9oeUNhYjFNZEh2?=
 =?utf-8?B?aUFMZzk2czJkR29uZFdaOG4vUGlHVmt1aXVOSFcwa3JWTHRmTEJFeW51VG9z?=
 =?utf-8?B?REVKTHNGcjRtOUE2ZlhaYWV0U1JFZkI4cDRURWtuU29Nc1hnTkhyeU1TOXI2?=
 =?utf-8?B?MWVYcE9sVk1YblE5UGR6NG00MzJCSFZkU21VZ0I5WkttMW1DR2EycmQyb2t4?=
 =?utf-8?B?ZFNRUWRQYXlrS3J3L2QzWFlJZXFXUlJmTXFzUThPV1FYT05mb0dTcVpKSzBC?=
 =?utf-8?B?cVFqWlpjbEpXRndhbEMxUDB4MmIvT0daQU9rVnlpSTVVNTQrb3RjUVpMSDF1?=
 =?utf-8?B?eWNMaU5Jd3lOa2VDRDZuVWlBR1Y2Y2c5YWZsTFNyK0t6SUtLTm1Ydlp4Vk9S?=
 =?utf-8?B?aVl6WG9ZWk5peng2cTRXeFliNEs3c2pZdjNJTGdsSmg1bmlpR2kwTFc1ZGVL?=
 =?utf-8?B?OHVtazZFMzNmaXd6ZHljUHNIdFVvZTJjZmZqL1JpTUlvT3hRMTRBRGpoaWtp?=
 =?utf-8?B?SkRyZGNVSlluTXc1TzQxTVpqNURrb3NZV0FRa3NsYUsvdjZoeFVBUU9vUkRx?=
 =?utf-8?B?aVQ1SEwzS203Unp1amthQWpWZlpRRnZYS3J1RTdhODVtOGdTYWNkMHdFRFl5?=
 =?utf-8?B?bk4rMkk5cHJtYVQ1UFNteG1TVVRTUkg4dDlEQy9YekViYVJRcXZ1NjM5RTRh?=
 =?utf-8?B?cXhRK2FIcFZ2UWE4MXVUb3E0L0lFNkhoUGV5RUtZbTlWR2ZBd3Y1WXpHaTI2?=
 =?utf-8?B?eE9uckhRQzFRZGV2VHNmMDNUbi9MeG5vQkt3NWcrQk1hSXZ2eGFMUG9sTDVz?=
 =?utf-8?B?M0NaK1hIckg5WEtnWExIVWpmMzYyZ2tkak5mWkVyQVZndUE4SWVEOGVyLzZY?=
 =?utf-8?B?SnRsbFV0NkowSmh2aXp2NDh4NkJHaHZ1YWQ1MXN5Q01NbFpHNmM3aFlTTFk0?=
 =?utf-8?B?dE91QzN5UmVIc2xMUnQxa3ArOUlHU2YvWEltQjJiVnNRcnI1N25KV0YxVStj?=
 =?utf-8?B?MXVjVURDSHhWd01Db1VvQ0FJYTRzaXVNcmVGSlRJeGtvY3cvenVwNFJPdGRx?=
 =?utf-8?B?MVl1QXZ2dWJ2Sndab2J0WW42SElUd1VzT0FIcUtGREU0RTNRS2FvTUFnd3Bl?=
 =?utf-8?B?MTQ5K2NuY0RwWUhKV0xzQzhCOW9uYTFJZHNkVmhiQ3p2YktOMHJ3SjRzOFJT?=
 =?utf-8?B?QWV3V2xxeUhmNkJvRUZIaEpmTlUvdWU4bWZ0cStMcjlwTjV3M2pYaFVDT0tS?=
 =?utf-8?B?WWFzRzlJYlJNQ01aQ0RYaGFQZ0hFNTVnWGFwU2tKbUpnRkFzWGhOVTFITjJT?=
 =?utf-8?B?QXU0OFd3cWJxWmpGUXN4UElRSTVrSXN2a3VJdU8wdEY1Vk9ydjVDdmpFdVpV?=
 =?utf-8?B?blZMZFZyM3NqWVlsaXJ6NmwzY1RidFUvMFdtSzhmS29hZjVkbFZDLzAxL3Jw?=
 =?utf-8?B?aTNYSC84WE03QThjTURHSHVVRDl0ZzVnVDQ5WEN3SlNudEd0a2U5UC82M2Zh?=
 =?utf-8?Q?GOt+zD8YrFVBWGjkoj5+OW6l5?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 276f26b1-2a31-4602-a50f-08de2398fdb4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 16:15:13.3103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dTszCKv1JUgGfE8a5M64vqL8pGYmKxYzRrD7N2sLlW5sbvgGoWmHovOkEX5N2oZbij/xLbwhuuNUgA1N/r3KXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 14 Nov 2025 16:15:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20562

On 14.11.25 17:03, Biju Das wrote:
> make -j4 uImage UIMAGE_LOADADDR=0x40008000
> 
> This is the command for building uImage.
> 

But Daniel set up things for zImage back then. I just discovered

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README_iwg20m.md?ref_type=heads

Maybe that whole thing was never tested again this way after 4.4.

Jan

> 
> Cheers,
> Biju
> 
>> -----Original Message-----
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Behalf Of Biju Das via
>> lists.cip-project.org
>> Sent: 14 November 2025 15:47
>> To: Jan Kiszka <jan.kiszka@siemens.com>; Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev <cip-
>> dev@lists.cip-project.org>
>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>
>>
>>
>>> -----Original Message-----
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>> Sent: 14 November 2025 14:18
>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson
>>> <Chris.Paterson2@renesas.com>; cip-dev <cip-
>>> dev@lists.cip-project.org>
>>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>>
>>> On 14.11.25 11:03, Biju Das wrote:
>>>>
>>>>
>>>>> -----Original Message-----
>>>>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org>
>>>>> On Behalf Of Jan Kiszka via lists.cip-project.org
>>>>> Sent: 14 November 2025 09:54
>>>>> To: Biju Das <biju.das.jz@bp.renesas.com>; Chris Paterson
>>>>> <Chris.Paterson2@renesas.com>; cip-dev <cip-
>>>>> dev@lists.cip-project.org>
>>>>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>>>>
>>>>> On 14.11.25 10:48, Biju Das wrote:
>>>>>>
>>>>>>
>>>>>>> -----Original Message-----
>>>>>>> From: cip-dev@lists.cip-project.org
>>>>>>> <cip-dev@lists.cip-project.org> On Behalf Of Jan Kiszka via
>>>>>>> lists.cip-project.org
>>>>>>> Sent: 14 November 2025 09:35
>>>>>>> To: Chris Paterson <Chris.Paterson2@renesas.com>; cip-dev
>>>>>>> <cip-dev@lists.cip-project.org>
>>>>>>> Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
>>>>>>>
>>>>>>> On 14.11.25 10:05, Jan Kiszka wrote:
>>>>>>>> Hi all,
>>>>>>>>
>>>>>>>> as I still have the boards with me, I "quickly" wanted to
>>>>>>>> renovate and test isar-cip-core on iwg20d. But the board I
>>>>>>>> picked from the stack has an ancient u-boot pre-installed
>>>>>>>> (2013.01.01) and has no clue about GPT or the right name of dtb file to load etc. etc.
>>>>>>>>
>>>>>>>> Can this board only boot U-Boot from SPI? How do I refresh that safely?
>>>>>>>> Or can I also make it load U-Boot from SD card?
>>>>>>>>
>>>>>>>
>>>>>>> With some tricks, I meanwhile loaded the zimage that
>>>>>>> isar-cip-core is generating via the old u-boot, but that is not
>>>>>>> giving any output during
>>>>>>> boot:
>>>>>>>
>>>>>>>
>>>>>>> iW-RainboW-G20M SPI_LOADER(DDR3) V0.20 2015.07.16
>>>>>>> BSP Version     : iW-PREWZ-SC-01-REL2.0-Linux3.10.31-PATCH004
>>>>>>>  DEVICE SST25VF016B
>>>>>>>
>>>>>>>
>>>>>>> U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>>>>>>>
>>>>>>> CPU: Renesas Electronics R8A7743 rev 3.0
>>>>>>> CPU: Temperature 50 C
>>>>>>> Board: RZ/G1M iW-RainboW-G20M-Q7
>>>>>>>
>>>>>>> DRAM:  1 GiB
>>>>>>> MMC:   sh-sdhi: 0, sh-sdhi: 1, sh_mmcif: 2
>>>>>>> SF: Detected SST25VF016B with page size 4 KiB, total 2 MiB
>>>>>>> *** Warning - bad CRC, using default environment
>>>>>>>
>>>>>>> In:    serial
>>>>>>> Out:   serial
>>>>>>> Err:   serial
>>>>>>>
>>>>>>> Board Info:
>>>>>>>         BSP Version     : iW-PREWZ-SC-01-R3.0-REL2.0-Linux3.10.31
>>>>>>>         SOM Version     : iW-PREWZ-AP-01-R3.3
>>>>>>>
>>>>>>> Net:   ether_avb
>>>>>>> Hit any key to stop autoboot:  0
>>>>>>> iWave-G20M > pri
>>>>>>> baudrate=115200
>>>>>>> bootargs=console=ttySC0
>>>>>>> bootargs_base=console=ttySC0,115200n8 ignore_loglevel
>>>>>>> vmalloc=384M bootargs_mmc=setenv bootargs ${bootargs_base}
>>>>>>> root=/dev/mmcblk2p2 rootwait rootfstype=ext3 rw bootcmd=run
>>>>>>> bootcmd_mmc bootcmd_mmc=run bootargs_mmc;run fdt_check;mmc dev
>>>>>>> 2;fatload mmc 2 ${loadaddr} ${kernel};fatload mmc 2 ${fdt_addr}
>>>>>>> ${fdt_file};bootm ${loadaddr} - ${fdt_addr}
>>>>>>> bootdelay=3
>>>>>>> bootfile=uImage
>>>>>>> bootm_low=0x40e00000
>>>>>>> bootm_size=0x100000
>>>>>>> ethact=ether_avb
>>>>>>> ethaddr=00:01:02:03:04:05
>>>>>>> fdt_addr=0x40f00000
>>>>>>> fdt_check=if test ${fdtforce} = "0"; then dynamicfdt;fi;
>>>>>>> fdt_file=r8a7743-iwg20m_q7.dtb
>>>>>>> fdtforce=0
>>>>>>> kernel=uImage
>>>>>>> loadaddr=0x40007fc0
>>>>>>> stderr=serial
>>>>>>> stdin=serial
>>>>>>> stdout=serial
>>>>>>> ver=U-Boot 2013.01.01 (Nov 04 2016 - 22:21:05)
>>>>>>> vin2_camera=ov5640
>>>>>>>
>>>>>>> Environment size: 803/8188 bytes
>>>>>>> iWave-G20M > run bootargs_mmc;run fdt_check;mmc dev 0;fatload mmc
>>>>>>> 0 ${loadaddr} zimage;fatload mmc 0 ${fdt_addr}
>>>>>>> r8a7743-iwg20d-q7-dbcm-ca.dtb;bootz ${loadaddr} - ${fdt_addr}
>>>>>>> mmc0 is current device
>>>>>>> reading zimage
>>>>>>> 15151616 bytes read in 685 ms (21.1 MiB/s) reading
>>>>>>> r8a7743-iwg20d-q7-dbcm-ca.dtb
>>>>>>> 41327 bytes read in 5 ms (7.9 MiB/s) ## Flattened Device Tree
>>>>>>> blob at 40f00000
>>>>>>>    Booting using the fdt blob at 0x40f00000
>>>>>>>    Loading Device Tree to 40ef2000, end 40eff16e ... OK Unable to
>>>>>>> update property <NULL>:mac-address, err=FDT_ERR_BADPATH Unable to
>>>>>>> update property <NULL>:local-mac-address, err=FDT_ERR_BADPATH
>>>>>>> Unable to update property /iwg20m_q7_common:vin2-ov5640,
>>>>>>> err=FDT_ERR_NOTFOUND
>>>>>>>
>>>>>>> Starting kernel ...>
>>>>>>>
>>>>>>> Tried kernel 6.1-cip and 5.10-cip already. I guess I should put this aside...
>>>>>>
>>>>>> You need to load r8a7743-iwg20d-q7.dtb by updating u-boot env variable.
>>>>>>
>>>>>
>>>>> Already tried that as well - same result.
>>>>
>>>> Can you try setting this in u-boot?
>>>>
>>>> bootm_low=0x43e00000
>>>> bootm_size=0x100000
>>>
>>> No change, still.
>>>
>>> I'm using bootz here as the input is a zImage - does that make a difference?
>>
>> I never used zImage, I only used uImage
>>
>> bootcmd=tftpboot ${kernel_addr} ${kernel};tftpboot ${fdt_addr} ${fdt_file};bootm ${kernel_addr} -
>> ${fdt_addr}
>> fdt_addr=0x42e00000
>> fdt_file=RZ-G1M/r8a7743-iwg20d-q7-dbcm-ca.dtb
>> kernel=RZ-G1M/uImage
>> kernel_addr=0x40007FC0
>>
>> bootargs=console=ttySC0,115200n8 root=/dev/nfs nfsroot=192.168.1.30:/tftpboot/RZ-G1M,nfsvers=3
>> earlyprintk=serial ip=192.168.1.33:::::eth0
>>
>>
>> Cheers,
>> Biju
> 

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

