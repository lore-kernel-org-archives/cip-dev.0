Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D7FCEB2CA
	for <webhook@archiver.kernel.org>; Sat, 15 Nov 2025 07:52:47 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.27])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4993.1763193162891237770
 for <cip-dev@lists.cip-project.org>;
 Fri, 14 Nov 2025 23:52:43 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=FulCOn8Q;
 spf=pass (domain: siemens.com, ip: 52.101.65.27, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKKgq6OmN9ggvgIXRJKGPebHcNHw6KKXYPzaWGFXCBZtN7eIyUaWQr08vPQxaAILyIy3wcyenKvrznL/sMhRaQ7qEu1Mc4Y4fvT7AE065BaSrv3WV4OP+XCvngf+hXtCX2v0nxmHylcG/+N1hTIHgq35Z/sURiG/851yuVJVeJlCcC7rvfxN5qhFiIEL+8WeIk7fBfJsWAHYY04n5egC4abuq6KnlrqLzB4JdqP72LgRO1PvC7cQLU2/hB2gY+1YGxIfuste3x7kPUzD4jWx8f+ytmr62nTSM9pCXsk+8l6w+Zdf51F6HMX3rwqqiYyHM+v3G2fN1AO13K2UpJElJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+FxzA6bz4KCCk2NxUqDN/WiiXtXkEivIbj7wZL3YN0=;
 b=U033/eGzMwKxRuLlLspb1yNxPDtwyM/7NjEKaeQ7PXSWKK4DIjBRDy7NMzPqa7htgzAufxVuSde3E61hLKWfq9NrV3nwPmovX+6veXGrgH7c1CjwTib46MA0IGUH3JCi0huCpeV0nc4nAnNIspVdXZZEYgYqe4bvdf+4K6Ekf3mmoyHqzBTpxGLmg05QEaYrBG5R2XuhqQhzbKyHuOIFQOcOEgs4Q3r+AjKlKgpAwZtLJbBNOIc2wJNyDaTepclXLx7LxjhTd4Q5xesQmRpB5ZYmxfJn4No2kVsiZKlgurbng/VmFkkboVULsHdNgKON2KN3zHd+nbm+4B322v2sUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+FxzA6bz4KCCk2NxUqDN/WiiXtXkEivIbj7wZL3YN0=;
 b=FulCOn8Q0eD0TJQlURuJxDJcJn5vKcWjQ6NYI4uaFWLBDpkWq4oyTU49E4ztibKztOjQmwn4yUOXdnL/tm+4gwWwuTNk8ApBzYxTP24uFGvUtFNbOGVZL2QN8lzSaDR5uLP94HoDOfgmUX7xdwbe1Fl5VZ0L79FXFBGwCGGNINSDXlZLtC/oxrQOBQ4iyTuBFSy7CHMbiDHaUi8psKIFrbi28c1HqN4m/f2w5yBU7Mk26NxYioKwPmCImIuUOjgs2r0FpxKwyqzrusSqSU814Ca1YSI5FGlMIyu+smLUndXSiO8TpbPedbwmdnI+P3A2DCyONTFT9Jki8QdIRwfkZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PR3PR10MB3819.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 07:52:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Sat, 15 Nov 2025
 07:52:39 +0000
Message-ID: <cbf91714-ab26-410f-befc-f43ae2840b56@siemens.com>
Date: Sat, 15 Nov 2025 08:52:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] Testing isar-cip-core on the iwg20d
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
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <80ecb9cb-2b48-46ec-b92d-090898097f5b@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR09CA0015.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PR3PR10MB3819:EE_
X-MS-Office365-Filtering-Correlation-Id: e6fe5fcb-7d76-427b-2218-08de241bf2e7
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?K2cwYnlPV0tYQ2tHT2lySGVqcU1LM253Y1BUUEVFdUN1ZVNpOEtsc3BxSlRO?=
 =?utf-8?B?L3lWaG1FUTR2bmthODlqa1JjN0tSNzdRck9QSFlQbFRpd2xBbHQwK2c0Nm5m?=
 =?utf-8?B?K3NUWjR2NG9Ed1Z6UmEyRDJVYWRZQU9QdTNJNXBqOU1hVE13UEcvZXpjZkxP?=
 =?utf-8?B?NWl6bFBuak8rTVZNbDRPZ3kwd2UvbGNDMVlzQ3RhNnNuSm0vc1hOT0FRTlVW?=
 =?utf-8?B?dXN4Smc5NE11L2tvMHFQZE85ckgxTTdidHh0THpabnF3eFovT1V3UzlQdzZO?=
 =?utf-8?B?Z2NMdGdOc1VMWjFpSENlYTBaYVg5VlJDcTJQaS9BRnYydFZCOFIrRmVBK0FB?=
 =?utf-8?B?VVVLdG9Ea3VwbXBReE9BVGplbzdObkN3TlFmZDZqVE44VVltd05jQS8zc3lD?=
 =?utf-8?B?Z2E3TmN3NHd6bmdicU5yYXBNUUd0THdQWWlYa2FsM1JmVGYydGkxTjdma2VX?=
 =?utf-8?B?K3dHNW0zU29jdmoyOExBWTRpdUhLWkRISzFzS2c5dk1kUFRaZXBTcFRJeHNL?=
 =?utf-8?B?RE1BaUsxQXo4VG5nR1Y0NDB4R050bVZuMmZNYXpteW8zVnZSUDFBNGt1NWNu?=
 =?utf-8?B?MXdLZnRtRFBTSjRqRCtjclpmYVNrWXhnM1FYWmRhazFQOVdsR0RyYTAvYkdk?=
 =?utf-8?B?cWZZUml6WTFmNCtVY1ViNTRDbmlaR0czWTdxY2Vhb2tLNTk5MndzSXl1Mzd4?=
 =?utf-8?B?Y3FnUEwxQSthaUNoYzlTRWJacFhtWHFReEh3TEpBdkdwMkxRbS92Mm1WM1VG?=
 =?utf-8?B?RzFsZzJReG5HcXRNVE0zVUZXSzVKWjU1TGFKZ01HU2Z6MXQreldNNGJ1Zlhu?=
 =?utf-8?B?ekNIWVN2cFBHR2JmZ2dxWmV6eWhnWDFVQW9MalE4UlovZ3VNZmZFaWFnYUV2?=
 =?utf-8?B?RVQ0UklmKzA3UnpmdmJnSU9zNk5oeitPelF3eTlGYlRyOFViNGdsdnNCcnN1?=
 =?utf-8?B?TDZGNUtyWVRTZEJYbkFOcmxHVnBETkNURklMWlZZL3ZDaFJhNTlPekJ4VVd2?=
 =?utf-8?B?emIwY2s5ZXBkUVRFYmx3TjkwNU5pQUxmcmRlcmZ2YWZDNkFVYWdkRnpZL3Rv?=
 =?utf-8?B?cjhibjJEUVlwVDV6aTQ2emQzTllhbjdvSDd4SU8yMmF2MFlvcDl0UjFLQnBT?=
 =?utf-8?B?cTQvYVpub2tDVndHdUtocUpCUkMvc0Zzbmtmc0pNVGRYQkdBVnZURDlwUTFy?=
 =?utf-8?B?djg4MjFOSW82cno3bmQxVVcrTldwWnlJVXJBUmZTNlNuT3V6cjM1K1ZXTURH?=
 =?utf-8?B?MmNuUXBhaFdUQkpnUjhpM0pHRTZyaVkvQmd2TE0yYlBMYlRXaERlYnV5OW9U?=
 =?utf-8?B?TDdSZmRiMlB5MHRGTEh5bHJubXQvK0w4aUV6emxtVzJJTVd0OTFyU2UwelFI?=
 =?utf-8?B?TFcxTFBBeEE4QnlaS1I3T2RmMVhMeVpkWXQzcGl5Skp2UG5wY2ZmSGNrdGZ4?=
 =?utf-8?B?OXpDWmNxV09XYjIzZi84NXM5WUl0SVNQM0lxZUpqWWppTVRNOHBDRVY1WGlH?=
 =?utf-8?B?d3N6eU1DNDc0Z2ZKMUw5NkFQa0N4Mmh4MzJtWlFqVzNGQWxOMDJkTkxZVUNr?=
 =?utf-8?B?ZE4vaytkcTYycmNHeGh4UnNCamdoS0NtMG82Vk9rVEY4eklKUXB3dXdzQytv?=
 =?utf-8?B?OE5yQlo4U3l0c0I2SlBJRmhwcFZxQldRdkpOY0laT21rUmdBZmtDekNBM1hr?=
 =?utf-8?B?S2hRMmpzRVpqZFdCai9PeG9MWENqbE92Z1BRblA2UDNwWGlxdHFPMU5zejlX?=
 =?utf-8?B?WFNaTFVEQmVYYmF5OS81U1duV3BiWkZBdWJ6d0tDMDVNczZvUG5kT0w5NnlF?=
 =?utf-8?B?elI3VHkwZjRjSUlETm41blNka0h1QTd4OVJ6WnhBTzhCYWhqcTNyVlBnNk55?=
 =?utf-8?B?TXYxQklWeWpYS0JRQzFla0kwSVZFN2h1eVV1ZVF0TkUwRDY0R0VjUVRLbjgx?=
 =?utf-8?B?cHBjbStieHdFcytvVCtyc2tsY1BBc3dsVTh0NWNROGcwYUNoVHZxVlE4Q2pM?=
 =?utf-8?B?Vzg2QzFSMnZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L2Z0dHVvbkpOKzZuYkkwZFh3VnZFNnZ0QVR4c1dDbmE4MFZQeEkrSHBvVHhC?=
 =?utf-8?B?M09WTktTaFpwUWc0QWh0Ym1nQ3Rad1FWcG9LRW5xMzZzT2p6ZjhCRHZvZi9w?=
 =?utf-8?B?bWo4WGFPUHNzRHNUeVRqWHlKejZEY2VKOWF3a1pVdHRzZHh4ZDFvK0p5K1hP?=
 =?utf-8?B?ODYxdmpaOHFxcEZxYlJ5YVNHWWo0eGsrR2dwOTBJc09UazIycG9ORDUvK0w1?=
 =?utf-8?B?eUdhTjFFZ1FyWStTTWZwaUpEazNkRnlwdDMwVUM3TU5tbStXbEgyTDUvRTE1?=
 =?utf-8?B?NDNnRjlVNkhxdjd4MDRtN2ZUTFR3cUJNdFByekJzZVB6SUUyQktjTTQzc1dJ?=
 =?utf-8?B?aWd5UWx0emo3UWs5RXhlWXJRR1dtWWR1SFVIWjNBWVEraE1GNEJoUnFnYkFG?=
 =?utf-8?B?K1JHemJEdE5GZ0duSzdQaFZrWTRKU1ZqbDdURFk2L2I2T3hRb1gxbVZyMEk0?=
 =?utf-8?B?TjZnRzBqdDBNMlNkM0M2UmtNV1U5K1NJc2tSTjhBclpJeFN4VXBOMFQzbm4r?=
 =?utf-8?B?Q1dZZ1o2QmZjQTBlRmUrMU01TnREQ0RvaTE5TmorQlQ1a3JKelNHR3lBeXF1?=
 =?utf-8?B?QmVpcnlVUVAzYm13VC94WGlrT2FIQnNheW5VYjdNVFhxOWhDWkVLM0VFZHZ6?=
 =?utf-8?B?Y2wrVVdYYTl4QXZpckl0Sm8wZldnUENBcW1VY053UDZhRm1OZ3ZPN2NpYVBL?=
 =?utf-8?B?NUtYUGZJZ3c1VFFSc2V3TnFKNTJRT01saE9kWEh4ZklKRVZET1V6OW5kaC9x?=
 =?utf-8?B?ekplbEQxNTVLT0YyVnRDVVVOaXh6SUd2WkhSSW9JM3M3ak5NdWRSYUk3Um5a?=
 =?utf-8?B?N2kwQ29ubFE4SHVUUi82YUt1UnJTQUxCanlINEI5T1pOeTZwUFFIWWpmSFMz?=
 =?utf-8?B?L3ZjR0NJQzMyeVhUbjFQTUNXNEkwb0hFWFZiTjVrTEdkSmhMMm85TXd2bEhm?=
 =?utf-8?B?dVowZ2VGZC80bERSVVNUalhFMW1Xa2JCcDliQ1pBeGsvaWxNdTh6K3YxT1VC?=
 =?utf-8?B?eWUwVHZ0RDE5cGg3K3JYMk1JWWU0VTQ3clNnTHAyQmc0eUh2Q1FIS0FERVNF?=
 =?utf-8?B?alJjYkJMRlJJTDlLQkRiSWlrRElXTWxwSlNBOGhoblBYK3UvZm1tL3JRays4?=
 =?utf-8?B?bnZMTmN6bzYySzNnZTA0bm8yR1h6VUkrcllRcDV6SnRIZXl2K0lyRjliaHRp?=
 =?utf-8?B?cFZzdXpuem1PYXpBdUhZdExUQ3Y2T1pQWWEyNk5tb3VNTmJlV2E0N2hvL2w4?=
 =?utf-8?B?K2N6QXBlcHd0dWpoQ1orNUt4Q2FrbjM5VnMzWjloWFRRTjJOaVdKdzhQQ2dX?=
 =?utf-8?B?MWJNQldtemNXMU9CaEJwU0VuTVFSMnNwS3hXbk9FUE5SMU0yUjVlcHBQcjJJ?=
 =?utf-8?B?RmZJbUVkWGl4ZkRnNHQ3bEFBTFkzeE90U1BuT3Y4ZHlDR2s5K0FXa09xN2NZ?=
 =?utf-8?B?MkJRZk16S2RzSW9iNThVb3R3RzlaK2pBWnV3dnc2djg2MHIyTm1VNWJRRGVk?=
 =?utf-8?B?VDNjTzdDZDJNSjViNWNBN2lqOXhZUEs3T1N2d0JlN1FnZlFDUUlhNFkveUhC?=
 =?utf-8?B?cXZwSU1NcEVSQ3hWaUVpVHpkWTV6SE9pbjBFVGpJRUZvcytsZzN3VTk4UHkv?=
 =?utf-8?B?d2dYWjBCUzkrTDdsZWFndUh3YzVGcUlyTjJNczJwVVdNa21kQWtmN2JJM20z?=
 =?utf-8?B?KzUrWnVLeHJIUXlyOU9GNU0zY2NXWG1pSTZPakNwdUszd3pzeE9jRUt6WXBK?=
 =?utf-8?B?WDZDWTFub0VpZFJvV0RPdllrbEVXSExzZkUzNlRmNkJsU2RSdzRrSWFrbzkz?=
 =?utf-8?B?c2V2OHFNc3dSdGRyeFhKNkM5dlpQRkxJSVJQcXlJNUFacUdSUks0NGQrd1Yv?=
 =?utf-8?B?REVLOGtoSDNNUnNkbEg2Z1VoUGlseC9Fek5jS3hEUnZ4MU92UlUzeHV3ejk2?=
 =?utf-8?B?K3FuMFFNMW1lZ0Z6bEZURjZod0VDaTlOYWkzSkJCT3JGMFJTcndlSXA0Vm9o?=
 =?utf-8?B?SnBJbGZFZU0xait6dXJlSFBPYlY5dllFUElyeDJKbjhrNXl6YlNUU0FyZGF4?=
 =?utf-8?B?RlNqWWYxMFNqVStGa1VzMUo2V2F6S1ZRaXlHQk1aOTlydms2Wm4wdnJaWWFI?=
 =?utf-8?B?NjBwVEZHcTJneUVFakVvakUvYmpxb3hFVUlFVVRHaVNyOC9pMllrcU9LOEk1?=
 =?utf-8?B?eUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6fe5fcb-7d76-427b-2218-08de241bf2e7
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 07:52:39.3772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQPtaFuIcJ2qBKDxfCvMvPGhDw0sJ9OvqXYrQrSpoRwbKggnXQWG/TR5HZWLfySm9TujcvHNBP7uHYRdYWYpUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3819
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 15 Nov 2025 07:52:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20574

On 14.11.25 17:15, Jan Kiszka wrote:
> On 14.11.25 17:03, Biju Das wrote:
>> make -j4 uImage UIMAGE_LOADADDR=0x40008000
>>
>> This is the command for building uImage.
>>
> 
> But Daniel set up things for zImage back then. I just discovered
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/doc/README_iwg20m.md?ref_type=heads
> 
> Maybe that whole thing was never tested again this way after 4.4.
> 

Tried with 4.4 as well now, still no success.

Given that the eMMC starts a 3.10.31-ltsi kernel, I think that U-Boot on
this board is just outdated. I would test validated U-Boot binary if
provided. Could also save time when bringing this board later on to live
in one of our new labs.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

