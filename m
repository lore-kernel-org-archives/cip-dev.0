Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5AF6C021A9
	for <webhook@archiver.kernel.org>; Tue, 18 Feb 2025 08:39:19 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.62])
 by mx.groups.io with SMTP id smtpd.web11.15334.1739867952389209751
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Feb 2025 00:39:13 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MxGSSlHu;
 spf=pass (domain: siemens.com, ip: 40.107.22.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5w9r7X9hP5uvTFdJkInuha+EUOOuc2FLyICWgBPCiBgmSP4c3tQXWf3tv5ly1sG6S6RDwU4/omnS3WlM+iy8R7b5bxVXXJIPhaoEvorER6xie06tzwngtPDg4uIQsDZlTmHPNe8sgANdRD5Dz3EPsNAEl1kzXdnhteE1pt6sKaNrMfNoPVy4tZ9oYeGQ7v3SOdRmrzsEhfEedaBcLnjcM2fWpkeqw2VKXstEYyMsiN+d4Zslo5/OKHtQpkgYHCeE/HNjd9mJwHlpCuUqlRG3v5MfZEayVKATe8tNyrliQmDE7MJgY1YSdqfXyo1HR4A2RrhLiGdyiG0XGqJxcmaDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGpg5LzgqQZp0r8usoYcLmETukgb3SZRF+h8EB/uo1M=;
 b=yc0PI9ysZMGsw5znCpBgicXiZ92rm8rRjMGwDMknezJ0/UYvMBp2Ygefs8QEi18O5N8AXz4sp6Zb8o9Rh9BmXgEY9CDTFgrt0tMA3Ws2QhhnwTwzC+kvPlJ3iEDMnIghA2eo9jYskaTVjZWr7gCCxgkXj1sYpdtkIeaAvmVXaQfooSYgg6zSqoQWQf4oJnAEjDRWiXJAxsSr6mxCpk4mEQzWWTI9+tbgXVfRhSNCgZq/mpxAqB+8BGa4q3ZFkwSGzxV5GBCWdnntM+ikVnrBySsVcFNg4V2T02aGdwgmrF/fzp9BzUx14evie5Abxl1ZpQQue8yd6yh3l1LN3esMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGpg5LzgqQZp0r8usoYcLmETukgb3SZRF+h8EB/uo1M=;
 b=MxGSSlHuLr+3V8MJanMax90x0g9CkVA/HlFLFt5CAtDDMB6HhLdnVW2JiTj776Uuu2wacubyLnQ/N/Ur5s2PjTPgT5C/ReE2GRi1IUgKTP+z2fHYdoqv13osHJjeCnGDhraSl6A/KL4++JWjbDVyYewTpxLexk3THWQ8FoEAaDA6XTY/7RrGTiQj+X4RZrlTNt5BPI6AXuz38q8ybn3V1e78ctK1oFMVDCKV+ol5GH9B2WsD44mjd5VR+cFPXHcW0IKfgc7JjHpi4arUvdSrgVlFvL6oiB1t3KDtR9HXQ0P9dRqYrgWVe7N5MBO1kntLf4NX3iikbsq2x9uxRyEsxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DU0PR10MB6059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.12; Tue, 18 Feb
 2025 08:39:08 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%5]) with mapi id 15.20.8466.009; Tue, 18 Feb 2025
 08:39:08 +0000
