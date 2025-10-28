Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C39FCCD1BF
	for <webhook@archiver.kernel.org>; Tue, 28 Oct 2025 08:03:46 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.52])
 by mx.groups.io with SMTP id smtpd.web10.6472.1761638621427903652
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Oct 2025 01:03:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=TBlJrhv2;
 spf=pass (domain: siemens.com, ip: 52.101.72.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSvSq3OSBWg57fafkzBXhESef4EIRDxM+gE862nMLpZ9b1s6/eCQP5Wbe/FNlnkl3OgDe1arfju344WCpYmF8es1EOxw5ve+PUB+D+c3TFIukPapHua8qmhKzhEsL49oWPvc0z9K2mB4g84QlE65Dl40l0KXl2J238cTW4hWtl7fzfrEBobhY1UT9WWxMLKPhZgmyrAPwDfdlXbSg2OpRobuOCAo1jqHj65RYEh63MhFRFY45bum+/wQq0H76Q7YYqwRfYlhq+SAEePx5/qefEDePecEm5bt2RY8hT87N9GK91xDZuxERTTW3az2riMubg8dGMRnMgSz5BSt0q5AqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vtW+0xjl0NbIVLoZjBPC1buJwuiti6NIGJtYoaz5Ew4=;
 b=yUBbOvIqbJ42+61VlgUvr6CAi7lSWRZOBeSZQTnCUot7Rp7FPxnrRIhl87S+WB6Rnfppu8YyFORp8we5uy8g+OE8cNLFmKXoPnz/PJwnui/YcW+AyzPHjA3wIZ+hr7K3UPmkjYWn4DSE9SclufLWeRXPlhqwUTIZ4hDdTlA0QMvYoYkBsKitaICuLuPbT/v1V1ViXvEs6ukQDfopJ6a30j7YkN734pzoYbjmAOTJR6r8vufp50F1ofsmpMrAxxZ9/DitYS6fuWy3SzHCUYEk5YRaUcV3CKWcC3DIQ64uV6iivXzbGDtCCB2wLoME3ufE25dfHEb/wr3Gx/Xf4mtcqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vtW+0xjl0NbIVLoZjBPC1buJwuiti6NIGJtYoaz5Ew4=;
 b=TBlJrhv2N0FeEJCOMaRc61BcUbRNDHxavdXLeUFmEYQ9wykpNQrZdGL6qqjT4eNRMCl7ZKAQNQI1HgwggjtPY8ytakSeBwaMux5iCP3bc95z2T9OEUU2WBinNlD/T6BtUPSdVGkMDIFHt49NkYR/BiJwH89iKh6p3qpcug9LnJEx5v1SLrTSm48NzQQs91g1qqFv/D9AGxuqBmbMnA2vHya5+YT3StizBv3nd+YMIYDlB1VuHFtKSeX5gfB3fSBL9Laayibab3Z5XG2OxfdovR2StypFPlgkChMY1cR5Tg18XNAxNbzz2vvYAY6wxAT8vOK1mPU2mqlpqS0yeAKeWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:525::6)
 by PAWPR10MB8115.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:384::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 08:03:37 +0000
Received: from AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a]) by AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4bc5:6908:1189:7a%7]) with mapi id 15.20.9253.011; Tue, 28 Oct 2025
 08:03:37 +0000
Message-ID: <61b708f4-f624-4e77-b58f-3892717f8a4f@siemens.com>
Date: Tue, 28 Oct 2025 09:03:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][RFC v2 1/5] SWUpdate: Use self-built
 SWUpdate 2025.05+dfsg-3 for trixie
