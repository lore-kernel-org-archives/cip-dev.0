Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10712C6FA82
	for <webhook@archiver.kernel.org>; Tue, 20 Sep 2022 16:27:39 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.62])
 by mx.groups.io with SMTP id smtpd.web12.14338.1663691251425115375
 for <cip-dev@lists.cip-project.org>;
 Tue, 20 Sep 2022 09:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=aHMiBflP;
 spf=pass (domain: siemens.com, ip: 40.107.6.62,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cs2hjhhdqcK8S+8vSigq4R/rooyTDTQkFcMgmyYgEEh2oMT+wOr87L2msyabRFFPYNFQ1ILHsSbqSBJ2zgp7avdgQAIpoXj7dEMM9hAbZ02P9Y7fO0/p0iEvRrLLwfOoem6O3F3+6O5mspjK9r3DNQls5dtAO1uQooLNxrlqLDhih9SLrRgRkOWgyI31v8Rdpbnx8JgfTvHkY7M9rjowqUNl16bLpAtpXiV47Diq2JCeIjIEMtM8JCtfIBP4vonba4RS3/S1ALzTnpRqaXBPik2ZvqLamqVs2rl4F8XzNCOqlpv7KzM9Ib2xV8pjHNdKD/Q7OTe84zG7jH47jczk5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sczwngNjcqY6we0o95qUPHA6p5kDK3A9wvOp7XLQMjY=;
 b=SLg/DhmZ2wJ8a3FtRz0Kica2B2nq14KtHvE7lT0h8cuYC353qON6AcnV7NLavEEt6mhkd/evmD9hHplZNztqQ38z34rwXYw1kzuUnmYfgBAfwvEWRU/3pay0GraY7OKYNtVTEgWtCkOVvbWH7GV4jI1UyDZMZudx1baoR9LZk90WN72KbV+zE7IyqaukW319rIIuKEzNpXt52WyW5eHaKmzIQJLdvADrZygsOTv03Bb9RQ7NLBdDn0kn7lwqmcJwqgEOWzjJlj9fHhideR5I0LdDem9rRDDcvKzr3F7cB6LbQ1qck/hgpNgUnLZ49i2MqcIxegcbv3bLPOGbZplsSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.75) smtp.rcpttodomain=toshiba-tsip.com smtp.mailfrom=siemens.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=siemens.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sczwngNjcqY6we0o95qUPHA6p5kDK3A9wvOp7XLQMjY=;
 b=aHMiBflPwma6ymyLxeuqQsZ1h4S/mT3WN2V+1zxf24K0H/Xvoh3/cC3i9yFn5QqwCy6+rClj72fgBETfKAUP8smK0HBh19JepC5pSB2KzJFGfbW33AzXI7xRrN28NUpTVVlubUvgJ+GJDLYkdGNbi0H59DigiQv8RMn9EjgwoAFkXWFl02v2lFaZAUXIk4QK2kQS9iXLBNJPPumswVYseOKDVlU9fc6TzhrwhSl2xow/+nJz1oAZjKbLZG96MN1koMIb1Tylaxf/ffyIiNEaeFrxzojBc3N/vkRwx2yyT+U5dYT3YX54rSPpjzrxaju4Y/l5juNzB11MoBcERUr8lA==
Received: from DU2PR04CA0017.eurprd04.prod.outlook.com (2603:10a6:10:3b::22)
 by AM7PR10MB3463.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:139::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Tue, 20 Sep
 2022 16:27:29 +0000
Received: from DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:10:3b:cafe::1c) by DU2PR04CA0017.outlook.office365.com
 (2603:10a6:10:3b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 16:27:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.75)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.75 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.75; helo=hybrid.siemens.com; pr=C
