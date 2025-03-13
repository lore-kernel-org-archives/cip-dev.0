Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F09C282DE
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 13:44:51 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.45])
 by mx.groups.io with SMTP id smtpd.web11.14924.1741873489721215621
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Mar 2025 06:44:50 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=f+O4Pmvo;
 spf=pass (domain: siemens.com, ip: 40.107.162.45, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLCx2Ilp4HW7sPqClIMzt3NtsA0j1BZ8Ea11Mtvxx3VrpimB1qZ0aKLgDS1M5hDyQsw/An2P5iZSvFMXiVEvye7DWHp3NDCCnmWDNa5c68DaHmXXnQx0X2xpyIrM4TdxaIRFOZqQZudnLxpDUkN3s01ei89HDBl6cA6ft28djmFqDnAp+nttHEiSJmVhoFkhgGywNjD6RxufAinZxpWLX6MxgUORiZ8WkLlW8UwYGtLlKQyaegHAHxRvMn5a4w2MdOkSyos2vjNpdosOjzjfOm/mkMPcMLI1R7GltBe5DRbzq4JhGXCedvCU3z6ACfEVUFKNLUuSg4KNidZoKv8PHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytkHJIiKx7/A9w8VTot/ZxNvZGlKrcGH6XxUqdbaGec=;
 b=FJcnuSuvuZz25cNrsW+GHGA/RpGNpgWfmXUzbR3ZTIt6AybOBNCGD2/NnG0uUIYX649wvpH49zPisLenlkphUIN9DoH1zL9Jpuy+tdd1USo/VZxto9SCHKVOswwjUBHLjEJ8lhC469eo2DhVmQYt4yq73YPR5sxnhUrdbZ1rh/BBGmPfvLmCUKAv6fmlWPjgfX4/kV7x5OCqUIWRxtly1QaYvUCVbnf1ifRSyfz0+O8+4DBcs5YeDLuKMEyBYyd0bTL7czmN8dGASeiRo3z9Ys9HqxDdN8aaeyDVQaVaBozk8UeC/JBYtWTXHWKB5L1CsjYJC3R5cevJ/uNH2Pc4ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytkHJIiKx7/A9w8VTot/ZxNvZGlKrcGH6XxUqdbaGec=;
 b=f+O4Pmvo6G/+LZBrltSEvDCtDcMk4Viau7TO+NQ3yE7qS4aAS1qwRLkMjdSiDuifie41g0ulrEczzXqmJ++85BrbZm/FS5K0Q9q0eWNSDdyM1ymrnChj+9gHukMupEs9R7IXIc3qhiHHJcUdwfcZHm2Snsta8NWAQZJobdm4taZ0VCZJHfIqXwRcpLGh+UdWb+8q1xcADroVqeu9w1MzWf+POzNlu7CMCQxQVx+lEopDdpNXqz7O0cnNSjTDksj1JLZXofhJHb4+AppHCYi9SVLILag3pi6MlIDoyLUNy+Gi87CxFhWBQgUPKifk052hLj4a5lC16Psab06tcTBgSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33f::20)
 by PA1PR10MB9081.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:442::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 13 Mar
 2025 13:44:46 +0000
Received: from AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d]) by AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8e4a:e5b5:6258:c3d%3]) with mapi id 15.20.8534.025; Thu, 13 Mar 2025
 13:44:46 +0000