To: cip-dev@lists.cip-project.org
References: <20251028054623.2268466-1-Adithya.Balakumar@toshiba-tsip.com>
 <20251028054623.2268466-2-Adithya.Balakumar@toshiba-tsip.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <20251028054623.2268466-2-Adithya.Balakumar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:525::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB6023:EE_|PAWPR10MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: e5d29470-fd10-4fbb-d5e5-08de15f87ffc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|4022899009|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bWZMdlZxT0ZsUTZ1SWFIRktlRDFCeTJUYTdzM09TU2Y0YW9zcTBUYThYZVl3?=
 =?utf-8?B?TlFHN1N5NExqVmJkUTlod0dYRUhMdVZFdVRJNWdXS05OU3htTzRjUExiVytV?=
 =?utf-8?B?VzkyOVZtK3h6MHlxWU1ETDhGU2R1WnRjb2Q5aVJOQys5cVFSUUR3K0t6RDR4?=
 =?utf-8?B?RjRMbm5HTkV0MEpUM3pJNk5EUWttR216ajhVYWpOUENOekJEbzhaSUF6YVlU?=
 =?utf-8?B?R3lEZlc1aHVDRXBXRnlYYWVrSmNGNkd6VjR2VUtyWCtoQmNjU0FZNDF5Zkhx?=
 =?utf-8?B?VVl3VElCUk9oYmMyWk5hSGpsRGJvQWw5OFREQnBYSTNZVFhNcFJOV1BJd0pF?=
 =?utf-8?B?ZkhWUjNJc3VUVkVaZHVsaVUrbENkY21NelJRQTFRSFhZSjNZMklWc3BwWmFa?=
 =?utf-8?B?azYrK29KMUEwZk04bkJ3M3g0S1c2WEcxU1dVSFZ2Mk4rNThKdWc0aFg2dHEw?=
 =?utf-8?B?QUFlandtRGF4dVAwREdDeklyaDNyeVQ5ZVlOUU1pVDVXaU9SZmo3S25BeGpP?=
 =?utf-8?B?ZlJQZHFDN3FIMVZVeG94NnA0SXB1VWNmdGVESjVkWUhHOWdHdDFNeXozOFpi?=
 =?utf-8?B?YXRDZWJwOGQ0UHNQVWlNYXVTRFJZYml4TlZHbE0yZzZXQ1pCMGRkb1RFeE9q?=
 =?utf-8?B?dGhqN1lmNDBNUCtDUTRGNDVVenlwVVo0TVFwNFpBVXJFcUpTZTVNUytLVG96?=
 =?utf-8?B?NHhWYXZuWUpPZ1hJZ3pSMFVER1E1MUt2b0lXS0VKLy9UYnc3dDU2ZDgrM25r?=
 =?utf-8?B?ODdneUhJMkx2M3ZMdTR1ZE9VZG5KOUIwYS84YTF6Y2lCUitIMUFyc1VVazYv?=
 =?utf-8?B?QW9ieHUxRjNtd1BQaXdpdWI2RjBpWS8xbkdZQ0tvQzlrWHpKenl0MVlXZjNC?=
 =?utf-8?B?RitkQU9xUVV0WVVDTkVoWGNOK1k5eHhPa3dPMTM2RW0ra2xRa3ZiaDRtOXVq?=
 =?utf-8?B?ejZrTHMxTCszUHl2YXhicmR2SHlQbVZLMnE2M05MODB0amF2SGU1dHpaQmNx?=
 =?utf-8?B?RHRKNk9DRTQzY2YyOFBMaTBFR3JTbzR2Vk1jV0xtRnA3b0tMVTlWN3QvNnVX?=
 =?utf-8?B?anNsNlovT1ZjVDRsQUFveW9FVm5CeUlWRldBQUxUNzVRcnNTWVBaY2FXWjlz?=
 =?utf-8?B?ejRUVk5YMUVZbjRpK1F3V2FSSkJtOFd0TWhNRjJzc1VpdzYrSkxhSVA0WjRC?=
 =?utf-8?B?Y0VoRFVpek5PQXhiK0F4TE1oUWVNcGs1R3JuTHBxMHlkT1hrR0xzQWlqSTg3?=
 =?utf-8?B?ck5JNnUrS0lkVTMrT0ZLRVlDTENBcGIyLzNLQmpGemd2Tm5TU0NuU0dOZ3Jl?=
 =?utf-8?B?MzhNQlVyeWxHKzMzK1NnQSttSG8zR3hpVnh1QkdMWDVqNG5vSGVkbThOemo5?=
 =?utf-8?B?Y0RXQ1NYNmRGKzl3WERYcS82N1lHZTg1RXRralN6Z3orQmNkUGhzd2pQYjlJ?=
 =?utf-8?B?OXlZQXR6T0llc1JUcGtZRERWcVhGR00wNnVmWlhYbk9qb3VtVTRKUFhyQnNN?=
 =?utf-8?B?U2VWRjBpTU5WNDdzTVYrY0xXTlVMSWdjYjRrdTFZaG5mWkpweUtKNnJHQXRS?=
 =?utf-8?B?dVk5UTZuMVk1cGoxUlF4TEpOUnp5RERHdk1ZS3NSN215U0MrRGNYZzBrWmNW?=
 =?utf-8?B?Q0lLb3o4cXhuMTRtQWt2bnZKNk1NR2R1N1U2TlduZFh0M1FOcWRud2RKV04y?=
 =?utf-8?B?TWM1cUxlczEwc1RrbVF2R2ZmcVhFeUFaUXJEU3haUUNXSzJ0ODJ0cEwwOUl0?=
 =?utf-8?B?M3F4NDVEcUFVZ3lKaUhkVlFhR0RURVFpMjUydzJuVFI2QmVmN0tMYlVvb2c2?=
 =?utf-8?B?NUlTdDZLbWJHdXA4WDFQb2tjUHBFdXQxSW42VGw3WVhjb2I3NjBOeTdlQVR1?=
 =?utf-8?B?dUIrMnZhK0ZZR1RjVjhTSWVCNlB6K0lFY2N2VXRDanplVGc9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(4022899009)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?V1ErOGcrb1BMOURWeUIyOVJacjkyZFA2TEFLQ2NHZmtVVmF0YVVVVklBelNM?=
 =?utf-8?B?WW1ZclNJVkNxbVJhTzN0RjJNN2t5UnFCMXlIeVVXMzFQL3AxMVpvUjkrYVFI?=
 =?utf-8?B?bXdnSjJac2s0ajUyT1hSaXJtbE9nOFZDZ1gvdlZSS1RJQllUeU14U3ZtVnpH?=
 =?utf-8?B?REtmOFdweGRWWENWaktURjJwZGVxMGRtTXc4dE5mQm1ZOFYvQlMzVXZaT3Rj?=
 =?utf-8?B?ekpwQU9GeDZ5SXZyR2pNZHZ2TDVzdS9UU3A3SUowMC9ySWJGbTZxd3hWRnpl?=
 =?utf-8?B?NjFSVUhYb1M2bTJ4NFRLQ1VnOCtpNDB1WDM1aUFsR0RnT09vQXhxcGVmbTNY?=
 =?utf-8?B?ZEN2Y29VNTVlR3hKalVsajd1TnVzcVZUMXR5cW5VNW9rVWRGcnpiays4WWM3?=
 =?utf-8?B?Rm5PN05wRUxCdTh0TUYwQVo2eGNRVUZteis4Q1dobEtDdWV4eWdQMjlFLzQ0?=
 =?utf-8?B?Q1FDb05rckI2UFJ3emMyK2p5MEZwbjY5bDVYRUR4ZXRGT3NMTGgxbGVNSFRK?=
 =?utf-8?B?SDZOWkZaTytRVWQ2ai95dVZBM3BGajhaUzlscG1yY1JvWlpmQmFMMXpCM3hU?=
 =?utf-8?B?TU94YUkveDc5Q2lKZVJzU25MZkxYaE9zcUhQOTV6bjNEVjh2VkE4WjNnSkVQ?=
 =?utf-8?B?SXBKZDVOUE9MRHZwQ3pNUXpWM2YzV2Y4elFlT0Q2aXYybm0vaGRDS2Q1ckRv?=
 =?utf-8?B?eWN6UERTdFZROFR0YzBjeW9PdTF0QllJR3BwRFVIeldYMUlWZjdMaHQrYk1n?=
 =?utf-8?B?NDdmbnBzNHR3Vnp5cjlkZFI5VzA5Q05zRnJ6VDdoUHRrWnV4TVA0YW1iVWdB?=
 =?utf-8?B?algzVk1KUlZVQU9DaFVYeHQ5Y1FoK3VoajFWUDltMytuVVo4bzZqSjJ5d1V0?=
 =?utf-8?B?a21GNm4wZXBqS0NhcTFDb21jd1hDVHpTY3ZtNHAzQ2JUZE10SncrTk84emhX?=
 =?utf-8?B?KzhKZmN1NmMzQlVndkxaK2xpUW0zSXlXZ2FzUEV4Yy9OV3Exa0NEMysvMUVB?=
 =?utf-8?B?Wm9RcHlVaGMzNVRHYnRiYysxYS9mNEhxd1hpUnl5MFhLcWw2S3lValZYd3FS?=
 =?utf-8?B?M1IyWW1RNklzUCttSXM0ZTlJcHU2Mk5ZdGcxeG9ERzVLcVl2WU11bHI2U3Mx?=
 =?utf-8?B?eEFnMGRZMjlPK3dQRFNHbU5xeXNxL3AzT2U4SGwvN2dIdFU5dTZmTlpUbUZ1?=
 =?utf-8?B?b3VTSmh1RnducGlwWTdVRE5WUEFwS1VkL3UrdXpXejRSejZwRVlpL2ZMZlhj?=
 =?utf-8?B?QXJjaFJ6MUVneUlFRFJCRFQxaFhQY25BZnliYXNwR290RG5TZFpYV2p3bER2?=
 =?utf-8?B?dC9DOUJFOUVVaFk2cTZ3NUJ6OUFoMkNkQjRPdHViVDJKRnFQc0pxc0hrL3pQ?=
 =?utf-8?B?RlRCaVF6aVh2bHh2R2E0MkRHWDJMSm9HeUYzUVg4NTc5aGorOGU3L1BFVHVO?=
 =?utf-8?B?OEMweHljN1ZhSTY4LzgybURVdWJ4TnRjdUJtVG5iZzV3Z1FNOFhwOEF0K0pX?=
 =?utf-8?B?ZzZaK2RIZCtneUU5YkhqZmVsOCtDQ0ZWUEhWNE5FZHlEWjZUTHp1RUFMd09B?=
 =?utf-8?B?Z21IWVAyZE4yWTZYeEI5YjdaVzJleW5DMnl6S2tvaDBnZW5pWkJ3c2h1dzNH?=
 =?utf-8?B?aE92VWp4UjhsYUhpQ3BRS2MvYjF5MjJ4SmY0UGp0QVowbHBHeEFzYWJVaVVa?=
 =?utf-8?B?bDNSU0UweUYreDVNeUdMaVl2bFVKR2lBdmVRckIzZkZiZ0s0QVBDUkIrR2x2?=
 =?utf-8?B?aXRkblc0dXlyWkpZUm1ndWxMNXRhMVR0L2RJS01DWS91TDNMUmx1NFFnOXZW?=
 =?utf-8?B?OWc1TjRrS2ZkN3o2QjdLU0xOLzczLzVZWm02My9qa204ajZWZzYrcmR0WUJS?=
 =?utf-8?B?VXdndk5iUFFSZjZxRDMvOVZIS2pxenliYkYyekRTU3ljQ0YyK05GK0V0WTFI?=
 =?utf-8?B?REFtSC9WS0xNR2ZGVWhiWldHL241MzJ6SFluVm1JcERidGJ1cGcvWDcvK20r?=
 =?utf-8?B?Wlhqb25CWll6RTYyOEEzdjd3Z1hqWnlkS1Y2aFBWR01BQmdzbkQzd3NPNGhU?=
 =?utf-8?B?bkoxdWdvRXoxNGVqNmtzbkpmcTdWVXNEdUZBLzNiSDc3WGlTcTdCR2VZczkr?=
 =?utf-8?B?WVE3Z2hjWS82aHNZcEprdE1ObG80TUlIZzZUVWtSWlhueHI3SjhCTzNhOFJB?=
 =?utf-8?B?d3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5d29470-fd10-4fbb-d5e5-08de15f87ffc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6023.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 08:03:37.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8PFQNBRN7k9XaqAorf3ua78dFwsf/AhXA3D2rn7wxZFk58VUCQC4sJUa77l4CEETUALiuRj7ahQ0QuAbZnB9VkmKCVdy0kUckfGSBzmwZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8115
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Oct 2025 08:03:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20250



