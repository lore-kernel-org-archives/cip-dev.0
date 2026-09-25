Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D12C9830D
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 14:36:08 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.35])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.208.1790346963832232420
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 07:36:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=RCe/oZa9;
 spf=pass (domain: siemens.com, ip: 52.101.72.35, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ECJIl+nittVyeCZRht+gFT/Sw8SNqqBFPo1glcWE4P49sHRLMdMkNRZPTChjLGHNmLgTl9FVwOPcnefcZGY8znpxdaaxMdXCNZZpfZagF0P918Zhd/1RqyTUYUa5RCA1RWBHNjw8E6mjhKcDVJf7Q0XAmpHZ8856F9yqzCVYFeA5SNfCWl0FVHeDWz/mXmzzWmPJ3xQtt4e1YR3hYKjfscE4rzB42tqddMmoRP4+fs8keA1kBr8PVagE00IGdI4jmVMmi4NHjY7hbSd9zvDeRJMTipwrXn4gthu9dqQ510pwMusdBW1/9E0Clq8ZDrUo4aP63sbz4YjAIgjFnXrj7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPprjL7N6L4ByfpOg961ZD2fIcmujDqOAJcizpaNLHc=;
 b=kkHLl1RsoEfIaiM11DR1zl037LHMS1l6/aKjSi7GVFpWS7CzvNBANK89DvBhfgCCvOSZCx7aaynBcqZChGjNGxpMYLMmFXvPcHrTUiJ/YJhjxFl2VRN7ZfPn84y3qsH0mxJHV9MXMZdBEVWsfxn6NeVly4WJMS/86VNnOMIPZ4tyux3+VXt+fXnekgrJapDCfuVp2NINTclkKw8kdWZyweKRz+IYWnTF9D1JN3m7XOmLj4CupoZCIKA5WJBhdXUELYtQuYKtRqa0o0YeBYZ4omimbLim9Lha8mO+cilwTUf4VZBTHKlZYpXzeMacxsgroLuf8v2BGwJHLTzF82Agqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPprjL7N6L4ByfpOg961ZD2fIcmujDqOAJcizpaNLHc=;
 b=RCe/oZa9N28MfY+W0SYR2k+379nu62jFpEmsaE/zwBiWMqCkrBKgJgxBENY6fsLStnXStqyJ9oEnhpmKz7D/sZmxJJcjvL7Qc31ESsexayK1EAo9wLIpe3MuNkSZTJNJLE4H+4mDVmp31OCPMKIuTy3Mn7q9kjSflrmOADtGzo7Y3epEwl1XG2y+tOES5pdkC7Dou0XNcUUk52xqbiVEg3uE8Qv178jNDZBH6TAODeLXb5Kh9Go2dHoQLIi8uIC51RPjeRcJd0rZtwthUrhF1p3LJgWwsZ6JkiPyed8fI8GNfcB0wFmvM/tJulBcvivnj9jaxRn76eoBdpc6WEUhbQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB8808.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 14:35:59 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::be9f:e8ca:ee9:83e1%2]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 14:35:59 +0000
Message-ID: <2568d437-101e-431d-aa12-4e4abdf48f77@siemens.com>
Date: Fri, 25 Sep 2026 16:35:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH] Add SECURITY.md
To: Hirotaka Motai <hirotaka.motai@miraclelinux.com>,
 cip-dev@lists.cip-project.org
