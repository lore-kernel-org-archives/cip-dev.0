Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B564BE77188
	for <webhook@archiver.kernel.org>; Fri, 10 Jan 2025 16:07:20 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.82])
 by mx.groups.io with SMTP id smtpd.web11.22502.1736525239567400399
 for <cip-dev@lists.cip-project.org>;
 Fri, 10 Jan 2025 08:07:19 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=P02wKDNP;
 spf=pass (domain: siemens.com, ip: 40.107.22.82, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mm9ulh2pk7VrEw3nS1vPRUY8Xt30HAxzgry5fx/1xBIFt6t6nbSMrDQC/YPkmmmoR35yOoI1IuKft/zFr0kl4ova2Wy6UvU24+rYBYNtGSvGEErK2GPj/VL3FaoN4CHUh/LWB9AwD7eMsS1vlepK6tVI0OaxHeeFPJ5USUHtHawzSw4UPaWi/9XODGQ8lNfYr1lBUNMcjcRWpWkxW1DNfkhXA/Mn893Z2eyuOkZxJQZEpEd78R6mZCF4n+Yo7fZiH4eCzyVV+LGohR1biJx6UcFYxsITclaSKsz66HipePggizmb36B6U42UrBvBhOCOcdrcYjFEonvoC1Z8GTZ9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKmlXGHITvx2JDSCj4JD4QvdOXlJq4oj/7gakaUojgI=;
 b=cnEGquiFd0anuh7R6t5gFqFxBsYDOHq06+iywiHZVenwHPeQwasR2LezVTqHKdQJWIhLYc33DaawfhgKW5qWmMz6lmXTw/j8b4LrBWs7oQIFDYjz5BisVLN2Zgtv5OQL/pRMqu6E0+l6RgLJ3e63ak6Uk9cuEl2eSEikr9ZEDeCfEChaNcuwxubLQRblvGOJr3JMBP5r9TqiTiPxHVoqHq1hYuODxGvelTZJmBGYkT89CiHxZdq78ur+eDW2NI6uXnkGVIEJvoRvoFuFBp4Y/fclCZAVM0FCMMzs0OAyiaHYxYwhDvgYms2KGEo6aqAQS8dV//sjr1BdWAx+ovwIkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKmlXGHITvx2JDSCj4JD4QvdOXlJq4oj/7gakaUojgI=;
 b=P02wKDNPAFZEx/CUhs6bq+H8Ai/NZOrMmddaxhhyn8aaZLpxqTxOcLaTAqHukvkiQKCC0y7ncZ3CwGN4Z/7cuA4bAQiIPAqmthaQL9pstcbVwnBLCF1XMmltVRrCUOovgtOOp5E1te3vYowjQD0SppblLte2fqCuEl9BQtAQF2MJHbDylVSUeWR/ixxX4hGin8Jv+v0ti9qQcmDSdzZX3QuH3mnDHQcXU9dl25fNSxrqKhy1pzRuQKuvy6xJFXP7pBe38C74vaQD4G0FRIidZuLNZk624Tu/llvjRYO9kEkIXUviGLMgKwWDXK6cyfaK01ZMZcOCoM8eh5wN7InrkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:76::15)
 by DB9PR10MB5617.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.6; Fri, 10 Jan
 2025 16:07:16 +0000
Received: from GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286]) by GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7fc:74bb:a781:a286%6]) with mapi id 15.20.8356.003; Fri, 10 Jan 2025
 16:07:16 +0000
