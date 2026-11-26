Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.50])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.407.1795708436974188556
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 07:53:57 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=FbZ0gWlW;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.50, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DTBwDByJbA7Oa8UstrR7N5et1bSZxvvAREkEfjDeM4pP3Cvuq9teRm1dpxgnloqs456kGkRjEgqNo5pE+yHl6tSkwPlK3toIZKSZJPsBb6IsEGngVUDGyNFUhDZCSiemR8cwvXXwfotEg8GlimStsUhNRndLjmmkTXDCofFE9kXQeEMmEECcUBY3h1qCu/YcnIQVc3MjX5A3OPRj8b0S0kdeWIz81LqiQVy1wx9kb0+NGa4qbMWj5INb8spNkuUperUYjjpGAutVWZLFJkl4vRkx3guVoB4fsRr3txgxKOrPcpgT+/zURn8V5hmBCIVZjua1X0yhkENbCc4LWJwgXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yF9JwvFi3GyTynON8/FAK/lXNw7aQsn5YqVDxPSlkAY=;
 b=RCnnc+xw0YmJfkiNfS7MJaSZap7xGAZ44jdLNLVKSODYp9C8l75f1R8GBi5SzKswmsEbfIdQBnaDhGEIvMuCE0oXgDWmjc54E5nzTUEsY0+wR5QFAbm4CJyVEAvd88HV2shhDpeD/EZ8n2vN55LQsWwLTrx58XODhYDZCRYcuXqd+GnTNmUoGrCYlA/xL0wF49ljcym0JprKN+4e3up4SknpYnEiuFiN9Qg2F/+PogQ9RW2yhOnPl4EZ6rmNEI21vSOJtlTcjFWmAXFG8ioVX74rflexE0XSzn3v5QjwV9B1Gwdtr1AwhNbOZAdt/CTk1L3raYy7bVSFIKRj81BsTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yF9JwvFi3GyTynON8/FAK/lXNw7aQsn5YqVDxPSlkAY=;
 b=FbZ0gWlW9tcMuqd2GNinpfrvLeGHJQZ4wJadx4WsFFyqPU2vsRHMMmFCPXfH3X6y4wjcqkWZK+EutEUXo0cB8hRfHRoc0Lh8tiTtEz3iWxC4A0WYblYYG+FuNqZB9GRD81WNv++50OHYJ7Hf73ASsC7rc/oJWcOUnfDyD2pfBLw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15) by TY4PR01MB13015.jpnprd01.prod.outlook.com
 (2603:1096:405:1dd::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 15:53:54 +0000
Received: from OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180]) by OSOPR01MB295138.jpnprd01.prod.outlook.com
 ([fe80::4f0e:fd0e:ff2b:b180%7]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 15:53:54 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 02/12] ASoC: sh: rz-ssi: Use SSIFCR_FIFO_RST macro
Date: Thu, 26 Nov 2026 16:53:11 +0100
Message-ID: <20261126155321.3834347-3-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
References: <20261126155321.3834347-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0216.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::20) To OSOPR01MB295138.jpnprd01.prod.outlook.com
 (2603:1096:604:521::15)
