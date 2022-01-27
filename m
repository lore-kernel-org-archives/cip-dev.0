Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB0C433EF
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 11:19:11 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.65])
 by mx.groups.io with SMTP id smtpd.web12.26753.1643282349480199462
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 03:19:10 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=SrDo3Ksa;
 spf=pass (domain: siemens.com, ip: 40.107.21.65,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QLvm3KTQN2soHnuR9Z1S+03PiNPDGGoSf8fKya+FI8xhOpYrETvopE3S7bUOqpiaiiM75AvSOaOR9NI2d4egwu7DSk7e84PUrt0gkg/svS1Q9lTEinp4Qzg39Cvc1e5utw0T/6G0l4+aYGJIvAI3KUHOKb06oEUbyxm/XRskB/OULLJTvx1bxE1N2D7+oUlexJ92m6GGLBO9ytDPHl3FHgkr/OMQdIu3y5oHgoQj2OXa8ZMQeAwklyZLHYOabqWYb4aQ2qvmkgDMZG4dvoTFIIyXJsMZnSi14IVt3ZCHVI/em0W0FQKhzHEL5LfgJmNKYR0MKq87MdGC4JddfiU67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeemRb9wf4TVml2otEXMHXlV+mVuGV3cHEAq2G0Roj4=;
 b=DJ3DKRSFL+k24RNsTU32jmC9hcqL7x2Wz9j++2Idjcwub40kg2aPG/wViHe/2Kw43ewgetdmvAkGfpImHJ+/UzjKmLn86bsRHDeZo/r+fgIJWBSmBW/FflUNsyHaNwXL8NALHy1pYHiAFV9GTWBC83DToF+TdSs8oA6tWMr8NelQ5dZ38Gbd9zcOcMHmMB2W1WZM9Q0U4YYnUegNZSg+HWSpT39/G94XXQkURYfWsNvY3sDLleg69RNmTxZIaZXsSCYxUzqqW4Kc63irKk7cZJIPyKFr6VQcB+aOLblsiBGrkNRcHa2y+THrY4UvHRRg/sj2RG74/pPBZP7Z6X6UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=miraclelinux.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeemRb9wf4TVml2otEXMHXlV+mVuGV3cHEAq2G0Roj4=;
 b=SrDo3KsaettDuj4qQAWDgF4Z1snH3Kn4pe7Vb1D7YBFYqpdITo5tAWMwj9sgUvsAHi7JRNmOmmoxWiDIiZI/Hq4oila60AlcgaPc35I59XvOFnNElPOiSuVEuS5WJB/kdnxrgxvdIAbCY4bSy6oIibMKQhdJepISXN93r42WuS18d8zxvCQqKhUzPw3sLT6vXX+5ETsUVUJnVlsPfV1i4KPC7GGAFEEiV7oO+as/VjuIb2fS+8muwBwVU3OrZ0dj69wa27TeSbQSjGLL0HwvgtCAPe8MS2eE5u2n233P6HSW7DLZiJIRWJcxieZwEa6iSPygzTIlqdSRDWi9iIRY6g==
Received: from AM5PR0601CA0035.eurprd06.prod.outlook.com
 (2603:10a6:203:68::21) by AM5PR10MB1633.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:206:1f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 11:19:06 +0000
Received: from VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:203:68:cafe::ac) by AM5PR0601CA0035.outlook.office365.com
 (2603:10a6:203:68::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 11:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT043.mail.protection.outlook.com (10.152.3.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 11:19:06 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 12:19:06 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 12:19:05 +0100
Message-ID: <4493f1b3-6559-8627-0725-faa35aa3508b@siemens.com>
Date: Thu, 27 Jan 2022 12:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core][PATCH v2 2/4] Add dmesg filter needed for lava
 test result
Content-Language: en-US
To: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>,
	<cip-dev@lists.cip-project.org>
References: <20220120125418.236990-1-alice.ferrazzi@miraclelinux.com>
 <20220120125418.236990-3-alice.ferrazzi@miraclelinux.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220120125418.236990-3-alice.ferrazzi@miraclelinux.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5bef25c5-744a-4082-9e61-08d9e186d501
X-MS-TrafficTypeDiagnostic: AM5PR10MB1633:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR10MB16337C2D6655BDCAFE35CFFA95219@AM5PR10MB1633.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	2f6IoGJfAgeL4tIUTOqhxbmFCom5yX+UcXXUGCHr7rfbZu52+Sl+wFHQWrwSelT0yiIuawDtK0HoF5kNHKBdSCsXnGz0tk56dNlUGg9aRGECUApfSwPks4E1oDBNxhlUWiBm6sgUDKWAESpm4Ji9hIPYAhgdE2MaGdr8ZLTVsO2N7nU9i8Kh44G5EnPnZ9fnkUl028SCfJDleRRKsQFrztlSdJVgxZjgN2sgRwqFcFW3WcLsP/UkrBlEU5f8Da7ORdol6IUS9ELxtSXWcxYYi9Jn9nTIGwqKtHOtaM2gBWZe2Ti+TmR0qP9GzDKEbuNDeMpiiQgNG7CMzAbxCoJ3vvQ7genAbJ1PH0mYH3Ur819u5Fam8AmyrhJVgFCnfmRiOs3rfd1edQaNptdSsapGN8J9DONFLcVmvvhhWPBCu01alwRitRC+zfmySz9MI6w3fgZqkuY1EDZqUQm4wqAEX4PDsGFo5xBNLdosjuLZYsSkTbV+EDWnpsS1K1cc4C4mk1QE+jxCo4Gm3q1Tqs/JgldW5HBcnv843MCxv5D9aQyeD1Mwr5pvrlEsuZqnkzc4S9xq+zdtToaEy93Gar0mTNh+fVDbtSgmYYHBFrFB7AJHJYYmCGEDw0w7btFC5Z43Vw3TSSMFi/UleupXJCLrwsFP7L/yRzJwJhEzhjgESGgq12NFURsHQxAPzKkshQvGokv7xlX9FsC0nxXsOwuNH8yF5reECZB/mPF37aiLuP5D3S0Rk/Kzyx8ZkbEOpjYbXUfE6shkyuEa/l7B+lMckQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(70206006)(70586007)(8676002)(36756003)(8936002)(44832011)(356005)(110136005)(5660300002)(2906002)(82310400004)(6706004)(16576012)(316002)(81166007)(40460700003)(16526019)(36860700001)(82960400001)(31686004)(2616005)(47076005)(956004)(83380400001)(186003)(53546011)(26005)(508600001)(336012)(86362001)(31696002)(3940600001)(36900700001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 11:19:06.4687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 5bef25c5-744a-4082-9e61-08d9e186d501
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT043.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1633
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 11:19:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7501

On 20.01.22 13:54, Alice Ferrazzi wrote:
> KernelCI is using a dmesg filter script for checking dmesg
> logs result with lava.
> Adding the script to the cip-core-image-kernelci.
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> ---
>   .../kernelci-customizations/files/dmesg.sh    | 23 +++++++++++++++++++
>   .../kernelci-customizations.bb                |  1 +
>   2 files changed, 24 insertions(+)
>   create mode 100644 recipes-core/kernelci-customizations/files/dmesg.sh
> 
> diff --git a/recipes-core/kernelci-customizations/files/dmesg.sh b/recipes-core/kernelci-customizations/files/dmesg.sh
> new file mode 100644
> index 0000000..3b096e1
> --- /dev/null
> +++ b/recipes-core/kernelci-customizations/files/dmesg.sh
> @@ -0,0 +1,23 @@
> +#!/bin/sh
> +
> +set -e
> +
> +if [ "$KERNELCI_LAVA" = "y" ]; then
> +    alias test-result='lava-test-case'
> +else
> +    alias test-result='echo'
> +fi
> +
> +for level in crit alert emerg; do
> +    dmesg --level=$level --notime -x -k > dmesg.$level
> +    test -s dmesg.$level && res=fail || res=pass
> +    count=$(cat dmesg.$level | wc -l)
> +    cat dmesg.$level
> +    test-result \
> +        $level \
> +        --result $res \
> +        --measurement $count \
> +        --units lines
> +done
> +
> +exit 0
> diff --git a/recipes-core/kernelci-customizations/kernelci-customizations.bb b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> index dca0891..c3f677c 100644
> --- a/recipes-core/kernelci-customizations/kernelci-customizations.bb
> +++ b/recipes-core/kernelci-customizations/kernelci-customizations.bb
> @@ -18,6 +18,7 @@ DESCRIPTION = "CIP Core image demo & customizations"
>   SRC_URI = " \
>       file://postinst \
>       file://ethernet \
> +    file://dmesg.sh \
>       file://99-silent-printk.conf"
>   
>   DEPENDS += "sshd-regen-keys"

This is a nop, you forgot to install it.

Where should that script actually end up?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

