Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68655C54EE9
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 09:53:27 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.43])
 by mx.groups.io with SMTP id smtpd.web12.9822.1663667598620744602
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 02:53:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=mv7ZzL4w;
 spf=pass (domain: siemens.com, ip: 40.107.22.43,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzjB/DmmRu6mpi4c0Y/IGoNmW8und8ijDg78tli/jNOsGtueKiqOvW8zAeq+aXnx+3CSupHZbGsqitpDE9ikfen59MfuMQyGC6ChgwbOzbURUUO3HHbFRrJXHDHT+mZC8H6V/idAwtD0HbNWx7q+rQNLD57gyjsCL2OJx36RAsqkMoW93tgmSbJaefTG1QkPg2DTNhyeRP9TFqw6AkpDdokoGxWqZ1Z2DVP8wNVtyIzbLI17LEf1bDGpoAUoPOABYWdaE9T2EOtjGZd/CqbJ50qPgq8OJ1Kg3d7tRnBO2O39Wxo9uX/TOhuyvx+mlePiMMMo67YqOIryDeLe2+4Ghg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TTdrHPZFFdLVn7AE5QXBXG5g4LjfR8CqdiLjODh9kTk=;
 b=Z2jz4orqyE+JAQOKR6sFyqQP99CEoHb+xeR/uU/WoSbnL4tmh2JDc1CykaEulZXY6YpEKwkj2nkGwknz0RObz8tjs6RmhZVwoieEhaFRUwBIEvW5ox6qrvX969Q0CCplb0FzMzQtR375uAbKFf02FRZkeOB8C4IITeIbkC5GAfa0fi9T0IYrrEHoVcz9lHBxFmgliFF3yz0qfJ9aU7kAy/AkaRx14lbFxxrJ9uUC4jy0+RkKUgoLDwgi3RvMgZYx7VMWTaBSHMXar5KzNkiI0wclcqexrurhLbMZgM/bAj4k3Pxz4xX55JmYZej/JPsjABHlQoujNz9S9vz/85GNXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TTdrHPZFFdLVn7AE5QXBXG5g4LjfR8CqdiLjODh9kTk=;
 b=mv7ZzL4w7YvRz1+hdt/T9J1fqkvu1YDyP9USEArXOSOgkeBWNvly/wIf+bCp2BiFc0DPI8cplgKDP1oQlX5XUNnifSQSfvNOA9yMMny5HOyEEnXKIydJuza2+P6TDFNDhyZMi0D5x/9VvwkSvmhj/8GOlRHbBgjiHs79bBep/2ceDYZtZZI4HMPECsCciWXPDVsKjnZQRbyMpRJAI29Omq6AQeNPc0uetzQ2HaFqVSJsL0/e1ax2hnEZntMILTQ3dWEpSRaxn2ikYfD9F6b9KUVguMa8KOz2GQrQS0Gcop9jcBeRAGvRfwptAJYALhTAMmSJOBvYzQpvpIE+9qmhjw==
Received: from FR3P281CA0122.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:94::6) by
 AM0PR10MB3603.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:156::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 09:53:15 +0000
