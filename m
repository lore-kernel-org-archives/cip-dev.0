Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5A6C36016
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:01 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.66])
 by mx.groups.io with SMTP id smtpd.web11.48796.1743417954692865107
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:45:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=IBP0Zg15;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.66, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i3eJUsYN8/jJMzzi6OZEYaOa0HWNkufNjFwUxc69tZS82+zTdDl1ohZ1AJ5yaVAcwdmjFPiFrBtyHZvUGXoT9VVuQ8kw7gy3pRJ4V/EZSsNPdHMnMkgfbUIj3SheVYkin4u7Xds7hOvAB2F0M0ZY2Lpf5tKCxLUVl/qxTv633+wndxK0tUjJ+k9U03aXadTGRMoiknR3crtd6xUrgQCn7RRU6pYOSmO1k8vu5gTXA0v3Ao5yzSceGNm8bAf9gUY56V4e6L01hbIF/IrWiRnlCz2aBjr6V7ee8IzI5w117Zjv5URl7+4ecq0J9nLRYy+l/EloubwQAKpwdsEG/I9t1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckwsI8omIklnIVL+1BijMVOBBPmu/THcahKWDj4nRhw=;
 b=YhL1dY84DQPPB90BrPJMT2UKn2RcyPoxdyDBnmi5RSVKbNPlDPPnffi262BRKLjpO9NyeL0tc5KbGXgwlPFeVw1MeBZHEkE4pH0LcBvTaQR4CbIB2KnAZx0usKEpnmciIpoetr5gQ14qq3fBbxeOjukPXygKxEZOao6nctXb/SBt4GS3mIAPioH3BgF8dZDvO3o1eLwb99+SouVfjbuxNyoa+lFFcNeUtXAn0FAFO4zbYPBbLQ1wYWgfOKqSsxBj0R77uXpmOaHfKk9r9uw0iSr3raHG+7Cs/8rKXo/vEOtB6WOIreY/NodfTTkjszvoYhfsdy2sPaOSqLuPXxxo5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ckwsI8omIklnIVL+1BijMVOBBPmu/THcahKWDj4nRhw=;
 b=IBP0Zg15N+nefgZMkuRtI0oOw/G4QmeMlYqwaXYTn1q6lYMZ+M7WTdU5oPKwlfosM+50IJoOGdnR/emLjqhWSZhJoSo+DPTvHDTsWCyBbdUUjIXKw4dmbiyb/WnshXPPms84F7yHlqBrTUjcIkHfGIEQUu1Y4ocub1Zn8VXvjws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:45:52 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:45:52 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 07/43] pinctrl: renesas: rzg2l: Allow more bits for pin configuration
