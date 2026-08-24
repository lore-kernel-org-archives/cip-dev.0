Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F668C61DB7
	for <webhook@archiver.kernel.org>; Mon, 24 Aug 2026 09:47:51 +0000 (UTC)
Received: from AM0PR83CU005.outbound.protection.outlook.com (AM0PR83CU005.outbound.protection.outlook.com [52.101.69.14])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13173.1787564855561939332
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Aug 2026 02:47:35 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ubVXh88y;
 spf=pass (domain: siemens.com, ip: 52.101.69.14, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNyXaHlhfgVcctRPZxi6ZwfUPSqNead2X9Zln+Ifm/FYZYEZgO6aZKnujWUebZXmwjrPRkaRqd20XOtrlqigIoo07ulmC/7Q40Un/tpXL0gWoFqkKBUlyU2ynNZPrCHt5miT4c8ww1mdQhpyJVbI1BhdRpsPg/dVDd8bp+96bHafCgC9B/4Oq6d6c2rF/HCl/T4QwaMtTRozuOH1QQeJ7haANyo7W79Ii0HJ5Sd0uIMIXLNjKN6F0iH+BYbMhkPFSYUvsdmul0vNCanlrCovRYf3DWrA3Ch4aLexX6ZcSqzjXLr4pI+sQYiHnrr1CBhOlxn7Nh2aC1fjt51LE7SKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=x5pZsGfk2WolOR7Ho3RScGkDh+uNUKFcNwFwsVfs3OSG+H+ygnbbZAn/A46zClvoAspXZi36rt+7ue2iweYXSLnuq3cVofZzVA3O/8tfJ9atPH2GED9fit1dEaD6+2wQ1Lcz1qxSP7nC239Bi3+STE8iDRiAWCNgty4HDY2j3JCBkvmSMmCekWulSy0Bdacp3TwsJgXFE7BVcfdQoPSTdOQcS18U/fz73cDZFabdqf2yhY08S3nbvRJqrsjhZ/7xnZtJ54VVTULBswiQMXJu+Gw4hGav6mIYfd82DZx5rK/fH5veONrlKaHXv1uDu4rhGtzbFNaANTp/MsUOfWm39g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=ubVXh88y5pMmqeUh/3jz220/NyE4VaInjb6OeFKvMd1O7MmvYiPNWav2Ah/oeH4sPxen71Hk/kS9OUkE4P+bxQwKQUTvfejQ8jsm9Em3ep6nLTi+e1rXUQpu6KCnWC7X6Kahih9UQXrI+qKQkc+FafDXJeqGtLlIUR8ydf1uXxMthJYOX3mfi4FxZijnBDoPAsm5fA9I8sOH5lV+YZnJddtsRjJHTKJc24/OOhLJ9bei958C9ZBZ3xYoVUHrzlFhxWIaVxnapOYeolEudygKHQxy8K2rJNsu6pG9j8Jy78W6QEsFRaZ8bPLF5v0XA0Qm9P/0sRCri0JmA2EZJut6BA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8521.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:47:31 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:47:31 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v3 03/12] Add github.com/ovh/debian-cis for the hardening validation
