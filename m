Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.1822.1793653903850404534
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 13:11:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=YnVYOFQt;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mry0qKTJvvURfx4RChZirUihWnBtHwUKPC+Zx7yyMz7VtWV9KrfBKTj4BorUgezWQfudfvub+WSgHwCnYOnQBVVJZT+oZnvpAMoI63GYwbU68+GJ2DPU/5PqSnsPp1+NoKQhiK27PWrXu5GNrA+hPtxx+ip4RVCyWoRKCpI/PslluNl+iX9LaiYrxKmsIfM9MoIMb65rGkE0muwYIVuXsbN/hRocFrlRpuai0S1+mUMSKyTmU7twu5vYoX/liCHnW3V+1GWdBMy5Z5y3zKSoavep0yrZtpE8+WJnuRox3qQat0g3b0IDUJo4IEJhSrDGlQ2+6ZstfIYzgFhEwJpRvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1RtNNd6q8vZa6AgHErEaJi8bmBvO9OS9xnAUDwYoPU=;
 b=Z1Bh9A4FmLvqL8vUnR2ZjWiTGJNNnnKr5PJ6IprEwtBlxBQfZQJVabjCd8KR4T4b9M9y0BrDMQDsVsLfF8a6eqjj/10oqB9ibphlwldtItNace98QOdyB9A7a+m/pCftN7x9brKfKlbiswZbxVwqOFMvpyVusdrxfBK4rbAKjj5vWLJdbuNq/BDcrmDFZKvjRSTUjU0pHWZ/Bd25W4FszmjH6Tv1IaHzGcZL2Uzry8CfuIcBz3pWH0JHycwHD3PEne0GM9XfKppLY5xq373BOg6W+rMoeE08nmBHPdiZsn49BB47yttRa3TnHKoMDaVCIfaQ/3hRYkYkiAOYKT6M9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1RtNNd6q8vZa6AgHErEaJi8bmBvO9OS9xnAUDwYoPU=;
 b=YnVYOFQtngisw/aSkchsyryZesnLgoBgm1ih+00nqW9scMt313S6RGdgmAbTiK2DNiVX2NDEtGgCWmYt+jfwjfrVJxb8lvX/EOXCz7HKoFG86+PfKgP8Ut0UN94m5utPEbmhQdSUAz46LnWxVQF7ruwlwm3Te2RzSHW0zyAjWoc=
Received: from TY4P286CA0045.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:36e::12)
 by OSCPR01MB16142.jpnprd01.prod.outlook.com (2603:1096:604:3e1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 21:11:37 +0000
Received: from TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36e:cafe::8f) by TY4P286CA0045.outlook.office365.com
 (2603:1096:405:36e::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 21:11:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005021.mail.protection.outlook.com (10.167.240.6) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 21:11:37 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 7F5833000230;
	Tue,  3 Nov 2026 06:11:36 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 2/8] memory: renesas-rpc-if: Mark XSPI_CDD1BUF0 as volatile
Date: Mon,  2 Nov 2026 21:11:25 +0000
Message-ID: <20261102211132.22646-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261102211132.22646-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005021:EE_|OSCPR01MB16142:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fb14821-1703-44c5-ae01-08df3925e205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|10067099003|261102123227099003|22082099003|18002099003|13003099007|56012099006|11063799006|261022075727099003|261021121427099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: vRqp7CAsibOhCbggQFfy8BYWXuzEFlEcwchZIyZ8CNH+/mLSbnDM2nNTHj10Ur7OaxDKMD8icrgaYMVJ/fEMR5A9neMHRfJpzdSgrRJ/2WcLO4iKTq4X59IOg0DmEi85RZh3I2vSzTc2oAAYQB2JJcuVews/3WswsqyWe7lulxvLWWwA9VHkfY80coESmuo6dTZTFFcJS9p8BjxwcAK2uBQWTZrj4l82xslXg1JllsudGKfHbG1XcodvQJavEcMxBA9Fo4YWS4w4tTSAwwbCKRhWYpcebeuJPqUr7v5K6mesE8JdGeYohRzR5UhXPOFFDZNNVbVw6PaY7yPXZ8+mziIHWXwm+nc/+wOe0Nyt8MgGk/RXRt6Mlgksi9vhcx+yPpr4rTrYHA4thoi+sRPc19Er/04p/Yng+pLJdAx5ZqlcYS0Ff2FdhFZFVbD/20HWWk9UWFFaMjhYmJlAdZZA3ltHKkR2soWboWmfIikh+KeBhWX2NGdjkfDBttp1iEHIFS1gOQsMn7yS+pF8AOYZPS/TNQKVv7m2E9dVHQXPRAUY3zZFI2Da/UWWrOI8un4xVHGVd3sM0PhC83kaDnJgJqHxZf1ZWQGEErtg8Jz/PuFpObZdideshQn4HAMRtwbpCWZCyWTk8s5baoaytcXOwdFCb63GUcKylQ+vRBFHPfc=
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(10067099003)(261102123227099003)(22082099003)(18002099003)(13003099007)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261009221227099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tcdvueFeM6IQqjL+fd8ZT6r+DoCFfrDBoVZPnVcasAxKhRgfhq9zDsmCyKJAApGEkTIoHXDiKtUNYf0G7Km1+oQriThx92DObrWtn5102kH8jahYxQod280ucLVsaCoO/7qCszYhYksmheYjnOa0zUfep42Duj/LtHIQB3nMpFYGjBHKuKWmFo5XiYg3g+ohr/AD0aP1Z2igIOY/rCeQqaScV3zAsfeP+vjZbTdbsa1xmUf5MH8Zo94DuvpgDCNp+2+Nh523uxro0RQYdouHCRTePQvlasIdcLX+V6ZEBYWQCQ/T91tM3r+DQKVjOYzg6g1emX1NgptlzGRPaG7e/ZUQSKAdSJQYWvvbQ2UQ4eN1RIUFGMo/c2NzThhZsmwZaIWhZ9pqS0DrZWMIBRYWGBC3pRi7T61FXurjnS4qH6wXM9UU481Zr76SXmENjPba
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 21:11:37.7995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fb14821-1703-44c5-ae01-08df3925e205
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005021.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16142
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 21:11:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24621
Content-Type: text/plain; charset="utf-8"

commit 3db1fb5e1bb4c9eefc554f985f6f3316fa1292e5 upstream.

Add XSPI_CDD1BUF0 to the xSPI regmap volatile register table.

XSPI_CDD1BUF0 is a data buffer register used during manual transfers and,
like XSPI_CDD0BUF0, its contents are transient and should not be cached
by regmap. Mark it as volatile so reads always access the hardware
register.

Fixes: 687cac9559d8 ("memory: renesas-rpc-if: Add RZ/G3E xSPI support")
Cc: stable@vger.kernel.org
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://patch.msgid.link/20260727103449.3188105-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/memory/renesas-rpc-if.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/renesas-rpc-if.c b/drivers/memory/renesas-rpc-i=
f.c
index 36fc5fb411079..14d4ed227a65e 100644
--- a/drivers/memory/renesas-rpc-if.c
+++ b/drivers/memory/renesas-rpc-if.c
@@ -34,6 +34,7 @@ static const struct regmap_access_table rpcif_volatile_ta=
ble =3D {
=20
 static const struct regmap_range xspi_volatile_ranges[] =3D {
 	regmap_reg_range(XSPI_CDD0BUF0, XSPI_CDD0BUF0),
+	regmap_reg_range(XSPI_CDD1BUF0, XSPI_CDD1BUF0),
 };
=20
 static const struct regmap_access_table xspi_volatile_table =3D {
--=20
2.43.0

