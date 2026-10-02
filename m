Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1BCCA5FE4
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.34])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9457.1790939991891002964
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=KPWWm2Mm;
 spf=pass (domain: siemens.com, ip: 52.101.84.34, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeTh4EQHKkkEtaD2a4LvU8lhqQUBqEek1DpZUa32bypFzuKDrgy/IgbIPMWiR15Onh+vdG39EKuTG6BrNJ1q/R93dnNekl8TKatUvEH8dP3IlOySsLSco4FsVPmkAF4UYUVRjKzPbv9Pjhw3YKVUlZSD/iKGbI8DBgOg09UIohuaBJawvCrAkpSmitPBxIhjySOdf77kCg3fQSx6jyQh09osqwJuyQDlO/fG1bBnWDhBdhlNPCzZK63nWvY4SaEeiE1OQPrb4bYGD8tOmI2l0wiCUAl7xbLRrDG0YFyKd/IokIFuTKdD60rtTh1ddejKxmgGodCJU2i8kqZNzKN3rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0E7TiRSEb2NzYx2+gW+yKEBR+aaqxn7auJqVIWxdj0=;
 b=QjQ4CXh2mRdfuvCU8B2sHXNkwo8EHGrfTAOGgXZzdRfbg4yudHQCdXvopu/cVAwx4ZoOi3j4gSdzwO2Mt4cgCdOOit84ow+PKAuCGon0BQ0YVXeOg912Nfvvfr78QexvsX5QfsKDLHDUkopCN6b2dI2AMnn8zleTKqsXOK9aJrH/1zS4rCqla7SunZy0Hvh7IJJAkaL/YgR9sYECW6qCeu4A9qXsZFMqD9i15iIupVf3aAugurfbsz1kgFz7MHCfue4LJ2Jf+Z3oQ5R23huAjUD0soSEJfT8r+yz50yDdBVySz7qdjcTCEPGObN/SL3fSaMsIwfM2ElACRv5aaefcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0E7TiRSEb2NzYx2+gW+yKEBR+aaqxn7auJqVIWxdj0=;
 b=KPWWm2MmFIXGUXqCgxhK6/3ZWKlzRUx6xoxM1YixkRg7GVeFzEyIwXRVxEn6wG6FpQXvWV4QI4yal8f6fEUvGJ7/Z1UtmPZ1XVjDWb9VBVlPb7PF9qkhQl6HbUffz6tsRfkZqbHydm9paHcO7A7WwTlH3GL2z1O+M+5ZoDFJE1iNDesdiiVesLzsqinhCkUgjqBp52tmMDC83sW7QT5DWkkf188RGO66Q0MOXptsp6WQmp+UMix+XaAqs+QkrWL5YASyl0di1M4tZ9SOyYFuUt/FXQ31IZgNzfD5GNT5YMKQGRP9pLF+xeic84IgvWwR5MxoZMkOpo4gi/BY0bESrw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 10/11] Kconfig: add option to generate initramfs with dracut
