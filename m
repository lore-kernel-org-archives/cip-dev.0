Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16004EC046D
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14371.1772529739040025891
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=lUm7YDmw;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v1/eiK/ep8XrEunMl/SEf4/JLNAoqAqjMENPp3QxZ4sDKDxka46VaPZK3tKjVxLKwcFHgtp40nzRZoG4JrMZXZcBT+m2NSwJUwTGpCyJtJLZW2kaxlNTBqbNVtryT72aP7tH624njVwS3reWU1AoAIWKvQH4mGyNuaB3PTDLa3JopmJWDFr0zjO5WucOIwdDiH8izfJ9CMBB9qJqC3jyfKIY5/3toP8pSRSqKSvfv9GMQIwaNjaRSYQgiMFpu12LS0yE/uQG6a2KcGyjoapaZfyYwA9L2wORJ/rhll6eWlUmW5cal5yqelml/Mo1XCI+upUL/fMpkmY1iYq9YvqZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u33suHZNylqNGnyh5VuAx9z+fbFS2r4VkbWecEUxQD0=;
 b=lvHsnOWr/98X3l52jP3QR+Gz240LRWH5vYHWBJGdN88T5PTBSnSCPmg3Y5/tLfZd+12h36vc1kwWYwxeXsOH0J9Vs0QbcfB99LX8ZJnrr4Im18XO3VDoWYlGu45AA8R6CKm6i0AGdE28DaqJmBiR6enwpNlYjh4YUGawKmqcEEUJCsA8nw22052hdVm6FfsqReAJzXn93FFCl34JD5syN6XA3jKXqQxaIbNLusStsryrpiwWYbJwmppVI0qm5X6fIvumAT0iZcxnzRdJd2RePOe9e61z9n+gKewGreDA3fNGun2iyjFK0r+Kyt+FU7oqbN5zacmsaiJzZuWUhfkmgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u33suHZNylqNGnyh5VuAx9z+fbFS2r4VkbWecEUxQD0=;
 b=lUm7YDmw0hDKEkyTfKZ/Fa+9xxIfyjGTuj2gyxHSCMaLA1sUr9zbd/x8Jx5KcaYfZZpSTLw2VT+gLtiBlOlJpHIncMXbcRMppO4ulqV9u9Vm1jt2FurXiJ1QauDdpcw2MmIS3ce2ecN/wVp/eIu+LE/Sr8nccwkXkeZ/tlaqbgI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:14 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:14 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 2/9] clk: Provide managed helper to get and enable bulk clocks
