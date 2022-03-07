Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9EA9C433F5
	for <webhook@archiver.kernel.org>; Mon,  7 Mar 2022 06:49:48 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.54])
 by mx.groups.io with SMTP id smtpd.web08.23952.1646635786672098223
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Mar 2022 22:49:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=bUuNUArX;
 spf=pass (domain: siemens.com, ip: 40.107.13.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTei/o82CSskGnM3azWozW5xMD2/Odl2WqKNXKzpzabUbeLnF3AH+gqzZP3UJzcFJKLdO9hw7/kTZOBWt3LNnTRQlHufw1NYOYKMhtXeQ6nummh5v1By+67TUfSfY70jgle7Mzp8OV6hYWkrsQ7/eKpUpUV1/Yi97Vl590fi5FD79U8NfqzDRVIPsM+TBM4edmj/wwBCIlOVP3oooll1/0zGOxiyavSSf/GZEfzmm6FaDfQ/ahLBx75Wo5hx34hClu4NeXMGFzS2N5BVBB1oWspJ5GIUxeVQmXN1H+ukxp1mwbyLxbqY8J7cOhH0EUTw0cZ52+7FjwB+XUgvy51Vbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDLqRoz5ksyNbV6IgdyIEV+DPzGt5e6yPr1CfERFE8A=;
 b=CmrbSda8kO6TngZ0WajisChYw/gL/Uqw0N4LTtvVulK3vPu+6eUMHFVyhW4v51/6alhqMqv8y6uVxAJw5VL7lUBRTp72hZ2mwNP1/izIjzGRnXqCitx21A67JU+5Hgpy1H/M307nI+9D05wLn8KSHculnmQrNHHyj0G/8tPoPdLFIjWdwHude3SHrX7cuJOsUqt7Dfv41CSg0mMFgX2KfdJJssHlcP98k0UIAJuUaAswn6eyoVZSrwVOi5JKdfHQHgi0UOv2S0ttOa8WTy5K74NJORgT0FM7wqzrku4rxFCcQi2AfdX9ZB3m31nzf5tZkwnsJFc2o6zRQDoP3MIOMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDLqRoz5ksyNbV6IgdyIEV+DPzGt5e6yPr1CfERFE8A=;
 b=bUuNUArX9NvmeypyxCPcqabsV1UHR8pRrqO+dmthKE35EqnVhyvp89oxjTHRj7f9Jwl6qZpf76LSMabffowBXGfmuNuaED0DJXr/R6cMTgaRgygiLHypf/6OBv1HDY02ovI24qyqZvU2aMkThGsu6cOpPyYiSV1NbTrZNgZ6/v+GDzdbiwQh/tAN3HQ8+2HNaa2ap9oEBJibg1MdpuG1w7FV3wYfhvtDWr75QO4GkmzZmyccMtl9VoDUPKkHFQUTWnVBeMh4vb5PVbtFP7YesWKc9ileUHS6KX5xR+eQ752LRgjkVFq2sbwqbbLWx9oVAMPoq4JJ1KwD0U+qPGGQUA==
Received: from SV0P279CA0047.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::16)
 by AS8PR10MB4631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:31a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 06:49:43 +0000
