Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D94CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:06:43 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.web10.1001.1755705999945957980
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:06:40 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OIR1ne6o;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.7, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UmkfPdacB26VRhEM+FfFvCLTgrwyk8a87TSlg94nsNfzHaE7hJQHBvE257M1zuOfPySdDQYMmxO/AXD0fGOrDkC7qBcSubnKacQRpcJKJ2oFHPD0X5seJZ98wWQf7179FIL2as27B/F1YSHjRLSRjWl3fE6YmjQkfWtc1pSSINqHfWLVXhmsmoNAxwUq2IF0swTeTNb1FF12t177J17/YUYrTRHCK2QWGgm4cM786e/iyzvkFn5/wY+tGy/S/CxO6UNWs09/LGkDz0ql8Br4q4BbMXdhhsGxQnXZhFKveUPlLJRFg8heG/+QEEW8xXET4QNvJDDBELk00QmOOtteSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qoDpr5rdXqzCn04LLBNakL2w2/hF3+d6OHvhSep7PY0=;
 b=wM2TJcOhop5psvZ/zg3T6nn33gRVjK0fhQHUHIaWC7Ffw5eYwG5fkDgExYQ3aGTne3X+ET5HaI6cW8a+iBQivb6neioyvSzo64dYViI4bJnrwbZ64TgA59W6v5uqqSLJRxP3zmVW5igv+YUFCEbpEbPDW5q5ZPLueuWNi13TkgpjnFIF/6c7IppEZBG2OANqPoEYvSd42D5YQSUCAL+YVuhaqMnlVrILzKVbwjneY4hT1TUzt77RhcAttF0Mvk617snOoAtCEys3UuPcVFx0tNlGnG/XagZWuqOA/0gZ1kLIm/L2B+wq1FnZQUvmG6+0+Q1mtmoxtTbDHyF7NtSreQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qoDpr5rdXqzCn04LLBNakL2w2/hF3+d6OHvhSep7PY0=;
 b=OIR1ne6oQ14YcrXuvYs45f8eEbeRnsYGSj38Tqp6CnBMTki+01x3WwA5N27iJA9eqVtERMY3Ib/aDMnhn/4uigB623ln8G88ln9DK8JB8osyIgzfx5vwgX0Rc1ShEiF2toLWio8JISHDoU44jjhzFILZvFClYdUonC10pzjpiJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:06:38 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:06:38 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 47/55] arm64: dts: renesas: renesas-smarc2: Enable I2C0 node
