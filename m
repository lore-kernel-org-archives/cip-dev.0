Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10DA2EEB566
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 08:30:21 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web11.43383.1726129810579095794
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 01:30:10 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=nCNVwP9D;
 spf=pass (domain: siemens.com, ip: 40.107.20.66, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3KY0r2zUfI2KU+i7AqbbAJLWO9YvFQ85rsOolnz3sfIL1hEeKYvolUSJHtBt0Kv4Nrw/yXeEUdL35hvSQsHkACTIMxVjYuoQzU1uWefStMxpXPFZD3CD7OiNi+JAOwArfW/dbs2jiT7Y8LWn3x7UZzij+tycOjUMAC6KD6JM3c5lytLKv0XFIxayGfrOQvqqQnqIAqs9xNhr7eOX7uVjzvrLkoSn7DaCcxmOevCG48DZZpSAUwJ85GAbK0Bxn4YvE1KNE8Cb+T40jCcKhUrcl6Cwbg1QaUj27HhJXpBApy80nJ9do4JD7AlFwi46MheMilT6B3MHJutk/beHGHV/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YxYkoFP4aJmpqAAwWxzLgs3L60pp/kYo8dvCPexcXU=;
 b=Fi2timOtapbV7xedppZ039DCx63L2+Jg+K5a9O1R5AOm4V9rksbImV30yEcXQRRrIfQaxEPcfnmt0uVbPiO8FgiiHUTEf45kxF9Jqt50jnYkPPg8tBnjabbxo+YS1mJFvsQ4mOcmjlv4SIuWQJsVdWVbIx1dvlQVf+NtPvR0w0rLmumg+sJO9ww+uY069qQ5od9fNMs1bqRFJiC6o1/Rgty8MGHZucVJPGFrstAHqj8IW03kktZm8kDlXqlcAWvIFoH7rUHZLvQkS3McQKbICd5WNXbkWiNWFIOwzb5HD9sCEZRXvdo4UObhKIwGniESDZOCTRqVNYKdUuhpqfWrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YxYkoFP4aJmpqAAwWxzLgs3L60pp/kYo8dvCPexcXU=;
 b=nCNVwP9DhFzUI8pn029CdMPFAydGgcDBI4UkZbeW8D/fgYvtkv+JRjQSj4BgUHVjx5WQ9Kbc1j5MyKHeJ3aDc98Rk/oym+UyqfmG0F5bUXPgYKeJswgc2csNMeARPV55iq9wk1/TixrS+1lZYYg7/sY6lqKiWe+17Ft1BaP2ihWubDBX1Fpz21JMCs1JNkcR9Hb1Cws5S52ukwi14Egi0R/P8A9TAnHvPGsF73NAv7G9hrK/4CpfW3L4dMVC28aB8cnn9jYrc2HilT1UWg2In+eboowYATft0ZBFFc2diCRw3vDvG3EnUwqcUo6f9WR4Lsz0mO2SoN55Gh1Aro6OkQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1f9::22)
 by DB9PR10MB5618.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:30d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 08:30:06 +0000
Received: from AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2]) by AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3087:c116:dfed:1ca2%6]) with mapi id 15.20.7962.016; Thu, 12 Sep 2024
 08:30:06 +0000
Message-ID: <f3dea038-cd6b-439c-80ce-42bb8b3e1434@siemens.com>
Date: Thu, 12 Sep 2024 10:30:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][RFC 3/3] Update README for swupdate
 signing
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
 "Kiszka, Jan (T CED)" <jan.kiszka@siemens.com>
References: <20240909112309.1028531-1-Quirin.Gylstorff@siemens.com>
 <20240909112309.1028531-4-Quirin.Gylstorff@siemens.com>
 <647a038e-f6ce-41cf-b878-0b153b605a33@siemens.com>
 <d25be0d3b59c1cc988b102468210bb3aeef4a968.camel@siemens.com>
Content-Language: en-US, de-DE
From: Gylstorff Quirin <quirin.gylstorff@siemens.com>
Autocrypt: addr=quirin.gylstorff@siemens.com; keydata=
 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
 XSdq0hnpafc1V+voPJq3LMxUvLNrwg==
