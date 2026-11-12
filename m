Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.32])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8054.1794466242309769280
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Nov 2026 22:50:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=STLeSCEs;
 spf=pass (domain: siemens.com, ip: 52.101.69.32, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQiaAUhNEmgZ+3opdc8CsTG6SjnRAfkVkfyJzOib2hU8mUa10mywhHCbTp9lbz/H7D3/MpUzjvcVNvTBDYSZE4/I9yydIqplHnQdAgdKqzvlcYfNjhwj9mrrNTJEJaZdMs+0b0HVqXyW2jsLmfZr4MSBAULKmZtxuWv0+0oiXr8DOag3xW705C35LjSY8KrNayBHnodMsvujPA4au2dcf7as0pWbDHMHnABPDbzX4y08iwIwlDLEgrbkxgz1PBBWr77ps7n7S8fv093FKngdwfPrBDTQq92iihMvoouGq9scN5JZ3aDKIWGL4uh5tNjwj5GG9BrnwYqvPJflFG2m1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7reH2wElJHKZyRFN9SUe/mnCSOmTzjl1OwkJKh1F3e0=;
 b=uaRLxsW1d4EaBv5W84eIOAGbdbScqTE3rOTWOy+9Xmh3JZAKdkMU6a5mkeDosvafq+f5+ZUZC62TlVK8Zu9jUQWYLXVkdDOPOjkoOsDMYB4mV9Df7FVG87Tdop7Acx4nu2Ywm2DPmsagbUbZVd/Xs1S9bLSbvuaJZBgROLQdBKXOXM8UZEm8CcUXkdoex+GDIzh5vRG03NAd4qiKbh1JVS2eVj75sVln4HkkHtYph74MfPHih1cu9k/acRFJtoE0+N9KGyYjJzjVrjAtja3CSl7ArPIOSGCgJYoZIl3VdVosGe6gclQnq5VC5qPPfn2F00hfT26NvlJN9vRNEjpT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7reH2wElJHKZyRFN9SUe/mnCSOmTzjl1OwkJKh1F3e0=;
 b=STLeSCEs3yxbzV8h9bEfwBsb20bUxKg6+6mj23mW4vwI2e2nvu+uFLhqbs0ZBEVhQnAyqsBRccyd+ruUj3nrAQnL8qtcA+G9WPAAOQ1KuZr5mhRmmJX12t6myWMD6NG4UanNYAy5UySjOQVC/epA/JqNAwmGRxJhjaQWxt1pjK+BYZKqyEUZ5oh4QIyqOcMs4NPaufROW/qDMrJx9CJsEfjPmdkacnLOKUcRe9GuPbUERQVP8L3jwQrnyPsQa6opsH/0T21Nnpw/fRWXZ9MH5xSnkVrRiaa2PFlv4ErLh8jUEDZEllip9AmeAZ4az7IAMWdqGeKobyqjqtOaZzSSaw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10) by PAWPR10MB8257.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:386::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.0; Thu, 12 Nov
 2026 06:50:37 +0000
Received: from AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e]) by AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::fbce:789a:27cf:d1e%5]) with mapi id 15.21.0615.007; Thu, 12 Nov 2026
 06:50:37 +0000
Message-ID: <82a4f2fc-1ef2-45a2-a8df-49e62f3366e4@siemens.com>
Date: Thu, 12 Nov 2026 07:50:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [6.12.y-cip][PATCH v2] Add SECURITY.md for the CIP kernel
To: Pavel Machek <pavel@nabladev.com>
CC: Ulrich Hecht <uli@fpond.eu>,
 Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
 cip-dev <cip-dev@lists.cip-project.org>
References: <be8e94d0-45da-4f96-b60e-20b45c9f865c@siemens.com>
 <avTTo3NICDkmFgEO@duo.ucw.cz>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <avTTo3NICDkmFgEO@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::12) To AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:785::10)
