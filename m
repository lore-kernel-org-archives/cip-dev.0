Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFB4C433EF
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 14:34:47 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.42])
 by mx.groups.io with SMTP id smtpd.web12.6830.1639751686371042702
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 06:34:47 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=uLGvhTsv;
 spf=pass (domain: siemens.com, ip: 40.107.8.42,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZONNiELF4ToUXyp/H2kMLiKSaaoHvCICbMw9jff88dgQfE1zz7yCSqoDj8inUrNV8o6+1X5Ci6DyF54UcOkNvY0ceV+hpwl1eTsjfShUhP7/p53bnFg4j6sCeoZp1W2jcoPJWbcQpXF49gzXD9MCMGNCaqMxE1WQEhrLzilV4yeI09cQkC92sKr2A18keDkxu2aBhZ/lMQZtDFVDIBArMP7AXXFlUTCqEUSb34fOWpo8L+3OOcjkXQNzWyjIHIA53BuvPx3Sp40ryYdmCNWvqSNSzCArcPH8odzFcFV+IYVpWboaj4Pxy8gFAqHUo3eEEpzdwDRWOL3vwlMTEbPVpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LV9NoVA9yYJq5p2MTMnkqH7uo5s8V/5IfAMvy7JGnkY=;
 b=NJ89xTaW41vvpGAY/tXXCMylImjopcihUv8pX++UrLAqkmf/kh0lCp8D0Hz7EMsr3tAq9jth261MGBZsuvCKrA3DnNFOTugW0RIAwUdjjGUvENrYsZlmy7L5WqZ5n9cl3MD2Ry5tSOC58/Ajh/qdQe7xgLi4cx7qBx9Dj+Lye/1UBrMrphs6AB71G+IqHan2j43q/3j49ZfeIOfRsUaesKtbTAKRN0pzDlRAk2X4X+sMAWjgT8Hp+7SI9ObTS4XpexFJo/S4qKG6K2NMdCAY+ukQpMXHB57/pxAh1X05Nf1GrxdYWpthJ4XYGepbpItDG2FIjj0OVqzsSJGGn030fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LV9NoVA9yYJq5p2MTMnkqH7uo5s8V/5IfAMvy7JGnkY=;
 b=uLGvhTsv8q5DCHxHn6eQlWFDF4GZxpdAULcLjtBYESOeuMNW6eOczOfM3FbpbLMZeVETDAPs/UVF79cIb26HmXZBKTE4qcq5+23W5djhNcZh2Nxi7/fx8MXnNiJQmFc+4v/jsTqUPut7padtbYeGLSW/YwDA7qPoeewr/OggK4CAlZseLlxI6t9/UKCQnJ92ltqBFC4untzspB+AIYV13hHoNMv6wATRVau405RjsE+lMo9+XaZ8aYaArmo4nwpSbQ3DhiPTsoRMVwC9i8pHhjlL5L+8yOo0Tn6RKruyZZchNiGMs+j1/HFi3CeN1fvusufwj12jqAW18/Y8aY7kTA==
Received: from OL1P279CA0061.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:15::12)
 by AM6PR10MB2277.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 14:34:43 +0000
