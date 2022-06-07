Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8126C43334
	for <webhook@archiver.kernel.org>; Tue,  7 Jun 2022 08:39:49 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.80])
 by mx.groups.io with SMTP id smtpd.web12.9829.1654591181815520810
 for <cip-dev@lists.cip-project.org>;
 Tue, 07 Jun 2022 01:39:42 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=D0H6kQpm;
 spf=pass (domain: siemens.com, ip: 40.107.21.80,
 mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cy1Ap2wftVpEPXINgHepU2ajQUM+p+UiqIN6d+En4BMzf5a5mOCkcGEUkUWUfPDqyu0XKSM1JvcFW8fqHfAAEJxi1GFwFKn5O3kt4y3fPudEvlSEzS0S6GCYmaKrQwkNBaDLi4RpTEOBhklEFcHPcpCUBHPKQ/RQBthxIBDJzqdoOxdSV0oXEdo/oAutQ5LEnnPKuHuYUljvTv5RO7uv1ZrCm/g7tDHqn9Od8PYsCSCZKu4CTSb9xUeAvCOdPDo2KK0oKxETibYr8SSs3D+ZVAXACt6DfdLfHyy/d3NavdM5qPIpg35o2cshcSrPUax9Keu1Hc+ZwKtoCnRtc9iVIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLp4AyfKFtG/ABy9ytN3GQtr14HHUoh46BPBxJ5QUlE=;
 b=Lm8EdPVwj7CBFSaaQ4bFjY5rcPtkpgchJ29Cs6JyhDhwFA3DHvqS5fGt7/hKNlh4hm8bW/bKix4v4Mn6odNGKku++66dNNRGYH/xtb3NtbDMO6uNE5pCkRfN2ndklTR3+pS+8yP2rEByVkY3qbhTOQMq1d6k5TNy91MZkt36lab30JyuTxdynTC1pGD7WQuvsxyA2KBVuZh8GsIqKU5/Rt3NvC9REvhvzrwltRs5QO9ILD//aUedkwTfk9YnNu4p/HCtYissMuXxdLLfn1hhFiNjzu62reTIloU8/T7S6ujfTQg6LSHrqThLqAqw4e1sPbeeUqTdZJzdmk0LFU8dVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZLp4AyfKFtG/ABy9ytN3GQtr14HHUoh46BPBxJ5QUlE=;
 b=D0H6kQpmZvqfM63m2y2ZrHXagFHvRq5Ay4P9GQTe/jE/QJ6/IcMmW+VRnG4nbxmA7j4cQuzNC6Q2EhJ52PxkEs3EcQ083vDX9Ox9oGKIP80TcUm4pfU8RWGeYBALvfPRHCdq2aumHoJ1xr/iVHHskkEMSp07vl6s7tQOqtZXZV9swELZeauhzbRZuuxQyxMmdO9GiHaAwHoRAEb7dCYkoQyh6fbvtmh2bAXAtKGykPLwUbgWKGqbczT+3kw3s/9hx1XIZgbfHSiFzvYMiI9EJ74xENw3av8jJJwEKcJJegyob6EvzXUvINAJzFYDTbeM1BpYbqyabGN36Ly3KTyzRg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAXPR10MB5070.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:215::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 08:39:38 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::209c:88cc:b026:ed1e%2]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 08:39:38 +0000
Message-ID: <0ce31f54-99fe-8454-b610-ce365241f473@siemens.com>
Date: Tue, 7 Jun 2022 10:39:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org,
 adriaan.schmidt@siemens.com
References: <20220603115618.985568-1-Quirin.Gylstorff@siemens.com>
 <20220603115618.985568-4-Quirin.Gylstorff@siemens.com>
 <d8f7538e-e02e-3801-261c-ba8708128d52@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Organization: Siemens
Subject: Re: [cip-dev][isar-cip-core][RFC 3/4] Adapt swupdate and verity to
 use new IMAGE_CMD_*
