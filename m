Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3290CA0EFC
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:05:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.32])
 by mx.groups.io with SMTP id smtpd.web10.942.1755705924351286346
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:05:24 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=TCdC21Rn;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.32, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8PTD6eKEQJCalK5+pcHUaZgbj+pl3Za/p8ep3o7EHQu0f+sw/N4NvZbg3GgivpwiOa/bmwm6NS7IpRHnElV9NQViX5AM9Ee9UjxQ9W3eVeOyMyUgs1i9xAk56O1Q14IvwJ8zMaFw+elsZUZ/DCkJxR3ySn/vtFZMDdms47UDrOzH0cZ6DnStBFdzKAyejZYDi2ujRgSdoGFA0laUnlshWfHupshjJRDAYlJwKwVs1/tTAeFLT0vKuJ8kwr2xi6rkvd0tryVpHWCwtixk9/3a9DRQ+YvUwuGIejhQKh1l/N4vEE7XUMRKg1PkIQtXJ2oix4u1KxbDDoVuYlvv9vncw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKxq4XSTqEwkD/pjqMzk4Y3zppMFltJH3W4oyJNuDYs=;
 b=vOJUPmS+WJzCExYobnVTIErcm/ot2v4sOLvSYToG6ADnkmRxT65pArLYI42BH9S7HaB6C7smbA4h7qg2hhh3FveivlJwNJgeE5fLR0s8NHg/6t5pOB1xWtJW7X0dSQTI1QEfqb3Prd8TY//EqamTtNyxYHisbunRxRN01IdgFwErUopPFZT2YufxxRCbEP11B1MmPCaAWoYMBPBMrMwbfwB0/PUO5ik8nc7JwHbR3Wn51lC6nN16GC67qvfLk9NxWLJ0BGb8fXVMlzVyJMk00F5Zpf2q4Cd9DrCclVb3uttyEPqAm6zSSQ0LscqWDb8eCX+0sex4d1LKwydfeOi/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKxq4XSTqEwkD/pjqMzk4Y3zppMFltJH3W4oyJNuDYs=;
 b=TCdC21Rn+2UctOuxzevbNCHviRrhxwK2ltUf+HX23+MY23AwJkKJcTgGOuuG2pVEkbtEjoi1iv1BywVbN+xafPEICLeCYigYgx9qMv+Ljlob4J9dRPZUyat7pmkKoDq4HQ6xJuTx8jBVVufFr6WxADhojxIUoFz7SARr5eOqaFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:05:20 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:05:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/55] media: rzg2l-cru: Simplify configuring input format for image processing
