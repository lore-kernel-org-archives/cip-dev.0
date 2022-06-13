Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB96C43334
	for <webhook@archiver.kernel.org>; Mon, 13 Jun 2022 09:30:45 +0000 (UTC)
Received: from EUR03-AM5-obe.outbound.protection.outlook.com
 (EUR03-AM5-obe.outbound.protection.outlook.com [40.107.3.54])
 by mx.groups.io with SMTP id smtpd.web10.3750.1655112644287550537
 for <cip-dev@lists.cip-project.org>;
 Mon, 13 Jun 2022 02:30:45 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=GbQoeJeX;
 spf=pass (domain: siemens.com, ip: 40.107.3.54,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bvqx8l0GWKUR7u8Z07hz7Y0G8HLFvlyfkUegoFojYa6RGjzQCkIiXyWCeeITkEhVMIgUzX7DfYoLcFVOpckcMr0NvCyfqKejHXlOgsXOJNFskBAsrtNgWrO3t6wsQrNVpPIXLnN2WCdnaMbuXPwD1IOSuHvU99Adz+bO0HAYH0Ivxmx37QYbu9qfAq11OwYxNPTiy179trqPWAsOj1Fy8ozxwhETAaBveb9f+XGWnUo+UG1w8rd8+yZg3jDa9Gnq8agE5buwMiAnewlkih9rIwVFmaEWEumRzxqZ11LzanImAmRp+phIuZifeIyt+KvO0BQJCZIl1zfKtcfpsgYXbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YwfuS7uZyYlLzwsXhW8TVdLVL0lOOuO8UoudemS5Ris=;
 b=JkOR95e75Wov6Ie5CTTX9qNqqgSVQFKKXMKnMHkz7gljvXUdBMTKocMEFofFjWBSCvNpwnbLV7oTP2Sk+ohe4xe6LhieTAGTz7ftHacv+wSpyiAVgR/AiQ/EIVdRr303tDJa8psdk61UZIrPpH+mJWcDj/6t58vhYRx5BUxtmLMwcXwpt42KAF48my2qeWes26Co6Q758Z8E47tcZDY9M8/SrUg59fD0kX6cTWJbazvSwWbGBtOomPoOwElj9mEeHgB/f1Nm/3pR2uhW/PNa66Lj8XREEBEskAFuxIKbTXeb/7y1Y8G3Q6ohRmECv7LknBbwFg+Iicg138buy3g3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YwfuS7uZyYlLzwsXhW8TVdLVL0lOOuO8UoudemS5Ris=;
 b=GbQoeJeXgz5WBxqIAAEYwOB93Ty2PgXpvjwrIfNmExQI9YRj4IrOPr2+KHw+aJlYfu+5BJMsP/NJWzr32qmMwNM4nPixB7a6E5LbA0I+UBUMDx0M3R7/1T2zZy6wqw7eplAus+wM3dbwZUctxlsrM8iCedcQoXk9Vr+oDIRsefcX9UcdJMQYmhb55O3dCNZtCHT5EPvkW+XtOD0M0Qj9xmTJD4Q5/YaWmcdHUupMpEY0l4DV6aEC6VFdu1miRroNv3YAF/H30K3Ma9kpe8KwcS4YWm52mbStsiRTyd0WHikopqoV7zykFO+Zur/AHZfoptdVNbP7zH9zIebsw53hqA==
Received: from OL1P279CA0043.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:14::12)
 by AM7PR10MB3605.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:13b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Mon, 13 Jun
 2022 09:30:41 +0000
Received: from HE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:14:cafe::1f) by OL1P279CA0043.outlook.office365.com
 (2603:10a6:e10:14::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 09:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.72) by
 HE1EUR01FT090.mail.protection.outlook.com (10.152.0.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 09:30:40 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Mon, 13 Jun 2022 11:30:40 +0200
Received: from [167.87.5.173] (167.87.5.173) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Mon, 13 Jun
 2022 11:30:40 +0200
Message-ID: <de736daf-c94a-55dd-7f1b-bf0a284af6e7@siemens.com>
Date: Mon, 13 Jun 2022 11:30:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH 1/2] .gitlabci: add qemu-arm64
 secureboot and swupdate
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220610072524.910925-1-Quirin.Gylstorff@siemens.com>
 <20220610072524.910925-2-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220610072524.910925-2-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.5.173]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--12.713300-8.000000
