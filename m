Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C60C433FE
	for <webhook@archiver.kernel.org>; Thu, 13 Oct 2022 10:53:52 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.67])
 by mx.groups.io with SMTP id smtpd.web09.6099.1665658422795252177
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Oct 2022 03:53:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=Fgl9tb21;
 spf=pass (domain: siemens.com, ip: 40.107.20.67, mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd6MEJ/lDKavi9oeUEvn0CCxnSH4I8vYWbvnRIeKBCk2cpYx0xdoEddIqNEZz+FjFrRXQnzIhE8qdUwVBXIxNmJRowvmBawFmkBvKKq6RU9cRsG5R+HE8uGjgwnZs+gxjtI0qh42M/fMyXXzuEGCvingM39rctejKt5lxDR8Dr4t9Cjy/tWz1aF6GfS7HWTKzk+pcocgLyh8lIFWnUEKp9kwJCxEerW/kigb3fZ1v27PgYzooHpNLhusEkdkE7WDR+2WdtMd44NUxxb0w21B60Ptx98+PxAd1ZfX9V6DqGNITCTe2eSFQ+Aj9nZDYn+05yFwy/p1Fnbb/mfD53axZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qOCwoalWVvM8ZSKJQBnv5cxvHX/5RP/q1gwALqCmttQ=;
 b=cLzNJEF4Ytsb42gyoxn4VQYo5tgwhcrUNBOE3Z+lc9KWuEo2tL7ay3xbTw2pQFWjqT0mteAmBXO/X17vFpyuKy0MduLAG41UYEPuMWvIpmwVy8hcrcO52sO2UAkcjI6Tu1jm+oVP6N1EAEuDB6QYX6LLrEewD/NRqTklEsra9JYUWFjPnRLU1YrHbvu/T8SwgfahP9eTfdjvPXO1ryg1V52nXEkxQxIZJG1CGyUy642zwkOAzEBAMIGtITmLwRNLGOgech+FNq8YmGWx5MmsLuRQwxo/++qZxkvavB4gOhdlg5nmwe7rgjKgaC/HJgQR6bICgmsF3Z2bQiuJ4yailQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qOCwoalWVvM8ZSKJQBnv5cxvHX/5RP/q1gwALqCmttQ=;
 b=Fgl9tb21gctv2nLxzttKhDq2sVwkFg/z7WAEIfOiY+uL5R0dJI5n4GxQiqbWS+3w5BKgC7t5cFw+/4kvA6krIFQ/BEZgSp9vp/dziyr8mqB8qpboS996t+yWQ1JZTbwuj18Pyx3kfZHGgOnmfwIQL8mcRXiuBhtFLwjmwROqvFA+KQtmU31epFgE+S3W9PShEk3PkLlMc8LiRBX0CC4T6URtWN6TyNT4l9Yakveud/yua5JCJCnVfRfUOq9vCQpl3/POFnGzNNhNDw9+vR9LmO7WQGBb4zJmT1PJmAgZ5Ct0KemG1d/vhulFviw0hMbmR1LbU49mKlh6Y+tblfEiJg==
Received: from OL1P279CA0012.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:12::17)
 by DB8PR10MB3292.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:11b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 10:53:40 +0000
