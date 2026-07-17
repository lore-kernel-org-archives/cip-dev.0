Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CDCC44520
	for <webhook@archiver.kernel.org>; Fri, 17 Jul 2026 13:13:29 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.26])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.13129.1784294002543212176
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Jul 2026 06:13:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=jWOCOrTp;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.26, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EPlgXRfBRNfkHIcszwaAvJxsUlfhApEslH5B0MA1E1LitgZ+plcwfvXGwUf0N2/+Hj+nDRS+eRAMIcv5zb1XZfmSKpz78jTF6//xevGZxny9VYgNhrzDPx5A4qeb7mGpWXwQHXEECzw8prWipfQZWi0TGaOnSkNajJme6HbA7E6QIM/61clz4qX3BEiuQQLdwoqkAz3Q1gOAYzbGMWt7p0uCEzF548cQG8/T9LIf30l8hUlfPGDX6PyTQWoxr95beKPDOh/BYk2IErjNrEqsvvt5xilMIU4e7jVNQ3SA1XnsGkv3UwVE3bTigcs83IntmlHHiCz1FeXFbpRZ3HUwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RsfO+zRtbvwSybULhutqJKCU4NpCb3KVQzgPQ1GsBqE=;
 b=fmseBydmIHxxSwUCHZ4MRxab6smwePqWCsUicHCZLYDHst+Ysol1MjlJxEzc7eL6cRpQ/HwVd8p0/MtJ86ZA68UXiQdTDSh/Vqvirl31uLk/uhea54uoq924oVUxLatuWm8e5T3fFIic/Gap5jKby82WNrx0qGnDIS67eo6fsSDTxZ+wOoIGYt9PAwDmOX4MiYFRghUytV2VQStK74C92DRNcX5LmAIcBdJXgB5Wc1+02Kcf9rtG48C++au3y8X0lns8b25u2Hk41IyVqN/JgUnm8mWI5LqNIgQWT9PyRHJrp2HE0SjRq2T4rzzrtb/TC8QhjWcciFlnFUyzqBO+wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RsfO+zRtbvwSybULhutqJKCU4NpCb3KVQzgPQ1GsBqE=;
 b=jWOCOrTpjXQgfP00ZJVG6pPBgzIHUINxgD3dyzcD+z/H1oqeUjzu7AriIcjcgI9xOuYxrnagaVWThUv30sG0NXUnSUwD2dby48VHgK4/jC0HzuBlz7HKBuzH2w8OtyA3+o7e/XRxezbTWIbIpx4+Dt7Gavs8wyUw+VN4hJoCeGY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com (2603:1096:405:18d::7)
 by TY7PR01MB13783.jpnprd01.prod.outlook.com (2603:1096:405:1fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 13:13:20 +0000
Received: from TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828]) by TYRPR01MB13588.jpnprd01.prod.outlook.com
 ([fe80::2f5b:8560:48ed:3828%4]) with mapi id 15.21.0223.011; Fri, 17 Jul 2026
 13:13:20 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 03/23] hwmon: (tmp108) Add NXP p3t1085 support
