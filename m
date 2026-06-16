Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B47BCD98DA
	for <webhook@archiver.kernel.org>; Tue, 16 Jun 2026 07:13:42 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.9])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.148867.1781594017188405884
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Jun 2026 00:13:37 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=z44yXlfp;
 spf=pass (domain: siemens.com, ip: 52.101.69.9, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Py7mcRHGqNWmGt1cn84TFTJXMa+PHMaA2Sdhjcm+VgzD1MJcBgQYGuaXXPr68B+XMdcJ/c7BrF5eAkl9Rlwp8im6BD163d+/qXHwvWWAYi+I4ySMfHyLK47YzQd6WgHEMgyfMpfDtwuS3usRbTGUY89DceiDbEOS4T88a+HHnkpgPGoaboU7qxhbXSMQFG0607yi63FUxyLa2clr436AbOBxl48p4j6zd/0/5i14pahqSRBXubor3zto9NXCa4t6sG/KaBnVyulAHEiqgR3K39/AZtnvWS6HSrkXMxgskUVmt3FqfeaMzCR0sdWRJwmP8YVHIwFaSSFY0wQi5MQhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NunAp5lcqJmyAfN+Pmiax/gaZPtR78C8PKol3NcBDf4=;
 b=P/BT9CCJxDUCYLJGH3/G3arY687yrKDOkA8OHTNhsLfdOLchXPZZDqx7Kmyu413YgXsSJjNf77xPhPrytL6+bhwOjUVvpbwqWee09XfYHI5Eam/cfr0ls+8s85/AoV0opq/BaqnKObNPlXgaCXpGb4O1nG5TPgWYO22iG11LJT0Hzx+ileJADAKJEBFa6SLF7labwn6BQpEk4RnpWQ0grai+PIYxo/SYkss8Jo6Hz1xHzuCrmz3GcKPJ3xboCz/IXzEEvBPFH+u5gdMFH9Y2ZuihmKn+WfZejVX0fJjX9h2+5Xjf8ZoI/JUYhWBpEMW5ucIfrpa63chn3l/I5UgdYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NunAp5lcqJmyAfN+Pmiax/gaZPtR78C8PKol3NcBDf4=;
 b=z44yXlfpgPsZNQIA1jSWOhYnvA5mRCyMQpDfD8ILWIvz5aVXVWoi4ab4prPGyfQeHZ2gTbXCJSqavYWB40ShNlBO2qGf2cWntzKJwUjYLCezPuaUQpkXVYlzZSoCkitJ89e++oM3JiA2d+WRNsuWwOgaJ0MEsCXW4ZueG0xUqa+NkQBenqnAdstoxK9tHRptudZHQfhuvIS4ijo5brbEYRRcg4uol4PoOda2KBZ3UQVEoFnxkYhfhjHdBkyRjOHwC6zc387w71RpPa7nrxONwJBgFF3XsGriaOAabtInaI7JnBQVtYfYX+v9UbZz8hqWFBDLdd4UpbyMCZSeCecnXw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6227.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ee::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 07:13:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0113.015; Tue, 16 Jun 2026
 07:13:32 +0000
Message-ID: <34c18027-b049-41a7-b43b-fb200bde4abc@siemens.com>
Date: Tue, 16 Jun 2026 09:13:31 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2 0/2] Enable Debian sid support
To: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>,
 cip-dev@lists.cip-project.org
Cc: Adithya.Balakumar@toshiba-tsip.com, dinesh.kumar@toshiba-tsip.com,
 kazuhiro3.hayashi@toshiba.co.jp
