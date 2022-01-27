Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE02C433F5
	for <webhook@archiver.kernel.org>; Thu, 27 Jan 2022 15:58:02 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.81])
 by mx.groups.io with SMTP id smtpd.web10.149.1643299080484795580
 for <cip-dev@lists.cip-project.org>;
 Thu, 27 Jan 2022 07:58:01 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Pau9ykxv;
 spf=pass (domain: siemens.com, ip: 40.107.21.81,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IGGrFqPIagWJOOxgpqAwjK+S0CEC2NvK/RWQ+s1XHKXpp8cOJH1nwS9ffgBwneYl3w6rpfINvdZ1wiT1zea5K4u0BegpKFnr+ZTuwNtrkHNk/ewKdKcckT/qiNRhvB5aDYOjnugW8GFjPEqK+FrXmoMmlR/iJVSXKho8nOpNjf0SNtTHb+Lru/UcjOqhMY3wF485B2Ixh2lx/o8e1KQ/g17JsqcBHolxFw8QbCdVUsFgASyHx4Xlos8cLQCl8KDqPElalG69Rcjw0ilJa1Pju4vMaMqT3WLCwEdIhW9PQ2wZpA6YNFyzBqCEU/Y0N8zWI986OzG9qntCf6KtUlHtlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSfzBYDr4chgujK7FYmSPqg1/8ZXsDTw7u3oUaGGrNw=;
 b=mJXKjgv5P+V0hLJVm8fuedLHDTHIzoID42dDMYpSiWwvYaQ7zXG8/j+P9S2tWvXF5ohQuKW/WtRT4m25zAcoB7jxSAsbiBq2MdjI/HcR/KLvFMFN/VetPrImLEPciTvaY5kwocR38ORIsMkGLfssY8ijNkBoYqIWIw0E/779dfpfwDgK7nFhVO2f41rmZuCqqAhO7iWQfnw5c0BjeuiMbql6ztILpXKTZMwMK0zHmKDIViNHIn/qftM12QaoszJUtwwJNGxVvVaFfiHZwIJjlQjAqi/Bky749zYSb8tOCRmc5/uBCxIMUJnNpV+gj94L2wos+u/AB1x28wNnH1Sl+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSfzBYDr4chgujK7FYmSPqg1/8ZXsDTw7u3oUaGGrNw=;
 b=Pau9ykxvdolnalDeAmwkrsyN5gvVMezq/wjaUlgOVP6SkpNrzAgV5lBYBO8fwURPjfTK4oB/dC5sRZsCy5TulqjOPAB7sSPZ2EkoeIrmj9nqWxIwH20DraCILX7y9RVHG/yqo0ebGsCc2U1W97QFSX2iic8wGJR1cElUUGv6DiswD3BIFK3Yjx2ojNskozWusYxOmRjt+CQpT6PNBffCfprQpan92wphIbwgcdkNEbZO9PxYe3ixIrRO5JC3Qq/5LLAwONPvQ/b69qLL2lj0PkRZyP736WgRdsuaz/lc2Toe3VonRN2zdBpH6ftgSC2uDT4DVi4edpS3DppG+LDRXA==
Received: from DU2PR04CA0042.eurprd04.prod.outlook.com (2603:10a6:10:234::17)
 by PAXPR10MB5207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:283::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:57:57 +0000
Received: from DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:234:cafe::29) by DU2PR04CA0042.outlook.office365.com
 (2603:10a6:10:234::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Thu, 27 Jan 2022 15:57:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT040.mail.protection.outlook.com (10.152.5.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Thu, 27 Jan 2022 15:57:56 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 27 Jan 2022 16:57:56 +0100
Received: from [167.87.73.11] (167.87.73.11) by DEMCHDC8A0A.ad011.siemens.net
 (139.25.226.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 27 Jan
 2022 16:57:55 +0100
Message-ID: <f31866fc-ed51-2ddf-6f25-74d05e410f1a@siemens.com>
Date: Thu, 27 Jan 2022 16:57:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core] README.swupdate.md: add readme file with steps to
 verify swupdate
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>
References: <20220127142627.6812-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220127142627.6812-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.73.11]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c19c449-c4ba-4a18-8a68-08d9e1adc8fc
X-MS-TrafficTypeDiagnostic: PAXPR10MB5207:EE_
X-Microsoft-Antispam-PRVS: 
	<PAXPR10MB5207DF71441F3F889FE922D695219@PAXPR10MB5207.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	NgGPMHSujyUXinoQQ69MwJz0zOJ6VPzhiyljFTvsklHbokVD/r0PlCC9QanZYO/E6KYLXot8XI5JZEtQSfXfMuF54iW+tm3z1a7217ZfjIFpUkF2UFXokqah+9BpU4KADQBL/iFQ/crl3W5rH/3traaKi1E/vWwGyopRFA/S7RUlvkzbSKtxl43e7cnLLJH0iWUzMEsMjMWgMLKc+SF/9ObNNc0USb8XePcZakcXKb3TuFhR45c6AUNFfgT5GdfB0Su1BnGime7aWhe/9wwhq+gCNy5VPKHoqWRFDPd12Zlx4SYlp2gZnXvxvgkVY79+kp7Em/ouYEJTaLlgmQ+a+GH64zgG1uZe8k3pIsUWVPMTjfCzTAowwSchcjA4nGCMuf2/C/hMeUTOez6wBNzO0nb6yeaPg+QF6iAi5M0gQF9e81lDIqPb58VEoALgxxsJTzf25ewKE9dpILgDS8NdTQPqwPHNYFLAxOy3KaBub82kB6bqPNeuaxYc6J2P8pd++cnvUL59WegnflePjLhMKojKJi+FS7Hr25ELIsWQB2MXxUro3AgWlrwt52kER+cXYZfaaU6uirdioJMfK7MiaGiu8k0emneS8wVMgBlDO81t1syJtNvFQt2MRdo2GhLlXuTAandz3kaWpeIJkM7rPKjBSD1L5Bb5CnsjrvaSzHUrqRgc4zu7J3CzFlr9gg4fdjuDOFYOwwkkfcblGQ4NlaY86ETKW4JlMraxIUNNPtQEky7eZuUyTl78xkQAhVEHeiVenEpHB4eVJ4670n6G0f7sXeUWYAjGCQYbgSV46KsZTT3rgF+h5km7J7yN6uJpYXPiOBgSWpBmK/8m15vlAfBEw9/bKY1Peqc0YFUbU8JwxvDgqAowO0tazLbRplxpOYxTePfXAz8ygPaOUsVbIw==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(966005)(70206006)(86362001)(5660300002)(15650500001)(82960400001)(8936002)(70586007)(16576012)(110136005)(508600001)(31686004)(6636002)(6706004)(316002)(4326008)(31696002)(44832011)(2906002)(2616005)(336012)(956004)(8676002)(53546011)(40460700003)(186003)(47076005)(16526019)(36756003)(36860700001)(26005)(83380400001)(81166007)(356005)(82310400004)(3940600001)(43740500002)(36900700001)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:57:56.6440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8c19c449-c4ba-4a18-8a68-08d9e1adc8fc
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT040.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR10MB5207
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 27 Jan 2022 15:58:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7507

On 27.01.22 15:26, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
> Cc: dinesh.kumar@toshiba-tsip.com,
>      kazuhiro3.hayashi@toshiba.co.jp,
>      akihiro27.suzuki@toshiba.co.jp
>=20
> Added readme file with necessary steps to verify swupdate feature along
> with swupdate rollback.
>=20

Logically, this depends on "swupdate: add recipe to cause kernel panic=20
during system boot", thus "Patch 2/2", right?

Jan

> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>   doc/README.swupdate.md | 208 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 208 insertions(+)
>   create mode 100644 doc/README.swupdate.md
>=20
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> new file mode 100644
> index 0000000..41b5f87
> --- /dev/null
> +++ b/doc/README.swupdate.md
> @@ -0,0 +1,208 @@
> +
> +Clone the isar-cip-core repository
> +```
> +host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.gi=
t
> +```
> +
> +Install `kas-container` from the [kas project](https://github.com/siemen=
s/kas):
> +
> +```
> +host$ wget https://raw.githubusercontent.com/siemens/kas/2.6.2/kas-conta=
iner
> +host$ chmod a+x kas-container
> +```
> +
> +Build the image for swupdate
> +
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:=
kas/opt/ebg-swu.yml
> +```
> +- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-ima=
ge-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
> +- modify the image for example add a new version to the image by adding =
PV=3D2.0.0 to cip-core-image.bb
> +- rebuild the image using above command and start the new target
> +```
> +host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +```
> +
> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` fol=
der to the running system
> +
> +```
> +root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-i=
mage-cip-core-buster-qemu-amd64.swu .
> +```
> +
> +Check which partition is booted, e.g. with lsblk:
> +
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> +=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
> +=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
> +```
> +
> +Apply swupdate and reboot
> +```
> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# reboot
> +```
> +Check which partition is booted, e.g. with lsblk and the rootfs should h=
ave changed
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> +=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part
> +=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part /
> +```
> +
> +Check bootloader ustate after swupdate
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmli=
nuz
> +kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000002=
 console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           2 (TESTING)
> +```
> +
> +if Partition #1 usate is 2 (TESTING) then execute below command to confi=
rm swupdate and the command will set ustate to "OK"
> +```
> +root@demo:~# bg_setenv -c
> +```
> +
> +# swupdate rollback example
> +
> +Build the image for swupdate with service which causes kernel panic duri=
ng system boot using below command.
> +
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:=
kas/opt/ebg-swu.yml:kas/opt/swupdate-rollback.yml
> +```
> +- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-ima=
ge-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
> +- build the image again without `swupdate-rollback.yml` recipe using bel=
ow command
> +```
> +host$ ./kas-container --isar build kas-cip.yml:kas/board/qemu-amd64.yml:=
kas/opt/ebg-swu.yml
> +```
> +
> +Start the target on QEMU
> +```
> +host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
> +```
> +
> +Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` fol=
der to the running system
> +
> +```
> +root@demo:~# scp <host-user>@<host-ip>:<path-to-swu-file>/tmp/cip-core-i=
mage-cip-core-buster-qemu-amd64.swu .
> +```
> +
> +Check which partition is booted, e.g. with lsblk:
> +
> +```
> +root@demo:~# lsblk
> +NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
> +sda      8:0    0    2G  0 disk
> +=E2=94=9C=E2=94=80sda1   8:1    0 16.4M  0 part
> +=E2=94=9C=E2=94=80sda2   8:2    0   32M  0 part
> +=E2=94=9C=E2=94=80sda3   8:3    0   32M  0 part
> +=E2=94=9C=E2=94=80sda4   8:4    0 1000M  0 part /
> +=E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
> +```
> +
> +Check bootloader ustate before swupdate and should be as below
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmli=
nuz
> +kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> +Config Partition #1 Values:
> +in_progress:      no
> +revision:         1
> +kernel:           C:BOOT1:cip-core-image-cip-core-buster-qemu-amd64-vmli=
nuz
> +kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000002 rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +```
> +
> +Apply swupdate as below
> +```
> +root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +```
> +
> +check bootloader ustate after swupdate. if the swupdate is successful th=
en **revision number** should increase to **3** and status should be change=
d to **INSTALLED** for Partition #1.
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> +Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmli=
nuz
> +kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> +Config Partition #1 Values:
> +in_progress:      no
> +revision:         3
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000002=
 console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw initrd=3Dcip=
-core-image-cip-core-buster-qemu-amd64-initrd.img
> +watchdog timeout: 60 seconds
> +ustate:           1 (INSTALLED)
> +```
> +
> +Execute reboot command
> +- reboot command should cause kernel panic error.
> +- watchdog timer should expire and restart the qemu. bootloader should s=
elect previous partition to boot.
> +```
> +root@demo:~# reboot
> +```
> +
> +Once the system is restarted, check the bootloader ustate
> +- if update is failed then **revision number** should reduce to **0** an=
d status should change to **FAILED** for Partition #1.
> +```
> +root@demo:~# bg_printenv
> +----------------------------
> + Config Partition #0 Values:
> +in_progress:      no
> +revision:         2
> +kernel:           C:BOOT0:cip-core-image-cip-core-buster-qemu-amd64-vmli=
nuz
> +kernelargs:       console=3Dtty0 console=3DttyS0,115200 rootwait earlypr=
intk root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000001 rw initrd=3Dcip=
-core-image-cip-corg
> +watchdog timeout: 60 seconds
> +ustate:           0 (OK)
> +
> +user variables:
> +----------------------------
> + Config Partition #1 Values:
> +in_progress:      no
> +revision:         0
> +kernel:           C:BOOT1:vmlinuz
> +kernelargs:       root=3DPARTUUID=3Dfedcba98-7654-3210-cafe-5e0710000002=
 console=3Dtty0 console=3DttyS0,115200 rootwait earlyprintk rw initrd=3Dcip=
-core-image-cip-corg
> +watchdog timeout: 60 seconds
> +ustate:           3 (FAILED)
> +```


--=20
Siemens AG, Technology
Competence Center Embedded Linux

