Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DBCC4332F
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:30:15 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.51])
 by mx.groups.io with SMTP id smtpd.web11.23234.1669217410236547308
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:30:10 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JjkNg0oQ;
 spf=pass (domain: siemens.com, ip: 40.107.247.51, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mJ/JDtKv1FfbEDUxwfEo9O6yfxbe841vns94WVorlM4UTIPPS+LjFSTYkrp5KrLyiuyNrlICd7AvDBMPEve8rC/u3xEhw4+VFTB+UX59FBvrjj090MXA4vwQlHoW5ppr9YGcCAbH9L9Pq3ycobLvWZXoRYdLN4BrIdxl3eF+PDnXFEdZbLhelA1tDRtF6LzZ//byaFSNDhvb1wXQiqGcG2MNIk2+wQN1WJYUHCzZU772qar9yY3SyQ2l/H9CzqJ+8n1fY3E5Yg1cFs1r2rOQZ0c5E92skBl2qvEgYyIDOKxHRbXw6DLWzqcLXiDizdfxv/xaB35Ybo+JRXeV3ZVV8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVV0ib9XRhyO+bm66mtM2NOd7l1HRjVAWcICguQiQks=;
 b=iaiUmc0JNn7m86/APbac6p+gx5RUmeZ8tU9rQyyZu/wyOI7+D38g3bHB12fFlWcgKexHVSFFXYrplSkSGfxG45JH17H+lhrkeQIwD8dMW1RbEIFDo1grmgfaDOtluea7WGhm6nsPUJlu14YXcxbV52Wdd2aRSSB89PGo03bLdz21MjtYg3N7wg+4vcDpF5z89fwYfvKvdWjbTpvc6lFx9M0z0esiz7XJgej8ztml9PNJqa6y5i4e6tsU8JhYrPJrzXXk6PWZUg5tJGhiqNBQFW9KP7MX7eNi52uEXZgTWxxXjX0lhZYQEO6Qq/KJIPz2ssI4Wkv/VGjA+Zvlc34+XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVV0ib9XRhyO+bm66mtM2NOd7l1HRjVAWcICguQiQks=;
 b=JjkNg0oQhqFsRRdLl6GodbRCLLC82i940/MAD2hLJySOFGRZcaCmm6WcH4VOFKTPTqhWC8xT4AlDX3uoSPvhKOfneVh9HPTYwgj/9GM/ry5bQbqpTbsliYGvwuX8nQywY6oWU9pH96Tm5o5Sw3pebyG5jv3FGGrQu1X9DcrFP3BZaAmf+y2Kl0e6VT3KJwLeyhHz+1DsadLP0twvj4OjZUK7UPCiz/ojetHljIbTlDER0wLZH/SD2xmRUxR+I7d6ftt8ckfjINOQhcyq538rWuH60V/dqdqFAs1O7ie/6iFpd0FPyt9p3E8INjVmvlGUD7zWVEuksxLQFTaYTscOjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:30:08 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:30:08 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 5/7] add recipe for trusted firmware a qemu arm64
