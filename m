Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C28CF6A92
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:00 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.40])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2985.1767864532451868369
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:28:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IvX1zTmt;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.40, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xv/KkzyXJvbBSuvISdNrTOVlZWpVJvH/VEGCYHcy4/AEpM95UAlI5et9YMyDAlya6gpEDCng5cLkQTftcfpRdqhDp7DKWh602Anvi9oIY7TFv+4N3203XeiIsuB4tl/re/YRdjzrv11Lb/gNRsItErGzWouxgYuAOoWpeqUm36EGVeKlQmLYBd2+hIRmzohEu4uxDQMLvbPSEhltgVYpMmgjvyurfsLfjSgOZSUxqi4aAwOScyncaqioNRCEmBkf3nV5vcErJjrmJFxka5mTA+wEhROSsa22CrEeIXYxYDThixqSBP25nVXdBly/Hosd3GNpEV/y21UPyjf3NwiTXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Dfal7Q576FPUQzhum/KeUiwPIwrMfuycFm9RwzFrxE=;
 b=iy3wbVdJ0ePXkeNImulBxQZDV9s9nlYjJare6D4yKhA3HI+jrUv5P9IHgXkAT/t2b8RiX0R0BqW+pUeRWYDLQ55Cck9n40yTw9kwzmD2Hx2epyaAfTO+xELFaf0awhEEnmyTwZdgiDa0Qb64FK4w56lVsdpj5di3Rsj4yvDixEqwlPKTDg0T3PMxefQfwe5NLUv/CLk8WHJTq2KX7ePi35UYt6FnKF480cAvfIB3ERI4yhAUA4f8TBx3mIh0W/Z5EEhtN4CxsSNhJgjoBld1J5E4ulV28hHJZz8s3V9XKLXcJIF78+/UKm2rr4AeFYx/67i+jZZ125h5aVOF1G9+nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Dfal7Q576FPUQzhum/KeUiwPIwrMfuycFm9RwzFrxE=;
 b=IvX1zTmtivR8t0hynJlNBUKcCXbhh/z9+j59eZ8Wa0AmV4ER3Xy/BntOEJYJGIqimHxpsy0WP+ftCn3P8Arlnxyu6YzCe2Q8mWnZ63reSBUCmBLcaAID6EhhsUWlKpJtuEG+UI05cJ983/fuY/h7ZGhspIDupoCxF+ELr9dvSkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB12872.jpnprd01.prod.outlook.com (2603:1096:405:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.0; Thu, 8 Jan
 2026 09:28:49 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:28:48 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 01/22] bitops: add generic parity calculation for u8
