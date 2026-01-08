Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C83BCF6A9B
	for <webhook@archiver.kernel.org>; Thu,  8 Jan 2026 09:29:30 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.6])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.3000.1767864569349438066
 for <cip-dev@lists.cip-project.org>;
 Thu, 08 Jan 2026 01:29:29 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=wlBCOlQw;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.6, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vnc0na/GZbhIZaVGUL3L2CsBoOInJqoN9juSRfjIZz/ZktxImzir1Xn2ZFi0Eos4WnIy0Lb1mJXfHcwxqpbz2vFYipetDyeMpuIPz1gyWDVCPS0oJznW/ZE2+sfAV1xl4eGyiB/7NWDHVVUpLxJOaDGkOWbOa2pvNKMNpYgjiM1d+ULYOlc4eHxuOvuhef3zbF+Gj54L6zQr4/xCfxNZpDlVuiW6t57oqVpfCvpDPH17x0sMaBw2SiaPq8d5pFYKpdF86HyqvJGtNQNvSlWqg2BK9gZMLAZjx8d2bN2v5Ej2wGjDEziMMLkZzk42RsHYNKlXsI3vT4zkPrpvhYst3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jz8NKNorjOJX1BnEBJ8UoAuoyc+rQq23V+jTPh/CiZc=;
 b=DvAmSfykrnw/aga0OG+1/gzXjXrOBzmoFM7/Mr5iNnqpdyTfoV4oU/5iKuZ7NR+hY2zFtq44IYzp4kFHfCJI9E8vyEwgOIjLB/FZnsx8j0Ye85reDbpI1+S4Sxv4GMsOw6YsN2BuSUjmUH3s4E6Ehs+AKLxIfIbStyVIsMy6nGezC2w1h9yZhMtd7fzzb6TjfMJz33lDK+U1fNAntIYZTQWo4sLp+MAIxjkRzH04wmgBc+K1hrzr1da00EeP1D2iCyW/bu21tdXz+MuqrgcDMObw/8IVohNUBN8r6yUxsX9reL3dVF720CxOiZO9BQCuK2161UKUm7H2rVwBfU95bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jz8NKNorjOJX1BnEBJ8UoAuoyc+rQq23V+jTPh/CiZc=;
 b=wlBCOlQwnniu6SOJLtQcQoKwSaX+dvHyOGpVqUMFYX/zSewt2oGH32c/wzcWV7NydCMlOO3UqbNdr41Hn0IqAvcS8ye0d+sW6QlmoQrb/xRR9fLG/M4T/6CvbzCAOWSD7W9mGmwOqv1pH/Q6qZ2ZsRCHyH0xB/29ZEDFsDeE6Ng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY7PR01MB14750.jpnprd01.prod.outlook.com (2603:1096:405:257::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 09:29:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9499.003; Thu, 8 Jan 2026
 09:29:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 13/22] i3c: export SETDASA method
