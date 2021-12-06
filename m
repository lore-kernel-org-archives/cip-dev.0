Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B161CC433F5
	for <webhook@archiver.kernel.org>; Mon,  6 Dec 2021 06:41:54 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.85])
 by mx.groups.io with SMTP id smtpd.web09.48071.1638772913178392651
 for <cip-dev@lists.cip-project.org>;
 Sun, 05 Dec 2021 22:41:54 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=p4lEIlKH;
 spf=pass (domain: siemens.com, ip: 40.107.8.85,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fO6oveMMRttg4qgjOq0bliZkd8PVJo3mbJc00SiL6navioLGizdhsKya8F4WcNS9sWnaX/AskgjTorUYbO7j3qa1jcQ/vIol9FuDHq4Hk6EYKU09rcrPrwFlIXe+78VM6sMbhatOd47BXsZAsWyBm8nbmw+XIBxNg4CXlqe6KU947JIiHytr0IJNbIJ0Fn8pXyJCQDXyy5IRRmXBxZELddhxZc+Z/Mb+dmpASBWa+3ZKrF/o7saPDjkE6Y9gDrauawQpwLRgK5u+50eKo6B+oSJLIFWJPjainMoCHadCfWdAEz70UGeqRXlsWEP+MyJ9nGoWMJD/jPI4skdxJXDfvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AUpzJ69Zxzcts/DGjWErsxCcuSBN0EYfH0tA1KAWlSI=;
 b=SsuPDXOWNgrHiRmyAo3ZUu7Ks1uD7Ba/5dgWuqDugUqOQqapt0W2Ew9daYQhrms4k5eFw0CZs/wv1CAa5vh6OSd3PqQ09Wwj/znN88l1Xte/bPbhCUHWxS15Pen7jYHmgoMsg7E8cghnxHlR7nxlOrdkZP8GU05zX1qIH5UZ0dCt0rTdB7H7tjyn1ztJ9xCWNjcHiiFPPxSDskvMe7rRUC/JvI2xgwm0LmZKGk6eORnQ82aHYQid+VaE2E1Kc4YOBfpUAF/psynzxHeAnL2zEETuh+nyf6cUO6JHuHY4gRPMLTKGW1tM1LFqjWc5ufx/iuTWn/Ma9AsI1thuUcihrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AUpzJ69Zxzcts/DGjWErsxCcuSBN0EYfH0tA1KAWlSI=;
 b=p4lEIlKHvn3MucMBgQt8+NL64ZJ2fACA9HUfCNzExSaHO+HUk4/EVPWBwzOSsH1igiTJcXWYVGccwoNwriTdmJZ7Nnqqin4HmxZqHUTLhL7nrcbjQBieEE9CAGiO9SzqRRZwVsq+IvhwfiK7qc/O1Moe4yhvE2qYuL8hKLjOku+23utxi7VM/aUtH+t9nFuB7N2WonvBtZXRA3TEBEHmuyQdrO9baydRAIt1aeSWDnHyQpRjnnqw/CKq05h3mwomc0PscidImP1+0haUpwaLzOdTJ5xeK5vPBM8fkdGuAAPzv7Cx8/Oue4x8iagBCOTB2gWY4OIu3phdSDJZAk672w==
Received: from OL1P279CA0033.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:13::20)
 by PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:ae::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 06:41:50 +0000