On 10/28/25 06:34, Adithya Balakumar wrote:
> From: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> 
> SWUpdate debian package for trixie (2024.12.1+dfsg-3) has an issue[1] when used with suricatta wfx.
> The issue is solved in upstream and the fix is also backported to debian but only to 2025.05+dfsg-3
> 
> For now build SWUpdate(2025.05+dfsg-3) from source.
> 
Please talk with the Debian maintainer to backport the fix to trixie.

Quirin> [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1118485
> 
> Signed-off-by: Adithya Balakumar <Adithya.Balakumar@toshiba-tsip.com>
> ---
>   conf/distro/cip-core-trixie.conf              |  1 +
>   recipes-core/images/swupdate.inc              |  3 +-
>   .../swupdate/swupdate_2025.05+dfsg-3.bb       | 36 +++++++++++++++++++
>   3 files changed, 39 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> 
> diff --git a/conf/distro/cip-core-trixie.conf b/conf/distro/cip-core-trixie.conf
> index b133bbb..663f2b0 100644
> --- a/conf/distro/cip-core-trixie.conf
> +++ b/conf/distro/cip-core-trixie.conf
> @@ -12,5 +12,6 @@
>   require conf/distro/debian-trixie.conf
>   require cip-core-common.inc
>   
> +PREFERRED_VERSION_swupdate ?= "2025.05%"
>   PREFERRED_VERSION_linux-cip ?= "6.12.%"
>   PREFERRED_VERSION_linux-cip-rt ?= "6.12.%"
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 75be566..47f18c5 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -28,10 +28,11 @@ SWUPDATE_SELFBUILT ?= "0"
>   SWUPDATE_SELFBUILT:buster = "1"
>   SWUPDATE_SELFBUILT:bullseye = "1"
>   SWUPDATE_SELFBUILT:bookworm = "1"
> +SWUPDATE_SELFBUILT:trixie = "1"
>   
>   python() {
>       base_distro = d.getVar('BASE_DISTRO_CODENAME')
> -    if base_distro not in ['buster', 'bullseye', 'bookworm'] and \
> +    if base_distro not in ['buster', 'bullseye', 'bookworm', 'trixie'] and \
>          bb.utils.to_boolean(d.getVar('SWUPDATE_SELFBUILT')):
>           bb.fatal(f'Self-built SWUpdate not supported for {base_distro}')
>   
> diff --git a/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> new file mode 100644
> index 0000000..5c47d68
> --- /dev/null
> +++ b/recipes-core/swupdate/swupdate_2025.05+dfsg-3.bb
> @@ -0,0 +1,36 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Toshiba Corporation, 2025
> +#
> +# Authors:
> +#  Adithya Balakumar <adithya.balakumar@toshiba-tsip.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg
> +
> +require swupdate.inc
> +
> +DEPENDS += "libebgenv-dev"
> +DEPENDS += "libubootenv-dev"
> +
> +DEB_BUILD_PROFILES += "nodoc"
> +DEB_BUILD_OPTIONS += "nodoc"
> +
> +FILESEXTRAPATHS:prepend := "${FILE_DIRNAME}/files/${PV}:"
> +
> +SRC_URI = "git://salsa.debian.org/debian/swupdate.git;protocol=https;branch=debian/master;destsuffix=${P}"
> +
> +SRCREV = "421a70d4449a9b036ed5a0598ae9b70a82dabfb8"
> +
> +DEB_BUILD_PROFILES += "cross nocheck"
> +ISAR_CROSS_COMPILE:trixie = "0"
> +
> +CHANGELOG_V ?= "${PV}+cip-${SRCREV}"
> +
> +do_prepare_build() {
> +    deb_add_changelog
> +    cd ${WORKDIR}
> +    tar cJf ${PN}_${PV}+cip.orig.tar.xz --exclude=.git --exclude=debian ${P}
> +}
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#20244): https://lists.cip-project.org/g/cip-dev/message/20244
> Mute This Topic: https://lists.cip-project.org/mt/115989447/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


