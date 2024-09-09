Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC98ECE57A
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:44:03 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.87])
 by mx.groups.io with SMTP id smtpd.web11.50886.1725882238756697724
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:44:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dkT6THt/;
 spf=pass (domain: siemens.com, ip: 40.107.241.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ed7UmEcTtBhPyFK0smWvgRh57LbzAFtHyPka3Rrj6B7A0tWULKVs5CN0WNfDPunPSe0xbd9+R/+CsM1rsJfY2kE7n/0AuvB8f8WBaRFSs7hyXYPtm0ZjmvTW0quhSwjmzk6lwcISsGaOtius+lZwXK3nkspfoeG2Uq/FoPrwpG8/ufGkZA5DkU98dT7R3NcY0yWhKUzmiXCJr0M1SLp38G1+G6v6z9SiAQXwVWf5r9c278AxrDimmEWrInRDJrRlZ476xllZrE45217ZunSTmgmLgmFfeGm0RzERxg3VhQK3jPHdMtbVCtR0t2HYWPSwHV+eaHQcpH6VYTYPsOUVbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tYfLHHgkTVzIGJnCNj3sR/oKVHMdkcCZQfHjQXNmDA=;
 b=hLaSmPJ7KrAWnMdx1gIXLYvfi3nSiqXaq/QX1yoT2GL8zB0X2ZVVnZS9r6sdrb9c/Axr0RckTbnYMjpKoN5+5tgxc4+5luk/I3NYPzM84zssKd+wQeb2dXpYS4MRxzOvSitP3ImrHwQ7RTUIrxIr2mAwsJ+feqQlu4YIyN1IBSFM/odM9sfus6MrmdBC2NbanDraHbNzVzWSYYbBJr/tHTUM15gEBgrSSXXIwyc7cGVNl9EhtbQKB5ke6ASgZ2RXPbR+G/YYRflbTS1/gIJwDI+cpf4+bQKeuBLZyNKhwuHkmrKPp9TpLUR9ninLGE/RSLugO0kQ5BCvVQzYyz62/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tYfLHHgkTVzIGJnCNj3sR/oKVHMdkcCZQfHjQXNmDA=;
 b=dkT6THt/rZF32FtzWqAJD1qgGNhUW/xW+OUDYVGfKSpYNhcI2OQMR9dumF3u1BDOgP6CIHLXZ+N6d+sI8bg8kbpD0TAFS0/eSjt30bol6cYsFRRS7ClwjXGe2+mNk4NMDKKqGE/JLMfbaUAmu53pjfw2qAAD6loEJZeIHgEdAo5182x0/mGnXYdSOh1KTv/CnRLxI9luVYFe0OlisxM3E3HN3CD/5AhexkqMGqc37bmXLYhGk6HsjPxvzPEmKwF2wisg8KRicFzXY3DG0UA/hDMMnbTPnzSci9YUESOGCQYnba8bk8yy+KjIWnC650HiZc5x7abIB+ti0H6Vp7on3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 11:43:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:43:56 +0000
Message-ID: <647a038e-f6ce-41cf-b878-0b153b605a33@siemens.com>
Date: Mon, 9 Sep 2024 13:43:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] Update README for swupdate
 signing
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
 <20240909112309.1028531-4-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240909112309.1028531-4-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: ad243d91-f96f-4286-cb26-08dcd0c4af97
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cEpEQ0VBbVprUE92Ly9XZGVhbTBQR1lNWFlNcHhNSFBoY2pSdkJqQVRSWlpw?=
 =?utf-8?B?bVlLVU10aHZ4VnBoWHI4Y3Q4RUg5d0ZjOHdoTEdhempNV1BKazVjcmhYUUhk?=
 =?utf-8?B?dGtWRXZTcURGV3NES0pUWWFBY0JqTEZPLzhkNFVxdFRudlU3MmZwZ01xR2Yy?=
 =?utf-8?B?OE1yNGx0RHg2L0hyN0NRTTYxWStteloxWnBDTDJDMTJ0OE53eGI3QTBhYVZE?=
 =?utf-8?B?akZoR1NTV0dndXBJR255cDAweC9uRVFzekZBT2NsVjlSNWkzam9sRGtXL29Z?=
 =?utf-8?B?TFdQVHJPTm0xcEorQW5ZenNTTzdjOVpPSzVwVHVvZHpobERLZGN3TW13ZUhS?=
 =?utf-8?B?UTdqMmFuOEpicjFDVTJXWWVsMi9EaEZpM0dhR3M1ZDVLMU9Md1BTT0RkVVpL?=
 =?utf-8?B?NGNJSkdvaUZia3lkTnM0b3RCakdIQlpmdmpNMGdiYW5GRHo5OWowcStjcnVn?=
 =?utf-8?B?NEFlMFJwMVdJTmg2SzE3TFUyZUJmRFhEeExvNENDTHZCU3F1SHFSeFRwcFU1?=
 =?utf-8?B?T3UvT1F5dFFndUtVbG9Xb211MmRydFVWVktyTUl5U05BankxZklUOVEyMW1C?=
 =?utf-8?B?OU9PV00vWlNWN2lsWU9oR3h0MXUyYUZKSHNZdldJK0RyY1ViSVUxYXY2czBN?=
 =?utf-8?B?VUR6bE8vQnhlZ2hMV1BxMWNydGhGTG1JY3FSNHVQNFpJZVVUV3FJRHAwby8v?=
 =?utf-8?B?d1YwMUZNN3IxYkFha3VBNXYySEhzQXpxbDFiNjN6Nmp0Wmx3azJTUmRhdXBt?=
 =?utf-8?B?Rys4L1UwcVhieXZxZFdGRlo3d2JobTJ5Mm1KRGRyOHlpU1dGNVUrZkhoekpQ?=
 =?utf-8?B?YmtMVVY4ZHpoLy9uTzJwQjBZMUorZjlWTVppbS9sV0xJbDJpTFpVZWVDTjJ6?=
 =?utf-8?B?YTBtTmxTbFFXTklaQ1ZQMVlqTHptTjJEZTdZTmNLUjk2RGFQcjlXaExCN1o5?=
 =?utf-8?B?YXp3VDZhZUw0T3VxZGpqTWpyZVNIdnFjc2V3amtCNnRoSmxKMzJWSlQxSHh6?=
 =?utf-8?B?UkpMZEl4dksvMVp0cUlDNkNKU3puSWkyZDdIUnhubWJ1Y2J6SFQzaGhSanAy?=
 =?utf-8?B?ayt6VVpNQWNCa0p1YWdVKzJqUEkzV3dRUEpaTEc5SzBEZ3dGdXU0bmxoSXNK?=
 =?utf-8?B?RHBxd01LaXZ3ZVZYUXp2OURwcHo5T1VMcDhmRWRiOHQ5YUJ0cEJ5R0tMK3I2?=
 =?utf-8?B?Uk5Mc3ZxNnhyS29yT0FkZUxyTWRiRGF1WFlib1hZc01laXZxdm5Ha1B6ZTM5?=
 =?utf-8?B?WGhEUGxyeFdRUGZFWUJCVEtiR0RKc3JHdEJQNXBNMkRCMFJRZGRvVFNDNmZj?=
 =?utf-8?B?cThKSmZOTktLWk14YUxZTnV2YnpWdkYvZ2s3dzZyTmlqMysxbWpUelRYRXpZ?=
 =?utf-8?B?a2FsMkRUSVlvVVNxQXhncnZDRStkUzZjV1NFRHBqOHRWL0UrdEgzMzRHT0J3?=
 =?utf-8?B?TytkNU8xN0tEbWU2bXRuelZablZabERPN0x2MGtoTmtjZW0xZTlMREN2ZDFx?=
 =?utf-8?B?SmQrVERZb1JlR2lQVXBGL3NNblJKWThydWdNR0FNRUMvWFU4akhVandZU0dQ?=
 =?utf-8?B?Y29EblMxMTIyR2gzV0NMTmJjZndoa00yVElxMlhSck1iN2ljai8xMHVQNk83?=
 =?utf-8?B?Zy9kNGRXZnQ3TjQzUXVpWVpmQ0R5RWgzWVBnaVdvdGxUclpwMjFMMmdVd2E4?=
 =?utf-8?B?a1VuMnorUE45UUxMVFkxQlRiczd1eFF1NWt2NHh3VHY2elZ3SzJ5a21SOENz?=
 =?utf-8?B?bGkwSXVQb0FlQ0NtTDV5WDhSVnp0SGJON0MyT1pBaHdwYjJvekt5bWk5ck1F?=
 =?utf-8?B?bDgwcFhHMjRmekIwZmFrUT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?amJqaDVtNGNBTGlXSEtZcWxjQ3Z2WHliODN1dXZadWpRNEVqdGxFb2lNc3pT?=
 =?utf-8?B?Q3ZQOUk4K1F3citLRERPRWR5S0ZHV3dhL1N3RUVyMk1XR3BpVStPNzNzZjh1?=
 =?utf-8?B?R1UvSXhNVHQrbElpUWFXVzlEWHR0eisrTUVhNGY0ZGh5OVZSOXRtUlF4VjEv?=
 =?utf-8?B?Um5PU0QxK20wT0JySXBHREJ6Y0hFa0hkRG82M1pNclhyWU9EYWlNMWJ5UGd0?=
 =?utf-8?B?N3NLdDA2alAxMTZCRk5GbHg3MjlSYnhWbXFTUGNYM08yNEFUSHpQT0p5Ylgr?=
 =?utf-8?B?czYwUDlsVlZyNngwNmN5ZS9mVDlCcHNvRWg1dks5U0c1d2FtMVN3dG9YeFFT?=
 =?utf-8?B?WFBkanpsMnd0c2hGTnlNTWdVb213TXg5UEdEak9EclVTR1JTNWg1bFh6QXM5?=
 =?utf-8?B?a0NUUzNsaE9xc0pWeDFjT2U0WjBGWUFGNi9vN3BQb1ByRWR5enZqdDVGTk9w?=
 =?utf-8?B?cStrcHJ5WmFuRDNvU2VWemdLKys5anVLbEUvSUlRVHdHRE1WZzY2N3ZlTERL?=
 =?utf-8?B?ZFN4ZXBOOHFiaERDRUZQMkxQeURuVEFLUi9yWVh0bXBlRlRweU4vU0JkdVMy?=
 =?utf-8?B?MmhydlZHV0pJUHdvR1dnTCtaLzllNDNJVCtyamM3SlhIN0FJVFhCMUNoZ0Zu?=
 =?utf-8?B?MlFiZHZsczhKcGZOR1lOSlBabjRPKzRiVVJ4WHAvM2o5c1B0blQ1YWVka3dj?=
 =?utf-8?B?QlRoQXlOMWpXU04zdGxXUTdFRW1JQWlIY29mRWRsckdzRzZoSGkrUDJvdVlR?=
 =?utf-8?B?RW9JMzhhNWFWZzhCWHJTb0NPelArL2psQnlLbitLL1IzU3U5eGxnVXBabTlq?=
 =?utf-8?B?UytqZlMyekpoQzRQdGo3M2N4WVdnOUllZm5rNXh4M3VaeDR0bW53dnFCZ3d3?=
 =?utf-8?B?Zm1hdVNmcERPNFQ1OUlRUnBlU0NNZE9ISzFVWlYxZkh6YTAxMHFWMVd2L09n?=
 =?utf-8?B?UGtoS1RkR0RaSSt3MnRUdmJyUDRIbjc2VkRZM21sU0RIQjd6K2VkNWVuaG5G?=
 =?utf-8?B?aWQxdUdYYk5lWElMRnZLSWNBNUIvbWRrUnhNZ20vRHZGc0krOFpuRlBMaDAx?=
 =?utf-8?B?OWV0OEJmV0VldStSMWJxcHNDMUFVeXNCTjBXNkJuTm4xcVpEL1JDZFdoOVVC?=
 =?utf-8?B?R3VPZWpUbHBvSXF1SmdZSmd5Q3g2SGZxd0p5UXBva2t2M3hTTnFLMG9SQzYv?=
 =?utf-8?B?VkdkMXVjR1hxdkt6Rm5BTW5kQmRmZmNWTDNUUXNsT1ZvY01xcTdNbXRMaWJ6?=
 =?utf-8?B?SThPNkZEbzh3Y2podGM4ZnFtR2ZuOWVVYWpWZ0VVNDYxK0phRHE3c2lKOEps?=
 =?utf-8?B?Y3hCdnRoYzlCZ3VwY0l3UnVkTSs4aGNtZlVHTmFFd3ZpS0VMcVFpWGNKeUJL?=
 =?utf-8?B?eUFlc2Ira2ZCb3BseVo3aTk2MnBLVGd3MmQyNkgxVzcyc2tSTG8vTkY4RFMy?=
 =?utf-8?B?eExvcWxHODM5bFVVSnJ4MzNyRkNTNVMycStqWUJ2dDhLQ3hPU1ovWHhOYnoz?=
 =?utf-8?B?NkZTZUlPaVVsUVY2WG9WUE9ndCtGVzZwd1dReTFydW5xZzJBeFpkdXpaQUNZ?=
 =?utf-8?B?bkZjZWFzZGVVVnZ5NGdYMUowaEUyR09WTTN4Y2JkVVRSWlpkNlJsQm45MWt6?=
 =?utf-8?B?dHNwWWlZUDl5c29kS0JHME8zRkpMOHRBbWRXT204SkJjbXR1a0Jsc2Vzemdh?=
 =?utf-8?B?ZFMxTDkzNUdPQjJyQktmWlN2azl5ckpkb1Q3b3lGY3V3ZE9DRHljSnY2SHlm?=
 =?utf-8?B?UUpwazdDSGkyTkxUZjhGK3k4cm1lM1FpUFVyanRTSWdtV0g2cEEwVzhUdFVm?=
 =?utf-8?B?SCtCNjRCcXcrQWtkM3BIM2JiWXVwYlc5NG5uVEZJSm12eThXK3RBd1R1R05s?=
 =?utf-8?B?ZSt0Ykp0TFVVbmdyY3FEM0pzODBaMmNxM3pscllMdjFTNCtRWUExdVQ0U1Ux?=
 =?utf-8?B?bTR0ai8yQVVPQk1tR0dKZkdsODdCUHljZDgrSGFZMWNtMTY1LzkxTFZ3Zm1i?=
 =?utf-8?B?Q2NMaE45TWU1YmJnTmcvOTFBY1FwTGxNdFRvajFkOEdRL2FCcWxRMUNYeUFS?=
 =?utf-8?B?Ym83U0RXNW9pWWJxcTZyZ1NyZDY2c2xoUWJNclVqdDhvbmRDRzdmbHNQY0kv?=
 =?utf-8?B?UXZ5TjQ5U2xhdHM1eXdpSU1XNEN1RWNWbG1mLzBaTWZJVVQwWDFURVM0YWJk?=
 =?utf-8?B?c3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad243d91-f96f-4286-cb26-08dcd0c4af97
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:43:55.8696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T9G6foIc7cEQl3wu7IAvqmFyvXuTnY+50b4eESHmhXcA21jLcFxjzzzs3OcqolprtFkXirXQwyXmz6fPHuA5Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:44:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16874

