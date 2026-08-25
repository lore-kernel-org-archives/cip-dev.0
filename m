Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F7F8C61DBD
	for <webhook@archiver.kernel.org>; Tue, 25 Aug 2026 19:18:06 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.45])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30242.1787685480284419473
 for <cip-dev@lists.cip-project.org>;
 Tue, 25 Aug 2026 12:18:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=STBJ6WGM;
 spf=pass (domain: siemens.com, ip: 40.107.130.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VUpeav49h3YhA+LRgpQhTFJDSC4Nvh6UNWeupuEjCx+tGkLsRnsVOQNlszNUO1+iehgbiIxvx+kFrLi1FHoEzCKEbFRez2acn3BtT7flAWstJy/2IEhFq1B+TlpSsTaXsi30lnMX7V0xJBIh0Pn1L9wG4gN85iSGIPYYyVCfwERo4+LW9RvSOvJdjzp+uttgThGzQn4I6X/b1tvKdhRnpeV2XeyN5kFsNVs4uSUXpHZKbFwRpbc88DWILV0sEg48G4o5OkKwhK8gqVKeH0c81SrY2t7EbFXf6KusIF3Hvlq8KluX5LwAkFD8r55bXl/JSrBdINRmkZE46P5Ph3ocSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ogvst1T7ZHjUvVEBRXub5b2noRqzcPmn0LjgGs/JrgE=;
 b=cpGYXKnkPYfrW0ODvjEUssu/4WhY82MuiXBd0VFvKh5QCtm2gNpdvMaVelgI3P83+J4/ObTnJoGlqMPliGuRSo9wNHX5OeDs39TwgwK8mlFi0NFRRPxSzcfh71iZZRwyG3TLq9GzUIviiTRyqBruLXft9Cs4saVwUMMrjZ9LF8Bmv7tya8p+q72oM+TZF/qIDTmcyLV1vopn3mW5OkHBQ5HVhyO8+fVnqkw6qwbADVkYnuRYLXhbaKrubuo4NkKknb7KRnuub8IyrhU7UEJ9Ng8fXhBrLLOsTHjjTpHQ7YUqWXptHGaHENOm4SWvYK+WRx8JJhjxO2UCEhHS3J0Veg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ogvst1T7ZHjUvVEBRXub5b2noRqzcPmn0LjgGs/JrgE=;
 b=STBJ6WGMNSpX9dvK9VW6UutJ4g9rjeguNx2+Btaf0v/EOBytK6ow4/zJr5NyNN57R0080aNkXLg9AwAimQKLyvPHDEuYvMUYMf1NypAPRC/NiNeHkngfTe3RF+xBhcAu10BdrHtLMBUitLahww8wjXGXfXyKDG8gFo0H/kzuRoFaN5K2wQCDv1RECHOoyzS3N09o014ki+ljm7ZwsoZ85FyqgAM1iKynuf2TvQ9K6FtI0h+Yvdq9lSyM6CpCoHKz9e7TVMpdA0TMAEd2a4CW7wVZDk4XbMPxR35Nk943hIggtv1TNZ6DuZXOSVzJXz59DpIw/ULLc9oGxEaVnum0Zg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by GVXPR10MB9005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1e1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Tue, 25 Aug
 2026 19:17:56 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63bc:6561:54d3:94b9%6]) with mapi id 15.21.0360.006; Tue, 25 Aug 2026
 19:17:56 +0000
