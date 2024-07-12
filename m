Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E7DC2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 07:16:50 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.71])
 by mx.groups.io with SMTP id smtpd.web10.2538.1720768607147345540
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 00:16:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=u7yQJ/y6;
 spf=pass (domain: siemens.com, ip: 40.107.241.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N5m7uLvUwupUrL7IRtm6py+60Ek9y8IzoI9zESZuVTIcaBo5+F5yDiGqx7WuKOQ8dR/c7ZHltLojBngJTDhdeLxGbs/qfA65AwUXPISCCA1yWxnht0IOq99WhXjyHrp0Mnr5e5glo6Q6HY7pe7oB/JgreDXySmuH65msk1dOxm5/siOcwMSVGodpzr2F29NEDflc/7WTupE+C5cpCCoOwTVpV6Al+dgqAxP4C47PkKmjSpdivk30jlazT93v3fRy46NsxYkX1fkDaOrXwb/YLNe5bG3Lc1bQBn0npgS2z9a7akC2ZNTaVP2PSY/4k+Ka5Xy+Y/Ih+d7D24h8+WyQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMt8lpGAKGPjZDpUc2C7fbkSfFdvE0iUJgKgZVa9yJU=;
 b=TE/fo4Z9Ru8dWLwkYYXVfa29AA4+Zl0ijHhawCSXXwEI3jdFgXUAJvz/3Fs954grc3+WU6lyJ9uwEo+jvt1hDc2cuxQ9/FS9p0/G3jc8r5q0YGAoWXgQXUScJr4es8ZyJA0aXFk05KNZUIuIUWm8w9j/xj8JApajD4Y3JMMq1aDFuHQh82delqSLXub95sP0RoOjybfbQPTVGSSwVIStyMgTdol5zyhlHBoGRnc7zF9pRb+uWifeM6zWRngzkFEfVxCYlvafdWTiYZu7NSZwEis88IkprPBr84eyP3x56FVLNMXQNR/qtNf1EN73HO7EhgOn+xCDQo/Th/T+Sndzxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMt8lpGAKGPjZDpUc2C7fbkSfFdvE0iUJgKgZVa9yJU=;
 b=u7yQJ/y6vtED82nekrzO6IZ4sgnjx+Ld7WcdZBS9t9bSl5D8rkqg6bssl16RAUIhhjGxRNNOgQmRP5zLg9fSUKsjIcNw5Pi/mQPgoSxMYHj89wwnI/Z/1qeg4OXkd7rK9HyqFTv3WJ+PG3aBC44+H+f+3Otdv/13RWhFSDd67wfq/c619Do0gjSgCCuiQv6v2Uy6eTGjhTGZEI+qCrC4EF+OUrTdGIBYqk0cSr3wsHU1Qq0d2lj042MShdDAVZY3ZfOowOfc6VC5/ZCgrbdPL0RRVEsonSnXOEu80Y1XjM844ozCrj7hN5eZyOyGjrnZ+r6b8x2U9wnhmu0Lby9MdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB8PR10MB3353.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 07:16:43 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 07:16:43 +0000
Message-ID: <e12e9483-1853-4b91-8d86-bfd58a9ca001@siemens.com>
Date: Fri, 12 Jul 2024 09:16:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v3] kas/opt/expand-on-first-boot.yml: add
 an optional expand-on-first-boot
