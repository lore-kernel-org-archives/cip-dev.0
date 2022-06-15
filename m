Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60E4C43334
	for <webhook@archiver.kernel.org>; Wed, 15 Jun 2022 20:39:48 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.85])
 by mx.groups.io with SMTP id smtpd.web12.10037.1655325586329657255
 for <cip-dev@lists.cip-project.org>;
 Wed, 15 Jun 2022 13:39:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=xD11VCLc;
 spf=pass (domain: siemens.com, ip: 40.107.6.85,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKal0DsBjUx3kZtP5bbg/6s7r7eJ1or8zBUuw84Rf9w8vJg4z/JUE/MI68CokSTwqDp3oyKUV9kNUNgyyWnk2TK/YEgYtlaN7cNmYp+pMwEJvIb4WKcmPA0adOC3nlN0aUhFmXb5OrLL+9HPDwd2NjgmBnCTbXeo8oyzIMS2thMwdhJ/q6qwwZwGcwYpRZdJZlBtrXg1XyckOR1RAdkk3RkSGQcHUX0E8KdgSpd3ywbF/S1kwfwpvY5q6nelKt9imuQjIG5v4IlAZREenueJTg5PnEhGqSsw27cpgSD9JStyc30hdiqDC42Rny6WNcz0+VuGaoVhc3oM4oGH+ov1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sdPeDKX2VZeiYvk+Qi9aIMIr4vHqtBa/2Pi6Z+b5uEw=;
 b=aE0Mh7UlFnohDuLbrPTU1UUHbVPdFq3udSfvOSC3bz7F88ULA9yjH1Mt0c4mWgnC0zXnmpiQqPz7429dwgVf2K2Gpi5OBB8KANwxCHeMq5rGQNwpcsexbcsJsqKRST/2X0XwYXcmMO3eGYekssVwc3xo0wXEISuLKDFRt2zZjFrNBT3GKrqqL5kOALYSvlHfSAWwuvRBe8RBIpiMyqtQlkfRK0G8WdFwoEkaXm5Q2vC4usttSDEb6yfvoDEttVBt8SXQulAdscFIKuz+xgeeTGbymRJXF2eD7h22X6DggE8OiYWAuwknr856+63IsKaCgpYtDmj09LIGfr4F1XKhkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sdPeDKX2VZeiYvk+Qi9aIMIr4vHqtBa/2Pi6Z+b5uEw=;
 b=xD11VCLcIsdNJ1lUjpNyoXcvsrjWrzSrQDnWSShjX2FnMBfIDqU69elO9C2aoySjSTCGg8k7DMMlCXMtEkjO71FPMrtXj5pdeFw2Jq/ZXUc3V8XMc29Vt2ZQm6PSzs14U9h5nAKXLu5brKxrZ06eeQIUXYTEUc4Z+UpY7AbE+zlrcyuTgAuea0Mt4m0VtdXm8xMJvFYLxslEozqELKig/yrSd4A1uNV1ffz6n4y36J4GFzr1gi+TYS3zsE/2Xfwyi4ZpaseOdTTQFHV+d6qrpjlV8xA52ddFDIshYoBNUoU7UjnvCvqMALxBxQftkmFeA7y1FZjz8Px+Q97sGpalJQ==
Received: from DB6PR1001CA0014.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:b7::24)
 by VI1PR10MB2703.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Wed, 15 Jun
 2022 20:39:43 +0000
