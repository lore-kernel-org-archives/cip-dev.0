Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39719CCF9EE
	for <webhook@archiver.kernel.org>; Fri, 31 Oct 2025 08:08:56 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.16])
 by mx.groups.io with SMTP id smtpd.web11.10014.1761898126813018958
 for <cip-dev@lists.cip-project.org>;
 Fri, 31 Oct 2025 01:08:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PH3IpQvZ;
 spf=pass (domain: siemens.com, ip: 40.107.162.16, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WlEX5a0R1dXG3IcYkn1Ehmbe05wi1SfpZTUBQoC6U9LfVOyxcebsiiEuPNy0/zTAczUrDQOmrTuT1f4uB8viQaR+IlxfuEE9pyC07zl5DXFkc9UsFMTn9nyr2BfqOHEQajqVoVEQ3GoZxLcPRThj1mXluDS5O9+7BcSLI80G83c1rVFgyU26RxH4pAc6LCtrNbd4EJz0LflZ2OuynuEnszCEA/zeqX+C9yMiLmGmkz8qNKpvm6n4tW/k4DSwhxKpmkgz7ZmO1/ZlbLO9dBuzZ3PUieWfQhrKSVSyrA+/t5b5OB/zZNbi1kwUCRvAODrv2sbsb6BB86yIYZDBztstxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/KyL6l7DnB61lmHRfveDrKYt+srYIAtJArXxh/HMmXU=;
 b=Y/aXhU1+4720dS703yj2Lg/1k+yaq6xr0+GqspiCAVthEyJdYAtcco3Qch2grjIpXtcBs05jBLSz0Mz1fMbBQG9aOVB9UQCSA79Tv7OjirXYanhEx4CQlBlrqeUTF8YcLXYUpmj6QTUlrGrBrbah1UvwU4J6/Q0cv2CG6YPPnn3i0cVH4kPBZz8p9KsnDd6tO6uG8Fv9i39aCT8zM1xoyY/GM9UBsRIci4EDOOHR5K7rV95/63RHINKyN912Dt8yBoflo8KXRBX6uQ79PuKeE4RaGTCAVVZbXu668LbfV9H8/86LU9VKcMNdgklueLl6Ez8TUr4tW2wfqmx4L+C3+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/KyL6l7DnB61lmHRfveDrKYt+srYIAtJArXxh/HMmXU=;
 b=PH3IpQvZpeSffpqzYjKnpeeGcis2Uuuv22h2KQ24Rh6HYVLXDyDJt9tbgj3WzMctxmHHb8En/XrXgIcjNsCHbUe6cAJzJ9tqECE0nQYiTgAj1TiMEoQKtUW2TEMAqS7+5UOlU8O/+3A08rvIsP77/8lrVX2qDfexH9OeZLROKCWEemOqUFBP8InHmnRDaQF3+xjWEaicJbAPApbApGgQ2NBhTdfuCUsmu3T+Gib41woDZYiYTDGkipG+RFp/GMZ12EVlhG38cfjAHwVojjGTQVIoRqFCaRZ0T+0mWlb+nG7jUkome4nZCxDGa1KOdKWsdXZhv38gqhvcTw5vDvwI3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB8PR10MB3531.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Fri, 31 Oct
 2025 08:08:43 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Fri, 31 Oct 2025
 08:08:43 +0000
Message-ID: <ec915def-2ba3-427d-b4b2-645075c151e9@siemens.com>
Date: Fri, 31 Oct 2025 09:08:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 0/4] Add support for TI AM62Px
 Platform
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>
CC: cip-dev@lists.cip-project.org, vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <a525b452-76cb-40e3-a9aa-8f31c181ad39@siemens.com>
 <d4ce7d05-a971-476f-8f93-bba25ba549e4@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <d4ce7d05-a971-476f-8f93-bba25ba549e4@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AS4PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB8PR10MB3531:EE_
