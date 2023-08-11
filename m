Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A303EB64DD
	for <webhook@archiver.kernel.org>; Fri, 11 Aug 2023 04:58:31 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.58])
 by mx.groups.io with SMTP id smtpd.web10.36757.1691729907503252155
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 21:58:28 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=EGWdZu7U;
 spf=pass (domain: siemens.com, ip: 40.107.249.58, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IdYYzxatHUerp+5p/AwGbiIuuW2vyShv8Sdq7lha1ForYxZGCksXxtS0+iLNbtB5fDXJuA+qFnqHTGYbrJuYRw5qJfRT2ipvYknu33Qa+nE6f7NLCew93DRVnr0H9dmMVZzKugQqOv1gKtCUCK/g4iSEuJ0QG7tbrKno45+Th0CDI+ZDbl0yafjc4m4kcGVPJZ6WDrD7/xbqyQKAAjo/NVCNDmrmudBjRlLEAGPXDN9lMZNUYGO5W7Vnm3GVJX5PZXsfDe6xgYqxK2Kee+sLc3G7Hagmdol2wTpw1dxV+yPuLxPPdLUpebaEGeWa7PkpC+JPSgSgUu4ihKqpCI7mkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGZnWJpkxisq0kYiOtlahkVcFKXs2+tHv3C+GYa5+jU=;
 b=IxPVu3m1llV6BtLvr1EdIjBAu/slzQ0LgB79x07EITIoTvW7qD03p58YXc8hx5WnQyVeRBAH3ffEPjlJknATSIwQGnffR170Im8DVpRKEus4vk3N8xUyWBl3SJaGKBczKe/Gp8u5/zvD+iBo/LoXncDcx3Xe7/5rkvsqtqh0S6P3cuiz3lNC95s3yW2on7hx0mDbeeSdabBwoRA/FY6q3nYxPUo+Y0q4bCx9qfQcRzy6/diYbN9wgVDIpHZPvURwi78QU3q7G6AqfoKQXsHVLCk1wFViIwBY8u6O9nouCiP/5MQ3K+TspBADAYicIE6lPU3k/3zw0M1cFxwCQRG1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGZnWJpkxisq0kYiOtlahkVcFKXs2+tHv3C+GYa5+jU=;
 b=EGWdZu7Uy2nY2qfxQytB5MRf5B1n8mTSO7CaRHISPFd2NMzkFFFuHIU4bXEaLTUq5R+iXdVsjR+R34zk5BRHIO5Q2oIfdypYJyTKwbNmtP3yowG7D+InY6vX2ARdSHj0Newp/zW9AOaj8ZAx8n7/O498I8/ar776N3RHZMXv2Hq97bXz+ibNRBGQjMDlCeYOC8vcfyEN6VX30IJhblIleuzSapnaoDYuECmFAOb8fDmFW5MT2o7Nk21vXMzz8BvwXI8K3RivufgEvyVSDKeqlV2HBjtOFWTe53DoHOWbKqd8v+Fdq/NHfXftBdKonIv/66nQv39biAA64S6CKgboBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6525.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 04:58:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6678.019; Fri, 11 Aug 2023
 04:58:23 +0000
Message-ID: <cce5cd20-8876-4417-b5fc-85dd0e053fd8@siemens.com>
Date: Fri, 11 Aug 2023 06:58:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <ed132a4b-7c2c-44f2-b1c6-8a7c8fdfcdda@siemens.com>
 <45e6785d-6d78-8d40-bce1-2606661730e2@siemens.com>
 <f75e9b6a-f89d-46b3-9f38-2847396e35d3@siemens.com>
 <e5b311e7-7a75-2028-156b-6f117f8221dc@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e5b311e7-7a75-2028-156b-6f117f8221dc@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0262.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::8) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d263e3d-b165-437d-fcfd-08db9a279711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4jLERkxYHBHHa9Hn1jmn1xjjLU0C0XanhivxT5E4qD6ixLDmvlWZHoXWKSDwN+hjbtsF3CAYcYxKD6n6m91Yt3z0ZUsb0kVU6pPnazbrYFD3Vw2t8jpc3p/FOCnvURIM6SGR3som6OKkfBySwR+1PDfAaCsNIg7vwIW9Fum1RZc5+IsDcWoxFKchTtEPpPD4SQXXIeE3HFq5GaEttaoYGTOvZKmx9J48b43qu3HEEVVvrHarATSwUMIktBc+CG4zheIr3UsHo3BSWA+xmvgVoHMYAuND8XKH7E5G7vbecDs1A7i/Tr0wukLLaOAEaYH9cbFNZSKHDAc8Dar6GnblTCGOjs0ya4w2BQ0L5inGC9BoG26SCf/gp7M3nfmN2TQ49ZgtB8jEBJE9x6rMGYc4VWZOraO3AfUWVufNp0c6zwiYVNufYTJ9fIuUm/eQutSmRmPd3c+3stq57vkneBU0vSfnEQlzN+Bpd+p163OwXUZ/2sDKHrvvZUVWegKr3rB1ieJW7LEdOt/uJu+XQNEVTQHJacZlMJV1H49rd64vICEAgUC7IIhVPVS6UGgl+CjPWXD9A/YQ9Vt8+xq6+CoftmauGmYkNiG76btlu5LACstglD4RtgyNQ2OP8XyPsy+JfUSc20PJd3U2SEQKVwky6w==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(1800799006)(186006)(451199021)(66899021)(31686004)(66946007)(6506007)(66556008)(66476007)(26005)(478600001)(36756003)(38100700002)(31696002)(53546011)(2616005)(83380400001)(44832011)(15650500001)(6486002)(41300700001)(316002)(2906002)(6512007)(8676002)(86362001)(5660300002)(82960400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eKD5nd6Udj/k0cF12S+5F5b/FfcwqaP0EUclG755qU+Ig7H9NYo3dq+MUN9I?=
 =?us-ascii?Q?kQbjuMCShaYBL5sT8Yz1ihcoJia5hkpoaYAnMdA1LLDhPebKdjszgiAPnT8r?=
 =?us-ascii?Q?F8+9ekIPqhXCQhbUSUoueEXMFtXJntQue2MypW5MTNS3DwyxANhvKfXFWSaS?=
 =?us-ascii?Q?xc6wSxA8OEwdlHzSDYOxGCtYfAoMjjqBizefy2wqh1jKTUp6LILHwOtkXqS9?=
 =?us-ascii?Q?oLiu0D5rG49+2dRLVb7s6UlvCl3yFGVOgvbCRHMeikKKqBNvGLNKcrA8SWCI?=
 =?us-ascii?Q?NJWNVlffY8L3QVpeCmaq9bE4CXe/P1a0GsbxaqcFSDSQbLoA4Vu87GwvAAIu?=
 =?us-ascii?Q?tm0WF1GCzDFyB79/vogPYyOC5hRU8gcmfjfPtproJL3PE8X9JnICNZDKGIbb?=
 =?us-ascii?Q?M9ZoOgJkZF3SxwI3dfvrfrDzaQsYP7nI3C7nx3hDxrXn9a6z4ycBzRdg4boO?=
 =?us-ascii?Q?i2mfh5Br6FhJLnkMMU/0O71XBpHwPS6wl0OSg8Cr4jwJgNi0GUCDX3Lvzd/W?=
 =?us-ascii?Q?ts5qerg7DqRvTJLx083YU66pWlMMJQbE44MsqGZ9/nEpXL+ORZM4ey1sgoDA?=
 =?us-ascii?Q?3ppTxM6XwkCA6PYv4yfWHP81HGDK39RRksi+2st8HyPv0XysIV8l4cvqDlCr?=
 =?us-ascii?Q?JaFG6wB9XUm8JjLsaog0gqqrT4/NoxKEZlN+gUeG6twRZXv3g/IzNxdQOAGY?=
 =?us-ascii?Q?+KVGT0jkjNvKrTglFJi0hDqXmPNNxzaWlO/P8zU8rIX3JZgKfgUOqV5lb3Gt?=
 =?us-ascii?Q?Abb+LToKTTTGn8HbZhaZy9JWYYuk1OpQMyZX7w1xjJvwvrwObRlxXhG2nL8r?=
 =?us-ascii?Q?sLTDicaixA1VP2ydD3NzJ1orj5ApzwXBP9xv7nJkMSBEiBv8IVDeAKZPOOku?=
 =?us-ascii?Q?2xG44S9C4bKd4rA6t5mPHRUU810k4lbZBd9kZzPZIMDuqidsgLEFCnEW1IL9?=
 =?us-ascii?Q?OrqqEVz1WQWIzBAY/GFABiDeHCRlIzz1FmYkLzEZe/K/bco8E+dTaEbM6nCT?=
 =?us-ascii?Q?QeqHDYnpM/LprUgDaey8+5d0E877BL5WIlF+9oVhVle9qg1xCz85aREELuTP?=
 =?us-ascii?Q?18iMeNF9rbD6U8iL1w8mv1il1BUa5d3zBiav5o8/GcWqJJLS4PTH2QZyzUMu?=
 =?us-ascii?Q?O04BMkfoIznAm6HJU8EYQq/ysTMj/ZJegrBryIcTB4t8COCrJurRxqJ2HE0v?=
 =?us-ascii?Q?7LrR9sw1GonWZq4tMj0nspPPTFEge5zXuDEzqfG0pxdHrhesb/kO9XctZ6CK?=
 =?us-ascii?Q?A8bMqhZSEEyfGf6JiLacWSkZNlTpi2YFX/ANyDRVriMf4KlCH2GXpaLEt4IA?=
 =?us-ascii?Q?9C5CFTc+ivPxf3NpZWuI5RTtmzAM1S5WR37SDenaqLk3dDmZttqyKudaThR3?=
 =?us-ascii?Q?vZzCgs0xSL3cMWDJNmYRrYnT8OqVZhBXiincvrUWZHhkPo2Q4eKRAtOAwRcL?=
 =?us-ascii?Q?DSv3oEr2Ik6veOHAxZKclNy9RzGgDZTrf4fziVXLc/0e+LDWEzNAIPKAY9tY?=
 =?us-ascii?Q?bj9F3vBxnMpwMBz7gcmyFyFmextGYHt0I5sxjcX6DeOwVtH2PMWGtUcds614?=
 =?us-ascii?Q?HZs8GSLW+Dujv6ZxErtrD2XHFadKMzSElXPL881FE8ZVmwjcfiOU/s6lNSTD?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d263e3d-b165-437d-fcfd-08db9a279711
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 04:58:23.8357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nrP0Nw5DtIYV5QHecE8JWSG/BYHhk4lhNyjQ+9UP8a7XFSOHO1lGmV3u+6mU/h+XjlyTZExTkHz3hVII41pYiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6525
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Aug 2023 04:58:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12609

On 10.08.23 19:35, Gylstorff Quirin wrote:
>=20
>=20
> On 8/10/23 18:38, Jan Kiszka wrote:
>> On 10.08.23 17:58, Gylstorff Quirin wrote:
>>>
>>>
>>> On 8/10/23 16:47, Jan Kiszka wrote:
>>>> On 17.07.23 12:54, Quirin Gylstorff wrote:
>>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>>
>>>>> With this change SWUpdate requires signed binaries to update
>>>>> the system. An update without the correct signature will lead to the
>>>>> following error message:
>>>>> ```
>>>>> Error: SWUpdate is built for signed images, provide a public key file=
.
>>>>> ```
>>>>>
>>>>
>>>> I ran a build with SWU_SIGNED unset, and the result rather gives
>>>>
>>>> [TRACE] : SWUPDATE running :=C2=A0 [network_initializer] : Software up=
date
>>>> started
>>>> [WARN ] : SWUPDATE running :=C2=A0 [scan_mtd_devices] : MTD is not pre=
sent
>>>> on the target
>>>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : MTD is not present in =
the
>>>> system
>>>> [WARN ] : SWUPDATE running :=C2=A0 [mtd_init] : cannot open libmtd
>>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : Found file
>>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0=
 filename
>>>> sw-description
>>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] :=C2=A0=C2=A0=
 size 1219
>>>> [TRACE] : SWUPDATE running :=C2=A0 [extract_file_to_tmp] : description=
 file
>>>> name not the first of the list: linux.efi instead of sw-description.si=
g
>>>> ...
>>>> [ERROR] : SWUPDATE failed [1] Image invalid or corrupted. Not
>>>> installing ...
>>>>
>>> I will look into it a send v3 if necessary.
>>>
>>
>> Otherwise, things seem to work fine. I would just like to understand if
>> that is also an expected outcome.
>>
> It is a ordering problem in the cpio. If I `cpio -t <
> cip-core-image-cip-core-bullseye-qemu-amd64.swu` this is the expected
> result:
> ```
> sw-description
> sw-description.sig
> linux.efi
> cip-core-image-cip-core-bullseye-qemu-amd64.verity
> 280835 blocks
> ```
> Can you do that on the transferred file?
>=20

Without SWU_SIGNED, I get

sw-description
linux.efi
cip-core-image-cip-core-bookworm-qemu-amd64.squashfs
265849 blocks

SWUpdate seems to look for sw-description.sig on slot 2 but only finds
linux.efi. That makes it unhappy, but rather than saying "this swu is
not signed", it complains about running into the wrong file.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