Return-Path: jan.kiszka@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMCPR10MB992291:EE_|PAWPR10MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 26097c74-44b3-4565-8986-08df40894219
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|4143699003|10067099003|11063799006|56012099006|261022105027099003|261022075727099003|261022113327099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261102123227099003|261009223027099003|55112099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: oT4HGWWAQZlhQzP5DS1/8c/0EQ+fE32DSYqkLUMsynR5nI4ge7Ql27azldJl8fez5Mw+Esx6rmP2eLFeepmqYGbuiQNUzQpSmCOz1H+jd2H7Smg/9H91cX7v/78G/SjniuWLKbrRpizrzMI+PDLBLZCQ4XWPx08Zy2sxUoHdDMYUJgnB/FJaMnh+FbzhPoTcNC0BSeIMvdqtLrvgWvpVpCWV67KR+ctb3sMyrR8MHhnf1gL28xdASNgZfFHINoLkiLGtmO/3CwdiDxNZFtawTtb4CUdLqvS4a7r5wRVxTqD3nvp/ptMQHC16OYFsjeSGiUdpaqtHWqg9usgLB0EM9d/nSPc3abed6H70Y7nFTK43V4IGYZS2lEDeMIVUThVdTR8douOgABvaYFGJ71+7Edn9yxGtiUcyx2OfWD28YPLU1YAlUlUXwrBzTfvPUWv+WYkY+IX6ezT5NT3OJT9FkbXZghAIlNOt/VwJ3F49L69SRo0rLv3Opo2NGFxL8OjYn5YjEegKczA0cDS+c90UHeAf5Lzt6vMweRh6N+9HZ6Qm4jkEDJni9ee0TUht6CzDieNYHHMmQOXsAE+wVj0kPi/cWL1rH//glJiPB7uS6/JEND6/nOLAg6Qwu6tgqLbH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(10067099003)(11063799006)(56012099006)(261022105027099003)(261022075727099003)(261022113327099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261102123227099003)(261009223027099003)(55112099003)(22082099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XUmLYAaWA2PUqSZfmP+rdp/d3mdW9MAswcH130a/spFUNe1Og9KIJQTv8MGs?=
 =?us-ascii?Q?jABbT0aGNWHFuT/0fX8bCqGw5YdAmt840RXeqAllC41TF2MpRk4cI2mrGBCD?=
 =?us-ascii?Q?zD1bYWUftsK/tVesExQ0RYcdVRbx/y3WkIp3vgQ6mIjKLKJ5za9gL3XtPVeE?=
 =?us-ascii?Q?wlsk4A1XBW5TCXAlMpCa+jm4DsQLhaS+SfFEg19YavXEdT99388hwRZpH8HH?=
 =?us-ascii?Q?754Bfeb8Aw8qt8F7lEFZTJdQp9qpKBv9hYcEeJdT3eK6ZUdhT9ZRRQykPfcR?=
 =?us-ascii?Q?F4XQH7c/bletUDwqUlKeiRQ0wz/2vl/QEaRcJQTEW+0HvrvNo19HZa6QjBDR?=
 =?us-ascii?Q?uPj/d/voi1aLOGsxHEl6zex2mF7gjUoYf9+f2h2kKafiTYiE29CVfmUIPIG7?=
 =?us-ascii?Q?3ZLLSxUT+zLBE/f0+/rAWO4rWzOvlQLAO0ODPDoLxXJ/oQYfh+jGrHPuxu+7?=
 =?us-ascii?Q?MvjGoY4iYWMXpIL7cOznCCU/yQONmcoVDTaChjhKsBwg0WlGR3Dz36wETPDf?=
 =?us-ascii?Q?HQGmCwb4d6sIOz/5gtCBa7wlICD0DxNKuTCKKF2KczD5ZNxfMgygj0NXvpFj?=
 =?us-ascii?Q?SUpywOcG7mc5k7hQ7Vpf6tusffjK8iFVQci9+593otO3R1dgmn3SKkBD1h0o?=
 =?us-ascii?Q?1q0CdThoxDVrrGC/tg7+md844Uwdvtk+RJe8Atkhj33TXbuijK8CR70fGzjb?=
 =?us-ascii?Q?mmXFgybpk1Pex0u9uaHLTBmtgPFGR5N6+rfSA5kBKO4gXAuK2w2Z6WjkiW7o?=
 =?us-ascii?Q?SerNf8ZhlwX06icB1Rfxocv/kPmwNb6j7vdX6PxkvrQCYdkLqHXX91t0ZJhT?=
 =?us-ascii?Q?A2qrfR1AKAjhHbP1gzbYw7HjsEpfjrDj8ZOPRm0PuvGtZe2R2/HicgVhaKVp?=
 =?us-ascii?Q?vnIsZ6InijDWe/62tlm/fLoGi7DCca+h/AhI3PjH29hjJeSDFwKmoXpcwwJo?=
 =?us-ascii?Q?kTHLmCDIyAr0crOUMFALHQW69+FLBHUOp/lypJPCNfNeDUgrmoKb7H05NEZS?=
 =?us-ascii?Q?kiHxGB54K8TKC86jQexcN9XCqOGtluS6ADDHYSYrvRgdpLdlYkotbCFv7Dhv?=
 =?us-ascii?Q?6fqXlViLd/MQGLA8Y3Qd+I/oA4SsFRsdmkA6c3fcZvws6lBJ9iC5b4BMiWss?=
 =?us-ascii?Q?o4ZdFN1oVGGEETA4K/stJRuFhax4NVvdL+s9uNBSiu1kqJPwQwmi+DryiKEM?=
 =?us-ascii?Q?koTmA2qrWzmOYDFNhDiG81iDiW/zWSIvKorFhBqmD5kVu9Xglwuspa98OrEx?=
 =?us-ascii?Q?SYSo2W2TFpUUgQz7lcGEMmFHgUw+NE00TwvGZyVFAvDHu1j0X9gmm+6tg0TB?=
 =?us-ascii?Q?1ymKmZqRm1+lhb032WfieAtQo5fDQagKBce69RNirZKXqPwmuTvE3md39Vdv?=
 =?us-ascii?Q?9FyrVnuM6SYdOJ7UpiGAEQEahMoSl5Y0fmlix1LedIhTp+bkLI/lfvhcnjRv?=
 =?us-ascii?Q?0JXl37g2WJ3VOsMliuc52t5/FJh1wCWLg6hA5jpT5ugmhU00asakJoO1MXGp?=
 =?us-ascii?Q?FtxFoOa9zGuObNWfRd3Uu1UtnwcjyKx3ZEoWIt9IZ5VWtn7TBDyyVzxsGag5?=
 =?us-ascii?Q?6QPmfxLkJN/4YIkZNUOgCdNbAfzfIYqLtElVWaeDnKlA8SQuIhykt8ugemn3?=
 =?us-ascii?Q?fodFS7Bpc2D0XqEXmpsr2TItnTNml7MP0yh8Nd57Cd5Cg5HOFLLf7lUmLss6?=
 =?us-ascii?Q?f4UQSiQl72EKB97yt86QXGcJF+7s0XpKfmpy6IZont3dA/xOr8PRBfQ4txgV?=
 =?us-ascii?Q?FM2i08i3OQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26097c74-44b3-4565-8986-08df40894219
