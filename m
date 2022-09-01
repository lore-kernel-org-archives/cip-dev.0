Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F12C4C0502C
	for <webhook@archiver.kernel.org>; Thu,  1 Sep 2022 10:55:12 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.59])
 by mx.groups.io with SMTP id smtpd.web09.10648.1662029704610074015
 for <cip-dev@lists.cip-project.org>;
 Thu, 01 Sep 2022 03:55:06 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=qun6nUe7;
 spf=pass (domain: siemens.com, ip: 40.107.22.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ReCpQK4h5Bfc+T6uvhZFi9+eWg9ReLpuqUpooiol+XXvuXq2WN85lMQoxjiWh7572oj7/XOcX1/K4FOoo7Z2+QMrlMfzMbOFxdZJ7EQZhLWcMhd1kscee4ePDcCUG8QqJ9aRTyJ21sFsgX59T4WLktkwrEfp9U3nmMH9OJCGNz+HKN8L8azy+3J9BE5BN9+xgtlFmONtDZ40odhcgCydFza/42824dZv3VxswLkhbSfOxHv3a/IPyPkZ0qHQO+iFRc19rkrso81wlQ3eJbWKznl5bUTR1wG0jvsklAKVR7DlrD2AjUzinH0gOM9XCNxlz6detNxR9ubL1HCbPV+kbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXvwUBI15U1BIDC0WX3XDtyUrVJcpmlnlnz5yMSVXW4=;
 b=PiPeqCIJA/CTeVSu8doXyWN5xUCgbBt48EmX4NbFn4trcE/ZPaefbrc5wmkBa+gnmbOFirInTdouR/R/15wYmlRDHOo6PVOv0PS0EU3aE2CHOeWXeqMTHBzIIUsq2UZ6/jtX5PlI4nbp9ORjxCNlJWEjjcUdsBu6ySmjUZTbf6UOerExnu8dO2dsN0MIC3OO5DtSj7QQBQ1k49LzvdjSpiKGOQ5b1qNFZ7G+04s8oZO8kDPbG6RAZtFtUCXoktF1Bk7uhr1mrGSAMAqoRUaxG54WGDyG4oDV3z+c1UuGtXeidsQSVA9li7EFYBvIXJTxW5ekhplZGOPZxvazrIZJog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.76) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXvwUBI15U1BIDC0WX3XDtyUrVJcpmlnlnz5yMSVXW4=;
 b=qun6nUe7e306vSGLK8FrcNIfkmdqp7jnRoeiDnTh4U5HmaXTlw2xxenbScvKEx19ibtAllPNp2BXv7Sm+EVWdXRTJGICq9TMgE5BglgJwzYVjw4vECB8kHbDVzGRqi3QhtX/7zsuyHXEE4D2+UO0R1kPbNsh+LwRVLHOlD4OmBSJ7GXIagY0Tpw4fP8P3uzUlWzZHjyUBxQCRz1mStLD36zBdsQ3RdXtqTGMepdnmoh4jhD6VHR3ia8aWOTCdqeZKr/fx6AR+ElnyGJtKTjLVhdigEa5wqr/ZLRBHeIEVpgKJEDrOKgYarGZv1o0FcCwnw3tQbEbyc+bCf+lWbM67g==
Received: from GV3P280CA0105.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:8::11) by
 AS8PR10MB6294.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:54f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 10:54:56 +0000
