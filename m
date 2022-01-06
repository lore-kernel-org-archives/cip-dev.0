Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6156C433F5
	for <webhook@archiver.kernel.org>; Thu,  6 Jan 2022 14:12:32 +0000 (UTC)
Received: from EUR02-VE1-obe.outbound.protection.outlook.com
 (EUR02-VE1-obe.outbound.protection.outlook.com [40.107.2.70])
 by mx.groups.io with SMTP id smtpd.web09.9160.1641478350714785415
 for <cip-dev@lists.cip-project.org>;
 Thu, 06 Jan 2022 06:12:31 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=dvc+8WI9;
 spf=pass (domain: siemens.com, ip: 40.107.2.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG6/gudSWN+atYaHqzcSZayysENK5YoqAqdJ46UqzgW+L5pcOVDEYVtRX3Y1CHHMU1i2l5ELez1cr3tI6+tcU/7QGUxI3fGS2Pajdi4gWFIo1a5mC6R946yVAJxrNjnh0VkljzAviwKm/1XfVtwehdbnvW8N6tNINSPATz0do4Cn0oCuhK8wmHOexRQ2nM2eKaPZ5/TW/+pjvzkrhWTXLFTT61hxvK1p6Y1pJt2bI2eKEA8Bj10mm/r3JtESBdBqNClOUZBGorWK9zCIOW6yAFrfmFoY+YtENqeCyxFJ+HpQKeCRNVyFg7jeDLb8NqRXl8hUdBJnTi1Lgq/In6E/qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ypt6evbHsEMur7hbEg3IKBsgwMZ8d3tV7EptDkZ0YPY=;
 b=CZpY/fpcgBCpBxDNODNb716GZyLoE6N8Pbpmd61Zhc3jQlTD1abUWd/lV4jFjPTDP9YYKeDq6dI0BJtpr8KoO6dsHJvPog2hecBWlR+NIsYHYHSQ7d3koCq8xrmj2iTDc2EkAYsrQwlsAsC0l66TgqdSymkFcZ/sZmhsFUSf27P45Yg7TWS66b2c+ZdU8vJOH94GZA82Fs2i2pefcrligUekcn3eYlKj0WSmmW1rRtbbew8YFwhzpvL0cTf+a4WH2KmOWrOomMU+NfeMerfMXQRe9nrVd89WnM/MBeBMpNLoQNKzJrT0Ij1T60R7EDR2klg4fLghNvofU7pJ6q/vJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ypt6evbHsEMur7hbEg3IKBsgwMZ8d3tV7EptDkZ0YPY=;
 b=dvc+8WI9WMUoPz2gevhNyfn3Lld9m3V+Xli50SywhhCtnh4+I53IA2P2BNIPCDBMPDWoy9gXMZQvoqJb0OVXdwVD+o/h0WZVRxRSdNKeq+f/Cl/R7BQ/oD8yIR3e52Rtw7uRyzFSLZUoOVLiLogbRNk4sej0IxDhezuQsaUbtmYDL6YrSGP6x1m05fnohReyVwWKAXihr+5R3wn4R/8bHgPgmfMPmY+7wGUYXtA0i/nt1+bYmPee9GiaRS7kCWLp7H2utiCTnmLell1RZpIihe1A4bUag7dcB6RAEJYRBqGBEWMxLsfEmReXf1j1sj8tS5yNvw3UW6jtouiTn24Lmg==
Received: from AM6P192CA0096.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:8d::37)
 by PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:106::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Thu, 6 Jan
 2022 14:12:28 +0000
Received: from VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8d:cafe::ad) by AM6P192CA0096.outlook.office365.com
 (2603:10a6:209:8d::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Thu, 6 Jan 2022 14:12:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT017.mail.protection.outlook.com (10.152.2.226) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Thu, 6 Jan 2022 14:12:27 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 6 Jan 2022 15:12:27 +0100
Received: from [167.87.72.7] (167.87.72.7) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 6 Jan
 2022 15:12:27 +0100
Message-ID: <c8e9fcb9-eded-90fb-98cc-f766a7a9fbf3@siemens.com>
Date: Thu, 6 Jan 2022 15:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [isar-cip-core][PATCH 4/4] enable cip-core-image-kernelci
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220106111614.218823-1-alice.ferrazzi@miraclelinux.com>
 <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220106111614.218823-5-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.72.7]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a3dbbf0-8a3d-471a-9602-08d9d11e9213
