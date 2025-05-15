Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB738C3DA6D
	for <webhook@archiver.kernel.org>; Thu, 15 May 2025 13:12:34 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.78])
 by mx.groups.io with SMTP id smtpd.web10.12182.1747314748257045584
 for <cip-dev@lists.cip-project.org>;
 Thu, 15 May 2025 06:12:28 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=DqFS7qHw;
 spf=pass (domain: siemens.com, ip: 40.107.241.78, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJhdLVp2whfydHrg4hfPWMHQFE+8SIn/KvzjNihEr57B0CeKCHWIBLM+0ZJbpzMerORg6KFDwEvQqZPdgs+I/cowYl6Lr/XNkwexT1s9zfCqcmakbvrSM5vWxgaWDr+USDUjI5tAUUeY+BEUTMndeytzX6InHSyZMqA4gW29C+WnOQ+/KNl8d9r5NcvB56n3hT8MiPshET+c8OZu6Qi8+kPu0h276ceVGEJXX+Bfc3vX/xuZ5BjaOn4IDbuIbBlcURX3L/2dqNM9iKTe/yol7iaeJRRNGVN5a5cCGnjKHmY3G6v1C8vQOWYjAhBw4Rj882EgiwPqOm8m6GlhfeMT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gp2zKbO8fHv/taX3nnV7ACkpCBCtic+EWljvDDL6840=;
 b=NC0ckctmYs3lEq2aSlU+Ta647+E5R6IBlk8InuMUf07JyB8qCSxgaHcfumCRbzYmNsUivj6CdrmRfoojBzfI1jP1bx9HTWhV6KJTGPwKqISTo95hlJAY8jtnLB8u073gC/JNXj3Nyo5cPnblCWMHQy5cRBpPQ5+XLczKCUSGrmn39a8d3VnUmRAaBFuQCfYj7bQYrbHahku16ZmFSUZc3Uxhnod23aI4ArQDk93fxMZA/Okfqp42MHQ8nj8d3X1fSLNWbrN7LG0Qt5c+vBj1jVvmvTW13QdANLlSz9bED0RvqgxuQos7E2cUlobYgfbBDv3AJ+hE2W2ulpCxacsu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gp2zKbO8fHv/taX3nnV7ACkpCBCtic+EWljvDDL6840=;
 b=DqFS7qHwfjAe+4XmPpU5Htx/XJlo4pQk3tCYjlzhqHcpaf8QzzAVaggAfgEFemAgrJWcj6niRmhgaKsQG9vfqg/liZEucQ+QpBELMYLZmuUkaNQ1pSBW6jNnLeBB0W7kaDsHgVMLZxrfyNtcoYTc+GjA0km5+EzOeGcuk4GprewY3+MN+/vhaa3FzR5zoKPleXULSW3UK6u0ad4Jo2w9b3ONw1ZrVAhwIc/KZneSnQd4sdR8lhmm76Y0wYaqrpYfz2xX8+OT9G4otriRK0MwY/RbIFCfmn2IDFxQkQgoZpYaMG0jNDelqiKfPXhvMAVnd1I2VRMPSnFFB9/T8EboCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by AS2PR10MB6520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Thu, 15 May
 2025 13:12:23 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%3]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 13:12:23 +0000
Message-ID: <71648737-4e33-44bc-8aa0-c67f443a42ae@siemens.com>
Date: Thu, 15 May 2025 15:12:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 0/6] Add factory-reset
To: cip-dev@lists.cip-project.org, jan.kiszka@siemens.com,
 Gokhan Cetin <gokhan.cetin@siemens.com>
