Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8503ECD5BC7
	for <webhook@archiver.kernel.org>; Thu, 13 Nov 2025 11:16:37 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.21544.1763032590809186079
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Nov 2025 03:16:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=nv+ZFCgf;
 spf=pass (domain: siemens.com, ip: 40.107.130.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k64VVz8TJ7hbrBPCaprGBP/1ZKHlmnqewJkCIpoEWP77UAFqkEuE7c3rekrV+ulW1Klwdl5nzApAa/WbQ4N2bD6K58/yUZMq//N8dzZLB5Mho6vR/HyLIlZRR3NSHPe7LcfrH6fS0wol9Kf49X2RDMpWX4OXAymuihldpY9UOt2ZEHEnUr626aEybn1uPxq3yKdcwi3GZCVdW4bp9cw62eJf2hCUZTFwcRnEvtZxTtmhcNLbr6IUo+PtAJEMMS6Zqfmz0pfbdUgrvsf6n2u0p/q4v0qC4gqtA/xGrNisphWiDj2ZIZKGsA99oFBBPkll8bvR+I9YgicYHzoWiRtW8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSKL2JwxCgyGr4O7tqXynhtiEnd6xU7A1p2yVYKlq5Q=;
 b=dl0Urb27cFex8ZmEggogBVukO9a80VnDeJnGuOA9J71L93HRs7uYHCdumDtCF+z9pKPqkB4Jo1Vj+iRCKXZ3PJrKthjP0iusxjabMlmTbrlRB6JYuMKftHwZJPA163L/RwTI8cipgnSRCKqTW1jQ0TF+tRGcSRRPN5zdYVrWuTYq8xP9ScV2j0TVn3FXwHLKMGjyk7gLZJ0DzlhrrjCbOaK54Td6gXzvxDWhXlq65f7/JlI/sxRYhWzkifAih09U0xu7YbdCkWrXracLYAQOS6LB+o9LmuFH7GxMxgA59QTnJpCd2OoH+d2x7/1g5uSbFMlFBeKSoXyXestMhVxc8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSKL2JwxCgyGr4O7tqXynhtiEnd6xU7A1p2yVYKlq5Q=;
 b=nv+ZFCgfZsLOl4knin3gRSlcBwXHiEo8dHIgbjjPBKv2bxRLx4cLl4IEpLP3+FRvUaSvhSfchKftGgUWerZgwg1el7Wox/pcs6LO2qOac72YBtkBWWMhGyCoAAq7w3S9OADdoeKZHxJFfUWPhRg2pW4pO5dSAPfYCbIP19m7h2h7wP99AVNI6RdQVdZzlIqZLHG0NztIf2z8AJm5KHGR2ggeGRNDMXXH83tlaGzncnPYlD4pvdtXukIJTqMrpN/MU5aOgxwLa0Xa407fDD37nvsBLw4Wy1UdWSzcHf2SkVQ7iJB7IwFbImZRfxE23K5l2XrH39InoUf0fqNwSCMtdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI0PR10MB9416.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:2d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Thu, 13 Nov
 2025 11:16:25 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:16:24 +0000
Message-ID: <5bf002af-dc40-4528-aa53-76d394919193@siemens.com>
Date: Thu, 13 Nov 2025 12:16:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v4 1/5] Add support for TI AM62Px
 SK platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20251113101425.1177129-1-s-adivi@ti.com>
 <20251113101425.1177129-2-s-adivi@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20251113101425.1177129-2-s-adivi@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0050.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI0PR10MB9416:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c0ee31-2510-416c-6d8e-08de22a614ed
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Sm1LUzJmTldweUQyTjF2UHRXZnZnSDdTYkxRb3o1a253emdwajJ4SmZMdEtU?=
 =?utf-8?B?ZUw4QXdhR3BrQXZNazF0ZElXNjFmd0VleCsweElrQ1N0Mm9uZEhGUU5VZ2hI?=
 =?utf-8?B?VDVsQzYwaVpwZlRaYlpTWERwNUlzOStJNkRxVVdXMHYrbCtRN1ppa1NmVzB4?=
 =?utf-8?B?YkNnRUlCMmJVcitjWDRKRUFSUno4UHZiRCt6bmRIdGZISmRmLzFkV3VIcXBX?=
 =?utf-8?B?TFJvZkpMSDJVdHUyL0ZxdEZrdllubGhsUEtKN3R2WlRFRTNYaklLeUIzeWor?=
 =?utf-8?B?MkE4K0RHNVQ3U2w3em1IQzFoQ2dzM0NIb2daUVMxRFZVLzNpWjhCKzhkSmtj?=
 =?utf-8?B?amJVZS9JaHY4cGY4SUtrc1A0RDlGSU1UdFY3VDFjSURyOC9DR1B2U3dndm53?=
 =?utf-8?B?QktkbEFhaW8xL1dwaDJKQmsyZ1ZLSXU0QkRnZzNxSkN3VHVleWFJNEVxNDE2?=
 =?utf-8?B?OW1XMzE2alJqeFQ5SGkzVmZkc1VOUGc2ZlJuc0VNTFlTL1FaSmxnL2J4OHNP?=
 =?utf-8?B?YzVCRFF2ckZXczA1VEV0VkQ5R2NmOWxTT1QwKzFQUGtsbkJoWWF0Nng2bENZ?=
 =?utf-8?B?ZWdacWR4bEtsOVVZQi95VFJacEtCRGQ3K3lEK21hSUVYVHpvQWcxMU9RaHFN?=
 =?utf-8?B?WWIyWGFCc3QvMktIbHJEeU54SmQ3WE5vYUJDNVpjVk9RajJsVGoyQ0xKZE43?=
 =?utf-8?B?aUYzMTYyL2pTNHAzRHlTRnJzQUNZTENiSk1ra3NBR08remJXVjF1aVlIZm5a?=
 =?utf-8?B?Z3czQ2dIcTV6cEN2bU9VKzNOMXdTRUFLMmNNYWN0OGNmZ0tMZ3BHNGV0MUNE?=
 =?utf-8?B?WGN0U3UxNkw1Z0hIYkppSkVqRkxSYXBzYy8vb2xwdlB2NzZCWFhISGFUNDhz?=
 =?utf-8?B?c1NwcFdxamVQcmIxdzhmWFZ4OG9QZFJtL2JUMkd1QjFlMEVoRGU5MmhueTBD?=
 =?utf-8?B?ZmJOSURJTWY2ODRHT3kxK1U1RG4xQlMyS2s3M3IxRkJRR0lpRG9UdGpaaGtq?=
 =?utf-8?B?MFBFclBOc21pUUtGYWtRZjBDYmRHUW4rQVh0a2paZEk5ZXltaHFZYnA2Q1VI?=
 =?utf-8?B?QUZFOHh3dFFXd0dLd0tmVEN4TjRmS21WQWl6emxFdUl0dlQxcXVsbU9VUnli?=
 =?utf-8?B?WTBNeWFxQStwYmF3blp5d3Z4bFpQanE0RTgvb3lxUjZJcVg5WGpLSU02bEEx?=
 =?utf-8?B?Z2FOYmNydFFGQStqdWdWRXRwREhxRG0zWG5nWU41cUVndEJLWmtNWEVMall5?=
 =?utf-8?B?dVduUGxUZXBBUzREd0VFblhXVUdQRjRwRnNmbXdER05MWWJGenMzSWtDMjVG?=
 =?utf-8?B?TTJ6bVpydFFBckd0MFVsYTl5ZEszdGJOS1FlRmRTR0NXRW9DVFdsR1hNdm1Z?=
 =?utf-8?B?Z0U1d0w0ejJDcVMzeWo0UEFjNVNBd1kvUFZmRDZLZ3NPTGh0d0ZLOUtXbVpu?=
 =?utf-8?B?NXZNVGxZN3QzMFJ2NmZzdGhvVkRsYjNSRVJMd3RnRmFEazNNYVBKdUZvUVcx?=
 =?utf-8?B?Q3lWazRjNXcwdzFpM1NZTHNmSlYwNWErUG9OcXdBV3BIU3RHRWhXMDNuSDVa?=
 =?utf-8?B?ZVRhQ3ppUEViZm4xUU1iczBVbTdmSlBsMHdhVi96TW5RUlkyZ0tnUGozcjlv?=
 =?utf-8?B?VVRqLzlxejdYYlcxaURKdERpNURMc1lDaTk0S2g1eHd6bVUyWTkrdGVnUnJN?=
 =?utf-8?B?YVVSd29xWDZiNFhuUlNZcGxRdTR4WjB5T0R1d2tZNFAxSXdjM1RmSXM0OWM1?=
 =?utf-8?B?NG5hSWpWOExtbXRQdDhzamNMRlFGaWdkekpkWElVM2VJWjF0WlhvV1dxMTdr?=
 =?utf-8?B?SDU5K3IzaGhkaTUzNm8xeTFEWFdpMzZiQVhZTjYwRWFXWFhmZGJJUUxwclJ1?=
 =?utf-8?B?MTAvcnpBR3hNbG11cEFhN2licHluaGpaWFlwaXQ4SmpnSUFyTGhoWi9kMUhI?=
 =?utf-8?Q?ULfdIv2/Kic=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TmJzeUxlUE4wdjFKTUU3dDZhcUFlS25BV3RoUGJHOG01RzhsZjMzWTZCT3Rv?=
 =?utf-8?B?US9uWGg4aFdnQXNxNFVxQnEyNE1zeUVBdWVBTGFseXZZd1RtbGpBWHVJVTlU?=
 =?utf-8?B?SEJHWVUrbzAwQWVRVzRoenp4YURxZkY3a1E4MmFibzlDREg0RS9DNEVlTFR2?=
 =?utf-8?B?Nzh2YUNuSGpHRTYzaXdXaGg2cDZtRkVnNEE2L3JyM0pPOFRUUHphSVY2RFZJ?=
 =?utf-8?B?T2ZqdURkNGpxNElBWWZWV3V4QVFnckU4emUrakhrRE5zQzBFVmRMVVk2NW1P?=
 =?utf-8?B?dzVoK0hQZktVam1ydXB3ZnNKdDR1bFlLMjkzTmp1emdFUktyR2k2TFBYY2ox?=
 =?utf-8?B?Z3RibVNoRm5jY25NQjdUZkxyMlphdnFFQnhHNlR1d0N1Y3VNUy9tTkQ1dEh2?=
 =?utf-8?B?bmpjSktZYlJXMTFuNHhZWnBIT3FzdWlOYzlSM1ByVTd0NmFUNlI0cXZtMi9N?=
 =?utf-8?B?Tm9LeDVJdUYzWEZUZG5nUU9vQndzSkVYRVVrY21HU0xRMTl1Y0NGR0VCUE5j?=
 =?utf-8?B?cDl1OG40QktTRmI5WUR4Y1NsLytjaWhjWWY2ODRaT0V6NGJhSVJUd2JCMjg0?=
 =?utf-8?B?R0k0ZVJJM3FJeWhnaTRaTFlyL1RuVm1uQk1VdEY1T2Y0TXI2c3hzUUFmTUtl?=
 =?utf-8?B?VEs3N3huRFJGSWlZNTlIT1huOTZWZDh1UlcrZk54eWRqalMwYXcyOGtvSzRV?=
 =?utf-8?B?Y3ZndWVkbXhYRVJPaGcyVE8vODFHSFAvYjFtb3BuOEYwK0FLVk91SldtSnN0?=
 =?utf-8?B?UG92ZHFGOEs2NkFWZ0hMclNEN3A2TGo1TVg0NHovclpYUWdVZklBUmI2bThB?=
 =?utf-8?B?eUNVZTROOUpaT2x1OHNaT1VCK3EzY291MGh4UnEvZzlZOGxLbnpYTEdhZWxO?=
 =?utf-8?B?UkgyaFozeTVZMDNXMiszOFB4b3I0eE9CbGcrNVZCMCt1VEZ4L3NiVFEzODBm?=
 =?utf-8?B?TjNTSmg0NytpRzhpNU9pdVhtWEVwMEZ6TFRBNTNlSjFFZFhMTzlYanIwRENo?=
 =?utf-8?B?QkFqT0YvNkFvVWFVa0U5REVpSitaKzJUa2hwWnl0cko4VElLSnppeXVZMGk1?=
 =?utf-8?B?Vm9ocWFzZkFEaFZPNVhUQWt2MnhwcFYxUGUvSWxRWUVzeUd0QlpxbEtwOGxK?=
 =?utf-8?B?VGM2cCtEaVNzR0t2dDQzK2R6Zk93eE90cnd0djRpdS9EczIzVDA2T3oxMWM3?=
 =?utf-8?B?N0tjYWFqSjhEeHh5Yk1hUnlPRXNidFc3L2F2Z1ZybmJIZnkvTXU3MGNqbGRs?=
 =?utf-8?B?UGxzVzlGL1V4VGJuZVlUbUJpUDBUYndOQ2dPR0pOeWZUWjc1cFNjeVFDMGRr?=
 =?utf-8?B?Z1UvemdKM09pTlBqK3ZxTkRTOHh4U1ErSkhuQ2w2SldWNndwSEFIdXpaMmNt?=
 =?utf-8?B?c3BTR0JPQ0dhekIyWVRUTVhTMWV6UDJWSUNHbnBFbXJ4RVIzZGxmQmJPYnNh?=
 =?utf-8?B?SWJOeUE3SkpWR0Fxc0RtZEs5VkpQd3dydnhyTHpYbGlCWkJFWTdUZnNsTnNu?=
 =?utf-8?B?MUs5NG93QWwvY2FOZDFsZlU4Qk1nT1o5WEVKNjhyeWo3MTg1SVB6QjhrOHR3?=
 =?utf-8?B?SFFQY2VQayttUE9xSERlWVZKdjNwRmhMdXpOdGNHZDk2YkJUb3lmR1JQYU9p?=
 =?utf-8?B?NERXR2xOaEtyMlhLT2d4VEx0UEVyUHVicnFFekVoWnllSVdlMGlDTDR3cXVU?=
 =?utf-8?B?MktqLzl2WVMwaEhJenV5SmhVcWJFYkhWdEo1cHNWcGxIY1B5dkR5ZGNpb09V?=
 =?utf-8?B?U3k0ZS9ncmlqeWFyQUlESzdKaGtQR0xha2Q3bXQ3Sms2NHM5MDNCZlVsaTZX?=
 =?utf-8?B?cmJBUkwxaTV2WmJiSlVrbTcrYmRkWFNCbndreDRmaW1xd0ZTdCs3R1RRVmh4?=
 =?utf-8?B?S0dSR09DcFV6Z2xmS0xpWDlveTY0a003bTVCK0JqRXpoQ0x1Y2pPZGNmTFlB?=
 =?utf-8?B?MXlaOHU4U3l6YjdDTytjQWczQ2J0SjhHakFSOEZHeGs5bjVjQitlVVJMK0l2?=
 =?utf-8?B?enoyK1llQUJuZEo2YjRPbWl0MENObWhOOTZoY2llM1E0azJhOWZUWWIrbVcx?=
 =?utf-8?B?YXNDU0xFc1ozMkF1WEFFS3lpTk9sOFRLTFhTZ05RK3lnL0JYSjhNdUJHQzdX?=
 =?utf-8?B?dWk3YXlLVjhrWElPeklxL0QxdEJvNmJxZk90RHJ4bk5jb0Y2RFFOdCt3RlNM?=
 =?utf-8?B?eVE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c0ee31-2510-416c-6d8e-08de22a614ed
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:16:24.6763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +c8shaATjSoN1lJrtN/JevmVMCTID2apJCGqkB1N2el69xcV4/yIUHqisws3VOypowo0Bfhw5Ii9Xm28DUuFHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9416
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Nov 2025 11:16:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20531

