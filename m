Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9D3C43334
	for <webhook@archiver.kernel.org>; Tue, 21 Jun 2022 09:33:23 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.45])
 by mx.groups.io with SMTP id smtpd.web09.41498.1655804000819371610
 for <cip-dev@lists.cip-project.org>;
 Tue, 21 Jun 2022 02:33:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=wzmMV/5+;
 spf=pass (domain: siemens.com, ip: 40.107.8.45,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AV7j2+H+cwY8FilLjVictx2wNKG0WFsQSSLB+DatgF65DanEXC1WZR5dYGhfOS4mojkX9qBNmoUs6zHslXPCwkDrifrssuj77BtftVumQ33Z49tp/OyQxOnpUxBZiz34LbdeQySwFKL7+F19tyYifXAmLXlfYm2yoaKlL8zsvy3OSV2o2iz67tmI4sJh2JuH/y7hCcgtbrSr4FwVYaEDixDshLZIgdDDCORuFe6NlVDnvOJIySUgR/qiWRYHp1QaaXy4dGxfRerg60XzJp9Y4wPW+aciaTDRTIIGIhEdfKHYtY+X7+hyUgfqi8Jy5kDjQNGjCBfGxMvxvx2+6Ws3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvSQyFXua9H4DWoOSL1/p0uI0LS2+9OReCGgrHrMtbg=;
 b=HMqi0IEC54HrOrUvuIh/nJNyfuNIV8Q8TLreMnrdb+9i/1SJOdQxYoVYCG5CrDUgXsHvvuR7OlYk+xKyNiW5fuVn69wrIDXa3R8RwmN+P++MCWlFaj/jRpeh2viP4IjyJavRaHh+h9JZqYLXTVx5CbePth9z5l04pinN6YTvnoKsBzMh2XqL3GKLGfzAbtD0hHV5Rco7+QlF2JV/+dL2C0IK8p1YbeWhyUxHPCUd1T9zrH58A/fuOx7+y51ZN8gs2dULTpt50OU9OP43KgYnmA65/ITEF8e7iieoHOGL59mz3rqiZQkcoZMctDCuXx66HWhju0QDf9HG+uxL0Osjog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvSQyFXua9H4DWoOSL1/p0uI0LS2+9OReCGgrHrMtbg=;
 b=wzmMV/5+jal4PnZjQsPmjAhPZx2WAx2bXGNjvuZBaND3IqZzsUjd/kUkmPTLxgoLAXx8lEnc0pjN/ZaaGTlgy5NnTQysQAV3jmkKh3TMVQea4a2ijp4TRCCigk1vXFs2gc/4AQ7qg3QY3Rn/2FxUxnHj+kgeBGdb9YZl2zUU9DEvCO2qlO3BavuR9cDJWxi8NRS6nEj9F50MBdL4m6zvVYCzjx+NByPoBzfQGP9Gxe1VcFoQPeluOwMyvtwA8BW+do1czR/5EBUz1hrf2vyxSKUYIDy504SU2bnqZP1ZYC9a/vGpITMF+VlNkq+5r9KbzySnDgAJSOTySjKMIHwYDA==
Received: from OS6P279CA0060.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::19)
 by AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:33c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Tue, 21 Jun
 2022 09:33:17 +0000