X-MS-Office365-Filtering-Correlation-Id: e929cecb-1f8b-4f05-680d-08de1854b546
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?+GOv+oJIojPjut4nsBxPttMLaPFdVeGRE2fa3SF1vv8aaj8hGHV3Oo2UlAlw?=
 =?us-ascii?Q?ru4pKuuAVsBUvUaIUcQiOeFK8RmDVoHIwbPHC6xFh6VBnyUch8nrnanYLV17?=
 =?us-ascii?Q?Z64daiuCHtnLTXW/AyoopLhDL4tXQe5wxybAp2xE1b5DsWiCDuMWYWsJLIwd?=
 =?us-ascii?Q?7oY1T2lCKVPLDbpr/4mEkr6UXQ+KUbh986TI/lTl2sCPtt8s9skHY+nah1W2?=
 =?us-ascii?Q?dZSzq02EQb3gK2tQMPZAqawb0UQ7DEJ9EDMlzPGMGPMN0qPScRD7PrKZckfK?=
 =?us-ascii?Q?QISDh2lJ1VkCLyR5rYNWxp0mSQQNFRyhqOmrkDfhyXTpePq5NCEWlTzCuX9B?=
 =?us-ascii?Q?Ny76HSiRWKhc77soKywMXGke4OQXVoZNA6GexqILs+9Fy0BACmSMD1oJ/Kq2?=
 =?us-ascii?Q?aHRixZMfWRT5oGNjbYRfWhMvYPRERIHKRdNVIxZjyo6p2UUDz1KEKZRhYrpd?=
 =?us-ascii?Q?fvvb7Qf9nDtVeg2uXWhlenr7A5c41cyIYVh8ucYUDbiV09NLvSBi40In836H?=
 =?us-ascii?Q?EnakF4l3EOcUS8YR3usY0IudyTzKe0bEotaSDYW8OuDM2K9zWZ1Qy0F0oZUA?=
 =?us-ascii?Q?lYChkqkvdKIsWDyAdRC2wp5j4Bs6s5CcQuoSvKAtc6SA57WTxyzRoW5Hvd5s?=
 =?us-ascii?Q?lV1I3/pH0MdlokOrqTnOBblGGg505jrzZcxYozsUlVuPG03UWGzXB8QVORAY?=
 =?us-ascii?Q?SkwOWlx/b+6Qj45VAqaLiU5tztcHPrqBEm0KFAAyJIXKgyxwr481U8IkPZH0?=
 =?us-ascii?Q?NlpTmdphZNMgu6mxDzGhFcS67yBvlUF2EVainHYTgWRM4J7q45W+Tn4RSkVP?=
 =?us-ascii?Q?9L67ik4czU5nngixuoOHc3TsoqyFcRDNgcwfLm7Rq5fWdEiymdJz83Umdefq?=
 =?us-ascii?Q?JL1ibLEMR0tF8f31Gg9DUudIQQousHRjGvLkbfXQvqPtPVvbvi790lIMe8h6?=
 =?us-ascii?Q?lhVC+bAW/9xShLe2lHfmhDzVTyL4qxyr6rztNlPItdeRWIv7E1op8EDGlP39?=
 =?us-ascii?Q?ZA8nYLdZWphSCQobUvQ2Nq4ScP9Vm+lgddwj8Do/eCdK8yX1BlzoYEY8dubZ?=
 =?us-ascii?Q?2NuSOIz5EP71ZiBue3OxUur2rkD38CHJUP904gED6tOQn0QWdSEa7g0ECP75?=
 =?us-ascii?Q?qG6igkP05OpmZN8MrcIVR44jXdFF3+YlLqqxcRr2VrjMz8YNpLh+qoGwxvrw?=
 =?us-ascii?Q?s8HVad70Xmy8CMLJDpbwISA54vb3T/cM1hIZYbS/LiQjGIoNfkfLPX8g4yu/?=
 =?us-ascii?Q?ntTnCCMkgrlx/QZjTdzcR8y3POrAwsUQb9+awHA3cDx8U7jVuEviqb07x3ao?=
 =?us-ascii?Q?T0y0Zz1PtYRUpXNU62oIH8unrUDE8sm2Zun21CvzZpzZLG1yOjwOed+8B44j?=
 =?us-ascii?Q?v8WimTw4ZjdVNzLEQh/CllrJKKpHiwYBoupr0SG2VdGeZk96pg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ZsdVcx8a5iSQnFVCzjHe21c4pgAbdS9iWO5qTxeWAbxnJ6POmpx7WJ4AXTm8?=
 =?us-ascii?Q?Zcgfe04hnFPxKdQ/0HZ/R1bHtjbdcviuIqd2Uf1CkzO2dKHnHOURFMejoo0B?=
 =?us-ascii?Q?Zd5HLLNUpA04xOpS86gMhbM1MpipPrdpDsy39IyUaccVg/QMoYL3cQTMi2jD?=
 =?us-ascii?Q?m57qjUF0IL3e9q0SwKVt9MF6ff/kyIjI6xx1zz5ZdlI0wY98OT2llF4Z9NGS?=
 =?us-ascii?Q?Kck/f2c9Qg7l3vV86CusrAvXYs7O7Hbkbv63g/QCzZ3XexKJpc4bpljFYOLZ?=
 =?us-ascii?Q?++u9YizfhOwCASdiQvixnSZc65Opkm03BD4zoXx1nU5FKzaTsM69MG++S/2y?=
 =?us-ascii?Q?7CKfSxugW1V35UsTCegm9zgXDZgVVJ7cfCd916GJMFqyRtEDQaPNuWYkuudn?=
 =?us-ascii?Q?2k0+topouM6RvF0w0dwvYp9t/hd+jkvBjXSvyvWaDe/ouhz0fNGtoshag5f5?=
 =?us-ascii?Q?H9YjEJE71VWRpTEmCAavlcJ6eoCSCnF3rT4dME2Z5bPU/6TM8RIOlX0C9Gaj?=
 =?us-ascii?Q?CMeu2GNZ2xMk68RK5VcfizS6ncPTJGfXbihHXDuudHB4nTUwSsy2CZxdg/mm?=
 =?us-ascii?Q?vwtdKju3ZeN7rnMxeFA2lV8S4lZJw53+4C1D4aUJ7A8LcE6mI6CBqApPl3VC?=
 =?us-ascii?Q?ZqEK1TU6PAAxqqbAC1PY5LMPTUkQwCw6jwhJNWne+wKh0ALWnvgRBJFNXHXn?=
 =?us-ascii?Q?OGRXHa40i4N88JCyP27v3M8ekQL5Vy4I6gaFMI5J4OtbYn3s+3bPOcU68gJh?=
 =?us-ascii?Q?cZhOS4jUwq1LEsb7/ZdNrqF+ar8MomxPzdQxtOCEUu7aU28G982k4WseZ1Um?=
 =?us-ascii?Q?LWlI1HgJ3ON0ieSuWJTlkhlMYV3daE3ArGBy+IO2ETgNL2jt/GessFlg+l4a?=
 =?us-ascii?Q?lpgWmKFYOwaQbOJYUGf0fbEFZtr4myBO6vfSjpDthCL3KPxhPNgWWkCFHLPE?=
 =?us-ascii?Q?w+xNL9+ReTqe9qLgD6Ru0lyHE+u2IGxLq4G2L7cPr2NZOBscdf1V00LvlEVx?=
 =?us-ascii?Q?TEkrn98ZOzZ2Q1RdfwJgVp8r3EyffH/X/FaizAyz68T1LFLp7Bz1phfnZbda?=
 =?us-ascii?Q?OzTbJgULg4Poi1vkKemqjMdzVsv5md377F/QQderPpNm0crmVErzfgBPvjtU?=
 =?us-ascii?Q?NWy3CguyZB+hl/vtIkiV+y5Rx68jwdvd+UgwsjDsVHAQCzvougbNpv3QtfNc?=
 =?us-ascii?Q?qfXxOGEx46pw+OR6V75h93RNkJiz+GmOHUKDnSTwrEmP7HKYm6rf7MdaLPp+?=
 =?us-ascii?Q?V3A4LcBiOqarLFCupJhtnndYtX3X9P18xxMGy07u0QrmYD6p/zGNjD1cvdSk?=
 =?us-ascii?Q?98j2L/E9wVMl/cPgM1y00YTOc0YkpDM7qKukVgifdS1JxJ8dX6SfBJ2AWWUk?=
 =?us-ascii?Q?tNJgcxNKtibQVF3lhL4+Oqq9mQdCSTmGeNfKnv4uQoSipKppxZ8jyqa+CkLs?=
 =?us-ascii?Q?JcpNWamwHZUMoJy6X3zbchrhhjvpqxlEY2kC9Jq7XfkRev/Jy6zkzuHLbWpw?=
 =?us-ascii?Q?z0ejiiaSy8K0kvDZpHSsuc+ua08wZd/NQ1PQ+/CDin0b628k51dIJwM416kU?=
 =?us-ascii?Q?mHGaaUHA5suMIIV1c5/d5OJcCxdBjhOvIrZkzfHe?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e929cecb-1f8b-4f05-680d-08de1854b546
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 08:08:43.3692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8si2bjdnWy9OimJA+a+za/RUJs1W2PY44W7fkhDNnodqaIIQpGLjsELoYHspdSEfa/AB1oh79j1TQlO+jGFMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3531
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 31 Oct 2025 08:08:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20290

