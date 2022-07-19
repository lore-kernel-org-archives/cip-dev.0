Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6627EC433EF
	for <webhook@archiver.kernel.org>; Tue, 19 Jul 2022 13:40:39 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.59])
 by mx.groups.io with SMTP id smtpd.web10.40828.1658238030247044446
 for <cip-dev@lists.cip-project.org>;
 Tue, 19 Jul 2022 06:40:31 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=WQ5yvp6G;
 spf=pass (domain: siemens.com, ip: 40.107.7.59,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FXlO9XHcKnq+m5PnLgK6Jfp39ApwQ7iXUS+lkTn+BLKogtNeJ22zLpmETr0bB72KDHb9rsK2fS3Zt7DLxmHB2sNM+ijf68lfhJef6hzXmsMarf3PkE1cYuou/B1ZySwfGIfUGRrupi+S94aya7/Humd7lubcPiKaqqq7f+IllJ+0opjVkglXvnE3VoF7MNE1imkb2alfe/LGof0/ocdrHZWPxahRpFreQXHVVEs1+cbP6cru1rviuV+nvhz72+Zljf2K6w2W6vxio/mG14pIsy8BZnDs0+hkpASN3eD69Wlf78M0iGNxgXM9qAX35i8LUc/+xOeMrMyPKN2LD7cULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ypQKHDJZtiDOSJLsW9JkbKV5qoEoG3jyhq3tKjiWA4=;
 b=G1bOpbl87BKeCktFMQFBBkzMdDeIfRqJCoQsEJWxr6TSpnF5wglXln8veKMpWU+l2znjANwvhgnc247c6zOtxjwG4DkK9JDkDGc3YCFHTadrwzqUo9XIzHgwa0n7759ceqyFJX9u++uopjV+bpKiBvcm+vF3Jct0uWcq15nhqL0X+s5AN6vz0dbyUaNhaFGsY5o+tJoXxl0zojRw7Y5cc4CfxrfjqZxmW2qQmn88Kq1HGzIcd9dYMGLnmY8fZgNVqsVdciAvBH0BaXs6iEVDF3LqG2opGpLZmYWq4N1olAfAwKbiqhGMM/0rDb9hpyfEg6Xayeflj/kpXCLXCj0EiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.71) smtp.rcpttodomain=mentor.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ypQKHDJZtiDOSJLsW9JkbKV5qoEoG3jyhq3tKjiWA4=;
 b=WQ5yvp6GlFIDg9RX1o5Tl973iEVGyrQl/q0FatmqjJX5L1B0xHlfHFGeDPpT7r1FQiFVTMwkIFwMLLOqkSd88xT1408WokUt+V4xR8LSvkM/8nP/+xY7h/HcmiFEXECAw9EeTyMO4KeduVxiOnEgSIQh6pOGj0f0u/B0Y42Og5He+QKtLKI7D5k20qGr1TmmEUDFJ5B2OCUTSq0xJbp1etcz+r3NpmPBJxRYVhxMnf4Qktud5Z8MYHR0kIQYw7JLeatUBHm7BHX5r1W3GsxpJBYNhj6T7HzBRfj0OCarDpX6e8djQJ8BS2mWMfAj6qnRiLfijCSeZZOKpPmLNustmQ==
Received: from DB8PR04CA0013.eurprd04.prod.outlook.com (2603:10a6:10:110::23)
 by AM4PR1001MB1393.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:200:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Tue, 19 Jul
 2022 13:40:26 +0000