Date: Thu,  8 Jan 2026 10:28:14 +0100
Message-ID: <20260108092823.489287-14-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY7PR01MB14750:EE_
X-MS-Office365-Filtering-Correlation-Id: 94095146-eb99-4c38-c628-08de4e98697a
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?qgMI6tsIoz7Hi2nSopJltGEZ75zGOrFF1i3jMP2EIPub//W3xA8SE1C1WcuT?=
 =?us-ascii?Q?y3C0vnWX1Wipu3FkhXJoyZng96AA6sd3kjgNg58lZDFuB/CAtXU9xL9dK/vd?=
 =?us-ascii?Q?JPz53vZ31OYG3OycEGyE4gfZcNCQ6ArL18uEqaatHH/hJI8zkH1s8GSU5COm?=
 =?us-ascii?Q?zGolyN+NgAfgwDieb7fwVetH9rfehUJFwvFWMUJkOQ2UXwR3OLEtvYy91Eib?=
 =?us-ascii?Q?fZV5pV46RgOt/6lOTMo59GDqEAzk5Ee4cfiarC/9aPROmgnqBqJSYIopqV+K?=
 =?us-ascii?Q?FA5Z7i03MRuNBCFOdq0SdqncEVt9OYbCIDpURo7xG8JMQanGyPtjyM2bYcbF?=
 =?us-ascii?Q?M9F3KqrU4rexEfgI4LR4c8f0bLCHDcfXRqNnJNZMExv2yxx53lBjPTeW0Buq?=
 =?us-ascii?Q?eulW+v8FU/Wxx0uBrOPCPsl+rakPZ88T6ACWdaVF1IQYPcKkFogo1p2IXRJS?=
 =?us-ascii?Q?udyf0+PxBnolVXf2AaEJlkpF/TYTECQDVKKurAiF99t+778NEgxt61wjYpZ9?=
 =?us-ascii?Q?o7s2JVmCN7OJ+l0UqE9KnJJhKe4XZCIz16cCjcIXzDsv8KTb1zjE0XYVGxro?=
 =?us-ascii?Q?IfoarN7MwrtKH4oRLVoa7C7I3X8z7/IJJzToviPoX43aVSKMg3Gfjf3oy0j/?=
 =?us-ascii?Q?RZDMX4MLGwJyuHksPb0X+otp79uZ/Apz0bB8d0zNGkdxADMxqoW460zoKaKW?=
 =?us-ascii?Q?swqtsAVVgz8NuGN/e2ZK09uoBnrrAcgzmNTQsbNfnNT8CzOhBnNoK1eGrtZQ?=
 =?us-ascii?Q?EL6MQD66EA5ckbFv9Mw1PlJbhi4cY911ntyaXAqred9o6YPoDzT9NUBZeIjC?=
 =?us-ascii?Q?QYycXxgo4lx1xtRepv99hRpF4UkMt8ce0BPIplnUTMrIME9aDWgBYPH6kjG9?=
 =?us-ascii?Q?EpTLStyEToN3/xCmOXsUiPVGUEjUU755nse/wajSq0Hr0qda7M59FK5YUY4g?=
 =?us-ascii?Q?id4KZVy4vSTUdHqSDl9qkbl7H83HgzI+D/hfQDNIzl4sYWBsA0/mPu9e9cLm?=
 =?us-ascii?Q?hvkHhYchLuASD+EtHdGVuKq+nC5N9OZuO9/9+LYmEWHus02otYZSA/VMTbyI?=
 =?us-ascii?Q?yLijR/2/M8WczYore0OeaEtVQUZRAPvP0Kb9eXtafQ+l0k6WUKX+DOVzoNJ9?=
 =?us-ascii?Q?TRzlqmkzCeu/pFkYHotCPmP3NuHH7lCG6wtK6cnH4HhHcjDLPJpQ1kzPRRWJ?=
 =?us-ascii?Q?Enh5lQgTCx70XZ6FtYdduLaxfaJ0k5vzURF2Iw9nLeZKajHF7Auy+wWu/HlK?=
 =?us-ascii?Q?If+mUHDOVR1UCkHctizY2HWsgZcgMXmRHq253lU8NEA2rFvalNQEay4+M28i?=
 =?us-ascii?Q?FZ2iFttTkxGeezW7u57hdhxHWygGDV8d3dzVO1Z0mjLFAhB2eyLBwUg/wEBD?=
 =?us-ascii?Q?3Mm7qDwgCosepnt1thhOiA2Go/BF5+gfDsNbCnsSSPlJgQ0M74CmujP1HpNh?=
 =?us-ascii?Q?ptBBaLkW83BPN4go1cbwpfe0waTSJYM1z11A5Fspwstc5zXRTxIrZAzER5o7?=
 =?us-ascii?Q?/Z2NAl7ol6K0zNjOkaKiAOYCa7nNLD6/rVhE?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?7Ie3WG8565K9lG4z/1RBl0IDxffAQx02fmHBdqyFaz1SSJ+wCLzvAoQzsERu?=
 =?us-ascii?Q?FJhfh6awxrCeshbxebRHGatpJ2UizwzxYmQRTCKhzQr9MK7yvz2QE9eNHzf5?=
 =?us-ascii?Q?6V1BxiZdTIt8+TTT8VbSeNXBkCuIL6gsKwpwPMTfFH3NwyA7/bJVUatrYQLT?=
 =?us-ascii?Q?QxQ8Ci6CC3PDljrRNLNmJNvv651IFKsWCa29GRAppKvCLGz+eUsf+y9PcJ7N?=
 =?us-ascii?Q?SFfu9bED0QPO2CUPFKLA6qyPz0KTVUZKJnQQLOpfPo9DK4T3LFwBBN03giYO?=
 =?us-ascii?Q?N1MZVhwmQCMlUyqZkjDyg02tL/DhDnN+YbGeGpS8J3JwTh9nzE+y0TxYCToE?=
 =?us-ascii?Q?7u+P9yD4cB6+ehVFVzFgZ4IYWXKI7//0idY4ZFeJSqXb7NOuID4oxliMWVgL?=
 =?us-ascii?Q?I8R5xQLAHUG9+llpPhfyU8aXMRh0eGxTc47qpQl2uMVOP5vR4mUTdWmLC8eE?=
 =?us-ascii?Q?5OaQtywHJHZRZmRVSBZcXEKrY8+CqhsFwO7ZGmErvixB/5yHM9y8wB2NcKMz?=
 =?us-ascii?Q?4FgBUkL/sO/y6pGpZZNMyZNtnjdnJx1EIMx1Q90a8ggh2HPSed0VR9+JOVfB?=
 =?us-ascii?Q?uZrz3soIQzI88rJ5skaA2RT/J7X9FT9OTM/BN8oKKtyRT2/NOl8LgAbUf8Sn?=
 =?us-ascii?Q?TUdM1LOOoj2nQauVJSQRsFIl46T5/8m5n6hv68qkv9HKc+7QiE0SUdn7YHt5?=
 =?us-ascii?Q?ofHmdAwWH7IctMWgDhWo6Uj8wSiiaMwmFU4UFQmhcR8wIBuNg0c7appmPFeI?=
 =?us-ascii?Q?RhbIAzizm94R0K5HnjpFEgDAo0Jhr7Nncv9KgoEUgRXMvYitiIguoeqUwEjC?=
 =?us-ascii?Q?ExsGtp+QcSTgyZE2THhehfJfDawOB1rnxkTh+RK7HPS2m9sHWpof1+uoMo0t?=
 =?us-ascii?Q?gRad2NYkllbBP7AaUq4XfSc5M+zeOWAZ8Y/41/9QXHusQbF3QkYGa3ZUjx0M?=
 =?us-ascii?Q?1BBC87mqbDnvf1jSQmZPcmmB3j/VklFq1saiDJsQXdarrzRhslPwhuMiI0IB?=
 =?us-ascii?Q?wc4bULm/a2qWeIOks5d89VYCAth1Saon0vAiX1ggQK1sdr6WBWcopgD8ky5v?=
 =?us-ascii?Q?KgrB4nOiVKf5O8wrJ1VD6M6BCn4bn1v1Zl4lGXWf5Sr0V4sF8YjLySrHa8Y6?=
 =?us-ascii?Q?W/YomIji0RbDqcAgnePMl4pHHwlKoqtfCWoldGUx2WA5ghq7IV+5JXuB3Y44?=
 =?us-ascii?Q?DqDd3+8gj3zth/Vo/A6RT/QVrGPrr3K8OSn4n5qfWf29Yd59z/4YgHDQX5uR?=
 =?us-ascii?Q?UvVkcR3yJZrLFBy6mc2SDzB2+OoYaoxxE3AuPhw9Q5yB/4kVAEWHdHh+bDh2?=
 =?us-ascii?Q?G0xiJOiQ4ouggz7hGi8ujpZlEPYyr2B1mgXotyzAG1ujqo729jK44NG7FJve?=
 =?us-ascii?Q?mIrpjXAATXj4lsbpmxklNxwsWnvOvCSHBDnIEG2zxMGTG2PQbIEMRyETFisK?=
 =?us-ascii?Q?8Z4o8fFai2qUHkVxuX5bfaf5BqJu4YGdpd8froZ3sCiRKGqWE6xh3pd6wa7K?=
 =?us-ascii?Q?cMcjI2qoODzEXqNoyIG5gMjPrXzfxW2857tLKnxmiS7EXeMScIu+KNeX2tE6?=
 =?us-ascii?Q?WUD1TpCi/qL4iqNn/B6S0oK1hmJITjtdeHL2O5nlXb3Z8hew929aFOZ+1Ctj?=
 =?us-ascii?Q?NH4lGEmq+8Z7EeuYh3Eh8ThySyAiwx//x5HNB7F0uI5y07irMDNpn/6BE+4y?=
 =?us-ascii?Q?FZIc5T4+G9ayX8soxlrWLcwH47GGuwZ+pSugPDs/Sl5CaaRzjgDJO73nbo5T?=
 =?us-ascii?Q?JLACGzLhh2k99HQAVXR9AcFjmJNrGYrmh78GX8PSApo64xF+yuMt?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94095146-eb99-4c38-c628-08de4e98697a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 09:29:24.8027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c1NZerBU17f5aiYKgofQ9PB1/uHZqJhsq+P3sd7op5+ifrdcQ2Yz5oNxAt2f08Wbr2JlGRHwIfMcAjxgsUGpQNYwXvP7dbtTE1xq9RU/BnTpNtONNTakEAcMwvoVBg7v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB14750
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Jan 2026 09:29:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21449

