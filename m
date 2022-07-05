Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52389C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 14:03:09 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.42])
 by mx.groups.io with SMTP id smtpd.web12.84515.1657029787027704873
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 07:03:08 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=PbEyxW/k;
 spf=pass (domain: siemens.com, ip: 40.107.2.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fl+t5c/5pjMcoarrDlYA1NVgKdBI1/NnO6jf2ilDh3hlWnBA/qMVhUPIwkdWwB+FnXS8fjF+xlRFx8lMbdQyCN+RGSVU6fV80MhjmKeBUNNfqWSb2LAsGrpqgz67v8yf1liBqbggtfViz1N6hklriuRpUyTlywUm+LhyoMgvy20mXu2TpTJ+uhA5BS5AK/NirMxZ4cm0ZOdtcZ6IXA1Qj0xQWNUa4ewWwCJs/T0THZq1HiOd5eu+s6CYUGeeLzCFKjEJULAPqcGbFwtR2UY33zJ77xNK4fdFXqJ94ErBwcpA3pE9CZQKTWMGXxFJU1m/RpVmQ56dK/72wKNvFZ7Sgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxHK6uPqYUZSRFRz+7eSx3AyQo50iZ7u2FN0e0yU/x4=;
 b=WhXo1z9eE9oIg7CakTvNtFdrAlIt/5Qg0Vh6t22ymMN4LZDOl0WbEGsALSCG0NFztPAlUJ9hs137bdh2FbhXEVDHv7fi8OrofVQjQFd0OGuPzj2ISqrz9BRN4s6VKzSJj6qBUCijMGY5Y2IQHwbSTybfeSRKm1TuqVQBy/qSST/Ko6YDLKRcq4G5G03utG7TYBcFy9Q49NOZjihDmdPQ7w1Ae3Qs0N+fZNW8Dj474Vsfu15CMO8upYwdj2RQFxZF16XcO8fuvRd4UthcX2peSyGTqkbkxw1eGuESVUJzMayzqr6IWGTgviD31/GSLF8AOb6LMCm393DtT5SiMM3++Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxHK6uPqYUZSRFRz+7eSx3AyQo50iZ7u2FN0e0yU/x4=;
 b=PbEyxW/kkh3UOdgrf+ieckElXnpBzi3GK3yf0o7t53BxitQMgeGz7wzNzr+pGLh2nCBKv/wKjSBMD9wLoLtI3U6Yc4eji5VJKJKZKH4qv71FLyaMSBEyQuPTmnj3hkj3PiC1fjfScazHnjfjhnH1tXMFB9Mese68xufi7Md21+i9ybdYG9eV2HzqGAYl2YNWFEEdYjBeIsFOe3nOzA1uWZZwXZv/P13icH4/bVW3To/+QsNEgVycj4eraY5ApRKIzv1KP8pZhQB5Jf8mBtNAyEVBGN0fmUxkmNCM08eukIEjp2aWLUIBgRzTQP7t3JmkbEhCwQFbMZPJgXyAt1gghw==
Received: from BE1P281CA0065.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:26::11)
 by DB7PR10MB2348.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:48::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.19; Tue, 5 Jul
 2022 14:03:03 +0000
