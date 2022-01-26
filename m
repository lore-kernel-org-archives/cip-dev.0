Return-Path: <jan.kiszka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9EDC28CF5
	for <webhook@archiver.kernel.org>; Wed, 26 Jan 2022 09:40:46 +0000 (UTC)
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
 (EUR04-VI1-obe.outbound.protection.outlook.com [40.107.8.84])
 by mx.groups.io with SMTP id smtpd.web08.10459.1643190044415898762
 for <cip-dev@lists.cip-project.org>;
 Wed, 26 Jan 2022 01:40:45 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com
 header.s=selector2 header.b=h1PzfEGN;
 spf=pass (domain: siemens.com, ip: 40.107.8.84,
 mailfrom: jan.kiszka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=apnhDS3T7syaWCkaeNEb23ZCC5TyBFVaea//Af//T/WDkkKZ9zvT/I/awLv7qzvzs2VEl4LbtfXwFyKyEh38qakLo7WMUQTf/wwgnAQ7ldAque5bS1NqPS3h9e3emFdVaTyFUbX3cNkeOBY/fGlAVQCSZO6/UijcOjXWoAGq0g2vcG/+n+hW1/wHRBAWX0OS/bn/4oE72pDAAbzx19kPvY4fK0ygOesOR89fZp2q/HL3Z3t8YapOviXDdcYYLpBfK5e2uTVr6V1iVqnuV2MkBozMfZy7+oNqzuHF69TpPycRWmIoyUM9FmzukjRqcXm58+DwDh8WLk8msiGPpuuT/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVbLo5mje+3PQaDbXeQn5jEgJGA/Lol1ntbsqxwMvmg=;
 b=IvcQkNe+G8NNaMZbp84mEnn8qFgKm/qZuV4F2wBJPcO3p4e3ocI42TKSNEOzzmvemId1yxcySgqEFB5FnE/NAR8g9ovT53BJEBzbeXJU3//nPJQarNl5GNzDSaa6H8nuciul312SDKISFmCr3pKJRizbbnptucip5T7tZ/baC7PRKFZlC927r42PSW2h6M1hoqhVLD9Tiz3oTmT0fQBXIaSRokvz0eFK2PscSNiGdcocm0h8ZcQGA5IZD31D7/c1P8Ig5NkthYqZYxxwz6DdAowwkncTeg8gRx7XAIfdn+W/yWF532h9nhIEbQKM5XuKpjpT3459uPkwHW9RTE16eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 194.138.21.72) smtp.rcpttodomain=lists.cip-project.org
 smtp.mailfrom=siemens.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=siemens.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVbLo5mje+3PQaDbXeQn5jEgJGA/Lol1ntbsqxwMvmg=;
 b=h1PzfEGNi5hIAp8zlUMKC+ELqWf5XuU1PPbK3UPC3N8RSpprsyL0WqL3IQr2NCdB8/YOjF4sqrYSzcnrQS9/D86jyu9MF/YdM9BW8HjD0O6+Bm5aBkQLg1Iy7Ju7encfD2Fm2XfKGqBZxvu5jhSYVtcQUS+jja03rl7nIb0YbAJaSTKl52IT7BC8WZ6lwpjVbfWVZ1A4024RFqLBYJIdKa3M57hIchFU2RVgs/Jzp3bnnGWKIIezc6zTtSfb2B3zzfKdHp/aWIrLY3bHS7451EKNmUfhOmAKbajfPffE3yMxe35LM0N7GdA0WIPIiAjlFA4/uTYvFVmDfFXGDNNDKw==
Received: from AM6PR10CA0093.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::34)
 by DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 09:40:40 +0000
Received: from VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::e3) by AM6PR10CA0093.outlook.office365.com
 (2603:10a6:209:8c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15 via Frontend
 Transport; Wed, 26 Jan 2022 09:40:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 194.138.21.72)
 smtp.mailfrom=siemens.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=siemens.com;
Received-SPF: Pass (protection.outlook.com: domain of siemens.com designates
 194.138.21.72 as permitted sender) receiver=protection.outlook.com;
 client-ip=194.138.21.72; helo=hybrid.siemens.com;
Received: from hybrid.siemens.com (194.138.21.72) by
 VE1EUR01FT030.mail.protection.outlook.com (10.152.2.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Wed, 26 Jan 2022 09:40:40 +0000
Received: from DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) by
 DEMCHDC9SMA.ad011.siemens.net (194.138.21.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Wed, 26 Jan 2022 10:40:39 +0100
Received: from [167.87.32.162] (167.87.32.162) by
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 26 Jan 2022 10:40:38 +0100
Message-ID: <9e710f2b-c3d6-3b01-27f6-e40f96df42bb@siemens.com>
Date: Wed, 26 Jan 2022 10:40:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [cip-dev][isar-cip-core][PATCH] update SWUpdate to 2021.11
Content-Language: en-US
To: "Q. Gylstorff" <Quirin.Gylstorff@siemens.com>,
	<cip-dev@lists.cip-project.org>
References: <20220124150855.633257-1-Quirin.Gylstorff@siemens.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20220124150855.633257-1-Quirin.Gylstorff@siemens.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.87.32.162]
X-ClientProxiedBy: DEMCHDC89YA.ad011.siemens.net (139.25.226.104) To
 DEMCHDC8A0A.ad011.siemens.net (139.25.226.106)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 300cfc4d-44f3-4bee-3e65-08d9e0afea24
