Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BF3C88E50
	for <webhook@archiver.kernel.org>; Fri, 11 Sep 2026 08:11:42 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.58])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.34546.1789114301746671831
 for <cip-dev@lists.cip-project.org>;
 Fri, 11 Sep 2026 01:11:42 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=iP5MTC5n;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.58, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLFCUPVDJ0Xc1Zil468jpKT3RsrAae6oNT73USj9qoiRststUatbHsLfHcJREsnM6oL2Ugh2e4I8/HUdme6IlPCHP84hgsjQsysSrlHxhN5O3qlS2Tf/xDUnMQe2G57fxwjL3d30MyPbCarte13wS/68vnmbZ7+zvpe1it8BO5SSX1j608BKEecC0iMARGtH9iws6iu68D4NkJ2pn9Lh19sScT/CkrH+YrJ3qeRp2soca54UU0p2EQVLg6v466sJaHGjyd7aPqqv1XCuW1WWsr2hPFS9bFNnJywYjWfTlrOf8HIUJ/YmL6xKBpLqAORlMWSTKgO3++Za5lWFRqbe8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+c5ac26qb+3+VGPPJt55F/n8quKh/U5uZw51V2CG/s=;
 b=azF//GA+OWOnJtfDHEV72KqcFHcC8Y3Zno8waLNuEp/0ZEYBNXrcC7voD2AE4r3vqHyBivEhI4kQsyAMGpHsEsYnacQM+Cu34MAZiYgjuN7WnIv0+vE4sWisaM3Tom209z2IHFI7WnJg0UqW0/7XSaGC3MK5vsSZFJrtuXyuQSBt3gMkz7MrCZJpV5J9iOj8sqyxEuGzHUtjozJTHSNxcgP1DsvrPuhVFhEkOqs+P6h1V7hM8rmnFnAyQ075WDFq37YcXfxsbsVX7FXcEo0QRNoa0uT47Dk07vDTVBv43TKJHQ8I/qAUSbsyW1upbuJf6Z+pah01bUr6rwJR+z356A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+c5ac26qb+3+VGPPJt55F/n8quKh/U5uZw51V2CG/s=;
 b=iP5MTC5nDX7wdnfSC0gyJNtqfD5ENQrgPQLGulaXnPCBpHq8GMRuoVSxW6DNe2Ej4nSlMtXqu5N+8JTYD7FHc96KB+z0ElHuYtvjzozPMnWLEbrOKblH24ghi+lIt2xVN4PIJPhBokg+997a6NXneOd+NQwmKJz2A+C/2nozS2g=
Received: from TYCP286CA0006.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:26c::14)
 by OS3PR01MB10106.jpnprd01.prod.outlook.com (2603:1096:604:1e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 08:11:34 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c:cafe::96) by TYCP286CA0006.outlook.office365.com
 (2603:1096:400:26c::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 08:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.5
 via Frontend Transport; Fri, 11 Sep 2026 08:11:34 +0000
Received: from Ubuntu-22.. (gbr-5cg2238qm6.diasemi.com [10.24.0.235])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 8711830002A7;
	Fri, 11 Sep 2026 17:11:33 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/8] Add DMAC support for RZ/{T2H,N2H} SoCs
Date: Fri, 11 Sep 2026 09:11:24 +0100
Message-ID: <20260911081132.11879-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS3PR01MB10106:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6c59d739-a497-4520-2d06-08df0fdc4bcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	+hNUWanJIROQ9reHVZM7+WD1iBqRouyMlPWlrBZP8jtyNr3WENzfse1UXYJOH7FG6nf5L+D+wUFnUDxW6sauhOhQR0PIAwRyqBAd/0GhWacbW4rWEZBmC2IAXNV8QhjpUYMZI3tSxCRcC1qUtXFhOFjzM0cRERnAkehdZC3N9E/ABHriK865IoMmJn0nS8OOY4Cqf7DpaFLlaqaitfxKvTSNxVzqzNRn0tdN2+VcEGaeOZckYDrMxvkMfvd6S+LF6xHbimO279SNTpvMK//iGleRHTKFIzV65OyQtgMlGA8nOFQoJ324rPRz3Z69hxKf5tdhdX2eli6XuSzPP0cBVsyn3QsJT4Xo851QNJHbtZidlz7UlE+WQ5irgVs3rEyIbXtuTonGPJiJs9QkqL8XMN0FLUiyHD16fmE5y7dAK5LNTixdiwCMBf7/wuJjEj/nO68TLnKf1jAKofDSrCR5Wv/KVjLywK/zE16HadBV1zCJJgk66Nx4Z91LPKkMQAhdwshedyTY3sBSYYKDXw01KqBbph5A46sV30ZEXKQaflqRYOb9Gsxw17ZNqZIHizxKLZrZuH2dIGL+a8rYgo4USftiqFC7ESaeoFEzlzLUK3LCphoViqC7iLEidcu8CoZnXQXmla8omjwcbd8KA0Oga/ffZUjzdXtGqxC9+h6ChkZVe9KCWBUkwwGZjTXPxQAi
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	6x2s9a2uz1zL/y4aID5DjkdJZ0S1ImKL+peKOkcKM02Oc2mxGjqPzAaMBf59+wVHKsa21iPUWbBrWS0paG0rB8uYEOTTES4ROC2ju9MQlcU8Qq78Slzwj+BkK+jeYPatsOMdtICuB37PgkKbc6v7l/UYUpzyzq8he1e0XbRshzPqpqnhRk0hE7d8yi5ymh7kONyTm6XeA90uyxegn+pR3A2V/GbBO270NlPtsz3UdZtvA2z1Jmw107o33dp8jzB1g8v4LwdrFpVQQFBqMWQwTdcBo4SgclUn8uqMWuywOoKABwn5lSftKqRimTwsSeIjHie1VgUtPLsO4Ic3uTwGTvgzkVSAODmpPQkFMS7fneAISNdeiLvKe+sOQ+OG/j8KnN5RpwUMWVRDpKz/mvK4Dgu18KtOB908jIP1C2SMef408hbFHmLbRzzU+IUpwvLS
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 08:11:34.8479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c59d739-a497-4520-2d06-08df0fdc4bcf
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10106
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 11 Sep 2026 08:11:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24118

Hi all,

This patch series aims to add DMAC support to RZ/T2H and RZ/N2H
SoCs. All the patches have been cherry-picked from upstream kernel.

Cheers,
Prabhakar

Cosmin Tanislav (6):
  dt-bindings: dma: renesas,rz-dmac: document RZ/{T2H,N2H}
  dmaengine: sh: rz_dmac: make error interrupt optional
  dmaengine: sh: rz_dmac: make register_dma_req() chip-specific
  dmaengine: sh: rz_dmac: add RZ/{T2H,N2H} support
  arm64: dts: renesas: r9a09g077: Add DMAC support
  arm64: dts: renesas: r9a09g087: Add DMAC support

Johan Hovold (1):
  dmaengine: sh: rz-dmac: fix device leak on probe failure

Wolfram Sang (1):
  dmaengine: sh: rz-dmac: add r7s72100 support

 .../bindings/dma/renesas,rz-dmac.yaml         | 100 +++++++++++++---
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  90 +++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  90 +++++++++++++++
 drivers/dma/sh/rz-dmac.c                      | 108 +++++++++++-------
 4 files changed, 326 insertions(+), 62 deletions(-)


base-commit: 9ac614bae427312bd04cbbd221d65afdb77353d0
--=20
2.43.0