Date: Wed, 20 Aug 2025 18:04:03 +0200
Message-ID: <20250820160413.801341-48-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 07017c55-f5c1-435d-e8e8-08dde0038ae1
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HYk02VKuE8l9g+KWgfwwcaAipUx75nmpXcnyysvEE02aitzbKxSwcTsJtS8w?=
 =?us-ascii?Q?Pe3VsCZxtKPM+iBoOPAcCcRb8mTH5AdMpXOtV52FBji+BBoedT3p18UEzclH?=
 =?us-ascii?Q?wCEqOsPdAudvzS2noFkv4a6c6MkKHQPTO2zMeXI3CfgbZ2n98CIplcGohkCe?=
 =?us-ascii?Q?kNeWn8gW0Jhve5QLd9hj2SITSNu9goNLHYe4NEoAfmRUMEADilRJ/xLPTiiZ?=
 =?us-ascii?Q?j8mrwzMgvnoXDLtwl1DfMxdXo/d8BKHcdXA0pP5ydz3TehrVhkJnVoalXzJt?=
 =?us-ascii?Q?5NgD9bcWQ1o2j/K7eBkCyHWd3HG5J6elJ+qUnkXCbBJMEJGtfLh9xC9f8/9h?=
 =?us-ascii?Q?5J88/sBziENd+TiPwBC0Ee0d4qM1sHDoYSczyEuT2/dLU1+s1cPSo21+R5Qh?=
 =?us-ascii?Q?nCexHKXsA5+pkHR1552HQ+Bxq/aDxE2M9tQeeLFnir8MC+PIPeNzYVI6fny7?=
 =?us-ascii?Q?KOSz9fJxw3/eTCZ6pmcia5RJg/fHqcFRdoL3kNcgpl2C/SixMiOwkqKoD1h7?=
 =?us-ascii?Q?+OUE4F81X5777Y0/WJLMmtth6rD0fMiqyUoQ7iDbVe9YBAxN+4lbQZFGG1Sh?=
 =?us-ascii?Q?hBj5CZrhvXPphOXMoAU9HsBl2jsz6DiMweyu6cDbFGMAb+myhH96DX6AWJNs?=
 =?us-ascii?Q?k4dKJTXEq0JXuKfUqDJwFX8LO7ReDJCXVy2cOtNBzoWcW4cvz3/R46asE4uv?=
 =?us-ascii?Q?XS76tpPuTdQp14Yz7g6caSVWybwUNMfzasknknMJGboGN1lf3dihrxSgOkn3?=
 =?us-ascii?Q?BSfqzBd2Sm0XxO4J8lxvIJP23QtZMoO4seZR9cXvKLPQoCjKCydQPzqfS/5r?=
 =?us-ascii?Q?U8/LyLm+Qszacip7eHVHuB7kqsxoDk+EpGiZ2NU6gYshm/1bbNVbK7pdwAwx?=
 =?us-ascii?Q?UXDUVpNPKtA9y6mRioXVwzqB/4roP2pEEURRBweXMj/XK6LKL7FnDwn8lZDU?=
 =?us-ascii?Q?6T9YGH46YjwiKyww666Ats0aZIBAtYo2v3eXpUxHO/dwVIPDliG8wYdusYvO?=
 =?us-ascii?Q?GdMO5786qtwgsysHz5o74laNNwLZxkya/F32nV7fM5nXdRC53G0BGRwNFGOU?=
 =?us-ascii?Q?DWbuTvXAQomxTppEriG7Z+kV09a8QrFNfjH7/TYG9eNOf8gOV7uExeCUFKQb?=
 =?us-ascii?Q?NRyjsTqI0aRtkEiiwFQ8ENsCgKVeNOpp4/S17XY8U5sK093Zbv1QRuxIDcre?=
 =?us-ascii?Q?fIx4c3N0Rlz2ZfJUiO2SYLaRzjjyhazwEI04ExAFAWnk4r/dpT56kjPAZ4e2?=
 =?us-ascii?Q?TJEDAOphUoYXtepF/zh+CwwX4tf4NecPsCpLA3ORUrCoEF3d+PZTbcDXeKug?=
 =?us-ascii?Q?trIrDRIO78wuXS0Y/d5V7yjlCUmbpwukjAKTTuLh40hedGwHmrWNnE86nr1q?=
 =?us-ascii?Q?cWnQN4GcRwgFh3uotSKsf7IQGj6/qJ6Fi0sNEssoOQ/rMo04PsPnXwAuGANo?=
 =?us-ascii?Q?vaDSOvDunkqEgp/XS/8v6fTyeFPPBgWB7l+Xi5iSCog2M7d6IjuSY+AwSX99?=
 =?us-ascii?Q?COh1Q6qzvAH559A=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cuobaN7J4y5hc8EGmRR65XjXKsjnSYfcIeegNaYdGXW8fbciM/qXSVC3mfhM?=
 =?us-ascii?Q?yLeIyRb/f0ZnlHRj+D73drrzaMzasfCTj26DoJcb6WCpprJLfk4dd5GyIl29?=
 =?us-ascii?Q?Xr4Fin+yLnWbYYLxmima5WVZwclqdD4WwSHz48XPA+kkZeLYnesIEh/zOVmh?=
 =?us-ascii?Q?2c5WzPP3CsUsEKYiNVbrmfbelAe50VQBcCZaH41c6NALif6EuzwK2GVYpWyR?=
 =?us-ascii?Q?MZZSr8B//YDoDCeUumrvMN7L6QcNsHsF9T30ts7Ve2stiTf3t07i5Gc15q/c?=
 =?us-ascii?Q?TeT/RHf9D6DBqCB4zd3FpWfa2eEjvosUBHi97tjYSma0Dv9m0VRgirnEsOBT?=
 =?us-ascii?Q?gjNxQKEWxe9piylA6p9LL4CMI9s5QgWnlkoKO2I9YJvuhxY5Sj+07x0aGvrJ?=
 =?us-ascii?Q?cWmi1VzBgf+0v/A3UqqCtY1YeuqiI9f5qBRUXTE+b012DB+JfEClC5o5yDTM?=
 =?us-ascii?Q?/Rl2ziI9Cmy2n4UxolWthBt0kee/eY7T+DtHtO1n+DCyrECzA3DFkX14j5KB?=
 =?us-ascii?Q?X2r23UVdiyxbGP+/DBh6Y2SKX4hAmCo1gjPPWJ5jeQH3HMvy2W/ysho2YYTh?=
 =?us-ascii?Q?sHS0J86q1ArsX6Odw95wLugwQ/vuLPLziPRIyptzvWv+6XZEAy8SyjwT/zdf?=
 =?us-ascii?Q?h+TQ7iwVYTQuk407KR+mO/zQOC2D42bMr9jSlTXpzT8dfgh2XbP18mgOjwfl?=
 =?us-ascii?Q?VddtD99Jdr2ELV4p4iQ60aDW+GIvbxvoMtAnRwtu0PvvkeYa6saJ2Y2B7OMO?=
 =?us-ascii?Q?WxYpK02q3a3dmn4ua+mPvQHV76U6Uzz0b76IwDQrY1oYfFTq5EiJzFiPsJ58?=
 =?us-ascii?Q?6B6Y9qjjpl9LbQKfFpmMdRikS8JaYO4jZLicBSW7iq2s8Jo3MpnNZ7wDoZ7a?=
 =?us-ascii?Q?EgCQEEiSSUZQJ/SvnPVYgQQTfzPnCUFvtwCciM+dVNXN4ESNm2y8bkMfMMp0?=
 =?us-ascii?Q?fdDe5OpVF/lqBT8Olc2t/v6HglcUNCcA0Fwm/26Yy7c54i0zgVxEG9s7oQnO?=
 =?us-ascii?Q?wNwglP+LZ2sKzMByCipuLBw1wVN6wYExADyFwXeTfyWXqnltjkOYDhykpvvV?=
 =?us-ascii?Q?gPaKyUxOzVyMiPLzierhbrYlApXx+K3qSwfJ6sffjXFmXCpKurY5N1AMQ8Zw?=
 =?us-ascii?Q?Dr6zHDUurXW5gU+jx3fPjBkJW2lWgQlOeWbe7o1shYgp6iaXoQBa9/cMNIpW?=
 =?us-ascii?Q?k6UAGAEyGaKWoHFv9Pls7wbxr1AjONKDCI8pqXHzRgs9+i/xdaawrv6T3mPh?=
 =?us-ascii?Q?0FdQyZJKQqDyhToCIt52sytYnxuYo6h//WkGxS0WAjJySzjgsV8Ln1TuaJ2R?=
 =?us-ascii?Q?MD56+7WI5EDJXbf7vuf9LxkzybQQpArlP0/N0tevd/Bb3l4e2KBlkBZrF0M4?=
 =?us-ascii?Q?q4vmIngjE0U68pJDzzghr8BFSKmZWY1s4TpVB+G0Qc8XC35sdkKPllpHZyzO?=
 =?us-ascii?Q?cpbKQu3OwtTWId/EoxfcAxM1SBoZhHQIeqMw1IP6GiOUo7/C901ndGj2he+Y?=
 =?us-ascii?Q?4rWF2KeI/7miDBdFP40UnvaSNCmzytiupZvMw9ql1Q4dTgVJZug25JpT/ULv?=
 =?us-ascii?Q?4hMreJVGuAKAqI96i7LkY6ZTfrzTqF3VKkBcsvqUVHWJvREoLA2v87TjHvFi?=
 =?us-ascii?Q?JcdZSGRpxQWhAOZkvMrKFiY=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07017c55-f5c1-435d-e8e8-08dde0038ae1
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:06:37.9677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X4qOcllfpeGaNvMgvGvWOuM8fT3hSWEeWM3U0rctIuXccIXNTXSc80b9Mxe6y8dQyoPz1+ry1NUVE8YhK8+8AP9jIKJrsDjAcJfGqv4lUUUUq/wVC9mk25cqZpwWRsgE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:06:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19872

commit 0acdad4097dbd166d5b12a94e2b58bf4cd5e9ac2 upstream.

Enable device I2C0 node for the RZ SMARC Carrier-II Board and set clock
frequency to 400kHz.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/20250514162422.910114-4-tommaso.merciai.xr@bp=
.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi b/arch/arm64/b=
oot/dts/renesas/renesas-smarc2.dtsi
index afdc1940e24a..3cac292f20b3 100644
--- a/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
+++ b/arch/arm64/boot/dts/renesas/renesas-smarc2.dtsi
@@ -35,6 +35,7 @@ chosen {
 	};
=20
 	aliases {
+		i2c0 =3D &i2c0;
 		serial3 =3D &scif0;
 		mmc1 =3D &sdhi1;
 	};
@@ -58,6 +59,11 @@ &canfd {
 	status =3D "okay";
 };
=20
+&i2c0 {
+	status =3D "okay";
+	clock-frequency =3D <400000>;
+};
+
 &scif0 {
 	status =3D "okay";
 };
--=20
2.43.0


