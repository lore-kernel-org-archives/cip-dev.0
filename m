Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80144C43327
	for <webhook@archiver.kernel.org>; Mon, 29 Jun 2026 22:53:53 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.49])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9688.1782773630189339002
 for <cip-dev@lists.cip-project.org>;
 Mon, 29 Jun 2026 15:53:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=OObKa9O9;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.49, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cawyNkB/aMHbJ/Nw4YrwtjrqNqVmW+Q/rFtr+gcXL0p4AEhr3hOHGkm+2otAv0iciEZ5dTHWQvwsrb5MK6akEic2T+6Dlgm8a9q/nDhbx+TvN5zotXgxgIJavPdDwbTggtnaaRLvXoUF1iAZff+ftmoiHP5zC/l/yL6tMrdqcFBdYnjhSoGBdMIWygHVbp8JWdTDMmQFewBqYzOJiDtMDNE5RGVyJxD4qjhxlXAoj4oy5psPMRsjdrXU1HNbN5PSbXjG9Ja2UMI1x4gb6Z3EKVLk+luBjn8YcrBlrllkGgu81jHGLlTOURL3i//iwuLRBQ4LSyPKx1d2oV8Nq6TK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umT/71KQk8qkwDZq5p0LPfsds3sjSnH8MjaFszif3qc=;
 b=gsj1vKCQOTmS8zyPud4QIpzyAgkADUZHJpEkuVIrNhWIT2ZwJhjAQy0ivid9XAqVg94NhRP6cji5qgL0XZHARdmevkE2EionY3HMLZeP1YvzGyvDnUJ/BuNWmV9JLLgZNjLiXV0l69wNGD5ZRuTdt6O6QvrlfhUVy6g3rFymrXiR+2JHta5I291HrKHxR6wOa6GOUDSOkrfW+PMNFUocm5r9ut9KeVo6ceQ7/hOtXA5vza9UHlKlyxOqUXGVlKw/6av14T91PLKgd8UzsQKgr7G8pkopQDbEhgZDH11ltZ4Mh1VyzUuku5tdNd5Q75VM+rvuhyx5gZW2teqSebJ+Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umT/71KQk8qkwDZq5p0LPfsds3sjSnH8MjaFszif3qc=;
 b=OObKa9O9NvIYe8SPgxEnClGnoWM5hXZh0nc8fs8u0w0QUUSEf7a9rS0zeXrazVBs+3K394xZybZcCujHptQx63a2tcfeIrCk0CcrsigphwHLsAHYQpjlkKsRHmjwHa2qAclfRC1Hix2ns14JZZynr52XCTBPq/CIyHdAotXPljc=
Received: from OS3P286CA0020.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:1f4::6)
 by OSCPR01MB13393.jpnprd01.prod.outlook.com (2603:1096:604:331::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 22:53:46 +0000
Received: from OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f4:cafe::8a) by OS3P286CA0020.outlook.office365.com
 (2603:1096:604:1f4::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 22:53:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003E.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.6
 via Frontend Transport; Mon, 29 Jun 2026 22:53:45 +0000
Received: from Ubuntu-22.. (ree-0065929.diasemi.com [10.24.0.99])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 9D24B3000255;
	Tue, 30 Jun 2026 07:53:44 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 07/11] pinctrl: renesas: rzt2h: Fix device node leak in rzt2h_gpio_register()
