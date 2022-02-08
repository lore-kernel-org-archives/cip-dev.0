Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D79C433EF
	for <webhook@archiver.kernel.org>; Tue,  8 Feb 2022 18:42:08 +0000 (UTC)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (EUR05-AM6-obe.outbound.protection.outlook.com [40.107.22.79])
 by mx.groups.io with SMTP id smtpd.web12.15456.1644345726961659337
 for <cip-dev@lists.cip-project.org>;
 Tue, 08 Feb 2022 10:42:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=Ic3lTdx6;
 spf=pass (domain: siemens.com, ip: 40.107.22.79,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g9T31PaO2f/iAQtHC01G4GXvMztFDu/EtYGSkX6kmtBXxv4/3SYfxHZEhNGUSL+o4nDPh2YS4iemKu7vDh9nvBn4n4bQtfs0SvXl+nfJG2tvqLJXhUTXX7pUW4ZTyn/cTcuolQCen/HMinye4X2Bx6DflAZGv6r4/YBY0xC/DliQWRI35240/sJG+EiyGutUiy44jiXnfUmILHZBQf6PGGwVRaCeOozyDVtOxdnMbXCPumIS0VcDtyUa34rwBY/dfQr4mzifdJkDNae/FISjBqganWCYEFt5Uy5B8a/YFa81FhVD1ws3Tbv2KGpTeIiFPkTLQkSUhtKI4EpHna5Qtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BROFL98vj/yY5AHFhb0NCXuI2yOXb3lRFyhGsMj1V0g=;
 b=eR5s4PHfaUwiI7OljpUDeE5qh8OHtOLjRT22Sj1zHZG2CCAlaZzpb113C9uEA3bggE5AbULSZ/awr4DE8CRJPUkvn2HvjZX1BxbyUsM1q3PmQjCIeCzc27+6EqA7EAIurh5kJpj7L//oXE1yeGAbtg26XGT2Gjbu8hWlJXox05LKESiSyNIlYbWsTWv26gGUqgJVaYXWDc99F0GOA8mDzOt4LC0CgPrBny7lpMSXUZWbAvIp3AIaX5KFZ4Hw+eXo6ArsriNzW9EGkVF8dSw7H7yHsCpvX35Ke45fNATiqmJO3pFQFrQgeGZWy2xymqhNddYYx0DFRBjg2Fk50PT6Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.73) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BROFL98vj/yY5AHFhb0NCXuI2yOXb3lRFyhGsMj1V0g=;
 b=Ic3lTdx6Ykv0vncwh5AIj6rKgrUYv9LlDhFtEsEWN/6cZ7hQD01JZZ4gNKcpI7GmaS4uRjKYmFUyEWVB/u2ROB9cdCOiDFyZ+QOu90fas+gxn69ZBYqj7m9EzvB8phGq0owdVfudlBn/y8V4yHaK3IJ6nNXrz377T6ZjRZwY/9BxaHm6rkuLOWqlZ/c2hcWUuMEY6kD1Ogp92zrqzwzXMlXKbMDLI8ZnQiSSYHLUqOx57fW3LUBj8yIxeTg5yG4rHxBAdw+Wai/HtLfkRLDKZgv3/4beqRXdEmd2DQ+LJgR/23pbqGJ8Bx2qWu9RJ/qo9IWV2hniVNIAb4hDvgPkLQ==
Received: from DU2PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:10:3b::19)
 by DB9PR10MB4380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:225::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 18:42:04 +0000
