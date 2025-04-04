Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E0C1C3601B
	for <webhook@archiver.kernel.org>; Fri,  4 Apr 2025 07:39:11 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.11])
 by mx.groups.io with SMTP id smtpd.web11.5805.1743752349177856105
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Apr 2025 00:39:09 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=nqv69L+8;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.11, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qyWw8eRgnlFTX592gvgAAJROHqV3MqgYNp5P3hJBVVFew0f5lDc7L7u/5Ve6rcogxYb/lBIgE0O/LwC9eQ3weTSOmxbYL3kk2XFAJSCj9y/mHBqbHU+Crlx9cD4g2yV8stCNQ85IhKQtvC9mpgmLHB287Sw8ThrBSGbqR+nVDVfToC3WaWPbIDoM/4CPNH0Bwmt8JFk6W78coR2yvWBruQSghvRPe5/xH8CNVGiG42pGM3VZ5I5EJklwczKxneouQb90rVJPZb77tXP31AWYYxpm/UTZg9srQcDQNz0yVPQy8XC54P7qvcv21W3Pc5c6VrHbPXEO0OAoyJPUgvxD/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV55CyQeqj+bIMDX3pPxLJfKOlHzohSG8tYeToP3qsI=;
 b=LI5HMqHE9Gsgi0sVNcpq8GNYj5LbGlMiM+LQmqH28JochLNKG+y5WqmO10xza+Axo5EmWLscJR1vJGNpZrbQQ1JzJCsnpYnVLPKk0I3IyWjfHcf4CMZfL9xPAkglfVZUVm/LbxyoMteta2rsMtCgL+5cu4mrUOoymCFBVKKTsjkF5pZsUenyeo+PQXXcbXYeN0IAyT7Cr395Aet2JHZxyRUBIqEHCQpS1JL8rwbcm6mtF2JT93xI/eRsVl0Tgxe2HH9A9DeyT/3pcpdZquGvKRRp9Uxq4kbvygKjWsrrYIt1fPmme61F3JwAhitFDJdK4UawIQTsUHdETkvEzjPqYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WV55CyQeqj+bIMDX3pPxLJfKOlHzohSG8tYeToP3qsI=;
 b=nqv69L+8vbDvvwO9nJ5B03JBg1n5WSJjjb7asL8FUJUI3SqWG9orFQm7GZb6wBC0dZeT3ft2EnPVnUY/xKVe83OfvlDmsU7HmJEWwsgaL9NQ8QNzMaIsvBkSLr6F92TaTp/cSk5xc8VlG6ZNy/Z2d7fGNhbXJJLimXSOTsLE0uo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13254.jpnprd01.prod.outlook.com (2603:1096:604:313::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Fri, 4 Apr
 2025 07:39:01 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.038; Fri, 4 Apr 2025
 07:39:01 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 6/9] i2c: riic: Introduce helper functions for I2C read/write operations
