Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9930C001E0
	for <webhook@archiver.kernel.org>; Thu, 10 Aug 2023 11:47:25 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.71])
 by mx.groups.io with SMTP id smtpd.web10.15136.1691668044492037910
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Aug 2023 04:47:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BtRSdGeO;
 spf=pass (domain: siemens.com, ip: 40.107.247.71, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDR23qmH9ZP9N+o42geZ9qN6u4uWmNC+Kr99Rsqgvq1WJRAjEaG/OV/WhXvRplf7XaHWgHBKGdGDdONyD4g6ETPqO3jLRH/RM2u2WcYu0NT81RtAGeYSGMPa5uIqX6OPQMoM6W+Isb2hZDqFyGtAVmNxKcnb48IXgEaq6BvnJOyyNVdWIxrdLLAhpfyJDu01UiH5PQ+V6tlfcnumt0Cyc9BIX++wGC/uuxCJYxQLNbDAMfCLsD+VWcr9iIg60ZcfVglnMzpe+ktc9XFmC5NAsDm2QubFFgIG6UFbjiVqB5UBZW1WB4E4sKAYbeOX6SmXqS393ye/PufmxOgYERtadA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ADRHPI/YUO8Dhvw7jU+tUrAozj7OjCZY4Bgh6Y1SVs0=;
 b=hGxKk3SJXR4AHsI15GgXGTbjkRamHv9YexGIvR7NfEz3gtKzuKOH5bgdNEuKJuIH+fKsnBsCn/n4B1yT9rRVFt1EoN/MNDs9/8jToZ5PTOE8s7ybsTGJVCGZR/qBA4L0CbOuvEdnfTmh1Zb5XRNnkOfB5QGjS5yHGewsmahBpiEX8vu1N9lvFyszRItjocoS+JefKHAt8nN30Vuur2YFuQdV9TjTT3bC5zC8P20CpoTF8H+NDjEucqO7c11/0ZCJ+9ZnqnPPH83DqTa4NtfZ1oZuqbcN+6EWIJ8Vn26zEEvAHBdE1NNuGfYdc8qNUEI5LQaW0t5FYq3ARRPM8bXBPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ADRHPI/YUO8Dhvw7jU+tUrAozj7OjCZY4Bgh6Y1SVs0=;
 b=BtRSdGeO6zlefpuni0rG44rGusNUO5iQi1fmxWBoRErfXmvh8gH23ZYn1J9sFJe0DGrzkGt8gkYw6aOO9YJi5BsZ0nTxiiJ+JfBqXp/QUhhaAmW/pzCmgsqClbPErlQ9OF9BFO9A6+jUkn6QWE5ozHRbySo+m4aMbFPjJvF2Ama0DcJUVeW8TwwTGzdLVrDlDlN5F32DMFySos2YVr1kcGCZiI2DDGvD17HaEbbGkCWB2YDB1fwmnrmspz/IW5ZHV/Y2nIIvf0GaoKmj99Fmvyje7Y4P0fnwomAUCdNGtCmpwQQppStN/1cBbFPiZ6OcAfqqqQxaYuNh0lek4rBddw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU0PR10MB6898.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:465::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 11:47:20 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7f20:d403:b43d:12e2%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 11:47:20 +0000
Message-ID: <d35d9d1a-8eb8-453f-a299-53b1dcb36981@siemens.com>
Date: Thu, 10 Aug 2023 13:47:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC v2 3/3] swupdate: Enable signed
 updates
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230717105417.27761-1-Quirin.Gylstorff@siemens.com>
 <20230717105417.27761-4-Quirin.Gylstorff@siemens.com>
 <14e1c827-c770-4f84-8b24-279dc54699d5@siemens.com>
 <ea49f7a3-0723-94cb-7af9-79a9c84ef766@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <ea49f7a3-0723-94cb-7af9-79a9c84ef766@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU0PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a526f8e-3e47-41c4-55b0-08db99978da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	6RQUc1nj+WpYkShCTuOSm3WccAScwsaTtpYpFP+xq/3/FEHMg+TpZpocxbUjFkZtT++8m0OenBuSn5BKGC5GrwEVN/fcHMZpgaT2/0eP9vJF6jRRuKgCBV12URyx+HuZ/h5h4fH3GDZcmWhJRJ0VQreKtTWuTT3IpxCB5eHexAbUPV/GKo+YCYRpefwACUbMS1dDFyd3JgUhKrVEgy8SgwTVHH9fEJoqkGyylayIY9znwatvIyulKH6j9A60na9X9RdGASUvxhPdUepZo7tJ7jJaT+wVnCgbBhewkUA+4YpQIMtqR5kvwd7u+Wx5NyyrmzBV1b1PsYK39pTfBQx1pj+ZLwkIrRTb6LsBORgYb3c1s1S7w2PgmpFYqw9DFH6k1ZZJcYyfDIDWc/UwaomnYCgHP3tZghYtn0h3SnceOGE+46BOYgFK2LsX2cYiJJe/N23rAWqZt5/f0thw1xhFCbl1et3WeUAyVhYCGwcuF6q7CgDLB3Ml64kXkwQo5vSvf+i09Ad1ORaFZXSKy9wxVRBLVsbG8YR0bgVmvLbrTrgqkylyy10QOVd1zjhfl4Qt2jAglE2SnvNvOR2mSSgSbUJGIm0RpR9XsBEXs5BcLr418Gq4QmaD5UjukhFwhQW+I5SSx+XC06nep2aSJ04aKQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(451199021)(186006)(1800799006)(53546011)(6506007)(82960400001)(478600001)(86362001)(83380400001)(31696002)(26005)(6486002)(36756003)(6512007)(2616005)(15650500001)(66556008)(66946007)(66476007)(316002)(44832011)(2906002)(8936002)(8676002)(41300700001)(5660300002)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?NtTsLgEUJTh8h4lbjwtHCrfltjzg9x1aqpsL5MpTXytdbE+irYHwqSORgFsf?=
 =?us-ascii?Q?zY+QTLsfcvPwOVcrEaE3hJNZ6fveSSnn1w/TtW0GUgyPr2hy3S1diA5br0Hv?=
 =?us-ascii?Q?USuP5qs106sr1jzZEjjDOqj5hL7HnG1puMZ0MV72q78/guWH0z4hVww0qIme?=
 =?us-ascii?Q?TdoEmhqpEWoabdUcd2EwdJ8uKc28JQksLt8RU5g+NLL3s7YS/D3+rOPN7MzI?=
 =?us-ascii?Q?99FgfVnsABl2v6B4eM7/TweKFyIiMjKAN5XDI9liffujGj251IcaI2vp+4kQ?=
 =?us-ascii?Q?0a9wzIxZlbUGp8xfo0aDuYZmC82HTstES1j1k+Hs/NClD9DnyF/ohIGMtpkx?=
 =?us-ascii?Q?U5FN59uT9A+zqCuEIkfl7jKmQ8i8ZmHs+G7TBKXsSwh2iLbBgVlROc+EUdBv?=
 =?us-ascii?Q?O0xcL48LyN2IR6sFp3StQbQF49w19P83UzfFjXAGqiCsQtK3BrCP8dVkaAY4?=
 =?us-ascii?Q?azaqfmod9+dQ3cNVDd0YB1neWcQG+dOeoIQczOXHACubcFgL24K3GR/AbNdF?=
 =?us-ascii?Q?z1jmJcRcZ+j7VAhSbl5HsFS1fuR1aA7M/wN03L7xnDi1wd/dqhSfckTFrmVY?=
 =?us-ascii?Q?LOILAUhGSQAN6E1ZgdlpkZ/rgLYxociJS+6gxIDETby5Jd8Q7LLNQat4Zhcl?=
 =?us-ascii?Q?sJjFIqSdLzwTyiSFSMVaXnWtFra65KNHMoysQ5rG78LZW/vzWropHIXmIv3w?=
 =?us-ascii?Q?S57IACgKr3SSZwdO6fcz+nGdO4vpxAPPYGD68qDoTiEbm08c2nM9nV7RfSia?=
 =?us-ascii?Q?Qjc17r8eZ0rh7bH4WEp89Cr2xCE6vBsZLQHaOuYFl7gJBxs6Z8uoBHP0vVXc?=
 =?us-ascii?Q?CqSEvulYkW76fYU3xDDPfCfUDshuVXQ3IOUhCZZRxkeyGIP9SOPa9TL4F+Yq?=
 =?us-ascii?Q?B1UJduUnKsbUD7hI5r5ZH7zT1/UY0ga/vxkXrpcE2ZuMgNpyX+q/h+KlSJKN?=
 =?us-ascii?Q?XjyEts0GQPRlXDXEf1hXm0vrBzFz1xao4rGYFrAzkbxG3L8r2TNbpm+5Xo+N?=
 =?us-ascii?Q?AJjihABF059G4N0+dGHOn6A2DH+JjGvZd6X31LQKUk40RG9vN65xUqCHllWl?=
 =?us-ascii?Q?PumOGxGpPCqUoqM6lSp9VJhqsqPVgoKeYomzAxIc41Zz00GBALh21BKhG57I?=
 =?us-ascii?Q?+Rrxo9+3cTCkMPyRTDOQiATgT+yAyD0VTfGpoN7oSkfdglXkBrzZ2evzGtmU?=
 =?us-ascii?Q?2sBAw/biRmfFIVCtN2LaiVTdfs0zGSaej7pxo1j+3ECBYLrGJGZlEr2lGKAB?=
 =?us-ascii?Q?1q06vl8qiGuJfmC1h55fK28Z8AsfsuJ8k8fPN2OCwB5htbZKiudvfezfzLt9?=
 =?us-ascii?Q?KJcDAB2arbqHt2GSVPXFNOEpfJj12m6XAUpUCEuGJIRkrUwlekvLo+nyVzc0?=
 =?us-ascii?Q?py/VT1JJ5p+pzm6RNBI9S4MJk3Kjjgkx8KYKdLpa9sGiuYZPHJmv2yxG63s0?=
 =?us-ascii?Q?VdpzN5Nz+4guoWmwB9TrFFofyXGw/DOqhIylKRjykMGvm42kCXIElP/3kxht?=
 =?us-ascii?Q?tve+ckDqeXuh+Z+V3IkPTgLGgz+/rQZd+XNsF+tDZVLkJSppA15JjjCrD825?=
 =?us-ascii?Q?XZnJCxzyBWQOE0JObMEfOWNqE7UkQwuADZrfN2v5jRQJREfWwuzYkcu65Lv4?=
 =?us-ascii?Q?yQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a526f8e-3e47-41c4-55b0-08db99978da4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 11:47:19.9675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T8aM5hSxtGWnHsOH30XZzZKa/h9pEO259RKqNMBGPNwndmCCROP7b/psCOIYVUjMdT4aHwZyAbawdwY3iH3dXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Aug 2023 11:47:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12603