In-Reply-To: <d25be0d3b59c1cc988b102468210bb3aeef4a968.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::17) To AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:1f9::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR10MB4085:EE_|DB9PR10MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: cc4d67e1-255e-4460-633d-08dcd3051ac8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?w/6UV5wAbQ9p9s/FWkesAUtGw9oUrQ1O98cyIvsnxxfOjI3dB+2LQyz5Mspx?=
 =?us-ascii?Q?6/bmCr5eJ+9OTzMTZLqhf8OcE8WVVibeY0LlrEcaqUhA0xnOsyjlC9tu5yFM?=
 =?us-ascii?Q?7IPpOZY1GOq7YDKHhO/XOX9Txu6FT9iRlLySYWh6PTk0ZobOQgsP3qS4+SPq?=
 =?us-ascii?Q?+LXFd0HDrA3vgWENf9nW7+MEUUOZJCYhhr/crOSjqb+NfhPYUd8oZUao/+Lb?=
 =?us-ascii?Q?4y7J6RloT9KCdh1E0jIC0Sey2iT1XNQaapWHZnxkcGVAuIihv75xd+A5Ivke?=
 =?us-ascii?Q?PPAqiBIvxozYWWL3Fhr3LbCSiQOaWkYSGYXxqbySC8nTAcQ123gyRrDU9S58?=
 =?us-ascii?Q?aUURYCiBtP2W49LA0nl4RxQMPIX1YxMUsfYj90ihOFE8rPxj/xPB4Mk2Dpoe?=
 =?us-ascii?Q?UmEkeNMtu7KhLx2W/BQaH97HqWRsPlnsxpthcZZG077VxA/Z/Lj2joFLzulq?=
 =?us-ascii?Q?9hizs77V5DkbEgydfqVk/h4/ZstUoZrxgDzffmAaWFH4bvfY8Tz8DfmRWa4Q?=
 =?us-ascii?Q?QPY28Z4JzJIYdoF4IBJ0gffn/kcdpSTnEwMK9SdzzBHNwbNbuvITzXktMnXa?=
 =?us-ascii?Q?HTlWzHqacxLtPNWBAyP6re/OAC2K1PSABV5LMi+E5WuL4NFXclqiXQnVd4xT?=
 =?us-ascii?Q?w1M3Mor+8Dykt+mmfQJZG8bFP06zSk+JPXSNs63EmZ0Wm5cJr7088K0bKD4B?=
 =?us-ascii?Q?3iWjnmtMKHfoLMsNIsdmkSmC289V0aClr2p4vrm4dq10nFv82TRifS9MevqX?=
 =?us-ascii?Q?fHg3m8LKPsaws6pFPZd7XzwDaJUJXDAsdKBVFFp5ByUNHXsbvcLo1jDbMMXy?=
 =?us-ascii?Q?ZBo01tKZfRudOu+6WjKeoZIq515dn5OclrVmh/MBYMAl5QUd7dJGbxBhd/VY?=
 =?us-ascii?Q?Fm1UO2bKnt66Dqo+KhAHEGtmqMxc6Dqss0frIdAASEJFyF6AAksF0DZzUMaM?=
 =?us-ascii?Q?mlWhQJ/2s0dXhn8I7HuIKhtFShurUd0MOIY4Ro1C1lLIQjrlSfHXUu30Dzs0?=
 =?us-ascii?Q?KQfUiwOwg9FhjWCXGLZcjEVGqPHz5Mr5G8KWd7VdJWqwAr+pOvPydQHb4bgy?=
 =?us-ascii?Q?N+qcrVGZZyMkmQH8XR8GnFvSRZZvmnRRjxZWqvgcVLTFesMpRQrgi1/LY3vl?=
 =?us-ascii?Q?KUNXA65djvXNR+exSB4ctn3hMky3k0kdYQ0ek50kHmgcqwKmoz38tUZOjDuI?=
 =?us-ascii?Q?n2VU8ia1Vtn8YfN85SEiQ2d0tEUMdeY5jHNsyLBSufWL5bQO8Xzrf5D0Y+63?=
 =?us-ascii?Q?kFmJOCsRcHfs8UHg6Icgt01E4eF9tWiUGU1JyVUBblP2GeMQ7976WM/SQ/2W?=
 =?us-ascii?Q?oDfwZE3+Dmx/GXHrotOoGrozmjcu/GH8rEDm8q1yRtqiIA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ap2+p6eQQShMpVRoCLUnl6nf85ecnR2ibVD6J04ajhnL9uuPoK3F5TzXe8vk?=
 =?us-ascii?Q?Mo8oLdicgWyJIr4M2RRCZxJAxsQHf7N7ivfUjaSJ73ph5fTpGPmNOgEQYZtr?=
 =?us-ascii?Q?49G/K4k/7bppGUH9FtD9xmHbRwvsMztNRj0J6rt56PpW6zMwAY6BdG9NWrkT?=
 =?us-ascii?Q?K2eHtY96XYMSgAihBNsFce6bENpagRVvvP9X/NEID1Bp9UcDS9du3K3Ektcw?=
 =?us-ascii?Q?7DXi1HMKHUK9MXeLhNKuhQSaU+B3tHaGrl88cE4R+5TZlqqiKMs2pLkKOu8D?=
 =?us-ascii?Q?CBaxpT4pXpRK2FmijFAqcv875k8k44yF3R+04rH161j2hcpgFWLi3lqVND8e?=
 =?us-ascii?Q?/2EdkX8oEhBbX4i9KcYC4rNLQyX9goz+c9AO7GDEAjpEtUvtwjYl/RhCjS2+?=
 =?us-ascii?Q?6hoNp69xeqrzj9BgbTqKs9pZbdwn3CSO83zQieHWl7XbkiEsnHu9Ze5s8s9L?=
 =?us-ascii?Q?2pMPWvaFgNt5JdkUjcVeTEc4FRDCdATF+6cTbmHqp/yepTZe4k/S5kbU9B1W?=
 =?us-ascii?Q?aE8xjN3JjT7in4oS5rjJSr8gZXiTXtIFhdTZ1x7SFVek0D9uD+TgUONgVaei?=
 =?us-ascii?Q?YqZcTjQgMGlfYm58P+Q+pCsTcFTEgqeDwEyNtB8ZCeyTqn39SwrKs01FL6hv?=
 =?us-ascii?Q?m/EM0QhS//xSM0YrrW0WCPaPS1oxhbutWTDtX3DtQNswmnYqVqeO5ZnWpuUc?=
 =?us-ascii?Q?wFbb2/T3/DKqA20vX4o/5mBX0PeGO7efgZTFuUUyUhmls6xJbPEacllOuJxK?=
 =?us-ascii?Q?S5vr17hm5LbJ1EimqDS9EM7igIBNiDlg+OacDTMlmDTtTGgwESf/Vg7W8u5p?=
 =?us-ascii?Q?WJffJUCB9u6qJNJzq1+zrX3Pn9LNbPJVKoSix6uJ0Aq5qp3ZJ4+tq+cq8Xsz?=
 =?us-ascii?Q?07KKHU7PQ/+29FEePg6I7hSEg2enPLq5HvkXUUjT4pUxaR8BH9iY6cxIi6yn?=
 =?us-ascii?Q?GLvZ+dO5HTcTDQK9PfKOjAxVZvptOFjCk19NVSMRizbu/ALaui0moT9HAe+J?=
 =?us-ascii?Q?fZfDK7wlP/B61+3thEkuvUM1aiphe85HvQhY/s1GSL/BjkwR+9Rx8s/w8JSY?=
 =?us-ascii?Q?AjMW6aBMkFZ05AfxqJynP1/tD+na9SvleX4ZfwjDf4lJHqag0SdPSPt1hh8h?=
 =?us-ascii?Q?fNqVmjhhLu71VaJLK7pSvmfvssAAlDT80cu5IVWCNiGFTjGXeqgeePlzP22K?=
 =?us-ascii?Q?+cj2RYLs4mUVQGHd+E5vLO6lRM59yyzefD5diLg/T6OfpOiW5RH7K5FrwYkP?=
 =?us-ascii?Q?XMEZWlnBiUpflvwUKWLMhDGDzraPRPogaL7V1yDif6REHVqJh/bHkjsjhbcP?=
 =?us-ascii?Q?vYmKCpG4Omk0zfc1oFaGbdGOeHFP2J5LcNlQ3vgH5gwNW+VLmbQhSbqkZZ/2?=
 =?us-ascii?Q?s3xtHfj2WfugaAbIA69fXvZ6TdJjcbus5JovCePot9IEzIhno14RHRbHz50q?=
 =?us-ascii?Q?gR8qW1sokUE1mW9NSjYn7/OYBh2fe2z/0ooMBGaBYHBg7kbfznCfCXqbu0e1?=
 =?us-ascii?Q?qIk0aDEXZawpdpbsHilk9bhH3KRDdngRLoyq5l2HMikKn8KCvCkw4LWGPqJL?=
 =?us-ascii?Q?aSbVjqU65iBHptPUJCEG7pZ1OIlT6jWnMwMWm2gPGYfA37n5/sDX/6JQFjht?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4d67e1-255e-4460-633d-08dcd3051ac8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR10MB4085.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 08:30:05.9483
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMdc8PsPSzwQjhFqGRGqAgZKSVQJ58Z9kOMbFsQdCn7qyb5KOeQNina90zhNYAh/32vChfXsK0QPWDUTq+QrcLhpWwpWC9A1firITEbTwVU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5618
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 08:30:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16889



