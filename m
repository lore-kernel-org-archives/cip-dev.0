Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179CAC54F56
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:01 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.30])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11068.1785244374150385555
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=UrKEq5bz;
 spf=pass (domain: siemens.com, ip: 52.101.65.30, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9R+PuSaLQlVz4OixP9rsYgjj0077NClthHIkQ+fxNVzIBf1fv73+LJvFc1UyAaqzHeVEZpSw3YpDHPJvAZ4d3eDQ1uwWQwd/USFo8sw/SyoqUjhRMG9KnpDdeY0i93/cPYvSCwL4febEQ01o/J046Hvu3B90FCxpga8+n3GkpjUrCy2s0Vi0z9o4lEp6r2iJmityfq8qx1otXWaxm4VPSehxYwspHz+cjWdZhVGY6zq3MwQ65tkNRYVsVNx6WQCFRpkKXzIl6EsXFgeLBueL/aAs2GmthVulYGcyMo92qIHoTDIr8spty8iB3JKkQLztO/FesMmXi1AWOADb46hmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7r9pHc+B74uBp+rslw0lNR06ZYBQPn6A4Wt58XodDE=;
 b=fZFD5ioVnSRs646Ym8rHPReCvwiM+L84QVqCSHOPOu3smpgsEojuCS+uowXfwWW7Lqjg/GEfMrcHl7XZOFx8dxwNfwcx09j5fCg9MMh3Kc75cxfMVgUoewtxYDTf3CHN9UtdX4cP1wW1ELxy+jIdtIugpd6F+f5mu128SpF+Fsy5gP0wVVe5IH+l3/NlHCa/0JhFKJHsDILEmLcjkdaaWll0QYqZ7ID/ntxCWZ/g+KwB1pMR2B2pBlYrEqWeHeN+OHiVXQsyDu5ldy91N1t/Y39lvyJ3BWkHMBCmtKJ0/TlNjaEsvh4KR08Dh7UpVa811xFz39IbgsFTP+Xn6LfCVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7r9pHc+B74uBp+rslw0lNR06ZYBQPn6A4Wt58XodDE=;
 b=UrKEq5bzmPZV1sZvfqPhEyTDwlvSSJhMKsMCDKiyPNSBk/pzkguvGUq0aQod6TP/M5Fl/e3KcgKuINM9blIdsNR77Mh6UfgLgONbPMBqPP0z8WurROHyBMQ73kIJyO+FNkGq02fM0czvhg5izgUN1jMPa7ZSRbjMhQV/QcM9S3ntgkJFW0In8VM+lxqi1ScVhNpsUzgFx/F0xDy58Q5l76kuMwRy8L4ajYasjPv6/yuboTkKf/ZFzqdp9FRuTA9Pu8JZYkwjn+dENNY7hKEqqcN0rZyh35zcvzwRZeWlXKpyuAfHLdjSfHWmF0M/oCyfUEQPOEm39MRXrgiuXKRA0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by AS4PR10MB5647.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:50 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 5/5] update README.md for rootless build
