Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D42BCAC5BE
	for <webhook@archiver.kernel.org>; Mon, 29 Sep 2025 13:56:16 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.62])
 by mx.groups.io with SMTP id smtpd.web11.54114.1759154166901833446
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Sep 2025 06:56:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=Hx6Wg3EK;
 spf=pass (domain: siemens.com, ip: 52.101.83.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CSZpiVY83sTYMy/30oDjkL2MGoUOUxG8JsZyVeYwDfeLdxJjVppUX8rx11HLpFXaGX4xx8sUh+/+LyNqJB3T0vWomDNFYS9V5HuJ972z5HDlpfdk/hCX1568e/tK6TyABncVJx1PQwGSh8ax1cO92nVjceQVU7pjEv4Rj0HGnLMl28M2z5NlRZ+IyWpdNXI/sjcRZMhmDUAcrwQvvTeMTLOnJVB0ut/HIC9IRStAPNIWZTTX/6eCju3oblKW7kb+dRjo4Y8qLflch9Mcfae3Cg5R2W4AmQ032z/H9dtcdepsTquk9Kzc5W+/6cUUp5zeRMaZaZPsPKTM+X/lYdM8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfWg93lVdzFdihC/n9DGyolM6B0L7SUX088j+XA7K5w=;
 b=oFmRHAXrtjKWXuErez75Ajdxqe+0HgNQwdze/g6Ry6/8ne43Zxo1Vr+W3AyTXnyAWHO80phAihezR8HzmUak1BqqbW1ghoWmCfZzW0o84ykCrxPlqrTv0oqWOgdhg/erCsDdNEJPsJ3iM9fc5jIdjJqmUHNtLa3xJq48dzUhwr0kWuqEcA4HOjRMGcAn2fdxlPlOq7LzyWYpk10Dp68s8O8BaU+8cYZNduRiSyok7CHlwfC8HWsZQJw6qInqPpBNxWZePkbIQ5pZ3pG4abPtaRZlJl96XJJEvGyp3i5LLKO2V32eVejSShTbpYdtCG7/a/cCblxmn5OUnKG1B1rxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfWg93lVdzFdihC/n9DGyolM6B0L7SUX088j+XA7K5w=;
 b=Hx6Wg3EKW64NkLoYk8JxXP4XbcfUJdKuSAav86Zke5aGZX2qPs3zEtj3RbclvJDblIZnmLQW7jXmMgyO8qk4YAqDaZt+4DSkYUIw6aNyfiiYkza2Ir7u1MXVBhflZKAeKvzK/TahGIjFU6tj98VhydRXFW64JEqCZelvl5J94vKMnEuMJr0TjdeALdE0BPnmF6cy6mQ995mHvxIO/glKbN9s2VKWMgSReYSUtXNY4rm9bJ/7SrFQqkqdqzy+4HZm5wKXfY665mJOf0M6BtYQNs4ILRQEa/IGONvECaSj+4sbgpWB1MmUdqMhwZ5NXA4gy9LQ/WVC4H3DQkUyERhJ7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DU4PR10MB8424.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:55b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Mon, 29 Sep
 2025 13:56:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9160.015; Mon, 29 Sep 2025
 13:56:02 +0000
Message-ID: <638abd24-8fc6-4fee-9bf4-679b51c936a3@siemens.com>
Date: Mon, 29 Sep 2025 15:56:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
To: Shivanand.Kunijadar@toshiba-tsip.com, cip-dev@lists.cip-project.org,
 Chris.Paterson2@renesas.com, dinesh.kumar@toshiba-tsip.com,
 Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <53fe043c-eba5-4d8b-826e-5846efce7d57@siemens.com>
 <TY3PR01MB11075F7F38A4345A60D5FF028C71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <3643259b-7e4d-4e38-9d53-b0e2227f9931@siemens.com>
 <TY3PR01MB11075A9F4E791BBC04C5EE28DC71FA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
 <c8e57ef0-6f4f-481a-9e36-214f44fffb5f@siemens.com>
 <d196dbf9-7c3f-421b-a80c-2d39cfb6e27c@siemens.com>
 <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <TY3PR01MB110754E7268909F7468881081C71BA@TY3PR01MB11075.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::9) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DU4PR10MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: e56d173b-006d-4fb2-545a-08ddff5fecfc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|1800799024|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?vc3Id/SLcXYgUtxAwcwArJegaO6aliOc4LAnRS8+n4KOjfv6AhSp7t5jaCo+?=
 =?us-ascii?Q?UTTO9HCWVQeJb8QETCCXXYfO2LNfh+4EikzsAepHHED5jZJabddIjjSvKO+o?=
 =?us-ascii?Q?PvbMqLTeIqTm0Br2YDmvKPhPqPE+HqzXX0nFXkpeXG6/gKVU0+uVFoRkaPuf?=
 =?us-ascii?Q?debVyzbFWQ2hOGWSAA82Qag+36P5W1zsTcAUo/jnjRVImZYYXj7U+CWZ2vJ0?=
 =?us-ascii?Q?XnovBRn8+x3vMN9NygVUy1JUpibgY6cIeP2wpHD8VFrwA9C4F4uXU5acjqwD?=
 =?us-ascii?Q?ZEUTXtp5QqFGwNA5xNAM99o0CK5OsgbrtEylv7kuaWm+torOKeIdUAmhDq/5?=
 =?us-ascii?Q?igBw62+wYwsyAmvhUTOgUKaSaVQVtWKp35zo7RWS/E1OLDMqMWB6hPMREDZ1?=
 =?us-ascii?Q?rajppr3icaxnqwarEpYDf9jSWd8cY/scGCwul0eVHrmmygU1sknwPTrTkBOs?=
 =?us-ascii?Q?Sb3P11F6lslWW6+a+NBfwMQFCK8MkNWS25//sDjCXsNjMqaj7Cj7fvZqAxXx?=
 =?us-ascii?Q?2CAuF5tg/n/Vy+c3yBtv2xkwCHO+gRxW+apOKje/xVjsxm9NTEKLzOejEiUg?=
 =?us-ascii?Q?FwcJMJ130cFPxsHQpefxyNPc9u2WWSr8gSe1iUrF499YS/8Qmlf0bOsXesaV?=
 =?us-ascii?Q?eCpY8qoblVeiZWoa2QRbpA8fTAG8PCC0aBuvDN5Hx3Ylb276tE8MkbZ3QPEK?=
 =?us-ascii?Q?/bc72JnxXc303Nt9zkCqNXOVptGzqFRAf+va6ccGBMhlkLvJT5Xt2gfn9c70?=
 =?us-ascii?Q?+ZlJis0lAf8E3uTuBjD0dCIHC5eoUL+u86Xb17Fhy+h/MAU4BXPs6zyugosV?=
 =?us-ascii?Q?mnt/DULy9uAItyvA9AbqfPVFfggup2ObuhG1KXQwS1WjN8w7lB2fosk9uUMz?=
 =?us-ascii?Q?x+hhjiROvTtbn+Wut/BU99r/55ib+VT8C9BChQVl+9fl0TMJptsi6QNKyCNm?=
 =?us-ascii?Q?23XzS6iwAhZjGDY+Rq5hoLB08S7JoszUCl4o4T/p0P0V88dHR9l0lD18Qf+/?=
 =?us-ascii?Q?CMRbAbGB8fPz7eo80oHnUdiQ4vMKs3vHxkvLY/eW53f6bIcAwG+P02enqmXC?=
 =?us-ascii?Q?tQZF0JbMH2pkntjqDRd8AWu8tz5cCaLAsqP3CkiOMZ03Z2EajI7cUKaVjs0F?=
 =?us-ascii?Q?FGxJVd9o+/v19PEudzRr1qmgu8o1LRNb2Vn/4NrJ+4eiGIIK0vmgy9AvTijZ?=
 =?us-ascii?Q?4SxLEFqU7KPsyLSLi41WR3KCcHYx3T7W3E8gUfHJkeIsJOBUl9wyFiTKWGEH?=
 =?us-ascii?Q?wRnWV6Zj597LUIORd3BQMv3l5SYLllAh7Pm0qUJ+f74i7Obim74mctBgaYfp?=
 =?us-ascii?Q?iSAnY4yUtK5N35ORENstJFeG5mlGtzrmlFPBuVFBh30BRLPs7hpQtNdDs/fm?=
 =?us-ascii?Q?Gwsya8YszLvBBsFedKZFwJZnmZbCH8Ti9uF6L3CwZLPWcjta4g=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7le/Xutg5Zp29plW7HhMkSMwDAqMPEfQnms3CCdcDvUTS1sRrHCA7Hp1Qy+v?=
 =?us-ascii?Q?M/Pkv8aVJKvKMhIq33i4hlnu8FnSxYrEt5CSTffXC7tELCAOmCqEC65goIFK?=
 =?us-ascii?Q?dznyv1iuV7z1DZv87NF5LrVlhTmHpXJTXrha+br1NAPC6zpKIZiUubrBFT0h?=
 =?us-ascii?Q?2cBwCxpfWKv4Yktw/pbgbqtnjp90LoGijCLaNYRl0RSTW0dRl9DLzRNGr2lp?=
 =?us-ascii?Q?x6kvwTSMXdfDVMlSWNlBOhuabKBKMZOy+DkgDiY2nVKyaPRIbWdW9j8c1Psk?=
 =?us-ascii?Q?QzMIaooAtg+ylHE1ZmcVw7Fgcn0Q7uedEKrPinH8vlzlh9JWgXk7iPrPflVy?=
 =?us-ascii?Q?ly9EiGxor2Bdugi46olUNiizV+T8+bgyICUbVVU1wRsjCpjckYdE8K31raxt?=
 =?us-ascii?Q?o+ZsYL/mE7OhVZ7bEQjF9XA6QLq4OzyKBGv7Xf0ZXCjR94oDgaHGrlLq33q4?=
 =?us-ascii?Q?tS5Bo2To55smlkVH/sPS3sXNjbVNofnpDSp3nF54ZeVQ5YJl2DTgcqaUpZZG?=
 =?us-ascii?Q?UHXBUV97n+MJLKmj5J/ta35gEuy3qtLPT42vpl7VvZ+cM5H+N0XzUxzl7fFb?=
 =?us-ascii?Q?/qCWcHMOJ5DQe0ZnfaVZS/Iw8pp7U8yVm+l+eWO46pUdizeCAuMUg8b9tUDH?=
 =?us-ascii?Q?g9u4FMuJ98ghuGG16rR1sghueqqxLK02pZTTbM/8ESxK5MoMdsENv2pYcS/5?=
 =?us-ascii?Q?rncI7qL8/gjSqDdfZhCxUccjs7O2CZE7UDnlS7l2+Rkko3o8BSUNS4fOYij9?=
 =?us-ascii?Q?1KJ7K7kpRhjbNDkNy9rH4+EBn02gkhQ+q4DJvKsS1UhDl4BK6vlEupTNoEJH?=
 =?us-ascii?Q?XS3ac/MershC0Rr+w4Hmxj0vls7645rxAmCa6mtcFHEHwpxsOOv5aXmsmkeu?=
 =?us-ascii?Q?vj5Sdjlu/Lo+FRRFKEGQ1boN/cukI4mBrtFFDfw2z9AKDFV00KHtxfQmUYGv?=
 =?us-ascii?Q?21ctBw6sd8jF2h51fv/8T0OjD7eHs5d5FzY+J4O83pdJheMfxf7K3z+Lo0At?=
 =?us-ascii?Q?3+fvJoZKHVBX/fKk5yBd+lCSovtJJo997qU9vC4Q91+PuL4mIUZIijAZjEDK?=
 =?us-ascii?Q?Fgga6I+aKyP980bTSaCyFhPRH5DAr9euh9eIDNmBOBfdQ9oUIcQWCtzJaCh3?=
 =?us-ascii?Q?BtsSD2KAdEKAO3HK3RZgQZJkXEaW63/uw/KKymkM4VXWZfBuQKcXwJ8GGUZX?=
 =?us-ascii?Q?x8bH4wzlf2ylROaY7rzMQxpGde0uXBPD6LdRBo1cOqYwq20atP43bTaGsoKn?=
 =?us-ascii?Q?a35JHkPsf1x+lxFELN+Ma3FzYnA2r0ZaIxtaNpRpoI9mGoboXRn2panJ/Hby?=
 =?us-ascii?Q?wYm4sHyRK5ADzQdYEZD93JFuXpIFBT9RPP9mt7w7OXzzVheLzSOiuYwSPE0h?=
 =?us-ascii?Q?IYHjrD9eV60j0RP9UzTcUXMAvlCnwbL5lksx3W6Swta+pONBxBEfzVDc6mLE?=
 =?us-ascii?Q?mT1wH0opSEvqWa7NQOyF91/Jk1pvX5gKLyVIttZj1ypIS5CeBBmXre3N22dp?=
 =?us-ascii?Q?wkCruR2mqFrRzbzpdhSV716PnDO9gWWMo/bFxpQELFghBIMBCiIPXUsclTpL?=
 =?us-ascii?Q?DysPYhX1h1TeSBSpaCZrYvzqpe7IcdsAcimHlimP6bJyAFbPRm5uOYTy0mmn?=
 =?us-ascii?Q?9w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e56d173b-006d-4fb2-545a-08ddff5fecfc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:56:02.2456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HGdvTEUL6xX70d4aDQ85IEgmAnDyKe0fpN6FcXLDT6HapMw+SNVFniDI7IVrcItDQMj6qwWGhChlCNq9BxFjpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8424
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Sep 2025 13:56:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20151

