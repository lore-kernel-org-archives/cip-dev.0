Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C30CC624D8
	for <webhook@archiver.kernel.org>; Wed,  2 Sep 2026 09:24:21 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.68])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.8517.1788341055403992852
 for <cip-dev@lists.cip-project.org>;
 Wed, 02 Sep 2026 02:24:15 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=B/TFixuO;
 spf=pass (domain: renesas.com, ip: 52.101.229.68, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eAfPZC5eFqGVBXY5uNKBITeI8nZBUB8gNCtp9w+qRC4vZqYkJQyUNcXm9zSodMJvm4WM5QeHWCu/LSuwvik1fDXT/Hx9tlPb7FTKmK/N3LckUueHbhUNsQrQHrLR5ZwPgO0uSRYruDCRj1LV6744y8hGa7dymANl8t5fEqlUCOEvZkQk4o4e1O1He7RfJOWpXLPJjVQCSN1lMEGkFUNFCuMXckfkOjWn2IWIywCfiXLliGy24bHsMPpLJGks/4bYLlcsBXqvHXs71V70U7VBIvRvJm8I+wZIJp4JOy/oFrEYX2tMISFL8HlB9pJ0Tj3kqqFYM84IeFvKgWUub5TVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ARDj+mdL6SZBERi/ESSS1OXW1P1r5a3xZKJLlg1V00M=;
 b=EOecBVyxc/27/ymLDY9d8JBQ4c6Demg3/4g34ai6Hb5M4fRNWApMH0TCdrDutbKQZLGlBrMKYLQmK/7QiUyxFurBHRIfvDpvmqvoBbbLYydjv2Aa+6/ZHOPbmbDPRU1r+urjGGMmCrRwYwzbQSsT6f0LUqAeObKzc1easVqKKW14PaY8vjcIrrHiB5PuLRWjvlVUOiPgovW3xghekU1OAIDNC/46YehGzGLvDf2IycEXz4OGLEwat/kcPeocjnu5UKtxaNlY93DIcrkH9zEuWUOQoMcHNFU0TQETNXl4P7Sn0wi4C/VMxinB1g6HtMXESLYxmhltasbaGblq2NTfBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ARDj+mdL6SZBERi/ESSS1OXW1P1r5a3xZKJLlg1V00M=;
 b=B/TFixuO6IrWfedz1jcifZ1cy7B4o2n5V8kI5qEImHu+j2/P/X/pGxn090Jkr9ZzVCo0/9zmoOcJ3jAFQk2Lcw6GOi5mDo/mXEQYfJo8AC+UDXjcwYf4Upx3rUT7wENzorp8Z7bfPiQieK7n3cCR7KrTFCcbhrHkPeMDimkobA4=
Received: from TYCPR01CA0182.jpnprd01.prod.outlook.com (2603:1096:400:2b0::6)
 by OSCPR01MB16119.jpnprd01.prod.outlook.com (2603:1096:604:3e4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 09:24:08 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b0:cafe::59) by TYCPR01CA0182.outlook.office365.com
 (2603:1096:400:2b0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 09:24:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005024.mail.protection.outlook.com (10.167.240.21) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.8
 via Frontend Transport; Wed, 2 Sep 2026 09:24:06 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.24])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 80B50300035F;
	Wed,  2 Sep 2026 18:24:05 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.1.y-cip 00/11] Add ICU error and software interrupt support for RZ/V2H and RZ/V2N
Date: Wed,  2 Sep 2026 09:23:41 +0000
Message-ID: <20260902092353.24648-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OSCPR01MB16119:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0e51eb56-d76e-4300-866c-08df08d3efff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	fVUzarpVW8axN2xWEQMfGqileRtrbzeKQyoDsDlpDmD6+aUgkhzL3v31IghOUiUnISn/cf9O/AqsQdPoYPVvwzKWbesouPk8tqTb1nskKjdq1OQvTguje/fDQ8yQc8J4H+beco+XgAwk67vzPLOhCxl/jj6aTlQ3EpcZIEXIPg9IhPX7Q6u0h9Iz1DgtCSZPiIi65v4XWNb/xbJH7wh17cvwuU6L3wy6gPeF6EyQhbPCCQ6C6nrDw4+EdlUEadEBBDY6E+kyT2dDa7L0SkgvZHes6PXpk6LkN/HKh9ITSmadEB7kPDXDenKe9R9MB1++vA5ItIy82VJSzdRxbeCVXMNo772UgAPFTNDpstZBB8x8QDJBGcGAMVNdu7XNYGOdAbxc0N2cTKYNl9AwNFKtptADj0at5oaBYz9LrW1xjqTuFmuRFFkYNhjQ1R+KCKajwX5mnirCnr8xFBQihv/RZ8i+A9A8Hvq411MS1C/onxdzFWQ1EU+eeXAN+HLE3ycn1V/YprWWMmKeQ34iA8y97xiWTK9MEFtUFe2cL8Nzd17Q6z8KhNqwL6i2vazo6uuQS6LMDk1yQSQ1grItoCDNBeDZpiP0i8ad0iEl+yuhaQmjpUhSzf5ecTUkQFIOybzI8HCxA/a74VJQAT+Ef3+pT9U5UIz0w961k/+t3d9mcAsBY/Huzy6LjJ+4MfrRJKMgU0l5dfGoTDFy+mUEki3rhA==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	iSE7H6Smrt4wzJQt3IeGMRNi6DS0iJmQhkPFIJ4P21TlLvcwuyJ/X+jwd5XlZFMySuH5q0EiYUu6XE8vKzp1nkqUFff7xmIRU3x6gaLeEPfGzFW91LkGlWRsk6sYxtCXw0HCJwdlJP8MBVSCA/rbQtq5t04r9UCM3hLiYGPGeZ+11kIQ488Y20RnCjjzbu9hCRbi7yNbBsTb6AV1paT7XSiL+r8/6a8Ovff7NhjJauEvX0K6LfoM3TVHFObpVltoNCyd+8I6+A8QJ9jewY3nua6lAbwwl4VzDHcIDU8WgXaKsyezfVopQdCuXkkgQfHoWDuDZLpit1jJdGEv5k109xy/Lxoba0LSnF9qFBr28ss3x7/g9/gckSV80HdrNykIvrc7biCvN3LAvsHpQ+45JHN8ODVZkyaqusCRC1rO+Ylt+DR2MvVaSAR8JFXP6OvS
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 09:24:06.7024
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e51eb56-d76e-4300-866c-08df08d3efff
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16119
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 02 Sep 2026 09:24:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24056

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

 drivers/irqchip/irq-renesas-rzv2h.c | 460 ++++++++++++++++++++++------
 1 file changed, 368 insertions(+), 92 deletions(-)

--=20
2.34.1


