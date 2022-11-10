Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B934C4332F
	for <webhook@archiver.kernel.org>; Thu, 10 Nov 2022 13:39:11 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.62])
 by mx.groups.io with SMTP id smtpd.web12.7534.1668087546274510275
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Nov 2022 05:39:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=kf6HgDCd;
 spf=pass (domain: siemens.com, ip: 40.107.2.62, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z37qLDL7XF80yCTiqQuAK5zg8wNzhcA6sFBHW2XHkTVzOZhtFQBlzooJSxyhDBQk6doCk7zux5QG00E2HSedqBL6pAojf2KZI3s/TEhrWR5FRG7dYg48Se5VX8LfBO/8i9QtP90wxH/AT441c7rTbh5owGqSw7m/nnzcfL7Cgq+6PazsaH+uveSYZ9p8NaljFGftCupSaHU+c/x2//ZiuzSOx9IUZcQTYimRwT4qqSRs5pXc1yXulpyUqm9R0U7ISxAKufKThrE0ctsYMvqom+DdEM9o2ArM36f4aY8JXny5yqvnJ2EdlfcqM/kJbhAQ/5+YAxK7cRYYX2uiiUvgrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFf9CRvluZ1QXBX/GEKUxxdhMqyDr4ryNoBXhXAxfS0=;
 b=Kstl6lORFAEpIEvzob4Jo+HosVM4ZRvoQmfcVLx9vDQ8G/swYQdLKaeeLEqp5R90Its7fqguG06X8GlSCpjuW9X8kxLxP+kgi6OzR53jyeuRsZKNB9e7xH3bcdqTiVvT42sqrTqgk+qqcYaRsXOkejTGJD8Qw7imVRJJboYFXWcT3qTLrbVXnJtySO1UbzXxj0Xo9mpFu8HYeurUImcpvs5ijR5EOceYlw0aQWm6Go2HUM5LTPpM7msMmUJtnQRcPEs0h4NojNGU7nob9DAsnFOLsJbyLlH+5eMFzrjAkP+M4faTQc68JAttSTI+u1XVbMZHh2gNqkSLEngdTdtk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFf9CRvluZ1QXBX/GEKUxxdhMqyDr4ryNoBXhXAxfS0=;
 b=kf6HgDCdgatpHDiSSrdm2PhKYTxYm2YrHJdFcNFIATLQsMtFtwcWk+rVY6D8jEFiXASN0xlFk+0wZ6gF4BIVf5tJ99jwjc/WrN+vSjqFq022CnqDwI/+4gjfkI7xw1iI7Cweq5ZB7a6uFT6jW1AJxP0ih5t77MxKikFaXbKZVX47rFC85DBzAHecrkTURQ80KnlJbXtEFp2Xyfye7d59f4fIPt/ICAY5ZVtbTI6Sc0lj/z9B6H9+dSLwcUTIc2a2MZP2vpN2d6usgduZJN00YyFXDqHCupFZhVtZyorytiSP8TvMF86HErnNIfZJ2wgd370hgdfHSyhwdrizOoR57Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:383::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27; Thu, 10 Nov
 2022 13:39:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5d9b:b9d1:bd69:107b%4]) with mapi id 15.20.5791.025; Thu, 10 Nov 2022
 13:38:59 +0000
Message-ID: <e7fe9b32-b5b5-a2cd-2963-ff0d4a332d76@siemens.com>
Date: Thu, 10 Nov 2022 14:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Content-Language: en-US
To: "Schultschik, Sven (DI PA DCP R&D 2)" <sven.schultschik@siemens.com>,
 "Su, Bao Cheng (DI FA CTR IPC CN PRC4)" <baocheng.su@siemens.com>,
 "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
 <20221024122725.383791-4-sven.schultschik@siemens.com>
 <3d75d1509a201b658f4e5be035265ef82fa43b08.camel@siemens.com>
 <d8d40615-4e43-86ad-c947-cd3c0827e389@siemens.com>
 <PAXPR10MB5037772EDDB7F8F29463E6DB90309@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
 <4e5a1133-8b45-2d45-101c-b059a89d6251@siemens.com>
 <PAXPR10MB50370BA1C33D4D3C49939A5A903C9@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
 <4cf6d301-bbf3-bdde-e4f4-fa646701c3db@siemens.com>
 <PAXPR10MB5037059BF144B2A489A75A6F90019@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <PAXPR10MB5037059BF144B2A489A75A6F90019@PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: CH2PR05CA0012.namprd05.prod.outlook.com (2603:10b6:610::25)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB4PR10MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: c20e3ac7-3a48-44d5-93c5-08dac320ebfc
