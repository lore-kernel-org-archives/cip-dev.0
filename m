Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E19EC00140
	for <webhook@archiver.kernel.org>; Tue,  2 Aug 2022 09:14:41 +0000 (UTC)
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
 (EUR03-VE1-obe.outbound.protection.outlook.com [40.107.5.54])
 by mx.groups.io with SMTP id smtpd.web10.4024.1659431672692756976
 for <cip-dev@lists.cip-project.org>;
 Tue, 02 Aug 2022 02:14:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=piUp6UyD;
 spf=pass (domain: siemens.com, ip: 40.107.5.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5/E37pLV1RxTio66XC6hfy3ZkNqG9H6EVQOWUnS3LjH0aYsVdmyIiYOeBsyuj7UvF9VhQG5KPqOEs0FldEISmm2+7mrDUClxhZqExBF2kd28rwa0nMAL3vi6LcFVuommZrrwqdd3r+Sjt3SXN71wi19wo5pgVkUjcj7RheFbrx0Aggrg78noldSV3tZHvxhlAyRpdFDcV4IZp4+QOnPDCJuUTMevi1MEa5DTynZTDIend6RLiBmM8r+fHyEtUPQvuwm9qUfESYN+Gz/N6mwODaE9TyilJku5s35T5Idp14VP8vh3zB+i2BhTe2IkcxPyvFKWmQAA6MnLU6A7qw5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXqdsCESpUaMU+zESrk2pxKUGicqJR/aDiWxWa+th70=;
 b=EU88mr02R3cL1YU8AVVaax6rqDSMYOQ/eF5wfsLOfbDhTA+142rzHJ7mbdOLGQwlKlrKH3+eln0Et8iSvM1cApaTbEGkkUtnwWGPPfsZPFaeonqIyiDCiRQzfD1SJvl431/bkH+Pfd99aXVQwmjUQQz094GyeVft0NLNZzSPdhC/gXSy6tpZTr/g/Q1gLFLDrPkH/3cASW67W4JthkVKiRqvz71dtfdISLqrZDvheY/CrS4HulO9u0/Tp/52+t0qWzk3MvuJe2e8C6ssyQsbmQtA9UlVtIcw6RQIuCfH9QxxmQITw3MjJ4T30gMIdact+xBqOHvuA/OludbuQczcHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXqdsCESpUaMU+zESrk2pxKUGicqJR/aDiWxWa+th70=;
 b=piUp6UyDx7U/YvzdL/gapIKfm+JUH+UV6A7fCTjXzbu0KNQ6o45xFeyCxOVeLZe8ljbjKgRv/LlOqMBG1FvP0bgC42HSNfVflGm/sGcpXylghON6Ot5K+MhQcaAH7lgeXoVZgaprcQ0d4QraAWDpU9Kaw1Mcj2p7JUA9Jt6WfqllmbRJmMer3Z381nRqFvhNnftokKPbHwfJ6L/BmspXy8BAqA/Rf3GEo4Q1KB+yWiehSosZYpumI1IDEzER2shLGHyGe/vkw6hFbnrkht6Q0CiHLaK+5awIZPykflC0T+aR++J1LRok03Eir8Izt8eu/GzfcjKFhy3K73pCY1Dy6Q==
Received: from AS9PR06CA0416.eurprd06.prod.outlook.com (2603:10a6:20b:461::10)
 by AS8PR10MB6413.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 09:14:29 +0000
Received: from VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:461:cafe::c2) by AS9PR06CA0416.outlook.office365.com
 (2603:10a6:20b:461::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10 via Frontend
 Transport; Tue, 2 Aug 2022 09:14:29 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 VE1EUR01FT045.mail.protection.outlook.com (10.152.3.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.10 via Frontend Transport; Tue, 2 Aug 2022 09:14:29 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Tue, 2 Aug 2022 11:14:03 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 2 Aug 2022
 11:14:03 +0200
Message-ID: <918dc71f-3452-44cf-22f9-133d15dd89fe@siemens.com>
Date: Tue, 2 Aug 2022 11:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH v2 0/4] Add support for ISAR with
 sbuild
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220729100431.453463-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.222200-8.000000
X-TMASE-MatchedRID: EhMq+2gclHs5QaOxwNGfvo9bHfxDWoibMz0EFG5lnW+5kFk6DtF9fxJS
	x+7Qm/dKJ7XU0Q1VfIdnbyATPFLi0qwMUvjfcK1boKrt6ZCfJkEwPeRMPzgMnSU8tW70+6utVBD
	QSDMig9Hfc2Xd6VJ+ykwSeVQnSS/FhsIVqBLXjR5YddZe8wGUCeqXDbz6Gdxnbl4CKqupkMr0VP
	vT0zx0mIc9Jc7K8Zqmo8WMkQWv6iUD0yuKrQIMCDzvSj1BF/M7VnRXm1iHN1bEQdG7H66TyH4gK
	q42LRYkvsCWz9eJlX5g86DDxKl06DpK2g77q68+SN2jGlbg/Ld+3BndfXUhXQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.222200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 03CA24A391D76619BE5CDA08C89F7CA9A479C01F178C2EF304CF4E4BFBF2A6172000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9414319-739d-468d-b5d2-08da7467676f
X-MS-TrafficTypeDiagnostic: AS8PR10MB6413:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	e/1c7y+7UPpHXhRzXJ9UztYGqYc611pfEaZkS68HU8mGAF/rEXgQhzeoUyYFX8nN3DrhwFASFrAQBtPNZVYS5Bb9FYYU2zpGPcxKwPKGobqVrephcePgMTnq7iKoER1wXTZv0pEXtrU6gBznf3cpTymCntlJTKeG/0VvGyo3zfr0PdW9CVqJq+9FwfwBIHojVtMvKfMmCvme3zQrrHvNWBZWigZqsq0ZqwK9TOdWIWb1g/M6e9/B7axV7tFXVYpzYIOfvnCzH2c5cNFzj8TcoKS6tjepNAp0CtfBJqEN/gQGlEI8bilP2lpdGqIo7hA/rvLy1dYUqb7KFOTnV1c42DkEPi0AoKAw2akTXS8NjCeIbshJOuWSfysTNZek3QPCQTrL1D2xly44UEpHaC6BNcAlFaA5bexJvgM6d7q9b0JvPlTZAXhj45u+DNpiE6BuLBVhhqJy7MbHRHjHxGgpNLj1XB3u0lvO+dQn2bBxJL54nc2LQxD3WFTHhCqFQ80odvosIFKy+wPsrAi96gx6cB61Pq1fXjfGQeBvXHZ/NBIzdyN7+fUJoeziwqTuqy6GVlwecTPQGyT+khlLck/94zpD4HExzu68U8dKB/CjIGZ+XXWYJZXwvcFtMSeeB2YKPIefyDTTtrIJpPxjMrHD7PuTdAVJNb7PtQ9ugINAouwUa7CslQUbzvh1fM54PcMaMuP8AXlKnWw3/cEFDjXzl/y7UIxZK2ltDzeQiV7gJcMQyGzMII7wM7mrXfuE6SGvmRgf0wRf4pRqxeJB1zP8PtZOSvY0BE2hMZfGhsTmr8EUvI9uwHCSQ67EwqzW5Esyj5SkRsh1wdFJFD0BtxXcIPgOqxNalJbhGGeDmLFeNJzPYfycADlpBfiEl2VbBz8SSnnwLktgWxKfRrV95/6aBg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(40470700004)(46966006)(36840700001)(47076005)(336012)(186003)(16526019)(83380400001)(40460700003)(2616005)(956004)(81166007)(70586007)(36756003)(8676002)(6706004)(36860700001)(110136005)(70206006)(316002)(16576012)(31686004)(82960400001)(8936002)(26005)(356005)(478600001)(86362001)(82740400003)(53546011)(40480700001)(2906002)(31696002)(41300700001)(5660300002)(82310400005)(44832011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 09:14:29.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e9414319-739d-468d-b5d2-08da7467676f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT045.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6413
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 02 Aug 2022 09:14:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8995

On 29.07.22 12:04, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This patch series integrates ISAR with the Sbuild feature.
> 
> Changes in V2:
>  - reoder patches
> 
> Quirin Gylstorff (4):
>   scripts/deploy-cip-core.sh: Use dtb from deploy dir
>   recipes-devtools/ovmf-binaries: Adapt to sbuild environment
>   kas-cip: Add patch for linux-cip with CONFIG_MODULES=n
>   Update ISAR for sbuild integration
> 
>  .gitlab-ci.yml                                |  6 ++--
>  conf/machine/bbb.conf                         |  1 +
>  ...ernel-Check-if-CONFIG_MODULES-is-set.patch | 33 +++++++++++++++++++
>  kas-cip.yml                                   |  6 +++-
>  .../ovmf-binaries/files/control.tmpl          | 11 -------
>  recipes-devtools/ovmf-binaries/files/rules    | 17 ++++++++++
>  .../ovmf-binaries/ovmf-binaries_0.1.bb        | 18 ++++++----
>  scripts/deploy-cip-core.sh                    |  2 +-
>  8 files changed, 71 insertions(+), 23 deletions(-)
>  create mode 100644 isar-patches/0001-recipes-kernel-Check-if-CONFIG_MODULES-is-set.patch
>  delete mode 100644 recipes-devtools/ovmf-binaries/files/control.tmpl
>  create mode 100644 recipes-devtools/ovmf-binaries/files/rules
> 

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

