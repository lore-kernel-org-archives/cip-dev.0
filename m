Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7947C4345F
	for <webhook@archiver.kernel.org>; Wed, 24 Apr 2024 08:23:03 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.73])
 by mx.groups.io with SMTP id smtpd.web11.11507.1713946977456764440
 for <cip-dev@lists.cip-project.org>;
 Wed, 24 Apr 2024 01:22:58 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=FauLqkEu;
 spf=pass (domain: siemens.com, ip: 40.107.7.73, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TwRMd+asgU/0p1Aa7VWlYenxX6Nxb9aRb/oTt2eNN02IsCpW9WECteh/HuVMlY0zaz84m25DxBjA/22n0pHXIiTHMfrqQAQ8vO1bksCtSDDgDnCHHo8eNxl5XiPPQdQOHXWVEjiLfvvNIzZHbDKvYBA/7hG14M/4RzMRETErofsNBJVBBKCwxM/K3rOrhWEFL822Ewg7gtcDKyrie72AI/x+pNVndVk0sRClHe0nA97iBXZL+bIMNjha5a+yeJdqnLklppOF6/Oc97xqAxawL0srShLiaDaH7e8A6Ni+uJFCkRsnd0kFJUBc3chr4tsyG/D+5wvTR+KY1IiyjlpotA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bo09iv2JLqzlp69b9ayT75ujv816EzGbWEOJlKoDbSU=;
 b=LeGlURxlPZ3uzvggVIT+ARn6ecLc7NX47xINPVuieGkXrYiC0hjRsmBzxG3YXeaxhm1aQWAy4Ah2JOkWZk/h6+SR30YFzN93rWX/yHkY1Y8KdJ7BVKX4+XjPErvldQX/r9mRr2ZwjkvGxOwq2Nf+FuDuEX4QgFIK3Y77ZFee4xnDROt8mh7V1zWD6IvcGLB17pYN5xEhYAm3/qrhUp8UvT/sz10IkCb9/ngsdyzdedQa6L9DDKJ12rosY/hsGDFb9pkF8mhwZd/Merh8zi5fLH3IVnocP9P0FPvhRYNrYQWCK/JcCvjUWJ9fl4E1NlbDg6x9/5Mtni+Uu1k2pOPZmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bo09iv2JLqzlp69b9ayT75ujv816EzGbWEOJlKoDbSU=;
 b=FauLqkEuIVbX5000qFx3IDs8xCLMOs4HnfbbBqflcbKEaDs8Ex6WYoDBMZalvcigCP8hEviNYvIWaDMkLcASaD6R+KXKgi29bN5kQUmlelsX6jCJyq+KdUrC9fKf5+vNko9WWm8UB4KG3phJ+25RKsqPPJFCgw2zVAe2wz0P1VeCISDjfL+mmEPwyoGy7p0ryxLg/BkC3Im6PMhE7aF0+uUSbzcGmRBHU9ezyt5NB79ODO1xkTVWNDJizmbaKQKAF7O6detcFcbo++wLFuLNxTFW5QWfYRRG2KRnz7nQHp00ZfLwhIr5l1TeGLVkjsIpjdi7UXaeKkEEd8BD+jn89g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:a5::7)
 by DU0PR10MB7093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 08:22:52 +0000
Received: from PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63b9:9cd3:ded5:9f16]) by PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::63b9:9cd3:ded5:9f16%4]) with mapi id 15.20.7472.037; Wed, 24 Apr 2024
 08:22:52 +0000
Message-ID: <48f21a43-2c6f-443b-a7a1-acb36eb16762@siemens.com>
Date: Wed, 24 Apr 2024 10:22:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 4/7] fix: use luks2 to identify
 encrypted partition
Content-Language: en-US, de-DE
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>,
 "johnxw@amazon.com" <johnxw@amazon.com>