Date: Fri, 17 Jul 2026 15:12:21 +0200
Message-ID: <20260717131241.2233788-4-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
References: <20260717131241.2233788-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ad::6) To TYRPR01MB13588.jpnprd01.prod.outlook.com
 (2603:1096:405:18d::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYRPR01MB13588:EE_|TY7PR01MB13783:EE_
X-MS-Office365-Filtering-Correlation-Id: 0019d838-bd58-42d0-756f-08dee4052c63
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|23010399003|52116014|376014|38350700014|11063799006|56012099006|3023799007|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	imba2Uusl98wQLOeBS1AHdPoypygtR9WNgnFLsW8XyEMl+wIWFpWxfV+npvuWDiQv+FmV/pcqEcP8SMlK8BvVCNOWaCOWTg2C+lWw3sBTeyfenMdbFYWmo8T5MxxK467OnMqJB/kcMnbF4X+ibcjdCtaiDgfcFEj+WLCrGo54KDWcX1sMbShj42LIMHxRmBvL7ag+j+jhI8GsDG0EF16wSj2mN4wzguy3XAkRpy1gxSmXrEEnzyllBU3RRxI4hiW9IAfPzVsbzv708oyiKqfje7tRFALEDkrJ2WVt6Yz+iRhJ8SWuq3QpTS5gcHjAGQpIF5Y5iYX1WHWEMlZ0OoRbWyP6j7gOeGuF1z+B7mvG9uXXpgXlphmuWT5CFH1YGYDFM5J3F4TAqF6D/ULXz5lNthuX/T+KHkDCjMt2GKKwsJz534iLmdfkPV49Nn191G9pm4qDOPkgvD9+wOqn+i183PIEPQvrzRy3NcKXjzaxMJBNInQZiOiF9y/EgdyDwYVUj05XNcNtHmeKsFGQBLcb1VXrP/1Fv/3mVYduUcYWs/KOZMe6hmE+Ta2lKofokhd0PJ5f43T6jP/SN/fxAfGvnzfA3Q8ImyLgh5Mexd4inXyYzkM/rDPzTlhnCbSEMCCwbKlDWNVN+GHR2WhuESoK8dOsW1RlnXtKlqfA+c4pMACIldRu+UDWqc/wRkMnTYpGKWfm9rusS2LXdehWAB0TmLALefaZtxGanq/53i0Om4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB13588.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(52116014)(376014)(38350700014)(11063799006)(56012099006)(3023799007)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?l+RCZXgFgcsX+NIQkwiMD1Mj8CVraYS9kPDPtgb4oAY+XqgpRTgyoULJdg7r?=
 =?us-ascii?Q?vzDSOkSJ6/HnzW+JVgWwP063Sa1oAyyThLpe6O44ygKGfhwugDoII+wWRRlq?=
 =?us-ascii?Q?LHrlC5yESoFFLtx4ERKqFAPOMpl30GaNGjiHxAfj8UE60HbVp9IspaCEdK2n?=
 =?us-ascii?Q?unYp/CDLjMlD5fhnb/d7DVQKRU0Jj1EIyrnHfH4hF4fWDrwwycwjJJjlEapv?=
 =?us-ascii?Q?PS831QKCGEFUzbcpX/THMr0SMM8+SXL7AqK1sVv/0xj3gw/o443gDo+wG+4m?=
 =?us-ascii?Q?swz1yFt/C83S9sh1Lyp5GIae1bKgBQgCr1H5OfHo5WOap4YGJhp2ylAnWMeV?=
 =?us-ascii?Q?4Z6TCVrrnusNclnxet6IxnIKJR+nRTvAsWHZU4CUHhMgyIdeSzs6voNsE0Qv?=
 =?us-ascii?Q?hZPEfxDFCnq+WXl0111pHTzh9AhYZZNR992BpYvaj9qlvrDazpM08hn1o5oj?=
 =?us-ascii?Q?+VvEBPgQGbT/i07lMQamwabapYrLZ9iyAmP6H+rENQszG50DnZd50iV1PlTN?=
 =?us-ascii?Q?dcfRcxEk2GmDphHvtN4iQ98ZkzihX3krCyfjDm61b/kR/FbNmfys4g6ROQER?=
 =?us-ascii?Q?HIFimL9LDOWg2WIvL366GSK55tWzDKPR8Nc5uZvj2k26HAAT5a1JBDjsVH9y?=
 =?us-ascii?Q?ORTEb1jh+l4fX2wYwrJzzB5qpdkr4jCJl4dm+Z268GVVqM+aE/Qc35mqzthE?=
 =?us-ascii?Q?i6TdgLwvumoi+83UAgsQ2lLLC661JCDI7H9D+7c3LMpx2HKMucDs2uAoFS7j?=
 =?us-ascii?Q?pXuwWbWIDILY+iCdl1LFMkSvPKSDBXNfgQfM8uzgtEl43qjqSvwisXFYC2MF?=
 =?us-ascii?Q?4RnE/JHgnqtoEFFY8r4UnoPiruk0OoevquETw1RYsWqGJnNGqsH/HxpkQDpw?=
 =?us-ascii?Q?eTeVggNdY08onpC6bDaro32RNZJDT6RymAQPHe0DO1cCouzxGJRrqKaqJY+M?=
 =?us-ascii?Q?U2oFc6GP2lME+IydCXZKBRI5cm7tgqA7hjfMUGK9uuNDK9vhCEcrELqAxxfZ?=
 =?us-ascii?Q?j1LjIHxaIIDGjzQ+oaMmFuTAvynro+lRV7mVloyENku7ytBVU72WEWXaNEEm?=
 =?us-ascii?Q?AA2KQJjndKhyAGaDYfl/I3qvxlWgcavhh3fqGvEFlT5MJ8XuwxF0rvi9C9HR?=
 =?us-ascii?Q?PmQQRXmkWKIJu2WE4MnDwCpova1/HboZFlswy/+qSk9xn/jibS4tvZDMJU2e?=
 =?us-ascii?Q?v8bDSbw1fNDLOmgFsHfzGWy2EK1VTXlN9ocUEdigIotM//Z1HpJrRJU3dIMr?=
 =?us-ascii?Q?GQUYowrGtUc3FKUFONBVJbHuTJqkk4xvT7dNgSGjFMvtCdCCguOawQtp1ne2?=
 =?us-ascii?Q?QtJ99TZmJafXFPtPef14nomjjd/xyIzxPkBmjL7PUsTi3pqn8W5/keIgkYgM?=
 =?us-ascii?Q?fjOJODQTaXTrfKuwwRA0R5E1zor4RRGfG5U3RbJnKFDQ0oHxGTBSe5iZ0JbB?=
 =?us-ascii?Q?reAG7HaFtsq0vSg7/Jlyp+JCJd58FJSK3ezpxCEaRhCoToZVVvLSvRocg+cE?=
 =?us-ascii?Q?1/a5R86rHaGCO5GSLDNHm3NDdo/V0IMlb4WQS7QUGX+TdXf+mwnPitJEN2Aj?=
 =?us-ascii?Q?jWyG2+iTE7+uz1grI23gTX6kN8cGDI3HJvoiCvyp8DY7px+XUyxv9tAwxAg7?=
 =?us-ascii?Q?cODuT8afEeWH2ESulPRSVayarHeX21BbULMqXWx89Q+GzsUewxGKECZLny72?=
 =?us-ascii?Q?KQY7QuhGg09fGua0PsKdrxugCls100mIkXxHTrFh9nUd21byQ3vVSCFSGOoI?=
 =?us-ascii?Q?AxfMVk8pf3b3w49G7OfaU7bAuDouaynEwhDjhQfkSGMCH1Uw3CLL?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0019d838-bd58-42d0-756f-08dee4052c63
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB13588.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 13:13:20.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HVBh7P3WqiX5fXorRWY4wdA83LQPdfds8IdO1UQmfJfkx2dVnf+L3aE0OYtSwaQ85VHEy4076EEEqMeTgfLb4Vv0smxjY5txFJfluN8FT6z9Ik0HBK/czO54GxExuPaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13783
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Jul 2026 13:13:29 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23631

From: Frank Li <Frank.Li@nxp.com>

commit 11d35624d7696a64724160199fc94587010d7cb2 upstream.

Add compatible string 'nxp,p3t1085' since p3t1085's register layout is the
same as tmp108.

The p3t1085 supports I3C interface.

Update document tmp108.rst and Kconfig's help context.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Message-ID: <20241111-p3t1085-v3-2-bff511550aad@nxp.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 Documentation/hwmon/tmp108.rst | 8 ++++++++
 drivers/hwmon/Kconfig          | 2 +-
 drivers/hwmon/tmp108.c         | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/Documentation/hwmon/tmp108.rst b/Documentation/hwmon/tmp108.rs=
t
index 6df7cf1b42f4..bc4941d98268 100644
--- a/Documentation/hwmon/tmp108.rst
+++ b/Documentation/hwmon/tmp108.rst
@@ -3,6 +3,14 @@ Kernel driver tmp108
=20
 Supported chips:
=20
+  * NXP P3T1085
+
+    Prefix: 'p3t1085'
+
+    Addresses scanned: none
+
+    Datasheet: https://www.nxp.com/docs/en/data-sheet/P3T1085UK.pdf
+
   * Texas Instruments TMP108
=20
     Prefix: 'tmp108'
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 7884fcb95c3e..df7a0d3b59ce 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -2063,7 +2063,7 @@ config SENSORS_TMP108
 	select REGMAP_I2C
 	help
 	  If you say yes here you get support for Texas Instruments TMP108
-	  sensor chips.
+	  sensor chips and NXP P3T1085.
=20
 	  This driver can also be built as a module. If so, the module
 	  will be called tmp108.
diff --git a/drivers/hwmon/tmp108.c b/drivers/hwmon/tmp108.c
index acb4ba750b09..a8d9a4e00eb0 100644
--- a/drivers/hwmon/tmp108.c
+++ b/drivers/hwmon/tmp108.c
@@ -420,6 +420,7 @@ MODULE_DEVICE_TABLE(i2c, tmp108_i2c_ids);
=20
 #ifdef CONFIG_OF
 static const struct of_device_id tmp108_of_ids[] =3D {
+	{ .compatible =3D "nxp,p3t1085", },
 	{ .compatible =3D "ti,tmp108", },
 	{}
 };
--=20
2.54.0


