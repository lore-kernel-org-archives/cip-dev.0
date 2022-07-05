Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F236C43334
	for <webhook@archiver.kernel.org>; Tue,  5 Jul 2022 10:04:47 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.54])
 by mx.groups.io with SMTP id smtpd.web12.82375.1657015463702454261
 for <cip-dev@lists.cip-project.org>;
 Tue, 05 Jul 2022 03:04:24 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=MU9iNZx5;
 spf=pass (domain: siemens.com, ip: 40.107.7.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGlLoSmr8ADigRCiP/hxF84V4m/LOMd9AP9Z2lM0BbllE4eCGKnbt4Hn2j764/F3XthbYZnayqoZBsj/iyvGw4KSDKRQcA8t52DWkIwxXdk83w86bvgYKzcsX4uZKxIw4GY1YC+v/PIV6MVCHKxCsNDshVLGYR/5Moe1/TmhG6YCPiv9rZ2j7G4DQJ9Zw01oOklSoKnNIrtV2TvyS9dZxVPJO1tPW+dH8a1lJgjBeThtLeknuUwNVjwArvCMdKLXk1rQinpkAnacXFn1cU94FHSb4vjTGFuH2Ds9zxzCYH7tOgFZYJeyefau+eYz7bVN8ahL6Q1QGlO2RUcnofhXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL3laLHdqd7FYrWiAwexOW8kZ87KXVy+0r7Pkay/r3M=;
 b=MjXjJGiIe8BWGbC8FwasadPh/BV4P8bSsWrsPQimo3WPwCduNd8BazpuKlRwbILwmiANp1vVh3ANoij7kzkSZYzXLQquFAFBVw/dl+eki21NTXPE2hQFZ0gn44uKSMUOINW6Q4MpN8L/QTcEv6zAOWeOuJdg8zem+/McTYt/SZItjNGrNoJTUJ+eLJvsStS0/TP/wm2Aw3DOo2Juvd7DhL/6+M9sH9yAXGmxWw9u81SPUgG+9u0UIiccrXdE/3LRUsW+IlMQrTdE/Ja8J4n2s0GU12b1aP2gev9czrYya0aHsGouYC65N4zXtc2K1/6Ge3uwz7TM4KX1kJl3pvMUpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL3laLHdqd7FYrWiAwexOW8kZ87KXVy+0r7Pkay/r3M=;
 b=MU9iNZx5IWPpVcUDfzJt1HtKNFkFGY3Bt5UHVKLevLMv02jdRtbWeiawgWR7iyoXL9gjWFAbx2aYnPMn8yVOlPzpuoUF9hEAlj1UQ1utgNVEb3cu8N1lM6zOKIIVBlJEySAM6ZYOR0mOWoYthghXlbgrEOFHuYKIi7exAquDBPILAKN7jEtB6Z/VT3TzFFa5VOtwsrmTPINyrSbAUm5t10Kdx8kmxw1jgZjIRpupU/cVBGxDjDaeaj4hkmJCduWt9fYK/j/p8fV5l3F7O7dRg5cRv8XinfyThq/vOBp6tU6aMdVJwyt82zUnQisi4Yqqy4JsGPC58GmCbO00CBt8/g==
Received: from AM6PR10CA0064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:80::41)
 by AM0PR10MB3411.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:164::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Tue, 5 Jul
 2022 10:04:20 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:80:cafe::f) by AM6PR10CA0064.outlook.office365.com
 (2603:10a6:209:80::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Tue, 5 Jul 2022 10:04:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14 via Frontend Transport; Tue, 5 Jul 2022 10:04:19 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 5 Jul 2022 12:04:17 +0200
Received: from [139.21.19.13] (139.21.19.13) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Tue, 5 Jul 2022
 12:04:16 +0200
Message-ID: <458d187d-c6b9-c06c-b2fd-341eb5d6154a@siemens.com>
Date: Tue, 5 Jul 2022 12:04:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [isar-cip-core] cip-core-image-security.bb: Add aide-common
 package
Content-Language: en-US
To: <Shreyas.Karmahe@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <venkata.pyla@toshiba-tsip.com>,
	<kazuhiro3.hayashi@toshiba.co.jp>
References: <20220704164336.3699512-1-Shreyas.Karmahe@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220704164336.3699512-1-Shreyas.Karmahe@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.21.19.13]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.958500-8.000000
X-TMASE-MatchedRID: /RB2PwB13wMwrKi3eh3JIsb9CgEQmMW5Pg9yfk4YC0awWQIt565820rR
	gIJiqlrlit/5bZREJSw5khb3w81T2N7za8Tj4CjmnBwFQhF1u6a4etNObxQ11167ppG3mtjJ0Nn
	UUVMlTKYHZBaLwEXlKGlF7OhYLlct77BIQvK33lq3ogO2QNkus5XvqupO0P3ML8y5bOx03xnLQx
	8PUawjW5soi2XrUn/JyeMtMD9QOgChMIDkR/KfwBMQLQ/0+9hG3QfwsVk0UbtuRXh7bFKB7j5Kh
	Et73BI+mNq5Zpv6m+ELdYjSOiYLS7l41UCvZOhRNkUSDDq742k=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.958500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 7D7FE3983AF193AC7D486097BFBC091167B7BDA7F6B33BE122E1D8CD5B3981452000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f9839a0-6e3b-4315-c28f-08da5e6dba6d
