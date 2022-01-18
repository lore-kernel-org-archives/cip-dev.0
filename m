Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E44CFC433EF
	for <webhook@archiver.kernel.org>; Tue, 18 Jan 2022 13:59:24 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web11.12954.1642514363091310720
 for <cip-dev@lists.cip-project.org>;
 Tue, 18 Jan 2022 05:59:23 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ioAH3iN2;
 spf=pass (domain: siemens.com, ip: 40.107.8.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1EOx4nLx2fEp6QnbooZzyUW4vHDW4kzIfuJn3OVnwVnFum12U3ubyVJN+xhkhGIjsMqCdNeWOIrQXIaMSqMV1JYi1s/WrJ0hn8ETbtMURny8mL2EjFYDU9IBJpMLSzomJ2oYQtDIBncILSgTrFCpBFMtkhcDX18qtWtmKMAfZzlX+H3JT7je+/4VKrXqOOi/wxcKZxfXmp48YXrch5l1TZRZ/TalW1DID7rnZDeXsVPI3bOw8WNx48yTfNwoFJNgX5x9ayEqwoOXUc1xDh5qd4EvKbYxQsbCjz/vzveugNkZdbpQEQzW/aIuI7GJ1BF5yRMSN0MZ80hkYB3LR9bEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ugAYT/QxKdNYJFRvja1rbygwFHfNt+cIoZrBiyQ/JA=;
 b=iQ1KhZcSB67zzUEY1+QJvKAgWnroVhom87hZ4zrRlm+DAaKvXAJ0k7CLpkjI+I4TEBFB4Dk79V7Vaenn2BoSpp0lxGMtwngIrAjWSgZQp4z2IosY5gi8FVPfHC20JE8HS15DJFyeFvO/pdbZojXX93qCW9KkoFbSp5RObjJYBsdfx4tQwzf3nhcbaJQx03WpzJYSIWMBoYbdy/ST454zZO7pRFc6DTnF8gKqwqYAQrtzKppGfVyUIeq+Ui48ZMRnerFHHw2vUzEBn0BVRSAczZmKrcz6jVATGq4EBl3VSvpZjapLWvIu0ypjIfG0TOM71n2lHTLvImv4MO2i2jAUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=toshiba.co.jp smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ugAYT/QxKdNYJFRvja1rbygwFHfNt+cIoZrBiyQ/JA=;
 b=ioAH3iN2U0QQULeenCQAy9CJIy58eYFnrD2tn50XZQEaql8fnbPcEprb0plzrzWamXz5XC9SXKT685HxDvRkPdCyqa2ALxu9rno9vH5B3enFu1gIz+Jcg717UGwFYA8kcUcYGtBtro79Nc/EWGRfrsb5CczV7eJxBXFhUIlGIlc9DHRBso2JwRqBh/IR8umCT3mjqJU0yvqw5QgMNBsaG9JVwUBFnUbQD3W323DOz8jk5cg3pm1zBw4ngwCKNZCo98ZWLx0IiNQNCorrrif3QdUdLYj/iM14u1mgrWPZtw2pM1n3AYOE/iDo+rJAKWi/rgw+wRFZ3lfp1DRaWfRgcQ==
Received: from OL1P279CA0015.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::20)
 by AM9PR10MB5100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:439::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 13:59:19 +0000