Received: from HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::bc) by SV0P279CA0047.outlook.office365.com
 (2603:10a6:f10:13::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 06:49:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT017.mail.protection.outlook.com (10.152.0.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 06:49:42 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 7 Mar 2022 07:49:41 +0100
Received: from [167.87.0.7] (167.87.0.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 7 Mar
 2022 07:49:41 +0100
Message-ID: <2055d3d6-bc3a-3878-d194-19ecbacfd71b@siemens.com>
Date: Mon, 7 Mar 2022 07:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] start-qemu.sh: Cleanup of common args
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: "A, Srinuvasan" <Srinuvasan_A@mentor.com>, Quirin Gylstorff
	<quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.7]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7797e73e-3c51-4f28-966b-08da0006a85e
X-MS-TrafficTypeDiagnostic: AS8PR10MB4631:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB4631CB3732D133E87E7B960795089@AS8PR10MB4631.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	9rfEcrdA5c6Nzs2QlRkwM/lci7WYdrtDKr9ABc/Qha/0bvoqGWUO2BsUTRAGgisTnE3iF5m/9fQi/FXhCfVczGauC5ASA54e6B2K9pr03xNRPiNOTqrF+UNNVkDBwuK32/ziwCR0XPYQp++QrhganM1bnQKW379c2uDlSNF7UI65WFAhlMXoK89bRI6z2nIPlURGTtvxAoaYEzL55K5vnJz7wKuD/dzP1Mkeys9b3SyZaMuj9QxFEtq5Assblv/ERrWU8OS8zC+2jWYwZquRrv7AUyulgsCRW/92UDgxjFXIns9BMNKmT6HCYGuB7TMCLCOLskgPqreXGg3Wgw9BFIvElig3iZLSgiXEe1lw5KrAAXKROiCpo9/Ji4zPy8S1+kcg7jox9qOpeDHvs+l5RLS3dC1Io+QagswHIndPCl+wxSBzUsCeXgWKCRdA2qYkLP2w8yz2UNanNAXOw1chTvuKp5fbtYMb9tWaC6PSuO++UJMs5WBbqO3zgFHlsn0j+v+2BKoY93vDVgm4ZHBPks0aRCuEwihA4fmJ5MerjN5BkszBuZGMvbJTLluGeRwWM59YWIPK3HRc9pBpvcy9bDOeTxYbKCZLq4C+mGwUDwH2Lg498bB9tgCoQLxnyu451NFR7DwCkPDgE3tHgtzFt+jIQtpS1JLf6F8OH5wMImJHJP4kYrf20ycft285wpTtq3Ya4Fj16Wo7X0yi9AdupPhHGaGTkZHGezbPd/DFDrtRur7vZ/fl67mm9JM2yaChcx9MiQzP/H7JYerzXEpHSA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(81166007)(6916009)(31686004)(16526019)(54906003)(82310400004)(2906002)(5660300002)(44832011)(83380400001)(70206006)(6706004)(8676002)(316002)(336012)(8936002)(16576012)(4326008)(70586007)(26005)(36756003)(508600001)(186003)(47076005)(36860700001)(31696002)(86362001)(956004)(2616005)(40460700003)(82960400001)(356005)(107886003)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 06:49:42.0140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7797e73e-3c51-4f28-966b-08da0006a85e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Mar 2022 06:49:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7660

From: Jan Kiszka <jan.kiszka@siemens.com>

Move QEMU_EXTRA_ARGS into QEMU_COMMON_OPTIONS to unify the invocations.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 4105d4e..b623602 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -117,24 +117,26 @@ shift 1
 QEMU_COMMON_OPTIONS=" \
 	-m 1G \
 	-serial mon:stdio \
-	-netdev user,id=net"
+	-netdev user,id=net \
+	${QEMU_EXTRA_ARGS}"
 
 if [ -n "${SECURE_BOOT}" ]; then
 		ovmf_code=${OVMF_CODE:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secboot.fd}
 		ovmf_vars=${OVMF_VARS:-./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_VARS_4M.snakeoil.fd}
-		QEMU_EXTRA_ARGS=" ${QEMU_EXTRA_ARGS} \
-			-global ICH9-LPC.disable_s3=1 \
-			-global isa-fdc.driveA= "
 
 		${QEMU_PATH}${QEMU} \
+			-global ICH9-LPC.disable_s3=1 \
+			-global isa-fdc.driveA= \
 			-drive if=pflash,format=raw,unit=0,readonly=on,file=${ovmf_code} \
 			-drive if=pflash,format=raw,file=${ovmf_vars} \
-			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
+			${QEMU_COMMON_OPTIONS} "$@"
 
 elif [ -n "${SWUPDATE_BOOT}" ]; then
 		${QEMU_PATH}${QEMU} \
 			-drive file=${IMAGE_PREFIX}.wic.img,discard=unmap,if=none,id=disk,format=raw \
-			-bios OVMF.fd ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+			-bios OVMF.fd \
+			${QEMU_COMMON_OPTIONS} "$@"
 
 else
 		IMAGE_FILE=$(ls ${IMAGE_PREFIX}.ext4.img)
@@ -145,5 +147,6 @@ else
 		${QEMU_PATH}${QEMU} \
 			-drive file=${IMAGE_FILE},discard=unmap,if=none,id=disk,format=raw \
 			-kernel ${KERNEL_FILE} -append "${KERNEL_CMDLINE}" \
-			-initrd ${INITRD_FILE} ${QEMU_COMMON_OPTIONS} ${QEMU_EXTRA_ARGS} "$@"
+			-initrd ${INITRD_FILE} \
+			${QEMU_COMMON_OPTIONS} "$@"
 fi
-- 
2.34.1

