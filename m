Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B957EECAAD3
	for <webhook@archiver.kernel.org>; Fri,  9 Sep 2022 17:41:07 +0000 (UTC)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (EUR03-DBA-obe.outbound.protection.outlook.com [40.107.104.60])
 by mx.groups.io with SMTP id smtpd.web11.782.1662745256645505546
 for <cip-dev@lists.cip-project.org>;
 Fri, 09 Sep 2022 10:40:57 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cVLYOaHJ;
 spf=pass (domain: siemens.com, ip: 40.107.104.60,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nfAwwoiHoMzcW0g0w/1PsIBxMjvaBtotUI/SrnCcAsfZtm5Zf4kcwXVd4xXwabBbvnjPr9doZ2sZxT5sghc5/42JaTBeKQjNRV6xa0l+uN1ZxVPvKt7RYbrwH13oY7hbfG2iMz8Xz1zX+g3izGpa5mj/YTDqGfCA9rWhNv94zr9V0t/By2xUkbcymf2cxXghAHrCdJOv1slumXYl7QX7eCYbCmnShp9g8YOI9GWyQah11wCDWrUclmFdnSUNs6jDRTVaCR0HT4V4RmucfNqSFNz3TrB1/IuZ1dBZLokbH3hjjP6EG2Y7PuccAAQKvQvT8E1uckLT2tI4FtQV2Bvwhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYe8jyuB+pnTD2fQwoJRl5hVZuMYB0fAVkBR08eT60s=;
 b=Sbdq7H7z6Eugzqi438CiIGN+bXoQFu4VhytZqzGAY5jtWplBMuUTl9xK6Bih++beKQwh9a79gTx87a3BrVxnIDZpAnUaIVzbd5nJH81TwVwplV5V5AHBThbHumC/25uROvFafWux0r7g51drOri/DZTZL9tGNZdWgJ0IfLPCYI9X9jFH826ACz+U4MNedi6Q46CWsK1rmqkHeEWzE3r3GtBz8NtQQFH3A/RsSvoCPZ3p6ePBWfluKi2NEoeLQ3X1v4ZgGdT4kiciC1Cg6zUdzjDRniAu63WcHh8/eAT7/UFZfk4JYBbbFN5et6bXZ136JallmvxwIyVWNgOacGxOsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.74) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYe8jyuB+pnTD2fQwoJRl5hVZuMYB0fAVkBR08eT60s=;
 b=cVLYOaHJXmQG7nv62zbYKDiwxjvzGRRnG6BiQPZeWfDgIzU7+xk2Jlc4EsJr6eZvF+GlCMLvQ/z+bgGWdAQeVWtQ3Q2kT+4tigkGdTpRWfefDng1o7JAyfiD+y6KG4tl3o5VZn3hqG/voR7F2+xUEahluwgAKRTtLppIBKdfmdh0/u/4qBev78NOgyaGNePOYjGGUlcXRDvl3J16hPB4FSsf2ApSclKKhZaPrxgxp+VqR2n5LiIpTHIVkpujD2Ljcn40yCMhDdqVKqlkQjI5adLJ4jFIHz+AfqkY6haHG5UizgvLx/cggHhwgKYwZzf64y/IgpMPFaVdhwQq28dkfA==
Received: from GV3P280CA0025.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:b::21) by
 AS8PR10MB7303.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:615::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.14; Fri, 9 Sep 2022 17:40:53 +0000