On 29.09.25 13:36, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> Hi Jan,=20
>=20
>> We have a problem with the on-device IEC test now. Retry didn't help, an=
d it rather seems we are handing during the TC_CR2.6_1 test:
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11513053235=
#L2101
>=20
> In the above test job, the test TC_CR2.6_1 started at 16:44:34 and failed=
 at 17:39:25 because of timeout.=20
> It is almost 1hr time, there are no prints from the device side during th=
is time, so don't know what's happening during this time in the device side=
.=20
>=20
> Another job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/=
11509181697#L2062 here timeout happened during the test execution of TC_CR1=
.9_5.=20
> The job started at 13:59:34 and timeout occurred at 14:56:53 so here also=
 it is almost 1hr time. And same no prints from the device side during this=
 time.=20
>=20
> In the job https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/1=
1513053235#L2101, the test TC_CR1.9_5 is completed and it has taken 519 sec=
onds.=20
> In https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/115091816=
97#L2062 job, the test case TC_CR2.6_1 has not even started (timeout even b=
efore reaching this test case).=20
> =20
> IMO, it looks like there is no issue at the test case, if we run again it=
 may fail in different test case other than the above ones and also the sam=
e test cases are working fine in QEMU architectures. some debug required at=
 the m-com lava setup.  =20
