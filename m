Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E5CC4345F
	for <webhook@archiver.kernel.org>; Thu, 11 Apr 2024 16:51:27 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.63])
 by mx.groups.io with SMTP id smtpd.web10.23479.1712854286898078624
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Apr 2024 09:51:27 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jRmiWwIR;
 spf=pass (domain: siemens.com, ip: 40.107.6.63, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WSYAB6glKgRRaZP4EyhTEKfgXMk4mGv4q8BSE9UWjPjJC8XHir0hii/tSK0zXtjX/cNbo9Z8sQULRFZFx0kzzTLHv5puG1A5MPlGQeiADdfD58vPDsY2rSJc3RGbVTqhuM3WRJXaVx4u13r/ho2RGsv/5semVlybmYqvFzk1e9xZT2raoRYprq++4a3x7wDXFRYsefr7DbUYnsq6aG2/eQGlvmKsbgTkHtTNj6Eu7Y2teacUFY0A2uHC/3sYSLgAwH8H/1zaob497fBtr2KWeu6FmFS4bFmkiozFQRbYScP4xvXrCiHHICu/q6pFwa8VagwgM1jbx7A2rIrSbO2BhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YhOzoj9bUqtAy2k2gir/uplwIH8p0XLYhD6Iv17SLE=;
 b=DBSvV4q7PfiNYuMvUctoJmPvzWKVMx6h70nJKOl9P6zNnS9rqjWLytjFYPqQ4dUTvYKHr7q+luSIaInwsbILw4u28Rh5MQFT9MbJlL7MPotZ7rje1owsoTCHdrfn0VLt4gfu6/TTyD65hlpvKEACMs5igyVn23kJi+XE/t37va47NC7BXA5/dHzsBBSypq56xQZT61hGkqqt72+FpdPNSap92wr+cXuAddnDiKnjoYenk4OjmuztGoZSdK2FwpeXtHSIEOHP37X9SE4vocSHSLpFvY1ZkW0zFl5vCD/dhqHAj8ILr/+1jCd3MfDSn3BRuZ0ZhY9r7YItjSB0SsUcRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YhOzoj9bUqtAy2k2gir/uplwIH8p0XLYhD6Iv17SLE=;
 b=jRmiWwIRgObvo4lvlGQF6PQGQze2/o002fAwTkPWgcahJpOJWAhzZR3PeKzBJ7ZYpsXv5MEzraJcegX3YhRh0JOh07dNOeDltsBoY6DIupDm+OGkB5q3zlqTZdZ4NEi2UbAyyx5RzMODegUd9GYR2EU0cSzzgQGjUiXo3eL/LXs/7ZgFKNwX+/hXCz/lSPPuYxvUMeAICCnhkKo90FWJhW7EwQqYyuD1LS/jUNWL0T5gkTiKl4bx05H6kTew+Tp6LwYQQgHhLjHZ3sU8CtNrYZoi/u7bMCBHLR6oXtKAoBnwqzxFZAnCyw+VTUbo2uDRK0T2oanAoF/VmgCkovxtXA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB3PR10MB6905.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:428::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 16:51:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::4e33:3630:e08:77b9%4]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 16:51:23 +0000