On 10.08.23 13:45, Gylstorff Quirin wrote:
>=20
>=20
> On 8/10/23 13:31, Jan Kiszka wrote:
>> On 17.07.23 12:54, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> With this change SWUpdate requires signed binaries to update
>>> the system. An update without the correct signature will lead to the
>>> following error message:
>>> ```
>>> Error: SWUpdate is built for signed images, provide a public key file.
>>> ```
>>>
>>> If unsigned binaries are wanted readd the Build option
>>> ```
>>> DEB_BUILD_PROFILES +=3D "pkg.swupdate.nosigning"
>>> ```
>>> to a swupdate_%.bbappend recipe
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 kas/opt/swupdate.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 2 ++
>>> =C2=A0 recipes-core/customizations/files/swupdate.cfg=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
>>> =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
>>> =C2=A0 recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb | 9 +++++=
+---
>>> =C2=A0 recipes-core/swupdate/swupdate_2023.05.bb=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 8 ++++++--
>>> =C2=A0 5 files changed, 16 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/kas/opt/swupdate.yml b/kas/opt/swupdate.yml
>>> index b0293ce..0e30e89 100644
>>> --- a/kas/opt/swupdate.yml
>>> +++ b/kas/opt/swupdate.yml
>>> @@ -28,3 +28,5 @@ local_conf_header:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INITRAMFS_INSTALL:append =3D " initramfs=
-squashfs-hook"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ABROOTFS_PART_UUID_A ?=3D "fedcba98-7654=
-3210-cafe-5e0710000001"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ABROOTFS_PART_UUID_B ?=3D "fedcba98-7654=
-3210-cafe-5e0710000002"
>>> +=C2=A0=C2=A0=C2=A0 PREFERRED_PROVIDER_swupdate-certificates-key ??=3D
>>> "swupdate-certificates-key-snakeoil"
>>> +=C2=A0=C2=A0=C2=A0 PREFERRED_PROVIDER_swupdate-certificates ??=3D
>>> "swupdate-certificates-snakeoil"
>>
>> This needs to go into patch 2, right?
>=20
> It can go there. Only with this patch it has an impact on SWUpdate.
>=20
> Should I send a v3?

Not needed, I've already moved the hunk while merging.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


