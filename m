Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E935C02192
	for <webhook@archiver.kernel.org>; Mon,  3 Feb 2025 17:36:52 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.89])
 by mx.groups.io with SMTP id smtpd.web10.94298.1738604202289417086
 for <cip-dev@lists.cip-project.org>;
 Mon, 03 Feb 2025 09:36:42 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=t0b0l4U8;
 spf=pass (domain: siemens.com, ip: 40.107.22.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ty+NBobl6owrFJbzqOK5WpBVaiTBmeSH0A4sTo9pyJ0cIXeKuzlg11bhRcknRUxPEc6Kk1ID8XQzaVPexuQXkQpqPG2ZhQjojuTYnw/1ulMAUZQ9lyn4elxgn3LA/FrD5pkkD+doGA+xrw3mlJfIzUYri7G6OixQzI54bqCalVKfWzO10SAw0pGX9L0uwobRYj4gW56Ux/9nUEoR+jJ5kbqv2Nch4mvRBYIjPNe1flWosGanOX1XgVrS3Dh0FE0Jbb3f3VUpFJ6Da7KIZ4XBraA28lM+UMBdEB9E4uCjrBy/z8lX+FYuAMW9j0wHiDno9cF8v6IuAOupL7XOkFbVmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZnTPZrrw6p+VaIq1eO7j6VF3pMYJBnbEoELslt+eRA=;
 b=PMA+gRy8XdV5gNqAEcKvw57NqAuLEEQ9WIhiRYMGDE6kXT+81uWl0KNPmSOXOMx4eX+OZADLxesXeFPGg+WHSmPnbWZFILGo25nyRa6PHxFUkusbWWfS5bMc1vyFZGC8ZpWLf46tAhDKq2dO/2rub6kMS8J4zgifJs9bgoDxeNmaIbm0skfH2piAAlPwZ4L56FUstpdVWgWG2OIrH//6nOq4G69hAkQeynw4gK0Fwa0Hq7fRP/DS5sPHexO4y9Vojczr9GHOoLlRKo76on8g5G+/paCaotvWWUkaYHEdUcfC4ba0BUJTzbShSjWDXwzaisN1fAP1dC4fgKmx14XAaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZnTPZrrw6p+VaIq1eO7j6VF3pMYJBnbEoELslt+eRA=;
 b=t0b0l4U8Ir0qcZFTpEgxkwvLw4DjypuEpCfOm3/ZHZL+kc0X6Vd5cP8j9byspYmF1I8BCMvrtN9tYjx7z6kgRvdGm6wrsKkC5m6z8ibmWFyvPaOu1QgJiIpY5ZtDeU5UHgj6RrNFmUoRfCWyUEFjitBJ+nrg5Zj/8nmW60IffBaHSdnYx+A6hMYg5NAYJLu6nLfR3Kv9S4d+OefqLNiIekwZ/q9Z7JaxANX4aivmiz3OW6WiwGVZGv1krtMt3YbUN16hJ8588Yl5fiFV3BUh2cfskhidbr7mDcpFYotOg1dYm+hQ60i8GYgLczDEZonKtCz0c5GrZAex7MCMN9aqsg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.8; Mon, 3 Feb
 2025 17:36:39 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 17:36:39 +0000
Message-ID: <b2f80a19-a8ee-46ad-927f-60a83aeecbaa@siemens.com>
Date: Mon, 3 Feb 2025 18:36:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][isar-cip-core] efibootguard: update to 0.19
Content-Language: en-US
To: Badrikesh Prusty <badrikesh.prusty@siemens.com>,
 cip-dev@lists.cip-project.org
Cc: cedric.hombourger@siemens.com
References: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250129102528.272043-1-badrikesh.prusty@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0112.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::11) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|PAXPR10MB5278:EE_
X-MS-Office365-Filtering-Correlation-Id: c323def7-3419-42db-7b49-08dd4479507d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NHZxKzFHdEZGNk1BeDltUlBIVFZ6dFZQRDFTWU5JV2pMUFRBUVdFWXJxMG42?=
 =?utf-8?B?KzE3MjgzQjVJdk1hcStnTlJwblo4SUYwQWhnK0Z2U2FDYWc1dzExYmdVR2ZV?=
 =?utf-8?B?ZEtWRFVsY3Qvc3ZJVGdkaWtDUzZ3OUV1TjBCQ2dMRDhKMmhUbVBjZ3g0aFEr?=
 =?utf-8?B?dnFRMFplbzU2OWV5OU5XWjAyUkQzQlRHbFh2YldZNjgrSzVjN1BGN0NKaVJX?=
 =?utf-8?B?d1JwVml6SXgwaW1pQksyTG40bFlVVFgxTklLdlBPL2N5VnNrV3ZNWitEeGFT?=
 =?utf-8?B?ZHljOWFsemlQUG1ISkZJSURRYjVGRFJZdFE1UEYrKzVsZGtCY3RaUXVrY3BY?=
 =?utf-8?B?MGNyTjFzZWdTMkMvQVU2bTJSVHhFdjBJY3gxVzlESlQ1TlpDSHdYWHp1RC9S?=
 =?utf-8?B?WStWNmdvRVNabGlsM3Jqb01xbHAwTXk4a2VGcnhJREt5cW4zTS83R211WXlL?=
 =?utf-8?B?QTE2QmZhYmNIdXlXUEFIYXF3ZTJQWUZjVzNZMGp0NDNnS1UwUlBwdVM4b0hE?=
 =?utf-8?B?NnM2V09HZWhYa1BKcDZydzN4S010cXlsU3BBYzF5R0IxUTIvdE1DYm1LRVpP?=
 =?utf-8?B?MWhyTkFpMmdCTjYvTXhBeW14RE1reG5FelJmN0N3WGl1cU1YTERlMm5uSFFw?=
 =?utf-8?B?OXc0dmNBZ3lhQ2ZtMzFWdUEyU2lvZGtxSG5qSHFMRWcwVkxNUVZ4VzFvOTBL?=
 =?utf-8?B?U2VHK3pVcU1ZYTZCWlNJdmpzSURpazJ3cHZZU2wvWHFPQUxqYk5zdk5HQWxl?=
 =?utf-8?B?VURXQ1VuTG5BZEY3aUFMY3d4QW16TFdHY1A1QXFQc1BFR214YUhCa3V6K0RH?=
 =?utf-8?B?emJETnhWUFJlUnFRN1V2U1l6aVJuYkRqaUhrTGFZaFl3QmJlVi9DYXYwVDlC?=
 =?utf-8?B?aUtwRjVZMTBjZ3h1VUxPc2pxOHI3QXN1aHhqeWsxbEZiVDNkamdvTVZHV2lD?=
 =?utf-8?B?emNONXM4NmtoZHNJMXdEdWNaNWVsK2YxelluN2xyTmNrR1F5eXJSZkxzTVVu?=
 =?utf-8?B?TExxUHRGYzcwNVZhVWtCYUZ4eVlydVZYeVZDZTZLdEtwREgvUFB6T0c5YmV4?=
 =?utf-8?B?WE1ucnhweEVZUVhWcWM4b05HYTJqUnJWU3YwZnlSMGRUT2dOT0k5R2lZYUdZ?=
 =?utf-8?B?QVpuZWVyd0JZdmdjS3JMenJ3SHNtaWxydFdIOHlFQUlSeTExTnZqbU1LWFA2?=
 =?utf-8?B?bFNZQStpcFkrK1luSmJBRTBLdTVsMlIvMUdMRzRTWVBSU2dIRUJCd2J6WXJO?=
 =?utf-8?B?ZUVNVWdSeWVXNWo1eW5TWm1sTUpoaUdPNVVHai9zMFZuR2pUQk85c2tLSVZP?=
 =?utf-8?B?ekQvb21WY1gxMUdaaGxTVDFsUXNNd1ZNbVQ3Q254dXNncmlOckpRdU42LzFa?=
 =?utf-8?B?UkFRaU9zalFjNWxSWlhmakJaa0lydG9GdU9ZTmdCZDl5dGNJcUpOQXpWRHFu?=
 =?utf-8?B?dHNyYXl2REZYWE00bytmVjB4dVQ2RlZaZ00yTGpwc1FWUlJJY2s0K3REWGwr?=
 =?utf-8?B?UXN2bjl2OXVOMkFXSW9tSVI3UjVOOWx6ZE5LdTBYRUphblpoU2ExdUo0NHN3?=
 =?utf-8?B?ZFUxaUgwdytIRDVNY3Zac1cvZnlFcWpiekh4SlczN01ZcEk3SVAzZlc5U0dR?=
 =?utf-8?B?Z29tN1BUMWRTbU1tb1NwS2FnY256LzA3QkRCQ1B6M1lJM1BuUlo5TWM1a09Z?=
 =?utf-8?B?aWdlSDFvbnF5a2xTcWdzN0ZZZ0g3UVNXMWdDQktiVDV2KzNGTE45dktGRG1n?=
 =?utf-8?B?MFNOTzl5c1VXcWlRZDlJQThZRHMrTng2Vk9MMXdGeXoxcXhjM2pZU2dFR2RB?=
 =?utf-8?B?L3FJUU1LSE1pU2QwUGw5MDBUVFFLUlhidDJpUjBad0NpUWF4YXB2YkJxeVlG?=
 =?utf-8?Q?cY8K3R5hW3Hn9?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VzRjWUNLT2IrZ3h6Qit4a3ZYMU5nSE1WYkVIUXJtQTNEVGtOdFFpMUxmYk00?=
 =?utf-8?B?UVUxSTNjTCtZZnBCZk9HdTJzSWwvclRjOWYzaElpUnVkNWZ4dDI1eHJUZzkv?=
 =?utf-8?B?c2FGRjJ3TTBicFNRUHVXRUVBbFdlVFh4N2NQVUdMcmxFZ3RvMkN2bGRqbWJ3?=
 =?utf-8?B?SmhSM0E4RGQ1YWp2NDhIaTRkUTVHTWZidithZUp0c29DcHJpK1MrMUdZSlE1?=
 =?utf-8?B?cTUzdWszdHpJODhXMFlpVFQ2ZFR0S2lZM2c4bFlwSklHbm1nUXFJV0tPcDRY?=
 =?utf-8?B?UE1adSthZm9rQXVhWW0zRXRlMGhqZk80VGNDa0NYY3RIWGE1QVFFa0t3Yy9r?=
 =?utf-8?B?dGNyL2pHT2dBaitEaVQ3OU1zOWxwa1pENDVKVjRVV1pETnZjSVhPamZpRmlF?=
 =?utf-8?B?V3p3Q2xqOVpEcU03c2JLTlpWdjBLakpGY21xVDdpd3g1VTBzcDFsN3d4M1Zy?=
 =?utf-8?B?RUFkYjJXRkdkOERadWQvTktVSENCaDFqR3RQMHZkK1ZWTDZlbGdKdnZZUmVG?=
 =?utf-8?B?YUl4RkR5RVo5c0k1dGtranprSHFzTXh2amZFWEs0azBGdFZWNkpXWGFFZHpD?=
 =?utf-8?B?V09MQXRuQkREbUNocnRrSkZtM05EYlUvaEQwRHc0cytBY3ltV1MwQUlHd3A0?=
 =?utf-8?B?QVBHSjRRejFhZWNncWFvNEppZGRxc1kva2ZxbFdWSTVpU0VUWW9BUGFIRHZS?=
 =?utf-8?B?bEIxUmcrQzJtUnBCVnhwWkNMVEJEdjU1Q09OWWZuK0Vqb1pNeDZEMXhwTEh4?=
 =?utf-8?B?K01UcncyKzgwaVZYZjNNSERtWHF1V3hWWmhoMjhkS3JxSHVQeU5nak1HM3Y2?=
 =?utf-8?B?V3NJV0NqbS8vZVNqQ3dMdVIvYkpwWlNYNEVKNlJhTzBLb1c0eERnakw2WXd4?=
 =?utf-8?B?T0Nid3NHUnZkN0V1Y015TnpqUStpM2xCOWt2djdHWW5EK0RETTE0UGVjWE53?=
 =?utf-8?B?cU5WYlNoRk8vQlJrTVU3QkEzV09ha0l2UFlEK2pKcHdhWWJrTVZFTjZUQk1E?=
 =?utf-8?B?cUQvMC9UVGUwRVMxUVBGMEtmbjVMYTRwVTI1Ykp1QWlhbko4bzFPS0UzSXJi?=
 =?utf-8?B?cHlPbHJPT0tiK01hMmZjUEI2ZE9kTnNhdUhvbnNxRjZwOTE5RW9CODNxcURQ?=
 =?utf-8?B?U01PTjI1MzVEOEpvR1J0T1Y2MjlxUHZ2dzAzdCtqNlNMVWkwUUVESVdjdG92?=
 =?utf-8?B?N0xsbnp4L3lZclJLT0N0bHFzOU9xUGQxMUJGV3N3RFpRR090MGhSN1RKMzhT?=
 =?utf-8?B?UlgvNDJaU1VsZHRKR1MrQk9DRE4ybmNKOEVrVWVIVWxYb3hKdHhHUDF3Vkt3?=
 =?utf-8?B?UUE5bmUyT2tLY3ArbTliWTJhQmswOVJhdXB1MEZrZGZtVGJFZ0pzQm81N0dq?=
 =?utf-8?B?Qk1lalBaYzBGYUZXcitkSGpaQXViUzlrU3R4YXZ2VmR3eDYyaEpGQjZZWUV4?=
 =?utf-8?B?WXQ0VVdtbDAveEkzaE5YR29CNGhhNjRicmpvcXFNemFQdThWTjdvbytrMHBl?=
 =?utf-8?B?NFMva0gzYVBiaGVTREJ3eCs2amtsQng4RDdLRm1jeGtLWkl6RFlUMFN6MllZ?=
 =?utf-8?B?NUFkVmtkUE1XV2NKSVg0STFHc3E0emxselpKMElveklrUXNWRW9UQzh1bVBD?=
 =?utf-8?B?TW5LTlF4b3BJNDNzVjVicHpvS0hNZXlEQ09PKzF2MWRleEFhcXJiMzZRUFlv?=
 =?utf-8?B?NzVTRHRPWWhyUzRybmJRc2psaDNpaFNFQmRXTlJ1MUp1RmgyNHJZT1pDUlNU?=
 =?utf-8?B?ZVZOOFJHZjlFekh4cDJ2ZUNCUStaVndneVhrdE1EalBkUmJiU2gzYWFGZDFP?=
 =?utf-8?B?c3BGTTVmUmVOejY4MXJ6K0QwZHBjV296Ujk0eC9HbTFybisxQ1hxSVdLMmk3?=
 =?utf-8?B?c0R6b2g3VW91d1BkOWtBT1B6amFESTJacnBwbG9mMEFkUnNEQmh6ZmF3bjJG?=
 =?utf-8?B?bFZOMEZBaVJGdHFlWXZsbmdOL1JpUGlJS1BTRkFOZUcrV1lsSjRtbHNHMzEy?=
 =?utf-8?B?UkcrRmw5TlRKblUxc1o1Tm1VRDhNRWZmbm5FTS9tSVg5MVp1bmZYWnFtdTMz?=
 =?utf-8?B?WCt3TzhkQ1lUakFYaGVpVFRJUGZQRFRubDhzdVVzd2pIcWswZmJnOFlXWC8r?=
 =?utf-8?B?QU00YTh6b2Y4S25kblZ6UWdwQUZ0VUxvTHV1SkdGNkh0aU1FaTJZVlVLWHZV?=
 =?utf-8?B?MmY5K1RQZXc0NGpjNW5JcUNUS1NtcTN4eXMrS0ZNZkFPT3NkaVlFUHduemNv?=
 =?utf-8?B?OURINlM4UXlrdFBydElDeXJNWEVBPT0=?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c323def7-3419-42db-7b49-08dd4479507d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 17:36:39.1418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LMzgByhCf6IKpo7nIG4hRK0P+PG53YTAa0xf5V6B5KDkeH7v7D5tSRi3me9ddeWI204s5efTW2GudvbXUYU6Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 03 Feb 2025 17:36:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17736

On 29.01.25 11:25, Badrikesh Prusty wrote:
> The latest efibootguard brings the Watchdog support for SIMATIC IPC BX-21A
> and Advantechs's EC EIOIS200, added support for and usage of the BIT(x) macro.
> 
> Signed-off-by: Badrikesh Prusty <badrikesh.prusty@siemens.com>
> ---
>  ...fibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>  rename recipes-bsp/efibootguard/{efibootguard_0.18-1+cip.bb => efibootguard_0.19-1+cip.bb} (87%)
> 
> diff --git a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> similarity index 87%
> rename from recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
> rename to recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> index 6d32833..981aa3d 100644
> --- a/recipes-bsp/efibootguard/efibootguard_0.18-1+cip.bb
> +++ b/recipes-bsp/efibootguard/efibootguard_0.19-1+cip.bb
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2020-2024
> +# Copyright (c) Siemens AG, 2020-2025
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -23,8 +23,8 @@ SRC_URI = " \
>      git://salsa.debian.org/debian/efibootguard.git;protocol=https;branch=master;name=debian \
>      file://debian-patches/0001-d-control-Make-compatible-with-debian-buster.patch \
>      "
> -SRC_URI[tarball.sha256sum] = "023b96548e0779bd7aaf58899883099dba9993b1b4af0c858adc00382523ae52"
> -SRCREV_debian = "7e31b8f9cc204d1210c6c03381f936a96c29b35f"
> +SRC_URI[tarball.sha256sum] = "167a808d508558341b81d9a493f76161ac7fd7119e764435eae1b13e31a69737"
> +SRCREV_debian = "040c116a61ffc99a92b6cbdb793abb7f51ef8d4a"
>  
>  PROVIDES = "libebgenv-dev libebgenv0 efibootguard"
>  

Thanks, applied.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