Date: Tue, 28 Jul 2026 15:12:19 +0200
Message-ID: <20260728131231.117214-6-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|AS4PR10MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d468b63-e6c6-46fb-fbe8-08deeca9ed19
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|6133799003|11063799006|56012099006|55112099003|22082099003|18002099003|20052099010;
X-Microsoft-Antispam-Message-Info: 
	HjxCAfDtix+Rp0hjdQ3m+8fkz0Oklcr2zAj49xkulSGaC/8T8BQJ/peAWzmk/GAfS86JzonsS8nabM7LxwMsBEbnEOGsDq497XO7q/mVZgDS+A3FCWjNr5Hst0MYIKdgMieCGH4d7Ws16zt6or0pENGDGsxbjcmjhGpKjLfYkoz9prbw5kY/Jiy6oeY3bwKUggv6h5JYwGW8oS4hS2fJhExD7LzDzLAnwuaGhEhbPOusWll9xmD5Ijy1n5E1YPBpcE8r7hShqrFALsejdLwGKz/4Apl9+5HFPYNsWwdS2f69DVbaqi60o7UMboy1MDNZvi+pkMohnUWUgAZLHVirQ9P1s/16mMG9LErkDYH4bVqWyON6gTL53HcwsOmGQ5wWS2XiYdQnhDayoiXiKHuk+oqbgEYNemKCZXUdOLzyMFck1myyvxxJO52nUWYqM+B0Jlu5fTWvYw0Dq49j+fv1TaIcgSb7rRSauv0kV/idwPhZIMuHH28+nTQjbbuAq2uBrmqrrrtdKnq8N9RvMYob1W2ElY3nUMJ/Sg1eA3PboTSdOirgAlClbtDFaUCOMKzOHTpTjVOEqq2iY1nxTaqN+My9hAebchtRWFPEekjWlipoaaSJhZ2yPaT47+zW+qcX88EpV8/LCuA/IXzPeKjkCyjoDTy4qvDtviQGSjAlDdE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(6133799003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?MmM7w1txDijHtMf9qmB/INoRet03mVtTHLRnE5lgRtyckQcWKDiCrTup6w1Z?=
 =?us-ascii?Q?S1hVyhtm/LPFgDaJzOR03/fT0kb8x4gtcoYrKLzpiZXI3rAX8RqKZlRbSTeI?=
 =?us-ascii?Q?9UEeW9sT3NPd2fIHr7lkMXwbS+pVwMzyOq+yhj9yRcEFtpvd6IXdYxQeioab?=
 =?us-ascii?Q?V1h++qJgCs1T8JNFI6o8aeuUumswfk37wSlWKx/oyqYGKcsTpFGqbZeowsQZ?=
 =?us-ascii?Q?9NDdssLsIA4Ne35hjKH5MUdbg1DsawlcrUfi1B8jBcSBvd46/nGRbAyPKnQW?=
 =?us-ascii?Q?b5XbKSUzJz+5J/eDVyb07nHBa4jqsFCqxtlpxXJVTRSN29M2zXBadZlC/Onz?=
 =?us-ascii?Q?Eg/WA+UOVtIPphCCkzUjB0+xkiR2rWvx4OZt3r82Kn5bdPBeVE3E2FdF9lYs?=
 =?us-ascii?Q?8dohYrmxU7CqgzPDFfAd4bHle6HpEHtUYaYbxM/WPJONVzRVwIHmwXC50Jzo?=
 =?us-ascii?Q?jUy4IvkFOuQZWkl+0RTkuMzzCGiQP7etCfNKIxdfEY3fM73Tqq5SeIooO017?=
 =?us-ascii?Q?tSTQ6tcAhB0CtM+WuzFQYyPpe3cH0949JVOjt435/0d73iztT5MuwqcX6EvN?=
 =?us-ascii?Q?ml3Gyg6ouKTCRux6Y6W8Exc4S5lY1y6E07vyq/rluECgpHptcl4UP5jzvvIU?=
 =?us-ascii?Q?5dFRNfKkRkuPObFQJJX0dIImhQ0N3jkRnRSklAH5WNndao+9jjLutG9u1GTW?=
 =?us-ascii?Q?ggAK+oM4fZYbENcROk1MqhDwTtjH2/qOPfeeKDWZk09mJkDv/sGKnWhDLQ+8?=
 =?us-ascii?Q?boCJNFw/WrAAH9fwF+DYs+YV7+brsAEPjom6uneQe0W0BWmkm2vjSKPZwXpX?=
 =?us-ascii?Q?/zKxTLZeu0fq9qYWRTy9f7XceQ1hxiC+n4GEpWGWuorfVYq6dCGA1dWEK+ap?=
 =?us-ascii?Q?jM7UNefXDHbKjPf235kiEHHnYuaYxqXh3kW4FplaG2eCDS1uWCyMJuWrX0s1?=
 =?us-ascii?Q?caHciwz7l8s92aCXMG5DhTVDOdba8xEhN3+SVSafBICpF8ZnQ0sl4gKuS7tN?=
 =?us-ascii?Q?nhjToKrMM8x34CdamZ2SNRs6bID2tBsF3ZSokdvO699zJfheq8o9aovqt4tE?=
 =?us-ascii?Q?WiRH5us03Fqp3e5yFTGDNtFgQUgcr9+EXgr5iLZ/AUQRDEeFl+tu5itNDba9?=
 =?us-ascii?Q?/SEJ/c0lRbuE+rg6C4XovSUnZRh/e2IPyC/k+UnhBQ91iip88tQ9KU+n56k+?=
 =?us-ascii?Q?tvxltmxM9zb/6+PBX1lTipzaYK4jdWW77rXCqVgwzmQGQYwxFA+Fp7XtwNMj?=
 =?us-ascii?Q?nkpIC5+AAUeKkpY6PkslPhKYFp1yCs5mrbEocpKAlshfiKyWMj52KUFuebFp?=
 =?us-ascii?Q?tjYBf0KqT1d08p32kkgNmsz2qDKz0uPkmR8JzK0ns6FSSxd3HTVmEXjhzaWs?=
 =?us-ascii?Q?vYqkIVnsW6lBlULM2zZkMa7j2sIMpiMx7qIBpUUmIsrH1r6yqrErIuk+xTY/?=
 =?us-ascii?Q?ITrBfEfJ2dTCN7JCgLh5i76LPfNo6tBumQCRAPrjKVV+4GJ4GrxjVw+sV1n4?=
 =?us-ascii?Q?sz+pDtR7DHYrosYRP4SyHcWOJGQNJY400c+hmYgibmbbTiWS4FikIl2woyIC?=
 =?us-ascii?Q?cgw2z226Hx50gpDPHs/zUpFguCWMQo1v8zlq/8Tyh08//x7YtgAeTx2d4rTa?=
 =?us-ascii?Q?BkF4jt3zOmXqbQ0N2bBjNjPMWGMYgslEBkrj0QBa6LpO/1Ei1KiGtupvU0Hj?=
 =?us-ascii?Q?Rw0nLZq8yBTWJd+/N2KLsMEDsISgr1jPEK2/6dhG/u34DhW4s+wuOW5YS0E7?=
 =?us-ascii?Q?nNbcEDMa7RS0jOrOweUDpmZ82+Uwv+Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d468b63-e6c6-46fb-fbe8-08deeca9ed19
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:50.6957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RL7AvASNWoESyc7lDxDaYkddWBBxGWAEPYkraF89tm3ja/4PqQfHjRPY89dyOILXZFvbmQW1POHycne2/KBa6xSN1fnM4NkJy7hQBbuHHtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5647
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23801

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 README.md | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/README.md b/README.md
index 435d037..df1564f 100644
--- a/README.md
+++ b/README.md
@@ -10,10 +10,10 @@ from scratch.
=20
 ## Building Target Images
=20
-Install docker or podman and make sure you have required permissions to st=
art
-privileged containers. For docker, you need to be part of respective docke=
r
-group (`sudo usermod -aG docker <USER>`). Privileged podman requires sudo
-rights for the caller (`<USER> ALL=3D(root) SETENV: /usr/bin/podman` in su=
doers).
+Install docker or podman. For docker, you need to be part of respective do=
cker
+group (`sudo usermod -aG docker <USER>`). The build requires Debian Bullse=
ye
+(kernel version >=3D 5.10.1) or newer to support user namespaces for rootl=
ess builds.
+
=20
 Open up the image configuration menu and select the desired target and its
 options:
--=20
2.53.0


