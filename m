Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E88AEC046B
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:17 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.10])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14370.1772529732365280893
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:14 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=qWXP0ytA;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.10, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixJPQhyURRaR06IL6VTxn7lskZk4H3p3GohYSws20cp53vw7EGKNFL3Mshh1XVofsZbi+2xk1GW2DB0dgLtwyVOhR9CYyG9uzT5wdXcqB7g9DHaOw8mGb38JP6lxAyN99FjBi/EO8TfolKPSkOtlyRXPXAdIwcbe6kA5t8Je7erWLGJ8VmWzRk/XdoVmcmDp0s+hbSZKK9cqiYDsrUJ73lw8JI3laiIM6sTdm9OvoQCmpIfuITYewQqmnvFYm/mcg2O3zbmP+ZCWZ+Spcm+a3H3XFIdO9fIVwusrAL2zOh5TDKiggEHQ5EQr+iWNNSpfN4wfshRjcRVzjVNTLrpGoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZdWn95kSQwpGeMPMciudXPJkm6EdV90VtgRzLJCHiI=;
 b=V7KtbzzVsd5kK/JTKqGaf2LGqxgW8PcoPF9JdjdRHaQ7DCjgPdkMR/EyHEQZL+S3X0vbU3LETY38QR+tg8sD5IrSO0SdqJmd5fm7BMN7k5FupN+4erKHR9XWYEumv7yjFl2CHPZphw4wVZgpgdF6p5pJyvBCW/4UqHR9s6qlfzArQPD9njQI123MXpi332gNxWsuQIOE6Z6ibN0EX78S/IYnZezhkch2FHk1yFdf7zB4WgM9I4cmCexgexIWNSSzd76oWXuJN6rxO7xeOerTEhA8iUbii6+YUKUl7iJ7od3rdmiD0El/G/2VQAe6cg8aX0r2y5xDYkK8fLU7v+3ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZdWn95kSQwpGeMPMciudXPJkm6EdV90VtgRzLJCHiI=;
 b=qWXP0ytALlgW2pLUM1TXm105QBTxQHwdKQ6sZY79yFJ2BJj4dIw8v3Fj6LSBIWnrBuh96KD+uC7VdhhVMGnczk5lT33XkIoCQBDKDebOTuBqhpquO7IP0jbZ6GQnU0Zb/kGvqXsGbRwUfwmhW7bN8tifF1egiEBInNr8qIRqYlw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS9PR01MB13190.jpnprd01.prod.outlook.com (2603:1096:604:30c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:11 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:11 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 1/9] arm64: dts: renesas: rzg3e-smarc-som: Enable I3C support
