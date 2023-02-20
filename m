Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD960C05027
	for <webhook@archiver.kernel.org>; Mon, 20 Feb 2023 08:26:38 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.49])
 by mx.groups.io with SMTP id smtpd.web10.8342.1676881592841226286
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Feb 2023 00:26:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fGmokLWa;
 spf=pass (domain: siemens.com, ip: 40.107.14.49, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NbH2bYh98UBB/pwAYYKnAoKpTqYxClr89feAwhaIJl9+xGGMqW9sTs58D6qRmBf+l/GbupNaG9QHe2frOhpBIFYL3gvMDaUqBxWWIyrfIXo0z1jk+9ULX0w4e+HMfYEQ6w/6An54xzu2y3stzZd0pqWkplstV/aSxQ7BpUPzqhX3jhM0YGFyXVkI0wvkT96PdhQhtgMnqaTGPUR4Oj8URGfppmGvRLN3oQ/XYnl3R/W6xvnEZj6Ud8ErOh9IXRDeiP2JX01MrKNSrI/ikmCD+fh7LDEYD85xx9jLAqQHIP9KaxQQ5jrwxMR4TAMHpspqGZwBwRtEEv61pnlu2/hI2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=McuYgvItIjrLrGdiVw9k3NCasVOHrqQ2Bq787gNkiV8=;
 b=Z53LhRW84VsBFVreiEnQtB85uKtLTu/XL1KAr4+uTm5881V9jEblBH9RxuEwQMPzvn7u+9Rh3JtixrGsJFkg5htE9hI31z9s8M6Rzy4G33WA1LhQEkTcMO80FSRLQ3BA9EUyS2fmHKK8dO1qmbQR6BFeCrIglYwf0wOZPTSclQeY8gdeoWZnLeJY2lDwNbtEtqrBhmF2+om2zz/nIIryVBcwYdTd7Ytde+d/PMcBfYAW5MF4jZ7EQGTr5bTS/id/TwePpZbd/EVhizDbsseialqF8X7BdklXsmnU41oeZO+gaWNrNhmD9v0pjyzK62iAAToNy6U86z5XyLQcVYQ8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=McuYgvItIjrLrGdiVw9k3NCasVOHrqQ2Bq787gNkiV8=;
 b=fGmokLWaONOQENmACIDDU66GX9eEg08R3ze+KSozgXkPnZM/QN2AcILixYT2F5SX4/nuJjvd25qivB7V2/gXZPsjur8+DheUfTy+yLLuXRb+8VDgttULisGkC7D1nG/1XGCYSaNSFbHqw+brQlocu7mZ6lOQO9b7grHkrb4sQ3OOA+wZHb/TE9YZzQgXZVM6kE8zPTd/HFj3YB2nofq3zRCjJP0ZA/Le8jpbCOF4OhxRreLousN89WGKJnK54nteRE6CO8qgoV3n9yV1qzeKULOhK5QcDgPxneGsb2iPBLKjigh4CLBd8QpkR/zSWWNl5rK3Lhww4St1JuW8+KtACQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by GV1PR10MB6051.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Mon, 20 Feb
 2023 08:26:29 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e22:9724:665f:8d94%6]) with mapi id 15.20.6111.020; Mon, 20 Feb 2023
 08:26:29 +0000
Message-ID: <1f2e1612-d43d-06aa-8165-2e00daac3d4e@siemens.com>
Date: Mon, 20 Feb 2023 09:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
Content-Language: en-US, de-DE
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev@lists.cip-project.org
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
 <86fa2631-b3d2-a667-2aee-a23f1f8f92d0@siemens.com>
 <4dc52776-be5a-00ef-a7d2-6a7522f8df7c@siemens.com>
 <0629fe35-2060-495b-cac5-71f259306d4b@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
