Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797FDC25B75
	for <webhook@archiver.kernel.org>; Thu, 23 May 2024 10:10:50 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.48])
 by mx.groups.io with SMTP id smtpd.web10.12004.1716459044064872091
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 May 2024 03:10:44 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=CM2jivaC;
 spf=pass (domain: siemens.com, ip: 40.107.21.48, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQQDpqCfbVwSPdSWKnB5m33RmLm3dQqYNwU+eQONvtvuGzRlHY2xtD83KPzxYe3+YeEGPwlRptxCe4HDS42R6n4BQj/XyhT6zxJnUp9eG9I4o3Esof80rziSJhGNdBBEgKZv6O18Ty6ELfCEguboSMPgb63U4haQg62Pu0pdg36b5ObhC3MwXO4q3Tc0aKfxfeHVnP5ZlJNcXXnM2ILcisrtG4kBi80qVqrR9BDbWMVLi4ZB2dZg5inYLHLkGNSSsSlS0Q8BycF8aZo0bheUuqlX/xsHqK0X7WaCAD08YgGhIEzy0YX4F7CbeADNx62DjUleXxBQA3GL6qC38frayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yf9ToVT7dMf+qUJSeuxV75Zvruwapyvm9wZRw8BOro=;
 b=kEFElyYeZDJ24beUurRqaZ2pNF5NR/BfsjE+L+kYbzZ7xddzWtiANZVCSIItii4/Vos+HzG0j4t1qUJeYBWPDxxxd4gcPHMgtuVPsQJjm1WYwzCa8UiViqkkSK0zuW8fkcVst0kDLgNN01oJ/P5Wzb/ODhrWdSzL+54tc/9beBq3QYQz7gpCsFrreV8R62lVq8hcSrUf58tajBAxUi6zwckj8SIKqdO2crt/7RQhg3Dy+KE36bZ1v7ogBgfY2xD97NnYRgR2Tlw5L/zcJaxhfmaxnqlq8Jy4Xfk7a1G2WBD2iZQSKnKmTzuBUuI4k7Z2obObR8SPTgd7JSJaSBQZRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yf9ToVT7dMf+qUJSeuxV75Zvruwapyvm9wZRw8BOro=;
 b=CM2jivaCBmYQmZxyZgxWB88ogLxx2OkQgLeKpTSZ56YmCY258/sgzGvFb6GhKYQxXpmJ054je6vvAQDAJa6mSYc9ppTEvCljwFDhOISshYp/Mb1n0dMJRhfeA6GQgDw92yA0poVhQfrjVqbDjU3PWri3mNg/stJ6zGFOOhnxPshW3opVPZjYDOeZuXIYOdLZajdvRoHOCOobvjBRcytxAB59r0VzZRVhPSF/JE+U6HJdiMkIHnw/M6WGnE6FwtzJWTjGUjQcc+jkXK1hhDU6YCT7WkPGKFT61b3fgGK7dy7lVjOHO6fg8SSa/e2CvKu1AQfzIYDkzOZTK/xsxVnSMw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33f::20)
 by AS2PR10MB7904.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:648::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 10:10:39 +0000
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d]) by AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d%7]) with mapi id 15.20.7587.035; Thu, 23 May 2024
 10:10:38 +0000
Date: Thu, 23 May 2024 12:10:32 +0200
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Chris Paterson <Chris.Paterson2@renesas.com>, 
	"pavel@denx.de" <pavel@denx.de>
Subject: Re: Re: [cip-dev] gitlab testing stuck?
Message-ID: <c4topyfzwtzk4h7525yjhe56lgtrisjfqkbsvmboz3o24wgub7@ji4aqgxfow6b>
References: <ZkTwEKwobEIumswy@duo.ucw.cz>
 <TYWPR01MB118620EFB0163032D2062BA13B7ED2@TYWPR01MB11862.jpnprd01.prod.outlook.com>
 <Zk8NZmeJPwIYiqqH@duo.ucw.cz>
 <17D2152C9599A0A5.4692@lists.cip-project.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17D2152C9599A0A5.4692@lists.cip-project.org>
