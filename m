Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF8F5C98315
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:44 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=v4xnE1zb;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcIK1Qb1PGfHVCqHmboEIUgw8KSE+EnKxeXyfWseKQqm1qI+TILOyavBkqd/sVWJxKixPftT6PUBTRDhI0vFE9X+GsqItF5WhQk5VY1e8diL7o1pFrMtZdgQ+2OFNtlUxVhIiLklW+J5lqD2AsBUtgArO/VEkpVvWzDyT54lq6Iud6xLwREUhpoyVULDKNDw2M4KRKh+yJcsglmBu8bVR4MLwgwxbp7dcbQEUxRE0BlAO9ACIGMnw1InJOiMao09DVbX0fRElIhLszcTGJhi1BQsLVxyZJWRJ+74bYC20+73UdNOX04LsnD+pYlekwjFiLap+VacnzWOPXnYTrl7QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=klGcyadW3XQF9z6iDfYgj9yJJ6Z2GpuSoYxZudu1QlSoTQyiOIy0ThMg3yjPzOcyY+lcgvLIuDySqkhbnO49fcEbuYkbr1SbBOoKypYblygocXjf2lgfXwZTAhz7QZ3YYXdnxbyGZDABfVEd1eZ5QBkXL85BEm3SFs/FM63dRJ/VpmUvNeYqTZ2ky1efs3ust9R7G4VkrwmMf5Fa5gwrZhEBZPqNy6QMT+n9kwgEDwUr2owHrax+sVIbSmO3sVQvG2n5eWJqW/ojpw5svT9apJYZxaTqbj/zt/K8q53U4pJtnBSXVbu6IK/+zTD5gUmWG38CDC7zgUAy57dcCjZqig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=v4xnE1zbUeKdgPfGCbJaXG0A2JlZwXWVueGG8darTRBjrLBFXsjl1UWa1h2fJkrx5rkUNn0uhN+xjIzDYk4FWczLLItBDQa/hPgyCjjed2jBlFquG/FyMBAZGvjE9O8TGdBUD3KUF5aLrV2sJcmn7aqrEWuBa8ETsRqizWmD5FfX28OipK6wuO1Mf7pn5GBPUAWu4Bwb7Cox2KTrvorcCyN/StZgZqHe1YmN97LB7eV4ERGg0BgoZcntI0+qSFTAh7E8P93y4/ka2aotJX9X3mpEBQ62egIvAr2ulTg5zkTuduUrZqWq4R9KfEnxAPpSR3uPBSk/WManAA+z62nklw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:39 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:39 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 05/14] layer.conf: use variables to control path of hardening config
Date: Thu, 24 Sep 2026 10:12:14 +0200
Message-ID: <20260924081226.2844456-6-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ab09b9c-35e8-42fc-878b-08df1a1398d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|6133799003|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	UQCSKFGxIQDyK5t8Qj+k4Edue7E3zzLgou31f3ZWQI0GnvcW05W3rLa5Kyl5fTQGWZltSaZwZN3jlMcWgBPCnF2b0Gopioh7zvf8IVUQPRAMZwL50BAGDvJFcqi0pA32mMWcSJTTAXi1iGFTG42ik+1bzst8xpKvNRI+tt7c1tf1m1QIpb2AqZJIAh8qQu2LEXxBG71P2bQGcZQqt6fFCcX34VpbrqMJ+hvzZCosLI+73oT80s8l4lPT3FRCdYhYhrALYLos1Xzlpc/mIktDbTca+BnKXVwzBKuwCmsg8MrOmTWFkdR0RCAedS53xlLe1PNPFmcBwkwY3EHYTRj1PI8YeJBvOA6aVXPPd8x8UIB4+7aNCb0GuCUMGGGLP1veNs4/tOl+kYnnQYe5QQcLLfkiwSL1J4g51y/kQbTI4665/7Ca9OinVPThSUfXnUJEq3ixwRELbel3lSKh1ifzpre/Tl1I1KZBEbsluIMfVa28TJb65tF+9auDrdEZ+fp59nsWJ4fR/yVVlbS0RDHInn/UcrgS0IBmPYDjlp5ErNM9yM0/wPeFaSQDHQHhOMnf6K/7lErfjebiL808MvH47XLkABUZqWWBKXfaHxuaEj6kMJFLETBp/V4wJ97kPxAIaA7F7gYAlQJWtom0U/VwZjbY1ab2gQIHKI6+o4/GtoE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?n6iqw1ej6qKtKhi89qG2WxhAlxpRGCKppaFV5bATj5urKtTZTO0TGY25Cwbm?=
 =?us-ascii?Q?qk4/lE2aXmAuJw/+BvnbmOA+mzvc0OQDT+5a1dwpk9yE+ITROtqr2QkRQ0ki?=
 =?us-ascii?Q?Hx+DjkUHY7jePfZM6u8oD0m1sYK/ruuGSzRHT37kNzKuuW4KYYOZSSD6OZd2?=
 =?us-ascii?Q?gVPNuKlqnJiLNuMZ6+4Nyy0Fdte7ZVTFdN4MCZnuGhchbt9GDyuB8rVCRdHa?=
 =?us-ascii?Q?aJos6CSXVkqMQ5LoOsXfY94Hhy8L2VVYwgGe44M3uXjUN6qLUbLTtaik5mIg?=
 =?us-ascii?Q?1ZvAmMb8g7Q2KLeCmyJUfjlWO0d/RjAgQOrikJ0E+77ts6xIG6TFloaHvu78?=
 =?us-ascii?Q?DlnnvDKuPdK8wZ8MLwgWwbx2wV2pL2IUCpvyFW37xqj2/iNGlbPfusgrzMKo?=
 =?us-ascii?Q?KDLdwqdS4PF4nbK0DpKKLXTqWsawG9VHccBabcrCmr3TPnONXxGYZWTcg+id?=
 =?us-ascii?Q?t5HEi5lPWDsOzBy7CZDe4KWNSVZT+MpeKvu2ILxffSQeTr6Byqro9slROHue?=
 =?us-ascii?Q?mqCtIxqopGaX5T2fPC3l3zdPofTwtThNjh6r4acNEiwWIs8ejU6mmgI5Dl7B?=
 =?us-ascii?Q?tPm2L3m/fxK20HFZ0a09dhwsz0MGSQEL19Be2/E9HfDzZbewC4qorfGwEh58?=
 =?us-ascii?Q?HOedW1zUUfTdybU/F5hcHGtp0hjm2R346nwiPgIVZ5CpnZWgWhfUswiEJlNJ?=
 =?us-ascii?Q?4EQkEXdwuks0r/+yROuX9JEdBHKPnHp5DzDqddvHrQ+QNyo1wnw/agwHmLRp?=
 =?us-ascii?Q?CqyKWRD034MEJgPvD6Ks3PlK4uBxBFYBA3+7cWDietSdhAtd/f7o6jdaOTlx?=
 =?us-ascii?Q?7j464ZVVf1w1eq8o5vDkFLVt1NYF+GJRshsON9A/sP3xwnduhw89gJbOUlE8?=
 =?us-ascii?Q?MSqhAftkL71bphfMNrnrDkUSrqbB0wOj3b4HOIy/d1Obo6dFhNWsuQ4iqt7Z?=
 =?us-ascii?Q?EZTy4HulIgb8WmtNzTiDDNpeR5XpUjjAzFa7BvEBN+Wrd4IqZE2ELxLcG3jF?=
 =?us-ascii?Q?KX4kaoQRLCSJYHPr7DpHvN8lVO4kcVgucEcgH+mSR13CcMbKvc4RsOtFH1cI?=
 =?us-ascii?Q?GxoeMuGLh8hT3xDtp/Qr9HvtxLKKgz+NFGB6QEqGHQZWAOcK7B73jA5ReT/H?=
 =?us-ascii?Q?Z/5djnDjgt8Mm64dsp5MhtKq3glh0AkNT2KBZBe6kGaAS4vDGDg4X9CbCHC7?=
 =?us-ascii?Q?4qoWOQyb2xieQ5wfUSKW6WZe9IwErR5+CVmzAF0bw0M8M9YSRtpEIIvHmUJW?=
 =?us-ascii?Q?i4kuq11zPlsaNQnHDdJOX3agAmjexYHzdIAlcKL7ZbCBy0k2L71dsYp56N8Q?=
 =?us-ascii?Q?Jw+1V7XSCJcoXPJIIo5ploQY2+Emk4RYMjvfTCvSc6Nl2wiEWkc9k4qVJ6KF?=
 =?us-ascii?Q?fHpE+Q6A4q7x2RlRyan9XldG5LFjVO7EMsBaqgnJwYk5k5WcI3pNkqcWkMY5?=
 =?us-ascii?Q?d2JL3LVCm7QekrrYSuYUFYz60fOyOYX9TUZ1vlP24rGlYbUAeRzzkM0lwz/f?=
 =?us-ascii?Q?KbPlEiHFVXtnKPrBAgpu9nnOdMZhQ3wKNi34AhRUXCDCeS3IG70CAwHFdJDd?=
 =?us-ascii?Q?4G8bzV4P2dPNv+A/SitEFGX4rsb7P7hc4Dyk8MBxpu0lBri8z9TTv42FY72b?=
 =?us-ascii?Q?dnWnuEWunywSzT+Uup9+QTC4FnNSz+uib0Ac7ZkcMmpTJWGIPf12n0CAxVAC?=
 =?us-ascii?Q?faYhMsdjMr24ncKB8mI4Ezp+lGCWatuWA50blLxsyw/gMpNftwZD62aDlymW?=
 =?us-ascii?Q?uoyFIgwkkSX0K3r0p08EHf5ZjnXoyMM=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ab09b9c-35e8-42fc-878b-08df1a1398d2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:38.2110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /1sVf4ImxaXPzGQhW2lf0KvCaZ9zibvb+zjOXUwHla5jmUzAGiOQ5TM834KJ5dovDV4Oj/X9t40el1eig24/Otjz2MMR3DTPtH86jIftxb8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24292

Add CIP_CIS_HARDENING_CONFIG, CIP_CIS_HARDENING_KCONFIG and
CIP_CIS_HARDENING_REPORT to define the file names of the deployed
hardening configuration, kernel config fragment and kernel hardening
validation report.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index c51c3af1..800f31f1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,4 +23,8 @@ LAYERSERIES_COMPAT_cip-core =3D "next"
 LAYERDIR_cip-core =3D "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
=20
+CIP_CIS_HARDENING_CONFIG ??=3D "${DISTRO}-hardening.config.json"
+CIP_CIS_HARDENING_KCONFIG ??=3D "${DISTRO}-hardening.kernel.cfg"
+CIP_CIS_HARDENING_REPORT ??=3D "${DISTRO}-hardening-kernel-${KERNEL_NAME_P=
ROVIDED}-report.json"
+
 IMAGE_CLASSES +=3D "squashfs erofs verity swupdate delta-update qemu-emmc"
--=20
2.55.0