On 09.09.24 13:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  doc/README.swupdate.md | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index a5fbab9..421ca1c 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -138,6 +138,7 @@ PREFERRED_PROVIDER_swupdate-certificates-key = "swupdate-certificates-key"
>  PREFERRED_PROVIDER_swupdate-certificates = "swupdate-certificates"
>  SWU_SIGN_CERT = "<sigining certificate file name>"
>  SWU_SIGN_KEY  = "<siging key file name>"
> +IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  ```
>  
>  The files `<sigining certificate file name>` and `<siging key file name>` need to be stored
> @@ -145,8 +146,19 @@ in `recipes-devtools/swupdate-certificates/files/` or in a path defined by an bb
>  
>  ### signing script
>  
> -The provided [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms)
> -can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
> +The package [swupdate-signer](recipes-devtools/swupdate-signer/) provides a [cms signing script](./recipes-devtools/swupdate-certificates/files/sign-swu-cms).
> +This script can be replaced by setting the variable `SWU_SIGN_SCRIPT`.

"When reusing this recipe to inject a different signing tool, you may
adjust `SWU_SIGN_SCRIPT` as needed." Just setting that variable will
likely not help...

> +
> +

One newline only here.

> +Alternatively an own signing script can be used by adding the following lines:
> +```
> +IMAGER_BUILD_DEPS:remove:swu = "swupdate-signer"
> +IMAGER_INSTALL:remove:swu = "swupdate-signer"
> +IMAGER_BUILD_DEPS:swu += "${@'<own signing package>' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGER_INSTALL:swu += "${@'<own signing package>' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +```

Ugly. An alternative package should simply PROVIDES swudpate-signer, and
one should set the PREFERRED_PROIVDER_swupdate-signer then. That's more
bitbake/OE/isar-like.

> +
> +The package `<own signing package>` needs to install a executable to `/usr/bin/sign-swu`.
>  
>  ## SWUpdate Hardware compatibility
>  

Jan

-- 
Siemens AG, Technology
Linux Expert Center


