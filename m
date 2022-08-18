Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25CBC28B2B
	for <webhook@archiver.kernel.org>; Thu, 18 Aug 2022 12:20:01 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.87])
 by mx.groups.io with SMTP id smtpd.web09.41461.1660825197165931092
 for <cip-dev@lists.cip-project.org>;
 Thu, 18 Aug 2022 05:19:58 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=IYPQuTSe;
 spf=pass (domain: siemens.com, ip: 40.107.21.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQUAsqB0FBI2xweKikN82jewsdLLhxbAjojImY2gxVOXgR4xs9JDpF7K2p+/P986S2k+0D338tWtjnNLZFcJKg0ma5hB12NK80Cit2OlYSeygiCtW1fzLUPRGk8WIPOyjxSUyHC9Bd7dfiw46eG/+9TNeaj/n3ATj+0qELyVYPj7Z4FGvgQd5OFLcXJNOjW168XJZLw1IPf8LcVrZquYKt5M8TlKsydG33x1/EEkq7OV/Yhf9OETVQWQ704yVYowiAcNpve4F6FGZAk1qk4ReopiJkqtX9/rBz977DDOTDH3X1UVXFMxRrY8scBVZiYqXn2oOR2aDKMeR8UKcePE5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfmFwbdQcuWK+9uDZeudoNPgD2jFLtb2Yt/U3wMQ2XU=;
 b=Y6tMrG7hAwEkiBphFXL5Az40qmvotjw8qiKCQQQx+yBHVru8LGs9fxSv9eVeF5EF2Lgjw9lKcfqe5zp46DEa9HPcdiExn/RuUhCdpavATmcJFUNdOFpZCix0Iy13MePtvzUiQmnXJPEguRRjGX8DMRakuobEItLW6OaMmF4o1/SoQkS/+1vIKccJZFHj2/0yDzL6XANqBx3fHqltAnwYJymknNvTw9t8W6A6vC2J6trCTkfXI/GpTO+WSGXqmS5HRHE3Fr6JORpLT57DplzInA69KrdZav+dm48InjH9XygJOdP0TwbkeQ+l30yeHFqBe4R+Su5OgwIU62IinRCMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.74) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfmFwbdQcuWK+9uDZeudoNPgD2jFLtb2Yt/U3wMQ2XU=;
 b=IYPQuTSe9HyFBoqX5MQQGVu62dKMnh5JxWDaMhGoy8tbGqs85NVGCYYyP4w26q9zw/36ToqkeSKRFFoOO2ZplTNwXHmzxuwI3eGLBZrhwweNUZXDECPaQ85cK89kd0aRU6rDbhOdicdwhkgFLQ81UoOAn6xBzlxpgFrOqYqWhQEtb9fB7IWPEO7hocqUm28529Sr/fTSfQE7P18XjYHiPQvVvLgVETW9KpcYaVpTuLJE8Nqry1sm7BRndg/L9s2LoFcT2RH/bdxuiNjWXiOEYImIfXUiEfrgFCGQTdFNq73Ikr6KwfF7MjWEP0jPHGuwv+7AKIqM7zaoIyMw114J9Q==
Received: from DB9PR05CA0019.eurprd05.prod.outlook.com (2603:10a6:10:1da::24)
 by AS8PR10MB4536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2e7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 12:19:53 +0000
Received: from DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:1da:cafe::e8) by DB9PR05CA0019.outlook.office365.com
 (2603:10a6:10:1da::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16 via Frontend
 Transport; Thu, 18 Aug 2022 12:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.74) by
 DB5EUR01FT042.mail.protection.outlook.com (10.152.5.100) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.15 via Frontend Transport; Thu, 18 Aug 2022 12:19:52 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Thu, 18 Aug 2022 14:19:49 +0200