Return-Path: tommaso.merciai.xr@bp.renesas.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OSOPR01MB295138:EE_|TY4PR01MB13015:EE_
X-MS-Office365-Filtering-Correlation-Id: 42cf6061-0dd4-41ed-5aa1-08df4bd5796d
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|52116014|23010399003|1800799024|38350700014|10067099003|260925022911599003|11063799006|260925021911599003|260925021311599003|56012099006|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261022113327099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eTXB/OdK4RrM9jg0UJVKZg523XFCtbDot9ENGs7WEoKB6auyWQnum/uixGsTv1bCxGNrC3Au5DPIHigVi6NNngvUKIUPMqC67XdLSQ6u8vtIxIAALOntUYYwBt6TIALp/7Jn2duwGtrL2QbHLJPwBcwwIuC0jSHiyBzp2SUKCs8qARYtc+lUoo2Uy8cHD3zpqXY2AYNRWNJ7jXzJv9KwtadR46+hkTbtl/ttpFh0grXiSBVJ3c/DizT1eXzendErwf/iflPhCsB9r8UAxKrqd3v/KOoqiw9Fcg7tjQhbCVOmLdjZxKaqk6YoJUHdxs4V0221z1JOC9+ESK1VtoMyPuSvKbfMdBmZ10OjrwRWU/ko0HGl/eZTu3rSXLHPwLxFetXP+M6jhyRzrOQAgtvIq7xTfc1fIQvLaDsm5aawJT5S1F1isKMLE4rUF2b86RmiCmU1jqppvvKAlZq68KHEa6kOmNz8eUX3seK3DAvZ8akH6mWP10fAB4FH/sCbxPx0v6zmejDdrcUkDHP7SUUgHwE8dnr4GkpMZBlnTU/X3JTbKmmL6m5/WZ2svuuc7Ig4IZEPFiYa7w4qo2Vur32dOw1yeTfm3sOj97XayKCzeqCtBUqZXI059NHAIUYr7hZN75RlTvv4yUEy/i6FO48SvTAn+I/r9EcFRAhSjCE+vHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSOPR01MB295138.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(23010399003)(1800799024)(38350700014)(10067099003)(260925022911599003)(11063799006)(260925021911599003)(260925021311599003)(56012099006)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261022113327099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LVzzCVwlNG5qdvTGogphFW4ExiJJPolAk91g1dZN3Nnqmz8zRVx/TSGjGGl+?=
 =?us-ascii?Q?U7CgbfzLALNrGhUiyOyk3X+Qd1/VVQKE1nejyM8Ad0ahWnCzk5lWsIrVN5K3?=
 =?us-ascii?Q?ps81+Bklqy9B7CStmqcQ5lfoADCw4GXpsTK497PeCI2gYh1vuLKXnL9nL9td?=
 =?us-ascii?Q?eOsvvdtVEyPLsDCVMcJi09o21H0yIxKLGqt/I344XJcsVrar97bn0xNeGgxU?=
 =?us-ascii?Q?MR33Gr0fsuqVJZXe2Xsy2c1c68CQhxM6nC+Ojtz1aXZGexfcqVPViggabXeU?=
 =?us-ascii?Q?fqa6HT2KkNeKUq9DP2ermrn1/thYYk0hazGUGGFkpdUUkNTXzm5yXolZfE7j?=
 =?us-ascii?Q?nu9tnXXLQmRSNleT5QLIXXbgLsXrZF1fXLkXQC9QGXklDlrbeK5GxG3PmDEv?=
 =?us-ascii?Q?QbZZf4eb8icdJDFDt7oTuIBauMgEC/kl4kqoth/ncx6BW134O+dknpbKR4ND?=
 =?us-ascii?Q?0qlVR2JtxJszMTkN42aIJUpOpJxig/jweJaLIDVcj+YXhlSYS6Jr1wVl52OF?=
 =?us-ascii?Q?gpHgvQ1CHIDbuI2Lqm2PDVgOtmwSW1MD4aBkGGJfHYongFbNBCSJLeebHR1V?=
 =?us-ascii?Q?vct0Ua7xno7ckLEfQqADakMTxWFJydOZWNkK8POGw0WM4PO0MwqM8yAcdeg6?=
 =?us-ascii?Q?nlnN7FBRnkRm837CAhzWyIJTVOr5xdmQqkNuDqezwISnI9U7RgogjBbHtd5A?=
 =?us-ascii?Q?rGSTm3ii9ackE8KkY9aJ8DuxzLGWXMBhCoPJCOYp7dPyFYlotkWFHtCtW4v4?=
 =?us-ascii?Q?A2pxBHOfh0HqKVJzPx7GtM4FgLA2DeEQMNcG4QA9i1mvJdPfotGGzHnXdr/p?=
 =?us-ascii?Q?ZbqKfoRHlN/YEuJHT/gtyX7MNSqRb1NRcz7ryj0EQVmiQfOI4H9FfpkP9xxM?=
 =?us-ascii?Q?wrXYxlFLb6YIbYXaza+gGv06LKP9ACKuU8HbyP/dsrrjuTtZBZOCSUaXnHg8?=
 =?us-ascii?Q?b0pTS+AxRnR2pqtswImkl6y/QShkEK6MZkkA0ntWh3AOzKphWVVww44rGI3h?=
 =?us-ascii?Q?OoOnipM9uOaWDkEtTj8nP4ZahJ2YyahZsfsEhrTigJecVgxlAZyshM8juL8G?=
 =?us-ascii?Q?T2WZ50UT72ceEzMTa2ujyAVqFyzlrycB8bXd19C+Wj/WUmNt+ztBFIw1JCNe?=
 =?us-ascii?Q?ax+6W6E/V0wsEe0DQOm/GOjng+QY0g3ZVngIgYnqgunlUCmpqkIBgBZsMkWw?=
 =?us-ascii?Q?b8/BX0ak6tJVYxeD+QZYcWxWYRVTzD+oA0ETnm/7jAGT8GPvApwA7UqhNnx2?=
 =?us-ascii?Q?sR6AMUzr9zy3xfVSBhtr+qxLdC/cV/UNoed+0m4BsffFBnhFfWBTtTF81mGS?=
 =?us-ascii?Q?6WCO/HQPgY2ADqimITpEv268eht8rDOqOUL8KyQtYD10bwOi+KY+WcB3uE8M?=
 =?us-ascii?Q?fd5iP5OWnDL69v4OlK+3DW8TmCHeM9SCAmQNvXzrG1ywW/zRlvoiHUEPRt2M?=
 =?us-ascii?Q?V1TK7LtW3Zmpxwk5ZkJ0Ez3ucG0/s92Bzh/JgG3OHzh1ggmB1YrLk44WRVnY?=
 =?us-ascii?Q?XPpvgK/9CA77SaT8f04SrRkfQ5QLqSvpIP/+sLtFgGgUkFIh9KY/b4yfNfH9?=
 =?us-ascii?Q?l0nXC1qQA3wVVtXcQsq/U4gZtKn1QhJ8oxnxFZmlZmUMZ9DUX1bWPS/9NqPR?=
 =?us-ascii?Q?FEWLo3Pt0dyHh359U4mLP2/9wNq+pid/zlVES8VZrQePWawIsgLJkxf6OcGL?=
 =?us-ascii?Q?co5pCPLWZMvb9DqnX6bdCBowymc9lOU1MbWFWzCPeSEi0HVz6OTzirjeRKRV?=
 =?us-ascii?Q?3+THFqCAD+ZMfUkOnmIVapZr1pEwXIaCBn2GV/nJAxrDe2GYuF1E?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42cf6061-0dd4-41ed-5aa1-08df4bd5796d
