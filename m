Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD4C98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:13:02 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2967.1790237573835819464
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:54 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LULTQSFn;
 spf=pass (domain: siemens.com, ip: 40.107.159.9, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHKiQq4ieQ7SaAYbkI+/3tmN1fvRa/ObLcUfSABlg3hugy+YVh4DU6zGjZwOc+IjbJUBJAjjkiNpanJcpUOjiz5Ea4szvlN6AxH1+KjINSoQonvETcgh8xuLKvB7ww0a0c5T03Imy6UXhg2GBzVP4W3gpYpm/aCzdrNYcCaRQxQ3n3w3EuDG2uAaFgroyfLWtFi2tPQtAXSD03S5suzz0itEnAy3gYwGGRYQlGiHFACZ13K0owrdFoalIsoAM4HyFcH2bF4MXc6Sy8j8FqG+mpXtkrndjEB26rbRbW79ik0Spbh9ouNzJj/3NfK25SpqGDyRXwdPyK+bWQSNI+Pz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=rZDBnU/Ktl8gJg5J8oPnIS0dtZNmQdTkh7oSyZ6fbj57HCYWmDsRkJkdAtDXz5tN5o+O6tTJLKzKnbuY9ue4Rt5bG8bGCGSWpCvSro+MVBratNtdoFnM4xm0RvlAQYGPMEGmWzhFRS3YXdG/lYYevrZm/Bk1h535U/qmohyG6U8nHTuVwf8CaFEuRUupC8xiir/bGHBOj6tXFOWqtP8NStxbvBKuYxI4V3dR3b8noB8s87D6mjMIyHfgu7SiADkc8TJUsi0Jr98qWKvrV2eEs/QiFnWeTZ+5c6YG066ws8UIcYEr0tMHToZbB1leNwaL7N/jWNF6Bk4SkSLaFHwpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kKu98pTlf39gOnYRs3MlM4g15HOFDAI3i3I6GIB8+gs=;
 b=LULTQSFngbbAqH6ZDaP1/fyxxdkBnhsxgZTS8Aw5Jjx/p+Wep6tpQWP1pgca++uddGTZUU85zRyQWjU120567yisOzDaXXRv2m/b0Z/COt6Jk4rsM1rFuAlmCXCuyStj9ucNilSgz1TJmcA93+f7ykCnrU9UlwqtpYoV3vICgMt5zPoX/u6iWhiWkYaLxcpy7QU/tGgflk8KtzX5SVDqXXgBrlDiaTNyofhfKrOfkf8PvkCkSp1MyxJM9ukLKqp1fT5deaxdnD4c7J+ZPFyBlRQ9QtAleVLbqSsL73z3Atk259RiqiSspRcM1IPWY7Lfese8obMBSDkFXfdjyxb3cg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:12:46 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:46 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 14/14] Kconfig: add option to enable CIS hardening