Date: Tue,  3 Mar 2026 10:21:33 +0100
Message-ID: <20260303092140.12732-3-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYCPR01MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: 17ad89ba-e0cb-4eb5-fd7e-08de79065b31
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	NNAwC8EuD6Ez7uA7Zmfwrif1XDkSAXUMwJPmd8oOeLLDpvsRhyQy377PXNp2qi3xa9RNptiY063t3aKtESAMJ6AHvx+hnnH0JI16/TLJlXaWlDFDlaTZ4IWfMCgHdyETSrUcbZYCHWEUL9xcXeKJdCwrdJZ2WNn1rl/3Sf6JwauwcKbxrzI86RgMf6TFvmhZDm6jcP76gwJHwdVu25qhyz1t6D8B7iCvq3hsjAsm9DnFdnY7FSS9+gAaCFtULQ5+UaV/LEnit/i7d1EVBRs8lO5pVuLH49hlaB4VAdvMnufcSstX4XAD07DFegUQ6wQS3q8u4DIzymhEphCfIzXs/0f4sGLKAhDrFivLj6LPBdZSgjzmlD72a6Zxxu8QGVOjBZUXfEA1A97RYN+SXS6WlKR3vWqmwuH09dT5MLf1RXdxnEDtuKAU4dJPDFYE+u6yucv+E4y1dc1qrASNviZghYi/DfmQLjrYHV6bEKyy5TF31jw6TSNqANiSR8qDz4tMsGERa2evUIyQk1IgHua0RBCUBhs2o25nXJOBow25120UbS1k3yxMo6ENx7qfuQabMek0cdbr3cQC4m8Dtfo24UN4K/6bWfXx9RTXAPlO8mYCbtgUY8i1++Nlv3VGie/tTlLOaOMHoKGV5Wjp7iratTbds98qkQ9eodXqN4QkghFYwzW4rXRtoe17jRB6Q6KKf3YdqGOskWYsH+7j6J7ca9AxhVV0aaKipLzIfMQ+TCBhz6VO7c+3lCgG4o5D2T11/RRhsg+Yqe8plRpgr11629ucqHcOyu4AtFI2y2tmsYs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CJHfviYo14py4TZxRhZfmHMJudL49RuwiXxQNHn40D9e9a1LzoQUWIJwsxRQ?=
 =?us-ascii?Q?aq18q7WBhLvYx6xNucMVOxwK9CNSJ0s4YR52GjZ40PWhKCCoAeA/Eswo8XIe?=
 =?us-ascii?Q?kaQIDFtKj6ou9xYW5oTMPQZkLU2iYpSlNWYmxn3gNCpILozixdfwgx3cIN++?=
 =?us-ascii?Q?QY+D2vXxz4wfhqbLCXBFlBvEyi9hLvmt/D6u/caco6oMG1gPVxI+YvRlO938?=
 =?us-ascii?Q?8xFm7AdckhS+q7T9g/bkKeWkVNi+Iht9euKdZy82xykfcbCcVOmuBk9wOjBN?=
 =?us-ascii?Q?B8sZmbRBIZk7RHYjGZE/hPFWwPe7Ip957wEN0QSul0ZF/DtrDorwIgWZwy5y?=
 =?us-ascii?Q?bDIUkiUSEj2a827tO8DRxJ9BPpD6jyx+L1sXBPg+UzKeLakaZxkZMJ5c4Gw4?=
 =?us-ascii?Q?cWVPq6cs/K2bY+7GVrr+2J5IbDiCEKqzl4em/sKSpWbolYSBTGUJcOjj3Z1i?=
 =?us-ascii?Q?abiHryVPWEEMjYBjYMWAdieTD6meAUFyyS/ofKWbnpAbaLt2NReDyg99roMS?=
 =?us-ascii?Q?h4dX+aLuTA6MGY/VP2KvGuAHJuzu9/2zFE/ECjeQ4TtUaenhPUD5x/ume/XV?=
 =?us-ascii?Q?1D63eZrm6aF6islV6Qju+sEAlGcnTLVF8RQgaBwS9sGlxOP3Tco8KwH4ROfR?=
 =?us-ascii?Q?96D/7lpH/DUxO3gunB3ku6/RhLVV1ATsZ7VFa4mFLC6iro47Y9A7Ghd9fpxq?=
 =?us-ascii?Q?N6libpOVlG+JOIi3QPd8o6Bc9za8WoKVAoy7eg1fdRwIf4HWj6K/MwNCgKrZ?=
 =?us-ascii?Q?tQBJKg+ZMaU5kSCmZvTOS/8CVbdFVQssrxKMZAmzw3JslnzgazXsMdmrWUB3?=
 =?us-ascii?Q?Klz9GfGu/umgQce0J95bW9VZFQvxiezCm8w7Q8k9TeRhsViujMO4czvxqb9y?=
 =?us-ascii?Q?x/dPbe1mvmtkx7YKCkDqUIDWy5KrDNK44WpZ4fFpk/ENWgAWLYdpeI2YU1r8?=
 =?us-ascii?Q?M/JtCtTxGVTxZwLWetwaGQtIexituIuGcXdz/IkiscmwlLM81CDaNz+qAc9j?=
 =?us-ascii?Q?CAL3GgVHkhLoatqm0RtVWtaAYXcfAZ6c/QwkvegyZYC7ScPz2UkBqp+2QZYO?=
 =?us-ascii?Q?zLHS7ADd50jfMsPehxlm4UldTZiPbbB0CSQhVcrnCRISOj01xia6qfxEFjyh?=
 =?us-ascii?Q?THDlPyz0yf4PEcbE1Gf3Ixb6VclFQguCS1m3HvRobJG4lZCkgcNbNILKUfx5?=
 =?us-ascii?Q?oN4iVKWfp08JxDg5AOWFayyxI1pozQ9rq0ADmQP7TMyxshsMxiJ1Z1Ccwhd7?=
 =?us-ascii?Q?zdxmBcZlRueI6ytMR0JLYl+x6nMe6xRUbui0IwMPAMK5dSyJ2rd4TSLvsMAb?=
 =?us-ascii?Q?bt/ReQh9PdVBPXewMgi9hl1js/7RUN1Ew1/CebtA9CvwtsJPnYOgsdBQDatJ?=
 =?us-ascii?Q?G+uON2nMD5VVlkSFckRl7sSqV6P0g00IQMGPSWAQ1lraNj+7a+ziBsNtvDMS?=
 =?us-ascii?Q?LajjO6XOpyMpP0XY2RVZHdaFzblIl+hJSaxUWbO8hQ2ilrqeDGfLZCGqnEsc?=
 =?us-ascii?Q?dRGMwZoe/CNZPhW8QsG3v7sZ0rJ7L0sYzTLFiFdb+FvIBym7hO+t26IFJB27?=
 =?us-ascii?Q?6/Py3hqHxc334IYzvb46eE/Qh1dKbCeihugSfIBjIKVW0H2kW9LuyAk3Avkh?=
 =?us-ascii?Q?ndybXRCsTG4Zq1ev96OdHC+sCIaWnwcj94wGVnn+D1TyNJrFi4AigVJFd0om?=
 =?us-ascii?Q?9G7DRnvW8q7oOJOtHxIN99Mw1msWvclkeQcO4ddPRDqq7IOET8YWJGXn8UKl?=
 =?us-ascii?Q?a1i6lP5GdhubJY6ZO/8RErOsova6ul2JZhFKwkYcPB5E2DJ+waQI?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17ad89ba-e0cb-4eb5-fd7e-08de79065b31
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:14.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zviOWJDcxQtlFLiNQNG2syeM3HcpbjYrJCPpj4HIJb8N8L3CPN8Uqbzsl9HEEC6JUj40xKdWc3SsveQvzUvHWqswLcWACt1xyMJLjrLEprp7aEFr7DyZO50QTW0cNi+o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22043

