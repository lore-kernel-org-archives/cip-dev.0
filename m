Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.61])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11640.1793623998240454581
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 04:53:18 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=HNECTQ9e;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.61, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=okWisboxb4NMe5Bu+1D8znS9XJ7+EgixdVqR8nEn6r+9RtMrs33Ag/N+X2i2lFFrBqWZIxZb+eo6eh5azNiD8O+0WqEsJ6v5UZIrlAKiQpZQLgb8Vk2NpzxQtZljrm4Ffiu7tLIFu/l19NFn3nFccqdskdgZ/+u5dT5bKg7ykghu4UtiXttZQMEuNLJ4yvk4UnYNaVKsEayzHZuxA5mchNxF4uEMHCeSbKhrmm7eB3cAgJV0PbI/FVKrSIXXjPdpRhjtlmYHfW3az4VT844zIa1DZHDS13er6eyPGP6s2T7NflUo7S77X4Z70tlMETHkefspUMF4kjS9Lmj4aZ518A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3D33ApediKxQkvR0wUxqyq82ncTdUQveyDd1U05kVSA=;
 b=eALCOJvGX7LzKF7ToYZHoHtXtFd/tYkPUFOe0KE7I22RpG+9qJavZ/fLgzRt7/fsCPqIOXNGaNPeqMcVCTjpOl2vX+u6bqj6O9kZ9+gqJ0YFpeZSht/XsYxfaGb+cz4uKeUK2DvKhmO+kkomdN43QWIYv3xCTNkLtGIvYkVfI2rCIa4/gGvfT4EOsMJtR3hvwihhKjvKw2z11ZZ71B713txUQoVEH7E4hvBn0jg+CNyhQtxCingUcXlQwTMEHpkNjADi0+hsNTKOoLK2/WLB49rnhzMfkp26Ug6+/p1M0ErB/34KHYGapUUXoDZHf9+OrxGKzBjTsaNHEqQaMdjx6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3D33ApediKxQkvR0wUxqyq82ncTdUQveyDd1U05kVSA=;
 b=HNECTQ9egsVF6JYy/vGZEZN8GIGmnbGJ2Uhtfc/4RwLI8Sji7rdYptU/DxTPxWruUmnQdFG+z+3jcsCHOCNBmBgm6KOy7Xi+s9mqLSb21IPlBUOl2RnhofoC7cUWx9u0x2ANFMlBqpPiB/amlF64QiW7AqXPnDfvF/e5dF4+la4=
Received: from TY4P286CA0031.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:2b2::9)
 by OS9PR01MB14672.jpnprd01.prod.outlook.com (2603:1096:604:362::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 12:53:12 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2:cafe::74) by TY4P286CA0031.outlook.office365.com
 (2603:1096:405:2b2::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 12:53:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 12:53:12 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 16EC73000230;
	Mon,  2 Nov 2026 21:53:10 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.1.y-cip 0/7] Add PCIe support to Renesas RZ/V2H(P) SoC