Date: Tue,  3 Mar 2026 10:21:32 +0100
Message-ID: <20260303092140.12732-2-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260303092140.12732-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0088.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::8) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS9PR01MB13190:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f1f2780-554c-46dc-e543-08de79065968
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	ElIcVuK5cmYKYH12PQ1Bb/M6JquIP5B4sgkZm5IoPsm+rWxSMumjOAkhl900uyzmjJxcXevQOT7D0918vt5M8ctvRnZkNuUh+7DvcVR1Eg2UVK/cpotPoVYJQdtlf/fOnCmfN+oYIAwAvAhIvJCYZTXP6kZtXsJsVHSuydgYWwdtp+v4AnYyg2fEhfrxbIPE2pDzBankcQGOkeJLDeGePOabvTEQ9hskGSWwsVppv1ehnCP9N43ZRFb9bDAJgTqmbIQ/PkmsQYst7sWdGzSKsbFgXHlq9Q7IS0XkZjyIMlUmnN6RpMY50kg4sq1EwDiP/4+sRugHHlXC3k2DBA/re4Q9jCks5aMm8l5lioIs6qLb2i2ZoV06VQBsosEptEoOx00x9lgA0PsV5DCRQ+JBt8/ulGKPCmq83oeoLASQveGr3k8B7C9DbV5rR2cmnExa6IDjdbyprxC4BYRTe/PdXLg+ONMLhTNKCtqpyMVc4wNL+GvsMeK9L7wTQQzJtjyMs6TEuMjIXzZ8SzdzPTLCHZTsMYReDPl99XEPQWGsoGvRS+Svc/C8lnVkA3go+KKqZrp7J12/n10IraAZJdO242M8AW7E+ZZ4u6vHG+iIQtGIY5tFBOYm1NbEN/fr2Gncaj3apV3CbrtsPWxbxILX+XULi9R7H1UEy0BW4cI/6lJG4DR9MRURhg9Wi069xdxubiBnPs0do9J+dL/X+bkZO9qp0jvIY7Wb+oxtslJB2jwnhniaJLX4XxSoXiBFU7fX
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Q0xexlV3lUwXc8JPC7bOE09Fa9uy1wmvwiL34qm73CgAYhyvARh1gRBmaLKL?=
 =?us-ascii?Q?pRjDwAKiPoUKvM+jmySRDLLXsd72XnpFfEOzNhsWDV7GGFa+0L9jhFWBXqZ7?=
 =?us-ascii?Q?8KMoTcrFgNtZlOl3/3HsEDNQfh9/DQPo5/0qPDt3YsyL7wzkqZ0TQDb0tCfr?=
 =?us-ascii?Q?eELx4FIiSKU7i980j8YLjPQ7ID3o1HFy4MC8ZdK0Mo0EfGpwLZhGRniQd4Dc?=
 =?us-ascii?Q?9NyMvGGHP9TZBmeUJsbFWPmhqanedB9qjitgpD0MWYFdOX/XjlbrHfXdTOnO?=
 =?us-ascii?Q?npnevpGTvri4pHa0Il46jUYzyhXOFv8ScmfCy2mR8X0Pd30d7tYi8+tr9u/x?=
 =?us-ascii?Q?v+WzbwQaQVtaKX9KZRUg4q1fkNaazat654QcjF4FKx9bE4pGxWR/IBx3lLRh?=
 =?us-ascii?Q?yUh/i/hrOSWJxyrRR9zl7mQCM+wz060/gUZX6P5dnF4qBrbXnXz7K1p4Hkeq?=
 =?us-ascii?Q?in4C5Ml34SUnqgV7osS9TIBx47WvfoZxcNiQxIUNkHK/DdS3qrvDnKDP6PyT?=
 =?us-ascii?Q?Yp0HJ0nKdSyt8QkKNAQm9BGCJ43fHFOz5YAWTq+aNu5lddG2BRoE8QbSbhRm?=
 =?us-ascii?Q?TbmUvW3KJBG8wOMcXMwvJxaVKwaKIRcn6hET3UsCZHhazHXXUPD8+hH0etKo?=
 =?us-ascii?Q?pHSzjI3QVopUqtkk9z2xrhWxX71kOwsddhTTgDb+fdwx8lCgNxaQGQUKDKnJ?=
 =?us-ascii?Q?gunHpw/xWNJAdPQs7/awIHtTBNJXJ1Lp70qIiEXEDHe0Jk2A4wUPkbKWBsaL?=
 =?us-ascii?Q?FfVai8JvjtJrE1EaCTCg+VXTHwWlbkAGjiXDwYsvL8PqsNjjexFJgBUJpuah?=
 =?us-ascii?Q?kx9SHsS3F84aIoKvZ3QiSOUtNj5OGv/+F6FHtKkgqZt7LVHTJifOzRCEnvgb?=
 =?us-ascii?Q?XtePUY0qjfLaGLtAtHjqfnXRBbuQ3LZIDwetklXYOD4y2yghNbb+KY209ejF?=
 =?us-ascii?Q?j4BRaLstqOLMGxC0mBJ+9ssLvsX3r8cbvlFIYoMhIlL+3nmo6YpfJJQHt9n0?=
 =?us-ascii?Q?7BigK0VWc02H5wI2old3tKNv9S0PyG/9p5GVBx9vfvnjJSQZ2nDwr3GVqbml?=
 =?us-ascii?Q?txpVfG4CuXDUxqxih3Ds72LHnYAY8nZGSwBqodTT7/xDYHH9JjPh0ZJqazmI?=
 =?us-ascii?Q?97U0vvJ4jdpl31M4g/qwYh/PCSTp+ezdCY29sowRoNLAZcQ9CJhvbNY3hiji?=
 =?us-ascii?Q?sO6B212AcmMy9CNwgm+k8RC9ZUWgKlizUoo5twxm13bpTzb43YwI6kxMRCek?=
 =?us-ascii?Q?NCHdl2nJQPcOXySNtpb8ls9Qt4KPticqsV0l0GXDwaXbRobXCbsVZh3UUWmX?=
 =?us-ascii?Q?LFeK4n9s6YQRCYhCvuagpPnuldSmSkbj4g9plPZPQd7MgaIhFgpXhnrxRnyM?=
 =?us-ascii?Q?NhWJ8SE0H32JJ9M7Sb4PvgsqmnqUD1vpRTAYgrhy/HPav+cVnyiDUxyZAJZR?=
 =?us-ascii?Q?ZM3gEf8Zc3n2YmmNitZWMOXyYXuC/saqwGI3o4PVgox/QUKXp3BoqAnuUl8l?=
 =?us-ascii?Q?HA4DVvizlzh3QefB4YK2HFNvj0S4cQeyi/VyWWPBGCe56Hz77ZdcvHyhygcN?=
 =?us-ascii?Q?s6Gljk2wcWdRV/oSAP+9MhCocv/dO8TuWJiMEwYiiGC5UncWse/R/Ctx7VE/?=
 =?us-ascii?Q?9S2VeGqe2qAQX2M7/GQm9XvGwTQ+1p258Icqto9XrWFSWz7zwEw1kkRsdZXx?=
 =?us-ascii?Q?Un7QIX+XxXBJF2w/ew8InUEe+FHihxz71I3/LR5SXCNhiWGC/n1bwrjgcGOz?=
 =?us-ascii?Q?HAeCT6oye1//dgFdw+0qheiHz33sxY/189iXkiNGlMTwvtlYP/0k?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1f2780-554c-46dc-e543-08de79065968
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:11.1387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpQiUpWpIOcb2Zv+ZzVv7TvupYNlElF9WXb8rJKvuB+usfziajv8F7L964bs0ibvCrd3hvGd+fLTGvY0sFeuFM11Q4vpXnAQd7VXfV70BVODo1zHaCnW31jD/+2qv7Sc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13190
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22042