Date: Thu,  8 Jan 2026 10:28:02 +0100
Message-ID: <20260108092823.489287-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260108092823.489287-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0364.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::12) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB12872:EE_
X-MS-Office365-Filtering-Correlation-Id: 750b3b14-2a11-4a4f-ab7b-08de4e9853e8
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2qk2GPQqAdAk2mYb4WbHscIG69tfQzZMl8UThtTGSy8GIUsIYJiaxbpRCZVl?=
 =?us-ascii?Q?cRkxEBapzMhjtEshg1B51b+BXIQM3TPuxa0oTZC6pEKGh8qrFBMTOtnk/rey?=
 =?us-ascii?Q?fMRAkMTQ8WfnZww2R6f95w5+G13F1JgLLQ4Pvy9fmdt2yLsQKnUd4iesWlRD?=
 =?us-ascii?Q?EKS6GkqwvyAPGcjqQM/sRqcaGinZ5L/OoS90kuMFcjLHEvda7Lm+TeRPNe8M?=
 =?us-ascii?Q?JNUHVd/K6n2h30Bx+8Oe4lSsfujtNVFe1gg3A/E1RGAY9oxBFHC0GhWmxnzB?=
 =?us-ascii?Q?1/VFAUv01/AOCDNVl3IN4Qt5Y2bHYw1/RTLape5ucRHGc+QZcyKSJHwV/fu9?=
 =?us-ascii?Q?MD32ypvQbatq1SONnnz6302YlHuslQe2Doc28Dwaq1JvsT8+PFWpO5CpRv55?=
 =?us-ascii?Q?uOt7NSEb8GhYnoTk7SI5pNvzmHa70Qwran06fIb5McTtV3Hya6mQ6V6mCwtd?=
 =?us-ascii?Q?BKMbOKK9HJzNDMf7/DwT8gRGr04uWUAf7kfNRVQqNvwyuSuw1CY6YAc1dVhM?=
 =?us-ascii?Q?hBYJJIhGQ56kKmvOX9EeLxX3r9ysFkai0Mwz1JyVcpjY+oK0VVZrypr7JT1E?=
 =?us-ascii?Q?RSdZk4YVC9quqN8maUk9mp+PT4nnPdO1/Q+X84OS6f/c8Jb7ODM2LmcOp1wN?=
 =?us-ascii?Q?I2m0qyp6QVjDgj3LZrbhxFMQRR5ifPHmv7tGSpw8n6n/Sbd2KivH1QzXxlVd?=
 =?us-ascii?Q?teXXabO3ryLe7tz9csOtdcypWiYq8K7giewXe3hVncbQ8R39xJ5peWVHkslk?=
 =?us-ascii?Q?7hMjqZjWri84WFDC1gkWbN+QWTKjaahNiXb2PnGa8k/7T+9tnlGFkB7bz5w4?=
 =?us-ascii?Q?gmFpkD/Il393A3czisUwSBFQoIHJ89H5jhL6tOXXH0r9pV7asfcF3qGqwyOW?=
 =?us-ascii?Q?IHk5rhLns8L3vMRGNum8/KABw4p9I/bY3sjSxReG6qUR7QLOFnkFGMJkf7UR?=
 =?us-ascii?Q?kVRSfpU9Q6Z9M9FC/9dpMPORr5TNrXiTtcJMBsvwGwvNW0lRg3wlUucBzjlX?=
 =?us-ascii?Q?r3m8Bw83wSMjE4otLiVpFWRRW0YXAfF8dHZ1kZKpVhv/XDQvP8fsoaZn04jH?=
 =?us-ascii?Q?jYrbfmIei1svzw7hT5a35Z4wZWmpjeO2EOwfZ1VC2yaCXFl3CVKN2vB10WZO?=
 =?us-ascii?Q?2XcgB/3rZY3BYc3GJJ8CS0jDVwOYeGIAkfSlku/D+peLwz7GeM3gv59c0X5I?=
 =?us-ascii?Q?UXopUlaxHzMQMASdoPO4Vh0fgFh+CmBDcPExkdZSc3tGrFQ6W1ePrvGcXpiX?=
 =?us-ascii?Q?x2smx6bRt+sAsxF9ZZ1ixrikXQcvVjISJmYeHSFSdlkBe645/4/keTVaQ877?=
 =?us-ascii?Q?CmtM6vrNnJMT5xXVfrrHmRVpAnL4eONVmVc9JtBbay85gwJFAXGMtGfi8Ye5?=
 =?us-ascii?Q?CojXF+xMG67ktEnluAlz9RsrenuiJ/vlulozduxWS10VkbnNAt/ACUTcyGgZ?=
 =?us-ascii?Q?Gt8vlVD7w8nZnW6m2tv6q9c407y1YvZDbQgjCbTgLJ/PmWEjCBZqwQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?3LUwxzVeF8iXuEt3XFAYU8xdfcbhhEQGC6nSioRSxO0HLYql44iU/WaiD12S?=
 =?us-ascii?Q?YrYptnzgiFNTAL1K48+03tXhHNspX5TRXzdqMG7FYf3I3tMDzWDT+0ZCAOZy?=
 =?us-ascii?Q?BbVskqs4hRKUKPdneL02sqPqg1uJ33fQxr9cpcxflYQ/9kzuzsjncIyz/fbP?=
 =?us-ascii?Q?QibZq4pvg4hlGfINQQOdZVu+PjmqSDnrytDMWntBBrpXmrWP6WnIIcUJBG3L?=
 =?us-ascii?Q?UG2yQlqUGhVCjZ1YKpNwVzWugaFnvER7Btv1jso3xfBxjulJlv7/Y0b0IdgM?=
 =?us-ascii?Q?7MIBqWeeOPxqyY0hjK+vVPOyNga4LQJ8NenBd5byWhvSgOC6FcWsuafjrW6o?=
 =?us-ascii?Q?8xYO4XGUWD34j23xbYisVjEtNy3kTsV+i3UxVNClrHu2/RhA60S4twVNVA9c?=
 =?us-ascii?Q?4EeJ2FzAY9PMSa+nS/FHNHLtFG3JTRaopklF6cq0teBbqNqdgxgERZeUevqu?=
 =?us-ascii?Q?nGTAaqMiDI8BseLeGc6wZ4KpoFQTX5EJPTLFyjOgUrHdm+etjGZJeYcLAhM2?=
 =?us-ascii?Q?TfVee1+0AhrQWs1hKts8Iyftj1H6E3wdWC6qw5vQ60qJMlBxvIMgxIwm1st5?=
 =?us-ascii?Q?Z49RWDzNW/43Fw1vhSjhvmd4fHQUaBbdqaqr2WgV9ujUw68XdtD0pdY6fPsY?=
 =?us-ascii?Q?SzCwCWK8ikQ60gY5Z7DCswkPtKBVDkN+AmWfQM2O99FTqHUCVsu3CyvSFebU?=
 =?us-ascii?Q?rTq873/AmvDWr6ueQYbO+cxbIpe8T7Q4xHSWadQHfqLIavRMXPg3AbYWXZ1d?=
 =?us-ascii?Q?U5ZoRROopiaxEUBXRet2UXSrTiILsGHNWG7EoMmIY1MXCrkOWXMCKIT8mHbq?=
 =?us-ascii?Q?0FGEgANDnwbQUZc/1zDGo8WyiW7vJCBFPi1hLfTDDC6PzwpGMmJcJLgHGxfM?=
 =?us-ascii?Q?cyGBfuHJsYmKwNjwypUTnV6OU3q8BpAWUsYgPPcul/vTUXoQjGqaxul0T9JS?=
 =?us-ascii?Q?jz1wnGAVJvTIrw6GSlDQ5iXYK3ME/qZK0Zo0tC6iVHZs/jV7AL2ubIakhpYU?=
 =?us-ascii?Q?L/No6l6xTnsfLa7Iy0JVu4Uo7bB99fkjfedPogpalfkoUZDah4ab5OzWsnn/?=
 =?us-ascii?Q?REguSNSjqoIqETplv1xcpEMVj0ZUamqHXal1LsBNS2n5lvNvWoJVMHgUTgj7?=
 =?us-ascii?Q?xqX7rxJfsfsodHrv+0EacEpzy0cxdCEBFHbFbOMPHYsM/QROyHF/nKmHNYui?=
 =?us-ascii?Q?qLfL2Fd9FVvCHo5cRvrzTckb6kRU1hriZlLlCm1nEd6TUo6HJBKHV6hqC7sN?=
 =?us-ascii?Q?1dJPSqwfJlbNbIeT6Be3Pn8/oUqiQu5v2Mb8pB5m9sup5dEuXdjglr38MJh6?=
 =?us-ascii?Q?ey3WMrty2p4+elB8dpO9WsSIPl7VnfM1hQdnv+dQmYkUQ6yJ7MyfPqCIoFcP?=
 =?us-ascii?Q?S6bFNInDuBJ495AibwT+y8G9DgYs7pKAF+dgyFQ6gduGP7PVbl4o5+63SuMW?=
 =?us-ascii?Q?cIWn3Fxwhtfqs1Gg2X54aO8t3t9NUiSPjqy6Zfuaq+C/duJc1ETjMITTsC0c?=
 =?us-ascii?Q?W2Z8C0qpjDg5nmg0s4Gb8LIY+ePtqUmSyxloN+/HCmkvs/rLBXjzPCFIiFl6?=
 =?us-ascii?Q?CIh+m8KrF+9jx2k8mSC1zfgxihKGUGD95zHSwZtqn5htOaLHtF8oc1YJtFfc?=
 =?us-ascii?Q?spRt4R4gaVbvKMHLyWaMngMKrVIMnMrR2kcKrDHfVmiRk4XuG/W/3FnUs6BU?=
 =?us-ascii?Q?MrK8begI4leVCdL/B9amGUejAUbU5Xs9D1fyjuxLl0Zd++5DLbl/5n/cLlsh?=
 =?us-ascii?Q?eV4CKW9X9uEgRMuhLr3Q4fws9QHwGzbZuDmfklxF276t1vT2sdFO?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750b3b14-2a11-4a4f-ab7b-08de4e9853e8
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:28:48.6476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS9CsJb1mTxxozzvd7s1ODobgh3XnDLHjjXiFOZatyua+BwyJT21Kq18CgCMWgXhBqXHI3lUGI7iIMHocJuxesW2rwxIsyl5i+Gjh9H05ITi4yNIVxhqxt1IA1CaruCh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12872
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21437

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit c320592f3f2a1e6a4e69e5db8e76fc66934a0a78 upstream.