Date: Fri,  4 Apr 2025 09:38:16 +0200
Message-ID: <20250404073819.173272-7-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250404073819.173272-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0438.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13254:EE_
X-MS-Office365-Filtering-Correlation-Id: 729df19c-1bfc-4af5-780a-08dd734bc479
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6I9bKY615LtoRnh0XfKSL2NlXIrS9Iqvl3ClaUfLp2HSOc+lt+qOK9jjAi90?=
 =?us-ascii?Q?uDqThREVMGaY+kzIh5cdNf8TDe8NmKi7bOIF8KXvh2oMrUVmUlNjQdBRJ2/V?=
 =?us-ascii?Q?ZmrQQIF3pfCGS0yLWuZYJG+LalF/PAZf36dcDAXkF9sDY8t57lBo746kFxfl?=
 =?us-ascii?Q?Bc7tmLvqQT99HbmoHx3ajGbeCySf6TH7IiyLAyuE8k8uxQ3YJjGo543sXSqr?=
 =?us-ascii?Q?Ssl0Px7EflTbV2EW+ObQBTv7Dq9SAJls/vgtoO85N5ep+Ff2+703tQtANxGr?=
 =?us-ascii?Q?MJMonyhwYv4uj9rkMlsSVDASkeOp4FPbZLpSbX9l64EATqshERiBmAP7A41I?=
 =?us-ascii?Q?mKp/l1J50KXMyz1UuOCmBYtOVIydidwmGZri0cjipLGcBIh0sxO4CX0Wqxgn?=
 =?us-ascii?Q?e8Vxm/vnM+tsoiJX9qcxpqukElIeCX6dWGHwUeMXxL+yPG1tU5X4fBxcu1UU?=
 =?us-ascii?Q?hsr4GOXWlCVzKiZJCy3UpDZD2lF5DZLGxUPS+YXeA/FtOtLsPKggvUS2906M?=
 =?us-ascii?Q?yb8mxWA4bnR8jZ2hNRdh4fYBSPCg/F+iJE9z9KOh1Y0lSELFkl/3etTDwvyf?=
 =?us-ascii?Q?EUa+WL9P52sLinfImyiqk/oXVsr8Yv+7CaDquUDcrrZhzrNmSsQHwm7uVWh3?=
 =?us-ascii?Q?1EVmLhY8FzW+PcyDhX0uvLPC+uvvMq59fKzyJ7PCwLYq/SLl2w9vTYfaERDe?=
 =?us-ascii?Q?Yzi/nQ3xk+XGU8jRqhZ4SQGYMR8ehstdlcoFVKV8cKzfW9T8R1DIeMHpXlCP?=
 =?us-ascii?Q?MMH6+8d2pFm9fa08BArGYfU0F+EaZWC2h0MaShDhA1VL/LYndNTWVC/3NAiQ?=
 =?us-ascii?Q?f+Yz3BYlyqCAfFmUNMDTJlIibctcpsokBBxtTf6GLhG/DAoU8iR3Zj+6odUM?=
 =?us-ascii?Q?73IVGLW/ZQyf9R992/tHApCIfbf6STAn0lVEBxjM+pfJT2nQFuH8k1+ykFji?=
 =?us-ascii?Q?HS8ziGAyWwmHBgUvmkH3s9u51/wbbuhiOkVQVE1aDUyEoBL+IvRr/lNSFQ+u?=
 =?us-ascii?Q?yGDit2/+4CKdqwnklv+C2eRng2G/ETEi8cLlB7GBlkrmQHdEmFE+/8p08gUy?=
 =?us-ascii?Q?nHzWZ851+ICXahFLfTEWfG7L933KOeALuH+TrxFHX0UuVZ7o6ejqxsKLusdI?=
 =?us-ascii?Q?Q3r9aJj0mT0jHk6BhFvGQfdwJ6F3VuBIRsJpFZzDNEEMr4a9QAQRTF3AAkeH?=
 =?us-ascii?Q?MAux8+e1bYy55l0rq9XxqGr8/6PjoVU3iUoPIzwRumvDmrX0OoQn5MW37O1C?=
 =?us-ascii?Q?drILwhFFqPmILCri7jc1Yi77PZAg2xyVPK9kI36zjM4yf56OQKckCjA7k+Ib?=
 =?us-ascii?Q?CmU1w4s8EyNnJirdIAUqD53IITmrguz7j3WyBnc04tplowjfF6GmBZ5xFDj+?=
 =?us-ascii?Q?Nm34WWzV3MokZyiSSProHva2O2OElraufDnmXj90QWL5IlRiW+u7LnicY+Kv?=
 =?us-ascii?Q?PWREPAPjxmnDPcMiyztBzJ7UcbCs1FW5?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vEcXe1kSW9c574yLJ/0NejAhWegTfR1K6WHEYgjKCeWqNWU7Me0r6GpeSebn?=
 =?us-ascii?Q?oQEnmEw6qkyEfZJJyv9wlbcMpNO+T/vQILBjSSjwU5ru46VEIRaW9C2I45RL?=
 =?us-ascii?Q?QBVEaFR50yoDWuW7j0dnq3MmuvpOykw3xgNub0i3vdlsqJqV4vLBHKrP1c3C?=
 =?us-ascii?Q?QUABeqAk8IJvq7OOK7maD0Dvj9JUphkRBjPwDGHRmlYp+S8Q4Z5qwM3kQXg2?=
 =?us-ascii?Q?XqMEZ1NUMFMrYlW1j7t9XbbC2sbWSyJyUQrlcyDLmRAc9pHgmY6hTP01CzgS?=
 =?us-ascii?Q?+TZY35bKBbaj0CrZyUxSGj59iZDOckUPUlB/5p4GeWwJkshxsUlofnoV2lhB?=
 =?us-ascii?Q?zor593VSvgs7EMQdDs3Jc1XLjzXhLql1BIz94Zf6WZtld/ULzvhbOQsjOiXZ?=
 =?us-ascii?Q?DNeGtyfIGDIaY6jndEqoapog6gKQLPRKROPQCqZcPUyMmv1hsPOfOIcPR7o2?=
 =?us-ascii?Q?AcifrjcWd5rUQSmgtQJuYNrKk1svOrNVSFsxARm7ebTGmX2OJLNRzS4I45wr?=
 =?us-ascii?Q?wQ5h35YN3N/b87owUVSydaigXtwISzqQk4H8wCMH8pU9hLFMJJKLCI0nwQ0e?=
 =?us-ascii?Q?zG4oQaCXHv7MLI2jIElyTbKOLskpmy9txLk4zBZbocE6pK3j9M/WOcu4uhyJ?=
 =?us-ascii?Q?j71LrRdkid+A8Z15qXyRJtyzPVHzTlY4q0IyUjGJARRWc32jX/fjbawO8aL2?=
 =?us-ascii?Q?CaHvHPNeSHC8QU8T2cAPqekvsN8LnQVg9adeB7W0tFiMyBtk+JD7zvJSQlA7?=
 =?us-ascii?Q?oBHQ/px+qblRnAREzKDGGSM8g1sbImUmWtB411ARdXRBpxRoyXGpghy7QViG?=
 =?us-ascii?Q?YAHtkpOCtWmP7bZ9GVa/8UGrRq7eayqdzODcAfQWMkC2w6a8NSIX4Nq0C/Is?=
 =?us-ascii?Q?4Mb2DJQJveGrTU0uMVMeoB/hrywp5dNcF/dmWPaNVdCNI1YP0HZh1zphgafH?=
 =?us-ascii?Q?2xt0UUcsJ9lSa4jZEi4gS9aTSVCSiDxuITWY0Z9HtoyvZ82c0RvucA9gXMBj?=
 =?us-ascii?Q?0sdpWEznyiSW8C8uEmiNJTv8DEU72HUsF3lDd03o7NyitoWjFyX0YV5s5Adb?=
 =?us-ascii?Q?o6m184J7HeMak/edmzj/c40zLTwp5tOHGlL5oCzLMqcffLcu8u7K1CjbzpPG?=
 =?us-ascii?Q?9mEr1cZ5QxxrbXPE9uJG0YDuf0hmmv1/dKEgyNFX9wZ3Rj+tfA5zvuhr/WCx?=
 =?us-ascii?Q?+S6R6qlu0CMXtIGGC4FXvvG7jkfdV74Oy70ohaCOf6mOcmIdTm2XKm5KWrod?=
 =?us-ascii?Q?5kng5My98OmbMwP0EBnGdAQfubjLN8spEy2wVbfJY0uWcijNg/23mulDdKye?=
 =?us-ascii?Q?jZQIKGrvvcZGcNZa2fbxsJHAL+QEk90in8AaEBIXtkLY8WiHLkj7rSVE6zJY?=
 =?us-ascii?Q?26Q54w+iZz7O8JODdM4HR77RrKUiJcuPrxXCQgEU+LgYOa2NALU+j57QLs2+?=
 =?us-ascii?Q?0rrUL2xjDnby8IgWBKM3KfzAQ48jbFhQQ76yIGT7Siksv7RM1SYU0iLMA8P9?=
 =?us-ascii?Q?2EAIQcrXsD8aWEu+MfT5OqjQhhfYS57/bGMx23NELEiTGsvQk44NkMnue0KK?=
 =?us-ascii?Q?tNz+FwpDJGqIzcwEMUhh6091Px4OB5JsJo9G9LNXYgDNQ2/Kvwx/AMCqTzgA?=
 =?us-ascii?Q?wpemllufRR9JAwRGpgivY2c=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 729df19c-1bfc-4af5-780a-08dd734bc479
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2025 07:39:01.3867
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qkFRui76TVGBSfgKhZYi2/FsYq+dL4ezYkCBfq/ZW7GkV7bcK4TKqvTIaxkPIDC05RusZEk8TpSziz2HXbCfSrOrObfojQIz+dVC3HxaoPcRgF2trT0IClU/30a+5u+q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13254
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Apr 2025 07:39:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18470

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 26c7871100f2933a2827b217320366e89cef5a4c upstream.