commit 4ef81dcac8f6e08b29c359ab147dd87a488d178c upstream.

Enable I3C on RZ/G3E SMARC SoM.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/9d1cf2cdb1c11f24378404142e4c8aff680c6961.176=
3638659.git.tommaso.merciai.xr@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi b/arch/arm64/=
boot/dts/renesas/rzg3e-smarc-som.dtsi
index 7faa44510d98..f05b9fec05f0 100644
--- a/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3e-smarc-som.dtsi
@@ -122,6 +122,14 @@ raa215300: pmic@12 {
 	};
 };
=20
+&i3c {
+	pinctrl-0 =3D <&i3c_pins>;
+	pinctrl-names =3D "default";
+	i2c-scl-hz =3D <400000>;
+	i3c-scl-hz =3D <12500000>;
+	status =3D "okay";
+};
+
 &mdio0 {
 	phy0: ethernet-phy@7 {
 		compatible =3D "ethernet-phy-id0022.1640",
@@ -219,6 +227,12 @@ i2c2_pins: i2c {
 			 <RZG3E_PORT_PINMUX(3, 5, 1)>; /* SDA2 */
 	};
=20
+	i3c_pins: i3c {
+		pinmux =3D <RZG3E_PORT_PINMUX(2, 0, 2)>, /* I3C0_SCL */
+			 <RZG3E_PORT_PINMUX(2, 1, 2)>; /* I3C0_SDA */
+		drive-push-pull;
+	};
+
 	rtc_irq_pin: rtc-irq {
 		pins =3D "PS1";
 		bias-pull-up;
--=20
2.43.0


