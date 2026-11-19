Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.19])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.831.1795110944275802022
 for <cip-dev@lists.cip-project.org>;
 Thu, 19 Nov 2026 09:55:44 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@renesas.com header.s=selector1 header.b=YiDy5vSh;
 spf=pass (domain: renesas.com, ip: 52.101.228.19, mailfrom: ovidiu.panait.rb@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNOpt5/w/5edU3ECgy3nn9yctg37r5nmuZI8k2dV/t78c94HtxjPXMK9hMFxzyzBJUBdOg5PJccEX+q0/M4o3wQOKj7J5ubKaB+GR8DbW1yOnKUHzvrXCi+sDt8FIE+2I3l5QgdOSiUzvN6ZrCjZ1cwIDV58QmlY8Lb58BwXU7FtOjCtNMtUWgTE9jCQKhx80u8cn8Usy3FnS1Py78ux3ipa26oTz+n0y7FEr7VwWApIqay5ZZeApRkCt1eHv1+bVcN4YaXlp7KMxw2aFnPuEAD0Izpo1wuKg/ywCU2UImNkSo8+VcM9B099p10zPj7+XWDgj3hIazFbRldY5gR0fQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AS4ePC41nMAHlU1wWrXUgqJWMO6ahIW3k60Y02QBRmw=;
 b=CQcHaUp3lJqa9uliBGgbNOWJuScAKkxfKukkNAN9cScUpNDT+Wabwt4nSHa0kwmSVk5ptwFe/u2p7kimCARQIsY1/TsjKOPDOCN7/7+1J2K2uwxUyrCqrHR3ZdbY2/J4yV4ThoK+c5wiei9X+EjMlLqQB67HMfOo7BkZfvAZxuAcXfFIAHwaqMI6xyDLBBxEKNtTEAlyV01mea8G5vYCxX7gq22xwo7VZ/wNvhtMA8hHiNZUFg7eX76wR3LJkOxR4j4mjGfEM8aJXS5MLMHPnllnDkatw9zbJKfyanMV8rgkk63DYyDX7pEQ/De/+CpZwI961Jd10X/1OHPmV9MhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=renesas.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=renesas.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AS4ePC41nMAHlU1wWrXUgqJWMO6ahIW3k60Y02QBRmw=;
 b=YiDy5vSh77SJyycJeVdTUt0vCCwySql8pq8Bq2id5yAyAX0NpxaTfWGGdOuWdx+p7R4hQTdIdg5+EtDbpNwoITJbd8dLWYsX0UrAWo19GybDGnBkArLJiaWuhnNJiN291djKG1drF26YeFMogp+aN0BeT4W47n3o7WBfQSf7lVM=
Received: from TYCP286CA0196.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:385::7)
 by OS7PR01MB17355.jpnprd01.prod.outlook.com (2603:1096:604:43a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 17:55:37 +0000
Received: from TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385:cafe::33) by TYCP286CA0196.outlook.office365.com
 (2603:1096:400:385::7) with Microsoft SMTP Server (version=TLS1_3,
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
 via Frontend Transport; Thu, 19 Nov 2026 17:55:37 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.9])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 34E593000230;
	Fri, 20 Nov 2026 02:55:35 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: cip-dev@lists.cip-project.org,
	pavel@nabladev.com,
	nobuhiro.iwamatsu.x90@mail.toshiba
