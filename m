Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD192C0219D
	for <webhook@archiver.kernel.org>; Tue, 11 Feb 2025 11:50:29 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.67.19])
 by mx.groups.io with SMTP id smtpd.web11.10485.1739274624395779616
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Feb 2025 03:50:24 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=kckm9Smt;
 spf=pass (domain: siemens.com, ip: 52.101.67.19, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BHPDwdtjJiV26XJhUGAZT41yEP49gcHnglMxnwQCCAX3J3hIQUZDOx7ulW6eS4ersjrfou6tp+b4YG6y+/K/TGsuglDIR7BccjSLieogMoOaqp4/NQt5Ov5mKuGyUmAD39K1xlPTKaT/3ctLmmf0qlPenTH53AVM2+ER64dW12uKpL5o4fDI3NHQtU6Hs+dWx0igAEtuzZLQ2ECl4VeSCAlIDPsZHBUVWMK//6sK0Gf/owJAR4jQo2j7BB1wyHUX894IB6ORgw7RO2xlm9k5pZubhLf/yrqj1kWyz9vwqMDeYyacgN3klh5F4mMt0//LobPjiOihDiCscHGJI5gSxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EDP8Rl9Gl0nA+3sJphM5SKMMsxlwdetdlmYcqWyqKsU=;
 b=p5Sh3XyruFn58iph4CRYCLnaA7/QxB7rMpEO+fZsFETh/eYUwRloVxgvSCzMKZMIxVFKrqsr1qrvPvTVOSxE1MSG7rk8+X3MesuXzo+yobYbr9OVEpFQVoCUAtHxidDL1UMSYvi34g7nfg+R5TjvHHp4W3W9G4gfKnSi5SwAizxE+p7eX0y6YktJZIF+uvGdYgrH1YPJlAPJOKbGas/l8pPJQZkl+kiPrQuTdvADM5xR+gsZ4U9WGu88fotwMoTw1LI+D2aDnOp81djcYRgdeWi/EyyhHX6v+j70nA4DjOPFDA3doLS9TXFMFZaD+mbLqZCa60okBVjp7DI6jMLFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EDP8Rl9Gl0nA+3sJphM5SKMMsxlwdetdlmYcqWyqKsU=;
 b=kckm9Smtk7aAE/zfpkkUjF1nMLrKfYkZr/2+z4UIQftuU284NMDXyLE8wofeQ/MFMj5xHDVdAvFNBwqDiXxJYhB9j+jHCX+Mdoof49SHjAQ5Y3c2UPudHo1efKvgk8XJqffpFJKCfCg2tkIhjRaVoHBQnLUL6UVVcDTV8ExECD0tlTG0V/tBA9jnWGik1wSq5sDJrutm4Lj+hKPIqexpoP7BFghpAL8PBP4fGbqGMiGiB1CQgKtwOt04/+l80WWHVzzad6RRqLPeqSrJeiQ1DSwKGHhdixKXc+7V0kICnlzAGzfGBywzu5voWjQvics/QAV4hPJMyaA2MDU5GojFng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7784.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.8; Tue, 11 Feb
 2025 11:50:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.8445.008; Tue, 11 Feb 2025
 11:50:21 +0000
Message-ID: <b461eb63-cedd-484b-9303-8d1407385a62@siemens.com>
Date: Tue, 11 Feb 2025 12:50:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/4] read-only-rootfs: Make
 IMMUTABLE_DATA_DIR configurable
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com,
 ludwig.nussel@siemens.com
References: <20250211085125.22154-1-Quirin.Gylstorff@siemens.com>
 <20250211085125.22154-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250211085125.22154-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0046.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7784:EE_
