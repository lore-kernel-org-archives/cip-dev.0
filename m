Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEFC54EAA
	for <webhook@archiver.kernel.org>; Mon, 30 Jan 2023 13:54:08 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.62])
 by mx.groups.io with SMTP id smtpd.web10.41217.1675086840640532920
 for <cip-dev@lists.cip-project.org>;
 Mon, 30 Jan 2023 05:54:01 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=RRIv/kKD;
 spf=pass (domain: siemens.com, ip: 40.107.21.62, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ljpIkY6HlNFxbTPBGga8zQOAI7m2QFTdWrJ0gkdRukDoFhnS6+WMIC3NSBsdNWOsS7/XeOqrXASegIMoXDKY0JJsBda3XId3vfp2pBNR/JaNjBg51aTJv9KLQbNylHue/t7Xx4CoBupetQ4+/NzFzoW8g9zZywGyTREGSSSbwwmdPO+xAUtcl2PlS5h+mYWkmddYqQzrSGEmKT+DYqJaCWzQjGvEwlVV+otrhR+LQKoVjdx2g7lNvp890MqJdJHng4ziIHCbpdytNRYzktwEBCJaJBj/kuI3CXkpCwhKIeCQorSGWVrVYjBrSa/K0GTSC9fB/XIXwhj+d/YeyVlZ6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPwOTBodmQZbH3QcGi5aN7IR9brA28LYguiiZF/2vD8=;
 b=MiPxcWKUthMdDKG2fYyDwgfO4kNqKPWnJ6Cmnp7EbXztyIA7+qaiGmpQiEQzS1U608R/Du1GfWhJMHZm9q9APtRE97p8c2zOQGK2di9Tx62N5iT1iIqyjSvA59m7eE5gbYgjFNcgiY4YOGAMcQMmX2KP2y0699yfdhZn+1etxP4uFI8Dc6k5wUwixAkN+ucGl1rPjeJeK5JQZrfiMVlfGo5zlJ1sYmxbZOcM6BOmUd4xTBMvJpYwdCiFk2W+dYRct6r8DHzx2fKkofUVhhICJefMdWDe0P2chgxOKbgXj8mM0kaK45tytEXVsjnOr0J6W+H6AiVZUYyjBY3/v3Y+og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPwOTBodmQZbH3QcGi5aN7IR9brA28LYguiiZF/2vD8=;
 b=RRIv/kKDUW4eUdYO7YOmVMPNAbEi5o+vLF2RApm5ZwK3O491qbcQf84znw+xLqZ6Xfnase1qIrlHn0Ci+qzl87jfRuktj8R3fwKq0BB34xxdfpJEEjgV39BTVL0iA+A+b+vrMsDB2yPLx5aB8Av2eY/JpQf6gQHiQ6tWJVhVJkjdwRvfJZXSzR+QJ9p/E5f33PEIx8RZYYLillEeM1198PwElkxgSfSudulMtD8ZuR2mKyBj3JGfnFzEo/aw+ASfbTUpArlNFC+71tqM1dmYViLmiXhjqEAXALLTxW/9btIuFTRaSxeYP0tUReV2uCixZRIqUXcCbyEciFrXH8qghA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV2PR10MB7030.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.28; Mon, 30 Jan
 2023 13:53:52 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::793f:57e:21e9:3741%3]) with mapi id 15.20.6043.036; Mon, 30 Jan 2023
 13:53:52 +0000
Message-ID: <efd2c2d2-79e0-f5f5-534c-33ddba4540ad@siemens.com>
Date: Mon, 30 Jan 2023 14:53:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED INW-CN)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
 <97eb0b03ed4831bbb9d3eebee92da01ee85b4c0d.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
