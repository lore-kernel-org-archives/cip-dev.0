Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.829.1795110941791514064
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:42 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=AXflpEAV;
 spf=pass (domain: renesas.com, ip: 52.101.228.64, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3AbXpTCkXGBxxvuvBG4pROwOE1UwMti0CPWpq2GHmnqHD5XHcGkjFiMxg8DBZhL27+15LLLcJ/1/ZOcoqhHlTMa+AMjkLH8NG30aKarWNr/o8Tr0MXCgRVY4UpL8dCC108cSqHisCCANPPBxMFHiuRlAz22ZqZGUiSmMxiMqri9UwLUytZxfMmgZiBrpVgK9DtfQUjHz8yR6LfMuXMV5BKD5fAvZS8dpZq0Pl2I05fsP+SD5AMmoUxtrJrTkL2IxB0xuuMF6R9tBjuLqTCq0x/KegmP5rHG4AOuasWVMmbA7L5KnGBsioZEMBx7m5A16OgNi3cZn1SXJ67lLgLg/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6Htv5pZcr7syv3BVzNDDnsALg/ONg6/yGORTtDxvJo=;
 b=N8Nhkh3lGiAmgp2kNUltXJYnVymRk5+39LperyLenB6dqrScK75Ft4dr/35Nku0vXFNVToQNF+1ZL8IB2BOGuvCPgZWpPhe/o/uYE+9XrKg4/owKmd/hvIvRwU4Ty9+BR7R62QkjNIF+D5nAckJC4g888LkFpskaiIXsQLjayQR5gPj865RkUPLDSvREnximZfbhr098SA2/jDT3mVdjDJnL0Gb2lw3nRqnMXvtF5K7C6Bh/yKyAuUt0m/WyPTDi4m/AqRGo+bXL2JLa977XOBcYrg6cbzbJ3dGcHCx4BvjVWY/1ZKhuKK5WNT8FOQYGQRN9BSmy1Rch8uw030GpQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6Htv5pZcr7syv3BVzNDDnsALg/ONg6/yGORTtDxvJo=;
 b=AXflpEAV3hk07SEUXQ2ghjSYPxqejNYBvdZh/hchZv1fBm7hpsGiwFbGFpEwLFozhVNM6jWXmSugssnTcqrJHh31AB1RyVlSf0w34b31OL983ID0p1fvhlO7XJRQmWdZuBAOE5TOaWL4BpXvYhc6mAy7CAsOiBVfY6Ryg7OtHNY=
Received: from TYCP286CA0204.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::8)
 by OS9PR01MB15231.jpnprd01.prod.outlook.com (2603:1096:604:3b7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:55:37 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385:cafe::6d) by TYCP286CA0204.outlook.office365.com
 (2603:1096:400:385::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Thu,
 19 Nov 2026 17:55:37 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.5
 via Frontend Transport; Thu, 19 Nov 2026 17:55:35 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 80DD9300024B;
	Fri, 20 Nov 2026 02:55:34 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 0/8] mmc: renesas_sdhi: fix eMMC test hang on RZ/G2N