X-MS-Office365-Filtering-Correlation-Id: e26fa2ff-7c4c-4b62-8d7b-08dd4a92432e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?ZjVXNFZjQUVON0kwV2FvcGhvWjdYVCtyYlZneFV3RU5JNlg1anNKemQzOEUx?=
 =?utf-8?B?R2xXOWwrSWhndmh6V20zWHVWT3RCbW5ldHFrSERncmpJdUxXcmRYeHVMdWJV?=
 =?utf-8?B?RUtQUWI2VHZQRHNtWTNzelgvU2dJNUpDMHBJc2RLMlFXeXE3eGZyRk44bUN5?=
 =?utf-8?B?MUM2dTBVRkcydWg2dUx1a09taWRnTmZPdVRKaUc3TkVIMDR3ZkhLblFadCtw?=
 =?utf-8?B?VGZkRk1ERjBJM0pkN3htTGpRQXlBRU5GU3J6eDRJWXZJWlE3bFcyS0Y1dEdn?=
 =?utf-8?B?SFhRUjNxYlJCdDVlVW9rVGxmVTZKS3Y1T1JVNzZDalVGNFlqa2FYc0p5STE1?=
 =?utf-8?B?SGpHWWtLUWYyTEhISUlnRmdYMHJyR0xkTWtERk5yU0xJNE9OdXlYTDB1Uzdh?=
 =?utf-8?B?WGU5Q0h2a3FVYkhoVWQ0UzhDREU5djArSXYyWS9pR1dWVURqSXdDNmM2Z3VT?=
 =?utf-8?B?YmtNS0JmV3o3ZFVlSTR4cXIxckVuWXp5VUxENHNCU1UzSVpHeGl3TGpzL1Jl?=
 =?utf-8?B?a00vUTAyejFRTXpnWUMwMG9Bd3lHVHJsUWpjVzNtQStKbU9JODJWc3BXbWdM?=
 =?utf-8?B?RXMyWm5pWFJFQkJRNmFiY0grMFc3TFB4c3h5alVCRk80ell5RXFpVVhicGZI?=
 =?utf-8?B?UW1YaDBJLzNaZUxqeE9KSkcxeE9MeG82a0pjUnVCbE55SUowQVZ6QVJLNlk3?=
 =?utf-8?B?QnhoZVRORGtuTTAzbm5vSUlnZ3NvRUE0MkVDRFRTUjBZbGpOeHRPcHJoQVVF?=
 =?utf-8?B?SG1scGF3R3lUV0xsUWpsVWx5bzk4QjJyTzdZY0RvaDNuUE5EYThRRHpvMkEr?=
 =?utf-8?B?UHlZTkk3TitUYXpvUlVxK2Naa2hnTUR6bXVtci8rNGk1K0ZlTEtNNThCZ1FR?=
 =?utf-8?B?V1dhN0NFc2xPVDJTOUhadmpTQWs5TVlkbktXOEhzRUg3TFh6Mnhxcm9Na0JK?=
 =?utf-8?B?Mlc1ancxK09UQ1RBWlNaMzdqWEM2UmxWY1N2Ly9rK3Yvak1ReTZObVZDTkVs?=
 =?utf-8?B?VWNRRDhSZVAyTmkrNGFZYjBtaXZadFoxd3RDWmZXZXJ4Y0dDcHRkRU5hT2g5?=
 =?utf-8?B?cjB2bnp6dkY5TmVkMzhuWEVEVUViOHZZaktiY2tkdCtMZFVXVld5a095VEND?=
 =?utf-8?B?eTdmOWh4Y3FTT25mMENPUVk5YW1Eb2NXNUtJbGdwblBubnJ2aFV3QmdQZk81?=
 =?utf-8?B?MG43VlhwUUErN3lkbWYxMUExOTRid1BWQU9yN0lrdFplTnJ0Y1B3NTdUVXNP?=
 =?utf-8?B?T2FkR0JhZUUxY1l6Mzk1QTV5ZkFyVGpKUW01MktndEU3RGtYdDZrMHc5eW1L?=
 =?utf-8?B?c2tFb1NKQzJDckxjQ1ZZcnI1ZkVKV3dIdGZsditjREZOQ2htaElueElET3Mx?=
 =?utf-8?B?d0RxZHpDN25TWjlBRzdjcFlLQ09wVWMvYjA2RkpUaGRaQTZUZHRmd0k5K3VO?=
 =?utf-8?B?NUZxeG5talNLb2pqbmpmMkNuNUFLUWpwWXhPYUpGaXZSWVJYQmlBd3J1M1V1?=
 =?utf-8?B?ZGlMbEIwRDk4RStMS29xSVNTenE3TVIvSXhsTllOYkZXMEtLdXFYK2k2djY0?=
 =?utf-8?B?dERUbjhBd0doV1pqbmhkOEp5ZDkrRlVQRytqMFZsMGpBWEZCcEsrK3dzdWcy?=
 =?utf-8?B?YkpVTC84c3pobVp2TUttVmFKMDBmT1pwUWdkVzduSm41ekdTdExSOTVrd0lh?=
 =?utf-8?B?T0kvYnVDbkNuSjZhNytiQXdhckN3RlJsT3dVM0lHNkVMRE5oTHE4dHE4VmdU?=
 =?utf-8?B?b3V4NmdnMEZaaWJGL1Z5VG5TOFR1SGYrMkpwd05wdEV6SmdOR3huUUhTZEl2?=
 =?utf-8?B?NUNZbTVkMlFqV3ZzaFE5T2xicmN4VnlUekZ0K09lV1pBLzNyd2kvVnBzcW1y?=
 =?utf-8?Q?640kqosX6Q+xJ?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a0FQL0JGR0ZDQTF0MEtMc25NZXpsVGhsOTJ6NHJqOWxvc2VJNkhJNHI3NnB6?=
 =?utf-8?B?QUxWd1pVZStCZXhoZjlROXR1R2M3NStiNzlhazQxcjZ0QU1VRjRHUnlpdFZk?=
 =?utf-8?B?VVRsaXJydzZsTlVCV1ljYTRnaG9iVmJ5ME4vS2wxMm9WR2EzVFliZDQzKzU0?=
 =?utf-8?B?blpNYVNCTXJ5L1QyMGZMbUM0KzR5T1Znbm9ldzMwV0lycHViMlNNbUJIUklU?=
 =?utf-8?B?NTZNQ0ZxQzlCNWhoaUovKzVSV3hsWXZyNmExMmh5YlpnUVRzOU4vaW5mMmZj?=
 =?utf-8?B?MDliMEVrZlFMc2hnbEpyUEJLZlBoRitUL2xjbjN4YjM4aHkxYlFZeWpPRWVv?=
 =?utf-8?B?L2FBSFdHV2ZKeWg3Wlp3S2RaaHJuRGt4b2VHaDFTWGdpN3dpTGVYWU9zdWRq?=
 =?utf-8?B?UmtJSWVuK2dqL3dKTWYxbno5R004MWg5ZTVpTk1vUFRnRVR3dEpKeEwzbjZw?=
 =?utf-8?B?ZDkwT3FCMXJNUklpbVBwKzN0SDBxT0QxQTRMWC9CS1JRVkw4aVlMTjlDSExU?=
 =?utf-8?B?bThMSkppVEw5VkJ2cnUxbUZEc0Vqdi9GM1ZFVnlEYlZrREQzY0x0cXlsa2pE?=
 =?utf-8?B?OXcrcVNUSU9PKzQvT0hGYjZvRFdZQ2wyOVRkV0pEYlhiemQyVHhwVXpaaTVM?=
 =?utf-8?B?MVdGdXNYZ3BpNmVKR0kwMkh3Vi9VVzJ5ei9oR3hXNGcvVEd0T1FPVHRER1J3?=
 =?utf-8?B?cE85MHh4WnNEakRVZTlRS0JRUU5YV2tnZ3BuVUdHZ2FUc1JGL1dqY0lnZkw4?=
 =?utf-8?B?MVVwNTRmamlaeDR1QTdYblFkd2pCUnlSeUVkblZSNzZpQllCNFUxaFJmc3dK?=
 =?utf-8?B?SFQ3U2M4MXYxc0NQZnV1S1pZMUhMeDdrUXQrQnZ2MlpiekpzTEFGT3R1d05a?=
 =?utf-8?B?STRJSzlOWHc2Vi96OGtoS0I5WDY1RkxXV29GK0QrUnpkUlJLczJ2WG9pWlVN?=
 =?utf-8?B?TWNsOUVUKzhTTXJ6anFEM3BYT1J2ZmlFQ2dEMDFVNjZ5T0lEWTZEbnIraDRl?=
 =?utf-8?B?S0RKYWxrS0pJb0tpcTFrTWxuOFUwU2RPd1BBZFBpWGZ0V1FGSmcvbmV2Wjhh?=
 =?utf-8?B?Z29zMCt1VWhnd3VZLzA2c09LenRPYU5MQ1E1UmlXVHMrZEIxeVFGampBa0hQ?=
 =?utf-8?B?Q0RvN0NLSUp4WTBmK0VRaXZMSGlRT1RLQjJFdm1Nclg2eUoxQWhrbSs3cVZQ?=
 =?utf-8?B?NUx3cDJ6Ky8zbWtIZzlaU29zelczeVdrYUJjc2U3ZGlDZmwzbG15Ymc1WG41?=
 =?utf-8?B?OXczVE9hRnZUOWYrN1JkOW4rQ0Viby9OdXJBbDVjS0JFV0FuK1lUR3hVWmxF?=
 =?utf-8?B?MzZtaEF2NEovMlkxMTAyeGRFVUhueG1iNDBSdk1zMDZjT0pMb3pRQWEvV0tL?=
 =?utf-8?B?RnBKYi82OEJBOHF4QlFUTDJ2WGRzTHljbmd2eWV5dU05ZGgzbnUxUEFXbml5?=
 =?utf-8?B?TWVEVFBBdUp3VmJLVFFJWWdhVHpGSmUwN0ZKMjRZaytJYWEvcHh3cFpnZlJK?=
 =?utf-8?B?UzJPREROdmFzQUZkdkRVU3pOVWhvQmlLNWMxMkxla3VQa0QxcllyckxabDc4?=
 =?utf-8?B?M2VERXdGbWR5dFIxUjN5amlPNjNHYk85TWpic0xJdVp3V2RSNUxUZU5WWHNs?=
 =?utf-8?B?QVV5THB5NTg5V3JNU2k1VXQ0Nll2R1d2MGs3OExIR0pBWTJjQzUydjFSU2Zm?=
 =?utf-8?B?cGVsLzVtSmFDeG11SVRLSk42QTRxREVCSldlSzkxdTBKcW1vdzZrUm5TSmpX?=
 =?utf-8?B?R1VYWWY3VW5xOFRJMG9CN0V3TlJVQjE3SHdXZDdFTnZ4WTd1QjlFRXJqN0lL?=
 =?utf-8?B?eVIvNUpSRGk3V2pNRVZsdXloYVYrb3Mwc3dCa2t6Qy9zbXVSNVZHdC9HWVpi?=
 =?utf-8?B?UytTT1NtSzJPRmNKYkU4VndmRU9rcmJubUlDZm85Y3hZUXVaMS9RV3BnTUE0?=
 =?utf-8?B?UUtKR0NDUHlyVmh5MWZHVW83ZGw4MEFueWUra28zbWR4bE4yb0JxZWhIdWxO?=
 =?utf-8?B?Z3F4cTdwakwzTXFIOEd3NkxZVlMzQ3g5ZUJlOUYxS2Izd3dZOEZVOXh4MmpG?=
 =?utf-8?B?ZzJFSmFGUi9KWm1lSStLMmVrZGFQNWdCRENXb3Ntdm5XS0hnZE1DZExUQW9M?=
 =?utf-8?B?SzhUb0M3bHdlcFQ5cjZvQ0R4NWtDbjQrZHltdUptTFI4cVRnVFZDZUIzR1JG?=
 =?utf-8?B?b3c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e26fa2ff-7c4c-4b62-8d7b-08dd4a92432e
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 11:50:21.0720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LryOszM21ac5OXDSb2XdFrOsXIwSx6+NaoJsJAf52h4fCwLagQKp195WCqmZcGaTsxRcs18fXskmSb0pekGBmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7784
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Feb 2025 11:50:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17809