On 13.11.25 11:14, Sai Sree Kartheek Adivi wrote:
> - Add machine conf and and kas yml files for TI AM62Px SK
> - Add u-boot 2025.07 recipe
> - Add patch 0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch to
>   enable KASLR support. This is already upstreamed to u-boot at [1].
> - Add new recipes for trusted-firmware-a, optee-os
> - Update SRCREV for cip-kernel-config to fetch ti_defconfig
> - Add wks file for supporting image builds
> - Update Kconfig to enable build support
> 
> [1]: https://github.com/u-boot/u-boot/commit/7d4136397715d2c08161a32a873c052dd1bb8b6c
> 
> Signed-off-by: Sai Sree Kartheek Adivi <s-adivi@ti.com>
> ---
>  Kconfig                                       |  9 +++
>  conf/machine/ti-am62px-sk.conf                | 28 +++++++++
>  kas/board/ti-am62px-sk.yml                    | 13 ++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb  | 11 ++++
>  recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc | 30 +++++++++
>  .../trusted-firmware-a-ti-k3_2.13.bb          | 22 +++++++
>  ...KASLR-OPTEE-RNG-support-for-K3-devic.patch | 38 ++++++++++++
>  recipes-bsp/u-boot/files/rules-ti-am62px-sk   | 33 ++++++++++
>  .../u-boot/u-boot-ti-am62px-sk_2025.07.bb     | 61 +++++++++++++++++++
>  wic/ti-am62px-sk.wks                          | 15 +++++
>  10 files changed, 260 insertions(+)
>  create mode 100644 conf/machine/ti-am62px-sk.conf
>  create mode 100644 kas/board/ti-am62px-sk.yml
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
>  create mode 100644 recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
>  create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
>  create mode 100644 recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
>  create mode 100755 recipes-bsp/u-boot/files/rules-ti-am62px-sk
>  create mode 100644 recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
>  create mode 100644 wic/ti-am62px-sk.wks
> 
> diff --git a/Kconfig b/Kconfig
> index 68773bc..9b3c329 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -86,6 +86,10 @@ config TARGET_QEMU_RISCV64
>  	select ARCH_RISCV64
>  	select HAS_SWUPDATE if KERNEL_6_1 || KERNEL_6_12
>  
> +config TARGET_TI_AM62PX_SK
> +	bool "Texas Instruments AM62Px SK"
> +	select ARCH_ARM64
> +
>  endchoice
>  
>  config KAS_INCLUDE_BOARD
> @@ -98,6 +102,7 @@ config KAS_INCLUDE_BOARD
>  	default "kas/board/bbb.yml" if TARGET_BBB
>  	default "kas/board/iwg20m.yml" if TARGET_IWG20D
>  	default "kas/board/qemu-riscv64.yml" if TARGET_QEMU_RISCV64
> +	default "kas/board/ti-am62px-sk.yml" if TARGET_TI_AM62PX_SK
>  
>  comment "Kernel options"
>  
> @@ -108,16 +113,20 @@ choice
>  config KERNEL_4_4
>  	bool "Kernel 4.4.x-cip"
>  	depends on !ARCH_ARM64 && !ARCH_RISCV64
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_4_19
>  	bool "Kernel 4.19.x-cip"
>  	depends on !ARCH_RISCV64
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_5_10
>  	bool "Kernel 5.10.x-cip"
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_6_1
>  	bool "Kernel 6.1.x-cip"
> +	depends on !TARGET_TI_AM62PX_SK
>  
>  config KERNEL_6_12
>  	bool "Kernel 6.12.x-cip"
> diff --git a/conf/machine/ti-am62px-sk.conf b/conf/machine/ti-am62px-sk.conf
> new file mode 100644
> index 0000000..589f071
> --- /dev/null
> +++ b/conf/machine/ti-am62px-sk.conf
> @@ -0,0 +1,28 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +DISTRO_ARCH = "arm64"
> +DTB_FILES = "k3-am62p5-sk.dtb"
> +
> +IMAGE_FSTYPES ?= "wic"
> +
> +IMAGER_INSTALL:wic += "${SYSTEMD_BOOTLOADER_INSTALL} u-boot-ti-am62px-sk"
> +IMAGER_BUILD_DEPS += "u-boot-ti-am62px-sk"
> +
> +IMAGE_PREINSTALL += "firmware-ti-connectivity"
> +
> +IMAGE_BOOT_FILES = " \
> +    /usr/lib/u-boot/${MACHINE}/u-boot.img;u-boot.img \
> +    /usr/lib/u-boot/${MACHINE}/tispl.bin;tispl.bin \
> +    /usr/lib/u-boot/${MACHINE}/tiboot3-am62px-hs-fs-evm.bin;tiboot3.bin"
> +
> +USE_CIP_KERNEL_CONFIG = "1"
> +KERNEL_DEFCONFIG = "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64/ti_defconfig"
> +
> +WDOG_TIMEOUT = "0"
> diff --git a/kas/board/ti-am62px-sk.yml b/kas/board/ti-am62px-sk.yml
> new file mode 100644
> index 0000000..5127218
> --- /dev/null
> +++ b/kas/board/ti-am62px-sk.yml
> @@ -0,0 +1,13 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +machine: ti-am62px-sk
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> new file mode 100644
> index 0000000..f8cd973
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.bb
> @@ -0,0 +1,11 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-bsp/optee-os/optee-os-custom.inc
> +require optee-os-ti-k3_${PV}.inc
> diff --git a/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> new file mode 100644
> index 0000000..444f6b3
> --- /dev/null
> +++ b/recipes-bsp/optee-os/optee-os-ti-k3_4.8.0.inc
> @@ -0,0 +1,30 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +SRC_URI += " \
> +    https://github.com/OP-TEE/optee_os/archive/${PV}.tar.gz;downloadfilename=optee-os-${PV}.tar.gz \
> +    "
> +
> +SRC_URI[sha256sum] = "5222cd553f5edb69ae4ec7cb99b2bfec2c47a47c0be1865b49744701918e8b4d"
> +
> +S = "${WORKDIR}/optee_os-${PV}"
> +
> +OPTEE_NAME = "ti-k3"
> +OPTEE_PLATFORM = "k3-am62px"
> +OPTEE_EXTRA_BUILDARGS += " \
> +	CFG_ARM64_core=y \
> +	CFG_USER_TA_TARGETS=ta_arm64 \
> +	TEE_IMPL_VERSION=${PV} \
> +	CFG_TEE_CORE_LOG_LEVEL=1 \
> +	"
> +
> +DEBIAN_BUILD_DEPENDS += ", device-tree-compiler, python3-cryptography:native"
> +
> +OPTEE_ENABLE_APPS ?= "1"
> +OVERRIDES .= "${@':optee-with-apps' if bb.utils.to_boolean(d.getVar("OPTEE_ENABLE_APPS")) else ''}"
> diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> new file mode 100644
> index 0000000..5b572bf
> --- /dev/null
> +++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-ti-k3_2.13.bb
> @@ -0,0 +1,22 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
> +
> +SRC_URI += "https://github.com/ARM-software/arm-trusted-firmware/archive/v${PV}.tar.gz;downloadfilename=arm-trusted-firmware-${PV}.tar.gz"
> +SRC_URI[sha256sum] = "68333c8be57830e7430d7dd39064826729923d86d6bb7af38d713d4e9d15dcf9"
> +
> +S = "${WORKDIR}/arm-trusted-firmware-${PV}"
> +
> +TF_A_NAME = "ti-k3"
> +TF_A_PLATFORM = "k3"
> +TF_A_EXTRA_BUILDARGS = "CFG_ARM64=y TARGET_BOARD=lite SPD=opteed K3_PM_SYSTEM_SUSPEND=1"
> +TF_A_BINARIES = "lite/release/bl31.bin"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> diff --git a/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> new file mode 100644
> index 0000000..d831b21
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch
> @@ -0,0 +1,38 @@
> +From 7d4136397715d2c08161a32a873c052dd1bb8b6c Mon Sep 17 00:00:00 2001
> +From: Gokul Praveen <g-praveen@ti.com>
> +Date: Thu, 10 Jul 2025 15:29:22 +0530
> +Subject: [PATCH] configs: KASLR OPTEE RNG support for K3 devices
> +
> +KASLR, or Kernel Address Space Layout Randomization, is a security
> +feature in the Linux kernel that randomizes the memory location
> +where the kernel is loaded during boot.
> +
> +OP-TEE RNG is a Random Number Generator (RNG) component within the
> +Open Portable Trusted Execution Environment (OP-TEE) which provides
> +a random number to U-BOOT and U-BOOT provides this random number
> +as seed value to the LINUX kernel for KASLR.
> +
> +Add KASLR OPTEE RNG support across K3 devices by enabling the required
> +configs.
> +
> +Signed-off-by: Gokul Praveen <g-praveen@ti.com>
> +Reviewed-by: Bryan Brattlof <bb@ti.com>
> +Reviewed-by: Manorit Chawdhry <m-chawdhry@ti.com>
> +---
> + arch/arm/Kconfig | 3 +++
> + 1 file changed, 3 insertions(+)
> +
> +diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> +index 5872455a0fe5..4e7593616d8a 100644
> +--- a/arch/arm/Kconfig
> ++++ b/arch/arm/Kconfig
> +@@ -835,6 +835,9 @@ config ARCH_K3
> + 	select FIT_SIGNATURE if ARM64
> + 	select LTO
> + 	imply TI_SECURE_DEVICE
> ++	imply DM_RNG if ARM64
> ++	imply TEE if ARM64
> ++	imply OPTEE if ARM64
> + 
> + config ARCH_OMAP2PLUS
> + 	bool "TI OMAP2+"
> diff --git a/recipes-bsp/u-boot/files/rules-ti-am62px-sk b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> new file mode 100755
> index 0000000..6b9a6b1
> --- /dev/null
> +++ b/recipes-bsp/u-boot/files/rules-ti-am62px-sk
> @@ -0,0 +1,33 @@
> +#!/usr/bin/make -f
> +#
> +# Debian rules for custom U-Boot build for ti-am62p-sk
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# SPDX-License-Identifier: MIT
> +
> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
> +SET_CROSS_BUILD_TOOLS=CROSS_BUILD_TOOLS=y
> +endif
> +
> +override_dh_auto_build:
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm am62px_evm_r5_defconfig
> +	$(MAKE) $(PARALLEL_MAKE) ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- BINMAN_INDIRS=./ti-linux-firmware
> +
> +	$(MAKE) $(PARALLEL_MAKE) am62px_evm_a53_defconfig
> +	$(MAKE) $(PARALLEL_MAKE) BL31=/usr/lib/trusted-firmware-a/ti-k3/bl31.bin \
> +		TEE=/usr/lib/optee-os/ti-k3/tee-raw.bin BINMAN_INDIRS=./ti-linux-firmware
> +	$(MAKE) $(PARALLEL_MAKE) u-boot-initial-env
> +	$(MAKE) $(PARALLEL_MAKE) $(SET_CROSS_BUILD_TOOLS) NO_SDL=1 tools-only envtools
> +
> +override_dh_auto_install:
> +	mv tools/env/lib.a tools/env/libubootenv.a
> +
> +override_dh_auto_test:
> +
> +override_dh_strip:
> +	dh_strip -X libubootenv.a
> +
> +%:
> +	dh $@ --parallel
> diff --git a/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> new file mode 100644
> index 0000000..8f8d0ff
> --- /dev/null
> +++ b/recipes-bsp/u-boot/u-boot-ti-am62px-sk_2025.07.bb
> @@ -0,0 +1,61 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +require u-boot-common-${PV}.inc
> +
> +TI_FIRMWARE_PV = "11.01.16"
> +
> +SRC_URI += " \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-cert.bin;name=am62p-sysfw-cert-hs-fs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-fs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-fs-enc.bin;name=am62p-sysfw-enc-hs-fs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-cert.bin;name=am62p-sysfw-stub-cert \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-stub-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-stub-firmware-am62px-hs-enc.bin;name=am62p-sysfw-stub-enc \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-cert.bin;downloadfilename=ti-fs-firmware-am62px-hs-cert.bin;name=am62p-sysfw-cert-hs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-sysfw/ti-fs-firmware-am62px-hs-enc.bin;downloadfilename=ti-fs-firmware-am62px-hs-enc.bin;name=am62p-sysfw-enc-hs \
> +	https://github.com/TexasInstruments/ti-linux-firmware/raw/refs/tags/${TI_FIRMWARE_PV}/ti-dm/am62pxx/ipc_echo_testb_mcu1_0_release_strip.xer5f;downloadfilename=ipc_echo_testb_mcu1_0_release_strip.xer5f;name=am62p-dm \
> +	file://rules-${MACHINE} \
> +	file://0001-configs-KASLR-OPTEE-RNG-support-for-K3-devic.patch \
> +	"
> +
> +SRC_URI[am62p-dm.sha256sum] = "85ba372a3c9cd0d09c84f9bbe46a72c7e4d6fdaff67df3ee7fbec3996965f044"
> +SRC_URI[am62p-sysfw-cert-hs-fs.sha256sum] = "7781f2e7cc6741077f502692a93f435e7aa185de14d6aa8bb33d4f32f998f47a"
> +SRC_URI[am62p-sysfw-enc-hs-fs.sha256sum] = "4563a2b22568581e04eeacc468feef5e204020c0d09a53351fd62d109e72b88f"
> +SRC_URI[am62p-sysfw-stub-cert.sha256sum] = "dc45dcbc3dec319a9f3400a7051b692fe3c5e2369b33a46e8ef8c81419557eaa"
> +SRC_URI[am62p-sysfw-stub-enc.sha256sum] = "9d6537148e7071f7ffbe33231c2e8ba1f17db398dff96c0a423baa8afd9e0bc8"
> +SRC_URI[am62p-sysfw-cert-hs.sha256sum] = "ec3a7783d7dc6aab1085dfd131cbd08ad5f895b7f22530c90a93333c4cd22603"
> +SRC_URI[am62p-sysfw-enc-hs.sha256sum] = "4d0ed21a36dd57ada78307506403204e179d81dd1f05b3db384d4b24e17c5b9d"
> +
> +S = "${WORKDIR}/u-boot-${PV}"
> +TI_LINUX_FIRMWARE = "${S}/ti-linux-firmware"
> +
> +COMPATIBLE_MACHINE = "ti-am62px-sk"
> +
> +U_BOOT_R5_CONFIG = "am62px_evm_r5_defconfig"
> +U_BOOT_A53_CONFIG = "am62px_evm_a53_defconfig"
> +U_BOOT_CONFIG = "${U_BOOT_A53_CONFIG}"
> +
> +U_BOOT_BIN_INSTALL = "tiboot3-am62px-hs-fs-evm.bin tispl.bin u-boot.img"
> +
> +DEPENDS += "trusted-firmware-a-ti-k3 optee-os-ti-k3"
> +DEBIAN_BUILD_DEPENDS =. "gcc-arm-linux-gnueabihf, \
> +    libssl-dev:native, libssl-dev, grub-common, \
> +    swig, python3-dev:native, python3-setuptools, python3-pyelftools, \
> +    python3-jsonschema:native, yamllint:native, \
> +    trusted-firmware-a-ti-k3, optee-os-ti-k3,"
> +
> +do_prepare_build:prepend() {
> +    cp ${WORKDIR}/rules-${MACHINE} ${WORKDIR}/debian/rules

Won't this be overwritten by the

cp -r ${WORKDIR}/debian ${S}/

in the u-boot-custom.inc? Why not appending like the rest below?

Jan

> +}
> +
> +do_prepare_build:append() {
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    cp ${WORKDIR}/ti-fs-*firmware-am62px-hs*.bin ${TI_LINUX_FIRMWARE}/ti-sysfw
> +    mkdir -p ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +    cp ${WORKDIR}/ipc_echo_testb_mcu1_0_release_strip.xer5f ${TI_LINUX_FIRMWARE}/ti-dm/am62pxx
> +}
> diff --git a/wic/ti-am62px-sk.wks b/wic/ti-am62px-sk.wks
> new file mode 100644
> index 0000000..40214a8
> --- /dev/null
> +++ b/wic/ti-am62px-sk.wks
> @@ -0,0 +1,15 @@
> +#
> +# Copyright (c) Texas Instruments Incorporated, 2025
> +#
> +# Authors:
> +#  Sai Sree Kartheek Adivi <s-adivi@ti.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +part /boot/firmware --source bootimg-partition --fstype=vfat --label firmware --active --align 1024 --size 16M --overhead-factor 1 --extra-space 0 --use-uuid --part-type E3C9E316-0B5C-4DB8-817D-F92DF00215AE
> +part /boot --source bootimg-efi-isar --sourceparams "loader=systemd-boot" --label efi --part-type EF00 --align 1024 --use-uuid
> +
> +part / --source rootfs --fstype ext4 --mkfs-extraopts "-T default" --label platform --align 1024 --use-uuid --exclude-path boot/
> +
> +bootloader --ptable gpt --source hybrid-boot --timeout=0 --append "rootwait rw"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

