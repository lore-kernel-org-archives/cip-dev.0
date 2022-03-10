Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D9CC433EF
	for <webhook@archiver.kernel.org>; Thu, 10 Mar 2022 19:26:00 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.40])
 by mx.groups.io with SMTP id smtpd.web11.994.1646940358445585829
 for <cip-dev@lists.cip-project.org>;
 Thu, 10 Mar 2022 11:25:59 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=KjhVFBX1;
 spf=pass (domain: siemens.com, ip: 40.107.21.40,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fu4Mrehm+0KIfJ9yFsnINMbNRdBvl5O7w8NrC9ydTrrqvaCX20yjxktUH3QLhBV3tBWaDy/RKWQLIsDpptvOFp0Ed/QcdWcZUDXhlvDvxxusmALmF/6K2D5Arf0tSILjOYFB0ZWMFY7amwLmgiTnhcMuTkmJFfePBc+vfbYuyoj2VWLke9heVFDflj2+Ouy/+ntqfRnm65ZF/omZzEhzasKCe2QXSyx2Z95TZlHqcWYXI894gJ0VJtwopjrJBZLsLzuJvBnIBI5RTIk2Kssbn39HEZ3crU1KfOxSLdJCQebpbK0gueiolm3w2WoCt6sHM65C3Y3G3trdHGaoJm3ejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ee1x2fPe0ytGUxFNoMQq2WOhdJyfSoLC4389E5kTabU=;
 b=ihM6DDJEStxK/L/OJlwQLvVqTwWj3B8mvGRfmh/ZU2ZIm4+hP+71uVg7qrWVg0+CJ0MdM3MyaGNdawnMJSs+zwt+F4LlXMxTGkc+rWCr59cThOKZUFlE2ljpj9rGK7vsS28oSFYnq+NYYBrkxU/BS2Cy+k1h1KrJrwUVyG/zOnwBrR4kBJ073zOjTO7AQs/5wIuTZIlrTUFFJpPTf3vov4OTvTmG7xtZ9qXxD76x4qkQrbdYW2m6pHg5RhzlQYM+2+UMsq5FM1kLy5E9DvEzffwploXoqZWeEglDoA9k2RSyCyncyo0Hi2jughpPAqIzZwFELLa2+TF70gklZ3wk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ee1x2fPe0ytGUxFNoMQq2WOhdJyfSoLC4389E5kTabU=;
 b=KjhVFBX1dMfk2HdaIpzl5BXg4i7vGDXgOtWLqGhNrAc7okiRCvtKdUWI8jWdotYHHTpn/IRyEx1SwU1+2Sjbhzh3yIHICIqGkHNuaJXaKjCW9DxgcdBAOD5OoTcc2sB4V04qBNSc+5agG8NICSQ8Yg9VtdXO7YExQ7xDlYImGCXbjAL20dKWuwdl92nKnbgXl036dUvQBdoMk/i7zv9NMeld02NUDaxxWFzkhEwTl290PN12q1oZ6bVbp7P3PJOGWwQywSX1Cj+PnjI2ZoBsQHyd+YlmBZZldinE3aw9Xbloxfx6t7qQkwUZTCDixf/vCHnNXwfXw/B7L55i4w5mnw==
Received: from FR3P281CA0075.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1f::23)
 by AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:182::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Thu, 10 Mar
 2022 19:25:55 +0000