Date: Mon, 29 Jun 2026 23:53:27 +0100
Message-ID: <20260629225331.10023-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260629225331.10023-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003E:EE_|OSCPR01MB13393:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 88ff4108-88c6-4263-08e6-08ded63146a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|22082099003|13003099007|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 
	NR9s69IczJJT3+07rvQacilhpafnd9702VP48O64YEDXGnevE8r/if5G879rzjS/MJDMRxZoDlCgUKAEjlc8P2QZak8sXbp6JlFSramuN+3Da+dMW2DbDmHq0GEHUtwM/KWvVe5upoVgAvfmIrT6CUfsjtIYALMAKnusXxGPfs9jzIvqOBevVQW7R2H+zQ/N3KDePVbj/KEFujGlwTfSMezp3vckBe/tfa7eaNYazMIF7YIYgPWboLq3Ej1SPICVEvJRaXfLjMnVSqYxiey/koyidcIWt+S+IwwIO2eW7CCr/pDtUumhIHvcl13+1yH0jgoCnywzx+ETJkTmORWJ6sJnqYmRxH+csicHhowxJcyg8+UYmcX+DuRxHp/2llEdri/OyBj+aPiZ3JagwQI1ghneOHzTVA/o1xZAuUtc9m93FauYFYk5nSFIWpOS6BEjafaQ8RepRBo3/TNCVaxzW3iRBMTShdxxx4YnnOMIdl8iv15wMS//STOJX5+P2DeyBAEuOpzmCn4H56+kgeu1PPprmgxf5O8ajUTx/ABevDSopha/vQCK/jlwI8Q5JkfgxnRWh2Y/aGAoHj109JdORz6jlU5BimgkGppyHKz4uOKW79cZM3xnunZBMtZUtevQhJfc1hbdE91a44g8QczSV+hi8XSMk5mTpcubkQ8NHr0=
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(22082099003)(13003099007)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	503TCblNyNeRGDGcvmfvYsBD+dhtyYEeqRSULDc6jfZ/kq9yuFt7uNH7MVzil2pP+I6VRkUhhJJNJdRfW284pa94XPYQO2iya7LTXyqfq3qkk0xIqeJMhaZ2BcW3Zfm+42t/7pzgF/whCgAAR/wLbxnGuxI8XEeVwRy15grKAwd6C5zrFG+61W9d2YSTMfk+tWrdof/SAECN7kcKkG+wPbH8RMAn7vInIPdScLNea0krhe89DCCUXxk18G4J6SiNi/bvi+z6LIWC+6Jraq92stA3DqtKhpWfwUvI18+opKlP3X+puVGIDa3i1HoTgMDjSANNbh0gT7oBMP3KX/Co+XGy6Mn7fctX2VW+mYDJ78ms4RIMXk4I2xrAKmVGnAXVX/eMK5DzEpP3cqU5AjEkPOXyrg96KRKe9oLZ0ArQ+JXnMY6sdaso56nPh3/GqCJs
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 22:53:45.9765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ff4108-88c6-4263-08e6-08ded63146a9
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003E.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB13393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 29 Jun 2026 22:53:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23315

From: Felix Gu <ustc.gu@gmail.com>

commit e825c79ef914bd55cf7c2476ddcfb2738eb689c3 upstream.

When calling of_parse_phandle_with_fixed_args(), the caller is
responsible for calling of_node_put() to release the device node
reference.

In rzt2h_gpio_register(), the driver fails to call of_node_put() to
release the reference in of_args.np, which causes a memory leak.

Add the missing of_node_put() call to fix the leak.

Fixes: 34d4d093077a ("pinctrl: renesas: Add support for RZ/T2H")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/20260127-rzt2h-v1-1-86472e7421b8@gmail.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzt2h.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzt2h.c b/drivers/pinctrl/rene=
sas/pinctrl-rzt2h.c
index b4107f18f5d6e..8dfdedeac23f2 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzt2h.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzt2h.c
@@ -831,6 +831,7 @@ static int rzt2h_gpio_register(struct rzt2h_pinctrl *pc=
trl)
 	if (ret)
 		return dev_err_probe(dev, ret, "Unable to parse gpio-ranges\n");
=20
+	of_node_put(of_args.np);
 	if (of_args.args[0] !=3D 0 || of_args.args[1] !=3D 0 ||
 	    of_args.args[2] !=3D pctrl->data->n_port_pins)
 		return dev_err_probe(dev, -EINVAL,
--=20
2.43.0