Message-ID: <134dbe0b-84a3-43c4-a60e-4c7d9c1c2eb7@siemens.com>
Date: Fri, 10 Jan 2025 17:07:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH] initramfs-overlay: fix missing
 scriptpreq
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250110154457.83539-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250110154457.83539-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0125.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::30) To GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:150:76::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR10MB6186:EE_|DB9PR10MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: cb45aed7-ed05-4300-ebd5-08dd3190da4e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RDVIMEF6OWRJeDBiSkYyS0x6Y2hUUnFlYWhEV0lGSDI1NFZTeFJHUENGMzVC?=
 =?utf-8?B?UUVNQVlkNlZMOG05TjZzUWdlVnJndmxHclVEUlV4WTFnWE4wY3hUcmptUWV0?=
 =?utf-8?B?NzRMRS9IeWF5VUlpR2owRGJ2b3NzS1N4NW1WRG1STmRTaTFURVFxM1hVMHpq?=
 =?utf-8?B?TC9CZjlsbzdmd1JQUmcwVnhUcFVXb0tZS1RZYWNaNFlLRXFweWprTUh4RXpB?=
 =?utf-8?B?bkJDU1BmSEpITmg3Yk5KcjFGQjg4eko2T1JuR3lndzE5YmFoOEs3Nmd6cEsz?=
 =?utf-8?B?OGZDakRUcGh6My8wd2o0cm1wcDQ5TDN0V1laSEZJN3F1cGhqajdTSGZYVGtp?=
 =?utf-8?B?SFZTSVdYakNUTkI3QmJ5WTd5M25qUGZjQk5TaE9rOENYcXJvb1JGLzdNU2dP?=
 =?utf-8?B?dmVxNVNTOGdCalhCZEJwLzdXK2xlRENlVFJJSzJJVFZCeU0xUTZOSXhyOEVJ?=
 =?utf-8?B?dWNrMkpGUDdHb2ZIVHJqSkV4ZTdiWWlqdFNGcWFuNGxCY0w4K3VEOXZIdHVC?=
 =?utf-8?B?dEQvYVNhMER4WGxlbDU5Y2FDaFFubWJsYU5ONEFQUm9melZMQjZWWngrMG9B?=
 =?utf-8?B?dFZmLzJuUHpiTnppNmlQdEEwVVZnSW02WWg1dEZiOWdWSElCY1pHYVNNQ0Ra?=
 =?utf-8?B?bldLamd1UGFyRUxVYVNNR3NObmJVTUxMZGdSNlVtTlFPRmNuanM4Szh6dWMz?=
 =?utf-8?B?OEFCNjVvQ1FxRytrc3JMTnVGSHJ6UnNaU0pBaUM1ell4U0FZMDM5c2VLU3Zn?=
 =?utf-8?B?T2hoa2J0Ynl3ZWI3UjJpS01UWWtRaHk5ZUNrZ2JuLzVQeW1maVViTkRZanZs?=
 =?utf-8?B?VzZQMmVXQXp1ZTBSNHV0RmNiR0JicytvNW5OR1huUGY1d2RMa2U5eFhDZjh1?=
 =?utf-8?B?Q3VHdmRrMGwzMk5ET215OXR1WlE5UW1Jc2NvZjUrVUYxWGx4NThmc0J3cVox?=
 =?utf-8?B?cjMwVTN1dVMyL0xUdFRnazFDaDFkU3J2WnVKOWZxY05pRUJzQXk1QVlhbXZZ?=
 =?utf-8?B?TXZzMDJIUmZqaHZvcjEvNk9BdlpvNndoMUc2UlV5b3hVV3FvUWZoaFZ0dXZQ?=
 =?utf-8?B?cWt0d1dzb0V0TXVhcU5hWTFnOFJpQ24yWWRpUE4vZVFvTTZ4TzE5QjRoNXNG?=
 =?utf-8?B?b0JmVzVuc2pwcVAydmIvTkNRY2lHS0dURzhkaTVEMDJvT1ZFN29oRFI2S2pu?=
 =?utf-8?B?Nll5OUcvNFlDa3ZjSlUyUjNqMm5QaUtQUVVmN3hqVWh4T3kwSW5KbzgwZFdq?=
 =?utf-8?B?OGQvNU9XcldlR0VBRGttNVdOV3A1OFlMbkNIRnlQK2g5QURCa09hbDZzaitv?=
 =?utf-8?B?dFhBeEh1ZDdPVjF5RnpocFBFZGNKWGVnTzRxOUg2S28vNEdweitteU5kenAw?=
 =?utf-8?B?OGh0L01FbFFSSEkrdnBBbHVPbG8za0hJaDRGQWxXWThNdUtJM3pheGxzdU1w?=
 =?utf-8?B?UHBwRlFkUkpiVWlCdU1vd1Vsd0x3QVNuWlR4MTZCbmV5NHNVS3Z5QWJ4dnBR?=
 =?utf-8?B?ZVlwRUh6eUg2QlVneEg1cmdsZHdVTzFyZVpQcURKRlR4bmwxWTBxSXBSTExF?=
 =?utf-8?B?cHorMVkyT3hadXRDeHYvM1hjVndZUjRFR0IvRlVvdnNPUFFLV2hyZ2JDak82?=
 =?utf-8?B?citKT01hVjJ3OXUxd2FFVHBUTmhlUmgwUklGZ1BmbHdRVHVzU0tVSVdjZEVy?=
 =?utf-8?B?VW9YakJrcEZqdi9jNGx4c09ZcjZ3Qm1CcFJMbVZaVmpxdWVvcTRTamYzaE55?=
 =?utf-8?B?cC9LRnp5VjdTRXVsSVlqZTc1Wld4cXJ1YnhFc1ZSdkx6RnpTNXZadzltSWJN?=
 =?utf-8?B?RFA1Q3J0dmlZNGgySU41MmY5SlV5Z3ZrMWxTUitrZ2puTUM3Wjc2UHpTTDNJ?=
 =?utf-8?Q?bBmnlQ+Mj3wJ1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?djUrYlJyUGZmNmRLRHRjR0tqNjkrRFdGNllhN1FZdy93VFFCZ0tQaVZML2RL?=
 =?utf-8?B?eCtSU3FaRzVEQlFob1RxUW13WUNsYzg4NEg5UGtrMjlLWGYvTXhERklQK3ZT?=
 =?utf-8?B?NHcrUWZlcXJac2hma3Q2WUFDRjFqMzZ3NkFOUU1QbEhNa3RPSXhqWS9XREQ5?=
 =?utf-8?B?b2tTdDRNZGJ2SHBuS013djVOaFF6YnJBQTI2V0E2dGVYcXB0SUNlZmZUZ3R4?=
 =?utf-8?B?ZkFyazV1dmtOOGlrWWozb2NaZ0NlSGxNZCtWY2RXTWNySlZEYVJOV21ZK2Ez?=
 =?utf-8?B?VEFjUDZaNlp3aGpSVmx1UjcvSDY0TmpZTzJFM1JoVk42cVhzTEppVHI5TWRs?=
 =?utf-8?B?bkwvOHlMOGZJUFNvQmdqa1hlODRMYk50Zk14M0hhditmdjFlU2x1LzBiNHZ3?=
 =?utf-8?B?NG1PSkRUNkx3M29GdC8zMDBoenpKUDU2VHNDK0NjRG9lV0c5N3hsMUY0TzU4?=
 =?utf-8?B?WDVOeWY4RTMxZUxtZEdVbzFMN3J1UUlnWVhuclB6dHBPNTRTamhCdzlkalhw?=
 =?utf-8?B?WWwraERWSDFTa3ZHcXdmRlpLNWZ4WVd0N0x2SjlzMmE5R1NaZ2Y5bHFtK0d4?=
 =?utf-8?B?am8rMnBjaWJzZFJGd1Y2SHZBOStUeGlSaHlpZ0tGV3VHaTZQYVI2RE00ZTVD?=
 =?utf-8?B?cWFXZWxwWk12aGVySE8zbTc5QWY1b1VITWk0SllTd3NGZ3pOMjRXMlhueUVB?=
 =?utf-8?B?ZENnTVkxc3pqVGZZTXpmdFh4cmlJYmZtc2pMS3ArU1VPdXNyWDI0aVZrTDVa?=
 =?utf-8?B?a1pteStMb2JKalk4TXkrT1JuUnBIYUhQWnBFY1hLNStIcUFFSzI2dkkwMVhL?=
 =?utf-8?B?VXU3QjVtWSt4WnMrdU00Rk56SFdvRWZVUWJDZWUvMkZsWDJRRHkydmpIS2t1?=
 =?utf-8?B?MHpQRzllYWFhakw4RUxDU3k2VjcwaEdvRDR3em1ibW5ja1VNbTFra0xIdVFJ?=
 =?utf-8?B?SHdDYWNCUWx2R0FNaTUvZkNqdERYZkVUcXlOSWZwK0gvNFF3OW9CdXl0bVZv?=
 =?utf-8?B?UUtsVCtGSm1VNTRzS3IvZ3FTV0k0aFhNZDRmM2g1WVpXN095QkJJYnQ3anh5?=
 =?utf-8?B?L0wzcUZRVCtodFdINmxxeFE3cU1oY21oMjg1SUtPc2pZMWRWc2llMmxCcE5J?=
 =?utf-8?B?eFBUd0dVdTJpUGl1UDhMVVpORXBaK2pvWXVkbVlVZ3Y4dEtsejUyMWJkeVcx?=
 =?utf-8?B?WmQ5MmxSajJ2enNka09BYU44TThXbU1DSjk0SEIwS3pmTTNQOVUza0t2NTMx?=
 =?utf-8?B?OGpLUEtlRzBtTGtZei8yQUcxSVBtT0pBcG04bkdiQzZrK3RJcXZRYVBZbElT?=
 =?utf-8?B?VE02eCt1RjJMOHRZN3F5MXZ1Sm1pNzJDNUVoclJIUURmODVYcXBld0dXMGRt?=
 =?utf-8?B?MFhuKzlsVWYrbzcvK2NpK2xXdm5DQ0ZBcURQS21WOHBIcVU1ei9KeFAxd292?=
 =?utf-8?B?VWJKd3lKQUEyVWxUcXBaMnNKcDlaZGhxcm9QazA2TEtaa3VzREhOMWlaazEy?=
 =?utf-8?B?bkJYVk1RcmJVM3ZFZGdTTVR5Uno0WWNLSDdDdlMrZ1l5VEdySVJvMFYzS29j?=
 =?utf-8?B?WjVzWWdQcjRUVXEyZFNYdERsMWgyNWhXeE9XWjFVbmk5VFNyT1RPejVMOXFH?=
 =?utf-8?B?eWVOTCtXZ0huZ2JZaXJkQUFQY2ErSEVZUmZNT1dHTXE1VVVkMHlQaC9KSHNB?=
 =?utf-8?B?ZXZ6WWlNYXlvR3UwbFlkd1BpYTZJR25pQUtiUUxmZ3ZwZjMxTTdobXhPVUlP?=
 =?utf-8?B?WjdnOWtHYkRGYzkzMHM5NjFmcUhiOWljWkJDTzJiblpsa3IwZXpTVE82T1hB?=
 =?utf-8?B?Qm90MzdXVnNrYzZpajRmWTZoUzFrWG42alZtRUVaMXVrWmkrdFhnRGdPR1pk?=
 =?utf-8?B?U29xSnpoa0MvOUtuSG5qZ3RPMjk5WDQrTXFKNkpRM0d5OVBhYXhEbm5JQjZk?=
 =?utf-8?B?NmxxZE56VjZ6aFY4alJQV2UrdnRLSmRxQ3RKalRxRDBudDhKbld6YmRNaU5m?=
 =?utf-8?B?Q1FzRDRzRHVmZWlEUHZ2R3RIRkl2TWEvN0NDa25jUGxXRXBoU3VuMHErdUs3?=
 =?utf-8?B?ZTZRY0hKeE9ESUNLS1VmazgzK3JYYUVtN3BDNFhrK2dCcFZ0Njl0dHF2OEp1?=
 =?utf-8?B?TklHVEtuWjlmMjFabDJGS0hvR1phOFpPclBUSTdCaDBwSjRCdkViRU1uRVRx?=
 =?utf-8?B?MUE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb45aed7-ed05-4300-ebd5-08dd3190da4e