In-Reply-To: <0629fe35-2060-495b-cac5-71f259306d4b@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::9) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|GV1PR10MB6051:EE_
X-MS-Office365-Filtering-Correlation-Id: 541747fc-ffe1-4e04-c0ae-08db131c2a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DYpXMHW2mUIwjYvZPCs/x+m+MZ7yi5SH9kFDTAqLHPIl5Z2emkSdHU/T8CtufvnP0gKIUwtIuD6MUKOCJeShYkyjXjtRV/IiIuf2JCCp9c/ui4fALj7iq1Rn2kCzjYA/IWKR8xqIOezrPgcGYf/PpuQsKx44zF7F3HRLfbknh3DCywG1a3+2C0BObaoLwVKc72BtMH2s8DXqVKVVAkGKRyFw0DOSBp1wfXLnwHynGue8x2DlwbuaJtlqJZ87UOhFfIUgiERODA7sBdwJ3P1D/KscZDdRpw8j/OxzEDK2+WrmAvFrFXh4d8+HDvAhhk6SWGL+ayTSHcg7GaoRAQixIeVdEXgmRwHLHxk0q1//TLlyc0U2+zrLItCLp4XWvRTHePTaeWVuV9XpxRXRwRhuz8a6TMht+DEbQrtZqJ+wCJ/GMlDxcAj3dz2d0OKcWXTa4Lbg6DM4At9QSSNi0wwDMC8cNn2RkSt8LuJtl8TYDc8o1HJ1H9scI3ZEd2uf3DQgjMCsvqs2Po7xawxYZdxuaczcDz2zWRV5O12vT+VgSBqynUoWQGVC3FE7MXokOG0MSYgeHfNGQoYtcNl0C2k1nMRAfYC+pyrGcjKvod04SD9+mtxnYKo8tYXSWWVDG3HBTfdb54ldx+iL1XQnPRg3zJPbx5aYDpaG7BQ6xaMzootqgU7ho2j0wtuLug7KzvNXOxEsLHQu8jBhC5DNXQKxuFIIc8k5g0RXkMfuh/UUw2s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(136003)(366004)(39860400002)(346002)(451199018)(8676002)(66476007)(66556008)(316002)(66946007)(6486002)(8936002)(41300700001)(5660300002)(31696002)(86362001)(36756003)(478600001)(6506007)(38100700002)(6512007)(6666004)(186003)(26005)(53546011)(31686004)(2616005)(82960400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sv3WAlxgtA+6YIn7u4vu9gRJku7X4rehOBt3qoBVmPCgc3cDdnvGJwQ5VhXe?=
 =?us-ascii?Q?TajwbNrMeauhLHi28XoRAyRXuYpwZYtntTAN6tu7ltZGZ7yXxYIgvHXBXvKk?=
 =?us-ascii?Q?DsbVqywG/7ylB4YY+JeAFpn2/5ghnu4OH509hqc7o+TCTMc5DNBuo4o2tKtW?=
 =?us-ascii?Q?JnSETj1UFO4uV46rGbYebrViOGeS4ebqzgvVojkHeyrT4wYLT16g24Eokdx9?=
 =?us-ascii?Q?noiIyNe/T/J3x6ZYgNyDKFBQqGvz1vKLuQe65VSwWn5pxkf/kslIzwEQnXvU?=
 =?us-ascii?Q?MvEL+lTdN1BHq+CptoA3n787eEHrjyoSymyHtc2r+1g4AyrGTIL95J16k9VH?=
 =?us-ascii?Q?cfG/REsyP1VjVZuCcz456i7KgTYbS5SefhccDX5VyQooMTwPr8j/MeIinkT7?=
 =?us-ascii?Q?oBnhCCkQQ4Jcbm85yw6DttArXs++GCLWb46+hXm6YyWc/aD82x5J5hzcxf51?=
 =?us-ascii?Q?MhEwDncc3UB1eqhFGYQ5RQ6mIya/ttJdZmR6KOJNMRdhIGSGzKNEsEgmVKdL?=
 =?us-ascii?Q?/fgIXUtAvKqiRmTcuxvaNp3jCBEaUj/ddq7kynxoaCKS+WaHSSCM0p+ZCZVX?=
 =?us-ascii?Q?037Qaj+VHBcJkyvku2zo0izn63fj2klUAfuWEmJM2e6zBcQiRA41ON+iaOjO?=
 =?us-ascii?Q?+nNowxjX3vLHE/JW510L2XLD3ji+kUbFL8Z+TXbzQD87xb8lwlFJ1cuOwly/?=
 =?us-ascii?Q?VcByu/trMwXHnXn4N0DfZaXU//invC5c9es2renUwHmGVyaK2ST+vzdH+q88?=
 =?us-ascii?Q?Auc7LiqbLcL4XXIygWeOenBFR7/MMHuE8gVcJW3VLpp+0LtgWQRTUZZpcVeq?=
 =?us-ascii?Q?EogLoi5VHw9FQ8qkoeEHEVdWkHbKzfRYnH0bn6C4nnILI21cj5HIPZgueicw?=
 =?us-ascii?Q?UczkbTyaanpWsRn11nI67G57pP1v+ry4/Ft6j/OgZFDY23io2y5j/hxNyMLw?=
 =?us-ascii?Q?SOGe5zLABfnlQOhm9Lw0h+/RGQ3qYa7yBHA7flDHvdCmUpp4Cu3yrp++eVzI?=
 =?us-ascii?Q?ArvPgtkd7GNOWVni5WBPrNmZcwOC++AgyBAjx0bBdtASlx1Ru0n/QGwNTBm0?=
 =?us-ascii?Q?299fn9TeRUXucaFBRSQ+Y98v7S157oSWQxxadLZH0sP6BN5Vp9CmJxgZVM3K?=
 =?us-ascii?Q?Knfqct4ieKREE7HXN4cUNx4Wm5WjyhRUdU9ldeaZJmHDBZGlKZFvD7CrWLI9?=
 =?us-ascii?Q?bA+P6WAj8IsS3C876pPQyc41fI1s5rgXCFrOQbtUVxKN2Jl4CxMA76Hvm3gU?=
 =?us-ascii?Q?yDjFJnRilXZ7OhpvanciYUqnnA5oekzQYTK00NljPN93hqXHcVjlXuBR7af6?=
 =?us-ascii?Q?++a15fRRJrzGjUHGuYnvbt8mU0/aaik6XUAixzau71JXtfZZYOhCoH/sfqqr?=
 =?us-ascii?Q?DE+wcrJmxRuJzovvbsGWGuHixYhBlZoL+FwAwgGU16B8aldnJwuifnFxXi+r?=
 =?us-ascii?Q?2fsJwlqsygXlA/owGp+d9zBB2fipPVXI8kHXkM+qmxaklJpcxhiYJnEZAFGO?=
 =?us-ascii?Q?PCftrhafx83oRCRc2+dxU0p1nKsZ9Tobbql5esQMNeO8hToXSQi4nSlKxlLl?=
 =?us-ascii?Q?X6nck/oq7c+jWb15vhtSmmKlYzcSn0L2fqDI5aLOI616Hf7A/JDE6sXjGvwN?=
 =?us-ascii?Q?ow=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 541747fc-ffe1-4e04-c0ae-08db131c2a42
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2023 08:26:29.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lex8H/QqvtIK0pZvN6TCxTCw3JuY9S+lJddeR2Tknglv2VYF8vkHQgb/8l/d5bY+MkuxScPiWTcj7tMIb5fnBpwZskQ37aHauXJcNcKUbjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6051
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Feb 2023 08:26:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10741