Received: from HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:13:cafe::c0) by OL1P279CA0033.outlook.office365.com
 (2603:10a6:e10:13::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Mon, 6 Dec 2021 06:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT063.mail.protection.outlook.com (10.152.1.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Mon, 6 Dec 2021 06:41:49 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
Received: from md1f2u6c.ad001.siemens.net (139.22.134.173) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 6 Dec 2021 07:41:46 +0100
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>
Subject: [isar-cip-core][PATCH 0/2] Add 5.10 recipe,
 fix free choice of kernel versions
Date: Mon, 6 Dec 2021 07:41:35 +0100
Message-ID: <cover.1638772896.git.jan.kiszka@siemens.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-Originating-IP: [139.22.134.173]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 443b0b54-a040-445f-5a60-08d9b8837b36
X-MS-TrafficTypeDiagnostic: PR3PR10MB4128:EE_
X-Microsoft-Antispam-PRVS: 
	<PR3PR10MB412840D6DA6E386515C96637956D9@PR3PR10MB4128.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	+IXbUKX6oGPyE9bOiMOb7e6A1gXLwc96xdMCWAsof83LOKSUIPIzY5jhDD9V14RJYC7jfJvnlOzdJdd2wmxKrC1lK1aXFsXGvfnwVJkVEjOTrCPsGf2O14c5AxcPzXtHDhPf4hesTJMRlP3N7YwXndwDfBjCkLCJwfy4VBWT1imDgdRV/+OckCsLfmbJD7TuubYhadcfvc1Sywy1rlXuvews2SkodSVpck2/rAyQItGI6jaLAo2+Bs+5rXh3EqyTS9O70QUnzUEgTcDYHWusAsqu0KxI7YneXCO1Fo45c5/yAXFVIzZ6fNjdXBYAyVgvhYGk2zxh9tjsaWIS9seZg8FkDS6UuDXbafmYIO5hxevXAMEwRedikSiC13ye8bS2pyrhmbp9hOJN4/O2n4tygs1Visrs1y93RJ0B1RqzKVqlwFHeE/B42TOq7NCH2hle51UDzLhD3xqW7KfRWrc6ZNU1gJhgIrxzuzM0qPNzUR3W6oQ/Kx5weA0hjo/oeN5B2QOiEytCOu+jw2j5YquH/Sq7FJlKONNc0KWpdMtPAih8FsrwfVXp8JTBY6mxxuX3GAcG7x/A21JPPJDJp3k8Gn4BpoaVx0dZfURxO6zUbVEXnj1vb5wcDuVX1GHwJ75AA5nK/gHt78kBca0aDvUs6aGHmG3yecDwaOjOZbUow4G1bJ6wY2ecLZAX6r+R5dBu5jgcHOTltH3cCbl5iaKnAuOkgzm85pmz7BqdLEMAjmcusvwCFzLp5gF0sxV7xwVGS+IeT22I9iA9Cxzyu2hi/UF3lMiqgOAN0pOGpq46HZw=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(498600001)(956004)(8936002)(83380400001)(40460700001)(26005)(336012)(47076005)(356005)(81166007)(82310400004)(36860700001)(82960400001)(6666004)(86362001)(44832011)(4744005)(70206006)(186003)(2616005)(2906002)(36756003)(16526019)(5660300002)(8676002)(70586007)(6916009)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 06:41:49.6084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 443b0b54-a040-445f-5a60-08d9b8837b36
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT063.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4128
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 06 Dec 2021 06:41:54 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7064

See patches for details.

Jan

Jan Kiszka (2):
  Add kas option to selection 4.19 explicitly
  linux-cip: Add recipe, option file and menu entry for 5.10.83-cip1

 Kconfig                                               | 11 ++++++++---
 conf/distro/cip-core-bullseye.conf                    |  2 +-
 .../distro/cip-core-bullseye.conf =3D> kas/opt/4.19.yml | 10 ++++++----
 .../distro/cip-core-bullseye.conf =3D> kas/opt/5.10.yml | 10 ++++++----
 .../linux/linux-cip_5.10.83-cip1.bb                   |  6 ++----
 5 files changed, 23 insertions(+), 16 deletions(-)
 copy conf/distro/cip-core-bullseye.conf =3D> kas/opt/4.19.yml (50%)
 copy conf/distro/cip-core-bullseye.conf =3D> kas/opt/5.10.yml (50%)
 copy conf/distro/cip-core-bullseye.conf =3D> recipes-kernel/linux/linux-ci=
p_5.10.83-cip1.bb (50%)

--=20
2.31.1


