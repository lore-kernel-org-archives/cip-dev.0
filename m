Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C8A2C36002
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.68])
 by mx.groups.io with SMTP id smtpd.web10.34507.1741778840344218531
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=re5S8DME;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.68, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UV63yWUrwsz7P7q+TF4KT5miPwtqfgOxE05rLuMuHdYh0h6a2iQJ7mdxnRIF5RxOa6m5zrhx/mwLk1998tuK7FHPnPBblqDL4hK0cz0JuroYjyDKtH3q9rpTs3Tn7y8CYFNG8JWWJSKN5yBpnHPUwIqr4wHA9eTM7rO21oIpML4MFrjo7r8bSFn4mNrL7+ahQtxs7gsd65+gpYe+cy9Idqw0rhmUURVkkIeRj3gR2JXUx679rYIPEoFxEse0ze252bc5ioBRkBHeKtprF+Vbc9e04LOlUSx5DkRao/FiJYZaYKV7F/BG2vrUTLSaYHeJelEy5j6v+MXVWZGEXUKRNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2dgvp1DenUw2fKHe6HqOO/uLNAgjuoWloazMmwl5sw=;
 b=v3F57+9z66SfuuV9/75d5INKdIZdZCkW3JDXZIbV41/WD+8+E1Y+TLH8e5s35f42jm8eXl9RAIn7g4qd917l7fnTjdctuHpacZLxzu5qoRZuDTDL1izOZqsf53/uTacE7vj5knQk+bYdYddxk5n+zz5QKGmUCCQ+9tqd+H1qaJ6F7mUcgWnAtwSDFjPUChfKteklfKqcftPmMKLQGGPvBs/CwdTr3vEt9Pxb6urXWzstY3O2XaNh8q4B8a8awkQd+XwfJvNfJvFCqMw1lV5Yz1lIcUoVzeo7Mhbcyjt3l7c0UeBsewdquNZZujItahhsAYOpkpn4Yj8AH3+aZcTS2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2dgvp1DenUw2fKHe6HqOO/uLNAgjuoWloazMmwl5sw=;
 b=re5S8DMEZ7EOAUYv4BOGkVgRhXxYAOCdCqEIbsJ+LNAVS/aPLDZZDCCzxheObWn2ohYeOa9A/gvAbm/0ApSHthhulJdYo0TvA8RZrL3BqXFdIopY4xTiJk5Q6qQmWVclAk0uOkx+552sGnovTQlY924bQKNxhHxUW3E+peSpyVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OS9PR01MB13175.jpnprd01.prod.outlook.com (2603:1096:604:30b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:18 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:18 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 76/85] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 12 Mar 2025 12:22:53 +0100