From: Jack Chen <zenghuchen@google.com>

commit 672825cd2823a0cee4687ce80fef5b702ff3caa3 upstream.

Because not all I3C drivers have the hot-join feature ready, and
especially not all I3C devices support hot-join feature, exporting
SETDASA method could be useful. With this function, the I3C controller
could perform a DAA to I3C devices when users decide to turn these I3C
devices off and on again during run-time.

Tested: This change has been tested with turnning off an I3C device and
turning on it again during run-time. The device driver calls SETDASA
method to perform DAA to the device. And communication between I3C
controller and device is set up again correctly.

Signed-off-by: Jack Chen <zenghuchen@google.com>
Link: https://lore.kernel.org/r/20221207205059.3848851-1-zenghuchen@google.=
com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i3c/device.c       | 20 ++++++++++++++++++++
 drivers/i3c/internals.h    |  1 +
 drivers/i3c/master.c       | 19 +++++++++++++++++++
 include/linux/i3c/device.h |  2 ++
 4 files changed, 42 insertions(+)

diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
index e92d3e9a52bd..9762630b917e 100644
--- a/drivers/i3c/device.c
+++ b/drivers/i3c/device.c
@@ -50,6 +50,26 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 }
 EXPORT_SYMBOL_GPL(i3c_device_do_priv_xfers);
