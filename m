Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1806CC4167B
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 14:57:44 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.45])
 by mx.groups.io with SMTP id smtpd.web10.10363.1702306659208469339
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 06:57:39 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zOPM1Ch0;
 spf=pass (domain: siemens.com, ip: 40.107.21.45, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipEjFnIi0w9U9qBmVsF1NONZhlM8MN0dzRtW0k0mswiwpccPshcZGMR7T1wZmuGKxos9jkEvSBqKm2FCY78l4cNGRWuZyIzSGmQzYxLCceb27Mwrv6B7X4jN77GpWBUwT8B9Mpc/Udg2FFuh2FVbhjns1fWH5+HbGSbAw2IE8G/t2WNuCE9DL89d64VIephnOtfLRl6UA/dn4WuCEm2xXoU4Z6o9pQRq12K1vmBIW4OV0Hnoxvk7rIuRxk0OOHWkOUVu1sLI16elIgY9oQCmNZH1Y9zOmQwoj7v/qBbG93cVT65tAO+8+ADV3PzWf54B22zJzqKmI9zWRWtCFtMh5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FbU2ApdkW6e198TyAM5GLsYhhx2Gksoi76B4cDq5No=;
 b=mn+EqBCEn10ji2TblnpYduJtWUkKA8c8gy3On28Qpm4XBfAMZObJ5/LI8CKME7H5/55NvYCFmrDzVytOTBLNE1jbWk7aAy1XghFodzN7pgmTFe8LspE41F2+Og11zzlvNjj2JRC2KLIoxveBZ2WLKpGYOXkGxkK8Ca8P3HKoCQEXdoJn3zHeS6XvCamJ4ZvrecUDAVdIC5HJMTLBkVI8Qn6m+FJqoy0uBqyD/0RdRdHB698C96L/6AnDaSBCPvI+r+R3iulskTSnfssxCuMvHZUvYf3Pc2qiI5xo+hzCvzUhKzXV+WHWqOicCwUmaD3bOOh1VIRQM8/1Pb174WXuhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FbU2ApdkW6e198TyAM5GLsYhhx2Gksoi76B4cDq5No=;
 b=zOPM1Ch01rjX3Gz1n9V5vts9cKbhAwisp+QK7cLbyPlp77P8TX+cGFNlaYRf34Jt7uU5R5QP/9YeizhkDA2t+9Xnhhq0HCq0ZVO54du1QGz07j0GTVj9THlMVWLxpD2/S0f55zUo8bpRfbtB4VKvrCtY3VY1V4Lu91tfZatZXZgULHRJzV94N8C8DVT7waj+U6DrNz0IyuCYELedeKcVPzupZFcQRO3UtmJiv20OO7tKC0LMscL4wpuhGDU68S2fYi4zn+DGFQppSS3s764E1h9kGOFIup28hnYfeK4pE/C6qBAmP2/vc/KNvtHtGwjIOTyG4bGDYGkDv/X5MP509A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM8PR10MB4052.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ee::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 14:57:35 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::96c7:d239:1723:8761%5]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 14:57:35 +0000