Date: Thu, 24 Sep 2026 10:12:23 +0200
Message-ID: <20260924081226.2844456-15-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 89225a76-8432-40c3-7077-08df1a139cc8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|6133799003|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	fQRKs1zRj7T0eJWL1lS/Q7GbrNBagPAYtXT/WwurCIsFxovyymgl0aZDsQAapdpwwORHhf0b6uOhsnnNvNWck2FeKeoPvvefSgv4H5DfdxZmT+QlMnlq4rXLmONxqowXGNnpKsbEWsDM6Nvr40oxGyN8SY04XCTJ7mURp1jiV9D7F+/14kQWSuICY6ZiRurvYVCvWcy5IXzGPnQFQ7hguhvSQ5o8S1CPIhXrIPQ4wUy2YxkGXO41rt0PCQZubGxbYKKkXxKs8DbE7eFaJYXaewrf+JhTTAqYs2I0OcqlcI5QWqq8QXBj53Hi0Q47wGclgeg6tUIFI8hXrDtO8GZlfHVuetrUM4YTOuxfSIxDUTbTyDp9XRfuJespZ31iyn2dF+u6v8a8pxv6SKfAG7xK+tYAU/mbeuvrtaNqAiVFyQMAgKFH/QBDB/OLjxJ6f/B35sACXaNkKjv6Y+IGkn1lNufTOdyQgCpCRjdL3FaD7X8ubQY821COUy6CrNICvhA50wdHvj3R25EelfL3mUbMcmKx2YjYfA+lYCsvEh7EKFM4WDqqKYih6SoC1OM/QeOgUixILEmrnoImTJcrLhIy6ub8NrKlR15KAtmRl0LtGgG8q5zTiE1GqL7YPTbMegU+xJtZr1r08ty6Kn0dVepCerdmE9EFI3hEAkF51UobWy0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(6133799003)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DJJhaHT42SAomHPoIyLytWaH4A2pRWWTvQrL9mzt3rWv6qTFBu7kosFfN6U7?=
 =?us-ascii?Q?Ab3Hbr5e5ckH4cqWX7MW1dFRA3J0S6jJ8jfvMGKrHg3cskaBMev7gRl3sREf?=
 =?us-ascii?Q?GLoHymRkjyNhsKjNh+47HquRwgNk6GvcXwNKTK/DPlzhipy6ljaMReK7dKN7?=
 =?us-ascii?Q?KB5MI+ixKbHy4hghgORY4ILg6AiqfRi67jwK1rZLM8UNRTFuLA9QRaHKd97Q?=
 =?us-ascii?Q?ECjGUP6qPJl3ECpgbEqsgaWcaL8iSQJlSXANJUAwXp9iI44auG4IHnEuC0Ij?=
 =?us-ascii?Q?FzgaSDDXiVev3X2xXV/elFaiJADh3CQWnw23FVohodYgur3lYdZGw3ogRY0r?=
 =?us-ascii?Q?oqZ4RJi3tc3EA9OpgMtnuVBRw9O7k57oLuuTmxkLr/OugP/oNo4jnITSk+3P?=
 =?us-ascii?Q?ESKIIcBab9kQbHp5oePcCkmP5upexTJ/w67e7M7mzkxCF9oEUqqTE3Or4ma4?=
 =?us-ascii?Q?6qfX5OR12+VW551Eor4wY4+g42yjjVxcHgKX62KdXjoN2f5cUDpSgAaCrL4U?=
 =?us-ascii?Q?QhDEb+p8ll58MtcJWuYBUGIpCEwyFEw+VNyBKXLYSaN24f0ODOJljsnEJR0C?=
 =?us-ascii?Q?7c9PNmxy0V9FD0EIHPwyufjAjJYA6/whprEXWLYjB0rsbR7gPMpuzl+V9NQW?=
 =?us-ascii?Q?Bha2+Sie6MShWryQK2SmxelH8IvUVxOsBSa7sd9m7NWovuiEiyA75CAkulNv?=
 =?us-ascii?Q?nArZsSGr9DegwtgDm6NwVYDXN7QsrEvnLcYMxS3EmGo0rxInY0riz3GnTQZV?=
 =?us-ascii?Q?eqCnTKWBTPVmFaoPiabC0fhcnovXqZevFkxcwHQxK8kXK1aqcgYrxY2zMB8h?=
 =?us-ascii?Q?KXTwV5yk5TF7Ai+gm7AbPPqUx8rrDRtKpTnNW9pTJkHoBOcPCSU68Blo7/5W?=
 =?us-ascii?Q?SWSHYyGDuY23Isy1BUHQ8Wbu1ue3o9UqwMEqTv4JxwjmzGE2eCTJNhLQu5wc?=
 =?us-ascii?Q?+L4FVwAMLWix92FrQ8elgfNmdf29MA0WDP9K743eRsg0DwhM02i+2W5Nimhd?=
 =?us-ascii?Q?OORLMC+ZYv86l7f5XcwFSs2/oIU96upWuFZrQlIrQFDyMgQeKgXQEsYctilB?=
 =?us-ascii?Q?NYvP+55foHLeL+Zw/hXJDxw1WZ30+gXqiI4Gg1xKmMfVYAcM/GmfjCEWlQIv?=
 =?us-ascii?Q?51Yu/PDbw76Ez44Eo2TqNH1IpuXmbWP+avuz/lqlWCw2agorLNxZ5vajD47D?=
 =?us-ascii?Q?oVDcsLnVkqjpdE7H9cP/u6Q/pJgd7WOVkUqU343ZGquFNwWUO2rbnPFF3mr6?=
 =?us-ascii?Q?GXsUyFGepBdOcA6YiewGY+qp7JYjdPSREPSQ++Knp10+LKZWlgaLxqBVl8fz?=
 =?us-ascii?Q?OWUHUYP+6qwifRXL9Jd5ztbvp1BMTB189R37/J2ndySlcWNwemji0a+/YHCQ?=
 =?us-ascii?Q?PUHMylDcAykRXoacLTtj+vUM3UVhA7RN9nvL086U8K4QI5JTUgbNF+sDBMJQ?=
 =?us-ascii?Q?hIjKGNlgv910J2ZrAfAHZGYqX7XKd/+Y5bjh14paaL3WoYZ9s5rfEIH5eQ7O?=
 =?us-ascii?Q?5jxy0eUgzRuaq350UKqZdfyyPn1kxqZQNsjd+YXXVNOmJd8sGOo4bweRIDdV?=
 =?us-ascii?Q?1/QREMLB6qU3No83+mOdMY9bx/8cD3qTG5aLJlOUwqktQdQ1NShrbmX+TVLT?=
 =?us-ascii?Q?uYS4YbCDo8Eh4HD8jTsJMgRX8LUkKz0yYujzQure/usjpgy0dXa4YrK3p/jN?=
 =?us-ascii?Q?Qoa9PW5GSjF9okxi6EMeD8VMhK1eSFpq94kMuBhp5lwwUf3E5z3gKwTp+Rlp?=
 =?us-ascii?Q?0rMWkfiRjGi3IQ6Vnyu6JC3vomS0gYQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89225a76-8432-40c3-7077-08df1a139cc8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:44.8726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxEZYP+zoCPQAjE061+qwfalkzRDVe1Pz0znPt/ivcPA7aFQYLgOxKChbvrOnZyQW+578O3c+Y6ccaRZX/AUAUil5+JDSJMvHThqRI3lIUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:13:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24300

