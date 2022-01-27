Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD019C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:12:59 +0000 (UTC)
Received: from EUR03-DB5-obe.outbound.protection.outlook.com
 (EUR03-DB5-obe.outbound.protection.outlook.com [40.107.4.68])
 by mx.groups.io with SMTP id smtpd.web11.675.1643303578560988612
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:12:59 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=tLHq5Rz7;
 spf=pass (domain: siemens.com, ip: 40.107.4.68,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl6MvucljXU1Xohk0aX+SvmIA2Vix1CSLz//RHEq2UkxwxkR5bHa3aIBB5w0sKqUQnspBeAsWJWJQouEjn9aTC5i354QX1Dw9YTNl6ditj5JVVLlhc+dlMX3W8LKsDHFdL2gFpnFKoVdidpQlwEmdlGB3l9jQvpnOdzSZwEl/M78SYhS2P+b9mztBgsTEKxZvh+2o5rSLdSHuSC5eYK1YTzCUNOC2dIztHYQ63Xqsg1/FD35szfTupkPBPkUV14nOaOKehhcme4bC0ALOhgQR3N1ENDMIV/9zyB07fIS2KhI2tAdxQk8uzJT9TSCtDHshek6C1jZrQAVyG3YHe2bQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ya7tBf5o0bA4v9mNzEwjJeFN6ZCxKzTXsuukbP7aXYA=;
 b=PqW+Kxm91xt5PjEo4GhfnruL4Xw/L/MHZieOdo8BqPq95uEEVdiIthhm6iOyUSfCfjTqgLypuYTCUBqRRyc064Jbso3nop+ceYBOq43v+MsIqZzgxYzyJPYS2W2wnX87eQAo/mXoS3gYJUd8fvA2lU9V7bQpL+quWVeJ30w8kPaihTf2NXlx1FUUBDLvxVC92L36HaZWt+V8cDkRLFAcjAZ7uW6eno5mrCg4/nLxZRcj/1XathWcr7IGWUikbFApTpXeuOKjckKgnltX7Z+3fNBZqm7p6gyR0DsWYJbCDhVC8a9wkCWQw/gTRa6ouF2cnsVsm2tcgdt9i9+qTCyMGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ya7tBf5o0bA4v9mNzEwjJeFN6ZCxKzTXsuukbP7aXYA=;
 b=tLHq5Rz7kUYIDq4EfH3JVGmkUi9xnVaaB3xFKsGW8nt//29l7aEHoag0d908W0hXtcZest+OVS+kmN6UWXuB0+4AzMqIpjuINgSNanPXj0trehTKQIThA8L2oan30yWJxAvTiJretpiuPLJGSNkOu5O5N7CYGV4wyUohttYnG2gdQDOcZUvWceb2f9Go37HjJPFxebHdqwAsp/2HuAZaH+IiQ/SHTQKkcrMgks/ZmXlVgG1xTo1bxTsovl5X3t8mC0ciXzPm46mpVy3oCm3OMXsJbpROqyIXkoqogcdp8XAGRxEQ+zpwAoxj1r/hDqe+xh7kzRUn9xFlDJ4TUtXkQw==
Received: from DB7PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:10:36::14)
 by AS8PR10MB4965.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:400::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 17:12:56 +0000
