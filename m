Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12DFAE77197
	for <webhook@archiver.kernel.org>; Tue,  7 Jan 2025 10:05:37 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.71])
 by mx.groups.io with SMTP id smtpd.web10.17135.1736244303431898293
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jan 2025 02:05:03 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=yUx8wwkP;
 spf=pass (domain: siemens.com, ip: 40.107.20.71, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ylMTKjAeSDsL7l81ZwSjlPaOYILgotoF2Plt9HYiHIKNQsz+yk4FO95eUovbcKL3Jpt/ias6uNf5mzy68IKZnNsq/ZOoTL2pINnkCFerb9oRcWwHEQP2y9vkucRyp1jPEtGmVHhXnNWq23acgVvMkrjR3rP49lGfVoK7PomDBk8Yfv4I94oGW7xipAJVV6GvoHjCrV8cSbtIIl/JcTb024U7Ja0O43hVAMyiU6ZArkyPfUQLDh7Y0xGVaAsQPbXEqR23+87yU/nA73yVfIH86QBYP3U80nflke+9mBXqNxYL7ULorGf9uE4M9/GQZTbjajl8KOSGgG5OL81Y3TYjkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CEiY1Ss0lDTMmVbPnkjSupN+HB1r0DQBOw1Lj8wCq8M=;
 b=UeuqllSoPtMLPFiqT5HFUw7+6uKwxnw+HmEGFJoHjdxRzDDc2E7n1iIi61HtIAb9bFpyfUDi//wW21TAJbM9CYrZglRco6iCkm4ZNQxFR2T7Xe2yzfWZ7eQGkmwdjxOCeHHiFcX37+cou73o7tdqGw9WoL1M5FK57YNCJBDho+rxXvbTZMJpQlx11+GG/QPqHYHAxw8Db5BypYIly8+J3CN1wcExyre0ajRBI7Mhqi0iBVkhnLS9ktLIPkgiEmXD0ogH/txqk0Iz4F06+uhKPNdifxM13CKT6run5rJKZzTdPn8FOKh/IiC6oBYKBkdJJ40Q2eaN0WXLUj7brRI95w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEiY1Ss0lDTMmVbPnkjSupN+HB1r0DQBOw1Lj8wCq8M=;
 b=yUx8wwkPX2Q60awuBJOGoS+e2/AxyXFSb9AEBbOZ31nFweMaRGkgeLZ28tjHM5c9rB/bOHpoEvssXDHXr+8hXEffwVtMmonwgu7rysAkPSaoc4tT269Jz+3K9Qi0iagFiLoF/Q0f9mgXmxQRmd8FfPfy4D9TqDQri7Zk5m2nks7X3QDbeK09lhNRogzJgrf/DPlai2AA5WBuI6yEAvUetJdj0XL3eZrncmds/BwMj7iZoZEOekwRiVZNwcisg+E/arIkzTUHPT00qjTDgIOvjIqo1K23nCRGnDFLE2Su0yTvxcgA8fLJeDG3nCY2dOjxfKIs7HZuD6NwR0c7rwbJbg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by VE1PR10MB3869.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:164::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 10:04:59 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::67be:42ba:72cc:5a8c%5]) with mapi id 15.20.8335.007; Tue, 7 Jan 2025
 10:04:59 +0000
