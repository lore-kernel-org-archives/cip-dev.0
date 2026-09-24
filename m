Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F08C98314
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.69])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2973.1790237559227108906
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:43 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GIg+Xxvy;
 spf=pass (domain: siemens.com, ip: 52.101.84.69, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D5fctSkh0Gu+65Z7AKeoCqbCggkoKztQU0ExOCbhhOeK/kf79LyhevYQc+aX3EguM/VELoC5ZPKRyJ6JJRChO6VhJPkPFO4l/bGxuZx0wwP2W9kPG0tEtVtomPsdB6NMhjMxMuuc1lCV2CT+jcz6h1RVNHgpfG03l3YYw6ye1G5FajU0zrZoiuklQQKo/oNsWePGalzamEfD20QcGUt6E/nz38ylgB61GiCXBxjAdx9X+WM8CaWpPB9+SBZ9vMgZ8QQtF4TvvejzSGgeIS8Uv0l8xb012bQYFwpwF3h3CVCVdyh+48Fst7UMfGE889DW0GKM8Mn1ZId96LMTJXanew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=PmCiv3qxHeEwrrEVnRRbUOXU8B4Oh4VACjv0BINtoq3GjydfXoek42t1uiT/POcyNuUo7QVndBoB6i0+zb4ki3agfhH+OJwd2QqE8PmXYjJLjLbT76w9btqd4ERlngO/E6o94Z5jvRznwxqtIYfkxQj59ki1D812CM7EPacXPlM0ICc7kEtxjVzubUhHrlLUax/mgG36P14SgEfPfP+LvE2llMwcvoUSJvb7kfkTxDmhZ+xMmw3ch5lPdS3oj8J+5Se1di+gAqLqQ9XcXLGoeeiH2fra1b4GUahnHJBwBv9ptNk2rZZK9x85H+Riw592FX89OQ3uOK49jAByETtXKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=GIg+Xxvywq3dhNNlRcXh6Y4bqPBQHPNLTB1Q1NNQU7UXu4EH5MMiWOX2tyD5I/Dd8mHGCsg2BZMrIssN84gOtP7qpcrQ2EJKK2uCWaMbLztEx8I6rMBlEuoEFCfk2SRpvOwivOv9yYZtEMhoFSeC50TYOfZrin7fjwrG17jVTSxMZRctNJWgn/EbavY5OkrUhB7SlSLiEDTwujj/BlP3/gdWuuDHu/IGaurTq/Miu50G8L4xsXdQX+Z15nzkAkssLfDUh2jbGMciTpG4ih83elvjRVO4thIG8+b2Rm/AbtT1KKEMsxUsYN4mFQNBhBilEcgWbQ/m9GnHsITyUArXkQ==
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
Subject: [cip-dev][isar-cip-core][PATCH v4 04/14] Add github.com/ovh/debian-cis for the hardening validation
Date: Thu, 24 Sep 2026 10:12:13 +0200
Message-ID: <20260924081226.2844456-5-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: 282aafe5-a066-41f7-a396-08df1a13985f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|3023799007|55112099003|18002099003|22082099003|13003099007;
X-Microsoft-Antispam-Message-Info: 
	NTiwE+BNubAwToD+U+Dnm5OKJLvVm/LDLFH/sVUIjwjISQtJAK28KPtmvl/cqKT5q8zCcaPIHrF1DHCXvdBXs5vivHQxhklAL5Eg2qxfXASPU1meHwZ7EJGSA2TQdRpH1VRSIJH76dyHWuZh0aSq65Lbqs5VOLGxrktRvQL4ejPHUZY5dcSALyTb9bQxrpG11pXzJrRL0P3ATfEpQkjlQOTWA4mZdsygEJ6RGhL4Nm9QIXo5YA0vaik25RvtiWkhiVheQgBQfFHW+DVGyMP4NId1hayWM9jSFS5iBTy6GxF5Dt+HNfXGcF60Zu0n25OsiHeKfntdHcLD/NXLDNSldL2wT3z10G8h9CdKCHedFdWJGioQAF7YcTcj3AI3ZrzOAtReo4aYC3miVj8A+3KMHguwQftYG2MgCryqIsJqK3xmJoXmVajhcN0TBZrl6cG+rgZXXfssDF+vdnC0oIPV7BvPw1HYjMbdG3MfmpyFjLSBfknQp6ZsBpOUD2h90VFz4e9xmSq2Y2DcCH+rpFrkRoVXUVVbGz3eTcsPW7nscJAQTCgOe36PWsFGJPlsJX1GJSdiz9FbUrFjx52DkaREIc5+p4QmxzI69eTa3bAu6aGaz9hVEcWl9U//7woi+8DeURCcue4iw/RW8dOMUhqh2Iiuy7LreehiItg94Y8MD6g=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(55112099003)(18002099003)(22082099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?BEQwyPDlgtAKuZkUMWA/poxK08vjgt3XUWo3NB4GgD3AHXt2ZSIf1v56NQ6M?=
 =?us-ascii?Q?/lcLTxe3Y2+dICnWnuZNU45ndN43p41LuXdqXxbpXVnN1Q+BUpKR2+xOOw1X?=
 =?us-ascii?Q?6e+RaExvccvd4KAPbFFcK1ryVyo7Lej6QOsJprekABMhNKKGVSfr//gDY92H?=
 =?us-ascii?Q?xuvwcWTsO28qSXPxaCJsWg/21ezKqWbwTGJC6HDheeD5NR6vZVlimCLbVHFw?=
 =?us-ascii?Q?u8GLCowGd3ttWwrQLJciKKiABWHM0Ssvwf5AvtCOLs6ob/Bkw1K+vhaAvGJv?=
 =?us-ascii?Q?2qTtB2LdMmmf3/TQhkeEJGc9I0D6NTxIUApzWltvaVNJNFpbGCkTuG/buW57?=
 =?us-ascii?Q?ZYinMo3bVdKW6c7KtNkcdtz0CFIPXdyhZGm4FVg4jmW1B1fJtmEqn4kvh2Us?=
 =?us-ascii?Q?HieH81TcmBGlOdedRQs8igVM8PQ4FoTZwawCZGOwtnVDHLZhLy7NKxQZw7RD?=
 =?us-ascii?Q?sx7NFEhn6WiR8AdLT/qQIGv0G4faq2XtLnVMvxy+uOKVThviODLzQGCgVdwQ?=
 =?us-ascii?Q?kxqLCcda24TEoVEPADOQTKeRJdJOvJ0m4RvmI/XgbOU6GR4TuZgKZcibR+Q7?=
 =?us-ascii?Q?RIPGbAN0+pKS9QUfY5csCWUEmYBlc3sewmd3eBBI7RmKl76s0CnLV0KHv7hB?=
 =?us-ascii?Q?J9vubDhp6UUMeH7s6Inxnii8M1trdU/WJWFrJ/0logy3jHch5wCO9bzqTCoS?=
 =?us-ascii?Q?6gZfW7KRxA1dHdw9uKAVCDMj40OcPp3+iR4z3UJBjTO4iNWetqIR4tqdG9l7?=
 =?us-ascii?Q?bVhSzCwJnR142YIqKgQB6K4EHHNHMAN5IYy+HEkS69Y/ycaGk/JQjNFB46YU?=
 =?us-ascii?Q?nIeEqOLSm7L6lolzJNURqHCOvHf6tU5VEhvQXS8XoZVNctNNGAAy8sFq9xjL?=
 =?us-ascii?Q?HH1sBAnIkwrzZ+jAk9y/TNVfv4rZHItqZNJcb8mIGtS9kJ853uTy7IIqKGPR?=
 =?us-ascii?Q?i94ICDy0Xs/mGjz3jOeYp+/eVmqWep6VROkb5wD7vmOgKfw/d1xPj2FZuNUT?=
 =?us-ascii?Q?nC4BtVrfofCgYw7Pgke2KzJ367aJ1g6U4lIk8cFZNQWLmLHMHWHGpYx3aEjr?=
 =?us-ascii?Q?yNxGUFscx1/WxVUi4ClntPLcYGbV8cTd6/P1Fn98kCINSvFf2HtX1gLM8iFt?=
 =?us-ascii?Q?vwIN3JrxIemlwtW/F7jrbIkM7I0s/QLaAqOV9E1bEjMoplNnvhHMxfadBdZt?=
 =?us-ascii?Q?6R3rkSyD1ysdyrkVt/VPSZNvfHvmOE5B9NdSqthAdobOf3k7rPm85NT1eqrm?=
 =?us-ascii?Q?rJqrCyEVikLkTSmx14/rvKyC8DtKzAxmY4eFtO224XeznYM3yqJObXNo99l/?=
 =?us-ascii?Q?iuuLwyhv1wztiMSGimGmBb+mzSpECNQBctEdVcQzJKIG8ibZ1ZpbHAl7gl4J?=
 =?us-ascii?Q?focSXN/4m3GYM/Jn1jtsyTugNgfNYMY4FkMQy3Ypuvtuxbbcd+49aspLx1Q5?=
 =?us-ascii?Q?D6DL8kAjmEBM2vg5lOs8ZnzWlMNWD1l+p9Ix4azclI5rEqG/r6Q8iHdjpxqx?=
 =?us-ascii?Q?l8wliP0PlklE9b6F0DRJQgjYaGUEUxQbsKQ92wUyAkqcOodBvHZtVC83Ylre?=
 =?us-ascii?Q?WXa852hUfG9oM7zLbaU9QC4yisv3fGqvBfFc99bDQ6eQsL0MBMWjNFw16jcj?=
 =?us-ascii?Q?xes3+JDy07x5pwBk9zsV+DDYzbfdVWth7304FErxWGY+ZmfixaUermuGt4y0?=
 =?us-ascii?Q?hw/vb6ZOmruYPcDyBsvIhoBsRau+/8w1+Eak3+LLpGnK5LvwGGdvKQVq9Rp2?=
 =?us-ascii?Q?fL7pjNRe3Vy6L/C7qAlsaSF1dg7qK2Q=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 282aafe5-a066-41f7-a396-08df1a13985f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:37.4309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eoGVFstpY6mvC01dVADbNFiFfR3Z4AlIXAlSXZx6X2XiLBdTbvzFjgZqU6UmFqy71NuqKa/fKSmT552+pLzAmA1cAGmvPhszFCW+7gjZ9sA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24291

This creates a Debian package out of https://github.com/ovh/debian-cis/
to validate the hardening level during runtime.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-hardening/cis-hardening_4.1-6.bb        | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 recipes-security/cis-hardening/cis-hardening_4.1-6.bb

diff --git a/recipes-security/cis-hardening/cis-hardening_4.1-6.bb b/recipe=
s-security/cis-hardening/cis-hardening_4.1-6.bb
new file mode 100644
index 00000000..4245c45a
--- /dev/null
+++ b/recipes-security/cis-hardening/cis-hardening_4.1-6.bb
@@ -0,0 +1,17 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+inherit dpkg
+
+DPKG_ARCH =3D "all"
+
+SRC_URI =3D "git://github.com/ovh/debian-cis.git;protocol=3Dhttps;destsuff=
ix=3D${P};nobranch=3D1"
+SRCREV =3D "efbd5b35ba32226e8950d52bd3f3444c702bbd84"
--=20
2.55.0


