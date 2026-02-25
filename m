Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69C1AFD3769
	for <webhook@archiver.kernel.org>; Wed, 25 Feb 2026 15:42:14 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.13])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.48038.1772034129548565999
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Feb 2026 07:42:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IyWpjeKx;
 spf=pass (domain: siemens.com, ip: 52.101.70.13, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DDIaDG3t93MH0ju+XUvwlfCEr1neA8QJ246PKXkvfxntn2vCjfIOwjH1fON+58BzhjGawSSKP75aVedMOJg+YTFSuTBbFnDpE/o/YkGxT63rsn9TzrgzouHfaWAbUDhePYSbn6+geS2da8lG9fFmpIuxahjB0fDOcplecR+ZkMO0bamilt+znusIe2lBtvEJJcDj7mWoHQsdLpEI3macvLryinNfiFkkODZga3YDnQ2q+LSlKwSTVUU1hDUJOIdRpNMTRadyFWPPOC4AkC5sKMc8XX4UcbWkEWT4NL/eI9x7V4nJJ9XOfyyd4FWVeADdpOUJNJ/SY0bXPkn9ZwDGRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+M5wxs3iabKLsiD5u4PHSbaT5c/dSD7vYRGt/ylnLg=;
 b=tEPIt9AhIf4XhqsjyLunO5limT5l1+AdSH4VslPv3jJkLFuJvAuC6+2C/ckntsu0ag4vywFqb9Re4e7bvMeRoN5aXoDArjROwOrISXfewzVcmv4e5VnY9vHEY30XaoIsOJpeVnh93E7txEPY5B5fDMdP5lqtemUEZ+5lfvS3chwHMJLbE7DKJlUwYuE5rxH11Pz9ayqxk+dKULay4xX8PNtKl88gqgcUWyfEyXurx3EzzggCuKVfearKelWOcYFdREJCWQAMWRGyW6G5CSuQsfCKaEdp+TXuy/B4AZLwTX5UVArL1/DZchDuraUa2+XvVLvUvYmp1uV25p/aHZlWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+M5wxs3iabKLsiD5u4PHSbaT5c/dSD7vYRGt/ylnLg=;
 b=IyWpjeKxVODI+c1aWPlbAi3aLkNRAinvtsaaCXZ4tL3H48nd6+FJvGVtfeuGducRUJ4ZRzltzAQUmkxDiRkHrJ7dajv10F0g5j1G32IBsIyzi69/wvpvYd6VXQDIdrggUoL6FfyL2bARk9wcTk/2HsWi9lYvSK0btJBpAPB1NhvvogdPUGVF/3QytQwY88ysP6n1j2iyB4WyaaE8Jh8Rp4M2foK/EcaySLaHU8bH8HZiCaU3HGfenC0pr+t+/sRiJY7Hc61xVuZ5Rb6xMPTah1h6c/bIBFJD4F2tZOTkl92dQ9p0CFrDabmlT3WYhLafYhRU43MF02ocp6mHWkjttg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB5PR10MB7751.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 15:42:05 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 15:42:05 +0000
Message-ID: <eca167cb-b110-4979-90ca-2bcef599d35e@siemens.com>
Date: Wed, 25 Feb 2026 16:42:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3 0/1] swupdate: Enforce signature
 verification
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: quirin.gylstorff@siemens.com
References: <20260212214003.734787-1-alexander.heinisch@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260212214003.734787-1-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB5PR10MB7751:EE_
X-MS-Office365-Filtering-Correlation-Id: 101b899b-56e6-451d-4353-08de74846d8c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	KPweqYkxHf/QTohk0ev329ZHLsxvzYvH9vvKrjOVlXSg4rrG31TK+ZAMEj6yqULVEwfzuCgLsVMdBLD06eD3GrgLMpP1qbAgD4ufKcWmX2GJyLh1X6OEdT0Tcml2cfYYdrYKLpTUAP/ghNAOzvuPxdftAOvbzL9HWCYKjxugKzGioW05TxzWvzRZZ/AzUClqe3WdLy4Pg41aPqOSs81z7FlwJrYYCyKkyiCz3Yr8Gworpgm1nOAa2V0SpWcUoxmjjJ3Ar3LYTL9pYKb0ftQ2TICfBtHvELlu2QuH4VKnPzxCkxtz1jQ9cEJmJ4FTT2E7ktPMPteFy6SKCxZO0R5pyWFLWxnaDEljVHwJH4Efh4WIK5+5oJVhzlBoIZZ5GnUwJFzZYNFIoHQAQGvtf6qc2IRTeNsZ6EeFav2CiylGdi8FbhERYnv0OjE0EtYAP9mWcobLwfAd/Cbi86VgmGmAdtup+xDPQqdMxpFKFcZfRwK2PB9afwRNRzUZfw8njDyFBoB8AAc8m98Li9QYHoFVUTxITEx3OJMA5nXMcT/Ji/8hV9A8r1brfNl+UcQxji5VXyhFamSzwD+Wix3Fyenpc5/Spl03M3t1fEgW5zDZIqBRsNaEX/LN+KWlvw6QT1RKhWiGKKgG/nubsJmsDlYrYskYQ/Fv2iMe6UFXRkxDw3dDys4Ygfm7VrtGRTAeTQ//yV1bhKb7Vs6oHRE1YAAMVcsSNiA1FJxCIAVE1tNTNi4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V25YQ3dEaS9BUzBqcndvcVNzTUFYRm1DeTI1Q2JLNTNaaDNLYTRySVF4QjFZ?=
 =?utf-8?B?YkdrR1c4M1BEamZPeDZEQktLU3RVeVhqMEFldnVISWRIVlNvZkF2TDVYSEhO?=
 =?utf-8?B?NEswUTIrcHNxY3VPRlBoWnZmSjdmRk1DT05OWlhBaWQrYVhaMS9wSytMSEVE?=
 =?utf-8?B?UjFybGFSL2ZQRFVDL29XNjBFT3FxdzR4V09BWWVFN0ZLeHZ5Qkc0bVVDRStS?=
 =?utf-8?B?NWZMVGx4Q21UN0VucTVqWTBkNVVBd0RDZkhzZFZMRUgzY3l0RE5HTUdoUzd5?=
 =?utf-8?B?RWZiNjd5TmpGQ1FuWVNCM1Ryam5xLzBLNFVlTlZuRHp5UjErc0t0YjFzSnVl?=
 =?utf-8?B?aGgvSmloL3VSVTBXc3RqbmtDRTB2V3FpVEM0bWZTQ2E3T08yUEVQa0hyNitl?=
 =?utf-8?B?bXJNcm5LTno4Z0xaL00yOG9ZVHQxWnlqR2VPc2RkTXdCTkZBM0pMci9UWkUv?=
 =?utf-8?B?UHBoOVUxRDk1NmVGT29SSWNlbVBqVUZFSzM1a21NZm8xVzFNY0owaVdTd0ov?=
 =?utf-8?B?QnBMd1RuUVJiODVRS0Jodllid2hrbFY3Q1htSzBrMWNNRmxiZGxOYndncGVH?=
 =?utf-8?B?cFV2d1ltTkY3U0RYakVRVkovLzBMTWUyaHFIengvY29HTzJCczZDMG0vOFdm?=
 =?utf-8?B?dE01eDdyaWFocStmQkVoUlFocWJ6c05QM1cvV2ExU1U3U21jajkrT3Ywb2F6?=
 =?utf-8?B?WTh1T2lHZDBNQzVYc09NQklGbEkwQjNxUmFvZUVSZjR0UGpuUFI0dVBHdVla?=
 =?utf-8?B?cEUzZkhzQnk0UTllc0wwbDhDdW1iaWlRRUN2ZmlTdXJZR0xGaThONVBPWEZp?=
 =?utf-8?B?aDhGQk5kM1R3d3UxdkR5bVp3Wk1EOFJpTjdpSkFjY1hHcjVJd1k4M1ppZDVE?=
 =?utf-8?B?VitrdW1GWExqNC9Vemp1Q0YxQUwrbWR3MGNUZW5XMS9NeDVOVTJSTnhld25B?=
 =?utf-8?B?WUdUTlJXM1FLT3IyRGlHUStVMjBwYm5Wd29TcFdwOG1kQ05iRTJaaXRDOVVD?=
 =?utf-8?B?ZFdhR2xqSEZDTFBIMC94c2ttOTViY2RWNUZZb2RQWGdXUXZVbWNHY1NJMXdT?=
 =?utf-8?B?R3djb3ZxclhzU2p4WXU0Qmx3Znl2OEZGSWlGbTRQdE9uU0owTjROTTVZRGIz?=
 =?utf-8?B?Wis1UHBwQ0tQZWl1SnRFSjArNERGMGpQbnZzQzM1S0RaeTlIVmVDd1cvdGVJ?=
 =?utf-8?B?dWk0YWlGajd1V29tczNTY2ZUWU00YzF3OW9OeUV6L3laeFFwK3UvUWIxaHRZ?=
 =?utf-8?B?UXRFOEM3YXdZWE5uZlo0Q3FFZ1kwcDNCNVlsNGlzSUgwZUpIaVljTk9TM1Zz?=
 =?utf-8?B?dytiSHhqcjNFUVdmWkhXSXdrL1FRT3U3R20xY0c5ZnFZeXlQQU8wcWdoeFpD?=
 =?utf-8?B?dnp0MkxxMUhlMGdFN1EzUU9OKzNQQ2llY1pSMU8zTmhZa2pBZzEwZkRSY2V6?=
 =?utf-8?B?cmozamtlYkJjWC94QVdMMURYNWphWWNJQ2F6dVlNZVgySjZiMUFIWERnSzRO?=
 =?utf-8?B?QjU1RW0wTnlrWDRBU0ROS3dDc3JudDhxOGl1WUNzSXFCcmx2aDM0WWw0bGJm?=
 =?utf-8?B?c0pyWHIrdTA5M29EUjF5RmJxRkpzeHhqbFZMN3VHb2JjMElpY2RvQVRCNS9x?=
 =?utf-8?B?b0lBS0ZYa1lSaDF6elQ4a0VsU2diMTNYcHpPNXIzM05mall1dWNVeVM2S0U3?=
 =?utf-8?B?TTZHOHVxMDQzS0QyUGU2a1dPSHlXM0NoOWRpbkY1MTRYMTZVME9OeFE1T0JZ?=
 =?utf-8?B?djQxMzRMN3pxNDU5a3hmcXZ2V05sTXJpRFQ5QTZyMlZhY0J2MFhxRnFSWG5r?=
 =?utf-8?B?STNwY3pKVWZBL0dNOUlHSEhuTWV1YUZEUCtlVEhOalF4U05jUkx5SmYvMDFF?=
 =?utf-8?B?YXA3MlFHYTVjZGlSQUROaVdTNHhMR0R1MGRLSFJpVTBCbWJTOGxtWjZJMXJm?=
 =?utf-8?B?aXZGaldQM0xLS2hQQStYdVlaL2xXRm10MkJFdUlnYUpLc0IzcWdUZlJBYXAx?=
 =?utf-8?B?VjRlTUdjcWZRT3pNWXZmZGFyMFg4RjBqS3lXVUFrREE1VXkwb3Zxa2lJUUtv?=
 =?utf-8?B?N3NsNmhHVndXZTRpb0IvN003N0N5dnRqM3JXb0ZiMGliK0FHRlNZNWhOS0Yy?=
 =?utf-8?B?bG9jQTNCaUsySEREdldva1ZzMW9Ub1NYRFdBenU2M1Q3RllVUDZaVWtDUTF0?=
 =?utf-8?B?THpjbE0rbHc5WjhobFlkQ2hMYkFPeVBZUkMzR0JZa0pPMVQ1SXRSZlhJZEZ5?=
 =?utf-8?B?Z3lQckF4MlFYdUlsQ2xPcmp1bXVxYVF5c2RSQ1grVFlZay95bElzZjlSNHVi?=
 =?utf-8?B?VS9BcWF5by92N3FWK3l0cmtkM3p2YmZlRzVhSmk0UE9HQ1hhZkExTVhOVWZ0?=
 =?utf-8?Q?Kazw/tbAzaq6MVPs=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 101b899b-56e6-451d-4353-08de74846d8c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 15:42:05.7126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SinYEUQIhrmDo9AyVudORY02acFE+GqBpKn7LXzqskkRp8STB/I/2tzeEY7e+jP+SGEwooL0ktytUC+1qLiPug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR10MB7751
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Feb 2026 15:42:14 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21982

