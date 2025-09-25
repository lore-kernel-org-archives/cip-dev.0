Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9976CAC5B1
	for <webhook@archiver.kernel.org>; Thu, 25 Sep 2025 15:26:48 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.51])
 by mx.groups.io with SMTP id smtpd.web10.81.1758814000660649477
 for <cip-dev@lists.cip-project.org>;
 Thu, 25 Sep 2025 08:26:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=JjeLDaT6;
 spf=pass (domain: siemens.com, ip: 52.101.69.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScNwaedM8Hbc1ui2LdoSmV+ZhnqNa7G7pt7kzkFgIHIeiE6NML6xQ1uGAAOBV03vutI5GOIhluUgNYkPS3fMeOt+9NYKGzzkL7O3yVUvjrm/VvsHWjhnmtCVzmBMBjcSiSN1F6E+exDwSUatvii3eRlneqcZwSyxurfvZSuOt9t183PWCuwnA5GA/sqHyLWUoIqkiz5Ob7/F8G7+iw+Jt4hrY6WSzjmEJ+3QSDLHmHQmjhSEcLaylpO1AeIUr/75hgd/FairHwgX0kap9z0oj2bFYY0pKlIpJa66g5NV8uzSW+FnwvjwjyodBAovb8HCNV9LYR0uMUW08if7ocr1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=caLeKqqM1/8svayeDtDw6CXR4cX+DDabSm1yqVUScoc=;
 b=xvQLyjV6rn6VwFz9BomwmyqnOD0Nmra5hfqf7GTOWWDAwqnwQQ6kVoPPb1Tuf+hc7pt70QveBpsnzLD6n5Aqa5v3rD445+qNahq3mKpwIiwti36VMILKsO4xgB1Z6Rsxuk+8zkV0nfEvByV6TMu6+fkTPTERTqqWeBFDSOC4UltJLuxyS9tDGNarKZ9B8Zvu2P/rKl9MXIjYTkIQI6uWNAZj0ByoiQrdF6uSG8lQMYxvGxBzJTHULbt0EYUT/080q5Aa2GA883nWs/O3+SRfIVj1T/35K1bLXE9Df2fjoh3VX/mVvpHAb0AwGpGu6v2hf+f6rjKv9cZCBAQGyOvqbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=caLeKqqM1/8svayeDtDw6CXR4cX+DDabSm1yqVUScoc=;
 b=JjeLDaT6940Y0aQE8YkkeqH3/+VCTLamrVs86FTzhUcdYGNTYN7xeBXOqqzi5xnj11PzNh7OMCgDsyUNClq/HrYlOOkg0Uf6esVaQy6OIIyf/6Ll47SjlruPInqIrrPaKxtY10fD9js+1sTCXIiFWfN259UvGJX/W2QQQmbzFslYBFaI3mqOTd1aVSbEpheSM1GyMmPOi/da2zLT03fQswGT9WyvtU2qbV0ZLibKrfeYaeYaLbp+21rPwlZZnSImpqNEMxfD0tkdzb+bOqGFTbazW5fvdmVMYzpjO8nUxT7aGymhYK4r6xxZwd0hLszL0SUA3D53XCk9aqiaCoKltw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7347.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:605::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Thu, 25 Sep
 2025 15:26:37 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.008; Thu, 25 Sep 2025
 15:26:36 +0000
Message-ID: <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
Date: Thu, 25 Sep 2025 17:26:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR15CA0015.namprd15.prod.outlook.com
 (2603:10b6:610:51::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 373c3dd5-9c71-4e8b-08f1-08ddfc47ea5e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?SU9YbDZjcDdOZG5uMDEwNEgrWTV3eXpwVEM2M0t0MXpCbFM5VndRMmRRSWJK?=
 =?utf-8?B?SE1JdW1HZENZVlFCM2lrMStERTJVdTZGSlJhSG9zYTRYR3BTL3VYOFgwTmh0?=
 =?utf-8?B?VFFXcUErM05oV3hqcU5reTBycFVtK05oQ1NCREV6cTdXbi90UVRvN3lCSTlZ?=
 =?utf-8?B?enc2bWQvWHlrS2V4RkMxd2ljQ0F6VW4vMWM5UTVmTjN2R1ZiM08wR1RaZEdY?=
 =?utf-8?B?M3pFeFBMZGZQNEVESzNzVFZ0S2dWb3lPYXlYdWF3bTdoajMwK3RSTnZ3TzZh?=
 =?utf-8?B?MkczL1Y4QUlQQldFRWl6dmp3T2hWelhzclhlcWFJSEkvbnRYUXY3dGZzVW1p?=
 =?utf-8?B?Qkc0bjhFVjZ0Q0pVWktrMkFJVXNrQWVHcDJkOTNHckZHeDF1YWFWMWVDTmJo?=
 =?utf-8?B?TENsMjJnREFaTGZLWXdqSUdDd3FxeTFES0kxeStVTzZhTmZ3dmtVMlBhS1lx?=
 =?utf-8?B?QmUwSU1xVVpQb0hmQzNKVSs4RjF0MzF4bGwxSjE1QzVGcDU2MFVaT292Rm1X?=
 =?utf-8?B?YVkrVG9kZy9yRzlqOVQ2czBpWk9lc3FwZWtHdHRYdGRUaDlJZkhMUkF0WEgy?=
 =?utf-8?B?aUIxS2xvcGJmOEVSNXFVTjRtdXRic240ZGVTOFRVT0s5cWxnM3ZRVXllNjhz?=
 =?utf-8?B?MWI0c2p3ai90bE85blYydmx1R0MyUGc1S2txa3lxeFFiaThOeVU1eCtqUmsw?=
 =?utf-8?B?WGJoNGVjSkR5TSs2elJ1VGlCNUc3R09zR0ZMQ0Z4ekk0UjRocnlaOEV5eER0?=
 =?utf-8?B?MXNKRCs3bE9WVzRIc21vOVYzdmZsblN0VlNUTjZJNHkxd3VMOGlzZmFmUEZr?=
 =?utf-8?B?OGxxYnJrQVBQSlpqWWNRY2dPYlNiS0xYa21WNTVJY051bGZ0QTdVRFpQNnpp?=
 =?utf-8?B?Y2hsQURCdGV6SEZBS2gyemhERnZMNUszYTJyWDFUdHQ0T0lvYm8wVDNqSUh6?=
 =?utf-8?B?MnZUVWd2ZlpnOFNVWXptZXduWDlGMGZhZVIxWGw0YWh0eWdWSmZ0blBsTjRO?=
 =?utf-8?B?eDF6V0MyYlV1WDkzVVkrUnVwZFoxSjQwNHZqd0NrdTJjNXk5cnZoWHN0WGE2?=
 =?utf-8?B?QitwTnpNSWxWbVpuTm84Z29ycUVxN1dsbGV1cTY5dE12T3ZyQ0pXc3h3cHov?=
 =?utf-8?B?S2VYaEZhakhEUkRmTjlBMzBpNTlQempyZXBtZWh6NUU5dm4zSG1zU2h1SERS?=
 =?utf-8?B?VDd3bzE0ZEpVdzFsM3NtYTd2T2tYR28xN2lkclVmTE9vQ3lUM2pYb3EwbUl4?=
 =?utf-8?B?UWRjZkZYc0M0N0ZFa1Ftd1ZQZTBMTzE1YU14aTlCS053VTF1bG1FL2ZtY29y?=
 =?utf-8?B?Kzh4ckQ5ejBxQzRMWmpheWFtdFkwQnBEWGJyVno5eEoyMWlibUFpTngycXlN?=
 =?utf-8?B?L1VGMDFoVDhPa0tmbElGeEZ5bGF3TitkL2dwQmJMRk1XRWRla1BtNUpabUV0?=
 =?utf-8?B?dGVNL0JqY3pnSDhmYzNnQU9naXVGM0pEcDNHZ3ltcTNBSWE2THJhNitydEph?=
 =?utf-8?B?ZFpJb0RHY2szMlNXQWRQclQ4K3V4N3ZlZnE0dEJKOFc5N3VaYlBrQzFjQlJO?=
 =?utf-8?B?dTFTcWtXUWRXNFZJTmxrQWNHVUxVM3BpREE5SmFLSENnOTZ2cFphU2RSRkFs?=
 =?utf-8?B?MzB4bG43dFIwOEhWTnRZd3BMdW5wMFozR3pPMWZBbERiOWs4eFhXWnhUNVk1?=
 =?utf-8?B?eklwbHNacXRxZWkyUjh2bVNMZFpGS1pwS2hEZEZ3UC9ZZ0JxbnpMZjJ1SkRy?=
 =?utf-8?B?a2lma2FHZDFST1hQY1NkelR3VkVYYVdwSGFIT0NzMzEvdlpRaUh6WDhlQ0FD?=
 =?utf-8?B?cUFRU0d4R0FYVFJiMW10WkthdTRNSTQ1eHp2OHJOUkQvMVlpbTB1dUIvK0Q5?=
 =?utf-8?B?VlJsR3lUTGx6S0x2MzdKUkw1dy96bTU4RUk0M3UwdmxIcFE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eUdlVUMzem41cHRPUEJqMC82NXkycTlqbVlXRkxySW5WNWQvSlJVTmNQZ0I0?=
 =?utf-8?B?cjdZUk9ydmdjNGU4ZCtmTVN3M0xHVFc4cE9sMmNFR3R4bGJ3czBMZ2h5aE55?=
 =?utf-8?B?Wm8vVTk3N3lRN0I0NnRrOFdQVk4wd0NZc21SWllHUENrMjVvSWhzQ01iRHVn?=
 =?utf-8?B?a09Id3pXb29IYysrWkl3WWRvYzZzVDZxa3lrNWs3TmNjL2hOTG54SHBiYzI1?=
 =?utf-8?B?YTY2cEhkallYZkhpcG5LOHUydU1nL0JQWHl2c2JYZFdIOFpMai9tVVArcWd2?=
 =?utf-8?B?VGZRKzlWeldSdWVtTjgxWDcxT0JlTXFJUngzR1ZkTTFqYUtjbElBYzF3MzZ3?=
 =?utf-8?B?aTB2UEg3SFpQTmxKT1ZCRk96a3BSV0NKTTlDcTA5YlhpZWVCWFpMcEs4NGk4?=
 =?utf-8?B?OGhlVFdmSTZtMkh2K25uK1BoSjlpR1MzUEJhb2hXZDYxOUZ2a1M3b0dlWTBq?=
 =?utf-8?B?MTRvQ25kRjVIeEhxcW5udENuNW55ejh0QU4wU0RlYndSWjdTQjh5TGFTY0xp?=
 =?utf-8?B?OEZjOVhOOWxxSE9ibVpReGp3RWdsbEZRY3U5R2FqR3gzc2FYcC9GaGlHczJt?=
 =?utf-8?B?dzBGS05GVUEzSmFkRncwcHRXYno5UmlPa3BsOG9WV1dZQU9meFVaOHNyMVB3?=
 =?utf-8?B?V25tNEgxejhRbzZBMWZPQ3BEZ1U2ZU9yUUNwMEdUMTRra3YwZWl3emw4M2xP?=
 =?utf-8?B?NDhnNXB4dEwrR0c5Z1dsZDJVb3RXeWJ6VUlWUGJhRGR1V3dHazN2ZlBRcWRH?=
 =?utf-8?B?MzB1Qjdld00yUFJjRFJXMTdFSmhuNHdyRjNsckZZQ1NQb2dQZ1ZYaE0wNHZu?=
 =?utf-8?B?R2RiZ21BNldWeVFOcGdzQlZKeWc0SUViaDdNU213UzFBMnF2aEdEY3lCbGY1?=
 =?utf-8?B?NXFuSHZSUGV3TGIxcEpLK1FyWTByYUhCRzlpdE5qb1VwZkllSmttR2JtN0pq?=
 =?utf-8?B?amU2T2MvUnAxRGVXL1ZsUlBrV3VmTkd5d0p4SUJUMFJCcHFyQmdQcjRzMnYw?=
 =?utf-8?B?cnArZzlsb1lOM3VidWZmSGhKR2hlTExuUDYvVHlYWXBma1hSc0lJemp4dytv?=
 =?utf-8?B?VGtKVHFJR28zNjRqaHZqclh0ZFU2THdKRG1YUHJYRHVQNm1jOFJuR2VaWklw?=
 =?utf-8?B?T29XcDVHWTZLTEJ3dEdvY21qUVEzczU2VU04YUtldDdOdWRmK2dxQTFtREFo?=
 =?utf-8?B?eTZobVhqOXpFU0V4M2Zmd2c1S2xwRzVwaWRCMm5NZWhBc25scWNmUno4OXl4?=
 =?utf-8?B?M0d2OTNoUTV3N3ZRM05Ga0dQUUN4eC8rWWR2aUpJdnM1M29DaHVQcE8vK05J?=
 =?utf-8?B?QXIwMTY3UXdZUDFkM3Y3QW8rOFcwS0QyQzlsZVkrakhMUlgrN1loOUUyVTNz?=
 =?utf-8?B?dEhYVmU5aEwvS1ZzTDVKTFdLNVdXTzU4Wk5sRWRJaUJ5MWhORWgrZXY0ZlU5?=
 =?utf-8?B?SEdaR3g5ZkxvazY4azRaWWFjSE9EYSs0MnZkbGNsZnp5eHhxVHVaczVWZGI0?=
 =?utf-8?B?MnhwZmRRMWt0eVZ4cy9JQ1BsTEsyVmdiL1B1SEVIL1UxRWgvWTFKR0kySkxw?=
 =?utf-8?B?Y3VWMjFlS01GYzUrbE5SbzU3bGtFWi9jUWI0dnYvZmhISzBOZnUyRWVDbEZm?=
 =?utf-8?B?NEovMUtGeXJaTS92SzErQXRwck1ab2cxUW0vdDVsT0dqNVRRaE5EbEhwaUZz?=
 =?utf-8?B?NXc5WHBPS3BIdlBGdXB4c0xnL3RPbmlvemNadmJvYXZTVDZrYno0V1RRVzN1?=
 =?utf-8?B?UGFNTEl0SUtwb0xMWTJNcnB4WFJRbGlvaWxqYitmaDVDR2dJU0dvT3N0bk5p?=
 =?utf-8?B?QVliK3Bjd0pleTNxRG44MkJaakY3eFdodUw2MjhFYmlCZ2s2NTg3ODIvbEZH?=
 =?utf-8?B?eUd5SVE4K2ZGRHZwL1JRTEhXVks4WlJNN3dYeUFyUm1CS3owelg3ZmlxRHNw?=
 =?utf-8?B?K3hnSEQwaDdhekx2eVFta0FmeTN3azdQQ2JSWE1sVzducEtJMW42azZpVWd4?=
 =?utf-8?B?eHdWTXBoZjZBeTZKMXJ6cXA0R0kvNkNpZDJHSFAvNVBYZHljcHYya1BOYW9C?=
 =?utf-8?B?Q2JyYndxWVludmlyWHdRdForVVk4OUdKbVF2Smo5cEVxMG9IeUhwM3VSNUNJ?=
 =?utf-8?B?bUxhcGEyTFBvaysvQ3N1TnY1TE5VS1JzTUM3MjdXYi9Eb0dkRkh1TWpwVEEx?=
 =?utf-8?B?RlE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 373c3dd5-9c71-4e8b-08f1-08ddfc47ea5e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 15:26:36.3933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qlaEromu0K/FHRd0iNuekXeyho520vLcqQDNtqAM3C94Nv+lZJUTSwE8R918kOO4h8SruB5vEiivHY0CyL8TDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7347
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 25 Sep 2025 15:26:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20142

On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan, 
> 
>> I'm already running a test with
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf71701983e3cb12f19efe9c217f500b9b0868
> 
> Ah, ok. Thanks. Hope it solves the current timeout issue.
> 

Not all issues yet: https://lava.ciplatform.org/scheduler/job/1310661

Will retry once more, bit it feels like our target became "slower",
could this be the case?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