On 31.10.25 06:57, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 10/21/25 18:44, Jan Kiszka via lists.cip-project.org wrote:
>> Hi Sai,
>>
>> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>>> This patch series enables support for TI AM62Px SK Platform.
>>>
>>> This series depends on the following.
>>> 1. cip-kernel-config merge-reqest:
>>> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/
>>> merge_requests/134
>>> 2. kernel patch to add microsoft,ftpm node:
>>> https://lists.cip-project.org/g/cip-dev/message/19570
>>>
>>> Sai Sree Kartheek Adivi (4):
>>> =C2=A0=C2=A0 Add support for TI AM62Px SK platform
>>> =C2=A0=C2=A0 ti-am62px-sk: Enable SWUpdate support
>>> =C2=A0=C2=A0 ti-am62px-sk: Add support for secureboot
>>> =C2=A0=C2=A0 ti-am62px-sk: enable data encryption
>>>
>>
>> What is the state of this series? Could you rebase over currrent head,
>> or do you need anything from my wip branch?
>=20
> Hi Jan, I missed this mail. I've rebased over the current head and also
> cherry picked some of the patches that you have on your wip branch.
>=20
> I see that now you've posted your wip patches. So should I just wait for
> them to get merged before posting my series as my series depends on some
> of your commits?

wip is now next, you can base on top of them.

>=20
> BTW, here is my latest updated branch.
> https://gitlab.com/sskartheekadivi/isar-cip-core/-/tree/upstream-v3
>=20
> I'd be glad if you can help review the last commit in this tree as
> without that I'm seeing build issues.
>=20

That OVERRIDES extension is not correct: :swu is selected when you add
"swu" to IMAGE_FSTYPES (kas/opt/swupdate.yml).

And the PREFERRED_PROVIDERs are set by kas/opt/ebg-secure-boot-snakeoil.yml=
.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

