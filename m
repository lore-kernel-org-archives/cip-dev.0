Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03066C05027
	for <webhook@archiver.kernel.org>; Wed,  1 Feb 2023 15:53:03 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.53])
 by mx.groups.io with SMTP id smtpd.web10.26936.1675266779366508820
 for <cip-dev@lists.cip-project.org>;
 Wed, 01 Feb 2023 07:53:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jAtD62nw;
 spf=pass (domain: siemens.com, ip: 40.107.247.53, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aaR5cpB2/rgW8IZIknjzWh+IkBnbdid2FRb9dD+oshSqty6hBK9RRIx7YNL2Zlj8mAQSTmr7mYwsL98IAFzfMrgzYAPolmtHoRueYr7sqB3m7Hk/5KrSG4eqV2wYMLYxVIIy3K/ZPI1HNAlkttWgC+0+KPuwJhbijmNtK0QVFG1yXkPCqjdmhS+QBv0SVUrUJY2y3H2dMQNCSuF4fCgHpTR2G11Q06ONVmxpyH3ZesJZZRb2DgNTE1QpMatBsj9U+49bHLdlw+Auwuq7uf3Ir60Jn0Ue2NJYcN1AMIJIA8uwDpl+b7P0qQIjg66FPpmV9XQrELEU4t6hDuVSZ1Dqig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q0DoKG9857jv0k1Bg6PZXjAl7Uef+oAxe/kqxh8yioc=;
 b=caciNQ0tUTwpIvqzDFst0t5w33rtaM0UvU53ULiISZNJSTU4wupCG/dSkaDFaVDQeyC6NUX2fUjpSekBb+osBZEXye4vAFhZJPVUUV8SAnyjAz2ztbWPNGT6jKCv9cU7CFpVXHZ6jJ1WkvS21zRJheQmyPgTfPrG8iTQn4yVAoc4bEaFloppUw5lOlY0MEWl44VIflguJ5wte5UefckenEeqUFrGxm3LtmOa5fDmNyG6aMtFfd97Jg76rig+sWqJ8hgPnJyOGgRJ4zUmC9BTwclUz9v4TGSMVkkQPnMFr9HSFW2lXNER8OImc8F5qsQHBx3oqoStr5kcSUton9XXQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q0DoKG9857jv0k1Bg6PZXjAl7Uef+oAxe/kqxh8yioc=;
 b=jAtD62nwVN7ISu/nmCbFefIK+0soUtBYHAuiGNJvgu73txhSe23ro3rkDI0wUGoDMg3YvGM8prwuzNv1okECEuifNgZa6BH+IGrbAQk0XYer9ezD5qpietxtPUkUb0jIm/ulJsMsBMKJhDj0btzFESncY5B05xNKwoT8nDWfcs0D8p8+czCeXGS5+h4JHpsal1H3pLfAJl8+Qm7X5QjIpFG5uLvAYdph5DNVhnmkF78+dX/BxFpfSIJBaVkFvseNSiLyUnDFfdpkj9TlcVZo9dK80Ei7s7TNH+tKgId6JLe18N5PO5BHzUHkQHVUw2axtYSB6bAtzCBM+7WqYPZQpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7778.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:62f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.33; Wed, 1 Feb
 2023 15:52:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%8]) with mapi id 15.20.6043.030; Wed, 1 Feb 2023
 15:52:56 +0000
Message-ID: <3697a7e4-8f4a-e2e7-81bc-015ef92b8375@siemens.com>
Date: Wed, 1 Feb 2023 16:52:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] Add bookworm
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 Florian Bezdeka <florian.bezdeka@siemens.com>,
 cip-dev@lists.cip-project.org, Chris Paterson <Chris.Paterson2@renesas.com>
