Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206D7C43458
	for <webhook@archiver.kernel.org>; Fri, 26 Jun 2026 17:13:19 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.60])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.39973.1782493997577412966
 for <cip-dev@lists.cip-project.org>;
 Fri, 26 Jun 2026 10:13:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bys8QqBT;
 spf=pass (domain: siemens.com, ip: 52.101.66.60, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PACm6D/lsVo3DAlT/v0JF/RUPTUt2VVMEKMPMpPNibWojfovwnZzwAZOmHXOuxcTIcHjk39uqvM2Q+aQ6gIUSIXq1bMa+aJNohQJqxx8I8Oix/0p+oP7/e9J6FOoMmEG0yj3cyBCVMsynD+0Kze19VhQbrqgSZAYZbRSnveKu8CmEI4SWMOvzfcdIwIMNt8fKha0IpGrcVqw4+nG9jwz97P+P4jl1/RyCEClDb0BorTe/urmcSiYSqodSZFAfMGFm75A9muozLppFHVqPa8QwxrISWAjEo75YutO2Ds3hi94yPAnz28167nWQ6Wf1bYrR4wf+3zN/DzI7S3GJTDLUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLmzW+JNX4nl7SbBodUl5ZiGcG0UeHLynH027VLkyQ0=;
 b=HnySH/0T1Qi2R6KXgGmUsFEz/DnP0SEtxnEaWOSK1Jda6sPVyi1SRx5RQ725/YBy/ZykC5Vm0sarzewtfJaBAJkJM4RWCDR9HlOeT4KCV/yl59srBUx9n1zKn5VdHYy6bWL9RVteadwRPz/AExHQJbYwDxZynWT57TScdHDmv/kP3vQrkCMa2KZD+K7Qp204c+sEH6I5qUByBQ1L2a2pkSRXpb6FZFW1vz9JXS4ITtf1ooxpubKu+gTr/8XTCMBUwBMPblj/Eg3vKUGaU0MvUjcuBZe2eAcHy8V2Ig5moSo8PNEjZ+wTTp6WLZPTUGrQDr6O3DAJrDMfK83naYGy1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLmzW+JNX4nl7SbBodUl5ZiGcG0UeHLynH027VLkyQ0=;
 b=bys8QqBTMM9AmCVLbB4SP9eBjOAX/J7nRLbQJDrBdSi0fBUVo/XdeyqKiQOXqHKlDx4lgygtgxvMdDomOEB3yyZ+uHL9dAPbzVe0YrsxFyYfrbknpD1kvrRlr2vfK5PjUMtMV88MjGJmpApzPWQjyhyUCDEOnRGYclibU2+c4BM/7a5tGqdC8xGkDrPXwgeJ4goc1tmkntPZgFhefAAIdA4aYDFaE8Z+Zs1OitDaI+vUrW/CLaBytsXh4DdH5T1n99HK7iRdhEpblMOxPFlesngHNeo3HKW2Pgd5i73tMP91SqebG0bQYU29ZDz0ZI3dfAA9IIRTX2ELUTZjWM+XUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB7483.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:426::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 17:13:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0159.016; Fri, 26 Jun 2026
 17:13:13 +0000
Message-ID: <71292516-320c-4da2-8e7f-7079b4293909@siemens.com>
Date: Fri, 26 Jun 2026 19:13:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2] Add missing MACHINE to install
 swupdate-config*
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, cedric.hombourger@siemens.com
References: <20260626163330.523726-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260626163330.523726-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0140.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB7483:EE_
X-MS-Office365-Filtering-Correlation-Id: d3e84d9e-2613-4647-9564-08ded3a63447
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|55112099003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	1tU3JLkPZ2xxkOA0fqKji51uni/oniwVf927vX+WMDplxTa2C46wafaZQFfSQPog3EhSOyyHK6xSsK5Xbk7MHKNfVaVGpXPTELG9YF13T8bqnP9oE0pz4INrgt66MTZZ2L+1vS0J5q7tgr2GvhWDXfz6+GCSVoCMXa+V4OJv3drSfMyQGkcGWJctvKpB0wPdhviDSDnO2b2I4fhgv6GV3wTku58EwoxU0j9OVWlu0hAcNguj5AOm6DPuIahZeu7jbnRS+YeBUO5Mgak43W4gq+NKfnOULCThlW6TstdRDkOHDDmcfyuCMMv5pyduwPUCMGq4QWfk0d8ENR+5Yd4SLrisKH8LmIugetPWN/XC9TIItuBOpxc/pzKXVwwEMT2VS7PoLOwF2n1brTJoRiDPn2RDaLSc439NVvxLCeet8O7GB2uKLBCPMkkmK3AqvT3JeWYCtM6CAJDx9k3aJEjOXe0Fvq4aH2w5Y1+ZDg1jpA1PGYFXrBvfoNen2viHyvoGQzfEuoukgMHh+cNwHS7s+R/sHs+LTOebtWj8/WTCQWS4qLLEHsdx9MiKZ8YFuij8d0KzXMmlaPTGOiUHeyFRlNTRpYIbfchOkM5JUo8J0Nf8sw4IzO7oLbN0teNODz91t9Ug2iEZP3gLmN5nC9WwzGZ1qywGuGa1UJ51sYc83t4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(55112099003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TTR1a05JejYzaVQ5T3RkR2RHV1ZWd2tnUVFUZlFjMTZUTTc5OExlQnM0czl1?=
 =?utf-8?B?WVpGcy9rbk5RRzNMeUdnaEp1THZ0S1Vrb3hRSW1MZWEzNkpFU2pkTjhzc3ph?=
 =?utf-8?B?dTBodi9nMkNSSUd2N3ErckNHTk00UW9JSVdHRHRwd2RoN3lPN04wT01Ya1Fw?=
 =?utf-8?B?R1lHdTlhaTUzY3Y2Qi9LOUF1TjZneVFENmsvMFFwY1puTTkwWFNyS0RhakRM?=
 =?utf-8?B?eEtuUVZvd2JvSW1IYUtVVVRSdmpCSTdXUDRhQ0pLb3lhZjhFYlZMcUxDU0Vk?=
 =?utf-8?B?MGtDYndQcnVxV2pXYVRhVXc2YWwwYW9CQWhia3U5UmNhK3NsSnRXa3lwVk95?=
 =?utf-8?B?S0hYTDdzT200UThHNGhiak12OVE3QVdjbDdlR0xITHIwc2JPVmh1ZGNhSThi?=
 =?utf-8?B?U2M3dkQ4M1N6anJqZ1duUkJNQzdjZzc4Kzc2RWRyWkZObkpiWlBVNk9qenV1?=
 =?utf-8?B?N2RuMEtITmUrNVRSMFpxS0wyc2dhM2o1MXJ4R3pqYVB4dEUvS3dBbEdLaHgv?=
 =?utf-8?B?M3IvZmNWODZXTUlvOVNIZ0VVQ25JYVdMQTd2SVNzcC9vNk1VZlhZejQvZVZk?=
 =?utf-8?B?MHhGcDJ1ajJ3VkRQL01WY0hkdjJ3NVdXS2lqQXN1V2VMUWZNSmRFVlBvQmpP?=
 =?utf-8?B?U01maGpBYmw5cHhwWXpNR21HQ0VSUUlrY0FzRlZRTjBNZFg0cDRoY0FZZC9U?=
 =?utf-8?B?THZHR3dlYjNDdy9kNEVzQjZyczV6ZHJZM3R0WTRtc0E3SXlzcjBWR011S0VH?=
 =?utf-8?B?bWpCT2h1ZkhyNTBJVG5YeDljN05udVk2aXNmYzlmcWZQci9hV0NyYUJxQm5m?=
 =?utf-8?B?b0lyQlRVMVRFVU1lYkFvYnB6VHM4RHZSS01CcDZEZXVjRUo3RTVmLzMwY1dY?=
 =?utf-8?B?c2I0ZW4xUVlLNGdiSmFUWWprcEIxVmZHU3lZTGZPcFNFWStMdVE0NlZOMW9E?=
 =?utf-8?B?ekxxNUVWcHMwL0N1NThSQ25EdThaUWpjNFV6V3Q5bjlNQ3pkeC9Yd1gwUUw4?=
 =?utf-8?B?K2tsaGxzTmREZWVKNVE4c3c2THlEUEpvK09UQkhJcm5FT1dGaWxqcGhramhX?=
 =?utf-8?B?VmRsZ2g0enUrcEJicittcHZmS1RIMW1HU1hpRjhtTEtNWGl5ckE4RGVZSTVI?=
 =?utf-8?B?RlBMd25TU21oU1dLK2hzN041QUx6U0p2OGJaN0RiQ3N3dzM2aXBIT1k2S1ZU?=
 =?utf-8?B?a3VaeXBVNWIwWHhlY0F5cURaa1pBekdsYnAvdGpKU0FMdUIvYW9zNTVHNGln?=
 =?utf-8?B?TldUUUVjNWptTHRSZmJjU0JNMWlhNzF3QjlnTk1XdU1oNGRWbHZSQVg1aFlY?=
 =?utf-8?B?bTF1L08xTERqaEVrVC93ODJGekRhSUM5Wm5mMFAzb2ZCVFd5cDUrZDFISjYr?=
 =?utf-8?B?bjFXOUZxSXZaRitCSVBxU1k1cHFvMUtyRHJtQWdkMndpUk5haDM2c1VTelpy?=
 =?utf-8?B?b2NxbzE3QVR0RGQxcmljQnVIT3NDSGFJYXZmUnU0VkRRWTJPNXI4Qjd0ZkxW?=
 =?utf-8?B?bHc2RndSN0xwVGR3RzdLU3g1b2kxNURJQXE1eHp4MFpTeVBqd3pKaUVrWXRn?=
 =?utf-8?B?bXoxR2h5TTFIUEIxcTVrZ3JhWDRRNDJyYWF2U0U2OEpRZEQzdlRqTW4rTzVv?=
 =?utf-8?B?THd4QmkvMk9zMGxjUkpZUXkvcXZxTzlxYjlSSXJKMnUweEs0SENROFJIc2pr?=
 =?utf-8?B?N2JBQ2VZdms2b2lqaUQ1Y3UrQUV2UVdPNFg1NFkwRG5sTWFCYlMxM0pKZUY3?=
 =?utf-8?B?bXZlRkE5R2pYd0Y2SDlLa0JET3lWTmtkZE04V0tWREc5Wk1ld2lMV0JPUU1w?=
 =?utf-8?B?RFRBYXdzNEFvQk50L0hpc0FhWU5ETTJ0a0xtQTRrdUJxYjcxNyswemRKZzh2?=
 =?utf-8?B?ZG4vdDkwbHhHS1BKVktOUzh2Z3c2MUZGZk1YRlliV0xlSk9hMFl1bkc0MThM?=
 =?utf-8?B?Q2lpMjMzVW12RCsrcGJmdUFCM3lyeG1Mem5JVnN4aVlBYlBBU2ZOZ3A5VGVG?=
 =?utf-8?B?c0s1c0tTUU8zWmlwRDQwUHo4eW9GMzlqOE10S01rRlk3QTZKMXduU2tTOVpE?=
 =?utf-8?B?Y1NkU2JsZkxJSEtTbmNwTjlSc3V1Mll6aVVWVUsrdU03ZXZYeE9ZMldYclZh?=
 =?utf-8?B?Tkl5aUVQZjlRNS9ENjZPL3hDU0xjZkJlUzhwZVhPVUJ5akQyeERZUy9QUW5W?=
 =?utf-8?B?TzlzNFBKRmE4MDh0SXBaK093T1VyYjBpRUpYWEtlNVN6eWZGVkJsZlNGeER6?=
 =?utf-8?B?ai9icnAvTGd4RzVOT1poRFF5T2hDdjZrZ0VjV1pOOTZiYU9lQVQ5SUZwNXVO?=
 =?utf-8?B?THp1NGtTNUpNOTE5eTVpMXh4QUxMc3d4WDlxZU51RmF0ZUp6dGxoQT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e84d9e-2613-4647-9564-08ded3a63447
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 17:13:12.9373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1YprOfTbqFUZtUfD6zVE86gJNKrhmt6g+PR/11PvvR9EwK7IuIXNqpxG6cF3dvVxSyqb+fOJEGpaAmRJGB+2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7483
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 26 Jun 2026 17:13:19 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23287

On 26.06.26 18:33, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes an issue when building swupdate-config* for two different
> architectures, for example arm64 and riscv64.
> 
> The reason is that both package are ARCH all and provide the virtual
> package `swupdate-config` which leads to the following error during
> installation in the rootfs with Debian sid:
> 
> | Building dependency tree...
> | Reading state information...
> | Package swupdate-config is a virtual package provided by:
> |   swupdate-config-qemu-riscv64 0.2
> |   swupdate-config-qemu-arm64 0.2
> |
> | E: Package 'swupdate-config' has no installation candidate
> 
> To be compliant with the Debian standard the conflict field is missing.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> v1 was 'swupdate-config: Set DPKG_ARCH to any'
> 
> Changes v2:
>  - set explict recipe name in image creation
>  - remove DPKG_ARCH setting in swupdate-config
> 
>  recipes-core/images/swupdate.inc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 00e972e..006d622 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -59,7 +59,7 @@ IMAGE_PREINSTALL:append = "${@'' if bb.utils.to_boolean(d.getVar('SWUPDATE_SELFB
>  
>  WFX_URL ??= ""
>  # check for wfx url to enable support for wfx backend based updates
> -IMAGE_INSTALL:append = "${@' swupdate-config-wfx' if d.getVar("WFX_URL") else ''}"
> +IMAGE_INSTALL:append = "${@' swupdate-config-wfx-' + d.getVar("MACHINE") if d.getVar("WFX_URL") else ''}"
>  
>  IMAGE_INSTALL += " swupdate-handler-roundrobin"
> -IMAGE_INSTALL += " swupdate-config"
> +IMAGE_INSTALL += " swupdate-config-${MACHINE}"

Shouldn't we then also retire the virtual packages?

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

