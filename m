Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA900C433F5
	for <webhook@archiver.kernel.org>; Mon, 14 Mar 2022 05:56:44 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.66])
 by mx.groups.io with SMTP id smtpd.web09.23513.1647237403154021926
 for <cip-dev@lists.cip-project.org>;
 Sun, 13 Mar 2022 22:56:43 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=By2plvnA;
 spf=pass (domain: siemens.com, ip: 40.107.20.66,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gx6B7vj8Y9ZN4kR/lcahtOaiD6Nm/uoRqI7T4aSpLR7V2Tq62xBek5upZN8q5vHj4tD+pirYZXe8kFZNuA9Ojtx2hqTafME8rPa/O/y8/pj5Yk5YbDid0MJFBRZKEkyEfj1081VHgHSosSWBbkoz+RJRGS+J47meclcdw9vDqja8x7qlxeGksnlG4r07zwtwlIBHL2NC4zwzUAKzPeeKAm780QtGA7YC3xXoTRnPzAWt23jYiA+vp4WkkDMOvm+GNgtwv3stt5/JStKmZgvBoM9R7xpJt/VT/YrdzK8GivSRZeGAQHjycut6+5b9wyhgKdFohthEgdznMhTLzv3yuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ibGsfg7eqAAUlkF8iVNHR5cjYtdpIqzmS9wkkaFrQJU=;
 b=oLjv90M2ZeYmuRNwxm7CPOKypcEyhEXq8f0ZqUFN1T+svFchnHuOK/NbCh7QGaMs7RIaccRcGBW5+MxmShmTP1ZmHYk2KeYz/I9QKploX6I/KgZSo518e9uRV1mP+0jwFIKl9hS+OgpvsSKwrhDUPhXStaO8S8o95XGUlmfkwFKhxQtQ9sPfMHEpSkwymtvGHVKnuwqs7dVV9IvrPUTixAAwQxW5byS7OdoVo5v6MBDZpT8Q85nSvCjWPeYXVguE/cn6SZHEp99UUJxzkgy9CcA0/79SYj7QijUOAu8+PgJC8VP8AsRPW9NJRxi6JZflBYu3hBouQQ3VPfpCje9LmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ibGsfg7eqAAUlkF8iVNHR5cjYtdpIqzmS9wkkaFrQJU=;
 b=By2plvnAQiQWp0aEc2gAjpaw6QU6crEwIKBWGssL/awZImQe9S/oGe62I93v/uSGxu/bCIAP4BFBaX+1RK3gIbg8j1/QX4YFb5Q24xAcgRpkyQSvL0y2ysRigYkYGKyT0goWZh4hgfk/TtzIPbp1zkpLn3UdJ/EzlaCTTgDT/c4sFf0edOG3lmTRFyjQNWw7yWugGyLTirVGG7zIVt90wxQg7h4N3IPB13SGkQwfkZkJZadg4rV5rBh4roSA2cStGiSBhhfKnQC1q1nfRH7CVSiHBQLCRH1qJKZ3bMzzkgcrAfDsDyD9OZIotA+UQ0wIEm82ippa2q1HKu7rkIX2cg==
Received: from DB3PR08CA0027.eurprd08.prod.outlook.com (2603:10a6:8::40) by
 DB8PR10MB3465.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13a::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.25; Mon, 14 Mar 2022 05:56:40 +0000
Received: from DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:8:0:cafe::75) by DB3PR08CA0027.outlook.office365.com
 (2603:10a6:8::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24 via Frontend
 Transport; Mon, 14 Mar 2022 05:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT082.mail.protection.outlook.com (10.152.5.169) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.10 via Frontend Transport; Mon, 14 Mar 2022 05:56:39 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Mon, 14 Mar 2022 06:56:39 +0100
Received: from [167.87.72.30] (167.87.72.30) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 14 Mar
 2022 06:56:39 +0100
Message-ID: <ee5fff6e-1810-9f77-28bd-08bfe3e2717f@siemens.com>
Date: Mon, 14 Mar 2022 06:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard: Architecture
 independent installation
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <Jan.kiszka@siemens.com>
 <20220311145704.2436726-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220311145704.2436726-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.30]