In-Reply-To: <97eb0b03ed4831bbb9d3eebee92da01ee85b4c0d.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0P221CA0045.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::15) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV2PR10MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fc3914-c420-45fd-9fe2-08db02c96b65
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mJrvWmHtuBMwPTgXG3t2sLH7/Ji93xE1ox3TCvIO+18ZHhqQUn0NT8GCT63rROVxlXM+gJ9DR13JCBV1h+LArCMnEaGiw6/6CAjXeZ2Jp3km8ixL1Fku8th3rpz/AgSsdpPn01gHsfJMlfjH+XasBOmUR+5V5dDquqHU9els5SWYTdlmMhrpoxk8k1WFXD55IXtSfCnRcp7j+V+mdd7vd+jgP1hHKIXsYTipNYa6+s4InUxWvjKRbxLXUm5hIS/zSZnTl5su04DSuv5LYxLz/RSwcCjvNr6nLjypcDjcYS9rtX2hRZhPOrIygCMr647K6ccgxAL5lJCtSfexIw3fO4LTgfYGxNJGSkKvhRJtnpDZX/nDXLRdZurdnU/77wQ1TyHwKp52kcMtyIIwWETHdyPXkaHW2VED5KeGLemCP/HdlFCsBD9KSqp26Hl4QeLRxkdtkh/JOZV2ySYddcsbV31QVWvbtt4StL4eUog5bhIeibdZ05HcRcL7AyIwWosTUxbsFTAiQlYH7KcoeUlWCjoxP21zbRwXv46sg5H3pzVuPdgxw/kzYwkKQCFAJpGMPodfMumEmbtUW/uicz1o2KKh1+kjnE2lHoBtrwkUrCICI64aOni6fK52mEXV+u+MIvuhI2q4VlgU/04FT/sTuIaFf4SaT9iKCm7RBaiRMHUgWOeCzp/KKj0GLamwacZ+fkgYDbY1PwXy0Fn2yk7fmLz5Fp9WwieIBpmFBJXlf8Igw93hViWTu6ViHF8fNvP9CFGHowcThgUINiq9IQUqnMZQ5BXU9a9+44RsFaN2JhY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(451199018)(31686004)(2906002)(83380400001)(82960400001)(86362001)(5660300002)(41300700001)(8936002)(966005)(478600001)(6486002)(36916002)(36756003)(6512007)(6666004)(53546011)(31696002)(6506007)(186003)(38100700002)(66899018)(110136005)(2616005)(6636002)(8676002)(66946007)(66476007)(66556008)(316002)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aDBBYVJFdVAycU54K3lQUVNlbWdiWHZzR1RuaER4V3dJcUt3ZllmTnM1QXNt?=
 =?utf-8?B?ZzI3dFBOaHFmUmtkaGh6YWlraXNMRzYxaHdCeVBVV0luWThWbjM5cG9mQXhI?=
 =?utf-8?B?M0cwdjVVUnlJZnl6WS9JcTg5a3F3YzJiU0l3azJIMjBWc1NhUWc1YVNDRG5M?=
 =?utf-8?B?ZmY4ODlycUlwUmJWbmJuZ05EUmx5Rnl5ZTVFVC96d2ZSS2M0THNLQWxnS0l4?=
 =?utf-8?B?dTJld2lldzdVQU84c2krNlZneis3RWZzWXpVYy85M0hMbGl1VW1MWVJHc2Yy?=
 =?utf-8?B?WFdLYUpyNTQyR0tDbC9YTkpyYU11Y3RTeUhxU1cvbit1MEs1ZUY0OS9mNVdQ?=
 =?utf-8?B?eU5kUUVwMForSjdpQ2VXNTRmZ3JXVUF3aHRnTExpSldnc0V1dllodHgrdnVi?=
 =?utf-8?B?cWFYOC9ld3JRaG9kZ0JTaXNSL3RCZHBaU2ZjR0djaEdHUGlua2NKVHk0OStK?=
 =?utf-8?B?bGttTUxsMlp4TVpJRldwZ0xmS0hQdVUwV1BKT0d5WTNjN1labjlQbjhYQzF5?=
 =?utf-8?B?eUtseDA1WlFydHZQSzVnYTloSFQ1UVJ1eG43bzNvWEdNTHZCMXArb0dHazVR?=
 =?utf-8?B?ZCtCeEhYMzlLWVNScmlrSWxHL1ZIazJxUnBSeHorWFN5UW4zS2dRMTMyOGhJ?=
 =?utf-8?B?bG03STRmNXpVdmdlWDNZMnhxcHRGcFJUcCtYL3ZzRzc3bGd2N21sTnlZcUlv?=
 =?utf-8?B?VXc0eWV5aUlWQm1mUkduVzBFVS9zcnROTUJwd24xWmp3eVIvY3Z1em40MU9s?=
 =?utf-8?B?R1l5bE1MMlR5cUo3dGRndzkxLy9TUWJlK3ByWFd4dzRxV2dxWTdUL3dqNUdu?=
 =?utf-8?B?VFZzTDR2L3ZLSDBXM0ZUaGtDdVJWOVpiM2JwMXM0TDhkV1g2YUlKL3BCKzVM?=
 =?utf-8?B?L3NMSzhnelRWdk16L2lDNGNPUFlwM0JmbEdrYXdVSWo3dmV4WlVCMnVuM05E?=
 =?utf-8?B?dWFPWThORVR4TXdvSGpvQ1hBSmhVMk5uZ2FnYVg2SHJSalJmaUFlYUpoTHVL?=
 =?utf-8?B?YS9OZEVaTHNzSlo3TzM4ZjJHNmRndmpUQzZIdEhtYU42dUxKdVY1MGFtcWVx?=
 =?utf-8?B?VDUvbllPbWlmLzEzQVlqUmNOSUk2enBLRWZBR2FsdW1kMDFManpWb3MyTHNG?=
 =?utf-8?B?UG5zRENKQlRkdXduOURWT05rV0o3d1hYVUNEdU92M3l6NzB1QkpJZnFjZ0d1?=
 =?utf-8?B?Y2NzbVNZRlFtQm40TURIMEZwSzQxY2R5QjRwYXlqb2gwL1dxL3c4a1NLVVN2?=
 =?utf-8?B?N1p1aXFid0JMRHFQbW1ET29xOStKNDVFWDk5VG5ldXdIcE1JSWIrQ285RVIw?=
 =?utf-8?B?TFBSQjRLZDkwWHRVME84WTNqRzA3Vm9zU3QxbWdhVFo5Umo0L1ZTdjczaDZB?=
 =?utf-8?B?TEdwUE5qRk1SZ3p3OXVhcmhoaVdLVnBGb1VLSXJhSFB1OFF0aWU4a2d5YTdP?=
 =?utf-8?B?YUJiNUtCMWFRSDVxdjRiMER1SGMzSCszMUFoSm1MNDRKRFRGdXh1eDMzOXFm?=
 =?utf-8?B?QnNvei8wMUEwcUMyZ0Jid25HNGhQeWdlYWpHazRRRGhaOTkvQ2NmOHJQTXp3?=
 =?utf-8?B?UWhVTXhRLzk5WXdGK01RTUYrdGpLa0tIWnRlaHYreG04eTRicTZ0UUw5UElU?=
 =?utf-8?B?Rm54UWFOVmU3aWV5czFjUThYRkRNOUY1V213dDRSMndXTHRGRENQZzBWUnRH?=
 =?utf-8?B?aThXR2lvcVdUNUp5ZVQzaGJNNTV0QXlZbm1sVXJTZE1NOHZkM1NQSFV5TjhZ?=
 =?utf-8?B?VDZtNktIemhXNE56Q1J0U2tJQXFuOEdjSXQySzg4Tnl6TnNtYVVMRzZiQVR4?=
 =?utf-8?B?bEZCNEFjVld6MHhONnY3ZUVpVWZPcVpuSEdaOStVaTVQZ0cvR0J6anRYVlQx?=
 =?utf-8?B?cklUZG5WalFJeFk3ZEsvTWhzbWsyRzFMSVEzWDZWSkZjQm00bjgvb0UyRTZ6?=
 =?utf-8?B?eGcwM3NZWGZvaEFSU2FNUWR1UUg5RllyTHR5SEZqS2FZcFJFSDZCVkNkRHZS?=
 =?utf-8?B?SkF5N1F0TzlkZER0UGsyNURpbGxYMi9UMVN5V2F3QjBMOHRmVjFtenZETTY0?=
 =?utf-8?B?NEZaRUFwNkNYS2laMVZiYU02K2lnVVVVS2NwMTRrZE10QW5XSkQ1NnFoVGxo?=
 =?utf-8?B?S21NUHZ2ZzUzMHhmK25CUW9BdFZCaXgxN1dLMHdNcklmS1B5a0Fjc2tOck14?=
 =?utf-8?B?VGlNd2pLTTk1TGpxZHBWTGprU2NxT2xaTHh5a3B3OTJvSVdtMkZKUkR5ZEZo?=
 =?utf-8?Q?Qv56R03G7TTMgPfei0NW7HUC+iCMzX6DIVgH+jV8o0=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fc3914-c420-45fd-9fe2-08db02c96b65
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2023 13:53:52.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hexwjjPSnhDMM1BiVvNtAHw798swjLpGDSxpMQqX4HetkT1szBe+T3B+PRTKVICXrWDwCi9zqIgAKTaiPoyYXhZgDAFmuzLBkZelSG33F+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7030
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 30 Jan 2023 13:54:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10507



