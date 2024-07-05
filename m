Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36304C30658
	for <webhook@archiver.kernel.org>; Fri,  5 Jul 2024 11:12:07 +0000 (UTC)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (EUR03-AM7-obe.outbound.protection.outlook.com [40.107.105.54])
 by mx.groups.io with SMTP id smtpd.web11.15065.1720177918517044072
 for <cip-dev@lists.cip-project.org>;
 Fri, 05 Jul 2024 04:11:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KI54BcmK;
 spf=pass (domain: siemens.com, ip: 40.107.105.54, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auJl3CT9l6lZZhZHJjOutNSvM31acLyoammkwzZORvCyQH0A0qdnj3SqgBIyeK62kci8lkETjTLCvQutBlSooj3bLpW1GfPnuWwj2X1I/xoNi9G3AlgGoYlFqtv0rYOvvJDY/7FgLcMawFLqTQXP/pQ9yFmmWyi9nYIRtdLhfXjNA/F4nen8TKaIa+D56wtcFr6utPL8sxc/ka/UWRIIbwdmZCpCJb+G5kj4U8i0+arulDpiuZ16oQeQvac6K6I0uKSJyl77pC2tzvwC2rrhHKACtqHRtldeEw9GMttwE5q631rumV1SwRnoLpn6TRrGv/uQchGjb4g12u2mpNHMSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dR8txAsPEeAuDX1Je59KSl89f1ihWeP6QeRNpZCxIbI=;
 b=LQctHTRAGtDxQ8bCAB98/wyeIfoBIA9+jHaDt3eU0j5tzAD31y1p5ubvK5dk1y8dES7141rasXFFpWVKsINjRelKCdfw9i/UscZbX6PMLx8D8YWTdMHOhyI/DuY+MFF5x6H8gN8uTXf3gj/KZyS4RwofmTiwHq9x1fKh+aJn+BQgJZwlPA2rnTqE0StwdurpSFRwo4nHT1ApM2DNANKQoNBascpe+ZwqlavPa6cJb+c4UBLpcyZWaycW0zhaMaCIhsaOEky36uV0JIsODrUVSSRyvvTxAPtCFt+yUm1Ytks813XCFORYHqIHK/ZfsNON2DkjAJkD/eBV7PN2uNzw5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dR8txAsPEeAuDX1Je59KSl89f1ihWeP6QeRNpZCxIbI=;
 b=KI54BcmKAsJ3ZsW70o9YoYIusVU5zCF2loEUmcFTpOrry/aaNPfEerB5zb+ZSoPM1WGqbBanVZOl00rmlNXwASWYR2qPtJLCtgNafh2RIiOaNgM8NzYs2rjdJpYj10VtzDNsJFTKzFswAZ+k+h25LL2P/yUgf5pKQz+7Kx1rW5jmzYshWUxlZnXP/fCUggkPZc+bld6RccYilpgJNG+yuRnPSMnYZAB5AZpb2tDznw3bd2Q7TeG+ZDcTS5HdS2TXsohl02H1NtNrPHmxg3T9RQ1lFiBAhBYGtMUwuuTlgb0cZ1AkC+ipjApaIypTJpVzkB20fhp/LlKQIchTloUQjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8706.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1ce::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Fri, 5 Jul
 2024 11:11:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7741.027; Fri, 5 Jul 2024
 11:11:55 +0000
Message-ID: <aed5eeea-9592-4540-aa18-a5bc03efc9e3@siemens.com>
Date: Fri, 5 Jul 2024 13:11:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core v2] Kconfig: Select secure boot as default for
 security image
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: dinesh.kumar@toshiba-tsip.com, kazuhiro3.hayashi@toshiba.co.jp
References: <20240705073541.1376479-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240705073541.1376479-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0369.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: 70285f69-4060-47f8-e561-08dc9ce34787
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WmpzdlRUNHlvcWtvYUkwM2tIVEZjVW1JdnhUVGdrZnZIUlhSWk5FWk16eXBP?=
 =?utf-8?B?UnZFamJpNzIzQTdPM3ZKTU56Y2dNWGIxS0k2Uk1WamxIMmNLZlRFbmdYZXhR?=
 =?utf-8?B?amgyT1R4bkRxejk4VXdUdjNrRzFOeSsxUURiYmU2cHc5QmpKV25zODByQmc2?=
 =?utf-8?B?NkE1TlMvaU5vM2ptSnpDOXE3UHdUMHFXM1p5VWE0aTNvbXVRelFTbzRuY1BW?=
 =?utf-8?B?S21DdjZ1RTdVRUYrYkRnT09mUm1YazJMaEpTTnBTMUlVcjlZandGSzNZQzEx?=
 =?utf-8?B?MndZUUpVQS9vOFJRS1gxTjVHekg1ZFhBcEZzK1RtSUtyYmFiTkpoV2Y0cnNN?=
 =?utf-8?B?Z29zbkd0bXNucUdSMnl0ZFhodnNDRHRnRjVlN1RiVW4xVkl0bVYySlVyY3Ir?=
 =?utf-8?B?UWpPdzdja0l6a3c4VXdncnlHWXZzVFAvL1hkZ3dJbTJCNnNXZy9VTVQ1ckto?=
 =?utf-8?B?cng2MzJyOTFwd2dBRGtwR0J5ekEzM08xNCs2UzRPQU9JWVkyanYvVS9vbTU1?=
 =?utf-8?B?cnM5V3MwNDlLVjVlZGtUOFhwVGZOSW9NTXVuYUxFS2NTek5yYXFwVE80emdz?=
 =?utf-8?B?b28rMjBybjhEaXVNRXRzSmczbWhzdEoyN2ZNRExqWElaME9WcHdoWXJTU3Zy?=
 =?utf-8?B?aVpWeXlMU3JmeWtwV1A5aDVOSWlGQzFkK3doY3Nla3ZxUXI1alpITm1HQVdn?=
 =?utf-8?B?eXdnYk82RTczV29WL0s1a0dLMUxPRmI1K0wwZ3lXaDd5VmVaZ1JzeGRnK3h0?=
 =?utf-8?B?UXpJOHFyblJqdG5mdnFnQ0tGaEJSRHM0bmJKeWZLS1FFYTdJemN1V1dyZVNR?=
 =?utf-8?B?VkE4QUJ5VEVXRDdBZ0JqeXpwVGpaZ3orcjl3WHVxYjVvSjk0blByTTZYL1pL?=
 =?utf-8?B?Q0hHZ1pZT1BWbkY5WHdCR24vY0ZQblBuS09raUFSMU9nVmlKa1AvTFl0UmdU?=
 =?utf-8?B?VWlUcXN2V3BWclpLMDhwbkhFOXRLLzMvZHJBK2lKdEtRYm0wQmlFOUxnTnBs?=
 =?utf-8?B?d3RCQVlRWWRtcy84TEdnNEg0bmNhMWpua0QxREd2ek02UmYzM1h5cnlBN2JD?=
 =?utf-8?B?TDZzdlljM3hCcXhBWFVDQmtIUTJXZ2pGbjhGL3E0enE5RVNKWDJ2dFMybE9u?=
 =?utf-8?B?RzZ4MTcxUldXSS9IanhzQlhQdGhlTTNtRHo2SHp3MmRxV1MyNytXWlNhek1t?=
 =?utf-8?B?cGducEpuczFwRVg5ZTQwL3R5RFRCU2pYcXpzYjVMaEhkRW9waUx2WUtWYklR?=
 =?utf-8?B?N1JIZUdOMURZT0JBbFZ2N054b3orenQwMk9vVmJmZGlBN0RnK3ZBb3dMdWgr?=
 =?utf-8?B?a0dmdmhlVnRIK3k1ZXFGMzJTMzZpUjZJOW55V3N5NTJGdURXRWFpSTdGNzEr?=
 =?utf-8?B?NzRNZG1tWXdCN3ZSc29Ua2tpMVA1RWpqV21yQ09KZGdxaThyVDNGRWFZSS9k?=
 =?utf-8?B?c044YzRzMmJxaUNYZ1B0YmE0bkw4NThwb2g5bXVNWk41TlBhMjIxYU5nM0Nz?=
 =?utf-8?B?QXVzTWQ2SVBjRyswVGxBRENNeUNCdWI4TzNLOVdkR3ZBem5MT0E1ZmU0cWl1?=
 =?utf-8?B?OXI5ajUzNlZEMGRIYUVqVXVmSEQzVjZEL0ZTWHV6cDFkeEJVNXJ2dWNicktn?=
 =?utf-8?B?MHliTVMxb3dyc1cyM090K0hQTW03U09kQTlTWjA4OGxwQ0hNNHJFRUhkdWpt?=
 =?utf-8?B?TGdzQ2tjUGxDQzQzSmpkc2FIQ0QvWGZIRTYrL0d4S0EraklnOVFzbnp0Rko3?=
 =?utf-8?B?WVcrOXJCRUNFZE9PcmNjOGxsb3lYUTJRbHhuUTRHYlE0WnZBV3JsOU1Eei9I?=
 =?utf-8?B?aFAzelp5RmlZU09Ib1ZnQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RnI5ZitsaHFETHN2QzlHN0d0L1NMVDIrZ1pBd2FJa2RqL1FUd3JTTVR2TzJt?=
 =?utf-8?B?VEpiZzZUZXp1QlJVVzNvTHhLMDYzL1RUdEVhZ09ldkJZbldjVFZJb3Btc2VD?=
 =?utf-8?B?c1pKWnd2Vk1GR0ZNNEI3dHp4QzJFRW5OWCtUV2lha0QrVUhNR2I0RUNOamxh?=
 =?utf-8?B?TzNUV2lKdm9KTWxBcnZ5MkI0NnBzdk5KTTA1TDhpZTh1RkpITlNXNXBTU09y?=
 =?utf-8?B?T0hKL3FLOWVVMnZrQ284dUZuQTNzWEt5Q1MvV0llczVJYURuSFA4ck1QSDhq?=
 =?utf-8?B?TUtxeEZqV212NllTWlRjQTc5R1ZpZFhmbDByS0dFNGF0QmRXMCsyeFR3d3Uy?=
 =?utf-8?B?MnRBeFFWS2hUZStOVlZwaG10SXBTRmJYMUdqa0d5ZWNPYUVOL2d5V1hFOGYx?=
 =?utf-8?B?N3BmMVp4UWc3QzQzNzlZWVZtKysvbHJpcVYyeEtvMnVDSVRDK0Z5SkhCbXps?=
 =?utf-8?B?ekNXSHNuNlVvK0p4c0RXNUU1dWlNWlFucXFXTUMyQTRkdzRVVjZNSnZDSkhx?=
 =?utf-8?B?blkxV2F3OS9QVjc3VUxTWWUxQ3lMazdJS0hSOXEycnl6ZDVyNm1WMFAzcXZs?=
 =?utf-8?B?dDMrQlR0NXNqMmlWMkp4UWhDS2QzWlRLekFYUjliOUN6SVFXL05KUFUrQ0h0?=
 =?utf-8?B?SGVsTWx5bFZNMnVuRTRucEpmaHpXKzFROHg2TzNnUTBWZ004S0t1N2hlK1FF?=
 =?utf-8?B?MTNyaUY2dksyUkJzOVVzTDVYbElTWmlESUhSTVBISEpZZ2VydHNCY1d6dyts?=
 =?utf-8?B?M2o0MmRZSndBaE0ycW1XU29oVUhNcjFjMy9HNytBZUlhckN1TGF4WVBUaytn?=
 =?utf-8?B?ZEVSZkw4emZWbHg0NXlLZ3dJdVNOVUZVSGR4ckVRUmtzcXluQnRjTnJKcVhy?=
 =?utf-8?B?Skhxa3dLUmIyQ29RbldtekQzQXgzWjAwbkdyWkRXUWZQUHFxVFNncmxWTFFm?=
 =?utf-8?B?NEVRUUV3ZzMzUXg3WHZoOER2cXJHNktwY2VXYldrbU1MQUhRYXYxb3p6b1hI?=
 =?utf-8?B?b3gzRUFSaVRhSHNkajdpODZITGpsUGxSRXNOaWZrVmF6a2QzRmo0SG9YSHh6?=
 =?utf-8?B?eEVOOFlONXFlNVVKRFJMZmVpRnNHa3JzdTF4TTI2TzJQTTE0TkNoL2dJMklW?=
 =?utf-8?B?QTFCKzYxaGkzaUcwRFgrd045bW9vVC9WS2xQSXE0ZnY4aUNKUnVweVpta1ZT?=
 =?utf-8?B?NDlDWW1ET0t1TWNzdFIwd2RQeVB6NWNNZ1QzeUttdmFGL2dVNm9Jdm42TmNq?=
 =?utf-8?B?bTNsbnZrcTZseGl4L2ZYait5eWk3MGZRM0FPSVlCcGc2TjJZd0NFdlcxb2Yx?=
 =?utf-8?B?STFWWnYvcmpsbVhrTWkvek5DdWtOWllLRFJTSVdWSHFTMWFidVJVQmhidDMv?=
 =?utf-8?B?bFNQQjVEeTBzVHllREVCTVhhdk52QUdvSTV3dUhNWHh1MnY2Zk1GSTNQNGdk?=
 =?utf-8?B?UVVtbnJaSWg0bFN5cmxKZ3BVcXdqU0FIYytCZjRRQ25xc2R5QWVocXlTajJD?=
 =?utf-8?B?VFZuZG5NMjN5OFRMR1dKajRXZ1gxRE16RGl0Q0RpNm44Qnh5Qk1jeXBsZEJP?=
 =?utf-8?B?dEpkajRqVllJallkR1F6U2FpV2J0QW9MYWZJNDRMRU1QbVJVeG02UU00ZEhV?=
 =?utf-8?B?TDV4UGdpWjJwMDFJbFM3eU9oa3pOZTFEU2NtMElYcVJHSWFvVkM4SHgzdFdX?=
 =?utf-8?B?eXM2cXhURjRUdjZMMkY0SUg4aDJmYjBGeXo1THRyYThwUTZsSE1SUmF6OExs?=
 =?utf-8?B?MjFXMDRvSUdlNHlPQVlpd0VXcFFRSjdPMVRUVlU0c1E3RExzbTdHcDducnE1?=
 =?utf-8?B?MldHN2tReW0vcmtvNHV1NWY1UnFUNGUwMmRCQlhtcHovL21ZMFBVdW5lcTlx?=
 =?utf-8?B?Y1NIUWEveWp5TCtaRWxzVGoxdXVIMElJcDNadUVMakVScThhR1hubmZscG5I?=
 =?utf-8?B?THRYckQ2UHE5bHp4dmtEa0FHd2tOWnU3cmU2ZklOODY0alFjcTNXdy9jV2ZE?=
 =?utf-8?B?T2tmeTlRNnErWEQwdFhESXZoMkE1WFZRaVRRc2hFZmJPUzFiT1QwNldROFhO?=
 =?utf-8?B?QWs2L0ptaCs5bEJnQUNTMWNybEFVSVJ3WG0xMzFPQjltRTgxdWxiV1RCYjBI?=
 =?utf-8?B?emtPeE4wZlQwNEZzbzlVNkd4RFBVRHZ2bUx0TFh1VFR6S3M1eXdpTEh0NDAw?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70285f69-4060-47f8-e561-08dc9ce34787
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 11:11:55.2157
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tseaP3tOMwphJyW+UBkYcMq83lbWxcL32s3L5Mh+tfBxgF/xpEmAmWC2hflTn7jw4cA0pKDUEa9RuzDu1xoGDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8706
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 05 Jul 2024 11:12:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16392

On 05.07.24 09:35, Shivanand Kunijadar wrote:
> In Kconfig, only SWUpdate is selected as default for security image.
> so, add secure boot also as default.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Kconfig b/Kconfig
> index 96f590a..b86305e 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -163,6 +163,7 @@ if !KERNEL_4_4 && !KERNEL_4_19
>  config IMAGE_SECURITY
>  	bool "Security extensions"
>  	select IMAGE_SWUPDATE
> +	select IMAGE_SECURE_BOOT
>  	select IMAGE_DATA_ENCRYPTION
>  	depends on TARGET_QEMU_AMD64 || TARGET_QEMU_ARM64 || TARGET_QEMU_ARM || TARGET_X86_UEFI
>  	help

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