X-MS-Exchange-CrossTenant-AuthSource: GV2PR10MB6186.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 16:07:16.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3UVeHkmuMEziv2Pc2gooXM730n7gag+WhuH0OtxYUyvV3NJJ7Wx3NnOyQWdkaiR5GUQC6SSIl7wEP8Ef2YGIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5617
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 10 Jan 2025 16:07:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17526

On 10.01.25 16:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> During testing with LAVA it was detect that the overlays are not
> mount on real hardware if the image is booted a second time.

"mounted"

Is this a regression of my refactorings, or was it always broken?

> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .../initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb        | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> index 56ae8d2..4e2e292 100644
> --- a/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> +++ b/recipes-initramfs/initramfs-overlay-hook/initramfs-overlay-hook_0.2.bb
> @@ -45,6 +45,8 @@ DEBIAN_DEPENDS .= ", awk, coreutils, util-linux"
>  HOOK_ADD_MODULES = "overlay"
>  HOOK_COPY_EXECS = "mountpoint awk e2fsck mke2fs"
>  
> +SCRIPT_PREREQ="crypt"
> +

This is a weak dependency, right? Means, it will not fail if we have no
crypt in play?

Jan

>  do_install:append() {
>      install -m 0755 "${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" \
>          "${D}/usr/share/initramfs-tools/scripts"

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