Received: from HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::ea) by OL1P279CA0015.outlook.office365.com
 (2603:10a6:e10:12::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Tue, 18 Jan 2022 13:59:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT044.mail.protection.outlook.com (10.152.0.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Tue, 18 Jan 2022 13:59:18 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 18 Jan 2022 14:59:18 +0100
Received: from [167.87.1.99] (167.87.1.99) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 18 Jan
 2022 14:59:17 +0100
Message-ID: <e13b5b70-23b5-2919-0ee0-2a69afa477ce@siemens.com>
Date: Tue, 18 Jan 2022 14:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Preparing a container for kernel compilation using the Debian
 compiler
Content-Language: en-US
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <Chris.Paterson2@renesas.com>,
	"alice.ferrazzi@cybertrust.co.jp" <alice.ferrazzi@cybertrust.co.jp>
CC: <cip-dev@lists.cip-project.org>
References: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: 
 <TYAPR01MB6252AFDF07076F430E2CD1DC92589@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.1.99]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6bc2212-ca67-47e9-24c2-08d9da8ab8ad
X-MS-TrafficTypeDiagnostic: AM9PR10MB5100:EE_
X-Microsoft-Antispam-PRVS: 
	<AM9PR10MB510037150E11C8EEC438CA4695589@AM9PR10MB5100.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	eA3cBk6n/X7mkIA1a1C/jfpW6EHxNQeEzo8Fw2/dzuRkDO2wrU4Lr0ge41NpEcMjqRI1R6LMskKNt6UH5I+AoPFmIh891m+pz+CYNcEd/PGmedCEoI7nDol2GvmF/2+ub86G8p1dLyjD5WfwJUG/cpElmv00sIB6/XBrtFGJ5OXLNAwgHfLMw4XHVSVlrrkADd9lQXdNZQGk8AO/m3IwvLeqtT2xTlVnPk0VMgPlKQfx04m/5zhhjEnavphuXXC2g6Ncdqt7WaDiERkwMep5Ct8mdN8xiDmbnTyL0jKGvWF1mAgpVnXumTpuvdF5AvHI28GrOzazX7GFLrkX/yh3Fd++had+Qa6T9Njo4Z/wy6pdM4vlCjcTjcko6EqTwIbv+dwwc0YCEUzKndp57P8d1lN3oZnAhzbiChixURoKHVWs1SDV/fN7BzEKCKEyhVnHrUDBDTw+bpcf7VgljWqpTQG2QL0oUzrGwsD7M4KaVLLfIgLCm9hmM9p2Pg/Gc3B1wtvovmF1rHe4FTq2i/YWZ8g3vbPy7j8U7mz/j0HZ+FZSEtRKhD4L4d0skIEwYockUr/ZqFFo259Fzi3/yIF3Nn8ZEJqa93xEbTDgTvxOcLMskOuCN6HBPM0Tdi7gMW/AijRLV7RWfC6ffILZ7lUy/xkwV6v+yReZiHwl28TujodGNhDrUdJTWGZgQ2J5Y3PrCpveLzZPLne/yrL2IplQu5urHTiPMKQbjIdXViEafj4XUfMLBvM+hUPif8LjI/6t5vokKWFKflrToOYDiTZGcGnw/GQWVt3+Ga2CBDVc8WM+d+Vdia2r8aIz/B9mYSBCqzt8xtqk8/7ewF8pMw63og==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(40470700002)(46966006)(36840700001)(70586007)(31686004)(36860700001)(4326008)(26005)(956004)(36756003)(186003)(82310400004)(70206006)(2906002)(16526019)(31696002)(336012)(40460700001)(316002)(2616005)(508600001)(16576012)(6706004)(7596003)(7636003)(110136005)(86362001)(53546011)(8676002)(5660300002)(44832011)(356005)(8936002)(82960400001)(4744005)(47076005)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 13:59:18.7395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 c6bc2212-ca67-47e9-24c2-08d9da8ab8ad
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT044.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB5100
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jan 2022 13:59:24 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7466

On 18.01.22 13:35, nobuhiro1.iwamatsu@toshiba.co.jp wrote:
> Hi Chris,
> 
> The 5.10.y tree building is failing due to a problem with the version of the compiler
> currently used for kernel compiling. To solve this, I thought it was necessary to prepare
> an environment where each tree could be compiled. We also suggest using Debian as the
> compiler as we are developing using Debian.
> 
> I have created a fix and MR[0][1] to solve these.
> Could you check these?
> 

Just a thought: We could also derive such build environments from 
isar-cip-core, building SDKs as containers for its images, e.g. for the 
kernelci images that will soon exist. I can't promise that his will be 
easier to implement, but it may be interesting from the perspective of 
having build envs aligned at some point.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