To: srinuvasan.a@siemens.com, cip-dev@lists.cip-project.org
References: <a77eabfa-9ed7-4787-8c77-46782aacafa2@siemens.com>
 <20240423145409.175324-1-srinuvasan.a@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240423145409.175324-1-srinuvasan.a@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0380.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::8) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB8PR10MB3353:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b876e9-020a-4741-6504-08dca24294d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c29SN3R1TmxERVNra0U0amZOSHJ6bnpEOXVOWmk3aGZFbUNIZFNuQjd0ZTRk?=
 =?utf-8?B?amQ0aUlkWnIwb3hWUldQK3M5MklabmNxV3IrSzZJNEJhcVBGaFRtZ0pDdm50?=
 =?utf-8?B?bmJTUENmUFJpR01vcEZQaDBreGZzVHRCQmd1RUFSMDdST3BkeUk0SzIxdVR4?=
 =?utf-8?B?RkQ4eHNQUHJuWUF6NXUxMjcvRHlrbTFMOGsyTzhPR0g0N2xoZWFqK2s0Q0Ru?=
 =?utf-8?B?d0FqRmlZS0ZadTAyYjcwb2NBSVRFczRJTEFYQUhXeHprSnF0cm1uZjRZaTBz?=
 =?utf-8?B?YVNibmdKZU5RaDcwSWtwVUZYZGRKZjUvOGpPN0xySmdnV2s3TDR0M1dxdUFD?=
 =?utf-8?B?SG5OK2d3NXhMMzZsZzZaelZvMFh1Z2lhNksyaGYrSmVSTHF3ZUovc004bDRW?=
 =?utf-8?B?bTFSOHp0QWpXZlkzc0ZKVnJnbHVhZGVCUnNTNEgwTXEyZXVxNVJmV2xOSlJX?=
 =?utf-8?B?ck4rOExkbGh0OTlGOTBOb0VpVFloQ09RSmlZZVc2Z1VhMldwaDJ6RzRNMXNx?=
 =?utf-8?B?bk04TDFiUWFOK0VEZm8yemhRNldJaThseU1nYTlXQjRDT2o1UU9tQTlmSER0?=
 =?utf-8?B?aE5JMFRnaUpVUXBXWlBjNUdQMUFaTit3aVljazd2QzU4WUt4QzVUWkZGTzhI?=
 =?utf-8?B?RUU1TU9QTWx3Q1VyMGVjcTk3SlJudEorN3JKaFJMem04YytWZlRRSS85dEF6?=
 =?utf-8?B?SDdiYWxGZThSR2h1bERKMW5LNklvSkk5ZDFPR29BZ2tvQ3QxWGRZNTRITXRN?=
 =?utf-8?B?WGc2QWI2N2NDeHNsVEhaVFN0Wk9VcnNqZE5TNWw0V0l0ZklpRk1Mdm1KVlFU?=
 =?utf-8?B?MHRyUTUwTVh6dnozRlpUc0I4SjFad0NsUDlJU21XeTVZUlFpU1FRb3ZhQThS?=
 =?utf-8?B?ZysxQjgxdWY3QW1DNWpCak1wVjUyUCsvaXpLUTJUTWl1UjZMd0RHalBPemM4?=
 =?utf-8?B?QlJmeFpIV0tsd291cGlYckpBMWE2TjllYVlZdWxuNzMzOWFieGVKY2xNV3FJ?=
 =?utf-8?B?SjVuZzhoVjNENlFxazAvbUtEQjAzcVBvNk9JYkx2a3VBMTNhUnY3Z3dDeDFk?=
 =?utf-8?B?aEZZWThzN3hZaHZOeDlUQXRlaWRidXF2aExBOTlXdjQrcEFSTVdrdGFqaDNp?=
 =?utf-8?B?enVVMFNrRkhCK1pSR1Y2OWdjeU1RTHFsM3k1dWw3bzN0MDcybHgvbXh1c202?=
 =?utf-8?B?TVVpNGVUL3lwcjlWS2NMZkxxcUJsQ2MrNDNNTjdKSVRzNng5WUtIeVlzdWdu?=
 =?utf-8?B?SklXR1paVDcwMjk1bDkzcGJpejl2OVVLWnlFbTFPbjhYdXYwWjZNcHdWT05p?=
 =?utf-8?B?S3ZTSHU1YXUwNmdmVFNZQUx2d01NM1YydGw0amRtSnRBSGd2R1FvQVFMNnlD?=
 =?utf-8?B?R3B4enJkR3dpMkdUT2I3Ry80dllvL3kvZzF4eS9hcGgzSlZCWnNoUUFWa21a?=
 =?utf-8?B?RWIxUDBVZ2pQK1kxK3VWTTBaNmJPendrRE0yV3k1d3Q2alpnV0VMa2ovb3N4?=
 =?utf-8?B?elhUZEhORjlWelNydW5vM3A2NytZekZ0aHh2T3FCbFlodEZPSG5zallubFNS?=
 =?utf-8?B?eWRrSEd0UlZuLzVEYWF5Wkp0RCtWUC9MRXA3Mk5hQm1xMk5TcjAxclZtc0Fw?=
 =?utf-8?B?ajBKUSt3b1NCOFU4N0hMZEs0dEFsYlFINVFnRWNTbjlyRDRzKzMzTFVrdHYv?=
 =?utf-8?B?cXJ6bVhpWjRhcEtnRnlHTTR0MGVoZElwR3UxODBRZ1hjTGl3U2o1T2s3bmwy?=
 =?utf-8?B?cTBhSnhITWtnVzkrYTVhWjIvMEpGMGMwN01Fam1KaEFaaEk0cEhFN0pXSWZH?=
 =?utf-8?B?ZXNoODJncnB3b2N2bmQ2QT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WDgrSFpBSjJOR2F2b1YxdldFUkl4WndtMktlK2ZHcVkwK0JKRVY3REw1V0w2?=
 =?utf-8?B?RE52am9ENDQvaEJBNFFIV2NBMGw4OEVKZVJTTHhiMG96U3d2NjBnZWwxTlBt?=
 =?utf-8?B?SzlPOEp0cGE1UjFycmJ4WVBsclhQc2hkaHczY2J4c0FRZGh0Y2ZsRjRqbTdO?=
 =?utf-8?B?dGRQR002anBhS3BrMDRnZ3dESUc4dXMyZ1hnN3NZaWhNTnZGMnZWY0dXY2E0?=
 =?utf-8?B?eURNN2toYzk2RU4yNmxraTJmdm02MzEyNGRZMWlWbW5vVnRnN0d5YnR6d3o0?=
 =?utf-8?B?VFM1VmwwcHc0V0N4R3FCU1FwZ3ByQit1cWV5ZzZKNUlkajlLRUtnODJ0emZX?=
 =?utf-8?B?Z2d3akh4cDFveVVBZDdKTFh4Yk5lZm9vcGtJVDErc2tkU2ZzM1ZxQlBPUW1M?=
 =?utf-8?B?R0F0a3doNmJkY2wyVnptelhhUzN5NDhtd0hTaExSVVYwSXJZK08zaGE5bmQr?=
 =?utf-8?B?c0FtK0hJRm5Xa1RhbmV1K25YdWJSZHZzZzF1dzBBNXMySm1rVHFBa0ZBUDRO?=
 =?utf-8?B?Y1FncjYrMkc3enY1MWgvZjkxUlVBTFExeTNmaFNyeUF0eXA2SVkyaGlZTCtW?=
 =?utf-8?B?TmMwdWZaRGtFNm81b09abHMyeDlnTkdPTE1OVmZ5L2hCcm5qNzlOZnAzT3ly?=
 =?utf-8?B?WXQ4QTdobEJLa01YV2dlenYrcjVSdHRhemdlaW51ejJqaFVBMmd0U2J6SVBQ?=
 =?utf-8?B?dFFLelE0UFBXRzRrbHhjUmdISWRqR280ekMzQUpTbHhNQTYxV0F3SHVremJj?=
 =?utf-8?B?MnFvWHViQ3hqWWtXV2puUm9FcUo4azBzZG1WeTBBUDFUMzdpNkQyWFR6M2la?=
 =?utf-8?B?aGtkTUtkN09uWTRDWjh0Z1EvUG1reGlEN2p3VG02dXVYZ3p4UHk5WTVmM2Nt?=
 =?utf-8?B?WVAwdk5HK2YxUEJCeEpWeTNLUXZad0tsVU0wV29pUkpXWmIrUEVaZHNOQ3VO?=
 =?utf-8?B?bk1FSUdjV01ZZEd1ajlmdmdGMC9yd0llbng3MndDcmFqTzR4cjFMc1dZU0pm?=
 =?utf-8?B?ZlJBeC9lQW9MMmwxMm16YkdpVmMxeHFWdkx1bGc2VGFvekZyS1c2L0pGeVEy?=
 =?utf-8?B?Z3FCcHZHQTFtK2FHZ2hjVjQ5TUcxTWxHbHEyQUpCVzNiSWpNb2hNSjNPUDFa?=
 =?utf-8?B?aEk5TUs4cm1XVnZzZXNrc0hNS2hRdXJwWndyenJQK01aaDZ1bnJsd015a3hQ?=
 =?utf-8?B?VzE3a1BsUG53VDVLTTRNbkhLVG9IK3BQcDdZL2kzSmFMejI3bzdSYWRnellM?=
 =?utf-8?B?ZFh2SGlpYzJOWjY1RDRpd2EzOHMyQ29tVjdwVURrTGZJdzQxMWN5NmNsVENO?=
 =?utf-8?B?Y2RBd21TVHF3QkJ2SHVYZW1rWHhmR2hTck4zaDRmQ0duZkk0QldvTW9tMDl5?=
 =?utf-8?B?c1lVR3ZvUjVKS01JQStmcnJKT2ZHTThSRFcxekZKYzNFbHBJemlKV0hLOXRL?=
 =?utf-8?B?N1IxbXFMdTl1UzlYUXJGS3g1SUdYcDVmWm5BZDRSVEMreVc5b2hHZ055a21j?=
 =?utf-8?B?MWlSOUtSRHpZV1pmOEg4dDlNMFdRWlV1dlFBUG00cUZJbzVkeHpMR1hpSUtt?=
 =?utf-8?B?VVJYWFgyNHBwY1N3Q05IU3IrckdzODJXb0creTc1bmdSTm0zQmZFUDNvT05Z?=
 =?utf-8?B?N1dOeG5CSFV5cTMvNmJxeUwrendmMi8wV3dGd3pJTXNXb1V0R1EzM3c0VUli?=
 =?utf-8?B?dWYrZHNSdkcwL1l4SG5sY0R5L0Q1WnNDMVRZUXhPZlJxUUxDRWkvT1FIeFFy?=
 =?utf-8?B?YU9vTStLZnlpQnc4VVFwbm43SDNNcExNV2JBS3RLZUpndDZiMGpKdVJCR0dv?=
 =?utf-8?B?Q0dXaXdiV2I1TVpDMVlyb1BPeHpGTlJ6ZGxjbENOaXJ0b1BQcVI4OXlCYTJO?=
 =?utf-8?B?dkhWUmtBaTNqQTlLTi8xWTVrRVN5dTNWTUpWUmpzelJaSHRhUlA4aDhVTlJ3?=
 =?utf-8?B?WUJ0WTJNellReTJpeDl0aG5jUTdRWWFRMWlXR2hSN3o1d254OVVTVTlyRmpH?=
 =?utf-8?B?THRxdWF2a1Ftc29lK1ZRaSsydlAvd2t1M0lEUzQwcHhlZDZlbkxTdjQ1NXMy?=
 =?utf-8?B?VFZQRGMyYVhGSzdOREZyV2REQU5xdVZGZS9WMVdUUjdkeUdoL3pSazNHeGZy?=
 =?utf-8?B?ZkpXNU1xeHRPMElaTUh1LzZuNHZvaFpWWEpyZEpza3lBZ1pZMkNnUVVQY21C?=
 =?utf-8?B?d1E9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b876e9-020a-4741-6504-08dca24294d9
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 07:16:43.0316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O91feuibIq1McLcOyz1UZFOVC6su9pg9hREj6dEfF501qoFBN8+zL8sLSutN10/8TdPmIky7QSkUqgRyC5LR4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3353
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 07:16:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16451

