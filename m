Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32593C43334
	for <webhook@archiver.kernel.org>; Thu,  7 Jul 2022 07:41:23 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.79])
 by mx.groups.io with SMTP id smtpd.web09.2961.1657179680730146123
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 Jul 2022 00:41:21 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=vCExIEGA;
 spf=pass (domain: siemens.com, ip: 40.107.20.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9QPEUlbfUCUIY+6nLNV2ibBxI5jgLK0gePg9HAQhQoeIf5bWcP4Ruqw2wcU4AnSc9PLOyR2gv54PMiNhPqvWG+pb2Ch7X6kLH7wjieL/h9BFeretBRMgV7qU9LNe1DH2ldGcVzKCnTQVLftFjsL63j14mlHzVl/WGVeWk3vwZWAeddCHuozQheErt1+Y4EQBFfPcyZlp3tI1F6zUDQbRSEoVzP//5x6/qtga4i1V7ngpnaK13pg8zNkI+zcFWz9NkxSKJMdMn7DAEmdeNMMplhtofYjmhZWOUwLDSAPUGXZ7g4MT3EosdFGoFz1wYR7vvwhGtARR317T+D0/bw5PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fl9+SPqySfbS3CvWPx9fH97fHGKIkJss8e0HBXnhXJ4=;
 b=IrHG7M9aSKM+nzUyxDdu4t13z9ihqTQVm9x1kwCgTQgiZZ4KUDwjyOn4P62ceuGh+NmIifrwDMkPfuNC/iMy0ObkCmGJWH8jJ5g3qZizRGrDh1RkLnki73+wWyrX+EywiFvEwWLKS0cy2OWnf8mzRxcCZSqNOSV4eY+IbPJnsFOY8/9QsApW/zdB6FMVoYTxhNlN0V1UhmndHiCSfMyHzTEWcsl/tpkzt8VbShxv0OYq2e+ExsRRTlab9eBJ+JgsdoHo+T8lD72h/+bhPLWQlrHryO6DqS+nGkOggrd3ykNPjeHDaBnbZg8jd12yDCIgGLlIqJtTz9eO5MglTLkA4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fl9+SPqySfbS3CvWPx9fH97fHGKIkJss8e0HBXnhXJ4=;
 b=vCExIEGAh0sZlbEZm65Iy2jyURVf+aa/MlG/jeSBG3HsCAS1KTbFvvXRpMspUlzqsn/97HJAfi5upj+Qtv4b6RL9Bi+eLdY3rAkHgwZwuXzGQpCb1uQxSdiSf1gWrdZb0W59X0/UnWtC7KNqcTpiv8HhJ+CIV6z7VcVNVGSr6bD1wL0Mm9TC0kwbE/2XeL8mhZFGxZdSC4cTY3s9RW+idz+wvxlOm1ViQDKsXQdpoRFGZEQetWaIriINpaEeRzwwslgBltUy+S65pxzF35fE5Erjc0Av/s/kvluTfgTvhxWpUmHuLy4CCcmBcFk+wdNyENMT2yPu1nSqGl6XcZfGSQ==
Received: from OS6P279CA0037.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:32::8) by
 DB7PR10MB2412.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4f::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Thu, 7 Jul 2022 07:41:18 +0000