Message-ID: <20250312112302.1605750-77-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OS9PR01MB13175:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b2c971-7767-4618-ef45-08dd6158d921
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?8YiljkJyyen/5R9tZrP3cFhaaFCg/jcMyogZLQib9bbbaSst8SINGYR1YFBd?=
 =?us-ascii?Q?EvnlQFTtymb5o448FtjHElKZSEvObasHlEu2RbRCzOvhXugWT2aJSppH7USU?=
 =?us-ascii?Q?rXgPErjjp+41zml2sUffTPZqhfqRIGnzFi+VSdxx2YNPay/4eWbxNGwssGi6?=
 =?us-ascii?Q?aK9xy8kXcpSFLD9jD8lVG/ZNtY9pyC4THRv6Y1dBo6EMFQIG5+s6jbq/TGfJ?=
 =?us-ascii?Q?HCPOMzimjkqBaJZn11hlU1QOu7Re/hE3O/n/htkpbhK7PVgk+iDaRfPzABW6?=
 =?us-ascii?Q?oW4KIsKhIUEuyPkIQavl5vUZUD/6CHWxk5Xrsxl56mv4MylLU9nhTDPQTL+m?=
 =?us-ascii?Q?Z1PaXAYTd+aIsR/+qiJsfxVqQd0Z3o1XPETt+W/52C0hPH+JtxSBRmCzFvhY?=
 =?us-ascii?Q?8jPzK24MskjeAakii2ile+yBX6VuImSyplmIaYOghie7yg1yO7gCBacaq68B?=
 =?us-ascii?Q?XhyEwB1ccd6M85/qd/qDilqMO2lOjD1UazjMHgMYxRwn0re4RnPGVC2LJesg?=
 =?us-ascii?Q?gjPZ65ruJgbjrDcvB0gVcgEbSdAljolrX7VP21aF0ZeHYT4uObXhq9iz7afJ?=
 =?us-ascii?Q?TTlkzkFs3ji/q2CouScczGu2wLc+ZFpKhgXZ9xeLpLtYYHQ4YhG6/oC+V7Iz?=
 =?us-ascii?Q?1FVpKqBnFwr6wmHMKYbqB/nPvxkvv5621Vl1dwkjy3MLuaT/tBvdWla+GaEX?=
 =?us-ascii?Q?Xq0jFv0XC+DmDbuyy+GOFETQ3d6RMZ1C9NbC/nqe8hcwlbVb3uBtulNXCt6O?=
 =?us-ascii?Q?F87hFRST1nTN1p4Xf8lp2BtH+zJwieEhODbSi/NQlzm0o7wvsAIAieVxIPxL?=
 =?us-ascii?Q?lBuaDBN85BeuWo5BzYBYDGIfi7Q9R84vdusmdAW0V6N5FCsAxF7QNt4a9k65?=
 =?us-ascii?Q?NCafuucjddEDZGWNtm+ZTipkVRQTCeiWWGZoSjLgJBg5WUabswA5lRvTsbkL?=
 =?us-ascii?Q?GLOhmLB2Ra5kT+lyHff5LxHdaPui7KLZdBubPhS9P0nTA5Igm+MDMsrm434B?=
 =?us-ascii?Q?nSs1PWZPlHrXwZn219l0fZcahfQsoOkXCBS1dMcHR9lgLaJL+6uBsPsbWdfL?=
 =?us-ascii?Q?eG0JHKwEN8+oowp1D72Qlb8QFh3Fg+6kIOrpY8i3u/PNKnIYUQ24LeBvbIJD?=
 =?us-ascii?Q?CpVUdqf3rSQBTmS2uLt1cW4eh6qKmg0QnTPL33xdEsz+jCJJGAMLEfJ2j6+7?=
 =?us-ascii?Q?iKQcIBwEpcVjLfP7oa+H+zmfYrZKE2tFQmwTgb8umB0UOGU4H3CIQs8SPX/j?=
 =?us-ascii?Q?J437pW1BA8HovtTsoZlbmOYimuafbeqc0SQMaqhC0mBARf2NnQKOZSxKcMno?=
 =?us-ascii?Q?AFRt0l1doP6zzS/H+VzAExTPFL2FFfuMxP/QYDysLsX+4S064mxmXo2Ld5/e?=
 =?us-ascii?Q?mgKW7QyBjACPpUn68ppMJeD2CNNK+Mvf8miraEoKH5wJ1zmXoV6LK0BgT5XC?=
 =?us-ascii?Q?zESSDxSJnsipv/Dg0bGI9mitGPgmFfh/?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lgguGnZwmb9o6y7+8TZIWzYANbuFraia3m1pYr5EG+ofSaCIRq/31Y9WYq0H?=
 =?us-ascii?Q?s3evdobXKknkWxmdOK1bI2RHsteFlGrZyJJ4r1I52bIqMQXQFC6uWcFuMaO6?=
 =?us-ascii?Q?J2+xoAmqZrineY1eDnD4+MJQ0ICYedFIgvxR/IX+l51dyQD4eg6cS3M4befM?=
 =?us-ascii?Q?6spTPx0eTAYZ7JLQKpbLvs3P+RGc2c3zoyovnL2FhQ4hM5CPJVvUeu9LwJ09?=
 =?us-ascii?Q?aYcz17r2bgqj+sBVJ6ehu2Q4xLy+UeXzF8CD9iuNh2ntMf9HM6e5HB5+SkRs?=
 =?us-ascii?Q?OmydO/PsD9Ju9WMLTzJ9Ju0lI2WVkypoOGlPFfY03/XJ4nIuRHu9yZLYkFJU?=
 =?us-ascii?Q?nADv/wpLX5MyIiQ3JR/zEkGYL06/8c6Qoz4E6BxEduSMvd6uVN7ji4+KffQR?=
 =?us-ascii?Q?f5ikMahb21bNuYSpo6kfPzbn8Td6cFx2O9sT5h9m5Vazo3bvqHmalFHEFkbh?=
 =?us-ascii?Q?neXlhvgWt+uVMui/vXwH8sZ800fqPLh+GmgK8T/jzkz/5xCnJoqD4OHNw2oQ?=
 =?us-ascii?Q?WUk5XcLfnP1XJyqCuFz+n39FAIMWyCfLcnsrqrlvxCvX3I0XDbZ+I7TiRszL?=
 =?us-ascii?Q?yMv8gSpeJBoiQ7gvqQPOgqB9lrToa2g8cl10exJtQ55kXg/VVYy5s8Q2f3p2?=
 =?us-ascii?Q?svEuRxVwCK0lEL+x9Icx1dZtdOg6ndsmBCKj9xwik22qclIKbWU5NlMMw0yR?=
 =?us-ascii?Q?1xGXsfBikeDdV9JweRltmAd2MsndcUytPObksoRBL23edXbm17931GKlp3Hp?=
 =?us-ascii?Q?98525BpDZMdDqKIrHldeFZossQjbkVDL7vV5nhJR0C18ym4ay6rCpbdHI3Jc?=
 =?us-ascii?Q?phClPM+cxY45SCPLpecHnFlmXh9siHpOIravQ1Gc/nZnyzbqTDruzhdT4tRr?=
 =?us-ascii?Q?7hirNMUbzarjIww5Grw6jtzZ0Y103q49+RcrWTZxKPIUiIfoNuYRIoNPFPAd?=
 =?us-ascii?Q?ji65hwjx+d+347ZV+mng6nx2KFIN4LCQTOuEIV7I1s/5RolAZkwGADkOPTYy?=
 =?us-ascii?Q?ip7o9Kp1DYXCkPDA9ubvRLP2fNpGzYGmws1hunfjVII+YEcCXnRHMn47G8Uh?=
 =?us-ascii?Q?rz7K3wDfEBEOaQpV0o5SU4uyupGyqSQSYxYuQcKNQreJBvM4Rprrv/6l22XB?=
 =?us-ascii?Q?GlHFRzNv9SsWPxSuyoxDpWN7B7bBRXu+c4I8XpUg2ldIE+ycqDVA/8rxTHZc?=
 =?us-ascii?Q?IIwTaTntAdLRqBAsILZDhie7wtNq3q9j99Z3Ruide3uMU+OgKxbqOQQVQE/7?=
 =?us-ascii?Q?oP/NZkhwqnCLdQ9mZvxNNkbgYxonYSZftKiLgPKo7Nly8erItLdGe/sVPoaD?=
 =?us-ascii?Q?s5NdvMdFIm5GV02PksBIbrNvVDB8zXYrKgyYjB27ZWl4fk594U8bkssVf/yd?=
 =?us-ascii?Q?t2TSoY7LjnNRT5U+ITDPhrenuVCwVpFLOOFsM0IhiXfjkU0xpqIkkKYzb/e5?=
 =?us-ascii?Q?oKZawhSo7l0QNhMlkgqmoPTCTacQDX70wd3Znsp2ocB38HoGFYIdgr7mIDx9?=
 =?us-ascii?Q?LAbldY9qXSiyNb5RKa8TANveFu74Guf6UNoD5/qXs1bG3np0FPx+f7i+kyFR?=
 =?us-ascii?Q?mYA4qRjPivE6Rlei3EfY4YL1UB7riPYxy8CGxKJnqLQozSau2wGyuBQfHfCn?=
 =?us-ascii?Q?6WnqX1xMSm5T+9X4vLhDCOs=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b2c971-7767-4618-ef45-08dd6158d921
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:18.5258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EfRoS3ynjZxR2DGFf1jONVKCYeYex66z+cL7hRV6mShoWP0YeUR/e4ff/i3cJaXbUgndMMJE0Prpxdd7+0SmJBerUM6ho5alYzobh9lpfLvwDKZVXB9gL5N460GnzqAJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB13175
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18168

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit 651dee03696e1dfde6d9a7e8664bbdcd9a10ea7f upstream.