In-Reply-To: <d8f7538e-e02e-3801-261c-ba8708128d52@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:83::28) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62f21ba8-1406-4d72-3ebf-08da486141af
X-MS-TrafficTypeDiagnostic: PAXPR10MB5070:EE_
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB507034482DB9BA76E3C8159B81A59@PAXPR10MB5070.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	t6Kh2bUQ9siwj8O5tCF+q/jeKZxk+BBupN1FcZi3YoQvyE8JUbAvNQiJf2tsl8wv5HHNNJMNa7q2UUdYZ1J9uYWoKeMyJMlb4p2JbBSwToajcx5F/3ZFYQjsW95HmLIE4kYttWKRnm3dkl+Dj7jHGtSu9NUuIhFnyTeLC/YnhbhYA0QfRVNtHmc2L3FY2IHjVcGwG4WvMU7OGWP80N7wg6aw9MPFk5zzBxIbMS1mMqXf0UfxOMrZhvdMTUaZKVUr1yxh1E/qVYuPa3wmoNbEGBX1X17tuRBOVyE9cJLqd3D8+r7fzfJlePshZdBmd2KVHJvKLkJCdZYwyfWunSxTZCgHfXqMmA/RYIlstbcpq8x8evj2cKDoa7XPV4UWfq78gGWizUhb2KbxOnM7HkLzpC9zSx1AvSQE5O9E3wUxiSet9rs3e+TzOImbKR9BB2TpPT8USo8t7EKqXyYyZVHWEa3ZMV0n/ysZ7qBUkRybBbQleKp//XLUjbVSIZWRtP20W27+xmhGN+iSTYEAjNcjphxU9wnFQY0PxJGnQRP8PGDRdtNDeyc1Pj8GE3IzwfDPbI+9Q/03exdoK/vSqbFckiK8qR4TNwDr/YYZsbAGlg9HW1TLXbpFBsJ8P06Tq7PL/JHZiGP9MaQF3ZcHlmbvxh9mIXbn7fb1KLI/oRLvcOiUOjUC0HFKPkNyMUlk9QjmOEf5uBBX7zZwFUcnR5R11BUS21UBIj3gS1E/qBMKp7Utu1we7NRPgzV+iarcxNIl
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66476007)(31696002)(66946007)(6506007)(53546011)(38100700002)(6486002)(6666004)(36916002)(86362001)(8676002)(508600001)(2616005)(8936002)(186003)(5660300002)(36756003)(2906002)(66556008)(83380400001)(82960400001)(31686004)(6636002)(6512007)(316002)(30864003)(403724002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VDhMdnRPcXJVdDE5UitQbDJzY1BONXZBZjI0bzkwUGtNVFdySU1wUkZtcEY3?=
 =?utf-8?B?L3BNYnhreWlLTmIzdEd3ODE4WDFFamxIQi81V2s2QUg0UFE4cGFRYXJsUWVX?=
 =?utf-8?B?VUhsNG5Ba0JmcUhqSnJOZzF1d0FKYmhKRmhtOGpnbUJZNEtpbmFodEJoNzRQ?=
 =?utf-8?B?Nm5PQnY5enlQTU5DNVJxNXBVUWY4Nm5USVhoWEM2Q2paNFZScVBOMkI5L0h6?=
 =?utf-8?B?ZzdhN3VJTHhndzhhYmFxM3BsNHlvdXI0bHZnVUtYWnRZUFV1Q3pPWTZLQTRk?=
 =?utf-8?B?Y2VXWTNtTm1xa2ZTZU92NjY5Rnl6MG9LMGJEQWxSR1FvZGFoZk9kVS9makJB?=
 =?utf-8?B?NHJLVG1hYjVVN3VTWDlyQ3NBK3A4R1grdVZzZmU3SUMxM3E2NTZLbFdMeTZy?=
 =?utf-8?B?NkQwbmZkS1FWT2VXOXl6SjZjc1FlTGwzS0U1dDJwdGJZMWl0a25nY29JSDJy?=
 =?utf-8?B?NDg3dVJOcWl2QkxZa2tKMmg1UUF0VlZHUTFkQURhRUFrRVMzL2d6SUZrMklz?=
 =?utf-8?B?NTFlc3VEZUM3Q3pKY2hLNVBUSmNSZTAzYlRHTy94N2ppNXdzaCtob1J0MmJa?=
 =?utf-8?B?Y2NScm53Vm1tUE1SY0czd3FlbjZheW1xckpXOWducjRYcW1ORjhEcGhWRU95?=
 =?utf-8?B?TGZIRmttdWFFbWdaUFBqeDBhOUlpTWp2bDJqY0ZSdXlDRjJrUXVkU2gvVDVk?=
 =?utf-8?B?Ymg5aWFqSlBuWklmMkpPUERhNllaZkM1YkxNd2dBdU9zVXdsQ0cwaFYrbnkx?=
 =?utf-8?B?RjVQTllSQVNQSVIvQWJHRGhzS3YwRGVVS1FNaXozQ2NsWlU1UWxJRmc2aXBC?=
 =?utf-8?B?QUY3S1Zxd1FSYzkwU01rUDRLSDdHaUtGTStyS0RrWnNXNWM0MWRHenJGTEJJ?=
 =?utf-8?B?NVFVTVZyaGw4WVFNNnZjdUZQbXN4aE15amxEVlVvcTJkM080aHVrZ0V5eDZZ?=
 =?utf-8?B?R2h3ZDhCKzRaSzV4MisxVFV4NTRqNG9vUWtUdVVlWkMrQStNSFlzQkxEdFpj?=
 =?utf-8?B?ZE1CTWRpRS9peG9COUJ4MjJxczVOTUcxWG1jTHk4L3pJRklGMmkyNnNQTWpW?=
 =?utf-8?B?UXp6ZVpiLzI2M3lMdTVybGc1NTJMUW8ybGtJM3BQV09FZWtnVWZxRmVCWHhJ?=
 =?utf-8?B?S003Vk9GM3YrUGt5UzAweW82NXkzSmtkb3JkL1ZheE16dnBPdnhWWlhFYUta?=
 =?utf-8?B?M3g0Zm9Ga0RFcXNOWEpXWXpIamFSY1JhRXFsdkFvTDZPN1FlakxaaHhlU2l1?=
 =?utf-8?B?cTRPc3pUWnV3RjUvc2dXS09ZbTd5MEN1MFpJaFM5T3crQUhSQ29OV0g1Z2Zi?=
 =?utf-8?B?a1MyWm9GZ3l3eHFFVW1mR0JQbGZWWjY3MTYzVnR1Tzk0V1lHU0hnMSt1ZkYy?=
 =?utf-8?B?SjV1Z21EYUQ1cS92RGp0ajZUN0kyWWNSRmhKWmZTbm9vZUdhUndCL2VJSjly?=
 =?utf-8?B?NytwcGxRTHh6NDl4SXBGWDY1RHBKQ3pNOTh1YkhYbElBK1M2d2d6THlPUmsz?=
 =?utf-8?B?dzNPbnZlQzhqYjhYbVBPZVA5ekVPL3dBOXpBRGt5NFc5UXhpMFNRUXdOQUxC?=
 =?utf-8?B?TWttbjc5Q1phVlp5YjhOYmtsNkMralBQYjBFM1VVTUk3VDZIbEg3NDd4Y3h1?=
 =?utf-8?B?aG1WYk00cVRIK3FuRXRDYzBPUktuNnYvSXd2bmZmNFVqNE5ZQ0pITUtnL1RH?=
 =?utf-8?B?TTlNREdRaFlaSmw1Qjl1TUQ4VHBtQncwK3MwbmJnYjVyTzVFMW1qVEtvZDFR?=
 =?utf-8?B?VHJnbFFNT2RhRkZpK2JLbkhKUUdGbDNoMWhaR3N0cG1aZzA3SUcybjd2SWRV?=
 =?utf-8?B?NUVFMDVBWlk2ZkdOMldwTStiZFpXRE52S0FDTVV1dVFlZGx2Rmo1eGJNeU1F?=
 =?utf-8?B?YXRlajBMTEtBaEw5S2ttRGs3eDBDUUJtZklnN0dSNmNHQjFLYlFCYXRBa3pl?=
 =?utf-8?B?RzR2V2pxTERXWHR4bkV5U1J2SjQ4NzBHQ21NUElBZWUvZVJJTFFFYmgzNGJP?=
 =?utf-8?B?Nk9Ka0FqMVpaMGxycTNGWWJKU2JDTWVIZUZkNUFTTFVQMzN3UExZaGY4RGky?=
 =?utf-8?B?UXNURGgycjk1SDNTVVF6cVQ2Um1OWU1FNUlzeUY1ODdkcEhSai82aUpDR2pI?=
 =?utf-8?B?NStYVVBpNmV2YmhFZCtHaXA4VDdtbUhvUUIxMkwzT09GN3hGOU55OS9tdllo?=
 =?utf-8?B?OWNDMktmbzYyTDVhSVRKWEVpbG80NHlMeHVIQld5OWtrWklvbTFqaGdqNG1q?=
 =?utf-8?B?TFdUSURUM2V4a2pWVjRXTHE5bjFrN0pEVzRnQ2pRbXJNU201ZWdvL2w1UUV0?=
 =?utf-8?B?YlhGVkFFckZrQXdxMzZBWm1nSEYxUEZ4NzM0L0hlRHRGUGRJcG90bVJqdnpn?=
 =?utf-8?Q?Hp/hCY526by9d1Vs61FEI7C29QadDK6Y1V1ydpXwu6vDm?=
X-MS-Exchange-AntiSpam-MessageData-1: kPO4bPkJ1B8gP2GnP07MY/PIQV5YnrNa9Ek=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 62f21ba8-1406-4d72-3ebf-08da486141af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 08:39:37.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 
 udm+3hLowfV+u7MYnjuzSWciQbfOEBOLhdGTx/gWvAmZzhF6OL4iOqdXvhT73Bn5+Z4ghKTCmYq2KoX5YeVcFiJaykQjjynXDAej2hZX/fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5070
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 07 Jun 2022 08:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8502



On 6/7/22 09:32, Jan Kiszka wrote:
> On 03.06.22 13:56, Quirin Gylstorff wrote:
>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>
>> The image types wic-swu-img and secure-wic-swu-img were removed.
>> Rename `squashfs-img` to squashfs according new naming scheme.
>>
>> To use squashfs include:
>>
>>      IMAGE_CLASSES += "squashfs"
>>      IMAGE_TYPEDEP_wic += "squashfs"
> 
> Now that squashfs is converted, that class should be pushed to Isar
> soon. Will "just" need a test case there.
> 

The testcase can also be a seperated rootfs for qemu.

>>
>> The modifications for a read-only root file system are now part
>> of a bbclass which can be include directly into the image
>> recipe.
>>
>> The modifications to generate a SWUpdate update package are
>> also no longer part of the image build process and in a seperate
>> bbclass. This class needs to be included in the image recipe.
>>
>> To create a verity based image to following line need to be added
>> to the local.conf or similar configuration:
>>
>>      IMAGE_CLASSES += "verity"
> 
> Maybe verity could go upstream as well, though it is more specific and
> may not make too much sense without the full image integration. Still,
> worth to think about it.
> 
>>
>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> ---
>>   ...u-img.bbclass => read-only-rootfs.bbclass} | 11 +---
>>   classes/secure-wic-swu-img.bbclass            | 15 ------
>>   ...{squashfs-img.bbclass => squashfs.bbclass} | 15 ++----
>>   ...{swupdate-img.bbclass => swupdate.bbclass} |  8 +--
>>   .../{verity-img.bbclass => verity.bbclass}    | 51 +++++++++----------
>>   kas/opt/ebg-secure-boot-snakeoil.yml          |  3 +-
>>   kas/opt/swupdate.yml                          |  2 +
>>   recipes-core/images/files/sw-description.tmpl |  1 -
>>   recipes-core/images/swupdate.inc              |  6 ++-
>>   .../initramfs-verity-hook_0.1.bb              |  2 +-
>>   wic/qemu-amd64-efibootguard-secureboot.wks.in |  4 +-
>>   wic/qemu-arm64-efibootguard-secureboot.wks.in |  4 +-
>>   wic/x86-efibootguard.wks.in                   |  4 +-
>>   13 files changed, 50 insertions(+), 76 deletions(-)
>>   rename classes/{wic-swu-img.bbclass => read-only-rootfs.bbclass} (75%)
>>   delete mode 100644 classes/secure-wic-swu-img.bbclass
>>   rename classes/{squashfs-img.bbclass => squashfs.bbclass} (66%)
>>   rename classes/{swupdate-img.bbclass => swupdate.bbclass} (92%)
>>   rename classes/{verity-img.bbclass => verity.bbclass} (78%)
>>
>> diff --git a/classes/wic-swu-img.bbclass b/classes/read-only-rootfs.bbclass
>> similarity index 75%
>> rename from classes/wic-swu-img.bbclass
>> rename to classes/read-only-rootfs.bbclass
>> index 41b2164..6f91f66 100644
>> --- a/classes/wic-swu-img.bbclass
>> +++ b/classes/read-only-rootfs.bbclass
> 
> There is still a "wic" relationship in this class, no?