Date: Wed, 20 Aug 2025 18:03:32 +0200
Message-ID: <20250820160413.801341-17-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a4aafc14-e668-4f20-6016-08dde0035cf4
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oon0VSkgi56fRV94244RSQ4427qnAtX2idlWSTiyVBzBnHVIaG6gAsxBVfqt?=
 =?us-ascii?Q?exweudgNnS3sCjB3hDeeCgl6mYMI3CO21CGELHbjXrcn+qvLJemvFJJQIw+a?=
 =?us-ascii?Q?07hRqvUmDRgy/je91Vl3/lYlsBdVwyMT8YmPb7Hzrpi/AznAj+2M403A5lOA?=
 =?us-ascii?Q?OJgKp99PBgAf7koFLNKIkI/xew6ndaHd+CVWfCqsIXzvQJgtTm8ntUWFkMiP?=
 =?us-ascii?Q?Nl7s584QjykiJfpED//ja7BRFfZ0xOOOlmXXBrtAPVlHoeN2iRbu+IcQ26j7?=
 =?us-ascii?Q?ZXd2Pph9la34R7gLz6VEeh7gwbbH3/anGdVwjbSfQAfZrMSmeKnEz6ab7EWE?=
 =?us-ascii?Q?NXUJBy9lkfO3+luUNem3mMsRFYpV3MEr8ua99RosBVe7GCYo5cA8xBeVi//X?=
 =?us-ascii?Q?Rcnin14pFfBUY+aiyiKoy1OK0fFoNGdOtVyRNuewHQgI0UV+azCQSsCF5oJM?=
 =?us-ascii?Q?moj1uITGkZzYZ3DJHtd18ia+HSAYfA4sY14qpxjmRLcjqc7wJBcc1R1nH/Au?=
 =?us-ascii?Q?TbdBV2JAfpi3JYOVBXvUDwsk21vwpWJ90sCgcEsCqUgCb1JOOQXbtOYd38pI?=
 =?us-ascii?Q?kegvuKtKstCxG3lEn+G9aG62wMs6xlBGJINTTaK+X3YQ3H/JhkOHNRcXJIx1?=
 =?us-ascii?Q?3p+qlBqU4Jn/DNyRMwEQ71dunkWGBo9iCMCUgNBs4ffZzSeeUEi1DwqvNM0w?=
 =?us-ascii?Q?Ih5zi1NRgOWNOMqn1Z4R3UHkXBg80Flm5bBUqQBGNTSRlWISPQ0Z0CU/j6yN?=
 =?us-ascii?Q?3AeywKA6KcZh3QylHqnNl0V4uwRuZR2ifoRwgwldKyRw70N54qzLamQPJaW2?=
 =?us-ascii?Q?7khJn0MSoLae4RisVYZlHJdWRq18uxyY/8Vzz+AKQ2lnq4UbNA0epOl7dfj1?=
 =?us-ascii?Q?6jARYghTzhaBby7kJTWhtSVq9LU9wUEFFhtzgeMtv5O+bdiSE04UsHD72zAM?=
 =?us-ascii?Q?Uhh7BGnqwuA50ERb2OoXSyE8ntfsitY13eU2PuyhO7pb/dnegPIl3lbaKx9O?=
 =?us-ascii?Q?rjfjvbgSb7sPvcp8sLygeyQl3gpgFKQzInvJmlUV318QSfjgJ7HuCUGCmdRH?=
 =?us-ascii?Q?vQAaykLfkM9OLA8PfR7hrC0tPmhNB/TKJJ75y1vEDDzc5OWGiZ1TWHj8P6OH?=
 =?us-ascii?Q?8yQRjQTgAKhmlF/zXxCU2pe9ks0Zv2ndpHu8LIOUkKjLYzuJD/I17A3Wrkpc?=
 =?us-ascii?Q?ubghNm+lqqaO0qJjoetau7fnNTmkNh6uo7essYwPhT1+WmX9z4yg9tGVMGGI?=
 =?us-ascii?Q?JoUNO+ZGefTyQfP3kn7bxSf8b3DryPhQscaW8FwS8ghZB9Z7ImwwF0gYfK1J?=
 =?us-ascii?Q?T+/XQHYW86+3EWC+KDSQ30phvqIRL40Q3oLc6QpCYgVBauYEI4j4uCQyBd/2?=
 =?us-ascii?Q?SQoLFn3qYRgw3R7dUUzHKiV2IYuwM4kpv8fyCYunCT+PWT4SP4TTNeqpG1mk?=
 =?us-ascii?Q?2L2eIimmhTX8cnId7NaoKC2RyVLD1p7exTXKw/biZz/d/kiRQNVRGw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UUaUiJwEsn9Vx7Jifdiz/tSjmlyaB+oDUy00tzUwKsXqr31dcUGJemOJB0Gh?=
 =?us-ascii?Q?vhUSyWDu++0CC+abpwZWs03C7AtMacG5ZgKaWF5rhu9AXLZ06LJ/WfO57ZJ5?=
 =?us-ascii?Q?N2rcaGLQUC3AWCEb3Iwv7BaUEObMmbwSF6BkNYaWwrg5D5aU3B3piXbw+cmv?=
 =?us-ascii?Q?kwSllcCTA6MrMEuyhtN3v6EvSNlFF4NfzsAHi/p+ua1dO7pXY6cLqZJoAfZ7?=
 =?us-ascii?Q?fqnnxlMJAz93wZtO15pLbR3caUz9r4SAikeg3t57B68hJgRX6ymB39NzWlCs?=
 =?us-ascii?Q?dkjjnU5dVvxU45lAFVnOjljrLquHQ0NZtYbtWO9ZA8oITxCNZA7tMn/FPPtV?=
 =?us-ascii?Q?g0qzBfyNI+YNFXfOPcbynqsuLW1I5XVuxveUltF3Qp2cX9+7IzMHkPKgZHXk?=
 =?us-ascii?Q?p4miC8qc74kYIk8O8WreBsRnlMrImGEFYocPch1L8m2+2Ivam3j6ILgOzTnp?=
 =?us-ascii?Q?8T8/0+8OUIW2vUt6/L4rEZEjdLpC6d40Trurlz9+vA59z4+rBH/uVkeFCuGo?=
 =?us-ascii?Q?t61hCGGJUkihMG4yPTB0/V7jxJ7UQhKDKvcKc/63Duew1PH+iUdSpS0ZTNfK?=
 =?us-ascii?Q?pFF4jnG06dDZv4T7j1CVtpwkLatvkCzQGP/YV6RPKT8rymuEh1Y98BSm5v7m?=
 =?us-ascii?Q?1m/Xt8LfiEXZ1fkrCmrkXH5XrvPxR4uABD2LXUM+8rX3tvS1op0/1xXNtHpp?=
 =?us-ascii?Q?HktVXh/6I1D089+DeCGyScNw8KhAaUtbCkoUouHicFDt6UR6AuGboUdSmTm7?=
 =?us-ascii?Q?oI3r9PUBptw5+ts01Tp2qWVqi1m5g/a4N/6x3cxbNft475c4StjP0jPyBKz5?=
 =?us-ascii?Q?HlHclq8LzD1gsfzKQ4b5vNvtK+wL0uvdQYMxyoJd2WXxJ050So7pKd6Ha0SB?=
 =?us-ascii?Q?50dcx4qycMpeVk6j2B1brqhMglBmY27eSi9mOyqX+2o7e/tidazdsxYIW2q/?=
 =?us-ascii?Q?rEAUb/jf9NkI1S26YDqICH9JwY4aEahAlqxEREQRvfcUjovHjCfmjmkPG8Xb?=
 =?us-ascii?Q?46Ex+aVKj6rw+zHNFtxIHWHxeX0fg6kjo3U7VToCIbHcSXeiej8JsePaLhkL?=
 =?us-ascii?Q?SiwpLSRluT8nvA1wQ77LPgMc5wyAlV45loTExGDbQRG/sDJ/G8LTp8XNAHUP?=
 =?us-ascii?Q?BKwBwTETAPSL060keWL3jSvZDWRGolCunAjTU3plNH/nJui4bvagEFmJhDmV?=
 =?us-ascii?Q?g3leiF6HyYO+wSzbYor+lpgZmgnNkwqTG4hCAqUq/6Mp+efutYuXa+T/fMQK?=
 =?us-ascii?Q?f7A9TmVHbAYuMMNLbpvIehRBfHtVKTFIKAOCU/ygWQuuVXCdYiNSPDaIze8A?=
 =?us-ascii?Q?eSeDa7U7LnEdmymQXkbszPXs71Wu9G5+ONPMb8k65qJmydJnUk+IjFL+U2yi?=
 =?us-ascii?Q?RScNqLaxmmYPFY7kURlyzn0YhtbS1Q/NalirdseNglyLLIgATD9VOhHkY980?=
 =?us-ascii?Q?sgJbk0jo9uXAN0PwufzPGS1BjxpBB7TGEmwQbdW9CyKShiEFCEIwvB73hCcR?=
 =?us-ascii?Q?xEa5dig2mCphyrMilIE74HWKEeyjajgpOhSHZp/jTgMb/c12xyEfhWS301Eq?=
 =?us-ascii?Q?3dKgpmMr/v9ubSRiDArZvh9u1rzBZN7Bh1kDP4lDu5KlhQcDvC2htgH+mBmz?=
 =?us-ascii?Q?TS5Ydde9UFIY52myS7PQGnc=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4aafc14-e668-4f20-6016-08dde0035cf4
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:05:20.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f7KUOlzdiYkxxJEzUkx3oeKETlDRMDUz0LlamNPCJrrfSd95BpTlZ5JJHQOFMEBvrxikRc+57yieFgmXPi+TzD9oJSx+rfBvdHO2LvOpBRWZzA0qY/F9e3SdYFhp4a6k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:05:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19840

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit b56dccafda941dba44b02fa3b41b95feacaff9f3 upstream.

