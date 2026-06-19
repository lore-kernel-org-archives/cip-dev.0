Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56153CD98F2
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 14:09:45 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.61])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43231.1781878181302585928
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 07:09:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=oZ0t+tV7;
 spf=pass (domain: siemens.com, ip: 52.101.72.61, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiDSNlcPEJyEzJHxKI202PhPJ2Ac8vptzKQLmrK1POyGNKLm5NTMJOpD6XIH4EtlOtzk5scRNGDKkIxa6LvOZfeypTBcisxnGqrEiJFnzuxIhwDFkpdAZKT78hdFFIQynOnWNcNsumqGNvlewYG4/WvXZlOtkk9mnaOCi8TLTLGhRho49q+yCgp/haYwnSAPQIWceNHp9n51o6EEwcnvrIxLifgWF7XWHpwMgX9VTQqZ2zf7aMowlIBFUjL0Us85PJECqTXJLqldb0QzTenuLgKptDCvP/2caLZ0MQLrz4rNVf22QQFsdpgVYLF8c6oDKgZPLRGs/DyyEzql9RtjJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mn1ZWgsMfAK/qoHPG3i6folTQbgfCDpCTUZYuuS+nQo=;
 b=wC9AbHRd7oTzHxJOJSjwOg9P5gefF1XWCG3xkAApe6/AnT5BNBdi/qlDev8Cf1CE+ayUakANGmhDI1w5JzLw3kvJrgNo/ZIY6ThuPk5puWOKOWjy++31nskcym7/7HU7COBWGNUsr+6//jGj9OtvE83r3fPaDFK7hxOWM+DcA+Of2lQezayzeuuFcmqFZIE4wzUL1MoV7Y3YVbGcxS/NKV+yJ6wYozqgkpY8ctXJ3ajWVWxAerLBZHX424Jg+ez0TKVNdjBj/jloNWEIW8KeZ+CO1hiHseS1B6Zq+dwXXT1tiKKIONDzWq9whmA+XzizBgxUqmU3wX+GVlyfbrSbCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mn1ZWgsMfAK/qoHPG3i6folTQbgfCDpCTUZYuuS+nQo=;
 b=oZ0t+tV7lUaAgTixTmibKqXiR4lccj7BhCJDMSNt2tjJwDTRBXzrCHPgbNiqSAxYfb+6EleqDOjxKigldWgfqZNPanCRrSaCuz5mJWIERFnQ1IeZBU92tdUy7a7HDBxS409vVdQI/cECxWQfBzill7R6odn0EVVUFghbZM9MGRy1oPgPe0fH18iBrpCGU0tDUxZipTMXG2xSn7J69CLL401x8rA5m0jbQ2m9wHrcacu92j5pJNYfAK8q7HHy3PcXtO/9oIGcaORXreRQm4FFrRm9dTeJ8XUXApcWt1HhFfBcrNV0if+W4p76AiKTZ8GPgYQXLLfRgsCi3HjVdXfTvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV2PR10MB6284.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Fri, 19 Jun
 2026 14:09:36 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0139.011; Fri, 19 Jun 2026
 14:09:36 +0000
Message-ID: <314fbf2b-2240-469a-9209-2998b73235b7@siemens.com>
Date: Fri, 19 Jun 2026 16:09:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] switch user in swupdate suricatta daemon
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>,
 "Kowalsky, Clara (FT RPD CED OES-DE)" <clara.kowalsky@siemens.com>
