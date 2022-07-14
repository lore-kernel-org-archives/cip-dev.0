Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11918C43334
	for <webhook@archiver.kernel.org>; Thu, 14 Jul 2022 09:56:11 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.74])
 by mx.groups.io with SMTP id smtpd.web08.5703.1657792568678360174
 for <cip-dev@lists.cip-project.org>;
 Thu, 14 Jul 2022 02:56:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ZHI/58e/;
 spf=pass (domain: siemens.com, ip: 40.107.8.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=htHvQPRYLwK67pMIabx4NoiwPhaJg73Gfc+Y74i38ZZ8tVh61BIGycWX/85gu0u8WYgqleeaHqGdzOr/OpDJx61NFNDulQvs6LXLlVEWGVkSNQ+po+59H1JrDOpF0cAXu3y+9a/VQAAI/AJfms6T2NYLiHMQzlapjX4Eljlc/uAg1ca4gsgaC+jCWn07wjlNBwYu6Fn4H1UhTBlSTTYpy2sH4VbMyorjGJ7uefcMep7Gu1TA9bqvhPBWjYaa/V6m8udviRtB+llUn2gtto8rS20xfRZY/sYVlecjSHAmHaWDzyeDGC3So5+k0vLloNIFXsf/ewVkhQnVRtPyQFfj9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMJWGKIJwg98XiycdawRPovFBxiFFrAQtvkiPdiiPT0=;
 b=TIUiC6v31C1Nht9LvGHWHdh9zr9giiegQ/yC87CfkKLG304Ngpso1ZaFJvKo1WNiOzjd6/5LjVNoCM0cFk6OEzCSGcxf/+nksBqL2KYjKSEOP16JMBysg6VRwXcz5sK3rbqMgIjZ5ga2/JRdjWQGVAeWZD98GvSP55b38Cl9Kw5XuTDZ+p7pNAPm6exD85xQwy5eZZI7K2pFJ0hznnAvaWzSpzZCA3yuUqlQc/OGc47Vycio4Er2u6kFmZ7SfDa0Ycfi5e2zaO0BBoqHfVUPtH66G3yLdp4K9qz7Wl8gJI7PoMpMKu/DWCuOuffD1YDo8f4t+VKBCWkLowKcmnH+cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nMJWGKIJwg98XiycdawRPovFBxiFFrAQtvkiPdiiPT0=;
 b=ZHI/58e/d7DQhVwvzi4HNQy570WV599wvytrQ+nApc3Bt9hZ5rqNBKEmhDxxbY5DXirr0l6dO69AlpF53l/MbItnxQ3GDi4EXrOM8ADFIMA07in/dNaEhJu4n1pZJ5uwIsZh5Wun/H5Mhvg75FwVdSjsKI5/T03gRu997gICFmOwW311e2WwYLCkKS7OZxxCyy512Sf8Hh0pTOjKQqf+n0J144dJimOybegT426tufk8FMqleJo1oKCTniqOzY/y29Z7sCQp1iWJb6PulrpYvCNdir5ibNgaAosf4HWBkqmEXhEkhg8Y2CTDY0MimCTIR8CyzV7YCv6b+6aoIob6xg==
Received: from DU2PR04CA0322.eurprd04.prod.outlook.com (2603:10a6:10:2b5::27)
 by DU0PR10MB5533.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Thu, 14 Jul
 2022 09:56:05 +0000
Received: from DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:2b5:cafe::af) by DU2PR04CA0322.outlook.office365.com
 (2603:10a6:10:2b5::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.15 via Frontend
 Transport; Thu, 14 Jul 2022 09:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT055.mail.protection.outlook.com (10.152.5.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Thu, 14 Jul 2022 09:56:05 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 14 Jul 2022 11:56:04 +0200
Received: from [139.22.135.46] (139.22.135.46) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 14 Jul 2022 11:56:04 +0200
Message-ID: <13c7d15f-9e3e-82de-a569-3cbf91f51303@siemens.com>
Date: Thu, 14 Jul 2022 11:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
CC: Pavel Machek <pavel@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.135.46]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.921000-8.000000
X-TMASE-MatchedRID: kxpaLTp5p65UexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwLVV9elkcNTqJtgtn0dnvgcCC8
	zqHvcG2pLfEy2DFePtEANTSZ3u3Xj9yL6hHwS2FfimYUTgbSLu9bSh9CO8PiqqDSBu0tUhr7qoF
	akaELIg1R/ptYWR8C7kIIyy3OrsT+LzNWBegCW2RYvisGWbbS+No+PRbWqfRJBlLa6MK1y4
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.921000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3C341557293E71787C00543DC67454B6312A824A1EEA48F17A227D6A237010612000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca416cb5-4df5-491c-7be5-08da657f115d
X-MS-TrafficTypeDiagnostic: DU0PR10MB5533:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	mAFvxIKKOkk+Lny+bhUInVqBzyWt0uq+32d7tTmP2UM9+j7ejaPH+lF70vaOelVrOVU2tvI49u1p+G+yuHZebA0xJNw8/ku9GAknoFrbxZL7iKheYn8gOAmHS9RoTxxkC2tElC1NFo+83WlrDrvnkpwQ2ALKF3xuolrGAOdQ3uXYUJlczA2s0jkG3yccl170Nd+pd3/ogVvt8yFIlLA4UnaNTobwlnlcJCfuhi+TocWzjzxGwxGQiIHkCtmlI8iTmuTEDB2M0uH8ksl2UvrRFP6OhnieBD84pXQQRGLouYmWukb2cSNj3EyHa3GdaMP3z7fdnG+MeuV2HibqJs7kPQYzCyhtb0caz++HjopaQirBrGMt5J/07JjP4uuz/yX0ud5fd8MIyD8r2RSQqlLQiBhWVIAdiA8EiwIrbYEYGSrxWi96+aXUHigSFjpkOIMCpNOmVqoH2/mAQaxEa9LqYhuaS9IQOBhEvOBlAkhCDpV4MG2xYskbhOU+ociT33tjijG8MOkrgrWsOjeReR1vsxsfr2OEj19T6FH+RD3t0BIgpO3Zv+HF84awlLvaom+ArJCrA7PNAs72StgERf0AwH8aInXPmdGc9tQ63UgfomPLRzCGac/MD6T+mFo8iiMJYqRudk3oGpAQaUOHeet8L7FZs+B2PR5iZ/JxCpHcn+S0ii1vkegc3VCJmYxL55Qp2p4BkG1TLAQAFGo7MeFxCbuyUHOhA99Z+czq0y9lwk7CrmsiupIabRYjS8Glf8SaPVJ72t/5DF/9cZqi9CjKe0U6moRY+P/uqiBZIx2mtYvqXYSXXOffLBO+ICsSZSaqSCzZZMFWp+3nrYZKrOxETdM19zCkeleWhq4r3P7AKNK3m/0mPnch8TE2p2ftChHDIR9xszWcP/GKXEPbkNNo18AcoCekD7LyXEoX6J7IbNmDszW5lhIiy9Y/iRPZ+nST
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(40470700004)(82960400001)(316002)(40480700001)(16576012)(31696002)(966005)(36860700001)(82740400003)(5660300002)(956004)(6706004)(36756003)(6916009)(82310400005)(31686004)(8936002)(356005)(86362001)(81166007)(4744005)(336012)(4326008)(44832011)(26005)(47076005)(40460700003)(70206006)(478600001)(186003)(70586007)(41300700001)(2906002)(16526019)(8676002)(2616005)(83380400001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2022 09:56:05.2199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 ca416cb5-4df5-491c-7be5-08da657f115d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT055.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB5533
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 14 Jul 2022 09:56:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8756

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=7&day=14&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/07/cip.2022-07-07-12.01.log.html

Pavel will run the meeting this week (TIA!). I might listen but can't actively participate.

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - ???
  2. Check cip devices on kernelci old pull request - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB
  - I'll likely be on DebConf day-trip next week (21th), will need a substitute again

Jan