>=20

Quirin had a look at the m-com device, more specifically its worker and
its mtda assist device: While the last was still running, the DUT was
actually no longer powered. Logs from the worker were not fully clear,
but it is very likely that communication issues with master made the
worker terminating the test early, powering off the DUT as well.

Can't we make the master's web interface private so that this machine
can focus on scheduling jobs again, rather than serving AI-driven DoS?

Jan

> Thanks & Regards
> Shivanand K
>=20
> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Jan Kiszka via lists.cip-project.org
> Sent: 29 September 2025 15:09
> To: kunijadar shivanand(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=B0 DITC_DIT-OST=
) <Shivanand.Kunijadar@toshiba-tsip.com>; cip-dev@lists.cip-project.org; Ch=
ris.Paterson2@renesas.com; dinesh kumar(=EF=BC=B4=EF=BC=B3=EF=BC=A9=EF=BC=
=B0 DITC_DIT-OST) <dinesh.kumar@toshiba-tsip.com>
> Subject: Re: [cip-dev] isar-cip-core: on-device tests failing
>=20
> On 25.09.25 17:26, Jan Kiszka wrote:
>> On 25.09.25 13:34, Shivanand.Kunijadar@toshiba-tsip.com wrote:
>>> Hi Jan,
>>>
>>>> I'm already running a test with
>>>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/e4cf7
>>>> 1701983e3cb12f19efe9c217f500b9b0868
>>>
>>> Ah, ok. Thanks. Hope it solves the current timeout issue.
>>>
>>
>> Not all issues yet: https://lava.ciplatform.org/scheduler/job/1310661
>>
>> Will retry once more, bit it feels like our target became "slower",=20
>> could this be the case?
>>
>=20
> We have a problem with the on-device IEC test now. Retry didn't help, and=
 it rather seems we are handing during the TC_CR2.6_1 test:
>=20
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/jobs/11513053235#=
L2101
>=20
> This is a release blocker until we can rule out a regression in isar-cip-=
core. Please help identifying the reason!
>=20
> Jan
>=20
> --
> Siemens AG, Foundational Technologies
> Linux Expert Center


--=20
Siemens AG, Foundational Technologies
Linux Expert Center