References: <20240422141120.577573-1-Quirin.Gylstorff@siemens.com>
 <20240422141120.577573-5-Quirin.Gylstorff@siemens.com>
 <9154239823f08a82d34c8810a51290e8e557fb40.camel@siemens.com>
 <69e0e19e-4600-4df6-b1f6-e159c71440d0@siemens.com>
 <ab7a2cfe1fe1cfed3111c95e06e06b8bec217ea6.camel@siemens.com>
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <ab7a2cfe1fe1cfed3111c95e06e06b8bec217ea6.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:a5::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3PR10MB4096:EE_|DU0PR10MB7093:EE_
X-MS-Office365-Filtering-Correlation-Id: d55ff008-c369-4532-14b2-08dc6437bbe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YIbXzZEtZ02d0fF/vm2qA3+k9kzAGfNCYooo6Db68ituYS+EQBhXwWkyp1ul?=
 =?us-ascii?Q?QxKyedQtp51Yz2GsO/jrPXFHT620ql+W5sTrTZbPXMOhZXgZWMzlP4tOT0NH?=
 =?us-ascii?Q?uim2kytdQZr6i8iQQJHn31e7Yz9SK61QScDgmQwG6IljaQUOTTfiAr9xNn37?=
 =?us-ascii?Q?K6n55kj0mn7Kzyui7U+LydM5gMbcQBLIJQzd3hSl5ZQ1mpejVzIQyjuAccWd?=
 =?us-ascii?Q?HU+Qwx1arVojeyt3mdEQP0mUXXq/qvC7PzfOKeBRlx1kzgW+ltplFxO50y0a?=
 =?us-ascii?Q?aUa6Sv2P/Z+fz0ZuanFY36XqwiHBzaiXHUBE0ZSrzqLXbEOjhKR95fPnULPt?=
 =?us-ascii?Q?4VmoSLOFWJuybdLhvPugjthCd+1XKXMKjdfD+aux07jwMVRCZ94BpOenQwnk?=
 =?us-ascii?Q?K/O7pxN0PqeKXMmtWS9TdpEqdc6agoEvoUiZqMvr8zGnqvYmfO3p2YuNk5Yo?=
 =?us-ascii?Q?09oIrYjo0iibamMLz8jGU1xh6m8jZySv7ofkvJJOPmz++PNu0V+jiWHl9NUj?=
 =?us-ascii?Q?XALkUqo/k4iT7RoCnfrXfOjz/RDAAXgQ/IeVfSxGzPCpqQ1F1F41XP3hzqa6?=
 =?us-ascii?Q?rshkRu9Z4phYv1omJS1CIhYlHK/mI5LRKrU+Irf4rhscoW3YWc4Mmy2+GR/5?=
 =?us-ascii?Q?52Hn9oHkNLx5CbbVJyiEN4D/1/rnObY2Ej1CmdhHN+lDIvJwL/YDr17MIE32?=
 =?us-ascii?Q?FQaEGC7jaKFHPmHEpfPRtzlzOH33snwSEXBCGEEOsIC3qiZKh+/6rCqfTc6y?=
 =?us-ascii?Q?mkiBXrXDEoWiMuEQ3U9S+WqzWaKq3pUrt80fjQKYk6oc1PvygRkKt9c+muM9?=
 =?us-ascii?Q?E5G1GIh769+KXGllfz9frQup6jZMvA0RSY77GvU5hvYPHH+Cwj5KSvmGoAv6?=
 =?us-ascii?Q?0DvnYyGm+FKG01pUIvEZPhP9Gwagcp1Wc9HzGlT33rECarlxNyWzHOh33ddr?=
 =?us-ascii?Q?b64/D16XPN9HA28t8OBfFssnUfTM2udVsONW/yWkEGVszlLKYt5HkL5sMdx5?=
 =?us-ascii?Q?HJeHvP6zwrpU708vzyStOeSkwCSPTjGjFS4ydNiW344igRx99e6OcXkzeoLX?=
 =?us-ascii?Q?z+zvnv8jXkF9vp9srTKabPnpwOzh9ntCqGxMTRwemeFcqn0gAFF3l6zujQtU?=
 =?us-ascii?Q?++T0uV17IK4UMMpobvwIP2o/TCnmBw04t8i4V1w9QgtLn8FTK7m2+8hZiI27?=
 =?us-ascii?Q?rc9T+yfIRyVnoUNWVArwvrTFKSBy1uYOa3JyN/Ca4sGWACGzI6C5L715sSzU?=
 =?us-ascii?Q?bkJWnNU9fw13hokcJbyR/YI+rMEDVnHqi+zrtPRmSg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xd/tvyeQon4C/IjW08LKUEVhdmxa2KrUtMdZD68SNZnexIWsRzGmioRXUN39?=
 =?us-ascii?Q?Pw8KWIMwCjhOc8X0907iGgyOUOc7LNS/WRTrLAjZRSElQ+FhHHWPlDV3MR32?=
 =?us-ascii?Q?t7INwn7mWAENsmjBKSfJYQNBNBjCNAKhMepHnptUyTEtp8u4pffGDFsu2eWC?=
 =?us-ascii?Q?YZL56FqRKGXk40SvZbi6BVphL4S0QC3ZWgwnCQgksy+JHJvGbIwbFahnqW5S?=
 =?us-ascii?Q?DGg6OCiHwK9cgYPOjcmB5KzpkC9r39krSca7IteOyj1BB35cIot2FGZ/Zcis?=
 =?us-ascii?Q?O2GoXGiA/NjKo8/gzrz3CpLU/wDPqQbds7h4g7XcD2hUcghhtJH1NtPN0XlT?=
 =?us-ascii?Q?R1sh8THOArKA4+MxnNjuSpR0Lziim0fSiyfAKeqifloXsi3/ilOwvkypHZ3r?=
 =?us-ascii?Q?fXCsu7sues73W37WvVM/OCuXWJKvsdRzZ+YhUGQvQMXSutv4Pqbcv9bLwFAW?=
 =?us-ascii?Q?43ccpdyGU4NspPBgIbYkurWPuhrLIQ/RM90VDYLSezJ2+0sy2kkfpvpqhpw2?=
 =?us-ascii?Q?IPR5U+Lh7csYFPHt/5jxMrxCSq7szUGKgjyLtlEvZ4KCB6OCRqbyXUJrP2eF?=
 =?us-ascii?Q?I4wgnq+41Y3Rp+3rvV5kYaImo3aBkNlwNTr61/+H2DeSFZ+r6wuooppD/HJ0?=
 =?us-ascii?Q?EYZyy0rEEMBQ2VwFS6eVNjl0rqaBQbfzU4DL9w7yPrv0tzpuWp9VEDYzZq7p?=
 =?us-ascii?Q?RykHB5YbG1M/2bcBndPQHVhPjf+YXbaiuGty0K6PrvsFpHljdOsT6IlQS6ab?=
 =?us-ascii?Q?aQBZZAgDLPI6z6Et+kLetHBnp+V6woBiBSJXyM4rHcCVaKCIrgB2rgBufiDR?=
 =?us-ascii?Q?xIYW9UmSGZi7tfv8xoXOYNV7TBkztCwGzLbadR3m/GmviGRkSZCy4xYpZrXW?=
 =?us-ascii?Q?rQ1GIJgzq8dPZ6LqKepJzj49fPqm3urzyVb7So6s3jj1GpWVzkQ5u5QMQokD?=
 =?us-ascii?Q?UEdkgdIKGOBrttEr30NjGpkzPtkPZ19BezkmTEQvJ13quHxaTqb0/sQZpLIO?=
 =?us-ascii?Q?yNX0s0EjOagPYzRHpguvhuojHmCkV21jcO09HUKcIUfZsUl10Jpw4/bULpcA?=
 =?us-ascii?Q?2SOEnMdD7jpDpC1sDLrT0vtaeRrz8SEUFOYlgV5AvOVrRhguX5xXghQStADo?=
 =?us-ascii?Q?xgPi0R/FC/wwBJ4z1N4AstZHfiANEpLW2jg5Ks8gbYKzHMGAR5Rc8ysJfLrm?=
 =?us-ascii?Q?c1ShJAIQzYis7z5QT9nBUBKmI+Y42y3GsGN5+haQ4R6qdcTA6TdVnSg3mVE7?=
 =?us-ascii?Q?YuCSENt0HG7tz/sGl9cFJNYYs7T2II2xXEk/CWrWEPOvbemmhwHL0Cjmx2nN?=
 =?us-ascii?Q?z0bewoxbhjPBJ/ujHKsrtfDqKu6AwK+aaPx+W4UkDW3336QCdlraJgQD3FH/?=
 =?us-ascii?Q?nTMiF/q3exmxNShh9L/210zFDlLgM3FAZ5uU/ORehorLXF4eOeS1EzxjdfKk?=
 =?us-ascii?Q?mEBMMl1z7IEIgcGJdYzbpd6n/5jkF3IzJ/Z0DwmqUs6OpSiM0hzZL3H8WuY/?=
 =?us-ascii?Q?kIUzSmX3MiDYNc945Yw4vqzcOhbLQKHlmb6oX6IrKhENQrDut+E0zta+ZYCT?=
 =?us-ascii?Q?WT9wSfXtZbDCoaJ01tF5lsggH9n9WGYLDZPY96GJ/1ZL+dYobls/5orvHFbt?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d55ff008-c369-4532-14b2-08dc6437bbe5
X-MS-Exchange-CrossTenant-AuthSource: PR3PR10MB4096.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 08:22:52.0967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ccovbfPRsBGI1n/YSTh9AIThAHbSR0nNU6qxtW7f31i3m9uG3/ZaPF3ysryeoxCxfVHAcuGmqSEdjFxQejq2OenkdUl3kmqtL5mv2WTLFY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7093
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 24 Apr 2024 08:23:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15742



On 4/24/24 10:00 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Tue, 2024-04-23 at 12:00 +0200, Gylstorff Quirin wrote:
>>
>>
>> On 4/23/24 11:35 AM, Moessbauer, Felix (T CED OES-DE) wrote:
>>> On Mon, 2024-04-22 at 16:09 +0200, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This fixes an issue with encrypted rootfs during system reboot.
>>>> With the token option it can happen that during reboot the no
>>>> valid Luks partition is found and the boot up fails in the
>>>> initrd.
>>>>
>>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>> ---
>>>>  =C2=A0=C2=A0.../initramfs-crypt-hook/files/encrypt_partition.script
>>>> | 2
>>>> +-
>>>>  =C2=A0=C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.script b/recipes-
>>>> initramfs/initramfs-
>>>> crypt-hook/files/encrypt_partition.script
>>>> index 51c81f3..685d882 100644
>>>> --- a/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.script
>>>> +++ b/recipes-initramfs/initramfs-crypt-
>>>> hook/files/encrypt_partition.script
>>>> @@ -134,7 +134,7 @@ for partition_set in $partition_sets; do
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>>>   =20
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if /usr/sbin/cr=
yptsetup luksDump --batch-mode
>>>> "$partition" \
>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "token"; then
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0| grep=
 -q "luks2"; then
