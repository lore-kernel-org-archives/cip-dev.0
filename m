Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 091BFCCA47F
	for <webhook@archiver.kernel.org>; Thu, 23 Jun 2022 07:01:57 +0000 (UTC)
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
 (EUR01-HE1-obe.outbound.protection.outlook.com [40.107.13.52])
 by mx.groups.io with SMTP id smtpd.web12.4493.1655967714846299292
 for <cip-dev@lists.cip-project.org>;
 Thu, 23 Jun 2022 00:01:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=iM2Vj6o3;
 spf=pass (domain: siemens.com, ip: 40.107.13.52,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V1nc+wO6vQgc6JqR0mPrRgpKxTAqK2ZOvXgO0TKhB28gDjmdUxOAUnacPJRkuLm0EYwd5I75lVZHYUhYecCfb44x/tPm9qYjycckKFQ15cH1WuHD4jBIH7DSfkxZaxs7hY8339jH0e4zmHBNOnEaiqd2BmQd1XQXg8QXhIbWHYQQHUIhMqbBttO1J0Gt5KYjK29jc34qzGmf+nix3/AueBXtVNqa+ANE6Ij9BZpKm7IrjD83W4wAuvBMvdI+xgF8BOtxMcJlQsZXYRRQWjAqqC13NruWI+uxEzv+UrxsUk7InXEZWC1cJTQFVP64ynIohlivOKVBJey5xm628XSq5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5UUNDY54gP9jg4om9qSRLRyTDnyE6/gn1P0d5Xz7V4=;
 b=NuwWDjZmby3stnzRF3i+hpY7iQHxenLutrcQTh6U6f5Qd+P27D+/Pcin6nIHyQS1j2xSTLgKK2Vb53V0t/OvWSFRBrjuhV3vTgc7KIXqHDWL2nS3R98ff5tmHC8zhnYXoag8zdK6de7/iBQnpp0BiCWFtc3F++wN/mRO9wrOVyJDR0x77MZU41Uk6qtp7vTWOcUr1dJi14I3leOU9JZgNicbA/ZQEeiUbZCXx7FzRGDWmmQnP1eTv/JkgEifUubk+hRiaVP/iGCwSpgcpVuxKLrAj0kfZTpip74lL0nA7DztkaF5ESsTjbSjdAUvMUhBFFOe2j8uqzOCJYHL+i7dnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/5UUNDY54gP9jg4om9qSRLRyTDnyE6/gn1P0d5Xz7V4=;
 b=iM2Vj6o3DmS830ffirjiODC8ak7SXuUoy0XOg1yL3iBGsyYedGTDfbbT+I/m0TLhr1TRkne6I9U3o0UTIXJ37bm75a7AImR0lEjM0iXBpMWGlZj9cYhI1BctI04w2Ey4a+fHpL4/YTBzg1SLJe7WoJv2HqVcmXVIFxz3tN88/qvNp/yNenjPimQ2sX/M/pg30fZQdDs4GxCWMGBKC63YAg6+v/UJqrSzwoBRgvI2lPNBbCH6I1Zy90ZoJLOC0g4wXJ8Xkn07OK7ffQuDYu3sbH632QYOSxMAADlHquRKMEWPOr3IOE0ZP+mL70tEX5wNJQ2PpooKeJudbw56xy9AfQ==
Received: from DB6PR0601CA0006.eurprd06.prod.outlook.com (2603:10a6:4:7b::16)
 by PAXPR10MB4897.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Thu, 23 Jun
 2022 07:01:51 +0000
Received: from DB5EUR01FT067.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:7b:cafe::dc) by DB6PR0601CA0006.outlook.office365.com
 (2603:10a6:4:7b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Thu, 23 Jun 2022 07:01:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 DB5EUR01FT067.mail.protection.outlook.com (10.152.5.198) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15 via Frontend Transport; Thu, 23 Jun 2022 07:01:50 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 23 Jun 2022 09:01:42 +0200
Received: from [167.87.6.167] (167.87.6.167) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 23 Jun
 2022 09:01:41 +0200
Message-ID: <f555a982-6a8f-241a-e724-43b594426b6c@siemens.com>
Date: Thu, 23 Jun 2022 09:01:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.6.167]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.680600-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtrrXu
	yaLdFR2N9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4inZm/Y3MNbKgYWo9dIuk10AkgXPI5D5JuEk8h
	agIbaGmmyiLZetSf8nJ4y0wP1A6APkvV+z371TK5MIx11wv+COQZS2ujCtcuA==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.680600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9C90EF287AFAB7A0C035A05F21CD3C009020DFD2076A8036377B1A1742C4A2C82000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7c7a79b4-03bf-4449-d433-08da54e63f34
