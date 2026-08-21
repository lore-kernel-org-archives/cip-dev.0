Return-Path: <cosmin-gabriel.tanislav.xa@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27589C5DF89
	for <webhook@archiver.kernel.org>; Fri, 21 Aug 2026 13:17:02 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.42])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.7154.1787318214583991219
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Aug 2026 06:16:55 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=QC71U5mX;
 spf=pass (domain: renesas.com, ip: 52.101.125.42, mailfrom: cosmin-gabriel.tanislav.xa@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LHKX7xl53ZZS18Xl93Sk3YzztuuKYfYR9RRtyq/+SCkHwcW2TOfr6lEs8OF2o5+9yQymQAiWGz8ivTR8D/aEBSg0BjC/RyyP7XKoH5gUjSrHj4RByrEVLtTxOah2A++3E6yca8I3ddUER7z1VnIpgchhE+bz/BJwlavMYw6gA4V/dBcWPoklY8DWpCskuLkvp4Xa1G6mlku1LCKGWB4Tql5KvGC1UjJbAWwTcyiYnQVUETKGRFwuQwiiSraAJyg2l2gWLCSZT5ykDezmDh6VOXy6oytVPLmG5mtkEBZT8Kh4pbjHFyU2CquPGDyb/fZKeXRpWMGYNK1GiTvMOk38Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWsTZR1G3W8a7MARb8AvRUZZ2v+zOGCaHq46US8Ma54=;
 b=Ldn6K49Alnoncv5B0dywTv58lYhRKc50Bx6aDzpRYepAsbHSuV25HPuNDiYICRuzIaqZKULxNubyPZM6wG5JQukEQBon0sarWfQjW6K0hb3I4R5HCRBh2bSPypbM1mD1J5/AcE1rb5iKpJFq6jOeMDjQTvdORZle8KFPftxWUO2PwLJeMPRgvG18i2o3yDGYZrTMjzSBWtJhtz3FL5YH0w1Z+WKi7FaqD8KAOOwKB8cgJACHEQ9ZD22Ri48q0SNP5xogQNgsDj6r3fVmXiYHpkRTrMumuOYqNnFdT6lQnJjeFq/qQ7zfIaBWyBrB+1pEXPseD5CqIoCBYNp9m+OEXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWsTZR1G3W8a7MARb8AvRUZZ2v+zOGCaHq46US8Ma54=;
 b=QC71U5mXz93POgRUXEq5uYZ80KIXAYJZUDGtKOdmJHg9cD0wL9J1Wbb2g6BODxLb/BIGCu+zMMN5ibJO0skjBikPh4WwzVkHodvNVQh4RnAEP9gcDhpXEspX+UmQ+935Ebl8yUHKfnNSZItgfo6FS7/uBFFG8QNm34hF4Up5KFc=
Received: from TYCPR01CA0201.jpnprd01.prod.outlook.com (2603:1096:405:7a::18)
 by OSZPR01MB6969.jpnprd01.prod.outlook.com (2603:1096:604:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 13:16:48 +0000
Received: from TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:7a:cafe::7c) by TYCPR01CA0201.outlook.office365.com
 (2603:1096:405:7a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 13:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005022.mail.protection.outlook.com (10.167.240.7) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3
 via Frontend Transport; Fri, 21 Aug 2026 13:16:47 +0000
Received: from demon-pc.localdomain (DEU-5CG5050QD0.adwin.renesas.com [10.226.92.179])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id EB7093000374;
	Fri, 21 Aug 2026 22:16:45 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 00/18] Add ICU support for RZ/T2H and RZ/N2H SoCs
Date: Fri, 21 Aug 2026 16:15:36 +0300
Message-ID: <20260821131554.638741-1-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005022:EE_|OSZPR01MB6969:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e3490da9-e74d-47fa-f565-08deff867422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|6133799003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	/Xv6YR2AlQnVS6V770U59sm8zoy47sK40SQV+q9YqagLVfIlNqOku4u5YpkYpDtJXKtWdHrHoVnR6XwDByhXrEWSEeiZFZlhEMW8+HBwJu7iVkue8cuNJb1jSovRX0PqesryK3I8C/O3M/gM0/t9LwXyoqWuyhtSV+ux2g0h/w4ThBrsiGBI/Z82j/Z1//cO/e1JlcNfRH9CdEmAk8+XCSGfAs7hFBq2GCC/ziMv0wfOjjLqUNdR4h9veBXBxC/aHehZX2qAoYLFX+PwGitvHiItpdtwAisuqTveF9VsxOK+mDXdTQALtUY/oIY9agj33ygVCz8cRizapdnMLPaGRCaLs/lyLl+lLUjTaryKD9xmaqrEXBmBtfl4l+nKmKVdTZvAhNNTHYKpZBpg72NmJWioeKW4qNxQwPJx4ahx0+EuEKUqdb/mD+H+uGQoHz6lYOaqSd0WBoGkgFTYJBibR4BphNm0c/ufeVpjB9aWksXdqzyiTbvLd/0QQeG6NaGrDiMxMFuc2CiHPegloG3iwj8p8nda+EMUwP6WZ8pnev/dxlUyI0cBbifFHjl4PuXlOZluLPqFgEuTRmcCYukqZSG9Q2qLiheSLdCV5PHuPvelVi1jjhUbbqJjYwrToUp1Rv+WHqERFoKoobPySQUkk3APCrVjQyfjfDaiQjk3RKoxff1su6OBwX4AolMIW90gqptH9hPZuGuCZ+UaTWTcwA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	NJnfvDbrRV0Al4VxVUH12nf4rEgA/41k3A37RqnAzUscADS77pDXK5mATXeagQmsmEvDZBPSAldtgdcHCx5IO581tFTMsJ8jXOvMghOg0i6st0NALwQKZ3JufqP57NAaGb3SviC35jzC4PhIkv0BWg7HhSbpQ2JiS6tfZ4kl27qcKPgvz4gd7FF/0/1gi8MnaqMHDdLOef+AdQ+gx2vMqdoI3hZJfamVbv/UnLtgnPKzr6d4pYaLiMhbAyXfiZrqRtprfyLc9BWQRIXN5rV/oebJKi5YRHFCZw38G1riIbW9KXqMRkAaNMysMXm9dEHsCefPwb2l8TpKxe6wBJ6PPK0DGEnS7yAIDvchoviaGQcLsBHrXWV6o2KnutQbyAepqHGGtvIGRcVc/RsFwKTQhd9uoLiUe1L6jU8cqoFTf7g+PshRjvj8HgLJEuEF4SbN
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 13:16:47.1830
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3490da9-e74d-47fa-f565-08deff867422
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005022.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB6969
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Aug 2026 13:17:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23957

This patch series adds support for the ICU block, including
software-triggered interrupts and error interrupts, as found in the
Renesas RZ/T2H and RZ/N2H SoCs.

Patches 1 and 2 fix s2idle resume handling in the CPG driver.

Patches 3 and 4 are preparatory patches needed for patch 5.

Patch 5 implements the resume behavior that fixes s2idle resume over NFS
for RZ/T2H.

Patches 6 to 18 are simple mainline backports.
Patch 9 required a change to match the current definition of
IRQCHIP_MATCH().
Patch 11 required a conflict fix because of the above change.
Patch 17 required a conflict fix in the dts includes.

Cosmin Tanislav (14):
  clk: renesas: cpg-mssr: Simplify pointer math in cpg_rzt2h_mstp_read()
  clk: renesas: cpg-mssr: Handle RZ/T2H register layout in PM callbacks
  dt-bindings: interrupt-controller: Document RZ/{T2H,N2H} ICU
  dt-bindings: pinctrl: renesas,r9a09g077-pinctrl: Document GPIO IRQ
  irqchip: Add RZ/{T2H,N2H} Interrupt Controller (ICU) driver
  irqchip/renesas-rzt2h: Use pm_runtime_put_sync() in probe error path
  irqchip/renesas-rzt2h: Add software-triggered interrupts support
  irqchip/renesas-rzt2h: Add error interrupts support
  arm64: dts: renesas: r9a09g077: Add ICU support
  arm64: dts: renesas: r9a09g087: Add ICU support
  arm64: dts: renesas: r9a09g077: Add GPIO IRQ support
  arm64: dts: renesas: r9a09g087: Add GPIO IRQ support
  arm64: dts: renesas: r9a09g077m44-rzt2h-evk: Add GPIO keys
  arm64: dts: renesas: r9a09g087m44-rzn2h-evk: Add GPIO keys

Geert Uytterhoeven (1):
  dt-bindings: interrupt-controller: renesas,r9a09g077-icu: Fix reg size
    in example

Russell King (Oracle) (3):
  net: phylink: add phylink_prepare_resume()
  net: stmmac: simplify phylink_suspend() and phylink_resume() calls
  net: stmmac: address non-LPI resume failures properly

 .../renesas,r9a09g077-icu.yaml                | 236 ++++++++
 .../pinctrl/renesas,r9a09g077-pinctrl.yaml    |  13 +
 arch/arm64/boot/dts/renesas/r9a09g077.dtsi    |  76 +++
 .../dts/renesas/r9a09g077m44-rzt2h-evk.dts    |  32 +
 arch/arm64/boot/dts/renesas/r9a09g087.dtsi    |  76 +++
 .../dts/renesas/r9a09g087m44-rzn2h-evk.dts    |  30 +
 drivers/clk/renesas/renesas-cpg-mssr.c        |  46 +-
 drivers/irqchip/Kconfig                       |   8 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-renesas-rzt2h.c           | 556 ++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  35 +-
 drivers/net/phy/phylink.c                     |  25 +
 drivers/soc/renesas/Kconfig                   |   1 +
 include/linux/irqchip/irq-renesas-rzt2h.h     |  23 +
 include/linux/phylink.h                       |   1 +
 15 files changed, 1124 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/=
renesas,r9a09g077-icu.yaml
 create mode 100644 drivers/irqchip/irq-renesas-rzt2h.c
 create mode 100644 include/linux/irqchip/irq-renesas-rzt2h.h

--=20
2.55.0


