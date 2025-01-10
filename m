Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0172E77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:12:30 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.86])
 by mx.groups.io with SMTP id smtpd.web11.22658.1736525543303931699
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:12:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=VwQwewEn;
 spf=pass (domain: siemens.com, ip: 40.107.22.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rYg5KpIco0eHCT5z3ZKabQP16YnvBUwbzeTpUxFeWGcQ4wE3slv1sCYw0Fkp84kC4NPTITrS35IRBtsDTPR/tuE2W1dFr9p0xsjCoDfOYJY1oRGY744+jZ+xT2TDPPCOMVnGKaxWV0F3S2RXxvkemgx6jxxWK1+JgcU9MhSFi8ZWYyyZSbeTLXynjwVVB/TWC95YZno5uzrqdX2IJR3+FiMVu3gzX+l/V3i83MvW1pdJIMZSmao6Hc9QuBs6KMKO7NO1/2nc0rEQezPDiRC9Fgr0Z50lzZZt/U3fopmt5tFDkVVPXzNKWYXwXKwTRi+OtGsnc5zIUoxXbmwfBKBMBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2J1OkPxR2z2pnP1fU8rU7fRkCRl5rxxldmgkQj8MqYA=;
 b=LQ3cV7Fhu+L9e4spS4Sv0JmQS1wUYsSVF7vHGhmvLkqL2NT6OQ6G1WuyR9wdNqH/eosjY1usl4aic3EJQJEbjEvi9QkCYu7k+h8T/iWcOtkIY3hkesW15edfjUHHhwKTmmd4PWLoaJC6iZ3xoHM80Y17X8lD/abI5iXQ02B66rZHIxOd6r4UgnQ+Pqyv8/LkD1/HONVu/yq1Hv64wgPRopGAjXbQ6rbkC40BB2qn4e5bW7f/xYOjIT3gEx/DgNjD+21Cm6GpGim6jE3dnT+K31WpT2N5xNTd60mrWDzmtXo7bIGqhTNuSpsTgwa1iC0hZhHzUihZiv5s1kDGOaFpBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2J1OkPxR2z2pnP1fU8rU7fRkCRl5rxxldmgkQj8MqYA=;
 b=VwQwewEnLpU2aD8kKsYjY8VM2m1daT25CBQW5m9XOGyXFclsaagG7COwqX4uncQIfl7A2jVmsyn2LI6+t6d8EZI/4n3Kpotb0UgMbsdL1GQtVUws8BXr4sNvw3QVz5SrFAth79n8LEhqe5POufSfPGLx7dIu9UEXJEimWLhHi6XoXcahsHKtb8Ak7EOvLhFFlXQgjdwPPpxy/UaeXANZrHER32WA8gSSvS6xf0Nq8thYlXqfpHUSfXVhfP0FRzrAJZmJwkZ6RysgnoFH/3DvYTood5TqOcF30tFHXJB0/7h7uilwbisqenNH6rsb+ZqLIFS4UYyN0SOqQ/GzyWsrAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 16:12:20 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 16:12:20 +0000
Message-ID: <bc14959c-9f12-4e68-ab21-7b7f3a07f726@siemens.com>
Date: Fri, 10 Jan 2025 17:12:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] initramfs-crypt-hook: clarify
 resize error
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250110160051.91196-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250110160051.91196-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0003.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3146:EE_
X-MS-Office365-Filtering-Correlation-Id: 049ac471-15cb-462e-2215-08dd31918f38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?U3daTDJJZGo3MGd4MEdOWEFvQmJoN1dFZnQ1eFN1dk5JS0Z0ejBOVlkwSWpE?=
 =?utf-8?B?MnM3RGkzVnpVbGpzc3F6eGdTOERGdWpLVk5LS29HZlRZaGxTcEhMQTBtbkVS?=
 =?utf-8?B?QjBUa0ZKeHlScURrWE9YM0kwaFA0ZnhkdUlUWVZYbXNFNDhBZ1U3MjJjZG9s?=
 =?utf-8?B?WWdiMjc5L2hraXdWaTVoNm9NNmd6bTNYZ1k5Ym1WcFljNjhreGlIbHh6UmUr?=
 =?utf-8?B?WTJxMEFkVlhJRitVemZRZjZPdE9SUTdyMlVxYmR4aTBuNVBEbVdJdmFNdU40?=
 =?utf-8?B?bzV5SUErOG5EOTZvaUZjeE9MUzAzeE5vWDlPbGhIaklMd3RNaVVWazFCR0Mv?=
 =?utf-8?B?MmtKbXk4MWNDdm43bXpocUJrSjNhWVp6Z2MzYyt4OXZFMkFtM2phb1NRWm5L?=
 =?utf-8?B?TTFsRzRoRDlzZEluSEEvNkRyMDVEZTJDNEJ4TTJYSDNMLzRoNE8wK3J3MGpn?=
 =?utf-8?B?UjdHOHNnQmo5N1JXa0EzN21UaStFc043MnZZcG1ya1h4V3NVZDE5WFNUN0ZH?=
 =?utf-8?B?TFYrRmJPQkx5VkQwRjBsWitpSGhYTGNUYjhkZkxTdnlCZWJXREwxaHYzb1Y5?=
 =?utf-8?B?MG9QcThEV09PT1RtTmNTMWhRTmt4aU12bVNmMHRrN2UzRVlsRGxXS1ZGeHVC?=
 =?utf-8?B?R2NueG5VMDB3bVlyZ3lYd1JRZWdUeE9jekpDMkVEQzF4RzcrUVNFMisxM0xq?=
 =?utf-8?B?cUFsM2Vpa2gxbE9KV2FpOHZ3NUJhVzN4WEt1Rk5hYmVvUzdqSVdTVGp0bWta?=
 =?utf-8?B?MlU4ZDlYZmUxNnBLdnhPTW9nZ3NCcy9JS3REcFdZdS9CN0k0eGFwNEFSczNG?=
 =?utf-8?B?VnVMUUR5Qk9QY2E4cTJBdE5zbGgyaERlbTY2VThmNWkxRkhxSEpFaU5kNW5Q?=
 =?utf-8?B?cmhtaVRvWnY1VXI3Nis5S1hxZ2thczM2amhOdCtjaFk1OXFuZmZaazErR2VZ?=
 =?utf-8?B?NmpRZ1UzUG9JVjY2ZkdOckZ1L3FWdVl4Q2hBL2FBV091OTEzbkhxaGtKT1Jm?=
 =?utf-8?B?YWVtTG81cEd5bDcyTjA3VVRweFF6TjFzV3FOdHZ5YkFLbmtrZVJtV0pVMTZz?=
 =?utf-8?B?VWMwTmUybHAzMzJIUjc2OHRvR1Y1ZzJxSmV4bXZrQ2pySU5sSDJ3TjlocWxD?=
 =?utf-8?B?Y0MzQ1RkdHZmNVZiVm1NallyWmNHUzdnaXFSTnZBMWxnVmYxbE5IcW1vM2sy?=
 =?utf-8?B?U014KzZLaDdYeDhzWXoybjI2RkJEVTNrN01PU2VoZHI0MG12aEU5WEhpZkkx?=
 =?utf-8?B?Z0FPSnkvTE95MnBCakc0ZTlDMGwraG5pMXlRTWNEV1lwWnRGc2JMbDkzNlJn?=
 =?utf-8?B?UDBkd0h0VU0wTGlnN2pOTGtHNXU3QnhVeVEyYjg2L0FmeHRjMXJ6ajIzZTJq?=
 =?utf-8?B?RGM5R2NSSTBvYkxPN2k5OGFmV1JnUVhXZGlMa0p1UGZlVzdHa0FsNlRaUkY1?=
 =?utf-8?B?NmdXR3Nlc2VnMzcva0poMmNzdU1ZY25UWG1oUk8zWVEzd1lSNHlya3RURUVv?=
 =?utf-8?B?OENjUVJSSTN5dWI5ZTUvZU1UOXJwQlRCWE1tNlJiNVFPYzdZeE4ySGZQQkFU?=
 =?utf-8?B?VjMxRmVkb083VlpRRjFPZEdSUmdQV1UvM0xLNTZtUDVHYUNGMnFWNXJSUTRB?=
 =?utf-8?B?eTgwa2VtempGQWc0ejJRczVhdm5nNzJLeFRTL29IT2puQVRCeEd2OW5BeDE3?=
 =?utf-8?B?bzNsT3NaWXVVajYyQVVaK0Z3cDFFaGljZjZlcXlhOGV6SmptK3FHVEZFTVJm?=
 =?utf-8?B?blM2bkEvWmMzbkFiNG8vYm56WmRSQnZsL3hyYTlCWHVabk1FM1d1aFNidlA0?=
 =?utf-8?B?TnY3b3pGWXkyYzUvUC9Id3ZPZFBybVU2cXlCNlRwaFM2QU9KQWpzekx3emwv?=
 =?utf-8?Q?97Vcp2tzaOSPm?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Nk5IeFlxb2FqbEtSUU5UZFVFS1RpSG1ieVgzYXJWQWJOenJiVzk4T0hXK0ky?=
 =?utf-8?B?UkwwUmZLNHIzdjJ1dzNOVjVlazR1ZXRTZTdzQzNGUndldS9zV0h5VlpyOCtp?=
 =?utf-8?B?Ni9zT29qeG9FVUdFVzFSdy9PMEd1bGYrb241WGxZbnB0RC8zZFY2WU1TbnF5?=
 =?utf-8?B?eUduOEt3SHpMcnNJLzVXWWxQVTZrUHBhZU40NmsyODQ2Y0VhSWVMWWhFbDJv?=
 =?utf-8?B?RE5xTUJZTkV6cmdRb2RPR28vdU5DazllMlVhVEJYL1FiVm9WUE5HMWd3YkxM?=
 =?utf-8?B?OWVOdk5XUm03bmd1ZGgvN0hGd1VLME8xcEJIUGRJOHBLNk4za2xIdFJha2hi?=
 =?utf-8?B?cXBFUGEzN01FWnJHSVRPYUw3QS9JbnVsZ2g0cHlRbUVjeUhmS0owMjJxY2tK?=
 =?utf-8?B?bTk5eWEvc0ZKZVZkbGordnBtakdiK1lBenlrMEtreWYyOTQyTWQ3cndrbDFi?=
 =?utf-8?B?d3pIWUZNMTM5d1RwTmwzT01vYUxaTHZLSkM0U1BvTXkzRE1Ld2tBaThZR3BV?=
 =?utf-8?B?bUdmZnB5MCsvbEJ0bS9GK05mM2w5MmN2V3U4SlM0dGZEcWhwSXhEVmdmZU51?=
 =?utf-8?B?NlliOXQ1WkFHcFF2Q3BFSFkrcTk4RGVaOVFtd0FvY2MydlRieDdPRENzenl5?=
 =?utf-8?B?dnVudGxzYkdaQUMzcVBZNW5WeTR6dVl6NXdORHhYdVFwbXIwUG8zOGJwUyt4?=
 =?utf-8?B?d3p1bkluV2NSaFpVOENVdDdTN01EM3BQeGJCVGhESk1zVy85YnBGbWtTRnFN?=
 =?utf-8?B?SURTVjlUY3pJcWE4K25YNVRESEZtUThCdCtUSGdqUE9DVUlRRWRkMWJ2VXBQ?=
 =?utf-8?B?ZVlzY2xYeUR5RWc2VUU4S1FPWTJBRitNdEszVi9jdlQ1UXM2ZVFEcHMxSVM1?=
 =?utf-8?B?aCs0aTdFTFRuWi9ObkJEdlFYVTZpamFIbkM1NnpnNHY0WGFUdlB0Zm0wZmpK?=
 =?utf-8?B?amFxVktMWGo3OXFZZjltQXZpbXcwajBqNmVtRGZ3MmVQV1RERWUwVVRjbng5?=
 =?utf-8?B?NU54V0hLSUx5MEdRSHhCZ3JIc1NKTXVlYUlHVnlGdzFSa0x5elRuNnRXVmRH?=
 =?utf-8?B?UjFsWW9JM1JFNkF1ZXc4cUVhbUZ1YlV0RVBoRndHNFk0SFJncXVTYlJSWHpH?=
 =?utf-8?B?NHkzR3FtOHNzeXdTOU5pTVJCL1UzanlXZUpqM3ExdXhKdFdBKzVXbmo0bmg4?=
 =?utf-8?B?YlhXM2N3S1pPbWxrRVRIMC81Y3R2MitNN0tTTGhRTmlxSEM4WG5Eei9uQkxY?=
 =?utf-8?B?ZG5jb3haYy9VbllBQ3pJdThJSSt2ZzdvRDNiZmdWUzBOOVpuMnZodGZldEFT?=
 =?utf-8?B?Z1A0cC9KSDdHQStad2psbHY5UXAyU0pMYTlweGhlcVZNVi9PS2pNcUJRYjNr?=
 =?utf-8?B?V1JQNTFXNU9pSTZKalo0T1Y5YmdMQUlhcjNXUlh6eGtPNEt1MjRyNDVOL1Nm?=
 =?utf-8?B?WEJjOXVaMVUyaHJzOHlXdXB4M1kyNStwcDJDZUlLSDl2MW5nVUYvZ09tTUJ3?=
 =?utf-8?B?NHRDSHlJbW0xWVlwV0ZTb3A0bkxaQmRYemFEM3hBNFowamg5SG1vTGpHQTI4?=
 =?utf-8?B?enY1c2Y4WTRQcENkQkI1alJnM28wQlBoVXVWdlpPOHFPTCtsWGVDWEVsN3JR?=
 =?utf-8?B?cis4OGRsR0JvQ0VFa1NtY3ZCS1BvUi8wa3pnZktPaHI0WjFCZ3ppMGwvYVJC?=
 =?utf-8?B?T3UyTU5kejZQbDI5ckwwVFN1VlM5cE9RZTdjS214MFoxcTRyRDV5dldxOVlP?=
 =?utf-8?B?a1ZwY0hsMFlramdyZnF6WHVyYjdSMFVSTFZ2NjUyeDFrRHRDZVdwdlVtUUdQ?=
 =?utf-8?B?RzRtRjBkRCs4U1RnRDVxZFNNVUl6S0t4WkNwVHo3blk0ZE1vQ1NKUnBhbThq?=
 =?utf-8?B?eTdNSlZqSTllOFdhMnNoUHB2YW03a2ZMUHlYTUxRVnhSMUJtSFZoZmcxNGJZ?=
 =?utf-8?B?OEQ2RFNWWGswSkw5MnlsTnd6aElQRzVUdCtkVGdGTVA0Vm11djByUjdXS2lI?=
 =?utf-8?B?U0RsdSs5clJFOHBFc25FSE51NWZRR3JDbStUNURWa09OQ3RPSWNZTFJBWHE1?=
 =?utf-8?B?Nm9mSFFjMDQvc0N3L3RRZTlZaXFleS9VQzc0Qlhvem02bW9FMXZBeU5KeVhy?=
 =?utf-8?B?RWtGbXFEeG9HMVdibDJQR1ZmcllNMVhteWsxOUdQVmxhTTJ6UG1hSG1LaWtp?=
 =?utf-8?B?cVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049ac471-15cb-462e-2215-08dd31918f38
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:12:20.0903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFkynjRvGY3LPdAmcfuJIq5iS/hoNM83gwArC+A8Up5T2HG7nw45DhEqYdDR/NUTJ1VhXTEC1IA7ShFPeFUoOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:12:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17527

