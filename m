Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D16C02181
	for <webhook@archiver.kernel.org>; Wed, 22 Jan 2025 15:41:31 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.66.7])
 by mx.groups.io with SMTP id smtpd.web11.46480.1737560490348383791
 for <cip-dev@lists.cip-project.org>;
 Wed, 22 Jan 2025 07:41:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Tdyxz4it;
 spf=pass (domain: siemens.com, ip: 52.101.66.7, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3WrNUbB5ESWElD2gLKP9Y5Wg6QjDfDaQMYzvELpHiuf0MXqpcOzVfpBo2c8X2FBn+UekWLCGQkbD6l2h/0P1+l9G9F37OUW+MtkQr7swND3mb9K/W2gn/N15UOT+ceqloBZr6TBgTdXtdeAP1DwI9W/RYCR7LHag/qXuX3VZDdKyHX4/8ZpUwowLK99btWC/zInlYn9cO4V/pQSOx3gBA+iuXBw1sPz0ohnEDiCGWHumRAmnJKFPwyxMbueSSn3Npf4KR7bzF0wYTiy2mkbMI87zSWgyBzGXKwnzr5a24tOAvYt3N4c7mbMB6YuGTuTAhRF9ekpYVWMzfRQUGt7Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V11j/VRJMNQf0QZTBROJEERMEnga3wrlGsCJEBRo2Nc=;
 b=hzqN+l0t0BRQ3qL6hS0IjTXTuUiA52Lk+i87ZI+vgu5kznicA8XMjC7w59J2gDC7rzsBrz93GHZFc9n92PLR44uZ7o+JkCXSx1w0S9ZVDFO3qzDMHyrMRiL2Q0U6ewvplXkPncxNrlnmuggmn6Fev4EEaMNiDl4CRUdi7S4deOqwhzG3Z6fmYqbtQ4UTCE4CtE1Stl1LoJEJPA061xHsV6/reQBMdj3mVO4tJ5P4OXL/5cWR9cmoWgxRjukQp/JikLl0qIlTZT+tV/ao+MCv8iV4HIHy0YdL0WfL2pgjRUnblNjI9tHmoSCotxq5ywVy1PIBTeiAGIDGgYzkvrlrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V11j/VRJMNQf0QZTBROJEERMEnga3wrlGsCJEBRo2Nc=;
 b=Tdyxz4itUVkPTY0BC+TuAmJ6raDomSXxqCgYh+rlS+cTiMnl1QXQBv3znozXmjPU0YLjzpdKOMPQWC6uJ55rlkH86rwpPkjJRKPpSh9E7sJIjtmyMi3Pq3N+jHwYAUflTACSPk5DjErblDK6VvT0xpZOIiA2Cok/7vwytOE0ACjEGHmlPqfynGKkD6IF40Xk6iijpeMYMlX4PhqqxBTyLz0OAwLo8x3+I2GzgyF1/rnxNffAueU+WpcJgUMhncuvjO3+6TeqVKLiOf405Zu5O2NX1GZ85VlZtfOGrnXRFgjzDM+3Lf7Cy44boVcqOnaU6TkPIEcRPbtnFOXcLH6W9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.12; Wed, 22 Jan
 2025 15:41:27 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8377.009; Wed, 22 Jan 2025
 15:41:27 +0000
Message-ID: <6069da75-0465-4306-be32-8d5c92615c22@siemens.com>
Date: Wed, 22 Jan 2025 16:41:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] initramfs-crypt-hook: Optimize disk
 encryption in combination with expansion of last partition
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20250122142811.106525-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250122142811.106525-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0177.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b9dcaea-f4a7-4ce5-752f-08dd3afb3bbe
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UFg1N1lGOGpmK1R5cmwyVW9YV051STYrRHpzcDUrOXhlN01FMTA1WklMUDF1?=
 =?utf-8?B?UTJOM1d1ZW9OSVd6WUZkOVpNVkorc2VuTEtnNU01SkZUai9zeUFhQURtZUJw?=
 =?utf-8?B?dDhSQ0ZVMjNjUVE3SEI5UmZmV0JSYnZrWDlXamlsVm16N25YbjQ4eGhXUUJq?=
 =?utf-8?B?c3JUTEQvRUY3c0tockVieFZ1K1NNdXk3QkRyRWxTUnBGSEhoSHd5QWlGc0ZJ?=
 =?utf-8?B?NkN5ZHBLc3VYV0FzSENsZTIvOWNxSmVFWXhxRkdYdVJ6MU1NVVB5UzJsOTU4?=
 =?utf-8?B?UDBWWFNzMDlvYk5PYjQvZGc3Wlo4enV0Qi9aTW5vM3VCN3I5UEFJYTd4eS9x?=
 =?utf-8?B?UWIvOS90R3RuR05sTUVUMjhUZmsxNndQd1VtTUM2MWhzOENhQWxDUHIwOWti?=
 =?utf-8?B?NUViakhFaDZEOHJ3bTkxVFdxeXh2WisyL2F2MmZ4ZmQ5TjRWM2h4OThTNXVY?=
 =?utf-8?B?STBTck5hY0Fpc2dsMjNhTmtOanM2Mi84aXZrbUt5dkpDTGNGZUk1RlM2UmpE?=
 =?utf-8?B?NGREWTBaYytqL3FneG9JNUJXM21wc1dtLytvSmw2N01uY21FVmIvTlNpeWM5?=
 =?utf-8?B?blloTTJ6QlU2Y3d3Mi9LZUpNNHc1U1NlUldtWlVYSEY2NXMyZmJYRE1tRCtm?=
 =?utf-8?B?U0FoaDk4OEw5TlQzS1JKcGphYUU3QkQvTVJ1bTd2a1dGbUpCR2tIcUpQOEI3?=
 =?utf-8?B?OENpbjRxcTZpVlM0LyszVGxLSTc0Z204cGV1Smw5MFZZak5HV0pKb01UVmpT?=
 =?utf-8?B?Y2QybzNWNlB3a1I4c3pOVnFmY2JKNGc5T0tYQ0poVGtuRGwvYUZnVm1KRXlP?=
 =?utf-8?B?aDd1c1NmbUFkUWdzNmNDTVdqeWJ1OXhYRWNpeGRBamI3QnV3SysrVzZnSTk0?=
 =?utf-8?B?dUU3TE1acW1qaGFlNURvVWsxdmFGd3FKdVhBOWpCL0M3d0hHSUlVRnhTQ21P?=
 =?utf-8?B?WklvY29EbXEzVEZDR0NiUDlHUStLZHFLWDlyNzRBOEVUUjlMTHhDVEd5L0R0?=
 =?utf-8?B?SVJhc1RGQk9hMmVVQVhwUGhxWTkrNXM2RlhPZUFGQTEwSUVBMWZEWUl1VlFP?=
 =?utf-8?B?UlE2N3NqNHNqc0IzNEl1YU1pVzdhZlFVOWhCNFRzTGs3WlFjbWNtMy81bUFG?=
 =?utf-8?B?aERFS1F6a3dCakJIMGZjek5jRTVobkhCMW11RG0vN21xUTgrRW9HZzhuOHJO?=
 =?utf-8?B?N1hnL0IreFNGOEdLTGFrQlJTTjcyb3JWZjBNVm4wWjBiR2Rvd1U1ZkRjUTBD?=
 =?utf-8?B?TFJOdUVyTmtqMlNSRDA5Ym1qdXg0SEduVXpsR2NzZzBJQnJxYWw1eWY3OXFQ?=
 =?utf-8?B?ajR6QU5uMVVzSENQU3o3T0I1R0hnSUxjaXlUeEYwcTU3QktBMmpQUHFlWUtv?=
 =?utf-8?B?VjRUUGw2ZlRFcEJRVGFoekxnKzNMUUVBcEVJSVJMTnZVN2ozUXN0Tm1QSHdi?=
 =?utf-8?B?RE5WbkJXUEF1VWpOKzFybUhOS0Rlc2ovSGJGNnl3VWNUdHM0NTdud25yQ0lT?=
 =?utf-8?B?Vmc3ejJNazJQcGJ4UHd2VUZTbWtrcTRiT2QvRnAvYTd0K25aZXJ2VXV4THVV?=
 =?utf-8?B?YS9pc09aczA3d0s0QTZ1ZDFzTE1CWW14L09BeFVFUkxYYy9CMnV6YXRCdTUy?=
 =?utf-8?B?OW02SCtLMDdFeWlYSGo1aWxVVjhudTR3OTRMMldPSEJ6dTI4ajFKN3ppcGxr?=
 =?utf-8?B?OFQzRXB1R1c4Zi9QaEpxS0hERkl3d3gwa25ZRE4wV0tqVXRaeFNDa1llS3Ja?=
 =?utf-8?B?aTlrNE1Jem4rUmkrUEJVVVRXSzREZnhKZ2h4cDFmWWIwT1Qxa1BiQzQwb3E3?=
 =?utf-8?B?YkRHZTlwQTNscE5kTjdDOFpVWFdldXhBSnhoY2phaW93TmZvNVdDNGFMcWds?=
 =?utf-8?Q?buttmPiMwIiEO?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bjl1TjhOOUdzdTJUS0J5ODZDT3M3L0lkU1ZzcXZ5T0VDUHZoQ01jandGSysz?=
 =?utf-8?B?Tnh4NmZRVTQ1TSthSldaWEsyMnRwUVJFSXVVZStIQmd4eEFPQ1ZkK1Z2TUYv?=
 =?utf-8?B?Z25BbUV3QjZGcG1DMkQrTmlST2VCTnRIMDgxL1ZhRDhheSs3NW5HZXdBT3Yw?=
 =?utf-8?B?MXMvRDlyaWtzVW50RmM2NzZzek1FLzduTkp3QmtiZWxPdW1mdXZCSzV2M1la?=
 =?utf-8?B?bFNMRDA1cEtTTjVUV1FBMUNicEFicmt0eWIxb3dLTXVFT3hzZUFOL3RrMUR2?=
 =?utf-8?B?N3JnMlFnd2VDeGRqNkQya21VSXVablRHaFVWcWNRRXhIM3BLUnRlc1JwNkdS?=
 =?utf-8?B?dVQ0UHZOWFBmN09Gb1laN0hJZzBlZFlUbXloRSs4NUlnZmVic1ZyMFFBS1lE?=
 =?utf-8?B?clV2MStseDlGa2k2NW5KYzY4UUFFNUQ3bWxMY3dKeUJIN3M1dG5RcTZyVGZq?=
 =?utf-8?B?S0F3Wmt4cjEvcXZJZFowa3F5eUxvTTBrRjJ6Z3JVRHIwdTlXT1NSMDVxODEz?=
 =?utf-8?B?a1lBZDB5Um5FMFNLcE03ZHZPblZ5eWl4SzUwaHBseUw4UHpINmN2T3JRMUt4?=
 =?utf-8?B?ejF2bFp6RjNKTFRFYXcrUWFjQ2tsdUprQTY0Z1BnSXlGU2hZcXJXTDN4SHM2?=
 =?utf-8?B?L0p6UEFRbGVEQ3dUTzJ2VlpWckZZUHJBRHNLejVaR2ZDcWtaU2pjUlZodjNz?=
 =?utf-8?B?akkyeE1TVzZvZk1BMFVXc3c5OG1OMnY5UVd5SGdjc2E5U25pczJMQkpJSFlR?=
 =?utf-8?B?MGlQVng2K2pIbWtvS2RrU0M3TXl0M3hXUWUvdXpPTmNHRW1ZSmpWMFZDeUR4?=
 =?utf-8?B?dlVLcmtveHpqOHdpZmdzMjdURGJSOXd5T0hPNE1mbHM5VUtTWDJNbHBiTVpL?=
 =?utf-8?B?dHB5QnRNd1BUTWdBYTRyNTVOU3ZxRVByVW5YZFhaS2l1UW5QS0M1VTQrV2pZ?=
 =?utf-8?B?aE9aTm5kZTVIT1dwaEE3eElsaXdiWXFDenphbHBOMkpXTnBoek1DZGVkTGE4?=
 =?utf-8?B?bUtURVNzSUUybjU1ckF3MXgxWkxENUI3d25CdCtQaWFDUENlL1NSQ0E0MG9X?=
 =?utf-8?B?enUxZzJRUjhYaTNSMGRpQ0tCLzdEOXEyUklPOGxlNmMwM2ZCN2pvMnR5eEcz?=
 =?utf-8?B?Q3dqaDRNZ0ZqYnY4Q0dHaVhObDdMKzZLQ0FURHRzYzRLNC9uSC9SR29wWmJM?=
 =?utf-8?B?YjZBVkNOZ2Q0WFRNcDdwSG4wMkZVcWFxVFF3VVB6cnpaMmJjcTgzOEVkc3RX?=
 =?utf-8?B?Q2NOLzNpWkIwcnl2Mk9WMTJrNWdmZE5pdkcyZEw0OXNhd3dRdTZWMzFOZi9q?=
 =?utf-8?B?MjNBcjVrN3ZSRDgvcTZzeVJJaVdJUWlycVQ3MlliT1VFSzU4UHFTNGlQaVpL?=
 =?utf-8?B?TG01eVVsdFh3azFLMzJFVmVsVzZLZGhaVWg1c0lpaEovZm1hR2JzdVRPL2hQ?=
 =?utf-8?B?YUtnT1FnWTFIakM4cXJieFpPNE9ERU5BaThMT3FpaWhMeTBScEpuN0pDRUJW?=
 =?utf-8?B?MElNVHdXZlZOaDhXbllnSm9DYmlWU1BGQndud1k5eFh3Q1ZLNU1XemxRdEth?=
 =?utf-8?B?a0ZNNGlkbndPMWRTS01NUUR3em00WHNST1ozM002akw1RHU4K2dGQkJlOWNx?=
 =?utf-8?B?bjQzZGJGMk5EamFwOGxVMFduNE9qZE9kSkVWQmtoSno3T3EzR2swWnFmY2d4?=
 =?utf-8?B?ejFEM1pRR3NKZ2xkd2hHQWUrS3JYTWltamlqdmZZSHhqR0FEREJEVnNnMnlY?=
 =?utf-8?B?bVZSbVhXenNVbm4yZFo3SCtYWmtFRFd1dzI1Ykd5NGRDK0FlOEhtT0tpSmtw?=
 =?utf-8?B?LzBZVDBlSlU2cndleVJlZzBzbndISEZlQ1FMbyt1cnR5d29ncHlObUlmYlFI?=
 =?utf-8?B?NnZuZDhXM2x0cU1yamF5WkRZNDdLUzlZNnNkQVQ4OWpqUmdVME5oSW9YN1Iw?=
 =?utf-8?B?YzFLSWZvM2hLM01kMXllOEQvKy9WYjdIQmdHK2hLNDVod1lCY0tzcDQyUE56?=
 =?utf-8?B?ZXZlOC8wUUtPSmowRGF1amhKakZxeXAxYTAvd3VNc3pDUVlSWjdUNzJhcjJF?=
 =?utf-8?B?WEtyc0xqcDcrMGVnbHB5aGFWckJCc0o5aDc3WFUraHZXQjVZZWVsVTdtZ3NP?=
 =?utf-8?B?cE9pQkVXbkROOUt1VkgzeGd0aGsxQ3FuRTJBRGduZnFsOXVrOGcxUVNTTmdU?=
 =?utf-8?B?WHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9dcaea-f4a7-4ce5-752f-08dd3afb3bbe
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 15:41:27.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M/ItsRFPXKugtX0yLJWPgxZyHARqamkZV15Ui9Nd5oVB5ohiie2dtmps+W49dsNZ8MVLvnbJ0Io5S7urDBa07Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 22 Jan 2025 15:41:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17596