Message-ID: <5c49bdf7-5909-418c-a8ab-683797f6b141@siemens.com>
Date: Thu, 11 Apr 2024 18:51:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Generic x86 kernel configration (RE: [isar-cip-core][PATCH] Add
 support Plat'Home OpenBlocks IoT VX2)
To: nobuhiro1.iwamatsu@toshiba.co.jp, schilling.benjamin@siemens.com,
 cip-dev@lists.cip-project.org
CC: Chris.Paterson2@renesas.com, minmin@plathome.co.jp
References: <TYVPR01MB11245F45500C758184F6369A092C5A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <5367.1711107559199640802@lists.cip-project.org>
 <2fa52e58-0ba5-4865-adac-3dbe03c9b83e@siemens.com>
 <OS0PR01MB6388EFEF8FAA99557205AB4092032@OS0PR01MB6388.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
In-Reply-To: <OS0PR01MB6388EFEF8FAA99557205AB4092032@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: VI1PR06CA0096.eurprd06.prod.outlook.com
 (2603:10a6:803:8c::25) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB3PR10MB6905:EE_
X-MS-Office365-Filtering-Correlation-Id: f86743d7-ae60-418b-baee-08dc5a479dfb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Z6Q78xlMjOVsWhcqE7AT9Rxe8lSAJiQPRD5rlZxWwkROW0YlP8LsMuv6nGUgYHIcEQNDvBbHyvInkEvoyfmkfZS8hwbpPqMGmFh8GNlGlnzwYuLafKa/xdZG7izcGkSXj++qNZsoZgnvs57uCncWKw/ZQ8I4x1lFBzct8A4aiFUuXx3tgMdhLrF7Km4YNVhTfJHF+NXK4qEtUmx4QUamJDzkfiHumaxeqQfGDqS7nDDkch4gVovfm+m1erHX4J150eqaVVFux6pyiqv8OT3hifhOH33JAnGS14iI+QNJyJpPsWM2UAUKE4R5bgFABEwgiM5vqFFmOTk4cxh7+F6EJSPLkOE+NEiqySk64zvo9meTtLtbzWkvBOaIHiWs8rJgswIzLOIPej7fVa+9jRqnwoWbm3AdGr7WNJ1kY/Mjqz+p+WOV1e8r1hSzCNQd/AgLodPufrHtIpZoRWd2QpGj5Vapee1aqRKh3FaNdqrLHu8yAdCUEF0J/jk2XlHEDnUiRGCk252eywwhxGPqgjqnC7GnBOnO6uEr11qfT12jysGmetJPgBl9q7jnT5BgIt6uPg8zNV4Fu4SmWqBo5DBDpOFGVMJEWjxCUcsRZNStVJk=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cdsnqSmw9wg7R96GzaPZCiH0b70tq47lhQoPwPrPt5NR9ZpfkllnGqZQVvlq?=
 =?us-ascii?Q?xHsa8lhhJkTfULtQRrdX4QMn9bZ2gWWMIMBO9JZhR/koohU7WNQzLLEzfCtM?=
 =?us-ascii?Q?V+P2W3g88BGSz+wuHMUU89928jvkEUOXQQM4hyWbtKELR7YhLu+dyvnNJ2RU?=
 =?us-ascii?Q?zIVGIDAVz6MQILeSCjJ/vm/NPNgj39ldk9JamPGWBW03RcFLXOLxdx4L8oqu?=
 =?us-ascii?Q?qE/kgKHKL5NPYmmvLi3LdbkSWSIc+JZVKdN71Mlbdp+qIIh9kcQr0zXBCBZv?=
 =?us-ascii?Q?3ZEcLXzIRgEWPCQmtH+56Oj6W2wZqwRNu5Iq2CFz9Afnuv9fIstlMJXp87Bp?=
 =?us-ascii?Q?3xm3FjsBihEMUqosSimcYOrBIUZIrdKw1acViSjm5vBRxnQOxz9SfW3n7oYx?=
 =?us-ascii?Q?P3OnYcWa/A1HreaBkWPBVhpOqxwvmt3UHTXeG3UqgKIYPBJQeoDE+mSIewlO?=
 =?us-ascii?Q?N0vWCXtrhITmDZqgpg0O2LtRIQF74zs3CPTBcTVKJPBBH4g8PtF7U8aYRfFZ?=
 =?us-ascii?Q?1UrsIDqv/wE/Cdwz8XZtZAOZunRwKzXv6/S2u1uAfDPi3LviZ7mE1UhYfsKG?=
 =?us-ascii?Q?yqAmHi3Rg4oNi2bkeEkNoUJBLgPZouH5gE6ZsgbSetwiW84W36K/Bf0xsX+d?=
 =?us-ascii?Q?fjv+4yG9D18jRajD6xc/8exUlHDllF1eV7/uu+VpM9YneiPo5BezCTqxDki3?=
 =?us-ascii?Q?rgaJbIs+e+sKFPWMxBvKJaAVk7F1za+Icw6t6PEq9AGnuKaaxna0l3gwklx2?=
 =?us-ascii?Q?eA9vpHbXUBNxaBz2znPkV/hyMsyIKOEuhy+WRN9/xX/1RE/MlxpTu6XZMEmh?=
 =?us-ascii?Q?5wGlMsYxCkOF18OTxL6TQZRMVXd/uZshd+Pz5dfy/vkr0NXc1IxU5JRR+HFU?=
 =?us-ascii?Q?lPKFur6WXyLfc+RmGcvhUIN++LREuOOL+/YInhWcGVfUnuwUYyXlMoA+Bg/P?=
 =?us-ascii?Q?XwHOl93MLzDOLinJIh6NDF1y2j7gJgPfRQ+7Rb8sZRPwIQ2tpoTn9q9PrwPs?=
 =?us-ascii?Q?oZl7ldNaFhq8bXCN6cWPqxpmAbmO7x//dx5B5nHwFGOFNvakt4ikNQvpQVs2?=
 =?us-ascii?Q?w1Fa2kXh2mvDDVUlhaZchR7B7qrjkMDt3QaucZWsxZEPYwGY+uBzEHt77RKq?=
 =?us-ascii?Q?wT5QSyX6u6rcUApph9iku2xjiXTGZkIkAK4eIBNU6iL32LKkU4m2ewwzBx+E?=
 =?us-ascii?Q?o2OgDwOXiDIachUqHyqWSlAOOTsGrF1h3gVd7CqKWeVvF2Di6QCgfsdN1JBq?=
 =?us-ascii?Q?0TYwgdoANJDYtepgRFp6HC5zWQrfuQxEmwmIed4NA8CJ5IZeMvmrXBWaEx1X?=
 =?us-ascii?Q?C/UJ1RKeo8v0VQsuyRg9zlH/dv2XKFWMBLQNkNFx0cDLWCQgipmQH760Ee7K?=
 =?us-ascii?Q?TR0SKJ3VDJKdBoJL/ShZ0vQ+IaVquJ2tpxCAVXT4+DUdc2SKDOfXxTfSrvO2?=
 =?us-ascii?Q?e36fBtLgldS7MlvVijnSptX08tzvAYZfpo50m5K/8MdSRFvzQn3/KGerU06M?=
 =?us-ascii?Q?M7/NEws7zi/5Wj8r11S+PzSd+zCeatGc9s3QlNBBehH8Fbnwn1sgQoFVHX0m?=
 =?us-ascii?Q?c+1ERQAC2GGyVaHzFMBTGjVglBZhFqKTk47lS9dZiFVyPy8gkJr39gtUiu00?=
 =?us-ascii?Q?ig=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f86743d7-ae60-418b-baee-08dc5a479dfb
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 16:51:22.9795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KzilnLHlmS2r2MWjZB4sQlTSO0YlraLNCq5H0FmkEfHZ1Z0CpxbjqAu+OgZ4+DA12AQs1U87BOkmt/DfOGDFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR10MB6905
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Apr 2024 16:51:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15547

Hi Nobuhiro,

thanks for picking this up!

On 05.04.24 09:39, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi all,
>=20
> First of all I created generic kernel configuration for x86 CIP reference=
 hardware and performed boot tests.
> The configurations of each device in cip-kernel-config are merged using K=
ERNEL/scripts/kconfig/merge_config.sh.

This script will likely prioritize the choice of later-provided configs
over those earlier listed. But we rather generally want that features
enabled in one config are also enabled in the merged ones (superset).
How could we achieve this? Probably most of the comments I would have on
the ipc227e diff would relate to this.

Jan

> Also, booting is fine[2][3]. But there are a lot of differences in the co=
nfigurations[0][1], so I think we need to decide
> what to do with them.
>=20
> About M-COM x86, but I haven't investigated it yet.
>=20
> Best regards,
>   Nobuhiro
>=20
> Merged config:
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/config
> Diff with ipc227e original config [0]:
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/siemen=
s_ipc227e_config.v6.1.83-cip18.diff
> Diff with OpenBlocks IoT VX2 original config[1]:
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/blob/master/plath=
ome_obsvx2_config.v6.1.83-cip18.diff
> Kernel size:
>     7760544 bytes
>=20
> ipc227e boot log (merged)[2]
>     https://lava.ciplatform.org/scheduler/job/1113259
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/ipc227=
e-merged.log
> ipc227e boot log (NO merged)
>     https://lava.ciplatform.org/scheduler/job/1113356
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/ipc227=
e-NO-merged.log
>     kernel size: 7251072 bytes
> ipc227e boot log (diff)
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/blob/master/ipc22=
7e.log.diff
>=20
> OpenBlocks IoT VX2 boot log (merged)[3]
>     https://lava.ciplatform.org/scheduler/job/1113301
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs-me=
rged.log
> OpenBlocks IoT VX2 boot log (NO merged)
>     https://lava.ciplatform.org/scheduler/job/1113303
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs-no=
-merge.log
>     kernel size: 9203296 bytes
> OpenBlocks IoT VX2 boot log (diff)
>     https://gitlab.com/iwamatsu/cip-merge-config-work/-/raw/master/obs.lo=
g.diff
>=20
>=20
>> -----Original Message-----
>> From: Jan Kiszka <jan.kiszka@siemens.com>
>> Sent: Tuesday, March 26, 2024 3:52 PM
>> To: Benjamin Schilling <schilling.benjamin@siemens.com>;
>> cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=E5=B2=A9=E6=9D=BE =E4=
=BF=A1=E6=B4=8B =E2=97=8B=EF=BC=A4=EF=BC=A9=EF=BC=B4=EF=BC=A3=E2=96=A1=EF=
=BC=A4
>> =EF=BC=A9=EF=BC=B4=E2=97=8B=EF=BC=AF=EF=BC=B3=EF=BC=B4) <nobuhiro1.iwama=
tsu@toshiba.co.jp>
>> Subject: Re: [isar-cip-core][PATCH] Add support Plat'Home OpenBlocks IoT
>> VX2
>>
>> On 22.03.24 12:39, Benjamin Schilling wrote:
>>> Hi all,
>>>
>>> I'm joining the discussion to start integrating the M-COM x86 support.
>>> What's the status on the generic x86-64 target?
>>>
>>
>> Nobuhiro wrote recently he has a prototype. Maybe he can share to finali=
ze it
>> together.
>>
>> Jan
>>
>> --
>> Siemens AG, Technology
>> Linux Expert Center

--=20
Siemens AG, Technology
Linux Expert Center


