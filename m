Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE966ECE57E
	for <webhook@archiver.kernel.org>; Mon,  9 Sep 2024 11:44:03 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.87])
 by mx.groups.io with SMTP id smtpd.web11.50886.1725882238756697724
 for <cip-dev@lists.cip-project.org>;
 Mon, 09 Sep 2024 04:43:59 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IKlAPzwj;
 spf=pass (domain: siemens.com, ip: 40.107.241.87, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SApHFP03eC/juwkilTrB5rIYdrvBKjabp355wlbRBWfjEKgRIhSdW5FRyjz0GXql++0W0HPle0UC0ZEPqorPblDrK1QwMceO4VpQPXu6bNN7oQQm22prQbUeyNjefA4g0DJvOrapGlRXEFqKUeDALkL+G89WrvSwuwz2WxZxmtNa9+cWyT0T02he+u/EW1tuASv81tq2yVnqPvHvEfVLDG4O8XPbWTB9ZSnQP667d9627rRy+lXrL4vH6Hkg4C0G/wogXITCRGfW9HaL4uu27JYHhyLeKUIyfXqdiQVWLUoSQgyXqF9J4b+gz71I72Sbu23Dltr6Rd6XHew4ygLSSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9WZVUGZn+1FHcNhdQ1OCylYXeV7n3wsl8P7V4WrQeIM=;
 b=bGmxTpNDxK8bXVXGxSQQNW0LJt5G6/hwUKpquObrRNPewKT5XcgIBslEnHBGzGMTN1FILHege6a4zCWSvOynUEnQ9jxW/fzSAGXUxXd0vkPYxWYOl+k/i3GNw3hyzjDJwUL2yg5mv4Yrt1+0RCV8J5g4MOjhnnZ+9s/MUp3O+o5roXkc9HpR2p4FWBcXkz0MU0vV37Q5vCRR9Y3HSwuUAOkb47C5bAy4ydmBUP3AgnovZT3P2ag2Pk5ZmWT9HJ8unnguQm5mHCcqX2ZMCqyZn6eGMcC0F+y37M7+bho1+nmrhr/sWM1Tk5gEgJND1sRAe0B30J/cFzSHJ9gf1V1JKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9WZVUGZn+1FHcNhdQ1OCylYXeV7n3wsl8P7V4WrQeIM=;
 b=IKlAPzwjXLtwR9TEIwr8HyXDIE0wAQKr1MSU1qqDss7SXij81cp55cpsLd8RfRQ8rvvHGTHvpPSgh/Wjw47rB/RJiO/gVBPbjuLDd3yv+0OTIwSe6bkpWNaMkPOTY0JkNFVLSPbZ15liIY0pE4muxUFA0Hog+Blbvc3Qy8PgeGk2Ob/fmfgmUPLWcp2iVKOixML39xLkyjl/b/4JfZZjM2Bv4m514Z5ileu82yLoh0+qgOYMQX03JAYDp9R6XXkWY27LBCeCk6B5sQI/THeznlbR/bza1BpxmQgsWhrm4k2GMOaowhAEXHWjDCtswhLFf9V5ZwwvVORCDRjpQH4tlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6381.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:bf::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23; Mon, 9 Sep
 2024 11:43:54 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7939.022; Mon, 9 Sep 2024
 11:43:54 +0000
Message-ID: <5f552a45-4174-4a10-bd2d-394b542f7e19@siemens.com>
Date: Mon, 9 Sep 2024 13:43:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 1/3] Move signing script to seperate
 package to better support HSM signing
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
 <20240909112309.1028531-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20240909112309.1028531-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0217.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: d12f98e4-75e1-45ad-406c-08dcd0c4ae8f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VHJJaktuTVVOQnBLTlZLdGcvUXM3M1p6MHBEWDhqSFVrYlJsTWc4bE53ZnE0?=
 =?utf-8?B?Wi9PTjJzblpzSW9pNkg3SjFabUhVSk9DNTdhSThnd2xRTlFNVTRFSy9hOFBu?=
 =?utf-8?B?ZzRhUmoxdXFSNGdicDlUZmpBYnhEYTJ6ZUNrUjQraEZpMUtqb2JJYnk0Y2py?=
 =?utf-8?B?ajlMQnFjZktPcThTUTFqblhMRk4raCsxbDRMeWJ4a2JQajd0dzBpVWI2NDlv?=
 =?utf-8?B?RHZCaVRON2RPU29tR2t4aWsveVpLaTU0aklNNCtwL3U5SDQyQXZUVzh5dTZ0?=
 =?utf-8?B?dVJhcjI0TktrQkFHaFdWQ2hiNDlmWndUdmxxK0dDU0ZwOEgySHJHSjM4OGtE?=
 =?utf-8?B?dmVXejJzR1pJNWtZVXhucHljS01XVWE2Q1BUMWZEVW8xWGtnL0NGTVV0L0dh?=
 =?utf-8?B?NHVGTkNVcVN3djVhdnhIMkZYT0hrM3pzSEUxRm9VeVZzekpHRHJGalpVUlBP?=
 =?utf-8?B?M0IzMW9sQ2VQY2NUenM4cy9kSEVTYUVrdDErTktJUXFTOVFONU9VZFppWFVV?=
 =?utf-8?B?YWJVS2duOXRubkdLd3MvYTZPdVl1d1BSUE5TcTg3T1d5RE0rbXROUWswZlhw?=
 =?utf-8?B?M1plVFozZkoyRy9CL3gxaHo0cFgwN1g0d0d4ZVZYekVWTzlJclg4cURYYW5U?=
 =?utf-8?B?UlkrUmJqcGQxWkhrcUV5U0psRkpicndVZ0ViL2hoR2dhN1pOcWtia0Rici85?=
 =?utf-8?B?bnlGSlNMMjBNRml6T0VpODYzRHNSRThWUHVndTFKT0xHOXRuNDNiODlDN2cv?=
 =?utf-8?B?YUdobEx3MklNNzg1V2txalJCZ1BpSUNVeU5LUU1kNXo1bjU4dEYza05WeGVG?=
 =?utf-8?B?Tkh4TU1VZitOa1pPTXdRdzErME43amt6ai9xeHZheGlhbGJnbEZnUG5sMkh0?=
 =?utf-8?B?MmpuMGZjcFJ6MkVmd1FaOERzeWdlc0hOdWUyYk9CMUtzUk90d0ZVTGxhcFBQ?=
 =?utf-8?B?SWVla25KM3J6dlNwR3Q3QmlxaFJkM2phSWlZcDJ0S0FmMk9LRzcxdlhnempM?=
 =?utf-8?B?dXJDaGZmUDJoS3dCNGg3ZklGM1lkOW5xczI0Y0hac2lwWnNzd0FpNk5YTXFT?=
 =?utf-8?B?dUg3YlFjNXowZkV6QTZYY0lIU0FBaSt6UUdwTWtGQVRuVTM1WnNFalZRRnNr?=
 =?utf-8?B?NjlhY3RzckhoLzc5WUhnVzBMajZNM09qMk9UcGZsY25iOExMMW1lWVdTK2hY?=
 =?utf-8?B?U0lGN3RPOUJ0cll5U3hkaXFLcGNmMEoyRjRxU2tLcTFKblJKOUFYSzhZem9X?=
 =?utf-8?B?cEp3bWlUcTZLcmo0MUd1cEhSeUNtdEx6RGZNY2NxUCt3TnZnTFhYTzFrZER2?=
 =?utf-8?B?QXAxRWJBNE85UWRKN2hpK2tGeEE0aklWVk9HckY1YTZ5WDkxaGZUNS83SXRZ?=
 =?utf-8?B?NVYvK2N4aUhCNmNJSmNkdGtjTzY5aHk5NHFNcjZTa0JhVG5VU0ZQdzdpNlNM?=
 =?utf-8?B?Y2FZeVQyMzgwOWtFL0YrK3lSSHBIV1ZxbEpyUlN0WlkyNFFhSmxOaEVpSEti?=
 =?utf-8?B?K3dzWWtFUURydDdJSFN2d0ErRXNjc2dwaWxjUVFkWE1lTkQ3T0xrR0ZvbEFB?=
 =?utf-8?B?RHdBTnloU3pmS280TE0wNWhuUC9LYi96K0o5NUNkOWhUV241NFI2d3NNb0Nl?=
 =?utf-8?B?Z0JoYWlmM1NRbVhrUCtadGV6bnZkNnkxOWo0a1NpKzN0Kzk2bmVEbTZ4Y3hP?=
 =?utf-8?B?RytRNFQwdUQ2c0ZVc2Frc3ZVRU9YL2c4aTkrbEt1NjBCVWJjL3pxMGsvMzdw?=
 =?utf-8?B?b1FoZENKNStVVXo5YkFuUnhsN1BsbkZ0WHJzdHF1Y0JHVVI4Y3FnMmZYSDJr?=
 =?utf-8?B?VU5CNlp2SVRVR1ZkcDF2dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Y01sZm1DN2hFT3AwczFoM0tIRFJLUFhKYjhkMTRPQk5sS3pQTkdncWMzWDUv?=
 =?utf-8?B?dEpYdUdKaVRJbHA2UzY5cVkyczBCeVdYeHJHRStpNDduc2c2ZkVKL3IyYktp?=
 =?utf-8?B?ZDBMQzRXbWNRV1Bma1VIdnI2NVdsM282SU0rYm5idFNReWpZc3ZiOXNEMFBn?=
 =?utf-8?B?TjNwN1cxUFpYL3BidE56dXkvQ25MVG9qcmZwbzBJR1Z3dCt6Q3plUFJGQmli?=
 =?utf-8?B?MENNVkZ0UWF2K2RQU3hyUkRqRVZBcVg4cUtCaWI0ODRjYURqSllVQm83VVJh?=
 =?utf-8?B?QWtxalBNT1ZmRTV0cHJqTXdpV0Jpci9hTm9Yb0FBT3UxVGF3MmxWZkg2RVVC?=
 =?utf-8?B?Q0lzM1oyRXhxYzZBUWJ6bzQ4SXY1UU0raDgwbHNicllYSUs3MzA0Qjd2ZFpL?=
 =?utf-8?B?eDBmdWRVVnR1UW84ejR2bzYvNFI1ZmhNdFVNdjBid0E5MXJvS1FFc3hlNCtM?=
 =?utf-8?B?RnBHbk11MmNZek5zeHY3aWV2V0hDcXl1WVRNb2N3amNvVFE5aDVXTnIwcVJU?=
 =?utf-8?B?RmtDakgzN1RKMkZ5T3R0aGhXbHZOckJRenpybGZVaVR5VzZXVEtkckdaWEJY?=
 =?utf-8?B?djhuYURJdkxPK1MrYVFtODdpaENnN2loRGNiTjloVk4rYVRoaGVKcHg2bXUy?=
 =?utf-8?B?djh5MVdEZ2xzcThzL2NXYmdWMXd5akdVWExNTWxBL3p4MUNLeU1CMFdNOXVm?=
 =?utf-8?B?MjVvekdtQkg1SldzNjBreS91QjhFU2s5V09tZkEyL0ViSm5RNWkzYnRyVWtk?=
 =?utf-8?B?TUtSRVUxb0Fja0lGQXBBWUQ1ek8weEI2OEk1V3VhT2orZTU0S1lOVVlEZlVH?=
 =?utf-8?B?NldzSXR0bnlENTM4VUhieVpIaks0S0I5WVpSemtxenhqZGlhNmRhUGZqMDJS?=
 =?utf-8?B?K2RWYW56b2lyNEZqSTJxVXRCOWhjQ3hoVGhwRS9BaURhay83NUdPalFZWFBG?=
 =?utf-8?B?c0JDSVR1aTMyenpCQTdtaVBkVGNWZHJoTzUwYlZ5eFFhQkgrbUtWenJ2KzNJ?=
 =?utf-8?B?b0p0Q1R0VVRQQWpINFYzT29LUzh4V0F4Tjl0ejdXL1laUkF5N2RvcXhzekVh?=
 =?utf-8?B?QkQ1am5PK2VIcklQS0dZWkNDdXU0WnVFWkpzbFlXM1NCclVIQTdINUpvZlpu?=
 =?utf-8?B?MXQ3UU9FbUpCMm1OenhneER6SitvK3M1RnFUckFSckVEU1lNVHpDa0RsY0hJ?=
 =?utf-8?B?azVuN1hzcFFYMTFLTlhUTXJEK1hvUXBjeUV5Q1RhZU9saHVrdFhXbjZyNUU2?=
 =?utf-8?B?ZXRlK1NySC9WR3RUcGJZU1BRZGt6QjNQZjI2OVVFaGhib2dpMjhrbWpYNGFZ?=
 =?utf-8?B?SHdsaFJkUXdRUnJ4MVVORmpWYzhyKzF3eU45Y1UvYUxUeHkrcmRVSmdTRnB6?=
 =?utf-8?B?MmxuRDZ0R2xZYmdiQU1ZTVNjMXUxVndEMWZKRmFpSGFHMWo0TG9KWnRNTmdr?=
 =?utf-8?B?ZjhHM2VUQlNhYzJrMnZhMVAvc2RpUmd6bmR4cG8zRjZvejQvVXlEdkgvamw0?=
 =?utf-8?B?eFNlcTNVa0Vva09zRW1FTHM1R0hxc0hGWEN0eit2QThuUjNxMStHWmNjRGYz?=
 =?utf-8?B?ZjB1RlRvaUdEbDhRdGFsRUl3THhiVGNhcklWRjJ0M1k1ZGpLaW5QaEZNRlpS?=
 =?utf-8?B?akhNSklrZk9sMmI3bnBXczcyZ3NWQVdYSUFnZ1hHa1hTWTBRNkg4YnBIdXp6?=
 =?utf-8?B?aEJ0bTFNY3ZoN05Ic21QM0hleWw3QnUxaEsyc2pjR2Rnd0FHQnIxYmx3U1BQ?=
 =?utf-8?B?UlZwMkpqNDNhNUdoRlhCVXRzZ3RRNzRhbnpKeVVkMkZKR2ErR08rV2MxcVpP?=
 =?utf-8?B?eEFua1ZlWGhIc2FVanQvVjBvb29iQlNoK1NnRTVIaHl1Rm1hQ0Nibm5tSHhR?=
 =?utf-8?B?aXZXdGl1bjhCZllmalhMa2krKzM4T0hxdlQ2ZVhpbWJ1MWFmTU93cFNiMlZV?=
 =?utf-8?B?UGN2U3FVTGRCK09RUnlVTGh3Qjc4b2lWM0xLUFhSNGZ3ekg4by9QQkFEMWJn?=
 =?utf-8?B?cHRObW83UC8yM1BxNW5zWmpMVEErb0ZoVExRc1ZpbzFSMDZoblVjMTljd1Mz?=
 =?utf-8?B?bnd1Y2ZWZjg0Z1poc0JlSkFNN2Zsci9NUmNIMXRHZWpSaTdwUEd0cHc5aFhh?=
 =?utf-8?B?MWsxNGE2cXc1cmozczFXTmRnVDdnVUxReExYcENPZ1QyejNOK0FadlhLSlZy?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12f98e4-75e1-45ad-406c-08dcd0c4ae8f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 11:43:54.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b2SHl8hBj0uZOoPJ8oEasE0DwUNblSjL/r/VTsJGjome7q7Dlv7SKQXcGjnnQIrrmfbOWsw+4k+L9THP6vvx1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6381
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Sep 2024 11:44:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16873

