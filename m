Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F4E3C7EE2A
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:48:52 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.65])
 by mx.groups.io with SMTP id smtpd.web10.423.1750690130688908500
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:48:51 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=I0HGLMN/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.65, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KGkpV3zWmejDdJLZPi6WT8a6DJgA4vH3j9DaL9GiWgxX8ICTh4IkDrp4IX8PVEvbw1c+OSKd257M6VgdFZeSev2D4YyOG8VrZluNRPdwpHHDJfie5hyNIYZs7Ip9LKJsR0Z/KZexus4jyf89pJBgVoHD2B931dQjwHX6d//VJKdBrjqocBANCFxk+ciutv10RK/NKtiSuD7Ti+VEfGY6GOK/gpS5/vIieF+JH/BWKZCMaHLC1bwHlgmgWxMpxuNdPfdX7zslOQGvfG1b85zSYy4wSRvb0yfscF8lJtqorqaFvAziE/q9uBBeNZie/Nj1ktEmWo1KtqE+/lB7IZCrlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrHiTxTGr3OmOatZ4TRjUXPi6CZcVNOP6yvwntV/4oE=;
 b=J6sM8ElbZw5hTSraKF7QgKw4jUVrZo7HxD3fowaQfGnOgpAwuBI+MOFuSwHATcNUDwOXEV6r9L53kOUelRnQvM4OR1CP6hVL0MO9YDxz3sth7dLr/4/OtVfa0Xy1jleHcqUvqblrebKOPlY0Ze3/p4d2Hl5CxPd7CzrJmbErvjGKXM/QS+ol/Fke2IwIQAtS5T9FDh8vwba9yDTaVpMCbkGhTCyF5GqMIHWM3v0RGU1Bx3FpYAoDyyub7zrr5afNcFPwlmc2Ugb1M6fqVuLWC7g43JsRcRSTPAwrPlKhPV3viEYB97uhDs1qjVYLaK21MtAiuPLmAAfZqaSzuIQjRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHiTxTGr3OmOatZ4TRjUXPi6CZcVNOP6yvwntV/4oE=;
 b=I0HGLMN/6N//8v94wYIYbXiuVpWG5uSnLXhrK4QFtDMAKhCj+KUEBoQB7F9pbyDmVa/FbuMs2dnReDuBy21k5R0TsD7H8cufMLq+NivcxqqOADhTi0VxApNuqI4XsCUSF4WcMW+ZqIrZetIyj0YKQKjLidTh5MlD0iDRal7i9i4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYAPR01MB5851.jpnprd01.prod.outlook.com (2603:1096:404:8057::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Mon, 23 Jun
 2025 14:48:47 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:48:47 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 04/10] mmc: renesas_sdhi: Add support for RZ/G3E SoC