On 9/11/24 9:51 AM, Moessbauer, Felix (T CED OES-DE) wrote:
> On Mon, 2024-09-09 at 13:43 +0200, Jan Kiszka wrote:
>> On 09.09.24 13:21, Quirin Gylstorff wrote:
>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>
>>> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>> ---
>>>  =C2=A0doc/README.swupdate.md | 16 ++++++++++++++--
>>>  =C2=A01 file changed, 14 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
>>> index a5fbab9..421ca1c 100644
>>> --- a/doc/README.swupdate.md
>>> +++ b/doc/README.swupdate.md
>>> @@ -138,6 +138,7 @@ PREFERRED_PROVIDER_swupdate-certificates-key =3D
>>> "swupdate-certificates-key"
>>>  =C2=A0PREFERRED_PROVIDER_swupdate-certificates =3D "swupdate-certifica=
tes"
>>>  =C2=A0SWU_SIGN_CERT =3D "<sigining certificate file name>"
>>>  =C2=A0SWU_SIGN_KEY=C2=A0 =3D "<siging key file name>"
>>> +IMAGE_INSTALL +=3D "${@'swupdate-certificates' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>>  =C2=A0```
>>>  =20
>>>  =C2=A0The files `<sigining certificate file name>` and `<siging key fi=
le
>>> name>` need to be stored
>>> @@ -145,8 +146,19 @@ in `recipes-devtools/swupdate-
>>> certificates/files/` or in a path defined by an bb
>>>  =20
>>>  =C2=A0### signing script
>>>  =20
>>> -The provided [cms signing script](./recipes-devtools/swupdate-
>>> certificates/files/sign-swu-cms)
>>> -can be replaced by setting the variable `SWU_SIGN_SCRIPT`.
>>> +The package [swupdate-signer](recipes-devtools/swupdate-signer/)
>>> provides a [cms signing script](./recipes-devtools/swupdate-
>>> certificates/files/sign-swu-cms).
>>> +This script can be replaced by setting the variable
>>> `SWU_SIGN_SCRIPT`.
>>
>> "When reusing this recipe to inject a different signing tool, you may
>> adjust `SWU_SIGN_SCRIPT` as needed." Just setting that variable will
>> likely not help...
>=20
> I propose to completely drop this interface. If you need to use a
> different script, provide it via a dedicated package.
>=20
Then i will also remove the swu-sign-rsa alternative from the package.

Quirin:

>>
>>> +
>>> +
>>
>> One newline only here.
>>
>>> +Alternatively an own signing script can be used by adding the
>>> following lines:
>>> +```
>>> +IMAGER_BUILD_DEPS:remove:swu =3D "swupdate-signer"
>>> +IMAGER_INSTALL:remove:swu =3D "swupdate-signer"
>>> +IMAGER_BUILD_DEPS:swu +=3D "${@'<own signing package>' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> +IMAGER_INSTALL:swu +=3D "${@'<own signing package>' if
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> +```
>>
>> Ugly. An alternative package should simply PROVIDES swudpate-signer,
>> and
>> one should set the PREFERRED_PROIVDER_swupdate-signer then. That's
>> more
>> bitbake/OE/isar-like.
>=20
> Fully agree with Jan. Please implement is similar to the secure-boot
> signing pattern.
>=20
> Felix
>=20
>>
>>> +
>>> +The package `<own signing package>` needs to install a executable
>>> to `/usr/bin/sign-swu`.
>>>  =20
>>>  =C2=A0## SWUpdate Hardware compatibility
>>>  =20
>>
>> Jan
>>
>=20