Received: from HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:31:cafe::8c) by OS6P279CA0060.outlook.office365.com
 (2603:10a6:e10:31::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.16 via Frontend
 Transport; Tue, 21 Jun 2022 09:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 HE1EUR01FT003.mail.protection.outlook.com (10.152.0.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Tue, 21 Jun 2022 09:33:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 11:32:44 +0200
Received: from [139.22.133.45] (139.22.133.45) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 21 Jun 2022 11:32:44 +0200
Message-ID: <4e20dd15-8c00-140f-a1c7-a42d27bf178c@siemens.com>
Date: Tue, 21 Jun 2022 11:32:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [isar-cip-core][PATCH] squashfs: Fix rebuild
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.45]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.764300-8.000000
X-TMASE-MatchedRID: gWVgGZTbTRaIhw/yEFvcRZe0W6Fejgt1vBkFvcgSMyKPkL2yhVQSiHhc
	s0GMz0PkWAuSz3ewb20z1brXqR2bWa3aC25avUua3un1d696gAB/RNkY1B4bYXIyzDBHWyvrfS0
	Ip2eEHny+qryzYw2E8MWxr5jPZ4+TUEhWy9W70AEgBwKKRHe+rzZymPSrCVA25ygIT2dV9V1IS9
	RCSrxo0XPSXZXYgkzYZrMyuk/cbNQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.764300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 45F24B2EC093B250170251C0B4E674B9568CD354D24AFA564BA040B1DBF99B9D2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84fe661f-a8eb-42bb-4736-08da53691228
X-MS-TrafficTypeDiagnostic: AS8PR10MB4680:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB46808BFB6F348CDFDA95A76595B39@AS8PR10MB4680.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HDgLb3ZMsl4nrxAETX6qHrpiK8ctg+I0WJPlsOzoz2Iaf86Ny60CVwcF82Da/Arfay0g9rGxwd12uLd6BoUl2MEohWftbNPE/4qi9lBnv2SWOfVh+w4yZCOrzOs9Kxss15Mj61Am8Ly20R91zDu16cwcTXxx6DYSbE4jfGDs4/ncyceZnObvQKAiBNOYHPZiK11DH+KLhelYrAiTDBWCF1nUqRNlqd27F7V5WtFIPMr5YMEXii8ug+aOU6OjjmwFOkP6gPWhu/56NYsmZ9wVArSp5yYpCKJA5avIMuttRN6pCoNlW+tEWOSrSMW2hRHq2Oy7bFfvopw19O7duvzhIj1O13ZHPsoiDqRPwfSgotRIOPzS1l0Q3JzIspgopxTjPLryf3+0tvtq6RpIC2YunFXenPyvinSQDTJurmKUPpBALrxpcwHjkTHuhxu/zpgtF1/7DRmmnMvyhiN4Ib3JuxCENl2+ra6q6aQcABUh4884+eWmAGYxOk5cuiGgAMW+jgFziaXinLoQKIsryUuF52/6bNgOX4n6tJCZRr89wL2Ogs3prwnWWIdQb6S+CweiNIk35d/xeAAnbzOhmsu37t2HQLoJ9ZNaWqCsHrgXf/vZUJQ4iuaPRrd+vc68WZnm4MqWNaUinnPZXz9Ox6FA4yZa7qe9wbb17W5ge8HcAbK+WjvhS2B5yEGhirmjLsel2Ls66CSSCChndYHg8k02PP0gpjfnCt5i5+9542wBmWWUdnMpV6zT7YCO2onMiiwF1LbU3JJQslGBpPkGKJa+prkuO4gEJusy69fTVJkVBv25RWulH0OGkrb+35wBKKIF
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(396003)(39860400002)(136003)(40470700004)(36840700001)(46966006)(8936002)(31686004)(956004)(70586007)(6916009)(5660300002)(478600001)(70206006)(8676002)(4326008)(36756003)(16576012)(36860700001)(316002)(40480700001)(82310400005)(44832011)(4744005)(356005)(31696002)(86362001)(82740400003)(186003)(6706004)(82960400001)(16526019)(336012)(81166007)(83380400001)(26005)(2906002)(2616005)(107886003)(47076005)(40460700003)(41300700001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2022 09:33:16.6866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 84fe661f-a8eb-42bb-4736-08da53691228
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4680
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 21 Jun 2022 09:33:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8579

From: Jan Kiszka <jan.kiszka@siemens.com>

The wrong filename was used for deleting a preexisting image, and that
caused mksquashfs to refuse creating a new one. We can achieve this also
without an explicit rm, just by using -noappend.

Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/squashfs.bbclass | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/classes/squashfs.bbclass b/classes/squashfs.bbclass
index 376ddfe..99436bc 100644
--- a/classes/squashfs.bbclass
+++ b/classes/squashfs.bbclass
@@ -29,9 +29,7 @@ python __anonymous() {
 
 IMAGE_CMD_squashfs[depends] = "${PN}:do_transform_template"
 IMAGE_CMD_squashfs() {
-    rm -f '${DEPLOY_DIR_IMAGE}/${SQUASHFS_IMAGE_FILE}'
-
     ${SUDO_CHROOT} /bin/mksquashfs \
         '${SQUASHFS_CONTENT}' '${IMAGE_FILE_CHROOT}' \
-        ${SQUASHFS_CREATION_ARGS}
+        -noappend ${SQUASHFS_CREATION_ARGS}
 }
-- 
2.35.3

