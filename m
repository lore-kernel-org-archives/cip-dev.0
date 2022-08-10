Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1951DC25B08
	for <webhook@archiver.kernel.org>; Wed, 10 Aug 2022 11:52:55 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.77])
 by mx.groups.io with SMTP id smtpd.web11.4643.1660132365341437880
 for <cip-dev@lists.cip-project.org>;
 Wed, 10 Aug 2022 04:52:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=XhJldGgi;
 spf=pass (domain: siemens.com, ip: 40.107.8.77,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHABtoXUW+CvS2sJoGDWzYkXkzJhfCkSKt8AD7nTSLYIPsxMUq8IZrvW6WNZUTvoiCFdEeDCKfW23PNpT1ySHWrK8ObaXQihP1jT9d6NykUMw5zitDYJjbaYgeTQDTuaKQx18zjtfNji2gxPcVVJPEDOevqStaEke+NKvw+3DaVJYSQQPFj+QB1HW9pWMyU8hHrToN3I4G29XQYJOUDsyTg0eO3tfTr5CArpRQ34kJzxeM64t1kGtnmbMV7ocFUaI39JQRGt2JgU5iAs5whzayoe69HaZRLTkZSrqFc2csz2/3icLslyyOnNVH4AK4YK6/iCYGqjaO7QSqjJ8I5PLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1y+RzSLPq0tUxOniMhCee8z3CtBzXIoq6sE45WGJ1xw=;
 b=i53hSvRs6BtyWU9A2yPphPCJuHz1egWYdqGXNer5rl3mVpzeF8uBIrqv82EQ+0ha87I69u0clZDhXJwhUvvG8E7kUjNZsrHJgdbKJgK6/nL4LkaNG9SHw0FFMNonrNRpyN1hUC+r5Rjevk1eKl6tAPWGINe0GoE6Q/SRHGFy0dhb4sPiPGMmbprmVXYoFs1iiw9GUpQsrcf1777aRfVcRF0DCw19mLZdXOYsgqcuZ+nzeeR1vwxAnw004SuRvkMhvDFPL7cU9bVYcfaEl2i/vWiTEUG6i98+lVAEdMXNw+6Tprr38fI8huICWdgGqNM3NGqqTCRLoJ5hDRf+B9++dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 194.138.21.76) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1y+RzSLPq0tUxOniMhCee8z3CtBzXIoq6sE45WGJ1xw=;
 b=XhJldGgimsnV8TkvfRceJ654n1HB1kkN5S/94SC1o4Hx9n2qznNWL5Oh0TiupNSrCFvL6jkKU3zVKlNH95ElG3Csjk01IjR9Wd42VSXIkGUDZ5E1xX7jbv0AcmcNGjm8ZLXLukCHOblEEMu/EBAyNFeKouLLc8+dlKz/xt5Ber4hTa37nDzlAkovlUsQ5+yZd2D8cQdp5RTjPhjfC2ID+Y/1009hrki/iJO3Ss2zgf5LLcrj4O6nfqcnmQKsBPmOccrVyZtN6b6Gy6r4wSIJdieNPryITC7HejZmFgJKRkb8xA992Mi3llMUELPKGuBVtRpE44SFSkXbHIzFzxtd3w==
Received: from OL1P279CA0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::6) by
 AS8PR10MB5903.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52d::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5504.20; Wed, 10 Aug 2022 11:52:42 +0000
