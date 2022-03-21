Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E9CEC433F5
	for <webhook@archiver.kernel.org>; Mon, 21 Mar 2022 07:59:39 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.61])
 by mx.groups.io with SMTP id smtpd.web12.27699.1647849577974341176
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Mar 2022 00:59:38 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=jDzVZi9u;
 spf=pass (domain: siemens.com, ip: 40.107.20.61,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTc1esbYNm4q9ooOXB5oxkix3QddyOw2Woyit9AI72D6FquGT2+V6ArB/WCD6sDYFjNFTgKD8VAtME/4lE8Mat/YtuKCjqyQcPZGCsWWnU+rf6Qdvt3c4XUbt4giFz4tHXkcaG7iRLIkepux7GCE2srAHzCDZU1pMntV+dz2oH8IyNGm94NyewDlkG4dMQgHfe4AAKuf4Dpz/puxNgTEext0K2qeuW+Z7K03YntWggkuo4jJryHWfT3TU3Tv0d15G2nLbv7MzDOpUgOHrkMHZtehS/216cExbUaiXeosp0sJX7e406gwLALKwcLcvqYV7aN2gai8YlYlHFBX71u8wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5YWldMrPgJq8RzrmX+e9nJZ0dFFNDCLSaICyy3Zx/wg=;
 b=G44olfKX96iSFuXI5Qr9DJHG6MYySuk3oLXYHTgPK1fiTnH+STnIYVICI35A2MWRVL8SG/AtkvWBYnbFy2hSwZTABQTTGXZXq/apDeOM7sgGwrHiscwOJjx/YpMCp++1sAmSu3KMZdyculRiOra/EmtU9fgxo81AcsZ3NmV9Vz6uuvs95gCF6OhRiOrs+HM+kD8XR0Gj0hyj4/7YR36nLJMt9pvTHPpekUPFz4wIZESSgAcPNVOoFmE7OiZsCqVWtSvhY505cEGU8dntFDAOUgYHwaSOeO2xk6kslDl0xTpwDVNP7v9g20llLStwGTtEO5FlmzPP3sAd3/F3Y4bKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5YWldMrPgJq8RzrmX+e9nJZ0dFFNDCLSaICyy3Zx/wg=;
 b=jDzVZi9uU52tStz51wF6/NAsoXz7F+0ZdQrTNIYOpKzv/By+9bIhnOUKFpeH9oGPr3h3eGXXXDRXtgljeDexZNfmhZUL1ENiDueNS1wg/FY+WqvbSTnrQJWUZQRpYxiYnHN9nC/Jvdh3L9u7+LCDvI1ufYnZ2mVgFD47PAoe4zgLtW/szCPkMW7nMHpBvKsAyuV/DG8ui/qtF9q3i96l4C8HykXuZxQUkDt9UrRvSyB4G3c3NR3qt9+4VTMFlxt8mG7jD1SJs1HCzFMj1YhJP1YrIVwA26/+l8hM7Gh2uDGTCv8JsULHoX0y9jxLKul2DkRBWi6LsfaL8Aa2zsPg3A==
Received: from AM6PR10CA0020.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:89::33)
 by AS8PR10MB4981.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:400::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.16; Mon, 21 Mar
 2022 07:59:35 +0000