In the sh-sci driver, serial ports are mapped to the sci_ports[] array,
with earlycon mapped at index zero.

The uart_add_one_port() function eventually calls __device_attach(),
which, in turn, calls pm_request_idle(). The identified code path is as
follows:

uart_add_one_port() ->
  serial_ctrl_register_port() ->
    serial_core_register_port() ->
      serial_core_port_device_add() ->
        serial_base_port_add() ->
          device_add() ->
            bus_probe_device() ->
              device_initial_probe() ->
                __device_attach() ->
                  // ...
                  if (dev->p->dead) {
                    // ...
                  } else if (dev->driver) {
                    // ...
                  } else {
                    // ...
                    pm_request_idle(dev);
                    // ...
                  }

The earlycon device clocks are enabled by the bootloader. However, the
pm_request_idle() call in __device_attach() disables the SCI port clocks
while earlycon is still active.

The earlycon write function, serial_console_write(), calls
sci_poll_put_char() via serial_console_putchar(). If the SCI port clocks
are disabled, writing to earlycon may sometimes cause the SR.TDFE bit to
remain unset indefinitely, causing the while loop in sci_poll_put_char()
to never exit. On single-core SoCs, this can result in the system being
blocked during boot when this issue occurs.

To resolve this, increment the runtime PM usage counter for the earlycon
SCI device before registering the UART port.

