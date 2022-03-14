Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813C6C433FE
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 06:09:37 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.48])
 by mx.groups.io with SMTP id smtpd.web08.23151.1647238175645262069
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 23:09:36 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=wcBq8U9C;
 spf=pass (domain: siemens.com, ip: 40.107.3.48,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJbua0M0xPEEKWvicxiZaeVCyGQvPjVfzgRUnC2LVZcsAYgCdj/1nzfaHg1aL4s3NL3+7zk/z5MvmT7RIWznRsjuSQanPXchA9Re205VzPsLS8MpahqgQfSIxmJYzdXCsbSFNAK1yRBHOpJx8vEXUFi8OFXv81uMBWVs9qtioYu59fVQxJSWGXL4mUHF23y/G5+sNTYUZyGPw0kuE55OC9fb0POta3Ghae5PU9oN7FZINAXc0FcmgoUG8o4mGIcKndv2rbSw3mZjpHGOKAwPPIgiPRKtbEW5eBk9Ky/woMikRWPkTASSFpl+56pWzu6hTdYFaouO+uURiJK3iKlQOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z0rPWyFXrXmyS+UTvyYKJIJlKdvKMP39vi3aeDfVEMo=;
 b=bUQOzIo3zYygY51Pennxhp7X3tCmbdGKRFc4zQPFEYdqmqdJdGRnNItdCVIyCXzQDg6RP95HABIz0Sze9Nso/bhTUZvrFBTPB5YlCxVeyaYaKi54LzmTQMeEPvXWGvTI+EoKMMXfpWwMyyREKMxxSMzJVcdqCASBKrXK0GRWCfZwn9CVmF/QhT0ZXHaLefKz1uzKNdKitz9Qn4rvmynkd/Rzc+qqsDPgas4pZuLV/+GAVl1m8eVdgrJ704sB2xzAadPXiHI4pNNWsQeaML+y1vh2gdh2bA9YdBB8pVUG8vjYU8m1qeSGxWnA48eac7FcBPT8LeseJECpOqoC2GLPRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z0rPWyFXrXmyS+UTvyYKJIJlKdvKMP39vi3aeDfVEMo=;
 b=wcBq8U9CYvZkzrKk0fToEvzpQ2DveyX7Oqao4E25LZ+06RQnN2BPwb14Q2MNJqOWjGsIrO2noP3zfabxWM/gPVQAGWLSnLTJc/yK8K0a22smmhYGlciMpsPxyeA9zyeGwsh35O0arEOfPl4tquK1WVSrrwShy+NqoryjFSOgkF1Qo9YsAq5s/HtY1Jt1kRlozk/mwjb+LBFmZkZF4VgfTiMRdCdEZyyE53Ww9orjeV7StHG4P1H0pESgW6L0NC7r/s4HKUXAT5J5OpMzjKSDRB0JLggA59/vJjsIhlKE9Jln42tJFK/R4CBSwPcPOkTfFMWsC1RftUWcwFoKOIYGLw==
Received: from DB6PR0201CA0026.eurprd02.prod.outlook.com (2603:10a6:4:3f::36)
 by AM8PR10MB4722.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:364::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Mon, 14 Mar
 2022 06:09:33 +0000
Received: from DB5EUR01FT024.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:3f:cafe::14) by DB6PR0201CA0026.outlook.office365.com
 (2603:10a6:4:3f::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28 via Frontend
 Transport; Mon, 14 Mar 2022 06:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT024.mail.protection.outlook.com (10.152.4.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Mon, 14 Mar 2022 06:09:32 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.72.30) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 07:09:31 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 3/6] start-qemu: Update usage
Date: Mon, 14 Mar 2022 07:09:18 +0100
Message-ID: 
 <12660a73068aeca04df5de0aa71a0dc6476e76ff.1647238161.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1647238161.git.jan.kiszka@siemens.com>
References: <cover.1647238161.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b675de98-f800-4ca0-8985-08da058134f5
X-MS-TrafficTypeDiagnostic: AM8PR10MB4722:EE_
X-Microsoft-Antispam-PRVS: 
	<AM8PR10MB47229AC5AD3AB76197122FE5950F9@AM8PR10MB4722.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	8RmSOBoty+l1EC08tQ4ZwpX1XPuOTKhpfyBVrxFuSfmEYO7kAZDFCuf/oOsr+tcPKAb66EveiWYbPALCdYeRa3ClEcL+8kXNU2vvA8FYP0ZJOFS7LmfPVkXmghSEyW1urW+detbOQ9brj4nJaGxfZMp/8dlkltgALvbgJcqMNOYGnUXtzLAMaSGtnLY9+T/B3+jE9f8XEbSobC7WBB2GxkJdDF1F+BPKWcbjj6gBsAjm/hdTgniMujAcf4s/RxxPkp03HiSOEbo1yafYQH1eb3RIl+VYqJWEgb2ZxXLz/PZYGIFmbHYG7o+L0UCK7PrKtJeC5uLVBu+fp7dp0dy9yeT8F1Vo5OexCMTqj+/cRxngc1P1KOHQIUalazCP7xVtbTOWy35hPUs13rD0eyrSD2tqgOLe8sIQklTSJuGLJwEaFC2VbSBM2ju0TLH498FH+KTMZde6UqSYQ5RCtxu9VItaX6McPIBXcP98Kv2RR8o0b+zcrH5t/oqoclw6bczHxsq2KlFQcI0EketwxLFQvy37ocmiWbEHESBB6yRRlPjoTvLn4oeyR5k6QlFlN2BwtwQTDqyNxAUbIkiMlcbL01jihBWvOI5O8L4zugSW9EgUcIq2IPZXApwoYJl0dawiDnfwP0a59HLvrtl4YQXRfIZa4dW25/icwA1X+qcgM+/kI0Q8ASf01uF1YrdGTdA6qAcyloYWIev0E5gZ74/zlg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(8936002)(8676002)(4326008)(5660300002)(4744005)(82960400001)(86362001)(44832011)(70206006)(70586007)(82310400004)(356005)(81166007)(508600001)(40460700003)(36860700001)(6916009)(316002)(36756003)(83380400001)(107886003)(47076005)(16526019)(2616005)(26005)(186003)(336012)(956004)(6666004)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 06:09:32.3148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b675de98-f800-4ca0-8985-08da058134f5
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT024.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4722
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 06:09:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7705

From: Jan Kiszka <jan.kiszka@siemens.com>

Document also SWUPDATE_BOOT mode. Drop the hint to OVMF_* vars because
we use the images taken from the build by default now.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 start-qemu.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/start-qemu.sh b/start-qemu.sh
index 0431906..e986791 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -15,8 +15,8 @@ usage()
 	echo "Usage: $0 ARCHITECTURE [QEMU_OPTIONS]"
 	echo -e "\nSet QEMU_PATH environment variable to use a locally " \
 		"built QEMU version"
-	echo -e "\nSet SECURE_BOOT environment variable to boot a secure boot env=
ironment " \
-		"This environment also needs the variables OVMF_VARS and OVMF_CODE set"
+	echo -e "\nSet SWUPDATE_BOOT environment variable to boot swupdate image.=
" \
+	echo -e "\nSet SECURE_BOOT environment variable to boot a secure boot env=
ironment."
 	exit 1
 }
=20
--=20
2.34.1