Received: from hybrid.siemens.com (194.138.21.75) by
 DB5EUR01FT087.mail.protection.outlook.com (10.152.5.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 16:27:28 +0000
Received: from DEMCHDC89XA.ad011.siemens.net (139.25.226.103) by
 DEMCHDC8VRA.ad011.siemens.net (194.138.21.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.12; Tue, 20 Sep 2022 18:27:27 +0200
Received: from [139.22.141.239] (139.22.141.239) by
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.12; Tue, 20 Sep 2022 18:27:26 +0200
Message-ID: <5570a5d2-5417-1fd3-bc60-7f1067bc8cc8@siemens.com>
Date: Tue, 20 Sep 2022 18:27:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [isar-cip-core] README.secureboot.md : Update steps for bullseye
 version
Content-Language: en-US
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>, "Quirin
 Gylstorff" <quirin.gylstorff@siemens.com>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
References: <20220920154019.555-1-Sai.Sathujoda@toshiba-tsip.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220920154019.555-1-Sai.Sathujoda@toshiba-tsip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [139.22.141.239]
X-ClientProxiedBy: DEMCHDC89XA.ad011.siemens.net (139.25.226.103) To
 DEMCHDC89XA.ad011.siemens.net (139.25.226.103)
X-TM-AS-Product-Ver: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-AS-Result: No-10--23.122500-8.000000
X-TMASE-MatchedRID: SPXcha2wtZzdDS6etHbe2w11PXnHro0//k5m7D0YTS/x5KZMlKYS/eRj
	ZuXE0WlHSZ8QfzbnScChSUtbFjUi0q3aC25avUua7k3eQ7SGVtKagvq+uK+0JMeuFL5UpINxczQ
	nRrpmbEngm7lSO4VWy3/KdTO4XUruuuklncNdZER6RCe/p6TP0ZT/4A/EUxg4Xrumkbea2MmNY/
	pqxovzxcwsPCCuwrU7v8RLHPvuU069jXSlSXPwrYRPnGaoX0EhHWE34M0GO86tIAhaF1t674VQ5
	5H8w+7mTJDyHMXec/YQwbwraxlHedRVkZDhZpEuiDskcbbOd/mUkDPUhpX2viknxKlVP07/lNc2
	tyboPcJirg8tJChsdJdtyTUmkMozpTfOax9VQl6QS/vqTZPVjiAqG/HTQfXBSHCU59h5KrGCLM0
	qfGuxcmnbLXx5NP9t21pBzAE1M7o0bGP/lbz4SSPk0cSE4V/+wBhAKrgQyUyRgPzABkqxIPmoZ6
	x4ZgCU27KSseGDg93RlUK52SaiHkoDGBAVRyRV36R9bGEGEnIdragYC5Z0+xSceev8ZtpPbiVzM
	TheSbCA6UrbM3j3qTQRC9JXJyQrjCM60ey5KKQvHEcEx0NzujLvC8LxRzodngIgpj8eDcBZDL1g
	Lmoa/PoA9r2LThYYKrauXd3MZDUD/dHyT/Xh7Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--23.122500-8.000000
X-TMASE-Version: SMEX-14.0.0.3080-8.6.1018-26680.007
X-TM-SNTS-SMTP: 
 24DD0245D387D9192228B8AED50B365E5CA2D87707CF01B08ADB3C94713F2CD12000:8
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5EUR01FT087:EE_|AM7PR10MB3463:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fb9f732-e823-4a29-8c1f-08da9b25024b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qt4+tsKOmd/9SobiUFF/WJ3kgw/L2sd8nrtppRvzBv0gTfXzrbiLvdgOPQsH+J1WboBtMcQ/moHVt0/DgsaCrntgn1cPxkAlg5J87d9/oi6+FKjAqaNyXojNuBLfqRPs76KjWyJqz1R37gB43JdjYTHFNKfpDjSJpYxzJ6+sYETDOfNSKvUpwSLb9AElycn//FDjJ1izFTBAptLxFfdCwbIwIpu6NxwKHBeLyxow2+RdC1P+YQVVG3xDe644PzV8Ndq4Yc8KGqSwmla3MH7W5d7XmykphsHNbvNTTbiGMIXJV6BHr9B9xHH3oCXDR4+++I+EAa5wRH3R8c/qDxsjQWW9f8Y7p0kOw5at9C782pQ3qp+JmBqNOsQSCegSnhS6Kefom3fLmelatTGvYglBLvJiH87pv2UxzHC1KJv1wshRax0ECe8OrMuirPuF3B6fFyEIPVVKJxOy9jfOYYkiHC8Xq3DVJsJJJgCbPbbGhyKxlU7Sg4qxv+t78dzcGcRH8tMfFVs6Vc0vVCTQbegLJFMjX9yIoUZYSaCx6Ai/KHLV8L1srR2Ifkpmg2Pgyfdn3Sc1XomCkcdABvA2pc2GtQmlmv0gJ95gYxf80HIqQSmKEz60/7wPIhQwaIhRpzLXN6YKeyHFY2DEuMtQRrGkehNmkzvGCnYEagR5Nh1V+Gz/khR7k92zfQP9D4ILyLgE8OMLjzLLumCvE26QnQuJB2J4rhLzvcNF5Tk72rxy6Phm8MMWBUHiwORia7P/21i5cba9zm5LV/8mnTbeICyXOYUyO5YOR1H3fgr9F/pUrs6BGRHAOu26IrOXXLKvM5WsknTSObYAcenpcJB4Hs0DEWw6EodjD4Fi7JvxMxrPTLkzOp2a6C1XGeJs38XHM0VqeP9j+cGYcJctTjmZkxKr6M7Ak29lGDLP4o2zhcpZ1UQ=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.75;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199015)(36840700001)(40470700004)(46966006)(16526019)(956004)(2616005)(81166007)(356005)(40460700003)(70206006)(26005)(40480700001)(336012)(8676002)(70586007)(4326008)(47076005)(36756003)(82310400005)(31696002)(16576012)(53546011)(5660300002)(8936002)(82740400003)(82960400001)(41300700001)(83380400001)(86362001)(36860700001)(478600001)(186003)(31686004)(44832011)(316002)(110136005)(6636002)(6706004)(54906003)(15650500001)(2906002)(19627235002)(3940600001)(43740500002)(36900700001)(47845001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 16:27:28.0322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 7fb9f732-e823-4a29-8c1f-08da9b25024b
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.75];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DB5EUR01FT087.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR10MB3463
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 20 Sep 2022 16:27:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9533

On 20.09.22 17:40, Sai.Sathujoda@toshiba-tsip.com wrote:
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> Updated steps to enable secureboot with user-generated & snakeoil keys.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  doc/README.secureboot.md | 62 ++++++++++++++++++++++++++--------------
>  1 file changed, 41 insertions(+), 21 deletions(-)
>=20
> diff --git a/doc/README.secureboot.md b/doc/README.secureboot.md
> index 319b4db..977377a 100644
> --- a/doc/README.secureboot.md
> +++ b/doc/README.secureboot.md
> @@ -76,7 +76,7 @@ Set up a secure boot test environment with [QEMU](https=
://www.qemu.org/)
>  ### Debian Snakeoil keys
> =20
>  The build copies the  Debian Snakeoil keys to the directory `./build/tmp=
/deploy/images/<machine>/OVMF.
> -You can use them as described in section [Start Image](### Start the ima=
ge).
> +You can use them as described in section [Start Image](#start-the-image)=
.
> =20
>  ### Generate Keys
> =20
> @@ -113,7 +113,7 @@ cp /lib/efitools/x86_64-linux-gnu/KeyTool.efi secureb=
oot-tools
>  to the current directory. OVMF_VARS_4M.fd contains no keys can be instru=
mented for secureboot.
>  3. Start QEMU with the script scripts/start-efishell.sh
>  ```
> -scripts/start-efishell.sh secureboot-tools
> +OVMF_CODE=3D/usr/share/OVMF/OVMF_CODE_4M.secboot.fd OVMF_VARS=3D./OVMF_V=
ARS_4M.fd ./scripts/start-efishell.sh secureboot-tools
>  ```
>  4. Start the KeyTool.efi FS0:\KeyTool.efi and execute the the following =
steps:
>  ```
> @@ -147,16 +147,28 @@ For user-generated keys, create a new option file i=
n the repository. This option
>  header:
>    version: 10
>    includes:
> -   - kas/opt/ebg-secure-boot-base.yml
> +   - kas/opt/ebg-swu.yml
> +
> +local_conf_header:
> +  secure-boot-image: |
> +    IMAGE_CLASSES +=3D "verity"
> +    IMAGE_FSTYPES =3D "wic"
> +    WKS_FILE =3D "${MACHINE}-efibootguard-secureboot.wks.in"
> +    INITRAMFS_INSTALL_append =3D " initramfs-verity-hook"
> +    # abrootfs cannot be installed together with verity
> +    INITRAMFS_INSTALL_remove =3D " initramfs-abrootfs-hook"
> =20
>  local_conf_header:
>    secure-boot: |
> -    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-secrets"
> -    IMAGER_INSTALL +=3D "ebg-secure-boot-secrets"
> +    IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
> +    IMAGER_INSTALL +=3D "ebg-secure-boot-signer"
> +
> +# Use user-generated keys
> +    PREFERRED_PROVIDER_secure-boot-secrets =3D "secure-boot-key"
> +
>    user-keys: |
> -    SB_CERTDB =3D "democertdb"
> -    SB_VERIFY_CERT =3D "demo.crt"
> -    SB_KEY_NAME =3D "demo"
> +    SB_CERT =3D "demo.crt"
> +    SB_KEY =3D "demo.key"
>  ```
> =20
>  Replace `demo` with the name of the user-generated certificates. The use=
r-generated certificates
> @@ -174,7 +186,7 @@ kas-container build kas-cip.yml:kas/board/qemu-amd64.=
yml:<path to the new option
> =20
>  Start the image with the following command:
>  ```
> -SECURE_BOOT=3Dy \
> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye \

We should probably flip the defaults in start-qemu.sh now...

>  ./start-qemu.sh amd64
>  ```
> =20
> @@ -194,27 +206,32 @@ To change the boot behavior, enter `exit` in the sh=
ell to enter the bios and cha
>  #### User-generated keys
>  Start the image with the following command:
>  ```
> -SECURE_BOOT=3Dy \
> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye \
>  OVMF_CODE=3D./build/tmp/deploy/images/qemu-amd64/OVMF/OVMF_CODE_4M.secbo=
ot.fd \
>  OVMF_VARS=3D<path to the modified OVMF_VARS.fd> \
>  ./start-qemu.sh amd64
>  ```
> -
> +After boot check the dmesg for secure boot status like below:
> +```
> +root@demo:~# dmesg | grep Secure
> +[    0.008368] Secure boot enabled
> +```
>  ## Example: Update the image
> =20
>  For updating the image, the following steps are necessary:
> -- [Build the image with snakeoil keys](### Build image)
> +- [Build the image with snakeoil keys](#build-image)
>  - save the generated swu `build/tmp/deploy/images/qemu-amd64/cip-core-im=
age-cip-core-bullseye-qemu-amd64.swu` to /tmp
> -- modify the image for example add a new version to the image by adding =
`PV=3D2.0.0` to
> -  [cip-core-image.bb](recipes-core/images/cip-core-image.bb)
> -- start the new target and copy the swu `cip-core-image-cip-core-bullsey=
e-qemu-amd64.swu`
> -  to the running system, e.g.:
> +- modify the image for example, switch to the RT kernel as modification:
> +```
> +kas-container build kas-cip.yml:kas/board/qemu-amd64.yml:kas/opt/ebg-sec=
ure-boot-snakeoil.yml:kas/opt/rt.yml
> +```
> +- start the new target=20
>  ```
> -SECURE=3Dy ./start-qemu.sh amd64 -virtfs local,path=3D/tmp,mount_tag=3Dh=
ost0,security_model=3Dpassthrough,id=3Dhost0
> +SECURE_BOOT=3Dy DISTRO_RELEASE=3Dbullseye ./start-qemu.sh amd64
>  ```
> -- mount `host0` on target with:
> +Copy the swu cip-core-image-cip-core-bullseye-qemu-amd64.swu to the runn=
ing system
>  ```
> -mount -t 9p -o trans=3Dvirtio,version=3D9p2000.L host0 /mnt
> +scp -P 22222 /tmp/cip-core-image-cip-core-bullseye-qemu-amd64.swu root@1=
27.0.0.1:/home/
>  ```
>  - check which partition is booted, e.g. with `lsblk`:
>  ```
> @@ -228,8 +245,11 @@ sda      8:0    0    2G  0 disk
>  =E2=94=94=E2=94=80sda5   8:5    0 1000M  0 part
>  ```
> =20
> -- install with `swupdate -i /mnt/cip-core-image-cip-core-bullseye-qemu-a=
md64.swu`
> -- reboot
> +- install the swupdate and reboot the image=20
> +```
> +root@demo:~# swupdate -i /home/cip-core-image-cip-core-bullseye-qemu-amd=
64.swu`
> +root@demo:~# reboot
> +```
>  - check which partition is booted, e.g. with `lsblk`. The rootfs should =
have changed:
>  ```
>  root@demo:~# lsblk

Quirin, could you cross-check as well? Seems fine to me on a quick glance.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux


