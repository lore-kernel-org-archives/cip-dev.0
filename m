Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA91EC01CD
	for <webhook@archiver.kernel.org>; Mon, 23 Mar 2026 11:28:43 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.12])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.15008.1774265311282998331
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Mar 2026 04:28:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=pnJb2y2N;
 spf=pass (domain: siemens.com, ip: 40.107.162.12, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nlaWEt3w+hsz/XJSWzuklRebeCr5jcInIcAMZSBC26Rs1q/F5NTZxyvly7MPf0mM8RB1Jv9TEChf6qgx3EdT6u0YmHegedfTqKpaJIR6BwY3mlrveMSoYXyFr28GYrWsZyPD4eX6BL6xw/5/JxZPJIhcMGE1AYN5y1aCKTd5B+VjWP5MRxS6Ko/uIOJzguNsgthQvBPy8+HUavERoJP6gC2qVkKw+WbhDARR/wEtBZrrA4GyEWQYYbncX6/b53IFRx8Rqtj+yWEoB7V2QtGewbF0bsES/CclNoaQiBUroKjEAUocgSsNWagMHGiSJbDxlcryR64p+r/AsvI1uHCsWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neQ4yz4WOM7tUNWcZiS2oIC1AhfvaXUapfgFoVYfp4w=;
 b=C9srjxjle2imcDVFYxzXYZdMXVoLgUCSndrd/CxmNgSZwaukZj0UNBPmbDOaqc0Qa6OK/59xKOx5fUDbVs8ui1V0zrFcq3gYPzj5l6N0MMZw4e6QnNwtEa9y9/FVjfzFq79ZTolPbhWn81WzPt/5+ndd9gIjlxDJI8aWnCq6IUggEeczGIH6/tn8whDW0UVDe/NPR15J8tKypwtiHTZJ6RJOjaYsEwfjaAKmvu9MRXVwgfyOgmpzZb2lRZcAyXMMN5oiJiKm9Awh6gNbo+6eWejYAzM657Cl5uJdezOGazbkgfdEQBUfXO+rj9KNV2ExHDAsRHgrWRgmXq1xVkTRew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neQ4yz4WOM7tUNWcZiS2oIC1AhfvaXUapfgFoVYfp4w=;
 b=pnJb2y2Nt4sRijuaNU3IZJvbiZn1RVXCIiEDC+/EQdvhc0ex5uuCP0ddT34HbUFFO2Q8kpiTqPqF1bJ9EVW/hkkJ1qBkNarSuwyG6PWutu7fZlKo1f8eJCQtk73TXKdK/rIGRsr4FQzFNyPT3pvblNFv6TDiIDq7aCAY+Txnd0Wqi8P78Udg/XwmJ4iXbJF4CekkYt+IewJu8XhJYod64MyrXGEB1FFkiL9ZZN/vUFm8st0Jk4b3gtVBkmOwg/cwP5JLUOUQue+O/g/tI5Y3UAeu1j1hYOLlHS1+PBSdOEa5RW6JnT19n7oxwtZpgYoBkopVvqjrxlfdGmhgg5mQPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6407.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Mon, 23 Mar
 2026 11:28:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9723.030; Mon, 23 Mar 2026
 11:28:25 +0000
Message-ID: <9a353cbd-f3b5-4f90-84dd-f27e9846d50e@siemens.com>
Date: Mon, 23 Mar 2026 12:28:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/1] start-qemu: allow more variable
To: Benedikt Niedermayr <benedikt.niedermayr@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260323101546.3273376-1-benedikt.niedermayr@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6407:EE_
X-MS-Office365-Filtering-Correlation-Id: f0512e66-46e8-47c8-6517-08de88cf4c1d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|55112099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	/7g/tTAkgzI/7Jdgpo8I1BPzANVa10+YrzS7BAvleb8RkapxTHsrMA0dK3SrYRjn1PzK9aiJF53jZQJSdjEKfc55K3EvUVaxcLbpuj4Mh59f51kDyNXbXyvCcqnVFvgr0mdJc5xjzMGxLkSkTeVaaaFu+luaAXGZitR3dxwZkJNQF/pVmsFkjsjNkoahvjqOKRZSzCRSBcccrTU7D21woSRvbnEXRBz7OkvajVTu674WjksMb5eW/PI/6QmbrmBlnNUyrZ2R67BNpyI667SfCt91LYABYXnTF/ei8iswQBLBnp5yNadkCg6OywoObUvhwFgVQdHuhdZpYb34feSj3SXPMA+U7G6N7z9WCEBEZ0IeiKepbotHhyLbvMps5pursAjOd+UdfX9Omv6F9VpYyG10wMXCyocdovm+v1v9m3fYzY5GQ3f15Hs0krdFtqDQRfaIDNF+Sjf7HMLArNTBemIRO66rAuYaKIoqh6AdCqA6onOhhOEQEAvz2ue0sfY0vG8OD5b/c/QT9nDydkfdfEn3/3/r1OXH/Bftu8Lx+oQJ0fZNk8yAabXZVnrvvP2HtSO+lSUiz7b8jl9hyrFVzyLtNI3u7ZN/smzPTqczAx+6nTwPLcGrk8R+b/ULCJmDqAN8h1mTJ4Xn9xFUHlOt2NQk1pfrRCBsC+A1vGJIySBwUmOSzI/MybNiDPUVDAZsduQXjO9ZHVmujLZaimSWkPNeivUeWePYZl3Vplk/U3M=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(55112099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NmZ0U2owZmUyTnU3WGRFeXB2bHNjdVptR0ZPZS9Cem9yQkM0RHk1enRNcU5L?=
 =?utf-8?B?MlUzVWFvQlJsTVV0bUtvR0ZxTXdSRDJaeUxvMm11WFNCdVNyN0pLWkdoQUtt?=
 =?utf-8?B?R29XK1RPUytHRlZOV3lkTzRmdmtvR254SjVVZFlBLzNwcVBhSjZmYnlFMVd6?=
 =?utf-8?B?dGUzN0o0SllNWCtTTDI1TEdVanVudXJRdFI2VkttOFYzOFZMOXFlZjhiakVa?=
 =?utf-8?B?TjM1c0dzS2p2OHhBUVNEck9WVm5YYjMwcUYwTzdqZFd6SS9vcHl6ZStlYjJP?=
 =?utf-8?B?RUtvdTlaY1RYV3NQTVdpckFiUzNBdEYyUllJdm85ZUtjZThpRzloS05oLy90?=
 =?utf-8?B?WHo0RmNCMTVUYmo1aGhVa3JmdWNuWUpPRjJ4alIwVnJYSVRaZzVUZEltMVMr?=
 =?utf-8?B?eXRRWUcwS2cyS2ZPRnBWQUpVZ29reUFrM2Q3UTQ2am5uclM1RCtvSGRWNWFZ?=
 =?utf-8?B?cUZpSW1tZE84KzBsSTVyOEZQVWVaWnY0ZzhWcndwd0tNRXdqQkw5c1VYazFl?=
 =?utf-8?B?eTBHdDVpbkpCUFV3UXl6NzJ2ZUZpYUNsZ0Y5aEtHbE5zamxuMm1XeWlQNXJI?=
 =?utf-8?B?akJIcm5LdWxJYTRtYzN6U3hOY2V6NjBYWUgwNnZJNzNIWk5TUmNtblFIWUdl?=
 =?utf-8?B?WnR5YjQwOCt5dkhIdFR2V21qUTRnM3FGcis0SDRzNkhhdStsdGhSL2l5ckRu?=
 =?utf-8?B?N1NFTEd0VTNPQ1Fockp2QlI3emt0WDdNZnZzZER6Q1hOTCtjbWxFZnhUNjQx?=
 =?utf-8?B?cUI0bXV6S0ZGYkRhU1NaTTZYZzFkQWxhcmsxb05SUkpUMUFTSmExVXFVVUZx?=
 =?utf-8?B?RGpYaENrbi9WL1hVcFNyRXUvaWFFaExzN2ZDeGgxZGtGejR6eWZoamhGQ1lw?=
 =?utf-8?B?c3RwaEErZklQVzdLRjJoYTRqRmVWbDE5cEd4ZE4yUWFnNzZ1YmlqOTF6dVE4?=
 =?utf-8?B?RzFGTkdHblAxc0VNUHZsM3R5TjQ2bE41ZElrV3VrMExDNWo0U0JMaVVqZDZa?=
 =?utf-8?B?OGNTQ3UxRzV3ZzJ1c2pNRVdhOFlKYitGTHFNUzArcWFtOEd5U1VrcVp5VlJF?=
 =?utf-8?B?dnRjWXpSdnc0OWlyc1Z4Vmx2T2tEZWdXVEdReXNoV2ZZZG5GOUFOQitFV1Ba?=
 =?utf-8?B?Y2NHbHk0MnFmbGFmNUZYK3ZqOWJVa2gzNzQ1aDZrTmhtM0JaTGYwQU04V0pn?=
 =?utf-8?B?bHpCalNvSGJzMmVJa2dpeHh3MktuRzB1dlYzbGdxTVN2bzNIekRrSFdSZkFy?=
 =?utf-8?B?WWVIZTFEclBObytGNmw3OUkvTVF0TGFSbHIrdFV0MVUwMHQwejcvYnUxaG13?=
 =?utf-8?B?bTJCVEh6WW1TZGgvcEdzRlU2RmVEdkRDeVlBa1gyOFRtdjlHcmdobTZaRWZE?=
 =?utf-8?B?Z1BYdjZGbWkrWnc0R2VKeTF3aUowYXU4NHRiSEJ5ZVhra0JXK3ZXamc0eGFP?=
 =?utf-8?B?VDRlbDNFMzUwUzY0WUJUUVBYVFJRdXZuc2VkSGMvK1UzM2RBZ2dGNjJxV2t5?=
 =?utf-8?B?eDlUNFdRWGt3QmVpaG1vTGJIYWY5c0lTZTQ2dFpodVI3cEJZYVVBOW1lYmVO?=
 =?utf-8?B?V1lYZDB6VDIySEo2MVU1UGp5RFBhdDJWQWV3eXNJUEo0Y2hrdTVyZmxFZWdn?=
 =?utf-8?B?NnZNa1NpbGtEeTZkd2I1bU5PRzhXQmNhRi9aQWpUMEZCL2JKTmFsRkdXUEwy?=
 =?utf-8?B?WjRoTE9Hd1lZREhHWEJXTFJ1VWp2Z1BBa1ZyNWJZekRaVmQyRlREcWFXL3B4?=
 =?utf-8?B?RjdKRDFQRHhhSnNxMEVYcUI5aFN0OHR5cWpMdVpYK3BlMW94TG1UVmliUllU?=
 =?utf-8?B?cEw0R3pTZFUxYVp4eDNrUkI3TGxPY1NzUkpFaWpoSEk3UDc1VHE1dURadEEr?=
 =?utf-8?B?bld2Q2c1SEVKSWNvOTNyY0RybmdxL0JlVUJuREZUMGlOcDlCNFVGclZ5Q3dv?=
 =?utf-8?B?M0dFQWlkcE5jRFF6NEJzbFBpNkhjUWpNeTIvL2JvWlZaNXJKNFk5NEQrTzA1?=
 =?utf-8?B?Sldlam1xTzNXL1FZK2xVMUpFc0J4TXpPOFBBR1luTDhna0E1Z1pqaEUwdGR5?=
 =?utf-8?B?emFrVDUxZGpUak9FcHNHYUhSdEhocjlyRGovd3dSVGRkSFRwQWtnNUh2QWJL?=
 =?utf-8?B?ZWdhcnpHbWR6dFZnVFZDNTQ3ZnpwT09MWVZWYzRESWJESXQ0WmtGTy93bHVh?=
 =?utf-8?B?VFF0bG5GNW11Uk43LzVkMU9ZbEpJNG44ZXAvY3REZXREVW8zNUh3UGcwd0Yr?=
 =?utf-8?B?dlo3TC9iQkx3MGhmQWRUaWkxYXhnR3UyZnhFTGlMcGlQVUxCQkVyTnMzVlRK?=
 =?utf-8?B?NzBvWFpIYmpRSWczdkJaYzczaUo3MitkZ2xpdWh4cXBVT2Y0Q1FZdz09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0512e66-46e8-47c8-6517-08de88cf4c1d
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:28:25.1624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u+kygJwDMwkSG/zXWYRGrXbX8e5lHGpGjMPEi/4VJYZWOjBcM9AKJ+BP2yW7sE/48UcNdqScFHFqpS8VjXABXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6407
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Mar 2026 11:28:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22530

On 23.03.26 11:15, Benedikt Niedermayr wrote:
> Reposting this with proper subject now
> 
> Changes since v2:
> - Fixed variable name DATA_ENCRYPTION -> IMAGE_DATA_ENCRYPTION
> 
> Benedikt Niedermayr (1):
>   start-qemu: allow more variable injections
> 
>  start-qemu.sh | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
> 
> --
> 2.43.0
> 

Just to set expectations: candidate for post-v1.11.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