References: <20230130113412.628646-1-Quirin.Gylstorff@siemens.com>
 <6fc061ea-a0b6-13f8-e1e8-50840d4c8622@siemens.com>
 <04ad45dd7d2d86046a77e4dfec13e4283a7622bb.camel@siemens.com>
 <82d96ec3-9381-bbad-d0b6-244a2610ce8c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <82d96ec3-9381-bbad-d0b6-244a2610ce8c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: ca16b2c9-b984-42fb-1e35-08db046c62b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	BGIaJTHg0z3tfN87pNK/O+0I3MiLmLYch/VdXUsmW1NvmXzTRpfq4si70P3BActcttwHwefyMClkyS8F3ByroSRrzcpXxnO5PF8z6lNpHxsnsldYRdOobhhlsGljoldlNH8ljjGhBYJdaIQuGH7OP6V8sVgS+Yp7z6Q0YrjNKETjWXqn9pE8fnalptPAwD/IzL3RPAFarvc4sClNRBY5+1mm4YWqzeqZDMJ7nJuRLuqtnxmBsC8pQMOQtr+v7rry0sAbz9IFfAeyNI6O5axBY3O5EYatMisavTgutNyge0a0Y0KngH2nkMnmzn/4ec5hsm/hGBI/3d0nKDpLzVncBT7EtRP5p/VFw848odgNie/ABI1OcgL/Od9NwV0UwQJbs9vxzuV/ry/k22f1xzFUdq6YYn1Ztf/EkMvSzavh9yRro3Y/2fEqY1A6fpFNX7T49tkfKAFdBpQJz6aQG2a0yBmlKX7udcSE8UM2vcuWulZA04zPVIL5H9WeBJfAAqGSDAPu/2qg7PMU+aiK97vh+B6Hjz6YOzgFttr96LVfqZZOsioQVBVg0eRRGcQLCtaMKYHm6hvvgZ8Vtww6d5e6Ooee+DySFWob2AwhNv3ou8EhAKYSSF6keuArjMxzRPeMYjrEf+gviv2E2tWKkn6RNJEEC7oAJeshuiuGGv29ttMBSduCVILNXEL1PdTxb3bcS4TViTlvVJzeQ4zDDa9EgK0XGaS+DYQQLRnPw2kvZzI=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(136003)(376002)(39860400002)(346002)(366004)(451199018)(31686004)(6506007)(36756003)(44832011)(6512007)(82960400001)(2616005)(38100700002)(186003)(26005)(5660300002)(2906002)(316002)(478600001)(6486002)(66899018)(53546011)(8676002)(31696002)(86362001)(66946007)(83380400001)(66476007)(66556008)(41300700001)(110136005)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Y3le2CLLFaf4R26Li1oVxqxupokfrZ7z8dlEt11DiortmgPtwKEBXn81LnWc?=
 =?us-ascii?Q?6PkRX4FQ6+KOODW1rD3dYMSTRMqwCwMqfDTA/KOXXPyk+Q0F3aYtHV+T0nkV?=
 =?us-ascii?Q?IiuAb7/OmeAI45K0TaDz5+6UpjghE1gBR0nLBRY2XOPLNAZzVZK4TyGqsGy1?=
 =?us-ascii?Q?xQNvIcIC7N05QHTZOPhQv845Zy3FCphdRpb80l2+5IXAEao4f6ZyL39SocWC?=
 =?us-ascii?Q?MTV6V1myVfv6yTjwpOPssu54P6/3zd1beK/nzrCRmL/uEyrA2nrlozILob3/?=
 =?us-ascii?Q?n2CLk1H40FWP4Qu/l9M/EInfbZM37N7dIY9/CHVttqJcUYKB9WLzhlbxIvnH?=
 =?us-ascii?Q?qKfICn1oc2UTiKz/HoK1okaTm2D88U1mUekrk/q8zSW+FGGpJOU7FFcWPbU9?=
 =?us-ascii?Q?vOxMhxjAvvnENMdZN/bnBxQJT76HWppPpVOI05ch4Q3acwX2pksWl8MEK0/t?=
 =?us-ascii?Q?Bm3K9bFpgFF3L0n5HvYWYLC+kO231Ubf5K+aCbL35CFVxbN4vaZHe75KnYgJ?=
 =?us-ascii?Q?suw1mc+CY0Mjrn+9NesOP80hBCYdNOPME5qQQyQ6azjHnBE6Rj/BQmcLV/pq?=
 =?us-ascii?Q?myDFcXw193ReoPUcDZbwxR2wlBMFMQGe5xtRFMTsMuJCVDiKexTVBxz+RlPO?=
 =?us-ascii?Q?9qpe0Kty6n4LNg1RP0A/YCbJfW4Ka8r36gZRR/QDkYgrn9pilJgLB4OgB8pA?=
 =?us-ascii?Q?ZhNG8m0iL5wkl3+8/fYM6Wj+IvHs2joGJsyEvbuBy89IE+cUp4ApdqYlUTbv?=
 =?us-ascii?Q?71Xnv59Q32sPtuON1qAW53ICPAIEwMpTAh3MTM6a+DmTzrC3MbfeHTekiDOP?=
 =?us-ascii?Q?AT7De0sj/M05B5HZciZBCCTeRlMfcVN9n7nU2o/y3ZKi/pZTV8g3iyyWaB6B?=
 =?us-ascii?Q?QSZaMCyg9lYj7VAoOA8q8gv9CcIMsTZZAbJ8qzy2K0x1zZZBcBC5qG6dtEek?=
 =?us-ascii?Q?ndvxHe1WHeA1zyic4LMh1mZRf/uHb9VaxB7CYNYuv9z5cxj0BzJy4GkPm4DM?=
 =?us-ascii?Q?p1xsPRbVSl5F4tll2bguan7mKvgc/UNQYfUrypBWXd+2N4gS8BlJ0fJj3Zqe?=
 =?us-ascii?Q?Gno5PO/LaYeea/+wJP/Y+iXo30ESsjPKo86sthSWuY0ZDUADs0OCvDYLdGkz?=
 =?us-ascii?Q?Y1eTiKIzofkIwsqT156a1r644Oh0sJmfL6hnNefgyXd6jWngfz3dKhOXANUH?=
 =?us-ascii?Q?a0iSXqZH3nhCIkGYOe0vr8TKnKK5rNo9o0LnvrfAM4XV5795UidG1y+AA6W1?=
 =?us-ascii?Q?ABnwNXedmN5wHjIl4DNCJstgKcU/9qLtMgcC0xdPe7fKGqD/pbUgtUCUVrft?=
 =?us-ascii?Q?Y8oOZo7LbdmS3A1JZTL69exVIGA94otFC9d1ILPDNe2usSjFosv8gRy9TSPr?=
 =?us-ascii?Q?V3omqk3sjhj8912/YrJvxl06rs+xnNgEA47/hjNInFmVxieTN9PqS6XiDhXp?=
 =?us-ascii?Q?1hQ399kM16wo0YYpyRasT/NieMrl93s/RzsoWEUdD3LAQU4+Vf2ASrFDpSZo?=
 =?us-ascii?Q?AX/u1lQ2a1Yuv/LzG6S8RnNS5bYgNO1D6ZzHLEUbhaxOmqBKq3OGS4UEoA8r?=
 =?us-ascii?Q?ri0fyJDyqpx1DoXGoJeP3Dvbt3CEh6nyWDXTiUs+2otoahNnb4F/DIRyyGXL?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca16b2c9-b984-42fb-1e35-08db046c62b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 15:52:56.3232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ea0JP4JTGDP8hDZ/7v0mrSW9Lub7Xu2yhUxXvOgm0gOAB043Kn0Lb1NNUoUkNnvOyZXgePwn3dko+H/Pn7Qn2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7778
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 01 Feb 2023 15:53:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10562