X-MS-Exchange-CrossTenant-AuthSource: AMCPR10MB992291.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 06:50:37.4693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ro+U0+8gGlqCM/2fTKpOBQNI7c8usfiAiVSi7SZrVhCQdDh0jEikwBtUnXitHH1EVKvqiOwG1TxeFw9jYef3DA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB8257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 12 Nov 2026 06:50:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24770

On 11.11.26 21:44, Pavel Machek wrote:
> Hi!
>=20
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>
>> This describes at which time which ares of the CIP kernel are handled by
>> the CIP security team and how to report vulnerabilities to it. It
>> furthermore state the this projects falls under the LF stewardship
>> framework.
>>
>> As the original kernel documentation already contains a reporting guide,
>> leave a note there which one applies to CIP kernels.
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>> ---
>=20
> Okay, so poor reporter starts here...
>=20
> [A--starting palce]
>> @@ -3,6 +3,12 @@
>>  Security bugs
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> =20
>> +.. note::
>> +
>> +   If you identified a vulnerability that only affects a CIP kernel, pl=
ease
>> +   instead follow the reporting process described in SECURITY.md that c=
an be
>> +   found in the top-level directory.
>> +
>=20
> Goes here:
>=20
>> diff --git a/SECURITY.md b/SECURITY.md
>> new file mode 100644
>> index 0000000000000..f39a0178338ee
>> --- /dev/null
>> +++ b/SECURITY.md
>> @@ -0,0 +1,37 @@
>> +# Security Policy
>> +
>> +This project is supported under the Linux Foundation CRA stewardship fr=
amework,
>> +as described at https://www.linuxfoundation.org/security. Security
>=20
> I would not mind " " before ".", so that link can be clicked (here and el=
sewhere).
>=20

