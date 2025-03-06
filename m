Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DD3C282D1
	for <webhook@archiver.kernel.org>; Thu,  6 Mar 2025 12:03:52 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.web10.11427.1741262628527134507
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Mar 2025 04:03:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XE3d7Wti;
 spf=pass (domain: siemens.com, ip: 52.101.70.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpKTh3PV6m5a9UOf3tMf6tSYVDhAEEE9wTHFfl55lLo/1c9vgEEUOMELze3Ocigc6g0vjCtJECqwpRAEgW7PYkEedH1o8Z6jP9208rN2pJmtTrtzKGS+M7/DWQgDaTlgPfSMacuf3sxU49TH9uFc9ocQ8mbL6m07juz8RPJJu92FTP/vINMr4QDos+JevnP7RoyPbyb3jUd1c7UWm17aUEIM/H5vxaUip5sukEBUJPDE5HQXQyWh30Nw0GZZCK8y54kS9X81mDQTqDEhLQMDYYm4X32n8wy5TQPTFQLZWe0J32riyIxTAXEeDS002hCT5aRgvelvMU/UMgtBboYWUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uF4KbPAOBS3LOu6xuVXQQJCnLK8F52PpyDKZ3OP3cwA=;
 b=QS4DgNLNHdMOMhlGemH8Q+TTWXH3HrgcJTb5SAMTnXy2kJZN07aHLXKrA+yrnkBfIH0xA4loF5cd0OhJENxDjxZGRvyGXBBW9kikeDD/xwaj4ibgdW0aRFfA0yHHAK0Pt0swDxU1r0/WhcqKLsDsULKNFijcbVpLT/CnemV92WDSNNpqrB7W+hn88YXfeoi00Lst0Q43qA65ygIbHgG0HsmR94ztUrFya0D4syXI9zabm4CAN5wTf+iwhdkClfnAcTP7NHy//ltncKgOzzCA2zshAKDTXk4xI6dU9IPdwO4Kj5vMlEqiesfai9i4QHXBF+MF+tFJosEdutBeegR17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uF4KbPAOBS3LOu6xuVXQQJCnLK8F52PpyDKZ3OP3cwA=;
 b=XE3d7WtiBpkggn2fmiIjGpBLv5D2+Fbv4tQlgJMspqx4kpSulCcqk+Y/DNMu7toWOXtQhMkBOsn19xOyoRK59a2L1QWEmC1WbUo74nJb8MDQr/67GJRZQCCH+kSgpD92xhESMxmvu4gcl6jrGA9+7OqA6aLyKdbSS+vZsmjE/3kjTaugN8q4VLFKZEWm2exp+ZrFfq55N4niSEZHdG+UNwDDIAhE7qexgdtTUQlkmF81OMKiZcX20X+hTl7fqJwJB72m6v15hIaWJhljyrWTBf8NGPzPRmE81/PXkKTW8Rgi9BVVlpT//RbUalNQVI9tzPDrpxus7t63o6Puf3HLBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:327::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 12:03:45 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8511.015; Thu, 6 Mar 2025
 12:03:43 +0000
Message-ID: <c610bd35-3b7d-48ab-a5c0-1f7e89f18b3a@siemens.com>
Date: Thu, 6 Mar 2025 13:03:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] initramfs-crypt-hook: make sure that mount path
 exists
To: Claudius Heine <ch@denx.de>, cip-dev@lists.cip-project.org
Cc: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <20250305-initramfs-crypt-hook-patches-2-v4-0-4170912e5261@denx.de>
 <20250305-initramfs-crypt-hook-patches-2-v4-1-4170912e5261@denx.de>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250305-initramfs-crypt-hook-patches-2-v4-1-4170912e5261@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0145.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5140:EE_