X-LD-Processed: 38ae3bcd-9579-4fd4-adda-b42e1495d55a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	tt0FaGBrHA30QZNdg/DIVwQmeBUIOF3vYg54eHFUeGy6W50vWzTpFkKPxKynM0YlseQsf63eXeqnRhV+71BzA/4MxiC7iiW0zrGX/9oTFltR5nK1GYv8zU7DBktutkUsezo4xZ4/v5tPdZ1I1lJ+2J5kV/tYBEAZUt0KsD7qXw+TSiehlo617v4a2EJPRrO5mSLLdChpaUIgXQTIctG8jie/KLV6IYMD+xSVK6SBE/ZhYTpEDWSsbQP2wopN4ZO0mfk1eWAzbAkUNrW9JA7qfn/lOPrdqwRB9+EO5PKBTUYRLtqbQIbyiaiRgcufKTN1sVLriA2hpanxnTPrvWV6GhWdw6qJ/FTAFd+GUIBcVz592tD8NXvVj/rEc3kXt/pWTyokMRtvsiBMY3lsdxR4qzaf/E3CSPQcteRMa+qWX0kdN3MlPbCNCDtcWn8EX1nnZJVDiHVQUarOf6Sbf0dn3y8CNypfZD+LpwlMgSju44c8qJtHFqBQqj2aiPIcE7ISwHC+r213N20ujya5oHCbyVvtQEHnSHZK5nY4Rl+kYHo0q92/gBI8eIaKHcdv5D2OHqWVNi5hvEd6+McPPEM1S7fhnpqTOZHuuF33NhhmJ5T7LVrVk5+RlefhOmCNn6kLgLnXSh/bzdNC5mR0UTNPQXC4aBNvDIVzti+2LuDG/Pf6pgWaRGG0IM0xv2UEbgk2wxb9qRH9OfiKRF5AvpGbaeSTla2NxMNXdAEixCGnIjzy65sTmtuZJn9u/JWcojae2rNp6OnRV9zuckdUSBtukt69W1WpjuRebm4VO9NUc1OAtg7jVmNwVgkRtRvemf0wEfehQbu/f2N8yayVi/URZA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(39860400002)(136003)(346002)(396003)(376002)(451199015)(8936002)(2616005)(82960400001)(6666004)(38100700002)(31686004)(6486002)(966005)(316002)(53546011)(6506007)(8676002)(66946007)(26005)(66476007)(66556008)(36756003)(6512007)(478600001)(31696002)(41300700001)(86362001)(110136005)(2906002)(186003)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nHvYGKqBlqoAS94kE2PQQy3ciGOy0kiTl9y++v+6mvH5Yrr0AkPfZnGMmb4N?=
 =?us-ascii?Q?jRQu9f0qW2TXS5iE9NjPZcYSH7Gh8he3QA52X4cgyTOgqpzfyaLpXfCbkl0e?=
 =?us-ascii?Q?uzFsvG5Cr3UUxJOAgfFt0b0OXkm2lAoNmYQzyD1DTvSmbWRtID2RE1Zd3EKP?=
 =?us-ascii?Q?uY7RpIOiNQufePpNnL/kCWANDJzZCC1vLu16+2nX0cxSG9hQVhDerEMB9ZUu?=
 =?us-ascii?Q?4YOKzf0RHK14MUPWFydHmE1uqd0cft+n04YyBZfTdQelfVs5rYCnS5iv3bNI?=
 =?us-ascii?Q?l1eGLJtO69xeL388YvLP1r0kIpWHLDJZE4nWFtgUDDzXF1u/EYduRz6f7zgs?=
 =?us-ascii?Q?npefc3lbZGMyxLfrYEVpsBaqMul43CD6agtcwTMSrwHHiDXRxOqv1H1nFBBC?=
 =?us-ascii?Q?mLUtBW0hNqSZBfGVUUuGSekINiSyDPdi5vcwQYhO9uJ0RNWDw4bDO97fjwVr?=
 =?us-ascii?Q?zS8GatnBZ5BQF5udHBWY9LMh196WmxIUeOQ7awC8rc+aZeM1zWqBsboeGMQw?=
 =?us-ascii?Q?VwY1DqXzXW5sVc46ik+X+x0MP+DFne7sOv4EY/enDU5PEwDmnPvJasnXuv/C?=
 =?us-ascii?Q?M9BtrTocbtqudRPChCUktcuvYgH752yi6FiqL1rApFovkNXi4exWhnBenZhG?=
 =?us-ascii?Q?boDHAl1jgDm8RXmYaJKM/LZDbsCKEMNfBgtRxUWjEUHglL4ikoloShBQQh0p?=
 =?us-ascii?Q?Od464qHekVGrXyduId0u6/Lqg1XCSkBzQCDHlVBZPsKYz6Scxn8D7qLz00wY?=
 =?us-ascii?Q?asN/ey7zkz3cK4AmTYB5CjI2iQTdkc4gOJc852aUMmJkrWe8W5IhDx7FIbY5?=
 =?us-ascii?Q?8eKrYwrynGbPHQla2yhNfP+MsmrrScFE5Hu2XxWhwWLYFj4xpnbrTtNuxC57?=
 =?us-ascii?Q?x/eo2pCANotlq7x1iiROxEyvxsxc0Bd2gTwzJIoA91izCPoUBkH2vktSevWC?=
 =?us-ascii?Q?Tf3o7YXlG78IIn1Gf0GX0ZKZmafGrwXAIDCXbu5T/togVakvdojrMTgBgQvt?=
 =?us-ascii?Q?JDAugDX2W6X0HBZYTU4QopkYX7Km026Jkxe2JEb7PcHtT7w8o12ZV2dO709c?=
 =?us-ascii?Q?s6Z30063bzlZc6DgWmu8Qx14heqA0UEIyocYkNt7Ki8FSyIk61a6zoiOtyJv?=
 =?us-ascii?Q?DiAI52ZzzogM41BvNsbUdG/jMw6UT2h7nSQFU/+whmMEVAIyAhk0CnWLXw1e?=
 =?us-ascii?Q?QA/+UHPkR78v5hLItX3blMZZL1CqSZUhgCaPO5vrnbky5mK5hObB85UK3J5a?=
 =?us-ascii?Q?IiZjqRolSm8hOdk5kajvoEWclsIfD93u3ypZ4k7zBoil5mQ5LQ+81Z/bCdYR?=
 =?us-ascii?Q?I7IQvKatTSoREcQ+A1QsjMR28xOmO6KqMKBKnhPZj1+sW/A4YLzTCeIUUpdl?=
 =?us-ascii?Q?LoeQu7o0NYAjXvV0ybdcU3zVpH+7NS4enwfE38T6nkKqefa9TbN4r8Wy4Us6?=
 =?us-ascii?Q?aSCMqaDQm0bJivDCRDTPBTVucm64feOV7aV/5j8O+X0w8ZmNyfo7vxwFtST1?=
 =?us-ascii?Q?WIf8lUVr5QowUyoJIe+soyvVrYx9YWAKGnUDcPOgV7cMnQzPba/80nAJ3Cgr?=
 =?us-ascii?Q?L0iV+XBD0u7eC++d2+11rPBeJLHwrXvXMPWHvyxXn38oFUUWrquTvUqs2Nqz?=
 =?us-ascii?Q?8A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20e3ac7-3a48-44d5-93c5-08dac320ebfc
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 13:38:59.3633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MpE1M3zpvQTJMJj1lXSMzK7ltumHgg2rwLtyJJSreXUtTAlrd/WieJCvgnkaZ6yXZ/spC7a7PYVRYaGfmWqF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6261
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Nov 2022 13:39:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10003

On 10.11.22 12:01, Schultschik, Sven (DI PA DCP R&D 2) wrote:
>>>
>>
>> Can you summarize again here what options we have now? It seems we need =
a
>> proper RPMB emulation rather sooner than later.
>>
>=20
> Option 1:
> - Keep it as it is
> - CONFIG_BOOTDELAY=3D5
> - manually set PK, KEK, db on every boot
>=20
> Option 2:
> - Write a small u-boot script f=C3=BCr qemu u-boot (never done this befor=
e)
> - This script runs on every boot
> - This script initializes secure efi env with PK, KEK, db

You can basically put the commands you would manually execute into
CONFIG_BOOTCOMMAND. We already have a custom string there for secure
boot, see
https://gitlab.com/cip-project/cip-core/isar-cip-core/-/blob/master/recipes=
-bsp/u-boot/files/secure-boot.cfg.tmpl.
Would likely qualify for separating this "special" extension for the
secure-boot.cfg.tmpl baseline.

>=20
> Option 3:=20
> - Proper RPMB emulation, which takes to long for now

Yes, likely. At least I did step 0.1, registered with jedec.org and
fetched the spec. It's not done over an afternoon, but possibly also
only within few weeks (with some experience with QEMU).

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