Message-ID: <715da9f1-ec6d-4a90-9d32-674d7fea0d86@siemens.com>
Date: Tue, 18 Feb 2025 09:39:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 3/3] Added support for rootfs-overlay.
To: alexander.heinisch@siemens.com, cip-dev@lists.cip-project.org
Cc: jan.kiszka@siemens.com
References: <20250217100024.42995-1-alexander.heinisch@siemens.com>
 <20250217100024.42995-4-alexander.heinisch@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250217100024.42995-4-alexander.heinisch@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR14CA0054.namprd14.prod.outlook.com
 (2603:10b6:610:56::34) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DU0PR10MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a9cceb-e1f6-4347-08a5-08dd4ff7b603
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?blRiY2FkZWxTMTFuUTZuWTJzYW5EMEd4bDlQYjF2dzhtQURLZW02NVFQZnBP?=
 =?utf-8?B?NzE5cGFLbE9TcTJIYjdFbzE2S24rSTlRMDA2eDhjWGVEbE5iZllUNWhKTURP?=
 =?utf-8?B?TjhoelIwb1FYajJON2JWM3ErZlAraHpFaU55ZzFveXFWUVhwWGo2QVMxbUU1?=
 =?utf-8?B?Q2dpbFVBQ0NHRDM0L0paQ2s0Q2JkbW5GbzhZZFVNSEl2d1JGYmo3VG5ZbHhs?=
 =?utf-8?B?UGkvRWlqblJubzRUa2hNaUY3OG1KQWZFNUErZUxyTVk3Nm14MldMbVRtaEw2?=
 =?utf-8?B?ZWQyQnJtaEZSWTY4QWtJbThKU1JvRndLOFlKWW9ITWpIcmhwRk1hZEljaXd0?=
 =?utf-8?B?dTFGYk55Y1RGZkFsNUdJMU9mTzh2QnRmRm0vNGdNNmNGVXorVGYrL3kvUlhl?=
 =?utf-8?B?WlovWm5hRmFwVVgzbHRmNEt4ZzkwcXUzOHdaOThZcFcyK0JYR3I3U2dTVTdM?=
 =?utf-8?B?K3F5dFA5dEE1YkgvYUVBSEhQcmZHTVpXenJScHdtQ2tKSjZRTEFGekNIVWFJ?=
 =?utf-8?B?M0ExbkRiMkpzMmh4ejlTaWt5NDhqV1F1Wkd3T0dvWUdOdEpJNUJHR1ZSZTdB?=
 =?utf-8?B?Ymx6ZmVtWGEyZ1l2RXVQZG1rRVZqYk00ZVBaanFVQWJRa2JZSXE3bk9hZnEy?=
 =?utf-8?B?bVdmOFZFMjdUMHBFaC9qc2ordlZsNFpMbjVYTndCNWJmL2JrZnhFVDUrSU5v?=
 =?utf-8?B?NHFBSFRQOW92ZkxQZDk1L0Qwbmx5QkV2ODFVRnR5Kzg0RS9sZkdCRUNNWlJ1?=
 =?utf-8?B?WWxkRG9RQjVLdFM2ek9ab3ZmSERGUnNFa3FnT3l2R252ZC9TYmRsMDlJaEpZ?=
 =?utf-8?B?bmxLL2t0ZEtKU2FGRXlzNFMxSlkrekdNRTl5b0VEYXJEay91NmxNV3duTDc1?=
 =?utf-8?B?UW1QVGZHUUtpcGMxRElwMW1zSTVPQkpqU0lSRHozTnlvQ1hua05vdWtvcHIz?=
 =?utf-8?B?SVl2Z0YzWkowa0djOHc0ZUM1OGU5YVJyNlRvSnZqcVRCMmVYeVhRMlZpNzJv?=
 =?utf-8?B?TUx6UXNDZHR5d2xkRDdEeXlyc1pTUjVkQlA2VXdHNmhNL1hLMXZXYjhHRTEz?=
 =?utf-8?B?NVV0NytYWVlWZjFUVWNWQ2VDdnE2dE1ja1R1a1R1STZrYWlIMFQrc21XUlBl?=
 =?utf-8?B?akFQL0F5TXZPU1hNL3d4czBaQVZiMUpqRE45UTBqUDMwWVkrd2pqTGVxdTNK?=
 =?utf-8?B?UlNZbmI1UmhWS1J5TGZGNlRITnZPbzlUY2Qva3dNSkhkcjdKbE5tVGxCZnJF?=
 =?utf-8?B?Qi9IQktBeXlZa1ZZMDY2UWNtOGFZaEdhOHdReEZhajA2KzhobHloNDR5ZnU4?=
 =?utf-8?B?L3VSZHpTdzllUkJvbEpCN09OcEpNc1pobEpqazJKL2pBVmJJcmFRUkJ2UjJy?=
 =?utf-8?B?V2xSSng0TUVBTG9vR3FuZGVZckowYW40d0xnNWNaY2N3R2laR0lSWm9UMEVC?=
 =?utf-8?B?ZEc4SzBlVlF0S2VSL0RkWjd1VjlUU2VwUHljWWYxRDk3MVY1TWFkZ3kxNVp5?=
 =?utf-8?B?WGYxV0FyRVJiRXZFNUtnUXJWR3JUM0ZhRzhSYklUOVVtakcybllNSG5xRWdz?=
 =?utf-8?B?M3NmdEFLKy9TUXcrbitvS2ZPcWQvcTRJaHpHSFBWSHFocWtmNmcxU2NySlZH?=
 =?utf-8?B?RXFOVkxUVTVoQ1dENEp1RGJ5ckVpZ3V5SlFLY1BVNDBsUzBOTkZOVGRTRXJE?=
 =?utf-8?B?b0dqZFpiSFJTc3F0SmdEeVRNQ0twdC9kSzhKQ0MzNVUreXp2dFBsbGIzY2Va?=
 =?utf-8?B?Lzlmckdva2VRY3liWi9TbXhuQ2ZUeWVOQXkvMytsd0JpNTBWVGZBSk5LSzYy?=
 =?utf-8?B?djN1VDhaKzFuQ2lYRmJESWpTbEJGSk9OYXc1NDRTdUNVeGxNcXc3TEtIeUFQ?=
 =?utf-8?Q?vxWms6vPjqtB4?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SS81dlVHNG5lZ0w3Ukdxd0x5Umw1Qmw5TUNGKzN3UTFUUjYvZ2V3RjM0R2dp?=
 =?utf-8?B?cElPVlhEQ1U5VlNmQzNXSkRhN0dldER5SGUrbTcyazFkSmlaRUwxVll6M0lU?=
 =?utf-8?B?RWtqNFY4dkgxbDBIYStSZUwwWUFkcG0zK2p6Yi9TaGxpQnpIbHpEMm5qNlNZ?=
 =?utf-8?B?Sk8rcWY3RktaVTdxM0lUODNxV0IzUHdzNldNaWtxbDRFNlVJZ3lpU0lkRUxy?=
 =?utf-8?B?TnhFWE5ERUJ1aEdqcXBYSlVBd1c2TUFrbCt1YU0zNFMwVndNL1RmdFBjZmRr?=
 =?utf-8?B?eXEvVFRuekc2cUVSVllDUWRGN0NSdWxJL3lmQ2dKdTU5WXZhUnlSS2Y3Z1Ar?=
 =?utf-8?B?VDV4OGxjak8xOXhtbmp6ZUZ3TkRndE0zMWowampxSWhlbWtpYlcreXBRcU94?=
 =?utf-8?B?NVFPMS9hd1lwcXdONDcxdDA4Qm1qWlhMUVk4QkZUdlpveC9xdzlHblpkT3R3?=
 =?utf-8?B?WXBMYTZZWkNDVXpzRnNQbk5MRkdHeEpZR1JFelNYUGRhWCtvZk8xMFdGQkY5?=
 =?utf-8?B?WmNsQzlOS3NlaVJsSUVkUXNTTytnMCtiTzZSU1A4NmZLWW5qcDltZTNrMTdU?=
 =?utf-8?B?TGpjWmZmZEw5aGxkZ0wvdmdMb2srQTJPdUZlRFM4U040bFNPb1JSenc4Z2pJ?=
 =?utf-8?B?L1d2UUdHNXJWcnFUM2lyZXkvd3R5a0VSUndYOFN4K2hIaHkzMHJGaUdUSnJV?=
 =?utf-8?B?ODEvOTFRdFB6MWFKNGdLTmE3a2ZPZW85dUtNRWJTUzBjR1gxeGtBMjBNdWh0?=
 =?utf-8?B?MGVVZWhid2JQUEhQdGdsU2tLTFY0a09qMkNqSVRFV1ZpcVN3SWFnRWhlRVhw?=
 =?utf-8?B?UmNxMHdlM2FLdW9ZSFNsTFJQR0VhS1VrNEJhZVNRb3NmNEhJRU5tL3NJSU5C?=
 =?utf-8?B?TkJ4bjFLV0V5THdaYVlnQmtjZHBtV2dvc0hOUzh1b2tjVzF3Tzc5cFZVL0ZQ?=
 =?utf-8?B?dGJSQlJiemRPOFN2MklkajdFc05TMk9PTGxnSjdBeWkvck5qQUloc094UE9q?=
 =?utf-8?B?UUxvTk0wSExqUi9JcWgwVUJWaHpnUGZXcUQydW5MdGJ5ckpROEtNNEZZZFlG?=
 =?utf-8?B?K0FCeUVuMFFzUUhJd2VUcURMSWo0SndzZFEyNmk3SWhBNUNLeVkxWTZXaS9h?=
 =?utf-8?B?ekVOMmNkeEdzMEhBYnhVUXE1Zzk2UysxSy9rVWJ5UjNoOUZDZ2NYY0hka0Fm?=
 =?utf-8?B?VWl1VGVYMElWaE9DdWRWeTlLRVFoZ0JWWW1xQ2hqWm1aVzJEbi9iQXhkem9W?=
 =?utf-8?B?WEYrMHZLWnlSd3NVOGpNYWJOTU12ZjN0QUJSZ1A4NFg0eWNsVDJLeWxrVHM1?=
 =?utf-8?B?d3RuMTgvRnFBN3JhTysyQ0RsZEJOVERyN3dPR252ZUZuVmY0dXhobmRZLytt?=
 =?utf-8?B?TUpqckNlSHJRK1NHT1FGNnUwNXJpRE5aelREZ0JiT3M2aFVXUy9zNDNyajNZ?=
 =?utf-8?B?WXREZlJrZnFDcnpmSGNPU0xvNGU0N29hT2FPcWRnWEkrVTJ3RW5XS0FPaTZY?=
 =?utf-8?B?Z2VNZ2pnR3lHYm5RaFJOWjdXc211dVh4Yzh5ekFMRXFaQUxuVUx3NW1raEQ3?=
 =?utf-8?B?R2toTjM5bFluUHd4QVdOeVROZWNOVVAxTmpqZkRBTjlkV1kvRktLMDk1YUNW?=
 =?utf-8?B?VFYyaEMrN3RNSE45TGpDZGdNYzh0M0NabVlMYlN6MmxBWFlCdFBKdFVSbjVV?=
 =?utf-8?B?QXlJZHRVN21ydjA5S0dMTjQ0RjluLytwSnJOQmF3NHAvcllsY1RRMnNzUXJL?=
 =?utf-8?B?SE80enl6MDZlYktKZTM0RWxISWRnR3hrdXFHbGpCM0dMQTd3SjBYQVlOZkVo?=
 =?utf-8?B?YXh5LzlzWmpPbEVja1VHT2RCMkR5bjBzeVRVQm1FT1R0Z1FGeE5rbk9Obkpz?=
 =?utf-8?B?V1h2Y2dPZERpOFFTVG5ZVWdHVDhWZlNhQ2Nhb0NRZVU0a3F4QjFFcGpMTnpl?=
 =?utf-8?B?c0hMUHlaS01EZ2VVWllpVW4rTXZwbXdVWVlVbkVTSVBxcFVIVmhPVFJudHlG?=
 =?utf-8?B?cThmV0doTkFLR0NkdnNoMFVxcTRITmZES0YwU2poaFFzV3ZyVlFGN3BNdjM5?=
 =?utf-8?B?OHo0VUtQWHY4N3o3Q21oOXBZTVcvVktYWEZhVVhFVlNsYnFleTZ0bno5dzFD?=
 =?utf-8?B?SDRabzRwOTdZZWRmemwzd1AxNld0WGowSnpMSUhwWlRXZCtSekpFVDYzZUNE?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a9cceb-e1f6-4347-08a5-08dd4ff7b603
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 08:39:08.7654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BucyYsQHttLAphOyxTLf0WaKHN1FL4OULoNim6C3amfeDZl2huFQvjyEnXbIZeuY21jXoYsJ13Uev+YOJKmP242E+Fj+c6z2rNPUXHq59DM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6059
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Feb 2025 08:39:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17859



