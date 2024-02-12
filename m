Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0E5C4829E
	for <webhook@archiver.kernel.org>; Mon, 12 Feb 2024 18:41:40 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.89])
 by mx.groups.io with SMTP id smtpd.web11.14603.1707763297882569917
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Feb 2024 10:41:38 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=C2vKVP0m;
 spf=pass (domain: siemens.com, ip: 40.107.13.89, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4NRYp6pm0isUnT+6vFMD8RvvA7wU5htBsQsGJODNRtSFJiTW9j7I4d9d/ngm7V8qtDdTZWpOFucapltGvsZn6leZs4ClW22HAKNlSv5QK5coFyUUWNivWYhHgQ+710tnn7IHEopmEknGz+Ut5r+/2+I83Na+I6EWIPGFKOSQSovUtAU65Mb/Qkaay4MUULGkAzenZXp5WuLlkOTwhn9/3o1LrrdL7sll9XF02PJt60hwhLOweikl19NVVV8h/4pbsajtNYCuD5yaocLiPpuJ+KFYxLqRqsDYSa46YmzySb6FBegQ5Vi22ZmdgdzFcAERFRjC6ogKRbI8qYAFCJ91A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tBt0lXCKSqog72SQu/IvVzFcQBE/JXereeJQRyjj6yg=;
 b=BXtdzg8khiBindtd7dyXrys406s2EYA6wGs7NEQG/I8aEM63IQWoxZk68b1Cupu1rXqBfCwyveyDnxKq1ZBaAiW5DJjZttEpgUnQYOrsS8g5B6JRJBqh2BRUiaw4e6xQnV924LknwpEkDDHDhKjR6fMpMnQP4m0twQ5Sskwlb46GeZwZseIYeAeB0ljJIyv7lwFXFl5iB0Hta6/xVCY+vpr5UmrtBpFMrt93jRochIfJV1lscUCO4OZRavhrW3agao61XYMAsEfWXFpfVxO1AvHr00CUhtuRg2Jn75szEYZOYlXbXcYTa/4EMGzvEhDyv4k2LOnQNKW0oa594/57JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tBt0lXCKSqog72SQu/IvVzFcQBE/JXereeJQRyjj6yg=;
 b=C2vKVP0mJZ9Aao6YDa+RqEsLVZhwvS/1D05We55hlw2wkqsJNE5R0O4ZrF/aTS2fyMklLWs2qYTHjntxVdr2xwkk/yFXveOlXx1t67PpmxWpvSoirh7oJiGPiy4SN/+pZdjP28t2U/S0B8tMQ2bHCLPV6WotwFwVvtWa/IZ2w7muFRcmhcfHatuvpPvV8OvVssoEcE0O4y5YlaG1hkcT+AAA0gPSmecknOtZuQO8UjFGyNjuZ8Quo0nOwatvCl04rCjNFzkrTDSH4gBCY+SFeXrk+he51oiPV1S8in6lhwhrHf1KVCRS4CH0JqcmK8rS+hYfg1AGXrIURis5YVge4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS1PR10MB5577.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:475::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Mon, 12 Feb
 2024 18:41:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7270.028; Mon, 12 Feb 2024
 18:41:34 +0000
Message-ID: <cc0abac5-1a10-47a6-bfc5-88e5d4cd49c2@siemens.com>
Date: Mon, 12 Feb 2024 19:41:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/3] Reduce difference to
 debian
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20240207134505.3286003-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0012.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::17) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS1PR10MB5577:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f89db4-a665-4223-c64e-08dc2bfa3cf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	0qDAYGnAJQ/+1/RrdVm/bfiI76KmXRXTRO5P9GY+GrR+pDX+M61T4TLvApBLmor38LKf7THHOJxYSnxaFqv6eoOR97plBVORh4lfQdfLL4OPoXn3crYaQdSwUMXFq1ztnzQxwHM5gE3yKz+shmeykINs0PoH4ijIP50hfMG48AmAE+vvvKRiOXW8reqp37dF/oLIZCiskKQY6Auml+WIjESVtRegUofo/MLgnQ8oJagskO57oiESXm4MD2C2kx+EOdooGePN2H4FgHtHAs1ryMdFojNQl0APDHuuY7+bwvk2OFzN/olvcFEWoa5SzpVl4WvlaGVkuhUtQgTd9mxXI9Kj41q9q5+sUXt7YpW3jxieb18pbSCnz5Bdyz2iTvnpKJMu4oA5KlTjF9jyF13MCcfmo2tCdwfgvs6xtNlFUmNU3TSeP1Jmq3z5tLU8e5nukEKkOfgwrNHWLmwL76aSt6ppDLzPDDP5VgTx7vY0f1RyLRHPDhvdjkQgErcH0UPqKXs0tuRpzW8EvvAiFbyEKjSiWDplRR6eK08x8FQLKOw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(44832011)(8676002)(8936002)(5660300002)(2906002)(83380400001)(2616005)(86362001)(31696002)(36756003)(38100700002)(53546011)(66556008)(66946007)(66476007)(6666004)(316002)(26005)(82960400001)(6506007)(966005)(478600001)(6486002)(6512007)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WU1TYmY4ZkJBRGE1VGdyaGhCZjlRQVEzL0lPeU1jdGVqU2RtekRvZE1NZ3Vt?=
 =?utf-8?B?cGkzSjJWSDJ4ZDNqbFFwZGJKTnFOZkFFT0h3YkN4Z1pLMHZ2WUVmaW1udmRi?=
 =?utf-8?B?bnVHWEVtSXE2RFJ0WjBXV1hXcTZvZk9JckpKNEdvSExyaW04MEduMVpZTlVw?=
 =?utf-8?B?elVIVWJKU3lpM09nVm4rMmZYbHZ0TnFFejZSbmo2MHJXbkdmS1E2M0ZWcWN2?=
 =?utf-8?B?ajdSdlRnSG1mQ3RPdGRqcitmYjlpU0FlbGZnbUFScDFSSy94N0pNcnRaR01C?=
 =?utf-8?B?NFJqS0hQdEh5ci96ZGdkRkErS2Q3WHJhUlZwQ1Bud25oeVJMMW5YK2xyLzRI?=
 =?utf-8?B?Y3R3TU5iZzZBaUtOa0lobjZ1QVlObmRiQ0dGZ0Zmanh5WW9QYlpJYitOMEsr?=
 =?utf-8?B?MjNCRS9Wb0JmLzhDMWwwdG1sSTV2VkNKbnM5MGpPbktYSXdMZ1p5TTl2LzlR?=
 =?utf-8?B?THFqYk5qeE42TVpGZnp4UElEUFhWblZ2Q2UvOVZVQTlFTU50bHltenk4WFJv?=
 =?utf-8?B?U2tacUR1YXZ3d1B6cTNOVkV5NUwzaERIV1dncU9PdkJGWGRSWUplQWNhQ3dB?=
 =?utf-8?B?dXNwSThDRHdGOWV4RTlGRmJEZFptYjk3UUk1bnRzV2tkZE14cVc4bUNrS2ZX?=
 =?utf-8?B?akJUNDIvRkY5K0R5aWVuZ1dzRDZqYVl1MTM0d2ZhelBmWkpSVHJaZkZ6MVRW?=
 =?utf-8?B?WW1Vd1NDRWlyUk8rWFZjQlpGeUppQVN6THFqL3oxVmNzSTYxcHdxUnZzU2Nn?=
 =?utf-8?B?TWtBK0ZLTE5HWjhQQnlUa0xoMmpqZE55NjZWRWF0N1ltN2k3bldKakcwWFlj?=
 =?utf-8?B?R01BNXg3MlhWZ0tsV3FPY1R2UW8vdXZ2YUpkd2QvU0lPTzRrc2ZzNDVKTHli?=
 =?utf-8?B?bGVQNGFRak52LzRXbnRReG16QUVEZlpxNXhrcGRhcG1UazB3a0hhakRCaDdV?=
 =?utf-8?B?N1RZcmREQzF4ajArTnhhVTlwS2xwNUx5VkJJUGQ5L1ZoT0kwUUNhMmF6V1Ir?=
 =?utf-8?B?dTBFWHdjVDBRbDZKaG0vYmZ6OCt2N09jRlNpZUQvZ2w1UjdXaDF6RUpOR0FI?=
 =?utf-8?B?T1FvYXBWRUhSaHJVWWdNVTNSdCtvUUdsV2tOYXVSYkRzWmhCNUJuT3BWNm5G?=
 =?utf-8?B?Vk83V0xzelZlNlhaQTN2Y3h0L2FFaWVtL2luY3pianNJeTZ6cTh2cUJMaS83?=
 =?utf-8?B?UkdIek9rN0ZtdHNJbGJYazd3dVgyOHpuZisydXFYWjY4RDZMM1NkeFFEWTBP?=
 =?utf-8?B?NjNXMFh5bTBoNlp5MklQb3pIQ3lFQm84dmZ5dnc1TTR1OUpBZDNYMkgwQThi?=
 =?utf-8?B?L2g1Ujc4RnBRbjR4YUxMU0NwZ3dNTXA5UW54M1kzV0E2cDV5cmFOSHZyYXlp?=
 =?utf-8?B?RytqSWtkTzhoL1MvUjB1OHgrM3BTY3JkOXoyNTU4REJ6NFBXOGF6dk1YaDBX?=
 =?utf-8?B?am9PdE1EaUFUSEpkWVU2TUJ3b2xuOURGUmk3bSszSnJGdEduM1lZU3Mvcnp2?=
 =?utf-8?B?alA3aUppelFCcnB5NHJzRDgveHNla2ltRStGVDhvelJXVUtDd3orRUhLaE9x?=
 =?utf-8?B?SmhHK3E0eHZxV3pYUW10TG44bXZuZU13dzhYbnFta3dRT3Y2WVQ5QVYxSmor?=
 =?utf-8?B?Y2xMcDBvbzlDMFBtejlhQm83SklLU0VPcm9YT254RmMwRnVuSnpiTnZvM1ZX?=
 =?utf-8?B?VUdtMU9TYnpBNmY1RmNnclF6TEpuQXpoTzVxT3VVc01VbEViK1JEdDZEYnFl?=
 =?utf-8?B?aTZ0Ym5ZT3NFZjZsR3ZNTFpYRFFDYkFzdjczWnFPRGJ0TkNxaHQ4MUZpeUFX?=
 =?utf-8?B?blcrUmpMS1NtQ1E4UlJrOFlNaGI2SGJUdWF1c1pzbEZnaEEzYk9FN3BFMVZ3?=
 =?utf-8?B?UXh1c2txdmlVSkEzVGtFQ3NGSVhhVDE1cEtwVjMwV2xwdFp4N29mdC9aZ1pB?=
 =?utf-8?B?Y0hUMVlya0dDMDBRRFJiWXNjcnk1YUVhRnAySHpJVHNvOFB4OHpUTVlRRHBM?=
 =?utf-8?B?dlF2N0wra01BbHloSHU1U1pOVmtvYnl1UFRtc0Q3UHZiaUdBUE42Mkl2b3Fj?=
 =?utf-8?B?bHhUcGpPbml6V21TcFRrK2pKR1JaRmJyMk5NMFprUzNxN1BZTXRRQTNIVzJL?=
 =?utf-8?B?SUEvTmVJUkxWemxLYTZTRUxVMFBmU0RISXpIZDc4QXQvbk5hUXVSWXJ3Vm1r?=
 =?utf-8?B?dmc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f89db4-a665-4223-c64e-08dc2bfa3cf1
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:41:34.5872
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrRhDfMsBv4eQxEWTlCpzD3OXiEJCkHHtG+n72bGEJoxoJ/hbb9kSn//iPvHFkhDA+kHzi9WCueAnt9YTBguGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5577
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Feb 2024 18:41:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14928

