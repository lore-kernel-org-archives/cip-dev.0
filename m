Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69262C02196
	for <webhook@archiver.kernel.org>; Thu,  6 Feb 2025 13:26:25 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.83])
 by mx.groups.io with SMTP id smtpd.web10.40696.1738848382465137519
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Feb 2025 05:26:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=CtOeoC8y;
 spf=pass (domain: siemens.com, ip: 40.107.249.83, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fLlW5Gk47BIfzSInOQ1mK7OgnsmRJr/95lYjzC0tCUaX/HE+KU8uLH8bRf8f32FsdRJpAEmbCP29ZhOb7hk1wGWOzdROo36kBPfRAQjzfliVe89Xp5A1fpfQeDmZQeRgwTsQZhI2SHB7c/EXi+yjE3VwlIXYaknJ66G3YDTqeecaP1UshfTWptiYAJUZTFXZkY6kRxMOYto6a5AsMPKvs8S41b9JvspbqvJxfAwREXK5WJ6IA20RCF+gYa48vReoGCih67LxcYleqdX9ei+AdoCYwzicFAK4gDJEn3vUpBK6iU+6L6CJhf07L2OHmnJEYr1vnVFIaU+nVqxdbtLs3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lICbYfIxV82ZJZSgOIflkrH5pQaZzGWObkGx0cMznoY=;
 b=DbRcwA+DHP8tcFTh2IMv4ptemUoQdrBZKq9QKtBKgCxJz/ayJXdbZRxFjPNJQAV6GnW75eDZ3zUAq5I6qq/Ps9pwffLmfJ4Iyu5yklX2m2sYm//vJw6l7soxmnMf52KxHciskM6VcOxRWH2Y0oTyOPTW9bgYGb6boILeIEm+2GI/HYvUfxK7a0I2RfhqYTkz8RaDbyrKTE9vJiuhFaUWlR+DZoZKAGoXhOM0O16R/c5/O26COf/uzZIgmauLrBRRw0pFieYoMdYRrrKobP9yNr4dcLwhbALfH/SCSy16tQtLOJ4QNzw3zAJ6Awp63tO1rOmpIPcIePSXusuZIOKlyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lICbYfIxV82ZJZSgOIflkrH5pQaZzGWObkGx0cMznoY=;
 b=CtOeoC8yC5771zQ7BcgJkGKIbLzF1GQVB8p8yB9SJOxzs8tBvCEjdHMm3dF7U1aE2ynrZg29qcHDVeggg+1JTn7HbJGkj8H8oWj7lli5Bp3uWjoDNnznPIhiOvod+ZkBSFevZtWsbJdLc7DgtnCzeLGgP1s0tU6b1NmyIOliAoBqo75x73qMdPmSLBsW8bGBxWZd5z92MnYV7BX0x2lLxDTyzadQVJM64u+fD5egENUVoXMAULom/4hA6GjMdZIBt1Q0EQaYIWKI72x7VpiUlXzGGga0w/AbAuRcLclas1kRkE9C+95HwP2Pd71BtRNBnxh6LiZyARUnsRGOFeAjqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by AM7PR10MB3811.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:175::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Thu, 6 Feb
 2025 13:26:18 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8422.011; Thu, 6 Feb 2025
 13:26:18 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH v2 1/2] ci: update kas-isar from 4.5 o 4.7