Received: from [139.22.139.217] (139.22.139.217) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Thu, 18 Aug 2022 14:19:47 +0200
Message-ID: <e796fcf5-7654-13fd-8001-71fa611398e0@siemens.com>
Date: Thu, 18 Aug 2022 15:19:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core 0/4] SWUpdate on BBB
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220818040428.11124-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.139.217]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.032700-8.000000
X-TMASE-MatchedRID: Cc2Ao8tLfKDO278aZjZxZ8c50LsMZjCp/k5m7D0YTS/x5KZMlKYS/eKE
	ndfG3ZsCkdC02KjLJgXK19xyPRdoUX0UHkg+CF9nf8whZ6upSa34kBiMXhevoR/R5SKe31ARF4r
	8H5YrEqyGusRy6B5Ukxjx1+Pmj1EixudOpdf8jF+FxEOJpXwK3f3haLW3nX7f5wXI1oONVuBCie
	YsjWBj6einx+Z6UuPwvqnFtM6Nq/KFio2ZmgO4zFigaS9ZIuCuXlJqiTX99kJtFkauyh5b+L91l
	4UIWFISTPm/MsQarwPjo+A3552ljSvn27+DO/kwtTOrxEGQm4Zw1ghGV72CB54CIKY/Hg3AtOt1
	ofVlaoLUHQeTVDUrItRnEQCUU+jzjoczmuoPCq1lEp6vagrufqd/F0BCx0HRdd71rFL4v9L+2Kq
	J6iGfcAPaO8YxOero
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.032700-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 35D9E51F3E7DE639D13C5A76C74EEE603ED34D611B0EF39A17ABEC064B5B276E2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af12f2f7-1ac5-41d2-5fb8-08da8113f3fc
X-MS-TrafficTypeDiagnostic: AS8PR10MB4536:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	wp7I4p4X/X1epAqoDC02bvlYTGJtWWCJ2DyQLShaohYZ3VC2Opj75/X4SKSewYxzGwbgl2BRm3BXoYfLP9ZxJTTFwvVzKibyzne11qTgP71ltuqc7TvTmFhuGK88uPXIWEN+m37bVPzDU7K3JC2NGhVflJm2/LPQpkmbT1DJqZo2Xgir+FODkyMNCpCnh1R4RJXjvyKzgMeSsa/3aPVcNbD6xhGSG4mmJuDzmYevPNEOh699RDbEhV4EJa0m1Ce5lgigHlrS/eR1hzn9lK3l64VdmW7ArKk3TC7j+Sl2N3K0K1K3mNPzftsQFr3Uaa3S0MsWVVBrSr4ffTK4Wwa4OKPA1H+p6VfOLRNwd9RkAbo8m/eROKAcPUJqt2N3tBzX2RQ0Jocm5Yq4rpOe1RP11ke2zUG3gfxhGPO+5zQKwJmt1R9qTWRENDjNYKb2lao3K2LG/uTwFCFJgOgPN5TgSc8lUNwOop/S8bc8KQNT+pq26wFC/xD+BI1Y+CorQBi703S9nErM2piXZ0fFS1oi0jLlYEjoBLsKCjKZAhPHpYPg+xfCSOo7uEgzZwL37sKRr4wyy/qU1zs3796ISwiDtDv5djjU0hVBNUEPSP4Dt6OCpZ6MikVPrj1rajaqADYYfzEFRVwiL4Ve8J4lbkCdB3yVXTT5TGT87mwJ6V0SjbPOmlH9+RsJpaXFF9nP7oLhL9ZpJPD7HvhDzP3Hj1svhWiGNFr4mDE0/hSltHvOYbp0o/QrWuhrO7bl4brb0uVD94nHMS0o/l0vQU0PVsypIt9CRrdNwe2QLXKKg2a3+vYElQOsKnkzznQ+5jY5ow9EPCN5h8O5Ve4E1k7iB421oNlNSCKtExd0v8NTDr9XSAZswnGTlaQeRfTOm0zoRbr/7MqIXKfBuPZoXNCUasT57nQhQrzj4RpvkBkcO9bzYSq6Dq5LzYFM24pWU7JXWAx0
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(40470700004)(36840700001)(46966006)(336012)(44832011)(26005)(316002)(186003)(956004)(2616005)(47076005)(6706004)(54906003)(16576012)(110136005)(31686004)(36756003)(6666004)(83380400001)(2906002)(53546011)(41300700001)(16526019)(82960400001)(7636003)(7596003)(356005)(82310400005)(36860700001)(40460700003)(31696002)(40480700001)(34020700004)(86362001)(8676002)(5660300002)(4326008)(70586007)(70206006)(478600001)(8936002)(82740400003)(966005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 12:19:52.3330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 af12f2f7-1ac5-41d2-5fb8-08da8113f3fc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT042.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4536
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 18 Aug 2022 12:20:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9292

On 18.08.22 07:04, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> The patches are related to swupdate on BBB using u-boot as bootloader.
> I confirmed swupdate on BBB board with all these patches. These patches
> are prepared by referring a branch[1] and patches are available at 
> isar-cip-core branch[2].
> 
> [1] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/cip-sw-updates/swupdate
> [2] https://gitlab.com/cip-project/cip-core/isar-cip-core/-/tree/shiva/swupdate-bbb
> 
> Shivanand Kunijadar (4):
>   U-Boot: Add custom BBB U-Boot and partitioning
>   SWUpdate: add SWUpdate
>   customizations: add custom modifications for swupdate
>   Added README for BBB swupdate
> 
>  conf/machine/bbb.conf                         |  23 ++++-
>  doc/README.swupdate.bbb.md                    |  90 ++++++++++++++++++
>  recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in  |  79 +++++++++++++++
>  recipes-bsp/u-boot-bbb/files/fw_env.config    |   1 +
>  recipes-bsp/u-boot-bbb/files/ubootenv-bbb     | Bin 0 -> 131072 bytes
>  recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb  |  59 ++++++++++++
>  recipes-core/customizations/common.inc        |   5 +-
>  recipes-core/customizations/files/interfaces  |   6 ++
>  recipes-core/images/cip-core-image.bb         |   9 ++
>  recipes-core/images/files/sw-description.tmpl |  15 +--
>  recipes-core/images/swupdate.inc              |   7 +-
>  .../files/swupdate.handler.u-boot.ini         |  26 +++++
>  wic/bbb-u-boot.wks.in                         |  13 +++
>  13 files changed, 315 insertions(+), 18 deletions(-)
>  create mode 100644 doc/README.swupdate.bbb.md
>  create mode 100644 recipes-bsp/u-boot-bbb/files/boot-bbb.scr.in
>  create mode 100644 recipes-bsp/u-boot-bbb/files/fw_env.config
>  create mode 100644 recipes-bsp/u-boot-bbb/files/ubootenv-bbb
>  create mode 100644 recipes-bsp/u-boot-bbb/u-boot-bbb_2022.05.bb
>  create mode 100644 recipes-core/customizations/files/interfaces
>  create mode 100644 recipes-core/swupdate-handler-roundrobin/files/swupdate.handler.u-boot.ini
>  create mode 100644 wic/bbb-u-boot.wks.in
> 

Why not using the UEFI path, like we have for qemu-arm already? Would be
much simpler to add (and likely also to maintain).

Also, I'm skeptical that your changes didn't break the UEFI integration.
Did you test it afterward?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

