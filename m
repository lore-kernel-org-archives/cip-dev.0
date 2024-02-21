Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C50CC48BC3
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 10:33:26 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.81])
 by mx.groups.io with SMTP id smtpd.web10.10227.1708511596046558807
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 02:33:16 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YxaStutg;
 spf=pass (domain: siemens.com, ip: 40.107.7.81, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZbl6B37t0YpsTTiFgWwvEfsgCaWQd8Hytf81VZDXX0o/Q1i5apBMHL3B9w7gSI2AaFdY2xSVc+FGof7vwrv0U/RWYhELORtLxnriNKwxQL/nqaiDtiWQM9mMGXb0WFi9OWBhTqMMbgwBJeiVldYciF4/a/UHjJbcUJ+RNKoBRfVWJIOfymQ7PBP2XSoviFKrINv7cDgId4eATM+InEgxFLXLkODyojDI8q1t//nUNW2am1vx31+thBgOMGX1thYmu7SToe3Mnx9FwqD3Yyw6X3viGcq0dxyNiTvN0Upz3VyK/JHJlshEjP/NPoFc0hoXU4jLTyp3Fz8ZzPmPtZh/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikZkYnKeg/r4bACJ/NTJ7sBg6Z4bDvADe6mz0fB+pPU=;
 b=hbCZron1zVJTgddA9ENWQILlV/odSWKTF/4p2X/gt9b/akyRSlSKjHFN/d6ySLvUQcQNwgZChfYzYVtdDCETs+KTMQpXJZudNtxL3cvCda8p4spVqgZjNi4iR+3uNMlkMKGmpsmSsgYNAj1yfU0Cp7lxs10OzstYGIn/+mBRLk3sdjYwy+o65Sx/33c6X6oW0xxIB2+r+Aei7rPWEuVfLXo9HM6/PFSfUiPVc2ZEhcGRttlqpVBvHYXWMUYUpHSkkRv0pmna9KXSKb35y+SWfGGq5dEoxPrOYGVPUQDB2hL7obe2PQhYZH2XGIRgQGbZQTDfVj730Gnp15wEVrk+Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikZkYnKeg/r4bACJ/NTJ7sBg6Z4bDvADe6mz0fB+pPU=;
 b=YxaStutg6+g8fIncm0TGwt1dH/H0Vbf/nrI8EL2qNS2VrVsDZfwHB13DX6Sc3hgw/uH5zEiw7TCyaAX4O2r6ta8QSDvhBlXS6KoSLsXwi3STA+8uNL50r0U2w2+hWvuitXFapocgu1NouzCil/OWrGApjT+3yf+mZ7HruZd+vVAz/L4TjOv1Mo5ejGGPN5/Ae+deTAQvHYwQTVtLJv2EiKeoLxAIr7h8IuEfDPbYS8FX8gMACGlexz+tVRgHha9pqX4xJ8DPDM4Pnc+u7b58F0C0I3MM+S+q52vciO5uiX3EuWzLKXTfXsTURT5FYEq4WHQg1DxaopsA2O67cmo6PA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7241.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:456::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 10:33:12 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 10:33:11 +0000
Message-ID: <a90c276d-5620-4bf0-b4ad-fc0675bc1311@siemens.com>
Date: Wed, 21 Feb 2024 11:33:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [isar-cip-core][PATCH 1/1] swupdate: use to_boolean to compare
 boolean variables
Content-Language: en-US
To: "Moessbauer, Felix (T CED OES-DE)" <felix.moessbauer@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Mou, ChengShu(Ben) (DI FA CTR SVC&AI CN)" <Chengshu.Mou@siemens.com>,
 "Gylstorff, Quirin (T CED OES-DE)" <quirin.gylstorff@siemens.com>
References: <20240221090005.54520-1-felix.moessbauer@siemens.com>
 <a08892a0-3b69-4fd2-8b01-6b37bc491c7c@siemens.com>
 <bc54041633fcd6f6c1da7387756fb10fbdf25415.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <bc54041633fcd6f6c1da7387756fb10fbdf25415.camel@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR3P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:94::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: c2190b45-5c05-41f3-dfe6-08dc32c880e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	3KKbxI9NI3HPUdWnNikNacQ5QW2Vmy31tSaAtpKdRuqDLWJruWVbXJVpSLhX7AKtkHsoHGSExNPCobaIPE0xtVQr34rr19ROtvkpLRzEdPr3/SIzXB/RfMbF/JEgSKJjtLMVzC2lo5Y6HKRP1hlKBbhMrMajS3VB4ujEe94oIXgcWqTHRBpLane8c1OU9c6c3LHi0DC0EPfkw1Sbwikf9JiJEnrmUKTJVMGw9i5bt7s3ktSuX7+yrKSOfh75Nz9tPd+HHLcoTx3eeDmoXqIs9mbu5DmtX+9x5DMUK3y9p8Nsia/nFW5KEqV6pzq6FY71WBS/bsyWshQwdXk9cZ36cL6/mG2jz2II2SarrW26oevrXgPnbgaxgQ/ml4FFkmnoU2ONOumIS9OSjqvnV87Le/VPSBobGXIQ2ydDZvuwgIwIjk3SoQzVhRjz+3YRsADjYlyU6uH0QO22r6WfVz+QFoJYpY551wNVKT0D01YxrMl8etFAJIDh9YMpqasdJ5FLz4S30vHreFKe7AcGkDigsZDZLXkBo2sSC9GOxvJapWs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MFY47f50Ucu6PeRPJE92xvY5s6osabqU7OFquWw9/4x0abjvZogZCqn8lxon?=
 =?us-ascii?Q?hZ+HXL+ITDWGJDtkM57wsAzRaV8h0Np6bOCjqH63TvqxnyTMKrWQ+sENBlao?=
 =?us-ascii?Q?ylF5qHw9UgBjeaA5ajbcX3PGu87dkaM727gtHxM2mCfi8eZx7xs5r+JUfHcB?=
 =?us-ascii?Q?cx1zildsXqp/Uf6xERPQtc1bfm9PI1nIWonEWguGPNZjaCy70u7c6e/Afrf5?=
 =?us-ascii?Q?sOYSU47ufmKJhdpWT0xdjMczApyjcJoRXRrZLCMzgCYsVskCX6V5xEAjpSxO?=
 =?us-ascii?Q?8oH7ABgdopHxyrDpzLK1UpFAX+HXZBH9pBjHjPGH608fIQDlaflKmgvKuyC5?=
 =?us-ascii?Q?z115PGsXx5tZSBG96naRrSL7UEk23AfVxDON8PdhFiH2fmuS+D05HhJd9YUO?=
 =?us-ascii?Q?koDwmK82Ly47wi+qZI9ILWB/7VY82n6qVGx8gH8/9ZUanf0eQn2evOs7wb9k?=
 =?us-ascii?Q?q1nvGcN9dM59PrB5lkbAm5H6YxDw2zwZmsAGfg4/PguE0+Fasm1vr36IuM4I?=
 =?us-ascii?Q?U26/I8Ften1AyT4ax+qum97aRKoGkpOEYZ+uHMEuuVJ9TxVNXSm/XddAqcpC?=
 =?us-ascii?Q?CQC9WREf6kEz6DhL5ZZKb0D7Q1SpiaGZpVANv7cEQm14BMtI3fqF9uWp48Fr?=
 =?us-ascii?Q?XUTr3ALXnzw1XJyuri+OdLNpSj3D3VqfQWdL8fY41M+mPiKMNrW7pibJYWA7?=
 =?us-ascii?Q?+AvISJaJ9MlwlWMhPfk9Y7005iQozJZGAvBex5vjQcFn/Zi3SiRXswjYpxAC?=
 =?us-ascii?Q?4C+nYIN5b+ET68DrYdhNpX0bjOuDe3LRgTFR9yFuDQDvJZk6aeWgwRf592Dp?=
 =?us-ascii?Q?N+N1SE7KoNKc5CHC/ntMMB3gvk+2AKdBTdbff7kTek76HuH0IcHfaF7f7SQM?=
 =?us-ascii?Q?UjMTPZqdu+bakM8xVzcI2sFtU/e1//lGTwc3rQvJGl/cqHFoR5LsyB8me+x5?=
 =?us-ascii?Q?nLoxifbLXzVf4axW8gWvhu1rVZIvkaX3ajCFwaqqRhw5tt2UbYsEJ5sQ1mG4?=
 =?us-ascii?Q?EUW5PKBI/jMLRTfh3TmQtNCnLZk716sxza3HZBKcLJOhB9zb9GkeNx6ybKOI?=
 =?us-ascii?Q?4Zdi5chDGPyYv+hg3glJqFCiA2o/6w1qbjUtB5OYO736UB/y78Afk1fNNCrg?=
 =?us-ascii?Q?Tlw/mfgH6i1mqJBFyOyrXYOZR1WtLcGJGuk/W1tedViYTH2F+WNj0Z6RfgzL?=
 =?us-ascii?Q?jolnbmjxG5vXuVxLGPnu9D0rlCor5POOQDlfBXIJlEvrFvsCsD7GCcan6Fyk?=
 =?us-ascii?Q?9gB30IGEUcdlZJor/G0ui3/YrgdlZ9VyEy9zoH4T3R3B1cWOOR+mgcCIO5PT?=
 =?us-ascii?Q?iS3U0sAsZGZz+1j0UjwtU2W628RvcsLMGU9BDH9FMeUscHxlXCEnyPHZ+zWZ?=
 =?us-ascii?Q?qM5Q466R0YWsHJ6wylBYxsf8Yi2qtpNfrhgl1HQB5mb30gB/0wflg7m6r0v4?=
 =?us-ascii?Q?jPeXy4wEDl9lhl7wXyg5yusjO97ZiRI9zZi7WhFeCAk2fQTSf2lGQks5LLRb?=
 =?us-ascii?Q?6Mn+aMuqTQVXLwsZw469yjbmsq+ZPaIxyVsf/tQf/gn7fd48ljEPFYn8BL9K?=
 =?us-ascii?Q?7gjRpdxBZooNudr1leyonor9M/pwRbmbrGi5oMx7EyiMskRgvXvPlNrNPaT1?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2190b45-5c05-41f3-dfe6-08dc32c880e3
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 10:33:11.8080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XsBoQgEyzPjyQ6kFwNAMVqn7f2AMURm96HeNwv/CBdTqPSd3t34rdJzqkNhsLRNXQR+tO2nbZUUx+p52DPtIgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7241
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 10:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15047

On 21.02.24 10:16, Moessbauer, Felix (T CED OES-DE) wrote:
> On Wed, 2024-02-21 at 10:07 +0100, Jan Kiszka wrote:
>> On 21.02.24 10:00, Felix Moessbauer wrote:
>>> When checking if boolean wariables are enabled / disabled, a
>>> comparison
>>
>> variables - no war, please. Can fix up on merge.
>>
>>> against "0" or "1" is error prone, as a user might use other values
>>> like
>>> "True" to enable it. For that, bitbake offers the to_boolean.
>>>
>>> Reported-by: Cheng shu Mou <chengshu.mou@siemens.com>
>>> Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
>>> ---
>>> =C2=A0recipes-core/swupdate/swupdate.inc | 4 ++--
>>> =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/recipes-core/swupdate/swupdate.inc b/recipes-
>>> core/swupdate/swupdate.inc
>>> index cb1716b..7a4214f 100644
>>> --- a/recipes-core/swupdate/swupdate.inc
>>> +++ b/recipes-core/swupdate/swupdate.inc
>>> @@ -23,7 +23,7 @@ def get_bootloader_dependencies(d):
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if bootloader =3D=3D "efibootguard":
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return "libebgenv-dev"
>>> =C2=A0=C2=A0=C2=A0=C2=A0 if bootloader =3D=3D "u-boot":
>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if d.getVar("U_BOOT_CONFIG_=
PACKAGE") =3D=3D "1":
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if bb.utils.to_boolean(d.ge=
tVar("U_BOOT_CONFIG_PACKAGE")):
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return "libubootenv u-boot-{}-
>>> config".format(d.getVar("MACHINE"))
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else:
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 return "libubootenv"
>>> @@ -32,7 +32,7 @@ def get_bootloader_dependencies(d):
>>> =C2=A0DEPENDS +=3D "${@get_bootloader_dependencies(d)}"
>>> =C2=A0DEPENDS +=3D "${@bb.utils.contains('DEB_BUILD_PROFILES', 'mtd',
>>> 'mtd-utils', '', d)}"
>>> =C2=A0
>>> -DEB_BUILD_PROFILES +=3D "${@'pkg.swupdate.nosigning' if not
>>> d.getVar('SWU_SIGNED') =3D=3D '1' else ''}"
>>> +DEB_BUILD_PROFILES +=3D "${@'pkg.swupdate.nosigning' if not
>>> bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}"
>>> =C2=A0
>>> =C2=A0# deactivate hardware compability for simple a/b rootfs update
>>> =C2=A0DEB_BUILD_PROFILES +=3D "pkg.swupdate.nohwcompat"
>>
>> Are these the only cases we have boolean-like variables in isar-cip-
>> core?
>=20
> Probably yes. I grepped with '=3D=3D "0"' and '=3D=3D "1"' and only found
> these.
>=20

Ok, thanks. Applied now (with commit message fix).

Jan

--=20
Siemens AG, Technology
Linux Expert Center