Date: Thu, 19 Nov 2026 17:55:25 +0000
Message-ID: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OS9PR01MB15231:EE_
X-MS-Office365-Filtering-Correlation-Id: b95a4534-bca4-4c0d-505c-08df46665052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|36860700016|82310400026|23010399003|56012099006|11063799006|261009223027099003|261021121427099003|10067099003|261102123227099003|261026140227099003|261022105027099003|261026121527099003|261021123027099003|261028144727099003|18002099003;
X-Microsoft-Antispam-Message-Info: b2nz6c1N+7cMoQOuPfx/irXWi8llWRwhHLAOxtwn7mbWyzyvoe2H/puqgxeBtcvFTQUN8r66Be7y2v3BZvoJwKu68e/Z3MIcXyuT9CLki2sbzCa+Mqe75/7YyAoBADX4nDpeR5VUTbWRXfGfvBVO1jnyYTZQCbOb1WJ4IBhS9lF9R2Q2GU/aqeL1QM56BNpCsRCsvNojIdtcFE1uJB8+XA3hR+aKMUEX1Aa9CFWeuISQghMkinZxd4B+psQGHAeWtzM3l9gwsUbI4fDXiudZLRw097D5mqkgs4LcruPaItf/7Je1lVflAf1b71trsDk9DKCLTFtn5G2A21ftGEbn/8Lhf8i7IFUkLFUmTkHKk7pA6qTIHdVJbOlwEI9T3yveTFWE+cfzaZ4UYD+VqLwjrAF6xpNExQdy22i6tuiWhJCCEsesyn/XaMAueyjdxtDFP0OE8R8Gt9SF0jzEoUJ9eHn+rAS7Kucuk230VfilTboyJC/eQnGCIcGq7dVt49cnv9ZFL6LDqrlikBnt29gXiPPZluUu/n4Bvp876Wir5R1QTm/OIBf/nQ5x+lnyYzGFXlrwQwOC+IJ7VPbxVFIPoK09FPGikzz7lGnWO7yikNc/kplpAGb7JOzvlpybUKbDbbwqftarFkmSKKFUDVLOKsfHlQ9rbM+4EntmCYADI4W6cufr3sPYvAAbDFc8Tr/2gIG+3tI7Y5awIXI8Vto0aQ==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(261021121427099003)(10067099003)(261102123227099003)(261026140227099003)(261022105027099003)(261026121527099003)(261021123027099003)(261028144727099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lP1j6xGDl7Fo9LtDFt4UwR4qWv5tMMLtsMnPFmIkLCPqZ+hgUnSqg2180MbUFohUOfnDjvRQIsIrsgvMLsYeGjU8mgiq/JIwvL+v9C2WmiaE7rBiX4ZBqzUzP5BUST23Mumc2UBAi5NCrJmwXjqjjgkfQMK27AWpTx5LaMrbxbT+Yo7lBbQNTaGBpCxM+w9cAdnUZRLbcg7EerJTPlGAqwSJ3VF2+q6dXokvXUin5p7tuL2rL+XYF2WWrPA6LMZHGt74wFUIgWVAc6vzFQEM13Cm5Wpv4Uhss+6ukbXjaUbySYhxg9WuQ2kr6243uko2Ho8tP5Dfe9ATATmzbkmM+H84Oi4qq1hyRs7VRd6nly9EtyqrnJC4OpK0QXiZH7FLzIFFIlpMgLBhD8Eb7U3VhOqv3Rzc460pJJnj9P4dIhbJ4FA2erWxU0THCqKo1v0x
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:35.7574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b95a4534-bca4-4c0d-505c-08df46665052
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB15231
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25016

Hi,

On the HopeRun HiHope RZ/G2N board, running mmc_test on the eMMC hangs the
board on 4.19-cip until the watchdog resets it.

This series backports the upstream manual correction series from
v5.7 (patches 4-8) to fix this. Patches 1-3 are support commits, so
that the series applies cleanly.

All patches were cherry-picked from mainline and apply cleanly.

Thanks,
Ovidiu

Masaharu Hayakawa (1):
  mmc: renesas_sdhi: skip SCC error check when retuning

Niklas S=C3=B6derlund (2):
  mmc: core: add helper to see if a host is doing a retune
  mmc: renesas_sdhi: add initial setting of interrupt mask register

Takeshi Saito (2):
  mmc: renesas_sdhi: Add manual correction
  mmc: renesas_sdhi: only check CMD status for HS400 manual correction

Wolfram Sang (3):
  mmc: renesas_sdhi: remove double clear of automatic correction
  mmc: renesas_sdhi: enforce manual correction for Gen3
  mmc: renesas_sdhi: cleanup SCC defines

 drivers/mmc/host/renesas_sdhi.h      |   1 +
 drivers/mmc/host/renesas_sdhi_core.c | 109 +++++++++++++++++++++++----
 drivers/mmc/host/tmio_mmc.h          |   1 +
 include/linux/mmc/host.h             |   5 ++
 4 files changed, 103 insertions(+), 13 deletions(-)

--=20
2.34.1