>>>
>>> How do we identify "our" partitions in the first place? If I read
>>> the
>>> code correctly, we still identify by label, which is quite risky.
>>> Otherwise we might re-encrypt partitions which are not even under
>>> our
>>> control.
>> We cannot identify our partitions- we can use label or uuid which
>> leads
>> to same issue in the long term.
>>
>>>
>>> We must either identify by UUID,
>> UUID can have the same issue as labels if not used correctly.
>=20
> Hi, the difference is that UUIDs are (shall be) globally unique - by
> definition - while labels only need to be unique per device.

And because of that global uniques UUIDs are not feasible for an=20
automated way to encrypt partitions with the TPM. We need to define  and=20
identify the partitions which should be encrypted - independent of the=20
bootloader because the EFI variables only show boot partitions for=20
example data partition are not part of the schema.

And using /dev/sdaXm, /dev/mmc0p1,... is also to brittle.

Quirin
>=20
> It's well known that UUIDs in the embedded world are not THAT unique,
> also for reproducibility reasons. This is still an implementation
> issue, while label collisions is a design issue, though.
>=20
> Felix
>=20
>>  =C2=A0 or at least limit the search to the
>>> device that we bootet from (this is known via the systemd
>>> BOOT_LOADER_INTERFACE on recent enough ebg versions).
>>> The encryption should be independent of ebg.
>>
>>
>>> Felix
>>>
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0open_tpm2_partition "$part_device"
>>>> "$crypt_mount_name" "$tpm_device"
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0continue
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fi
>>>
>=20