On 22.01.25 15:28, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> In the current implementation (since: 284175c3) disk expansion logic
> is done before the actual disk encryption.
> 
> This results in reencrypting the full expanded size of the disk, instead
> of only reencrypting the sections containing the actual data. This results
> in a drastic increase of time (approx 20x on our systems ) needed for reencryption!
> 
> Since relevant disk contents are only available in the sections of the disk
> available before the expansion, it is sufficient to reencrypt them only.
> 
> This patch changes order of encryption and disk expansion resulting in
> faster encryption (since only the necessary parts are encrypted).
> The resize operation does not reencrypt the added disk parts but just
> extends the LUKS container (cryptsetup resize) to reflect the maximum
> available disk space.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
> 
> Changes v2:
> - Reuse get_fstype from mkinitramfs scripts/functions. 
>   Therefore, we could also get rid of mounting the partition
> - Dropped support for btrfs (compared to v1) since crypt hook
>   does not support btrfs anyways

Will likely return soon: I'm playing with a/b /var using btrfs as a
first option (should not remain the only one, but you need to start
somewhere).

> 
>  .../files/local-top-complete                  | 28 ++++++++++++++++---
>  1 file changed, 24 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 8adc4e5..0146f58 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -153,6 +153,26 @@ expand_partition() {
>  	# Inform the kernel about the partitioning change
>  	partx -u "${last_part}"
>  
> +	last_part_device_name=${last_part#\/dev/}
> +
> +	mapping_name=$(cat /sys/class/block/"$last_part_device_name"/holders/*/dm/name)
> +	cryptsetup resize "$mapping_name"
> +	last_part_mapped=/dev/mapper/"$mapping_name"
> +	fs_type=$(get_fstype ${last_part_mapped})
> +
> +	case ${fs_type} in
> +	ext*)
> +
> +		# Do not fail resize2fs if no mtab entry is found, e.g.,
> +		# when using systemd mount units.
> +		export EXT2FS_NO_MTAB_OK=1
> +		resize2fs "${last_part_mapped}"
> +		;;
> +	*)
> +		log_warning_msg "Unrecognized filesystem type ${fs_type} - no resize performed"
> +		;;
> +	esac
> +
>  	log_end_msg
>  }
>  
> @@ -215,10 +235,6 @@ for partition_set in $partition_sets; do
>  		echo "ROOT=$decrypted_part" >/conf/param.conf
>  	fi
>  
> -	if [ "$partition_expand" = "expand" ]; then
> -		expand_partition $part_device
> -	fi
> -
>  	if /usr/sbin/cryptsetup luksDump --batch-mode "$part_device" \
>  			| grep -q "luks2"; then
>  		open_tpm2_partition "$part_device" "$crypt_mount_name" "$tpm_device"
> @@ -259,6 +275,10 @@ for partition_set in $partition_sets; do
>  	esac
>  
>  	finalize_tpm2_encryption "$part_device"
> +
> +	if [ "$partition_expand" = "expand" ]; then
> +		expand_partition $part_device
> +	fi
>  done
>  
>  if [ -n "$watchdog_pid" ]; then

Thanks, will apply (once I cleaned up my local tree from the
ab-var-snapshot hacks).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

