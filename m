Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F216EC636D6
	for <webhook@archiver.kernel.org>; Fri, 17 Feb 2023 18:57:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.86])
 by mx.groups.io with SMTP id smtpd.web10.2935.1676660258048127305
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Feb 2023 10:57:38 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=MOuyL6L+;
 spf=pass (domain: siemens.com, ip: 40.107.21.86, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a/1MU/31KnboqwPXvFVOW7Ws8WWpY1K76msEVu+09uvnttwZldW2fJ61cmX3V7eBrJhd5mAIwhU3V0oQQ1J8NIIPU+DOct++5GOvJWM4VbXkPqgx0l1a/Mj8rut6iDxOmkx9FhA5tiQ3PxXy23SrF+LnEfYSFlm38D/YkdNpiaGO1xBNr1R1iAd4ekebF3rosKHI88T65IUhu4i8zkzhzvvEhuWTu/N1UNBdR7Q0juyUlkQ6w6aLeGq0m1Z3ZXNucfRc76lWvq23KdW4ohPwyMGefVJiSh+nw/JsllOUrv0WOhKcgAF/KUyHSMXjcSe+vTNxwVadZC529XYRT5uamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mzt2oTZPGSknVXwNEgvyeRJPyOwCmhinSdD11YxABWI=;
 b=Dm4GyksG3qt3QYMVT1hm8wB7BRjQlDwRFdfYf7VQCRhkWdM6PrHimRWajXW2DQOVI1Udxp31iL6n/MVVJ+KzPJzK5eIX+5zWrbsrVjOYXEfS2rcTOlOHMfRddvbS+uBUZb9blQafwzm1rWz6rhz3PW1ZdqDRXHHrJx+6ZR4yxCpgmVf2/uoP6t7JMeDga476euKt1SR88npFcMVZlefMEW5ubbOTwfEF0E+QDPTCTXXGDkaoJ3qGmjB+QFRtKZqmjLoNLP3z4d4mrlza/JL2NoSyD3j6RP/n+DcmewsJmSD8fIwKQWaeieO82u4mr6r1Edhu2XvS95hxGUliiSP2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mzt2oTZPGSknVXwNEgvyeRJPyOwCmhinSdD11YxABWI=;
 b=MOuyL6L+MDAPlUv5fbjaO0bAcuuKZb4oosUGWjT0NNkeS+VPeiBrtZPQOZJX160r4ioj0LlbUxvzBgRrOVrpHDeUch/hzF8VdQzboVx4URterSxc0FiA0w8QPzcU7dUiCEbD/4f0lVFYfYBGDgnyaDH76r3nmdHz5kbeJHjXlYyWx5pOJJurPPwIEs+LFStNp+Bv54kqNrByhGUBN/Jtj8ldUdcLEVzMcP/euAq3EnZ6oAnWqloBHCW2/0DB8YH8Z0v7+jXlEzKntsPDGDMx+mrRTcxaBjd19cTbszECfJn4NdFryRfX9KR81mpL+vylPY0fusdYLMlwMGfxltw2lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7761.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:644::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.14; Fri, 17 Feb
 2023 18:57:34 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Fri, 17 Feb 2023
 18:57:34 +0000
Message-ID: <0629fe35-2060-495b-cac5-71f259306d4b@siemens.com>
Date: Fri, 17 Feb 2023 19:57:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [cip-dev][isar-cip-core][PATCH 3/3] .gitlabci: add riscv64
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20230217152556.516948-1-Quirin.Gylstorff@siemens.com>
 <20230217152556.516948-4-Quirin.Gylstorff@siemens.com>
 <86fa2631-b3d2-a667-2aee-a23f1f8f92d0@siemens.com>
 <4dc52776-be5a-00ef-a7d2-6a7522f8df7c@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <4dc52776-be5a-00ef-a7d2-6a7522f8df7c@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0098.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbf729c-15b0-4c6a-de74-08db1118d48c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	uYM5WGghoW6j6+vbtoAq87hx7VfjpgM5wi+pR+ICoLS6HU7sx+Zbqc+Vn933/mfYi9yhGvDbCw3prajY/xyyE9A87oplyJPoH69RdI/m/89Dm98jQnJW7s9k2vIHAL1jyoSmdi3XOap/cV3tjid6HYz/catmN7oQIfqcaPWxSyyTsZnt1iU40/RPsWJeFN4uooY/z8rGQ/3EKSGPD9m/PqN1IoexNEh47s8f4lJEmG/rxjQTtIR6vo259xayWCaa/Rf5amn3RW8etWSSWnqmwdXHC+Bj+C774muTqyyeRwIQwZxzbobKXzAGXzvhsoNbFc0GPzNK9ZA5fzEa7Bx2wnm9ZNd4yOdkWHWXb2E3/D2t2EivsDi8cYzJhsnIRP+D8USzUqCmWMu6lxJ06mWnzscOwSLaHdave2IZ3CLFrrwz5mDGiY2tG7+71yfZbQ2qHQFSYM3WBNIBoX+kJFUUo3IXC1FjGUbSHBaCGQP/CA1PHCvbNMK7WCZIoZHaYi0bORk76v/+mfjOAa3AK40AGIdPI2tSk2+l6053t6SVhFaXi/VGXBKvG6zDR+GfwEcKNEd2T5QnWquerZWKrgu3l1T+6AQuUlzQ+G19y26GxnudD1hZE5tqzasM0TwHncviAT0cH/T+ALLZd0uRhdvdJtGMqBNkDwehx8lURht9duYsatiOrBSI1v1p7B6Di8VzCI5zvYBklEgtKhcxzk1wFd4IELyYDtd6ISRrEDesW0o=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(31686004)(36756003)(2906002)(8936002)(66476007)(66946007)(8676002)(66556008)(6506007)(44832011)(5660300002)(86362001)(38100700002)(31696002)(82960400001)(478600001)(6486002)(316002)(6666004)(41300700001)(186003)(2616005)(26005)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZfYNbJJYOAY2ZZ7P8uT9HGgBDbyD71XnpIoMWfgp3hj9/Lz1rWypDCQAFwxT?=
 =?us-ascii?Q?f8Eq48EK1W3kxiJl5n4msWOrsINbqRy3wwpR4/rogMCTKTK+ld4GH1Oe41RU?=
 =?us-ascii?Q?taKHv0l+08knPuePTybn00588YV+iupK7oodVV5UBp7ASg4QI5i0jE29IanP?=
 =?us-ascii?Q?/Ruvi7s2ZiqaSxTrf+oc0I+SGwEHKr/9SD5EsSVz1Zo82H8yuD6hyviwLaey?=
 =?us-ascii?Q?YMwZmdxNqjzVE0jWy9+pVFxlRs7BRY4acf1hUA2lGUPrYBuiyJC0smGIyHBk?=
 =?us-ascii?Q?o+u9mDpUa1ECR6v4uEjTIE7Lmg1MZvvx2kXvrKQinGP8SirE1pKyWNTMgA3i?=
 =?us-ascii?Q?d+rTVt+gGVqDbE8d2MbTLTnXfjG1Y3a50RPJjiRbANWiYObWr0ZdNy/czcvT?=
 =?us-ascii?Q?RiEN8IUVmns+bESS5cguJL6UMKilNh8m/Axb4+2aa2B/nohZk+zL+0Xr89c6?=
 =?us-ascii?Q?IIHpwzFQlUBDEozvduI9O3I5YsJuLfa7sDwkhA/ZvQPkFZJpqOgNqBJ8uXPp?=
 =?us-ascii?Q?jxB5Dgg91LfPUYdvlR2N58waywqUYTE00V6PYLbQ/0V+MDdAIAoIEOUmQxC9?=
 =?us-ascii?Q?+ovjHiycd5CD4zJ0BZPxJ1mId+Jtsg08tNDqPkr561cJw0rEZmnb0n39kGo/?=
 =?us-ascii?Q?sIz3tT2zcLSRAaxtbOw0vtWvuhbE4TXTunghIe14X34l6cqYUMu43F/5GxKY?=
 =?us-ascii?Q?SIlZc4Uh2+7fh1YtQMh286DYnOM6sDBIIuKuig8hT0pIg3NH3szg3olXDgsz?=
 =?us-ascii?Q?dVe6gLBpVPLKjR575jT6XR1/s7XUxpvWQmLLIwApb+2J9mQz8RxVgEkbOLcP?=
 =?us-ascii?Q?630IRIGOuqN+j0JIGqUk00B+EEFNDduZ+TGeN6N6uriDKlWFL0QK5if5akmV?=
 =?us-ascii?Q?xXbLCA23nRmSqCX3hT84uC6dJse+XYc9JjvkL8eoiDPFbg9IwVtU8IG9rOnf?=
 =?us-ascii?Q?gn7HdiUrgnsVvaXt0CB6STCCPwJDcpCWqv70d2jwYikuapCWXjg8YeVqgVm1?=
 =?us-ascii?Q?WstOsjP66I3+zYFUE2e6EjSQAVazNMfyQlMJWmMCiLjR98Hpoativ0y6KBCJ?=
 =?us-ascii?Q?8KNxWGv3S+ar8/5QIokPLa0a556wn9YsT1vxQn4M/wRYnWWuDrC46Ux9NrBn?=
 =?us-ascii?Q?zn/kGPKZRDHF+uapUE0dNzNyK6MH3U5j57dSowYiO9I1fLSh4xcLDWqqkNtV?=
 =?us-ascii?Q?prcWshxbc15yn2BCD7iybOguabA48S26JEtMZ4mbEIGc2wd0VlZreq1LHp3p?=
 =?us-ascii?Q?oFhe+yXLycOfhgcQv1Seg6sj5PRbAqC+YgPNCAxy9LzSiEyNE7tgLpz54l0I?=
 =?us-ascii?Q?/47ZMHqvp/yBIa4dK7rDKcV/6c9rUEbM4orXrct7piYxiK2mX70WdMkypV6Y?=
 =?us-ascii?Q?Q/fniDgUpxuFRV9OPlrB17tNqIMz3tf7QvPfkowiWbetiHHtc5i3ExlPPhR0?=
 =?us-ascii?Q?UVIniI9TgWmy8Umw0QZh+rkv8Fm0B5E45eiJDIPWi5Q9y/DL/vlT5ePoWWb0?=
 =?us-ascii?Q?UNzbzeypneKEqis7yf7dEf0WgwbSkLJUiXzjvjsE0tOR04H67oGKBfLqjJsh?=
 =?us-ascii?Q?DMlvE/q8n9Vt8W5y7jNONqFACdhcJLwKeWxJahowtKWypZCmejWznK89mh0q?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbf729c-15b0-4c6a-de74-08db1118d48c
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2023 18:57:34.7195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ka9E522Q7xRirMzJ58zkpaDcwJ21nFG1Wa+qu0JdxCGedae1ps++YcOZs1VnMOD3dXJ8Scxa/N+SL3AhkuErZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7761
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Feb 2023 18:57:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10737

On 17.02.23 19:16, Gylstorff Quirin wrote:
>=20
>=20
> On 2/17/23 16:33, Jan Kiszka wrote:
>> On 17.02.23 16:25, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .gitlab-ci.yml | 15 +++++++++++++++
>>> =C2=A0 1 file changed, 15 insertions(+)
>>>
>>> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
>>> index 311702f..95adad5 100644
>>> --- a/.gitlab-ci.yml
>>> +++ b/.gitlab-ci.yml
>>> @@ -38,6 +38,7 @@ default:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "buster" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/buster.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bullseye" ]; th=
en
>>> base_yaml=3D"${base_yaml}:kas/opt/bullseye.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "bookworm" ]; th=
en
>>> base_yaml=3D"${base_yaml}:kas/opt/bookworm.yml"; fi
>>> +=C2=A0=C2=A0=C2=A0 - if [ "${release}" =3D "sid-ports" ]; then
>>> base_yaml=3D"${base_yaml}:kas/opt/sid-ports.yml"; fi
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - echo "Building ${base_yaml}"
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - kas build ${base_yaml}
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - if [ "${deploy}" =3D "enable" ]; then
>>> scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb}
>>> ${CI_COMMIT_REF_SLUG}; fi
>>> @@ -326,3 +327,17 @@ build:qemu-amd64-secure-boot-bookworm:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_rt: disable
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 deploy: disable
>>> +
>>> +# riscV
>>> +
>>> +build:qemu-risv64:
>>> +=C2=A0 extends:
>>> +=C2=A0=C2=A0=C2=A0 - .build_base
>>> +=C2=A0 variables:
>>> +=C2=A0=C2=A0=C2=A0 base_yaml: "kas-cip.yml:kas/board/${target}.yml"
>>> +=C2=A0=C2=A0=C2=A0 release: sid-ports
>>> +=C2=A0=C2=A0=C2=A0 target: qemu-riscv64
>>> +=C2=A0=C2=A0=C2=A0 use_rt: disable
>>> +=C2=A0=C2=A0=C2=A0 wic_targz: disable
>>> +=C2=A0=C2=A0=C2=A0 deploy: disable
>>> +
>>
>> This will run against snapshot.d.o, and I'm concerned about both
>> duration and stability of such runs. That's why I left if off so far.
>>
> I would like to have a build for riscv64. We could add something like thi=
s:
>=20
> =C2=A0 rules:
> =C2=A0=C2=A0=C2=A0 - changes:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - conf/machine/qemu-riscv64.conf
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - conf/distro/*sid*

But how would that help? It would only build on changes to files that
are generally not touched.

Did you try a riscv64 build in our cluster? How long does it take?

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