Received: from DB5EUR01FT100.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:4:b7:cafe::1e) by DB6PR1001CA0014.outlook.office365.com
 (2603:10a6:4:b7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Wed, 15 Jun 2022 20:39:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT100.mail.protection.outlook.com (10.152.5.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14 via Frontend Transport; Wed, 15 Jun 2022 20:39:42 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 15 Jun 2022 22:39:42 +0200
Received: from [139.22.104.253] (139.22.104.253) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 15 Jun 2022 22:39:42 +0200
Message-ID: <1bd6b409-1c93-168f-c02a-21d921e62018@siemens.com>
Date: Wed, 15 Jun 2022 22:39:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] Build warning when SWUPDATE_BOOTLOAD !=
 efibootguard
Content-Language: en-US
To: "Bezdeka, Florian (T CED SES-DE)" <florian.bezdeka@siemens.com>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>
References: <22e98bbc8a23f5a88dd6f7131d79b83db89d6add.camel@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <22e98bbc8a23f5a88dd6f7131d79b83db89d6add.camel@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.22.104.253]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--19.239600-8.000000
X-TMASE-MatchedRID: irl7E//xM97PhQMrvkSA3qWxvLzh6MfqPg9yfk4YC0Y4zRqVgiL309hQ
	O8CvZj/XiMjwne07X4kg2AikADwu40UWuNOlf2MMH54QuRj/igWrZVxUZgnbfdUcSZdVkdtzOVs
	GEArOAZ/T0dXE0JWl/EaYXWkoUjstnaUIl+aCcEVZyLN0Ehx8q6yO/JMoC35sbrJ9gVnOsZ1PnK
	xAOPp4WeZAlRR6AIJ7dCN9jYKoXjzxgwYhHpmqNZU3pG6saX+HL+rjbAJqcd43aW/7bl6SZ3FmR
	H67eyYFGUs9b7xvtJr7lLC8K/RKLSd1NUlKXf/6ri1JtSsDN8xiL8D++5xelW5eAiqrqZDK9FT7
	09M8dJin7m/OxjmYo/D+6IQMRxU54vM1YF6AJbZFi+KwZZttL7eQq6mF2S4/seWplitmp0j6C0e
	Ps7A07QKmARN5PTKc
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--19.239600-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 2E634226B1CF4CC6D3F1FD27E6B8B2734B276D11CAA134003B64B3E4AACADA472000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c766707-e237-405d-fe94-08da4f0f2d55
X-MS-TrafficTypeDiagnostic: VI1PR10MB2703:EE_
X-Microsoft-Antispam-PRVS: 
	<VI1PR10MB270300EDAE2A897335B9C45495AD9@VI1PR10MB2703.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	yPFAbHtcFCiBY3IneIsx+9JsswnwAQQ/Aeo6WqzrGdUOknasBAAFRVK8klZsIjbeDIBjUfPnpZWb8V8nQqI+cfFuHXVOs/pcceGwRKq3B0N1i9zdZiEcKChSutGY4/taf9JIweHgyYxn1g/TeGJQw8MVuaSWN1EajYFwoHEETve2RTdjEqL24gaNx7GGPUzYyWj5pO8QYe+JxI5/Zcl3kYjHY4hDQeOKJ0t23EzkXGuNKhOMkqUpRtYuIk1jgUVGktQ0OoNtAQnCiDHZGeuSVMRkNeEF1YrlZX9mWGo5fDjGOedN7/fWWhR+g4GBNYSosAlz5wP8OYs48Vk+OzdV6WzpN8dxAUQK9JlGhkKTGtQe2a9q0r9lg8sc2hvJ8rKZOzK/i8+RMEM5CH/NRyF2YKam7/act7O4GUf/PlwbKcWkE/BwWkg637fbpnlo0Y1dt33Ru+6TgPQ9u1VoYLhms5G/ItTGsGulxHibKhMLiUo6OTXcCwCQ9IPWjm7xgA4yAMApVxXRwyPmhHHEzVnfLQswtwEsnPasDUUoqQr+/4RBCu1KEpB097sWAw+MzQYfUrmVzxI/WrQ6FGl82dTvGkdI3fHdzPVCwTtiraz+g/D6RNpQVMU5j6bgjjJPMNyCVaAdIl2gcY1oS/GK5PDThuwgVXyJTan7SBYGDFnfj4xCkcsOIZ+av0UOWT6tslAsrHf2f0Del7BMEtaxVC1tYZb4qRvDyG1GnJBlYeEzRoBE1eexh+tCNLs8kYtoKh/0vQ+8ztXL8TR+3+Idl8LPpA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(40470700004)(46966006)(36840700001)(16526019)(47076005)(336012)(70586007)(70206006)(4326008)(8676002)(2616005)(6706004)(26005)(110136005)(86362001)(186003)(31686004)(83380400001)(53546011)(107886003)(956004)(82960400001)(81166007)(31696002)(82310400005)(40460700003)(36756003)(44832011)(316002)(2906002)(6666004)(5660300002)(16576012)(508600001)(8936002)(36860700001)(356005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 20:39:42.9279
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6c766707-e237-405d-fe94-08da4f0f2d55
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT100.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2703
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 15 Jun 2022 20:39:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8566

On 15.06.22 17:03, Bezdeka, Florian (T CED SES-DE) wrote:
> Hi,
> 
> when trying to lift one of our internal ISAR layers to recent isar-cip-
> core version I get the following build warning:
> 
> WARNING: /work/cip-core/recipes-core/swupdate-handler-
> roundrobin/swupdate-handler-roundrobin_0.1.bb:
> Unable to get checksum for swupdate-handler-roundrobin SRC_URI entry
> swupdate.handler.u-boot.ini: file could not be found
> 
> The swupdate-handler-roundrobin recipe (which is actually never used
> here) has a SRC_URI modification (see [1]) that only works when
> SWUPDATE_BOOTLOADER is set to efibootguard. For all other values there
> is no guarantee that a downstream layer provides such a file.
> 
> Is there a way in bitbake to check if a file exists so that we could
> add it conditionally to SRC_URI?
> 
> Changing the condition to
>         if d.getVar('SWUPDATE_BOOTLOADER') == 'efibootguard'
> would require all downstream layers with SWUPDATE_BOOTLOADER !=
> efibootguard to add the file manually to SRC_URI, so the pattern
> introduced by SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG breaks.
> 
> Any ideas?
> 

I think we actually have to limit the SRC_URI to the cases we support,
and that is efibootguard for now. There is no such thing as a
if-file-exists entry, unfortunately.

Jan

PS: You likely want to have a look at the swupdate-handler-roundrobin
nevertheless. It may simplify your partition selection logic.

-- 
Siemens AG, Technology
Competence Center Embedded Linux

