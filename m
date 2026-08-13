Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2770C5DF69
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:38 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.16257.1786617573899323685
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:34 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=YwRoFS/r;
 spf=pass (domain: siemens.com, ip: 52.101.84.64, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AS1nvVTIUQsg97Q0XSMCw2SmKGB1cZWEYavXWyABHYTnHXrEby7u/dmDBQZ1cADUhxtb2cqM34pnky9Ic1DBCtcFbJA/u+JQP9Aj/tB3rbKkRTy7C9ydT7dQB9n/DHvGhlntt1W7O6ZQH+UVe/gDJzN/BfUc8gpLUW9FLMxtIfhIpMtMpMG1XKlz56tDStbNI7cSlzun9Lr6nDzu5Xhs3Wx4gSdQeS7tOOFe2lDBZSmcGfFX4b7zqlubv1HqMw9+0ri/vYdN9gjgVP151LHicNC8uMmRyINytsXb6dI7UWUegTynVmVTY1+vcAlOliygvY2CxwT9Gs7Q4PwnsqAafA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=AiiLCiWwxHavEHQiYBQ1kbfMdbhLkcTfq7nePjiZyZtTlXRWiirn94D+DrxfyAY7mnf8HxdbP9oOOHDtTZy0aZ8m+DBNWBy98nWr+fQezs4J3ew9DodGkwFaGRHRkG32kQvJ0O0CQQeuhW52HlbXj21BlVTjBeBJprsZ/lBr9gKXCVfEVVW75wXrsqJ7EBabeagtzfr6f+2GnJI9PwUUV8DkrJ+tQQbyXxpz1TcpCyJfs2waBD57fx9/qlSG/tt19ASlyM8YF3kpO7Zf8hq4HH8AL630Ydtp8JSqgTxPrQ1J0BpAOdNQx/TJ+hrp6HGX/evP7l5ilHq/33GXixuy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hXJj7TzCT0n5JL0G2xpCdrw6rrSmFTKxiunfYIi4vvQ=;
 b=YwRoFS/r+Y2syS22T0g0U5osTl7A9MleEDiOjuo43zHn5B/dtauhxFHjpue2QFGdVVAGlbCP409sIW4Jlt3Nb3A/4gYEsoAs5Ne7mqeKvV07tkxLFb+qTOFpLay9c3f+GBkchP6QXN2U+/jGHk4y30KqzFTHmUd+4Xb5yNyCYtQNNg5b2x3K7tVIk5vsrPOjWQmYpoHhLojwq68oqq7gM24dRAZbH1FRopqgukE6LiKxUUbTL/9Vmkm580ElT9jmRkaNLwSrKSy8IxgBUeWX5SJECL9tzEu4Vyw7GLSnWlmCp44kosyYLeJwGZFESG1p8WuOwPa/OehhSlLUFwWnDA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8597.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:29 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:28 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 03/12] Add github.com/ovh/debian-cis for the hardening validation
