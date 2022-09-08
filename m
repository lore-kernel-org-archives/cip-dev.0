Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44170C38145
	for <webhook@archiver.kernel.org>; Thu,  8 Sep 2022 06:03:39 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.44])
 by mx.groups.io with SMTP id smtpd.web08.2109.1662617014610368775
 for <cip-dev@lists.cip-project.org>;
 Wed, 07 Sep 2022 23:03:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=BdIlAPLH;
 spf=pass (domain: siemens.com, ip: 40.107.7.44,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImjLVcJ9v0oDugQnzGr0qVztes+qxwoPvSDKKRxfUhsJf/blFzXKwRB6qOuU5y68TNtIKa7El4Q4dIU9E0QPz4UtIzTGCEwnqvJH84C+iW2gX/+CFtjCvIGbl4cBQZvsAOap3TdaEtlckB4lM16apyzZCq7yD14zOFs80T9k23ohXsEKlFyW1hX4dmL7fQcedXH7Iku1laPI1oFQ1N8qrqZCLfNcaQG1DTP1/LzkyotKoM38NCcm4JHvHGZFII9XPfyBWHP9qZvqbTEnFxdDgKbtaFiDs1ascWpbAI/v+myO3vna89Cc38o1zTOzj1R+MgqRtFYZDGi/qSS7f6helw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qqF7wpm1xwWGHNs/agch7wC5gBvQHUVqXlwdIdziko=;
 b=YiU9VuJnFRYrjulKTRmw88zUFVUYaEgQL5EftHRMei/7jinsr8oKEqnOYbw6oj/zxV1Lo1Hth3m/JE/HW+n1eJbKc0rdy1Ob6zq2ATvIPlon8xl38Q/+3kD+uHz5cV51Mq8tTFyR6RWJDXIscQFH7R/bEUB56GEyCU0Fux8giF0SKd13SNAZPyvt+yKKWdtK4N0msO+1DYwZfZz5D8td5VvJBkll/TdqZ7CTeVCMRB7rxORbrINbjuTc29MH0JBRlAYBNe9O1ZLDq3TMQoMIf701SpAlNOIAwrBvV/FgQ4cR0jZsDF+y5MYzpgvqPz4qti45jTGRug3A3Lsy2ft+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qqF7wpm1xwWGHNs/agch7wC5gBvQHUVqXlwdIdziko=;
 b=BdIlAPLH5axlGJjxVA3n/KYHIqTf0j4yCwBGDEUaaHtBM3Mlb4J/+U2KayejEB79XQLz4nViJ/nCUSDctc6kbWRcp4MTDpUGcHfjty1/MaM2juuMonVjts7YeCINqrQWrjnHEHsOLyiC7+8jw0VZcTPdxCQpN7Xt6LFX0SdELri59JYqgSNfARRYGS662kmhmtM+f+sbjCZVbxoHLJCg3ivt14blYk6oANKBBlocfDiHVF+95mnAtm2RhcNRGDjGLtIm12PIHYLJMrgTc9gJGUxphrTx/fsF/rz2k0QseqaUxhdGldIDjSQrmAFJsoTJsmqakimnYEOeyS99PYpfBA==
Received: from FR3P281CA0100.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a1::18)
 by DB9PR10MB5161.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:331::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 8 Sep
 2022 06:03:30 +0000
Received: from VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:d10:a1:cafe::32) by FR3P281CA0100.outlook.office365.com
 (2603:10a6:d10:a1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Thu, 8 Sep 2022 06:03:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT059.mail.protection.outlook.com (10.152.3.127) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Thu, 8 Sep 2022 06:03:30 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 8 Sep 2022 08:03:29 +0200
Received: from [139.21.16.183] (139.21.16.183) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 8 Sep 2022 08:03:29 +0200
Message-ID: <dfa182c7-be02-5d53-4e65-ec9f48f2a6f2@siemens.com>
Date: Thu, 8 Sep 2022 08:03:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.16.183]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.697300-8.000000
X-TMASE-MatchedRID: vIFHZ/uiyj9UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4ijSczs5lmzuE5UcZtwNsCro5f9Xw/xqKXZwhk
	tVkBBrQxq9PbUOwsP9QSFbL1bvQAbxAi7jPoeEQftwZ3X11IV0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.697300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 986BBB4371FE87C1E513694D5269AA8C69A2C4829E7F72E58C20E764D19D979A2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1EUR01FT059:EE_|DB9PR10MB5161:EE_
X-MS-Office365-Filtering-Correlation-Id: 66adf753-53df-43c9-2217-08da915fdaaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	MuJjBADP6m0tks7PN6z3e0NI8ERWO5o1GPDipXV8pspHs+36w2mJ7DE/DTLsT7lPWLGMmjTzvUBzmIZ9YNSR7jiYew90if8iw2n4ZqC7z7c7b4jx9rm17Es+1On/+UYWVE0yBo28Bfj/dFMn6HIayZHIa0s1C5ufTOe7rQ6Qo6J2A1MMz/x8WZIpBRIKnKaLAnTEh4HCn5e7j8QCKWcjqB/9cRbrRxF3nJoshvkdf6vD8pDyBIYzoOFMJU45aey5+zz9opi/zzkR6MVL+NvLVBufDjtD9RTkIIq2GlQFc+L9zTF6tZFnTF92p7v6BZ9sus25kxEsgyJNPU61R3JC9braMV0jCGYQI6pvg9MCTWD1CqmASxZygtdrmi4tubiADFTr7HLz0hVZWuXzT6lLMikrkKCfNSq9f7gJktvaecVniP/aYNeOlYEBT5SkVrwTmPNGP++Pw3/qI0KrttqpNQeJhONfHtHNesl/8yy0lTpr3L8Ls9+TcwBQQKX+H1Er7MJfrtmPpkVM0ralfHrQ5Fk8ahQjeJB0BvTUbREqPnEh8E8ZrtpvsSG6NZkxEf+YvWJGUKb4vTYLEB38gTEsesBj4f28DSPJPOOBkMCJazI1cQVSQ/K8c1L8AGpIbalxgBmpiQAvuhrN0bEEmyyh2iRljMj+tddPZsLCYRZZX5uwaZ1t/OakuKSpPorR5imUngYP9oJuHoSmEOOVUgCt0WpbSu0dPVm/NgqZFmgLrk1qsIe9VF8vB7GlNt60QdvIWZvBr6H2DtVnU3EE7lMbc8g1xXmzv9CK567qbByJCmdvK5pNUndeu+SWze1e6+vj7BcBo3ADWXgtc5tPFZiFKDWYQ16Jti7mYbmE0qJ5sEsTA28VSLITHVsbgBk8/0kmDWuNar1z9Adx595nuj5u2w==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(40470700004)(36840700001)(46966006)(47076005)(186003)(83380400001)(2906002)(336012)(26005)(956004)(16526019)(81166007)(40480700001)(31696002)(356005)(40460700003)(82960400001)(82740400003)(86362001)(36860700001)(2616005)(4744005)(8936002)(36756003)(70586007)(44832011)(82310400005)(41300700001)(31686004)(5660300002)(478600001)(316002)(8676002)(16576012)(6916009)(966005)(70206006)(6706004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 06:03:30.2552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 66adf753-53df-43c9-2217-08da915fdaaf
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT059.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5161
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 08 Sep 2022 06:03:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9473

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=9&day=8&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/09/cip.2022-09-01-12.03.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing

Jan