Date: Mon, 24 Aug 2026 11:46:40 +0200
Message-ID: <20260824094721.2636375-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
References: <20260824094721.2636375-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::16) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ec8711-bc8b-4ca6-1ee6-08df01c4b739
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|10067099003|3023799007|22082099003|18002099003|55112099003|11063799006|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	8Iieec8rgtaIw5lC6JASvJMJappBBRXsP2MFisIO/kPpQZql2dHJPrtT1RzxF8nfRgIsDvgNF/hnA/3kz9cmZZz2AazSrYwKdlLXiGFEAJXPafi0pEX4IIMQVxAeIt40CzR0jZpmbxE3K7WzUYSOu+7TXvPT/sAmJ53Q1XMaa5QJZQzHhK+094j+A8ReDxdPB3D2oRFwS7AA4U/SN+Z6xAvnvvTWrX+GD1RH/o5b4gJgvSmLPa2Wxl9YhzdFHgkwAF/70E9YhGap2zr2MsMqb91jhe8RnbW3SaBgczc3+rllTjRSkCCOI+vzdryaxK7nyiFXstb/DLhJkp06E5j1wBX+MyUlxBtkpzfISNv6VRDkM6/IRXxdyXDITcKc/ODY9YuEmZFJUM1lG+ZDzO078+fomwNoi9Tj2wC654N0Eqnbwx1nB9eUXWH6D81LQUqEa4iPZSlTAT8i4lGJXrWfyNmyCsmSLLkkdL0rkwZ8XTTPnHBj8/FGvUdn0wdt65QnlOJmHFxhguVyaEImiS1OB0b0cBkYn7ca+GjLtvFNnCaBlfCTsA85Z2zS93jTc506+/LHJQ9+6aYPzu3KgW/cL4NmIMGg6H2KXC6UyMW5yI7NA1wRWmC8aRe8kIFDMtzC
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(3023799007)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?M0NdboxsYjttWraJG7HtMITarUuaQxdWFcYj1ioUdcE4Dc65B6+htJJIn397?=
 =?us-ascii?Q?wd03ott0YU6CYlLJ9Vi7qhUfNrmZ4ge0qydAX4GB8fkNP0s4b5WWSbBnlDUb?=
 =?us-ascii?Q?SfA5auOptDF3Pa82d2FizIm5hCF/U/RNyRALo6FLS1xMOORlRszou+9J28eX?=
 =?us-ascii?Q?TwrXzMsXU/8ZTDuWYcSDEJOtOy4iIF3ZriFURto5AtoaSWpJssGEOhxFjkyX?=
 =?us-ascii?Q?4s2D0hP03olf10f4OPvv3VUSmmWbyehUKWTNKpDsOaYtKr5JUY+BtfYe8MMd?=
 =?us-ascii?Q?65kqoPR394hzxtffaEeHA2mAhszufwicKqZyrEzXOPdUUGxe8TMf1q8h7P1n?=
 =?us-ascii?Q?cmtwEu9aXhYyme7mG2jAP2bEhGObjqOdbR6Qcgyu3y5gdO6tUyAe9DVsG2Cs?=
 =?us-ascii?Q?nqgStSy9lECFzs5ciJ4EbHN6j37Pg0+3uYDEOdChdm5lYPfH3MejEQ+Vks5w?=
 =?us-ascii?Q?0BSXuQAlljGB+aom/h9c5rCCHzDeGHgsUgrk30HeBit85QvIWS+P9L0JuYCN?=
 =?us-ascii?Q?4FVeARJH5rkvtUHtIVNpZslDvL41LB7HKU5ygsLHfiQ9tM1BIPyfzhLKjoSc?=
 =?us-ascii?Q?PZ1iK2xFSG3D86RGDdY6FtVJCg4y/gZlbp1UWZDJEXg25ZWKdiTpgNB/rgW+?=
 =?us-ascii?Q?VFevnl7OjeO5EERqMqM8DkIffl1iOLh3xX+/oWlbXMdXGeZT2ProOfWJf4h9?=
 =?us-ascii?Q?1VS1QHpFlQrywhTEEe4n1UkyrvCHjIgqCxbKr15Ss7w6urLbkXuPuj2U2fgM?=
 =?us-ascii?Q?7MLADg96VYKkTwUaQdnzLo/mUEfkqNLQ4DK/md5DHkUJPrfjE8dY5BiOIlmG?=
 =?us-ascii?Q?tR7+TQRAGfs410eKQcEjY3aMW93Vn+kevabhkxKeiseQvf2cgG/H4DpaRJ7a?=
 =?us-ascii?Q?34tAnZ5V4XOe6fVr7NlpGTX2VGt7XIvjXR3bi2itcGOr/lxxuTioH8+QRwZO?=
 =?us-ascii?Q?XuSGlK6REz3e2/ImamwCdnZezCcqiVd32GX+MOs1+xkO/GMClCdjR8m+/5nS?=
 =?us-ascii?Q?QhyHlez9oMmw99mgbf94DLmYhGZ/mNYCv26L4tyycCmKYJDmMbuXJEXix9gg?=
 =?us-ascii?Q?HkYfUoUumiICHQoUEBaEZ+W1LpSgorGBfF5cxqRtw/NZCtK7M2VuJFCpzIJ3?=
 =?us-ascii?Q?LFfk/9mGj1sGfcBPZlh/ynaTeog1wpSBitsrT+4jRwQx67zLyxoOg6i0c5If?=
 =?us-ascii?Q?67x61ExdQp7sUQhjL9MIG/CeuQ1A+Wbb56NUKTjs9SDE0A7/NbbrJC9uJc32?=
 =?us-ascii?Q?so7/sX5ztDsH5i/D9LyZyRC67C+ZlDXQMhcHzFcjGwqOw70INo4WkSdJpGsi?=
 =?us-ascii?Q?pqKx5swpvi+nvVlwaFzdSTUseoPvyIXa1AA+ilaFctz1pVJN2xD1eEyEp2fY?=
 =?us-ascii?Q?b4q3WeKJZRMHlpueHBZv6BF6x0cQHktla6qPG3YDGJ4RgVe9jkB5MSwstkfw?=
 =?us-ascii?Q?67AWJliqKyFVPgruWAUBWz0x9TxGngEPW0rfCZbfSD6TLlk/jvDS89JvXkoi?=
 =?us-ascii?Q?MEkLZuMC9eMsQkhU5vtZfTshpSZO7TsxTWNn5sxaqrayyVo6bE/LsosiWh7a?=
 =?us-ascii?Q?uDBdas8bhoNYxa5hg8kOlRewqLItMffYd2PcKDxmd8FYwZOAGCmsl75DzPp8?=
 =?us-ascii?Q?alcN9Zk1OVOgEMsnL8B4lnOmaFmsbmB3JHBC0XG6ydCNYiXHJxC2B3pbMabb?=
 =?us-ascii?Q?B2yfZXL/sis8EiWbTtz5OgxcwVQ8gsj7M60HMY/5jcisLcOXhhQAFOpDtTzb?=
 =?us-ascii?Q?IlNF2zmeVx+0yV27kN08tX0j5mtG4FI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ec8711-bc8b-4ca6-1ee6-08df01c4b739
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 09:47:31.1309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9k4Z+v97NgV2FAX0qNAnQ8/rVx+s9KpGIEZEhJuqaPHb8umm5Mmv+X4aFEyFpqiSQrR0cVh7CAF6wMZSunxXV7ZEVhLfslYxh6wHvdbWq40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8521
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Aug 2026 09:47:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23984

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


