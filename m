Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96E62CAC5B0
	for <webhook@archiver.kernel.org>; Thu,  2 Oct 2025 15:12:08 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.23])
 by mx.groups.io with SMTP id smtpd.web11.11772.1759417927737037827
 for <cip-dev@lists.cip-project.org>;
 Thu, 02 Oct 2025 08:12:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I2KL3ZXg;
 spf=pass (domain: siemens.com, ip: 52.101.66.23, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ld+KqkAo9jnCX13dYIWI9yw/CmivQny5NGbMZ7r4binupNcFsXD3Du/kAGMZyHWIx7+1kpkVlggobcTTNFZMAo49oDqETY7RaoKp4VzRZMLhlOF63dO7HwyGMnhgO1WMQwdcwpspH4OIAvMhiEy4+kkDNa8ks4V3m4X9eWp9B1w73N7yi/yLOOjD+60D/33AJ06+gA4xQACbd3Ary27t2hWOzHKs/SzKB+Qhk+4xPrepe2F6/iKl7iM8KEB0U8KYMPsq8Q8/DJQOfNaSPGOrh4CNb1nRwrN2xrswlvExyv+rNcqmSFrDJsReYQqAhrU9m6M+TxtAERKSWZund2Hjtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVh75SsQJyhoCDE+1RMVmAxdVgV3hQFFfTzIorFReyE=;
 b=fP1kGJki+x3kdsPXlpsKk1IUgDk+E81tt1hwZjyHO+El0CoQwWDnx1J/QLelqQ2km/1rMYU0v6UN8Px814Yzjk+EEj/Ya8/1EOhx6s1UAUtKrWXDdwEkTrm2x4vBj2LS0sOXwVc5I9EPq6vNSa6KkXxzpS/8ZZsy8Hw2x1Odqmcm/c0oMDg3WIDagWt9rm5VEcrdzHqYAnx7DSW07dkhcDcUfVo97/wg7DYL5EsBDBclrNmwgAS/6kdTwRvBZVHlUpiVVF9UEA8TcrEbHfxHK7gplJvxJTBU2pneKeo6jb2LDRnW1tsJqFmFHBIjoh1EztlHn63j4jyQ9ChNHZuWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVh75SsQJyhoCDE+1RMVmAxdVgV3hQFFfTzIorFReyE=;
 b=I2KL3ZXgpRgoA6hb1WOyxIwFn0MdeePWSY8ySM8gw1jJXvoY4fbnOL8FpTRexuP6ukrzb+dTfUM6r+gaZ9FZbefB+RJAJvMs6aVRbBE8nLDEiDqqb+AhZtaqBbsgAysjCMbH7xnkgrlj/MIT1wLs8Ltp32m/qYK59EuBze9l/67fPbiDS8pUnXOSrf/LMSjaA2lqtzF48c14+hKeH1z6RAknm9QpEYkVC652rwP63MGK4Sovpk7QnmHgHMHKWVdvjdd0z/cy0uiTk9BdyNIl4ksBvSd5BjHtnUgDXUTNn/1OptAYPwfGgD6TIS8gz4tN2GsCLkEIXpwntWLH0wLGCQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6124.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:98::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 15:12:01 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 15:12:01 +0000
Message-ID: <df95de05-096b-4304-8732-973523347159@siemens.com>
Date: Thu, 2 Oct 2025 17:12:00 +0200
User-Agent: Mozilla Thunderbird
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [ANNOUNCE] isar-cip-core v1.9-rc1
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6975c037-284c-4a4d-144e-08de01c609ff
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d3FNN3drSDl0S2xXWkEwcEsxbmNNdjJsSVJWV1BONDJRSEZmNWNCaE5PdE5u?=
 =?utf-8?B?UnNLK1k4VG9UU3lJTEpGUXNVelB0RU5MRkd6aUNVd0Z6Z0haUGdWS2daaWRy?=
 =?utf-8?B?c2lxUmx4eTNOT0NDa0dRTHg0cGZicVFzUHNhMXB0a2ZTR1E5YmhhZGZFUW1R?=
 =?utf-8?B?M1FhenkzQXpTdFVwL2hIdS93Y0FhOEk3dXFtb0xFTHlVamloZ1UrWm5RUDFC?=
 =?utf-8?B?TGZ5OFhrdlJOQWUveC9uVUdPVkd6RXFTRVhUdjFpSXZpWGNQN1g0ZHMxbDRV?=
 =?utf-8?B?aU9LcDNtdUJ2a0tYeUNJNFM4eDNQS2ExSU44VW5lOWZrdys4RHhRK0RYMzVM?=
 =?utf-8?B?emJnbUpid3NlODYzM0RHVHVPYlQrQ0lKRVFYL2pmRUJwOTh4QjMxTnYva0J6?=
 =?utf-8?B?cXp4UXJSbTE4bkd6WkplZzZwYVp3dUhFa0REUFNGb29JcUhhS1B1N2FkYkdv?=
 =?utf-8?B?V2swMnVyTXV0NGt0UC9DZU9rb3V3N2FxaFMybXJHTDN5UWNGa1E3V2hWTCtV?=
 =?utf-8?B?akw4ZHNoWG0yWmhHc1NpbklxTTFzUFdxQU5lVFJvVlREVFg0MHZvWmlqcS9J?=
 =?utf-8?B?WUtaL28vbHI2aHo2eFh2aFAwOEd0YUJBMTNEOGZ3S2h5UEJqUmtkNUNXa1BV?=
 =?utf-8?B?UXhMOTBhL20vUWkvaVdxdEI5aVlWTzFGVFM5a0dJdFJPenNsTzhPZG5oUlFq?=
 =?utf-8?B?VnFab2tubjFNbmZ0eUhlNUxyRC91bE5neGZRK3dzU1N6QlpmSlB2dHgxcjdV?=
 =?utf-8?B?dzErWm9qbDVTUnFza1hDR3pzSnZGTUFBZTJFdmtxMm5zTzYwTlEySmdUVGxY?=
 =?utf-8?B?a0U4TG9Gcm1TN3pDc2UzOUFHYmdZblBuZGxZRkF0UlJHZkpYQy9IM3kxcFdt?=
 =?utf-8?B?WlAzU0xBM3BEMUgwMUs5bko3Qk9TTW0wM3FDZVoyVUh5d01HSjdnTXJsMUl6?=
 =?utf-8?B?M3dQQzJYVkZLNWZXWmdzbjVESnByUVBwTUtFeVVtQS9GS1NabEd5eXMzOFhM?=
 =?utf-8?B?VFRyWGpkZ3NzaUM1bzZRRy9YWjJ0OG1nN3ZIVzFidEpMaHlLdDk4ZE5DUzF1?=
 =?utf-8?B?bHJ4TWZlQjZqeDR5NFcvdUZsbjc2NlVKYXhjWjRiN0puKy9FYXAyUlFkTlZa?=
 =?utf-8?B?N2VwcDZHQXU3NU5aSkRhQU11THFuS3c0UGVxL1ZxZGxSaTdrMGVuQkNvdUtq?=
 =?utf-8?B?OTJMSXMrVGthQUhVTUZPQ1ZrdkRaTzhZMEFkMlM1dXgycmtJYldBLzVLZ3VP?=
 =?utf-8?B?U3VMd0hydmNtUXkrMzNnSEtJaThRaEpsSjBYUWhpTGxvd1hYd1pFTXc0TDR4?=
 =?utf-8?B?dkNaSHpWd2xaWWJIakRJVFZTQ29jODR6VnB1WFJUWTR3UUdXT1JiVndRYlY4?=
 =?utf-8?B?Z0RrSHdpdmJWeGh0bUZPenM2YmNycGs4dmZLdzNGaWpLeHJWbEl6aEVpQXFR?=
 =?utf-8?B?d1g4Vklvc29KZDU3MjU4UUdpTGJwUDc5VENUMDUyd3l4ZGMyaUZpeHR2Tm5C?=
 =?utf-8?B?YXA2UTZOUUFESVRZS0I0UXQweGZYcGx5dlZCdjhXd0k1R0l2NG50bURRMXFP?=
 =?utf-8?B?OFFiTWl6MmVScXR1K0V3MDFRMjVkM0pmL0Fhbld5L2xER1cvQTZqUDZ3SEhS?=
 =?utf-8?B?b0Q1VjU5S0dBSFlFRndFOHdtWGRRQ0pYOGJuTVBJQjRxZkV3U3d4aEh5TDRR?=
 =?utf-8?B?RFRLelNWcC9OTTFyd3d6cC83L2pCaG93RXlLbWNLdjd3dEJwSUZ2blh0bTg5?=
 =?utf-8?B?dW10WEtPaVJOL05ZME9XcGoyNEZ0dkxMT215MTgvQU5lam1xMGdUM1IyQUMr?=
 =?utf-8?B?WENRdjgxVFk0UFJvTmFNNWM5OFRIVkJZT1gwZzIzMUJDaTZqVWxKaFREZHNv?=
 =?utf-8?B?c3hsbnVtYnFPMDZPbGlHeGtQNUZoTTVDUUFLQ0NaajcvbUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?YVE3d2xtdmpVa3JxdG9lUzBtczhrNmtYeVRBVlE1YmlZR1JsZHFzWHkwVzk3?=
 =?utf-8?B?K3htUm81K1VEbnpJS3c1bDVadVFUZm5aZXlWZm14Y241NHpVZ0tQbnVMZ0px?=
 =?utf-8?B?Ti9aeExaU2VIWjdVelBNTzBnZUFwMHZBVGgwc29xNTJHQzBSclVLRDBLNGNL?=
 =?utf-8?B?U0tUeGFqajRtTW9kaks2eldMNWovaWFoZS9ZSkpJZm9EVm1tMEFkL3lXMnhx?=
 =?utf-8?B?dWkrcjFXWG9TZkJudm02TTEvM2FBYnRWb0dDczNaUFViQ2dVYnJVQWhEUVRh?=
 =?utf-8?B?SWpnSUprUTlQSTFtOWltdHVud090aFo2Q0luVjAvbWN0NXE4R01rM1poelZI?=
 =?utf-8?B?SmQ4TFhERHlHdHBCZG0vcGxxTHN3ZDBMYjJrY1J3c2JuUG9KUG5paE9OS3NY?=
 =?utf-8?B?eWorcWdpV2dMU3JKTTM3eFJORWFlbzF2QzRZZWxlZlNENis4dDVENTNnYkt3?=
 =?utf-8?B?enNwR0lOWDZxMjVOam9PcUxBZGo0UEJDSW4yYWpDL1JhU2dOZEJoQ0g1VHFH?=
 =?utf-8?B?THlIcmFMeUUwTkhlNWI0cnhsT1VjL1d4ZUlldXIzVmRsVVVsVDhpZStiVjBH?=
 =?utf-8?B?UzN5N2VJblBlaDZjKzlnYUlCZVlJZnRVMVNndTMwMnh5cEF4VHA4citwQ1JC?=
 =?utf-8?B?Y1dvNklRV2RvQUJyc3piRmt4cTNrT3pQMXAvL2RLbExwbVNVekFsbG5aOU5C?=
 =?utf-8?B?ditlWnR5eXhMakZNblpXZnBlY0VNamdjTU5XWUh4SjNieXppYmU4ZDJPZU1O?=
 =?utf-8?B?bFN2VmpDRGhxQ3c3OFhsR3hwZjAzK21Vc1NyWk1HdWs5anpQeU93U3krU0lp?=
 =?utf-8?B?RTJmUVhaU2FheTFMd3p3bzdBeFhMbEtmWVA3TmpRQldWdGRJZndqN3JoRkh6?=
 =?utf-8?B?SWcwbGJ4b2Eyc1p6aWUyK2xZUFd2ZUJoeXJJeVJCYnRVcUozVTZXVjkzaU9h?=
 =?utf-8?B?VGpZU3ByS0FBUlVxcnl1UWxCcGllbmhxWWNHUVU2K2diQmpYeGIrYWFYTS9N?=
 =?utf-8?B?RFdOeVZyV0k1SmpmVXJ2Ui9CcTVNWFdVMGFWV1RNdHg4UzFUSXVHQ0dyYlA1?=
 =?utf-8?B?Y3dTMWxBS29tT1V0SVUrMXZQYXhaQi9HT0ZNaGZNUkc2M0d0UDgzeGJlNnpw?=
 =?utf-8?B?bnR3d2xMUkcxOTIvUWxWdUdzYk9MT3dXNHNha2s2TEtmMGtNWU1ZYjhoK3p2?=
 =?utf-8?B?dVRaVHR0SnRNNlQ0OUVzb3d6UkhCTGxKRi9QZHppOVJqa09hTmlzVjZ5d0c2?=
 =?utf-8?B?UHBRU2VJRm12ZlEyT21BQ1RTMDc4cTY2ZnpOZDZTVWRJRXZDNFJJL3ZXVk9R?=
 =?utf-8?B?T2JYMmlPUWh5S2RWUnVydU1Nc1NmNitqcS96WXNSWWY4Y0lNZitDRHdvaXhR?=
 =?utf-8?B?cit3a2VmS3lPUmZNVzIwQmRWWk8veC9wWVphSnZnNzVwQWNZUDljclMxYTBm?=
 =?utf-8?B?ZXRnRkFIelViWDhOK2d2d2Z5eVd4a09xVXQzaUNJV0dTSU5oRk5lRllzWkV0?=
 =?utf-8?B?MElxS2ROajU3U3JYVGVYOXpqdnlIV0MrNUl1WEtZUXV1MzJscWdndENvcEdE?=
 =?utf-8?B?RFB1RHNMZG9SbXJjeC85VHJ1K0lpd2pZSVFnVTRROGNIRGJGeTJwc2xEaEhS?=
 =?utf-8?B?dWViMXQ3dVlNVHVWRU8veGYrVG5IVlQrS2prZ3NEWnpPZzR2cWtIN0ptLzZp?=
 =?utf-8?B?WXBraDJNRDgwV0k3aVJBZkNOYVFCNXZ1b1JSckhML0VSOWV3eldLQ01BM252?=
 =?utf-8?B?dHRWTkpaVE9kdHRtTXM2SUlhazdsZGtuMUJGQUZEd1ptejVIbUkrYzd0aHZ5?=
 =?utf-8?B?OVNxanBhY0ZnQW9XakZLakVCcE5MTjl6dmVNNEliOXRTTWtISUdZZzJjR1d6?=
 =?utf-8?B?cjNmUVF2OHlDZzNpbXZQTVYxbGorTTA1UDBWSnNhamFPMGpHK3NRYzZ2THRP?=
 =?utf-8?B?N0hLNXBrN2MyOWFFenBYdFNzSFN5cXAxTFF3bGMvYnRrazZaWDUwZWpWTFYw?=
 =?utf-8?B?aFVRQTRHUnhnM3F3Q2gvL2tCbmhkQk1sNHJ0elNMa3F1c0Jyajg2WjFzMTZk?=
 =?utf-8?B?OUxreG9tQjhncEFsYlloY3NOS2VMVTdCVWt2ZHI4eVRHd08zN3plZ0pGbU5W?=
 =?utf-8?Q?Rwyi6wBg8+coan0vRbzjfMoPM?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6975c037-284c-4a4d-144e-08de01c609ff
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 15:12:01.8266
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IguiC8x29NCCYj2PT92qsOWY9Wg7RsqLfggIL1DcA6yy8QgTpY1IgBGUGHj8/iF8arz49lmO9KEOvBenw8Ldg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6124
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 02 Oct 2025 15:12:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20157

Hi all,

here comes rc1 for the next isar-cip-core release.

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/archive/v1.9-rc1/isar-cip-core-v1.9-rc1.tar.bz2
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/v1.9-rc1?ref_type=tags

As usual, test carefully. Also note that I tagged this despite our 
currently red pipeline. That color is likely only related to glitches in 
our LAVA infrastructure, preventing long-running tests to finish. I 
expect that problem to be solved or at least sufficiently mitigated 
before the final 1.9 release.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

