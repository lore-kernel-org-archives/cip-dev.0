Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED76C433F5
	for <webhook@archiver.kernel.org>; Fri, 17 Dec 2021 15:18:13 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.74])
 by mx.groups.io with SMTP id smtpd.web08.7359.1639754291519092396
 for <cip-dev@lists.cip-project.org>;
 Fri, 17 Dec 2021 07:18:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=WWl0PfgW;
 spf=pass (domain: siemens.com, ip: 40.107.14.74,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLz/DH+psVLQunGOgLa+SsFh+DFZe82vsOMjMYaHtsmEaXGNB6RA5wXlyPwN3XO4nryVPH8SclbL0t7pE6jwc7c2vkw0Wz4Yx3/dW6h4hJjYwwUkfQurdI4xXuYbiaRHEfssAfdZCmuT7Ywu8rwV7capEHmCN/p0ddSxz7jGIGDIx+B1gHyujpn3NrK8JjXLnqfMKdZkejbiBAl2SPuKW+suEmAEdjm1rW4d9LZMiOQyYv51hKgpVjFRn/y0yCKcWMcg6KB5ZeRWI8oXhqHSD3Hm3WRigoGfGrPVhmK9A2xQ6hzEW1hxwzjRnDLsSz5e3XX4TwzfctIIdJGnFjS1rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aqz7c+emX9+3LVeRQZEKfritx+2sqb0tRqB8U12t4P8=;
 b=oGjcgEQD2lk8RjaLOhNka8eIsSVL6B7k0YakPqnDH8b2C0xih1WHtMt5Da8629hgIo5boSeGTqLpMX/N5hZjVkdXgVTZKyPJ87EKeZ58B42o4NKhhb8s8H8WuaPIyxZhp6GefDFZpy+J3KFdBdhaBYhsz77qExmhctWGm1YD7NIKuaz84leGSuTLjXcwl/69F/SNNsN7Xl7iwlKo70RNh7h/JN1aIuP1xUWgh7e0Vq9h3FI12ClWsAGLTXYx7jpQCXzuLGfguhE+G9hun64A3oDprM5/5N+R9i6hfVtHIWM2erdqmqSmBz7YOjyx9bR4OCG2TJVDdBmzuPLiURjJIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aqz7c+emX9+3LVeRQZEKfritx+2sqb0tRqB8U12t4P8=;
 b=WWl0PfgWtu/3OU81trXFic1EPPvtV9oTGkIHDXNJkxQRcDsZb5BJ2qnEMwHnvo4JtBR4aR/RL2zEXwJ7eBOd2xZ1qEA2SFVC8g8ZQhQJIaMxKK/VoSGk42ilJ9GnICVBRPs+yWlUhGHroXomRIx3xPRSN48PN/Q7XU4QHSxThOKddsDp/kdbayQJwjuCX4FbLtzsDXOUN3nTy8dd24+oI/o2z/pFDYGExX6feTStyYrzjWnNJgvJ+wrHK6sZSP3SOlWCI9TgBewFlDIppzXV5oqQv6EYg772kwRMUN8O6fcROUGD2HPtzsPqOPRCydCR4IvL+Lk07qUb9PBfukImOg==
Received: from AM6PR08CA0019.eurprd08.prod.outlook.com (2603:10a6:20b:b2::31)
 by PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.14; Fri, 17 Dec
 2021 15:18:08 +0000
Received: from VE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:b2:cafe::fa) by AM6PR08CA0019.outlook.office365.com
 (2603:10a6:20b:b2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15 via Frontend
 Transport; Fri, 17 Dec 2021 15:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT003.mail.protection.outlook.com (10.152.2.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4801.14 via Frontend Transport; Fri, 17 Dec 2021 15:18:07 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 16:18:06 +0100
Received: from [167.87.72.12] (167.87.72.12) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 17 Dec
 2021 16:18:05 +0100
Subject: Re: [cip-dev][isar-cip-core][PATCH] kas/opt/ebg-secure-boot-*: Make
 Backports for OVMF version depended
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>, <srinuvasan.a@siemens.com>
References: <20211217151139.1353130-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <eb168c38-8977-ca0e-e565-c19976c6b4d9@siemens.com>
Date: Fri, 17 Dec 2021 16:18:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211217151139.1353130-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.12]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 379afdd0-78ad-4ea2-5f09-08d9c1706e38
X-MS-TrafficTypeDiagnostic: PAXPR10MB5278:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB5278EB3DEBE9EC68AAD1C44195789@PAXPR10MB5278.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	OC9f3lnRN4cNoqU6cr21hUaM88sQCSeZsZpR8uD5sf5NDlsEysJ7+Yx93DYXzFG7vK1cBhI8KYUM1QEcONzaJ+PkdG1O6KB56c9b2cg/Nl8EjQ+MYf99onLj/mm05pMbS1eJIFwpXpcc5zD1M4AtUR3mcd7tbctmUu868W83YmNERd1zDKGyp+5alNz9w0JgsoqoGnlDVvX7pHO7wV3hOLxdLIcVQ6DvjSdW/3fi5uhBlk2eUv2LxKXXiqyrIyuBu3jIPgxsl5a+68AS2N/5BMM6D36j/P6ruLycwuO4p5TVB+klGgKzg/e1rjgco2KM10Ns9NFPdLEXmEOE7aijOUnDnNHBdPZzJyKRgsKS1D2aXufpda1lPLv9FapnsB0FF8xws3w4L8nnetg6i+g1aAzstWZ3RzyaZzu6JdxqlHJuPbPBkXo7edq+0jZCfEfmu1RLvPQJt6I53Z8KOzCd+9vvlgpa+EEFpo5ZMp68tU7Cm2wpHxK3/TPDQHNd9XXSzcrTknW91NmNxEMr/DcjeWm07ghqU4VoM8UO4E4BjJZFp3BGLi30uSiicN/2ou5CtgHwO41uR+uZ8iLhG1sBoMXHYQrNdjQdDViwa7gKNbT7VsBMUSRqxKSe7qw3MjOx6sGsj0K1YabPKLrOygGw1FbVI7X0crLd0zM9J6ZCcWR32UQi12XFOPRO20/ERLBdAxOQRK2EbX6yI4eIuUOKKFtnYiCF0PCDVClrSGHNAJu1VAaLDXNLzLEHiIb7dyvwj/Il55x+cAJPHtHz5x0stX/Ydwjwgi/JfGrF8KJDJRkokVFspHjH+9yOqi2rgptfStPBETiLlSjfZo29yQPiUnQH3CFnRfyNabVcwbbbbIs=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(44832011)(47076005)(31686004)(26005)(82960400001)(2906002)(316002)(82310400004)(83380400001)(81166007)(956004)(336012)(86362001)(53546011)(40460700001)(2616005)(36756003)(110136005)(16526019)(70206006)(36860700001)(70586007)(6636002)(508600001)(356005)(6706004)(8936002)(16576012)(31696002)(5660300002)(186003)(8676002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 15:18:07.8787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 379afdd0-78ad-4ea2-5f09-08d9c1706e38
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT003.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5278
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 17 Dec 2021 15:18:13 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7188

On 17.12.21 16:11, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> For Debian Buster we need to backport a new version of the OVMF package
> with contains the necessary option for secureboot with qemu.
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
> 
> Changes since RFC:
>  - move back to ebg-secure-boot-snakeoil.yml
> 
>  kas/opt/ebg-secure-boot-snakeoil.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot-snakeoil.yml
> index 9f3eae9..5aa5eff 100644
> --- a/kas/opt/ebg-secure-boot-snakeoil.yml
> +++ b/kas/opt/ebg-secure-boot-snakeoil.yml
> @@ -33,6 +33,7 @@ local_conf_header:
>      IMAGER_INSTALL += "ebg-secure-boot-snakeoil"
>  
>    ovmf: |
> -    # snakeoil certs are only part of backports
> -    DISTRO_APT_SOURCES_append = " conf/distro/debian-buster-backports.list"
> -    DISTRO_APT_PREFERENCES_append = " conf/distro/preferences.ovmf-snakeoil.conf"
> +    # snakeoil certs are only part of backports, for Debian 11 and later the are not necessary
> +    OVERRIDES_append = ":${BASE_DISTRO_CODENAME}"
> +    DISTRO_APT_SOURCES_append_buster = " conf/distro/debian-buster-backports.list"
> +    DISTRO_APT_PREFERENCES_append_buster = " conf/distro/preferences.ovmf-snakeoil.conf"
> 

Thanks, applied to next.

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