X-ClientProxiedBy: DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b54516a-5eb4-49f4-5430-08da057f6859
X-MS-TrafficTypeDiagnostic: DB8PR10MB3465:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB34658E4A8B22E5D66CDF1AE0950F9@DB8PR10MB3465.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HW017mGPIOYQ6Q5xPMhvg/CzmouXCXjLo7n+fXLu4h2j3wp52AT2lG5kYQmY3rzvrna2xYWyEb7BmY/Qd6JFYu5FFy3p1YfbUwOJxA/ik2iTetvYpXUS3iMr60371XD8MXCzEI3RnatBQDnpugba8jl5LKUlpxDs0Ikh15v4xSwStZVMXYEeeDBi44Y2xJkEyGsF/+mrhV2CDwHBVDLiHiP1mJ+hNtOAP+7tSx2s5wBirDUGfgc5HBOQmjyMpCAp55O7XUEaa1StR9jAfJ/8QABzOMuYls22VDeHXWZ86/J87GMBI6EzYPFghaHdSsxtnndA5Cz64C46flUuknlZbMynZAWqL54bO7Tkm8SkHtqnMNkkGqKqQF9zIhyb+N1UGeUL4wcqaG8joMjiQp1TEcTGWJJWL6HRI5OhZQybkHTx5Oizn1fBFe6ybeZLmVqFc8ddJwsGB+qBs6D1VcTmM9H+K6onH+1CLEioCr2eAcLqd/4WDZ8xRg9nc0NZumnCabzGjKaAo20lXglgmeRKMFSYxAH5YNB2nM8SqgSUFjMkGs5uIIt+6Qv5wci+mZcXC0e/HyhUn3QNtc5R05HhEo5DeQTK8RLC4H42sMtLtIQNqJwqFMVojSeu4f/6uU/i7EUC4j6pGvjj/25ZGce0WVQBL9LB3NQCIhV4AScUHXnT/YH0EPMKWntJm0Y7Lt1G+Hnjq1yEpSlv+nVmriN6Bj+D3LB3vWBQIS/p/6tXSFR0jO05G6VJpEdirYnCtAin+K0ez502UnGdOa4r05moNg==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82960400001)(356005)(82310400004)(36860700001)(956004)(2616005)(16576012)(316002)(336012)(508600001)(8676002)(70206006)(70586007)(81166007)(31686004)(186003)(53546011)(26005)(36756003)(44832011)(83380400001)(2906002)(5660300002)(110136005)(47076005)(31696002)(6706004)(8936002)(86362001)(40460700003)(16526019)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 05:56:39.5235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 3b54516a-5eb4-49f4-5430-08da057f6859
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT082.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3465
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 14 Mar 2022 05:56:44 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7704

On 11.03.22 15:57, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> Add globbing to install the efibootguard binary architecture independent.
> 
> Also adapt the wic plugin to use the build output.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  recipes-bsp/efibootguard/files/debian/efibootguard.install | 2 +-
>  recipes-bsp/efibootguard/files/debian/efibootguard.links   | 1 -
>  scripts/lib/wic/plugins/source/efibootguard-efi.py         | 6 ++++--
>  3 files changed, 5 insertions(+), 4 deletions(-)
>  delete mode 100644 recipes-bsp/efibootguard/files/debian/efibootguard.links
> 
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.install b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> index 0239953..462fc1d 100644
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.install
> +++ b/recipes-bsp/efibootguard/files/debian/efibootguard.install
> @@ -1,3 +1,3 @@
>  bg_setenv usr/bin
>  bg_printenv usr/bin
> -efibootguardx64.efi usr/share/efibootguard
> +efibootguard*.efi usr/share/efibootguard
> diff --git a/recipes-bsp/efibootguard/files/debian/efibootguard.links b/recipes-bsp/efibootguard/files/debian/efibootguard.links
> deleted file mode 100644
> index 97bab21..0000000
> --- a/recipes-bsp/efibootguard/files/debian/efibootguard.links
> +++ /dev/null
> @@ -1 +0,0 @@
> -usr/share/efibootguard/efibootguardx64.efi usr/share/efibootguard/bootx64.efi
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index 858fcbf..9e6febe 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -59,7 +59,7 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          }
>  
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/share/efibootguard/boot{}.efi".format(
> +        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
>              distro_to_efi_arch[distro_arch])
>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
> @@ -67,7 +67,9 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          create_dir_cmd = "install -d %s/EFI/BOOT" % part_rootfs_dir
>          exec_cmd(create_dir_cmd)
>  
> -        name = os.path.basename(bootloader)
> +        name = "boot{}.efi".format(
> +            distro_to_efi_arch[distro_arch])
> +
>          signed_bootloader = cls._sign_file(name,
>                                             bootloader,
>                                             cr_workdir,

Thanks, applied.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