Date: Wed, 23 Nov 2022 16:29:04 +0100
Message-ID: <20221123152906.75323-6-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FRYP281CA0016.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::26)
 To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: bd711f92-5dd7-456b-02a6-08dacd679a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Nv2vQu7asSJkcRhejCsEJD70ENCHnRmQgHyFYDomHKa3g8aBknCU7YEYN5t+sTR2gPsqWkFRjzN8ybH6vlWb3fHaw/f4ySn2F5tNU+ZZgpdBchF3toK3mtBhZokhua3rLIXT/QOf52obqv943kaIxZcUHtucn8sSjt44Ep8ejDeXLM+79JbH4q+aUyWt1+EfEIPk1aDN7yCM7mSd9FY0TyTjbL4L/tgYGr8qSCkFiXueI8Rc6MxfpnZ/5ApdYT5eVmgt6hNwDlAEwq7NmW2Iw4efU3HGdJXmeF3v6MjBpA8QiI+fLVvv16Y/eqRNZ54XTlBdvXCVBRPH0Rh2smXZaOya3ULWB/S9u7yl0UcqUaDeeHaP1YVQ6ZFuFzpBgzWVFKv7vt5HNUO9ZglhWvstv4CQTIntdEuUX+A9cFvHf+XvIqJdk9nCv8wIJXhxCMULbQ2zBjleZSg2KTiT1FkYtySLXBlVShKa+yk155F56DvpZzSfTwRNYGXwQbejeAv0lFIBHBG9+7hOue6/j8iQT7ZcjowKN6R4zSzd+b7DsU+UBkXCoBO4yrjDZsCTsBReZpn68q+tKBzwxHBAHKOz8XI3TKO1GmELbj+Cq1pHyrIPc6rM3d8bzpMQtBLmnezcY57NDZhY7+4FUXujMXUz22rumpQ7T370Lyp5eUfTvGs=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(6666004)(41300700001)(107886003)(478600001)(6486002)(966005)(9686003)(4326008)(66476007)(316002)(8676002)(1076003)(8936002)(26005)(66556008)(66946007)(186003)(5660300002)(36756003)(6506007)(82960400001)(6916009)(55236004)(2616005)(86362001)(2906002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J1OgrXRYjPbhIuUuRyy6gjbahoyHapAoGfyWd1oBLiE2+Bdk/yU2cmkf7eLU?=
 =?us-ascii?Q?dMONDRLSCTUKXUm/26rCXeMVMIbiGipWiW6sv8Puc2SNzrV3LZfYB/Yo33fC?=
 =?us-ascii?Q?NUKibiGLDz5RuO0k9wW+ziSzdEpGB9Pk4FrNoWRs1HvVOcowx0Ou4O8Lxf1T?=
 =?us-ascii?Q?6hl5VP11evDuKyX+tucJbV3yxPAhYqoOkZs48sM9ljJ3hM50nBq2Wro+Nq5K?=
 =?us-ascii?Q?Av+HhNZv00/tL9q5C9WcKUfL5CPigzI+fZxM4dCvQZclIF0wUhRN9ootX3bm?=
 =?us-ascii?Q?po5yYEbaw+Ka8MrWZlfWB3aWiOtHbWDrGqPJjArYPiELJz7BwFLFaocd1fgC?=
 =?us-ascii?Q?wODMyxkQchsPJ8b73QcAFmhhizgj/IItrtHs0mMgGGGnZfxY4c2pG6MA1CKW?=
 =?us-ascii?Q?fBpTmRtZ6ssHHiw64/94H4JRUIv3DZay7xATqtxXqoDaOwTc5aIVRdW+OJtH?=
 =?us-ascii?Q?CbP1UcN0ud22y93LbXNdmyNGO/fGq3QtpHou+tZuBtrgGTYc5s8sP97U9EGA?=
 =?us-ascii?Q?XIZPVqIyVU37ffUfxSm5ENtTHmy+fKMaIQntXhT+vsknEN1XFiia/LANHfmm?=
 =?us-ascii?Q?4+f9UGKMUK6t08qS9/rLL5qKwi2AOp4hmBsSMRfUzHJnY1u1NT6vf19HEA1V?=
 =?us-ascii?Q?cx8RRZpoehjnmdwqx3uPqdzfSwjSbO1hWnEndrAQml3NeTKOmpc2tBvlXLIr?=
 =?us-ascii?Q?2+AZYSGPDShFxEC0FDVjMt0+UiYVK/9HBDy+jfn7FOvf7EeU0SMp3Ue4ieS3?=
 =?us-ascii?Q?/KTrXbN42nCr426n1DUIvuXGI1Iu5uUnr76ZZwleJFo23yP1O/BjbVNvr28M?=
 =?us-ascii?Q?ESI3evvm5yWXp7JorgYWFVpWsityOf4wkm8/Zg2uUPNcEQYoT25bRhtTWruU?=
 =?us-ascii?Q?Oap9InothY4yok2o1H4VpjbQj8+1E02gsMnLI3A1CiDB8oitzVyzcS985R0F?=
 =?us-ascii?Q?MoKLumJVqtDqrjxcb3KjIJ801NE+JXAR9eCLVetSPgwKcKLTkXzb9KsYQvdc?=
 =?us-ascii?Q?+fg8vXEKZVccUbZqcAQYfNAt862dTfbRXgf1REjnf6RkQiyyo24VcSIFxqKw?=
 =?us-ascii?Q?XvjFTE/V0Y4J175pQwdmTk/nkvX6f7Gnwr7hP/WdPccu6d18bNHtFpRKujzb?=
 =?us-ascii?Q?3gzOVaE/fMJ+PNL0vew7YhkyJcAskA+/m2en7JTPi3JxPVoHC0z9Gt/UE+xU?=
 =?us-ascii?Q?XnoiD405fprIyZXsfARjQl7FGEZosJJB5HxObn3OAiomj0aYyTCSPrtOa7xu?=
 =?us-ascii?Q?5a4klkEVeSRlD5GOOjHk6nAdYZmIHSPVW0AvOsVeep95DGJZC+UjxYs9coLb?=
 =?us-ascii?Q?jZFsIFwgnbmxceTMyFtY5xusyOdtEhHiLiQakb4i72u+C95hqbw0TmE5RiJ3?=
 =?us-ascii?Q?LuwpOONdmh7eyMl+hqVceOWOaGtf342aVBAG2pTqMomZLSf266W4v82KuWRg?=
 =?us-ascii?Q?rp0oHIfVpd3f7grPRYTcQCRa784zXc7Z/yhrQK2t5wQS9+t6CnTIXA83o/T+?=
 =?us-ascii?Q?3zkXAscSyeWeJa2ZDwLqhpEIbTZvHVuNq2SyukLsA+oKccqKBPnQiSJgeTOf?=
 =?us-ascii?Q?HTzfM22ZjBRnuPdl6yjS44uKGr/mZE8qGXtHZr2tFq7e4gEr5TYr3/6XvEcG?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd711f92-5dd7-456b-02a6-08dacd679a40
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:30:08.0339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 35wRBCMsUT5/qUsuu5NgWbrpbktx7G/ph19y1LrvkLp+jC0hzRWPARcw4ZFc4FX9uu2CnNgisn2SPx7Nzy6XHLLqk3DfMdg5DPMhYCM9s3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:30:15 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10095

From: Sven Schultschik <sven.schultschik@siemens.com>

provide a recipe to generate the needed binary to start a secure boot qemu =
with integrated optee and active RPMB replay protected memory emulation wit=
hin u-boot

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 kas/opt/ebg-secure-boot-snakeoil.yml          |  1 +
 .../trusted-firmware-a/files/rules.tmpl       | 22 +++++++
 .../trusted-firmware-a-qemu-arm64_2.7.0.bb    | 62 +++++++++++++++++++
 3 files changed, 85 insertions(+)
 create mode 100755 recipes-bsp/trusted-firmware-a/files/rules.tmpl
 create mode 100644 recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-=
arm64_2.7.0.bb

diff --git a/kas/opt/ebg-secure-boot-snakeoil.yml b/kas/opt/ebg-secure-boot=
-snakeoil.yml
index e92ea5e..6732095 100644
--- a/kas/opt/ebg-secure-boot-snakeoil.yml
+++ b/kas/opt/ebg-secure-boot-snakeoil.yml
@@ -26,6 +26,7 @@ local_conf_header:
=20
   secure-boot: |
     IMAGER_BUILD_DEPS +=3D "ebg-secure-boot-signer"
+    IMAGER_BUILD_DEPS_append_qemu-arm64 =3D " trusted-firmware-a-qemu-arm6=
4"
     IMAGER_INSTALL +=3D "ebg-secure-boot-signer"
     # Use snakeoil keys
     PREFERRED_PROVIDER_secure-boot-secrets =3D "secure-boot-snakeoil"
diff --git a/recipes-bsp/trusted-firmware-a/files/rules.tmpl b/recipes-bsp/=
trusted-firmware-a/files/rules.tmpl
new file mode 100755
index 0000000..45eb00b
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/files/rules.tmpl
@@ -0,0 +1,22 @@
+#!/usr/bin/make -f
+
+# Debian rules for custom Trusted Firmware A build
+#
+# This software is a part of ISAR.
+# Copyright (c) Siemens AG, 2020
+#
+# SPDX-License-Identifier: MIT
+
+ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
+export CROSS_COMPILE=3D$(DEB_HOST_GNU_TYPE)-
+endif
+
+override_dh_auto_build:
+	CFLAGS=3D LDFLAGS=3D $(MAKE) $(PARALLEL_MAKE) PLAT=3D${TF_A_PLATFORM} \
+		${TF_A_EXTRA_BUILDARGS}
+
+	dd if=3D"build/${TF_A_PLATFORM}/release/bl1.bin" of=3D"build/${TF_A_PLATF=
ORM}/release/flash.bin" bs=3D4096 conv=3Dnotrunc
+	dd if=3D"build/${TF_A_PLATFORM}/release/fip.bin" of=3D"build/${TF_A_PLATF=
ORM}/release/flash.bin" seek=3D64 bs=3D4096 conv=3Dnotrunc
+
+%:
+	dh $@
diff --git a/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2=
.7.0.bb b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.=
0.bb
new file mode 100644
index 0000000..fcb2729
--- /dev/null
+++ b/recipes-bsp/trusted-firmware-a/trusted-firmware-a-qemu-arm64_2.7.0.bb
@@ -0,0 +1,62 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2022
+#
+# Authors:
+#  Sven Schultschik <sven.schultschik@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+
+HOMEPAGE =3D "https://www.trustedfirmware.org/projects/tf-a/"
+MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
+LICENSE =3D "BSD-3-Clause"
+
+require recipes-bsp/trusted-firmware-a/trusted-firmware-a-custom.inc
+
+SRC_URI +=3D " \
+            https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/sn=
apshot/trusted-firmware-a-${PV}.tar.gz \
+            file://rules.tmpl"
+
+SRC_URI[sha256sum] =3D "553eeca87d4296cdf37361079d1a6446d4b36da16bc25feadd=
7e465537e7bd4d"
+
+S =3D "${WORKDIR}/trusted-firmware-a-${PV}"
+
+DEPENDS =3D "optee-os-${MACHINE} u-boot-qemu-arm64"
+DEBIAN_BUILD_DEPENDS   +=3D " \
+    debhelper(>=3D 11~), \
+    optee-os-${MACHINE}, \
+    u-boot-qemu-arm64, \
+    libssl-dev:native, "
+
+TEMPLATE_FILES +=3D "rules.tmpl"
+
+TEEHEADER =3D "/usr/lib/optee-os/${MACHINE}/tee-header_v2.bin"
+TEEPAGER =3D "/usr/lib/optee-os/${MACHINE}/tee-pager_v2.bin"
+TEEPAGEABLE =3D "/usr/lib/optee-os/${MACHINE}/tee-pageable_v2.bin"
+BL33 =3D "/usr/lib/u-boot/${MACHINE}/u-boot.bin"
+
+TF_A_EXTRA_BUILDARGS =3D "BL32=3D${TEEHEADER} \
+        BL32_EXTRA1=3D${TEEPAGER} \
+        BL32_EXTRA2=3D${TEEPAGEABLE} \
+        BL33=3D${BL33} \
+        BL32_RAM_LOCATION=3Dtdram SPD=3Dopteed ${DEBUG} all fip"
+
+TF_A_PLATFORM =3D "qemu"
+
+TF_A_BINARIES =3D "release/flash.bin"
+
+do_prepare_build_append() {
+    rm -f ${S}/rules
+    cp ${WORKDIR}/rules ${S}/debian/
+}
+
+do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    dpkg --fsys-tarfile "${WORKDIR}/trusted-firmware-a-${MACHINE}_${PV}_${=
DISTRO_ARCH}.deb" | \
+        tar xOf - "./usr/lib/trusted-firmware-a/${MACHINE}/flash.bin" \
+        > "${DEPLOY_DIR_IMAGE}/flash.bin"
+}
+
+addtask deploy after do_dpkg_build before do_deploy_deb
\ No newline at end of file
--=20
2.30.2