Date: Thu, 13 Aug 2026 12:38:53 +0200
Message-ID: <20260813103919.184402-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8597:EE_
X-MS-Office365-Filtering-Correlation-Id: da84b3c9-9444-444c-9846-08def927270e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|55112099003|56012099006|18002099003|22082099003|10067099003|3023799007|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info: 
	6aiZlsisx8b0EeU0MQ2euVqGxy8RHLAGQwtyHi6i3pRMYkHolo1Q1VLsiCZZxHFI/dj21xM3clhOWNvwNmmgoJNHF0fzYBA/DSUcxWmL9LhWb1InEOPSMSnRdDEU/F61JTK6BbwndCFSlucxsks1LRWWFbqrX8ykU4VUmNTwoc9FCXG1i+wxLaVvJc61iutKBFRwCbT31tmy1asayjMtUMqJr1QL1Qde3P/ci5LZTHoz2aG2jeQBPHaUKuVFu5hDolNEhlNBqRY6oTWOkt5ay1dA2SFwBqEgShDYtNZ/S96uStqcxS8s73/I3LKZ4v07Y/4Lbo70Ffxwao24pjWfV7WmrnB8iBG2l8mO00UTc7O5PX6MhBmK/8uhfCxndVsTt8zONiyXLKsX1Nv2jwJziLtIvxAdeBRLEDhaGfd/e/j3fJIHiJdyegfs6P1YFNSgEVHejJtQ7BDqIgp5weCdwytpcCQBbGAi9qaDy6IaM3/IBJstIrxfoqoeByLG0X+4drM++eo1NKlMs64Fm0sy2oKBAtr8c1Y4rXfPccFAI2lGakqBvcH2YQZrRPAiW8xsBVKAQhHSWB7HNkd+qU8gtdqolbTl75MfaCqGDqEGBINEcaTFXyTm6zvntUQ5CeN1
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(55112099003)(56012099006)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xWLbebz51JHreHellnPefeh5WPH5GK26WsILwxCKeQdRgAILTnU7E9GK3Bp9?=
 =?us-ascii?Q?NlbY1+Ysw6/CTUHdVn8U8OH35azFQzwgl2GrFVtKIZdn4s5pIGvvsa5Ca0aa?=
 =?us-ascii?Q?07gKQxpoBbIxFe/w2uuLMBIfqBJKO3rdi69sSYNZv2lWFG+jMIM1AZiC5a9f?=
 =?us-ascii?Q?CNs+u+FWisD4W6qBfAuoyoWt2NZ5tqnr1Uam3mk/z63hZvQeImlWo7LLQtr2?=
 =?us-ascii?Q?T5jvXhdmv7pXkKwb3mHBty+WsxpIGKfVKSTJBtl7U4UyjJmPuE/+YozHflOJ?=
 =?us-ascii?Q?HWZsRxLOO05ztONghnz3K3qBDONEqdBXkiZLqunE6A4eKj5Hw+25KTSnFYWs?=
 =?us-ascii?Q?dhvP8V3DwuwybLM5OcOpeB8UEOyefZRL5HQ0XIOGb64YNxJPz75lVTSuSDC6?=
 =?us-ascii?Q?1G2cP8xaEIGcdFwBOL4wAkY8L40g89A/Jx0z028smNj+mEnVHEbZCRxLz3Li?=
 =?us-ascii?Q?/GhbjaRNvDSl/vJzE1gE1hkS2HHGW8PGic+dZWKW9SO8JFwXxonkeeP05/XP?=
 =?us-ascii?Q?uTvyF3im1JVaTlLGHCGeOumqdTFfzcXudOimP7JUOHJVk8JUxeOpqJ6rdoiC?=
 =?us-ascii?Q?vuBaM7faLBNDsF1u+i6jR1USlqCXph4UtrYUyqN8ucNrnj+sUCOePyUcj+Zw?=
 =?us-ascii?Q?qoX5wAa6KOhRurMICnvGVUDSiz0+LpkBug/lO25gJgcfY85E3/XR4MzKUIk5?=
 =?us-ascii?Q?s0KgS7MYZUwG+PoP216ZMXAWuUitIk9voY8H22j4ZKLI50BFnd4nH6qf9BvJ?=
 =?us-ascii?Q?5XUjQwVZ3nXdiLFvBrSM/ilvZmiOlg73froQ6V9nfmEgdKJ2A/3ccw1WmJYq?=
 =?us-ascii?Q?SWorjB24aKiEc5fk5UGDTuGOoe8KG/WW4kuHtoiyPaZT3zRWRUXnkbq3cXt3?=
 =?us-ascii?Q?EXCx8yMadzgJ5To2y3WhrsU9VW4oSwYM+FJDruv8W/gtDlojKeU8ThY2GDsI?=
 =?us-ascii?Q?yPsyqWVLXi6S3AVsGu9OdDI5j2GncQNGn+l7x+KAkaZkiIer53SYYt7saxrG?=
 =?us-ascii?Q?RYJetlvk0CpLW4Io07/9UJS3/WCVQDcWbVLEU8/tuwRkklhFARMcPZEBrs7y?=
 =?us-ascii?Q?A7zFfRghRX/DwHJRezz0/OeU5yet9QC2xYb0qBgWPsoM/GBLYeisFywhLzaE?=
 =?us-ascii?Q?g7bDhuM1SOlQT3gCyQKe0eTPBZAd5ynvbwGDq+wA6r36deLpQwKSbGlqpq8C?=
 =?us-ascii?Q?LOgX7vhNQOvlhgjpU3GA2MK46qTqBZzcf2E/Wo9t7oPoZuUphp1UR2lt+cy5?=
 =?us-ascii?Q?sBtAmWiMwZIdQzSTPJMzrWSKCBkpUEPrN462ICCpug7CpCCyMCu8l4KVxqHM?=
 =?us-ascii?Q?YkxQedvoTalD4a3b9WPlsvS5FnKJPLowK6uNfRSWEvyE8VLX0u7eBjCCRnec?=
 =?us-ascii?Q?KHJebPzGFdt1FeoSup7P5fiJValSucOFUX1csIDSglgcaWsteJwStCB/6L5F?=
 =?us-ascii?Q?PpyqGA38vuKlgZ3Jo7ZsCfEqcNr3J6G119wVjKaXXwiqKJpEb5WIfx0ZRiv5?=
 =?us-ascii?Q?m9OOVHmA8GRPPvW2bImSDruBJIIBYTueq4psCu+TwoO18kAcqKaTEtzf8hj3?=
 =?us-ascii?Q?BUBv2KzAuIy3C1yaJDavRSx5NIn8gFSxhFUC53PoLvduFasp2vlSuQG8EVI1?=
 =?us-ascii?Q?SgoNhajDNEXXl/GLgWu1ovByElvB1+FKwQPQPjk5eHfVW54B2hrth0G3mBtN?=
 =?us-ascii?Q?82Tndk6NaYrcT0qMrq0DDibw8X/2EfRenWiigD1OeuhvQGEeONxgy4e+tSYb?=
 =?us-ascii?Q?Ucj5KIVmGBu1UEIhRREro5TRsWtjtUg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da84b3c9-9444-444c-9846-08def927270e
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:28.9120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vJWjfSfugRqh3BYhu4u6Ye0FCBLJcswIjm59BoXADslD9r2h2ojeLiBw5O4O+mucByJXkmcxDrDQ1vD2u+cX6ATnReXk6PhNxQ/GjFQnpFI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8597
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:38 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23919

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


