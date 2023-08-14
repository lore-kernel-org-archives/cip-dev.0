Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24876C04E69
	for <webhook@archiver.kernel.org>; Mon, 14 Aug 2023 11:52:03 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.68])
 by mx.groups.io with SMTP id smtpd.web10.105705.1692013915629481979
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Aug 2023 04:51:56 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=hnxhKJwi;
 spf=pass (domain: siemens.com, ip: 40.107.22.68, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtWvkfoyVGqTkH721kkSIFsK3ICzCNCzZVbAFmInqhpsRZUgQMkfM114n0ZI1JRGY3zvrag4lORTAr7/zgYQ1OBLpdy/sYJl9ayOJJbMld8AYLUKM7sja5sN7VrCBSdUO8NaB32dmFDHPMAy5MnMtHxUTKrms7iSC1mVTrKSMt5xULEqi4XfG2kEqE1XHQ0Ngsl9P6SitPr2/t3BIVkRlvl7bHUwcTsXkYHa7Ib3ZDGEFqWMvtSmDJ2XzpoRlT5i4jQAf61PxgaErtyYu0PJpVXiE8vdUvaDDhhmJimxZp3gWYcb+6i00ujAHVRv334EuAcwXQhIXTpBoAMIPMzOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1jnXTP0qlXnMLMah19crkz+iFq9zaouAOF92FCGSmo=;
 b=MdFftbNM8mAcWxGyzYi31CN56AR2Ygi2KmnBX8a9LSbWzgHR/TqOZAsx4Pb4zGvOGCQhTKPc307oz0a9LUumcXYa6PIFR9v8xKVQEFUrJ4e/CXuVptZoFwb8oG9kfcFN2u5hGiC9/7o5AyzVZjYReeHSaJI1r4ug327oK6NPT29FBDsQLh57xwLqlMvNGazo2i1yls8XcXDL8T4BB/vUMc5Ntu6IqPbbIkzm0RvzmCpD4H+/RGVUpG75TM5XxYkGH6WjMJTtFYwPYDeErBLnPd7OZW1XXSHyva6GEuw6WYpP1WlS8/l2RipR1XRQmhcOeTiYK32WucnkjpGvQ9tTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1jnXTP0qlXnMLMah19crkz+iFq9zaouAOF92FCGSmo=;
 b=hnxhKJwiyywXduqgEJRuZ77RlfMpGOeCChKZgbq0MbFau1VoCyowZL8PEn861Wh6GuSeMBp66nnRMslddZqilZUj0SLlpigdbo17anOhlLfmS9Z52e34VAcRYv1wpvcP0Ied4CxymwLwvzwiegbW1dyhHhV6ECMiKPn1F7VK2r5Ly+V/Et47my6SaYU0Zj8R0L175L59sd35Um/QZYsvhdOYRV1RIfZ5XgDG5fZiMSG1bK1esvxKIbvhEcyc+wIM4RyqLImABYu0ub2VyGzfMDHdcp50N/FNRzN6TFpok0kFxzsJjUKGgoCMRnLpVhTm+mXwMWqMctJEfPOEE+zPRw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by PAWPR10MB6878.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:33b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Mon, 14 Aug
 2023 11:51:52 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::90a8:2018:8363:8691%7]) with mapi id 15.20.6678.022; Mon, 14 Aug 2023
 11:51:52 +0000
Message-ID: <002682c4-d856-69bf-de30-9ce7fc85231b@siemens.com>
Date: Mon, 14 Aug 2023 13:51:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [cip-dev] [isar-cip-core][PATCH 3/4] initramfs-crypt-hook: Avoid
 calling of tiny mke2fs from busybox
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Koch, Stefan (DI PA DCP R&D 3)" <stefan-koch@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Sudler, Simon (DI PA DCP TI)" <simon.sudler@siemens.com>,
 "Storm, Christian (T CED SES-DE)" <christian.storm@siemens.com>,
 "Adler, Michael (T CED SES-DE)" <michael.adler@siemens.com>
References: <20230728143320.3891194-1-stefan-koch@siemens.com>
 <20230728143320.3891194-4-stefan-koch@siemens.com>
 <15101ae1-62b7-47fd-808d-501433da81f1@siemens.com>
 <a49cdd53-e2b9-52c3-ac40-b11264952b28@siemens.com>
 <e27c652d-f203-483f-bc7b-1b994f3d4e7c@siemens.com>
 <9443dd8ff4eb0bb72c28c99f62d71c341d6f958a.camel@siemens.com>
 <6ec810bf-51d6-4ede-9c31-027e8da203f4@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <6ec810bf-51d6-4ede-9c31-027e8da203f4@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::12) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|PAWPR10MB6878:EE_