On 09.09.24 13:21, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> If a Hardware security module(HSM) is used, the user needs to modify the
> swupdate-certificate-key package in multiple ways to remove the error
> message in case of a missing key.
> 
> This changes decouples the signing
> key from the signing script to allow easier integration with HSM based
> signing

Strangely formatted sentence.

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  classes/swupdate.bbclass                      |  3 +--
>  recipes-core/images/swupdate.inc              |  5 +++-
>  .../swupdate-certificates-key.inc             |  9 +------
>  .../files/sign-swu-cms                        |  0
>  .../files/sign-swu-rsa                        |  0
>  .../swupdate-signer/swupdate-signer_0.1.bb    | 25 +++++++++++++++++++
>  6 files changed, 31 insertions(+), 11 deletions(-)
>  rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-cms (100%)
>  rename recipes-devtools/{swupdate-certificates => swupdate-signer}/files/sign-swu-rsa (100%)
>  create mode 100644 recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb
> 
> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
> index eeb05b2..06418e5 100644
> --- a/classes/swupdate.bbclass
> +++ b/classes/swupdate.bbclass
> @@ -46,8 +46,7 @@ IMAGE_TYPEDEP:swu = "${@ '${SWU_DELTA_UPDATE_ARTIFACT_TYPE}' \
>      if d.getVar('DELTA_UPDATE_TYPE') == "rdiff" or d.getVar('DELTA_UPDATE_TYPE') == "zchunk" \
>      else '${SWU_UPDATE_ARTIFACT_TYPE}' }"
>  
> -IMAGER_BUILD_DEPS:swu += "${@'swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> -IMAGER_INSTALL:swu += "cpio ${@'openssl swupdate-certificates-key' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGER_INSTALL:swu += "cpio"
>  IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>  
>  
> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
> index 1d237f7..96994b5 100644
> --- a/recipes-core/images/swupdate.inc
> +++ b/recipes-core/images/swupdate.inc
> @@ -1,7 +1,7 @@
>  #
>  # CIP Core, generic profile
>  #
> -# Copyright (c) Siemens AG, 2023
> +# Copyright (c) Siemens AG, 2023-2024
>  #
>  # Authors:
>  #  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> @@ -14,6 +14,9 @@ inherit read-only-rootfs
>  
>  SWU_SIGNED ?= "1"
>  SWU_HW_COMPAT ?= "cip-core-1.0"
> +IMAGER_BUILD_DEPS:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGER_INSTALL:swu += "${@'swupdate-signer' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
> +IMAGE_INSTALL += "${@'swupdate-certificates' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"

Moving these dependencies here requires some explanation, at least for
me. Not saying it is wrong, just like to read the reasoning somewhere.

>  IMAGE_INSTALL += " swupdate"
>  
>  IMAGE_INSTALL:remove:sid = "swupdate"
> diff --git a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> index 93cf255..bcc8e2a 100644
> --- a/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> +++ b/recipes-devtools/swupdate-certificates/swupdate-certificates-key.inc
> @@ -18,17 +18,10 @@ PROVIDES += "swupdate-certificates-key"
>  DEBIAN_PROVIDES = "swupdate-certificates-key"
>  
>  SWU_SIGN_KEY ??= ""
> -SWU_SIGN_SCRIPT ??= "sign-swu-cms"
>  SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_KEY') if d.getVar('SWU_SIGN_KEY') else '' }"
> -SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
>  
> -do_install[cleandirs] = "${D}/usr/share/swupdate-signing/ \
> -                         ${D}/usr/bin/"
> +do_install[cleandirs] = "${D}/usr/share/swupdate-signing"
>  do_install() {
> -    if [ ! -f ${WORKDIR}/${SWU_SIGN_SCRIPT} ]; then
> -        bbfatal "You must add a '${SWU_SIGN_SCRIPT}' to execute the signing process"
> -    fi
> -    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
>      if [ -z ${SWU_SIGN_KEY} ]; then
>          bbfatal "You must set SWU_SIGN_KEY and provide the required file as artifacts to this recipe"
>      fi
> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-cms b/recipes-devtools/swupdate-signer/files/sign-swu-cms
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/files/sign-swu-cms
> rename to recipes-devtools/swupdate-signer/files/sign-swu-cms
> diff --git a/recipes-devtools/swupdate-certificates/files/sign-swu-rsa b/recipes-devtools/swupdate-signer/files/sign-swu-rsa
> similarity index 100%
> rename from recipes-devtools/swupdate-certificates/files/sign-swu-rsa
> rename to recipes-devtools/swupdate-signer/files/sign-swu-rsa
> diff --git a/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb b/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb
> new file mode 100644
> index 0000000..71cc10c
> --- /dev/null
> +++ b/recipes-devtools/swupdate-signer/swupdate-signer_0.1.bb
> @@ -0,0 +1,25 @@
> +#
> +# CIP Core, generic profile
> +#
> +# Copyright (c) Siemens AG, 2024
> +#
> +# Authors:
> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
> +#
> +# SPDX-License-Identifier: MIT
> +
> +inherit dpkg-raw
> +DPKG_ARCH = "all"
> +DEBIAN_MULTI_ARCH = "foreign"
> +
> +DEPENDS = "swupdate-certificates-key"
> +DEBIAN_DEPENDS += "openssl, swupdate-certificates-key"
> +
> +SWU_SIGN_SCRIPT ??= "sign-swu-cms"
> +
> +SRC_URI:append = " ${@ "file://"+d.getVar('SWU_SIGN_SCRIPT') if d.getVar('SWU_SIGN_SCRIPT') else '' }"
> +
> +do_install[cleandirs] = "${D}/usr/bin/"
> +do_install() {
> +    install -m 0700 ${WORKDIR}/${SWU_SIGN_SCRIPT} ${D}/usr/bin/sign-swu
> +}

Jan

-- 
Siemens AG, Technology
Linux Expert Center