CC: kumar.dinesh.h95@mail.toshiba
References: <7c5a1901-7536-435c-aecb-bfdf3a8a9d6f@siemens.com>
 <28467eec-7feb-4bb0-8c2f-a73ca9c4b6f7@siemens.com>
 <8229d22c-889a-45e4-9726-6b6bc5d7b2d4@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <8229d22c-889a-45e4-9726-6b6bc5d7b2d4@miraclelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0001.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB8808:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af55bea-11c7-4dae-b75e-08df1b1250df
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|10067099003|11063799006|56012099006|4143699003|3023799007|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	aqyXgc1LfJ9/uBGDEEeVFCv1fH9qH7llwJQ4fOn+1quuvYHgiTDLIik1Tcpxt+y55quu1d3fwi6bkyUEP+/GTuDwPvswDKrs7lhmBaQf4b4GJH3T6xhb2OJAmIFysCYpW0eD+8LRoOzI2JeWU6QgLqyap4Tcs9bB2Z1zfA2PSUx1Cgen0YQXhYSjyEBM5y1YmMTunjcjjpfgR4GWEslBjUQmBUagFsomUAvRngXln26t5WmE/wzRAKrOcq3cigjr4lzuHgjHRDcRV2xQPyfheEuTrNOnQoqP6XK5arFElshLSQebc4w8y8uXUsMozVgnWIJofMuuMFBlZ0DsOo//T9ywQAp3/i4Un6gCwN/tbfpbO8NZrMZTyonvGgUPkhaDJqwxFSaCRnqCps74JpBsXE8SWYYHU6GbbkIDmjzTbMw+Ei3rOhpCQjjtzLP12BIQFj2qptkOE3pBzKPCdwKGdc3UgMUmhsfI5TiOao/sB9ED5oSj75iTyMX0F/gaxyWqq3C/DS9r//hLrZBNrUK9f5TvxZ2OaTnimnx7RSYKUqlcRlswz2AOi3dQ14c6x/cAHE0erosE5xAhdjJlF64sgcX/6Jb10RkrhhRceg1TikBF0nmXENizg3s/hcNFbrFjCgH6rpJA+bqz0nW1qX/pfs51ceirypJpQeesnZUvlFQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10067099003)(11063799006)(56012099006)(4143699003)(3023799007)(6133799003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LA2tTo4H1MD7VaMRHMfnnnUPUfjjVQ9oKRPaIJHZc5YMudrzLtPHawyYQj4K?=
 =?us-ascii?Q?OFYv61utI1tXCzOgRu+PPjY9HxMj1PK0RiSPPBHkBYjVwuJBcDLj5tKFBs7O?=
 =?us-ascii?Q?wPSOOBdYe4N/NaDE6rlilv2ikRNgNIV/WbKeGbrqEII3T0WUgbRADa0+nioz?=
 =?us-ascii?Q?rMQD2HMIiqehshP60pd4VHq0s0B0k6vxBdILDUyxvIaogOEfKAHEKBKQb680?=
 =?us-ascii?Q?uC8YZt3Lub8pdWETaH5Tq6mDCZ4j3w2rvG9dDtzC6obx/V0BRcPBiTxRKDFm?=
 =?us-ascii?Q?DRsRnFISMj5XIwrmqrmdjXo7KNzI1XaG3OEDxsWb+0k4G6bUeoQmw7ATYRDB?=
 =?us-ascii?Q?+svInzQzVGibLvBxE4WKwCCtaJq66UW+IFMOmyzS7/pWLNa0KuvOAFaHLCS6?=
 =?us-ascii?Q?GzlTeCAzArv0aKOoPARgqmhRxpA9N+KWPOgM9rAhnhVRW/i0BU9KR+ixgvHm?=
 =?us-ascii?Q?nR/aA7ZMzQe4bKtqgdooNcbt3Yv2BgjRmNXH/bOrKd6QIkDlqTjve5GIBGVJ?=
 =?us-ascii?Q?skorLkjDAq3aIfkp/EXE7iB4XWEpXz0zExpmlo9fLArp8ubnYWNT5WZ8aM+f?=
 =?us-ascii?Q?o6JQ5z4Vh1j+ayuvIoaRklnX8XtULYpw1muZ9wwNi8jKOBvVkmCltBDk8A8N?=
 =?us-ascii?Q?DZhB7MX/O6oQnoaYvovoQN0Cj+5N4lu9CRpNmKqVg8QxqJIj7BXxMWhIJOQp?=
 =?us-ascii?Q?D5i3Fah8qizxifQMUXUyM5rW+fb/q+Oz+WVbtG2+d71daDBhK6wEp6DpHXqf?=
 =?us-ascii?Q?+fbrx7UymmVFkcqz7boXbqsfTHG0yTyyIJ+LUAHCtzsfRSktRkhCZC5Qg3v7?=
 =?us-ascii?Q?Ztxqz/HDEzkANENcbqM5OToZV7vrxVCr91aX0SkDLy79PLQJAlRt9jsFq9fT?=
 =?us-ascii?Q?fjpwwCh0i7tPvPxjsizb1qmSURaII3njdY6ZKPCGoEA9TCFmowvHk7TM8G3F?=
 =?us-ascii?Q?BB6DHdSObYHbjgGYKt+F8+XByWcwy0RRT56oSB/h5NC7KlT3of2moTf5uX4R?=
 =?us-ascii?Q?s87cBX/tqG4uv45vnTKnPe/hmdAsl2OJfBo1tkeo6eEWXk1mMSgLTzxaZ1OG?=
 =?us-ascii?Q?3KIKBzC0R2UN9iCCqelW84tfYZ2NT4qxyehzwhRyULYt5NOhD1b6+zCws/SV?=
 =?us-ascii?Q?orKq4LLB9XIKbRHYvcZC7KdtRTP8fAgFqrXkU1WVh6irBiJJeYm67z/FlBpA?=
 =?us-ascii?Q?mjBn/3N/nbzKOyANI9WVZkbWFX10ValHZjE92rO2xAWuNeFZuzfdsU6El708?=
 =?us-ascii?Q?hbitHr4pDnH3GHj0JV5NdxbaJNaS33B2r78sfJNQNrfkKaS5UXshVnW8MRas?=
 =?us-ascii?Q?YzP7thF7OGH+hap++nJd78pJwFLsqgrjLuCSKss95Az6bxWAzuZ2PnuI5S5U?=
 =?us-ascii?Q?ZTailiilE4nO01IJBT7ahTpIvIzysJ751knvxnbp1JHT65aKMOLA5GHiUEJk?=
 =?us-ascii?Q?m/leapelCs7Ty2scv8kYPOjI4DVjp0lKDJqtCSK3nJ95WnMv0Uk3Eenp7z68?=
 =?us-ascii?Q?vLgI0pAxyuw1OcHZBjmLa18lLkjCKnykfqBBdijIdqkgiDH0c+z1INVxUHnE?=
 =?us-ascii?Q?8PjoqheUr/yb2JJdOxeTeP8sy5Y5dnhgRL06nTybpaIyLEc907NOshXrT5wn?=
 =?us-ascii?Q?N9GILYk9hGIx4xbi1ukF+lb4n4r70nYxzd1/zwgl97ZfF5HvItewZLYnyAuz?=
 =?us-ascii?Q?50Gn9OI488RihIDFviZhaBG+KQw2xJ1JZdNlm6BR2sRw4r+3Ws884nXzXYta?=
 =?us-ascii?Q?aZMM+h/JjlceCTEw7n3ZmeWRm5A3tY8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af55bea-11c7-4dae-b75e-08df1b1250df
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 14:35:59.1330
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YUShdRUjJdunHIh6WQx4S5BC6X98CHcobJRRQSNir05zUeK97qp7M/c0lcj4ww4N5NBcjhFwg/R13dI6A5FUUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8808
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 14:36:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24350