Date: Mon,  2 Nov 2026 12:53:02 +0000
Message-ID: <20261102125309.7743-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OS9PR01MB14672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc49518-2754-42f0-3a2c-08df38e0411c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|11063799006|56012099006|261009223027099003|261009221227099003|261028144727099003|261021121427099003|261026121527099003|261026140227099003|261022105027099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: D50wX92BGjOFc7UDE5hEIvMKlT+zRyn/kggrRXfWq+eDc5FxtMQ7z/m0pJQzi89pIpu4KpjD2nLDXA/L8POOf3qfELc4HJuvD3aqhrtLHp+yW60NRu10KNpwxN0Uma3LC4nnOxi3Zg0wLAcp9cU1QDRLMi3L1x+E5E5ehMuN5oUsvNA62NfjtSPY9YROhXVpLuFwuoHReWZH1yaYsGjjJMII3CKDJlufk2sVGTqEMTzvGSqo2JufV9YK2EVv/wxuFbQnF1KbJgga/8QAxgexZpfv8Ngv/umMhnU5Is5Cyr39nGBvTLMT5ALyKE3OyHM+hJG2q4yP9EOQxD3qzVJAjHWtqz3NoVyzVZFSaF7PpYRgf1yAcTRqlb/WChUxWpBLwZLReDWckixB7DCkS8havK7dmwEiua26rL/ibT3eu7Zi4eUwAn3y90RnlTU0dUQzqLl8R25ofvlRAiHPUR3Yo5RNvvlvacktj0jm/xTpgOQVzVkV0qxAFawbKaD3e5YbdXzmjNKwQjoiwS6Tb5Lbv8GvIdaRwgvVyXzgiCT5Ul7otqf43m3olXdjbdopo0upVjdfyyO/hueyR5l7GyQHH9Mn0XGv2gYrxorMxyiiz8gruPlVqWvrPNobK044dHsv9JOO9Yuqo1KqWxVk1p+uz2+bHrMpmOQBxSuBqcY4Mg4i8RLmnkHoUbpwWiLjbEx33+xzGR551tebd1O3KR3atA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261009223027099003)(261009221227099003)(261028144727099003)(261021121427099003)(261026121527099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7k9SLJgVv7oL+FqfjZmlzhBBCYPzg7qy2TixKQS+7ko36lSOaYyBQLxxXfChUaEyFilJxRPnuOq7FuK362B+hfIfNjxFTMcs9PBzmFAW2HRYPon+ciZywIlxrOJ1IhGBiWcIqS9Fc72f5VehEMfATm6+b/gLfUoJk95kb2OIMTqbic5TulKPF6LOQrqbF0Uu+Vs3cv/KDuEYBk8qxJcm3d0ysSCYm0BRNI5hHSY2vqZTJpqF16tfUKlfFXpGb0Zl0olb6oAbpORUuZD0sK25wJyEfDnSOkYNz3JJQ6MZZCaHT9I5LnAGaVsciryxJvbeSCj+ise1x2CqpnQovUmUXLGc/vdWzfblVTxEyMMH3BbaYpjyqekhVIs4vvxEUE90txHQwKJu59ktYaNnZHPBb6obOH7g0W6MziQwyTiYfV+7YUs7zgdYQfPUlHWPiMaX
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 12:53:12.5590
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc49518-2754-42f0-3a2c-08df38e0411c
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB14672
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 12:53:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24602
Content-Type: text/plain; charset="utf-8"

Hi all,

This series backports PCIe support for the RZ/V2H(P) SoC and its EVK to
the v6.1 CIP kernel.

The series adds the PCIe DT binding support, updates the RZ/G3S host
driver for shared reset controls and multiple controllers, and adds
RZ/V2H(P)-specific lane and system-controller handling. It also adds
the required clocks and resets, describes the PCIe controllers in the
SoC DTS, and enables the ports on the EVK.

The EVK DTS uses a fixed 100 MHz reference-clock node because the
Versa3 clock-generator node is not present in this tree.

Regards,
Lad Prabhakar

Lad Prabhakar (7):
  dt-bindings: PCI: renesas,r9a08g045-pcie: Add RZ/V2H(P) support
  PCI: rzg3s-host: Use shared reset controls for power domain resets
  PCI: rzg3s-host: Prepare System Controller handling for multiple
    controllers
  PCI: rzg3s-host: Add support for RZ/V2H(P) SoC
  clk: renesas: r9a09g057: Add PCIe clocks and reset
  arm64: dts: renesas: r9a09g057: Add PCIe nodes
  arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable PCIe

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  |  34 ++-
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 140 +++++++++++
 .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    |  24 ++
 drivers/clk/renesas/r9a09g057-cpg.c           |   5 +
 drivers/pci/controller/pcie-rzg3s-host.c      | 233 ++++++++++++++++--
 5 files changed, 416 insertions(+), 20 deletions(-)


base-commit: 34e4c87e6dac4a58264018b7c72ce3b41af726e7
--=20
2.43.0

