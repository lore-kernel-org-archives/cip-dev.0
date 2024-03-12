Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69698C54E58
	for <webhook@archiver.kernel.org>; Tue, 12 Mar 2024 19:21:53 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web11.5816.1710271311179801559
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Mar 2024 12:21:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=IP2fl0Jn;
 spf=pass (domain: siemens.com, ip: 40.107.7.51, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S2tIDOQL2YPRtLbNgO6J6OWDLGJnwzX+JDX1h7fP6xkgs5433bJKF786cl1YLeoqSirYZZc0ApYanRAvDdkGJ2067asx/XYTRV6+dKI+yUeIR3xzAvP0fHdLAxPl6LeE+siOJP4/fp6Xmb8mt0aTQ9qKFRqXhcL7wBoc7nL9EDAfNTz08qFDo+KQ/yp7t0VaVnMzikvtZE+fwVJEnheYPoGnnLxaEn8pd/Y/2nBDyFEreJz1wTVa5CtNItndNIRQHhyX+2iK+cJ/TiQLK47Hc+7kAwjl+Tc+0LJbHFnAy9A6c01fA63ZyM2o63qOqXA2OOIMPqVk03TZe4EQHr1Kfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prNzVsD+6e7eS2swj7xzwWe0BtsGYj0BJi1DEMBbILw=;
 b=HFoxNhULTChl2QSMaT+lEpddPXZeDw+AI8v53lrHmmqiGCwmpBvKrN3SLmxMCTBt/opVaUOjQdrKacOrH8xDD/UjeGZriZQ+lwZQlCBuj3dfwBOxAkZv2EiUiP8c+fSMvfGzXrOcw7Zh+6lOH/AugtvphTlQ10wIxKhTTO6I8aecGPx/VbmQd/s6wiX2naGVL1fLrj6FwfDlUIgfcVV1CZ+wnIhiTj0ow3YUywEf6uDKqdJKVB8K6jlniaPMWk6Ymbxke7+A/ocWe9QTV+9qo1TGqkVeRavNfzulZaRmUxeC73Odi1oO9NdrPZ8xnbgWleyjJIeC9p5TxhZKb3N7bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prNzVsD+6e7eS2swj7xzwWe0BtsGYj0BJi1DEMBbILw=;
 b=IP2fl0JnaGjKiHSKivDdRNeakwyCp6FLKBClm0GtjAxEYFbu7OIOblmP8tSMpZgbAZqzg+EyoqgJ0AaLjoWQ56qRjpBSMySRLEwRWtzM+7HPaQ1/NfrERDhr7ZY0pWA9AXk0/+TxYcDYbFPxnnS99PZT6v5kICBiMChGAE247i8uwI8on1URZwiDQFFuBNuSqYf5o3KOb0sb6+c3oJKuwGNOERLeD/fG1BYIhd7z/LBz0NiossBYcrRVIiS7mx2tvvRw6unX4/YNW/yvc1kd3wu7Ro9z68nmNYXAKLiSLUNRtvnvguJw/wyFMhFq+LHDuJ6N78ZH9xpYN8I12qihsw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS4PR10MB5271.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4b7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 19:21:47 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8d16:7fbb:4964:94fe%3]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 19:21:47 +0000
Message-ID: <487f769c-d9c1-4071-ba45-71563eb0a411@siemens.com>
Date: Tue, 12 Mar 2024 20:21:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev][isar-cip-core][PATCH v3 0/6] Make swupdate signing more
 robust
Content-Language: en-US
To: Gylstorff Quirin <quirin.gylstorff@siemens.com>,
 cip-dev@lists.cip-project.org, felix.moessbauer@siemens.com
References: <20240305161128.2777211-1-Quirin.Gylstorff@siemens.com>
 <66be0ad7-bcf9-4383-bddc-34bbbb000e60@siemens.com>
 <894ebcd6-aa83-4076-abea-2ba743536183@siemens.com>
 <127e08c5-2de8-41b3-ae37-6f0bb510dba0@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <127e08c5-2de8-41b3-ae37-6f0bb510dba0@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS4PR10MB5271:EE_
