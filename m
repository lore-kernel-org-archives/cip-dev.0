Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946FACAC5A7
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 07:36:39 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.30])
 by mx.groups.io with SMTP id smtpd.web10.11256.1758612990248564868
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 00:36:30 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=dqbhyZWS;
 spf=pass (domain: siemens.com, ip: 52.101.70.30, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ip5pOV5hXf1d7lQ7vjLNFXokfFkdgg3TY9NvPT/wFiQbTbemI/68GlQ4NtIrp37RKnwRRSLWhb8JeWKTnXgefBST2ljAbGaB9fJyyszSjh1jc7/NURaYIfDt3Tibo6GJZrUEcCyu8VVPAp7i02ArHbNMLvHRd8g74ASkK1lMMxQMsDkOi5WbEnL4keeJ9xrnzJp+KXO6ZbtMNv/4vjLOgJRmXu6mQ5VyyKhYWR4zjoEcfQB4R6Z91ixBTR/aUieRGc+wuF0i/aR+MWu7uwkAVR+v8d8aaRleyHUTMr3ofobgggs9gN86sGqQV1By8Gti4CdtjA9tR0tIO/03y+3+wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UDduDTxZPdxYjVaZt7LbLAiDnN/rammijS+AfV8sy8A=;
 b=mzxktjN9/BHS1oncWlcArbMAaNY7Y6OAaIYcGVLvqlTf8uZP7ZZxE7spsszLi7475rgshDZYoDnZFRb7qbm8Ne4+UFBtPNw1X/fZu5jih5WQeizIdSyVQgKhYmfuT+9RxkRJTuZQFW9acquqWj+Hl4ZMXEh7KktrOWfdhN9ZrtOPeH7iXebRE/V2eDzc8kovv/koAlyVXR+Rm/kY9k7VfS6WBy3dtgcAK3kMP2ZV+WbmTQi4twBhX2P1J5jRlbta+I2HB+vpELw7WZeIp4HxkGp0CiNBTZxfJCJ/dwCKxL/VregbwvL6RfrUIP7XBM2S1GjiFqcL2mgfoLGz9hYqPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDduDTxZPdxYjVaZt7LbLAiDnN/rammijS+AfV8sy8A=;
 b=dqbhyZWSKJ3igZW2fen2zUVKaw15RoNWNYGTlTfjph0UTkxgw57hYebHng2n1tCrpm9FczJOoYM/t+PXRXO9XQ5xk3nI7DkejE/WkFYiwcj3681bQ5D/RzNwpMldgGw2YMP4tV579RCr4hDIY9ajKOEfY8FBB6oRZUDNi6bm8e9kUYyADW9MfNZZ4JStt5B+7rwuojiPeJbrSxB7vl4ZhnqgDUe07bIRIHiUMWGV7iM0CF3CE0KIru51Y1xuxw11yR4yN06cAId00QWqLR2m7dRC7e+GF/uHx4ntyOD9dU8JInOQ/6nQDnQGA5OlU9c9BL3ZaBSQGOXzID40KeuGTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7877.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1bc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:36:24 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 07:36:24 +0000
Message-ID: <507561cf-0070-4816-aa8a-b3e6f2f9779a@siemens.com>
Date: Tue, 23 Sep 2025 09:36:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH 4/4] ti-am62px-sk: enable data
 encryption
To: Sai Sree Kartheek Adivi <s-adivi@ti.com>, cip-dev@lists.cip-project.org,
 vigneshr@ti.com
References: <20250722101551.1727649-1-s-adivi@ti.com>
 <20250722101551.1727649-5-s-adivi@ti.com>
 <a7c8ca61-26da-4714-9f6b-b91ac8e2a8d0@siemens.com>
 <678884fe-e78d-4299-a4df-192e69816cc3@siemens.com>
 <7c34e296-e5c7-490f-931d-23e7b193f1ac@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <7c34e296-e5c7-490f-931d-23e7b193f1ac@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::14) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7877:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a447a47-4eac-42bc-5bcc-08ddfa73e630
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?egmvuf+Df9EV+eN25GyMVCYSB1nCjyCCL8IXW45S5yTKdoADDZTEl8bMOGhE?=
 =?us-ascii?Q?tD2g/GEIdD71lsrzn0JSFyc8r5uM2CsGBGe5IWbeTlDqnuepu2n8xSaUMgpc?=
 =?us-ascii?Q?EDSPHtBkauvgaUSXyNSTc1YKeC9ojsGT3bdR1XcEz1+ri9nojJqAhxkfIuha?=
 =?us-ascii?Q?7P8rhLCgjxK/pZOXQaa/4JsanX37XN5e8PG/ClGYa4L/dpIydqcgV3UEj+dr?=
 =?us-ascii?Q?XNfHmzBp+m+SdDJq6bQwc8fEgVOYuyDUtzEGbLZaBGN1D0GXZVGeBcrbjVMp?=
 =?us-ascii?Q?9YFtE+75AJnQ/3YPOA+F79KdxR7x+HFn9rhqvCjjKKiVcMXLlghnEXak0k3e?=
 =?us-ascii?Q?GlTMOW3OgbDY4pxjCUHM29a+gTUPXRBVQ0BMUGUvSFoZb5/a0gLXz9aGg30Y?=
 =?us-ascii?Q?690Sel/5G/wIyogcPjj6Id9sPs42AEvl9plHQbgHUwBs17zowEO0Q3JC0kvn?=
 =?us-ascii?Q?asPFli7MzA5hbEvBVDMWMk7lQD7Ng0t5zItViY0XEWAySCgI51cJHrLibI8G?=
 =?us-ascii?Q?luxGNxWQ3oMWayJPc6RICggWDGcvGr6KZCNpjCiUWzHGR3J73HtOe3xpLMF6?=
 =?us-ascii?Q?IHkbM9FA43vK01QNe1LmJf/dAK1EZV5lwvwKUIyyJ3bLM69qd8M/S7aYORFg?=
 =?us-ascii?Q?wXD0ryoSlyoOqS8YGP8U4z09x3v3KoPbKgf24n7luYD5DwzH4R25IQzGh7aL?=
 =?us-ascii?Q?LNaiI0gOt1iCV+ozsipeQhqf6Aj6E2g8vVRT2jGC2Ke6XFaDrvG/BqdaeO9u?=
 =?us-ascii?Q?e2pxgXG/ku8bTXOBDf4V/OikscQ+rC+T2ZzA2mkSRts2nhf4/H24N8erx2Mv?=
 =?us-ascii?Q?qTFCZ/j9CtGbkTqVv82FGIFaby2uOC5HJHakQ/+aYvKJ2Cfu5uaz9iItCHBC?=
 =?us-ascii?Q?1+0RfdXoKUIPwP6ua3vl+gOxfGKr+QlmAXI08J8EA+F0oUDNdw2czzd3xgOb?=
 =?us-ascii?Q?KDCiC8rVY0EStwrrBNZ+BOeicw2net5gKNUM9gbvaNz1rMwfwDJbJKKGXdjg?=
 =?us-ascii?Q?zHsdTaemmIiuOqWSBKJVuIj9bO9jOLZ2i2J3y9V8qH4pFN2CX4i3rph4Sk99?=
 =?us-ascii?Q?fwA67DJYaCZAYR1OO6krahvchEWSMfELBQIelY8dJtc8v+If33rih2hU+iwt?=
 =?us-ascii?Q?mW018+1F0suVOZ5SpfMEt9igeUVsOzw//8L67yc6rf9Y01i72NaDo0XM3xJ8?=
 =?us-ascii?Q?hP6vfry6fyiOc9Ja4/kqveQP8qtXqxxuZ2v2rn7jOStgv6fKtQuCqCCRbbOc?=
 =?us-ascii?Q?sE+u+3grhH0vm030GQfU6lBTstEpphsRA+sgIxX8jPwHphk45yCMfZ9n26TB?=
 =?us-ascii?Q?IRMILbKgwylB75oBeE3q3fYcVTNMywbLGVLZ5JqRQknQ7nvZNa8tR/GzsUoI?=
 =?us-ascii?Q?yOHxjWu5vb35X1WB+C41bu6CIqxp?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o9G2wMLzCBydHYIxF90ng/46s1vf7J0sazOnQssZnif1QuH355sDPrymJr7u?=
 =?us-ascii?Q?2VSEX/KyDcavtXx8dhTn3c1/yVi7GgTce01zbAZiwe2rSHpPA9twn9uMaQ/6?=
 =?us-ascii?Q?EDz09YxfCCzGa6NewjsyhhVJYqidaVanEpBTCuGNfeSsglWHaTnmwsCY+MXm?=
 =?us-ascii?Q?0RbyD/N1Lr/lKp+eKw+G+c7LfYXxrTW9axWzVQreIOMOTcH/Zh5+xQL/c7Kz?=
 =?us-ascii?Q?20K/JRngOoxz69xcwqQOrmTnFbO0pFebPXC0b26DIFOS7ZYyoCKPqrGQld+6?=
 =?us-ascii?Q?dKeO2+fPfP7xqs5JkKxWpcTJ2UpF6j3AW3psUNS/ancxODLVyIzYjkTvq10Q?=
 =?us-ascii?Q?zraOC2Mv9WYyJkBGKlHr2a9A3Ep+SsLgLujKujhNgj3vllX2E+tRSZ/hjdZP?=
 =?us-ascii?Q?F2L1KamIrNfiN+hVV+XcshnMjqVLWYPQgfkYrQycpeztbRUPuSha8tmjbFjD?=
 =?us-ascii?Q?rKxjVQt3FuLdCV3+lsRk56d0bZNHLTXsFySrU+B6l7I14dytWUr0tQOX6xbA?=
 =?us-ascii?Q?jvMtiVCyVuzwhYMviNjXz9hO0m2gTza4ZK/dq+g8xwM0KYFXrFaFZ878HKSP?=
 =?us-ascii?Q?UTFVVkPqtRs2kftuwJ0S2sY2ctVKM5A0Xbt8bciQBmfxQNPotYLcWQzhqYxx?=
 =?us-ascii?Q?/s3F1AVUj+o4mXyh+6EtlvXVE9f68TAAN1YzInJwM66npDVMSWpxr5vBFYjz?=
 =?us-ascii?Q?4LGETp83mR9mzUx0RKKgH+yhEM2lV8mpXgq2f1FQqr+m9kOaFtLh6va+8rN+?=
 =?us-ascii?Q?DQVRw7yridSekgzS0iAlTRf5+DwFcr/qH2aKOOibpm+w7hbzuTAQD441yfWT?=
 =?us-ascii?Q?EH72tONWZKVlcBix0RiAFW83ZNkc39auxNXJ9MoUU6LgZu9N8CarbXfA3dYL?=
 =?us-ascii?Q?DDj1qyCVRY0q2UtXJz9qMZ4TbZ0Xif+Xnm19+FN8yWHEiV7WH5LNb5coLglU?=
 =?us-ascii?Q?B6/sI2x94tcv/GH6GYBPfq+E1ww/uFosSNQmeC+5gf7tixnjkdBAzCYjoctB?=
 =?us-ascii?Q?Yo1C4xCr8V5VCvXrY2lVckGjKIaMFJ/ij1Leb3lSy+8eKHjTGemRdmYa8cO2?=
 =?us-ascii?Q?7bv6qQFzTASOPEUN18cWQhXt3BTdAZSnTyl44P3nbaG4l0iFytAoiIF+hX91?=
 =?us-ascii?Q?Pcdi9kZthw3Q5Jc3ETBwL3slOGkvRm8xyWQuA9kqo5t4Apamd+F9/JnrFyry?=
 =?us-ascii?Q?HVnojxIF/b3SKtxgFK5W3sr/uJQaM9pxln+eprHnZcqHexVcegiLBU1RRKdx?=
 =?us-ascii?Q?stlJTgC8aIaoixi6j0DtDEvnQOxs9nVBUe3vF0BrPs45Kv9n5aHPO2UcU/YP?=
 =?us-ascii?Q?LdjMwr+Dk8CRwD/Qy0SG62D23H0tN72x/96nbEtVy/EOMke8NMV6juDJ0N7f?=
 =?us-ascii?Q?hNf/2yEH9/RakMdYYHUCZKsSWzflWWM/K5WLqsK2f4qvTxWMJX2lYlFB+KVR?=
 =?us-ascii?Q?icvTlUa+ml8+Ll0g+KcUlHC73SaUhO9m+ht3xxsbCD9lTUVkmkf01LqWyO3o?=
 =?us-ascii?Q?sxdBn3GzXXC3BvqFXJh4wkyS39i6I3u3WswPsJBu+MZrHMvM/+jQS1965LUY?=
 =?us-ascii?Q?d/RRCskMLLFPcYjOBhYa8/9C7k2TO4iqbQI2YjO0?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a447a47-4eac-42bc-5bcc-08ddfa73e630
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:36:24.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/goQWBp+vtcJHRBX5ujKmfN2wcrM71rLjm0fXq/Bw1O4UfM9BHw18VBbSIE6MaSPouQbMVT11o6VYEZQjpksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7877
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 07:36:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20094

