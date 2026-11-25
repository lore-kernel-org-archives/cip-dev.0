Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.18])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.38138.1795595248426102581
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Nov 2026 00:27:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=g6R7KJju;
 spf=pass (domain: siemens.com, ip: 52.101.65.18, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCajej3n+j1NYf1iJOkAZQCNxr3K23FURsqQXXEd4FoHUAZQg7LY9OBaEOet+fUqEjRU4xnDJIeR/xLSnxOmkVUpxGUg26X2x4vnCDiCg504nNnWYIX9mJkmd+v6pzlV9nRgBHzq/5/36UW7f6WbaC6xhdOOTGCgjb7UBMc/8A3qEhSO2fELuWKCxkI8BbC5lJT7+3Uq8djy2sT8BMUI07UDK+zhID4pdF5U8IoiSQmgKsBzAN8wNz/mR/E3LfymQiiL/R3dGRoQoPVUa2X06JKKfKcWZQSLvJfvvTWYBc8qbU32O0ODqkRpDEazuNBgKwtc+juhFIIkYeFzCWYmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSEcfsMVElxSSB8vZgR1guDc8utoFsAkGMemqk2Z+P8=;
 b=jG5Zrym2miNhk9mJdIz3WDv3xbJttN8TXH+E1BQJgB4Y9QmzXjOS7wuDwce07EcDIVBEKZ7cpIXKObBzwANn1CCoQ/zO1Hne8/2+S9iwpb3ja1ZP7WdOPx0bHZANIXCqufKV1+eg+OSJAnqu7Iz6bkD4mqpQzI2fGlFL4JEGSF2RZFg5nS4YZOAl6uY8/qPk/xPflVfARY7BHd0wOvWfxiLvw5wjTvD/QWPxD0aq9Chfym3pyPlUwk5Hmy1GRm9JjQLPtS8wYbc89VtG+6m60R46iujx3BuGcXsqIhjNHCkyx0tl8Yi6NDWSl2OlKT+7hkE1dCVwkHy8xIGtyGJr/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSEcfsMVElxSSB8vZgR1guDc8utoFsAkGMemqk2Z+P8=;
 b=g6R7KJjujC+Vpi9ey8jfAMU/NYga7DcR57HFVkPvG4M3wXdq/frZwyjjwOHo8FmhkVJ7yEhv0hcukpb3wdtjk5IrlwY94mdmB1XZRCDyB7U4qqISaPs3ry2r1oI4TI3xtmOFSTUKCo/StlgDECwnACn2/HK7aqJh0vEJ1Cf7VW6X5EIC8DZWZa+WP73+f1jxO5WsaHR24RXfcYrz4JMRrLrGsAWRLsPdMqgY+kzPCWUh9Teh7e+CGq1Cts2FxejPX43ILr7asYwbpYdnGY4GaargagPpe0llcLw0CyNYZ60eR5av/D6GNlopW0UTsiJNao6wwb/X/ypwkqz0fMe+BQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PA1PR10MB8972.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:448::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 08:27:24 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 08:27:24 +0000
Message-ID: <ee066451-53cd-4e86-a06a-6f986ca0c1d2@siemens.com>
Date: Wed, 25 Nov 2026 09:27:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memcontrol: protect drain_local_stock() with
 get_cpu_var()
To: =?UTF-8?B?5bCP5Y+j55Ci5aSrIC8gS09HVUNISe+8jFRBS1VP?=
 <takuo.koguchi.sw@hitachi.com>, 'Takuo Koguchi' <takuo.koguchi@gmail.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 Ulrich Hecht <uli@fpond.eu>, Pavel Machek <pavel@nabladev.com>
CC: "rostedt@goodmis.org" <rostedt@goodmis.org>
References: <20261125043900.3618611-1-takuo.koguchi.sw@hitachi.com>
 <OSCPR01MB134491F796D1F30432D1990C2D7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <OSCPR01MB134491F796D1F30432D1990C2D7432@OSCPR01MB13449.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0445.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::18) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PA1PR10MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: e1bed0e9-23fc-4d97-2efb-08df4acdee6a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|261028144727099003|10067099003|11063799006|261022075727099003|56012099006|261102123227099003|4143699003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|18002099003|55112099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: d5VBWonHTvoqBwOH1VBErLWMWBH7N2xT+zY0/pbMfmviM0uK+S/OZdJp19PLcQGnbrF0zn26weUc5G2gr7wUFtycf+XNf7CtWe9riywv1N4aQUB59DqNONJsHq407LDDuTsSmiqDnkicv05ovXDVIgTuTl/pgKS3KOIklB+1CeB4EcBa0YGSekvzFfAnBHort/L4ckqUsEIgL/l3jG8LrFrvKV1QRxRX/wozoQmiyo4qsk8jUMVjpBZNeZaNezOHUa9SON8T710JE/aLTA4h3dR5z+eMFN8mWo76tG5wzpgxEwndKIe1ELbtMMm6cXIndYW++uj0dMWYJVIg+QnRwzKIYo/fKjCM6xjOog3Eoj9nK2u+orTepo6THiUH8OnsEDjxOh4JcY2NCqZ+mGPjNZ04W5zZePLOeP4SrH8YcVX+Iu+nOMioLTNe0V7tCX6S/jXHLchvgWoZqk2wUWiY0lYS7og7rFHO2jLgpI2mbwLlEZb7FEZ053oXc++8AL8VzrYLlLe2ZNyzAVVwZku6IHPUi8EHOCqQPJ/0oQCVyOzQ4OKugYSsnhvmcMBbxV5ei7K8F10hlNj1TxUXz5l0CC1rYrfCRmBVrZ5nyuoTu0QIxui358fr0fEPcQ2zFK8zxElAcqVMFHNtxM3cco6cf3V5iUWTU8y6w5nt9TBI8Q8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(261028144727099003)(10067099003)(11063799006)(261022075727099003)(56012099006)(261102123227099003)(4143699003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(18002099003)(55112099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuuGE3dtZ+iSog0czXICE6/kUEKiW20GLDr5LXsNTXfmOA8OamYz1vuWhMm7?=
 =?us-ascii?Q?Fh2pBoiIhXrroRvLlZqVelbwUzQ2DN4HoDmZlQ++auOpDoeud8XAPFD+Fs/w?=
 =?us-ascii?Q?fD81ZNM1Hwwgl1u8yoWNWUs+8h8kCTf+Qv25Lb8CPBT+KAvnMH3CgjI4rH3u?=
 =?us-ascii?Q?lln69J+yG4Jg4ztAlm2D+efSPb/9oLQkklOsS1KyDjiXef0Ro1TRdAWnV64W?=
 =?us-ascii?Q?9YZNdY4oCImW9FN+IKPEZkSJHVX06bnoDptF2xnSwKPRq6z8N8jezakLdICw?=
 =?us-ascii?Q?3mo0kx1WP/zmwfOuqL4ZrI+RfNjMCXZwMMK4HNb9qTA1sZneZLw+CRKIpjg6?=
 =?us-ascii?Q?uKm2jNT7T5WpVWfm55U0tDCW+23C6zsFKcnBpmdej0E2++G9DskJss/QSazR?=
 =?us-ascii?Q?/6rIMNPbuc32vL2cn2qMTrU5qk+HW1oRyfKlZq2EdFix5m39A+GKgog1gWAX?=
 =?us-ascii?Q?U1foUcR1Rh3HmTVWh5ut3T7xTzxyZc1JxpVNoDj0r1xb7PVf1PmBuN0II7Mb?=
 =?us-ascii?Q?P8oyoFZxrsj2WYVc6lZuGD8HgAOUn+HdqMfvs542dZPB1/EDXFkIN5qeiXsi?=
 =?us-ascii?Q?amySmcFJVj6qnhNOmGT2KfE5agn6zRWdCtyhvgbq6j/MIhOMwYykpVea6zh4?=
 =?us-ascii?Q?9DbZ8EM6vrEwgZTh6c1+/UtUd3WkMxM4b6aoQTqk2lRawBT2QTftmV06wuZM?=
 =?us-ascii?Q?lQEVPGUQaOyGg9+HYOzL+dcA7uem4n1FG4NFTh0USPkwvTW7eetc6rR8nHCA?=
 =?us-ascii?Q?qYLZA0wKZbE3mHWn9in1K8KrtEBEcqVGChJGKVaodffjL3Iyva4SNRMJla9Q?=
 =?us-ascii?Q?bmYzrQFIfMgqJwOJE7TEPu2a0MIGtJTTMMSoZU0XNoTHSD+JBEqfc0/+S9/u?=
 =?us-ascii?Q?BwQDpFz2fxt28Atco5EYMfW9zYP2nQPq0IXLjHF62atJNlOBW2vtiBltPVcK?=
 =?us-ascii?Q?nbs0qFnVvdK2A5W+oET5QotwyTvUHGxXh7cnwmG3b2hdkYf+1DaI+jSOGFsP?=
 =?us-ascii?Q?F/uwsoy/kUKjoBzx3yqovYSa7ehX2gN/I2F13G8zlFu7+CDD1a/hj/l7Zm4n?=
 =?us-ascii?Q?1JCXx7sIUE9LNVHs5BYo2svPJv9K+h6expiccamaSiovZn+tfKReONT28A2p?=
 =?us-ascii?Q?RVzkRi2uOidrDwsSwXFHEx/47TMqXZ4S6h+l6AaJUuGcG7vmvvjh72g3meDB?=
 =?us-ascii?Q?1wz+FLcJ1TjwVSa0C0VF8FKbfJ9nkWIbfBwPIL4kWdBe/kor8JpxeW2AWq86?=
 =?us-ascii?Q?FQZ+xQ+O5TrchngIFl9YzNp1s118OiPI589Dei1QajrOLh9SmMeeXUONAub4?=
 =?us-ascii?Q?xTcvInHgtAC1/YHYrlpWlaiqFZghDHfxK6GACSYbPynflvTM2TgtSGrzaJar?=
 =?us-ascii?Q?qiGiyT7d3L925Idpa0GSZKFVcBTq5lt7/6LQ5946b6wxPNfdm7JOv26700wV?=
 =?us-ascii?Q?q04BOElb5/rffe5MwmhNrsjO/X3P4qr8m3uEy/fvIZpODN/aQozqpsAPsBcL?=
 =?us-ascii?Q?jbv0s3+qloPYSH5PzXSFC952frLmHfJeheBxmlZwfJ/e+lcoTmOlb13OIxBY?=
 =?us-ascii?Q?RQhwx0zZdNzNmNrJkPvlVNSpKnvpLomphQ8s2lNeONfus8i1YR63gDVdNbIM?=
 =?us-ascii?Q?vt5JM4JBjR9npMiOoslRwk3koMAvdCCmn2i4yEEqbedSLeMpmSXDwBQidRdH?=
 =?us-ascii?Q?OxcrKkjRAxr4cDCv5cdLSrnxYgjt7njN6ztDkcgFhhy02JUCdCf+K8b0anNT?=
 =?us-ascii?Q?MQeeKnDY5Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1bed0e9-23fc-4d97-2efb-08df4acdee6a
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 08:27:24.1279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o4T73hgveYqx3/9ADHMDvKV9w4o8unCHd0+ex4Reu0TPWID1pQ+9hXhGR5DvgHZy8oCOUnryC9xC3niTuVGrjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8972
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Wed, 25 Nov 2026 08:27:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25070

On 25.11.26 05:47, =C3=A5=C2=B0=C3=A5=C2=A3=C3=A7=C2=A2=C3=A5=C2=A4=C2=AB /=
 KOGUCHI=C3=AF=C2=BCTAKUO wrote:
> This patch is meant to be applied for linux-4.4.y-cip(-rt) only.
>=20

I hope you know that 4.4-cip is very close to its retirement. There will
likely be final releases of vanilla and -rt in December, but then it's
going to be over. IOW: All users should by now be migrated to a newer
kernel, or they will be in troubles in 5 weeks from now.

That said:

> Takuo=20
>=20
>> -----Original Message-----
>> From: Takuo Koguchi <takuo.koguchi@gmail.com>
>> Sent: Wednesday, November 25, 2026 1:39 PM
>> To: cip-dev@lists.cip-project.org
>> Cc: rostedt@goodmis.org; =E5=B0=8F=E5=8F=A3=E7=90=A2=E5=A4=AB / KOGUCHI=
=EF=BC=8CTAKUO
>> <takuo.koguchi.sw@hitachi.com>
>> Subject: [PATCH] memcontrol: protect drain_local_stock() with get_cpu_va=
r()
>>

Is this a backport from 4.19 or newer? If so, please reference to
original commit.

Or is this addressing an issue that was only present in 4.4 and is not
affecting newer RT kernels? Then please explain, why. This information
is actually the most valuable part of this patch because it may help us
to resolve an issue that will live longer than 4.4.

Jan

>> On PREEMPT_RT, drain_local_stock() accesses the per-cpu memcg_stock via
>> this_cpu_ptr() without disabling preemption.
>>
>> Accesses to memcg_stock from consume_stock() and refill_stock() are alre=
ady
>> serialized using get_cpu_var()/put_cpu_var(). However,
>> drain_local_stock() still accesses the same per-cpu state without equiva=
lent
>> protection.
>>
>> As a result, drain_local_stock() may be preempted while operating on
>> memcg_stock, allowing another task running on the same CPU to observe or
>> modify the same per-cpu stock concurrently. This may result in inconsist=
ent
>> updates of cached charges and stock counts.
>>
>> Failures were observed as divergence between memcg accounting and actual
>> memory consumption. The divergence occurred in both positive and negativ=
e
>> directions, indicating corruption of accounting state rather than a simp=
le charge
>> leak.
>>
>> Under stress testing, the accounting divergence was reproducible and was
>> frequently accompanied by oops storms. Protecting
>> drain_local_stock() with get_cpu_var()/put_cpu_var() eliminated the acco=
unting
>> divergence and the associated stability issues.
>>
>> Use get_cpu_var()/put_cpu_var() in drain_local_stock() to serialize acce=
sses to
>> the per-cpu memcg stock and make its protection consistent with the othe=
r
>> memcg stock users.
>>
>> Signed-off-by: Takuo Koguchi <takuo.koguchi.sw@hitachi.com>
>> ---
>>  mm/memcontrol.c | 13 ++++++++++---
>>  1 file changed, 10 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/memcontrol.c b/mm/memcontrol.c index
>> f9d80952723c..9b298ce10a7a 100644
>> --- a/mm/memcontrol.c
>> +++ b/mm/memcontrol.c
>> @@ -1933,14 +1933,21 @@ static void drain_stock(struct memcg_stock_pcp
>> *stock)  }
>>
>>  /*
>> - * This must be called under preempt disabled or must be called by
>> - * a thread which is pinned to local cpu.
>> + * Drain this cpu's stock.  Called directly by drain_all_stock() for
>> + the
>> + * local cpu and as a work item for the other cpus.  Preemption is
>> + * disabled here because neither caller guarantees it on PREEMPT_RT:
>> + * drain_all_stock() only holds get_cpu_light(), which is a plain
>> + * barrier() without CONFIG_SMP, and the work item runs in a
>> + preemptible
>> + * kworker.  consume_stock() and refill_stock() run with preemption
>> + * disabled, so this keeps every user of the per-cpu stock serialized.
>>   */
>>  static void drain_local_stock(struct work_struct *dummy)  {
>> -	struct memcg_stock_pcp *stock =3D this_cpu_ptr(&memcg_stock);
>> +	struct memcg_stock_pcp *stock =3D &get_cpu_var(memcg_stock);
>> +
>>  	drain_stock(stock);
>>  	clear_bit(FLUSHING_CACHED_CHARGE, &stock->flags);
>> +	put_cpu_var(memcg_stock);
>>  }
>>
>>  /*
>> --
>> 2.34.1
>=20

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