Received: from DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:110:cafe::ce) by DB8PR04CA0013.outlook.office365.com
 (2603:10a6:10:110::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Tue, 19 Jul 2022 13:40:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.71)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.71 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.71; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.71) by
 DB5EUR01FT085.mail.protection.outlook.com (10.152.5.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.12 via Frontend Transport; Tue, 19 Jul 2022 13:40:26 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC9SKA.ad011.siemens.net (194.138.21.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 19 Jul 2022 15:40:26 +0200
Received: from [139.21.19.101] (139.21.19.101) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.9; Tue, 19 Jul 2022 15:40:25 +0200
Message-ID: <7b1d4941-45a9-1389-c889-af0d7febe2b8@siemens.com>
Date: Tue, 19 Jul 2022 15:40:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [cip-dev][isar-cip-core][PATCH] doc: Update the document for
 bullseye image
Content-Language: en-US
To: Srinuvasan A <Srinuvasan_A@mentor.com>, <cip-dev@lists.cip-project.org>
References: <20220718125235.1871420-1-Srinuvasan_A@mentor.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220718125235.1871420-1-Srinuvasan_A@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.21.19.101]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--15.076200-8.000000
X-TMASE-MatchedRID: G9QKf9eUqNDdDS6etHbe202hKdup83X9fwTLmr2lfb32b09s2KGDsAvx
	MaV6x4s8vGAx/1ATZ5tx8i5uUdjWrcRY72YZeVvqcOU+CGo+d/JiWV0DQ85LUovNlIrJDKnMzKn
	r9zj6h3FZBcohYQ9S33MWfmr8UEU8A/oe4NwFf2quUfWqF4phwF2LV3ndNUhfHC7hAz/oKnJUjH
	UEf69xHsYzyg858y68hHy6a/HDKeCzQ+90QhIMZk6PxIuSksyTR3/YVKCZ7n+tIAhaF1t672AW2
	j9VWc0lwaUU9evdfcPRlUK52SaiHudm2EP7ypTnDdVkCiUNvR1TzaoxYFQFUHScCUrPKwM5LPcg
	mI1EeksVdmVcyy1BK3nC8v2KW2/A3iY5enorcx4T8ltSZlOY+R3noULxg9bujrVn4cme+w4ujMj
	6uE1hubbMVaqtU3gFki7wEI18pApBj25t7WpOfl+24nCsUSFNt7DW3B48kkHdB/CxWTRRu25FeH
	tsUoHuvjVNtXuCXRUvaElC8uGVZUQaD62Mumd6XUBQeoJeEDY2RRIMOrvjaQ==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.076200-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 9A423AB3F902BA872E78D404FB0CD951BC0FC881C5C99CEB4438BDA3AABA76812000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0541c806-f2e3-4e49-87e5-08da698c3d0f
X-MS-TrafficTypeDiagnostic: AM4PR1001MB1393:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	WAXdllNjMzx1VQcw5HAbkQGe5w6cSqAiKgEWVc9bLSmE+uTkgCtXl4B2DW65B7sb1D4s3tj0rzz9drJF+CjrI1HeHVUjdA/rt7THlJihpZPwcP9opSGFIBl9KhZg3zBmBPPgqVpVimrg9wtHLQi9+IKctGWCx3deillhlZzPXUKgmBfWcUfBu4L7wl17niMXzMX7suZXPCUcm6UXleGs9slesiocIXXN++nOM6kg4foVew1nUYKCYd1kWA5aW9NdgWlFWXPobqRT30PAf6RcXHTqJYfDWr2p3Kf6l1xBZQ344jaJfwgA0L0UesPm7+HhmikS0nOlLUU1LioLbpL9edLYo2e0b/8ipzPEds9awAZTVhLsIG6i5OFScjTGWIRL9nLFd525ExPnZ+Q7xrl+onNMgQUH8H/Q8u2qUBaKzxHFJHhecU1cJ3RFk+IhwLrrxzmVsy8Uv03Z+vOf2biVxPUz+GLCKjluNgy30VUl2sqiRZry3NOigSvkxCZlQ7GMul5iQ5Psi9bOFOJytoEDODeBIWH7zwTdS26hQpmtcBxj1fhnk+x7gjOwST3O8JHKVLbN3lJBHQPNEbZ/wxl24dT/Ml6sObxFw7G1JVCgosYMkFKRzsYFB4IZVh0DPVk2ON2dfgu8ihl64srz2HffvmJeFD0G+D7eEVgxxl128YN0ky33Z6pC8mgM9aF2FUdlUgFzkj/kb73KAn5gbq/U77P7laNlgVGjQHR+oM58w7p3E8IuchntoRWmxYEBUnj4eNr0m9zqouG8wgscaVBkG1/DUsRJt1xYgCqr1yNzjDoDMcGqzenxcIpa0sVhWw2dvD263lKrjJnbbBi1nivtVurm7A3g8M69qgy/IU+hQqwDG/kySlMYfJ2PckZYLE0cM2uH/iiXhG518dqWVNdySQ==
X-Forefront-Antispam-Report: 
	CIP:194.138.21.71;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(136003)(346002)(396003)(36840700001)(46966006)(40470700004)(36860700001)(40460700003)(47076005)(336012)(16526019)(40480700001)(110136005)(186003)(83380400001)(81166007)(8676002)(16576012)(31686004)(316002)(6706004)(36756003)(70586007)(8936002)(53546011)(82960400001)(2906002)(26005)(956004)(86362001)(41300700001)(2616005)(5660300002)(44832011)(356005)(70206006)(478600001)(31696002)(82740400003)(15650500001)(82310400005)(3940600001)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2022 13:40:26.6333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 0541c806-f2e3-4e49-87e5-08da698c3d0f
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.71];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT085.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR1001MB1393
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 19 Jul 2022 13:40:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/8861