Received: from HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:150:b:cafe::eb) by GV3P280CA0025.outlook.office365.com
 (2603:10a6:150:b::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 17:40:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.74)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.74 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.74; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.74) by
 HE1EUR01FT033.mail.protection.outlook.com (10.152.0.178) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 17:40:51 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VQA.ad011.siemens.net (194.138.21.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Fri, 9 Sep 2022 19:40:51 +0200
Received: from [167.87.17.3] (167.87.17.3) by DEMCHDC89XA.ad011.siemens.net
 (139.25.226.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Fri, 9 Sep
 2022 19:40:50 +0200
Message-ID: <d98e57e9-2219-6e09-582c-b465e9295193@siemens.com>
Date: Fri, 9 Sep 2022 19:40:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [isar-cip-core] README.swupdate.md: Add steps to verify SWUpdate
 on BBB
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220909132535.3671-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220909132535.3671-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.87.17.3]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--17.605900-8.000000
X-TMASE-MatchedRID: aGuL5piyGFrO278aZjZxZ8c50LsMZjCp/k5m7D0YTS/x5KZMlKYS/ReK
	/B+WKxKs9/tYry8FJ+9fjqIZlM+knq3aC25avUuaplCaRSPAyU0PBdAcQklBEq6pwuq7tDp2giz
	NKnxrsXLfc2Xd6VJ+yq2LobuNU2ekROogZf1QZqaJFgYp6ABGFIHDqMX5R2gd5wXI1oONVuA/pO
	SL72dTfxzSdtho/k/DxM9DM4OIRzby66m4pHtXNS6zCHyQ4joSgikKe+oTH2EjCTunWqnclmTcE
	lmE8+OMpnCV5PvGM7l+HeQLNZd3GHKcng1pq9Qu8X2+vR6qXp/ni7ZGg7ZwKeW9J5hJgRQsp1Pj
	caldww1VZCccrGnfyJkEGjXl3OWU8YTRonwCdsz7Iv0Mn080e3EcMtD4k81Ij0FWpA5CVPlKlo6
	qIxfTgA6QlBHhBZuwZqOFWDadl5YYUuDXXiJSOzngTIv296D3wktTXgr7N6jHrhS+VKSDcbqzpQ
	vjy9EABXf5SNAXllZyuMROkONAN3O2B2RLfEcULxxHBMdDc7oy7wvC8Uc6Hfbta0OAYFzyfS0Ip
	2eEHny+qryzYw2E8LLn+0Vm71Lcq7rFUcuGp/EgBwKKRHe+r5fB0EF68SoC7M930FJfCMSpkbNC
	L1ejpxUWcsmK8aDryd7r0VUkTgQ=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--17.605900-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 B5C09F7463F2E2424DF6C5B6CA7EBEB17F5508BB62E3C3F7131F3520886410582000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HE1EUR01FT033:EE_|AS8PR10MB7303:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c2879b-eedb-49ba-5136-08da928a70b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	jg+MteufhbFt1MNH6kVKn3kpvsdyN8MdgYvQHK7axOQUb7R6kpjhPz0ae1iUmgcgxncmpdg2YxST/69SOs6rjs1xj1FIAYAL7KGdiMfIFYMcKTXhkkYDF8LU+6JixQg/Zc/it1cs+PsDVCchgyjW0mdhO2tqiXFaeXy3/bneGO5/1O7IYfRcPe8TjSkpVu0PWPQc9CXnjZEBco8EHxyZam4SwBCwB7lPlAb6Em7ca/OPtikcxaFDDVU8oNOd71v/BkP7rsVrxZl8geDnonSssBtDogbAII0LpVKwtU3G8laAedQEu4jh1Hr7SjyAQ/kfzU8DMcNhB4h32Qo/BkE5JIw+NhqEdDnqT1b4YfvwyrAfmkhXFUzQs5X2vM4sNp35ON03zNzNfqCFM9+TDgA2+kRSxceoxBuJLhdGxhbVhiYVKRGcOAuiUNy0xWnmyWtoRHvmCxqpbSGSWEKNqONyawlTXsaogfQyztxfuLc8nEf/yZhbkV52jg/gJTJTBHr1bGT+leU/dYQAoNRipo0SPOKufoF3FD9XD/u4uXqxrCGHUIdT1cYJPARRYKEk7IoE8nenAlBrMlNpFsU6fKIoKnHKkScyZeJFy2qDu9KXipuufAfdRONioNSRggn1FpGqlPAa3x1bGEw1oHugxjvOiB5Y5SRsrAck8yBXN/4GvdGCPm+z3xN/3WCjrQLUfPNFhFKhThZnkKKfDssacv+21eoUnDg5I8uO2YMOnohzxunZnHygQfYlmyrUtlFYgS06vyM4DMYibXTWAUdBevlhjBD95GZMQ9eh8XBmqdfB3TGkxzF3X+nBCw2USep6haRd/QmoyiHMXikHsqkVWnjz0QE/7sPUUf5c75ETLIfBL7Y=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.74;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:hybrid.siemens.com;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(40470700004)(36840700001)(53546011)(356005)(31686004)(8676002)(5660300002)(956004)(44832011)(82310400005)(36756003)(26005)(41300700001)(8936002)(15650500001)(7596003)(2616005)(7636003)(31696002)(4326008)(70586007)(54906003)(16526019)(16576012)(82960400001)(86362001)(110136005)(186003)(82740400003)(336012)(478600001)(6706004)(316002)(2906002)(36860700001)(83380400001)(40460700003)(40480700001)(70206006)(47076005)(3940600001)(43740500002)(47845001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 17:40:51.9613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 82c2879b-eedb-49ba-5136-08da928a70b7
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.74];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	HE1EUR01FT033.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7303
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 09 Sep 2022 17:41:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9484

On 09.09.22 15:25, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> 
> Most of the steps are similar for both qemu-amd64 and BBB targets.
> Add reference link wherever required instead of repeating steps.
> 
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 52 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 52 insertions(+)
> 
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index 1b242a2..72690d6 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -32,6 +32,8 @@ Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` folder in
>  host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@localhost:
>  ```
>  
> +## SWUpdate verification
> +
>  Check which partition is booted, e.g. with lsblk:
>  ```
>  root@demo:~# lsblk
> @@ -215,3 +217,53 @@ user variables:
>  
>  
>  ```
> +
> +# Building and testing the CIP Core image for BBB
> +
> +Follow the steps mentioned in the section [Building and testing the CIP Core image](README.swupdate.md#building-and-testing-the-cip-core-image) for creating images and .swu files.
> +- Replace qemu-amd64.yml kas file with BBB board specific file i.e bbb.yml
> +- .swu file will be generated in the following folder build/tmp/deploy/images/bbb/
> +
> +Flash the BeagleBone Black image into SDcard
> +```
> +host$ dd if=build/tmp/deploy/images/bbb/cip-core-image-cip-core-bullseye-bbb.wic \
> +   of=/dev/<medium-device> bs=1M status=progress
> +```
> +
> +Prepare the hardware connections
> +
> +- Connect a serial port cable between host PC and BBB
> +- Connect an Ethernet cable between host PC and BBB
> +
> +Insert SD card to BBB, hold S2 button while applying power suppy to BBB.

typo: supply

> +Once the system is up, execute below command to configure static IP address to BBB
> +
> +```
> +root@demo:~# cat <<EOF >> /etc/network/interfaces
> +auto eth0
> +iface eth0 inet static
> +  address 192.168.2.2
> +  netmask 255.255.255.0
> +  network 192.168.2.0
> +  broadcast 192.168.2.255
> +EOF
> +root@demo:~# /etc/init.d/networking restart
> +```
> +
> +In host PC, configure below settings for Ethernet IPv4.
> +
> +- IP address: 192.168.2.1
> +- Subnet mask: 255.255.255.0
> +
> +Execute below command to confirm 192.168.2.1 is accessible from BBB.
> +```
> +root@demo:~# ping 192.168.2.1
> +```
> +
> +Copy .swu file from `tmp` folder to BBB from host PC using below command.
> +
> +```
> +host$ scp tmp/cip-core-image-cip-core-bullseye-bbb.swu root@192.168.2.2:/root/
> +```
> +
> +For verifying swupdate on BBB use the same steps as mentioned in above [SWUpdate Verification](README.swupdate.md#swupdate-verification).

How I tested (in the absence of a test network at that time):
- mount the flashed SD-card on the host
- cp the DIFFERENT swu into <mnt>/root/
- boot the target and run swupdate -i /root/<image>.swu

I think that is simpler if there is no common network with dhcp in reach.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux

