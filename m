Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379B6C35FFA
	for <webhook@archiver.kernel.org>; Wed, 19 Mar 2025 09:49:10 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.33])
 by mx.groups.io with SMTP id smtpd.web10.4043.1742377745706950030
 for <cip-dev@lists.cip-project.org>;
 Wed, 19 Mar 2025 02:49:06 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Fs1viM/R;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.33, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMtaUE3uX7mEMyYhpN+Ie4wXraw2uW3Htw0zFVQ0MOggkGt72x8mwMGT2rZ/HPncM8W1ohYzwnazYE6giRz5sGQwuV6KLVdMilFTTscOBW1YbOrNfGmsE50DMPeLgiAn82egMBqXFhRFJe7TyOK6wXhWQOIZW/tCBVeevRqZ2h4yNEP3Zmxk5jGHBcZus//4SVnExHaKXvotBZfHc7T8s8XEWp9S84H+Z59EKbOoHLAnZkA702PKpQoVwWmnJ3g0jEg+vdd/4Ey/E8xtJ2lKrxr54o2n1VZKfgbsbYq338cqsM705U/RZt+nmSZw6+AOTabMHXnizLZepdZDK3Lxtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2dgvp1DenUw2fKHe6HqOO/uLNAgjuoWloazMmwl5sw=;
 b=aqtJQYoxNalSD6K0YC0sB/7MgI18YWa86dPlaGtEKj7en9ZmaEl18LXKoa4cfQ2lNInTUjweYMwsoKVGBtXF3YRJNRPX57fXNCBZEqAPHhCvZJxZJy5x+spskPPtS3y8easMST4n/gez9s4pDaqpc5K2rMrEu0eCL1NLCMLBK5gLHso+94lHGpx2liV9CDeQXx1PCXvVdJ2WXKCWNklXQlzYjnaNMKTDkwiAQDgWFyNLP0a8lC4KvVvrSAWacpetdMvw/UdeSB9Xt5AB4kI+HATRU+XA1Lw/UfIjm6+W84rC2pJwoGAmLJvUhlk5UnZ34XiW9Z1o9wqFMjO7iw5qgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2dgvp1DenUw2fKHe6HqOO/uLNAgjuoWloazMmwl5sw=;
 b=Fs1viM/RzqW+5DPK+jf8l30dtOBXlQP9GycLH+knp2csqn/04qRu/1cKejfEhZwV9CUxcLSnqAa8UZejyx94JiUSsGdM1gC6OqbXJQUru5mCntbMeAdXSUVZBbHCIU6NppSueyOdVMPi5gj0BGIopDX6QzJUQMd2WR39jm2qmtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB13904.jpnprd01.prod.outlook.com (2603:1096:405:1fb::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 09:49:03 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8534.034; Wed, 19 Mar 2025
 09:49:03 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 12/12] serial: sh-sci: Increment the runtime usage counter for the earlycon device
Date: Wed, 19 Mar 2025 10:47:54 +0100
Message-ID: <20250319094754.2404386-13-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250319094754.2404386-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB13904:EE_
X-MS-Office365-Filtering-Correlation-Id: e955d690-75f3-46d1-54fd-08dd66cb4835
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gwwWqmjtvW4f62GRCix69nK1zu4Iii6YwS7O/0HB/CqF6zdphCWOwITD+Vyg?=
 =?us-ascii?Q?fB9r2PGi4tt4bmQ4icJkR7gD8o1PkwNgMeNhR3L2z3fY3o3TphQbd4Msfeaq?=
 =?us-ascii?Q?+ymQUL7l+jZselqL7Wi6uPc8oJ8+6jNtH91eDkwxPnrOicHSekYlyweCvaO6?=
 =?us-ascii?Q?exm1bgkYACSfIt6psHLDSn9WbNSBG+uNDpehoJEAmVU/pOOsMYhtuXlhbIbz?=
 =?us-ascii?Q?TRUCwTL9nJmNbutsPgN1pl+ddQJRjlbpCtyYPM+SGt4BvnF1VPjr3aq4/QmC?=
 =?us-ascii?Q?hdY6pgM8yA5Tj7TtKGawbY04ClqpOdcOflQ5XprllJkTKBBlV4qHAgQPns1z?=
 =?us-ascii?Q?ejF5wzphMgFlTCAS0cFz3d8C9AHs7gGqfxE61ID85NnvYAezN/pQN3Upb/yD?=
 =?us-ascii?Q?KhPXHcExR/iT43g0LmFGxUteM/zcglVwr6YXuXoqwz6HN4TcLX8kQzoug43J?=
 =?us-ascii?Q?ytXSi0J9cwlad7245wVfGFkU6epTo2ifem9H8vtf98jS8B68Swuz0jNYVzyt?=
 =?us-ascii?Q?24NvtQnawWyN/8DyB5me1XHqlVKP5tYphTOTP04UCQGk0r/1b6sogkvZOhTD?=
 =?us-ascii?Q?7buCM2Qvq1NGlNLF2pY8mVyXtDSPSiyK9SKmRUeYRCazImx9CdWs+pkPo0MV?=
 =?us-ascii?Q?rEmYaXASjYjXE0u5LDKK2HaC9uvJMzRCYU3nPdwET9Fehu9rgjXhqq7MOhp0?=
 =?us-ascii?Q?kPvgG5W4WJiD++xwz/FNyXyTNFGWkSPqw8KcfgndoTUuCGXq0v/3P1j7Jyfz?=
 =?us-ascii?Q?R5LsCHPQ2x9QHR5eytDQ2hPCjgWL9pAb5iNzT82oVPmtcUGG6VqhlRfuNU/N?=
 =?us-ascii?Q?J9C7mZqELyU527T7vqpl6cLLxwvBZ1tJ325gPDVuFGq4+/RVaide5kWHj3r7?=
 =?us-ascii?Q?E+fieqDfsQyAnmr2meyyrvIHSYhVGtar7CJUYFYgxyxy1GVa0sbi4DGAbRKb?=
 =?us-ascii?Q?5uejFp5R2Y9x0gM6SNFwLI7SIgqVa5VfH1q3eLUu8VBZhcnQRYEnf/jk0WUL?=
 =?us-ascii?Q?I9cHsYLuPD6m70O5T+s2Sj8Dl5Yc7xwzBR3CXNO6Rn0Fc1NFk9ehnUHvMQ+K?=
 =?us-ascii?Q?Y0Pz29VSebCjC9L7SICwUN6t6u6kc8QOPC2Y984qJSd5B33ZXjMaASrqzCkH?=
 =?us-ascii?Q?Fril/OgokyR2Z6pz1aGqm56pNctf0Ehn1tr3P3XzHnHk1Vrcpomuw23/i+Ri?=
 =?us-ascii?Q?veJQ+ZdBjHmR36cgPmfuF4Sb0FFqqYeSEwBzLbQ19KLtAZLHy7LGFpf65kPk?=
 =?us-ascii?Q?lfXEwZYOu7aZjh+5PBpZ4I3N1WIQDNgCzp/VCI/l4GoHw/4ifX1nxqfNFvSG?=
 =?us-ascii?Q?Vor/+TnLIB8HHOWKqoe9+aHgevR2n0yGiWSwyA5k4sHZ2pwVe4J+Lgfqx+u2?=
 =?us-ascii?Q?ukKE5LkfEoSv5JPOfALNW2+fqdxoQe3JtjPhPDiXY0qVQiPFWgHgEBncQzwo?=
 =?us-ascii?Q?AV9zwEwz2tlau/ug/P3eA9TiCSlSQVHS?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?R3ayN8Q0kFxEFS2vzciNKVChxYwIDHvPuX1fyW53b2+HMhY7mcmyqzIvmwpR?=
 =?us-ascii?Q?BfH9uOsIcf2WapHRpcbg0OQNU8487jQx4mIbgmBwQ6ON8DvQdp6w45VVa8Vt?=
 =?us-ascii?Q?OqBUInr88GpHZNT7DuAErA5qszC/i9iA+nBNis1DFiPx/QPUu6/+l19L/Xmf?=
 =?us-ascii?Q?fWJ1KL0hQOCukdS8rNdyUg1cSAViSm0dILPrc2UV9eVJwUfDpZ9Cc95zfWMz?=
 =?us-ascii?Q?7NnM4WBFiKzf7mRQNLsi/WG/3L/nNZOhAt+iCGNUERL6dGBygYh0pNH5+EFN?=
 =?us-ascii?Q?KcibR30rbfhzNT6J+i0h3yJ16vW9TJi0nyFyRf0Eks4L2DQOcxQqlbUsY8yH?=
 =?us-ascii?Q?aR0fsmQh8hra3s6r4fT56Ziks7rJAcrTbpj1NBqb/iMl+cyyxN14vcZExFwo?=
 =?us-ascii?Q?9JkxOixzFgec8+Nv4btIxumByNkCkDMFIlO+FmdIU7HLk+2sGJjyjSShK1y/?=
 =?us-ascii?Q?B36FHTJaGmHx8yps06WXx/WD/t3DuzLAJYQtf+r00+DbWnk7NTQ1TU0/NOFA?=
 =?us-ascii?Q?otG2qbcA/wL9YhaKpVZUWYXoesj+7EQdHAGUVHf6XoKvskhDdyfTvG+WyKzg?=
 =?us-ascii?Q?h1WTtAKpWN2Mr52I6TdTGr4nazKFnqaxx2mAS9xNGtyFK09Xz9+yJw8Y5QZf?=
 =?us-ascii?Q?2cIxGJtGI0226n136mkMrA4fFqQuLIEHbwfoZ3Y6yorCGDGseu/9ceplhOpx?=
 =?us-ascii?Q?TpEimMzx/pfIqnwhbuCAluLOA3G2tBMMDt0nopwgZy0dHoGrxfN6pqjqGGre?=
 =?us-ascii?Q?gliAGxuXSor0gAT6bqWgDwy0j+0cm1tpDbKCVSQAH57mM3DwULacMSG0k5Ix?=
 =?us-ascii?Q?J9pv1+mvmBweyEoE7XHwooRRsCxDYtqCvobt8lG2XR+Ua+DiZjV+JYLy+MT4?=
 =?us-ascii?Q?dQbNUq0UP9NG99QwJBhq1IbcLOdsPPUZlwxFCZnnIdlLeXqtizKT2k2AuAbc?=
 =?us-ascii?Q?8+u5YArcabKD/PCt4Eq4jIZ/dX9VnXqFI5W7OpkuiZf+SgovskR1Lp1OufAK?=
 =?us-ascii?Q?YjHSH0CC5tIilW8LoKdKr7NaUozrbYjZgnf1FbYFlW+fK3G6Yc/FG8jw4GJz?=
 =?us-ascii?Q?94yRs42wGi890L0BkjGsvSLTMqvCbY4JySBFWcorPzeKbd0uctFLY4q/4h69?=
 =?us-ascii?Q?rJATdptQ/BmlMVDEuuOIZQbO2voBDz1cWAJTC+5avxoxPCWxkXljCX4lgS7S?=
 =?us-ascii?Q?H3lyTI1VgJ529NcIDBaj3/bWOSGJl1g7pMPREYcUsnnARKR5FdcAeB0x2reN?=
 =?us-ascii?Q?4DSXnt/FvCM9nHeJTYxOX5F8TnYdrvEPFAq80sMtkTDXiNJe66l7E7jEQA3z?=
 =?us-ascii?Q?YVSnnS7fFslf34WMRiXtACxGz/exYPd80a81HwwjNhIIGCJMS9Sqf9Glv5S2?=
 =?us-ascii?Q?fdmHZxrEHdCasI3OJdHnsldt1r9bcNSezs1McryEewQIJgD+PE6lmWZnAj5J?=
 =?us-ascii?Q?OtYFBSkZvbw1yuTAaQ9OZ/gE5vCjhmDJdTWZ9D7bfhBGYqtJFp7kTi5onrva?=
 =?us-ascii?Q?Ps5qYDUnaiqWDyoG4u8Un9y3yu84vKqtTHBNFwBzva0vVY6kVg5qzr5YPrFB?=
 =?us-ascii?Q?NjknhHoWhtH1S6tem2mtFGYYrjPt1dC2LJ2ehcPOFNghEsCsox/ucrvI1dnw?=
 =?us-ascii?Q?eXUrbI5iWOiJpFceo4rCvTg=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e955d690-75f3-46d1-54fd-08dd66cb4835
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 09:49:03.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vtwNzhwSiD5j5NK0AoI+yy5YMNDcYyakE4rqmEiKEQFKKKqE8J9G7sTg40as/E597v1CRbCJ9N52P8Z0eEFImCPNTX+PTnwAKSzXYWi1zdFYSe1IvrZJNXS6T2kz4ras
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13904
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 19 Mar 2025 09:49:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18259

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