X-MS-Office365-Filtering-Correlation-Id: b54404c1-acf7-4514-d51f-08dc42c9a936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hjHSsA4/Q/rFBAcj48Ej3gdJ6NcGn5safbW2hjojc5VB99yvb0R78kvMR5wzZxNMuH2FOpBk8sv8iHmpBP3oc5QuiEBINOYaRWloy0amkPZhHGywYTjxwd5X4pqFBBx9KmnVJImPaADlN9zOweuzFhguC3jMhUxFSCDMOigFSQ/qANCeb5BS3vPsHr93/8JLTo5nf3Ae+pD9lO2LWJGypNoQFzDgZ8mM33d18a+2KJuXGpEVdqQKA+r7HrtmBNTDBijNMXWN2WR3yN8kX9D8LdskdNad8TD1f2SNUcZfRZVWdhJhiErCZ2QTLoyvMDdtxzN+mZ2sYEqmOBZe8mrAjrckrWgULjarPR5DAVGMvLrqIhaRg4G2zyCNKiHh270EgKF5LCLd7LEQB44tyNPOH7M/3E3qigSgyoH+QTnsw4O11TGXsOyyJ8Ob9U88+Q5ep2obj3jdRR8NgVqALdJItqmbc4QiiLwrchuqHADTu0xNmgY4Epnqs5q53VB+WSsRfCbTqdptLFLk83ftZ/Gg2SpOuOH1JW8KozOP0tNVrvOhtBgixUsqbj0iXX0GMM3rvLo4Wcwp7Ajj27UwqZZaU57M2hEBSZDVngV2uo8D2p8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cPnJ1fI6k8IDzQALRUn9tmhc7TswLUgabWNyM0B52aqVR14b6gNbTw4FRiu/?=
 =?us-ascii?Q?CC/Sodp4ff5fggltIdlmkX6ED4EZ86vYfOv7wboW5+V1/tf9PU85Dj2obTdZ?=
 =?us-ascii?Q?pxR4jVi/ogmEL9GY+bEvTpkIhwtCf05r8r/vCxP/TrYWMCuXsoWg6wYSHHmq?=
 =?us-ascii?Q?osUFqNhhFlkbRIYZWZFOZgrpijjpperK0Qrl2znnxVnH/x3xA2v+AQgQvEfE?=
 =?us-ascii?Q?rPXYs1XEN4xYcpDH8zrIjAyEUJkBufPYnlOhYv60s4kBdl9iohC2hj6trQL2?=
 =?us-ascii?Q?R5EsSVyJGwEXNqdPVCOdKqe4UEyN7lbayUDD0+waqxd3Qd0W10fbpV2zFwIj?=
 =?us-ascii?Q?0B0hhqGiALdLQqB7+e1V4jd9lCrEt0AceYvk2eQJ8KfeyckqoPAOHMzLdW3P?=
 =?us-ascii?Q?W9WPl3x8ApDKOpsvAm28mH8PKbehbs76Nmg72xCAAvO7BcxdxDCuMgagebSZ?=
 =?us-ascii?Q?Ib1vUfdoVVXLySKpdai40UoUBhqOjbf4/veggFuWNzKkuhL+Kydka8gKmD93?=
 =?us-ascii?Q?0dPRtMkUPOf9i/OVSr73uvvvirJIaLu2SrptH7ZqdfT8qH/XwpW0RaihDnf4?=
 =?us-ascii?Q?3usMun7ex/Y0F7NAMryj+T2MtUJq4uT8DiyxxKD8MK+f2GgQt3nZDUXBFhd+?=
 =?us-ascii?Q?F5D44T5P8pjnGvzsnnzSLY/f6wnrLamZdaQbPxHh7CnJ5RvGwz/70Kcvn9+K?=
 =?us-ascii?Q?9gKiHryV+60D7GHX6FbydgT+DxKvw4CpIUoCC9nV2iurazCGhpW4jWnj+UZ0?=
 =?us-ascii?Q?9i1/eD5X1YCswRRBeLdJQL+zC2Q2pIV0C1duzWg/j9WtRDRS0OsBCeL0Nbpm?=
 =?us-ascii?Q?m1ulSa8FSd7sH8cA9FUjnLezbMx5qHgdef5zh9aUhj0SM+bjucxejOKrSUPV?=
 =?us-ascii?Q?URg+yB3DLIAPcARtJE7XhjoUvtITpmmHxWGaPZiVR0C2IzHVwRpSkryyMxlc?=
 =?us-ascii?Q?gqZCtDyT+z3DhcixGnV/GPtarazEhUfr0QZQmRQ2NtfKhnBl63Uj1esFIBaC?=
 =?us-ascii?Q?6GBR2AhD9K+8Ol8pMk7O3pSf5OPz/MPlMc33m6FBrlvxWE+mq9ff277eyZjB?=
 =?us-ascii?Q?LUm7py7heUJptos30dmV3CSrbMonaz4G8Q2q1cmN7zocQa3gQpQojehHPWrS?=
 =?us-ascii?Q?AMIW1Uy33B9lF6YTUVrS2Ah32ZfpY6yYiWnplR9bSi2I3f3VZN3oS8HkZzUJ?=
 =?us-ascii?Q?uO+eLiSvepJjUQOcXL3sjOEKS9i4zg+xOJNNKZLgmKN+VHRI5V0m1W5fQsGy?=
 =?us-ascii?Q?BHDbvAPaf2Xk5cg2Gf7g14PRJeihcPQdqzSxK9uW6O1h1cY/i7qV6pfXJBRn?=
 =?us-ascii?Q?D3sls7rGkhZsPsGwYVs0/+HNDed6rRssRQDdw30naI0xXKA10iAXXOuB5Cvr?=
 =?us-ascii?Q?5It+qA6PkSahBlRzOGscpPBJp0o8wx5SVK3ZsUSjaU4PHLZiEUEZ71jgZSqB?=
 =?us-ascii?Q?WX6SOgEAiNaOGHubL7CBIxJATXXdpPPPMm1y+9ekCMifTal8BUwKCBooyk8Z?=
 =?us-ascii?Q?pozdx9FElFbnztdaPo0y0AJYq4YBgtYNtQb0R5EVbE6TZKES2TftfUnVoDyU?=
 =?us-ascii?Q?dffkbgs2Gq0teQY3i+eaJO2uczpliIAuTN8AST6n93O7g5G60JFLCi9e57AB?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b54404c1-acf7-4514-d51f-08dc42c9a936
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 19:21:47.5640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pp9uXgjjm/wedpyl/p/T/SiUCje89PiryXAMxvRDIhTHQitqveDSB/2kvch1JzYW7PWp8K3UXIDEHIW0kGGbWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5271
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 12 Mar 2024 19:21:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15282