Received: from HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:32:cafe::d6) by OS6P279CA0037.outlook.office365.com
 (2603:10a6:e10:32::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Thu, 7 Jul 2022 07:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT102.mail.protection.outlook.com (10.152.1.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.16 via Frontend Transport; Thu, 7 Jul 2022 07:41:16 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 7 Jul 2022 09:40:41 +0200
Received: from [139.22.133.252] (139.22.133.252) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 7 Jul 2022 09:40:41 +0200
Message-ID: <121837a9-39ee-6c26-6ed5-fcd56b18bc2e@siemens.com>
Date: Thu, 7 Jul 2022 09:40:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.133.252]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.801600-8.000000
X-TMASE-MatchedRID: 10+ctCQpgSxUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgtp1Nv
	bGpMw/nt9zZd3pUn7KDjzqIHW5M3lGW+hnAtX4inZm/Y3MNbKgYWo9dIuk10AkgXPI5D5JuLqoF
	akaELIgn6yJSmANM6ajxYyRBa/qJQPTK4qtAgwIPcCXjNqUmkW8QIu4z6HhEH7cGd19dSFd
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.801600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 A5A6147F0973FEC6BBCCD80C7F381EB1635C5A0CD0D310E4FD78D9A5835B1DED2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b060b7dd-2ef7-466b-bdb3-08da5fec1371
X-MS-TrafficTypeDiagnostic: DB7PR10MB2412:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	4WE6awkQCjlHmqtUoDJq7SYIQyUnbuTSPUr0GMYrpVMjfJkgGT6AQbO4e9h22Wu47JGhyT8yRNNtrMOFsGfQdtS00zb/6J/WA7dhgIkGua54GiDbXtVKddPnXKP4RSWDTN48Ec6xbAJgu3MtGpeORuTgJG6dTxVgyOOSKuQGQ0uPSmS5VpgFgzED1ABpL5G+6ENQwKqBI2djWBkHJIS4QMC5vmeKEolljfrKyu3x4ya5zCZCRPQnw9vP9Bm1dCGg4z5/onMyzwGwt0/jD9qz5LL/p/rQ1jEe+DmxKJdhk46y8/eachaQ+evRFcAc6XareD/PwI5RFgkKawm6TGtbpBrTXg1fVxcrF2/7M5L3h3U0QbMHvc7OEojz/h9WZIPfSjNeISbSgMw3/LlgWr0JlFPGRnIPTcdOUawl9NAeEDDjE05onk6X5vqmh44dyH7skAd0CASs289TaevEOcURWcWWPp79M3okqWGtzrxcX4VPJEJyrdm9Eo9qY0E3QsKW4AHSfRJmQLlBXTi/Ahg1Qgcg4j9jkRTRSqByr3ZLCHlaLVTGQfmi59ASEWNUNsQVaav5DyO0TAE9Q2C+bhLKjEASQFi9d/g4mnhyMuQjCGjaNuUGZl7RWhTpzu9eJCYJOWdZZyTPGSN9gNOfKHdlmggFdYKYUn5cf3Jz3OGNa6MwYyg9f7AzJRlFK0VQiZ+A2H3nb1tvwq/IAW9uTQqVC2U35BaNi80GUA0pris2flyrNRlJgazCIweGtoUUOgFNyZeZFmTu/mz4Cr2BbKWW6a9+2J3WyU5slpcOZJhl3SGBCYB3ffyqfjVka++a/hqpdyFFT1FhRai+sJSPlMBRILJQJ3wS6ROdJu187aUL7Z5pOnJ2GXy0apD0STdf+jSdyaav5NGA3RtSR3alCEhyGam3RpjoY0jZGI9Dh0fQ66BSN81AM9hOJk0em70WzcKv
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(40460700003)(31686004)(36860700001)(83380400001)(16576012)(6706004)(41300700001)(36756003)(4744005)(44832011)(8936002)(86362001)(6916009)(5660300002)(82310400005)(2906002)(40480700001)(31696002)(47076005)(356005)(82740400003)(186003)(70206006)(70586007)(8676002)(16526019)(478600001)(966005)(316002)(82960400001)(81166007)(26005)(2616005)(336012)(956004)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 07:41:16.8707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 b060b7dd-2ef7-466b-bdb3-08da5fec1371
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT102.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB2412
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Jul 2022 07:41:23 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8714

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=7&day=7&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/06/cip.2022-06-30-12.01.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Check cip devices on kernelci old pull request - patersonc
  3. Update https://wiki.linuxfoundation.org/civilinfrastructureplatform/ciptesting/cipreferencehardware - iwamatsu-san
* Kernel maintenance updates
  - status 4.4 releases
* Kernel testing
* AOB
  - first thoughts about next cip-kernel

Jan