X-MS-TrafficTypeDiagnostic: DBAPR10MB4140:EE_
X-Microsoft-Antispam-PRVS: 
	<DBAPR10MB41404B61741AC0AD8927BAB295209@DBAPR10MB4140.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:416;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	G03brz8vxjUiyO/x4amTJ7Wz8cYXSMTt5gvLY//5/aD/DKy9KMKNI6Ku3IZ5wUMY5oJUbjHiuR8ILiUyHznineySVw5Ugpj2gfudyx3Gg4JA921gydcW2Z74pIj8j+Ge0uudfAlfZBsyGmkSN+zlaU6rD7J8ynM4Zz2WVrVF1gvBNi/78b0mFmgyA9mwvxALS0Mpj4Ms5wkvcaMtwB3MiFDe5VGUzUmfmGrEm0gjHlQwPCmJcOeKeoaC0AfyCoW1CXbN6XJqTt1AvPlPIWi6FQSke0DVEnwNwhKaJ1RRG3doT2ROD8fScOXTBOwKEOtRPLht9T/o7Rs1tFv1yWy920orqytBZnhdXdamUvYjQFefkmcz3Cdp7d779X9jQRAsfWXy7XbwtUJajPx1vJ8V49e/nuo8jbMuHBCCr8c08G/vQHUY2bWVM0N8ICjB1V8xhJjkkatY1IVlwKSuAFs/jByDEwpsG4P0w87tr5W1p9IWVzoyFD6ngHSUOTO2drEBtVMER7cBA5ZmMgCNN5nzKdjCBVAjOfrbwp1if9Pq9cyoH85wvtpKwMzVtfEBjRbiat/ampp3cMl7oy6NFlwqAfgC7PE6Kf8NCjoMkn2lCgg5rkHl8TzT9kmD5e3T8z/Xgr+VbTGwt3FnK4mBs3HVrUiScgJoZzJEDD1Ypwp+I8SWKKCrtYhu3y4s4HIQQLOqmLTrR/cNnFeG7b8/dL0vtHIyzsw4oiXStArJDurHyAOEshQYsKn1DtaRw08OZXsbHgHXh4hQ/ZbaHVvo2LCeIGoaAQafRkCM/Odp8iqFoyIyDEkqEZinPg/b0VZfsiZfZgIvp+nd0WecAfYmo+0Wwl54EKaAhhcSynYZ3UStU6A=
