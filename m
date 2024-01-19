Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D132C47DB7
	for <webhook@archiver.kernel.org>; Fri, 19 Jan 2024 09:41:46 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.49])
 by mx.groups.io with SMTP id smtpd.web10.18498.1705657295914810179
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jan 2024 01:41:36 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Qkogkm/i;
 spf=pass (domain: siemens.com, ip: 40.107.247.49, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHZn51XmcTgTEUNXuvvbrX9aPVr3gfo4VkaQW4Zh2DT5wr6tD0gGW7WxNb9lPxQC+jVUKYe0ROmdr8dttaA6knJwP0EzBB/VIUebEnqtoMYErolEalBaphw2DwQzwK6YwRuhNTnmQGqQ+zp5m9aYtN1Td+CrxJ3nbcTHSmeo3S788slfFb4MKsvmKb0W+hAnmG/EHehVj7BUwl9wG4K3WlD8iFNmzbmUNk+w/6IyMXALNrorq1aO51HGRlLo0juWISd82qLi5QpnUb0kayo2KuyEZANZN0kbKIjp9Bi0UBKflcBkse7LMV9SrydTj+odjk9YWaKt43LKdr5e7RRUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoW1tfFKvt2EAn5ojFLzMyFkF3qfqsLuMgd0Z9EaJ8o=;
 b=d/9N8BLslnvDjA5yHxoPCAVjd3PLBJZYEBuROjmWDqeJ8+Eb2UEDaq8v9aOEHoEY9iYv7EOgXI2JpZ2ezfmzXZPu5frt2zgrTY6iUhST4dBXXWqxdOmA1kSEQDzPzklLq4GpufygHi1J2kTajNpytFCZWKgKtDLeTvzij0QhNlg513oBWr+SjeCV3iEtBp4gORadg1AAISwPrPxH0e4pdA7URqMcGEJK+1pd2rNcq7SFmbkX4Osn0oLcL39cnnn/g8RZTD6deIioigbpKV8PmGLc39FXnNnhvtDLi8cejaZmtKsch2bcUHqVtFmP3qIDrpKTbsphdC7I4ksC0/ReSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoW1tfFKvt2EAn5ojFLzMyFkF3qfqsLuMgd0Z9EaJ8o=;
 b=Qkogkm/ieB9moUZe0DAlbordaJMNjZ16SU7D5KyJ3uzhxvyELHwmIf8qh5keuBmUeISfSv+/OfuI1fprfGrYuLN8+50WXrSEjcCEdC3wmaWfe5/vn7NtengbX2x9tOzmxw/wqHpkBQxG0jrn/X8U5AHnIAbxcJzjmX5pDoAEYngdypvJEoOHrccGAUo9D1wEPZDDaM3aUwHrAVBr1qIPW17i2RqysU1ixZ0HDZ3EIZ8QG+iY3hqwnURnTIXx6cvgRmIkdAHwManINErOOnV4xGM3rZIDkOzC4LAGQTlPXY7rmTXR1UkT0daDPEsEH0vdukBEVVj1ArM/NxZ3QbAaHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB5209.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:325::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 09:41:32 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 09:41:32 +0000
Message-ID: <2d477c07-9613-4f45-908d-7f707ac0d14d@siemens.com>
Date: Fri, 19 Jan 2024 10:41:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH v2] efibootguard: Update to latest
 debianization
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <2b28ca7e-846f-47f3-bf8d-20e98cbe08b9@siemens.com>
 <b8d7723c-f000-4e59-868d-e72e82a00e84@siemens.com>
 <e00b6e017009e96402ea2f17a4294757b48e958c.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <e00b6e017009e96402ea2f17a4294757b48e958c.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH0PR04CA0103.namprd04.prod.outlook.com
 (2603:10b6:610:75::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB5209:EE_
X-MS-Office365-Filtering-Correlation-Id: d218f459-eb83-4434-b9f7-08dc18d2d1f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	U6wBNSrVoWOZIv59WWBZbOscqBWJhKc1E3WV2LC1M/Yq9DWmYSWhVetANXJgKuk3x9fcHEhhbI1NpT3jw1kttdJtgHDqiO0tWabvfrKGVLUAO8Qs6QjHeoSUen4QgUukmpHuFOX+Rzt8C5xprnGXMS1N+XK7EZspciK/dlPLnigGXKQth958bnY+p/FZYKzjxIJ98yZ7FZOUB+hmCZg/Nx3hZKPlstIh5shGOsx9KBZc4xderEQ8t/IrDr55YYLBmQ+4ty6Tl/yrD7GBtlQukz1JyvsNH30Br/DhuZy/QQ0ditAGJCDEvC4AMiatq1bUlSyLshCVfHo6gaM2RGKeBtgrl3xtNM9L3pAvuzC+v6ul4JJvcxX0a/CF68gzU9xWSZJ7YfEL7WA4fXDUdksie6DZhU6dyM1lYu7NLnHm6qcTDIlEwvPVd5fNzbuWE9z7ZXu6WEy1J+foFaxVN96SzaM61MQULiMGLM/S/B8BeGgg8nTeaey9MdaD4aGfHbumC2unLUz5i/gopoc5ibs9Fvk3A7a7V+0CrxbsT7PUyOOhwwdjcG6P89TnGy6p0Cx2WMXNll4OqnlZHb3+9ZuzWc8QCDMItRoJ6yqXXAlvneYKApn/WGLK29funItQWrb5/EZLqtlybM5IDkE2FZY8lg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6506007)(107886003)(2616005)(53546011)(6512007)(83380400001)(5660300002)(2906002)(15650500001)(44832011)(41300700001)(478600001)(6486002)(8676002)(966005)(110136005)(8936002)(4326008)(66946007)(66476007)(66556008)(316002)(36756003)(82960400001)(31696002)(86362001)(38100700002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dNBU5rQ/PDl8GjH1+5tM5NUZZwL9iYtdjP+ZUG+nDZEuDJ4LfVQSF8vU7biH?=
 =?us-ascii?Q?uMwipG+DWxvAzkiXl48b6neOOcimY8/ihJlYzmOQxpLoEd9L4LNNuhq8j4aM?=
 =?us-ascii?Q?zsKaFmQSytFGehYXLCPE/H2NW7j0SsmiFaJMuMF84jXQpGl/OzsVYJ5nUJh/?=
 =?us-ascii?Q?NQKN9AZBPPgq+vc9+ob9GP6ZnYzWV7slBUsKGUeIY5ENQnsdkXuVNlJ88f97?=
 =?us-ascii?Q?xaIyKkEkgHlMqLd3l4ZWlN7r+SATl+LwXvk+hNt4M8zgMLsFMR3Gd3yzFKtO?=
 =?us-ascii?Q?Rqt9EIBvgP1lfU3tNf993fYugHHhwJTlD/rlQ/zrS9OfdJy3mzA1xPXZF6XV?=
 =?us-ascii?Q?Kwjmq2Q3mSFYuKkq/CjbsWbX+5lLUbPrVnDw8S6xQgBx/B79f4KEOTQSZdKs?=
 =?us-ascii?Q?Hl5JqMCfdpn0wFyJ8K38tLHhJUAgUgdVVvMmfoBI2CwiBVZJC46laTj8m0Mw?=
 =?us-ascii?Q?ZSgG7egUGQMOFXV/pZm0NmJ18Qdtuq6hKvxDLGau/lOV9eZNCWN/+OG9UUMo?=
 =?us-ascii?Q?/zSfOMgW3QzigW/73g/HQBSd8G9A8zmpeLZiRfgtKor8ivNXa7Flx25RlK4f?=
 =?us-ascii?Q?onScZe6D732KNHRVWNn/I422igBKMJ4RRBekx5MSJ8mFqmSDiHprJp9Ko3TN?=
 =?us-ascii?Q?EJ9r+sNcIP61tSEXTveqZnva0iJII9sZes9V92bHanNQzhZG1/0uDtbAcMKz?=
 =?us-ascii?Q?sURFMT7sKLxA0whAgdBGB7WwPuQZU2A5GezuG+387jSHhzRspeuiZ64u2sh0?=
 =?us-ascii?Q?mNAlUdYJRJMDNkMX+Zn6QtODH9/MhHeZLfUanlM+leJA1L71X+LfkYUA9lzN?=
 =?us-ascii?Q?s1YeQ9qsuTktrcY3b/UNWwOrae3JZNHot2ypN2SvRY7cJXwC1nSfoW+nG6Iz?=
 =?us-ascii?Q?fSfnx4MBacqxXlPv/g0LSEBq+/t7KCN7IJDEUkvuC7zeuUb+TG1Bh4GfwXA5?=
 =?us-ascii?Q?o3owEYd6TYjmgSYEuJBln3sW4mBuBu1egNw4wmHyXZx5PTE+J4/anI5JEiy0?=
 =?us-ascii?Q?LygP7r0iN7e1Eb2zFdCNZ6cJc+OY707Kdrr+3LJj8cFPe6HnXGzaHD19sUh2?=
 =?us-ascii?Q?1JjxDQH/3NvcStEVDphSJGxw7eUrVoXoZ9uy+veW5yjXqaPeU+mNyieZ3t0D?=
 =?us-ascii?Q?rOUuLUP3OP4a0JOToGDNeKm5dIMIKdlLck+tZp1e4nPxVjPk2pPsuWz7n/S+?=
 =?us-ascii?Q?bNOtygpwXL1U9YPdh8pesm63WYTVgofrwLfi/UWjCVshBUF818FU4ZXONr0U?=
 =?us-ascii?Q?+Npl/hAbzNTq5f8af6xXi3DfKm6HcsJasNNXRPsexcMnC4Ir7HVZaNc9RKYC?=
 =?us-ascii?Q?Z31Iic5qk+/WMiCdnsP3e+bkF/iAug7iE1ALZdCdkLHJzabv1IrK5WrdLoUN?=
 =?us-ascii?Q?2M4ApLpV4EdTf8j4Mf9A6rek1oXsh99nnWBvFPbYJ3gXMDqbq3y6bZxchdOv?=
 =?us-ascii?Q?fsFbCdCpMjHc8nAVbi/UKzBEygerDZktHgt1QXOof/pNAKQ0lW44icHe/BFy?=
 =?us-ascii?Q?X6j76EgJl6JJJc4LE5XhMEVtIVadXxx6kuWB/xWabC7IlWPd4Cah7Ybig06I?=
 =?us-ascii?Q?z1sdZVlV7/iZKJgWPrIdioRnVXtR/0KIXhJPOne9H3j2DEBt4wq3HFOXdabi?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d218f459-eb83-4434-b9f7-08dc18d2d1f4
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2024 09:41:32.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEM1qkKXF6iF1jwgHovBM+RddgEOswQC0+kc/8gm4ncmfYbx5VN9UG2/VIIbUaYRWA28BQ2q5ot4xMU4rc1VNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5209
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jan 2024 09:41:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14423

On 19.01.24 09:41, Moessbauer, Felix (T CED OES-DE) wrote:
> On Thu, 2024-01-18 at 21:18 +0100, Jan Kiszka wrote:
>> On 18.01.24 20:50, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This fixes cross-building and allows to use python3-shtab in
>>> bookworm
>>> and newer from Debian directly - at least as long as that version
>>> does
>>> not include the Multi-Arch hint that was recently added and that
>>> also
>>> our own shtab recipe uses. That one, in turn, is incompatible with
>>> the
>>> :native suffix that was now added to efibootguard's dependency. We
>>> therefore also need to switch our shtab debianization to a version
>>> without Multi-Arch yet. What a mess.
>=20
> Why not simply always build shtab from the latest commit on salsa
> (including the Multi-Arch specifier)? Helmut confirmed, that the Multi-

https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/5961907081

Jan

> Arch specifier is indeed correct and the way to move forward [1]. By
> that, once debian updates, we anyways need to update EBG as well and
> remove the :native. Otherwise it becomes FTBFS.
>=20
> [1] https://lists.debian.org/debian-cross/2024/01/msg00012.html
>=20
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> I was considering to hold this back until python3-shtab 1.5.5-4 has
>>> been=20
>>> uploaded by Debian but that would delay our CI testing of riscv64=20
>>> because cross-building python3-shtab for that arch is currently
>>> broken.
>>>
>>> Note, though, that the generated swupdate image will not boot in
>>> qemu
>>> because=C2=A0 the 6.1 kernel (just like other upstream kernels) is
>>> missing=20
>>> https://lore.kernel.org/lkml/42c63cb9-87d0-49db-9af8-95771b186684@sieme=
ns.com/
>>>
>>> =C2=A0...bootguard_0.16-1+cip.bb =3D> efibootguard_0.16-3+cip.bb} | 8
>>> +++++---
>>> =C2=A0...{python3-shtab_1.5.5-4.bb =3D> python3-shtab_1.5.5-3.bb} | 2 +=
-
>>> =C2=A02 files changed, 6 insertions(+), 4 deletions(-)
>>> =C2=A0rename recipes-bsp/efibootguard/{efibootguard_0.16-1+cip.bb =3D>
>>> efibootguard_0.16-3+cip.bb} (89%)
>>> =C2=A0rename recipes-python/shtab/{python3-shtab_1.5.5-4.bb =3D> python=
3-
>>> shtab_1.5.5-3.bb} (91%)
>>>
>>> diff --git a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>>> b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>>> similarity index 89%
>>> rename from recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>>> rename to recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>>> index a7ffb00b..83be2a4d 100644
>>> --- a/recipes-bsp/efibootguard/efibootguard_0.16-1+cip.bb
>>> +++ b/recipes-bsp/efibootguard/efibootguard_0.16-3+cip.bb
>>> @@ -1,7 +1,7 @@
>>> =C2=A0#
>>> =C2=A0# CIP Core, generic profile
>>> =C2=A0#
>>> -# Copyright (c) Siemens AG, 2020-2023
>>> +# Copyright (c) Siemens AG, 2020-2024
>>> =C2=A0#
>>> =C2=A0# Authors:
>>> =C2=A0#=C2=A0 Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> @@ -24,7 +24,7 @@ SRC_URI =3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0
>>> file://debian-patches/0001-d-control-Make-compatible-with-debian-buster=
.patch
>>> =C2=A0\
>>> =C2=A0=C2=A0=C2=A0=C2=A0 "
>>> =C2=A0SRC_URI[tarball.sha256sum] =3D
>>> "d6d37c59aed17489d02b4f0b63db16994dfb8f9f70f54be4d65c366f58c6be9d"
>>> -SRCREV_debian =3D "2e80fafa87f8f6fd093f49ff33ad7cac61592871"
>>> +SRCREV_debian =3D "22b173a3293c976c9dff2ae92085d7ed995f6768"
>>
>> Someone reset history on salsa, for the master branch - tss, tss. So
>> this won't work anymore.
>=20
> This is indeed bad. Maybe we should create a branch for the cip history
> that is stable.
>=20
> Felix
>=20
>>
>> Jan
>>
>>> =C2=A0
>>> =C2=A0PROVIDES =3D "libebgenv-dev libebgenv0 efibootguard"
>>> =C2=A0
>>> @@ -34,7 +34,9 @@ PATCHTOOL =3D "git"
>>> =C2=A0
>>> =C2=A0inherit dpkg
>>> =C2=A0
>>> -DEPENDS =3D "python3-shtab"
>>> +DEPENDS:buster =3D "python3-shtab"
>>> +DEPENDS:bullseye =3D "python3-shtab"
>>> +
>>> =C2=A0# needed for buster, bullseye could use compat >=3D 13
>>> =C2=A0python() {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 arch =3D d.getVar('DISTRO_ARCH')
>>> diff --git a/recipes-python/shtab/python3-shtab_1.5.5-4.bb
>>> b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>>> similarity index 91%
>>> rename from recipes-python/shtab/python3-shtab_1.5.5-4.bb
>>> rename to recipes-python/shtab/python3-shtab_1.5.5-3.bb
>>> index 7a5cfd2d..f20cdcf7 100644
>>> --- a/recipes-python/shtab/python3-shtab_1.5.5-4.bb
>>> +++ b/recipes-python/shtab/python3-shtab_1.5.5-3.bb
>>> @@ -19,7 +19,7 @@ SRC_URI +=3D " \
>>> =C2=A0SRC_URI:append:buster =3D " \
>>> =C2=A0=C2=A0=C2=A0=C2=A0 file://0001-Lower-requirements-on-setuptools.p=
atch"
>>> =C2=A0
>>> -SRCREV =3D"8db4615b2c3ee0a9332b6030687e1179fcfc8670"
>>> +SRCREV =3D"3cdca7c8f4ead23c194c4e8a84e2631989e26b3c"
>>> =C2=A0
>>> =C2=A0# We don't have pristine-tar in this tree hence use this option
>>> =C2=A0GBP_EXTRA_OPTIONS =3D "--git-no-pristine-tar"
>>
>=20

--=20
Siemens AG, Technology
Linux Expert Center