On 2/17/25 11:00, alexander.heinisch@siemens.com wrote:
> From: Alexander Heinisch <alexander.heinisch@siemens.com>
> 
> In addition to the overlays for e.g. /etc we now support persistent
> overlays for rootfs as well.
> To enable this behaviour you can either set INITRAMFS_OVERLAY_PATHS = "/"
> or extend your existing config INITRAMFS_OVERLAY_PATHS = "/ /etc"
> 

I would like to avoid that anti pattern of creating an overlay over the 
complete rootfs. What are the debug case you need a full overlay?

Quirin

> This helps when developing or debugging an existing image, while
> still maintaining being as close to the prod image as possible.
> That way all image features like swupdate / verity / aso. remain
> intact with the sole exeception of having the possibility to
> work on a rw rootfs.
> Bare in mind while this comes in handy for debugging or developing
> new features, such feature has to be used with care. e.g. when
> updating the rootfs, overwritten files from the overlay could
> potentially cause unexpected results!
> 
> Compared to typical overlays we have to move the storage device used
> for persistence off the previous rootfs. Otherwise, the recursion in
> the overlay setup would cause panics when finally switching root.
> In addition to that we move all mountpoints setup prior to overlaying
> to the new overlayed root.
> 
> Signed-off-by: Alexander Heinisch <alexander.heinisch@siemens.com>
> ---
>   .../files/local-bottom.tmpl                   | 92 +++++++++++++++++--
>   .../initramfs-overlay-hook_0.3.bb             |  2 +-
>   2 files changed, 83 insertions(+), 11 deletions(-)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> index 71cc63c..a17e4a4 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> +++ b/recipes-initramfs/initramfs-overlay-hook/files/local-bottom.tmpl
> @@ -6,14 +6,19 @@
>   # Authors:
>   #  Jan Kiszka <jan.kiszka@siemens.com>
>   #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#  Alexander Heinisch <alexander.heinisch@siemens.com>
>   #
>   
>   ovl_storage_path="${INITRAMFS_OVERLAY_STORAGE_PATH}"
>   ovl_lower_dirs="${INITRAMFS_OVERLAY_PATHS}"
>   
> -root_mount_storage=${rootmnt}${ovl_storage_path}
> +root_mount_storage=${ovl_storage_path}
>   storage_mount_point="$(echo "${ovl_storage_path}" | awk -F/ '{print FS$2}' )"
>   
> +# Setup mountpoint for persistent storage
> +# Either, it already got setup by a previous initramfs script,
> +# then we have to move it from $rootmnt to $storage_mount_point or it has not
> +# been setup yet, then check it and mount it under $storage_mount_point
>   if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>   	ovl_partition_device="${INITRAMFS_OVERLAY_STORAGE_DEVICE}"
>   	ovl_mount_option="${INITRAMFS_OVERLAY_MOUNT_OPTION}"
> @@ -21,6 +26,8 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>   
>   	partition_fstype=$(get_fstype "${ovl_partition_device}")
>   
> +	# FS checks should be moved to a separate hook / or at least initramfs lib
> +	# so generic functionality can be reused here!
>   	case $partition_fstype in
>   	ext*)
>   		fsck_ret=0
> @@ -33,32 +40,97 @@ if ! mountpoint -q "${rootmnt}${storage_mount_point}"; then
>   		fi
>   		;;
>   	esac
> +
> +	# Mount overlay device to initramfs - will be moved to rootfs at the end
> +	[ "$debug" = "y" ] && echo "Mount overlay device to initramfs - will be moved to rootfs at the end"
>   	if ! mount -t ${partition_fstype} \
>   		 -o ${ovl_mount_option} \
>   		 ${ovl_partition_device} \
> -		 ${rootmnt}${storage_mount_point}; then
> +		 ${storage_mount_point}; then
>   		panic "Can't mount ${storage_mount_point} partition - overlay will not work!"
>   	fi
> +else
> +	# If the storage device is already mounted on the final rootfs
> +	# move it to the initramfs. Otherwise, we cannot move back the
> +	# storage mount to the resulting rootfs in the end.
> +
> +	[ "$debug" = "y" ] && echo "Move ${rootmnt}${storage_mount_point} to ${storage_mount_point}"
> +	mount -n -o move ${rootmnt}${storage_mount_point} ${storage_mount_point}
>   fi
>   
> +[ "$debug" = "y" ] && echo "Iterate overlay mount spec..."
> +
>   for ovl_lower_dir in ${ovl_lower_dirs}; do
> -	# remove the first '/' and replace all '/' with '_'
> -	# on variable $ovl_lower_dir
> -	work_dir_name=$(awk -v var=$ovl_lower_dir \
> -		'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
> +	root_moved=false
> +
> +	if [ $ovl_lower_dir != "/" ]; then
> +		log_begin_msg "Mounting overlay $ovl_lower_dir"
> +
> +		# remove the first '/' and replace all '/' with '_'
> +		# on variable $ovl_lower_dir
> +		work_dir_name=$(awk -v var=$ovl_lower_dir \
> +			'BEGIN{subvar=substr(var,2);gsub("/","_",subvar);print subvar}')
> +
> +		lower_dir=${rootmnt}${ovl_lower_dir}
> +		upper_dir=${root_mount_storage}${ovl_lower_dir}
> +		work_dir=${root_mount_storage}/.${work_dir_name}-atomic
> +		mount_dir=${lower_dir}
> +	else
> +		log_begin_msg "Mounting root overlay"
> +
> +		# When overlaying root we need to move the mountpoint
> +		# from ${rootmnt} to a dedicated mountpoint inside
> +		# the storage dir to prevent a "recursion" within
> +		# ${lowerdir} and the final mountpoint of the overlay: ${rootmnt}
> +		# While this is not a limitation of overlay itself
> +		# such "recursion" leaves the mountpoint for lower-dir (the ro-rootfs)
> +		# outside the tree of new root which panics when switching root
> +
> +		# create lower dir to move ro-rootfs to
> +		lower_dir=${root_mount_storage}/lower-root
> +		mkdir -p ${lower_dir}
> +
> +		# make the readonly root available
> +		mount -n -o move ${rootmnt} ${lower_dir}
> +		root_moved=true
>   
> -	lower_dir=${rootmnt}${ovl_lower_dir}
> -	upper_dir=${root_mount_storage}${ovl_lower_dir}
> -	work_dir=${root_mount_storage}/.${work_dir_name}-atomic
> +		upper_dir=${root_mount_storage}/root
> +		work_dir=${root_mount_storage}/.root-atomic
> +
> +		mount_dir=${rootmnt}
> +	fi
>   
>   	mkdir -p ${upper_dir}
>   	mkdir -p ${work_dir}
>   
> +	[ "$debug" = "y" ] && echo "Setup overlay L:${lower_dir} + U:${upper_dir} -> ${mount_dir}"
>   	if ! mount -t overlay \
>   		   -o lowerdir=${lower_dir},upperdir=${upper_dir},workdir=${work_dir} \
> -		   overlay ${lower_dir}; then
> +		   overlay ${mount_dir}; then
>   		panic "Can't mount overlay for '$ovl_lower_dir' !"
>   	fi
> +
> +	if ${root_moved}; then
> +		# Loop over all mountpoints already setup before we established the root overlay
> +		# and move them to the resulting overlayed rootfs
> +		[ "$debug" = "y" ] && echo "Move all mountpoints already setup before we established the root overlay..."
> +		cat /proc/mounts | grep "${root_mount_storage}/lower-root/" | awk '{print $2}' | \
> +			while read -r old_mountpoint
> +			do
> +				new_mountpoint="${rootmnt}/${old_mountpoint#${root_mount_storage}/lower-root/}"
> +
> +				[ "$debug" = "y" ] && echo "Move ${old_mountpoint} to ${new_mountpoint}"
> +				mount -n -o move ${old_mountpoint} ${new_mountpoint}
> +			done
> +	fi
> +
> +	log_end_msg
>   done
>   
> +# Finally, move the overlay workdir from initramfs to the final rootfs
> +[ "$debug" = "y" ] && echo "Move ${storage_mount_point} to ${rootmnt}${storage_mount_point}"
> +mount -n -o move ${storage_mount_point} ${rootmnt}${storage_mount_point}
> +
> +log_success_msg "Overlays setup successfully"
> +
>   exit 0
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> index ec7f85b..af610e5 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.3.bb
> @@ -45,7 +45,7 @@ TEMPLATE_VARS += " INITRAMFS_OVERLAY_STORAGE_PATH \
>   DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>   
>   HOOK_ADD_MODULES = "overlay"
> -HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
> +HOOK_COPY_EXECS = "mkdir mountpoint awk e2fsck mke2fs grep"
>   
>   SCRIPT_PREREQ="crypt"
>   


