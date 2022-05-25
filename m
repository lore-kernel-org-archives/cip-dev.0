Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA464C433F5
	for <webhook@archiver.kernel.org>; Wed, 25 May 2022 11:41:55 +0000 (UTC)
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (EUR02-AM5-obe.outbound.protection.outlook.com [40.107.0.70])
 by mx.groups.io with SMTP id smtpd.web08.5714.1653478905480808677
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 May 2022 04:41:46 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=oGw+ePxJ;
 spf=pass (domain: siemens.com, ip: 40.107.0.70,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ihhZO19o+1WqRbiYBqFUD55veC/CATbuTU9gaGCYN+FOb/Hr1eRPk7t++l4liV7OGYRh8jH1FPOHyx+o7v5gOA7JI3h7Kbxy5m8H43/QpZIIomAv/wG2s09wMgzY/OsTLU52fUHRCUuihrprmV9I/b0jmal2ZMZ5FKv9yLKRkBvE235Ysvg6DAcrTf8ti5JuFalH217lDjxAylMQK7dP1B9vrAy+tWfw0s5GGQYBuG9Cba5sQpUOX6vhALMCp2z0wBwhXDwPr3Lcn+ViJ/Yr4dJbbWwZ6Qk2zTdfk+O2nOZBMk1Kc0CoYP/d7+w7WCQE33+yxfnysw8TcoDYvfUJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3jAsNG54ttVUJWVjyaVctKq8267EnLvdZsmnpzgcuPU=;
 b=Pz+a4KN/xn/o7u0ykMj27HUgLhzzi6lymIfEY1lY3M3YUEeqzozw6oAyI7BK1KikivxhUSE1KxtnQCQxlTCQYW9BrXC3TpmfIjZcwlKZiHrtC+buhnJi/RHWZmJ8jQgIQz+W4pcCdxvTfZ9cBi9l3HDECqcRUz45sW/v5AzMZGlfr+UGn1dkLoAxHX0CzVpaZDS+WnXRV/4cFfKHbzGx4HPbUpFS4sUlgCabN6ZenBLn6lNKAbFl3A8/5B8ySBfTSVbMcXv+nOT8dIDJVAtJ4ngzJ/4uV0vheiTQcp2pxuxPtgCvzmTnxJfxr0XkqxMJWQ6lKthCnHlBgwR8EfYLsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.70) smtp.rcpttodomain=essensium.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3jAsNG54ttVUJWVjyaVctKq8267EnLvdZsmnpzgcuPU=;
 b=oGw+ePxJ6/TFTdrbBGWMWorRBc4oWQ70YMH3Sj6+bnunsqGZ9lqAG77QBUvMlwqdV93OSydIVelEDYKHKhIkhVyMEnvMpK8NrJUJAYEO4gtdGc2ddqUXDT/H6p0+v4to2RsDbzmI/UYX+RfS79O1VnNo4AGHt0L5Wexalme7S40KOL/ZMGJSPvKrqXh9BvD2nMPLP13Ueqn+W8Di8hjwydsS9PtEAH3SfZXF/dnVD9XtqhVrVdfmvW6fCIZHxgy44Kbp9gdnePrGj2srCKS6uia4TB8p8YyqcxZkSGAofnvAmSeFmWYgQkxLFXy1VObo3dMGJHRCzEJHh5S+hOBEKQ==
Received: from AM3PR07CA0099.eurprd07.prod.outlook.com (2603:10a6:207:6::33)
 by DB8PR10MB3546.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:13f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Wed, 25 May
 2022 11:41:42 +0000