I can rename it to wic-read-only-rootfs. only the following
line is wic specific.

``
do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"

``


> 
>> @@ -9,16 +9,10 @@
>>   # SPDX-License-Identifier: MIT
>>   #
>>   
>> -SQUASHFS_EXCLUDE_DIRS += "home var"
>> -
>> -inherit squashfs-img
>> -inherit wic-img
>> -inherit swupdate-img
>> -
>>   INITRAMFS_RECIPE ?= "cip-core-initramfs"
>>   INITRD_IMAGE = "${INITRAMFS_RECIPE}-${DISTRO}-${MACHINE}.initrd.img"
>>   
>> -do_wic_image[depends] += "${INITRAMFS_RECIPE}:do_build"
>> +do_image_wic[depends] += "${INITRAMFS_RECIPE}:do_build"
>>   
>>   IMAGE_INSTALL += "home-fs"
>>   IMAGE_INSTALL += "tmp-fs"
>> @@ -37,6 +31,3 @@ devtmpfs	/dev		devtmpfs	mode=0755,nosuid		0	0
>>   EOF
>>   }
>>   
>> -addtask do_wic_image after do_squashfs_image
>> -
>> -addtask do_swupdate_image after do_wic_image
>> diff --git a/classes/secure-wic-swu-img.bbclass b/classes/secure-wic-swu-img.bbclass
>> deleted file mode 100644
>> index 5e8e48a..0000000
>> --- a/classes/secure-wic-swu-img.bbclass
>> +++ /dev/null
>> @@ -1,15 +0,0 @@
>> -#
>> -# CIP Core, generic profile
>> -#
>> -# Copyright (c) Siemens AG, 2021-2022
>> -#
>> -# Authors:
>> -#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
>> -#
>> -# SPDX-License-Identifier: MIT
>> -#
>> -
>> -inherit verity-img
>> -inherit wic-swu-img
>> -
>> -addtask do_wic_image after do_verity_image
>> diff --git a/classes/squashfs-img.bbclass b/classes/squashfs.bbclass
>> similarity index 66%
>> rename from classes/squashfs-img.bbclass
>> rename to classes/squashfs.bbclass
>> index c22d7d6..376ddfe 100644
>> --- a/classes/squashfs-img.bbclass
>> +++ b/classes/squashfs.bbclass
>> @@ -9,9 +9,7 @@
>>   # SPDX-License-Identifier: MIT
>>   #
>>   
>> -SQUASHFS_IMAGE_FILE = "${IMAGE_FULLNAME}.squashfs.img"
>> -
>> -IMAGER_INSTALL += "squashfs-tools"
>> +IMAGER_INSTALL_squashfs += "squashfs-tools"
>>   
>>   SQUASHFS_EXCLUDE_DIRS ?= ""
>>   SQUASHFS_CONTENT ?= "${PP_ROOTFS}"
>> @@ -29,14 +27,11 @@ python __anonymous() {
>>       d.appendVar('SQUASHFS_CREATION_ARGS', args)
>>   }
>>   
>> -do_squashfs_image[dirs] = "${DEPLOY_DIR_IMAGE}"
>> -do_squashfs_image() {
>> +IMAGE_CMD_squashfs[depends] = "${PN}:do_transform_template"
>> +IMAGE_CMD_squashfs() {
>>       rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
>>   
>> -    image_do_mounts
>> -
>> -    sudo chroot "${BUILDCHROOT_DIR}" /bin/mksquashfs  \
>> -        "${SQUASHFS_CONTENT}" "${PP_DEPLOY}/${SQUASHFS_IMAGE_FILE}" \
>> +    ${SUDO_CHROOT} /bin/mksquashfs \
>> +        '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
>>           ${SQUASHFS_CREATION_ARGS}
>>   }
>> -addtask do_squashfs_image before do_image after do_image_tools do_excl_directories
>> diff --git a/classes/swupdate-img.bbclass b/classes/swupdate.bbclass
>> similarity index 92%
>> rename from classes/swupdate-img.bbclass
>> rename to classes/swupdate.bbclass
>> index 1437c07..c3fc303 100644
>> --- a/classes/swupdate-img.bbclass
>> +++ b/classes/swupdate.bbclass
>> @@ -18,9 +18,9 @@ SWU_SIGNATURE_TYPE ?= "rsa"
>>   
>>   IMAGER_INSTALL += "${@'openssl' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>   
>> -do_swupdate_image[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>> -do_swupdate_image[cleandirs] += "${WORKDIR}/swu"
>> -do_swupdate_image() {
>> +do_swupdate_binary[stamp-extra-info] = "${DISTRO}-${MACHINE}"
>> +do_swupdate_binary[cleandirs] += "${WORKDIR}/swu"
>> +do_swupdate_binary() {
>>       rm -f '${SWU_IMAGE_FILE}'
>>       cp '${WORKDIR}/${SWU_DESCRIPTION_FILE}' '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
>>   
>> @@ -91,4 +91,4 @@ do_swupdate_image() {
>>       cd -
>>   }
>>   
>> -addtask swupdate_image before do_build after do_copy_boot_files do_install_imager_deps do_transform_template
>> +addtask swupdate_binary before do_build after do_deploy do_copy_boot_files do_install_imager_deps do_transform_template
>> diff --git a/classes/verity-img.bbclass b/classes/verity.bbclass
>> similarity index 78%
>> rename from classes/verity-img.bbclass
>> rename to classes/verity.bbclass
>> index b7d7f08..bbc57b0 100644
>> --- a/classes/verity-img.bbclass
>> +++ b/classes/verity.bbclass
>> @@ -8,13 +8,16 @@
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
>> -
> 
> Unrelated whitespace change.
>

Will remove in v2

>>   VERITY_IMAGE_TYPE ?= "squashfs"
>>   
>> -inherit ${VERITY_IMAGE_TYPE}-img
>> +inherit ${VERITY_IMAGE_TYPE}
>> +
>> +IMAGE_TYPEDEP_verity = "${VERITY_IMAGE_TYPE}"
>> +IMAGE_TYPEDEP_wic += "verity"
>> +IMAGER_INSTALL_verity += "cryptsetup"
>>   
>> -VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.img"
>> -VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img"
>> +VERITY_INPUT_IMAGE ?= "${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}"
>> +VERITY_OUTPUT_IMAGE ?= "${IMAGE_FULLNAME}.verity"
>>   VERITY_IMAGE_METADATA = "${VERITY_OUTPUT_IMAGE}.metadata"
>>   VERITY_HASH_BLOCK_SIZE ?= "1024"
>>   VERITY_DATA_BLOCK_SIZE ?= "1024"
>> @@ -37,14 +40,28 @@ create_verity_env_file() {
>>       done < $input
>>   }
>>   
>> -verity_setup() {
>> +python calculate_verity_data_blocks() {
>> +    import os
>> +
>> +    image_file = os.path.join(
>> +        d.getVar("DEPLOY_DIR_IMAGE"),
>> +        d.getVar("VERITY_INPUT_IMAGE")
>> +    )
>> +    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
>> +    size = os.stat(image_file).st_size
>> +    assert size % data_block_size == 0, f"image is not well-sized!"
>> +    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
>> +    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
>> +}
>> +do_image_verity[cleandirs] = "${WORKDIR}/verity"
>> +do_image_verity[prefuncs] = "calculate_verity_data_blocks"
>> +IMAGE_CMD_verity() {
>>       rm -f ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>>       rm -f ${WORKDIR}/${VERITY_IMAGE_METADATA}
>>   
>>       cp -a ${DEPLOY_DIR_IMAGE}/${VERITY_INPUT_IMAGE} ${DEPLOY_DIR_IMAGE}/${VERITY_OUTPUT_IMAGE}
>>   
>> -    image_do_mounts
>> -    sudo chroot "${BUILDCHROOT_DIR}" /sbin/veritysetup format \
>> +    ${SUDO_CHROOT} /sbin/veritysetup format \
>>           --hash-block-size "${VERITY_HASH_BLOCK_SIZE}"  \
>>           --data-block-size "${VERITY_DATA_BLOCK_SIZE}"  \
>>           --data-blocks "${VERITY_DATA_BLOCKS}" \
>> @@ -55,23 +72,5 @@ verity_setup() {
>>   
>>       echo "Hash offset:    	${VERITY_INPUT_IMAGE_SIZE}" \
>>           >>"${WORKDIR}/${VERITY_IMAGE_METADATA}"
>> +    create_verity_env_file
>>   }
>> -
>> -do_verity_image[cleandirs] = "${WORKDIR}/verity"
>> -python do_verity_image() {
>> -    import os
>> -
>> -    image_file = os.path.join(
>> -        d.getVar("DEPLOY_DIR_IMAGE"),
>> -        d.getVar("VERITY_INPUT_IMAGE")
>> -    )
>> -    data_block_size = int(d.getVar("VERITY_DATA_BLOCK_SIZE"))
>> -    size = os.stat(image_file).st_size
>> -    assert size % data_block_size == 0, f"image is not well-sized!"
>> -    d.setVar("VERITY_INPUT_IMAGE_SIZE", str(size))
>> -    d.setVar("VERITY_DATA_BLOCKS", str(size // data_block_size))
>> -
>> -    bb.build.exec_func('verity_setup', d)
>> -    bb.build.exec_func('create_verity_env_file', d)
>> -}
>> -addtask verity_image before do_image after do_${VERITY_IMAGE_TYPE}_image
>> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
>> index 3f2a794..2822cef 100644
>> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
>> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
>> @@ -23,7 +23,8 @@ local_conf_header:
>>       IMAGE_INSTALL_append = " swupdate-handler-roundrobin"
>>   
>>     secure-boot-image: |
>> -    IMAGE_FSTYPES = "secure-wic-swu-img"
>> +    IMAGE_CLASSES += "verity"
>> +    IMAGE_FSTYPES = "wic"
>>       WKS_FILE = "${MACHINE}-efibootguard-secureboot.wks.in"
>>       INITRAMFS_INSTALL_append = " initramfs-verity-hook"
>>   
>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>> index 72429c6..c2bd15c 100644
>> --- a/kas/opt/swupdate.yml
>> +++ b/kas/opt/swupdate.yml
>> @@ -23,5 +23,7 @@ local_conf_header:
>>       CIP_IMAGE_OPTIONS_append = " swupdate.inc"
>>   
>>     wic-swu: |
>> +    IMAGE_CLASSES += "squashfs"
>> +    IMAGE_TYPEDEP_wic += "squashfs"
>>       IMAGE_FSTYPES = "wic"
>>       WKS_FILE ?= "${MACHINE}-${SWUPDATE_BOOTLOADER}.wks.in"
>> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
>> index f5cafeb..1eb7758 100644
>> --- a/recipes-core/images/files/sw-description.tmpl
>> +++ b/recipes-core/images/files/sw-description.tmpl
>> @@ -16,7 +16,6 @@ software =
>>               filename = "${ROOTFS_PARTITION_NAME}";
>>               device = "C:BOOT0:linux.efi->fedcba98-7654-3210-cafe-5e0710000001,C:BOOT1:linux.efi->fedcba98-7654-3210-cafe-5e0710000002";
>>               type = "roundrobin";
>> -            compressed = "zlib";
> 
> Why that? Looks at least unrelated.
>

This was a workaround during develop and should have been remove.
Will be revert to the origin in v2.

>>               filesystem = "ext4";
>>               properties: {
>>                           subtype = "image";
>> diff --git a/recipes-core/images/swupdate.inc b/recipes-core/images/swupdate.inc
>> index 64887df..2ec767f 100644
>> --- a/recipes-core/images/swupdate.inc
>> +++ b/recipes-core/images/swupdate.inc
>> @@ -8,10 +8,12 @@
>>   #
>>   # SPDX-License-Identifier: MIT
>>   #
> 
> Please add a blank line here.

Done
> 
>> +inherit swupdate
>> +inherit read-only-rootfs
>>   
>> -FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>> +ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.p4"
>>   
>> -ROOTFS_PARTITION_NAME = "${IMAGE_FULLNAME}.wic.img.p4.gz"
>> +FILESEXTRAPATHS_prepend := "${THISDIR}/files:"
>>   
>>   SRC_URI += "file://sw-description.tmpl"
>>   TEMPLATE_FILES += "sw-description.tmpl"
>> diff --git a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> index f0d2d68..60ee8da 100644
>> --- a/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> +++ b/recipes-initramfs/initramfs-verity-hook/initramfs-verity-hook_0.1.bb
>> @@ -28,7 +28,7 @@ VERITY_IMAGE_RECIPE ?= "cip-core-image"
>>   
>>   VERITY_ENV_FILE = "${DEPLOY_DIR_IMAGE}/${VERITY_IMAGE_RECIPE}-${DISTRO}-${MACHINE}.verity.env"
>>   
>> -do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_verity_image"
>> +do_install[depends] += "${VERITY_IMAGE_RECIPE}:do_image_verity"
>>   do_install[cleandirs] += " \
>>       ${D}/usr/share/initramfs-tools/hooks \
>>       ${D}/usr/share/verity-env \
>> diff --git a/wic/qemu-amd64-efibootguard-secureboot.wks.in b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> index e097eac..0e298bc 100644
>> --- a/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-amd64-efibootguard-secureboot.wks.in
>> @@ -1,7 +1,7 @@
>>   include ebg-signed-sysparts.inc
>>   
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>>   
>>   # home and var are extra partitions
>>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
>> diff --git a/wic/qemu-arm64-efibootguard-secureboot.wks.in b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> index b3bbed4..3b8dadd 100644
>> --- a/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> +++ b/wic/qemu-arm64-efibootguard-secureboot.wks.in
>> @@ -1,7 +1,7 @@
>>   include ebg-signed-sysparts.inc
>>   
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.${VERITY_IMAGE_TYPE}.verity.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.verity" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>>   
>>   # home and var are extra partitions
>>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024 --size 1G
>> diff --git a/wic/x86-efibootguard.wks.in b/wic/x86-efibootguard.wks.in
>> index f60ebcf..c71253d 100644
>> --- a/wic/x86-efibootguard.wks.in
>> +++ b/wic/x86-efibootguard.wks.in
>> @@ -3,8 +3,8 @@
>>   
>>   include ebg-sysparts.inc
>>   
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> -part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs.img" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000001"
>> +part --source rawcopy --sourceparams "file=${IMAGE_FULLNAME}.squashfs" --align 1024 --fixed-size 1G --uuid "fedcba98-7654-3210-cafe-5e0710000002"
>>   
>>   # home and var are extra partitions
>>   part /home --source rootfs --rootfs-dir=${IMAGE_ROOTFS}/home --fstype=ext4 --label home --align 1024  --size 1G
> 
> Jan
> 


Quirin

