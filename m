Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE911C433FE
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 17:13:00 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.89])
 by mx.groups.io with SMTP id smtpd.web08.656.1643303579638070388
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 09:13:00 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=fIggF6Uv;
 spf=pass (domain: siemens.com, ip: 40.107.3.89,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CSBA5XLA73nCDu5wJBLk2wfuMZMqVXuqbzpCIDyt6Lx4bMKoJo9x0sDQPnniCC5oX4mG+0xu/Qn2vjQg04LtYFjgOVqD4iycPU0ORDhR1BfUjlvLao1zMlY61o9YoCsk1414gq5l14D9kmPyEN6s9mrwU3s9PfkbXSO95XF9RILHNcBW6/gCZ6nENZ7nUyJuxacgW1sbEIhjK+GOh7KM1wKgmfC/1p2ahNFOs/S7UZLEuqw5NyWi4K9cIM1B39t+kIPsEAT1qNowhJTeD9IIJR/bRJRt9IdqOdIB1/DBoWNPLXpR7ArNILwNz3ZST/KxhSzTB8c/uFyzX+z0gO6QQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8UFUo4x4rZCqsowgnspJBE/mF5b8XxZ29HA7Fy/lec=;
 b=CQw5k1n9wg9vbnzdfR5NPeX23hlumJ3WjKY1JZrpSqa/vGl41JmJMy31YnnKCsqUszF9M8uTwJj6itwssGUsYqwHTbJk+ZNYQYfUYB/izNqcOKGPL+GjP1vulw3W6N0CzcGRhF+mv0MDQpABoteaIk7QnuwYM3EV1kLdcYyMpUfd3d9NcHYU3/eu94DAuUS//vAeegE+E+wg7YgGNyKu4KC503AjQr6XEa3fGeg731COb92RPIoZrMi1ay07QkfHvlt1U4cDNQAhQ3mEnUiVAP3I+0tTOJUoiBn4Kw+/w2tH6+lipeUiNdbt2jhTIAXQihlSdg7nvF6WXHXQn2k9fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n8UFUo4x4rZCqsowgnspJBE/mF5b8XxZ29HA7Fy/lec=;
 b=fIggF6UvVsEfejsqhC0ZWCOVV2g/rzp29giNbGfPu4nSE6zTurtKJdlt0YKv8FYZo7unNO3X6v6z3yBAjGMZtxIoxcKlDZfnT8Sp9oWpTo3Q4bkKfzUhbUnpTqon7RSF1VPfx8OKmsouGdi8BoAJq7BvszcFfv8xby9M3z1IUQ2OTVedXzeyT8jhCaxRzbvxEFQDVerKBHwKwuW6nNgsTd3C1YFdZS3ecyWyDDWoiU6l0Wg4H3sERb5FYqPyLcZiCVKPK5R+H7zSu9Br7GOMM4ptIqecIaF3SI24ar3xXQuZI+JGdXWDgTkySv6a+e8nyBhXwBTLdYQMxCAUPHKrRA==
Received: from DU2PR04CA0048.eurprd04.prod.outlook.com (2603:10a6:10:234::23)
 by AM4PR1001MB1363.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:99::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.13; Thu, 27 Jan
 2022 17:12:57 +0000
Received: from DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::2c) by DU2PR04CA0048.outlook.office365.com
 (2603:10a6:10:234::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 17:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 DB5EUR01FT015.mail.protection.outlook.com (10.152.5.0) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 17:12:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 18:12:56 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.73.11) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 27 Jan 2022 18:12:55 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: [isar-cip-core][PATCH v3 4/6] enable cip-core-image-kernelci
