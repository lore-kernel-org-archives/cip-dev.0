Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A87F5CD4F26
	for <webhook@archiver.kernel.org>; Fri, 19 Jun 2026 12:35:30 +0000 (UTC)
Received: from AS8PR04CU009.outbound.protection.outlook.com (AS8PR04CU009.outbound.protection.outlook.com [52.101.70.66])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.41474.1781872523184582048
 for <cip-dev@lists.cip-project.org>;
 Fri, 19 Jun 2026 05:35:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jn8yyCCS;
 spf=pass (domain: siemens.com, ip: 52.101.70.66, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iCCeqS2VvXrMhFN+sNbSqIPktRYQqJCUiNDkJQTH7a3bNorDfnb4ygXKlvQDouqE6HMungaC/HzrlG7oQx0jZAsU9Rs9/7VmiNcJkbAD+UmglxpADdz0s9Web8J78tL/TK1jKf+/g5UxbFOyS2g7yhxlEmUrEHFuYycY/Es1zWBluz8ds5d/Sy2d76uXju0LisnDFpntY0TWclfI3mzFFeRwogqu96tr8bVJ/FHy6KRbuoO5pVbNula161Z8zJP3hJf+OPJShUVrX0CjeIlu+ugho69GhxlQrKeD4uX6EXEqO1y/XMDrpBOf302MXlb3P7sPoGRU1fVZy++p4bbvNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAaa5eL/E7spTVOKiViSZwV51Iob6dMQGWJZlECS5OA=;
 b=N5WoTR5MwyF10yzBP9TLUK0XYICO1gbNT4TjidtTZigMbueQc1IR12dN1G6s4cA2zdTyVDyx0Rt6mTRTxSqHRH9s3L+3vQhBjkzLfQeSKG4jUSBufykOD/bwE8bFaMDpHZAetWJYo6qQ4HkQT9VlIDoP+1wss41poBlzjvHwYfVl9bga/oo0NAEkuVHdB78bfPdlk5iale9n4SBPaR5P7I0eYBZg4Q/3rYw5eneSOg7eBRrLA56o/0v/ZLd1mXL7ujlmvovk+7+Oh/6WhcEVvU+2QTLdEQLmoDeie4eHzmYC2MutQ8DGCAU7RRvjdja/ldqiIcKYSU/3gCkea08LQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAaa5eL/E7spTVOKiViSZwV51Iob6dMQGWJZlECS5OA=;
 b=jn8yyCCSfQuuoIbg9kJIUFpds+pI31x+hh5g7VFQ88zHHrMesw+Ebd+vFY+bGsPEP2yUQVXC/gBprGfbK6R/W6RfA/jJL9AkZdOc6FJs46nOsUmk5cHtReYWMI0RGr8qsOp4SDyO0h6WGINec5uEpE4PRfakNNjvWH5f8ZgVmGbnK+pMNnGBEiJ8NGabWVTUUZ2rAhc8phgK46SxAhAq5J2DdQZI35SccBPFfdj9c6Wwhs4Wyra4npM+eiZ51AnrMc3XbbKqxP6ZHejVjGQ8KhQSbT5S3wHTIjusiRrOrtY+W7B7DXcZsZ7+yq5djbEWjtShZmo3pFGCh5U/rI39BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AM7PR10MB3973.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.13; Fri, 19 Jun
 2026 12:35:19 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%3]) with mapi id 15.21.0139.009; Fri, 19 Jun 2026
 12:35:19 +0000