Received: from HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:e10:15:cafe::b3) by OL1P279CA0061.outlook.office365.com
 (2603:10a6:e10:15::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14 via Frontend
 Transport; Fri, 17 Dec 2021 14:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.70) by
 HE1EUR01FT038.mail.protection.outlook.com (10.152.1.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 14:34:43 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 15:34:42 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 15:34:41 +0100
Subject: Re: [cip-dev][isar-cip-core][RFC PATCH] kas/opt/ebg-secure-boot-*:
 Make Backports for OVMF version depended
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <srinuvasan.a@siemens.com>
References: <20211217142229.1211986-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <ffe0f512-ecc7-f9aa-5ebf-02b849357eea@siemens.com>
Date: Fri, 17 Dec 2021 15:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217142229.1211986-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b7d7187-8e61-4d75-e2ad-08d9c16a5dc0
X-MS-TrafficTypeDiagnostic: AM6PR10MB2277:EE_
X-Microsoft-Antispam-PRVS: 
	<AM6PR10MB2277AD18902408DC631EE2B595789@AM6PR10MB2277.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DiZrsM8Q5vRcgFDuomMqlfKVgwTH1RMmyVej90CdsRFgDlwNZUK0dYTzFY75HL33Igc80ruSPJI3fn5pl14p673WTN/sP0+p3gXRqP8LByACXTki+KS2Fo+eW2OwlQBqkx+NRYlZu8QRu3X390Rm5SnEhKT1hJnNunX4Gg3GEnBfZ3MVm4R9HwGuB873urrD348ifSGOgvUHavFvgoVAJlEvSig1M9wB0J1F5+vO+gEKdBOuQPMES8DURMNAlzjwGeKYHT+OtX/Jf4necPuAYIyfsMPAvPh4Ru3qItqURdXWy3cZFaAnEL3guwrD2YVpI0T4i+EcBiQx9mbdFhY9v+VoHboJUEtOOZUS4UA35osOgx9AsG3+VM5OeKDSDRi4ntPB2sOVDZJP730E+oP4Z/sGhkhkao+bhax0yVGqGLbwEJ8vVGEDgiLNt2cUo3rOi6T2k4bWS8Eal6HNcqDi9lhVTd+zaZsLIb77F/3V8+PiLa4brJJ0YxcAJS/bfyJ1f0Nj9SkdqO4CW7wSSdpcJv4Q2I0F8uVX5dBOXzpSO2FjlOafQTHd4+S3tSSm9MyI3/8HckQT6WYtkY5e4ssnUyVED+Dwe7YFQPG3Q1oBWr/vpShLOQjAZycRTkogD4KW1Ns1F7q4zRA5sPLJAh4U40MsKQju5WzjhfdswWHD1EpeOT3S+7OUTwKpMUFEBed/BWPKka9K2UIlS+GsuC/CgIcmhIFGn8w28L6rByEEyxMPYyi7hgbpJJtQbJWhTNJy8JTAXAnmRyZADOGRQ0WPFEBjd9rn/tA/H8aUUpNkTjOTY86Wl/PfZeZ0+wl6CmCJcks22TmiJXvVW1uGrWcpGA==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(70206006)(70586007)(16576012)(86362001)(356005)(31686004)(47076005)(316002)(110136005)(2906002)(31696002)(82960400001)(7596003)(82310400004)(7636003)(36756003)(6706004)(44832011)(6636002)(508600001)(53546011)(83380400001)(2616005)(186003)(16526019)(8676002)(40460700001)(5660300002)(26005)(956004)(8936002)(36860700001)(336012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:34:43.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 9b7d7187-8e61-4d75-e2ad-08d9c16a5dc0
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT038.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR10MB2277
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 14:34:47 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7182

On 17.12.21 15:22, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For Debian Buster we need to backport a new version of the OVMF package
> with contains the necessary option for secureboot with qemu.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  kas/opt/ebg-secure-boot-base.yml     | 6 ++++++
>  kas/opt/ebg-secure-boot-snakeoil.yml | 4 ----
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/kas/opt/ebg-secure-boot-base.yml b/kas/opt/ebg-secure-boot-base.yml
> index 8f769b6..5a3d751 100644
> --- a/kas/opt/ebg-secure-boot-base.yml
> +++ b/kas/opt/ebg-secure-boot-base.yml
> @@ -19,3 +19,9 @@ local_conf_header:
>      IMAGE_INSTALL += "initramfs-abrootfs-secureboot"
>      SWU_DESCRIPTION = "secureboot"
>      SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG = "secureboot/swupdate.handler.${SWUPDATE_BOOTLOADER}.ini"
> +
> +  ovmf: |
> +    # snakeoil certs are only part of backports, for Debian 11 and later the are not necessary

Why moving this block here? It talks about "snakeoil", but the related
file for that is below?

> +    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> +    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
> +    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 807b0d7..9a3ff94 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -32,7 +32,3 @@ local_conf_header:
>      IMAGER_BUILD_DEPS += "ebg-secure-boot-snakeoil ovmf-binaries"
>      IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
>  
> -  ovmf: |
> -    # snakeoil certs are only part of backports
> -    DISTRO_APT_SOURCES_append = " conf/distro/debian-buster-backports.list"
> -    DISTRO_APT_PREFERENCES_append = " conf/distro/preferences.ovmf-snakeoil.conf"
> 

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