Received: from VE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:94:cafe::2c) by FR3P281CA0122.outlook.office365.com
 (2603:10a6:d10:94::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.14 via Frontend
 Transport; Tue, 20 Sep 2022 09:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT065.mail.protection.outlook.com (10.152.3.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 09:53:14 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 20 Sep 2022 11:53:14 +0200
Received: from [139.21.17.42] (139.21.17.42) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Tue, 20 Sep
 2022 11:53:13 +0200
Message-ID: <ff9627c2-d15a-a600-6e3c-36c4563b0cdf@siemens.com>
Date: Tue, 20 Sep 2022 11:53:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: [PATCH] swupdate: Fix swu signing
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
CC: Rafal Radziejewski <rafal.radziejewski.ext@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.17.42]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.140400-8.000000
X-TMASE-MatchedRID: u84ugoKN9Hx/mx07ATCoC1TUqH8/USCeAiMGz/np4Ov+xRIVoKNMvAGo
	1vhC/pWjva4hxzuVF7gz1brXqR2bWa3aC25avUuaCce0/MwBd9vutZJcJLSUMLHi5RYjnQEoEDn
	DEqNPdupM+b8yxBqvAxoy+DGF8kN2vtoKD5YN6RPd+Lc37tAofmgO84xrp6ee194/5X9VfCx/7i
	VTXtdMVZsoi2XrUn/JyeMtMD9QOgBJeFvFlVDkf46HM5rqDwqt7WPW/xHv7V8ZBv5KgfRpRrz+1
	QhwXOrUNLUy6FVONwnx90pTOlsCIg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.140400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 795B964AD75163615A952408959AD47B7757396C0B815ACCF38C7F1C2631A48A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT065:EE_|AM0PR10MB3603:EE_
X-MS-Office365-Filtering-Correlation-Id: 076ad0ae-fc00-435f-a335-08da9aedef9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	RqHcAao/cE30nzvL1W/OrkIkFWW6c3n44ycw0V1+IQQSw5Ozs3FMniFSj/1fSrPjgVrI6KXkzXYZDQ/OCXTmrCVHOgvsVeiOodfsKq2KLvv7ePsH5Jr8WtwCUf1x1uf3SHKWznlFhIw2AwF3DUGys+MHAshgtjv8L2ZvhlAjBfM5A+14WvQ73/bic9ts2EJ3lhpqmaRXcXsW8bDR5oZhSJUxesDqyhPoEHXRF0FPM+uoDgCGFb4A91SBUfbwO4FbWildrOhrFs2mjFjyZ47GYcL8I9ZSwYj5QFZP4rpTv0CdwwXp0U3/R6753rouKtO6dPH8bEGiz3+ql4yUSvT4f6iv30ZiZylF+QmwH5vKaOmCPHfW8Od+8yIxW4L2lnuoJodX8bRrfWu3Fizl9ZB+X3jEM4S/SRHvq8xJP+PNXTo7+T8aJn1s5J+L2sH6LCis4uWtHMK5cF1W+EC+l5Ixzq4fF/r+aCqXxrRJu+1ySauEQAR18zUn/8TyOHjCnjiqFUAmpqDFi3fIXBgGVqWV31o5MTPlZNKKd4827BOTL7sJeacm0lNZQPRT3zQCD4zYcl/WpEr/tFomzdBpywlJnsQGodjCwRldjMfctUvwSGci11W33Fcj1tMGMnSon5X8TvTO/ubgRmf3Nck6hAl4y5p5fsxNNtkadd6eeLgznQd3+InwfGfo2v1zCBb+GLk6Kx3WlnRKW05eiL8kAxMVKr4/s5BGznAhm90wrIA44AJjeMnZ8F8GZ9eMTDi4uYH/cCBa/2jPz56QLhh5D82kslVet6VYWYCORX+eJCSRq3m1VKZ00P2fGL4xjgXT3Cn+voTAN6S+dY80A5LEdL/Bi2OQEXbUBe1kjc9eBCi0mCk=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(36860700001)(82740400003)(44832011)(47076005)(41300700001)(82310400005)(336012)(8936002)(107886003)(2906002)(36756003)(4326008)(956004)(82960400001)(2616005)(186003)(83380400001)(70206006)(16526019)(70586007)(6706004)(6916009)(31686004)(316002)(5660300002)(8676002)(16576012)(40460700003)(86362001)(478600001)(31696002)(356005)(40480700001)(26005)(81166007)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 09:53:14.3733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 076ad0ae-fc00-435f-a335-08da9aedef9d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT065.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3603
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 09:53:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9522

From: Jan Kiszka <jan.kiszka@siemens.com>

Was broken by fa31a98f0d18: Export 'sign' which is also needed inside
the sudo env and move checksum injection into the chroot so that the
${WORKDIR}/swu/* links work as they should.

Reported by: Rafal Radziejewski <rafal.radziejewski.ext@siemens.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 classes/swupdate.bbclass | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/classes/swupdate.bbclass b/classes/swupdate.bbclass
index 46d2a36..451239e 100644
--- a/classes/swupdate.bbclass
+++ b/classes/swupdate.bbclass
@@ -58,19 +58,18 @@ do_swupdate_binary() {
     image_do_mounts
 
     # Prepare for signing
-    sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
+    export sign='${@'x' if bb.utils.to_boolean(d.getVar('SWU_SIGNED')) else ''}'
     if [ -n "$sign" ]; then
         cp -f '${SIGN_KEY}' '${WORKDIR}/dev.key'
         test -e '${SIGN_CRT}' && cp -f '${SIGN_CRT}' '${WORKDIR}/dev.crt'
     fi
 
-    # Fill in file check sums
-    for file in ${SWU_ADDITIONAL_FILES}; do
-        sed -i "s:$file-sha256:$(sha256sum '${WORKDIR}/swu/'$file | cut -f 1 -d ' '):g" \
-            '${WORKDIR}/swu/${SWU_DESCRIPTION_FILE}'
-    done
-
     sudo -E chroot ${BUILDCHROOT_DIR} sh -c ' \
+        # Fill in file check sums
+        for file in ${SWU_ADDITIONAL_FILES}; do
+            sed -i "s:$file-sha256:$(sha256sum "${PP_WORK}/swu/"$file | cut -f 1 -d " "):g" \
+                "${PP_WORK}/swu/${SWU_DESCRIPTION_FILE}"
+        done
         cd "${PP_WORK}/swu"
         for file in "${SWU_DESCRIPTION_FILE}" ${SWU_ADDITIONAL_FILES}; do
             echo "$file"
-- 
2.35.3