On 01.02.23 16:36, Gylstorff Quirin wrote:
>=20
>=20
> On 1/31/23 13:20, Florian Bezdeka wrote:
>> On Tue, 2023-01-31 at 11:54 +0100, Jan Kiszka via lists.cip-project.org
>> wrote:
>>> On 30.01.23 12:34, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This will add prelimitary support for the debian 12 aka bookworm.
>>
>> I was triggered by the subject of this patch. Why do we re-add the
>> bookworm distribution when it's already available in Isar itself?
>>
>> Maybe rephrase to something like "enable tests for bookworm" or "enable
>> building images based on bookworm"?
>>
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0 .gitlab-ci.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 45
>>>> ++++++++++++++++++++++++++++
>>>> =C2=A0 Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ++++
>>>> =C2=A0 conf/distro/cip-core-bookworm.conf=C2=A0=C2=A0 | 17 +++++++++++
>>>> =C2=A0 kas/opt/bookworm.yml=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 15 ++++++++++
>>>> =C2=A0 recipes-core/images/efibootguard.inc |=C2=A0 6 ++--
>>>> =C2=A0 recipes-core/images/swupdate.inc=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0 6 +++-
>>>> =C2=A0 6 files changed, 91 insertions(+), 3 deletions(-)
>>>> =C2=A0 create mode 100644 conf/distro/cip-core-bookworm.conf
>>>> =C2=A0 create mode 100644 kas/opt/bookworm.yml
>>>>
>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>> index f7c8c88..2b9505d 100644
>>>> --- a/.gitlab-ci.yml
>>>> +++ b/.gitlab-ci.yml
>>>> @@ -37,6 +37,7 @@ default:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${targz}" =3D "enable" ]; then
>>>> base_yaml=3D"${base_yaml}:kas/opt/targz-img.yml"; fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "buster" ]; the=
n
>>>> base_yaml=3D"${base_yaml}:kas/opt/buster.yml"; fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bullseye" ]; t=
hen
>>>> base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>>>> +=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bookworm" ]; then
>>>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - echo "Building ${base_yaml}"
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - kas build ${base_yaml}
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${deploy}" =3D "enable" ]; then
>>>> scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb}
>>>> ${CI_COMMIT_REF_SLUG}; fi
>>>> @@ -281,3 +282,47 @@ build:qemu-amd64-secure-boot-buster:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_rt: disable
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy: disable
>>>> +
>>>> +# bookworm images
>>>> +build:simatic-ipc227e-bookworm:
>>>> +=C2=A0 extends:
>>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>>> +=C2=A0 variables:
>>>> +=C2=A0=C2=A0=C2=A0 target: simatic-ipc227e
>>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>>> +
>>>> +build:bbb-bookworm:
>>>> +=C2=A0 extends:
>>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>>> +=C2=A0 variables:
>>>> +=C2=A0=C2=A0=C2=A0 target: bbb
>>>> +=C2=A0=C2=A0=C2=A0 dtb: am335x-boneblack.dtb
>>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>>> +
>>>> +build:iwg20m-bookworm:
>>>> +=C2=A0 extends:
>>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>>> +=C2=A0 variables:
>>>> +=C2=A0=C2=A0=C2=A0 target: iwg20m
>>>> +=C2=A0=C2=A0=C2=A0 dtb: r8a7743-iwg20d-q7-dbcm-ca.dtb
>>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>>>> +
>>>> +build:hihope-rzg2m-bookworm:
>>>> +=C2=A0 extends:
>>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>>> +=C2=A0 variables:
>>>> +=C2=A0=C2=A0=C2=A0 target: hihope-rzg2m
>>>> +=C2=A0=C2=A0=C2=A0 dtb: r8a774a1-hihope-rzg2m-ex.dtb
>>>> +=C2=A0=C2=A0=C2=A0 release: bookworm
>=20
> Hihope is not building in bookworm as the package
> firmware-ti-connectivity is only in bullseye currently available.
>=20

Huh? Where did nonfree firmware go? There is some transition after the
GR, but now it looks like there is no firmware at all?

> I will remove it in v2.
>=20
> Quirin

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