Received: from HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:b10:26:cafe::ed) by BE1P281CA0065.outlook.office365.com
 (2603:10a6:b10:26::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.8 via Frontend
 Transport; Tue, 5 Jul 2022 14:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 HE1EUR01FT052.mail.protection.outlook.com (10.152.1.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 14:03:02 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 16:03:02 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 16:03:01 +0200
Message-ID: <8742d63f-0f50-e327-6fae-204c9b89448a@siemens.com>
Date: Tue, 5 Jul 2022 16:03:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: cip-dev <cip-dev@lists.cip-project.org>, Nobuhiro Iwamatsu
	<nobuhiro1.iwamatsu@toshiba.co.jp>
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: qemu-arm not working with 5.10.126-cip11
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--8.635500-8.000000
X-TMASE-MatchedRID: jkuY4/1TzJBZL1+fxYfJB4X5VsOU7mfTfs5hB+q5V/eejeo11iW0N0oh
	bZMxFXE6aIwFrkgzXvZcwuidjR/1ECvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt
	1ofVlaoJlgn288nW9IIghcpGUPiP65MIx11wv+CM7AFczfjr/7HGyh4RbRpoIQmO+vAFJpOgQAC
	hlz65+mJEnmR/UFrMsinD8FQOt6PM=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--8.635500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 6E91B1834D5F100FE827E05B458EC43C64DE2356B8A11EBF232597EC935482A92000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a555711-32d8-4943-06bb-08da5e8f138a
X-MS-TrafficTypeDiagnostic: DB7PR10MB2348:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	K3IDH5d+LXMzBmbtBb1bEBPZUsaqftrYj2VEhRDYPkcPlfEFI2t0/EPktMx1ORTH5XApp6cIMEhUOd7UCUpebv5q3IlEaO1TkUSZa26SM4KABQcr0DJHWR9NlU5iINiiDNIwiMPhJc8O6Rgd1I/0AvJ2t9LEfrk676WVtsU2z3XclSHY9FZMJNTq0bl9ZwYVwN5B9GULZEkJXTf5ymQZ3tyvMooEtfNpdFL2O9+5mz0ipGH7eYegc2T/cSUI8TpWwmCJ+WxvcDfT7kvxYmMZXS6SaeeLhx8hrvqlAaDjHDzXM4j+iNS0tt+nSQi1QiqrbaEtfMJvz9TbQZALgtISCYHCtW2UMrL3H7CFR1zdzZT5BSdUIKY0bwIoO/lp+xeZW7Lm0yBu6r9b0hbQkSIr/nBJHlq8O8aUchnW5J7WOcBQ1doympLHPEIiYRm8Y0z5ZoCvmmCTKRM8K71QEfMDQeGXBBAYPwdqf3NzwqL0NX8xpvKIUfceGrPI56FcR/AyKEPS4aMRm1UGcE6C39LAkbjUl5AmpP6+7rlKIGAwNcQdRbZnJiIbycvBuRH2fOlYQCkvdsTCgRkUSSKXFFf7dt0H9N7X78iHwQO2K0vcw6aVDt7adEjMjT4a0ajyRUlU9Zk3EmZYt76o6PI/a888FPZBaZrx5vHLF9akE0TLu+YKdvg6s1vkr06T+4QqmMhX2RnFmb471i301dXDC7lu1WbyrCZsaCkiGRyQwcxlk3yWYap/fk5k4h5uM7X8Z00t80TApGRtRv4+09yt33kkMQaYqD+4enBCf2EKkyGABCILCI1YSO/J7497pd9YnFslZcX+rxRllmNQAj5bZE7pggKGMD/Fkd/TKCGIsezNAImiBSUAHpPWK6d5MTuzo3v/V9HDjUfeivEhfR1BzMep2+TgaYuI6nRpmwfLfjnt7Y4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(40470700004)(5660300002)(8936002)(478600001)(31696002)(36860700001)(86362001)(40480700001)(16576012)(44832011)(82310400005)(316002)(36756003)(31686004)(356005)(40460700003)(82740400003)(82960400001)(26005)(110136005)(6706004)(2906002)(2616005)(956004)(47076005)(336012)(16526019)(186003)(81166007)(41300700001)(70206006)(70586007)(8676002)(4744005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 14:03:02.6712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9a555711-32d8-4943-06bb-08da5e8f138a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2348
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 14:03:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8684

Hi all,

it /seems/ (still double-checking) that there is a regression in latest
5.10-cip regarding the qemu-arm target as built and run via
isar-cip-core. Not getting any outputs from the kernel. Just rolled back
from next to master in isar-cip-core, and it works again. Any ideas or
similar observations?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