X-MS-TrafficTypeDiagnostic: AM0PR10MB3411:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	CeNGnmjY1/BEq5Igc7z/3J4i8P75YA5fm52PySrjr23eR3BiKUqH4GE7x6cPItOZiclJDuOGYdHYf6DJRPz9Ixs3TFRnaU7Pd/4YD3rmnmvV3PVq+BqItPQrkarbNJ69fdplEhd8vxta1EsSUYQIloQl7oDSJ8NjQaAH/MrzoIOPH0zZ2bO3NHsrn86vtY7YysD8mnptqafjbagpWQN5MKAW5+d9PGP3thSTt/+/scKttAb95L+zI/eJgzFO7LFyLczGEttoBBIiR0CQfTnKlIMckSBti9zjtV2V4Pd/OLeE5pT5XYEkyc9XkMJGHeUUxl/6ykSkFog61V5+K6jul7A+ZHQzYsiJVCdIyhzWljFx4Vut1lD9YiPej5jozFNxAhRrPzgfyrKA4WeoHFocdmrTkNvKL6JebmnIi8nHpy8BoW4027TkZkkl+7CDDm2TJl5/7BYXHHAxMsAKPyIug31Z6iisIOFpi6BkrlBvYsZ07+hHkzMAMUcPP7Ski9uIIhAFNKlEH1agYNo+bQsr6YlShVvfVtAU471zveZk8YsgrB7dbAMjkFCndjLVmohr1y31+jTnZH4UEqHnNmb5SYoCzVpn18fhTUsCf8BitFZ29wn0clnt/7SEFW8mv/CQ0Ue18R946GcWayo/qEy5ayFIVLhhC0ZPTA0YDCsBr+ohRhJzNZESrHinlICVQKrOsbbdET5ARY0f1fwshfnCJWtrWwUmooOAsEE9koPX3g41rKW30gGdnBbwAX8wD5d8MuJu8eeeeEdDZsZFgWcT0nmhq6ObUQvd1Hv7DKg+M52zGNBLYcHOnVSjOTo1uuKF45GOTwxxGmoilPr34jwgegEwhQuL0h/kiDyDWKJnKE4eAnjhsbisccWCH4XlRft70V0BcoagDsgeLUWFctmgv1WIIToqsn2M/21GS5iGENg=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(40470700004)(46966006)(36840700001)(316002)(6706004)(54906003)(16576012)(110136005)(86362001)(956004)(2616005)(5660300002)(8936002)(31696002)(70586007)(8676002)(4326008)(70206006)(41300700001)(82740400003)(81166007)(82960400001)(26005)(53546011)(356005)(478600001)(40460700003)(47076005)(336012)(2906002)(15650500001)(36860700001)(40480700001)(36756003)(31686004)(83380400001)(82310400005)(16526019)(186003)(4744005)(44832011)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 10:04:19.7766
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5f9839a0-6e3b-4315-c28f-08da5e6dba6d
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3411
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 05 Jul 2022 10:04:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8682

On 04.07.22 18:43, Shreyas.Karmahe@toshiba-tsip.com wrote:
> From: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> 
> aide-common pckage added to resolve missing aide.conf file to run
              ^^^^^^
Typo. I've fixed it while merging.

Thanks,
Jan

> IEC Layer test.
> 
> Signed-off-by: Shreyas Karmahe <Shreyas.Karmahe@toshiba-tsip.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/recipes-core/images/cip-core-image-security.bb b/recipes-core/images/cip-core-image-security.bb
> index 3ea544a..6060978 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -32,6 +32,7 @@ IMAGE_PREINSTALL += " \
>  	audispd-plugins auditd \
>  	uuid-runtime \
>  	sudo \
> +	aide-common \
>  "
>  
>  OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"


-- 
Siemens AG, Technology
Competence Center Embedded Linux