Received: from HE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:12:cafe::56) by OL1P279CA0012.outlook.office365.com
 (2603:10a6:e10:12::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Thu, 13 Oct 2022 10:53:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 HE1EUR01FT061.mail.protection.outlook.com (10.152.1.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.20 via Frontend Transport; Thu, 13 Oct 2022 10:53:39 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 13 Oct 2022 12:53:35 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Thu, 13 Oct
 2022 12:53:35 +0200
Message-ID: <59cbca91-c319-61cf-4170-3c82a27d1bed@siemens.com>
Date: Thu, 13 Oct 2022 12:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [isar-cip-core][PATCH 1/3] fix: add missing class dependencies in
 image_uuid
Content-Language: en-US
To: "Moessbauer, Felix Jonathan (T CED INW-CN)"
	<felix.moessbauer@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Gylstorff, Quirin (T CED SES-DE)" <quirin.gylstorff@siemens.com>, "RC CN
 SVC Pluto" <pluto.svc.chengdu.cn@siemens.com>
References: <20221012100641.2986740-1-felix.moessbauer@siemens.com>
 <20221012100641.2986740-2-felix.moessbauer@siemens.com>
 <73ba5e31-243b-1ddd-e225-6c285297e5ab@siemens.com>
 <HE1PR1001MB109838FA85BDD29747EA1E4189259@HE1PR1001MB1098.EURPRD10.PROD.OUTLOOK.COM>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <HE1PR1001MB109838FA85BDD29747EA1E4189259@HE1PR1001MB1098.EURPRD10.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC8WBA.ad011.siemens.net (139.25.226.105) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--20.046400-8.000000
X-TMASE-MatchedRID: rRgX50UcFf5o0FBZlmedTrZv+ayzmKtKPg9yfk4YC0bM1jffIgQXhng9
	csuuqcCglFENJQphsMKabGVEnOoMFnggpNBbPCpFi9EDX0Vp0l2ZT0mCrGol4GhCG8qMW+KyUXl
	p1FHYSPWxHvem8y6Tr2OSrrGACxkILz1GYRBt5agm0m9weMGSy5A8LqYDuhanZf3zf+xpuLgOZN
	XmvnJaeileBpqCo+tIOrTV1pt7yWLk58yZKZsfm8cyWni3/xqJle+q6k7Q/cwvzLls7HTfGctDH
	w9RrCNbmyiLZetSf8nJ4y0wP1A6AAYnglAWdCYbt7DW3B48kkFJV3La6JhRYvoLR4+zsDTtviI7
	BBDiM2KTNF4qzbNibyvnIIZjKBTvWezufuGNDBU/OGVDPrcwQg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--20.046400-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: FE941D1929ED930E601DE7838AC96909C3157F985D56EA9555CF3300142C5FA02000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT061:EE_|DB8PR10MB3292:EE_
X-MS-Office365-Filtering-Correlation-Id: 34705b3b-1510-41c7-2eec-08daad093020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	smKUQ3dt9pvT4bNPOvmqUPKnelAzoKiqy/4EUzD/PXAAF/dQFoKaL4A/1RHJcLSxeUVjt8vGyK3tfrWKcqKNgmc5RdVu2k2foQzYT9LWyOGt0uxAcCeZukW/9DR61sAnk8jV6nYGO9H1Kg6e7+a2jSOq9x1S6+YMSJj7eaextn331s+Ztg+PCUWxo5YHgL2rg76Qiy1AJBnW/o40cDK5BemmPatVMfFxIDRBewtFvYXKs90Y6DVq0jTUjciIvhYDXI+hLjzdSYVI6KzT4cw05pjPsD5VR3JaiA0NIQyEJLRzBkgkZdKs/2fEvXppBSGNo7J/jsYQdryDhqMrJbZJtX2I57IObIsVaMWd89t2cSoFIogwO1b38h5QFTfykI8onJwdP3M6JzWuzKyOdDMjLEwiiv0H2tODxIUkVmvkeOU03OrFXw2uqSyvRvmt+kKknDcIYMS5IovTUFoUylW56guguzBUetg0vlSiktXF4fw/9fcAaBq209fdUmiui4UUEhp9AM5rv7RPgKliOu5oM0Pzm3NvihsMZOAHTM1NiVb2Gb4dSjnvkiqUtB94TIFiG5plHf9Eq7qs3SiGjHv6S94WbFsDau6c47sgKr5henQsiGkfYrlJq7HgeqKMxdbYC2TF/9ON4I56S19a+Thol44q+GMlBCfV2RsPm5vfmIieQI6hwJrnUikq+lK1PKuBFGd7z5vUCY/wbUEAj0TN4S7YuWJcxjnR6CpFEp7fFGsFJMV/Akc47bI3PwMfFsJZjFWc5FzFz0pBh426MwXNq/w1wHWF+uvA9JV5f91TQXldxtSb2Vfj2A6J2bk+ley/ncU+JAKMxZ5NOsmzrhzUI5FJyrafZ2c+/8Tfo773zl4=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(31686004)(2906002)(4326008)(36756003)(16576012)(44832011)(40460700003)(5660300002)(36860700001)(54906003)(82310400005)(110136005)(8936002)(8676002)(41300700001)(70206006)(478600001)(316002)(70586007)(107886003)(2616005)(26005)(31696002)(53546011)(956004)(86362001)(81166007)(47076005)(83380400001)(16526019)(336012)(82960400001)(6706004)(186003)(82740400003)(356005)(40480700001)(6666004)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 10:53:39.9074
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34705b3b-1510-41c7-2eec-08daad093020
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT061.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3292
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Oct 2022 10:53:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9752

On 13.10.22 12:16, Moessbauer, Felix Jonathan (T CED INW-CN) wrote:
>> -----Original Message-----
>> From: Kiszka, Jan (T CED) <jan.kiszka@siemens.com>
>> Sent: Wednesday, October 12, 2022 6:20 PM
>> To: Moessbauer, Felix Jonathan (T CED INW-CN)
>> <felix.moessbauer@siemens.com>; cip-dev@lists.cip-project.org
>> Cc: Gylstorff, Quirin (T CED SES-DE) <quirin.gylstorff@siemens.com>; RC CN SVC
>> Pluto <pluto.svc.chengdu.cn@siemens.com>
>> Subject: Re: [isar-cip-core][PATCH 1/3] fix: add missing class dependencies in
>> image_uuid
>>
>> On 12.10.22 12:06, Felix Moessbauer wrote:
>>> The image_uuid class references tasks and variables from image and
>>> rootfs. By that, the class has to inherit the other classes to ensure
>>> that the components are available, independent of the overall include
>>> / parse order.
>>
>> Just for my understanding: Is this more a theoretical issue, or did you actually
>> saw errors because of where you included the class?
> 
> This depends on how you integrate the components.
> In case use "include" the recipe that uses the class in a recipe that already inherits the mentioned classes, it works.
> If you do it in another recipe, the patch is required.
> 
> During my efforts to integrate, I actually ran into the issue.
> 

Ok, thanks.

I've applied this patch now, waiting for updates of the other 2 only.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