Received: from HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:8:cafe::a7) by GV3P280CA0105.outlook.office365.com
 (2603:10a6:150:8::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10 via Frontend
 Transport; Thu, 1 Sep 2022 10:54:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.76)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.76 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.76; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.76) by
 HE1EUR01FT031.mail.protection.outlook.com (10.152.0.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10 via Frontend Transport; Thu, 1 Sep 2022 10:54:55 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VSA.ad011.siemens.net (194.138.21.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Thu, 1 Sep 2022 12:54:54 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.9; Thu, 1 Sep 2022
 12:54:52 +0200
Message-ID: <49100f0d-819b-9b37-d0c2-e8b91530eef9@siemens.com>
Date: Thu, 1 Sep 2022 12:54:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core][PATCH v3 3/6] Add script deploy-kernelci.py for
 upload the cip-core-image-kernelci
Content-Language: en-US
From: Jan Kiszka <jan.kiszka@siemens.com>
To: <cip-dev@lists.cip-project.org>, Alice Ferrazzi
	<alice.ferrazzi@miraclelinux.com>
References: <cover.1643303563.git.jan.kiszka@siemens.com>
 <b9f11b364d7a658ccfd11313afdce13d19f6da7d.1643303563.git.jan.kiszka@siemens.com>
In-Reply-To: 
 <b9f11b364d7a658ccfd11313afdce13d19f6da7d.1643303563.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--16.374200-8.000000
X-TMASE-MatchedRID: kxpaLTp5p67rOhfRe676RwJfVW3wuXXEPg9yfk4YC0Zeu6aRt5rYyfSm
	5aLvRrjee3wXTvBMUi4wl6B/4JChYSOOgy6MfIG28dbnMyBysedkHsVpDopD3212v13Qb606y73
	3NwuklsJYC5LPd7BvbUAc6DyoS2rIqQ4DH3i/D95Qe/WCY5uq8Z41vyajJKDzoHDoEp2TszGcql
	CdrhyhQJ4jWPBZdp4jPuyheEAqcMnebBoxbNfyedr28BbNwuuZle+q6k7Q/cwvzLls7HTfGctDH
	w9RrCNbmyiLZetSf8nJ4y0wP1A6AAYnglAWdCYbt7DW3B48kkHdB/CxWTRRu25FeHtsUoHuRPWp
	X5VqAOdbrAK2/4Faa5aHT1NIwByVeQpbEym6caFLhb8xGEnVfg==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--16.374200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 04D4FCFEFC4B897210A8C7DB8E2FCD47D14627FC3A3265687809197C396267972000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 936e5f16-2163-4372-f023-08da8c08678a
X-MS-TrafficTypeDiagnostic: AS8PR10MB6294:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YbH56Z+5SgLVQwsFFfWqKLeU/HDgb79QzrTFxWl8SOrox4mkPxeJZwrHlTI+BB2Op5JjHu+ykMt+VF1gWSAea/9/fVq3UnqR7hTp6cMXrHlfPBGsemgJ0ZER8gt+zNnTGEQ7vRZ+57NTvqBmBsKxFLUSPegBnb1nUlV1lS8GPP8yRsfg9bq4pcLvFY2IsO93v6x4krI9q5Nk3S6lLsvZL+hNEydSyd0KYaShb9pQVY3F3ynTuHKsNNiZ9l5H+mmZMivY6egoN/6WA3+TBty9WRjrvFNunocEJPh38VciCBhfKzzFRHT11WQ5Sq584sPJtCkeOEJq+6BWzcLYzv8BMoC+bUa3pyVoF1/KcxpEVLL3deICzVY8ZRnZac8XmV5AQJcscFaXXbHyhUugCvQ3Qk0WW/Q7G2O68n8ffSKcZlnUUNm+3mHRE+4OFiQsiRA4XS786bPB2zz1J84MHvl+YyhKAjRNs069IJOs5fys3LdW25HEaIWpkAMyFO04zGuPhkFXF/8cMShkj5EGY5CKRt46EueRfz82XLa6XHZnuUlqoaHo6aC73r6dH0shIGERjFhMim5GPt5vhh0j2kIjxBv5scOBiKQJFwhPFTQcBXfulpoIzBuWfmhagFgeP2h/MX1ztyn4XLF5x02K7yXHDgikVAEjm1vstlEQ1MNC1MukVe9fpi3jBRU9mvtEiDrVL73OJyWocu0PA+XYNe7rxsogiDaeIGYKRl6ItWIn6fDPp+B2wauTbQqgtC/zL6oAaTxtsPlOFxiJ4TAkaYB8wAC9Ycvdr1BETLsA+QFTpTavqb5X9HlNXGRF+TU5K7o92DIXo3hZfPVUxTfKMvqRAiZ34+Tkjkw2VCSMENtnBHZL1373Ny3kc4P4KMvN7Kl2m6sOviHx1LjsrZXpqsk55g==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.76;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(36840700001)(40470700004)(46966006)(70586007)(81166007)(31686004)(82960400001)(356005)(82740400003)(316002)(6706004)(40480700001)(110136005)(16576012)(82310400005)(36756003)(36860700001)(41300700001)(26005)(70206006)(966005)(2616005)(47076005)(86362001)(956004)(44832011)(2906002)(53546011)(478600001)(336012)(5660300002)(31696002)(40460700003)(8676002)(186003)(83380400001)(16526019)(8936002)(3940600001)(43740500002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 10:54:55.0038
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 936e5f16-2163-4372-f023-08da8c08678a
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.76];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT031.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6294
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 01 Sep 2022 10:55:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9418

On 27.01.22 18:12, Jan Kiszka wrote:
> From: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> 
> The cip-core-image-kernelci need to be uploaded to the KernelCI
> production storage for been used by KernelCI.
> This script use the KernelCI API for uploading the
> cip-core-image-kernelci to the production storage.
> The images are uploaded in the following link:
> https://storage.kernelci.org/images/rootfs/cip/
> 
> Signed-off-by: Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>  scripts/deploy-kernelci.py | 55 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100755 scripts/deploy-kernelci.py
> 
> diff --git a/scripts/deploy-kernelci.py b/scripts/deploy-kernelci.py
> new file mode 100755
> index 0000000..5a8adca
> --- /dev/null
> +++ b/scripts/deploy-kernelci.py
> @@ -0,0 +1,55 @@
> +#!/usr/bin/env python3
> +# -*- coding: utf-8 -*-
> +
> +import subprocess
> +import requests
> +import os
> +import sys
> +import time
> +from urllib.parse import urljoin
> +
> +cdate=time.strftime("%Y%m%d")
> +api="https://api.kernelci.org/upload"
> +token=os.getenv("KERNELCI_TOKEN")
> +
> +release=sys.argv[1]
> +target=sys.argv[2]
> +extension=sys.argv[3]

Just stumbled over these:

We do not use "extension" (it's always "kernelci"), that's an easy
cleanup. But more important, we also pass the dtb while we do not push
it to kernelci - by intention?

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