On 23.04.24 16:54, srinuvasan.a@siemens.com wrote:
   ^^^^^^^^^^^^^^

Your local clock is off. Please fix (ntp...).

> From: Srinuvasan A <srinuvasan.a@siemens.com>
> 
> Add expand-on-first-boot package as an optional file, this would be
> helpful to understand/debug the expand-on-first boot specifically w.r.t
> LUKS support, this systemd service expands the last partition on the
> boot medium to the full size of that medium and then deactivates itself.
> 
> Signed-off-by: Srinuvasan A <srinuvasan.a@siemens.com>
> ---
>  Kconfig                          |  8 ++++++++
>  kas/opt/expand-on-first-boot.yml | 17 +++++++++++++++++
>  2 files changed, 25 insertions(+)
>  create mode 100644 kas/opt/expand-on-first-boot.yml
> 
> diff --git a/Kconfig b/Kconfig
> index 96f590a..282fecd 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -151,6 +151,14 @@ config KAS_INCLUDE_DEBIAN
>  
>  comment "Image features"
>  
> +config EXPAND_ON_FIRST_BOOT
> +        bool "Grow last partition to full medium during first boot"
> +
> +config KAS_INCLUDE_EXPAND_ON_FIRST_BOOT
> +        string
> +        default "kas/opt/expand-on-first-boot.yml"
> +        depends on EXPAND_ON_FIRST_BOOT

Broken indention - I fixed that.

> +
>  config IMAGE_TESTING
>  	bool "Test extensions"
>  
> diff --git a/kas/opt/expand-on-first-boot.yml b/kas/opt/expand-on-first-boot.yml
> new file mode 100644
> index 0000000..03d666b
> --- /dev/null
> +++ b/kas/opt/expand-on-first-boot.yml
> @@ -0,0 +1,17 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Srinuvasan Arjunan <srinuvasan.a@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +#
> +
> +header:
> +  version: 14
> +
> +local_conf_header:
> +  package-expand-on-first-boot: |
> +    IMAGE_INSTALL:append = " expand-on-first-boot"

Thanks, applied with fixes.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