Date: Thu, 27 Jan 2022 18:12:41 +0100
Message-ID: 
 <9f00d50ebfcdd3cebba57431d6c98952f6344fbf.1643303563.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1643303563.git.jan.kiszka@siemens.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC8A1A.ad011.siemens.net (139.25.226.107) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88959f65-6348-4f2e-1d29-08d9e1b84329
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1363:EE_
X-Microsoft-Antispam-PRVS: 
	<AM4PR1001MB1363AA76C10392FE11E2956B95219@AM4PR1001MB1363.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	obVxLUNAVMpRmlPyiLrQQPNSKJGQnlaCadUKq4Z9ERlDTGsOOtZpqMZpbykq9SyLqHoS0sNj0KlRL1G9uYhBs75NDjKJfsH++J6TCSXkcqcDVGq1jsAxlYwUFFg8jExFDXGFs6G88j6oQB0TTmB4Y6kosGpsiKJoUX5nioVhLz/eaapP0euW6bHyI5AAhXdWsYDM/8igov+vuHhEf7J2yPJfgWXyw7dIbsfzp9HBvSiBfqn2cVkVv/qSg8xIuj7f6UMb/bMUJF3D/Dc8ZwYuJh96Nsx6vpjxr0zJOl/YN60U1zIXoEnjqB1HSZlhhYyS6lhM5SfAExZ0+NYkJpnuEorcidnTNkfbFBxMowpInFv9q8Cu+TEmj0mBTo3oXVy6a/yBb9ffiovskiHSgoVj7ZJvYLGJP1ohmu76Pv4c3z4+JzcmGSXAoIRG86+zoxkUU3JXajoMkrfFsXZ9Y0xbfAhSSAv6asJ44HHqWGIYyWM1GNH2HRC4PrgBCRlI0J9/RF06FnaH0JYDNaeGs0n1l7O9g94xlx6kh6hNKDvNDrbtlxSzdPpEgxyxtiNydt38POIO/95J7sUqMesXbL2OPnAz/HAVsFq3dnanEava/voxlUa8glaPxELJ4daLKppnblM77wilFVFvZ/a6irRUtBX8oodciuDQA8KZShUAMZbFC8h2uhpE/QwFEn6OZyWg22G98ar/D+Moit39hSMSsGDWnias6ZFTD2PYTPf86gw+ytSW7dU+egd/A4TosqW0M83nx4X3KeTz+QDjFMOdyg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(46966006)(40470700004)(36840700001)(47076005)(86362001)(6666004)(956004)(316002)(70586007)(70206006)(7596003)(7636003)(2616005)(82310400004)(8676002)(4326008)(508600001)(36860700001)(40460700003)(8936002)(82960400001)(5660300002)(2906002)(44832011)(26005)(6916009)(356005)(336012)(36756003)(16526019)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 17:12:56.5854
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 88959f65-6348-4f2e-1d29-08d9e1b84329
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT015.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1363
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 17:13:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7510

From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>

enable CIP core image KernelCI to be built with gitlab pipeline
and uploaded to the KernelCI storage using KernelCI API.
enable cip-core-image-kernelci to be built for amd64, arm and arm64.

Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 .gitlab-ci.yml | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index e9cbc60..c06c783 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -9,6 +9,7 @@ variables:
   targz: disable
   dtb: none
   deploy: enable
+  deploy_kernelci: disable
=20
 stages:
   - build
@@ -38,6 +39,7 @@ default:
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
     - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
+    - if [ "${deploy_kernelci}" =3D "enable" ]; then scripts/deploy-kernel=
ci.py ${release} ${target} ${extension} ${dtb}; fi
=20
 # base image
 build:simatic-ipc227e-base:
@@ -77,6 +79,18 @@ build:qemu-amd64-base:
     wic_targz: disable
     targz: enable
=20
+build:qemu-amd64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 build:qemu-arm64-base:
   extends:
     - .build_base
@@ -87,6 +101,18 @@ build:qemu-arm64-base:
     wic_targz: disable
     targz: enable
=20
+build:qemu-arm64-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 build:qemu-arm-base:
   extends:
     - .build_base
@@ -97,6 +123,18 @@ build:qemu-arm-base:
     wic_targz: disable
     targz: enable
=20
+build:qemu-arm-base-kernelci:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm
+    extension: kernelci
+    use_rt: disable
+    wic_targz: disable
+    targz: enable
+    deploy: disable
+    deploy_kernelci: enable
+
 # test
 build:simatic-ipc227e-test:
   extends:
--=20
2.31.1