Which programs have problems with that? All the public renderings I
found were fine, so is TB.

>> +vulnerabilities should be reported through the mechanisms described bel=
ow,
>> +which we will coordinate with our CRA steward. For actively exploited
>> +vulnerabilities and severe incidents that may require CRA escalation, p=
lease
>> +use the project=E2=80=99s emergency security reporting mechanisms as
>> appropriate.
>=20
> ...and follows link
>=20
> Sending an email to security@DOMAIN where DOMAIN is the domain of the
> project/foundation. For example, Linux kernel security vulnerabilities
> should be reported to security@kernel.org as described in the [[Linux
> kernel security bugs page]]. In some cases, different email
> address(es) other than =E2=80=9Csecurity=E2=80=9D will be recommended.
>=20
> Link makered [[]] will send him straight back to [A--starting palce].
>=20
> Well, problem does not arise if someone goes through whole SECURITY.md fi=
rst.

We can reword the last sentence: s/as appropriate/as described below/".

>=20
>> +## Security Context
>> +
>> +Open source software can be used in various contexts that may go far be=
yond
>> +what it was originally designed and also secured for. Therefore, we des=
cribe
>> +here what the CIP kernel maintenance is particularly covering and what =
is out
>> +of scope.
>> +
>> +Unlike the upstream kernel, the CIP kernel is maintained with the focus=
 on
>> +architectures and configurations defined by the CIP project members, se=
e
>> +https://gitlab.com/cip-project/cip-kernel/cip-kernel-config. Vulnerabil=
ities
>> +found in code paths not covered this way are considered out of scope.
>> +Furthermore, vulnerabilities that are affecting the upstream Linux kern=
el as
>> +well are in the responsibility of the kernel security team, see
>> +https://www.kernel.org/doc/html/latest/process/security-bugs.html. In s=
cope for
>> +the CIP kernel are issues caused by patches not found in the correspond=
ing
>> +stable kernel (linux-6.12.y-cip vs. linux-6.12.y) or that are related t=
o
>> +missing backports after the corresponding stable kernel went end-of-lif=
e.
>> +
>> +## Reporting a Vulnerability
>> +
>> +Please DO NOT report any potential security vulnerability via a public =
channel
>> +(mailing list, gitlab issue etc.). Instead, contact the CIP security te=
am via
>> +security@cip-project.org via email. Please provide a detailed descripti=
on of
>> +the issue, the steps to reproduce it, the affected versions and, if alr=
eady
>> +available, a proposal for a fix. You should receive a response within 5=
 working
>> +days. If the issue is confirmed as a vulnerability by us, we will reque=
st a
>> +CVE, publish the fix and give credits for your report if desired. This =
project
>> +follows a 90 day disclosure timeline.
>=20
> AFAICT what we are saying here is that:
>=20
> bugs in -cip backports in 5.10/6.1/6.12 -> security@cip-project.org
> other bugs in -cip for 5.10/6.1/6.12 -> security@kernel.org
> all the bugs in 4.4/4.19 -> security@cip-project.org
>=20
> That means that SPARC bug in 4.4-cip, for example, goes to us.

That is is excluded by following "Security Context" -> cip-kernel-config
-> no coverage for SPARC.

>=20
> Good news is, that we have CRA contact at linux foundation that can
> help, if we need help. Ok.
>=20
> I still believe we should publish GPG key for
> security@cip-project.org. I know sharing private keys is usually
> no-no, but that still seems better than potentially no encryption at
> all.

Even the kernel uses no GPG.

>=20
> I guess I'm ok with the patch.
>=20
> Best regards,
> 								Pavel
>=20

Thanks for reviewing.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center