On 12.02.26 22:40, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> The self built versions of swupdate (used by default in distros < trixie)
> do not enforce signature verification.
> 
> ```
> $ sudo swupdate -n -v -i demo.swu
> [DEBUG] : SWUPDATE running :  [read_settings_file] : Reading config file /etc/swupdate.cfg
> [DEBUG] : SWUPDATE running :  [read_module_settings] : Reading config settings for module globals
> [TRACE] : SWUPDATE running :  [swupdate_dgst_init] : public key / cert /usr/share/swupdate-signing/swupdate-sign.crt ignored, you need to set SIGALG
> ```
> 
> This patch modifies the swupdate configuration files to enforce signature
> verification by default, which may break downstreams relying on unsigned
> swupdate images. However, the diverged default config for signing and
> verification of swu files is probably not desired anyways.
> 
> ---
> 
> Changes in V3:
>  - Reverted default value of SWU_SIGNED to empty string in swupdate.bbclass,
>    which allows to control signing behaviour using CIP_IMAGE_OPTIONS.
>  - The dependency on swupdate-certificates in case of signing is enabled
>    is also handled in swupdate.inc via CIP_IMAGE_OPTIONS only.
> 
> Changes in V2:
>  - Dropped patch introducing duplicate config in kas/opt/swupdate.yml
> 
> 
> Alexander Heinisch (1):
>   swupdate: Enforce signing and verification for swupdate by default.
> 
>  classes-recipe/swupdate.bbclass    | 4 ++--
>  recipes-core/swupdate/swupdate.inc | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> --
> 2.47.3
> 

Just to avoid deadlocks: You will eventually share a v4 of this, right?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