Date: Mon, 31 Mar 2025 12:44:38 +0200
Message-ID: <20250331104514.79090-8-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: bff5b341-68f8-4239-353b-08dd70413513
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?oUrcqhdhRHCTNvoRrHKsz9taSBmUELuyte9OIi7AdN96PDYUmodyrEFK9/wl?=
 =?us-ascii?Q?sAl5jeqeg/Eq+XDQvV6iyWTOE11zvMgUaRSvtvgCQHoxuws08dYhMFvGlECg?=
 =?us-ascii?Q?kveagrr12Lu01CavM50zRZx4TZTEdjDwIzezW+aXQoSwA8rgKsTbOVNUPvNs?=
 =?us-ascii?Q?O7zugC2uq7YiFTWU0ro/sOLT/hl8KmomaoyfYU8K2+dbkG3EdaND32m9Oblq?=
 =?us-ascii?Q?7oblrGbrhzrWphFgYH2oriLoDSpT40eBpC+GXmlhF2STNF7sQttu0NMrTeV3?=
 =?us-ascii?Q?4XrJ4Oj+iZzmbv+1IR2P4Jtxsc7WSqlxW1ASR3r2F8ImVu32aN2hSdYWc54A?=
 =?us-ascii?Q?6VyRi4ykU4PC1QVVX5e96yzB3Y0xVWQZNtoo/9ZteASrpemVAJhVzsb5pZrE?=
 =?us-ascii?Q?PRMOqkjOrVGxqprYwOYSfOPUB5k6Anp2atS5ETIfhmOq6YRSwCer2fq2XTZv?=
 =?us-ascii?Q?qoGUsNtqJV1qEyj3f8HLVyTOSyvvTx4jCkmNETCUcFNfrixXPy4yjyDCCB0c?=
 =?us-ascii?Q?wxhAXcs1UvbkY9o+zT6cpFr1bacua7Vhn8c6XbjcZbs82m1ixCRphEDl0c1r?=
 =?us-ascii?Q?A8o/CWIiuimv+IveMZRGBhB+hwMzJdWG6tVt4m2uYEWXSxd5eFMin4B+94j8?=
 =?us-ascii?Q?C8xmo/5Pry9FVBOj4H1XbDpyO2bKJZ05PT5Wrw3aa402vPxrggJs+YGXhjwZ?=
 =?us-ascii?Q?0EZo66ppuObdl72xX0ub237F2EiFwyz/2PBBV9GJe/hHW6I8FuvLbWEb8yZS?=
 =?us-ascii?Q?btkO9R7YRj7NpJo5Vao6JMkQp4+8+ljaaAinGvZ/oJEC1Pr8yOSNLgmFNQg9?=
 =?us-ascii?Q?qGPOii0ZNmW12Kh8yK0Za2NGaJeDDwvxErEvS+vXvyAYWD1jkjkceFmYmNJC?=
 =?us-ascii?Q?aq5t7FdGCKYiVTRplaS3BUNkZ1kmut+gn3CNBWxohxifs1+L0rlwdeFWm1fh?=
 =?us-ascii?Q?cAofEgEDpQIVEjAQs5yNYlj/YBp0SaL/NQ3x6EPaPAtl4DxRgRKcSxH7gxpU?=
 =?us-ascii?Q?wdnkcIUCKwHgjzxxfdr0WxvJL5C0jzZ9lbsy4+s1EgnhSY8S2QdRZoqgCX+Z?=
 =?us-ascii?Q?m4Zjc0vurjVd7VRzbskSlPPYt/RBzBv5Mh1FrWcayip+m5I4BabdOyuM7Hs0?=
 =?us-ascii?Q?a3K2t46Hx+eMfXspipN+CKRwsoAkwccB8xABjR/7OF9nIoMQDG5uxG077Noc?=
 =?us-ascii?Q?CCZCpW7hy+2K+wspObOKKFslw7qjkLuKQ0GSXOEZiGslzWqXvLcqc9l9P+In?=
 =?us-ascii?Q?jBZcAUtCydx/e8imllmB8CHyb3tTYeE4iFcbZcmz4XCU+qgBicHN27xSmJUA?=
 =?us-ascii?Q?LaasHEV9my7QHH9XUlOg3D9OD4VPoB/jCehwCFtdaxwFzpyw/nTKuhCu9APR?=
 =?us-ascii?Q?lpvEDITyJW+6fOUY8X/bb3au1n9ok1wsBh1cz0hO7jgshcCQ1n72nkqT/XzP?=
 =?us-ascii?Q?nfZV608dUD96EGogTN1w9Vrhtctt7X4t?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?wErG1srD70+MOAWkelbdnGZoVg7h9jbxmbXbFJMtvd2sGuGwALRt8KmPd4y3?=
 =?us-ascii?Q?TN2hcdlnQ20c1NU/6VyF/id7/ESnAc4DSKL9EAI9xKyAh8XirxGkmIVmSQuK?=
 =?us-ascii?Q?yrvgY/ELlxEmtJg9PyeVv31qmJPRLTjJr0EONgPYrTr9YrdSXNXayjYsvMzB?=
 =?us-ascii?Q?vT0de+Dn+/WrXc9nS6JLvzd9i6fgpSKhWhYKqF2YQzHQQkCdbwsgeGFYKJQK?=
 =?us-ascii?Q?ACEwRksq5hn3lsCKaqMm8+w1pSnBHGacS8XDpT8iuOyT0673CDqRsl8WuapS?=
 =?us-ascii?Q?Lvrn19kXWTwqjz2kMaUa7r4A+4MapOPJ9S+ixrO9GKXqioIF4xPZjA3fp5H7?=
 =?us-ascii?Q?qt6pNBjGLotASjhlPsUgDIG9cUZIjYrG7vN/nCVgRapcrgg4kUQNID3pVzWb?=
 =?us-ascii?Q?vv8x8/9+VTeIpjy0WECew6FFQSi2adJVNgRHiFbF1etNmy+oFgosQhZg/ulY?=
 =?us-ascii?Q?wfWCY/SpG4jrApIY7JlQ3De/a+kotWDMiqbc7qydV6AE6hLozmBOyfmCXM/p?=
 =?us-ascii?Q?DTG9NbsM4N+pcZm0O2RPGcVFyYZZRsy1M+EVwmW9UJ0GrjXH8Iti9YATme+i?=
 =?us-ascii?Q?wLT5zpNwLaHISM1QH1e7bBVXizFuOfg/7gQQdyR2KJvBBtDZiWxYQQZ7Z+jr?=
 =?us-ascii?Q?cCcrfIEK+CvwufqJ7LAYYS2R2kYir9tGtVbFQV6VORXlU8vA5w4L93hMIa3+?=
 =?us-ascii?Q?DoeimPfQfm6QwYH0uvB204MdaJCaxFSSR8R2oIOPqn7kVjT3QhZr44adTjaw?=
 =?us-ascii?Q?kz+3tr3HLxxDB3Fw8mulMHl6B/hKFLEEKSxuz70FOr4J8WSJaUQlqE4wWkeI?=
 =?us-ascii?Q?BgjWUS00CAXhzToeA0zvwm+Sa2wMviBUMwfoqLGUd6rDivMNznYBpGVxTBXX?=
 =?us-ascii?Q?oGaBUjTCvuClM6sp52indPD1TogbH10HgNiHjiz4TU1ckmbjEcPQqx5Gfmr7?=
 =?us-ascii?Q?wpjpwvYmNw72JxCkOsacA7QaVvv8Tb0EObs95sX1xUOhP5Xcre5StnnMKQCo?=
 =?us-ascii?Q?AP6VdphIIdPaO6cjVJfNh+yCVtbBIc1d4roz5C8C0Bs+mvihYOXVM4kh9upu?=
 =?us-ascii?Q?7ll7ChuH7n59qXkgivRUHYvgl09TQ38VPp+bRrUPemZxkcZDetagm4CKU3X5?=
 =?us-ascii?Q?+TJFQ7Y22c7jrQxjmXFjLc8BIAFH4dNTZKkOOJif4YtS0DtYPlQP0eW/+jje?=
 =?us-ascii?Q?6aNT9QsQpaLyW20UW6yO/7rcl1k62A54V9qaSXb77a19sOD/0+keOGEeMLZY?=
 =?us-ascii?Q?su+Kj2BD7k+uuUOwjFlbH7ZV+uv34c1LnJ0sgcLDAHVOmPzRiwHlLjCkN0ww?=
 =?us-ascii?Q?zEZmC8xVasN7Uc3L7LAMpBv7lDLy6J/DijBzVgCpSGSzEn9bCayRj73X4L1+?=
 =?us-ascii?Q?iM0E80DEhz984eumQ/7uDgOW7PbBjfyuZWl62NxYYeD7TxIcytWgveD12axX?=
 =?us-ascii?Q?7xBqDHfbI17zcCWC3NAIwCjEc51bCW04mwCpoLXQ2lI9f2S0Aa8QrpsH0PnE?=
 =?us-ascii?Q?FtzsP5IrRYBaS226xkX+hhQbGPhdcivU0SgQOJ69+gKzR631aSIetoibCAfN?=
 =?us-ascii?Q?o4dJuLbX7qQt1AYjgoxtKdIkHsMBjAT9N7QRtvs0XyIRcg7msR+58HS5hpvP?=
 =?us-ascii?Q?PYp7isdUdukbWeNT+wmiPPw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bff5b341-68f8-4239-353b-08dd70413513
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:45:52.5673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LGYCp3yAwryuUeDAj6XOqgE1drxkYfCs10SojhyXcgPU0KTGSbkAp7Iy1HF9ybTvooB6QbbECkDEd2ZgeSDUjO9Q+cgW3sDkzuZL8N1lkWCnJvtqRi/hA/TlDxRZc1oU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18395

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 8081a03793d3276c50d55a6f561872168eccf944 upstream.