On 12.03.24 19:50, Gylstorff Quirin wrote:
>=20
>=20
> On 3/12/24 7:12 PM, Quirin Gylstorff via lists.cip-project.org wrote:
>>
>>
>> On 3/12/24 9:40 AM, Jan Kiszka wrote:
>>> On 05.03.24 17:10, Quirin Gylstorff wrote:
>>>> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>>>>
>>>> This patchset adds checks to validate the certificate and key before
>>>> used in the signing process.
>>>>
>>>> Add also adds the missing Documentation about swu signing in cip-core
>>>> and fixes two issues:
>>>> =C2=A0 - an error in the build logs of do_image_swu
>>>> =C2=A0 - Creating all existing image recipes by touching SRC_URI in a =
anonym
>>>> =C2=A0=C2=A0=C2=A0 python function.
>>>>
>>>> Changes v3:
>>>> =C2=A0 - rebase onto next(704353612238cb2ac1c16f29db6f314b60cd83b0)
>>>> =C2=A0 - use local variable to increase readability
>>>> =C2=A0 - add formatting patches
>>>> =C2=A0 - fix typo in commit message
>>>>
>>>> Changes v2:
>>>> =C2=A0=C2=A0 - Add information about cpio option in long form
>>>> =C2=A0=C2=A0 - replace cpio option `-H` with long form '--format=3D'
>>>>
>>>>
>>>> Quirin Gylstorff (6):
>>>> =C2=A0=C2=A0 swupdate: check output of sign-swu
>>>> =C2=A0=C2=A0 sign-swu-cms: check if key and cert are valid
>>>> =C2=A0=C2=A0 doc: Add section about SWUpdate signing to README.swupdat=
e.md
>>>> =C2=A0=C2=A0 fix do not add files to each image recipe
>>>> =C2=A0=C2=A0 format: classes/efibootguard fix spacing
>>>> =C2=A0=C2=A0 format: classes/swupdate fix parenthesis
>>>>
>>>> =C2=A0 classes/efibootguard.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 39 =
++++----
>>>> =C2=A0 classes/swupdate.bbclass=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 88
>>>> +++++++++++++------
>>>> =C2=A0 doc/README.swupdate.md=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 21 +++++
>>>> =C2=A0 .../swupdate-certificates/files/sign-swu-cms=C2=A0 | 29 +++++-
>>>> =C2=A0 4 files changed, 127 insertions(+), 50 deletions(-)
>>>>
>>>
>>> Thanks, applied.
>> There is a regression on next which was not there on my integration
>> branch. Can you please revert.
>=20
> @Jan You removed a `\` in line
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/next/classes=
/swupdate.bbclass?ref_type=3Dheads#L232 with
> https://gitlab.com/cip-project/cip-core/isar-cip-core/-/commit/8d9e44a154=
ee685dc2311b7248d5f269350d2fd6

Oops, sorry, fixed now.

Jan

--=20
Siemens AG, Technology
Linux Expert Center