From: Shradha Todi <shradha.t@samsung.com>

commit 265b07df758a998f60cf5b5aec6bd72ca676655e upstream.

Provide a managed devm_clk_bulk* wrapper to get and enable all
bulk clocks in order to simplify drivers that keeps all clocks
enabled for the time of driver operation.

Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Shradha Todi <shradha.t@samsung.com>
Link: https://lore.kernel.org/r/20240220084046.23786-2-shradha.t@samsung.co=
m
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/clk-devres.c | 40 ++++++++++++++++++++++++++++++++++++++++
 include/linux/clk.h      | 22 ++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 737aa70e2cb3..90e6078fb6e1 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -182,6 +182,46 @@ int __must_check devm_clk_bulk_get_all(struct device *=
dev,
 }
 EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all);
=20
+static void devm_clk_bulk_release_all_enable(struct device *dev, void *res=
)
+{
+	struct clk_bulk_devres *devres =3D res;
+
+	clk_bulk_disable_unprepare(devres->num_clks, devres->clks);
+	clk_bulk_put_all(devres->num_clks, devres->clks);
+}
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks)
+{
+	struct clk_bulk_devres *devres;
+	int ret;
+
+	devres =3D devres_alloc(devm_clk_bulk_release_all_enable,
+			      sizeof(*devres), GFP_KERNEL);
+	if (!devres)
+		return -ENOMEM;
+
+	ret =3D clk_bulk_get_all(dev, &devres->clks);
+	if (ret > 0) {
+		*clks =3D devres->clks;
+		devres->num_clks =3D ret;
+	} else {
+		devres_free(devres);
+		return ret;
+	}
+
+	ret =3D clk_bulk_prepare_enable(devres->num_clks, *clks);
+	if (!ret) {
+		devres_add(dev, devres);
+	} else {
+		clk_bulk_put_all(devres->num_clks, devres->clks);
+		devres_free(devres);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(devm_clk_bulk_get_all_enable);
+
 static int devm_clk_match(struct device *dev, void *res, void *data)
 {
 	struct clk **c =3D res;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 06f1b292f8a0..0f44d3863de2 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -478,6 +478,22 @@ int __must_check devm_clk_bulk_get_optional(struct dev=
ice *dev, int num_clks,
 int __must_check devm_clk_bulk_get_all(struct device *dev,
 				       struct clk_bulk_data **clks);
=20
+/**
+ * devm_clk_bulk_get_all_enable - Get and enable all clocks of the consume=
r (managed)
+ * @dev: device for clock "consumer"
+ * @clks: pointer to the clk_bulk_data table of consumer
+ *
+ * Returns success (0) or negative errno.
+ *
+ * This helper function allows drivers to get all clocks of the
+ * consumer and enables them in one operation with management.
+ * The clks will automatically be disabled and freed when the device
+ * is unbound.
+ */
+
+int __must_check devm_clk_bulk_get_all_enable(struct device *dev,
+					      struct clk_bulk_data **clks);
+
 /**
  * devm_clk_get - lookup and obtain a managed reference to a clock produce=
r.
  * @dev: device for clock "consumer"
@@ -968,6 +984,12 @@ static inline int __must_check devm_clk_bulk_get_all(s=
truct device *dev,
 	return 0;
 }
=20
+static inline int __must_check devm_clk_bulk_get_all_enable(struct device =
*dev,
+						struct clk_bulk_data **clks)
+{
+	return 0;
+}
+
 static inline struct clk *devm_get_clk_from_child(struct device *dev,
 				struct device_node *np, const char *con_id)
 {
--=20
2.43.0