Message-ID: <0042ec6b-7a82-4789-b843-4defaa80242c@siemens.com>
Date: Fri, 19 Jun 2026 14:35:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core] switch user in swupdate suricatta daemon
To: "Moessbauer, Felix (FT RPD CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>,
 "Kowalsky, Clara (FT RPD CED OES-DE)" <clara.kowalsky@siemens.com>,
 "Gylstorff, Quirin (FT RPD CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <dc698ef3e64c793fdf42c79d41cf5e8b215ddd91.camel@siemens.com>
 <c113bc29-5c1f-48af-b781-2909438bd84d@siemens.com>
 <fec35a13acac4b94b4806b4c442dd4b8a836a06b.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <fec35a13acac4b94b4806b4c442dd4b8a836a06b.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AM7PR10MB3973:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a6cc08-2633-48ae-e21a-08decdff3933
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|11063799006|22082099003|18002099003|55112099003|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: 
	MTfrZQD2jCb5VCtOEAgFlDX3jTxgT7H5LkE0AIXyupyaRNvyXhIsCDtc/Uc4A6AcMD0qeGEIQk9YDipbJf6ueMoxQIHagtQVZrGp9Ok+ynjjgpyHbt6oe6KFEYjEpQ8DmQqodNWPv01Vys0wBvOjFMk+nZf+PfK+wRB0brt6/k8CDFDNyEYMYWuRh6t41aHXFwxdAcDDMFhdiwLwxYD89HZyB/hQ1aquHeBakiORqOsZUO2mJD+DJHfdRWvB+bIn91vl4834m9G121dNVRS2T8UDGYxtzxkDAaNv2iywW6/Vq2RiFKJsVtHRqb7KythTJD6OJyx/87hj5JhqH+TjKbGV/Tn3LjWc9W1o/iwZ/tveBGYOBeg6jdWQkrIaex3+cSfSRNmwZd00Jg+SiyA0KNNGujo/8Gwtp1Wri9MxP3rCojr0k4PST6UZI5PoqFizsRqzHYGC6ueIvKxuNjwF4ZEzuUAfx65NGMZfSjMGUzsblziodrbmuO6eWsyRr6dzfYA6RHc2JKUmZ4cSJTO3mrqVXZl6K4/B4tGptF9FCYr2suXIlGII5w1qDF87T6RV4ks7fH/y6jIrbaQrMRJqJfBQLX7JMInbXN/vco3MzoDgkPsPR+wbgdkfVuRyCJeeVXfATMNIsOYaR+QjUYoL3kkZ/BYujtRbDBeaI4ausSY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(11063799006)(22082099003)(18002099003)(55112099003)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Tc9fbHbhFlrOBGscxdr8Bknh1ha/ayfT25tSFpaDKCRwM6H9k5lQVrHeekAa?=
 =?us-ascii?Q?KpWkqdE9Aqa6/zEiPuEB88cwifnERirOnXHZeL84YivkD9b25w1ADzHvpF7e?=
 =?us-ascii?Q?H7X1v8KFhwxUzHDmBX1gQknk2iFoxPkrfRDrWFc53dsnh3/r0lztxKJI2fKe?=
 =?us-ascii?Q?tnFn6uejOakfLhekhRedpFps9HAXgxb3gpR46F4HvCm4NzAgohliISlvhrG6?=
 =?us-ascii?Q?GbE7KrCFFEUdqhHFgfqjmFRy3mGcjBexuCuLvjuluC2XytYoSGDsdT7RwDRn?=
 =?us-ascii?Q?xFaAElh6WtsoeAMWaZwge9WVNUOOfS37V/XSEPnBuqcddYHRQ4SNQFCG+wHn?=
 =?us-ascii?Q?CjJzzzkRtaM/6isCmSw+vL3x9KNKmeeXGy+pIcywKhhCBG4gk2zBY2ZfsM+k?=
 =?us-ascii?Q?ez/DS5/3HxAbVL7hdewATvYuIkiDjyU+UhocFQs5hAYejrhokNQ8Vxy2EOgA?=
 =?us-ascii?Q?UnrxGY96kRuV5ZcQ9zy5Yil6XBTL0ogKjESTSUFzZPabCSeWjmTSwQhh1a01?=
 =?us-ascii?Q?OctM31JdjKCrS1P8TT/9I+w5MmfVYg58uunbdzQXlPC/aliYJRXSH5TWb2VK?=
 =?us-ascii?Q?l/h6DLbuN7URa/8gMeJ8TFUpgCe0CwOGLQDSl446DApCHNMnxuPabzsEIXBv?=
 =?us-ascii?Q?2/UHhM5s3UWnvaFB7wrAPFX4/jp81MH2mgXK/S09kWnssJVHeCsu1EUgR+l9?=
 =?us-ascii?Q?iuUBy/Cf2ho2ZgUlMVN3a52I48XESIoAW/mkpqrj52escAuc0bZZ84JuUaMf?=
 =?us-ascii?Q?uvk+SPiV1ScBVQ1z9KItGKKca9NOiYQvKo72TWJYs68fCgacbNGq28WjrcKT?=
 =?us-ascii?Q?PRoPe+v+w81+ZYVk/FW+zXH0zGmfEHL3Afm4z0ZqAFbt2dp89YlXKjkz50KT?=
 =?us-ascii?Q?o4wfLO2kETfH3qZwcSQnS1Rp1wTw2c7tLg3XBvNtntMUe6NZYB52J2o3rXPV?=
 =?us-ascii?Q?b/l+BtXeKiKzjPcsw8DyJk6vVGPAOZwmCigjO9ByhCRMHuwQlddIj8RZ3RDN?=
 =?us-ascii?Q?fFMAc+yLkbRKKsigCgLpr4A6E/DessgbUGXILhoWByhk8spO/Elp/Lie0AUR?=
 =?us-ascii?Q?bWP2uZnqmNzXximnFUr6cYLDyUOusyNAGme5xcHMsIZLw5WbGnGW9ziMlQLF?=
 =?us-ascii?Q?GuF2MJGq+6WEf/Zbur2WJrr5ENWdykG8tno1W8REToz2jovbPztHDnU4bCj0?=
 =?us-ascii?Q?xyzXE6IHqc4r8ljwm8HbC+tAyZGGGZaw0jZRVbWAvbP4KcyyRbEb7A2pTew3?=
 =?us-ascii?Q?VIU+il6XwDtOniN4m4asEkigTMm2u9L3OaRJ9y6LIEvSsowrc/Gqn3vwEdBx?=
 =?us-ascii?Q?19KxAnzQCe5EF/c0yebVdeozWlrCVqBuop08WZAkdLXD3dwAePR08iSgAkTS?=
 =?us-ascii?Q?mAXk8YJrj/0rzX2xaXJ6YLB9RTFF05VfhRR+Ck1vW3nxRw69FkUjY0B9J8zy?=
 =?us-ascii?Q?/MH6BZIW5Liv5LNDsEtzFplZ9zfL586s1GjzywvEt4WjLDrEBb4bvkJIsYDx?=
 =?us-ascii?Q?v21prSdTOqw1tEcz0jU9HlfaMcxuonANqzGSReoDxklbNNbpyo1twX9YkCSN?=
 =?us-ascii?Q?A0zxhLn7VbkXOwID0RCGynAk/vhrEofNb8HfXmrPk+QmsJEOZ7m2Ph46aTTA?=
 =?us-ascii?Q?9vNFpY1s2qvIG8y2fKC3ChiqAC7B6s0/5VlzEdo5+p94tNaWTPWF4sdZg832?=
 =?us-ascii?Q?JPE9msxoEq+VUyb9Cgj4PsJK4uvzNAq95JDYx+JS2ZgpEhHOj00kfPP19tGY?=
 =?us-ascii?Q?ty9eXmKAMw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a6cc08-2633-48ae-e21a-08decdff3933
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 12:35:19.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZgbVxZpbpcCxAOe/K/KMHAmb2AiZAuv7wmjhQTafWWRM7RKKODzivZlb6eDHuSDhN+eEEcR6IQZ+PGAnC1vdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3973
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 19 Jun 2026 12:35:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23235

