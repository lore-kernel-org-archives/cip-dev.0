Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EDAC433F5
	for <webhook@archiver.kernel.org>; Thu,  9 Dec 2021 11:19:50 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.87])
 by mx.groups.io with SMTP id smtpd.web08.10147.1639048788319058730
 for <cip-dev@lists.cip-project.org>;
 Thu, 09 Dec 2021 03:19:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=ORFdsOdq;
 spf=pass (domain: siemens.com, ip: 40.107.7.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HzfpsJTmcFVMizdbEQhOt+4alyb+pybp3sGh13g+sskYMEXsPovVgOYl4EJIt7XZnHmprYj9LJbyuln3T9tbx6PV8aWXN1f9XsPf+z5EtoVwphXEJV4Ha2N5282kAH7lwY6dkKft0mStOufWO6YBs/4wyyv6QA5+nY1scCPcGXd+zusdkGQLCSo01iy7E7+dbEQn411BsZczd9Qz5oEY7n7nCv/9HRuN9byn5MmAJSdJxPF8Alop0U3SLIvNYKBvZVdldqDZGLMWhRmbf45Exc/QPtV/3VDxkuy4aMiaC1z78j6r8XF8aoqPyvLl1fMSLVkB6+pfuH16YSnX5qS7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1nm7PdPd74+xn8fH5aiCYjLXKCNs6JsdfmZZDJ94K7M=;
 b=ml+b4jTh53QH0rHEehSlaL9dS5ydbH+TdC2D2qbG6aR5v5Hxt3XrFGLJhXmCoFBpJLzTQ9IKbzNGJULL2J0PlHurS/aWK6RehctxvfXQP5neeoMHkwiLUootvb9i63A11+G0PLQkvOu23zjRvQjwREgkfYt1sTielLBp2OZKczzJyTYQYBiLYFnKAN5h7V3shmoNELy8vVforEB1z4bN9nxNMxAMSf1KEEubRai144D2BNI1d7JcUeXXo+7ScjkHAyq2z6o1sn2z4sX8SWPXsEiQMzSwYpW6KH4BnR33Uo8xqWHWL+0XgvPPFkxqDdEnTz/aL4ajFuPeYRXxzSenOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1nm7PdPd74+xn8fH5aiCYjLXKCNs6JsdfmZZDJ94K7M=;
 b=ORFdsOdqzUi8HORZPIEcLH+2UtUL6QFeiBLcmeMJFDjp5mLMQZmJ2PNQYFN5rQbzC4Tj03oG9zLCvSN/vTvCe7Ukyr43gayLm+lw9Qv8FNxf8T9cS6aRnr7n3WsYhLE6pjZVNkr8AwhU0CA6lFvuBHWt8H5HsKGDlejxAAe3Aa1ISRQ01dUkTnoZF4ZNe7QUOtiJqrMvDspHOo5+66P2jdGV2HN6JleWQ2VzyBGwCIBzE0pLOAezb01tguyhAGlZ2FOARMXcLKhxwiPk9ZVhzitbyTkZxK3ucuL4wdOKLuotXUgUEISSByPI0zSoF67djaKhJfZJK8kIovTiQPXHgA==
Received: from SV0P279CA0044.NORP279.PROD.OUTLOOK.COM (2603:10a6:f10:13::13)
 by AM7PR10MB3639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:141::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Thu, 9 Dec
 2021 11:19:44 +0000
Received: from HE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:f10:13:cafe::6a) by SV0P279CA0044.outlook.office365.com
 (2603:10a6:f10:13::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 9 Dec 2021 11:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT051.mail.protection.outlook.com (10.152.1.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Thu, 9 Dec 2021 11:19:43 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:19:43 +0100
Received: from [167.87.72.174] (167.87.72.174) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Dec 2021 12:19:43 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] sw-description: Use Labels for
 Boot partitions
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20211208112827.3121367-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <fdf17dc4-a8dd-c70d-0c7f-9d7e3c3fcd0e@siemens.com>
Date: Thu, 9 Dec 2021 12:19:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208112827.3121367-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.174]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 348a858b-f47d-47ee-a12a-08d9bb05cd1b
X-MS-TrafficTypeDiagnostic: AM7PR10MB3639:EE_
X-Microsoft-Antispam-PRVS: 
	<AM7PR10MB363954AE613EAF7639F8B26795709@AM7PR10MB3639.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	hUCyFO0yUXpo/kyRhJCPkA4OZaTq59aOiGG5YV+XGWhn84CW597bccYwfch/rPoq1BgabDbU5r6dv5D6H0DtmeC5SHxte61XskJWDdLBfq124H2GtDW3GvhOg2CjQDf6oWXZfZbP7orIOfHVr99oen9cZvluJS3MFDPSfn8DWiNKab5XO1gRVReYprGgSgKdaKT+J9E5doWg60OLdkuvFIypqPMJAdMtIR+L5sOYmkKDhFIR6mzw9up+EsxNwU7d0kvSLSquUe4Yu+ni63RTDIZBFRdX4uLFaR6Tc41cypLcaU64fv4sS1/cl/GtoYwlSif43p6Az+NhHo6sJgeRgNqyXUPBfl/J8Go0nLeMp3jvmzbtLa5jbYv+ZkQn8PsQqHGvDF8INZJ092p4I5DM5yfpSd9UJksCRnvSn8BY+qQKJS8e9qglDjb0fBFWI02XAXkNuDiKWeMfcdWKrJqMgRcf5iTpyrpLTonwVRrxMByPlkCeGYH0W3Fx6XSG0zqmt3BV1Ecmr0ovCimOnBs1J7hyMpGPedRzU3k1TkDXl+3PgBCBmAVWeUrjEq5nf6Z8cco3g04NDALAofQxfXUV/mOrriCVnUUl2ScyNBOv1V1EAkcrMHF74S+Z8btI7CLfXFke0zHFwidin3nyWbtjziK383dDyLdL6eW6tvpedqeu+1WU/Ox5pLuoJFWbS1cATDafqVc8J+6kMnm9azXvAkGZqmkX4olCe0oZN20JoXhH7yGGyMI4cat59HKn8TgZWFS39lDWJ85rN72CM4JZdnOKDI8FyDqd8bh20LPp9MUcyCNwpS0kVX1iK6HI7gMBQgvyqLCObjq3RW9CuDxrytoO0BXbTau9mj5nbs0WCQQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(508600001)(82310400004)(16576012)(2616005)(6706004)(8936002)(110136005)(44832011)(316002)(8676002)(956004)(336012)(36756003)(2906002)(966005)(26005)(86362001)(70206006)(83380400001)(47076005)(5660300002)(7596003)(31696002)(356005)(7636003)(82960400001)(31686004)(70586007)(186003)(36860700001)(53546011)(16526019)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 11:19:43.9225
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 348a858b-f47d-47ee-a12a-08d9bb05cd1b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT051.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3639
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 09 Dec 2021 11:19:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7081