There are multiple open coded implementations for getting the parity of
a byte in the kernel, even using different approaches. Take the pretty
efficient version from SPD5118 driver and make it generally available by
putting it into the bitops header. As long as there is just one parity
calculation helper, the creation of a distinct 'parity.h' header was
discarded. Also, the usage of hweight8() for architectures having a
popcnt instruction is postponed until a use case within hot paths is
desired. The motivation for this patch is the frequent use of odd parity
in the I3C specification and to simplify drivers there.

Changes compared to the original SPD5118 version are the addition of
kernel documentation, switching the return type from bool to int, and
renaming the argument of the function.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Tested-by: Kuan-Wei Chiu <visitorckw@gmail.com>
Link: https://lore.kernel.org/r/20250107090204.6593-2-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/bitops.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index f7f5a783da2a..296c177ed088 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -229,6 +229,37 @@ static inline int get_count_order_long(unsigned long l=
)
 	return (int)fls_long(--l);
 }
=20
+/**
+ * parity8 - get the parity of an u8 value
+ * @value: the value to be examined
+ *
+ * Determine the parity of the u8 argument.
+ *
+ * Returns:
+ * 0 for even parity, 1 for odd parity
+ *
+ * Note: This function informs you about the current parity. Example to ba=
il
+ * out when parity is odd:
+ *
+ *	if (parity8(val) =3D=3D 1)
+ *		return -EBADMSG;
+ *
+ * If you need to calculate a parity bit, you need to draw the conclusion =
from
+ * this result yourself. Example to enforce odd parity, parity bit is bit =
7:
+ *
+ *	if (parity8(val) =3D=3D 0)
+ *		val ^=3D BIT(7);
+ */
+static inline int parity8(u8 val)
+{
+	/*
+	 * One explanation of this algorithm:
+	 * https://funloop.org/codex/problem/parity/README.html
+	 */
+	val ^=3D val >> 4;
+	return (0x6996 >> (val & 0xf)) & 1;
+}
+
 /**
  * __ffs64 - find first set bit in a 64 bit word
  * @word: The 64 bit word
--=20
2.43.0