References: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <20250506120807.255675-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0185.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::18) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|AS2PR10MB6520:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbc83e4-c779-49a0-251a-08dd93b2214d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|4022899009;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?NG53c240U3JZTk0zbG1yM2JZaXlYbmozSWlMT1FQV2VLb3RUdWoyS3dORnh3?=
 =?utf-8?B?TVhTZURETXVNR3lWVnBLQ3lNMDZWZ2VoNXU4VGVRWGljVFB0aXBJbnlZZVZC?=
 =?utf-8?B?MVV3K2ZmRVQ2RXN5UHRXS1doMGUxWHhJNGU2Y2dqK2lPUWJsdG9wVmpEcFd1?=
 =?utf-8?B?MzM2cVBCSnNUMFl2dGIvRFlCcjh4MWEyTnBOK3VvTXpJQkpaSDB2ekFHbEhr?=
 =?utf-8?B?L1AwTlY1T0I2dVlINzBzSXhrRkZTWE9qT0orbTAxS29HN0tqcFNGYjdHV0N5?=
 =?utf-8?B?S09NZmNla1VybmlyVGdSdWNtTW5jVTZTalRSVDRkVi9OblRDMWx0Z3VvMjBu?=
 =?utf-8?B?dGRFVjFHalhsR0V2VGlpYjNzeE9TVWxWUmFrWExOTEFkMk96SXQ0b0toRXV3?=
 =?utf-8?B?V29zWGh6bURtS0RJdm1tcUhHNGVWdkV4RmFpZFFWRVBtRGs3eit6UW9Sakph?=
 =?utf-8?B?cFFPRm1md3VXdU14QUh0elBqT3NtbzNvMzlONDBXd2VGNWNHYjNBMXVvTkVG?=
 =?utf-8?B?MkpDb3hKdUZsUUhsSWpTdU0zVGdNb0F2bGdXWDFwTmhiKzU2bitZaEdPYlpF?=
 =?utf-8?B?dzcvcjQrOFZqWk55cFpIQ1FScGVneUZ0T1Q0bElnYTR3MGkzdzJOajlGN29B?=
 =?utf-8?B?S00rdjViVEl2UnNQSGRjZFRiTTdBM0tBS1RmV3U2QjRWc0JoWVYxRXJFcmpX?=
 =?utf-8?B?SVcwLy8zaG5IbCt0djM3VnZqU0ZWV0lkcDZBZWtRSFFCUXFkM09IdWlQS3hD?=
 =?utf-8?B?c2hvUlhWZlEwcllQdFVTcjJxMzhIdWJVZjlYN2s5VTY4MVIyZGZLTWVQb0V3?=
 =?utf-8?B?K3VrdHprc3pGcGRRVTVRcTFCNXJ0ekcxZlZMRzE0K0o2WUttc2RtdnVDcE96?=
 =?utf-8?B?SUVWVnJWTVljZy82UTZYS0hwWkVyZnpYVG5sV3MrNzdHZm5idGhlQSsxVy8r?=
 =?utf-8?B?VWZlcS9xRE9WMnZ0NllFb0lEcVNxR3B4M05mN2Nqb281a2ZCcXZXcUF1ZWo2?=
 =?utf-8?B?L3EzOWw0eC96SU5sdUNYUnlEOEpaZytQTVN5NmFOOWVDNUZ2TWs0MmxuUjV6?=
 =?utf-8?B?V1NyRU1sK1ErbGNyVGp0TVZqeWp3WklJQ2tyejQ2Q0lSekR0Uno2TEJpcTlI?=
 =?utf-8?B?cU4waGVONGRST2tCUEQ1OUhnZDU4NTI1Yi9JM3dLWTRCTVo3MzRicG03TmFE?=
 =?utf-8?B?QjF2UGJzOTZRU1lLUXAwR0pPalBwc05ibU1YVVhmaE93VjhqUUluZ3lIc3ky?=
 =?utf-8?B?aFpKU3VZTU5FMHpUbFROM2dKN2xlZHFLM2N4aFh2TmUxZ3dnd2xOUXF1ZFp0?=
 =?utf-8?B?dnZvUHJiNEQvRml4MEkyVjFFUStzQ25aei96UndseG90MHErUWxrbXZTOGE0?=
 =?utf-8?B?V3JxN3NIMjNpVmhJd1VjbXRHdVpBNFhSMFpVUkxFVWxRT3VhNXFUcy9zWFFM?=
 =?utf-8?B?d2VBejNiMXF0cmhlNjdVZVpiYm5rOGFRNEIzcHhsdGhUMW9PZGtZWWxGWXdQ?=
 =?utf-8?B?VW9qTUx1MktrT25oWlJGK0xUczlPeUlpQStjWlh1OXZaaDkvWUJldnBXaHY2?=
 =?utf-8?B?UjdReEUrNWxEQzVlK08wYkk4RGVaZ3RhamgvNk5YYTFHRVFCUnhVQmg4dW40?=
 =?utf-8?B?ZnlTQktHTGRld21zMGFGQ2JJa081VlVLMUpiS05uUGFocXM5ZXVRQUs4bmNR?=
 =?utf-8?B?NlJnVEY3cEkyY2VxdHQrelRwbEtTVyt2NnE5cWlTVVR2aGRFQnlmTE1VTytB?=
 =?utf-8?B?ai9zb1dFY3BvWnJ5S0p2MHcwWkRadzdGN09rN1E5Z2dTaDd2cDRPRUk0NDdU?=
 =?utf-8?Q?DO99eqgLbejlh0iKLBeR4o8v/wlhF5LQUmgQ0=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(4022899009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TUltczZEVDJ4Z2srVE0yVWpBSFAwemw1VVU3ajdNYmhPeHV5RTBGOHJHWVFk?=
 =?utf-8?B?Zmo3MTdYMTFVT2h2alJGRWZUdjlRNnVaWlFJVlNOdVpNNHNSSWFiWlZWaHQy?=
 =?utf-8?B?MFdLN0lMaVFYK0FuSG14bUNDakxHNlZvSFV5R2dodFFqZkdNWUxDNGhreHZB?=
 =?utf-8?B?VVM3clZkLzlUODlqQ2pLNERiZERHekhuR0Jhb3kyKy90Q0NybnJpUTdycHRW?=
 =?utf-8?B?dXprVURoVWVEcnFLd05UYm9tNW9OcWp3UGRLVUJqZUFtQWtCZ1djdGxFSTFw?=
 =?utf-8?B?bCtZU09UNll3eVNuZ2ttTWNJbHJsdllpandYNHpOaytFdldGMFBsSTRjcFdL?=
 =?utf-8?B?VXZHNU9HemtoMTk3Rk1sMUNxbE1Nb1MyTTd2aXRKa3lwaW5xN3FYS0Jta2F4?=
 =?utf-8?B?VURSMGxuZU9BeHA1K01HZWQxRkF5OGljVkRGcHpkSVZlVDhEeGdGUmtvVFlU?=
 =?utf-8?B?L1hFeVJ2TUlIdnkxdEN4SjcwL092WGxFZjdEamFFUkQzUitzZlBTM3RTdHhE?=
 =?utf-8?B?NExGa1l0dTNmdE9UU2VBVW1ZRVlEc2M2Mng1dTZNayt3RXJFdmhWM1E5M1lP?=
 =?utf-8?B?eUJUMXhSbFU1cEsxQ2d3R3AvTFdOQ0F1VmNsSjRDZ2c1d1NmSTFoSlNOV1V2?=
 =?utf-8?B?b1MyTG9oM2RWMXN0Q242YzBDajk3YVNLQ09QL0pLcjUvUEZYTXRkajZCUGxO?=
 =?utf-8?B?UEJFcFA5eEZQNm04SGlkdlE1aHgwKytpWUhvK2ErZk9uazFqQUFnUnQ3dDZI?=
 =?utf-8?B?RU5iOTNuK3ZEZEFONThjNzQrNFE1VUYzc0U5ekpBM3FGbmVJMjdNMDF2WVFy?=
 =?utf-8?B?UXpYRXRRY3lzMTI2bzhPYjMwV0toL3FRL1o2cytVNXA5U1VXcGpUb3BUN2d0?=
 =?utf-8?B?ekdISWM1bDVwc1JEYnFISWdDeDJ4L0tKQVRIM0JJUnZmREJudEswQUM3WGpI?=
 =?utf-8?B?K3NxaUFVaXdob3p1eUdpSUpiWVlvd1NNTnBHL3NidGNZWm9TczlBK0VpZjBH?=
 =?utf-8?B?NHZFRGVocXhhWUpxNHA5NFlwVmplaCtpZzBrNVVmQjlnT3oybDNSWXZCeTMr?=
 =?utf-8?B?NmNRNUZkY1k2ZW14Y0pZbktjeWFvRWxxVERCWkpxT1R2N3FGMUxib3V1TFFw?=
 =?utf-8?B?Zm1SbCtmcVI1eDUyL2FoRnBSMnBuV1hpRllKVEsvb3dwR2YySEZpSytvb1pB?=
 =?utf-8?B?blhULzVkanJmMFdwaHZRekQ2L0NPZ3ZOQTRCUG81WjBaWXNBUmtZbnI2aGE5?=
 =?utf-8?B?RzJkeGJLa3ptUTByNHlINU9aUThoaHpkVUpLOER2SWlwUXhEWkNUc1JmSEVJ?=
 =?utf-8?B?ZTUzdnhhcG40V1dNaFpLWlBtYWFES0paRzN5TU1EbTVORkZ4MkhPL3lHTlAz?=
 =?utf-8?B?UGFzU2Q0S0RKbXlqNFVkb2Z0QW5PRGJyNEpHWTlDSWt0U2hVTWQyTmwvUFZX?=
 =?utf-8?B?cndRTVNGSmI5c3U0NUVJT2hwVGlDSVIzNHc3dHp6VlY4UTcxLzRadGVxTnM3?=
 =?utf-8?B?LzYxVEFXRnFuWGdHSENPeitOMzlML09pcFU0V1NHNzNpNzY0c2lWWTlidmdm?=
 =?utf-8?B?SW50aHpHV1NrblRVdkhDcUJaVmFyc2ZBRWRoQXdCUmI4Rzk4S3JCSDBOdFVz?=
 =?utf-8?B?OVJ3SVNEUVprMk5wSmg4ZzFXUjBGRFBMV1NKcjdzMWNhcjFGNnlrM3JWeWxV?=
 =?utf-8?B?dDFkT3owVzY0a1Bmenh6QSthSmkweXdreUloQWxvNVMyVHh4TjZnZ2s5OE1i?=
 =?utf-8?B?SjNJUGovMm1VRHFmL3lnajhTTURiM3RwVCtJaEQ3R1E4eWZNeWtid0hmSVo3?=
 =?utf-8?B?bHBSV1RRMmJGUkhHMkR3VFk3OS9OUXhlQzRTbzl5bStIQnU4dXc3eEk5Visx?=
 =?utf-8?B?WjY3NDFkcVBtZ1N1bHJJeG16OHZoMlhkM3BHUVJLMFhSVUxJa1ZvZFd4cDBL?=
 =?utf-8?B?eDZ3bVUwK2RqQ3gweXdXL0Q1QXhKVjcraUx6TUQzTkc4eW5sYUtscEZ1T0xv?=
 =?utf-8?B?VTJpMkRmWDVvUlZPMGNKK2YrRkxCZGszV3dFRTNpNnZ3MkphRmpteTRaeHY3?=
 =?utf-8?B?N1N0aGFqc2h0YUZUWVJmb2UzQkcxTjZqUys5azJKM29PU3FZbjkwS3FkOVN2?=
 =?utf-8?B?NWpmTEhaNDVaWnZzT05RZXFyMEozY0FzclphdUxzQmJVU09aR1d4U3RCNkdJ?=
 =?utf-8?B?akE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbc83e4-c779-49a0-251a-08dd93b2214d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 13:12:23.0852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XelR+qdoPwSAVUQz1mUcb6t2crk/+3Rl7h1mHoQ6PK10JD4KDck81vmT0wlDrdaKvG+9pbWDTGu5btTblL2WBnkUPmt5iDR5fIC2d8MKDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 15 May 2025 13:12:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18915



On 5/6/25 14:07, Quirin Gylstorff via lists.cip-project.org wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> 
> This adds an new hooks for factory-reset to the
> initramfs. This hook will
> 
> - format the disk.
> - In case of a encrypted disk factory reset the TPM is cleared(all keys
>    are deleted)
> 
> In case of an encrypted file system the marker hook needs to be stored
> in a readable location, e.g. one of the boot partitions or the efi
> partition.

I am currently working on v3, where I replace the file based marker with
  an efi-variable. There are some issues with this approach as u-boot 
would need to support that. Also gohkan mentioned issues with preempt-rt 
with that approach during an internal discussion.

Quirin
> 
> Changes v2:
>   - make marker check a separate script
>   - change data-reset to factory-reset hook
> 
> Quirin Gylstorff (6):
>    add factory-reset initramfs hook
>    add factory-reset-helper to set the marker file
>    encrypt-data.yml: Add factory-reset information to encrypt-data
>    cip-core-image: add factory-reset helper
>    add factory-reset to initramfs
>    Add settings for factory-reset with a separate home partition
> 
>   kas/opt/encrypt-data.yml                      |  3 +
>   kas/opt/separate-home-partition.yml           |  3 +
>   recipes-core/images/cip-core-image.bb         |  2 +-
>   .../cip-core-initramfs/cip-core-initramfs.bb  |  1 +
>   .../files/detect-marker-file                  | 33 +++++++++
>   .../initramfs-factory-reset-hook/files/hook   |  7 ++
>   .../files/local-top-complete                  | 67 +++++++++++++++++++
>   .../files/reset-env.tmpl                      |  4 ++
>   .../initramfs-factory-reset-hook_0.1.bb       | 52 ++++++++++++++
>   .../factory-reset-helper_0.1.bb               | 34 ++++++++++
>   .../files/set-factory-reset-marker.sh.tmpl    | 28 ++++++++
>   11 files changed, 233 insertions(+), 1 deletion(-)
>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/detect-marker-file
>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/hook
>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/local-top-complete
>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/files/reset-env.tmpl
>   create mode 100644 recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-reset-hook_0.1.bb
>   create mode 100644 recipes-support/factory-reset-helper/factory-reset-helper_0.1.bb
>   create mode 100644 recipes-support/factory-reset-helper/files/set-factory-reset-marker.sh.tmpl
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#18766): https://lists.cip-project.org/g/cip-dev/message/18766
> Mute This Topic: https://lists.cip-project.org/mt/112647390/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/unsub [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