Received: from VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:207:6:cafe::7d) by AM3PR07CA0099.outlook.office365.com
 (2603:10a6:207:6::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 11:41:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.70)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.70 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.70; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.70) by
 VE1EUR01FT036.mail.protection.outlook.com (10.152.3.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 11:41:41 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SJA.ad011.siemens.net (194.138.21.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Wed, 25 May 2022 13:41:41 +0200
Received: from [139.25.68.37] (139.25.68.37) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2375.24; Wed, 25 May
 2022 13:41:41 +0200
Message-ID: <bb00ccb7-8098-942e-e7d5-d7edbd35ca4f@siemens.com>
Date: Wed, 25 May 2022 13:41:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [isar-cip-core][PATCH] Update README.swupdate.md for bullseye &
 5.10
Content-Language: en-US
To: Hannah Kiekens <hannah.kiekens@essensium.com>,
	<cip-dev@lists.cip-project.org>
References: <20220525092017.445653-1-hannah.kiekens@essensium.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220525092017.445653-1-hannah.kiekens@essensium.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [139.25.68.37]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--14.160900-8.000000
X-TMASE-MatchedRID: odSQQebQng3dDS6etHbe297nCW9E8ExwiwORQkMXRryOtWfhyZ77DvTW
	YbN2f76BKjjlLG8O6u9KKQ/kQgkQZO0oum4zWmfUiIxsYVyITyRwoTxwetcEIyqwx8x+s5lFwuQ
	Mz4Wokvrk1kyQDpEj8Cj53aEB5qDLrdoLblq9S5oOZaoiDFlHji/33TWoSUH6f8dNT84FpMa/Ci
	KQLeaSpPH96zhMF86najppDrQRQIgvsHtgVpiiya6CYdf8su7KE2Fn9cnI7peLzZSKyQypzMyp6
	/c4+odxkshAoFcG3yS10D0B9nuX094bimfUll2nr6Av8kK6SAo8g1fEYZ3829bgzPjrV+wcQZpQ
	RfyCdHyJS00sVxaFr3FC0fMeQA5wggtTQRVqZR2Q9QkHsuf0mCirxlIJMr5pkYD8wAZKsSCCLM0
	qfGuxct9zZd3pUn7KrYuhu41TZ6T+Mn/uyGA4HDHePU1MbHBZn2/vZnACZTV0nAlKzysDObv00H
	tUkATFfXHbVgZA2C55wvL9iltvwBZSzhpKqedk8x9+tEL3Ui3INUBYpHy9LSQ3IpkCK7x4LozI+
	rhNYbm2zFWqrVN4BV43rBTndKTO4vM1YF6AJbZFi+KwZZttL7ew1twePJJB3QfwsVk0UbtuRXh7
	bFKB7hmAVJq/6uHdAb6dCCSmA2vpq2cD0P9EeBv4R+LDDy2pSwwcGKLTYEc=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.160900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 5494AA63980A8780B6865F107F719BDCACA43A58A6FD4C01BDDD0FE777915BD72000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cf519cca-b0c3-4b91-8fb5-08da3e438998
X-MS-TrafficTypeDiagnostic: DB8PR10MB3546:EE_
X-Microsoft-Antispam-PRVS: 
	<DB8PR10MB35463B34CA43F3066B93560B95D69@DB8PR10MB3546.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AYhr/8jjXOtXN5LYUPNRAU7h5FZJ/xjEMVjUjsYqGuJzxLerXH6I5Jc9+tpJPqXBc9gJw+nQXnoxc5zfzgw97L+rDC++TEZMah98GwHSabzJ07dp6FyyziwOPug2hSqg++N/1dklRWKRuwVf8aXgRXv3E6fOyiBDIHI0OTVWnrEKBtNa5lKiS0N2xJ4JUZg64Bn8fTVSpkMwsR4hScH5TjLTp7FjqEPBDAVvVxcQd6HkMriB6DSTL0/rIsBcdIRkg1kr6ebNx0Ss1aEBzJfaw4P1SXVoBgD3/ArDwj0VJPAV4zc/VMX9813PM5nXLmDuI4oMHJHzMcRtJcTRVTnvUQa+iytYGKZi7Pnbhx+P3m4UBIzBf1/veRo8077vuhkxe78ZgA+Nq8chR3bSXaRaVCi6Z7Ym2rvUBLhz0pD9A85pss6970d5CAtDuxju/+NXMqC8TWetr4jcyFeSm9WuvR6iEhJ2HOpwtVoWtVRVghkhOropxCeB1V+CeLsaG2G5JVGBgXxELms5y2/5I1DfgRAJc56eEFdjmmAs/kwGSlQAQz7RKKdAIUWZNiTHGmoVJAJUVT+i5U6HToy2i2Gz/iE+/BYRk41kZQPQ1pO1Cr+smyWflZBLY1KSxuvwI82gO+tD+gWIC/Cj3cnuuwu3pIU+7j0fDg+ImO3blrZpbDAAcsu9KJNGFIlIvCLhv31KNzMlrdyX9BYkS4f17MOCZGEM+dJ76uZyJKXFYN/TZc/JZivfp+r2a2s05iRcVBP9IWy/6TGQSHbUx1HBdSyciBr3Kh2+R0IgivIrvMyFEfFY76tl2C1o+uD3UmJnPFnONR64qrWFYQwN6aCO6f3+VQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.70;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(82960400001)(966005)(110136005)(2616005)(70586007)(70206006)(2906002)(6706004)(5660300002)(31686004)(8676002)(956004)(508600001)(53546011)(8936002)(47076005)(36860700001)(336012)(82310400005)(26005)(40460700003)(44832011)(83380400001)(16526019)(7636003)(31696002)(15650500001)(186003)(7596003)(36756003)(86362001)(356005)(316002)(16576012)(3940600001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 11:41:41.8085
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 cf519cca-b0c3-4b91-8fb5-08da3e438998
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.70];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT036.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3546
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 May 2022 11:41:55 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8437

Hehe, someone actually read AND tried the manual :). Thanks for caring!

Would be good to list some reasoning for switching to bullseye here.
Buster should still work, "just" not with 4.19 anymore.

In fact, we should think about making bullseye default in kas-cip.yml.

On 25.05.22 11:20, Hannah Kiekens wrote:
> Signed-off-by: Hannah Kiekens <hannah.kiekens@essensium.com>
> ---
>  doc/README.swupdate.md | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index e28db24..ab957f1 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -13,13 +13,13 @@ host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.git
>  Set up `kas-container` as described in the [top-level README](../README.md).
>  Then build the image which will later serve as update package:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` into a separate folder (ex: /tmp).
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
>  
>  Next, rebuild the image, switching to the RT kernel as modification:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml:kas/opt/rt.yml

5.10 becomes default when selecting bullseye, so you could drop that option.

It's probably also worth noting that some of the build configuration
issues are "resolved" now via "kas-container menu" and its dependency
encoding. But it is still clearer to describe the actual configuration
the way it's done here.

>  ```
>  
>  Now start the image which will contain the RT kernel:
> @@ -27,9 +27,9 @@ Now start the image which will contain the RT kernel:
>  host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
>  ```
>  
> -Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
> +Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:~
>  ```
>  
>  Check which partition is booted, e.g. with lsblk:
> @@ -47,16 +47,16 @@ sda      8:0    0    2G  0 disk
>  Also check that you are running the RT kernel:
>  ```
>  root@demo:~# uname -a
> -Linux demo 4.19.233-cip69-rt24 #1 SMP PREEMPT RT Tue Apr 12 09:23:51 UTC 2022 x86_64 GNU/Linux
> +Linux demo 5.10.109-cip5-rt4 #1 SMP PREEMPT_RT Wed May 25 08:02:24 UTC 2022 x86_64 GNU/Linux
>  root@demo:~# ls /lib/modules
> -4.19.233-cip69-rt24
> +5.10.109-cip5-rt4
>  root@demo:~# cat /sys/kernel/realtime
>  1
>  ```
>  
>  Now apply swupdate and reboot
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
>  root@demo:~# reboot
>  ```
>  
> @@ -75,9 +75,9 @@ sda      8:0    0    2G  0 disk
>  Check the active kernel:
>  ```
>  root@demo:~# uname -a
> -Linux demo 4.19.235-cip70 #1 SMP Tue Apr 12 09:08:39 UTC 2022 x86_64 GNU/Linux
> +Linux demo 5.10.115-cip7 #1 SMP Wed May 25 07:46:12 UTC 2022 x86_64 GNU/Linux
>  root@demo:~# ls /lib/modules
> -4.19.235-cip70
> +5.10.115-cip7
>  ```
>  
>  Check bootloader ustate after swupdate
> @@ -121,12 +121,12 @@ root@demo:~# bg_setenv -c
>  Build the image for swupdate with a service which causes kernel panic during system boot using below command:
>  
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml:kas/opt/kernel-panic.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-buster-qemu-amd64.swu` in a separate folder.
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-image-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
>  Then build the image without `kernel-panic.yml` recipe using below command:
>  ```
> -host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-swu.yml
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/5.10.yml:kas/opt/bullseye.yml:kas/opt/ebg-swu.yml
>  ```
>  
>  Start the target on QEMU:
> @@ -134,14 +134,14 @@ Start the target on QEMU:
>  host$ SWUPDATE_BOOT=y ./start-qemu.sh amd64
>  ```
>  
> -Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` folder into the running system:
> +Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu root@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:~
>  ```
>  
>  Apply swupdate as below:
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
>  ```
>  
>  Check bootloader ustate after swupdate. If the swupdate is successful then **revision number** should be **3** and status should be changed to **INSTALLED** for Partition #1.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

