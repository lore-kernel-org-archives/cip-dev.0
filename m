Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A127DC021BE
	for <webhook@archiver.kernel.org>; Thu, 27 Feb 2025 08:34:07 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.59])
 by mx.groups.io with SMTP id smtpd.web11.6412.1740645245624438451
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Feb 2025 00:34:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jP5s1yy9;
 spf=pass (domain: siemens.com, ip: 40.107.104.59, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=clUMsNC0yw6jzQaScudCHUQaOCP+RV2xkJMAl1FcReJ1Kr507X565Gv8IJax6OlHFxvLllRNPA951xzVQVNbso2lozrVH7KlYTyz5zX5Ag24YqfeEF6e8FIjf5kNetJZNN90aQ5aXdNDYMEalND7ZMAQzaJlWwnoDtKXWfls0gyIQ6mLvfda3O+PomMJnvSpLEujT3LqGLuoP0pF9HRK8iwWog3eZAomhsqUaB+Zm2Ola+FfUk0axg4fiFYAKAJlxY1Wa329yoKWf79I1DJ1ztLDQ0psvp8Jbh2z6aaGz81lHrSz1XtqXiR/pvco2EMFXuWDxuv5toIdgK8wyhY70g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=augmDkkzyca1vibVe5mmbgynU3mzTE5CB0RdDIds34g=;
 b=lMsMxc3La0NpaJ/7u5Ali9scjaQTL3LwRm2/Os2Fu/UwaSZr0OsVuSFbi5UojfkoGNP8zBlrKiUr7vHnOQoFPtX5sEs1hxY5a0Rm84hJ5SkDnIICKHzSVVuYxI13I8wsAkr16zoIgPZ9fQzTNO/k51qLuMBLzQf/GhxpEITHUChjtN+suxCsFQoK9K+zYJFQH7FnTvshnpNem9DjzgDb4LECvuRyufdp81KIwWw4WJCxvkWhrxzTqTaBGhnp0AMvor4iBnPfNpF21gZgw5BMHXEQerB8hUSWXjpUf03B+zIrCGmCbxQTaKTEOfpBsKZiAyIIhW5H5526g+VuLyPLOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=augmDkkzyca1vibVe5mmbgynU3mzTE5CB0RdDIds34g=;
 b=jP5s1yy95qfdhXrt0kO7LTJPs/BpXruXPUT+JnfrfXbcep/Ih7AU5QXAapBUSiXQ418NeQGwellRSuzqfRMa4cZ5wgTHi0AGejTQpjDGZW3r6gXWge2+K6pxhM2/4TZHRjwglbPiEcKs9SN3haTWurdmbVstkzJDRTmNSAb6veLwvjEQK0bBz+erKWK1D+B1YOoUmuzXT0QiyCSdiG8zVlF132O1FEwI4GJ/6RzEXYwLQcr+Zttflf8NaiLdVQ5lnILqwVmJoOoIJywupn144GaR42/VyBYzDwA3PYCXx/xcBmxKyO4w1ZW0+mhAiaW41HjeFEC3SPiddqI411Xv3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB3327.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:12e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.20; Thu, 27 Feb
 2025 08:34:02 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.8466.016; Thu, 27 Feb 2025
 08:34:02 +0000
Message-ID: <2909f697-a25e-4f28-81c3-98b503de05f2@siemens.com>
Date: Thu, 27 Feb 2025 09:34:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [cip-dev] [isar-cip-core][PATCH v3] initramfs-crypt-hook:
 Optimize disk encryption in combination with expansion of last partition
To: Stephen Ecker <stephenecker240@gmail.com>, cip-dev@lists.cip-project.org
References: <20250226232812.374892-1-alexander.heinisch@siemens.com>
 <CAK9C7GBj+Ovxx9GqS842OMqzKC7Yfn--6=yQMc8mnDHxMrt38A@mail.gmail.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <CAK9C7GBj+Ovxx9GqS842OMqzKC7Yfn--6=yQMc8mnDHxMrt38A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0387.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f7::12) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB3327:EE_
