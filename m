Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916A0C624D9
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:27:32 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.46])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.8323.1788341240276524265
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:27:20 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=csPP1nHn;
 spf=pass (domain: renesas.com, ip: 52.101.229.46, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ka8XG1qttIjQ+ACB7GeD+kwvRvdEtK32DYTP5at2cEgqB/jjbFa9kvLGBKmZ0JNr2Pz/Kzdx8CO67shbmxXcefpzNIY2IbJDXQMuhHTq7nsXkRhUiXuf4rcLCzhrbC6s3Kpd3M5GuIcLsIf2uacuv0y7+zr3EYiTBsD5tsMn8crQXw7LaPbc+xM5ka9Ki2l61vBW5a4PBjt+TuTt/V6ixZsFww8SpwU0aqdlXF/k5tl7Xe1cnEHd70imTRyNwuMN4g6G2Ud/GlLFiuDOwOMejq+GxQ2UZ7C3K1wbKLIhJO/SsvVKGCChPUSdf2V1LcmLmUsySM6kOU1VB2I3f/aDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PggJDOupLp+maEPVUBrLOn+f4eEtz4MSocMH8rHDU3c=;
 b=CxrAaXh7Q+Lxn7KOLqyFvsOkq2guF/tpFSHVRwIBMNJbZ1q17oBsjjZxEci/38Af/A2MJWvkZ9KmcqtUcFVPdy5OnRM/Ynsg4T6jpi9ikj7BCKUNqH2M21AFXroD05fh/nLoP+seGVundux+BsYo0y+PLPIgdsO8dmu4pexVe0mmpGfec1YnEbObhaeDQXe8tn7lH3omjiNkQXgsMCAfxikjN2bctGQslMaCXJFuX2mNoHSQDAsvYd66trJpkJJW3+4EARf1F6kEFG9JQ6ikgVK7gRISoQZRUTPy2RqCAog3uzSWPe/hBlzk1v+DZ0zblwxJuO7+0UX14bVH94ytuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PggJDOupLp+maEPVUBrLOn+f4eEtz4MSocMH8rHDU3c=;
 b=csPP1nHnyGHGRXRm/oBumlFNF0rt31zuiWkQrnPHrgRLe0OdR03iJGiFvgxzcvlAUAACDfsG2BncfPEoex1HUUmpwnEEFufDpi5pT6xEpMbnZ+G6OB9Q5EN+aoKuFZbLk2/XwO1Gmucm16YFthRB0DPvVNARioptSgCQW++lJgk=
Received: from TY4PR01CA0047.jpnprd01.prod.outlook.com (2603:1096:405:372::7)
 by TY4PR01MB14830.jpnprd01.prod.outlook.com (2603:1096:405:25b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Wed, 2 Sep
 2026 09:27:16 +0000
Received: from TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:372:cafe::24) by TY4PR01CA0047.outlook.office365.com
 (2603:1096:405:372::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:27:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005020.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:27:15 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id BD15B300034C;
	Wed,  2 Sep 2026 18:27:14 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/11] Add ICU error and software interrupt support for RZ/V2H and RZ/V2N
Date: Wed,  2 Sep 2026 09:26:51 +0000
Message-ID: <20260902092702.24746-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005020:EE_|TY4PR01MB14830:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cdad8cba-17b5-4aeb-4be2-08df08d460cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|10067099003|56012099006|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 
	xl+hW/WUpzcGXZZ6mJZcKIxIzPtpmfyZaAoHeu05PGn+JVgo13xo6hkBsN9gm3t8MILq8qusXZRvzaKEXua5kCfAJVlSfDt4bFgxs0w1eT+Pj/ag921VCijqD4WtSRKE7W3dyWU3siffgLqBE91T09mZUu6lKiNH7e5DVm397XPgsjp4IR4imBWLIGZ1Ysw/+22V7UeYDapfADlWyvgkw+T7DyN+BPoxOm5L0DTBsgELjqqAUFupP9QAqBUsMCQHJPfFTKTNZQNEQ0s0oPmlHYr5CF9+/OClrXYFut/8MzCepb3tIocV6fiptg7mhJ6Y/tflH4Yb5ziHmChTUYe8qKvbZnqhO2BNmySMUBbSwRGjoS9AJeCA7o+Fc2T8oN9rztLl6GNxftqQ4kMWjlnPGknzQTpfP1WE3WeozTiyMmcTLZZA1esjQ1ws3v/Ez+3Ndxpgf3GZ+pCmGl5dL7qUaamURmj1EGkwYewQ63fdcLXLht6aJfF4l0dogYyNWRFcx3GZEuM8eKOqdFR+jPzwi/q3jYWvasV50zy8Gz+hyqWqsKrHaXqrVEHV/Syjw531TpiUDrRaPEBrydZPmgXI5aqaO1JVWksC4f/Ux4ohV0DJq+PgDcvXhCeins3ldUV/MjIwZ8GopIt6NTq9uD0dwaHzSpa53nZpaWPqNvw+c/bZMYOZklbDqYdQMtjGEJIu6sXOcN3Iv1q2BUQKwJ7IZw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	Qmfu6kjoNq6lbTv5x3t6xtbw25roQcjd0RMhedjVuLLLXJm0V0vokgM/cNt94APheI5oUqJ6Lc+3EyXIK9F0dfQbb9orbxDGDUm4kN6yarwAKu5RoQDzXlE1NIdtI9SKnWWF/m4kuN44t5ilSpzQoj4UezJ4Q9+BVXSGHrzkn3HvOWtpgfsby2Hke0vCQZRLz9janbR1xXUo9W1i4OeL7hdrynDl9dTFN1f6Ekc3uRGfv6l7BEOIhsRDToo2M1LpFcSbq+j6K0kCN6/ClQx01+qhLOu94kvuMqK1w1b14YCxsKbFv7ISyT/cef45pe7nxciDrHxG15UoGVDBOLci13hVDYvQNQe5hOq5jfeKiFYafOhoXj/NIek7gQeFCsZT3F1H9zkTiIqbRaG/2QQeoVd+p/NoKVyumfEH8tB5/0TcwbRzVqp7GVQnRw1nf3fZ
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:27:15.9564
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdad8cba-17b5-4aeb-4be2-08df08d460cd
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005020.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14830
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:27:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24067

Hi,

This series adds support for error and software interrupts in the ICU
driver for the Renesas RZ/V2H and RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Biju Das (1):
  irqchip/renesas-rzv2h: Fix error path in rzv2h_icu_probe_common()

Geert Uytterhoeven (3):
  irqchip/renesas-rzv2h: Kill swint_idx[]
  irqchip/renesas-rzv2h: Kill swint_names[]
  irqchip/renesas-rzv2h: Kill icu_err string

Lad Prabhakar (7):
  irqchip/renesas-rzv2h: Use local node pointer
  irqchip/renesas-rzv2h: Use local device pointer in ICU probe
  irqchip/renesas-rzv2h: Switch to using dev_err_probe()
  irqchip/renesas-rzv2h: Clarify IRQ range definitions and tighten TINT
    validation
  irqchip/renesas-rzv2h: Replace single irq_chip with per-region
    irq_chip instances
  irqchip/renesas-rzv2h: Add CA55 software interrupt support
  irqchip/renesas-rzv2h: Handle ICU error IRQ and add SWPE trigger

 drivers/irqchip/irq-renesas-rzv2h.c | 469 ++++++++++++++++++++++------
 1 file changed, 370 insertions(+), 99 deletions(-)

--=20
2.34.1


