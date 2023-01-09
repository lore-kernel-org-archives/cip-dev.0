Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE57DC54EBD
	for <webhook@archiver.kernel.org>; Mon,  9 Jan 2023 07:40:46 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.47])
 by mx.groups.io with SMTP id smtpd.web11.66104.1673250039936410664
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Jan 2023 23:40:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dXECUE2U;
 spf=pass (domain: siemens.com, ip: 40.107.8.47, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R3xH6UHlcc42lGBHcMNI0sUMZNujAFfQPy4zkuVmG2AiBQ6Jnws7yy4MSeHotHnCekJJ3iJX0MDf3049QxhtE8sQxF9dNlpdUf2EfM4mqS7JNFCypycHbYolR90vwCGKF9M0JIjgsWUb8nw8HGLEDzKX/7MI72ClLddTCEzYKeuCS2svGviM8dE/ys6aBiq3nWvz4O7WDfP7ZK2EVkTih3Y3MeUIflPtaE5ckqgPdoo8q+u1/4dN/rdiD28KLJ37UsFnaZD9T7NSsQt4c2WSvATsoL7lDRoGJpB5hnAvdYFk/L+z/3crw1+DLm+20tfWGxtO0gPQesr2IcEWpGJuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HF8EkGIgibctmnDfsvN02i7lEeXQy5VzAOIg+4rtGYM=;
 b=UpSFK4qwcVqDMlwt8dte5zrvKTP+tzlR9zyJ96eGcbftfyt9zonhFscvDOSZ7sUnnFhxf/dFdZY5EOOIpJ/hso2ryK8fPp4EOi6vjtMMrw9ckY8MTNK61XqKtAxAHZ8zsqhG+30a9M1SPQ7TOFNBBLlREnGpyYMUaNeuTmKJNEaGr67PDc/8g37jvjKEsbvPw2d7jIC/ypUkZxIXWrzXYKm296kbMzn2tJTchNiQMnvww7dXdQVy6chwEY+yAibUwQwdSL5IIIyBBQMfDQKZpBF0rp4GngRYQx6ubUYLtyWalYPODIVKe914WZoQhR2etxEIDmgp6s9gaS8vfjXJhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HF8EkGIgibctmnDfsvN02i7lEeXQy5VzAOIg+4rtGYM=;
 b=dXECUE2Uq22494QT4ZzlxVjs1z6sQpKV352knRDWyGzH9ikz8aezkCuRuX0gAaAYMwwmgyxa1f1Wwr8HEDxB9Bh0+LapWuhFqngttjuenopDmfZ1a77hlJnYYBDNtU2HnUnmJVy1RTwAqGvYKLHoDdmR1TMCtGT+NdQBJxurLxbBeyNoouZT9sDoadbhnVx+hX3tIQ1UW72FeV/jWJJq2KMrhnldsGYYPNihVgckFHtKIrRhF/ZsxsFYyfpHgAdSOwTVl2PbPNF2ov+hFtVCGhveOxomA1eAZxoNNQTIxKBHc+htDdnwr/rafD/xwaYF8YOPiN5uOe6Vo1jUP6zhkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3146.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Mon, 9 Jan
 2023 07:40:36 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%6]) with mapi id 15.20.5986.018; Mon, 9 Jan 2023
 07:40:36 +0000
Message-ID: <8a77538b-7676-aeef-d7d3-724cb2edc532@siemens.com>
Date: Mon, 9 Jan 2023 08:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 1/8] add recipe for edk2
Content-Language: en-US
To: "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
 <20221120204711.5826-2-sven.schultschik@siemens.com>
 <ce17712b66a6faf582f44903a2732cf6a48c6db6.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ce17712b66a6faf582f44903a2732cf6a48c6db6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0063.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3146:EE_