X-MS-Office365-Filtering-Correlation-Id: 683d664b-3c20-4955-6e92-08dd57097d43
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2q3wUVqJ+N7OxwJrBdkjx1hE8vSlYe3sQCkLtyOpNXSGU6aTbvh/hujeOyzN?=
 =?us-ascii?Q?0wda3TU2uget+VxjNEigj+SY7osSPtJb2Qq861Er47/zsI1UYd52VbM5e6tg?=
 =?us-ascii?Q?KjxGzOccEZyXPCG4OtCWvXrygDuIykHBNSAUulr8GYprVuKHzV75O8V6E/F2?=
 =?us-ascii?Q?84uYRGX0Tt2BnIKEmLvxiw9tfhqccIAWe11DtZ7IE03AOTy+5clgT5lJlPxB?=
 =?us-ascii?Q?LAzxS8HQhZzKMMJavWil+wJ4cvOOmJVEwGCc2Iq6f8cNj6HMC3HcCNlwOKpv?=
 =?us-ascii?Q?9HhdaKk0VMjmh7nCdjcvHrjQTQEAv3FH2UQIRFMEtTuoMXzenjUyPye1/rb8?=
 =?us-ascii?Q?jcLMLqM13cwGRrJeSav7eJkW88Rg5E+HFyAAcdMhJg6zJa3qB//nDaGtRQnt?=
 =?us-ascii?Q?cVNrNerShVY6mC3NdMH89wlc+NSJonqOMrs1uwf0FKmPWUND5/FZiY8NibUj?=
 =?us-ascii?Q?PO4vdoLJPWUsybY9fAnnwEs7JdrdclgVeJLJRI89djPfnbdspVQgaAPuBxVd?=
 =?us-ascii?Q?kihCABkeeBrtVAQc61M87S16VbgZpiaMem3opxFzPGIUC0TzBOu1areBqqYr?=
 =?us-ascii?Q?cnXCZ5IYOek3PCPrxeeChMcToam8k4rOzcHeHDqKP8FNEdR4Kog4zzyo2EDa?=
 =?us-ascii?Q?kEZ59VS9HlHTYjzguksEo/fshKJ3KMWeRx06E+uwFWpJIRCBMS4+h5FqxOSJ?=
 =?us-ascii?Q?OHpu7D+frNptl0Oo2WFuumrdHqHXx8CWryMW7gJqPK3H2ayp+UnzSbtcj6Uy?=
 =?us-ascii?Q?JPOAG3oAYYPbuJiAghdlpkmlTDPuda2J2MhbuD5nsL0zOxYOJ639Gr9HyjH9?=
 =?us-ascii?Q?3zxLDnCUw7PR00hpxynhQBjtLG8MwkOlWHck0plNdp+VV4vHuBDG+wyi/4Zj?=
 =?us-ascii?Q?RsOKxkFSnOsE/ZOsP/SmsKsuoYzm1ZF8pC4OuqW3xzLbiWHH5Lqo6ssy2pi0?=
 =?us-ascii?Q?BWJus0MemXUTSOqcyWJYweSEY0nY2OMusQpxdFQSlqMt1FF585u2h+2Y10TP?=
 =?us-ascii?Q?OdhclZsVpqQs9lK4tdOGAv9MfL4IV30TAm7r/sVAWTmmy4xZ84yjSV3vm1Pd?=
 =?us-ascii?Q?qj8TbvBzgUi7VvYefsTsPsFm34u3WYQNXBovHxc0cSVNrrUspRU8CuxiuhYf?=
 =?us-ascii?Q?pk14Qe4JSbQ8435YBpCyHLzfm+cocmQ+S552vQehs/xfR9P65QMbDcFIRU8y?=
 =?us-ascii?Q?ZlwjzkDwDHqUR5wWse6jLS4ocwNloLpuhrvTWwdgPKgkVlWTKOzBEdLmoBCw?=
 =?us-ascii?Q?y+E52jydyIQ8u7IgWgkMBy8cgo1ONRXG07EDJJs9z0MQgzoX811qpwlO+pEa?=
 =?us-ascii?Q?Ajuv52LSo7/xzVkNsSAHlpzYOhHUFGxmX04TmcNO2mhZToX8CoFpwXTgJ9vZ?=
 =?us-ascii?Q?S7q+mp64o/qDVGd/f2Q0jXVq9nGN?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Pn9Efxw35slMJbz4cE+NbqMiWlj6UBaI8cUwt+eMt2GP9ccVZvEhpUcm6YE5?=
 =?us-ascii?Q?Q3WhO7yJ9a8AGy57QpPDLYiXMmN2z4bPsDbDD8bYP1FeR/9rzR1BqmMUX8gs?=
 =?us-ascii?Q?6kOQLE33W4TiyEgP0wYoweF6oFHPBq9tl4vHG+7h1FPFo/PqA9m4qJjd1rC6?=
 =?us-ascii?Q?2MZA5RhhmIdcJcOe8GUqqL4mJkcO0tus6mJvwnyNDktBfXOCZHlRKmwkNFXx?=
 =?us-ascii?Q?opAA7hoK7vsLfGt937eIKR8uSAchk3jSMfdaXpm3emnZblNZX0Gr74zCanDx?=
 =?us-ascii?Q?L3mkkW+izE+CJ9ydHcbfh+92r4+inHaDgpaJP24Nmql3mtstg1msXUpusRCd?=
 =?us-ascii?Q?sux/nXiKSLEjtPvSSHUHHNF8XOBriCFHsfX6EfM/npuCqEsFo9wEufJCZzXO?=
 =?us-ascii?Q?HY+r+na4/xvszyGRjFqzGLz+3EYHVfu5bhaq2SllzbgSC5/dceVq1Vlgz68i?=
 =?us-ascii?Q?CSYHkK93igS062y43bNYhkf68LYSFHjqaommbWQ9BpIjXOc1JUOAO40AkIcQ?=
 =?us-ascii?Q?MlFeG2ksDEQ8KyAdB6BpUK1sRWIzK/r0wKXl9JAOe0I/6utTHEbwbaCTDyAW?=
 =?us-ascii?Q?Dffp6CjhDP37jW9arRDHmy1MSWeKaWzQlwEEVd4ifkxDMbfFpVHy+Lo4R8Mz?=
 =?us-ascii?Q?OZD1+yWvSA31cYt22oNlrEt+QBVaoy3fjsNxDD6+1kzj0iuitIjfGzoexDIe?=
 =?us-ascii?Q?vMcdB0GzVMLjACmPAnxcq92JSQUPf5kcZ0iOhr6WhLPr3y6uJwnqKjmM2xuO?=
 =?us-ascii?Q?9lToovYYqlhW0U4DjRo5YevLbOeX+YkpxBJ9w8VHMVrarZ0Oi0YnAhgDDI8H?=
 =?us-ascii?Q?plZWOB5zBlnQqV/5rFeoxeiTe9ADa8wpeUGUgasB4EwZK2dambEPpDtnw1Pn?=
 =?us-ascii?Q?qz5fAmu1VHN1oZI5rPfX0nMpfExEAkTcFan61TIWX22qJf+2hTbUSYR3+hxG?=
 =?us-ascii?Q?SIO30k+JfFiaVzC9R4k753c1JwR0uY0kcgv7Ghj2KjiDMReZLptxPNWz6vDU?=
 =?us-ascii?Q?YwVu3HZ5P1EB7cpZW2ttvsSE2aOUdNYrbdPu9CuxFkQj1NNBKdapL1XHlpnc?=
 =?us-ascii?Q?eWMw32iJtYlWW2ZyFCEIQ1V5qbbTbcLwxe/DWIoxPjtxEUb6ujCBCPKz51o7?=
 =?us-ascii?Q?pQ7xNm1S1gIiv4y/hTxE+il/vPeINtIZ5ib0CHPketqfVmefaA66bUDCTrGZ?=
 =?us-ascii?Q?drcPC0xCftoEKAJ6ePmplyJpBgXjxOP1xly92ZMkqCeOLbciYUaUxWiqIywX?=
 =?us-ascii?Q?IdCx9lzl7954sPXEVZ/bkEujhu21tTJfhXADQcZ448H/aFWhTlkgy/WsWFUq?=
 =?us-ascii?Q?CynDqD3cXtp0w//F849HokT+f4vIiJBZNk1M6ViSFTF5a4S0Qe4Fw/7p2qsX?=
 =?us-ascii?Q?Gw/VIdvPkC1Zv1b2bVh+auybm4QzL/AcT5mT3cDPkQ10uScKwo6X51yYM+DL?=
 =?us-ascii?Q?1Xb1dodTlzFh/HRNd0swwJuu7YWgDaE9r1FLuA00ay03JfomLXBjBDtKmB/M?=
 =?us-ascii?Q?NYS2otZHtKStTbOl4en1YGojlclFkPfCPPqH3GwDVNgVGyxraVdKbVPhlrsR?=
 =?us-ascii?Q?ci1XSyw0oGcs/tqGqbfb/FQ3sgabM7XcBbGLOH8Gn7ce+/jntMSgr9l5IaBi?=
 =?us-ascii?Q?/Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 683d664b-3c20-4955-6e92-08dd57097d43
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 08:34:02.5927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eXazSiS+veKKtwh2lCLnovTFA/In9zZ52bv9PEzJK1epot76uDPxBC59+U/WduJUmlJWyBtpvaYtsOPTmxKJiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3327
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Feb 2025 08:34:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17929

On 27.02.25 01:46, Stephen Ecker wrote:
> Is that right?=C2=A0 I presumed it was encrypting the entire disk, not ju=
st
> partitions on the disk.=C2=A0=C2=A0

FDE (Full Disk Encryption) is a misleading term. In UEFI systems, you
cannot encrypt the partition(s) that contain everything up to the
kernel+initramfs which will decrypt the other bits.

It can happen that you run into security process folks that didn't know
that so far and ask for an actually fully encrypted disk although that
is not possible and security-wise not needed.

Jan

--=20
Siemens AG, Foundational Technologies
Linux Expert Center