X-MS-Exchange-CrossTenant-AuthSource: OSOPR01MB295138.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 15:53:54.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HI/iFAvCF0FanuBpKr1C3Oxktx9iPJz+XT2bMtblhP6VU0o5BK2BPJWiPXDMaywsJm6l1IUG1/qc+XJCJ9gVpqTbrsLIu47aV5SPx+wUWSbrJo+alGI3KMb87GHUM2QG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB13015
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 15:54:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25180
Content-Type: text/plain; charset="utf-8"

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 64207f8024899938f8e13c4649a060a19f18bff3 upstream.

Use SSIFCR_FIFO_RST macro to make the line shorter.

Suggested-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20241003081140.31332-1-biju.das.jz@bp.renesa=
s.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 sound/soc/sh/rz-ssi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/sh/rz-ssi.c b/sound/soc/sh/rz-ssi.c
index bb3be2c338e2..0438de291f81 100644
--- a/sound/soc/sh/rz-ssi.c
+++ b/sound/soc/sh/rz-ssi.c
@@ -333,8 +333,7 @@ static int rz_ssi_clk_setup(struct rz_ssi_priv *ssi, un=
signed int rate,
=20
 	ssicr |=3D SSICR_SWL(3);
 	rz_ssi_reg_writel(ssi, SSICR, ssicr);
-	rz_ssi_reg_writel(ssi, SSIFCR,
-			  (SSIFCR_AUCKE | SSIFCR_TFRST | SSIFCR_RFRST));
+	rz_ssi_reg_writel(ssi, SSIFCR, SSIFCR_AUCKE | SSIFCR_FIFO_RST);
=20
 	return 0;
 }
@@ -360,8 +359,7 @@ static void rz_ssi_set_idle(struct rz_ssi_priv *ssi)
 		dev_warn_ratelimited(ssi->dev, "timeout waiting for SSI idle\n");
=20
 	/* Hold FIFOs in reset */
-	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0,
-			     SSIFCR_TFRST | SSIFCR_RFRST);
+	rz_ssi_reg_mask_setl(ssi, SSIFCR, 0, SSIFCR_FIFO_RST);
 }
=20
 static int rz_ssi_start(struct rz_ssi_priv *ssi, struct rz_ssi_stream *str=
m)
--=20
2.54.0