On 08.12.21 12:28, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This allows an update process independent from boot order or
> file systems, e.g. if a usb stick is plug in.
> 
> As SWUpdate returns only the device identifier in case of device mapper
> mount point the `sw-description` for secure boot
> still use device identifiers.
> 
> This also fixes [1].
> 
> [1]: https://gitlab.com/cip-project/cip-core/isar-cip-core/-/issues/16
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-core/images/files/secure-boot/sw-description.tmpl | 2 +-
>  recipes-core/images/files/sw-description.tmpl             | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/recipes-core/images/files/secure-boot/sw-description.tmpl b/recipes-core/images/files/secure-boot/sw-description.tmpl
> index 34a58a3..f8e5375 100644
> --- a/recipes-core/images/files/secure-boot/sw-description.tmpl
> +++ b/recipes-core/images/files/secure-boot/sw-description.tmpl
> @@ -26,7 +26,7 @@ software =
>              filename = "linux.signed.efi";
>              path = "linux.signed.efi";
>              type = "roundrobin";
> -            device = "sda4->sda2,sda5->sda3";
> +            device = "sda4->BOOT0,sda5->BOOT1";
>              filesystem = "vfat";
>              properties: {
>                          subtype = "kernel";
> diff --git a/recipes-core/images/files/sw-description.tmpl b/recipes-core/images/files/sw-description.tmpl
> index 3309271..c44c2a8 100644
> --- a/recipes-core/images/files/sw-description.tmpl
> +++ b/recipes-core/images/files/sw-description.tmpl
> @@ -26,7 +26,7 @@ software =
>              filename = "${KERNEL_IMAGE}";
>              path = "vmlinuz";
>              type = "roundrobin";
> -            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
> +            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
>              filesystem = "vfat";
>              properties: {
>                          subtype = "kernel";
> @@ -36,7 +36,7 @@ software =
>              filename = "${INITRD_IMAGE}";
>              path = "${INITRD_IMAGE}";
>              type = "roundrobin";
> -            device = "fedcba98-7654-3210-cafe-5e0710000001->sda2,fedcba98-7654-3210-cafe-5e0710000002->sda3";
> +            device = "fedcba98-7654-3210-cafe-5e0710000001->BOOT0,fedcba98-7654-3210-cafe-5e0710000002->BOOT1";
>              filesystem = "vfat";
>              properties: {
>                          subtype = "initrd";
> 

thanks, applied

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