Introduce helper functions for performing I2C read and write operations
in the RIIC driver.

These helper functions lay the groundwork for adding support for the
RZ/V2H SoC. This is essential because the register offsets for the RZ/V2H
SoC differ from those of the RZ/A SoC. By abstracting the read and write
operations, we can seamlessly adapt the driver to support different SoC
variants without extensive modifications.

This patch is part of the preparation process for integrating support for
the RZ/V2H SoC into the RIIC driver.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/i2c/busses/i2c-riic.c | 56 +++++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 23 deletions(-)

diff --git a/drivers/i2c/busses/i2c-riic.c b/drivers/i2c/busses/i2c-riic.c
index 6f8ce656183cd..46fd6c249c7e1 100644
--- a/drivers/i2c/busses/i2c-riic.c
+++ b/drivers/i2c/busses/i2c-riic.c
@@ -106,9 +106,19 @@ struct riic_irq_desc {
 	char *name;
 };
=20
+static inline void riic_writeb(struct riic_dev *riic, u8 val, u8 offset)
+{
+	writeb(val, riic->base + offset);
+}
+
+static inline u8 riic_readb(struct riic_dev *riic, u8 offset)
+{
+	return readb(riic->base + offset);
+}
+
 static inline void riic_clear_set_bit(struct riic_dev *riic, u8 clear, u8 =
set, u8 reg)
 {
-	writeb((readb(riic->base + reg) & ~clear) | set, riic->base + reg);
+	riic_writeb(riic, (riic_readb(riic, reg) & ~clear) | set, reg);
 }
