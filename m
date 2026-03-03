Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F1CEC046E
	for <webhook@archiver.kernel.org>; Tue,  3 Mar 2026 09:22:27 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.9])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14371.1772529739040025891
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Mar 2026 01:22:19 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=VeFmRIYE;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ytiISIbq+X8wvGivrPwv8cEZeJQIj1F4kHxjo5NPUT1eNuh4Hwf7z0tK45uA+uIEQ68labHPmoC1D8xbhphwq8qtnS6HExae2NOwBSeYXvkKFS7aWKl5LBqVK7NgHbvlp+BA6BFEM/Vvw8cL2qDnTSlssqp61Hmuvp5K/hLAvRm6iScQhENgMrjAMNg5VPyEN8t9826geLXuC1e+Khcm0e3dIoRooh3jnUFiBk5vEND8hzKDr9VVLm/F3yJE566nBOCN5ekupdJ8FvRhil9gtSEYMpRcu6wNpOsak/oYCQvg776xlKB063pBRpWqsi9Ori2jdhnr+RhSJ7j2E+yHsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztZSIXlxTjUHDcn1+YkKg2QKSPo06WDLuYWb/uHUzB4=;
 b=LczEePvalP3e1Ngv/1yAjjN6FKU5DfkMV02dSY8D0Fvci/hFU7Ym1kv+scT4JdHT4HjQfr3GC/Rw1JGgytL706tys32eTibkaBdxSOlAyc5j1qZCvzUDbNowS/X37KtBOdA9JXIqHhlyJdLw4m4kh9eCekAVQVvpjvEbxHrzxikMKAwB9oDfs+78u68JjQ0fm7e08ANTIkJo5hm+NDMBs9GliqJzI4wi9Ac8ZGjoY88RXqn5Ae1W9pKWxGvHfp1rzuGozrJd4XrW8dRfJl34feKdCsQaXXUV+tKwBC2qjRQb41l34Tfxw9CGBtza9xRPyVBX8nrpN36eN5cx9do0cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztZSIXlxTjUHDcn1+YkKg2QKSPo06WDLuYWb/uHUzB4=;
 b=VeFmRIYEQbtx4Ofi9kC0g57YQYT83tVHqzVFNOduOzIDTicSNoxQkxiQ4G1hoJz5XxItVVGkXPivTijmPIB+ElLG4MmjM6RLbVXIWxnxmsVJE/j55xgb4/ImMfAIN105E8egM3K+1CxHkZbI8zZ4scCeJc0Krcj/pOAAoKOFiig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYCPR01MB8342.jpnprd01.prod.outlook.com (2603:1096:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Tue, 3 Mar
 2026 09:22:17 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9654.022; Tue, 3 Mar 2026
 09:22:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 3/9] clk: provide devm_clk_get_optional_enabled_with_rate()