Received: from VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:1f:cafe::82) by FR3P281CA0075.outlook.office365.com
 (2603:10a6:d10:1f::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 19:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT048.mail.protection.outlook.com (10.152.3.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 19:25:54 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 10 Mar 2022 20:25:53 +0100
Received: from [167.87.0.196] (167.87.0.196) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 10 Mar
 2022 20:25:53 +0100
Message-ID: <145c6730-0b18-5e97-42b3-4dde925d7598@siemens.com>
Date: Thu, 10 Mar 2022 20:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: [isar-cip-core][PATCH 3/2] swupdate-img: Use pigz where available
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
References: <cover.1646938228.git.jan.kiszka@siemens.com>
 <6e5722e86c9ddf733464c7484158555df707cddc.1646938228.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <6e5722e86c9ddf733464c7484158555df707cddc.1646938228.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.0.196]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c485056-b57f-49b4-5ed2-08da02cbcb94
X-MS-TrafficTypeDiagnostic: AM0PR10MB3154:EE_
X-Microsoft-Antispam-PRVS: 
	<AM0PR10MB3154B967B25992AAFAD72962950B9@AM0PR10MB3154.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pDqEJo0n5gVkHpEB3CKbju5Pl0rUoiTPJD+nQBjMZ5mZYxoBKeHySZk1crTjZsaZFQFjesv/56RHh1LM6z8YfDwGB+MKXrnNFiCH0r8f1nU6Fpm0XCsGH9LCLuCmZmvIKwUfcUJ8306lTnebGgzoonnfNH/3vG0oXz7uHWC5vqPNn8coXLXAmU4IQ3O4APCC/KqhgIvIY0acRf3fYIUvAyGVL6ZWBLA5YjSiEbbB1m1JasvlMp/XpIPMlEl2+Q+KUiWzYNuo5kffalJ/Df8HXmqSImZz4hC+Cb5jvHOwL3fvDj1g/oqz3kueOXS4CeMBTP+X0MfYXlz203h8rPeICceChZFfT2FvF/RcLADC5HOPE39fdLWuja6ranAOUhVJV8kYUktZGjiOA7CLdfiUPhuPhgzc/uLRYTiuC1xQ8EzWDUbvsgtjuvdSIj0/ozQ43SyHx5E7C0IGeCSMA7w89BauUHpgNcfjHQKzVksT335hm6B05+f+FWprSAcufteT6By6ZKbh5lLlj0cCuS3K1d+TC8ZQ28gvGifeLvyGifwyyKS/a5rQuAZhWHIHsP51I9r+EDh+HXA3BUKWKWGDbZEApRZYTGAQd03tnqGEmv4fEANEOyUUtWF/Fc1B2ETL25FgccRStYvhQ4Dx2f3qiBrRwrARJmu4kqCh6eyWZ6ep9BqcoI7xqpd0Dseo7V3D6Rb4DOUh5FkC2feF/ngmCNMZpa0JwMvPsl0NnUlXNAeZCWtZB7r2hE/dakc8UcRrXSI+xkaPi3QyRE3+obFANA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4744005)(40460700003)(44832011)(336012)(5660300002)(82310400004)(2616005)(83380400001)(70586007)(36756003)(16576012)(356005)(36860700001)(8676002)(6916009)(31696002)(26005)(81166007)(316002)(8936002)(31686004)(86362001)(508600001)(6706004)(956004)(47076005)(107886003)(4326008)(186003)(2906002)(82960400001)(16526019)(70206006)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 19:25:54.2836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4c485056-b57f-49b4-5ed2-08da02cbcb94
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT048.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3154
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 10 Mar 2022 19:26:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7693

From: Jan Kiszka <jan.kiszka@siemens.com>

Accelerates the compression by using multiple cores.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate-img.bbclass | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/classes/swupdate-img.bbclass b/classes/swupdate-img.bbclass
index 97e833e..1437c07 100644
--- a/classes/swupdate-img.bbclass
+++ b/classes/swupdate-img.bbclass
@@ -33,7 +33,11 @@ do_swupdate_image() {
         for uncompressed in "${WORKDIR}/$basefile" "${DEPLOY_DIR_IMAGE}/$basefile"; do
             if [ -e "$uncompressed" ]; then
                 rm  -f "$uncompressed.gz"
-                gzip "$uncompressed"
+                if [ -x "$(command -v pigz)" ]; then
+                    pigz "$uncompressed"
+                else
+                    gzip "$uncompressed"
+                fi
                 break
             fi
         done
-- 
2.34.1