X-MS-TrafficTypeDiagnostic: PA4PR10MB4464:EE_
X-Microsoft-Antispam-PRVS: 
	<PA4PR10MB4464036F7EA14EF126AFBEEB954C9@PA4PR10MB4464.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	a1MNPflI5O8jwRGlLEmMIYKBKtydXo7q/47AT6kDCWyTOvNs4sRdctFG/2p2mupr1kCzH94MFn6yhX11hf9Z/5CrE8Oim/W6qB5Xy376zxmfB/023Ag3pmMpx7pkReonjxsl7+dmALdz0WWMN883CxSF77y4N1Im5p44Ja7rU1SMJlYNyPkYeLIm+iHZxogx95oQYe+vB1o2GmcJK+NVdeJO0nAov3crdW3vgeCXyV9LCToE4YqpwlJtI5VJuP3LH/HJMbC1ig1YzMdjFlVdq9GkM+SsK3uwemx52qRxdteKyazlNbHItG7zJB/lgGamDaR5fFTaVoUkYJ3aq9WOa6gMx3vCrIi2NVNBJHka8J0Gxa4Yq/6eZ9qrRGS00KU9ZZDHSfK6soRI/f/QbMIzm6tXPQ9f64nOtscM0dWciah1+gWNgWSqT4Gp46d+/DO4h0/A1ETvOxITYFIIa9177EmB/4PESgMGBxxfl+gUjKeyr85//yAR4zjIpMyVQTJ09NA92hWv9nAd2I6NuOUHGd9gQNud8R/FRFL4tcPhvigyFJ+2C9iz7B85XSdVlIBuMgJkYhPYn6ZO2kWSITbZ01cUhcJa1Xt1p5EmiRzk02Tovl36hH83fAdenvncrt5fMpSfrtb+X6Y42KW8pipc6+EiqGHfyXd4GNi6hfr8xQ5wDLHN+derHOssQ9pKOuDehFuiVNIRRsIHZyGDlYc9rSDrinFUYxld8CpKBZe2kwX0wH+0qXJSKCmtMY8F1BKRSS5CuFah7XMcrZPKfEVfhAvc5L4Wjl3Y713U4Hhys1iKP5dlY6efs9pbslLuCekAG/wBw/GFSh9W5r0C3C6dgFoDd4TAQoV7dvjm4owHPMY=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700002)(40460700001)(82310400004)(336012)(16576012)(956004)(70586007)(31696002)(36860700001)(110136005)(8676002)(44832011)(47076005)(2616005)(83380400001)(36756003)(356005)(186003)(86362001)(82960400001)(31686004)(2906002)(26005)(53546011)(8936002)(6706004)(5660300002)(316002)(16526019)(70206006)(81166007)(508600001)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2022 14:12:27.9148
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7a3dbbf0-8a3d-471a-9602-08d9d11e9213
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT017.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR10MB4464
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jan 2022 14:12:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7334

On 06.01.22 12:16, Alice Ferrazzi wrote:
> enable CIP core image KernelCI to be built with gitlab pipeline
> and uploaded to the KernelCI storage using KernelCI API.
> enable cip-core-image-kernelci to be built for amd64, arm and arm64.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>  .gitlab-ci.yml | 40 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 39 insertions(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index e7db8c1..784343b 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -9,6 +9,7 @@ variables:
>    targz: disable
>    dtb: none
>    deploy: enable
> +  deploy_kernelci: disable
>  
>  stages:
>    - build
> @@ -37,7 +38,8 @@ default:
>      - if [ "${release}" = "bullseye" ]; then base_yaml="${base_yaml}:kas/opt/bullseye.yml"; fi;
>      - echo "Building ${base_yaml}"
>      - kas build ${base_yaml}
> -    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi
> +    - if [ "${deploy}" = "enable" ]; then scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${dtb} ${CI_COMMIT_REF_SLUG}; fi;
> +    - if [ "${deploy_kernelci}" = "enable" ]; then scripts/deploy-kernelci.py ${release} ${target} ${extension} ${dtb}; fi

Does gitlab-ci forces us to add that closing ; to the last-but-one
command? If so, better add it to the new from the beginning.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