X-MS-Office365-Filtering-Correlation-Id: a83861cd-aa70-462e-d83e-08db9cbcd962
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ii+RtIM2VW5FJYZ9c+UIxreCKPg3XYD/p5llXxHiCrOxHTrXfJIMocT5iMZ4RgUbWytD8ZbqEVHiFY3D/2rrF8G+e+ACZyePuVwy/YhYRB4yhl8HAYgxs1nqaHY+rfpR40ZANNn6fWFDFArZj0xSZgLrmK2zfg+UibyZig/YAXutKLYMlX9CocvoN0jkKSF64X/NiVheQ+GQPWkvPCuSbP5QOWwPYHQ5ZqbeFO0kAth7PK2z09rg9PTYxxhclcuw/Pre9ArCTDMav4Ok+DSwAiLR2HP8Q56UtJVy+V/c/XgRX1+45inyYItv6p1ZawHOP8gyJ1LgFCl9APoIA1h4xjTVELrDRbdsLY7hLNsafcUUdThoKEcVxLbXM/DsWFPS+oc+xHKS7bAy4exhmxA47zzwzM6870LXHHUv0Jq8mXN3LyCxoJVL5M6BZ/JWU8upkzNkWdEvaixR5XM32pEtKNH5ObhGzLijtZV6HIbb+KI/GeMVzVZVU/bZJnypuj5kpY/6qMeDPe7ZOhBTLT11hDHeabisdeVrmmyiwbdVRxdGIpjO+p2zM2QKDl6MlBEjiHP4zCtYibyf4v2HZ5qBf+4vWhRdT1x3AU8f0A2tjvfB+PmKcib71CF7+LEVfvnhU399gY/Es2cFF6xaFGMyCw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(346002)(39860400002)(136003)(186006)(451199021)(1800799006)(4326008)(8936002)(6512007)(86362001)(478600001)(6506007)(6486002)(316002)(8676002)(66946007)(54906003)(110136005)(41300700001)(66556008)(66476007)(53546011)(5660300002)(26005)(2616005)(31686004)(31696002)(36756003)(107886003)(83380400001)(2906002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?SHVM+Pbv7kvh6C55atIO98oim2C4ZiN8qYIQjiZ4iTSb3WTzsgyPCviV76ey?=
 =?us-ascii?Q?hN/e9YKgIQ/rKh37HajFcHN3NupNPgE+NZx+SCofTlzEHmHHuDhreZxNwHXJ?=
 =?us-ascii?Q?aBeQwupESnLXuXjw8G79JS5AF52o/9JXzlENDzsEFoZ7Tqcv2wwLKPFHp+VZ?=
 =?us-ascii?Q?PkwaopS4y24/KqnXBjhALYDvg/R0e4Vf5wsRvzMFHGVKBNZxzehDYp5wOoVM?=
 =?us-ascii?Q?QXNauaskLD51illGbVptDK0m7weVeiO/P02pwdmBIchhihMLq0U1tB8gQPYg?=
 =?us-ascii?Q?ShMECakhgAbN2rmR7cWCXQZQDmxKcfPFk89UhyziP9Ir4VCl5AqXOjdITCAk?=
 =?us-ascii?Q?AWYYWiJ0+iKKQ8SY9ZVK3c2yaZdAiU8pjaaZ2OFhRurPhQ27KXJpdq/PJ9CF?=
 =?us-ascii?Q?R9SXLwFeFB0eWR+24MUppt08LE9MhBdlFX5twCosAteecbFnbynoRSZr/Czt?=
 =?us-ascii?Q?ocpidCICB/+OINaon0YAxB7yKsHYCN7aVoTOt/Y/SEjsfLF/7jOAcRLifH4f?=
 =?us-ascii?Q?lEbJ62stV3LuZboPQ7v/uNPkCW9V3kaqLyelSnMtBx2bW9eJIBNuHuytjmvI?=
 =?us-ascii?Q?4uTAdCcHWcArC05EmnaA7LrqO6ZcBG/EdZEtEDfWJ8kXgEJ+8lWySSSXSfaZ?=
 =?us-ascii?Q?TDUU/L0BL6Nl4buhYicnGxF0Qwwd8fGpmupi3Wsnizs+vELcKUTjVRKajPNT?=
 =?us-ascii?Q?qojMAItO3eN2pMb74sdPNB6kAbeC5hzzJSV3PnH7AprI5tm+qR3zMqvd87dc?=
 =?us-ascii?Q?Mmnaegl5K6crBn3L5fA+J9LaS3wfnyDmJKqE5+jZPgy0aoS4qqiYs2HGwQEI?=
 =?us-ascii?Q?WPDjuxz6J164n5/9s6AfKVM6mPY23uMHTa2ZG6bXGNtYXqRZtHUL03cyDobt?=
 =?us-ascii?Q?j8ou9jAfFW95tocaajf9/2JyhUV+3t8GtRejy+s25KLHqKE9UZLeRWl8CNMe?=
 =?us-ascii?Q?qK3hGw4UYShj/hXWw4ERFxOx8tEqOY8b1J2um2fkzr8ThCeh+gp0IvSY9Psl?=
 =?us-ascii?Q?jExwE+AhJSwndlKicQaqt/VIB6BLnUHY2uzkdK83VvPWNyONbRVBHEYmYPhx?=
 =?us-ascii?Q?w495QRxhxQ7pv73R7LoBjd5juzMq21+pVCDhi42DYrt6xvyBa2/epKhwqMAP?=
 =?us-ascii?Q?3HRTu0YMrz0/KCVgV54AJFIpa7teZuDfz19GKcwa2FWXu60kGar9Yks5MUem?=
 =?us-ascii?Q?JIz+lZ/IG8rhYEXXaqxthdsfyX/4pIEZOPsQgveY8NofwdwKF39i1evp+L+T?=
 =?us-ascii?Q?HBrEvczHvtbncBMNeDTq34yF6fjE+PXjW29GSmweCYZx5j/VL52UZmd9cCc0?=
 =?us-ascii?Q?pxePNFyqMZCEaofr/hoGCx8NDhcNQt4gQOruxtwzPkllIt+IofK2QmB098jO?=
 =?us-ascii?Q?17yhdhe7kpjT+uH/ahywEwXN1+jvNudf4/+e4BKiThG4Zie4AmcHb4kHGhgO?=
 =?us-ascii?Q?HAkTj9WQ1y5QdTOWI8VGka6VD8mD4AA4FnmfwcBfnqnCm0tHBQH8IRdPIe+7?=
 =?us-ascii?Q?x/nZqxUmWsV3H9kzjcaZGt/ufj4yX1CyANaT9NNWc+mKiPIO/RNI1Z2P74Qx?=
 =?us-ascii?Q?5SBKuMvO+VKHCQ3IJ6n17vHhPWoM/jXBK0Er320Y6tw8eAC6s+/98jnagNNi?=
 =?us-ascii?Q?mw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83861cd-aa70-462e-d83e-08db9cbcd962
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 11:51:51.9158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wuja4NwNaJGeqgCVChKDWlxOsOHwQJjhpUFLDoa93xdn+wkrV/mSlJFPSeZ66LA6pQ8hph3zDAL3YsbJJ3YPzImcpQiGnewkcbnCI227BEo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB6878
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Aug 2023 11:52:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12645



On 8/14/23 13:43, Jan Kiszka wrote:
> On 14.08.23 13:25, Koch, Stefan (DI PA DCP R&D 3) wrote:
>> On Fri, 2023-08-11 at 14:53 +0200, Jan Kiszka wrote:
>>> On 10.08.23 13:17, Gylstorff Quirin wrote:
>>>>
>>>>
>>>> On 8/10/23 12:36, Jan Kiszka via lists.cip-project.org wrote:
>>>>> On 28.07.23 16:33, Koch, Stefan (DI PA DCP R&D 3) wrote:
>>>>>> The tiny mke2fs does not support the used -t option.
>>>>>>
>>>>>> Signed-off-by: Stefan Koch <stefan-koch@siemens.com>
>>>>>> ---
>>>>>>  =C2=A0 .../initramfs-crypt-
>>>>>> hook/files/encrypt_partition.systemd.script | 2 +-
>>>>>>  =C2=A0 .../initramfs-crypt-hook/initramfs-crypt-
>>>>>> hook_0.1.bb=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 2 +-
>>>>>>  =C2=A0 2 files changed, 2 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git
>>>>>> a/recipes-initramfs/initramfs-crypt-
>>>>>> hook/files/encrypt_partition.systemd.script b/recipes-
>>>>>> initramfs/initramfs-crypt-
>>>>>> hook/files/encrypt_partition.systemd.script
>>>>>> index b32b2f2..4e04d37 100644
>>>>>> ---
>>>>>> a/recipes-initramfs/initramfs-crypt-
>>>>>> hook/files/encrypt_partition.systemd.script
>>>>>> +++
>>>>>> b/recipes-initramfs/initramfs-crypt-
>>>>>> hook/files/encrypt_partition.systemd.script
>>>>>> @@ -42,7 +42,7 @@ partition_sets=3D"$PARTITIONS"
>>>>>>  =C2=A0 create_file_system_cmd=3D"$CREATE_FILE_SYSTEM_CMD"
>>>>>>  =C2=A0 =C2=A0 if [ -z "${create_file_system_cmd}" ]; then
>>>>>> -=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"mke2fs -t ext4"
>>>>>> +=C2=A0=C2=A0=C2=A0 create_file_system_cmd=3D"/usr/sbin/mke2fs"
>>>
>>> This is not correct.
>>
>> Oops... Params lost :( Then default should be ext2.
>>
>> But the=C2=A0condition
>> 	if [ -z "${create_file_system_cmd}" ]; then
>>
>> is never true, because of "??=3D" in the initramfs-crypt-hook_0.1.bb
>> file:
>> CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>
>>>
>>>>>>  =C2=A0 fi
>>>>>>  =C2=A0 =C2=A0 service_watchdog() {
>>>>>> diff --git
>>>>>> a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>>> hook_0.1.bb
>>>>>> b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>>> hook_0.1.bb
>>>>>> index 1c1bf3d..3c3f6bb 100644
>>>>>> --- a/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>>> hook_0.1.bb
>>>>>> +++ b/recipes-initramfs/initramfs-crypt-hook/initramfs-crypt-
>>>>>> hook_0.1.bb
>>>>>> @@ -32,7 +32,7 @@ SRC_URI +=3D
>>>>>> "file://encrypt_partition.env.tmpl=C2=A0\
>>>>>>  =C2=A0 CRYPT_PARTITIONS ??=3D "home:/home:reencrypt
>>>>>> var:/var:reencrypt"
>>>>>>  =C2=A0 # CRYPT_CREATE_FILE_SYSTEM_CMD contains the shell command to
>>>>>> create
>>>>>> the filesystem
>>>>>>  =C2=A0 # in a newly formatted LUKS Partition
>>>>>> -CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "mke2fs -t ext4"
>>>>>> +CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
>>>>>>  =C2=A0 # Timeout for creating / re-encrypting partitions on first
>>>>>> boot
>>>>>>  =C2=A0 CRYPT_SETUP_TIMEOUT ??=3D "600"
>>>>>>  =C2=A0 # Watchdog to service during the initial setup of the crypto
>>>>>> partitions
>>>>>
>>>>> Do we have both already? Also in case of the isar-cip-core
>>>>> generated
>>>>> images, or only with additional customizations of the initramfs?
>>>>> Just to
>>>>> understand when this issue is currently visible.
>>>>
>>>> cip-core does not include busybox in the initramfs - therefore this
>>>> was
>>>> overlooked.
>>>
>>> Ok, so the path should be adjusted.
>>>
>>> But now I'm wondering why to spots have to be changed. The script
>>> checks
>>> for create_file_system_cmd, means CRYPT_CREATE_FILE_SYSTEM_CMD, being
>>> zero and falls back to the standard creation. But then we have the
>>> standard command also in the recipe. One should go, also to avoid
>>> mistakes like done by this patch.
>>
>> Should we just delete the condition above within
>> encrypt_partition.systemd.script - since the default value is always
>> set? Or are ther cases, that do not use the initramfs-crypt-hook_0.1.bb
>> and bring in own customizations that might fail after dropping it?
>>
>=20
> I'm inclined to delete the script test, given that we have a default via
> the variable. Or what was the idea behind that, Quirin?

The script test can be deleted - It was more or less a fallback during=20
development.

Quirin

