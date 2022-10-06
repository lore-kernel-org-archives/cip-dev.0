Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AB4C433FE
	for <webhook@archiver.kernel.org>; Thu,  6 Oct 2022 06:23:56 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.59])
 by mx.groups.io with SMTP id smtpd.web11.2672.1665037434587392795
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Oct 2022 23:23:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cS43Gbjl;
 spf=pass (domain: siemens.com, ip: 40.107.8.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gvhhtbEax1NPdrq3lzX3T9xYh5nWy8NUH3sQYV97Qv9V2xGkdGODSgz8ge8sxc9OQt0sCLQBqo1UaHd56pz8PSjKpaDkjHRu8X3F3LlRnIS+GhcPnyIOxLBv5JvKzfvk3aaWMjxdA+QeTgjmnwckeVXGv6TdandzRT0TxGgDZKRyyq4yjytNad6LgEsB1jStdL5nX2M0xel7rBG+V7nRF/pSMPg1DGvMzYjOp1tFkiWLv/61X9TlovlRHAdH5CqN7vQxGIfrLDF50AsYjKtTaFTD++pPRl0Dju3ciB1E//Kvwj5My8N6jG0R1BGvOZxMslQAq5zwAc3m0epSjPVZ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H/QABZOiZFD75+7SnpYY+Spb1myxfdzitTSbjRMJzqs=;
 b=WFMpmpHlFuUnjDJZEspv9aB7HEUDCYM9aJ9K/od/AknBilBGocdS68pYY6YMmOPD7E7LL85pE9tmPb00jyET+/pZBauLa5c5hSVaMCoEOdkcLItV3ny35ZgIAQRe3aohSpHwMI5tvlZelAmT35sHOrfcvkVhVjhK8Z1LvfYLdK/+SUBuWs3F03IFcm8Zux1i3hvOr+xM8/FeW7CMs4hartQADpeXBDc0SmDxgLGUKduzIPsf79qbP1WM4TYmfEScV0hpuqjebdw8L7FuO4ukKIyqlFir0dHijVF+lITfWYsBztMfSSNNSOQLwp99ySgJZIKAOVLk1EtDTQ7UoaqY2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H/QABZOiZFD75+7SnpYY+Spb1myxfdzitTSbjRMJzqs=;
 b=cS43Gbjl2H//CM4iV7LjIi67Q/Xo0Xl/Hfb0PwopmLSaOuR4rmAv+soGpuHPyLPTriwEmV+gvSqO+JZL4lqNDGf6unausMUK82VF9RmAUqG/OucRtC8cfIQzOcFGG3CZekKzLa1fPt0Fre0mUiAczLuXw0MCm633lvrrb0JL9J5DvBNy0Trw/SmGwlCDzgPbPg1QX15+crgR3Iqq5qyN8KnY6TNFT/v6oulPMojakU3kC69f5L8Ko8uMhrxK+5IRGdxl5osa0n5KZiNvcMmE8IwnSuCtvvhCYt8L+uj/sBwk6Oc+qP7JSyjy6p6A9ZqY6vXz0/tmbeJtD7Ai+D8T5g==
Received: from DB3PR06CA0017.eurprd06.prod.outlook.com (2603:10a6:8:1::30) by
 AS2PR10MB6543.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Thu, 6 Oct
 2022 06:23:50 +0000
Received: from DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:1:cafe::7) by DB3PR06CA0017.outlook.office365.com
 (2603:10a6:8:1::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 6 Oct 2022 06:23:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT058.mail.protection.outlook.com (10.152.5.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 06:23:49 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 6 Oct 2022 08:23:48 +0200
Received: from [139.22.132.91] (139.22.132.91) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Thu, 6 Oct 2022 08:23:48 +0200
Message-ID: <01b96606-3f9b-18b1-2ee2-9ded8eaded44@siemens.com>
Date: Thu, 6 Oct 2022 08:23:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From: Jan Kiszka <jan.kiszka@siemens.com>
Subject: CIP IRC weekly meeting today on libera.chat
To: cip-dev <cip-dev@lists.cip-project.org>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.132.91]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--18.693700-8.000000
X-TMASE-MatchedRID: 3OnHKS+pL/RUexHo4vWu8JBmg1zv+iLiePOjK4lyDHhlyUAXnYRaSF+B
	oH4JnCIGZ++q5oZWwp8oqL1chlV2xfbjZLhs5ua57qEZpoAUsFTispvMxPAIBU6PG3UB9o6G9pL
	nYtQ99xJLpCLN4NR43oc/Zw06wyFfWExFuTDNuJXwgTN5hsYOwKDRSBS1ZYGL+L2GsArAgto1by
	NCHOgAtejMOEZ5AL0SImdkknPE0j7i8zVgXoAltkWL4rBlm20vZiFQvkZhFu1q8/xv2Um1avoLR
	4+zsDTtAqYBE3k9Mpw=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--18.693700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 3809F9CE6D43C25CC193719B799520AB078D439349181013F0ED968C0D6C29952000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT058:EE_|AS2PR10MB6543:EE_
X-MS-Office365-Filtering-Correlation-Id: a87396fb-dfcf-4b4a-023e-08daa763550e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GJ7yZTDDBLOAh2fZm30LrDwmLheOZ+IW21Cmh52TdcFXdTvNYljDrIC5ld5dvALhwC3F1DGa2RrmlTTmUbk+HjQ/fxj5nnzLxkmvhbTiM0O0cesfcwjKBphi1qkuIB2rZEhMHff1wPzi2cJrZRRrKpjgRDL1nh4zhIQ3eLhY79ARoT8oVN2ul1TTfPDbGQ2QjNeoMv1hLfp7v27QsDWUvrS0s8QN7VrVy5LMa8clfuIIrIsAEPbooFupSmM8ZJ/oq8pTdZLXGeLVxJBMdDVJgS3zD6SQosvrDRAOytqNDWf2ZMy5tgAe9MHK4IATrXUKpXOA4+QEoZQhXfaSgkHQln0pqVZcHMaL+itQmSscy7oz6jfXLjJUAoTOM81pVtPDjqzzNmEcapE9xdS12xx986lHvoLFWyAdwDXET20gsV+TPkoS6pOVoTyW5kRHxm3eh6YcSbofYkKWkFsqex5MGL90R+7yfk9fRma8WNf4HzguilJ3ku99/JovS9X9WobDdFGU+p8M6GclDEg8sJtmb3kQdiJ3ffkQWolpNxNpmXHWvgOCZObYbDG732u2GQmieqHe0kkZPuNM03qCZ5fTU12ZEXVf2wWESalmjsisvgGUYYrMkBXS+kZEKsTtPAw+9Tp9aObZ6OsH28X71qQ9jPQD3tSL2YAOr0LKP8MJ8/SeD/9PmYJ+rYrxR94F+njFmgJirLn1vrqkHExRiyZZcKHZkhi6AIMX+0v8HgM+m7pmoXg0tRAb7EUARXkUgoSak2SZw9lgwiuaxVSyiYCWHZciOtikctM1yEuYORofTZUMmeGe9CvEwF12P4Flpl7BtM+8YNub7QF7VCX2fyH1C4TM+b4wd1+dTFo77Wxez4m5EmEN6V2TS+YHenYQvKukG7N70oZs16HogR4xgcA/JQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(82960400001)(83380400001)(4744005)(44832011)(8936002)(36860700001)(26005)(47076005)(40480700001)(2616005)(956004)(336012)(16526019)(186003)(478600001)(86362001)(31696002)(16576012)(82310400005)(6916009)(316002)(70586007)(70206006)(6706004)(8676002)(40460700003)(356005)(41300700001)(5660300002)(82740400003)(966005)(2906002)(31686004)(81166007)(36756003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 06:23:49.6147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 a87396fb-dfcf-4b4a-023e-08daa763550e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT058.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6543
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Oct 2022 06:23:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9654

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss
technical topics with CIP kernel today. Our channel is the following:

    irc:irc.libera.chat:6667/cip

The IRC meeting is scheduled to UTC (GMT) 12:00:

https://www.timeanddate.com/worldclock/meetingdetails.html?year=2022&month=10&day=6&hour=12&min=0&sec=0&p1=224&p2=179&p3=136&p4=37&p5=241&p6=248

USWest    USEast    UK        DE        TW        JP
05:00     08:00     13:00     14:00     20:00     21:00

Last meeting minutes:
https://ircbot.wl.linuxfoundation.org/meetings/cip/2022/09/cip.2022-09-29-12.03.log.html

* Action items
  1. Resolve/ignore failures of KernelCI on 4.4-cip - alicefm
  2. Add qemu-riscv to cip-kernel-config - patersonc
* Kernel maintenance updates
* Kernel testing
* AOB

Jan