Message-ID: <11256256-a5af-4f3c-aa0c-e1bf2ac29edd@siemens.com>
Date: Tue, 7 Jan 2025 11:04:53 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] efibootguard kernel missing squashfs mod
To: cip-dev@lists.cip-project.org
References: <CAK9C7GA60Zw2d4gApaRi5fw6x5G-XTn-6m8bi6Q=2ps2Xyp+Qg@mail.gmail.com>
Content-Language: en-US
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
In-Reply-To: <CAK9C7GA60Zw2d4gApaRi5fw6x5G-XTn-6m8bi6Q=2ps2Xyp+Qg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH5PR02CA0004.namprd02.prod.outlook.com
 (2603:10b6:610:1ed::21) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|VE1PR10MB3869:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d7b67aa-9aad-48a9-42f6-08dd2f02bd9e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|4022899009|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cHpxVlREdVkvV2VQeUp2eW1RZ3BOV2c1U3BmWTRVcHl4S1FnMTdhWXVtOFpI?=
 =?utf-8?B?SjdPYit0YU1tU1BTWHQwaDBGZ0Vyc2dYN3ptZ2kwSzRNN0pweUdkS0QyOTFU?=
 =?utf-8?B?QnhlNGJHMm1kcFNQMFlrRHRSOGV1RmdwWGRadWhUbnNUbEJrR2ZMRlljcWdt?=
 =?utf-8?B?cEhib2dqNEo4UU4rczlCNURTaEY5SXA3c0lKQlZxcGpnU1kzY2tERFIwYzZH?=
 =?utf-8?B?TjMyeHdJVityQlFCY0p3Q0FwYXBIeGJyZ1diT3BUbkpUbXAxNFk3cTBYdHoy?=
 =?utf-8?B?d3pCRlIrTzVGbUloY2wvb3F5MkMyL3BiSTcwRlpaUXpkNTQvOUp4M0VIQTg2?=
 =?utf-8?B?NGlibDdGZFpxUDhNdzZVUjBuaURuYmZRbnFWRGhFbFYxcFREMHEzZXhCc3Bz?=
 =?utf-8?B?alpNZk0xZWliQ0VtbEt1Rm9aOEpnZmNlMGVwUm5zVkY2TUNQSHNiR0pHWE9T?=
 =?utf-8?B?UU92cWhrNXMxYTlEaEcySVR1RU4xVXlMckp3WDF2ODZqcVg0aWNsZHFEa3Vk?=
 =?utf-8?B?b1dNSU8wUnI0d09QK3FodmlramxrNlpYc3BJL0h6MjNaNXNHSkZYOTNBUy9M?=
 =?utf-8?B?NU1PeHFqOVNod0xXaDZDMVJwZ2RjL2VGUGl4REF6UU9ENVpaZE9EUHBoUUQv?=
 =?utf-8?B?bFZnS2VwdllBN3N3TzJUUHRXM25kQk5QU2prSVBEZWVnamd1K0tCZzRvN2NB?=
 =?utf-8?B?WFNodnlMbVhnSXgwNHIwclF2dW00RndRUkxJemRzVEdKSTJlM3cwTk5YN0to?=
 =?utf-8?B?dnVwUEp6RWpxclVJQzYwTXJVZmh1ekVBVXJDQkhIWDl4MHljSkw5dEdnVkU2?=
 =?utf-8?B?UVdKTHlSNGwzZ0xVRk5SVEYySUpMZ21EN1F2YVhKRTdEeW1MY0c5cnBWTHQy?=
 =?utf-8?B?UndxUFdzYkNzWFA2RStTYUZLajBTZlRpT2ZUNE5BaFBQSFdpWTRLeEttSVkv?=
 =?utf-8?B?U2pMTExQQWxBZ01YZExoeklNa0lyTHByWGNTZCtialZCZGxwVWxmUU50aDhW?=
 =?utf-8?B?Qm9CK2E3ajM2Y2FZVUdtUk03bldBNFhrNjJqTndmUXE4Y3pxUVNDaVZ5UERJ?=
 =?utf-8?B?OXpJM255ZVlOdEFBZTJrYWpmQmw4NnZLKzZtc3Q3aG4zOW9EaTR5VnVFdVZo?=
 =?utf-8?B?VGk4U0FXS1RDM2hXRWtvY3NjMnZ3QlhMRXVyR2JvdHc5RW1uMGtkbVpycEc3?=
 =?utf-8?B?bVpjMjlsN0t2TkVDdGdEbHB4amhpME0xK0QzNE1JOGJ0dGh3YWt3RGdGUUdZ?=
 =?utf-8?B?LzA3d3RNQnVPZVp3UW1TVXNSS2NNb0RNMmRTVW5ycEpZOS90WDlrMzBiUVBU?=
 =?utf-8?B?M1oway82QWY2YWpuaGluQU1IRmhzZ05iOFJkWDlLc01Cb2tiSzd2cER2QTJ1?=
 =?utf-8?B?YVRPMFliYnZ1MEtJLzBCd2owdlhiUzl6bm9nS0J0K09XdENGakNyYnBSSlRy?=
 =?utf-8?B?c0MwdTFTZnFScHpySk1sQUNsTUNISHFKaWlzWllPYkppb1dFQjY5cDlubHpw?=
 =?utf-8?B?UnIzTG9GVDBHM3dxSmV6c1JFQnRtYnNUQVYwV3lyci9KU3FhZzIzbGZLYVhH?=
 =?utf-8?B?MW5QWHpGOE9hWDdGV3owNG1kaDFxRzh4Y3NKbkMvOS91cGdydEZIemVRKzY2?=
 =?utf-8?B?TFBPL2NTZjZOV0hDSiszZ3NBVk5oOVdOaXY1c2Y3QTZ5d0UrK3dwN05nNDg3?=
 =?utf-8?B?L0tueFBDZktBUEN1NmM2c3V4V01CU05IaGp6cUNub2RvZkllK0hBVHdiTVZJ?=
 =?utf-8?B?MkQwdnI0L2czQ0hoczlyUXVxUVJ2T0x2cUhFbjBrNHptWlNwK3lkZTgzTHh6?=
 =?utf-8?B?RTMyQWI5MXUxZnVkMXlrdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(4022899009)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UUFFS0RYVTdtcFIweWt1NVBiZm16NysrZDc2YzBpZTF6VHhzTjRtbXhMaG5L?=
 =?utf-8?B?SFkwZDU2U2h0eUJ6STRKQkNOR0pDd1RPcVJXZTgvY1RvTnJFbU5CUjhJb3Zu?=
 =?utf-8?B?MHFROEtPSkRZWkxIdFdkbE11NXpsY29adEhxNmd2d2Q0RFRGTzR5dFRGa2Vq?=
 =?utf-8?B?UjJuVjI5dEhicG5INFhNUFFrRVdZWlk2K3g1bllWY2FHYnB2L3B2dmlWbWJO?=
 =?utf-8?B?SVBXSFpvK3loWXkxZjQza2NFcm1MbHpQZ1p1QjNvcitpblB6NlVVOWU5OEhF?=
 =?utf-8?B?TEhiZDNRYVI3NUVxUTJ4MVZlM1ZMQ2VqdXVvTlZZQXk4TWVkelV2OVN3enpk?=
 =?utf-8?B?cllsNEEvRU95Zlhsak9SRU92Ni9NS1VkNW1nTjgwM3NqS1ZxQ0MveTRMaW5D?=
 =?utf-8?B?L0MzUVpWQ1AreFVVQzNLS2twRmRraTFoUEgyVUtYRkpNZFcvemUyNmdOdk96?=
 =?utf-8?B?QmgvaXNad2U5TU1VMkU1NFdBWWlISHcvU2JJSHFCbEFadDM1ZVFFTzU0eDBP?=
 =?utf-8?B?YmJiM0VvK3RleWZyTG5mekhpM1NmeXpzTXhuTWN4aXNrQUxLWlB6QUdCUEVp?=
 =?utf-8?B?ZnBxbG5lNzUrS21FenJBNGtMRzFiTW9mUUkxR20xUFZEckhsM055VVF4V1dH?=
 =?utf-8?B?RVFLQ2FOVnFnUTBYY3V4Uk5YYmF2bnZSNUFjUktGT3JKT252Z0tpV2M3TjEr?=
 =?utf-8?B?MG9iaHV1VFdrSklrNVpnVGROczhmQy9oMFFZY1NFMmg2YUJQZlpHRlNuQk1J?=
 =?utf-8?B?K1dMMUlUZEFmR21mcTJveUcyYW51Q21pclpzUmV6Wjd4V1lTQkNTQndUWDR4?=
 =?utf-8?B?NWVoU283SlJDOUpLOHJPeFBoYkhNZm1HaUtLK0MwV1V4SXBvSXNLNEhUUFV5?=
 =?utf-8?B?VXZMc21FSWJRaTlaUlhFbldVN3IyeEJsMFpmMCs1T1JBUlpBQkcwcGtvZW4r?=
 =?utf-8?B?N3cxMS9uWUgrOGl1Y3U2b2hWWkZiU3VPbWl3T3dZb3MwQXpWTXF1bENUWk1E?=
 =?utf-8?B?dE1ZR0ZDOG1VSXBjNkZwbXNTMW8rc1M3MjFHRHh6YXJNZm85VTQ4VFRYRm5v?=
 =?utf-8?B?clpHZHh3ZnhWSFBtZ0psMEhib1dieWJTc0pFVTY2SHVWVXNlTzAxajg5elJ6?=
 =?utf-8?B?MWtsTnVzWVJkMGRwLzFDN1N5MkVVMWd4TEpyMVNQQXdNaHl4K2luMGptbk56?=
 =?utf-8?B?TmMyVlg0QmZJUHZiSTFVVDBsZ29WTzBPU3cxeXh6ckNQcTRXRXpncFZLbG4r?=
 =?utf-8?B?SlVPcnNlVDVhVHZzR2xnVnNJdnRwempmU2RBSVV0eG1POWZ5czNSSWJndkVi?=
 =?utf-8?B?NCszb3dxLzViOTR5S25xMHJyN3p6cHhsVnN4MkxSMGp2enRyL0hhQkxZUnpY?=
 =?utf-8?B?bU5pbE5GbHl4WWdtMWpzdzB1a0F5UzRKN2lIU2E3aUo0Q3M0dXpoYWVCcWtl?=
 =?utf-8?B?aGpKdytVK0FyMlYwbWk5WGFzdWtScWxKZDc0Ukpta2NvRUJoT1BoRzNIUXlI?=
 =?utf-8?B?Y1J5RjVrbURVd0p1Qk92NDFTQmt3clpWNnF4RWVYOUgrL1JLM01YSzNvWGJn?=
 =?utf-8?B?bjczZmhoL3Q5TDJWRzFPUUNTby9VYVBmQ0YzYjROREtFUVJka1JaUm1HU3Nk?=
 =?utf-8?B?S2lyZlhFcUljdjlEQ1RJa3ptQ3NYSmNrMUMxMW1UdEZCTG0yUGdpcy84VWZ1?=
 =?utf-8?B?dHBDVSt1OUV6TUw1NUJheExsRmZJZlMwdmhSYU5hVDNCSW41b0lvUmY4ZExJ?=
 =?utf-8?B?czUyQmRXQ01hdVRlbHZXOWIwaWtYeWRBNVdXWXV3dnZCeDBydTN2RlRhRERH?=
 =?utf-8?B?Y0dtUGNMMGJjWThkR0NBcTF2NUNEK25hMkp4VDh6UTErQWFDK25QaCtxMXpZ?=
 =?utf-8?B?cGpnbXdOTjZlZmdFbnNGZVFzcDFBenZUS2F4M2IxTWZHT3FNUmlyUFlZeUky?=
 =?utf-8?B?NzdoZFRScjcxbUFyUjJOOVJaNVg0WUkycEpkclRLMEw5VzZWTDYvTUNQWUFD?=
 =?utf-8?B?YW1RVXhBU1pTdGc3MFBCendSRWNabWdaMmtBVDMvZEVLdHNXOEphMnZsZDRH?=
 =?utf-8?B?T0FYL0M5SzlVVmFkNTNGV2p3SkZHUDlYN2tFbjJOUHIyblQwL0E4ZHJJNEg4?=
 =?utf-8?B?VkJyS3IvWWlVQm9FbXJrbGp2Q3YyT2x3RmJmdHdPY2djNWRtdXJINlRaTEcx?=
 =?utf-8?B?Vnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7b67aa-9aad-48a9-42f6-08dd2f02bd9e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 10:04:59.8429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJ6jcxQHI8ZfKHVtyWFsKxWQa+Dp2qNyEzpqyzDGYlKJoWxxCfreEKILUKYR0IuZsq7L3eROIZoAb3WBZXEiqlYKBkuV7OMqiEa5zdWWCLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3869
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jan 2025 10:05:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17502

Hi,

On 12/24/24 07:46, Stephen Ecker via lists.cip-project.org wrote:
> I am using squashfs as.the read-only filesystem, but the kernel is
> lacking squashfs support... is there a directive for defining modules
> which need to be added to the initramfs when building a unified kernel
> for efibootguard (I am uncertain which parts of that are relevant)
> 
> thanks

the squashfs module will loaded with with the `initramfs-squashfs-hook` 
recipe.

Quirin

> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#17493): https://lists.cip-project.org/g/cip-dev/message/17493
> Mute This Topic: https://lists.cip-project.org/mt/110269114/1753640
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129121/1753640/1405269326/xyzzy [quirin.gylstorff@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


