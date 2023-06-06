Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF130C7EE24
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 07:58:09 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.78])
 by mx.groups.io with SMTP id smtpd.web11.3594.1686038281362846700
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 00:58:01 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Xfyao7Cs;
 spf=pass (domain: siemens.com, ip: 40.107.7.78, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfEeqMm1bUlqzjcvq+szEB+X/yJjuQMac7cOCak3ys4/im87II5088WYbURdkyMzZ1LwAiGy6jSBgJuPq/lvwJWuEmI8RgnqGJJyCle3sZWTRzkS59o9Smcs86r3JxBgT4PCTE0bTalMJFUVdw6G+tiPauiclZByqK6inZcIffEsl60mihOR1Qg+eEyYSibn2hYQTagc66iWm/19mx5ZdD9AXWhw7wYivL9AVFzceb810Yz0OBilfUQ6Xv1ZXr0HMEbUDiw2F7ahGu4SmvzFDAkWo7bPK+n1GwnCb7xcc4XXevcKI4vuB9s0x+PELL2dXd9KJV9tfzGQmfFp4eVrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD8+znExKZmxkn6rGv248COaHjIUcl0iPIxvbBnAo10=;
 b=XNZyk0m5B/FeAA7B+cXApMqsIYUfQ/Sl+tUEK/NxP8hhEvD++DHI3GzUOSnVH8i4CTTlP+EbGHzfKvAAWp6JCT0kAPb4Sb8x6tPuVnl/zD02qlZJT92kQ0S1YZMUQMiayoafXK/pcsHcnkfVCoOL7wwZlSnl6sp55GMvzo/ww78nIuBlF+IcsOSAAPAODocHzjao3JHlJrwzaJhOHRHvDdS01BcqcLuo1SmgwZaxEAUseYDMF9eW8AAQ3kr8KjG9fn7zP5jwKbJ9ywR4F4X2zAjwQZ4n4RVFfdJM45vp0vj4zXu8UDMISlbY+MzXUqHhHqFTeX68WAPCmHrhIgdE0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD8+znExKZmxkn6rGv248COaHjIUcl0iPIxvbBnAo10=;
 b=Xfyao7Csc0nxLO9ofL9f0twhNwqwfojuew1eOR6Qwt5GseD8BCHQ/BDTpGIyLH3+VbswkoZNLtxa7vBLmpDGdxGircPk4PKYFCEna4KgPpWolpZE5opQD8VI/q/bTKJo9/eBj7mnFmiKac/3EcIvj7tMpvoKkQvqsy2cTOi2+8O9ij0q0CIu3fN1NCUXXDEDBqQ71++VXs72oO6bwL0sRPz9+1mlDQ3Ew7zpObO/2GI7FQ6yxf9wGIPyokUaGV7uh7LIvDAJX/9kfmxf/Lw69vGfxB43mTC0i8tEBhp2Gu8Ji+aqJL3FvC6x2wVH8q8qHDnjJb6ZrQX1Mi+E2k7O7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GVXPR10MB8198.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:113::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 07:57:57 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2ecd:9a8a:5601:47e4%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 07:57:57 +0000
Message-ID: <b7d6f5e4-7da1-bc89-4500-e51ead5f3b3a@siemens.com>
Date: Tue, 6 Jun 2023 09:57:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [isar-cip-core][PATCH] IMAGE_TYPEDEP:swu: Don't depend on wic
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>,
 Uladzimir Bely <ubely@ilbers.de>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Gylstorff, Quirin" <quirin.gylstorff@siemens.com>
References: <20230516085018.26436-1-ubely@ilbers.de>
 <cb62ac04-f64e-192e-7d00-e411f4422cea@siemens.com>
 <0fc8aa184fe24a549be85f87a69a0edb@siemens.com>
 <86438485-f93d-5457-cfd2-7021a0b2916d@siemens.com>
In-Reply-To: <86438485-f93d-5457-cfd2-7021a0b2916d@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:610:4e::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GVXPR10MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: f1a26977-d654-4bab-b100-08db6663bdab
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CCpmLOhTC3DytutXSooq6hOxcNs1AdKq/7obHIZHC2TKPZlLXLgUfJgNTaTmqCOcCycC7S2DH1k9PcoPxK3X8wqQf5W2/59Y9V88iv8/bbVliMt5HSNGaXAQ7erIi30G1oQqccV+x9RnR46ukTTRK2/kbLfqsOcdpEAjSs76gL5yaoVfOe/WZL/aMczYZm/bkaDpYoCQzHIp9q35X6QADO2fn1CPb3xhH3XKomvsSo34g//9Cxx9Sl5HezZGSEtopEa98Uly+wTSYQ6j+fsS76Utw0AbT20Wlqj2/lE9TYXrg6aObpcEAK5MS9NpgBsbd7KlA1OUKJILkk2xIwPfMcienVxdvXeWFWaOym8oWIrd5ORAkUOMBcurwPgZ8RziXKNBx3aLXd7e1e1iFqLftLmqnTgcUloT0J5giFXNJ1AZVkU4lael+oacwgnx0BbB589fAzlDQy7uBgpY84k2Nv+ZBpgWzoZe63cUREZde9UzsgySwUx8Y206Gzvma3zmbf0OtbBmAhX/pYCSxTjmsnA4prdRPc7sIPeFMGZKJAPeZ5KUVs/P4C6hjgz3KrR4QPIWnnAKf4hezmLDX3p8yy70KkElGR6HQTIl5Pw2J5Gpb/KA9BD3miW3YOwfDKbWiC0UyYybuIX0Rl8McQazOA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(451199021)(83380400001)(2906002)(2616005)(36756003)(86362001)(31696002)(38100700002)(82960400001)(966005)(6486002)(316002)(41300700001)(6666004)(5660300002)(8676002)(8936002)(110136005)(478600001)(66556008)(66946007)(66476007)(31686004)(6636002)(6506007)(6512007)(53546011)(26005)(186003)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?MHN4ZUM1YkxCbjd2VlBiTUNRMzVaTGM2K1psOHZDQzM4WXJRN1Qzcy9Id1pr?=
 =?utf-8?B?Z2ZvenQ3YVFMcWNMcG1jVG5sR2hPS1QxZjc2VmZIbE9LNlo4Yy9RanJ5MWhG?=
 =?utf-8?B?MHhoN2k3L2h0alpYaDA3cWxJOXY0UXFhbDFMMG9GRGdRVGkzcGtPSm9zZW5H?=
 =?utf-8?B?M25OMmRjcHFNd05Dd0x1QnJLU01mVkZxZ2ErMng4eHc0QTNWbWFuY0d5aHc2?=
 =?utf-8?B?eE9EcDFDWGtoTUdmMTMwM1RJdE9xQTcxL1NrcEZnR09iL3JSUHhDTUg4UmFm?=
 =?utf-8?B?WEJocUxTTzhKcmZMckp6cWZMaUZUNEduQW12ejVTM0xYRVQwQ0s4MXoyUE0r?=
 =?utf-8?B?UEMxWGs1eWZRWkhaQVY0dkI5SWNnNlZNUEczR0JRZWpOa1M0U2gzTmUyNm5o?=
 =?utf-8?B?c2dhUk5KdHE4YWtkY2lnN016Njk4Tk9KOHdSS2RGVVRyZHhpcEVucnhGWXdp?=
 =?utf-8?B?aFVOU3V1NWpvR3NVVVF1WjY2TEpGcklxL2RESnh5bVo0dnlZaGhtMTNRWXd2?=
 =?utf-8?B?TVJFUW03QXE5NkszL0M4WitqdzZOZjNlczEwdGxGemRwOG9hY0hkcFZBQ3VR?=
 =?utf-8?B?clZjTERIcWQ1Q3pxUWhSTDVEL083R0NrRm03U3h5Sy9LSWlFbUI5WVZiamc4?=
 =?utf-8?B?Z0NHTEhsWFB1Q2M4OUovbkFqekhMcktKcE1Zb0JmRm84OHV6Q1dtT1F3b1pu?=
 =?utf-8?B?VFN6aXdSVHh4MDlxM3pZUkpKdEx1RTNySGNXL0hKK1JFNnNyRjA4OFpkTVF6?=
 =?utf-8?B?a21ma0ZzVEV0d3RObkhoTWUyY29SL3ZsMVdZYURWYXVVOVJ1YS96MWtIWXoz?=
 =?utf-8?B?RVl0dU9YMFJnOXBhaS9IeUVXOTYzVFhpRmp3NmVnVGUxaDhpSXVub2IwZVds?=
 =?utf-8?B?bXBBOUk4OGFRd0VVK0NOZ3F4Q0tOZFp1VDkvQVo0MTFGQWYrbC95cmg3Q3or?=
 =?utf-8?B?ODZMaU0xSExyenk0bVlPVTRXQjhjNnNXK0tjcnRNbjU5SGpxek5CQW0zZEJ4?=
 =?utf-8?B?Z3VITHVmb29NTHQrTXpIODI5RGszdE5RRFBaU0huL0ZkR3pBKzQ4Yk5ETG1k?=
 =?utf-8?B?RDUwQ215QUdFM1c5TDBYWGlLWkpnZlB3Nk9lQ3VjUDdKT09MR0tCYUhBeUN6?=
 =?utf-8?B?MTlHQUZkR3R3Y0VMY1VLR2RKWU5pUTRUVTdOZ2N2QmE0Z28zQ3V6ZENENTBM?=
 =?utf-8?B?QU14NHc3RHBVdGZNNnFqTlRLVmlOMEJocGw3ZkphOFR4ZXpFaCttVEZxVnk1?=
 =?utf-8?B?VEUxQ2p3RkN2N0FjY1JyMmZUZFBCV0NZZEg4eTZEZlQvTlZ0ZityTUZHRmJh?=
 =?utf-8?B?SHdmbTJ1MnlTSkpRZTFRYzNodUg3WDQxOWxnWUlOR0hDbkIzQklWWUhYQ2pG?=
 =?utf-8?B?anhSc3NOY3NiQTMraHg2M3o2M0x0d1JBNlFRM0ZxQlg3ZUhjTWlpRUZ0ay9H?=
 =?utf-8?B?ZVFBT2xpUCtKdzdGaDBJazRnOFIwZmE2eWljbHEvRlhnU0J1aElGT2xCNmRS?=
 =?utf-8?B?SkJZakRYZnRHazFuVEZGSTR2SmQrLzQ3SXcycUd0YnI5RWtSNjd5bkhCMDdX?=
 =?utf-8?B?dW8vUzVQU3haMStiVXZxQmRUbmxBSUFjK2RTQ3JHK3dNK1hLUkppL3d3cnJ0?=
 =?utf-8?B?TlZvYmo3Y3JOQWdLLzFCMDhjMVphcm1WcjlXTnhTZFNUTW4rLzBFMGJMaWY3?=
 =?utf-8?B?UmNaYTFNcGR4a2RDczlueFJPTmMvSHk1VHdZK0lWUnN3RXNXT1BqUEVqZmZG?=
 =?utf-8?B?dkg2QldSaGN0K3p4Y296d0FyZzVJUFpOaWNGdmhLQThzM1FPS2pFblY0V01F?=
 =?utf-8?B?bTJhZkx1VE1sNG95UFFrOXZmSlZYTGEzaVVaZ1lDUW5YdGx0c21ENzgxaFZ0?=
 =?utf-8?B?aVBtVlRJenNBZnI5VEFkOCtmL0lzTGZBaTVUd0lnOFdNaVQwbnJkY0dQWDhz?=
 =?utf-8?B?M0JZN04ydjlKaC9XVmQ1UkwwZnd4Z29xa3lwUThUS0Fzcm5ZYjFUNWFPaElv?=
 =?utf-8?B?ekVNaTZ3Q2paK3RWUURCU1N1MCtrWVp5dmc1MUljengwRzNWMzhDdFdzYkZU?=
 =?utf-8?B?Z3Eza05CMjJaNWdDNVJidFBzSUtqZ0cvNXlvWlFkUE9jKzd0UW13M2pUVGlr?=
 =?utf-8?B?c0Q4NDNSSnV0aXVSWHFxNWozYjhGYjBSbVh0U2NjUnFYWEJRTGVGSXJjWmh5?=
 =?utf-8?B?QkE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1a26977-d654-4bab-b100-08db6663bdab
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 07:57:57.5572
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+badM2VJidf061zGtIoAxT1tyk51f43Tru8eEAdyTZ1Uzdo8OAYdvxRflXc9JoCE5grjTPC0n5kXv7hvjpiCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8198
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 07:58:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11850

On 06.06.23 09:09, Jan Kiszka wrote:
> On 05.06.23 09:13, MOESSBAUER, Felix wrote:
>>> On 16.05.23 10:50, Uladzimir Bely wrote:
>>>> Settings IMAGE_FSTYPE to something like "ext4 swu" or "wic.xz swu"
>>>> causes uncompressed '.wic' image left non-removed after the build 
>>>> finished. This is caused by indirect dependency on "wic" in swupdate 
>>>> bbclass that can't be overriden by the user in local.conf.
>>>>
>>>> This patch removes this depencency. If the user want to use some wic 
>>>> partitions to be packed into .swu bundle, they could simply add 
>>>> directly add "wic" or "wic.xz" to IMAGE_FSTYPE.
>>>>
>>>> Signed-off-by: Uladzimir Bely <ubely@ilbers.de>
>>>> ---
>>>>  classes/swupdate.bbclass | 2 +-
>>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass index 
>>>> 9a4d509..6f034c1 100644
>>>> --- a/classes/swupdate.bbclass
>>>> +++ b/classes/swupdate.bbclass
>>>> @@ -31,7 +31,7 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>>>>  
>>>>  SWU_BUILDCHROOT_IMAGE_FILE ?= "${PP_DEPLOY}/${@os.path.basename(d.getVar('SWU_IMAGE_FILE'))}"
>>>>  
>>>> -IMAGE_TYPEDEP:swu = "wic ${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>>> +IMAGE_TYPEDEP:swu = "${SWU_ROOTFS_TYPE}${@get_swu_compression_type(d)}"
>>>>  IMAGER_INSTALL:swu += "cpio ${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>>  
>>>>  IMAGE_SRC_URI:swu = "file://${SWU_DESCRIPTION_FILE}.tmpl"
>>>
>>> Oops, this almost fell through the cracks.
>>>
>>> I'm indeed not seeing anything in this class referencing wic, so this removal seems logical to me. I'm just concerned if we have downstream users relying on >it and then seeing a hard to understand error. Any thoughts?
>>
>> Downstream layers need to adapt to the new interface anyways (if they don't use the plain version provided by CIP).
>> The .wic is not needed and should be removed.
>>
>> Acked!
>>
> 
> Thanks, applied now.
> 

...and dropped again. Seems this requires rebasing or some other tuning,
see e.g.
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/4418633832

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


