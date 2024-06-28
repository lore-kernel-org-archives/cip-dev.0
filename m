Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B297FC2BBCA
	for <webhook@archiver.kernel.org>; Fri, 28 Jun 2024 10:49:55 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.47])
 by mx.groups.io with SMTP id smtpd.web10.14372.1719571791471511486
 for <cip-dev@lists.cip-project.org>;
 Fri, 28 Jun 2024 03:49:52 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iG7rlrp0;
 spf=pass (domain: siemens.com, ip: 40.107.20.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCcVLvUEOIMMCAQsTPExtTsx1zlutakCoI2aA589PyKmgbgzhZ56ABK7k0gxRLvnok7hUBCsNBfhTBVxvIi6ugcRieP9J+x5QI8KPjXehV3+NSJw0mqSjzV2v0oUMX5E8Vv4vCK39T1IzK7JlfPttlb44mehAGXnxJqseftKvfgaZPsAgcsLJNLXuh+6+MhNf6/xExEW2jYI0+LCcNkDbXZKuKx5Ccd6tuIcH17TZKwiMDcvQtWMuL7Dm+5RI3G1IwBKE//cq29mHT937RHc72+y0N3IS4egbLJIaicvAg9BUY0Bbe1pjJN4kOPlkPqtmlGlsG6qgsSVm3wyRVWHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iGsCm14AldK68Ct5B6rcPYNsE8gLe0sliywijChqcoo=;
 b=WkTPoLiwKUTxFjKifbneqFw2qKotxBA1+5FF1P95iBc0kOy5OhVcVDMR+favhtAJToKeU6Jx4cWJA4v0bRGpZoY0W+7LKoRrJXqymfY/pTBHbgHWbEjRnukUAsnzF8af9gf4jEHWqcnjv7qGaP09IKcxf/vpYS5uq1mIYAOvNpM4tDErZeu0MMZxrjDReZo22/wFJFg+1tV0/dZwEsmauZpoyFrr08dnO0KFhUCNTEFgv8ynj/DcCbmgsr3FyDFJXx0zvaYZTfsxfCC38UbcfthKpGjemSt1nqCAdv4rwAB+qkpSOlv17s6W5AFReBAB147bamzNgYCGIgZ7lCKlkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iGsCm14AldK68Ct5B6rcPYNsE8gLe0sliywijChqcoo=;
 b=iG7rlrp0QV3tJr0IBSkLBQX4JF8XqVjIsa/pLwjUtev8ADdtbYuuENBUiZB8qwcBLIxjOUN/jCk1G7Ant+ye6/0htL4AyEszwEUx3HqQxzd6YVMr4r9Vp0FSLizu7oUnVNsEK71or8iN3SF1AfKrqxCeHjS9BAm/1XecpFa5LQbrI88TrNGBojFKZUURR8L0EMPilGMs+DGd8Y8+dums1wpSOQWT06Te8mqhWHikVrY1QNssVY1OopD6Z1pIXCVA81tJcZXRdv81/gC280F5EazT7jZCD1dpv9BQ7QVqe61NKLOsN3GOZ7ufNN+xxfwGZwyXmb8ZhLPg9trPBBjV1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB6399.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:557::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Fri, 28 Jun
 2024 10:49:48 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7719.022; Fri, 28 Jun 2024
 10:49:48 +0000
Message-ID: <e5185370-5741-48af-9b47-b5b4946bec22@siemens.com>
Date: Fri, 28 Jun 2024 12:49:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] recipes-core: ltp: Update LTP to 20240524
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Cc: cip-dev@lists.cip-project.org
References: <1719540103-23049-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <1719540103-23049-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0234.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb892db-c89f-41e4-2f33-08dc976007a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bUtabkFDdDZIbG1OeG5UTG5FRmFTYWE1OXdOZWlJcTZzRGhEaGFOVE9QNUg0?=
 =?utf-8?B?QkVyZWNIVDVKYUhicDVkVzNhUUFmeVdWc1J5bzZ4eGRCbVlXaFNrTXNtYXd0?=
 =?utf-8?B?Nnl0cERlYzJWYXlUdjNiR3pBY2c4MXFoVUtIM2RsTE11U3R2Nk5hYkRqK2Zo?=
 =?utf-8?B?TldXdFVFTWhyZlIxdzQwVXNyN2EyQnI0Y1ZEeU50VnBVb0s4SUUvTDcwajdr?=
 =?utf-8?B?cHpCOVVsWnRDTTBxOE40eFRpRUhaUnVmcURQSU1BWHRCNDNYV2FPSTVuanNk?=
 =?utf-8?B?eHlQdm95aXptWTNQSm1QTHFnVmxlZ0RmREFrSlM0MlI0dlcvK2lnNmNzTi96?=
 =?utf-8?B?dGt4elV2V0tuWE96aWNyUTJ4bzJQejlQNEdENnhONjEyNU1wRXdlN2FpWDAy?=
 =?utf-8?B?OXJnbVVlT2pUaFEzRUxrOTBmZnhjajZ1b2cvZDRrcXJkK1NZc211cDFTODB5?=
 =?utf-8?B?bzcwaW9yU2FLYXdZU0RKZ21oWmRzY3NYaFlJMlgwbVZkUDlPV0I5NzVCS25X?=
 =?utf-8?B?dGtVK2k4Q2Ftblp3VTZPcnBONFpvYkFGYm1xSy8zUU8rWkdxOG5Cb2ZZQUMy?=
 =?utf-8?B?ZnVkdnBJWGxUWU5PT2JLSnRuYWZaMzdHczdXZys3R3JGWTZHN01kbkVXTVZB?=
 =?utf-8?B?eENxM2ZDWDZZOFM1L01SUENHTEZlOWFvZ1FPWG9UcnBsdkJEVVcwemNsWURN?=
 =?utf-8?B?MzZ2dVlLQlZKRkxMTno1U2RjSE1BT0dmdkdieFVGS3JCQjBET3c4NU9iR3B3?=
 =?utf-8?B?S2NkdzE2em1uUHlkbEw2MldKUVMyRzIrVm5qdkFLNW1NTGRrVmNHb3ZHV3Fn?=
 =?utf-8?B?WlplVk93eXZ2by9TMGlTU2JjMXlYVVNyRHZCL2N6dWxES2F4bEhZSDJ5aTVW?=
 =?utf-8?B?d1lKVU9tcERTMXdWam8rWm5OYjJURFE1ZS8ra2NvWHZSQWIvczhrMFdqb3JX?=
 =?utf-8?B?YzRwbG5mVThsb0tMZ0xWRWpMa1BieVBZajdoQUdxUU96Wll0S1ozWFRMRjU5?=
 =?utf-8?B?QWQvcUJEMW1oeVFOVlBSbVVYU09PS1NDM0lXUnpHbXNjdHhLdWpnbmxMQTN4?=
 =?utf-8?B?Tno0ZWp0ZzdjVVp4eGMvWXBmVTU2S2lWeEtJNVZhQnBoaWhsam94RXMzUjhE?=
 =?utf-8?B?Ri9FcmZ4MVFuTXNSRUw1UkUxM056aWFxNXJ2OUkxVEdKZHlPa09UOXJCc0Rv?=
 =?utf-8?B?YUNteVJ2alpvVFNDa1FqNVpLMEc4MUxLNnV0UmJxYklOcHZTMjdZZk5mM1Zx?=
 =?utf-8?B?b3ZTUGswQXhWeWp2b0lPNFYrSnZIL0VpaUpuSW9MeEpJRDA1c1lZQzAwSGY0?=
 =?utf-8?B?VXVJM0wwT21qemh4YklmZ0NlMnhJQjRZc1puMXZnVGo1dCs2ejg2Nm4xbW1L?=
 =?utf-8?B?TXhvbFJIZDlKUlpRMnliZ3RoK0R1NE5pYysvUWlpdDhIb250WExicVlvS1ZX?=
 =?utf-8?B?aFhQSG96Y1VqVUVRbzQ0cUE5NmpKK0hLMjVNMzkzQTVLUG9BYzVlNjAyZnFN?=
 =?utf-8?B?MFJDSHNaU2JYWWtTUUIxZDdRc2hSdzU0aW1OcGE5TUg3NjA2c3Z4amllaFJQ?=
 =?utf-8?B?NkdybmE3d3QvcXEyUmdaZHpEY2dGeFVleXdBTTdVRldzUXUwZFdiYWdMQUlk?=
 =?utf-8?B?UmZWcHdabUhmVHBUL1FNSGN4cmx4NGU3emM0V0xNOXB3blE1MnFYdFpMMXJk?=
 =?utf-8?B?ZTViUm1vcGwycXh2akhNME56ZmU5cUk4K3F3OXNqRnZsZTV4K1dQN2xkWGw0?=
 =?utf-8?B?YlRYVkJxbEIrSDFhSHU4T0EzK2RySVRuMnNDclRzc1N0blR1dWF4UnRidEQ3?=
 =?utf-8?B?YUhBTlMvSHJzUk93OHB5QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OW9KclZmVlpvK3JVS3hha0ZBbDZlLzJRUWhKaFF6VkpPTlQ5R0c5YWJsSWlq?=
 =?utf-8?B?V1VDSTIxclJxdEFuUGdTaTRHeGpIaVpmWG5JUlVsck1ud2wwL2lCRUJUdWFi?=
 =?utf-8?B?cThucTg1MFk2QVB5UGpIa1NlWVdoL3g3bkRxclQ5Snl2ZnRzb280VEc1QW9H?=
 =?utf-8?B?UVRGUkFaV1BGVjF2ek1FZFhHbUxEc2F2QUZDRGhWc3pVQlYwWTAxTXZXRFcr?=
 =?utf-8?B?Q0sxMjdSdlNiditEcmM0UWtWY2Z1NVU4M01UdkFsMTRyVG1UWnpLVFl0THBk?=
 =?utf-8?B?YUpRM25IYm9QdjB5K25BQnBvTzJucmxvd2FjT1ZPS3BQbXlKVDBZcithcWFT?=
 =?utf-8?B?NFNENCtKTjBhRDlwcm90UXRNWnV5MkI0b29vUDdsbnFWNWM2WWNxWllLUDdF?=
 =?utf-8?B?bFlCZmp3enUycUU0bU5IWVozbHk4SWRuOWdmMDljaEdjUSttQXlaRUpyS0cw?=
 =?utf-8?B?ZnZ5eG1QU3FqczIzRjVHSUZiMStiWWZkTk1YU3ZZakZIUEF2SHZyeDNzaTVo?=
 =?utf-8?B?VUVLY3Zxd1hjOFRmeUlFSW83MnpKMVFaWnlES2VVNW5XQlRDU2hpYXRnbllx?=
 =?utf-8?B?eEVhWXorcXhIcGEyMHpaSkJXQVlJWUZVRFNVbm1qcmxHOHRQUFBubDU4Sllp?=
 =?utf-8?B?S3V2aTBvSGV2NHYrU3VpRW54TFVySWE5OHF2dVZsYXE4Yk9BK2x6M0lIQnpm?=
 =?utf-8?B?azI4V1B3ckdUWXVtNnFMZE1UU21KZVZqMzRjTGdGejQ3NTNyMlk1K1RPdHRj?=
 =?utf-8?B?cmNLTXh5eDZlT2lsbnMwQWp1UzBEOVV1Qm1TWno4azlidWhROGNiWlM1OEhR?=
 =?utf-8?B?dWgvbWIwMDZZU1hEVGdmSkV3ekpwWlpHdWgvbjhIM2puZTA3MS9xd25kekxs?=
 =?utf-8?B?cDMvekFmVnpTb1JBZ2VtRjFBR3VOZ0s0ZVI2RzIvTWxjdjdFQ3AxK2tDaVYz?=
 =?utf-8?B?OWoxa0EvUUNDTGlOS29vV3lCUnEwWTBSRmNmK2Q1V2F4ZEVTQTNzbnBTRC9a?=
 =?utf-8?B?c0NRcXpzSTc4N1RhRUovN1N0Z1ZPRWU3UldRRGhOVmt4K2JRMUFWS2VtWkdC?=
 =?utf-8?B?VjN0RlZPQWk1dlEwa3I5QmJLalMyMGFudll5NjJoUmJqdXMzOGhsb0NrSWEx?=
 =?utf-8?B?anUwam51QkNDbmo1MmJlYTMrcFhFWS94M1o0MFU3S20xK3RKVDNneE1tcFox?=
 =?utf-8?B?YVh0a3l5ZmhCTHVER0lVdkxBQ3hIREI2YnQzc1QzS0FDTEl3cncwVk1LV1Bo?=
 =?utf-8?B?WmhzVmhmQzkyakVDMVVZakhhWmxMU2M5UTRkNm96RVhvNjc4by9yVjlwUS82?=
 =?utf-8?B?Z1V1SGliUklxcU5vK2tPalVpMEs1NGJLNlVzc29uenAvdEFPYXI5alphS05i?=
 =?utf-8?B?RkJXcnpic2duL3FuNEF4TldmeHQ4WFhGc3U0TnhBa2VSRmVPSkduOXArVkxY?=
 =?utf-8?B?RmlKOThmSWt4dFdjMUNwQUsvNUxiV2o3cmNRTjRIeGZjNkNvU3VEdjVQZFVF?=
 =?utf-8?B?a29vaTdCeG9IODdjTXBTdjh3WVR4K1Z0dll4c0h1RHFRbFZ4ajk4bUg3M1M1?=
 =?utf-8?B?aVg5SUdKcldRenJVZlJtbFVuaGVEamhwU3RBQ3VLR01Fa0VyQlFMUFFLVHI4?=
 =?utf-8?B?b0ExL0dLVjEwc0VtQzRuNzBmdXdMN3lGejFZWGdOT3J6R05JT0lEVWlPeEZM?=
 =?utf-8?B?cUt0MTB1Wm1RNzR0SHlOc3hKam5oZlB5bU9OSytUaW5EMGZEYUtMOStFWTVO?=
 =?utf-8?B?S3hFYmtRV2xjdVJQRFZlazJMby9BMi81Qy9GVkxncEh6MkJ3WFFzelBQMjlM?=
 =?utf-8?B?U2xkaUtoYzJaaDdGdHloYjgwK015NTdRd21EUzRvMWhYeVBZOS9GM1oyZmZW?=
 =?utf-8?B?WCtRTnMyWTB0UmpzZzFxVk03ZFM4cWk5ZEpQYUhvazBzRW9vWHdoY0E0K0NT?=
 =?utf-8?B?UXYrY3dwWVdLSGw5UnRPT3BTWVZMalZnTFZDaVMwY0N1MUdWUk9vNHdPQUY4?=
 =?utf-8?B?NnF2N1VHWk5Rdjkwdzg3UTJyMHZGaDd5K1JHR1d6Q3pCMXRoRTEwakV6VWR3?=
 =?utf-8?B?eDhVV2lJejdPdUxSZWk1VldHUm9kNHl4QzJuNXZaZmFBYm5hZ3F1OW8za2ta?=
 =?utf-8?B?SWVkcytzK0FabnpKMkt3Y3YyWXJ4UHFFWmNxV0xVUVJleEdVSlhwODIyWEVD?=
 =?utf-8?B?WFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb892db-c89f-41e4-2f33-08dc976007a1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 10:49:48.1308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NMcQjEcOTzKGFI2ic7QdsNDR0+uhrOxKLWWkAWq/Nlf7+ibMv8+7szZPDo/G0D1HzDLM06W7eIN8NMm33MQ5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6399
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 28 Jun 2024 10:49:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16341

On 28.06.24 04:01, Nobuhiro Iwamatsu wrote:
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  recipes-core/ltp/{ltp-full_20230516.bb => ltp-full_20240524.bb} | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename recipes-core/ltp/{ltp-full_20230516.bb => ltp-full_20240524.bb} (69%)
> 
> diff --git a/recipes-core/ltp/ltp-full_20230516.bb b/recipes-core/ltp/ltp-full_20240524.bb
> similarity index 69%
> rename from recipes-core/ltp/ltp-full_20230516.bb
> rename to recipes-core/ltp/ltp-full_20240524.bb
> index 943340f..1ec0974 100644
> --- a/recipes-core/ltp/ltp-full_20230516.bb
> +++ b/recipes-core/ltp/ltp-full_20240524.bb
> @@ -11,4 +11,4 @@
>  
>  require recipes-core/ltp/ltp.inc
>  
> -SRC_URI[sha256sum] = "d78f4bdd5bdc9e91357631954affba7e66190a2509c369b59f55efd190268956"
> +SRC_URI[sha256sum] = "2b7c07bb281b7ec49981eeb06c4b66f147b103977254632678d384034f6e9663"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