Move the `rzg2l_cru_ip_format` struct to `rzg2l-cru.h` for better
accessibility and add a `datatype` member to it, allowing the
configuration of the ICnMC register based on the MIPI CSI2 data type.

Also, move the `rzg2l_cru_ip_code_to_fmt()` function to `rzg2l-cru.h`
to streamline format lookup and make it more accessible across the
driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Link: https://lore.kernel.org/r/20241018133446.223516-12-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h    | 12 ++++++++++++
 drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c | 13 +++++++------
 .../media/platform/renesas/rzg2l-cru/rzg2l-video.c  | 13 +++++++------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h b/drivers=
/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
index 24b36097e0ca..1637366e666b 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru.h
@@ -62,6 +62,16 @@ struct rzg2l_cru_ip {
 	struct v4l2_subdev *remote;
 };
=20
+/**
+ * struct rzg2l_cru_ip_format - CRU IP format
+ * @code: Media bus code
+ * @datatype: MIPI CSI2 data type
+ */
+struct rzg2l_cru_ip_format {
+	u32 code;
+	u32 datatype;
+};
+
 /**
  * struct rzg2l_cru_dev - Renesas CRU device structure
  * @dev:		(OF) device
@@ -150,4 +160,6 @@ int rzg2l_cru_ip_subdev_register(struct rzg2l_cru_dev *=
cru);
 void rzg2l_cru_ip_subdev_unregister(struct rzg2l_cru_dev *cru);
 struct v4l2_mbus_framefmt *rzg2l_cru_ip_get_src_fmt(struct rzg2l_cru_dev *=
cru);
=20
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de);
+
 #endif
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c b/drivers/=
media/platform/renesas/rzg2l-cru/rzg2l-ip.c
index 800e6258e627..a85852c926d5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-ip.c
@@ -6,17 +6,18 @@
  */
