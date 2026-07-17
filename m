Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1F47C44514
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 07:46:49 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8708.1784274405096117280
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 00:46:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dK8A2WZo;
 spf=pass (domain: siemens.com, ip: 40.107.130.26, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E9TjM6fhJWnIaYVN+ZT0CiSQA18weEZGzB0cdHTfBj6Du/ghmoujz0O6poPwq75LT214qkul7Utrnbx5PkwrGx+3a/lSF3I4ZdnzXYJrA196s8YKDRFkaQAIjzDW/3sxAGX6/AT5FfFA6ZnMML/Nz4ydAupu0A09H/sYCeQInEQhM+jtGWHT5XcUCJ0oqA9Ep6daX+W6oH7qs/WgDkw1LIPSYf5JFoK0+e8byXqL7OF/VBbyIhbGR08ntPXjHHwNDm9mJ95ncqXIgl7BLoChzyM4kq8bHe8loK3mVq4RaiZE1nZ1ekkxEQ2OUq/G7F+HMuSN7Fa42FH/satqzt2zjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1AWfMhPtYPv0QGXrzaHjAE/pFocrzKcQKKBeBAF5qoc=;
 b=vVOv6YqmiD7/elDNEe3G1ydGBdblue9UgGqOO9aL2skhz2c23IWeR16QmHNeMkCDQHjpjlTlZP47WaiQApnIgbjHF3CLOSJd6jSCEqTVGJc92yWhcaLswHM4PpRmBo4fDnYkuE8L+yM898+sdRiBRYaK9qCQst9AQnL51xqOQgdIpXwiLjMmxxR7xYh4JiXRdx3M/563nXi3nOVKT0yPIh3wsAZ69rFzVkYmYEFiP8EdidWocZOf4uGkyV/4krqpFH4BgAdrGIk86sE8LA7eV76aYNeJZlhjbFFsrlZtVeXFQ1hPcPK8vZjdMaVVTyrC9AUka5iyPLVhcCjK/7Zs6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1AWfMhPtYPv0QGXrzaHjAE/pFocrzKcQKKBeBAF5qoc=;
 b=dK8A2WZoBrUdLXI07TdfzOUH5u9lqQU7IGoqVR9gRnCRFrzXDkWYY2FWidcq9FZAuwLgcy8Rvb/44PzmjtuZCQPL4dU7dqVBT6tQD3/o24KP6Z9h7ezFx+0JHhxQcfBxXwmCZ4JQuAt+8H+Q/3skfmIsiryz7IFoUG/av0u+boF+/Odj099VTdRRZvMP4TQ0Sh7Kk+dKFGWOW+2QtdYtQs6BgbqD2ysnc3I1fm0HxDj5RNbgfXFV5Hiidoww3nkhIWh6nSadOuLlkosuXvPP/VYDdJn3NAs8PmYT/2hZqvZ31TQe1ZvFsNKAG/k4AdzmD17k+TgDKN/THQ0yGMxEhA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:63d::19)
 by PAXPR10MB5182.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:289::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 07:46:40 +0000
Received: from AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70ce:e88d:3958:f5a4]) by AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::70ce:e88d:3958:f5a4%6]) with mapi id 15.21.0202.014; Fri, 17 Jul 2026
 07:46:40 +0000
