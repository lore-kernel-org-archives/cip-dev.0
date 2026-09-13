Return-Path: <ovidiu.panait.rb@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD58BC88E5C
	for <webhook@archiver.kernel.org>; Sun, 13 Sep 2026 16:37:09 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.67])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2193.1789317419673006475
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Sep 2026 09:37:00 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=b7RNq04q;
 spf=pass (domain: renesas.com, ip: 52.101.229.67, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pqAuEp1qcDzb8n/Hc+pV/tyWvV0dZpSB19jTGe8OPrLpRDMO17c9B91lMOiUgPCOdZDw8m++XOsVXBBmnjVXG987YHhoEHdOt10wxlmw4Z9N1nfafzc0ChLm/NYAmBq4uWujBnc+YZLefILZZ/fwF1gdoSHrwi/ZbCcF2mgCgeUoyFWmaBI+yJYFYUkBKCoM26fYzujck95/pKtfDwpy3xOWvkwfiqRAyxgQkTRkFJxFp+2ImQvxvhRJHJ7fvi/KtznpdtwIYaYmloJI7Xfyysi/oP/yyuHORocdELb/tziH19tYAhxlikWVZmciUGo18eEoppjlsartmphj37IWvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=owxwEMd+7aNIU7t2sHrgiwhKEqXxfMF0nARVVAHpcpo=;
 b=no8m9R7Cj4876Fu4/AIM1EKlms1zEjXGoT8O0wSTNkLUMQkwNYZtL+nhlyb2XGeCG4yHb2Vdt4b+JMJLxIOSPri79cruk1POIC1JEe2ib1cN2bv2H23E5cONzDw+0k+a9D1TpuZFiJG4FwZutRVNxuVFnePmBEdQ1JAgZJ7f22qV5UITA6wzqjAKAv5QECxeW7H7DSMLh5GZU7VHrKKqdYfOC/uXQd2pWpJ54FVe1KB/KAefm0OwxFoifDD8AZO5OYp8AT0zjJ3bUFJVb5JIfEaWVH9196Yj0/5t48Rfm6vfGwEEDPjtcv+csgm5eImePr5xBQya+dsk7fABICS+0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=owxwEMd+7aNIU7t2sHrgiwhKEqXxfMF0nARVVAHpcpo=;
 b=b7RNq04q6Z6cFgvI71z0HbLMnSTgNiJJtnhH5YpyU8DUyoYNj8n62SbLxmvZsHqC+FGToLthg3Ws1PNmHXO5gNvNwLQjxxOdiCOLLvKjBj3tqBBwkKlXa3O05uuZmKH48wxQsI/CXY34+PqXrp9IWmcPDodJfOxtbjVih2llTXs=
Received: from TY4P301CA0070.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36a::8)
 by OS3PR01MB8269.jpnprd01.prod.outlook.com (2603:1096:604:1a0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Sun, 13 Sep
 2026 16:36:53 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36a:cafe::6c) by TY4P301CA0070.outlook.office365.com
 (2603:1096:405:36a::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Sun,
 13 Sep 2026 16:36:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay005p.adwin.renesas.com; pr=E
Received: from ejcrelay005p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7
 via Frontend Transport; Sun, 13 Sep 2026 16:36:52 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.2])
	by ejcrelay005p.adwin.renesas.com (Postfix) with ESMTP id 9374E300024B;
	Mon, 14 Sep 2026 01:36:51 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 6.12.y-cip 0/2] Add RSPI DMA support for RZ/V2H and RZ/V2N
Date: Sun, 13 Sep 2026 16:36:32 +0000
Message-ID: <20260913163634.77803-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS3PR01MB8269:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1df31350-5541-4da6-833a-08df11b5378e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|23010399003|36860700016|82310400026|376014|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 
	L4xeXTjYiemH5o5eEO9fhB6fK3zv8azBjbo7+RnBgJf3Rdn4zZzxVZJCwzJK9Yzgm2pXg4VAVBBJtJewT0u9rxQUp6P1HDU2tE2/U+ysDuRcyrELEOoHd0/9EmuSYseQsjFpKu7Fl/PtIheZ7VTA4YLJGR0UtxvLdY3sNPcYXW/Gn+8ptBCDn22yF0zlH4fq4WAzS23K6T7YpUY19A4mYYawyImEuPmP1AyZI/r3RLSM8DFNUsJHNWSI3Ho3Ne1sazjGOVks+tgXVuDvVbvaMaiMeRBDYEWTHHunsjq0uajKu12l7Z29reQcLwpNB2AecUOR+79XgG0lJeBXFoUSUzDWGdlbO6eijKLv/J/Px6roZraChSR2k1eI/9Nr1lKnCvICj3Lu+Fl+1DqxmoOwT3xSEnEg2dg/xdaXpLwkCdMCLhTJxKiceamm3+d2crT2j/IM00lnmvLgs7Rbw5UDHnD7MFH1gRDNKIVyGfo2SIXjSDIALaVWz/A6/kbjIDwM5zdoMLzvYyWVQTArh4fLOIGccYNic9747gWzgYPEsyx6PXQRTDBMK8K3qXHR3JZkmCe0IC8C7k/JeKhpDL7I6X7As2xH7YQe7z/WFvagacZfZCCuoh3xmg17jDl8wzGQiA8NWT18i8UTMAtnD0D2DSbNP6XItjWyILHHtuHgYqnvidtdsZLEV767nkVh1ezso8aH6lTUCQwGEnfJqCBMyw==
X-Forefront-Antispam-Report: 
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay005p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(36860700016)(82310400026)(376014)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	626OPbD75jYs8mLZWQLE9VnyApbE1VUE8xA4rQKeb+Acry0ZLFkOVx2IiTECPI/c4oCVqJmPDsgo72mvBVYEzbdPqMLRnPdVCdC7kkBg5ieEVgoj8ScNWL7AbV+aB4qZjFcm8N0BFRWL+8Rgm1pyV9A3BoHQy7/yT4SfrvCvYH2ewtP2XIVXQp5vNE5xDlUduzZ/kzDK16PbSPbH/Uvnfxz2WrT6GITSShb54AxG+tnzVgEClL8D9XWUUYaaPFLkZHBiFx6xEWD4SrQvWSt5dvG+s56r4Unu4Jm7pSa65195E8Q7NbLnmGpj37rxXOO/Vh2ZFwpt14stcL8T8P1I7V1mdmqB/xOwdqigpF+2dJ8NMKs7D9z96DeR1sjseNCcD6MI4F885S6hwq/4XinSUqZsNa0mcXKpUeK83qFF5+TBZ/YmopSYT3KtC4dnaHrw
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2026 16:36:52.8238
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df31350-5541-4da6-833a-08df11b5378e
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay005p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8269
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 13 Sep 2026 16:37:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24155

Hi,

This series enables DMA for the RSPI controllers on the Renesas RZ/V2H and
RZ/V2N SoCs.

Patches were cherry-picked from mainline kernel.

Best regards,
Ovidiu

Lad Prabhakar (2):
  arm64: dts: renesas: r9a09g056: Add DMA support for RSPI channels
  arm64: dts: renesas: r9a09g057: Add DMA support for RSPI channels

 arch/arm64/boot/dts/renesas/r9a09g056.dtsi | 21 +++++++++++++++++++++
 arch/arm64/boot/dts/renesas/r9a09g057.dtsi | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

--=20
2.34.1