On 23.09.25 09:04, Sai Sree Kartheek Adivi wrote:
>=20
>=20
> On 8/18/25 21:39, Jan Kiszka wrote:
>> On 18.08.25 17:17, Jan Kiszka wrote:
>>> On 22.07.25 12:15, Sai Sree Kartheek Adivi wrote:
>>>> - optee-client, optee-ftpm:
>>>> =C2=A0=C2=A0 - This integrate Microsoft's reference implementation of =
the TCG
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 TPM2.0 as an OPTee trusted application.
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Since the OPTee secure storage on TI AM62Px S=
K is RPMB-based, and
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 the RPMB accessing is provided by linux tee-s=
upplicant, this TA is
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 only discoverable when tee-supplicant is runn=
ing.
>>>>
>>>
>>> I started to refactor isar for switching to optee_ftpm. I'm collecting
>>> bits right now, some are sent already (isar patches), others will follo=
w
>>> ASAP (wip branch for isar-cip-core - huge hack still as I'm enabling
>>> qemu).
>>>
>>
>> Here is the change to demonstrate everything in qemu.
>>
>> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commits/wip/
>> qemu-rpmb?ref_type=3Dheads
>=20
> Jan, I've got optee-ftpm to work on AM62P but Measured Boot is still not
> working. PCRs are not initialized.
>=20

Well, that may be independent of your board. I haven't played with
measured boot and fTPM yet either, and I would rather start that in QEMU
now.

> Here's my branch based on your wip/qemu-rpmb of isar-cip-core + built
> with next of isar.
> https://gitlab.com/sskartheekadivi/isar-cip-core/-/tree/wip-upstream-v3-
> optee-ftpm
>=20
> Ref: https://github.com/OP-TEE/optee_ftpm/issues/20
>=20

How about pushing measure boot to the back? It comes with additional
complications anyways (remeasuring on updates), so it is a bigger to-do
for any arch and any target.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