X-Forefront-Antispam-Report: 
	CIP:194.138.21.72;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:hybrid.siemens.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(508600001)(966005)(82310400004)(6706004)(19627235002)(16576012)(110136005)(86362001)(8936002)(31696002)(83380400001)(70206006)(70586007)(40460700003)(8676002)(316002)(336012)(26005)(82960400001)(53546011)(36860700001)(81166007)(356005)(47076005)(186003)(2616005)(956004)(16526019)(31686004)(30864003)(5660300002)(44832011)(15650500001)(36756003)(2906002)(3940600001)(36900700001)(43740500002)(20210929001);DIR:OUT;SFP:1101;
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 09:40:40.1309
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 300cfc4d-44f3-4bee-3e65-08d9e0afea24
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;Ip=[194.138.21.72];Helo=[hybrid.siemens.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR01FT030.eop-EUR01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4140
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 26 Jan 2022 09:40:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7483

On 24.01.22 16:08, Q. Gylstorff wrote:
> From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>=20
> Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ---
>   .../swupdate-handler-roundrobin_0.1.bb        |   4 +-
>   ...dd-option-to-build-with-efibootguard.patch |  39 ----
>   ...nfig-Make-image-encryption-optional.patch} |  14 +-
>   ...an-patches-add-patches-for-dm-verity.patch | 191 ------------------
>   .../0002-debian-rules-Add-CONFIG_MTD.patch    |   8 +-
>   ...-debian-config-Make-signing-optional.patch |  40 ----
>   ...s-Add-option-to-disable-fs-creation.patch} |  32 +--
>   ...les-Add-option-to-disable-webserver.patch} |  10 +-
>   ...ake-CONFIG_HW_COMPATIBILTY-optional.patch} |  10 +-
>   ...les-Add-Embedded-Lua-handler-option.patch} |  10 +-
>   ...repare-build-for-isar-debian-buster.patch} |  18 +-
>   ...bp.bb =3D> swupdate_2021.11-1+debian-gbp.bb} |  19 +-
>   12 files changed, 63 insertions(+), 332 deletions(-)
>   delete mode 100644 recipes-core/swupdate/files/0001-debian-Add-option-t=
o-build-with-efibootguard.patch
>   rename recipes-core/swupdate/files/{0004-debian-config-Make-image-encry=
ption-optional.patch =3D> 0001-debian-config-Make-image-encryption-optional=
.patch} (80%)
>   delete mode 100644 recipes-core/swupdate/files/0001-debian-patches-add-=
patches-for-dm-verity.patch
>   delete mode 100644 recipes-core/swupdate/files/0003-debian-config-Make-=
signing-optional.patch
>   rename recipes-core/swupdate/files/{0005-debian-rules-Add-option-to-dis=
able-fs-creation.patch =3D> 0003-debian-rules-Add-option-to-disable-fs-crea=
tion.patch} (51%)
>   rename recipes-core/swupdate/files/{0006-debian-rules-Add-option-to-dis=
able-webserver.patch =3D> 0004-debian-rules-Add-option-to-disable-webserver=
.patch} (85%)
>   rename recipes-core/swupdate/files/{0007-debian-Make-CONFIG_HW_COMPATIB=
ILTY-optional.patch =3D> 0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.p=
atch} (85%)
>   rename recipes-core/swupdate/files/{0008-debian-rules-Add-Embedded-Lua-=
handler-option.patch =3D> 0006-debian-rules-Add-Embedded-Lua-handler-option=
.patch} (83%)
>   rename recipes-core/swupdate/files/{0009-debian-prepare-build-for-isar-=
debian-buster.patch =3D> 0007-debian-prepare-build-for-isar-debian-buster.p=
atch} (84%)
>   rename recipes-core/swupdate/{swupdate_2021.04-1+debian-gbp.bb =3D> swu=
pdate_2021.11-1+debian-gbp.bb} (68%)
>=20
> diff --git a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-ro=
undrobin_0.1.bb b/recipes-core/swupdate-handler-roundrobin/swupdate-handler=
-roundrobin_0.1.bb
> index 3a5a51e..1f0a620 100644
> --- a/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobi=
n_0.1.bb
> +++ b/recipes-core/swupdate-handler-roundrobin/swupdate-handler-roundrobi=
n_0.1.bb
> @@ -22,10 +22,10 @@ SRC_URI +=3D "${@('file://' + d.getVar('SWUPDATE_ROUN=
D_ROBIN_HANDLER_CONFIG')) if
>  =20
>   # lua version 5.2 is currently hard coded in swupdate @ debian salsa
>   do_install[cleandirs] =3D "${D}/etc \
> -                         ${D}/usr/share/lua/5.2"
> +                         ${D}/usr/share/lua/5.3"
>   do_install() {
>       if [ -e ${WORKDIR}/${SWUPDATE_LUASCRIPT} ]; then
> -        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/=
lua/5.2/swupdate_handlers.lua
> +        install -m 0644 ${WORKDIR}/${SWUPDATE_LUASCRIPT} ${D}/usr/share/=
lua/5.3/swupdate_handlers.lua
>       fi
>       if [ -e ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG} ]; then
>          install -m 0644 ${WORKDIR}/${SWUPDATE_ROUND_ROBIN_HANDLER_CONFIG=
} ${D}/etc/swupdate.handler.ini
> diff --git a/recipes-core/swupdate/files/0001-debian-Add-option-to-build-=
with-efibootguard.patch b/recipes-core/swupdate/files/0001-debian-Add-optio=
n-to-build-with-efibootguard.patch
> deleted file mode 100644
> index 00f9a5f..0000000
> --- a/recipes-core/swupdate/files/0001-debian-Add-option-to-build-with-ef=
ibootguard.patch
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -From fe3f090e3764e1e2625d509a56bd521bab507ce7 Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Wed, 15 Sep 2021 12:36:09 +0200
> -Subject: [PATCH 1/9] debian: Add option to build with efibootguard
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/control | 1 +
> - debian/rules   | 2 ++
> - 2 files changed, 3 insertions(+)
> -
> -diff --git a/debian/control b/debian/control
> -index 9e43eab..6031537 100644
> ---- a/debian/control
> -+++ b/debian/control
> -@@ -28,6 +28,7 @@ Build-Depends: debhelper-compat (=3D 13),
> -                libwebsockets-dev (>=3D 3.2.0) <!pkg.swupdate.bpo>,
> -                liburiparser-dev <!pkg.swupdate.bpo>,
> -                libubootenv-dev <pkg.swupdate.uboot>,
> -+               efibootguard-dev <pkg.swupdate.efibootguard>,
> -                libcmocka-dev,
> -                pkg-config,
> -                gawk,
> -diff --git a/debian/rules b/debian/rules
> -index 4b55be2..c076839 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -33,6 +33,8 @@ ifneq (,$(filter pkg.swupdate.uboot,$(DEB_BUILD_PROFIL=
ES)))
> - else ifneq (,$(filter pkg.swupdate.grub,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_BOOTLOADER_GRUB=3Dy                   >> configs/debian_de=
fconfig
> - 	echo CONFIG_GRUBENV_PATH=3D\"/boot/grub/grubenv\" >> configs/debian_de=
fconfig
> -+else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_BOOTLOADER_EBG=3Dy                    >> configs/debian_de=
fconfig
> - else
> - 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_de=
fconfig
> - endif
> ---
> -2.30.2
> -
> diff --git a/recipes-core/swupdate/files/0004-debian-config-Make-image-en=
cryption-optional.patch b/recipes-core/swupdate/files/0001-debian-config-Ma=
ke-image-encryption-optional.patch
> similarity index 80%
> rename from recipes-core/swupdate/files/0004-debian-config-Make-image-enc=
ryption-optional.patch
> rename to recipes-core/swupdate/files/0001-debian-config-Make-image-encry=
ption-optional.patch
> index 45990f8..c07b103 100644
> --- a/recipes-core/swupdate/files/0004-debian-config-Make-image-encryptio=
n-optional.patch
> +++ b/recipes-core/swupdate/files/0001-debian-config-Make-image-encryptio=
n-optional.patch
> @@ -1,7 +1,9 @@
> -From b0cfcc9980c6daf6383c6dc51fdbe90e1c7625d5 Mon Sep 17 00:00:00 2001
> +From 20bb45563fe8f3ec95ef22d715d1add014156543 Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Wed, 29 Sep 2021 15:28:21 +0200
> -Subject: [PATCH 4/9] debian/config: Make image encryption optional
> +Subject: [PATCH 1/7] debian/config: Make image encryption optional
> +
> +This can be use to ease the setup with SWUpdate.
>  =20
>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   ---
> @@ -10,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>    2 files changed, 3 insertions(+), 1 deletion(-)
>  =20
>   diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index f959e44..8e1a810 100644
> +index 02681e53..b34168e3 100644
>   --- a/debian/configs/defconfig
>   +++ b/debian/configs/defconfig
>   @@ -3,7 +3,6 @@ CONFIG_HW_COMPATIBILITY=3Dy
> @@ -22,10 +24,10 @@ index f959e44..8e1a810 100644
>    CONFIG_SURICATTA_SSL=3Dy
>    CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
>   diff --git a/debian/rules b/debian/rules
> -index 4793c84..6d32d50 100755
> +index 864add23..08b74a1d 100755
>   --- a/debian/rules
>   +++ b/debian/rules
> -@@ -42,6 +42,9 @@ endif
> +@@ -41,6 +41,9 @@ endif
>    ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
>    	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
>    endif
> @@ -36,5 +38,5 @@ index 4793c84..6d32d50 100755
>    	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
>    endif
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0001-debian-patches-add-patches-=
for-dm-verity.patch b/recipes-core/swupdate/files/0001-debian-patches-add-p=
atches-for-dm-verity.patch
> deleted file mode 100644
> index a4c8856..0000000
> --- a/recipes-core/swupdate/files/0001-debian-patches-add-patches-for-dm-=
verity.patch
> +++ /dev/null
> @@ -1,191 +0,0 @@
> -From 9904222a872e1707d8e1205009962fd68c3e5c7d Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Mon, 25 Oct 2021 14:43:07 +0200
> -Subject: [PATCH] debian/patches: add patches for dm-verity
> -
> -Backport the following patches to detect the correct partition to
> -update.
> -388f1777 util: Add get_root source /proc/self/mountinfo
> -3914d2b7 util: Extend get_root to find LUKS devices
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - ...d-get_root-source-proc-self-mountinfo.diff | 67 +++++++++++++++
> - ...-Extend-get_root-to-find-LUKS-devices.diff | 82 +++++++++++++++++++
> - debian/patches/series                         |  2 +
> - 3 files changed, 151 insertions(+)
> - create mode 100644 debian/patches/0001-util-Add-get_root-source-proc-se=
lf-mountinfo.diff
> - create mode 100644 debian/patches/0002-util-Extend-get_root-to-find-LUK=
S-devices.diff
> -
> -diff --git a/debian/patches/0001-util-Add-get_root-source-proc-self-moun=
tinfo.diff b/debian/patches/0001-util-Add-get_root-source-proc-self-mountin=
fo.diff
> -new file mode 100644
> -index 0000000..2b25a19
> ---- /dev/null
> -+++ b/debian/patches/0001-util-Add-get_root-source-proc-self-mountinfo.d=
iff
> -@@ -0,0 +1,67 @@
> -+From 388f1777e3e9e7dfbe41768aa7ce86bc0ee25c37 Mon Sep 17 00:00:00 2001
> -+From: Christian Storm <christian.storm@siemens.com>
> -+Date: Thu, 10 Jun 2021 00:30:24 +0200
> -+Subject: [PATCH 1/2] util: Add get_root source /proc/self/mountinfo
> -+
> -+Filesystems such as BTRFS report synthetic device major:minor
> -+numbers in stat(2)'s st_dev value. Hence, such a root filesystem
> -+won't be found by get_root_from_partitions().
> -+
> -+As /proc/self/mountinfo's information is subject to mount-
> -+namespacing, it complements get_root_from_partitions() rather
> -+than replacing it.
> -+
> -+Signed-off-by: Christian Storm <christian.storm@siemens.com>
> -+---
> -+ core/util.c | 28 ++++++++++++++++++++++++++++
> -+ 1 file changed, 28 insertions(+)
> -+
> -+diff --git a/core/util.c b/core/util.c
> -+index 7d7673a..51a16b6 100644
> -+--- a/core/util.c
> -++++ b/core/util.c
> -+@@ -883,6 +883,32 @@ static char *get_root_from_partitions(void)
> -+ 	return NULL;
> -+ }
> -+
> -++/*
> -++ * Return the rootfs's device name from /proc/self/mountinfo.
> -++ * Needed for filesystems having synthetic stat(2) st_dev
> -++ * values such as BTRFS.
> -++ */
> -++static char *get_root_from_mountinfo(void)
> -++{
> -++	char *mnt_point, *device =3D NULL;
> -++	FILE *fp =3D fopen("/proc/self/mountinfo", "r");
> -++	while (fp && !feof(fp)){
> -++		/* format: https://www.kernel.org/doc/Documentation/filesystems/proc=
.txt */
> -++		if (fscanf(fp, "%*s %*s %*u:%*u %*s %ms %*s %*[-] %*s %ms %*s",
> -++			   &mnt_point, &device) =3D=3D 2) {
> -++			if ( (!strcmp(mnt_point, "/")) && (strcmp(device, "none")) ) {
> -++				free(mnt_point);
> -++				break;
> -++			}
> -++			free(mnt_point);
> -++			free(device);
> -++		}
> -++		device =3D NULL;
> -++	}
> -++	(void)fclose(fp);
> -++	return device;
> -++}
> -++
> -+ #define MAX_CMDLINE_LENGTH 4096
> -+ static char *get_root_from_cmdline(void)
> -+ {
> -+@@ -936,6 +962,8 @@ char *get_root_device(void)
> -+ 	root =3D get_root_from_partitions();
> -+ 	if (!root)
> -+ 		root =3D get_root_from_cmdline();
> -++	if (!root)
> -++		root =3D get_root_from_mountinfo();
> -+
> -+ 	return root;
> -+ }
> -+--
> -+2.30.2
> -+
> -diff --git a/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devic=
es.diff b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.dif=
f
> -new file mode 100644
> -index 0000000..039bfb8
> ---- /dev/null
> -+++ b/debian/patches/0002-util-Extend-get_root-to-find-LUKS-devices.diff
> -@@ -0,0 +1,82 @@
> -+From 3914d2b73bf80b24aba015d9225082c2965c7a02 Mon Sep 17 00:00:00 2001
> -+From: Stefano Babic <sbabic@denx.de>
> -+Date: Thu, 10 Jun 2021 16:14:44 +0200
> -+Subject: [PATCH 2/2] util: Extend get_root to find LUKS devices
> -+
> -+This helps in case of encrypted filesystem or device mapper.
> -+The returned device read from partitions is usually a dm-X device and
> -+this does not show which is the block device that contains it. Look in
> -+sysfs and check if the device has "slaves" entries, indicating the
> -+presence of an underlying device. If found, return this instead of the
> -+device returned parsing /proc/partitions.
> -+
> -+Signed-off-by: Stefano Babic <sbabic@denx.de>
> -+---
> -+ core/util.c | 26 ++++++++++++++++++++++++--
> -+ 1 file changed, 24 insertions(+), 2 deletions(-)
> -+
> -+diff --git a/core/util.c b/core/util.c
> -+index 51a16b6..3b81c09 100644
> -+--- a/core/util.c
> -++++ b/core/util.c
> -+@@ -24,6 +24,7 @@
> -+ #include <libgen.h>
> -+ #include <regex.h>
> -+ #include <string.h>
> -++#include <dirent.h>
> -+
> -+ #if defined(__linux__)
> -+ #include <sys/statvfs.h>
> -+@@ -851,6 +852,10 @@ size_t snescape(char *dst, size_t n, const char *s=
rc)
> -+ /*
> -+  * This returns the device name where rootfs is mounted
> -+  */
> -++
> -++static int filter_slave(const struct dirent *ent) {
> -++	return (strcmp(ent->d_name, ".") && strcmp(ent->d_name, ".."));
> -++}
> -+ static char *get_root_from_partitions(void)
> -+ {
> -+ 	struct stat info;
> -+@@ -858,11 +863,28 @@ static char *get_root_from_partitions(void)
> -+ 	char *devname =3D NULL;
> -+ 	unsigned long major, minor, nblocks;
> -+ 	char buf[256];
> -+-	int ret;
> -++	int ret, dev_major, dev_minor, n;
> -++	struct dirent **devlist =3D NULL;
> -+
> -+ 	if (stat("/", &info) < 0)
> -+ 		return NULL;
> -+
> -++	dev_major =3D info.st_dev / 256;
> -++	dev_minor =3D info.st_dev % 256;
> -++
> -++	/*
> -++	 * Check if this is just a container, for example in case of LUKS
> -++	 * Search if the device has slaves pointing to another device
> -++	 */
> -++	snprintf(buf, sizeof(buf) - 1, "/sys/dev/block/%d:%d/slaves", dev_maj=
or, dev_minor);
> -++	n =3D scandir(buf, &devlist, filter_slave, NULL);
> -++	if (n =3D=3D 1) {
> -++		devname =3D strdup(devlist[0]->d_name);
> -++		free(devlist);
> -++		return devname;
> -++	}
> -++	free(devlist);
> -++
> -+ 	fp =3D fopen("/proc/partitions", "r");
> -+ 	if (!fp)
> -+ 		return NULL;
> -+@@ -872,7 +894,7 @@ static char *get_root_from_partitions(void)
> -+ 			     &major, &minor, &nblocks, &devname);
> -+ 		if (ret !=3D 4)
> -+ 			continue;
> -+-		if ((major =3D=3D info.st_dev / 256) && (minor =3D=3D info.st_dev % =
256)) {
> -++		if ((major =3D=3D dev_major) && (minor =3D=3D dev_minor)) {
> -+ 			fclose(fp);
> -+ 			return devname;
> -+ 		}
> -+--
> -+2.30.2
> -+
> -diff --git a/debian/patches/series b/debian/patches/series
> -index 8c5564a..f3bd00e 100644
> ---- a/debian/patches/series
> -+++ b/debian/patches/series
> -@@ -1 +1,3 @@
> - use-gcc-compiler.diff
> -+0002-util-Extend-get_root-to-find-LUKS-devices.diff
> -+0001-util-Add-get_root-source-proc-self-mountinfo.diff
> ---
> -2.30.2
> -
> diff --git a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD=
.patch b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> index 0921aef..8ebd09e 100644
> --- a/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> +++ b/recipes-core/swupdate/files/0002-debian-rules-Add-CONFIG_MTD.patch
> @@ -1,7 +1,7 @@
> -From 43365f98d70d83dac42913ff907a8a9dd25a4333 Mon Sep 17 00:00:00 2001
> +From 1d52fe25e72f9e33525bca7efa5efe901cb32c65 Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Wed, 29 Sep 2021 11:29:57 +0200
> -Subject: [PATCH 2/9] debian/rules: Add CONFIG_MTD
> +Subject: [PATCH 2/7] debian/rules: Add CONFIG_MTD
>  =20
>   if pkg.swupdate.bpo is set CONFIG_MTD is disable but not enabled.
>  =20
> @@ -11,7 +11,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>    1 file changed, 1 insertion(+)
>  =20
>   diff --git a/debian/rules b/debian/rules
> -index c076839..292133b 100755
> +index 08b74a1d..6705140b 100755
>   --- a/debian/rules
>   +++ b/debian/rules
>   @@ -20,6 +20,7 @@ endif
> @@ -23,5 +23,5 @@ index c076839..292133b 100755
>    	echo CONFIG_CFI=3Dy                  >> configs/debian_defconfig
>    	echo CONFIG_CFIHAMMING1=3Dy          >> configs/debian_defconfig
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0003-debian-config-Make-signing-=
optional.patch b/recipes-core/swupdate/files/0003-debian-config-Make-signin=
g-optional.patch
> deleted file mode 100644
> index 347b316..0000000
> --- a/recipes-core/swupdate/files/0003-debian-config-Make-signing-optiona=
l.patch
> +++ /dev/null
> @@ -1,40 +0,0 @@
> -From 37f9afeeac5483f677b5be41b3d31e6557fcc146 Mon Sep 17 00:00:00 2001
> -From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> -Date: Wed, 29 Sep 2021 15:27:51 +0200
> -Subject: [PATCH 3/9] debian/config: Make signing optional
> -
> -Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
> ----
> - debian/configs/defconfig | 1 -
> - debian/rules             | 3 +++
> - 2 files changed, 3 insertions(+), 1 deletion(-)
> -
> -diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index b38aa62..f959e44 100644
> ---- a/debian/configs/defconfig
> -+++ b/debian/configs/defconfig
> -@@ -2,7 +2,6 @@ CONFIG_SYSTEMD=3Dy
> - CONFIG_HW_COMPATIBILITY=3Dy
> - CONFIG_DOWNLOAD=3Dy
> - CONFIG_DOWNLOAD_SSL=3Dy
> --CONFIG_SIGNED_IMAGES=3Dy
> - CONFIG_SIGALG_CMS=3Dy
> - CONFIG_ENCRYPTED_IMAGES=3Dy
> - CONFIG_SURICATTA=3Dy
> -diff --git a/debian/rules b/debian/rules
> -index 292133b..4793c84 100755
> ---- a/debian/rules
> -+++ b/debian/rules
> -@@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB_=
BUILD_PROFILES)))
> - else
> - 	echo CONFIG_BOOTLOADER_NONE=3Dy                   >> configs/debian_de=
fconfig
> - endif
> -+ifeq (,$(filter pkg.swupdate.nosigning,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
> -+endif
> - ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
> - 	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
> - endif
> ---
> -2.30.2
> -
> diff --git a/recipes-core/swupdate/files/0005-debian-rules-Add-option-to-=
disable-fs-creation.patch b/recipes-core/swupdate/files/0003-debian-rules-A=
dd-option-to-disable-fs-creation.patch
> similarity index 51%
> rename from recipes-core/swupdate/files/0005-debian-rules-Add-option-to-d=
isable-fs-creation.patch
> rename to recipes-core/swupdate/files/0003-debian-rules-Add-option-to-dis=
able-fs-creation.patch
> index 1121923..876e164 100644
> --- a/recipes-core/swupdate/files/0005-debian-rules-Add-option-to-disable=
-fs-creation.patch
> +++ b/recipes-core/swupdate/files/0003-debian-rules-Add-option-to-disable=
-fs-creation.patch
> @@ -1,47 +1,51 @@
> -From 22a96e95676123c6ce8800b9d911402704dce9e2 Mon Sep 17 00:00:00 2001
> +From 8b6f01b6126933723963497d0db0c256e5251c5b Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Mon, 4 Oct 2021 17:15:56 +0200
> -Subject: [PATCH 5/9] debian/rules: Add option to disable fs creation
> +Subject: [PATCH 3/7] debian/rules: Add option to disable fs creation
>  =20
>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   ---
> - debian/configs/defconfig | 4 ----
> - debian/rules             | 7 +++++++
> - 2 files changed, 7 insertions(+), 4 deletions(-)
> + debian/configs/defconfig | 6 ------
> + debian/rules             | 9 +++++++++
> + 2 files changed, 9 insertions(+), 6 deletions(-)
>  =20
>   diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index 8e1a810..d011deb 100644
> +index b34168e3..d011deb1 100644
>   --- a/debian/configs/defconfig
>   +++ b/debian/configs/defconfig
> -@@ -9,10 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
> +@@ -9,12 +9,6 @@ CONFIG_UPDATE_STATE_CHOICE_BOOTLOADER=3Dy
>    CONFIG_WEBSERVER=3Dy
>    CONFIG_MONGOOSESSL=3Dy
>    CONFIG_ZSTD=3Dy
>   -CONFIG_DISKPART=3Dy
> +-CONFIG_DISKPART_FORMAT=3Dy
>   -CONFIG_DISKFORMAT=3Dy
> +-CONFIG_DISKFORMAT_HANDLER=3Dy
>   -CONFIG_FAT_FILESYSTEM=3Dy
>   -CONFIG_EXT_FILESYSTEM=3Dy
>    CONFIG_UNIQUEUUID=3Dy
>    CONFIG_RAW=3Dy
>    CONFIG_RDIFFHANDLER=3Dy
>   diff --git a/debian/rules b/debian/rules
> -index 6d32d50..9349c22 100755
> +index 6705140b..983e122f 100755
>   --- a/debian/rules
>   +++ b/debian/rules
> -@@ -45,6 +45,13 @@ endif
> +@@ -45,6 +45,15 @@ endif
>    ifeq (,$(filter pkg.swupdate.noencryption,$(DEB_BUILD_PROFILES)))
>    	echo CONFIG_ENCRYPTED_IMAGES=3Dy >> configs/debian_defconfig
>    endif
>   +ifeq (,$(filter pkg.swupdate.nocreatefs,$(DEB_BUILD_PROFILES)))
> -+	echo CONFIG_DISKPART=3Dy       >> configs/debian_defconfig
> -+	echo CONFIG_DISKFORMAT=3Dy     >> configs/debian_defconfig
> -+	echo CONFIG_FAT_FILESYSTEM=3Dy >> configs/debian_defconfig
> -+	echo CONFIG_EXT_FILESYSTEM=3Dy >> configs/debian_defconfig
> ++	echo CONFIG_DISKPART=3Dy            >> configs/debian_defconfig
> ++	echo CONFIG_DISKPART_FORMAT=3Dy     >> configs/debian_defconfig
> ++	echo CONFIG_DISKFORMAT=3Dy          >> configs/debian_defconfig
> ++	echo CONFIG_DISKFORMAT_HANDLER=3Dy  >> configs/debian_defconfig
> ++	echo CONFIG_FAT_FILESYSTEM=3Dy      >> configs/debian_defconfig
> ++	echo CONFIG_EXT_FILESYSTEM=3Dy      >> configs/debian_defconfig
>   +endif
>   +
>    ifneq (,$(filter pkg.swupdate.p11,$(DEB_BUILD_PROFILES)))
>    	echo CONFIG_PKCS11=3Dy >> configs/debian_defconfig
>    endif
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0006-debian-rules-Add-option-to-=
disable-webserver.patch b/recipes-core/swupdate/files/0004-debian-rules-Add=
-option-to-disable-webserver.patch
> similarity index 85%
> rename from recipes-core/swupdate/files/0006-debian-rules-Add-option-to-d=
isable-webserver.patch
> rename to recipes-core/swupdate/files/0004-debian-rules-Add-option-to-dis=
able-webserver.patch
> index 23a456d..66e48e6 100644
> --- a/recipes-core/swupdate/files/0006-debian-rules-Add-option-to-disable=
-webserver.patch
> +++ b/recipes-core/swupdate/files/0004-debian-rules-Add-option-to-disable=
-webserver.patch
> @@ -1,7 +1,7 @@
> -From 9caabe416aca7ca2bf1cd2d8be89cfc89cedf6cd Mon Sep 17 00:00:00 2001
> +From c1f46ecb2ac3aed3a711dec767321afa92b600d8 Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Mon, 4 Oct 2021 17:27:11 +0200
> -Subject: [PATCH 6/9] debian/rules: Add option to disable webserver
> +Subject: [PATCH 4/7] debian/rules: Add option to disable webserver
>  =20
>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   ---
> @@ -10,7 +10,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>    2 files changed, 4 insertions(+), 2 deletions(-)
>  =20
>   diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index d011deb..337fcce 100644
> +index d011deb1..337fcce0 100644
>   --- a/debian/configs/defconfig
>   +++ b/debian/configs/defconfig
>   @@ -6,8 +6,6 @@ CONFIG_SIGALG_CMS=3Dy
> @@ -23,7 +23,7 @@ index d011deb..337fcce 100644
>    CONFIG_UNIQUEUUID=3Dy
>    CONFIG_RAW=3Dy
>   diff --git a/debian/rules b/debian/rules
> -index 9349c22..4574b18 100755
> +index 983e122f..6078ed89 100755
>   --- a/debian/rules
>   +++ b/debian/rules
>   @@ -39,6 +39,10 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DE=
B_BUILD_PROFILES)))
> @@ -38,5 +38,5 @@ index 9349c22..4574b18 100755
>    	echo CONFIG_SIGNED_IMAGES=3Dy >> configs/debian_defconfig
>    endif
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPA=
TIBILTY-optional.patch b/recipes-core/swupdate/files/0005-debian-Make-CONFI=
G_HW_COMPATIBILTY-optional.patch
> similarity index 85%
> rename from recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPAT=
IBILTY-optional.patch
> rename to recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIB=
ILTY-optional.patch
> index c2d37a9..4cca3bf 100644
> --- a/recipes-core/swupdate/files/0007-debian-Make-CONFIG_HW_COMPATIBILTY=
-optional.patch
> +++ b/recipes-core/swupdate/files/0005-debian-Make-CONFIG_HW_COMPATIBILTY=
-optional.patch
> @@ -1,7 +1,7 @@
> -From 538e54a36b24eb6caf49d7dca91598fa9fc86713 Mon Sep 17 00:00:00 2001
> +From ccc6f5d04aba0f1270f7d6b6de298b2084ad3bfd Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Tue, 5 Oct 2021 10:56:25 +0200
> -Subject: [PATCH 7/9] debian: Make CONFIG_HW_COMPATIBILTY optional
> +Subject: [PATCH 5/7] debian: Make CONFIG_HW_COMPATIBILTY optional
>  =20
>   Add option for qemu.
>  =20
> @@ -12,7 +12,7 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>    2 files changed, 3 insertions(+), 1 deletion(-)
>  =20
>   diff --git a/debian/configs/defconfig b/debian/configs/defconfig
> -index 337fcce..6fc1137 100644
> +index 337fcce0..6fc1137f 100644
>   --- a/debian/configs/defconfig
>   +++ b/debian/configs/defconfig
>   @@ -1,5 +1,4 @@
> @@ -22,7 +22,7 @@ index 337fcce..6fc1137 100644
>    CONFIG_DOWNLOAD_SSL=3Dy
>    CONFIG_SIGALG_CMS=3Dy
>   diff --git a/debian/rules b/debian/rules
> -index 4574b18..9a4b0d4 100755
> +index 6078ed89..19870e98 100755
>   --- a/debian/rules
>   +++ b/debian/rules
>   @@ -39,6 +39,9 @@ else ifneq (,$(filter pkg.swupdate.efibootguard,$(DEB=
_BUILD_PROFILES)))
> @@ -36,5 +36,5 @@ index 4574b18..9a4b0d4 100755
>    	echo CONFIG_WEBSERVER=3Dy   >> configs/debian_defconfig
>    	echo CONFIG_MONGOOSESSL=3Dy >> configs/debian_defconfig
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-L=
ua-handler-option.patch b/recipes-core/swupdate/files/0006-debian-rules-Add=
-Embedded-Lua-handler-option.patch
> similarity index 83%
> rename from recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lu=
a-handler-option.patch
> rename to recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-=
handler-option.patch
> index 44a83c4..447f6ad 100644
> --- a/recipes-core/swupdate/files/0008-debian-rules-Add-Embedded-Lua-hand=
ler-option.patch
> +++ b/recipes-core/swupdate/files/0006-debian-rules-Add-Embedded-Lua-hand=
ler-option.patch
> @@ -1,7 +1,7 @@
> -From c2f07b552c6d83562fed5452bc778ae0e5e19cd4 Mon Sep 17 00:00:00 2001
> +From 7107052e6aa1a35a2900070797ac013d49814f0b Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Wed, 29 Sep 2021 11:32:41 +0200
> -Subject: [PATCH 8/9] debian/rules: Add Embedded Lua handler option
> +Subject: [PATCH 6/7] debian/rules: Add Embedded Lua handler option
>  =20
>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   ---
> @@ -9,10 +9,10 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sieme=
ns.com>
>    1 file changed, 5 insertions(+)
>  =20
>   diff --git a/debian/rules b/debian/rules
> -index 9a4b0d4..a1f73fd 100755
> +index 19870e98..12eb0ba5 100755
>   --- a/debian/rules
>   +++ b/debian/rules
> -@@ -66,7 +66,12 @@ ifneq (,$(LUA_VERSION))
> +@@ -68,7 +68,12 @@ ifneq (,$(LUA_VERSION))
>    	echo CONFIG_LUAPKG=3D\"lua$(LUA_VERSION)\" >> configs/debian_defconfi=
g
>    	echo CONFIG_LUASCRIPTHANDLER=3Dy           >> configs/debian_defconfi=
g
>    	echo CONFIG_HANDLER_IN_LUA=3Dy             >> configs/debian_defconfi=
g
> @@ -26,5 +26,5 @@ index 9a4b0d4..a1f73fd 100755
>    	echo CONFIG_EXTRA_LDFLAGS=3D\"$(LDFLAGS)\"           >> configs/debia=
n_defconfig
>    	echo CONFIG_EXTRA_LDLIBS=3D\"$(LDLIBS)\"             >> configs/debia=
n_defconfig
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/files/0009-debian-prepare-build-for-is=
ar-debian-buster.patch b/recipes-core/swupdate/files/0007-debian-prepare-bu=
ild-for-isar-debian-buster.patch
> similarity index 84%
> rename from recipes-core/swupdate/files/0009-debian-prepare-build-for-isa=
r-debian-buster.patch
> rename to recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-=
debian-buster.patch
> index 8462951..3ff4ca9 100644
> --- a/recipes-core/swupdate/files/0009-debian-prepare-build-for-isar-debi=
an-buster.patch
> +++ b/recipes-core/swupdate/files/0007-debian-prepare-build-for-isar-debi=
an-buster.patch
> @@ -1,7 +1,7 @@
> -From 16dd48c2282aba91f8fc1f458f7b0c06504cac19 Mon Sep 17 00:00:00 2001
> +From 123190b2aa72818186ba12a04d793ff7d4244828 Mon Sep 17 00:00:00 2001
>   From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   Date: Wed, 29 Sep 2021 16:17:03 +0200
> -Subject: [PATCH 9/9] debian: prepare build for isar debian buster
> +Subject: [PATCH 7/7] debian: prepare build for isar debian buster
>  =20
>   Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
>   ---
> @@ -13,23 +13,23 @@ Signed-off-by: Quirin Gylstorff <quirin.gylstorff@sie=
mens.com>
>  =20
>   diff --git a/debian/compat b/debian/compat
>   new file mode 100644
> -index 0000000..f599e28
> +index 00000000..f599e28b
>   --- /dev/null
>   +++ b/debian/compat
>   @@ -0,0 +1 @@
>   +10
>   diff --git a/debian/control b/debian/control
> -index 6031537..710cb2d 100644
> +index 192c4a2a..9318fa12 100644
>   --- a/debian/control
>   +++ b/debian/control
>   @@ -4,7 +4,7 @@ Priority: optional
> - Maintainer: Stefano Babic <sbabic@denx.de>
> + Maintainer: Bastian Germann <bage@debian.org>
>    Uploaders: SZ Lin (=E6=9E=97=E4=B8=8A=E6=99=BA) <szlin@debian.org>,
>               Nobuhiro Iwamatsu <iwamatsu@debian.org>
>   -Build-Depends: debhelper-compat (=3D 13),
>   +Build-Depends: debhelper,
>                   dh-lua:native <!nolua>,
> -                liblua5.2-dev <!nolua>,
> +                liblua5.3-dev <!nolua>,
>                   libfdisk-dev,
>   @@ -23,10 +23,10 @@ Build-Depends: debhelper-compat (=3D 13),
>                   libzstd-dev,
> @@ -44,10 +44,10 @@ index 6031537..710cb2d 100644
>   +               libwebsockets-dev,
>   +               liburiparser-dev,
>                   libubootenv-dev <pkg.swupdate.uboot>,
> -                efibootguard-dev <pkg.swupdate.efibootguard>,
> +                libebgenv-dev <pkg.swupdate.efibootguard> | efibootguard=
-dev <pkg.swupdate.efibootguard>,
>                   libcmocka-dev,
>   diff --git a/debian/rules b/debian/rules
> -index a1f73fd..a2ae1ac 100755
> +index 12eb0ba5..e1c4a921 100755
>   --- a/debian/rules
>   +++ b/debian/rules
>   @@ -19,13 +19,15 @@ endif
> @@ -68,5 +68,5 @@ index a1f73fd..a2ae1ac 100755
>    	echo "# CONFIG_MTD is not set"     >> configs/debian_defconfig
>    endif
>   --
> -2.30.2
> +2.34.1
>  =20
> diff --git a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb b/rec=
ipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> similarity index 68%
> rename from recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> rename to recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> index e25ee4c..48a6cc1 100644
> --- a/recipes-core/swupdate/swupdate_2021.04-1+debian-gbp.bb
> +++ b/recipes-core/swupdate/swupdate_2021.11-1+debian-gbp.bb
> @@ -13,20 +13,15 @@ inherit dpkg-gbp
>   include swupdate.inc
>  =20
>   SRC_URI =3D "git://salsa.debian.org/debian/swupdate.git;protocol=3Dhttp=
s;branch=3Ddebian/master"
> -SRCREV =3D"debian/2021.04-1"
> +SRCREV =3D"debian/2021.11-1"
>  =20
>   # add options to DEB_BUILD_PROFILES
> -SRC_URI +=3D "file://0001-debian-Add-option-to-build-with-efibootguard.p=
atch \
> +SRC_URI +=3D "file://0001-debian-config-Make-image-encryption-optional.p=
atch \
>               file://0002-debian-rules-Add-CONFIG_MTD.patch \
> -            file://0003-debian-config-Make-signing-optional.patch \
> -            file://0004-debian-config-Make-image-encryption-optional.pat=
ch \
> -            file://0005-debian-rules-Add-option-to-disable-fs-creation.p=
atch \
> -            file://0006-debian-rules-Add-option-to-disable-webserver.pat=
ch \
> -            file://0007-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patc=
h \
> -            file://0008-debian-rules-Add-Embedded-Lua-handler-option.pat=
ch"
> -
> -# Patch for dm-verity based images - can be removed with next SWUpdate r=
elease
> -SRC_URI +=3D "file://0001-debian-patches-add-patches-for-dm-verity.patch=
"
> +            file://0003-debian-rules-Add-option-to-disable-fs-creation.p=
atch \
> +            file://0004-debian-rules-Add-option-to-disable-webserver.pat=
ch \
> +            file://0005-debian-Make-CONFIG_HW_COMPATIBILTY-optional.patc=
h \
> +            file://0006-debian-rules-Add-Embedded-Lua-handler-option.pat=
ch"
>  =20
>   # end patching for dm-verity based images
>  =20
> @@ -42,7 +37,7 @@ SWUPDATE_BUILD_PROFILES +=3D "cross nocheck"
>   # SWUPDATE_BUILD_PROFILES +=3D "pkg.swupdate.embeddedlua"
>  =20
>   # modify for debian buster build
> -SRC_URI_append_buster =3D " file://0009-debian-prepare-build-for-isar-de=
bian-buster.patch"
> +SRC_URI_append_buster =3D " file://0007-debian-prepare-build-for-isar-de=
bian-buster.patch"
>  =20
>   # disable documentation due to missing packages
>   SWUPDATE_BUILD_PROFILES_append =3D " nodoc "

Thanks, applied.

Jan

--=20
Siemens AG, Technology
Competence Center Embedded Linux