X-ClientProxiedBy: FR4P281CA0061.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::7) To AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:33f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB4727:EE_|AS2PR10MB7904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c79eae7-41e9-4894-9422-08dc7b109881
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1n6RnICgvxczOsNApcsEhVTEZgi7mKRvgmOsoTUd73NcqFqm93fXIkr/yJ20?=
 =?us-ascii?Q?LqlW12LMfkPsrebAHqvjjVFCHY+U0bzmS50y5xxMg3/EvolCFoK9xJXnouxW?=
 =?us-ascii?Q?2g3cF2BqgAONZsmAvLBMnC93jvMbwuAGLGAvlrBcvsIWHT8537A04O8wtjdi?=
 =?us-ascii?Q?1FLWqZOs8PKyGwj4TnFXPwop8U2fiv66OerWj7CpG4hi+cTHLnCNGPdKoZr0?=
 =?us-ascii?Q?mKMTT/huHkAugNhqid/2sGibxafdqrrsBdblg35DHeTPaZoXvMlo7+PW1loo?=
 =?us-ascii?Q?RL3c5g0tjviT14NUtUeq+QMO4zWmp9HzzIHzhr/366rixLXmJYhIgHoOJueX?=
 =?us-ascii?Q?QNGxWs6tGFWwshE7XWxWL0QTLp3k1aU20BPiRQdmijkp7h6Dn+tB9PwYXeXw?=
 =?us-ascii?Q?xUN92TvliISUWm6i2+j7XoHCVxdbDWh7CwtKaaQYp0JbC+tI+88yRBLbN3/U?=
 =?us-ascii?Q?e92+UxBAhuE3l7WbALuV4lZJcUh2S+CRG8iaj5jWBaR2RxZA10EXL+gV1aLJ?=
 =?us-ascii?Q?HpgYlP/09XfwmwXHSOfqrd2UKczebj4BnIunpXphfE3kPPczgstEwC2tKUqH?=
 =?us-ascii?Q?7XxwdylmciihZu16mLw49Y6dQGAMDVL5KN53RVd+Vdq7DAkbYEr+3gjjkJ3Q?=
 =?us-ascii?Q?0te24nhic8CIeSAtRxJE4p8R+RPgZsD+F+x+baYE3tLG8Ocnwjb7V7wluNia?=
 =?us-ascii?Q?GUCF2+OOpo0VBlp0Rs2LKBDNVtYaFOehsiiF7JGMO3ElC+TXZh+n7GipNwMw?=
 =?us-ascii?Q?0xBG1wGTr+cVZ/S5uOYXCJUPQgeeHb2RUWSFJYISlZY7wRjZm1+DhmK/ZL+k?=
 =?us-ascii?Q?8eVP/3p+aY3Ea3YXnE0zjjSx97r5jb6r4RjfuNxPncuoQxzWFLN4YPTBWwYd?=
 =?us-ascii?Q?kxi3t2QyGXMoNG1lk/dRV8P4eTQBJpdHV1U8J9oLarzDviz7C1nFjNcRNIMa?=
 =?us-ascii?Q?6ZuPKwqv1CvWZt2UDGS/gvwA6JFL+4UHfbx6PdJ8OKI8EcvezffRW2OECnHP?=
 =?us-ascii?Q?iVfzHg5mFyJajAq0Ima+lXThKIwmeQbgvJtxH96vDZSxIIT8TFAulMeLSGMa?=
 =?us-ascii?Q?vBUB7vZJwjW8tSIexLVzP8yVYB3yaPw3mGdeTELy5mdBkqCGif0/7/XpxUFx?=
 =?us-ascii?Q?klfZwtkcSlleVehNIMidTxZ1NAmm7L/TfIYXxUgz2cm0TD6uthStB/e+VMGh?=
 =?us-ascii?Q?WfTruwcukJeWWz+bwZkU13BRUXX2Bk9CRXOx3qR51xCQ+B5XgIPzUkqKkeU?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?8RZnw/EhtvK1ce0G1brNDsouSC24ix2y08pL+wnQoIs/r9l7nNwCdChALikC?=
 =?us-ascii?Q?aA23hH8iZ8azUOiryE+PPAYQq6BvdlKxD6MEBBBG+VR7lSENmAOwYxU4CA17?=
 =?us-ascii?Q?T55v8nL9XJnRBajo1J3e7dqBX4HEloCQPp+sQTaK4p3FmUYT0O5COsy3PDEV?=
 =?us-ascii?Q?zyiQLwOLEn4cslnl5VzVAstapen0AxbJodorwH0oRusaoTEV2dY2/cDUBXZp?=
 =?us-ascii?Q?afv6sTVcKKUwnHu4JHgtg4dPC4JRoYrLmoRZzrXz+LBKFSltxRyGt8PHCS4t?=
 =?us-ascii?Q?chrdv4DecnzvNNUR8Ku+H2w4O17eoXZGLYHUGtSLxsvePEzLgNGWCdwDN0+b?=
 =?us-ascii?Q?yXVdjeMKJ0kYzi8Lx80QgU5+X4HlM/G+35B1JOwPFZHkkA8r/76nPW2HvO2q?=
 =?us-ascii?Q?616O4WIMxVY1d0Y4rn7Ux3P4K9Cx+OOK+KC02JRJ8R22GsIXqKH3s32lejbQ?=
 =?us-ascii?Q?GTL00BeQXJrtgeAVC4fsbNokUnDY5zowhFwsd4atfTMnvagWp3knQajV6AZJ?=
 =?us-ascii?Q?6xOe1n9tuvIBRlYtTysIRaxSD2Ml+Q4Zc591Lbi2QcAUCV5HrBBnGcR4T94A?=
 =?us-ascii?Q?SwYLIa3NkYX4U4rZ5ayMfzhYECJVJCIa0Mx8SbNMdsHW0TM+MwmZJD7fyiOg?=
 =?us-ascii?Q?zXcchw3y4165mcUXguqlPKWQk35t925kKWwI8GwzDVCkyHOPTCKM2vMl4JXf?=
 =?us-ascii?Q?yYYZey+VVAt6T1Aq+BmCzluw30NdsKOt8pXabHmIgNOHy6UbvuHuIaipsLmZ?=
 =?us-ascii?Q?rTK9YnT+Kvo/iEuTQ8HEzj4Il7mzo+dnoR08b2zXH/1S/cN+dNxE6LtCEwGN?=
 =?us-ascii?Q?8vBQlqvOVyJPO5b4Jd4CI1YKN+vqyV7DQrgxWs7gcKIPkaQiGOXUk6DZTGFI?=
 =?us-ascii?Q?4WMOE7qKCRw3+licMvtAtcQg1vopYkYlFbed+nbmIz+xz37Sae6MlY0//wKp?=
 =?us-ascii?Q?JcYjWESEOckKl02xoyjzOZESd1giH/R9IKjNE3y6sCgJxLnJxuyRLdLhX9la?=
 =?us-ascii?Q?r8IeP+o8DiFFbWHpsf3oT3VaurU6kRt+XRNSiCgdKyfOCm0SlOxX9NmtaZ6x?=
 =?us-ascii?Q?3UK65qYYsM7Q2pGnPcrLS7gUTkSnNXY4MqWYKO48CXUNINB0zGYltwXwNoin?=
 =?us-ascii?Q?7/ntwmz3b6Gsby7rKXJzma7OlAp0oJvB1lCM7DWysIIxKcg9G5GyrzrWtX7+?=
 =?us-ascii?Q?APdfbQsbQ6crSfXC0A/VPV9nlvYE8GDnP/K/0kOIBwxxZXplzalv2n4ZFVNb?=
 =?us-ascii?Q?b1qtM92xqtJrT88yJXRWyHbiT6R7qHsLPdh8tZ59BWdpkIz75nelpAwDbjZ+?=
 =?us-ascii?Q?bZC4Tgio3tSc57FTUvKFI42TX/mg9QxTfZQVUMG7uRdAcw+XrBbOF3RRxQdm?=
 =?us-ascii?Q?Xk8e4YxeStF8dI4T15gkot1HNf9BzrgiGyulOC2y7anbL8qwmrhnguoXLL24?=
 =?us-ascii?Q?GiFC9D0LqxDekdsmOJguq7bhvucdrz8dmvS9ESoVOQzxawLquAvvVQ6tNdsq?=
 =?us-ascii?Q?YRAVjx2UJ1Stdf8z4WBnFTVTZOfLlt0uuHrnjQq0OMF/UTZMOn2Cjb9H1gX5?=
 =?us-ascii?Q?3i5s+Gi2e4DtE6iAH2Smx2yjyjfZrgZzgEPcZ2IbToJWYYaOYnkwSFgt7kBP?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c79eae7-41e9-4894-9422-08dc7b109881
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 10:10:38.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4RvJtPdR/VP/KndOoPAv8TUPT9AnScvrShj8o+9Ntmk0Dlsjtjb6JXp2hEdFHVfcoaFc+r94QkhNKduFPHOnIw2Nve6H+wmx6qsPWQ8csg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 May 2024 10:10:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15930

