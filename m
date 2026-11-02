Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.60])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.12026.1793624542050635190
 for <cip-dev@lists.cip-project.org>;
 Mon, 02 Nov 2026 05:02:22 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=fQul1YGj;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.60, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDSyMXYbBQ8DC9sUCb4vLdlTKrxg/raGAFcvlwYoGv7bUKpibmULoa57/BG+tNqSnx6GsPGw0oj4L7R88bG4er94x5XTVgaQMAbiMjKiNXbrST6L4ZKbXeCyBhnGhJStRpb7kQPrE/b/dsaDQvSCIS4e2A9d3pUnAU5hMYxNkUcgjqtINVKxQnQ1J93SxZHUX4eXplLEyCalxaLUZPkBHsA/u45oDMeYqs5ZMVfZyhhqmjYCKMtmIzOZ+IQBOqk9PdlomxjOwiISoJ85wypL7st2rgNjNv0r3l6gy5vODtkzO2l+T3+Kv61BD49N8BOD/jSGxHAQ0okPtrnbsZiodw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbtovbhhq98XlQ6hYvzsjQqvOdds0hUdiPUsSigi5w0=;
 b=DQWHx5BaU0cjxsXG7SSJFrJnADsOUmPXjvV/2GuOhXR3IqD57yJ8J2wcYn/sIEqL9yuYLyOLxCYgd0ZmEnctH5emNxvT6clZxQ6UkeCWe5yI/APUp5s/tRJ+Y6+32nIAB8uEoaWtR6EHG1CUQLk1dSjZl9C65SYKfkv/nKzvpLPxivqGIICyVZ//wRgQXNkSExl8vsxYLDbhwPAv5HpV2JLayAj/ndkw4x8K7Wh8JCj0ekD/fQX4LVbWwXOlQVu+JZ/rNs2ddsGg3+c8iS+qMspnkDpqN5Si74JNs3HBlRHBWsGt145+3QIJPpJIhQmD55aIqq3aT1G038sIf473Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=bp.renesas.com smtp.mailfrom=bp.renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=bp.renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbtovbhhq98XlQ6hYvzsjQqvOdds0hUdiPUsSigi5w0=;
 b=fQul1YGj9OrtkuIF3F9ujQ91eYHW225WPRhR/+9XjZopSWXh5iN+SCjqiX5YMlCzjsnOiC4yWddT9KQM0BXQbVXInH3ED3DpJmOA6rmRsmT6wlLJYDVQCqFbjtVVmYmiYhXuhYsuEbgdmDx89B1BNX0eh77GJ7NjXNEfCNBiapU=
Received: from OS3P286CA0070.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:201::11)
 by OS3PR01MB8603.jpnprd01.prod.outlook.com (2603:1096:604:19b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 13:02:15 +0000
Received: from OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:201:cafe::39) by OS3P286CA0070.outlook.office365.com
 (2603:1096:604:201::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Mon, 2
 Nov 2026 13:02:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=bp.renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=bp.renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of bp.renesas.com
 designates 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003B.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5
 via Frontend Transport; Mon, 2 Nov 2026 13:02:15 +0000
Received: from Ubuntu-22.. (ed-eng-lt-dbi.diasemi.com [10.24.1.66])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id DCCE13001283;
	Mon,  2 Nov 2026 22:02:13 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>,
	Pavel Machek <pavel@nabladev.com>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 6.12.y-cip 0/7] Add PCIe support to Renesas RZ/V2H(P) SoC
Date: Mon,  2 Nov 2026 13:02:05 +0000
Message-ID: <20261102130212.8115-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-Path: prabhakar.mahadev-lad.rj@bp.renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003B:EE_|OS3PR01MB8603:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce68376-7857-4a35-8689-08df38e184bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|261021121427099003|56012099006|11063799006|261009221227099003|261009223027099003|261028144727099003|261021123027099003|261022105027099003|261026140227099003|261026121527099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: cHlEJ6EgBz/acAuXQ7gFVtVead6A6qHbxbIEn7qU/b4y1g/Btgq8Wy+mHnMlw+k65EFfJnayP8xEKSIixAwHqi+GHEpFdx8YbMr0xHOD5HiOGwu1zVP/ZZbvdKDhzbnNN8U2KT40dsNl3h/rqIBxG+mULHYCvWOH4/oRj/nOVLW/NUyJyJo7DpjSpUtZf7IDOuJhRqkFf95ryd4kvUMjCazpmfwHP3oYMr/Cv4+RpVW3roait9y2Cit+ScuwbBNJ4afjDRbvYU2roPwp1ARNYMoaA2NCT1CIlCtt2kUrlq83owQNrr4+m4BNEVINlS0TXOnilE+AdO61Nd5zNW+3rfJ/ROdANUl7I7dog+OXKT8viDLIq+FFG/gSl5ORg+4FvTVPsMGiY5xQBXyliuTJdlWlo894mJpH4WCMWY3eEZ2A6j1uhkepAiVC5zC+ffdUkI+svq8eLfwEYS7RrvP5OqpVhkVVjPKIdwFXsd/Vc4H0rlwnkPzDsiWjxvuW4Ey5W8SCuG4cF7mNkeAPeNwwF7gov+8/GntED4qUvzL/SEi4r+KCWjuaKqVkCGL4GnE0QjOHDVLvuEQkljhzZjbFrH59acSgd5PQ7i0S0v9Ulgmikf+0Bn9n2X/apF3cgCRLFIpWPtMULwIsh0WTlj936XsiNXSlHWXYm27MFg96kJZgh1oJNO6qcCC6BRAjT/s84w2gtF0IQr9cCY3FedJhTA==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(261021121427099003)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(261028144727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: av90omoPLvjIo3DJD6GAfUwXROj/WtZdRdjNI87ddkmTDGBzm2tBkr+OmYKT5zjrQkj0D4ncz35n8G2WmhLMnEBx3a1NIgp0/M0VFk0bfHg1VNtesGy1RTX66Or0d94Spg4qMSwlmEmq830WbXj/h9ThLRsB9MM5tjNmBDVbp3eBNGYwCFTfEEMSQnHItAQz+5uoqlAXS2C3ROKuo8MeNkrSPIp3EmkZ4a8j6RchRVwvSgdH212GRN3vSXH4M/pbL5Vo3k7BgqHJyyZivUrI6nYkT0fFCrjAVfjUnd9lnd1G3a+p3cChMltiHtmPyxiCO1ZhBTGUtdfjojMurzgoaqQ26MOMxmNIMEB3PED6CwcxQ1mRcWHKbK+sfM5MsUae9VEWX0g5X1f2I/U2r/KIt0KgLQHBaflwDh5jv4ew/0jTOM97m56USmVrlnPpeGFU
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 13:02:15.5191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce68376-7857-4a35-8689-08df38e184bf
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003B.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Mon, 02 Nov 2026 13:02:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24610
Content-Type: text/plain; charset="utf-8"

Hi all,

This series backports PCIe support for the RZ/V2H(P) SoC and its EVK to
the v6.12 CIP kernel.

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


base-commit: f0ff96b9db4c6dd62a05fb58babf7d08c83909de
--=20
2.43.0