Message-ID: <7c598271-95a7-442f-a6a2-bf8ce768c04f@siemens.com>
Date: Mon, 11 Dec 2023 15:57:35 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dec][isar-cip-core][RFC v2 3/3] swupdate: Extend
 sw-description to update efibootguard
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 felix.moessbauer@siemens.com, cip-dev@lists.cip-project.org
References: <20231211122528.486786-1-Quirin.Gylstorff@siemens.com>
 <20231211122528.486786-4-Quirin.Gylstorff@siemens.com>
 <e0acb7f6-585b-4e39-9d2e-5e7691fdeb32@siemens.com>
 <b53a426e-b5f9-4ba7-b76c-e4020ca1a1b5@siemens.com>
 <0d705fa9-9c0a-447a-9eb3-5f08ee0e8a0f@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <0d705fa9-9c0a-447a-9eb3-5f08ee0e8a0f@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0026.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::13) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM8PR10MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a28dc22-d859-4708-0f3e-08dbfa5982b6
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Hx2yrT9huhe1PXF2kB4+xDNm+sVPbuL+aIVzCmpa6nbv94/dNqFgp6sIHoeMfpiy9e3fwvs854pQNzx8BTX2xN1Po7AbdL5R8c5gohx3caeZvgG4AdY6jN5MMd5tTxdBcmEJV3PbM3YBpQyhxd8J+fGI0edF1+qhhWHWxUyyC9RVfiRUBFmD/OCwlt4ZKF+x9gTMPeDcaoOb7JrziFKZPHyVAkO3KbXEnAb6Z8juYHu0yUf2bDF6UFrOYTcy6OlHLAseyTIE858ujzjosL2mq/PJiU6JsWDEvbb3PmOorQV0ZEAb0XJ+36qdMP6ffVlgLsOWo+gwPA8dFoSYW0XHzxeM1aV+oaX8pc3LTXm5vLXmiS+5/fVX0UOTjSpJ4eNhcTMgVSNWE0d2rlfL33fqbaFllw0lDsw/bStnGFWHbulZTxeTkG9DCzJ0pTZO8fyh/bEy8XrRz7R+AEaiJlUdg9Wvq3FzyS7dLzs5WkGUND/Vz4fRgFonq5pj6cJgODK7/QRXfgOZnZRvDHAGynD/wxksS+5PCqCv44nKVzwcGs1ew8GzCiWFqxew5qky9Ei5eHPlwkjgF03jFRP25kilxECLoERtfRgmMjZQFYoxfPJjgm8/SgU78N1fwNyZQHyLbp1rkKEJChmm63896traeg==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(6512007)(53546011)(6506007)(5660300002)(26005)(2616005)(44832011)(36756003)(66946007)(6486002)(66476007)(66556008)(966005)(2906002)(83380400001)(31686004)(82960400001)(41300700001)(478600001)(86362001)(8676002)(8936002)(31696002)(15650500001)(316002)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZRffnmms+3UGfMpy4rFr9bt33IqEN9vSwCp49v1WakVyVO6onE2rjVgDrw0d?=
 =?us-ascii?Q?U+qiP19P6KSA9t9SJvKCUFXnl0KYkWth8ajUeCcsL7Z/+zek8i67rKXkAIxx?=
 =?us-ascii?Q?hLixzddJbr/3SNFenkewrMGH95d55fCMotKyUWMKgpU/CVfqyICsAxaosQCP?=
 =?us-ascii?Q?sVQYKtk7lPL2B/XPryV3WBGxrtp3Qxy52nwPplptG+v/fo9VXwpiSDq74hQ+?=
 =?us-ascii?Q?UMcJ6qZPWqm18UAPcVFYZ9J/IB7occ0MptNrmBrYzaVyCa41R2vwc1Ys4wub?=
 =?us-ascii?Q?/8W5bd7XklmQ8ztklvUaAe/MEDfOd6wsviw/k02TDR+rOyWcOTZ1huWY/O5K?=
 =?us-ascii?Q?I7qN9pf1lilrAzQyI4zCs3SdvdpbTVvMqEtVYUp7U3mN2WG+eSOxE7M9iKAG?=
 =?us-ascii?Q?62R5ABzZuMNEF8KPaW3GCDY826BRFB7qLXF14QLjuuEpmH4M9rURVgDdV9fX?=
 =?us-ascii?Q?y1OZpQBA1znnCPvQaPl12U1hH2tBWtd8oFqHn3wTrw4dTSoP7B+UOAtppdRS?=
 =?us-ascii?Q?9YUwbObluwwbcb0gbP/qJcmrZGllfFCl+MuUYPN4Tfx5UceTpbtnl/2Ifwft?=
 =?us-ascii?Q?jTWPfFTSHTqdibeSG/R20tHVqJKyD9Q+w9Tl5z+4WHK82y+/dEzjwGkZiczi?=
 =?us-ascii?Q?YiD3+s5BPyU9ZflKPKMU8xXXZnGcotOWSMe6xPFGBnO+/awjeJtV+rBZl2na?=
 =?us-ascii?Q?GzOLJ1osyST6SZtpHm113ZOEGfsS2p5gwTdEtUV8A299p26jI0V0dr3KtGNH?=
 =?us-ascii?Q?ljEzpCH2Ip/MdhDzu/2w4C0fBu214wwi3hpS6DXQF7NuNZZ+KHO7wtAZw1Md?=
 =?us-ascii?Q?UjniS5/Btf/KDa1bZ2GaLowx+lYlEg+cvDu0WtyXzY9FGM3rFAhYffF5snBt?=
 =?us-ascii?Q?N/Ul47OorCh5U/ISSwuTVSs858veKaF61rmCRjYUMfSm6MM1vfSZp7WRyJnt?=
 =?us-ascii?Q?cIZEH7VzrtCTl3cO5iBwVSgWqYw9Jy9Ks9JOeFijigT+V77c163aV2j+2/22?=
 =?us-ascii?Q?5aGT9AbQ/Oj6kWEJZYQSXnfErBwPdxD7ryiPGhgF4+KHG599TK1+Jv+dliYh?=
 =?us-ascii?Q?h5E3mnt1CiQHqKCOtYYYSSdXQ6mus56B8g3wldAPgpJH+lmzky5FextIUBHP?=
 =?us-ascii?Q?4oNHSHjcbwHsKCky6aXBt02yX0Js2zO2qlmuOvF4Yfh3y9LkxJLw3TLZ7Jya?=
 =?us-ascii?Q?s0LVS8HoUBYszOkxhUjT1gMtggpcejt297mCz7WnX2VMqBom2Yj1zd7J0e8e?=
 =?us-ascii?Q?cx3LSO51rtZZR31Zw1MatHJhlprZYZsrqjnd9hOUlaZjJCW9aCN9WARHAC1A?=
 =?us-ascii?Q?85WS+SkhLMgjtea6qdP511WBOWm/2/Gt2/CkHNCbbdjHsuLYGP3lmzoRXvmj?=
 =?us-ascii?Q?caT6d3pyVFD8c7MWzSquSEbeoWoRJa4LhwazPcs8vJ9tPOPw9tXtu9OpWRM3?=
 =?us-ascii?Q?bDUu21gxRjUB4wKWleG95XdzzgeSKWAqlIEmDO2v4LPCv0tOs7zPq1keV666?=
 =?us-ascii?Q?X4NMZR22zs5P3Wt0AtNfM8m4IUScY+lJcy9c5JK9D5GvMg21GKJszxnTSHin?=
 =?us-ascii?Q?ub57VmdFpWwpwLWh9/wljjEvqzhHmelOLxvS2UMbRr3ZGbaPXBnjfCp3NSQD?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a28dc22-d859-4708-0f3e-08dbfa5982b6
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2023 14:57:35.6051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 15kyxo2IOhZtyYMLemuKM37A2GvMWOlSP9+bsI7JlB6ySEncfg9NOh8Gqd96kVMh/kf1pJEe+Pabny7U7oZAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4052
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 14:57:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14031