Subject: [PATCH 4.19.y-cip 1/8] mmc: core: add helper to see if a host is doing a retune
Date: Thu, 19 Nov 2026 17:55:26 +0000
Message-ID: <20261119175533.110210-2-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
References: <20261119175533.110210-1-ovidiu.panait.rb@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-Path: ovidiu.panait.rb@renesas.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005024:EE_|OS7PR01MB17355:EE_
X-MS-Office365-Filtering-Correlation-Id: 31901f91-d42c-494f-a122-08df46665156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|261009223027099003|11063799006|56012099006|261022105027099003|261102123227099003|261026121527099003|261028144727099003|261026140227099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: oEziycNi3ybZWAlqbHixjsiQ4Dc0MWNQseXx4PCg717tO8RpcJ9xUomoQtVTs9oQCHEhzNwwdgMkXgrEMq6rsKBTNiOyoV6spDTREaofTu/RbAk+bHC8JYbSM5ZTeCBbUwq++Xg7CIjvrAeGYtklDY6yO4/wr0oBqnTDMdDp3cfTf1wMtULiaTm6i+QuPpkPe3L4MFUBQ0gNdWHe9mcJ7Bl5/ErboXO2ehtcy0PxKNhrSAryWG8aqAo3MlAGbnLkXy/4PdaAI41dHMztJsyiIVkQvFEVIeCuYlCKes+ZffaZtZuS5OQk42iJBY5p40/NkK/9rY5QWrFxp7OATU3cn4lDbCP/DZXAF61PcMpL92X8sY2y0oqV2gcsNaLuH+yLFOQiZkVea+rMpdJLctKtaq4ZAsDrKD4UX6eKcuDZOLk2PskXoR5n1q0DiXk7nSfAhedTEpdKDeY30C4t/KH1zeUn3cOBKRd3TD56fa6DVpZbuS7MAeD7UT7hcn4I828DQZtwN9BfSyY4GZaMcLeQH3bEVt23tiC2UwTRlDE1mEZ6Q3/82ie0zavkgQrXvIrtdeOvi7CGdw+s8nUqgjWvsuycHcFu8Pql+Hdyc4f4oMlZqXrnyIu/6edhB0ui4RcyqGA05pHFnFbLpavBQJvelKWrCoZjM4HOfHuQQeJeI4+spIjxOp2BwvvxKVZVPvstE+Ck800o/37tL8JEgezfag==
X-Forefront-Antispam-Report: CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(261009223027099003)(11063799006)(56012099006)(261022105027099003)(261102123227099003)(261026121527099003)(261028144727099003)(261026140227099003)(261021121427099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7EaXNhyQPgUTieUr4hX1VcmwpMdqsRtYa/qBRtga3nlp6TG4bcdOC9JCDPHXQwuGcQPKeUdM+YI/SK3trDUzGJ0ZeyRfBcmwpU3UgynJrikNUX5lOcq4ck2NT78PvlcYtm3zuWWK1Wc3T64MA1crSJ+ZTvduQ3cr7qY7aZLoCHE2OfLJe8B11enzQmOmjOiaOvY6TftAHyjZozAm07TllEhZAFk/4hSOstjRpCJq0/Zk4g2ObgISIe+/RQne26LxTIGztJKsUYOZydQEGJjD86Ex/XtOKc5nDIJWkB0Fek9rgJEjDcvLJ6uwLLlEzQqQvkNpjm/7xKLCMuGoLyVSPmaMKBvi5tsp7luXyHpNAhPqXl/jZeQ1MPqN/b+YCkr6l5RfYiEYrPfwgxMKoTn3SUDHzYezQcGFlDBPwrRCd9skcfVg5wiD44H7xMRY0rPj
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:55:37.4611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31901f91-d42c-494f-a122-08df46665156
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005024.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB17355
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 19 Nov 2026 17:55:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25017

From: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se>

commit cbf6d82cad4a507475d92d380228302fe668dd94 upstream.

Add a helper to allow host drivers checking if a retune is in progress.

Signed-off-by: Niklas S=C3=B6derlund <niklas.soderlund+renesas@ragnatech.se=
>
Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 include/linux/mmc/host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 0190c10af8c3..2718f267c84b 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -587,6 +587,11 @@ static inline bool mmc_can_retune(struct mmc_host *hos=
t)
 	return host->can_retune =3D=3D 1;
 }
=20
+static inline bool mmc_doing_retune(struct mmc_host *host)
+{
+	return host->doing_retune =3D=3D 1;
+}
+
 static inline enum dma_data_direction mmc_get_dma_dir(struct mmc_data *dat=
a)
 {
 	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE : DMA_FROM_DEVICE;
--=20
2.34.1

