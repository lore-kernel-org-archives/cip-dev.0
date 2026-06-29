Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25438C43638
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:54:04 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9261.1782773635014823544
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EqRu72fB;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.47, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iL7c9/9kYuimM1yPf6PKKM3brL2bVZl+QhumpoX/gRvvPzDsMImHhrfYhNm6VvwoW2Vqb7dZmhoi3PAyhcUKnIKHaM2t1O3EjYnQ2P4YdtUlNIOfJ3DmKfC3+UZESuwIbtrH1z5SJxk4UcLU3p0YOXsvajAHBVF+e746qd/wU77bUxUigJCyvPquo+TXCAcE384UcJhdQMmVvZ50dg3twzrK2jFlmjHIMEGtvSpiyKQ/eCuxTycUtKEItbli/8sFiamruGF2N19K9WSMxdx0z7pLuKVdMeGXiKZqubKJkhSUx1fsFkR5eOXc2ZqHnqdlZyexIjesu7icTyyiyg7Y2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G03yiF2xwywws02p7lfv9MlZh9N29wibQNBactvxhY0=;
 b=K6fnRVoIhTyr7DPXFMH9W0xwEjkJk4atEyG7Nh2cTIt7+NeLxjuakkPFqe12hMQp1A8H0zpmCV548YH/Dn+QJQfFu6KiLEPrEUAesMQeXLx+vWXoRGrQJKY0SsQDSW+bCh9Q3sIamNXT7eJF/Rfqvr380YnjCNtm3v2IUHWlQa+h/oZKOHch9nGaYE+bZsIHL/vvK417cgrwhzYVVGmPAaL7MukLQCSpfDXmdMVO7+sS8FRSmUIQXjM7+/e3Wu43J9HHSdotLBJXIO5sgGo9LhiLv1jRS257q5ImGV5WsF2pGL+uGJw290evj8hKJlkYAfgOwe5RYU3AIkyWdGI0UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G03yiF2xwywws02p7lfv9MlZh9N29wibQNBactvxhY0=;
 b=EqRu72fBX48OWWIjxTBOZNd8AfKgJBwkXZJw0x7m9cOy52/sZYrT7EglwHl6tKHoZrqVBEJQLVTWbxy24jPqlV598fHBD+Ra33YbHqmWmM1HfcTNLVKmgy9bERhdjnI2ThejnVaMmXmpCQNp5YEkjuSw5vjCKyFYg7j9ISO9dWQ=
Received: from OS7PR01CA0093.jpnprd01.prod.outlook.com (2603:1096:604:256::10)
 by TYWPR01MB11060.jpnprd01.prod.outlook.com (2603:1096:400:398::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:51 +0000
Received: from OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:256:cafe::66) by OS7PR01CA0093.outlook.office365.com
 (2603:1096:604:256::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS1PEPF0000D20F.mail.protection.outlook.com (10.167.240.38) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:50 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9E4E73000255;
	Tue, 30 Jun 2026 07:53:49 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 10/11] pinctrl: renesas: rzt2h: Remove unused variable in rzt2h_pinctrl_register()