Message-ID: <7262f4c5-c831-4b78-ab67-8646518a0222@siemens.com>
Date: Tue, 25 Aug 2026 21:17:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] initramfs-crypt-hook: Use multi-call tpm2
From: Jan Kiszka <jan.kiszka@siemens.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 Alexander Heinisch <alexander.heinisch@siemens.com>
References: <fb8f6674-7d83-4fb3-891c-4dc6e10a263b@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fb8f6674-7d83-4fb3-891c-4dc6e10a263b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::13) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|GVXPR10MB9005:EE_
X-MS-Office365-Filtering-Correlation-Id: e8897e38-319c-4d46-7544-08df02dd9155
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|18002099003|22082099003|56012099006|3023799007|11063799006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	Mk+1aSNxibfAh/uA7uw4M8pF8cSzqDTHbTD3Xt6Ws3vuMqAnvGGcbeu3bfsif+VLsS/UaC76bmLr1GqZ43ENwuAqHWig+K7rvImoPwcpOfj7I5yLsPeObO2RJ8u0qsqC4SHbihLD/hZ+mRJ0dYYG60/fC6K8QeULYqnNTAixOIOtgxaON5jgzyTs+GH4Y/Tq+b5Dhvu3UQ4jNQMxac90f3wNzC/PSpqzyIT50wBKCtq0pr+RFMmgWj9WuNfb7+17vIZl4LLdhlTOvY8uBEcBP7xhqkJK7jpQi9rqVIxzPGS5UV1t336eGlA/zcFZ5ydoOEimZGfPEmwG/tHcJU+mX1lHt3KflW+74LrUUIwPLHLmc6aCrDsoENkCwXUHN9DpVG1R1MBtai7NDGjBmNof+D7OM7xvrNmuqNzN5FPNR6LnQ7m2ZsG2a4K2hmiz6HfgMkOy1eBccsk2hWdn0F0t//3TfWh13DA4hI1X5bXKdccVoQh08Om/WkvoHsUWuS5SmfEA5eaVDAdcJUJZXPzv9EGxd1cbvX7WvwqOEnNyTffe4lYCxz889g6gv7HakyK8FTfxqjM3gvY3LjaPb00S2Cy+3DtR8ZFFnbN9190bfcTAUTP/8grsYW4khnGgIc97ifd9KsiDi+qtEBakoEw6H5HbUlVhNI8k10QVvk4f1B4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?dnFmVjZ6dlZnT0t4NEJFRTFSNGRIajc2ZUU1Zi9KNytUbFh4dE10Z1NlMkJG?=
 =?utf-8?B?UXNXTER6di9HcG50MkFJWVVOSkJJdVNqcXVMUXcvTW0ra29PYnNSQ0hCSi9J?=
 =?utf-8?B?aUliWjI1SDBUV2M3UlVwU1d3clJLUm0yWFAxeS9sdUlJZjBPdTdNaFNKaGNS?=
 =?utf-8?B?WXc4aUhYNjF5THZsb0VMdm9kYU5saWVURlNMbHRqTWUzQXdUaFRIQ0dEYkV5?=
 =?utf-8?B?YjdTRFBPcEdKWU9Kb1MzbEk3M1c4WXJSSTdhV1BiOVVvS2pEN0NBYThaYjVI?=
 =?utf-8?B?Q0JVbkdXN1pUWENWcWt3UWpYQ0ZtTTFqTWhSMWRiTk1NVkgvd2NkMDUzZXBr?=
 =?utf-8?B?K2YwSFRTWFZZQndnSXhhZDZSQzRNelJza0JKMFk5d3VaQXdSWEFYOFJaNXBW?=
 =?utf-8?B?a29IOWFUeWthQmhKWGpncDJEQjZDNmk3bFovcSs3NzRWUkVHcjE2ZzdzSWw4?=
 =?utf-8?B?OGR1aTdGcVJYbHVpY3F5Z284bGtzbVJ4c3Y3WCs1dWRtbEZrMmNoWVF0Vndr?=
 =?utf-8?B?b3lRZmxIU1NlZ05nVnpVZWRiVWhiVzZqZ0U1VVhyVXBmS05kbW5uUk9kZGxC?=
 =?utf-8?B?UEpQazRzUzN1cm1Sayt2ZTQwemphUFBaNm9Pc0paZmNqcjZQVFErUmhqQlY4?=
 =?utf-8?B?bUUvVE1XS1ZBZGNFZTM0aDY0czdWYlhMVk5xZGNsZk02Q1pOazk2M2J2eVR1?=
 =?utf-8?B?bkh1MGJLSGFJa1hJaHVCSE9FUE9WaG05NGEwVHovSWFKVVZxYklWZFhHdHZq?=
 =?utf-8?B?S3djeUhLVDBLVVh4R3hpcTk4TGhDQXp5d1BvLzBTSlVRL29GcTl0ak5mZkFB?=
 =?utf-8?B?VDE4b3lSN0RxYm9IcWwvbUJLWTU0UlozbjhsQkt2Um42dkZqTXlDVkpZOWhF?=
 =?utf-8?B?NVMzQ1VYaUZUcVZIMWE1ekk3VUczeHBZV01OcTM2WVMyZnE0QVVmbkVkRE0x?=
 =?utf-8?B?Y3UzRmorSllETndjSHZ6ODdpTkRYcTAyMVVkL0tnRFN0aVpLVlpaRCtlN0pZ?=
 =?utf-8?B?anQycUNnbk83V3BOQ1RlRndPNHhES0VtWTdyNnRnTVBBT1hxeDBHdll4SWJ4?=
 =?utf-8?B?UkRhNW5EYm1KZHVRVEhtUVVQcWR1RUE4ZEYrTnlseEttcm9GNkxtV25EQ1hH?=
 =?utf-8?B?b0tYbTMwQ0lnY1ljaVlCaXZ0bkRCWEVqNk4vd0UzbTV2SzdER3RvSU9yR2d5?=
 =?utf-8?B?bnNhOEdrOXVKSWtyUTdnSENIWHQ2QWU4dWczSGU0V1AwZ2ZHcUFDMzhFb2NP?=
 =?utf-8?B?aDBGUTZjZ3RMM1VlMGdlc1RoOUNidEJiWmZqQkdiN05sU1VRUTBESjYxRXVG?=
 =?utf-8?B?ejIyY0dLdytINUJWc1l4RlBaOVVjcnJMVi92QWVNZWcvekRzS2Y0MVJpMXRF?=
 =?utf-8?B?R3NLUVo2TjFEYk5DWStKUWszekRORDQ5MEg4MXowcUVhelY4VktBRkJpQnh1?=
 =?utf-8?B?OE1SM3Q3WmRVdy9mTGtNWDNPa0JmVUJSVHNxU084b01jUGRlVWx5N2ZSZmFX?=
 =?utf-8?B?cUIwQnBKOWx2dkUySnBYcWRWNTNaWEVkSC82ZjRHcFQ4WEMxWWkrZER2Mm1I?=
 =?utf-8?B?eEVXdVdCUlZ2bW5MMTdYdjlib0lrbDdlS3ZCLy9hQURGbFFYNjJHVjAvWm9H?=
 =?utf-8?B?SXJPRFA2cDZheTNMV25PQ1FlYXZQZ3F6cEpCNkV2U2kwbmRiTmsvV2hFUXEv?=
 =?utf-8?B?MGVvRnl3dW1oUkhKd0NyV3V1Y2NJWTVlSVU1cTBvdFd3aSt5aXh3VkkwME1h?=
 =?utf-8?B?Q1dKbVRiYXYrREtFTmdRZjVwK1FxR3p1VHBoQ1ZjRjlFTmNwS1puYm9yZXNR?=
 =?utf-8?B?N0dBdmkvR0pQK0VRSzBjUUxZcGlsU3ByUDZnUVh1dVRPcGhseS9GeVhwQlkr?=
 =?utf-8?B?enpBdzI4dnlqOFJ0cVBxdTRsbnJIMm9QdVpwcVF0cHNxYytMWlNTM2tpNUNa?=
 =?utf-8?B?aDNZRHIyc084ZEhoOXJSb21IUTFkejVUYzU0QlIrN0E0MzdaWTdFS3RsMXZo?=
 =?utf-8?B?T3d2L2VGMmxVYWg1UkZVWGM5c003U3d1Vkgrbmp1enJBVVhyS0gxcGpaK2FF?=
 =?utf-8?B?dU4wK0QvQWxiS3FhQ1k4QW00Zitkcy9xQzJVOWIwZFZJdkxnUkFMenNrR0F6?=
 =?utf-8?B?S0VVMUNKWWNibDZyRUpQUDNZR1U3TkRMeTQ2UVNoY1p5b0hFYjVJMTFvUG5Q?=
 =?utf-8?B?UG9XMWNyYnc4TVQvT0FvWmRhcE84NXIzOWtUYTA2RmZyVDZ1N0xPRFFwTkNE?=
 =?utf-8?B?QjJtZlVwRzVZSDBPVWpnS2FSNXR2ejZmKzNDUlBNYjZmbUIxOWVuU0ZyTVJE?=
 =?utf-8?B?RFhjcE5SY2pNZjdkc09ueGpiR0lydjUySEVMdGxYNkpqTURYMXc0QT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8897e38-319c-4d46-7544-08df02dd9155
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 19:17:56.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qW2F2aUli4Qy/H3WEaLJ+sbJNlAwxzd6V2N1O+Zb3JRSdVPBS+CMrddiCMcIsGLD/EoffQsqBj/GJAa2n5iRpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB9005
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 25 Aug 2026 19:18:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24005

On 24.08.26 18:17, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> tpm2 is a multi-call binary, all the subcommands we currently install
> are just links to it. Avoid setting up those links and use tpm2 only to
> accelerate the installation procedure and simplify the recipe. The only
> exception is tpm2_shutdown which we continue to use as availability
> marker.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Please double-check that I didn't forget a conversion or otherwise mess 
> something up.
> 

Too bad: tpm2-tool of buster was not yet multi-call, and this is
breaking it.

I'm putting it to the backlog, for the day when we drop buster.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