Date: Mon, 23 Jun 2025 16:48:11 +0200
Message-ID: <20250623144817.2119838-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144817.2119838-1-tommaso.merciai.xr@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0422.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYAPR01MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbd1769-01fd-4e29-4300-08ddb2650f3f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?/nWhwhghPwv1meYw9LPrMwVCQnBkm1L28sKq9ncNKrFWYznnEoO3Vi38YIq/?=
 =?us-ascii?Q?unBY4bYn+M1i1O+UwQQ9QN2rLxY6Vtn03NVvW7sTwGJKS1ZqxXaw0oJwuKOv?=
 =?us-ascii?Q?jyDfERdIbOGSpOSIb76isAsYkyIl5ZhE+2CFNaglYPLWw0P1JG+ONbDU4QMx?=
 =?us-ascii?Q?nP5/N97MQcE2eC8LMKUXkHmYbkss5w1Hk8d+aAO+ObcOFB7jZYGVBX3GvycT?=
 =?us-ascii?Q?gHOqy20/1TbObfwcbuiaUOE8D4WYPiy0bg16n2yQAtVYHPBS666CktzpJHFL?=
 =?us-ascii?Q?lrunh5d0iwXmKznIl06U9xl7WN9v+W028F3mxdiFI9yo6fTr0sZFsXpKv9gj?=
 =?us-ascii?Q?+TXf5qaMylcZ64B3HXR0Ipfn2T9d7OtUU8JAT0XDaKYcb03q8v/pjyhyMwt0?=
 =?us-ascii?Q?7tg1OSDIayAAS2Hx+WpLqHm0vkIDGb6d/fzMKfap6+fljeG7/KBGaw1kXo25?=
 =?us-ascii?Q?w7rrioEXbr3lU9twHL2qQ4zBG62l7d4DOtYFHDItt1NukbGuGdoikcuWQKLu?=
 =?us-ascii?Q?r0eaCVgJScLVR9EuED6S7V8LE4EZ8Ni/+sjJMFh/MG1UoEliG6wnTnNVhxtG?=
 =?us-ascii?Q?n0eI/y6gIniVvJEC8cOJaiuioww7Pknkr/NALF2lEx6atAZ3UBeRqh+ar1ZW?=
 =?us-ascii?Q?g7ZGk004UuN6+jDM0+d/Ret3TeuyPoqvl7Ppmh1lHWGMVF+XjTKW9AyAwcnQ?=
 =?us-ascii?Q?7kTxRbB6F8E6a+NAvWlFwmobjDaP70pKd7N86aOenuiIcsP7snNCjmXsg/e8?=
 =?us-ascii?Q?MgDhnXMMt64CWuqPACBdEglxyNHPYfQKI33CGpTExUZwTS8jk1awb1C5Ywap?=
 =?us-ascii?Q?DJhqM0+51mSJLvis0CltLJo0/LU+TZGU4X6Lx25vxwovyAEyRWDBpOjp7Ea4?=
 =?us-ascii?Q?8kut0ouWYnTXpPn8Ku6nMztupkcmmeUCmVKO3yAjfMbx6U8KGqZIZiZqcVJx?=
 =?us-ascii?Q?f+qukRQ6Ghwo+6o85gkwHN/IeydU/ums8VkN0QTLwIdO4gmsm2NYZ1bPLqwi?=
 =?us-ascii?Q?hAexNMsWB/xzvSBPl+2qhB/ZE5xNRYuC19b04MElR4ueS5ERq6AacZaCyccz?=
 =?us-ascii?Q?2K3ChUs3pAhmaqYUJWXZ1QCXGeY37CFNmB17DJDJzy4QLKOaJfp+/NxMxTxa?=
 =?us-ascii?Q?SfUlrDhf5pOLDl2ZD95GXeLuIOKz3yXWlesPtVXOCZzqLFSydwxTR/lxftmC?=
 =?us-ascii?Q?f1uAcSC8qjh7ajW2eS/0JoShl4ZKq14+3EM2xVkS5DzlkBMeOsof/4lHi6fB?=
 =?us-ascii?Q?KBwM1h9N6xRjVM+5sJ6tPLPBb3PqqDKpC/aquTA0oNWopZFQI2CWcDhewedi?=
 =?us-ascii?Q?nijXTttEUb543AxGxDI+Yn6U62CGOwrrKV5m9bELkCWABMdMfr0khBQ7ADRC?=
 =?us-ascii?Q?U26BGIO9HNtPX2Od67ugWIGNB1AV7vI6NMj4YHFS4obACM7x/R4VWyqVz9vK?=
 =?us-ascii?Q?mWgGAthceo0+XJVUqy6iEIatlXBU32XIVG4+b2NQ3UkNb60u1ddCew=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9rHiXarh2x0vCu65/AjJCMT0jVrN6okiT5iReYKFdIisBGz+47OrpVHR6mtl?=
 =?us-ascii?Q?ofX9EtARXtTitpHTfui/18qx5nf6ewckIgydLz91yHIwLb97Z/JMXfSZKnLf?=
 =?us-ascii?Q?qn3/+ScvWLgUrbFhVYJyPrWJYJ6UsvnKN+R9FH0mqYyfpZElSP/3M06hdFH9?=
 =?us-ascii?Q?bwLOrHmVJ5Df/q5Uc7bzKcpWpS8+E+3r4lVM2rTsOz4OKSmYMQgS1xdX9DiG?=
 =?us-ascii?Q?ip9trOpEGEFQTM8v2VPvxs70cz9bdXczznZpkxgFPhdF1XEZYKoIoe1CWJLl?=
 =?us-ascii?Q?2aqDXhUjNeCR6q1JCKb2HOcPtlgIAA+NdkpE0+ezg6FEqhdEfiTO6VkqlGTD?=
 =?us-ascii?Q?wAZwD+7VRpzFwk+8OgzeR9PVqvFfykMb4iLN8zcnV38N0KSC9dmrjymAahBB?=
 =?us-ascii?Q?0fluirj4pRHAnGgdGrkQL6Z6EIHUf61cFtMhgtO5XxXe13PK2XKuReGSp01V?=
 =?us-ascii?Q?NrWQG+rxAXY1R8StuGV3SAusOLBIHIp876An5DKsKEZeahVvt9RG8+KHa1dR?=
 =?us-ascii?Q?NnnUO1DqjolhYr7j1cRxtBog9Vg2LMCpaY0H18IzFkdiuNejFE6NbSMsyBhA?=
 =?us-ascii?Q?evCecwCdwMZ08pGa25Bl37R/C0Y7STkH9BqGBq2ioErZ7KSQc2JqXxwb0zwq?=
 =?us-ascii?Q?IaYkjNVSoQJBfI8dVgOKXYcWNf5A9IPykEOJe2vnVqnBvfl9ZaRDIyC1kkwD?=
 =?us-ascii?Q?ums4bIrowgzuDWU5cnrUlANdYouyy7D11WBiARil3CabZ4yiO0J6FQ6oXr7W?=
 =?us-ascii?Q?/Jk1U1Lf8he2ua9nChz0eNjXazoYMd2oWmewhyVyoo+5t0dNTiFj8wtTAaDR?=
 =?us-ascii?Q?c4W/7JzH2XeJ3gdftxCv6Q34Q1TOfuCwHoIuarrxMyAaflLg4ChnX6tbn7Ys?=
 =?us-ascii?Q?i6D/Iy3HKAMLSOhOb5E8j3Z6lY4QDmI2NpGX86h2RYx3GIpDWiPr+KmKpnzr?=
 =?us-ascii?Q?nKXhJ1OQY+Ykbm+tJcc+nb4gYg07VSTVVzgaIjVMveaLWe9IqFFxSEGtru1D?=
 =?us-ascii?Q?mlY8eG04PqZCC6MWk65x8FOre7hmuNlHuOvgd+z+jg/ldPq5Ol8ai8OrMhOs?=
 =?us-ascii?Q?mw2BY/fh+If8O1kMHKxZBFC2UL7gDif94JIPv7kbIyghwlu889ae462VsYDr?=
 =?us-ascii?Q?9Xve1NVdqLJ3PY0cfJL9MUtZArwq5WOia7tcAzhwGJmv1zecWQMX/s4kcQTm?=
 =?us-ascii?Q?SVpxzBfZVnZdWeOzizD57TzekU9/UgVr1sgq0swEm0KFj+jsPkXJFdeOR6ER?=
 =?us-ascii?Q?AxlZ2DyQbd0DPuWpwokbiiDoj29aMdx6F4eiMdnm318qv93VwU3d+OFQ/Dlf?=
 =?us-ascii?Q?iiIBrjXkk7d+XhrPTXAhoB2HnFNAwuzdYO1nBfeMBs38H+nlGQgAc5E8UygH?=
 =?us-ascii?Q?b4l566QSWLoMGwYttsNa6ewCx/ZVQ0zBQu7ju/oiguBuY0Zej3kLFULS6+x4?=
 =?us-ascii?Q?Hw/tn4frokGCDPw6BMVMOgC/6tDlVLP53R6QYoqs3wvekOsjJgy4FFj44AoW?=
 =?us-ascii?Q?+o/Q5yY/DOYsMuKTegILwYyjS0EqseHDs/fJW5S+KkjcsHiQqepZc23M2kjt?=
 =?us-ascii?Q?K/Hj2RqgXQ4Bb+lduNjBaJypaiFvGBYAf3DAPD3ga15tMyyLvwnhtrWyEhDy?=
 =?us-ascii?Q?r7aJsCwHlWyoOwQRMVeAnu4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbd1769-01fd-4e29-4300-08ddb2650f3f
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:48:47.6798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bUgkj6su2yEw7arSfsN7rH3bOJ/agsXg9oFGLruE1t7Zuj55/QS8LwHTpa3qkJbZmKZSMhKcauts+KUJj7z7DXtQ4W1TRe5rDQinIhFIsIl8XZDfJEo0ld8MqhWj20N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5851
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:48:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19209