On 11.02.25 09:49, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows the user to set the variable IMMUTABLE_DATA_DIR.
> 
> This allows to set directory as requested by issue #124.
> 
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/124
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/read-only-rootfs.bbclass                            | 4 +++-
>  .../immutable-rootfs/files/immutable-rootfs.tmpfiles        | 2 --
>  .../immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl   | 2 ++
>  recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb       | 6 +++++-
>  4 files changed, 10 insertions(+), 4 deletions(-)
>  delete mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
>  create mode 100644 recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> 
> diff --git a/classes/read-only-rootfs.bbclass b/classes/read-only-rootfs.bbclass
> index 35a3ab3..acc04e0 100644
> --- a/classes/read-only-rootfs.bbclass
> +++ b/classes/read-only-rootfs.bbclass
> @@ -28,8 +28,10 @@ IMAGE_INSTALL:remove:bullseye = " immutable-rootfs"
>  ROOTFS_POSTPROCESS_COMMAND:append =" copy_dpkg_state"
>  ROOTFS_POSTPROCESS_COMMAND:remove:buster =" copy_dpkg_state"
>  ROOTFS_POSTPROCESS_COMMAND:remove:bullseye =" copy_dpkg_state"
> +
> +IMMUTABLE_DATA_DIR ??= "usr/share/immutable-data"