X-MS-TrafficTypeDiagnostic: PAXPR10MB4897:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB48978BB05696511378D4FE9795B59@PAXPR10MB4897.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	TTRVKyUrN/Qv/cKXbkGbRhxhcDqric8RSGKJLk+bNYWpo92sEaIjxeaaUE3sNFiCw9sCseYlGZizdLg5k08Va2z+yal2WjAWU+vxu3IOTKnwGrbYH2eLdv04S6SfCZMgpOpxxEvh/b1cIJp11KeQk5zt4ktmTQGnrevI0CO4jrzIgdK7BkE6t0PVzdo9Qydm5i+RtO2F7F2OqbwNG4MWtxONI713wZFN8+pAx4wuQv8EfiARQHM5NpOV5MMiNkjqd3aE/IzDiNIuP68AcqVS1+GOaj3MdAO8VEft8nu7zNRoi66hAcocuME+pg3jyIddi7c+XocKgPFyI19Gm7+eWijOxQjy+8ni9yQdSMLiLQpvztk1SGbeJAuOEfpEx+Pexa29KgolZ5uHtBMlmj9bDWI+kL5nUzz5UszTNLW48OMSdC8+O/xe12BbSo/p6IsxxYGCd/XZZJbL0EcusdkpvxfiQ/3UflcdK67u/+i2zX3z6/zkFC5zI6w9+Dw8xJvbLYfKqpuZGm76TvYmrfu45w6iT4TW/8Y1xOi5dqFmXbg04f8W1b48D2HL6hMbKLP+z78RORW4zaPRrpMxqkgeHgSUAGJWHh/kVS28D8TEnc/93z7nWaQ57rkJ3L93gDbZZgbAj3jU9zYbxHNuEC2Fv6M+KlAL+iG0qCyaONRkpmTIpqkeOE+XbMwnfr6f6GaVySV0VBnuU5tPd3QpNllrFndtRVsWfJ+A3k+MWozCU2csvFjoiSX5noh6ng4R3+dqzXr4lArSeUIqHeU4bcWfjPDS+1zvLRFlooLw5ER4RW5EqDnAVo4UyYlWBmPttXJOxbnkmzh+mDBIJDFqHqOztjdffikPSAwvS44lVjnjymuCVplmFqkPHFIQNK0LuufY
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(26005)(31696002)(966005)(478600001)(86362001)(8936002)(82310400005)(5660300002)(4744005)(2616005)(41300700001)(956004)(47076005)(336012)(44832011)(83380400001)(16526019)(186003)(356005)(36860700001)(82960400001)(82740400003)(36756003)(70586007)(40480700001)(6916009)(16576012)(81166007)(6706004)(316002)(8676002)(70206006)(31686004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2022 07:01:50.4896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7c7a79b4-03bf-4449-d433-08da54e63f34
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT067.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB4897
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 23 Jun 2022 07:01:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8585

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=6&day=23&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-09-12.00.log.html

* Action items
  1. Resolve/filter irrelevant failures of KernelCI for 4.4-cip - patersonc & alicefm
  2. Check cip devices on kernelci old pull request - patersonc
  3. Update https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware - iwamatsu-san
* Kernel maintenance updates
* Kernel testing
* AOB

Jan