X-MS-Office365-Filtering-Correlation-Id: 39392971-2b75-4e0c-37d8-08dd5ca6f0dc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?WnltQTg5VVNrRFVLeUdmSVNFR213bDlVL0VXNVNRd3E2Zk96ZU94UnpUUG05?=
 =?utf-8?B?bHpScWJINFczVDdHRVVWSlhvWkR0SFNNdG14MHFtN0xXY016K2lqTWt1c0Zq?=
 =?utf-8?B?bVg0NkpmMXRLd2ptL1lzSm4zc2xtRGUrK2tRc2ZxcHpub3VsM2l1ZWtNQXpL?=
 =?utf-8?B?a1lqeTFDVExWMTdsNTNDRWp0T3U2WmQzWTArV0x6OUduUjY0ZFhBWlZ5dnB6?=
 =?utf-8?B?STByT3FJUnFvZVBTNGQ0QkNyRldpK250K1N3a2I1anlPZ3hOY0JtcU13RE9F?=
 =?utf-8?B?MzlEQTI4VkI0Rkc0N0pDQ3N5WnNzQTdraTI2cDJFQ284V3QyMGZWTVhpRHNU?=
 =?utf-8?B?TEk1V2RUYXRGaVNPRWRSeTA1eHNlTHh3MzFGN1UrSEV0d0kxM0ZKRDZ5WlZy?=
 =?utf-8?B?Z21ZMkJabmtLK08wZ0UySzlic0NrU2lOdWhjRHA2VVNuVlozYk9hVlRucXZk?=
 =?utf-8?B?amVUNTBYMkNObmQ0Q3l1OE9TQ1F5cUxHY3BoNmFQZ0NQSTZhekQ2M2NXVTlI?=
 =?utf-8?B?TlRtRDBwSk8zR0RGVHpkU2s4ZzVRWEJrdzlDaGZxWVRkOSsvWW44V01NQXBt?=
 =?utf-8?B?QWlxTkQ2ZkdaSFFkd0ZXcnVDbFUydXl6ditUbXFMNVdHY0QvdkhsU2tRTnkw?=
 =?utf-8?B?a0c2V2VzR0NXSG1iTDZxWS9DUEdBUmdmdXA4Y2I1dnNhUitYM0VvM0xqREhF?=
 =?utf-8?B?Tm50eGJuby9QQ3puL0hVazVuY0IxK3FsUEtLaWsvck8ycGZ4RGMwazhrRFU1?=
 =?utf-8?B?bHNtSUM1YW1Td1dTUGtLZUkrUm9KamVTckhCL2taWGkyRG1kZEpVekNUbjFK?=
 =?utf-8?B?WktBUFpOelFqNEFqZlQxcDFDTTFFckhNQ1FmSm41M2hwS1YvSzE4WExjUVRm?=
 =?utf-8?B?aWFEa0dHYm40RWw1UjhyLzZHRWpJK2hucnZIYVNYWjhLUVcvR0ZDRzQxS2Zk?=
 =?utf-8?B?bVNacU1STmZnNmdSQXJ4U2tyeUY0UmxmSzgyZG53SGgvTEhMQldRTmMyYWVJ?=
 =?utf-8?B?NFk3aXVwd09lUXBNcVNONDg2MjNQYWNsMUsxbFhrcHNkWVV5clZYblhnM2gw?=
 =?utf-8?B?NlF3Q3pCbUNWaFdVM2s4VVUxOUxGbGdISG8xelVoUHY0LzM5cHo2ODE0VTFM?=
 =?utf-8?B?NDNIcHBHbmFEcnJpdjJpTEZERFFZWktpeWZiOFlRUmFVN09zSVNZSmR1UW1v?=
 =?utf-8?B?MDlHTFFoZkl1cGk2T0ZWNldMdThyYmVqNHpjVVpZZ1loaFBvL0JzUXRyV0Yy?=
 =?utf-8?B?NmZmNTYxMVlKNmZIYzJ1RUg0VXl6blhkQldTUThOMy9XQUJaaVNQYlByUVpO?=
 =?utf-8?B?aXJvdXZ6c0NubjJBdzZvKzBLK3FJTzNwMkZwWUZTUDhQcjhUMW5vKzVGeUpC?=
 =?utf-8?B?aHZCRldJQVZrK2VlMUxOaVEyQ3QyTVlNdjZFeTFpem5CbThPcklFZUJpRjY2?=
 =?utf-8?B?TkJVQVlZQ3JzR1BpOHFxRFJIdSsxc0tPZnE3Z0pjNXB3dE9MWEF4RnpxcUtx?=
 =?utf-8?B?OFEvM01KbGE4SjdPTm5oMmR3YmcyNUM3VU11SXovcnNiYlB4MjZFNHF4S1FK?=
 =?utf-8?B?VWRaRFpOQnQ1VlQxcHppSFNodWFpRU1DNkhaWngrWHp1d0ZGTjZUb0Ztb2dO?=
 =?utf-8?B?MkoveEdGbnFCRmdJMm1QRkQwZnIzNStZOFNUMW8wOGtzZFlTWXlHZktCWG0y?=
 =?utf-8?B?cWU1Mk11WXhycWFsN0thR1dsb2pzbE9ocGZVdnZaMGxhd1cvNzkzRFRkWGpP?=
 =?utf-8?B?NjBSV2R3NEFZZjB0V2Ixd28wUUdNTHdGc3dDc1dnRm05b1FlNDFrWTRKbG45?=
 =?utf-8?B?WTBXQlhsQzkzYzlOaE9VbGQzQkpZY3k0dkFoS2Y1ZDEwQWdvelRPTGpoVm9a?=
 =?utf-8?Q?uEyUsBwSbYT8h?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cGhoTzFBVjYxaHFHUDFJYXpqSHQxRTNDLzdaNmtWWVBSQWhZSnVyOXI2SUZj?=
 =?utf-8?B?SUwxQkhaTTNXTWU0Q0JWdXlQTERDZ2hUdlByQ25IdGJLUFNvTDh0aVFFZTA3?=
 =?utf-8?B?K3N1QW1YYmRDUjBCRlFDc1VlSDcyOXZSbTJXdjNiK2Q1aUdxR0x2UmMwK2NN?=
 =?utf-8?B?d3NBOFRiZUd0bDNNTWlNc1JlYTZnQWw1dnNqM1dKL2dEMDhmTXJBOE45cHd3?=
 =?utf-8?B?VEVDbnNieXZCNFhkVXZ5SFlsOVZQV0NsbnN1UUJzNXRLWGlsRU83NDFlTjU5?=
 =?utf-8?B?eThubUhNTTlrRzJUUnV0akxWTXNaYkNYN1lOTkgxZWlIaU50WmxveVA2NWJP?=
 =?utf-8?B?KzNRRnRZMDRLTWhDQXEvdlE5OEdSeXNzY0FWYUJ2UllkaGdSNm9FZEhuZ0lm?=
 =?utf-8?B?ZWlWaEZEMnJPVlZRSWovOFdtcENIdVU5blM4WmRMYldVbW0wbVhkUTJBakU1?=
 =?utf-8?B?Qm1MTnFDV1B6ZFpBSmh1elluNTZFOW1DYlRFOUpOME4wd01mc2VCcFRnS2ZZ?=
 =?utf-8?B?dVZJYU1mdFQ5cE1lMlFXS0Mrd1ZvNjRJbk9KaWgvOVVuWnI1MGNMWGJYZSts?=
 =?utf-8?B?cVpIL0NMQXVwc21RbTRJL0krQ2hOTzlDZjFVTEh3b1JwekhsTnEzQXpvOVo2?=
 =?utf-8?B?bXQxWHR4eVBTQS8vcVVkeGt2UmdxczltQjhVMUxWQ0xnYldjSjVnQ0hkMDVP?=
 =?utf-8?B?a0RuYUs2M28zVDI0cE9yOFA2YzEzdlNhRUpGMW5CUVJSeFdVbWVkQ1l4OVJ4?=
 =?utf-8?B?WnRtelNERTFrU3kxd2FHelFITHlKYjBLZDVvbGRYSnBhR2laU1Zxd2c1ODEv?=
 =?utf-8?B?YnVkQVhXTzJrTGNtTG14UThWNlR1OGQ2ZWhXZmFNWVpRekJndTlXZmx5RXQ4?=
 =?utf-8?B?Y08rdzRKaU04MWdPVm5GSStxSWNXYWN2V1prdEJla2JZakJkUU5kRFFjL3N0?=
 =?utf-8?B?NHpnME5TOE1SSzZZQmZxQUJ2cHAxdVArZUx1TTV4UjNMaEJwODl0WHptRlNs?=
 =?utf-8?B?Z3QzM0JYK3o4aTc2eHo4cldFdDZjUitBY2I3b3JvbDdWRkt4cE9mYnFLZDN4?=
 =?utf-8?B?b3Y5aEk0NFQrTGdYQXg2eUkrVTI0bzJDZUwrQ21vcFJ1ZEFSTy9FZXlpaFE4?=
 =?utf-8?B?NWNxcTZsYTNDZHBYU1U3TnFFcUlPUXZ0eHVwNFRyMTQ1aEFRRkoycGVaM2dM?=
 =?utf-8?B?REJsdCtrVlR2ei9FZk5DaUtNOHVXM3o1cVI0b3c2SDkwK0pCUE5uYzlHb1hH?=
 =?utf-8?B?ajlFVlVyck1nekh2YStEcUswalBkcERodjhsbVg5RStlVE8wd3pKMzFReXdj?=
 =?utf-8?B?NVlmZVFkZ0N5ZzFMRXEvUHVLcXlVZThVQWZ2MFcwVnZZaC9TMldVT1Fza0sr?=
 =?utf-8?B?TmVSanFkOWJKdHQvblJRaUZzQmR5SEFPS1M3Tnl0V0JUOG5tblFueFZKd2xE?=
 =?utf-8?B?NnpXM3A2a1E0TW9SZzRQU2dGcmxXR3NPK3hKd3RqYnMyVzluR2lBcDVRdVBE?=
 =?utf-8?B?a3RzTVlLQXVkQ0xEcG5kNmQvU0VpRW9VdXNQeUh4WEh6NjhkNElaYnZXZkw3?=
 =?utf-8?B?UVh5cy85QjNoRi9yTjMvSjNBVU10Q2p1eTNTMTRPOFVBUWhLeEN3QzZqdXFT?=
 =?utf-8?B?ODBQQUdBVzJNby85Y3h6ZXhBMVJON3JNYUprR2l5eHZsRk1FNEc2RU42Mnpr?=
 =?utf-8?B?SW5lMzViU29PWVZqQXVReER5amoyZXVtNjg5cmpjRmpobkhQSXo2ZDUxTFRD?=
 =?utf-8?B?MzZIeHJwR1czREc5a1llTG1xNzBGRXFHdUF1TndHOHNqZGduWElYb1JEYmQ2?=
 =?utf-8?B?OHFYQjVVOC9iQkRDZEduMGRhNnBqdWcyMmtoVnVYVXluQS9CRHEwTkdUVVNN?=
 =?utf-8?B?KzdVTnJYTm5VQlZaWU14OGY5bU5IU1NxdFIzSDFzRzJXL05zYzA0UE9qNmZP?=
 =?utf-8?B?UWhnaGF6U3UzZUd4T0JwbC85dUkvYVRWRTNuYVJLSTkvSldGa2pKbHkvNFgx?=
 =?utf-8?B?UDlWTkNnbktzTzczb3BJSGhGNkgrM2N2bDlKa3kvN0EzUm16NU5GbHA5Tkdi?=
 =?utf-8?B?Uy9sbEExUUtBSTNDL1RyN0E4QU4vb0cyb2RoQjFFeTBxbTBzSUFuMTlPMHBM?=
 =?utf-8?B?OGQ5QTMrMGxiMEpsMVkxSUpaNC9hS3FZV09SYjBCZmlDcEYvS1hzNWs1aW5v?=
 =?utf-8?B?bHc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39392971-2b75-4e0c-37d8-08dd5ca6f0dc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 12:03:43.3987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G87eXg61cmBzy6Maqjri0UnjSrNguD0WUHL0Xaj4mM4hedamY9lERudkd+ey5Z35tgzAS5bz5pKlmKhrh2xysw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Mar 2025 12:03:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18057