The option CIS_HARDENING includes kas/opt/cis-hardening.yml, which
enables the CIS hardening and its validation.

Note: With the default configuration the following rules fail during
validation, as their prerequisites are intentionally not installed:
1.3.1 install sudo
3.5.1.1 enable firewall
3.5.4.1.1 net_fw_default_policy_drop
5.3.1 enable pwquality

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 Kconfig | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Kconfig b/Kconfig
index 490af8d9..f922a2ab 100644
--- a/Kconfig
+++ b/Kconfig
@@ -369,6 +369,15 @@ config FACTORY_RESET
 	  This adds the necessary packages to request and execute a factory
 	  reset of the persistent partition. See also ./doc/README.factory-reset.=
md.
=20
+config CIS_HARDENING
+	bool "Harden image according to CIS rules"
+	depends on DEBIAN_TRIXIE
+	help
+	  This hardens the image according to the CIS Debian Linux Benchmarks
+	  and validates the successful application of those rules.
+	  No default rule selection is shipped: provide one via HARDENING_CFG
+	  in a cip-cis-rules-config bbappend. See ./doc/README.cis-hardening.md.
+
 config KAS_INCLUDE_DATA_ENCRYPTION
 	string
 	default "kas/opt/encrypt-data.yml" if IMAGE_DATA_ENCRYPTION
@@ -385,6 +394,10 @@ config KAS_INCLUDE_FACTORY_RESET
 	string
 	default "kas/opt/factory-reset.yml" if FACTORY_RESET
=20
+config KAS_INCLUDE_CIS_HARDENING
+	string
+	default "kas/opt/cis-hardening.yml" if CIS_HARDENING
+
 config WDOG_TIMEOUT
 	int "EFI Boot Guard watchdog timeout in seconds"
 	default 60
--=20
2.55.0


