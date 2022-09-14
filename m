Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5040AECAAD8
	for <webhook@archiver.kernel.org>; Wed, 14 Sep 2022 07:34:32 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.52])
 by mx.groups.io with SMTP id smtpd.web11.3550.1663140863084268110
 for <cip-dev@lists.cip-project.org>;
 Wed, 14 Sep 2022 00:34:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=LfEG4FkZ;
 spf=pass (domain: siemens.com, ip: 40.107.21.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YxJJl+rEiBsuoGeUpJuQvuHjLzenJo0XxNVd08J2H264Z3f0B4nnXknZLT/Xbze1LAsh4JV6XfEPDJOKXtJMooag2AjhYsKQOIe6N3aN33O4dWW/YKY/JIvUUZBHgWdSv2SU7qqv2MlvirBbpWXA9KWUk78cLpBV0bFN1vOwWfmUx3z5yKaK7GOvK+tVTD/7bm/kG7EK4sr/zyAkENqFxzRb1srkYREbd9YQjQ5n5vtx6EYLaAuIFVtbrtPRWabjoOzsiCureb8kVPgHSwXNqCJuETkSrzb36t6USd0/Iy8yBZ1NBwmuMflwmwtLPICBlVXLR749anMMQ10gLE9h1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2SGbBfzUt5vZKI33wHKyengM08B+kxEZ9mokrpAsOA=;
 b=hBt29qmEIOjZdOWwQ/lduXrMGiUKjjVlWZFZmCA2ExCozwdrWR6c1BHPW8B+hzSWJ9bfQbtOZHMSJB3llu5JjClsPD8WAzlNtPGaDX+jxrBYljC6234X2jDssct4MddQcB+yiEgHm4ffhSykr45mqNk4xAnhzI61e+V5FRKqWToS4+0+Dx63FsvDSGS8e6RBW6fUA8L1UkY23jaPwZnhqDfiwCurYpQtGG5yPnsmxPKylftgUCywiHQ7JW7Tuofiq5hsGafDfzSvHIwhMt/kAw+X5F9cBSOUpqzvInLXY5qezbT8AbGmpbFy+p6oxyekGmWrCIILgAS9rCBhoXeu1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J2SGbBfzUt5vZKI33wHKyengM08B+kxEZ9mokrpAsOA=;
 b=LfEG4FkZ4XKVwB5Xoqt32AMZl6ZXKjWVEdG7kBb2Z4sHAIDjcfadvbmlWwN5jI8hzE6Z4pwULSa2Dtx2H6Inf0HSE9rPrNFCPYMwXTTgT5Cu4xbYMuPlveJ8gy+7KuEI8P+jyB4nspbQ/q3zj18H4z6DgMDLaXHDN3Ngz/nS/sEUSloFLF9H/I0dRM9A2kGJlPkxsnsexMrz1c/F7b03OXvvIEKmwVGaDZn8MZ4ySIIB6bgNmkEce5WxLgGNhLZ88aOiQnGDp9HjVQuOEF1BAC+mAGYw7YoOvhiwV4J1s94FK1zV1MZO8Y5EkwK61Osu/2KFnwP2gC+JoulFGFYYBg==
Received: from GV3P280CA0016.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::26) by
 VI1PR10MB3631.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Wed, 14 Sep
 2022 07:34:19 +0000