On 11.12.23 15:10, Gylstorff Quirin wrote:
>=20
>=20
> On 12/11/23 14:46, Jan Kiszka wrote:
>> On 11.12.23 14:45, Jan Kiszka wrote:
>>> On 11.12.23 13:19, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> If the variable `SWU_EBG_UPDATE` is set to `1` an additional file
>>>> element is added to the sw-description to replace the ebg.
>>>>
>>>> Use python as newlines are part of the sw-description syntax an
>>>> therefore cannot be hold in a bitbake variable, see note in[1].
>>>>
>>>> IMPORTANT: Even if the property 'atomic-install' is set FAT does not
>>>> support atomic writes or renames so a powercut can still corrupt the
>>>> system[1].
>>>
>>> "system[2]".
>>>
>>> But you are not implementing option B described there, just the even
>>> more risky option C. Doing flushes before the renaming and after it
>>> should reduce - though not eliminate - the corruption window.
>>>
>>>>
>>>> [1]:
>>>> https://docs.yoctoproject.org/bitbake/2.2/bitbake-user-manual/bitbake-=
user-manual-metadata.html#line-joining
>>>> [2]:
>>>> https://lore.kernel.org/linux-fsdevel/20191022105413.pj6i3ydetnfgnkzh@=
pali/
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>> =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 | 35
>>>> +++++++++++++++++++--
>>>> =C2=A0 recipes-core/images/swu/sw-description.tmpl |=C2=A0 2 +-
>>>> =C2=A0 2 files changed, 34 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
>>>> index 0e95e3c..99a4c6f 100644
>>>> --- a/classes/swupdate.bbclass
>>>> +++ b/classes/swupdate.bbclass
>>>> @@ -21,7 +21,8 @@ SWU_VERSION ?=3D "0.2"
>>>> =C2=A0 SWU_NAME ?=3D "cip software update"
>>>> =C2=A0 # space separated list of supported hw. Leave empty to leave ou=
t
>>>> =C2=A0 SWU_HW_COMPAT ?=3D ""
>>>> -
>>>> +SWU_EBG_UPDATE ?=3D ""
>>>> +SWU_EFI_BOOT_DEVICE ?=3D "/dev/disk/by-uuid/4321-DCBA"
>>
>> Oh, and where does this UUID come from? Is it a wic default?
>=20
> It was added with
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/b1bc585877=
549dabca78873f6bada730cd56cf71
>=20

Thanks - was searching for the wrong string.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