The pin configuration bits have been growing for every new SoCs being
added for the pinctrl-rzg2l driver which would mean updating the macros
every time for each new configuration.  To avoid this allocate additional
bits for pin configuration by relocating the known fixed bits to the very
end of the configuration.

Also update the size of 'cfg' to 'u64' to allow more configuration bits
in the 'struct rzg2l_variable_pin_cfg'.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-4-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 30 ++++++++++++++-----------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index cbb4780fb2d04..33eff02c6206e 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -77,9 +77,9 @@
 					 PIN_CFG_FILNUM | \
 					 PIN_CFG_FILCLKSEL)
=20
-#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(35, 28)
-#define PIN_CFG_PIN_REG_MASK		GENMASK(27, 20)
-#define PIN_CFG_MASK			GENMASK(19, 0)
+#define PIN_CFG_PIN_MAP_MASK		GENMASK_ULL(62, 55)
+#define PIN_CFG_PIN_REG_MASK		GENMASK_ULL(54, 47)
+#define PIN_CFG_MASK			GENMASK_ULL(46, 0)
=20
 /*
  * m indicates the bitmap of supported pins, a is the register index
@@ -101,8 +101,8 @@
  * (b * 8) and f is the pin configuration capabilities supported.
  */
 #define RZG2L_SINGLE_PIN		BIT_ULL(63)