On 1/30/23 13:37, Moessbauer, Felix (T CED INW-CN) wrote:
> On Mon, 2023-01-30 at 12:34 +0100, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> This will add prelimitary support for the debian 12 aka bookworm.
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   .gitlab-ci.yml                       | 45
>> ++++++++++++++++++++++++++++
>>   Kconfig                              |  5 ++++
>>   conf/distro/cip-core-bookworm.conf   | 17 +++++++++++
>>   kas/opt/bookworm.yml                 | 15 ++++++++++
>>   recipes-core/images/efibootguard.inc |  6 ++--
>>   recipes-core/images/swupdate.inc     |  6 +++-
>>   6 files changed, 91 insertions(+), 3 deletions(-)
>>   create mode 100644 conf/distro/cip-core-bookworm.conf
>>   create mode 100644 kas/opt/bookworm.yml
>>
>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>> index f7c8c88..2b9505d 100644
>> --- a/.gitlab-ci.yml
>> +++ b/.gitlab-ci.yml
>> @@ -37,6 +37,7 @@ default:
>>       - if [ "${targz}" = "enable" ]; then
>> base_yaml="${base_yaml}:kas/opt/targz-img.yml"; fi
>>       - if [ "${release}" = "buster" ]; then
>> base_yaml="${base_yaml}:kas/opt/buster.yml"; fi
>>       - if [ "${release}" = "bullseye" ]; then
>> base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi
>> +    - if [ "${release}" = "bookworm" ]; then
>> base_yaml="${base_yaml}:kas/opt/bookworm.yml"; fi
>>       - echo "Building ${base_yaml}"
>>       - kas build ${base_yaml}
>>       - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh
>> ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
>> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>>       use_rt: disable
>>       wic_targz: disable
>>       deploy: disable
>> +
>> +# bookworm images
>> +build:simatic-ipc227e-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: simatic-ipc227e
>> +    release: bookworm
>> +
>> +build:bbb-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: bbb
>> +    dtb: am335x-boneblack.dtb
>> +    release: bookworm
>> +
>> +build:iwg20m-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: iwg20m
>> +    dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>> +    release: bookworm
>> +
>> +build:hihope-rzg2m-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    target: hihope-rzg2m
>> +    dtb: r8a774a1-hihope-rzg2m-ex.dtb
>> +    release: bookworm
>> +
>> +build:qemu-amd64-secure-boot-bookworm:
>> +  extends:
>> +    - .build_base
>> +  variables:
>> +    base_yaml: "kas-
>> cip.yml:kas/board/${target}.yml:kas/opt/5.10.yml"
>> +    release: bookworm
>> +    target: qemu-amd64
>> +    extension: ebg-secure-boot-snakeoil
>> +    use_rt: disable
>> +    wic_targz: disable
>> +    deploy: disable
>> diff --git a/Kconfig b/Kconfig
>> index cd24ce2..87056b9 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -128,6 +128,10 @@ config DEBIAN_BULLSEYE
>>          bool "bullseye (11)"
>>          depends on !ARCH_RISCV64
>>
>> +config DEBIAN_BOOKWORM
>> +       bool "bookworm (12)"
>> +       depends on !ARCH_RISCV64
>> +
> 
> Why is riscv excluded here? If the blocker is only efibootguard, we
> should try to get that unblocked as soon as possible to not miss the
> bookworm freeze. I'm happy to help to make it possible.

 From my understanding Risc-v will not be a official Arch for Debian 