Date: Tue,  3 Mar 2026 10:21:34 +0100
Message-ID: <20260303092140.12732-4-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-Office365-Filtering-Correlation-Id: bbc8a79d-faa3-4b8c-c729-08de79065d2f
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	hiWGH8OmSDXzj38Qn0vkGP6pA/f+pQcJAF7AEyUzm1WWkbj5n55AOXUgwccaxlHfjFM8ULA1/wlyxIFQ5vwQpVIM9BAWkBuZbetBC5lWKVIGT0bKbTHl/tfOa0j0x5M/GZ+4e/K3WNPRm/i/SyKQQyl8htTJRJbxvBe0wqCDQiHZFrTwToNle2k9WrHaIo/wlzdETtwjXqsjb2vsgVUgcG8dN/4P17Em53TIyGd2WKr/3n5mOhfcC0ASeUWa37ca/bx7MbJSS2/RbQMDaGU0t+ucQqfFk8HGfF3ljz2BOOoWQU8/8/CuTNe9ruzhwqdspEFVqv8/UjBG5+Ely1v60SWMwXcvU/9FaAdg0nPcXL+okuH5B2yijtqFoRrDq3Eq6DExK7AnqbB4UNPyD13zflBuGtlBKc5j9sIZe9m4HIRKPGqcZHcwrdII4edYRa/QrSWZXWF21X5e3JG77a0K9Bk/tnl5S2q5lB8r7LeQlct4UWAtuvtZEKnYyEumiDuR3lr6NgmEToUiC8ArOZYJ2UFCMqaZopIB9w8vEW+pVlW3YIUPvmGlxgylHd23n6zOGOKXXlHZeJAri2L7ABwdmcML+a+v6/+OqywOO5jQojeUSfTv/5frQsc6OIiVaCtsHmTUeig0Cq+8AaXkKO178yM2N0uZNIE2nkqJ3KmNaAtyyxR4DOawnPQZy9c/sIZGXAKbTKC1mLFg8o1obHA7/Iku43J3Cfx352gqTjJTziEhAwvD1gR52rzzkes0BTLBeMLMn2jxmdz1KtVNB0jK1nlGpxjyNqs5+9Gb2TBVNX4=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9wTE59LAZMAPl8pRg+vB0lWhscHmaQjHZ+4N7Shsx4VWomw9vq5svviljEp1?=
 =?us-ascii?Q?emnjntY3qurnrbHcozpsNUM7ihNfj454SFmPIMNQ3BT+MppuojAS+wPQP3yY?=
 =?us-ascii?Q?A4aWFxcq/62f2Mmxge53tO/7C/aOxHexTfDHTZTzBGwKpkAniUrTXL8Qs/wa?=
 =?us-ascii?Q?rA7DUSol8TCJh1jfXTr6880xp11KQOk8aSL52rNO1WEBu+FF3K7u8SCtaAYL?=
 =?us-ascii?Q?OitdI7qVEMjbc0+n9TneWbyaUk72z+Ckl0lS4COIt0Uvpvso1usIX1MuntIG?=
 =?us-ascii?Q?8F3s9LbZJbAdE2C+CsJLeE0x447S2Z9q+6PiCXdiCSgXDWHEyR/0rbvidmpb?=
 =?us-ascii?Q?asO3vOFwpeiQIeSfwrcYEGJYz2srfD/puGvKhBsUpz/eggu/TotbK+kCGcJd?=
 =?us-ascii?Q?haHrjIvD5cq7Sh0N7Hv08rBFcN0101HifiMWD1V5e7dtDzLOZfX26hy0/p3F?=
 =?us-ascii?Q?OrwagJXecpR5NNeZHcaVUev6YqNm9ykX+MCsNPAnkKGePTJbRv9Tn4j6Nuvn?=
 =?us-ascii?Q?enb1Eu3dnYM7Xc6M8o/Fk0suNdAbEDXDnPfsEHsKSCLUdzAEWhyxwNmVsFdP?=
 =?us-ascii?Q?uJGzWMb7IsjU4lB3+ugp00QfMXA1sd8VGs/DJsSmJmCKqpYNQB3ovob0DKL7?=
 =?us-ascii?Q?+LanC5BoxMZDsitWAXSVzfx5HYa424CMaudw3HwDB5rTF61NXng4IvioPmSr?=
 =?us-ascii?Q?USTEI61B0yWrq2vBzaGc6cd8EA4h13Yo2oUj6XyfPAxT5js/SpU+i/uqxXUn?=
 =?us-ascii?Q?kYRtu9kjRgIuWBIYaru2XAxFVAbpQ1FB13Rc8wI00WSu2VBZhxs2H4fVxZkU?=
 =?us-ascii?Q?AOjzIkg3UsIl4i8T7e5PK+Y424Fdb/Kc3S57dgCR8rVmRsyrWM+iYki/2PGB?=
 =?us-ascii?Q?F1OCic9uCRxor2xquDY0oP01owyPAWyl8dCRxxSvlp2v/omlmxioZ9EjXMPr?=
 =?us-ascii?Q?vi2RSLYyg1aRMpS+CuaJi8ouVSYocCsRlLMFzMX9rQXW0yLdjPHnKJeA6g+/?=
 =?us-ascii?Q?v2LwOSkgMKWjmSgesXlVLJCjSNJkj4LQnYnOnNrXjb9/wWsxO9JslpVYBWWu?=
 =?us-ascii?Q?KvgPy/FRIC8uY3wr79rlUVA8yK8S0w1zLXfHjWjrPU0/pC1uz+wpeRTqvtYq?=
 =?us-ascii?Q?Hnivi/Si0luFb+EC4olTwZ//6nEona3z/RpXPY2bt0HJ2xIc1w1HERyI4QVX?=
 =?us-ascii?Q?IlQjP7UPu195Sshs7XKuNU90PRm9ZrGgXu5e5nDnuL/z6G8OdLWnDza6d3+G?=
 =?us-ascii?Q?KwaNEPaSTfOTwa7xdSBhzTeazuPSSIdh48/5kUkiGIROkRDg6SIvZ2WQ1+nB?=
 =?us-ascii?Q?dB2gWTpStiZbUqbXMUX9BlSMEBYA/mKz4yzHGEdYO7PdKd2nk4hfb6zrf9ha?=
 =?us-ascii?Q?ojLx2O4SCduLlwjzNNQzHSIXqdmbHQyro99w6HTM1KNOu6qOPNFOtCY1L5m4?=
 =?us-ascii?Q?wSkGMH7RJfxfjWMjWjYF7Ngn447BZnE9Nh2KqHnfBHFzTKFBlvUe/vFyGdFi?=
 =?us-ascii?Q?54ipjJ2zlOz7uU1ZUbb0J1EZha8B4qKT4QDYf8e7bjkrm70eDZhHDikmZwXd?=
 =?us-ascii?Q?QpL6sEhAV65oRWc8fC8+ofBE1B/9/riWZtFncm24Be25BCKYIBsrDeRyfctv?=
 =?us-ascii?Q?OWvoDUL7Hjj2WWhNddRoiJC5bolFBcwR5Kj4KxCqI+O0YyQ+89x6c8n6Gy4r?=
 =?us-ascii?Q?6BLQiDhdRb508GJi/mSe7vJ9QQ9iat+DdkUgGrXZqAsyF606s4taN2yZFvdS?=
 =?us-ascii?Q?Cnuhs9rzhs91obfIrIRf1i50jPwe/ec4CfBWgxqrvF0X6CZcU0SP?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbc8a79d-faa3-4b8c-c729-08de79065d2f
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 09:22:17.7369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DX39suRgk28SGSs0cbrtZf3pfXMOMTCulOFMthm4KpAPRDIIxsI2PEbNNYQpaRLEIQ1+6skr4i0N+OVv+BpEqlegU5SHO5TxzCCX0QKJQblobq5/keg2GLHTmRWbktpe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8342
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 03 Mar 2026 09:22:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22044

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

