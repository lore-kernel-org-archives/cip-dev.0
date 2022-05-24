Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A1BC433EF
	for <webhook@archiver.kernel.org>; Tue, 24 May 2022 15:07:17 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.87])
 by mx.groups.io with SMTP id smtpd.web08.10608.1653404832085717934
 for <cip-dev@lists.cip-project.org>;
 Tue, 24 May 2022 08:07:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=K5FKOA1l;
 spf=pass (domain: siemens.com, ip: 40.107.22.87,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKzLUBcLQBV2s4gxZE1zaAXjdtw+kPcW8C/4fgQFLXVgSvvD8qjAEcS6sVYNFqMG8uFEE9ZorUJHH1zH7PP8GOWwLkB3KdEIjmtury4MOcI78Kx+02AxUsq5Qx1d6wBjGmC0nLeb1ravPK4JjCPX2jM9Bpcf5vf2H9pOhKWLLUIrq08+FDDxrxphMq7/Kb8QJvA77kB3hRs1ELTymI0EDcx5ZKUPjv2Js3BfNCfd4vAb2u72PrTAKSunN201GIo1Gb5P/Gwcl11AE6BIqqoa9NJlbe5oG5nbhYHggiPFm9h/sx6/49VidG9JdQY68tdKt5lWearNxpDhFLK6OD+aaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGORNb2tSqOfZHHzJy9mVGOawXlONzXLEU+n53b+4EQ=;
 b=Ju2qGkvt+FUyVYa99OQTIPjhWxP2LFYhDupAaTjI5C3bnejQXDHQhcVvbzH82TvnjKQ7MkcmuAJWeGjfA2o8p+sFGReWJsFnzObGebrZEC8lQtYVdDI49rCk5q1db9qrTNbAEe16i+GbtYALKMJq0As5ouxiWf04x5CCYe1tbFo/Ho873k5PJIezTUUt4o0hH2WxNj8U8gftJYe9H6aSUJV35mOEgpu3UIZlDKGwkFhT79cjCFtklKQyQBTWCAD6GK+GM8Op0Ko/6/5k9wYHrsWwUbj4grRc/I8tR5XM+p7FKj5jVYV1iZCEmr83MlmVrAvHGr4vsvp4xHKiKyM0/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGORNb2tSqOfZHHzJy9mVGOawXlONzXLEU+n53b+4EQ=;
 b=K5FKOA1lYsbhnAlhyt6Ey4ZDYWZdkGvSl6e/mp4v8hnfqkLDjFe9uCesqnu1afLeflgDFq+y/d51iNd6STb0upuQ/UACzoXkvTOh1YNC4+7TRTF5pBtsf3rmwwcvEELLXQVxbxcIEP6Y4s+XgBCxSqcIrKaCv3TSYiYJIGOqcTrGMW+Y1S/q8m8CXvNpqxqk2MK2jfrXjBeDW+8BHkHOrLXw1I7RFBtmU5dtK2XAvmkeDolt10Ng8bY/GNsxv4rvW2Ydk/RFwqFwcFblU8W6N1AxoXTI8SgIa2lvn0g7O4AIGMmt09nPHRC7qoy0OC1WLDXDDux3GXlBbwki7lfobQ==
Received: from AS9PR05CA0043.eurprd05.prod.outlook.com (2603:10a6:20b:489::27)
 by AM5PR10MB1698.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:206:1c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13; Tue, 24 May
 2022 15:07:08 +0000
Received: from VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:20b:489:cafe::2c) by AS9PR05CA0043.outlook.office365.com
 (2603:10a6:20b:489::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.22 via Frontend
 Transport; Tue, 24 May 2022 15:07:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.73) by
 VE1EUR01FT040.mail.protection.outlook.com (10.152.3.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5273.14 via Frontend Transport; Tue, 24 May 2022 15:07:08 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.9; Tue, 24 May 2022 17:07:07 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Tue, 24 May
 2022 17:07:07 +0200
Message-ID: <8827c44a-366e-59b3-8062-d2d4b1dd47af@siemens.com>
Date: Tue, 24 May 2022 17:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] efibootguard-efi: Use correct
 search path for the efibinary
Content-Language: en-US
To: Quirin Gylstorff <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220524145757.1704927-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.994000-8.000000
X-TMASE-MatchedRID: /RB2PwB13wM5QaOxwNGfvo9bHfxDWoibx1/NuoFDMxRwsULORIYX4ylj
	52CeQMtqO6FzZl3Z4YMEVgRlP8d0ToOiFnLlLKM9PdRKVxuI5P9iWV0DQ85LUrNE9DxPih7lxEk
	sT8U2vYPDQeGGV/t6W3Awi8qlmI2oApQjIaYhHq10ekkMxskO8ZXvqupO0P3ML8y5bOx03xnLQx
	8PUawjW5soi2XrUn/JyeMtMD9QOgADpAZ2/B/Blrew1twePJJB3QfwsVk0UbtuRXh7bFKB7rJmL
	kqMDqmMXB9HeuPchyRq7xY1OU7enLx4VXIfnMFcHIV02d1rpG8=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.994000-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 C174FBAC80A3EF595E70D5BB766D34EB9361747B72F323768D12E6F552A865B52000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27881829-ad0a-4c25-da5b-08da3d971261