Bookworm [1].

[1]: https://lists.debian.org/debian-riscv/2023/01/msg00001.html

Quirin
> 
> Felix
> 
>>   config DEBIAN_SID_PORTS
>>          bool "sid (unstable) with unofficial ports"
>>          depends on ARCH_RISCV64
>> @@ -138,6 +142,7 @@ config KAS_INCLUDE_DEBIAN
>>          string
>>          default "kas/opt/buster.yml" if DEBIAN_BUSTER
>>          default "kas/opt/bullseye.yml" if DEBIAN_BULLSEYE
>> +       default "kas/opt/bookworm.yml" if DEBIAN_BOOKWORM
>>          default "kas/opt/sid-ports.yml" if DEBIAN_SID_PORTS
>>
>>   comment "Image features"
>> diff --git a/conf/distro/cip-core-bookworm.conf b/conf/distro/cip-
>> core-bookworm.conf
>> new file mode 100644
>> index 0000000..86c97a1
>> --- /dev/null
>> +++ b/conf/distro/cip-core-bookworm.conf
>> @@ -0,0 +1,17 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require conf/distro/debian-bookworm.conf
>> +require cip-core-common.inc
>> +
>> +PREFERRED_VERSION_efibootguard ?= "0.13.%"
>> +PREFERRED_VERSION_linux-cip ?= "5.10.%"
>> +PREFERRED_VERSION_linux-cip-rt ?= "5.10.%"
>> diff --git a/kas/opt/bookworm.yml b/kas/opt/bookworm.yml
>> new file mode 100644
>> index 0000000..8b4431b
>> --- /dev/null
>> +++ b/kas/opt/bookworm.yml
>> @@ -0,0 +1,15 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2023
>> +#
>> +# Authors:
>> +#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +header:
>> +  version: 12
>> +
>> +distro: cip-core-bookworm
>> diff --git a/recipes-core/images/efibootguard.inc b/recipes-
>> core/images/efibootguard.inc
>> index eace4fd..d8d3a06 100644
>> --- a/recipes-core/images/efibootguard.inc
>> +++ b/recipes-core/images/efibootguard.inc
>> @@ -8,8 +8,10 @@
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
>> -
>> -IMAGE_INSTALL_append = " efibootguard"
>> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
>> +IMAGE_PREINSTALL_append_bookworm += " efibootguard"
>> +IMAGE_INSTALL_append_bullseye += " efibootguard"
>> +IMAGE_INSTALL_append_buster += " efibootguard"
>>
>>   WIC_IMAGER_INSTALL_append = " efibootguard"
>>   WDOG_TIMEOUT ?= "60"
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-
>> core/images/swupdate.inc
>> index 9b2aedc..a47928a 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -13,7 +13,11 @@ inherit image_uuid
>>   inherit swupdate
>>   inherit read-only-rootfs
>>
>> -IMAGE_INSTALL += " swupdate"
>> +OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
>> +
>> +IMAGE_PREINSTALL_append_bookworm += " swupdate"
>> +IMAGE_INSTALL_append_bullseye += " swupdate"
>> +IMAGE_INSTALL_append_buster += " swupdate"
>>   IMAGE_INSTALL += " swupdate-handler-roundrobin"
>>
>>   ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4.gz"
> 