X-MS-Office365-Filtering-Correlation-Id: aedab88c-1277-4f78-68b7-08daf214cbc6
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	EJVyDNtm7R8/+1rGz9zDR+glZ+eCKtsqV0Av5SteGhLFp9WS6DBGT0HXGFHUMxfK0gMdLYmnNk/EKQ7QN9gWl20Zss9aI6A28gHExpkIA+nAHinkY5iwTPE7foQSy6ybsM4T8HqcKINN9vPCBcW0YvBxBgYsjHjCCL9pHjL36872Ao14dbBDP5Bc26iYJHO1RKhDPpojKsKerizntYekb0hfUkc1KHobrQZKsljofNAEzJSzlNdcr6H0J5sIMvNwjJ0EP7FZTIT78o5v79pc6qEm78EsbUHnYOiKBUqRPBtoDzgkkQP3kouYPdkoi8DeVKpztwOBEOTBEpxtmCT6g+5xbUPo0s6gbB2BbBB/oc/wxnicROyDUbdeijOsIMiGRivskoI9/qMd/5EMVEGM5MZVLjV2Yos9h3Kzaj6Cgr81AHZx8pbwZxGO2t1j8gpijwv7Afq9XqbPBYhYkj9gq96RrOFT72yzv7q7dlby8yMGblRrGRjenG/NxOo8+RQ7ZqW8oxn4ZNwd+vYC67HLrKibQLYHMXGC+60SB5LxgDHiGMLK8Jr7BiuTXcfjKaX8PtwNP0kvO9TKrU7YiUCwwMh59vLxDxfuxNTQD2L5flyiOdXn4EjbvLLiOjgXlqVHrn2Yp7pmwliyDoiZAYsRzTzZ4tU/iZ2alEDTRER8eGtgsGsE2FEd6WkWOHp9/RqyQsG5jUiPBc2LrlYYN1iEVId8FsbGrQCAoqjt3fTz3Ya3Ggvyob9vCwa6MsrUiMhpnO5mCrf+aZ5F37u4lrs3pTT5Cb+V5f0dvY0pCrhUv1UlktJcbR/HGSkTCn/XKD6S
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(376002)(346002)(366004)(136003)(451199015)(83380400001)(53546011)(186003)(6512007)(26005)(6506007)(6666004)(86362001)(36756003)(31696002)(82960400001)(38100700002)(2616005)(41300700001)(8676002)(31686004)(2906002)(5660300002)(4001150100001)(6486002)(8936002)(44832011)(966005)(478600001)(66946007)(66556008)(316002)(110136005)(66476007)(6636002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MmtCNHJJcElxWVVKdUFQTEdJZkxzMHlrMy9iM0JjNXFzOFhEbU11S0ozRWxk?=
 =?utf-8?B?bzA0OURGa0lKRmsreGxDMjBETXc0MTRER1FRcTByNFcrSlVQdmdsRkRJQkFQ?=
 =?utf-8?B?Z0t4bmczUDA5VEtXdFhOdkRkeG9CbjBoM0pNVkN5NFRvNnVXKzhDZmJnUHow?=
 =?utf-8?B?clgvVmp2Znk4blJhK1UwZHRNWk50Zy92OGJFaTZOV3MrZDJZM3llV0ZlQ0VG?=
 =?utf-8?B?dE4ydG1IWTVEM3kvVHBCbXZ4OFFFY1loOGluS0V1UHZTTlljU1Nsb3JOTDdr?=
 =?utf-8?B?aC9oalBFSkZ2RWRMU1lReEUzWW1JMFRhOHFXSlo4VUNTMGdwdytnaVpSSDgw?=
 =?utf-8?B?eU50dkhaTDYxVjhtN0pOMGRwRVdtNVRKSC83STEzRFQwS1JvQWhxdEZKeUF4?=
 =?utf-8?B?cGg0VGV4Ry9WVHdIQkd6VUs3RnhWRmpIL25RamJyOUI1U1ZQUGt6dUZpd1Er?=
 =?utf-8?B?bDdlZk9laFZwSWtuTGlQbnVlRnpWcFNHODIwR1lsUzVNM0Era1NmeDhnOU1w?=
 =?utf-8?B?TlE1TEFia3VwSmpDemh2bDdRUVNDUXBia3k4K01YcXYrVjRYa1JPYXM2NUpP?=
 =?utf-8?B?UXRNQ0VHUzlBcS9wUk00R1BMRTd1UHluU0U4WHIwWjlPZm9pWXdiUUR0a24w?=
 =?utf-8?B?TEljazM1RkxzeUdXYURuemsza3BEQ2lmdklOOFJSNVpXajMvMkV6d2pmQUpC?=
 =?utf-8?B?RkJwWllPUWN3dzJmQU44S0IwVkYrUW5Fc2UzNHZJbk1lYWZkY2grRjZ4RXlu?=
 =?utf-8?B?UDZOeDNoT2FZdDZSWWFHNitVNW1Oc1NSWWFnbzdhZjlicnpvVW5wVDExREJw?=
 =?utf-8?B?c1JPcGlHR1g0QllPa0Vwa3JGcmR3ZWZnN3NCNnZ5RjUvTXdHRTZQaEpOTTFi?=
 =?utf-8?B?eGZVWlE4elNtUXlPRTFnNDZhU1lKSU51bUtydlhsdURzU0VMYWNpQTR3Qzh4?=
 =?utf-8?B?WERWMG5uVGRJajA4QXFRWDhYd2hEUGpEcllEU1RFSjZLOEY0SGpBSWw0eFE2?=
 =?utf-8?B?U3J4bGdYZ2JIYjJ4ajl3V0xqcnEyaFNNT0wrUVNxREV3OUd2NE9JMmxodjJY?=
 =?utf-8?B?OWxsb3NrMVNacms1RXNhOVNxekZGWEFrczR1ZVhML1hnTkE1LzFDWFM3Ylpu?=
 =?utf-8?B?MG0zMlUwNng4R1RpTmZPREFtN25ybjBNa0paSldEeXlxR3BocHZUY2xFSyt2?=
 =?utf-8?B?LzRzVG1jcHUrTnljWmdTK3JPeCs1TStzcjJneG5qZUlZdDlmUzVVeE0zcUUx?=
 =?utf-8?B?U2ZaNmZtOUVueEo4cm1ZZWxKajArWmt2VWtCY05MNUN0MDExZTRvaUlzOFBF?=
 =?utf-8?B?Z3ZWY1ZTYkxVa3o0R0xwVWdCN0FXUmhPNlN6WldoUFl5R1MyeFd5dVlZSjF6?=
 =?utf-8?B?aU5WWU4rdXczcm5uU1hrMTdWZFAvYThrWmRaemkxWVBwN2JScGxISWhNSkZH?=
 =?utf-8?B?SzhoblZ6SE5jUnRvWjFEVFRIVm5rRWVHNnFwSG94YmwwNlZuYjhFeG5JSExh?=
 =?utf-8?B?NXlJNTBkYW53dVlhajljcUlBOUJBdHJmWU5ZZ3F5amZPaUlSaFZsUnhGZzRs?=
 =?utf-8?B?OG1kdmZMOXJvY21iL3BqOW9ia3lEL2J5SnVaWHR0U25BVnMrQi9DN1ZrT05y?=
 =?utf-8?B?SWpaY1NRUU8rVjgwWmNzNXBuTHljMWQ2RTJmQTlPU2xWdVJIQ1FJL2dFYUUx?=
 =?utf-8?B?KzRRcEgwU0kzalVEbFlSNW5tbHc3UzVxeVNRbnNCSm5LU050NHgrT3NHUGVw?=
 =?utf-8?B?Kyt4NEYvRGNGa3lhZFJsdVhySFpwR3RPb3NKQ3BkSTBCYmFFSitUUEJ2anhL?=
 =?utf-8?B?T25BWVFoODlvTDduY1ZXVkFOSXFLblZsSkJqTWovZW9YK3JUd1dPOE9WQ3ln?=
 =?utf-8?B?M05veDVKdGVmclljaWlLMUpZMU9tN2NJMjVwbkJRd0VQZEdyTlJEeFlHT21K?=
 =?utf-8?B?N2JyZUNvZXpOaFlBbHRoYkRmQTJPSlRXTm9WUmQyb3huc1FCQUZjZm5ka20y?=
 =?utf-8?B?U3E2U0xzRUR1UDVzOUdaZXlvdVh4bG5teVRDV1RYdE5mNUJPYzZIMm1JZzRN?=
 =?utf-8?B?WGI5Z1djUHdUQjZSVnFMSnlSYmt0bWVkNVk2ckVSTUdlRzJsMHU2NVB3SXhn?=
 =?utf-8?B?VDdmVnJCR3ErWWR4LzVJWVFMbEFkMTBYcVZyTUR1RU56MG1CQmNhWnFyZjlP?=
 =?utf-8?B?SkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aedab88c-1277-4f78-68b7-08daf214cbc6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2023 07:40:35.9797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mOUhQUIdfQ4hJJrm8PSlA5AwfngNm1gCNKDy+AEBkjIFyYzh5WPo8vLTxZ8u3tkSugOdg9SsYBp6z83u0v3Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3146
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Jan 2023 07:40:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10330

On 09.01.23 07:42, Su, Bao Cheng (DI FA CTR IPC CN PRC4) wrote:
> On Sun, 2022-11-20 at 21:47 +0100, Schultschik, Sven via lists.cip-
> project.org wrote:
>> From: Sven Schultschik <sven.schultschik@siemens.com>
>>
>> provide a recipe to create the BL32_AP_MM.fd binary by edk2 which is needed for the qemu optee generation as dependency.

Should mention the StandaloneMm for RPMB, what it is and then mention
where it will be used.

Also adjust the subject - we are not building complete EDK2.

>>
>> Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
>> ---
>>  .../edk2/edk2-platformstandalonemmrpmb.inc    | 56 +++++++++++++++++
>>  .../edk2-platformstandalonemmrpmb_202205.bb   | 12 ++++

Recipe name became too unreadable. "edk2-standalonemm-rpmb" maybe? By
convention, we don't use camel-cases in recipes, so this cannot help
with separating words.

>>  recipes-bsp/edk2/files/rules.tmpl             | 61 +++++++++++++++++++
>>  3 files changed, 129 insertions(+)
>>  create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
>>  create mode 100644 recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb
>>  create mode 100755 recipes-bsp/edk2/files/rules.tmpl
>>
>> diff --git a/recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
>> new file mode 100644
>> index 0000000..3277cc8
>> --- /dev/null
>> +++ b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb.inc
>> @@ -0,0 +1,56 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2022
>> +#
>> +# Authors:
>> +#  Sven Schultschik <sven.schultschik@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +HOMEPAGE = "https://github.com/tianocore/edk2"
>> +MAINTAINER = "Sven Schultschik <sven.schultschik@siemens.com>"
>> +LICENSE = "BSD-2-Clause-Patent"

We don't track licenses this way, so better drop this line.

>> +
>> +inherit dpkg
>> +
>> +SRC_URI = "https://github.com/tianocore/edk2/archive/refs/tags/edk2-stable${PV}.tar.gz;name=edk2 \
>> +    https://github.com/google/brotli/archive/${SRC_REV_brotli}.tar.gz;name=brotli \
>> +    https://github.com/openssl/openssl/archive/refs/tags/${SRC_REV_openssl}.tar.gz;name=openssl \

Can we use the Debian sources here? Would avoid separate version
tracking (SVM, OSS license checking...).

>> +    git://github.com/tianocore/edk2-platforms.git;protocol=https;destsuffix=git/edk2-platforms;name=edk2-platforms \

Why not using an archive here as well? Even works when there is no
release tag.

>> +    file://rules.tmpl \
>> +    "
>> +SRC_URI[edk2.sha256sum] = "e6cf93bae78b30a10732b8afb5cc438735dc9ec976ae65d12dab041c18bb7987"
>> +SRC_URI[brotli.sha256sum] = "6d6cacce05086b7debe75127415ff9c3661849f564fe2f5f3b0383d48aa4ed77"
>> +SRC_URI[openssl.sha256sum] = "6b2d2440ced8c802aaa61475919f0870ec556694c466ebea460e35ea2b14839e"
>> +
>> +SRC_REV_brotli          = "f4153a09f87cbb9c826d8fc12c74642bb2d879ea"
>> +SRC_REV_openssl         = "OpenSSL_1_1_1n"
>> +SRCREV_edk2-platforms   = "3b896d1a325686de3942723c42f286090453e37a"

Would be good to clarify how these revisions were selected. Do they come
from the EDK2 build manifest?

>> +
>> +S = "${WORKDIR}/git"
>> +
>> +DEBIAN_BUILD_DEPENDS = "python3:native, dh-python, uuid-dev:native"
>> +
>> +EDK2_BINARIES ?= "Build/MmStandaloneRpmb/RELEASE_GCC5/FV/BL32_AP_MM.fd"
>> +
>> +BUILD_DEPENDS   += ""

Useless line.

>> +
>> +TEMPLATE_FILES = "rules.tmpl"

Which variables are you actually replacing?

>> +
>> +do_prepare_build() {
>> +    deb_debianize
>> +
>> +    mkdir -p ${S}/edk2
>> +    cp -a ${WORKDIR}/edk2-edk2-stable${PV}/* "${S}/edk2/"
>> +    cp -a ${WORKDIR}/brotli-${SRC_REV_brotli}/* "${S}/edk2/BaseTools/Source/C/BrotliCompress/brotli"
>> +    cp -a ${WORKDIR}/brotli-${SRC_REV_brotli}/* "${S}/edk2/MdeModulePkg/Library/BrotliCustomDecompressLib/brotli"
>> +    cp -a ${WORKDIR}/openssl-${SRC_REV_openssl}/* "${S}/edk2/CryptoPkg/Library/OpensslLib/openssl"
>> +
>> +    rm -f ${S}/debian/edk2.install
>> +    for binary in ${EDK2_BINARIES}; do
>> +        echo "$binary /usr/lib/edk2/" >> \
>> +            ${S}/debian/edk2-platformstandalonemmrpmb.install
>> +    done
>> +}
>> diff --git a/recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb
>> new file mode 100644
>> index 0000000..84761c9
>> --- /dev/null
>> +++ b/recipes-bsp/edk2/edk2-platformstandalonemmrpmb_202205.bb
> 
> 2022.05 is a bit older version, the latest ones are 2022.08 and even
> 2022.11.
> 
> Not sure if any security updates between these versions, but I would
> blindly use the newer version.

Ack.

> 
> - Baocheng
> 
>> @@ -0,0 +1,12 @@
>> +#
>> +# CIP Core, generic profile
>> +#
>> +# Copyright (c) Siemens AG, 2022
>> +#
>> +# Authors:
>> +#  Sven Schultschik <sven.schultschik@siemens.com>
>> +#
>> +# SPDX-License-Identifier: MIT
>> +#
>> +
>> +require edk2-platformstandalonemmrpmb.inc
> 
> Sorry, after some rethinking, I find maybe it's not a good idea to have
> the multiple version supportive for EDK2, since:
> 
> 1. EDK2 has too many sub-components, if multi version need be supported,
> somebody must have to maintain a list of these sub-components for each
> version, which could be a not easy job. Also, it's hard to notice if the
> wrong versions of some sub-components are selected. So it would increase
> the chance of making mistake.
> 
> 2. Unlike kernel, there should be no real requirement of using different
> version of EDK2 stmm for different products/projects, from security
> point of view, the latest security version should always be used.
> 
> 3. Best practice, per my understanding, is we have an unified EDK2-stmm
> version in cip-core and downstreams just use it. if new version is
> required, then upsteam it into cip-core.
> 
> - Baocheng
> 
>> diff --git a/recipes-bsp/edk2/files/rules.tmpl b/recipes-bsp/edk2/files/rules.tmpl
>> new file mode 100755
>> index 0000000..388e49a
>> --- /dev/null
>> +++ b/recipes-bsp/edk2/files/rules.tmpl
>> @@ -0,0 +1,61 @@
>> +#!/usr/bin/make -f
>> +#
>> +# Copyright (c) Siemens AG, 2022
>> +#
>> +# SPDX-License-Identifier: MIT
>> +
>> +ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
>> +export CROSS_COMPILE=$(DEB_HOST_GNU_TYPE)-
>> +endif
>> +
>> +export WORKSPACE=$(shell pwd)
>> +export PACKAGES_PATH=$(WORKSPACE)/edk2:$(WORKSPACE)/edk2-platforms
>> +export ACTIVE_PLATFORM="Platform/StandaloneMm/PlatformStandaloneMmPkg/PlatformStandaloneMmRpmb.dsc"
>> +
>> +# https://github.com/tianocore/edk2-platforms/blob/master/Readme.md#if-cross-compiling
>> +ifeq (arm64,$(DEB_TARGET_ARCH))
>> +export TARGET_ARCH = 'AARCH64'
>> +else ifeq ((armhf,$(DEB_TARGET_ARCH))
>> +export TARGET_ARCH = 'ARM'
>> +else ifeq ((amd64,$(DEB_TARGET_ARCH))
>> +export TARGET_ARCH = 'X64'
>> +else ifeq ((i386,$(DEB_TARGET_ARCH))
>> +export TARGET_ARCH = 'IA32'
>> +else
>> +$(error DEB_TARGET_ARCH $(DEB_TARGET_ARCH) unsupported)
>> +endif

Maybe a blank line here to make things more readable.

>> +# When cross-compiling, or building with a different version of the compiler than
>> +# the default `gcc`, we additionally need to inform the
>> +# build command which toolchain to use. We do this by setting the environment
>> +# variable `{TOOL_CHAIN_TAG}_{TARGET_ARCH}_PREFIX` - in the case above,
>> +# **GCC5_AARCH64_PREFIX**.
>> +# export GCC5_AARCH64_PREFIX=aarch64-linux-gnu-
>> +# using export here at TOP Level does not work, because
>> +# GCC5_$(TARGET_ARCH)_PREFIX gets deleted again for what reason ever
>> +# Therefore it is set right before the build command
>> +# export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)-

Context? This refers to something done much more below.

>> +
>> +

One blank line too much.

>> +export SHELL=/bin/bash

Needed?

>> +
>> +# ENV Vars which should get set by edksetup.sh
>> +export PYTHON_COMMAND=python3
>> +export PYTHONHASHSEED=1
>> +export CONF_PATH=$(WORKSPACE)/edk2/Conf
>> +export EDK_TOOLS_PATH=$(WORKSPACE)/edk2/BaseTools
>> +export PATH=$(WORKSPACE)/edk2/BaseTools/Bin/Linux-$(TARGET_ARCH):$(WORKSPACE)/edk2/BaseTools/BinWrappers/PosixLike::/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
>> +
>> +override_dh_auto_build:
>> +source edk2/edksetup.sh --reconfig
>> +
>> +CFLAGS= LDFLAGS=  make -C edk2/BaseTools
>> +
>> +(export GCC5_$(TARGET_ARCH)_PREFIX=$(DEB_HOST_GNU_TYPE)- && \
>> +build -p $(ACTIVE_PLATFORM) -b RELEASE -a $(TARGET_ARCH) -t GCC5 -n $(shell nproc))
>> +
>> +override_dh_auto_install:
>> +
>> +override_dh_auto_test:
>> +
>> +%:
>> +dh $@ --no-parallel

I've discussed with Baocheng to pull this in earlier. Unfortunately, the
situation for QEMU is still ugly, and I do not like that U-Boot hack
which does not allow us to truly explore EFI vars in RPMB (even more if
kernel patches will show up soon that allow using those via the normal
kernel APIs).

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