On 05.03.25 13:00, Claudius Heine wrote:
> Wherever or not the mount directory (and their parents) gets created
> seem to be inconsistent; mentioning a missing mount point in the
> `/etc/fstab` might cause the boot to fail, while using systemd `.mount`
> units will just create the mount point.
> 
> Wic creates missing mount points that where mentioned in the `.wks`
> file; so moving from such a setup to letting `initramfs-crypt-hook`
> mount the file system at boot inside the ramdisk, the mount would
> suddenly fail.
> 
> Therefore creating the mount point for your, if it doesn't exists seem to
> provide a smoother transition.
> 
> Signed-off-by: Claudius Heine <ch@denx.de>
> ---
>  recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> index b991cb49fbdfdc4b2ffc81c1424fb3c695a973cd..80553d1cd8ccde7a6cc9b324c6e5faba8d8f3579 100644
> --- a/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> +++ b/recipes-initramfs/initramfs-crypt-hook/files/local-bottom-complete
> @@ -41,6 +41,7 @@ mount_partition() {
>  	partition_mountpoint=$2
>  	[ "$debug" = "y" ] && echo "mount device: '$partition_dev_path' to '$partition_mountpoint'"
>  	if ! mountpoint -q "${partition_mountpoint}"; then
> +		mkdir -p "${partition_mountpoint}"
>  		if ! mount -t "$(get_fstype "${partition_dev_path}")" "${partition_dev_path}" \
>  			 "${partition_mountpoint}"; then
>  			panic "Can't mount partition '${partition_dev_path}'!"
> 

Merging this one already.

Thanks,
Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