From: Biju Das <biju.das.jz@bp.renesas.com>

commit fae80a99dc0320be854aa789cbe7ed0e1e574c61 upstream.

The SDHI/eMMC IPs in the RZ/G3E SoC are similar to those=C2=A0in R-Car Gen3=
.
However, the RZ/G3E SD0 channel has Voltage level control and PWEN pin
support via SD_STATUS register.

internal regulator support is added to control the voltage levels of
the SD pins via sd_iovs/sd_pwen bits in SD_STATUS register by populating
vqmmc-regulator child node.

SD1 and SD2 channels have gpio regulator support and internal regulator
support. Selection of the regulator is based on the regulator phandle.
Similar case for SD0 fixed voltage (eMMC) that uses fixed regulator and
SD0 non-fixed voltage (SD0) that uses internal regulator.

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Link: https://lore.kernel.org/r/20250305092958.21865-3-biju.das.jz@bp.renes=
as.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
[tommaso: Squashed the commits ede057759b83("mmc: renesas_sdhi: fix
	  error code in renesas_sdhi_probe()") and
	  77183db6b8db("mmc: renesas_sdhi: disable clocks if registering
	  regulator failed") and
	  9078f01fec12("mmc: renesas_sdhi: add regulator dependency")]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/Kconfig             |   2 +-
 drivers/mmc/host/renesas_sdhi.h      |   1 +
 drivers/mmc/host/renesas_sdhi_core.c | 131 +++++++++++++++++++++++++++
 drivers/mmc/host/tmio_mmc.h          |  10 ++
 4 files changed, 143 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 7199cb0bd0b9..c5a169395162 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -681,8 +681,8 @@ config MMC_TMIO_CORE
 config MMC_SDHI
 	tristate "Renesas SDHI SD/SDIO controller support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
+	depends on (RESET_CONTROLLER && REGULATOR) || !OF
 	select MMC_TMIO_CORE
-	select RESET_CONTROLLER if ARCH_RENESAS
 	help
 	  This provides support for the SDHI SD/SDIO controller found in
 	  Renesas SuperH, ARM and ARM64 based SoCs
diff --git a/drivers/mmc/host/renesas_sdhi.h b/drivers/mmc/host/renesas_sdh=
i.h
index f12a87442338..291ddb4ad9be 100644
--- a/drivers/mmc/host/renesas_sdhi.h
+++ b/drivers/mmc/host/renesas_sdhi.h
@@ -95,6 +95,7 @@ struct renesas_sdhi {
=20
 	struct reset_control *rstc;
 	struct tmio_mmc_host *host;
+	struct regulator_dev *rdev;
 };
=20
 #define host_to_priv(host) \
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesa=
s_sdhi_core.c
index 6ebb3d1eeb4d..8c83e203c516 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -32,6 +32,8 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/of_regulator.h>
 #include <linux/reset.h>
 #include <linux/sh_dma.h>
 #include <linux/slab.h>
@@ -581,12 +583,24 @@ static void renesas_sdhi_reset(struct tmio_mmc_host *=
host, bool preserve)
=20
 	if (!preserve) {
 		if (priv->rstc) {
+			u32 sd_status;
+			/*
+			 * HW reset might have toggled the regulator state in
+			 * HW which regulator core might be unaware of so save
+			 * and restore the regulator state during HW reset.
+			 */
+			if (priv->rdev)
+				sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
 			reset_control_reset(priv->rstc);
 			/* Unknown why but without polling reset status, it will hang */
 			read_poll_timeout(reset_control_status, ret, ret =3D=3D 0, 1, 100,
 					  false, priv->rstc);
 			/* At least SDHI_VER_GEN2_SDR50 needs manual release of reset */
 			sd_ctrl_write16(host, CTL_RESET_SD, 0x0001);
+			if (priv->rdev)
+				sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
 			priv->needs_adjust_hs400 =3D false;
 			renesas_sdhi_set_clock(host, host->clk_cache);
=20
@@ -904,6 +918,102 @@ static void renesas_sdhi_enable_dma(struct tmio_mmc_h=
ost *host, bool enable)
 	renesas_sdhi_sdbuf_width(host, enable ? width : 16);
 }
=20
+static const unsigned int renesas_sdhi_vqmmc_voltages[] =3D {
+	3300000, 1800000
+};
+
+static int renesas_sdhi_regulator_disable(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	sd_status &=3D ~SD_STATUS_PWEN;
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_enable(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	sd_status |=3D SD_STATUS_PWEN;
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_is_enabled(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
+	return (sd_status & SD_STATUS_PWEN) ? 1 : 0;
+}
+
+static int renesas_sdhi_regulator_get_voltage(struct regulator_dev *rdev)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+
+	return (sd_status & SD_STATUS_IOVS) ? 1800000 : 3300000;
+}
+
+static int renesas_sdhi_regulator_set_voltage(struct regulator_dev *rdev,
+					      int min_uV, int max_uV,
+					      unsigned int *selector)
+{
+	struct tmio_mmc_host *host =3D rdev_get_drvdata(rdev);
+	u32 sd_status;
+
+	sd_status =3D sd_ctrl_read32(host, CTL_SD_STATUS);
+	if (min_uV >=3D 1700000 && max_uV <=3D 1950000) {
+		sd_status |=3D SD_STATUS_IOVS;
+		*selector =3D 1;
+	} else {
+		sd_status &=3D ~SD_STATUS_IOVS;
+		*selector =3D 0;
+	}
+	sd_ctrl_write32(host, CTL_SD_STATUS, sd_status);
+
+	return 0;
+}
+
+static int renesas_sdhi_regulator_list_voltage(struct regulator_dev *rdev,
+					       unsigned int selector)
+{
+	if (selector >=3D ARRAY_SIZE(renesas_sdhi_vqmmc_voltages))
+		return -EINVAL;
+
+	return renesas_sdhi_vqmmc_voltages[selector];
+}
+
+static const struct regulator_ops renesas_sdhi_regulator_voltage_ops =3D {
+	.enable =3D renesas_sdhi_regulator_enable,
+	.disable =3D renesas_sdhi_regulator_disable,
+	.is_enabled =3D renesas_sdhi_regulator_is_enabled,
+	.list_voltage =3D renesas_sdhi_regulator_list_voltage,
+	.get_voltage =3D renesas_sdhi_regulator_get_voltage,
+	.set_voltage =3D renesas_sdhi_regulator_set_voltage,
+};
+
+static const struct regulator_desc renesas_sdhi_vqmmc_regulator =3D {
+	.name =3D "sdhi-vqmmc-regulator",
+	.of_match =3D of_match_ptr("vqmmc-regulator"),
+	.type =3D REGULATOR_VOLTAGE,
+	.owner =3D THIS_MODULE,
+	.ops =3D &renesas_sdhi_regulator_voltage_ops,
+	.volt_table =3D renesas_sdhi_vqmmc_voltages,
+	.n_voltages =3D ARRAY_SIZE(renesas_sdhi_vqmmc_voltages),
+};
+
 int renesas_sdhi_probe(struct platform_device *pdev,
 		       const struct tmio_mmc_dma_ops *dma_ops,
 		       const struct renesas_sdhi_of_data *of_data,
@@ -911,7 +1021,10 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 {
 	struct tmio_mmc_data *mmd =3D pdev->dev.platform_data;
 	struct tmio_mmc_data *mmc_data;
+	struct regulator_config rcfg =3D { .dev =3D &pdev->dev, };
+	struct regulator_dev *rdev;
 	struct renesas_sdhi_dma *dma_priv;
+	struct device *dev =3D &pdev->dev;
 	struct tmio_mmc_host *host;
 	struct renesas_sdhi *priv;
 	int num_irqs, irq, ret, i;
@@ -1053,6 +1166,24 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 	if (ret)
 		goto efree;
=20
+	rcfg.of_node =3D of_get_child_by_name(dev->of_node, "vqmmc-regulator");
+	if (!of_device_is_available(rcfg.of_node)) {
+		of_node_put(rcfg.of_node);
+		rcfg.of_node =3D NULL;
+	}
+
+	if (rcfg.of_node) {
+		rcfg.driver_data =3D priv->host;
+		rdev =3D devm_regulator_register(dev, &renesas_sdhi_vqmmc_regulator, &rc=
fg);
+		of_node_put(rcfg.of_node);
+		if (IS_ERR(rdev)) {
+			dev_err(dev, "regulator register failed err=3D%ld", PTR_ERR(rdev));
+			ret =3D PTR_ERR(rdev);
+			goto edisclk;
+		}
+		priv->rdev =3D rdev;
+	}
+
 	ver =3D sd_ctrl_read16(host, CTL_VERSION);
 	/* GEN2_SDR104 is first known SDHI to use 32bit block count */
 	if (ver < SDHI_VER_GEN2_SDR104 && mmc_data->max_blk_count > U16_MAX)
diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index a75755f31d31..41787ea77a13 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -44,6 +44,7 @@
 #define CTL_RESET_SD 0xe0
 #define CTL_VERSION 0xe2
 #define CTL_SDIF_MODE 0xe6 /* only known on R-Car 2+ */
+#define CTL_SD_STATUS 0xf2 /* only known on RZ/{G2L,G3E,V2H} */
=20
 /* Definitions for values the CTL_STOP_INTERNAL_ACTION register can take *=
/
 #define TMIO_STOP_STP		BIT(0)
@@ -103,6 +104,10 @@
 /* Definitions for values the CTL_SDIF_MODE register can take */
 #define SDIF_MODE_HS400		BIT(0) /* only known on R-Car 2+ */
=20
+/* Definitions for values the CTL_SD_STATUS register can take */
+#define SD_STATUS_PWEN		BIT(0) /* only known on RZ/{G3E,V2H} */
+#define SD_STATUS_IOVS		BIT(16) /* only known on RZ/{G3E,V2H} */
+
 /* Define some IRQ masks */
 /* This is the mask used at reset by the chip */
 #define TMIO_MASK_ALL           0x837f031d
@@ -226,6 +231,11 @@ static inline u32 sd_ctrl_read16_and_16_as_32(struct t=
mio_mmc_host *host,
 	       ioread16(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
=20
+static inline u32 sd_ctrl_read32(struct tmio_mmc_host *host, int addr)
+{
+	return ioread32(host->ctl + (addr << host->bus_shift));
+}
+
 static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr=
,
 				      u32 *buf, int count)
 {
--=20
2.43.0