=20
 #include <linux/delay.h>
-#include "rzg2l-cru.h"
+#include <media/mipi-csi2.h>
=20
-struct rzg2l_cru_ip_format {
-	u32 code;
-};
+#include "rzg2l-cru.h"
=20
 static const struct rzg2l_cru_ip_format rzg2l_cru_ip_formats[] =3D {
-	{ .code =3D MEDIA_BUS_FMT_UYVY8_1X16, },
+	{
+		.code =3D MEDIA_BUS_FMT_UYVY8_1X16,
+		.datatype =3D MIPI_CSI2_DT_YUV422_8B,
+	},
 };
=20
-static const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned=
 int code)
+const struct rzg2l_cru_ip_format *rzg2l_cru_ip_code_to_fmt(unsigned int co=
de)
 {
 	unsigned int i;
=20
diff --git a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c b/drive=
rs/media/platform/renesas/rzg2l-cru/rzg2l-video.c
index 4498c0ed7773..0e19f9223ab5 100644
--- a/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
+++ b/drivers/media/platform/renesas/rzg2l-cru/rzg2l-video.c
@@ -301,18 +301,17 @@ static void rzg2l_cru_initialize_axi(struct rzg2l_cru=
_dev *cru)
 }
=20
 static void rzg2l_cru_csi2_setup(struct rzg2l_cru_dev *cru, bool *input_is=
_yuv,
-				 struct v4l2_mbus_framefmt *ip_sd_fmt, u8 csi_vc)
+				 const struct rzg2l_cru_ip_format *ip_fmt,
+				 u8 csi_vc)
 {
-	u32 icnmc;
+	u32 icnmc =3D ICnMC_INF(ip_fmt->datatype);
=20
-	switch (ip_sd_fmt->code) {
+	switch (ip_fmt->code) {
 	case MEDIA_BUS_FMT_UYVY8_1X16:
-		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_YUV422_8B);
 		*input_is_yuv =3D true;
 		break;
 	default:
 		*input_is_yuv =3D false;
-		icnmc =3D ICnMC_INF(MIPI_CSI2_DT_USER_DEFINED(0));
 		break;
 	}
=20
@@ -328,11 +327,13 @@ static int rzg2l_cru_initialize_image_conv(struct rzg=
2l_cru_dev *cru,
 					   struct v4l2_mbus_framefmt *ip_sd_fmt,
 					   u8 csi_vc)
 {
+	const struct rzg2l_cru_ip_format *cru_ip_fmt;
 	bool output_is_yuv =3D false;
 	bool input_is_yuv =3D false;
 	u32 icndmr;
=20
-	rzg2l_cru_csi2_setup(cru, &input_is_yuv, ip_sd_fmt, csi_vc);
+	cru_ip_fmt =3D rzg2l_cru_ip_code_to_fmt(ip_sd_fmt->code);
+	rzg2l_cru_csi2_setup(cru, &input_is_yuv, cru_ip_fmt, csi_vc);
=20
 	/* Output format */
 	switch (cru->format.pixelformat) {
--=20
2.43.0