Received: from HE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::eb) by GV3P280CA0016.outlook.office365.com
 (2603:10a6:150:b::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 07:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT101.mail.protection.outlook.com (10.152.1.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 07:34:18 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Wed, 14 Sep 2022 09:34:17 +0200
Received: from [139.22.106.123] (139.22.106.123) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Wed, 14 Sep 2022 09:34:17 +0200
Message-ID: <fdf89bbb-fa06-7920-62fe-0b4b151eb63d@siemens.com>
Date: Wed, 14 Sep 2022 08:34:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
X-Mozilla-News-Host: news://lore.kernel.org:119
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP kernel lunch on Thursday at OSSEU
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.106.123]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--9.579500-8.000000
X-TMASE-MatchedRID: oDjc5pbq6ZRFhtKHemq9opMS1tg9L+WMCnwTJQGi1HEd26DGgISeqsZi
	egX8JN5laQKtJ+EEdCSjxYyRBa/qJQPTK4qtAgwIzTcc1ZfI01bQLWxBF9DMQQAeX2eeAFW7Kra
	uXd3MZDWLaw5NgA+TJRzLDIANCLMBfkwfx70ZZ6V2AaiIO6vy50E2/n1n13Qh
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.579500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 CBEB7B23C500F27BE884F72A1DEABB4127BD7C42E826B214E4D253BFFC80153B2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT101:EE_|VI1PR10MB3631:EE_
X-MS-Office365-Filtering-Correlation-Id: ac76afed-9d90-4b75-e7bb-08da9623888c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	I/4ZlB+PhjP5/JLprC/TZhW7Vwr2zy/oMzRGJmk1oxIPFYZy15w7oPtQHarjyFGRVSR6Xs9aAWPzx1oLt6FZdYHiBE10BLbA8UHQDRwBmSocpOajHMoKRm0o0MyjJdUWvikwNX+mgvLXA/KTbfKclbBl4oCrK7Mpq5gMV3nMP2Kc3omEXo3QWEKV81kWtfJgVO/oGGG6YHGjAgfS3NtXCimvSeNoqTz5ywEerzJ0ILI2e49rxDjWfWk8EDr9erZbafJOu1zYxNyA/oF2NhkYLH7o72Ea8JZjKHcp31Ex8VYYb6qv2JRXtxdZfBYiQ2ik6VpChhZ8TBQ9Uj4NDF10QVGuubJsXhjOgey0pjS1g57ruJhXBVTt4DFUTS1ihtpOlCGMQE+pbjc84DLtDf9sImvfKSEm+0L2nJBE9UXoATBJan8/T0E+tOWwV1P55PdPDORBE1JsoDO6hrUdG1toepsuVPU0W3SUIgK5Wz+9Zb4uII86FIuE0ZMA6OGunLRmLFvzd+4UTNljttG//BVQ1MJIW1Tr6ZhV5gWNhEo8rTD4Or70ybQI69kql5pqTSzFmNMEOGcNebPhfTRt/qKlqWoozw7QxEvci+/anKxClB7GjzYuiCb04xPxL48csZ8Op4EidCZKbCeNBD6PXuW8NSDcERhseeNsR/O6r/PoDy+mkiJI8iuC6jT7Baot6baF0Fd9B4+7rRKeVSBFMVHWa6yG/VUHseXF0EDBkG2Z0CWzshzgqjaFa7UKpq0xsj+eyYJC4CTDD1yACHRbs7v21rWK16Sk3mOuAM4z0M86pdnmZE9AHbxLLPRkqMK+0bJf6nZIePwytH86PRU6yrDxsdnQ/+nbai2JeJw6LyNZLwQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199015)(36840700001)(40470700004)(46966006)(40460700003)(6916009)(36860700001)(16576012)(40480700001)(5660300002)(70586007)(356005)(47076005)(956004)(86362001)(44832011)(31696002)(81166007)(6706004)(70206006)(82740400003)(8676002)(41300700001)(558084003)(8936002)(26005)(2906002)(82310400005)(478600001)(16526019)(31686004)(316002)(186003)(336012)(2616005)(36756003)(82960400001)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 07:34:18.4366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ac76afed-9d90-4b75-e7bb-08da9623888c
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3631
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 14 Sep 2022 07:34:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9493

Hi all,

if you are around at OSSEU/ELC-E here in Dublin:

The kernel workground, means those of us who are attending in-person,
will meet tomorrow at the CIP booth for having lunch together at 1pm.
Feel free to join us!

Jan