References: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20260616050628.3560536-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0162.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6227:EE_
X-MS-Office365-Filtering-Correlation-Id: 358b86cc-7bbb-44c9-26d3-08decb76c646
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|6133799003|22082099003|18002099003|55112099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	MX3/vdGseMnI+ZeIkSSo5Nf9Q0Gft2Bg3bbuXYqIGauuTdsbzwl1dfPQOgZRzsNLQsI838K58kx30HSH7AOPsjvDNbqIu6OlaWoTO1DuUbk0HWwWrqMxpk4nvwRwVBtSiroupzQ21EY8XqLnRPnPW5M59TO4fsP8xu7nX0aF2BCyH/iwi69Vx88EqUoix7MlEC4f/1BR5sj5NYriZxI7mVpmA36kyR5wqG+4FnxY3OVW1uSWHd2CONM39m/HvxHbTzbuyaZvFFD0h5fXN4ApC8uYefbQEP3UWEmsfbPebay7tE85yvVvb4KEdLkEVfQr9D0fLqzIlV+qbKZGpilXPKLxT2U3DG7fKGVVeYWY7mHQgOiJ6NdEvMQ1XNXF2gWaD0LwpgKMx0rQbEaBUWsjo/DCludj4HiVT0DhwzMSQ8DlJXji+UfyWCIkuM+L9dm+Mk9289nfdjrV+1KMw3x7Aop3qu3kFX/0tQZtDpQyH89VzORIn8BkVP09aH7a1K4NENaVwID9EaImMfT/hvnsvn+Ghxf/3bnnOs662ETKU6s7Xbz0zA9dlxfHazI3qpwYRTlT0ZmLcF2fmOptiQVKtgaS7DlJ3TCrPSFgOfJzcLoFbGvGk/9v5TZ4O7Uma06XbwT7XT+iXFo+lpGZLdC13lywAyXxzAjYmLTJypN2H1AGZdU+Wvvv1jPzeNoR77oB
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?enJzT3J2REpCMG5vZVNKcWZ6OHZkMi9hOFN4S0pMRkZ4R2MrWk5rZ3Vyb1pD?=
 =?utf-8?B?Nmo4TFNUUC9GWFhHUGU5Z3Y1SGFQUy95QmZVRW9LS0VmRHVXclZKV3ZyOHBu?=
 =?utf-8?B?NGpmd1RLd0ZBQ25NZTMydFQ3L1NRWDh6Y1hpTFBoeUdXaGFCYWxZRFFCSXFt?=
 =?utf-8?B?WTB4THlRWHUvYUlPbHkxT2hrWUFOR01MSjZLcXlOWHVTNGl2WGNJT0VNQmVL?=
 =?utf-8?B?QzZrS2FqV0NSZ25LMDczUUoxcWxwWktBb0N0c3cyOFlOMkV1SUkrUFNmcTU4?=
 =?utf-8?B?Zk1PcUdRZC8vNzNPTEcwaFVhUm9BajhoUW9CdUlMSkxPdzdrcytkSGxpczhP?=
 =?utf-8?B?eFdWT3VkZFE3Ykw3QU90RmF3SjE3ZldaUUJuaHc5S2RRQ29uT3o5TUFIQUVh?=
 =?utf-8?B?bDhTdFp3SUozWmREN2E1a0lXenZQb2RNR1RTekNBMmZ4SVVCZkgyWkVPc09o?=
 =?utf-8?B?Mlc1VTc2RTNsVWJJTDdtWWg4Tnl0R25kYkpvYUpBTmgvaDhXeDRXRkVDTjFn?=
 =?utf-8?B?Mks2MndNejNqeEM3cWppT2M4SjFnaFlWM2h2K2c2amQ4ZXZveUYxTFdsMHRp?=
 =?utf-8?B?UGVFNHpsRS9GWFJRTDhTN3F5RExsNytFZVZ1Q0ZhaHlvcjNlUzdZak9qK0Rp?=
 =?utf-8?B?aUVWMGZrN2ZKSHkzV08zcVFTMUxHbEtsMnlOQjgybFZQbUNsdjhzamVsNnYv?=
 =?utf-8?B?UkV1b3RiTVZBTzBtc09ZOUxLVEl2R3JacHRUaURqcW5qMEFQNzdHbmF5eFpT?=
 =?utf-8?B?TzRLN3ZBVnh1MFc5bzFQMkRBS1ZqTFc2SzBzcnU4dU95aFNLOC9YOFNSVWpw?=
 =?utf-8?B?RjFQNFordHlERDJhYmx0REFUOEFrNnM1alNKd0tUZGRCS20rL2gxeERmUHhq?=
 =?utf-8?B?SHJEVEFPSjlkNFVsZ3Bab0pGbW8rWHo4SW8yL2lhUlBlZUs5SUppaGNPQTlu?=
 =?utf-8?B?QXNjSUNYRUVkQi9HY3hVT2dmQ3BUZ3NkWXA4bUZrZERHVWVXbGxBcS82bW5j?=
 =?utf-8?B?em9HTWx0SVVsY1dUZVNKa2RCcGo2OHFNN3Ria1pQZWdvUkVpcG4wZ1hBQkFo?=
 =?utf-8?B?TmZCVGg2OWtVY3JhbGhhTmJBekQ1WUZObThqa2FNM0RJU0RlSXpCM25nM0JC?=
 =?utf-8?B?VDFGeW1XWGkrTnl2TmdQV0N6cEt3OWNQWUpzRkNsRFk3ZEI0d0dyRzFpQmhX?=
 =?utf-8?B?b1hmVC9leEdMeU1pNzZpcmxobEprdlRvR2xEb0tvMjh3YzE0blRVeFE3Ukky?=
 =?utf-8?B?dDVWeEhId1J1dmFGcFkxVUpMaUNERmJTZll3RzF6RHR4OTBVczR1dmpScGRM?=
 =?utf-8?B?QjlYZUtlUkp1dndQVXFMUFNER0FYY3VCbUNjNDMzTm11ek5YWGx4UmcrTk5G?=
 =?utf-8?B?MVlJREl0UUtnZW5idGN0WmpFT0JkT3hvd2ErR2dQanJrak9MVzczMW53TGR0?=
 =?utf-8?B?WmdkQVZvbXU3eXpqSkxsVzk4MWV3YWdFM1crWXBjdnhNK0FPYytiaDFHUEoy?=
 =?utf-8?B?ZEhwbkJGczdZTEp0b1l1WC9CSnVjSjlydU5IUG5MYVd2K1Z1djQxeGRLRjZk?=
 =?utf-8?B?TXRnMy9ERkFIWFUxQzBUNUdaYmxPYU5sYUdtd3pZOWk3VWZuU1JvK09CT0hq?=
 =?utf-8?B?UVBhOE9ZbDlHWkhhalVLdGg4MDBHeTZuUmhtblBlSmdibUNQT3d1dzdZR2Q2?=
 =?utf-8?B?cEpad25DVDJVT1lIbGZWWVJxQlViL1g5aUNJTXFTQXZxK2FVMnVsYThWWEpT?=
 =?utf-8?B?TlpqUWMxZWdxWUtXS1VvYUJ4VVBscEtodFlWRE0zRFNyMnZsSXFVVGw5VEhn?=
 =?utf-8?B?VDZEa2lyNXB0QTJjY2U5N1lCTEdHUHN0SmdtN0taQ3FxMkRKL1lZbGpIMi9H?=
 =?utf-8?B?TDl0UmlqRFlMVFhIMVJDZE93US91S0lkN0xRZ2dNeU9zOFR3c1VwYUREanVP?=
 =?utf-8?B?Y0xTdEFVaCtSV01TYW05S1hrQ1loRGVSTEpkaU9qYmVmcFJSSmF1Mk5qZ1dw?=
 =?utf-8?B?WkdCZ1c4U1FPcjE2REY5dFpCTWt5YjY0WjQxNitWRU5rYmdRY055QTA1eGhn?=
 =?utf-8?B?YmVMWnZld21oYmNISUFQQ21vUlJRWms3WWdwcFRVdGc2bWlBbVhmTWdLY0hp?=
 =?utf-8?B?a0tVQTczVGlVNTRUTDFRSlorcFlKeHdtZVZ5b1prUlk1T2JCd3NuYUVyS3Ry?=
 =?utf-8?B?WFpQbWxLeC9iSHlwdFAvb016aE1uS25PUzdoazNYUFRZK3ROcWxWZHIyS1Mv?=
 =?utf-8?B?d2FDVjF4ajZYaTNOTkJPcWg4M3pBOHluWXJRbFJ4YTZuSE9rTjVXVVFIMkd4?=
 =?utf-8?B?WWJHYWhPQ3NRcmFoMHd4TFBkSzhSSkt5OWhNYTZ5VlZsZzFwQVBuUT09?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b86cc-7bbb-44c9-26d3-08decb76c646
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 07:13:32.7734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TewolGcR5t2LFTLc8sDXRBgvnlmUWn3sEypOrAkVmY+OkVxV0XKKGu96gGBkwNtbLXiBiCxCQIfuvjH4R70+QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6227
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Jun 2026 07:13:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23151

On 16.06.26 07:06, Shivanand Kunijadar wrote:
> This enables the support to build Sid based images in the repository,
> which helps to detect the issues in advance.
> 
> I've confirmed the Sid image boot works for SWUpdate & Data encryption enabled images.
> 
> Shivanand Kunijadar (2):
>   Enable Debian Sid support
>   Add crypt library packages for Debian sid version
> 
>  Kconfig                                          |  4 ++++
>  conf/distro/cip-core-sid.conf                    | 16 ++++++++++++++++
>  kas/opt/sid.yml                                  | 15 +++++++++++++++
>  .../initramfs-crypt-hook_0.11.bb                 |  2 ++
>  start-qemu.sh                                    |  2 ++
>  5 files changed, 39 insertions(+)
>  create mode 100644 conf/distro/cip-core-sid.conf
>  create mode 100644 kas/opt/sid.yml
> 

Thanks for enabling this. Should we also provide a forky target?

And another question would be if we want to have a CI pipeline job as
well, though one that is allowed to fail.

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center