On 10.01.25 17:00, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add context to the resizing error as it is was unclear why the
> encryption can not continue.
> 
> Also fix typo.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> Changes v2:
>  - do not skip the check in case of optional encryption
>  - add indication what failed to panic message
>  - fix typo
> 
>  .../initramfs-crypt-hook/files/local-top-complete             | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> index 95d0a5d..b8a2f18 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-top-complete
> @@ -82,14 +82,14 @@ reencrypt_existing_partition() {
>  EOF
>  		e2fsck -p -f "$1"
>  		if ! resize2fs "$1" "${reduced_size_in_kb}"; then
> -			panic "reencryption of filesystem $1 cannot continue!"
> +			panic "encryption of partition $1 cannot continue - resizing of the partition failed!"

reencrypt, encrypt - naming is a bit inconsistent, I suppose.
Technically, we are reencrypting, aren't we? Also, the partition flag is
called "reencrypt" as well.

Jan

>  		fi
>  		;;
>  	squashfs|swap|erofs|"")
>  		[ "$debug" = "y" ] && echo "skip disk resize as it is not supported or unnecessary for fstype: '$partition_fstype'"
>  		;;
>  	*)
> -		panic "cannot resize parition. unsupport fstype: $partition_fstype"
> +		panic "cannot resize partition. unsupport fstype: $partition_fstype"
>  		;;
>  	esac
>  	if [ -x /usr/sbin/cryptsetup-reencrypt ]; then


-- 
Siemens AG, Foundational Technologies
Linux Expert Center