Fixes: 0b0cced19ab1 ("serial: sh-sci: Add CONFIG_SERIAL_EARLYCON support")
Cc: stable@vger.kernel.org
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Link: https://lore.kernel.org/r/20250116182249.3828577-6-claudiu.beznea.uj@=
bp.renesas.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index f8e4062d9b4c..3f5c319215d2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -3435,6 +3435,22 @@ static int sci_probe_single(struct platform_device *=
dev,
 	}
=20
 	if (sci_uart_earlycon && sci_ports[0].port.mapbase =3D=3D sci_res->start)=
 {
+		/*
+		 * In case:
+		 * - this is the earlycon port (mapped on index 0 in sci_ports[]) and
+		 * - it now maps to an alias other than zero and
+		 * - the earlycon is still alive (e.g., "earlycon keep_bootcon" is
+		 *   available in bootargs)
+		 *
+		 * we need to avoid disabling clocks and PM domains through the runtime
+		 * PM APIs called in __device_attach(). For this, increment the runtime
+		 * PM reference counter (the clocks and PM domains were already enabled
+		 * by the bootloader). Otherwise the earlycon may access the HW when it
+		 * has no clocks enabled leading to failures (infinite loop in
+		 * sci_poll_put_char()).
+		 */
+		pm_runtime_get_noresume(&dev->dev);
+
 		/*
 		 * Skip cleanup the sci_port[0] in early_console_exit(), this
 		 * port is the same as the earlycon one.
--=20
2.43.0