commit 9934a1bd45b2b03f6d1204a6ae2780d3b009799f upstream.

There are clock users in the kernel that can't use
devm_clk_get_optional_enabled() as they need to set rate after getting
the clock and before enabling it. Provide a managed helper that wraps
these operations in the correct order.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Link: https://lore.kernel.org/r/20240805-clk-new-helper-v2-1-e5fdd1e1d729@l=
inaro.org
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/clk/clk-devres.c | 28 ++++++++++++++++++++++++++++
 include/linux/clk.h      | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 90e6078fb6e1..82ae1f26e634 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -99,6 +99,34 @@ struct clk *devm_clk_get_optional_enabled(struct device =
*dev, const char *id)
 }
 EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled);
=20
+struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
+						    const char *id,
+						    unsigned long rate)
+{
+	struct clk *clk;
+	int ret;
+
+	clk =3D __devm_clk_get(dev, id, clk_get_optional, NULL,
+			     clk_disable_unprepare);
+	if (IS_ERR(clk))
+		return ERR_CAST(clk);
+
+	ret =3D clk_set_rate(clk, rate);
+	if (ret)
+		goto out_put_clk;
+
+	ret =3D clk_prepare_enable(clk);
+	if (ret)
+		goto out_put_clk;
+
+	return clk;
+
+out_put_clk:
+	devm_clk_put(dev, clk);
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(devm_clk_get_optional_enabled_with_rate);
+
 struct clk_bulk_devres {
 	struct clk_bulk_data *clks;
 	int num_clks;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0f44d3863de2..ca0fe17827a5 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -623,6 +623,32 @@ struct clk *devm_clk_get_optional_prepared(struct devi=
ce *dev, const char *id);
  */
 struct clk *devm_clk_get_optional_enabled(struct device *dev, const char *=
id);
=20
+/**
+ * devm_clk_get_optional_enabled_with_rate - devm_clk_get_optional() +
+ *                                           clk_set_rate() +
+ *                                           clk_prepare_enable()
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ * @rate: new clock rate
+ *
+ * Context: May sleep.
+ *
+ * Return: a struct clk corresponding to the clock producer, or
+ * valid IS_ERR() condition containing errno.  The implementation
+ * uses @dev and @id to determine the clock consumer, and thereby
+ * the clock producer.  If no such clk is found, it returns NULL
+ * which serves as a dummy clk.  That's the only difference compared
+ * to devm_clk_get_enabled().
+ *
+ * The returned clk (if valid) is prepared and enabled and rate was set.
+ *
+ * The clock will automatically be disabled, unprepared and freed
+ * when the device is unbound from the bus.
+ */
+struct clk *devm_clk_get_optional_enabled_with_rate(struct device *dev,
+						    const char *id,
+						    unsigned long rate);
+
 /**
  * devm_get_clk_from_child - lookup and obtain a managed reference to a
  *			     clock producer from child node.
@@ -965,6 +991,13 @@ static inline struct clk *devm_clk_get_optional_enable=
d(struct device *dev,
 	return NULL;
 }
=20
+static inline struct clk *
+devm_clk_get_optional_enabled_with_rate(struct device *dev, const char *id=
,
+					unsigned long rate)
+{
+	return NULL;
+}
+
 static inline int __must_check devm_clk_bulk_get(struct device *dev, int n=
um_clks,
 						 struct clk_bulk_data *clks)
 {
--=20
2.43.0