Received: from DB5EUR01FT004.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:36:cafe::a4) by DB7PR05CA0001.outlook.office365.com
 (2603:10a6:10:36::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT004.mail.protection.outlook.com (10.152.4.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:12:55 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:12:55 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:12:54 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 0/6] Add cip-core-image-kernelci building
 and uploading system
Date: Thu, 27 Jan 2022 18:12:37 +0100
Message-ID: <cover.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32cf9f91-5661-4b90-71ab-08d9e1b8428b
X-MS-TrafficTypeDiagnostic: AS8PR10MB4965:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB496553910F23EE6E3D20C0EB95219@AS8PR10MB4965.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	pDok8IAlPgP72MJJ9XqGPgetLZ5NqSsj+fnxCOF2SDikHBrPXjAcuhPCjshC1rXWzj6i0L77sT2VXTcCCAc/jaQ3/LmbHKpDsOtqVmG6VQKTYM1I3ESwdzHcpK2laHwoFWGg6K/j0ozYEIwv2H9lsephPSFtmuhDx5bfq12BVM85FE9i+jgpwlxtY9Xen3K+N7l5RaVkDLwb6XPj/h8Qy5q/GNR6MoOwt7Vt0Eb1orZjJobf01iRi9Wem31ZMznUlKxqizHstLDgk2FXKIJY/BBeepckhLxzpMvcmQLVZLsfQayYx5BsalENDCJmn7Jomzs1oEV9Ky8U0wiaAZYoe9atud7WPpwi0BT0WnwOHLRVjoiesjmzT4q/LoVEkrrYrvCFK1f0BXw/lH2gHI7pCP9Y9EDOQDJnajesYUwpHyyCeuchx6zQ8kGrmO2nopOXEYDNK7CW9lbBk8/jGb1RGEzP3cTU4ptPDg+jXudn4rnLuPyV8ZnfTug7OItbId/Cbbox277EqCN9psOKSOGeKncefUzZNI/7ooppvBH1n1F09ZwQ8UpfaCW9w884uvk3Kx0g9DvrqYg8jZcZOeyzod30dq2UwSGp19dby4IeAZg5iqNxvm+rikbYdRa+oJVJaT2/Gha7Uy7BL2wxAt6S14Ld7Vp19H2m/nK+hQxEfJWnF2GXv7YJ59CAYv9SMb+dY+jqMYWBp6DUTIxp8ZdcjKkGwhEFS/zFqRpJARJxKnxzsuivny63eR1rvR8JuEo7B800SZu7Jtwev0RUmGgZ1g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(40470700004)(46966006)(36840700001)(8676002)(70586007)(26005)(356005)(5660300002)(44832011)(82310400004)(186003)(6916009)(40460700003)(2616005)(956004)(4326008)(47076005)(8936002)(70206006)(508600001)(7596003)(7636003)(336012)(36756003)(83380400001)(6666004)(36860700001)(16526019)(86362001)(82960400001)(316002)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:12:55.5521
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 32cf9f91-5661-4b90-71ab-08d9e1b8428b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT004.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4965
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:12:59 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7508

Changes in this version
 - added missing dmesg.sh installation
 - consolidated customizations recipes

Jan


CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

Alice Ferrazzi (4):
  Add cip-core-image-kernelci
  Add dmesg filter needed for lava test result
  Add script deploy-kernelci.py for upload the cip-core-image-kernelci
  enable cip-core-image-kernelci

Jan Kiszka (2):
  customizations: Factor out a common.inc
  kernelci-customizations: Reuse common customizations

 .gitlab-ci.yml                                | 38 +++++++++++++
 kas/opt/kernelci.yml                          | 16 ++++++
 .../{customizations.bb =3D> common.inc}         |  4 +-
 recipes-core/customizations/customizations.bb | 27 +--------
 .../images/cip-core-image-kernelci.bb         | 16 ++++++
 .../kernelci-customizations/files/dmesg.sh    | 23 ++++++++
 .../kernelci-customizations/files/postinst    | 34 ++++++++++++
 .../kernelci-customizations.bb                | 23 ++++++++
 scripts/deploy-kernelci.py                    | 55 +++++++++++++++++++
 9 files changed, 209 insertions(+), 27 deletions(-)
 create mode 100644 kas/opt/kernelci.yml
 copy recipes-core/customizations/{customizations.bb =3D> common.inc} (90%)
 create mode 100644 recipes-core/images/cip-core-image-kernelci.bb
 create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
 create mode 100644 recipes-core/kernelci-customizations/files/postinst
 create mode 100644 recipes-core/kernelci-customizations/kernelci-customiza=
tions.bb
 create mode 100755 scripts/deploy-kernelci.py

--=20
2.31.1