=20
+/**
+ * i3c_device_do_setdasa() - do I3C dynamic address assignement with
+ *                           static address
+ *
+ * @dev: device with which the DAA should be done
+ *
+ * Return: 0 in case of success, a negative error core otherwise.
+ */
+int i3c_device_do_setdasa(struct i3c_device *dev)
+{
+	int ret;
+
+	i3c_bus_normaluse_lock(dev->bus);
+	ret =3D i3c_dev_setdasa_locked(dev->desc);
+	i3c_bus_normaluse_unlock(dev->bus);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(i3c_device_do_setdasa);
+
 /**
  * i3c_device_get_info() - get I3C device information
  *
diff --git a/drivers/i3c/internals.h b/drivers/i3c/internals.h
index d16a79953709..80245b953c71 100644
--- a/drivers/i3c/internals.h
+++ b/drivers/i3c/internals.h
@@ -16,6 +16,7 @@ extern struct bus_type i3c_bus_type;
 void i3c_bus_normaluse_lock(struct i3c_bus *bus);
 void i3c_bus_normaluse_unlock(struct i3c_bus *bus);
=20
+int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev);
 int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 				 struct i3c_priv_xfer *xfers,
 				 int nxfers);
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 035dab33f85d..7405bf386d8a 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -2924,6 +2924,25 @@ void i3c_master_unregister(struct i3c_master_control=
ler *master)
 }
 EXPORT_SYMBOL_GPL(i3c_master_unregister);
=20
+int i3c_dev_setdasa_locked(struct i3c_dev_desc *dev)
+{
+	struct i3c_master_controller *master;
+
+	if (!dev)
+		return -ENOENT;
+
+	master =3D i3c_dev_get_master(dev);
+	if (!master)
+		return -EINVAL;
+
+	if (!dev->boardinfo || !dev->boardinfo->init_dyn_addr ||
+		!dev->boardinfo->static_addr)
+		return -EINVAL;
+
+	return i3c_master_setdasa_locked(master, dev->info.static_addr,
+						dev->boardinfo->init_dyn_addr);
+}
+
 int i3c_dev_do_priv_xfers_locked(struct i3c_dev_desc *dev,
 				 struct i3c_priv_xfer *xfers,
 				 int nxfers)
diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
index 419192b5cc4d..1c997abe868c 100644
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -294,6 +294,8 @@ int i3c_device_do_priv_xfers(struct i3c_device *dev,
 			     struct i3c_priv_xfer *xfers,
 			     int nxfers);
=20
+int i3c_device_do_setdasa(struct i3c_device *dev);
+
 void i3c_device_get_info(struct i3c_device *dev, struct i3c_device_info *i=
nfo);
=20
 struct i3c_ibi_payload {
--=20
2.43.0