Received: from DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::1d) by DU2PR04CA0014.outlook.office365.com
 (2603:10a6:10:3b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Tue, 8 Feb 2022 18:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.73)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.73 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.73; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.73) by
 DB5EUR01FT057.mail.protection.outlook.com (10.152.5.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Tue, 8 Feb 2022 18:42:03 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SNA.ad011.siemens.net (194.138.21.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 19:42:02 +0100
Received: from [139.22.137.229] (139.22.137.229) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Tue, 8 Feb 2022 19:42:02 +0100
Message-ID: <d666d83b-0ab0-5c3f-884b-4c0144feb079@siemens.com>
Date: Tue, 8 Feb 2022 19:42:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [isar-cip-core v3] README.swupdate.md: add readme file with steps
 to verify swupdate
Content-Language: en-US
To: <Shivanand.Kunijadar@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>,
	<quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>,
	<akihiro27.suzuki@toshiba.co.jp>
References: <c5e89aca-caf7-17dc-7a96-94e86cade48c@siemens.com>
 <20220208113225.22682-1-Shivanand.Kunijadar@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220208113225.22682-1-Shivanand.Kunijadar@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.137.229]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f1017ce-8d47-4650-7eb4-08d9eb32b306
X-MS-TrafficTypeDiagnostic: DB9PR10MB4380:EE_
X-Microsoft-Antispam-PRVS: 
	<DB9PR10MB4380AB4F97C039796B4E9513952D9@DB9PR10MB4380.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Y6Op/eNfjJa+oV409vcbA/2j201Hlk4aFXnUxA6PVcF7VZ9JNmJc6BAcZLmH2men9OHCHejdmA2ndq4bWII+UqID8upQcV/4nQo5uj7hYrtjGl/z7j6rqjRUnvvbhoMF9p6QI60ozHmtSEiglxJpvTVB66a3FMGdEr1rtK03233q76iHNU4cS1t+coH8QskQIq/bfYn+ZZievBVPFiIXe1oTrr5qRFvmihD2rNEqu4oko+0QdS95O+WtN1qTh1YUQLB/YIQA4RfT9xXU3++x3GOubDumGVcC8asMmyTrRKH/o+ImxI27U+F3WQBXmTJIrz6b7dPHDz6dMpIwSGWt/Kgb9GvCyA9Euggg1vmOUzqH68ZyJsp8fLMafiA6qefiv4XPOtcnwFwdejlxEuNyJbIs1Y1L9m5eXigfGyDNPXoDQTnCbG2ms5LxQvyhG1vupKxM7wHi0mcYhQWiiU5ExHz8oznq61ADMxJwQNDnsyR/TyeFnKSYrbqVkT1ROaNn2HKOM34qlIko0i5cmg4IkCCRsPo+BTYtnNwnEyU+sFEI+WxBO9MzfQJ538rugi1giesb6JDYiwbJAVCuD+0Y2ugCi0ByFROkulqlQyokK/NE9TKi2D3SexTJ2DsLwyFcA/o1IxvfkIUn+gxa+3GP5RCwo3hVi6u4yKaFQQydMTlT/fRKnD586DrEwG0H97JCkp9HHP/YLYZZyGrrKy7qOuF0qeeRq6uc/rKk5AfGlXNatbTh5W8ZeBkePrGDZ3y40PXbw786W4LS31VzDlO2aU/tuvvwbXhClM7Fam81t01HiOmPgZV6GXZYu384y2xOwzI2QOQ/ftrktBS+N/qNj+UkSJMfpMTUL4UKMdNIpKE5REMJIzGCaUDBGWGgQa2i
X-Forefront-Antispam-Report: 
	CIP:194.138.21.73;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(31686004)(966005)(508600001)(82310400004)(16576012)(70206006)(47076005)(316002)(86362001)(82960400001)(31696002)(81166007)(356005)(40460700003)(6706004)(6636002)(110136005)(36860700001)(16526019)(956004)(2616005)(15650500001)(5660300002)(44832011)(53546011)(4326008)(83380400001)(54906003)(2906002)(26005)(186003)(8676002)(336012)(8936002)(36756003)(70586007)(3940600001)(43740500002)(36900700001)(47845001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:42:03.3341
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7f1017ce-8d47-4650-7eb4-08d9eb32b306
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.73];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT057.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB4380
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 08 Feb 2022 18:42:08 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7585

On 08.02.22 12:32, Shivanand.Kunijadar@toshiba-tsip.com wrote:
> From: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
>=20
> Prepare readme file with necessary steps to verify swupdate feature
> with rollback functionality.
>=20
> Signed-off-by: Shivanand Kunijadar <Shivanand.Kunijadar@toshiba-tsip.com>
> ---
>  doc/README.swupdate.md | 203 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 203 insertions(+)
>  create mode 100644 doc/README.swupdate.md
>=20
> diff --git a/doc/README.swupdate.md b/doc/README.swupdate.md
> new file mode 100644
> index 0000000..05768da
> --- /dev/null
> +++ b/doc/README.swupdate.md
> @@ -0,0 +1,203 @@
> +
> +Clone the isar-cip-core repository
> +```
> +host$ git clone https://gitlab.com/cip-project/cip-core/isar-cip-core.gi=
t
> +```
> +
> +Build the CIP Core image
> +
> +Set up `kas-container` as described in the [top-level README](../README.=
md).
> +Then build the image:
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
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
> +root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-im=
age-cip-core-buster-qemu-amd64.swu .
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
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml:kas/opt/kernel-panic.yml
> +```
> +- save the generated swu build/tmp/deploy/images/qemu-amd64/cip-core-ima=
ge-cip-core-buster-qemu-amd64.swu in a separate folder (ex: tmp)
> +- build the image again without `kernel-panic.yml` recipe using below co=
mmand
> +```
> +host$ ./kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt=
/ebg-swu.yml
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
> +root@demo:~# scp <host-user>@10.0.2.2:<path-to-swu-file>/tmp/cip-core-im=
age-cip-core-buster-qemu-amd64.swu .
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

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