On 2/17/23 19:57, Jan Kiszka wrote:
> On 17.02.23 19:16, Gylstorff Quirin wrote:
>>
>>
>> On 2/17/23 16:33, Jan Kiszka wrote:
>>> On 17.02.23 16:25, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0 .gitlab-ci.yml | 15 +++++++++++++++
>>>>  =C2=A0 1 file changed, 15 insertions(+)
>>>>
>>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>>> index 311702f..95adad5 100644
>>>> --- a/.gitlab-ci.yml
>>>> +++ b/.gitlab-ci.yml
>>>> @@ -38,6 +38,7 @@ default:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "buster" ]; th=
en
>>>> base_yaml=3D"${base_yaml}:kas/opt/buster.yml"; fi
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bullseye" ]; =
then
>>>> base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bookworm" ]; =
then
>>>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>>>> +=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "sid-ports" ]; then
>>>> base_yaml=3D"${base_yaml}:kas/opt/sid-ports.yml"; fi
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - echo "Building ${base_yaml}"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - kas build ${base_yaml}
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${deploy}" =3D "enable" ]; the=
n
>>>> scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb}
>>>> ${CI_COMMIT_REF_SLUG}; fi
>>>> @@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_rt: disable
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy: disable
>>>> +
>>>> +# riscV
>>>> +
>>>> +build:qemu-risv64:
>>>> +=C2=A0 extends:
>>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>>> +=C2=A0 variables:
>>>> +=C2=A0=C2=A0=C2=A0 base_yaml: "kas-cip.yml:kas/board/${target}.yml"
>>>> +=C2=A0=C2=A0=C2=A0 release: sid-ports
>>>> +=C2=A0=C2=A0=C2=A0 target: qemu-riscv64
>>>> +=C2=A0=C2=A0=C2=A0 use_rt: disable
>>>> +=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>>> +=C2=A0=C2=A0=C2=A0 deploy: disable
>>>> +
>>>
>>> This will run against snapshot.d.o, and I'm concerned about both
>>> duration and stability of such runs. That's why I left if off so far.
>>>
>> I would like to have a build for riscv64. We could add something like th=
is:
>>
>>  =C2=A0 rules:
>>  =C2=A0=C2=A0=C2=A0 - changes:
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - conf/machine/qemu-riscv64.conf
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - conf/distro/*sid*
>=20
> But how would that help? It would only build on changes to files that
> are generally not touched.
This was more as an example as the correct rules. Another m

>=20
> Did you try a riscv64 build in our cluster? How long does it take?

The execution time of the pipeline increased from around 48min to 73min.

Quirin