=20
 static int riic_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int =
num)
@@ -120,7 +130,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
=20
 	pm_runtime_get_sync(adap->dev.parent);
=20
-	if (readb(riic->base + RIIC_ICCR2) & ICCR2_BBSY) {
+	if (riic_readb(riic, RIIC_ICCR2) & ICCR2_BBSY) {
 		riic->err =3D -EBUSY;
 		goto out;
 	}
@@ -128,7 +138,7 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
 	reinit_completion(&riic->msg_done);
 	riic->err =3D 0;
=20
-	writeb(0, riic->base + RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICSR2);
=20
 	for (i =3D 0, start_bit =3D ICCR2_ST; i < num; i++) {
 		riic->bytes_left =3D RIIC_INIT_MSG;
@@ -136,9 +146,9 @@ static int riic_xfer(struct i2c_adapter *adap, struct i=
2c_msg msgs[], int num)
 		riic->msg =3D &msgs[i];
 		riic->is_last =3D (i =3D=3D num - 1);
=20
-		writeb(ICIER_NAKIE | ICIER_TIE, riic->base + RIIC_ICIER);
+		riic_writeb(riic, ICIER_NAKIE | ICIER_TIE, RIIC_ICIER);
=20
-		writeb(start_bit, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, start_bit, RIIC_ICCR2);
=20
 		time_left =3D wait_for_completion_timeout(&riic->msg_done, riic->adapter=
.timeout);
 		if (time_left =3D=3D 0)
@@ -192,7 +202,7 @@ static irqreturn_t riic_tdre_isr(int irq, void *data)
 	 * value could be moved to the shadow shift register right away. So
 	 * this must be after updates to ICIER (where we want to disable TIE)!
 	 */
-	writeb(val, riic->base + RIIC_ICDRT);
+	riic_writeb(riic, val, RIIC_ICDRT);
=20
 	return IRQ_HANDLED;
 }
@@ -201,9 +211,9 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
 {
 	struct riic_dev *riic =3D data;
=20
-	if (readb(riic->base + RIIC_ICSR2) & ICSR2_NACKF) {
+	if (riic_readb(riic, RIIC_ICSR2) & ICSR2_NACKF) {
 		/* We got a NACKIE */
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		riic_clear_set_bit(riic, ICSR2_NACKF, 0, RIIC_ICSR2);
 		riic->err =3D -ENXIO;
 	} else if (riic->bytes_left) {
@@ -212,7 +222,7 @@ static irqreturn_t riic_tend_isr(int irq, void *data)
=20
 	if (riic->is_last || riic->err) {
 		riic_clear_set_bit(riic, ICIER_TEIE, ICIER_SPIE, RIIC_ICIER);
-		writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+		riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 	} else {
 		/* Transfer is complete, but do not send STOP */
 		riic_clear_set_bit(riic, ICIER_TEIE, 0, RIIC_ICIER);
@@ -231,7 +241,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
=20
 	if (riic->bytes_left =3D=3D RIIC_INIT_MSG) {
 		riic->bytes_left =3D riic->msg->len;
-		readb(riic->base + RIIC_ICDRR);	/* dummy read */
+		riic_readb(riic, RIIC_ICDRR);	/* dummy read */
 		return IRQ_HANDLED;
 	}
=20
@@ -239,7 +249,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 		/* STOP must come before we set ACKBT! */
 		if (riic->is_last) {
 			riic_clear_set_bit(riic, 0, ICIER_SPIE, RIIC_ICIER);
-			writeb(ICCR2_SP, riic->base + RIIC_ICCR2);
+			riic_writeb(riic, ICCR2_SP, RIIC_ICCR2);
 		}
=20
 		riic_clear_set_bit(riic, 0, ICMR3_ACKBT, RIIC_ICMR3);
@@ -249,7 +259,7 @@ static irqreturn_t riic_rdrf_isr(int irq, void *data)
 	}
=20
 	/* Reading acks the RIE interrupt */
-	*riic->buf =3D readb(riic->base + RIIC_ICDRR);
+	*riic->buf =3D riic_readb(riic, RIIC_ICDRR);
 	riic->buf++;
 	riic->bytes_left--;
=20
@@ -261,10 +271,10 @@ static irqreturn_t riic_stop_isr(int irq, void *data)
 	struct riic_dev *riic =3D data;
=20
 	/* read back registers to confirm writes have fully propagated */
-	writeb(0, riic->base + RIIC_ICSR2);
-	readb(riic->base + RIIC_ICSR2);
-	writeb(0, riic->base + RIIC_ICIER);
-	readb(riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICSR2);
+	riic_readb(riic, RIIC_ICSR2);
+	riic_writeb(riic, 0, RIIC_ICIER);
+	riic_readb(riic, RIIC_ICIER);
=20
 	complete(&riic->msg_done);
=20
@@ -366,15 +376,15 @@ static int riic_init_hw(struct riic_dev *riic, struct=
 i2c_timings *t)
 		 t->scl_rise_ns / (1000000000 / rate), cks, brl, brh);
=20
 	/* Changing the order of accessing IICRST and ICE may break things! */
-	writeb(ICCR1_IICRST | ICCR1_SOWP, riic->base + RIIC_ICCR1);
+	riic_writeb(riic, ICCR1_IICRST | ICCR1_SOWP, RIIC_ICCR1);
 	riic_clear_set_bit(riic, 0, ICCR1_ICE, RIIC_ICCR1);
=20
-	writeb(ICMR1_CKS(cks), riic->base + RIIC_ICMR1);
-	writeb(brh | ICBR_RESERVED, riic->base + RIIC_ICBRH);
-	writeb(brl | ICBR_RESERVED, riic->base + RIIC_ICBRL);
+	riic_writeb(riic, ICMR1_CKS(cks), RIIC_ICMR1);
+	riic_writeb(riic, brh | ICBR_RESERVED, RIIC_ICBRH);
+	riic_writeb(riic, brl | ICBR_RESERVED, RIIC_ICBRL);
=20
-	writeb(0, riic->base + RIIC_ICSER);
-	writeb(ICMR3_ACKWP | ICMR3_RDRFS, riic->base + RIIC_ICMR3);
+	riic_writeb(riic, 0, RIIC_ICSER);
+	riic_writeb(riic, ICMR3_ACKWP | ICMR3_RDRFS, RIIC_ICMR3);
=20
 	riic_clear_set_bit(riic, ICCR1_IICRST, 0, RIIC_ICCR1);
=20
@@ -482,7 +492,7 @@ static int riic_i2c_remove(struct platform_device *pdev=
)
 	struct riic_dev *riic =3D platform_get_drvdata(pdev);
=20
 	pm_runtime_get_sync(&pdev->dev);
-	writeb(0, riic->base + RIIC_ICIER);
+	riic_writeb(riic, 0, RIIC_ICIER);
 	pm_runtime_put(&pdev->dev);
 	i2c_del_adapter(&riic->adapter);
 	pm_runtime_disable(&pdev->dev);
--=20
2.43.0