X-TMASE-MatchedRID: /RB2PwB13wM5QaOxwNGfvo9bHfxDWoibLGmmJTL2jhwD2WXLXdz+AfG6
	GRFYrbYY1uAUoTXqv3uZ3hjEkMd3uNFChERArRPndi/MkERaqKSgemJNshdGjhRROHBHC6aTIiT
	d2l7lf6H/NxYRh4WZH1HsYDQ6MXSWl5arMr6t6P3Q2lMrz9wQrpXvqupO0P3ML8y5bOx03xnLQx
	8PUawjW5soi2XrUn/JyeMtMD9QOgAGJ4JQFnQmG7ew1twePJJB3QfwsVk0UbtuRXh7bFKB7lELe
	3uvz3xkMmeWSNrWMKyHnOsYzNAmuFB/YnrvxZnhsBTJSD2iAW0=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--12.713300-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 24D7B8B15ACEBE430D028C8A611ECA180C759A9D2BAD56F496E9B85DADAF13132000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 252302fa-98b5-4111-89a1-08da4d1f6206
X-MS-TrafficTypeDiagnostic: AM7PR10MB3605:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB360578D7D4510B3DCCE63BBF95AB9@AM7PR10MB3605.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	PavQeRJeLjcHudDaNchEVRw9vEyLU/j65UUwtEyoaVc+c5qu0T53TRQkSglF8ZBqDs2IL8wFNqe/k+IStzhM3BfD6w4xv0am3Or7wV2pyGvQPcat8DVnOmwhX+RWRHw88DWVu+AUmTPuZuL1Gn2TJeni/cf1C+Fthw2MPtn2hSOSI83/g5aGGbk/bX8QuRvQk6V3c5lN24JD8GoZ+8QGJyPT/7toGWuPM43swcGrul5whu3vTLeOri1XmzsxMcTlKhGtIU8pjc2WV9Cw59neafePLmT5tk1kjkjmmLQ/NGh/Epj172X8zLddLhTUwMeOLVk8P5qiRDsQQyps1EhIgFFBn8yexP4hHmbxHw4N0RHfmG5V9UNEOpKQPyG2USY9uuxHImX4dWqD6oS22Nz4K+6aFXnAOY6DDjDy8pltBcmt265QBkUAKlGzziLMNj/HbaFtOzGFHVXXPrmc5LVLeIUtk3X772KBZIT9Kyi7RjZkkQHWZmtZe9Kk3JP5g5KqQPeitaZoy7wy0HOY5Y6iS4mxTScpc73UNjNldbEXCcIBOdChUcIZqWO/NFriaw4L2USBqbEsucfMj5Iyajq6U3QSdC+mBL1YFqCv2VexY3Z6qKNJIj26xdeWXIkaulWtWPV9D7nEH3oV9aLSOUIGxMIQEU2Nsy2ksXaApPCNpmvFD2EQQFFoCbIsTJdWilluP2XXXvsuQVN1hiHlxepNB3KNsKMWCf5s73cOudDLew8vhUdorcOTCPuXJE/ccx/6a/i3nDBWkETc0VwMoIo+jg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(81166007)(83380400001)(40460700003)(316002)(186003)(53546011)(26005)(16576012)(16526019)(44832011)(36756003)(5660300002)(2906002)(31686004)(70586007)(70206006)(508600001)(86362001)(82310400005)(8936002)(356005)(82960400001)(47076005)(36860700001)(336012)(6706004)(8676002)(956004)(2616005)(31696002)(110136005)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 09:30:40.9485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 252302fa-98b5-4111-89a1-08da4d1f6206
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT090.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3605
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 13 Jun 2022 09:30:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8547

On 10.06.22 09:25, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  .gitlab-ci.yml | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index 8545a66..23ab1cb 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -218,6 +218,29 @@ build:qemu-amd64-swupdate:
>      targz: disable
>      deploy: disable
>  
> +# secure boot images arm64
> +build:qemu-arm64-secure-boot:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-arm64
> +    extension: ebg-secure-boot-snakeoil
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: disable
> +    deploy: disable
> +
> +build:qemu-arm64-swupdate:
> +  extends:
> +    - .build_base
> +  variables:
> +    target: qemu-arm64
> +    extension: ebg-swu
> +    use_rt: disable
> +    wic_targz: disable
> +    targz: disable
> +    deploy: disable

I think we can skip the second test. The non-secure build variant is
already sufficiently covered by the x86 build, and the non-secure u-boot
build for arm64 is not too special.

Jan

> +
>  # bullseye images
>  build:simatic-ipc227e-bullseye:
>    extends:

-- 
Siemens AG, Technology
Competence Center Embedded Linux