Received: from VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:89:cafe::4a) by AM6PR10CA0020.outlook.office365.com
 (2603:10a6:209:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.19 via Frontend
 Transport; Mon, 21 Mar 2022 07:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT047.mail.protection.outlook.com (10.152.3.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.15 via Frontend Transport; Mon, 21 Mar 2022 07:59:34 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 21 Mar 2022 08:59:30 +0100
Received: from md1q0hnc.ad001.siemens.net (167.87.32.40) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 21 Mar 2022 08:59:30 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
CC: Quirin Gylstorff <quirin.gylstorff@siemens.com>
Subject: [isar-cip-core][PATCH 0/4] Fix EFI Boot Guard for aarch64
Date: Mon, 21 Mar 2022 08:59:16 +0100
Message-ID: <cover.1647849560.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [167.87.32.40]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f05124-f7b0-4183-744f-08da0b10bd0d
X-MS-TrafficTypeDiagnostic: AS8PR10MB4981:EE_
X-Microsoft-Antispam-PRVS: 
	<AS8PR10MB4981D38EEF291883A438921C95169@AS8PR10MB4981.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	lw8GgwacB4nMAk1Q0clz7lIJF9qASjRiew/aV5waFs4RfS7SybDG9bwwgB9ETqyOOtPxSmHtFY1k6RgDZkItylmHSD9EUz1VX8HoqaQRGfRf05hhpCL2tE78y9t7uADTI9TWaATbxCvjnwRg9bcakcVV94ZE7U25wgSZJzLjpyXkH1o/gPgTu4F7F4yoZsolMxYp6hcGTw2tA/f1vvBNSXFRANtIer56k42atjSMFTwZ8fe4BN7+IwRxtcXPRRNggVRiVG9UH78Dx+fykXdHSCSFbAQ+aNHPV+HlblY1zOLK4346MCVMYQQq+qtXgz7vkJchh02ltUruNPevYnxyy/fNYtl5c6yXjYJ57SGnklG0VdP4N+f80y0S5zyPOxJIBo5xLnHzx0zzdrECbV9JNGXz1UPyZxq6+W5pSTDec3inO6vNkEz39gOkqVXbdD6meFvRO+fsPpgh+auvCAC6SWHrBJ9dxVlaIMjRCTlIT0EYWHPsb+dGFtrTsGYul41+adUYCIz+S1tupGGskfOhsg4ZAWuT3jwkHwnZKvtHFgQfLi5YTGFRT/rW/tE6pebmosOLaP0KpUZoLFW1m6f0aSv23PLUAlnkatdkAuw+MTukgWWm07DKEEYNGT+rBMaR3KJu3jbRgC2Dr0RToSIvE5+HSES7XZCyQl3LFaT2UODq5XQSNOU6TLwahO3i/OM9OAoNGOOCezIyLUuLvfJSSg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(86362001)(5660300002)(81166007)(44832011)(356005)(2906002)(8936002)(82310400004)(6916009)(498600001)(40460700003)(19627235002)(8676002)(6666004)(70206006)(2616005)(956004)(70586007)(82960400001)(16526019)(336012)(26005)(186003)(107886003)(47076005)(83380400001)(36860700001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 07:59:34.5035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 40f05124-f7b0-4183-744f-08da0b10bd0d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT047.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4981
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Mar 2022 07:59:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7784

This is unfortunately not yet stressed in isar-cip-core itself (someone
should add a non-secure SWUpdate via U-Boot UEFI first), so it was only
found while trying to enable a layer that uses isar-cip-core. But to
move forward, I'm pushing the fixes already.

Jan

Jan Kiszka (4):
  shtab: Fix cross build
  shtab: Fix PYBUILD_NAME
  efibootguard: Fix non-x86 builds
  efibootguard: Fix plugins for aarch64

 recipes-bsp/efibootguard/efibootguard_0.10.bb | 17 +++++++++--
 .../0001-configure-Fix-aarch64-EFI-arch.patch | 28 +++++++++++++++++++
 ....install =3D> efibootguard-dev.install.tmpl} |  3 +-
 recipes-python/shtab/files/rules              |  2 +-
 recipes-python/shtab/python3-shtab_1.4.2.bb   |  2 +-
 .../wic/plugins/source/efibootguard-boot.py   | 11 ++++++--
 .../wic/plugins/source/efibootguard-efi.py    |  2 +-
 7 files changed, 55 insertions(+), 10 deletions(-)
 create mode 100644 recipes-bsp/efibootguard/files/0001-configure-Fix-aarch=
64-EFI-arch.patch
 rename recipes-bsp/efibootguard/files/debian/{efibootguard-dev.install =3D=
> efibootguard-dev.install.tmpl} (50%)

--=20
2.34.1