Date: Fri,  2 Oct 2026 13:18:57 +0200
Message-ID: <20261002111938.3600786-11-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 38577a1f-cf9e-4e62-a720-08df2077144e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	2jLBuIi014M2yTsMZ4LrJMKbXymRahm9r1IkgQhjh/OpWu44/R7EV6zHhuVJvqwQHruFFZn3yFgRCLyHsCNG3UrP3ijmTBQuS2fC7Lwa4+8q6/cdMrNBrvReXQCKEOH9VYHkY2Tw8VmmEgUoF6tM21wUXsTyR3qHidyi/e1zhWa962y1CgUP3VIl/TgZ0qMH7/ZR4tJthIMgbrFm1/ZN0XOJLrcYh8AUu5u0T9lVL9Q0AFAQhGs4sKaiYAEBQgBNFVlV0e9moJcOWAUcFws6u8aMzyNbmd2fayl1aoyPejBVEEm+jG0A7TAo1tvplioaAKTuOovX2MeD9zCC602aj9yz469+kloY3RlEfYq544hgpFJYVuiNV/a2OFUCoZlZzJZmfZeAINScnR8BpYtmivZ5w0hP6LeIXjDItRSpX73ZwaMJtkLY+oOEXjJPE/vgRDWzKHru++wmYtUOyIYXK5Z5DeZUpS1pTLUqT4HY4QA6Jp2sZ/5u2WSFu0sXawCNij/pXgQaC7abeGQ6Is3Wn56uzUfAOJuAYP2gqTqC8Mc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?pzqkqrL1tLD818bRdIqxekZQ3tJKcbLBNVdV0884jkj3KKTPckUF+stlsi32?=
 =?us-ascii?Q?6QpF+pIumS/c8YNn9KLpyYMG4xffyfXXN4xFdrhbtyPjgcYR7LfqRZiHW8XX?=
 =?us-ascii?Q?jFL70vDbKchHVheDho/gwuHk1sfFR/uNKDjzMLPI0zNSA1NVbYtnupxVa+fq?=
 =?us-ascii?Q?4kakq0mu5bKpzH35pLEkSlQ8NxBnGBONn9Vw1FLb5U5zSgupKPlxc+92RQ/T?=
 =?us-ascii?Q?NJiZz6jSzmRE89Cys5o5LzDH/+Tg5PMiWLZ4AMOykw+nDKVtrDwa5VF8nz7F?=
 =?us-ascii?Q?FLhWaTT4GytROgNvgEPg3RjMuYTZHv24MJisrPGaEJPRa+p0Vl+k1VZQaipI?=
 =?us-ascii?Q?zEHmCUyo+J8m36hykMuK0fywmFz4bAuCRBvjSgqa1NMrbJRxLEug2C+45GFN?=
 =?us-ascii?Q?RrLEwfIIZW2XZQs3+H9Bki5QkPonokABRk80DU3LJ6DPjO6GBaZg+eQEMork?=
 =?us-ascii?Q?44pFfTXYV4N1+dx7BV4GfUVUfObxAL+VkX/Gu5+uy2U5PnXdc1CXUdpQXQVt?=
 =?us-ascii?Q?XZMzud418yfZMTK7OWRofbCd7hHdqFSF4VzHxTkewp7RRV1HVEtMZ8Y4OWUD?=
 =?us-ascii?Q?QDfYlIF2h/aS+Gqd4ofSKex3q1JLNrmvgES7sG6OhyrFpMYsZq7c0UgxQQEw?=
 =?us-ascii?Q?DRXhUUB5tSYERMDycm9LEdDDETx12WAjW+MjN+GLPTJX8e85ceHtt/lTqM/e?=
 =?us-ascii?Q?/TLks8h1wyPTed0eluDCfkszOmNzyWuuSji5OouV6Nmg4g4b1SVaz2K75V/T?=
 =?us-ascii?Q?uJ3ZaYdulXrLogaJ7nLO8pzZb5iVsPvodpw8YBCe/jUaPDnj2P6r6Kky0/f8?=
 =?us-ascii?Q?WJgMqMvK/TYT5zXQRUzwlojihLIilRX2GPfwIGvYhZF4HyAJ31ZI+fp5qZ6n?=
 =?us-ascii?Q?b9DV99nLFc8OBTgDHeYfGVKQUH8lWEuoBxLmPriTznjepJYiQ3zYatCsmjnM?=
 =?us-ascii?Q?t2Vq9DzQyKw/rcpmm3HlUrktfp2ArSXUMzoILuoJRJ+ETsP1AAmUpgzFn1Km?=
 =?us-ascii?Q?LldwhvGX3KIa/wBzJK27DV0YHCtqDuKYSAJVQaRWzZGJOjQJWpGZ3DZlb8Ie?=
 =?us-ascii?Q?2GCTKn4qRk+AK+7Scn7OiIY3QeKWcfwNyRCWrgzacx4menJsR8NQJ01MnmbV?=
 =?us-ascii?Q?XiHmyM/tIdcgOKpaEgMl1EPf52gHCrRrhpLExIw9hkV+rs3dvSbHiBiPlvzk?=
 =?us-ascii?Q?zhtvo8EV7VScuXfedR3tUqXGGJEL0Wqc7pgcyz8Eb91GTOYqdzMnTVAsEFge?=
 =?us-ascii?Q?lE6pxVZFmO57HBqj8qsyW/d0gVAxeHc/FuVtrA1y2QTC1l+uUk0PlLVM+yZ1?=
 =?us-ascii?Q?NJveQKqGpAV7ahM72dJKKtO2sUHdDqahMYQ6gP0YpZVrQ6UN2shWsO7hLV05?=
 =?us-ascii?Q?yqYz+jBgDqSHSZxhZpzrsAr5g7UdjwoZ1nemNlPVFDn5VArWR7JYonMAoAcU?=
 =?us-ascii?Q?+O7rWUhU2cUJggezggfh6f0HXFIsgf3QKu5HTEUlnyUe0PmoDap842E1FL4K?=
 =?us-ascii?Q?3rcRpvw/dteOwGjOuRIz0uuc+oEeqXTKnwodFWP7a2YBwAoCYp5KenxEgGfA?=
 =?us-ascii?Q?I4WSz4/4eCyP+eN9F3MaV7XxgVhVqgLvQd7L1DLuYig2L+jOdO1pFo91Jezh?=
 =?us-ascii?Q?vXlA56zLA3SdyfazMB/9lFFZxBwJAcMR5d/xUZgN89jpk+orpXq+ahWYMwI7?=
 =?us-ascii?Q?S9lPL4dWuLok3cKyGgstGkjie+osFjmCDPiTTMoEyCUI1p2JBDL0edW1xLml?=
 =?us-ascii?Q?0VRBtpEI6Qq4xt3f4tlvsnyTsDwDxGU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38577a1f-cf9e-4e62-a720-08df2077144e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:52.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QLqmETnI+DdMO1ZV5xqZcBrPklFcZSfMdQy/NZWZpGU638041DlOIjNZPUeqii2XBgfvYc2oXsOuR8JfTzRk7hDQ1BnInonpALDm/fXe6pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24413

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Kconfig b/Kconfig
index c5dc3019..e041e7a7 100644
--- a/Kconfig
+++ b/Kconfig
@@ -279,6 +279,17 @@ config KAS_INCLUDE_TESTING
 	string
 	default "kas/opt/test.yml" if IMAGE_TESTING
=20
+config IMAGE_DRACUT
+	bool "Use dracut to generate the initramfs"
+	depends on !DEBIAN_BUSTER && !DEBIAN_BULLSEYE && !DEBIAN_BOOKWORM
+	help
+	  Generate the initramfs with dracut instead of initramfs-tools.
+	  See also ./doc/README.dracut.md.
+
+config KAS_INCLUDE_DRACUT
+	string
+	default "kas/opt/dracut.yml" if IMAGE_DRACUT
+
 if !KERNEL_4_4 && !KERNEL_4_19 && !NO_KERNEL
=20
 config IMAGE_SECURITY
--=20
2.55.0