On 07.02.24 14:44, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patchset introduces a new configuration package for SWUpdate:
>   - It adds /etc/hwrevision to allow removal of the
>     swupdate.pkg.nohwcompat build options
>   - It moves the swupdate.cfg from customizations to allow the reusage
>     in downstream layers
> 
> Changes v2:
>  - drop Add patch to copy the server_wfx.lua to /usr/share as Debian
>    upstream is also enabling CONFIG_EMBEDDED_SURICATTA_LUA[1]
>  - Use RDEPENDS in customization
> 
> 
> [1]: https://salsa.debian.org/debian/swupdate/-/commit/3dede8b0bd8fe2a313905512fa738dcb37ff46481
> 
> Quirin Gylstorff (3):
>   swupdate-config: move swupdate.cfg from customizations to own recipe
>   swupdate: set SWU_HW_COMPAT
>   swupdate.bbclass: weak default assignment for SWU_HW_COMPAT
> 
>  classes/swupdate.bbclass                      |  2 +-
>  recipes-core/customizations/common.inc        |  8 ++----
>  recipes-core/images/swupdate.inc              |  2 +-
>  .../swupdate-config/files/hwrevision.tmpl     |  1 +
>  .../files/swupdate.cfg                        |  0
>  .../swupdate-config/swupdate-config_0.1.bb    | 27 +++++++++++++++++++
>  recipes-core/swupdate/swupdate.inc            |  3 ---
>  7 files changed, 32 insertions(+), 11 deletions(-)
>  create mode 100644 recipes-core/swupdate-config/files/hwrevision.tmpl
>  rename recipes-core/{customizations => swupdate-config}/files/swupdate.cfg (100%)
>  create mode 100644 recipes-core/swupdate-config/swupdate-config_0.1.bb
> 

Ah, here is v2 - wasn't recorded by patchwork, strange.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