Thanks to Chris for providing me the new tokens. I've registered the runners
again and it seems to be working.

Kind Regards,
  Michael

On Thu, May 23, 2024 at 11:47:54AM +0200, Michael Adler via lists.cip-project.org wrote:
> Hi,
> 
> the runner is gone because of a breaking change by Gitlab [1].
> Basically, someone with the appropriate permissions needs to register a runner
> and send me the token, so I can re-register our runner again.
> 
> Kind Regards,
>   Michael
> 
> [1] https://docs.gitlab.com/ee/security/token_overview.html#runner-authentication-tokens
> 
> On Thu, May 23, 2024 at 11:33:26AM +0200, Pavel Machek via lists.cip-project.org wrote:
> > Hi!
> > 
> > There seems to be something wrong with gitlab testing at the moment:
> > 
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/1302074556
> > 
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/6920224416
> > 
> > gitlab says:
> > 
> > This job is stuck because of one of the following problems. There are no active runners online, no runners for the protected branch, or no runners that match all of the job's tags: small
> > 
> > Go to project CI settings
> > 
> > Best regards,
> > 								Pavel
> > -- 
> > DENX Software Engineering GmbH,        Managing Director: Erika Unter
> > HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> 
> 
> 
> > 
> > 
> > 
> 
> 
> -- 
> Michael Adler
> 
> Siemens AG
> Technology
> Connectivity & Edge
> Open Source Embedded Systems
> T CED OES-DE
> Friedrich-Ludwig-Bauer-Str. 3
> 85748 Garching, Germany
> 
> Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
> Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
> Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
> Registered offices: Berlin and Munich, Germany; Commercial registries:
> Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15929): https://lists.cip-project.org/g/cip-dev/message/15929
> Mute This Topic: https://lists.cip-project.org/mt/106259374/4520419
> Group Owner: cip-dev+owner@lists.cip-project.org
> Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/12503494/4520419/1780039012/xyzzy [michael.adler@siemens.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 


-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
T CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