"/usr/..." - better readable. And you can drop the leading slashes below.

>  copy_dpkg_state() {
> -    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/usr/share/immutable-data/var/lib"
> +    IMMUTABLE_VAR_LIB="${ROOTFSDIR}/${IMMUTABLE_DATA_DIR}/var/lib"
>      sudo mkdir -p "$IMMUTABLE_VAR_LIB"
>      sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
>  }
> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
> deleted file mode 100644
> index 2f7c338..0000000
> --- a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -L /var/lib/dpkg - - - - /usr/share/immutable-data/var/lib/dpkg
> -d /var/log/audit 0700 root adm -
> diff --git a/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> new file mode 100644
> index 0000000..de8a238
> --- /dev/null
> +++ b/recipes-core/immutable-rootfs/files/immutable-rootfs.tmpfiles.tmpl
> @@ -0,0 +1,2 @@
> +L /var/lib/dpkg - - - - /${IMMUTABLE_DATA_DIR}/var/lib/dpkg
> +d /var/log/audit 0700 root adm -
> diff --git a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
> index 2dbda6d..c61005c 100644
> --- a/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb
> +++ b/recipes-core/immutable-rootfs/immutable-rootfs_0.1.bb

PR += 0.1 in case of such changes.

> @@ -15,9 +15,13 @@ inherit dpkg-raw
>  MAINTAINER = "Felix Moessbauer <felix.moessbauer@siemens.com>"
>  DESCRIPTION = "Config to link volatile data to immutable copies"
>  
> -SRC_URI = "file://${BPN}.tmpfiles"
> +SRC_URI = "file://${BPN}.tmpfiles.tmpl"
>  DPKG_ARCH = "all"
>  
> +IMMUTABLE_DATA_DIR ??= "usr/share/immutable-data"
> +TEMPLATE_VARS = "IMMUTABLE_DATA_DIR"
> +TEMPLATE_FILES += "${BPN}.tmpfiles.tmpl"
> +
>  do_prepare_build:append() {
>      cp ${WORKDIR}/${BPN}.tmpfiles ${S}/debian/
>  }

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