Date: Mon, 29 Jun 2026 23:53:30 +0100
Message-ID: <20260629225331.10023-11-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS1PEPF0000D20F:EE_|TYWPR01MB11060:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: fe63664b-6691-4abc-3065-08ded63149a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|13003099007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 
	eX9OlmtE/qlR3azR0UZmN5yhUVEvIHRFR6Rk6lrXNHuiAHXpj3176S0jnGIoxWxa8wpw+DrQyHwrFu4txUpaIwxprEhX0VFWUZPkEJaK2HuhDeSRFboyIk4y2TTaH3+nPZzkqFlMU4z1VwAuwMy3z3jPf4kS3r5zJp3KDlzxd46bKmjvHq4mod9N3nMYidsyUY1U4vAIsiPiq0n1GwYgXEMTXqpKJd5iu3uj6EBzCGG4vpArEXBQX2dNf6urMn4/XLugUqXpj/QPiWQLxjvjBXQVfclNJjuMbzZoEBYxDvhnNnqK01Jo01oXqH1TneDANuoMDChsgpV9eWSk30s0hMSHVe3qJNp9ed6gHWTRZubD8i/314p9ld6z5h02XoWBHOX2WcSmt2gsMFgb3s9/S4Qwts5+Kv22H+l1gSovH9foLPcnlZ4+RAOz3xszsGtK3eK/KI8MUfILFcJAQZzyLJ/708rHvUpZ6dIXIxYuvzjH5ZftezBrEHSCUoZcGTAaCEYD4LPoUn/1ZI2/IgHYMHuCaN6m5mGNCZ9gcB9wUrDlh/4t0VSbEAY8FctYxNzcm3Oxh2bN0UDR8V2ITIm3crIY29K8+WGpMzKa8yxidlOgr3OF+SZEXwADT1/W/N3py5t0F1z9IA5JUfyEkKdAOSsv7Ri7qKZIu+NUj3edBRI=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(13003099007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	RWlsYj82g51J2ZjLNgJ/5X0i3Db6dX4HZ6FQDgij9iV8ULNSy82IQbdFW6xhgF5nlQQIfEADbLMCUatGaiKnla7c9Oj0Z5t/pSXSOWLYgU4kR/xy3hxUDnCrhGRRe/Zde1/nQfuJHwCidfQiVVjixE5LY77WKzVwAfLl3vhVDi23M6cxjk5pQdjNd0izy1mgsvvWU+rfpNEp7Bh4xi+U6e+21LqwQieQLItsDU5eZDgwP4mJ6Onj2Ebrj5zRAXoJ8djZXYDwz92i8fYOCgaemitlO+50YkXaeDRGVf9yG6iLKgnVGlLQ0O5PoYWUHp5YxOfOYUF3ZwN7Zt3hh2VExhpZ1/HbdoBUSJsj31h7beB4FzN3q7pJDw3JoYXkJoXOpvVkHHBUrwhGNWERDvY7cYXB/3P2QDlBt4N/rxDwf9Kjh7GkwI5PXjDD/WlC+cLy
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:50.9848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe63664b-6691-4abc-3065-08ded63149a5
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS1PEPF0000D20F.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB11060
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:54:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23317

commit ccf707ca74cbb1d7ad0f99877518d2e3fe58611a upstream.

Variable 'j' in rzt2h_pinctrl_register() is incremented during pin
descriptor initialization but never used afterwards.

Remove the unused variable and the associated dead code.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260513115312.1574367-2-prabhakar.mahadev-l=
ad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index d127e150b41e2..b620817f82db9 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -1138,7 +1138,7 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinctr=
l *pctrl)
 	struct pinctrl_desc *desc =3D &pctrl->desc;
 	struct device *dev =3D pctrl->dev;
 	struct pinctrl_pin_desc *pins;
-	unsigned int i, j;
+	unsigned int i;
 	int ret;
=20
 	desc->name =3D DRV_NAME;
@@ -1155,11 +1155,9 @@ static int rzt2h_pinctrl_register(struct rzt2h_pinct=
rl *pctrl)
 	pctrl->pins =3D pins;
 	desc->pins =3D pins;
=20
-	for (i =3D 0, j =3D 0; i < pctrl->data->n_port_pins; i++) {
+	for (i =3D 0; i < pctrl->data->n_port_pins; i++) {
 		pins[i].number =3D i;
 		pins[i].name =3D rzt2h_gpio_names[i];
-		if (i && !(i % RZT2H_PINS_PER_PORT))
-			j++;
 	}
=20
 	ret =3D devm_pinctrl_register_and_init(dev, desc, pctrl, &pctrl->pctl);
--=20
2.43.0