On 18.07.22 14:52, Srinuvasan A wrote:
> From: Srinuvasan A <srinuvasan_a@mentor.com>
>=20
> Now the default distro is bullseye, hence correct the document of
> swupdate and secureboot w.r.t bullseye image.
>=20
> Signed-off-by: Srinuvasan A <srinuvasan_a@mentor.com>
> ---
>  doc/README.secureboot.md |  6 +++---
>  doc/README.swupdate.md   | 16 ++++++++--------
>  2 files changed, 11 insertions(+), 11 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index c1a0301..319b4db 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -204,10 +204,10 @@ OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
> =20
>  For updating the image, the following steps are necessary:
>  - [Build the image with snakeoil keys](### Build image)
> -- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-buster-qemu-amd64.swu` to /tmp
> +- save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-bullseye-qemu-amd64.swu` to /tmp
>  - modify the image for example add a new version to the image by adding =
`PV=3D2.0.0` to
>    [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
> -- start the new target and copy the swu `cip-core-image-cip-core-buster-=
qemu-amd64.swu`
> +- start the new target and copy the swu `cip-core-image-cip-core-bullsey=
e-qemu-amd64.swu`
>    to the running system, e.g.:
>  ```
>  SECURE=3Dy ./start-qemu.sh amd64 -virtfs local,path=3D/tmp,mount_tag=3Dh=
ost0,security_model=3Dpassthrough,id=3Dhost0
> @@ -228,7 +228,7 @@ sda      8:0    0    2G  0 disk
>  =E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
>  ```
> =20
> -- install with `swupdate -i /mnt/cip-core-image-cip-core-buster-qemu-amd=
64.swu`
> +- install with `swupdate -i /mnt/cip-core-image-cip-core-bullseye-qemu-a=
md64.swu`
>  - reboot
>  - check which partition is booted, e.g. with `lsblk`. The rootfs should =
have changed:
>  ```
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> index e28db24..1b242a2 100644
> --- a/doc/README.swupdate.md
> +++ b/doc/README.swupdate.md
> @@ -15,7 +15,7 @@ Then build the image which will later serve as update p=
ackage:
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-buster-qemu-amd64.swu` into a separate folder (ex: /tmp).
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` into a separate folder (ex: /tmp).
> =20
>  Next, rebuild the image, switching to the RT kernel as modification:
>  ```
> @@ -27,9 +27,9 @@ Now start the image which will contain the RT kernel:
>  host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>  ```
> =20
> -Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` fol=
der into the running system:
> +Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` f=
older into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu ro=
ot@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu =
root@localhost:
>  ```
> =20
>  Check which partition is booted, e.g. with lsblk:
> @@ -56,7 +56,7 @@ root@demo:~# cat /sys/kernel/realtime
> =20
>  Now apply swupdate and reboot
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
>  root@demo:~# reboot
>  ```
> =20
> @@ -123,7 +123,7 @@ Build the image for swupdate with a service which cau=
ses kernel panic during sys
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/kernel-panic.yml
>  ```
> -Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-buster-qemu-amd64.swu` in a separate folder.
> +Save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-imag=
e-cip-core-bullseye-qemu-amd64.swu` in a separate folder.
>  Then build the image without `kernel-panic.yml` recipe using below comma=
nd:
>  ```
>  host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
> @@ -134,14 +134,14 @@ Start the target on QEMU:
>  host$ SWUPDATE_BOOT=3Dy ./start-qemu.sh amd64
>  ```
> =20
> -Copy `cip-core-image-cip-core-buster-qemu-amd64.swu` file from `tmp` fol=
der into the running system:
> +Copy `cip-core-image-cip-core-bullseye-qemu-amd64.swu` file from `tmp` f=
older into the running system:
>  ```
> -host$ scp -P 22222 /tmp/cip-core-image-cip-core-buster-qemu-amd64.swu ro=
ot@localhost:
> +host$ scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu =
root@localhost:
>  ```
> =20
>  Apply swupdate as below:
>  ```
> -root@demo:~# swupdate -i cip-core-image-cip-core-buster-qemu-amd64.swu
> +root@demo:~# swupdate -i cip-core-image-cip-core-bullseye-qemu-amd64.swu
>  ```
> =20
>  Check bootloader ustate after swupdate. If the swupdate is successful th=
en **revision number** should be **3** and status should be changed to **IN=
STALLED** for Partition #1.

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

