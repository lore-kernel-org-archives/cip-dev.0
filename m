Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC6FCAC5B0
	for <webhook@archiver.kernel.org>; Tue, 23 Sep 2025 10:57:21 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.21])
 by mx.groups.io with SMTP id smtpd.web11.13952.1758625036961081895
 for <cip-dev@lists.cip-project.org>;
 Tue, 23 Sep 2025 03:57:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ZeV8D1nD;
 spf=pass (domain: siemens.com, ip: 52.101.84.21, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+BeAL0aRqxYTyAYR6eHIAf0tEITNuiXTXC0I1mcRLCco1cVUBqCg8MTNq0b1Dt9M3MFstabMriTKLJO2vH28BWQbGOoB6busXindrzTTcP+lAPH4rqq7mXEb5QzgunHWEB/I+I/6+TJwJGIxDpHuGsadsekMbRcUD/TYiXN1KacmSoYmZO+ecCcRzIogjApERDOUI2W1VNEpYcTzRC0J599vunjafUSnXcwJQ7UZ2Q4do9rKe/IyGC/fQpaPvgNf6teqX6TNux567Tg7pQ8bd+LvP7UTZNWecPCjwzF3iWPAGzuFi3ajVcKeB5FMLbBTVG7B1G3luvsMElV5QUBvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNW0yRXmDh4cn5Ov0rplID1yByFQnXeHa8Ja6RliQ2g=;
 b=wdhm+IqXHuFlDNvlZkGlKG4NUZYkq7TjODTyNwK980lRFiqAwb6L7wq7w83y3BKsdw2S7jWXBcyqxwwiVNdoG8WkIAmndxGjM/02KfFe63HiC1KWzweGW7NTmXz7R5gUan8fYKGDeBpuRDPWerxK56M1a7DkZ+ZXOm5buAWpCu921NTMjL1q37gJMBtrPP0l44wPv1I1kM6AJ4vbx7drYorFO1LykvYrWjiMkQzMOZP/+/8CmvBSN4wQyefDAjdBpLbbkBObJ/FHROmw7+TScE1N0fo+jpWaIpD8YvHiUgeZspcfRkO7MsrUeriVhy7vL8u0KnbDJ7DmVrxRIBuOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNW0yRXmDh4cn5Ov0rplID1yByFQnXeHa8Ja6RliQ2g=;
 b=ZeV8D1nDQs/gkaKW06d7y7B2tsZTnq6o8Ol3q3mfEnJYEKLavyOsDDZ2NHByMiWJMCCnlkxtc6QiIHE6wy3nT0OR3JegPxCanFLRA+kfoaNPO1FNBQ6h5XOrouSWVFw3aK0Vue3XMysE6ay/vzzvIPgrnw69GTNxwIyZO4gF6lvJUKJkNutk/8OqyUsGoerlDfEHejlkZ+ZTGBptQ1gtgr2iNd8D7dvqpCVm9EPolVeFvt0SPrrJ5WCOEtdl3ksA4fO8nW8NhRwoq65MPvr+HEOsZPhCCS+KVILAFapjRWfLd+CcbD0Tzfpf9LHB9HzqF27FXGkeNMa2R/mC+I/b4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM9PR10MB4117.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 10:57:13 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9137.018; Tue, 23 Sep 2025
 10:57:13 +0000
Message-ID: <5cd09e93-7366-4a6a-8709-ba2bc4f314e3@siemens.com>
Date: Tue, 23 Sep 2025 12:57:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v6 6/7] Factory-reset-helper file
 is incompatible with encrypt-partitions
To: Quirin Gylstorff <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org
References: <20250923100734.319688-1-Quirin.Gylstorff@siemens.com>
 <20250923100734.319688-7-Quirin.Gylstorff@siemens.com>
 <deccd90e-14fb-4129-84d4-c09cfd64c98d@siemens.com>
 <e77657c6-e371-4ad6-a488-34c423f145d9@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <e77657c6-e371-4ad6-a488-34c423f145d9@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SG2PR02CA0128.apcprd02.prod.outlook.com
 (2603:1096:4:188::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM9PR10MB4117:EE_
X-MS-Office365-Filtering-Correlation-Id: da728ea0-6ffb-4c57-f143-08ddfa8ff381
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?YLiL9f9MsSWQRYEel2bD31Tfn9VzFGfbYI2GG2ijCm9Zvm2Gy5pVxeaHE263?=
 =?us-ascii?Q?Y9X4jT9oCNKVVkKyP1GJELDaeOz0iMYEtd1o1AW3nz43l2E8Bp6c9u9PK5li?=
 =?us-ascii?Q?pYthxfRstxDdSR99/od7AmjO7nvq+mGtfJy0OK40k8zFbqFD0FBxr9OAWgrH?=
 =?us-ascii?Q?qi5O571wGCT4s8+aUKwyo2Vrc17lsrbJ7e3NEfzDSziE1Zn2NLq50lmHM5VR?=
 =?us-ascii?Q?r3CypuRrY57Gev4s1pMAMt+X3ISTz+ZoLXH5VXo/9KDaw8JffdNnbWZLvDqG?=
 =?us-ascii?Q?kjWoaM014YInL/mdblFDTYVDzRMUmC9wAF3lUBeOYQGKNfHiG/b+Jvxz2u84?=
 =?us-ascii?Q?LsTpkqEU0wxy/MIkoGuk2YVwuXdJVls/jDSJ3NjYo54baNLAXT9vnLN+yxt0?=
 =?us-ascii?Q?ccN/+/rlfNCKYgkzeB8ROeVwCiY/ChBo/cv2N26phSxCO+labQO+pqI236Bl?=
 =?us-ascii?Q?wllu6In0k26d5oOybnNk2UN7VoxycZErMlx83Bg54Ixi0/b4fgfiCO2Q1Zgx?=
 =?us-ascii?Q?5JPiy3slJ6BD9zJcWr3jPenkg6v7IIYuEo+4h5aVF71JeG03XGB+khyCS4kw?=
 =?us-ascii?Q?XVOvtkv3hHeBHRpNfIj9vb2z37cYkT1ajMNL73LJI5Phux/DcYwI8u3tKOmN?=
 =?us-ascii?Q?UONyJngc89FoHNAYYTMzy8z2UntEtBorNIRF5czglPAVq4xyo+qW2GOAFSyo?=
 =?us-ascii?Q?+S5uK7IYzeJgu54bJggLQOb4wyEwMJtKy4DvGB7gp08lG9OjZ/65f/Jdjdoe?=
 =?us-ascii?Q?iwknJh+G8h9OANjtFwzvhY6Er5RnI39+rVWkg+Px2bHRxahsumnldWp2X5Q8?=
 =?us-ascii?Q?JaOQ8dLdeBVKpW0VeFC8q9ro1GPuSxBcOxXhOGItJfzs6SjYSHpf8+CrS8Nv?=
 =?us-ascii?Q?glG7lAAIIqjpXj5ID89R7YmonBD+DV6d8uRTNU5xHbsBej1yb2EEIMIRja0o?=
 =?us-ascii?Q?BZ/DO+UXl3vTGp8p5/O31RVzpnJB6Yp9j/N/Lu9ZuCREKEL48svMwbDPlzcx?=
 =?us-ascii?Q?C5ygUiZXuvCad9CvpPK79+Zyn+hPOxZfDqduF2Zz2UwsNk1D+j5h6hIie1q1?=
 =?us-ascii?Q?X9xwbrRvYXfMMYsyt5QHNUY0eDjSPgkTMtmhTEZs+OqZtK+3zdQiOkOXDEpz?=
 =?us-ascii?Q?Re293P1ER0R1O0COe4GhVSOfkiWlV4cwg9y0H0rhuYD3m6AlPClDYqjuvc3O?=
 =?us-ascii?Q?nPLzctTEoW2Lj07TCVQojraFAvGGugsE+ctsRV4PvFRNvF4fw5nxSTFfhBlB?=
 =?us-ascii?Q?F4YqL9FZ0LXbt2JWMYKA3rIBDmIOiGUILUXeALOZQZvII4T5oHj8w4xsQ6Cn?=
 =?us-ascii?Q?619ITfLP9Yv7dQeJdAyW9DaxbNWebuA3QrLEnvIQNubozPJEUtkTHx+ru3xE?=
 =?us-ascii?Q?LYaeeJJLsvSPQ0oGXQ1DMM61/PJV/jd6v/+vyuzOVFStEg+z6Bci6536F9h4?=
 =?us-ascii?Q?WGSFs4cSeaw=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mNLqNso7gM+0mQ2ehbHiPlzjVGv8shUZ4Qhztl4S9HGxMgIz16wytY9cFboB?=
 =?us-ascii?Q?J0mFe6L63vTlUuOyfWU+oTXC6NJRU5c/FSmt4DkloPtNxJMeoi7g7YhIkCk4?=
 =?us-ascii?Q?YfN80+PhmRSeuGyrYuv/9RIsVSo25QGx8b+t2FxPzBiQgzETjE0QDG9OkuKK?=
 =?us-ascii?Q?hY9nz+uBoAve3+V8KUQVByBWGZxLW+8uN9vd8nyi8yySpQy0Y8fUhDCB9ggH?=
 =?us-ascii?Q?fWJSlahToGbM4tpTWMG+yRsheOIKQOyLcL9BULokYAZSoqA45Q5oMTwXf0We?=
 =?us-ascii?Q?ks7uTh+iwv+sxF0r5jz3SeLq7PfDoPpgSOWxAVBEQXrzQRv9yBweA7VAomvm?=
 =?us-ascii?Q?0VSfrsexwpsNyN35BrT6J+KhX/1NVmgZ0MsDhBoOup7kLiNKXagKgdwNDXN0?=
 =?us-ascii?Q?+9lR8imWD0H2JXcz6s8y92q4riDSV4JvPNY2aIR5qwaPD6i9zlByLf5Ed3En?=
 =?us-ascii?Q?9f1P5oycz2SBFlY6kJCG+FbVBFf3O+r3yImW71MnNVbQ12ksQUR7qUX11ekP?=
 =?us-ascii?Q?VEUB8XEQxZ2MnEEM6DQCxFLomCHfK2rgzgw7jlY2IZF3pCua4jISQb7e8Tgs?=
 =?us-ascii?Q?g81xdYLuJQYzCuIlsLu6tH6utYnxfCVLIoWica5rAshn0yd4ee89Yz1VSdB6?=
 =?us-ascii?Q?NH6cujK1R/Pvu0bd7d3rH9Owhcw/A8Kv2uqGkOnNLggReTPe6WYq/emfZeOw?=
 =?us-ascii?Q?OSYzEIOlpCSCTAexkZDJ57Fbwafo4Xme5JYRHKK93soivQrWZcphUl8eTQGd?=
 =?us-ascii?Q?cZbw3pxFxshxJNO/T4jxS795umhkBbfGJQFr9b9fYFnWgNTzcH+CAansb/Uj?=
 =?us-ascii?Q?ePxClskp+qUWYbjVRTHEYVcjkd9bl8WsSGTTdY6rRVH2qkPO5cGSSxZJRVP1?=
 =?us-ascii?Q?9uCyChIKbj00AaYstXc7X8JxAsPDVJUfQSphs7z86FbX2cXoA4AG+jo4gGop?=
 =?us-ascii?Q?abVsOm4MEVPH3Pw6PMi5CvOAyaNb+8f5DHxeWFgulyvyzxAw/oDSMm3eDn/K?=
 =?us-ascii?Q?mxQswdOwcwfTEsAQJ6pIQ4Swfrfe0pini7TYaDP7YbXti2FnkAP5B/VivAuz?=
 =?us-ascii?Q?5UmOyEwG/qPgLbiPLDXwszbYSaK9Zn9URcJ9w+H/wtvaGd1T3g+lkSkEsGBY?=
 =?us-ascii?Q?LnFecyAysVYnFxrbMwEY7swbRewxGMBkrysvLYW3bjMpS2jKTJlqrd4ZbmwC?=
 =?us-ascii?Q?DldnPbGNaeew6EHJWDmpreixOYrlO1Gij3B29vRFBbv120wBt0GYugw4sMWv?=
 =?us-ascii?Q?I3fti4f37yKdyPye/q3f8AQk3UPOSat/xoUr3h/gxszFFBYKH9pkF6RHCJJR?=
 =?us-ascii?Q?BUCcv+qe4gSrcNoGXpd71yd8umMzIaSm+3iTrydJXal+RZyGDmr1VQiepusr?=
 =?us-ascii?Q?vHqLKDhp+QnU5T0eat97CrNOOwpwqH15PjKJ81ItN7VocZCgpHf/+SB4avpj?=
 =?us-ascii?Q?zjC1F/y5Y9gb4zHnRu+Sp9qScu78+9HDT89Q9qRQ8U5xOztvfnpz3ybFG7xD?=
 =?us-ascii?Q?Vdn593Bc9Pdrlaii8oU7oNyfu4Bz9RpKo9XICJ0QFwRov+JNXJjeVKyzuVuX?=
 =?us-ascii?Q?jSZFR4zA9OOU59bjCcaowyuYKi8EDE3twtsyzJMRVou+o8nGfwvQHZuOeUvZ?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da728ea0-6ffb-4c57-f143-08ddfa8ff381
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 10:57:13.2065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FPbMexv+RL7vFH1P1wWyUQygT+1/DZhZnN8u5HjfkavK2gfMlGkrOROkCQoAxfbi9kSnS3YqvJBBZvCwhp340A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4117
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 23 Sep 2025 10:57:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20106

On 23.09.25 12:55, Quirin Gylstorff wrote:
>=20
>=20
> On 9/23/25 12:54, Jan Kiszka wrote:
>> On 23.09.25 12:02, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> The partition which contains the reset-marker is encrypted and therefor=
e
>>> a factory reset cannot be detected. Print an error if this incompatible
>>> combination is selected.
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>> =C2=A0 .../factory-reset-helper/factory-reset-helper-file_0.1.bb=C2=A0=
=C2=A0=C2=A0 | 5 +++++
>>> =C2=A0 1 file changed, 5 insertions(+)
>>>
>>> diff --git a/recipes-support/factory-reset-helper/factory-reset-
>>> helper-file_0.1.bb b/recipes-support/factory-reset-helper/factory-
>>> reset-helper-file_0.1.bb
>>> index 8d82663..14870ce 100644
>>> --- a/recipes-support/factory-reset-helper/factory-reset-helper-
>>> file_0.1.bb
>>> +++ b/recipes-support/factory-reset-helper/factory-reset-helper-
>>> file_0.1.bb
>>> @@ -17,3 +17,8 @@ FACTORY_RESET_MARKER_STORAGE_DEVICE ?=3D "/dev/disk/
>>> by-partlabel/var"
>>> =C2=A0 FACTORY_RESET_TYPE =3D "file"
>>> =C2=A0 =C2=A0 DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs,
>>> bsdextrautils"
>>> +
>>> +python __anonymous() {
>>> +=C2=A0=C2=A0=C2=A0 if "encrypt-partitions" in d.getVar('OVERRIDES'):
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bb.error("This recipe is in=
compatible with encrypt-partitions")
>>> +}
>>
>> Intentionally a separate patch? Or should we fold this into patch 1?
> Intentionally as I want it visible.

Commit message comment?

But at least it should go before any enablings, thus right after patch 1.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