On 25.09.26 09:25, Hirotaka Motai wrote:
> Hi Jan,
>=20
> Sorry for the delayed response.
>=20
> On 2026/09/21 14:25, Jan Kiszka wrote:
>> On 14.09.26 10:03, Jan Kiszka wrote:
>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>
>>> This documents that isar-cip-core falls under the LF CRA stewardship
>>> framework, describes what we consider in scope for vulnerability report=
s
>>> and defines the reporting channel via the CIP security mailing list.
>>>
>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>> ---
>>>
>>> We will need something for the kernel as well, and also for other CIP=20
>>> components. This is just a start and, if it makes sense for all, can ac=
t=20
>>> as a template.
>>>
>>>  SECURITY.md | 37 +++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 37 insertions(+)
>>>  create mode 100644 SECURITY.md
>>>
>>> diff --git a/SECURITY.md b/SECURITY.md
>>> new file mode 100644
>>> index 00000000..664a303f
>>> --- /dev/null
>>> +++ b/SECURITY.md
>>> @@ -0,0 +1,37 @@
>>> +# Security Policy
>>> +
>>> +This project is supported under the Linux Foundation CRA stewardship f=
ramework,
>>> +as described at https://www.linuxfoundation.org/security. Security
>>> +vulnerabilities should be reported through the mechanisms described be=
low,
>>> +which we will coordinate with our CRA steward. For actively exploited
>>> +vulnerabilities and severe incidents that may require CRA escalation, =
please
>>> +use the project=E2=80=99s emergency security reporting mechanisms as a=
ppropriate.
>>> +
>>> +## Security Context
>>> +
>>> +Open source software can be used in various contexts that may go far b=
eyond
>>> +what it was originally designed and also secured for. Therefore, we de=
scribe
>>> +here how isar-cip-core is expected to be used in security-sensitive sc=
enarios.
>>> +
>>> +This project provides building blocks and reference configurations to =
create
>>> +secured systems that support secure updates. Demonstration images that=
 can be
>>> +created from it may use publicly known keys or contain debugging featu=
res not
>>> +intended for production use. It is the responsibility of the final int=
egrator
>>> +of this project to use appropriate keys and harden the system integrat=
ion. This
>>> +includes the choice of secured Debian package versions.
>>> +
>>> +In scope for vulnerability reports against this project are flaws in n=
ew or
>>> +customized packages provided here which contribute to the security of =
a final
>>> +system. Furthermore in scope are noteworthy documentation deficits reg=
arding
>>> +how to achieve secure usage of these packages.
>>> +
>>> +## Reporting a Vulnerability
>>> +
>>> +Please DO NOT report any potential security vulnerability via a public=
 channel
>>> +(mailing list, gitlab issue etc.). Instead, contact the CIP security t=
eam via
>>> +security@cip-project.org via email. Please provide a detailed descript=
ion of
>>> +the issue, the steps to reproduce it, the affected versions and, if al=
ready
>>> +available, a proposal for a fix. You should receive a response within =
5 working
>>> +days. If the issue is confirmed as a vulnerability by us, we will requ=
est a
>>> +CVE, publish the fix and give credits for your report if desired. This=
 project
>>> +follows a 90 day disclosure timeline.
>=20
> I have reviewed the commit, and it looks good to me.
> No further comments.
>=20

Thanks for the feedback!

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