Date: Thu, 13 Mar 2025 14:44:25 +0100
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
Cc: Pavel Machek <pavel@denx.de>
Subject: Re: [cip-dev] Mailing list inventing addresses for people
Message-ID: <whqvkav5o3ofm2kubxknu4mpctdtce76jiplvg7aemtn2d3q4g@f7ehpky3zjqp>
References: <Z9LQ6u3m4LRFTCPM@duo.ucw.cz>
 <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80dca55b-9632-46d5-9dab-74dde8ba4424@siemens.com>
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:33f::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB4727:EE_|PA1PR10MB9081:EE_
X-MS-Office365-Filtering-Correlation-Id: 95440c29-6744-4efe-2894-08dd6235379e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?a40jDbQS0KZGLzzPUK6+nEF+lpfrnwOdgSuej1RG+c4UY64y8sKHMm+c4lr8?=
 =?us-ascii?Q?Hbfu4WMxVYmQDM+VgC5ySRym/T9AuZ72OXQerGVPDebtsvBJbSF5JnZW/6N3?=
 =?us-ascii?Q?vt00dm1p3pkJJ7i2VXmGy4zbGFwWLWdb2SxzdCl1WMgG3HhtjNVjhfvpLP63?=
 =?us-ascii?Q?w9ROoLZIXQv//Cye72rSE66elFKnis1lbUf/hWu8DNlxevrc139LBeRKw2Jo?=
 =?us-ascii?Q?plumJdi6LEwulBDkmv4mS8jfJhPEhWzOsiVDkjSD/9KO65NstymvKwmAJ+2c?=
 =?us-ascii?Q?pw7aYJr40Jep3jGCr2t9txQC9i7jLuuVa1+8FpUgopQzvtf+TkKQHuswGYFY?=
 =?us-ascii?Q?DYO9iszUV/4Cj73HEjMKapxOj0s7TAVowwxJTuZQDqT06PJrKatrD23AXc0s?=
 =?us-ascii?Q?KENhK6wusQi2MKgQZcZrX8d1LOruZIrKoC+tZG00rBsZC9A4B/iW2WLpOknS?=
 =?us-ascii?Q?G/yef+THC1dTJ3es7M+dH1tCJheZJs58t9W/nlfaPUXcFIAwBDJwofMoC9XP?=
 =?us-ascii?Q?XVZF/eb3uZNoNbymlD/GGqe7pFc8hvslgM4RtkhDOEcN4kv2m2MhSjQ7UTAd?=
 =?us-ascii?Q?3+lrOoj9xdz6878Ed/w1wVYDE+ESOlhh+18Uk0aXuCn/Icmzk64cF2r3wYEB?=
 =?us-ascii?Q?/ClxooUNWe7PYO9/GpcFU4zCls1933B2Hq8LkNgmEELF9Mm52JwI7D99BC2a?=
 =?us-ascii?Q?ZCTplJhL5EWLw4d7XRYXrZllBKPbKllg1ahcMoS4MamH4pk2WkPVPxRZ51vC?=
 =?us-ascii?Q?KT1jfkR7CZ8t526nAADjQAF5f6tJp0YxNKE5p4F9uSvEYm33bzmUMG5m6qJB?=
 =?us-ascii?Q?voDg5IX+QbCcd6DJE5+Ij5Lf/Ew/pZ13BASLK9nwSlk75TTtjYQYQCLVdGIy?=
 =?us-ascii?Q?SAX0liKe7VzYSyP7fPN85VESKQZPwpaUJX1HTUWuTN9OK7nqwLH3xWIUMGPC?=
 =?us-ascii?Q?eRdIv15AiwE252wDXiu410BUBu145jBy6k6XUmDYcnzN1TTwaVrAD5fCI2Vx?=
 =?us-ascii?Q?kPVV3qoQ4bTPaKHk6LiQ8gpqQUeBkf/8hY0CR0d2QWsAkVgHZRcaHHpYdjtd?=
 =?us-ascii?Q?VmOR52MGHeI218CTU8b1I29iuugo+GmRT3T5byx5FsxemhuE8mZ5m7UsWv0+?=
 =?us-ascii?Q?gyRyL0VPOa1gJZhwNnWKUaxbjQvFUtSqmb+mO+ubBAXgY74hQAM+qz7r/sqa?=
 =?us-ascii?Q?a8t4uOEMPvEA8LwfVisGJFa5bKfR4YUky7WIfVNUmJRVAp/CpKv5aMygtPdO?=
 =?us-ascii?Q?uuXZsf0MQptmI1nNl2LLt6ACkOdwxL7zvu+PdwFWqgBmrjTgFq62Oi+sm3Mp?=
 =?us-ascii?Q?BYTS02XzgBwRYi9s6D/gF4ONl6gZPMdhPRN3Mm8gNReIg6BxR+1JK/pcnvE4?=
 =?us-ascii?Q?ab1YVY3YfoT1TMenAygNdTUZ7fQU?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cGonHHXJxaE/z+ZM6uRtkzAwt+ZRUuyRpd+tRIp8u3yo13JFKAY1CricPrjS?=
 =?us-ascii?Q?S/+7SoBKw7h+X9V0LpUYxe9RnfCOXhIxNE3NpvkA3X9dgI0pA2x6MZ0Yg1Co?=
 =?us-ascii?Q?vvKv4sdTfV9JNNEWYvjE9WpYTBb1Tptc38RIf3mr2TKcBsrduM8Rk+idOrpg?=
 =?us-ascii?Q?xOiies1iEQGVj2qp7Q9BdB5Vew9cJiOc9JWTts8JWPLyLVBch5UmC+rPe/Ag?=
 =?us-ascii?Q?yPScqGnGyyr9DHJ+qbtFK0UWVjFuuFVsdZxySHk9D1vImcHT7Pu5xyupDNqa?=
 =?us-ascii?Q?EZe7QOcTTRF8IH0CeirdcVPd6/yQmgKRS80C4+yFh/SYuyTAHAG9Y7GJKnCh?=
 =?us-ascii?Q?EjGuIVSEyCjP0MmY8zp9jwv2d123X29kvty2Dy++OgGpxffKQ815B4zVSAO3?=
 =?us-ascii?Q?f2Ktow3G1zRd5wq/xDZZhwdd0l0wyObthZKwLti7ZOx45iO8LsUoYhVnuY/P?=
 =?us-ascii?Q?6Z/Zx8QjIOwMKIHUJdltXAK3OvTaovR7sNtt/PCZqvhAwT3rpOZ3soI+YpiW?=
 =?us-ascii?Q?JphJ3+sCduHRQk2YWNFQ8VX52VL0Mzm89EfA1E88pRKORInn3oY+0iTSr4oc?=
 =?us-ascii?Q?rPoDWN92IxDOHRoDT6QarH0vOHFf1sCjMfBnrWJr/jWf7CDDrR1Jp5rLsgYT?=
 =?us-ascii?Q?gkYQQ+OKiJ2mJ9D73yoLpn1ZZIf1g1ZK9rNdZbBS2+In7NLoc3NYIHDFSna0?=
 =?us-ascii?Q?B/zO8/5tas9M0sud3g645FLp9F0CotjEYamgcoOcc7Mj2c9YYhRFOr6VuCWO?=
 =?us-ascii?Q?u6SKzTFLo6fm8BP8xdrkk1hkwxRdfNls2jwpytVIjb8/b5sPYSUn+31MgOtQ?=
 =?us-ascii?Q?3bYs98pR/rCfv+jhF5stSAvNQhdMyJhDMVNkFQN+BqbvCI8dFovgUyGJo8hb?=
 =?us-ascii?Q?v2sJvkpU6jJ5XFix2Y/4GUOelmufFDUPi3aoI5Hgwnv1y5Zyp+A0VF85SHlq?=
 =?us-ascii?Q?ZsMnxoDv0jTe4RdzKoxMQz117Fj2d2gPGnpk2e91/UAhS04PJ687mg06mkmf?=
 =?us-ascii?Q?Eok3gucaAs6v6NycpdSasIcF/XWjPujIZiYMOu69ihJ7Zml9jGobb5G96s+o?=
 =?us-ascii?Q?PF2iBF16OAFaCmI7FNvfnvbxgSBS5rQdZUFJuDyAcwJQfeOK1N7fiEEUJ3RV?=
 =?us-ascii?Q?tbejnbN9XJdTROvR37pva6vzNx/aTRTiMymo1MAHhHMDMxp2QQm8Oit/ZtM5?=
 =?us-ascii?Q?WXzrAtIhWMaS4/Re3sstJDy6UgBpHuujgmYuYHMrJcEvVKQyRQ+mkFB0menl?=
 =?us-ascii?Q?S3bTECuYCJqbZURJK0V5UkdnF+BciDFpmd1hioq9xj83Vo0SSxNimFvnEVtC?=
 =?us-ascii?Q?xFXkxEnX270HYeNzPNalcLgRfHS+hKkypsyQkD13byGGuOSvJIE+NMhQTv4S?=
 =?us-ascii?Q?YBArpOT+Lj2VRyD273pYhM1YQ30S6iVV6Y41s6OYUrZ2u3au6g2n1okZszWu?=
 =?us-ascii?Q?VzbhlRvLS7LpVdEubSKhQZnuSXH3MGkubArwGsqcNgtPyukgHbwWO0sN1Ceq?=
 =?us-ascii?Q?7ZKKZnhVeZln0FHffGxlnZGksTJe4oRpTNf3zaZ9fAfZA141nbgwn2JJJNBb?=
 =?us-ascii?Q?HaI0HB8YsvdZtiFLxQ59/mMKYyIGq3BT87/HeA0I5wdE5hjIymb1nmXsB2Uj?=
 =?us-ascii?Q?nw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95440c29-6744-4efe-2894-08dd6235379e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB4727.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 13:44:46.4087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tpRmwe0MI8xvtpR1wOvi55bVYbAqBH+Olw7wU8pm3Bufn3NxMSWHo0IpwClxLzLPMztkZ/+OJVQbXrjqO80Dz2PKH5Qzfgy58a3trbSaCI4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB9081
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 13:44:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18197

Hi,

maybe it depends on the mail client what is actually being shown to the user.
For example, I see the following mail headers (and my mail client ignores the Resent-From header):

...
From: "Pavel Machek via lists.cip-project.org" <pavel=denx.de@lists.cip-project.org>
Resent-From: pavel@denx.de
...

Do you mean that with "invented address"?

Kind Regards,
  Michael

-- 
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
FT RPD CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executive
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 23691322