References: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
 <c113bc29-5c1f-48af-b781-2909438bd84d@siemens.com>
 <fec35a13acac4b94b4806b4c442dd4b8a836a06b.camel@siemens.com>
 <0042ec6b-7a82-4789-b843-4defaa80242c@siemens.com>
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Language: en-US
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 Z2NBPBZUysw=
In-Reply-To: <0042ec6b-7a82-4789-b843-4defaa80242c@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0332.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::18) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV2PR10MB6284:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dc6104e-1326-4abf-7cfe-08dece0c64f4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|55112099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	ErlbqmcQoqX28TZpP5l1zCbZSlPQ34UK37NJc3Q73cyN1HDoripdrdI3zYW795Hm3e+lPbHR+Jx4QFfPawg0vafGCFIGseNMCtQuTVbA9PQyUxnpt1W0ZFTD6D69X5kfuID/ThRlPEBcaams5xmwv+wzsj0pcXCV5nglIHx3TLwrgs81FX0DYi2DSfrFgyoqmKtRnwoGfwYoBCkzJ87KxMxhMA7n0dEbWeZBGrZtLaGx29wa40vJAnmJWTfsMwIkZz1uc8cf78qkXpnbhmoYNvzHC3q0up/pGzE74wNjCKdFUYoXrkEMG5gm+3+JREYaqebUmEdQpB/orVQOo3nqSzLv/aFiq+86HnNAG0FOLELSZuAt+CI0RYwhlA1pgxKYMOhpLc940ApEXdm9dTAa+vbC0C+yfFek0WTsc4p5OS4OBFkCxVrsHSbnPVmfVqSwGPAqAbmQGWxyUkJX1kzhoelDtMQ7pKX62rL55s1cU0UeqpVz4906k8SkOlzrRGzluwZPS3II4w6xfOsIartOruvuVqzbDU4Q0Fo9Zm5xfiZp99e7mMCLZ+Fb9GS2QrYI3/dAQfXHqUwGYrHRLQA1N8zkYWD5r4wLRlnrUNxm5nGyk33nenNixmnZPdpuyoJwsv3l8/9VndoLLLHjziOXT5mG74RjnNc/OoR3g7/lo3g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(55112099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eEcNzDunGhWu8yNM8pQ0TpkYseBSci/aQm36QPfXPnrqvJqz5YHNaYOoyZ3y?=
 =?us-ascii?Q?gmUrbNZDzm2zNGwLZBnJJj0BLkB5fDhZs7Nac+HQgt88S3RLTX/7wZU+V1Dy?=
 =?us-ascii?Q?JMRoFU+BrSuK7pUn/rlBKjIDaS/2I4Qz7dbyKPd839An/1T9RxN2v7FDW0OF?=
 =?us-ascii?Q?QQ7zxHVwngMwxnjWj+xjqhI2Rc7hfK79i+Md7Nx1cUpf7fpRIV8K0zfEk7UA?=
 =?us-ascii?Q?aZ5oQFtn0V3oHc1xyHIfbMknpqUVjvYzPmya1D0AjY+d6iiS6KYQygzy1Jrj?=
 =?us-ascii?Q?HeD7WTuA+YIgdjgJMdKOimwj1/2K6bKRaut7EdqwWvsOCzI34CH3Sc+26RRq?=
 =?us-ascii?Q?wsMiSvcolyF8VcrdBHVaYit0XqNfqxXm1kcvfistpkIKrDaz6lGn/BhvKgLi?=
 =?us-ascii?Q?zzpqmHFxxweLc5m8mAg5hxiXqqcztNXsTUOD2Rlplm/GQMahiwahAc43aJh1?=
 =?us-ascii?Q?U8Yd9vVn/EwMRKNFo0/2cDbyt6Ws/+cE/x0mZE3xFoEJysiIukTV73duSTX8?=
 =?us-ascii?Q?Eys0UEnDNJX953BL0+AY6v8T4kioi22c9CPnGnzkcbPfhqu+kLovuaME3oe/?=
 =?us-ascii?Q?SrsIqpie4psT2rn/MHHkbgvAxziDOGvPfamthTpHt68VkBsAxMxKOVdP6qNU?=
 =?us-ascii?Q?8A+jen8DgVT91KWer9URB2Ni3WtdhbW0uDyg0ps7QD80znlhUNbBgbTDBlsj?=
 =?us-ascii?Q?vYYgqbIeQmFkMez7ZG04dRAMTElHxSfM2DwomyUfbYwt517crQVS+oeHEjmM?=
 =?us-ascii?Q?k0F6boKUQrs4PuMuHSCMOE+KrP00IWcBBDkyKD7FBxEo6smUxIciDG3TbZER?=
 =?us-ascii?Q?N5ISQi1XDw7kwyefJX7oIuQb+zSHgTW/jU66e0aNv6HDonq6dO40VyqIgyP0?=
 =?us-ascii?Q?TUFaIisnPwcV2kibsMD5fWgp4goesqCmy/AXAdeomSU74imnQ67lx1hpwUAY?=
 =?us-ascii?Q?9ipl2sPAHT4eNs8UgIkhxhRndIZPF/8rVVfRSmwAMrqmhOzdjyTJodM/LQyM?=
 =?us-ascii?Q?bSwuUPMqwp4ks0+jE4dAUwheJ4x4ecUYSifHuUtySg1fZH4YYHayOMTOZqRC?=
 =?us-ascii?Q?GlxL3sjO3ZXQ4+cqzvFYuMq96zlLfxLvl9n20Ws3JaIQ0w6ZM1bdwlPF8WzB?=
 =?us-ascii?Q?yMQp9lIm9Yd1x06i0eN/c7hOJtdAfswZf4boIaUpJNBovxvIcZb8AgVIGL3v?=
 =?us-ascii?Q?QyT0FLx3CtNWbPmi4j2kL5yJB9wboAaAgAGbkEO/AeTLopn2MgJNkNgRZRKx?=
 =?us-ascii?Q?lbLV81QhVyOpPru+CDierUiulqIDPhPnzy+JS5GxCGUKIwv9Lx2lZzdcvokL?=
 =?us-ascii?Q?FDUu84Nk4dIKnrvtzEipJzhWiR9qUNPwqAwlc+S/IhnClEKLloTMUjg8/NCS?=
 =?us-ascii?Q?ZjZ5IrZyIeNFTd482mkg1/DgrmAJvfomFQAFk/ZEBkC3mHO/ojTy9RTHaf/p?=
 =?us-ascii?Q?QaA37R3VUp9gjWTS9trBQiCQDAk0w+r+lYylLkb8IZ8lEvxyqfkehKb8LrIj?=
 =?us-ascii?Q?khO5xkTSsMN4DZKsqUbM1xCsa3uVhALcMuGwB5nD5MDic3iMV7Bxb4BkmF99?=
 =?us-ascii?Q?CvhZPdFRbMnl+3JjQUg0kwOqHVEt5Ow3gSmHPB8/CLGHLjKkKfz0+ZLKIkxY?=
 =?us-ascii?Q?8LCF2acCJ5BigLYl4k8+rw7GoQsyp2Li760foToR/cMThDFQNH5Qc0R46K4A?=
 =?us-ascii?Q?a2yjVj/om7mZe8VFQlZ+wNRZzSsYRzbpxjyy3V86WB3oc779ltIdU23+Zn8r?=
 =?us-ascii?Q?ubnr1xl1pxwoGbMv5joA9yl/7nkksZc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc6104e-1326-4abf-7cfe-08dece0c64f4
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 14:09:36.3510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DyVYAdrtdcQ/bwhBL0W+ZWCi33KfC0yOZQVettdsxVdq2ouEj+Ae+klPYmIrFXxTY0x61gak/4DcqEoVSzpbpP6u9I4LvXQf9oxWyFzNbgI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6284
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 14:09:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23236



On 6/19/26 2:35 PM, Jan Kiszka wrote:
> On 19.06.26 14:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>> On Fri, 2026-06-19 at 13:56 +0200, Jan Kiszka wrote:
>>> On 19.06.26 13:38, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>>> Dear cip-users,
>>>>
>>>> as part of efforts to provide a hardened base image, I noticed that th=
e
>>>> swupdate suricatta module is running as root. Hence, communication wit=
h
>>>> external parties (like the artifact download) and storing of the .swu
>>>> file are performed as root as well. This significantly increases the
>>>> attack surface, and makes us vulnerable to path traversal bugs, like
>>>> fixed in [1].
>>>>
>>>> swupdate already supports to switch the user of the suricatta dameon,
>>>> however this must be done via the single global config file (there are
>>>> no CLI options):
>>>>
>>>>
>>>> suricatta :
>>>> {
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 userid =3D 65534;=C2=A0=C2=A0 /* "nobody"=C2=
=A0=C2=A0 */
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 groupid =3D <??>;=C2=A0=C2=A0=C2=A0 /* "swup=
date" */
>>>> };
>>>>
>>>> While this works, it is tricky to impossible to integrate in CIP, as w=
e
>>>> have to know the gid of the swupdate group upfront - which we neither
>>>> know for existing deployments, nor do we set it in new ones. If the
>>>> group is created by systemd at service invocation time, we have no
>>>> chance to know it at all.
>>>>

In trixie it is create by systemd-sysusers=20
https://salsa.debian.org/debian/swupdate/-/blob/debian/master/debian/swupda=
te.sysusers?ref_type=3Dheads

Quirin

>>>> We could use a generator to create a derived config file that is passe=
d
>>>> to swupdate, but even that would not help in the systemd-creates-group
>>>> case.
>>>
>>> Referencing only by ID seems like an SWUpdate upstream limitation worth
>>> resolving there.
>>
>> Working on a patch.
>>
>>>
>>> But we could also fill that ID during postinst, enforcing group creatio=
n
>>> at that point.
>>
>> This would only work if the assignment is stable. Otherwise we risk
>> that a locally changed /etc/swupdate.cfg freezes the id (as copied into
>> the overlay) while the /etc/group file is updated with a new one. That
>> is a worst case, as it breaks all future updates.
>=20
> UID/GIDs must be stable anyway, Isar had seen a patch proposal for that.
> CIP will naturally have to pick up such a solution, irrespective of this
> issue here.
>=20
> Jan
>=20


