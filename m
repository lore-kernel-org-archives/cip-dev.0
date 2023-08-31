Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9A1C83F10
	for <webhook@archiver.kernel.org>; Thu, 31 Aug 2023 12:35:36 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web11.15674.1693485331962822313
 for <cip-dev@lists.cip-project.org>;
 Thu, 31 Aug 2023 05:35:32 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=F7OxsSYq;
 spf=pass (domain: siemens.com, ip: 40.107.21.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKggoS0dhvzEhS7bhNG5+q6MgQMp8M4qdOy6B1qgMhWonh8SszA+Nu9MgfYo4prs9q5B8xtyYAorU6csxVu1J7N7qDDfbKhbJmFpaiIcnYUcP37sf7F0fC8zB/H0X4E2tl2aLT6zsGnQA6aDgdDjdF34nOeaXXIPUePcBdwwVyOIQa5FaDW9gIN1r+nJDp0d/O28jGL1PCqPov141fIfYmFH7vw3GzsXe2J+0vYToS7XobdtBfe85jk2xheVbAspMSfhs3eR1G+/aPvtiL0Mi5OaBPtsCmzzNg/VFgMwuADUVsK/QJ+kp7Lt/nNk6yxSPQJljwI1X+v71QFXqBHrcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cTVrXmp6750NzcPZLMmno1AHy23eHsEPEM0mVJu6OOs=;
 b=aG3h7XNul7QcBP0AnDrV1IP3aACWoDoCdM2RRrj5LZ4sMtULIeqTNad9oLxp8euAUHyoXXS5sYaGrvZlLy0WtGmBdVWMXAKByl+gNQSf9XtHXEO5okkjYdwaZtRBxEJ6UH+57aEI8+60N+UBIqAKObX0P72ktnQCxgGHpKlobaZmRX3aIIdfSkbyZxz1UTFgpM8u0iSEm32hRpIpQIFpg2TZt5V65ilthMFd4861kup85cxxSVYJHUxHj/5im6P1WgXHwvf46v0R5BZOOIR40e7zSd8xVjbVXSFQrh9on7pd8RHU7oBeoS1ZFbmxVZDr1ANLWpL2ocjPOiDwxBtsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cTVrXmp6750NzcPZLMmno1AHy23eHsEPEM0mVJu6OOs=;
 b=F7OxsSYq0xsqmRChZzr/yTWyI+IPi1tmIGlHFkbOwzeKrudywe6JhwMXnhiPZipmsSXcprmXp/ToMTnHYZnlr7wOZOFN/HFsFuxR5cj5Clb70ZUQccrPaVgDKVVZURx6p8rL3nX3gN3p8SS2t7fzq5si/SLrN7Bil1r88E7bt5a+mpAdnvikBqzRz9RnZqt4upr+gHqhLx9xDaY8nWIj5ESQ/PMhmbjM8Pa9GuptnHazQT09MwwV9cHt/fV3OILSfd9V9GUAwfy6HzmvhMnY8NO6+LepbIBNuoaOA+1k/MSdnGqD5fLkuwj3n+3W9ZCTj/QznuSYoAVHQwkj3uBjog==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:395::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Thu, 31 Aug
 2023 12:35:28 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6699.035; Thu, 31 Aug 2023
 12:35:28 +0000
Message-ID: <2f3ce816-38e2-4a51-9126-5b25e416b1af@siemens.com>
Date: Thu, 31 Aug 2023 14:35:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: RE: [cip-dev] Problems with git.kernel.org snapshots in CI
Content-Language: en-US
To: Chris Paterson <Chris.Paterson2@renesas.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <1086cb49-013a-4776-89d1-11d372826eeb@siemens.com>
 <695be8e9-14a7-46a0-afc9-00aeb182d4cd@siemens.com>
 <b5def4f8-61fd-4238-892a-5cfae8bf9960@siemens.com>
 <TY2PR01MB3788787FC3B28A9D806A142FB7E5A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <TY2PR01MB3788787FC3B28A9D806A142FB7E5A@TY2PR01MB3788.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0179.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: aed6cda9-f30a-4e00-1f55-08dbaa1ec1b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	z3zvquRcRL+uMJKlgXisYVW3QbjRe+fHxA78ni2GF5UZLtPN6+30Lc/BB7v0vghsaA4tP1+KCNvHAyGcBAHcWCHthU2RW+Q5HH0yy6OZRPoo9qJocXcj042IjV7zVPG4v579OqMeapmM1jsEvmIgBmjGtlrZU29c77+P5jjQAnd2prJnV9wrcCfNhI2RQ1gn9JfC21xjYOH3Zy9xijKjQSnGbygvyxl271Z5UY5yYQherJBdFLkTk8KW/ZVfIUPDTNRCmbmAlZUZukKlpB6KG0MwYCNIwe60I57RWpHjNzsE75twbp83vjHMVIUH8bzr4TwrG90k2vga3U/L94GRXauJ7+LLXoYbNWWWjP++7jHrbhKneippkJEy5DM5Z73fIBjJs3RSdMmhHyLwh+03QIJjv8sx+MvpoHlu8s1DrZZ87uV40gmDGHjEzpf0MWweJlyjIwQFpA4m7GorsfoCCH3pMHoPF3pW41bKj2bTTnQTAalYKQmPKz9I8tollPJoUg+L6C/IQxMdRA7I+xuiWYUZYha270et8yNmyldgmI8gJzRdKvdDsyzs5FwS16V4BNOpPiRs3yUiK4oaoYgRNI4DkuXBShS1apUjPwlS9gFNGNeSw4BCv6RbV7MlV4s2hJSLgki/7U97St7sJetvNw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(83380400001)(966005)(66946007)(316002)(82960400001)(66476007)(38100700002)(478600001)(66556008)(110136005)(2906002)(6506007)(31696002)(5660300002)(8676002)(8936002)(53546011)(86362001)(44832011)(6512007)(26005)(6486002)(2616005)(41300700001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OVY4d09WOWdOZWtabmlqV1ExWml4T1NBUTNNNGVTRXNpbitTNllja3FoVWtq?=
 =?utf-8?B?WHIzNHVJYW8yZiswK3JPc1lWWmRPMFVObFlsWmgrcjZOZ1k2bUJYeDBubGcv?=
 =?utf-8?B?T2tBVmhYdktGZXZScXowbG1CSm53WkEyVEpzUzV1MHRaUmpvRXcwNDFVbVV2?=
 =?utf-8?B?TzZocDQ3bjVpZ1BIc1VPelVoSG9oYUVXWDFGYUhBQi9CWWFxakRBaHVaaXRu?=
 =?utf-8?B?ZjIzVGQxbVFBSXhoQmdRYmtoK013L2xEWGF0c2ZtN0gzMFVWTXdZNFpWYVh3?=
 =?utf-8?B?N2xGVTVDT003WXRHSHFnOGRibzd3TGR6Z2hKdW1yNU0yS0lOVWo4czkvSVdl?=
 =?utf-8?B?R0NvZXdzZ1BwOXI3cWw5VlgwOWZqbllhczdSWkFZaVhKWDlKTTNVM2xuL1pY?=
 =?utf-8?B?YXFOQzR3QmJ6c0dtTm15a0pmaW52VUZsQmR4UGZRZlJDNjF3VVJla1RHWEJq?=
 =?utf-8?B?WXdGUEdyaWllY2JKU2I4Q1NGMFZHa25XemlHTFl3cGo2dVpIZi9LNHIzRjZj?=
 =?utf-8?B?QVFlUlpyYXZ2VFJETEJOOS9sNEtydFdBZlZFOEJBUWpZQnY0SzVNSVYzVitk?=
 =?utf-8?B?Y0xucS9iMWR1RFZBNTJ5UVprTXR3L3lLLzZ1YjdHMXJpanNCUFB2amZ6Wkty?=
 =?utf-8?B?KzJIRmVVQ3haVlh2elFNendUUXFLeC81T2hmSXM4UnV4UVpnMGdhRXFMWVRp?=
 =?utf-8?B?b280MnFQbGxpVFBSeVU3NDd4V1N5Z0Vkd3VaOUJPTjJqNTVEcFhGQ2IrS1V0?=
 =?utf-8?B?VWliMHdBK2dmZjg1TzcrbllWOHdVMjZzbFc1L0Znb01FcFpwdm02QTZUWmhs?=
 =?utf-8?B?NWp2OWhPc0RFbjlzVjMwVTRDNnllYlg3aC8rako3cjZXRFpvQWtGaXI5L0dh?=
 =?utf-8?B?d09UU0REK0lHZFFBTHlmYUxmdkJJS0EvZGppSlhwZExtR0J2ZVlMdkNQZmYy?=
 =?utf-8?B?T2x2NFZ6UVBJNU5vY3BYOWU5Vm5KV09XSDhwblJyckMvNDhadzhJSlVXUWNu?=
 =?utf-8?B?bkcxRDNPcXhqZTRsNkQvZnZYcE1BNzBYekNIYmN2Rk5pUksxaXpVaEQrNXVD?=
 =?utf-8?B?NHIwaUx3UmlWTkhtcnUvZUVVMWpJMXM1OTdLUUVIRTF4YjlLS09lUEVlUjA4?=
 =?utf-8?B?Rm9FdndMc0dkWGdyTjBONGtHWUNYbmNPRERmbjhQaHRLTEVKckkyY3RqckZs?=
 =?utf-8?B?eVRFTVpmaCtJN00rQTBYT215MllkUUlHNzZEcGRXYTFyRUV6NFJEUzBCVWpR?=
 =?utf-8?B?ODVBMG16emdLTUQ2aEhKNHhja00zemFKUC9TNmRMUUorNXRvcW1nWEczYkc2?=
 =?utf-8?B?UEw1akNiL0E2SmxVdFpyc1JXVi9OcGtocUwyYzNhM0lGcmlwcEhLRVI1RFdU?=
 =?utf-8?B?dk45d1kzQlZFRGM0NzdMZm96T1BNVGZ6QUZ3eXVjZUIvMzdHTTBYWks1dmFD?=
 =?utf-8?B?NlVoSXZaUHprdXU0MW5BODFGL2FwOStMNXNyK0ltaTNVdTVtWmovS2k3WGgr?=
 =?utf-8?B?Sm9ob0xDUnlvSStENktNcmw2WkZCMWtNWEVBSXlVS2JDRHFPLzk0RHI1REFR?=
 =?utf-8?B?YStlNGZLRHpTT293c0IwSyszKzNtSEVWS084U3E4T1ZnTTFUdmo4R0hpTHQv?=
 =?utf-8?B?eEZyMXdlZ3d0eVRCMGI2QlM3alBOSzB3UE9EcnpqZ3M4WFZ5blE3Qi84a0F4?=
 =?utf-8?B?Vk9LUnZoSHI1S0dHRzNSd2kwUDVkQjJJRkNQK2Q2TUkzOHd2VWlLRGM3OTlo?=
 =?utf-8?B?RjN4MmNuamU1ZjBFWFNnY3NyMmhXREt6RWNlL1hnVzNoaWkrOFp5aEprenJF?=
 =?utf-8?B?RE9nOU5KZFpDZnR5N21jRUQ4bmN4TW1jcHBPTHZuQnh5eDdJTmVmZ05JaG5O?=
 =?utf-8?B?aXdUUHcrYUVkOHVOOHRGa0x5c3FsQWFaYkVTaUVjR3FYa2dFV25zWVVibWJn?=
 =?utf-8?B?WlRVNE1pcEs5TnNZTlEzenZWOUtPejZ0WUhxRTZCcFovNmlMMERLb0thaGxi?=
 =?utf-8?B?Z2w3b2VKYXhwYk9KT3ZrUFJBSHZ2akl2SmxkT2hHNVI3VkxHTStIeElJWFhX?=
 =?utf-8?B?aFRKeG9BeWI3MExCK1ZZZmV2d3hNWmkzTTJCa2UzblR4cURrUnhCd3RxTlVG?=
 =?utf-8?B?UlgwaEFnL2dxQWhEV1AxYlFEWTY0eG5rYWNSQWdMWHhVV3owbStOSVJodDVN?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aed6cda9-f30a-4e00-1f55-08dbaa1ec1b9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 12:35:28.2629
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZGGAC3X2/9kecaYpJJTIgGDr++WH35SSwj7e4KN1aMr/eUAjPLWlLQ6OqxF86/2fp/ur0dbWZf1KKferEeiHug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5881
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 31 Aug 2023 12:35:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12930

On 31.08.23 13:37, Chris Paterson wrote:
> Hello Jan,
> 
>> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
>> Behalf Of Jan Kiszka via lists.cip-project.org
>> Sent: Wednesday, August 30, 2023 4:08 PM
>>
>> On 19.08.23 13:49, Jan Kiszka wrote:
>>> On 16.08.23 09:54, Jan Kiszka wrote:
>>>> Hi all,
>>>>
>>>> isar-cip-core jobs are frequently failing due to fetching issues of
>>>> archive snapshots from git.kernel.org, see e.g.
>>>>
>>>>
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4881160724 
>>>>
>>>> Retrying those generally resolves this again.
>>>>
>>>> I think we tried gitlab as mirror in the past, but that also failed
>>>> under CI load. Do we have any other alternatives? Would it make sense to
>>>> make the tarballs as regular downloads somewhere available?
>>>
>>> What would surely help is having a download area - maybe on kernel.org?
>>> - for ready-to-fetch tarballs of our kernel releases. Would that be of
>>> any value beyond our own CI? I suspect uncached downstream CI would
>> also
>>> benefit.
>>>
>>> Download caching would obviously be another option.
>>>
>>> Thoughts? Other ideas?
>>>
>>
>> Ping on this after we had a discussion in the TSC call yesterday. It's
>> breaking way too often now.
>>
>> Options we may have:
>>
>> - ask for download area on kernel.org
> Do we know that this would be more reliable?

I'm using regular downloads of kernel trees in other projects, and they
did not show any issue so far.

> 
>> - host our own downloads on s3
> Certainly an option. Is it only the kernel sources you are having issues with?

Yes, that's the only thing we pull from git.kernel.org so far.

> 
>> - try out a git mirror (and its snapshot support) under https://github.com/cip-project
> We can try, but would this be more reliable than doing just downloading the tarballs from our GitLab project?
> 

We use it for Xenomai kernels in xenomai-image because source.denx.de's
gitlab (or gitlab in general?) did not perform well enough.

>> - use download caches in CI (and suggest downstream to do so as well)
> We could save the whole Yocto downloads directory with Gitlab CI caching if you like.
> Or just the kernel tarball. It "should" work fairly smoothly.
> 
> Something like this:
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/c62fced2cd86757aa0eebc14eedf04c203f34cde

As discussed on irc: Yes, in principle, but this will either pile up
linux tarballs of all our versions we released, thus will need
maintenance runs to clean that from time to time, or will not work at
all yet. In addition, the first run for a new kernel will still cause
troubles. And possibly also the first run after cache maintenance.

Jan

-- 
Siemens AG, Technology
Linux Expert Center