Date: Thu,  6 Feb 2025 14:25:45 +0100
Message-ID: <20250206132546.177943-1-michael.adler@siemens.com>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::8) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|AM7PR10MB3811:EE_
X-MS-Office365-Filtering-Correlation-Id: b4415e77-ecec-48a7-b742-08dd46b1d6c5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?TyAIYPyVrsF7Wcc6iB+ou056hvl7Vf5pbJTk1KtnMtOjZCZS5iUcPc0+yOKJ?=
 =?us-ascii?Q?TzdG3yQ7ItbEJl3rrx/LXXa+SZdg6YdZ+rGvKF6vYH8VcFFkhFffGQfU82Wc?=
 =?us-ascii?Q?pK2mHir4EC1KeiHt5bKGDrEZyeIIn2+J/dLSbhE19sb3W6sDsZP2pDbmqKpK?=
 =?us-ascii?Q?Sm1K+ObpfIkueQt0wfK7c0PLItnb4sU8y2AajO34JVXE3WjXMXwu95IrgHgS?=
 =?us-ascii?Q?hPCpZoiWa1HRnoCUGVLISa3KlEjr4tlp70rhha8kvSl4O5n3VP4Cr0zCsn3w?=
 =?us-ascii?Q?+NUJ8ByFNhg5DjFjszqX+KboaI66qvH2jJ8EFNhbjJuLwckDafbwp1f74+J0?=
 =?us-ascii?Q?iIjA0bcgYp470JANi0OB4+/0dvuQ6pWnmplHONQHjsxFfDShwiKlJbZB9Ygd?=
 =?us-ascii?Q?fRtmM2In5639tdrOLLqjdQ6rHdrsQOhHZ+1ivgEaXhxNbU1aKtcePg5+xNF9?=
 =?us-ascii?Q?0WQpXPtbLKPBkiWsZDNITm968tHTWts6KodnFaQVu4j2RF7WSi/sMPMU9P56?=
 =?us-ascii?Q?BjgLgiwX5R01x668ooGbBOBrehT4bjheFCqKyigmPXdedbxbzoCCA4uaBVbO?=
 =?us-ascii?Q?bnVZbV4+sb8g9OptBTkJczE2bmtdV02aR7ZhLyuRlAVCDguLpTzxY3ZlGhc3?=
 =?us-ascii?Q?p6nxP83sXdB4qFSG0F0frRjwk09WU0r08OxfCHpxY5LyQa298sqMyURGT0O6?=
 =?us-ascii?Q?rEHuSRTbji6CQzy2uqIzXZEB+hBFj7vaOkDYKjilmie9ynNbtb8JMfP9nazY?=
 =?us-ascii?Q?FHR76opVXv9WqYzQOBBaSTFsbkZC+3DqKqWPuJEdlTUQjV5t3z+M84X3XFXO?=
 =?us-ascii?Q?gpn+sid4uI7FbLJcHIswsJszaOZgxYsXPQgjKWEvUNlEsP3sKVM2utWUZSdJ?=
 =?us-ascii?Q?V9QZx8MZToHwNzXvW30sQoJlDY1jn4U3h5MBIKzrNpwcr3fRtEJOvE+ftZWQ?=
 =?us-ascii?Q?3z27KYSuUssf4Pv+e47rxmRiyWaiOk3d+H1QAKErLBvDIuH4RcVzXMe/27Nu?=
 =?us-ascii?Q?9g1dhtebEIDafVhg1XTu5tO67MUFlCegLU0OCzPAK+Q525nKzdJ6rStvOhSp?=
 =?us-ascii?Q?chmmRIxSvzcyHxrpeEerupS1/KKdlJMe5M8nrGeY+xGpXYt9Stf6gl0y+dB5?=
 =?us-ascii?Q?SydyDb1/L5X6cevEn3PFI+4alSteW+Ipi2lL/JdoHqVbk+98FVes7PVr0mKt?=
 =?us-ascii?Q?HUGwju3gOqcuW6O4RVYJdohSUkawM3BqoHQHBMYUn55LAv+oL0wPqU8kkdXq?=
 =?us-ascii?Q?NEYP5hOCrsw5M1ucU421TC7xdAPnodx5+eClcTWEyIgmd8PvAHOB3y0arUn3?=
 =?us-ascii?Q?s+BfkpMYjwRgu7fEO4cUIxVSjVm6UfYpaMvosWrSfJpSUA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?d6Fox10W8/MpKqzwUebV7MHjGKzQ5GBgOSjwtAcPA7h1RoK5t1nXH1+L8Pin?=
 =?us-ascii?Q?60bA56sKLIULtY3iIef+CD9dT4K4hEOtKzyW1h132mHTZ9pSPf2G0ia9Nhn1?=
 =?us-ascii?Q?39s/kk0wFFjZjsQASXvH4qb9FdMlECGoMmcmoYMxeYvLnUgHilcxusJK5KKW?=
 =?us-ascii?Q?U2Uv76FDi/4f+9v4C1C+J4mkx4/d5pm8s33mYu1jdPVy0NIyvD7KKpMMbh1x?=
 =?us-ascii?Q?Sh0VwPwfQVvmALoPzGWW39S73KmhsB/JJJY9P7Qw94HwMU8YUdmmJBtAzebj?=
 =?us-ascii?Q?IcbgwNUQLlDgS4OEBZ1VarPRyPg2HOZyNoaFRj9o37RgSdXcFKcCWCsTlGf3?=
 =?us-ascii?Q?a3LPfHAwM00SBTt/Q2FQp1BkgNmC1QDLHAJ7LHpMUoEteHOCDLYhJVCCekNV?=
 =?us-ascii?Q?OTaqmH5ebyXg3yfz2vhUVzWJmO/gl0FrI1rdvLhc0Uu75pTJnoSiqMOPr9Tx?=
 =?us-ascii?Q?DJ5b6/Tc+b+Jvt9R5hOwHlipA+nQjSrFD4ttfbY1pjq1I/Y8Zl6Ikv9KVDyK?=
 =?us-ascii?Q?37Q4VLppAAH1zV/oUn4dFDBrF1Ij55TEn6RgxOIHN3gh1JOgGhxSx3McpVua?=
 =?us-ascii?Q?yWGQxYfkfxhyyaVnxCh6EHnyxQTslBLHsg9UaLrH7PzCgTrw2QH1QWZMZl+1?=
 =?us-ascii?Q?2u8Iu84OIN6JYVC4HmvSuHfmSxvMUWO1/97UU0hBODiycQbie/v06RIMN0GT?=
 =?us-ascii?Q?w7s0+dRUYDD4lproDNdKMiZXoZV6GHt1ahxEoGpwf7zXwzoGE1dtStcZrAKg?=
 =?us-ascii?Q?8bHOYUdhl0k9pQwGZjcVjm5C863oF4h44A0a4UvfmRRlLZwnIGA7JWGcXpdi?=
 =?us-ascii?Q?DpJayaDon5lOJC2Jk/eJ6Nn3s9S5r7z9NkWgIPkzqq7v9H6lwYvGj9DyjxAS?=
 =?us-ascii?Q?8mbbpELLfqUJrROr0+KLS7o1NsY2wesncYY/KeCC33ghj3sacwCKK5dyiwdP?=
 =?us-ascii?Q?hyrYuJX6jb9yt1IPyrIC32w/I6oDwxc3hf9GZLJO+6CkiOspvJnzjvB2pKLd?=
 =?us-ascii?Q?92tuRT2xHC3x9zqjNvy1EdjbT3Gpb9urIGJao4IHMWpUbU8yJCHTmxylf++C?=
 =?us-ascii?Q?RGgEGI7yC7IpyT/YxrVU6s8a19Wrkpt39d/JCBpJpkGJTnSkIcr1MAE+WlGz?=
 =?us-ascii?Q?GRZrdJSPnpjg9Jpsux8Azxxc3uwJOi1n4ZMTVa2NCuIP3VbqQC2ieV/vm/z1?=
 =?us-ascii?Q?yOJX92sg3fM7I6geEAG+66RX7w6yXZ/dOWPZWcHKNPCEaWTmOBAg7vZoqPUb?=
 =?us-ascii?Q?2UDT+ih3Pman4Hax3G51kPzEkOR1vNQilq1ruIUxO8rBsat0JAVF1plzWZmo?=
 =?us-ascii?Q?AX28DzoXY0HLwwwmSEw2/VoZVJ/IfUb+sebOYuKAWJpAqVrb6rCI9zsiPSuF?=
 =?us-ascii?Q?FETct1yfJbmyBb6P36pezFr7NbiSotmZiv/IYpNTZidrKjt+Ng9TDoCjlhNW?=
 =?us-ascii?Q?u5VXjOq3cHnyFGJclAiSz5w4GIkig0qjGub9/ZAxremrxuyTXg0G9lACTFvX?=
 =?us-ascii?Q?ZAy9s93xzJi0aRG6pVUutgf0I98OT4rK5nVSruifrUWS4GE3xiWeDUZyn1jc?=
 =?us-ascii?Q?37aAlk8uMGL2NLUb3tF4rstJfGMRe/dgj9AoDt11q1cSthCj0WTttrAv2x+s?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4415e77-ecec-48a7-b742-08dd46b1d6c5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 13:26:18.6751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U+FMUqKii3eHY04WYboZW8sfCDzu5oXLMpryx0HeNNvppcSVsiMXeR56TpZlXVZZbNa4c5zonOcvxDDGHaJJ83fiXXGc9GpN8Dw1N2W/WI0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3811
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Feb 2025 13:26:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17763

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 .gitlab-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index d4bd283..62f6edd 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -12,7 +12,7 @@
 # SPDX-License-Identifier: MIT
 #
=20
-image: ghcr.io/siemens/kas/kas-isar:4.5
+image: ghcr.io/siemens/kas/kas-isar:4.7
=20
 variables:
   GIT_STRATEGY: clone
--=20
2.48.1