X-MS-TrafficTypeDiagnostic: AM5PR10MB1698:EE_
X-Microsoft-Antispam-PRVS: 
	<AM5PR10MB16988372A37D385633A88F2F95D79@AM5PR10MB1698.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	En8YRkJVBF24ccYRaqAh3VLgqvKyNA5gjBGoq2+39vq8HqEIjVJGe1Kkrhsg7L4vQAlaizY146k8q2JYpykQdazQLROTWr9mZKVoM2d6L2hbwHJoUuo+5lZMr9UNGX/1ggKz7UlrUb6z38L4HTOtqVXUSwVvi8nHNvnjhft0bCVmasiXgr5qTI6Zcs7P+ciTCLPRcUgP3YbN5TiUXJq0zqgWb3aPDsYOOtg7UOrdjH+s4BWN3DhCiSVP4DMawj1V2U/RMfxkv8r2EGThUZvFcmJSdgKng+ChYRIu5x99wx6ha9+u5VGzOgYoqNkQbDh3yVm3iq8LrX88dFXuMjebw8kNnbWVponxzu4dwE4u3kHmj4vJ/z/6ihFnswej/v/njSyYdCn03XDfPO3KhqGIMWCqRlEZi1k0irYFZ8JoHh66iINBsEMTd2aPki2UaDHSr/zXoCswLHPQagu6Lvfkibmx1NMcgG1dUcnMWQ6c3U3qZ81ik0BngOOGMUGWzYdF743RHXsKlRgYg8TeWJHSBd4ziIiNknhL23vjCpJ6GuNsvhEfDi5k5U72pQXX9Cc9P3p2ReXEvOsHkiMLfMUQ2W9yHnUNX1SG4XpaDDgla8RCs8Fgan0KCCF9jZZKDhBrvQuELTXtZVPYs6dbhBXRDq75Ge10xcv5lxBYMjouBZSluUCudKwSDwoBtygi6qXk3Lfu9+YT/F904T02enbtj7rvPFhYTQ60EqmZe7H6YlgsAwOeM4cQfg5VPGJNU7Mvq8cWuyj6g9RjnsL5mjj4ZQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(356005)(8676002)(36756003)(8936002)(5660300002)(82960400001)(31686004)(81166007)(110136005)(44832011)(40460700003)(16576012)(83380400001)(336012)(6706004)(2616005)(956004)(47076005)(36860700001)(31696002)(82310400005)(316002)(53546011)(508600001)(186003)(70206006)(70586007)(16526019)(26005)(86362001)(2906002)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 15:07:08.3636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 27881829-ad0a-4c25-da5b-08da3d971261
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR10MB1698
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 24 May 2022 15:07:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8430

On 24.05.22 16:57, Quirin Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> 
> This fixes the build error:
> ```
> ERROR: _exec_cmd: cp /usr/share/efibootguard/efibootguardx64.efi /tmp/tmp.1Y4utA1zC2/sentron-product-sentron-sentron.wic/tmp.wic.ampnawp6/bootx64.efi returned '1' instead of 0
> output: cp: cannot stat '/usr/share/efibootguard/efibootguardx64.efi': No such file or directory
> ```
> 
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>  scripts/lib/wic/plugins/source/efibootguard-efi.py | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/lib/wic/plugins/source/efibootguard-efi.py b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> index e1411cb..a01e484 100644
> --- a/scripts/lib/wic/plugins/source/efibootguard-efi.py
> +++ b/scripts/lib/wic/plugins/source/efibootguard-efi.py
> @@ -59,8 +59,10 @@ class EfibootguardEFIPlugin(SourcePlugin):
>          }
>  
>          distro_arch = get_bitbake_var("DISTRO_ARCH")
> -        bootloader = "/usr/share/efibootguard/efibootguard{}.efi".format(
> -            distro_to_efi_arch[distro_arch])
> +        rootfs_path = rootfs_dir.get('ROOTFS_DIR')
> +        bootloader = "{rootfs_path}/usr/share/efibootguard/efibootguard{efiarch}.efi".format(
> +            rootfs_path=rootfs_path,
> +            efiarch=distro_to_efi_arch[distro_arch])
>          part_rootfs_dir = "%s/disk/%s.%s" % (cr_workdir,
>                                               part.label,
>                                               part.lineno)

Makes sense in first sight - but why did it work so far? Or did I miss
to test one of the two cases (signed/unsigned)? Did you test both?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