On 19.06.26 14:21, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
> On Fri, 2026-06-19 at 13:56 +0200, Jan Kiszka wrote:
>> On 19.06.26 13:38, Moessbauer, Felix (FT RPD CED OES-DE) wrote:
>>> Dear cip-users,
>>>
>>> as part of efforts to provide a hardened base image, I noticed that the
>>> swupdate suricatta module is running as root. Hence, communication with
>>> external parties (like the artifact download) and storing of the .swu
>>> file are performed as root as well. This significantly increases the
>>> attack surface, and makes us vulnerable to path traversal bugs, like
>>> fixed in [1].
>>>
>>> swupdate already supports to switch the user of the suricatta dameon,
>>> however this must be done via the single global config file (there are
>>> no CLI options):
>>>
>>>
>>> suricatta :
>>> {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 userid =3D 65534;=C2=A0=C2=A0 /* "nobody"=C2=
=A0=C2=A0 */
>>> =C2=A0=C2=A0=C2=A0=C2=A0 groupid =3D <??>;=C2=A0=C2=A0=C2=A0 /* "swupda=
te" */
>>> };
>>>
>>> While this works, it is tricky to impossible to integrate in CIP, as we
>>> have to know the gid of the swupdate group upfront - which we neither
>>> know for existing deployments, nor do we set it in new ones. If the
>>> group is created by systemd at service invocation time, we have no
>>> chance to know it at all.
>>>
>>> We could use a generator to create a derived config file that is passed
>>> to swupdate, but even that would not help in the systemd-creates-group
>>> case.
>>
>> Referencing only by ID seems like an SWUpdate upstream limitation worth
>> resolving there.
>=20
> Working on a patch.
>=20
>>
>> But we could also fill that ID during postinst, enforcing group creation
>> at that point.
>=20
> This would only work if the assignment is stable. Otherwise we risk
> that a locally changed /etc/swupdate.cfg freezes the id (as copied into
> the overlay) while the /etc/group file is updated with a new one. That
> is a worst case, as it breaks all future updates.

UID/GIDs must be stable anyway, Isar had seen a patch proposal for that.
CIP will naturally have to pick up such a solution, irrespective of this
issue here.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