Received: from HE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::60) by OL1P279CA0055.outlook.office365.com
 (2603:10a6:e10:15::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Wed, 10 Aug 2022 11:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=siemens.com;
Received-SPF: Fail (protection.outlook.com: domain of siemens.com does not
 designate 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT101.mail.protection.outlook.com (10.152.1.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11 via Frontend Transport; Wed, 10 Aug 2022 11:52:40 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Wed, 10 Aug 2022 13:52:39 +0200
Received: from [167.87.13.241] (167.87.13.241) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 10 Aug 2022 13:52:32 +0200
Message-ID: <47fcb7de-1cc0-e216-a593-4d30c6660c44@siemens.com>
Date: Wed, 10 Aug 2022 13:52:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [isar-cip-core] security-customizations: Inherit common
 customizations to security image
Content-Language: en-US
To: <venkata.pyla@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220809165528.21438-1-venkata.pyla@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220809165528.21438-1-venkata.pyla@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.13.241]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--21.270800-8.000000
X-TMASE-MatchedRID: rRgX50UcFf5o0FBZlmedToldd8VMUiC5/k5m7D0YTS/x5KZMlKYS/dDZ
	1FFTJUymeucl7MdNw8TXrpdvf8fDg5+geJXkbbjWwh3LRR1yoyQu1SW09WHtVlk1hIeTdmvRo14
	v+1uPCQfLkl8e9W70i9tfYcedsMHgbLvleGi9Xh6ptbHNy4b6yrBAQLqGlKivPwKTD1v8YV4dLj
	iwtocA8qY5ZGw7wyeHZBWcixWI3T5fmMtyDJnbDA1q0EW+4F49jl1W6HbLC+FeYVWU5uHQ/EF+Q
	lYpjQppCtWCkj21FWSjxYyRBa/qJQPTK4qtAgwIPO9KPUEX8ztWdFebWIc3VsRB0bsfrpPI6T/L
	TDsmJmg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--21.270800-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 70380880D4BD0F0ED05154C119877AC1421E71271E8C225DAED6DBE27881A7AC2000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4288e3e8-51bb-45fc-8052-08da7ac6d44e
X-MS-TrafficTypeDiagnostic: AS8PR10MB5903:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	UaLugetzTDxcvPbE6nkJEzujuXxrDtccPC94vsn2vnkqK/GQMFaiN8bwd6XKvUHU7nYkZV3sgFWVZ+KzuOoEFzndFp2ozYRpZwOa60yPvickqyGmS2fTN7on9mvzLjgr00d90mj7jksQXIpJ3v3I40BYxjS6GY1Xw6xYzAjeqLHDhhaLsx+Aq+hV4mKZRJvaUvkQ1Icr/ZmOUIb7nZLEF5ds8ow3nizI2JNsCJHWtf1Oro4W+l7HFQF/kHGJR36AG0Lyu2ASw+YpMT0baJ+aoj6eb+GiMDu8A55NbtmypDJS8q6pd/qHLLp1x3Tep18EPFYJ3dbLKpeQmZI1k5G/WDiCaiveynjzuQOs0+OUH8T9Dpg2K38LpzplIClzl2lgVZhr2YTnBTjot3AeDvxRQc1om7lQoMbMCWRYKB9rVAKl27BhbPPeSknmVWP0E4m8AyrTDXn96u/0zrJ9Bq9U4DqvZRA+iX+8GU6/4Lperm3G9su/u15O6RJA1Nc3DawUDsSWrfm6goxuSAvCJpoM5ldmL8wn+sMOcP7Cqfn6/mltuIPtOC0cDHgb++mxbOTo01ZWT97vTqheKogNGc9bMvukZCQaMqJY7ifMvzOQvJ5zds4t1NdsnbZ0wG/e8cEpBNNuXbmfpVhyYRP8w3JSGdhv41CVHDEg0jeDmRIRgotqvrxz38ZuerPrlrqO2/I332FzFnQ+wjKy91i8I1rYFkSrwuGbn7X6Np5eUyoRXggKA2AQhzJ9QdWbyDiJwM/Or1QwztkvkNl/oB0RePN3yOGyAI21z0ZH3MVPreu99D4hO3BFWoJ+ule8rP14zoyQpXFf8yEJi0xzhMT2QYcJKzwVtO2ufW/FuAB9Czp1+Z9eC0VVd5lO73S0bSUTxdLT05ssgrvV1glnPNOMV242jg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(82740400003)(6706004)(36756003)(70586007)(70206006)(54906003)(110136005)(40460700003)(86362001)(4326008)(36860700001)(31696002)(31686004)(478600001)(316002)(8936002)(16576012)(40480700001)(8676002)(5660300002)(6666004)(81166007)(15650500001)(956004)(41300700001)(53546011)(2906002)(44832011)(2616005)(82960400001)(83380400001)(356005)(26005)(336012)(47076005)(82310400005)(16526019)(186003)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 11:52:40.9370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 4288e3e8-51bb-45fc-8052-08da7ac6d44e
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT101.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB5903
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 10 Aug 2022 11:52:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9151

On 09.08.22 18:55, venkata.pyla@toshiba-tsip.com wrote:
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
> 
> Current security image doesn't enable ethernet device by default in
> QEMU target, which is required to verify some of the security requirements
> like multi-factor authentication.
> 
> This will reuse the customization in common.inc recipe that will enable
> necessary settings in security image.
> 
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  .../security-customizations/security-customizations.bb   | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/recipes-core/security-customizations/security-customizations.bb b/recipes-core/security-customizations/security-customizations.bb
> index 4a41d2d..240a577 100644
> --- a/recipes-core/security-customizations/security-customizations.bb
> +++ b/recipes-core/security-customizations/security-customizations.bb
> @@ -9,11 +9,12 @@
>  # SPDX-License-Identifier: MIT
>  #
>  
> -inherit dpkg-raw
> +require recipes-core/customizations/common.inc
>  
>  DESCRIPTION = "CIP Security image for IEC62443-4-2 evaluation"
>  
> -SRC_URI = " file://postinst"
> +SRC_URI += "file://postinst"
> +
> +DEPENDS += "sshd-regen-keys"
> +DEBIAN_DEPENDS += ", sshd-regen-keys, libpam-google-authenticator"
>  
> -DEPENDS = "sshd-regen-keys"
> -DEBIAN_DEPENDS = "sshd-regen-keys, libpam-google-authenticator"

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