-#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK(30, 24)
-#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK(22, 20)
+#define RZG2L_SINGLE_PIN_INDEX_MASK	GENMASK_ULL(62, 56)
+#define RZG2L_SINGLE_PIN_BITS_MASK	GENMASK_ULL(55, 53)
=20
 #define RZG2L_SINGLE_PIN_PACK(p, b, f)	(RZG2L_SINGLE_PIN | \
 					 FIELD_PREP_CONST(RZG2L_SINGLE_PIN_INDEX_MASK, (p)) | \
@@ -240,9 +240,9 @@ struct rzg2l_dedicated_configs {
  * @pin: port pin
  */
 struct rzg2l_variable_pin_cfg {
-	u32 cfg:20;
-	u32 port:5;
-	u32 pin:3;
+	u64 cfg:47;
+	u64 port:5;
+	u64 pin:3;
 };
=20
 struct rzg2l_pinctrl_data {
@@ -1081,7 +1081,8 @@ static int rzg2l_pinctrl_pinconf_get(struct pinctrl_d=
ev *pctldev,
 	const struct pinctrl_pin_desc *pin =3D &pctrl->desc.pins[_pin];
 	u64 *pin_data =3D pin->drv_data;
 	unsigned int arg =3D 0;
-	u32 off, cfg;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
=20
@@ -1185,7 +1186,8 @@ static int rzg2l_pinctrl_pinconf_set(struct pinctrl_d=
ev *pctldev,
 	u64 *pin_data =3D pin->drv_data;
 	enum pin_config_param param;
 	unsigned int i, arg, index;
-	u32 cfg, off;
+	u32 off;
+	u64 cfg;
 	int ret;
 	u8 bit;
=20
@@ -2413,9 +2415,9 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2l_=
pinctrl *pctrl, bool suspen
=20
 	for (u32 port =3D 0; port < nports; port++) {
 		bool has_iolh, has_ien;
-		u32 off, caps;
+		u64 cfg, caps;
 		u8 pincnt;
-		u64 cfg;
+		u32 off;
=20
 		cfg =3D pctrl->data->port_pin_configs[port];
 		off =3D RZG2L_PIN_CFG_TO_PORT_OFFSET(cfg);
@@ -2459,12 +2461,14 @@ static void rzg2l_pinctrl_pm_setup_regs(struct rzg2=
l_pinctrl *pctrl, bool suspen
 static void rzg2l_pinctrl_pm_setup_dedicated_regs(struct rzg2l_pinctrl *pc=
trl, bool suspend)
 {
 	struct rzg2l_pinctrl_reg_cache *cache =3D pctrl->dedicated_cache;
+	u64 caps;
+	u32 i;
=20
 	/*
 	 * Make sure entries in pctrl->data->n_dedicated_pins[] having the same
 	 * port offset are close together.
 	 */
-	for (u32 i =3D 0, caps =3D 0; i < pctrl->data->n_dedicated_pins; i++) {
+	for (i =3D 0, caps =3D 0; i < pctrl->data->n_dedicated_pins; i++) {
 		bool has_iolh, has_ien;
 		u32 off, next_off =3D 0;
 		u64 cfg, next_cfg;
--=20
2.43.0