Date: Fri, 17 Jul 2026 09:46:29 +0200
From: Michael Adler <michael.adler@siemens.com>
To: pavel@nabladev.com
Cc: cip-dev@lists.cip-project.org, Chris.Paterson2@renesas.com
Subject: Re: [cip-dev] -stable testing failing: out of ephermal space?
Message-ID: <alndkM_tdnS3WP7v@t14g5>
References: <allKbnDSqXCS3vZ0@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <allKbnDSqXCS3vZ0@duo.ucw.cz>
X-ClientProxiedBy: ZR0P278CA0155.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:41::16) To AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:63d::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB7705:EE_|PAXPR10MB5182:EE_
X-MS-Office365-Filtering-Correlation-Id: 39fd7803-4eda-487e-3de6-08dee3d789bf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|55112099003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	10OvDgm+V2B7pxNlNLtf1t7qMjaZWH2JvH6aV4qqZiZpoNjExYx9EUg9KjIHW8wp/7zN8NP119J2Qj1WCtzadmOnSmMMOnNNfKejh4QDHT2U6V8e2XC+RBYKEaG4AWo+uZSb/uZc/P+x30KOQSIvigzgk0l1bH6KKpEK1VrzbvjPFJOCR1gHYqawUZtagrfikOnwW3YaoDnZ9tCAtP7z1xgyUJL3ReDQgdz5A4Yqw8vEMbOWw2suOh6SaDW6d/dWXx7VGKLIzxjbvFgUTSz4i9fPkt64OtvxW+M7mGiq1vDsudS6cABLP7rs2Z3EV9EBepxgxivd2lLVAIG58vpmhXenWNf67eOJZetUDJE8PBaMNLUm5rF4Ikx0XUQ1zTeQHspB3jT2SCFt6cYIq4eySuuq98JIdHY8BIWhtvHOGkV7UdwL7FYQCVDi1zu9K2GfH/JM01aIm/4xm7i00aRAMu4+aEEwYogLXcROvI2ZWj8qKQ0rbJ6zveDGDzfGJ5fAyUHx3a1vkiHrYHa9W3rqrkWphUQIRsIV7TxXk5B4NSwFjij6c4b/A1OpO2KjYlYseIc+f538MGR8p8BZC6Yl+lrbi1RepaSK7VSF7w7F/wkwJlE+UBMKzz1wOEv1BHBnYX7Rf13Lc/cDumvqlFYiiubM62y/nuAnQWBiMUp6n0k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(55112099003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nyBK45rn5zN3PK+KEQAd6IDRFmhJtku2KewHRgRFULJL2Lw9QhvFQIT+yJUy?=
 =?us-ascii?Q?P7MrYfcIjW41kQvkDqXin3cLYsmpK+jxNFw6kp9kB38ACfjcdlhJTsjvbjn3?=
 =?us-ascii?Q?2iwc3AwMnijd+hFo8g5nVqTUVMgC85ggZranvKmuDrs04g62UXRFtKiXOG2B?=
 =?us-ascii?Q?OoalvXW+wqkz+u1DUkxPSQ/+ATNJN1C8MXCIJKnN3gZuw18Ba994K078Vga2?=
 =?us-ascii?Q?BkdVCi9MqVsSdoFQOEirkF2D68b0X7dhsqv8nMLdUHsMu+lnr9PlQbSrLida?=
 =?us-ascii?Q?CUVsDEu54P8dHPSJzrAIJKwOE7nF2oQl0Fp4F3AJ2k27pVqUPc7sPeYhcjyG?=
 =?us-ascii?Q?UEQd9jT2IwKDfKNqvS3ooiuBZA+TvtMzUlkto/GiwE7UIYkmhfS/L4Au3fHV?=
 =?us-ascii?Q?ep2XLX0MIYqff0t45jiZMQt4ojJZS4ccppdAbu5snu6GnAwfE0lzkFIOFTth?=
 =?us-ascii?Q?DM+1ymxkyyujHLlevHlrhdN1e5/wWsFZ9aYMxwwLDnxliPsO4H7XLDug0VZ9?=
 =?us-ascii?Q?2jKDoGbPhkznhKaOJ7+3BPqV0jRcl6jEOrmtDXYqju6+kkAyVcFatnhVE3oF?=
 =?us-ascii?Q?XWjeLVDloKwQEzCBunBkW6lySTVZWIykNqTp9UfPGo9myL6RcGRJUY728YzI?=
 =?us-ascii?Q?PSQ/BMy7uLDXeT4e/W7wqo98ODnDyMkWZ6FHTdwbE5V9lZovn2gAk3Gr8ZBZ?=
 =?us-ascii?Q?DQ74EloKY/sNgQQih2tpzCiCz9FFoJs7tk4UddLh0dW5OGu3ckKhECqp7vLb?=
 =?us-ascii?Q?YhFP3Gl+kaBnMVxbeGBv/S59GNu3Libo3+ku5Xsyh1puP+Ra5keMPMLOLTVH?=
 =?us-ascii?Q?tIVdDnn3yCIGc34prLg5daBhX3IO/Pzti/y0u9jL7Z2ziN0nTcnWcLYyZfn6?=
 =?us-ascii?Q?V8bKwDy2Xv9N0/V+wURhe/nRlk35h1Dsnt3yBNkjg3VLWzogV4TU8EtXeF0O?=
 =?us-ascii?Q?QpAB+H1zSrrjcJtWVR4C2oM6rQHEJbB4AyBMBrGAAtb3VgkPdCcX9NmHVJ12?=
 =?us-ascii?Q?sbNVN/lqqUbXLygDxqAMCefz6tKXbmZcvLuE0u1z/4vPl/T48iQT4PdacNq7?=
 =?us-ascii?Q?ZVfGoCLMimOtZoChqxbUGUkLJhBLcMWne59c4RmNGde+d1BNEc5yy9QWOuQM?=
 =?us-ascii?Q?fw7/JEalAF7Ak9LlFFAA62sXtECT+fEWKFRXGpdrbxdqHTEiXKtBcxaUCumw?=
 =?us-ascii?Q?o52O71IvTrDZAsfXyhyK3I/lGzfI0Wim0SBHSr4mVeIfH9aY5MEm27/XAgBY?=
 =?us-ascii?Q?7r7WmEi+E0ahnkAhXIvNziqXJ0NgSrYqM2sOrJxOLwsrM8k02+slPGjuRbqq?=
 =?us-ascii?Q?c61hx2Gu8Ky6SQ0mg8XXmB+rvyBtKVjv5oxBaC8T1avufwqviJUXZJ65x8IL?=
 =?us-ascii?Q?BAD1FG9wEgJBTRhXx2R0N7qbDNnhAx2921kWitxzkqyQUAsh/0zaBp+/q041?=
 =?us-ascii?Q?W6uYuNFzP/7YKrNptrKAixMuo4qihQ4L5PYYpmpinhal616evOev4tlXXJtQ?=
 =?us-ascii?Q?FIBoQWWZkQJCWwJgYfypI7RqFy26dJYeqcTFQcZBLDw2ujCxyWvNCfu5pv3N?=
 =?us-ascii?Q?nuJyDWm7TSup15aqJXaCfXmPD1tC2dztLOZVRprGhSHIChbyRyWKs8lBC1/P?=
 =?us-ascii?Q?cbUuQJIoMol9vVDdqA+voIU4a7mD0hM2HJ1JHmm1gnTOW0BgEt5srKWRkL38?=
 =?us-ascii?Q?hmXayidalqBpPI1z/jMc3C2IAi3734q0iaDtkauH98ShlTG1xCHLf61ozaWV?=
 =?us-ascii?Q?Pqi9AD/JXOS88JK2XjuzVxmz8mtPHFE=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39fd7803-4eda-487e-3de6-08dee3d789bf
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB7705.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 07:46:40.2659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wans5npdcXW89xaC3iei6W2gAyXvxxl8+AcfhNzM0J9a9PYeuk/gK4Vt1YeLN5tO0wxlyU6GPQxKSUbkYcdJbPdVW+Kz5IbkxGNV5so3Lrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5182
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 07:46:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23626

Hi Pavel,

> I hit retry on 6.12, but I'm not sure it is going to help this time.

try again now. I have increased the disk space to 1 TB. If you need more, j=
ust ping me.

Kind regards,
Michael

--=20
Michael Adler

Siemens AG
Technology
Connectivity & Edge
Open Source Embedded Systems
FT RPD CED OES-DE
Friedrich-Ludwig-Bauer-Str. 3
85748 Garching, Germany

Siemens Aktiengesellschaft: Chairman of the Supervisory Board: Jim Hagemann
Snabe; Managing Board: Roland Busch, Chairman, President and Chief Executiv=
e
Officer; Cedrik Neike, Matthias Rebellius, Ralf P. Thomas, Judith Wiese;
Registered offices: Berlin and Munich, Germany; Commercial registries:
Berlin-Charlottenburg, HRB 12300, Munich, HRB 6684; WEEE-Reg.-No. DE 236913=
22

