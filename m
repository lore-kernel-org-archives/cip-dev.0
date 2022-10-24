Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4198ECAAA1
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:28:07 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.49])
 by mx.groups.io with SMTP id smtpd.web09.18488.1666614481000126223
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:28:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cgfysVzY;
 spf=pass (domain: siemens.com, ip: 40.107.21.49, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mi0ApGhosMDHGHe5Q0QNqBNof8EHVKVYTp6w7HkDzjv39WtQGsTV5qVDPyUQ2A3ExQ2Fwja0FnYwzvdiBRKK0xFH+C0fvh2+Jve3x50Gyly+43g3pLKbKoWXoMqPSAmMGGrG+j/aZduasCXG/Fb1eKIiaorcMS7zLFjTXsrZdHkHe3cCEOExvzi688bBIMGy81jZT3SLyfwg5MK1Z/9WREskiULWim+vaNtI20tGpvJri3TOJOiEOm3Z4DSXb+lA9vD49xh5EsyOVRHFL9SOzKyZ+IZsGV+b3fcz1ipf1MPk8pm0UI7HOO5bIXPKoDc++DWUzqNJxKbV7ExT9Mlo5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZICFyjodtBKQoKKIWAR+MadjYQzWKsXhFmBTM6yi78=;
 b=g2EciwV+5EXAdAxJhRoc7sFw0USud0QRbCaJMuDZiJuRDlOgvSSIPMZlGjM88am/pHnZG7OmC8Dt9a/LBLAp/amtnWCcAjRw/JRgy/2NoM9JGAiGgYwvwnZJsYexaNaEsxIZSiL6+ecl8JJOaf8jz0EvABM92FPUtVKgR1BmdhKiH8KgP7MUANMrWYkDERBwI7D9aXyYwO5FBJiqLSd5zsqcEsZ+6qdxXLXAmypJGvfOTlgjFT1NyEYk+KKFKLm89Xkv7+Q67nBljldLLUe3kk4L4H5QYqJeIgZXdFqrDl0usPbINOb0cbt288ebBOziAgeRP7J9aEkPLscgL2j0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZICFyjodtBKQoKKIWAR+MadjYQzWKsXhFmBTM6yi78=;
 b=cgfysVzY6WuCEfGVb4MEmxvYSkbflGDvWkraEoVYdGrlTVFn3lTgdwueP08Rctkayiwz4OlMol2utycDKyDG7lkYDT5VCeZ7ypC4Y7Hgd5k6YOc+fg6dcf+pcyBv4/5aOfWLJVM1C7CWLyJbEuPtg87DHf7qz/C7C26KT3uC+bdXdLjWawNdGo2uDsrz8xqRsLwYLpPlIXncfTEPHQ0GtiKFBZeSKlQa/lr1gohiNITxCBnr1AQNGli1KML+s4Fz4Xm8HGaKhsHTXFcTwDmOurfhFyypdt+kmaslNjMfzmr2GUHyRIvgIn2gXrYVFE7MxdTYCnECtdgEspWS93Pi7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by VI1PR10MB3565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 12:27:57 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:27:57 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 2/8] add recipe for optee qemu arm64
Date: Mon, 24 Oct 2022 14:27:19 +0200
Message-ID: <20221024122725.383791-3-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR04CA0106.eurprd04.prod.outlook.com
 (2603:10a6:20b:50e::15) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|VI1PR10MB3565:EE_
X-MS-Office365-Filtering-Correlation-Id: a97c09db-e43f-465c-8af4-08dab5bb2ecb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	HtpdDy9hJB+4ZsEnjCMyqz2gt4vhkQCVhdcqzU7qBOh51Dc9kQz37U6K/rgoUDO3SerfQUT7xatgDVulAXYW9emDw4FXSYmLnDJr+iIRC7w2s93Geyys55D9zG6wnDz+Vt2YNmT+vs0oW5ugtxQAf/tneVMkvqmn2BYV6jCFZMUUB5bnfL1DFKg0gw9MyWnxAVqnoMQ6KOZUYCj6onwRq5kxQ2jLoADwFDcnj2odAzxiSjuJrZAcvdfqoafa/qVLBBpUkPy4QhT4tjvE2SK9iBgx5TM/sowsh8nLLwzUp3TkQ/sl/gXDDO6edWWTypp6gJHJZA1V7YD5BijII9gS41tx66JVP3FOow8koaS1CDk/NmcxhIkA8rUl1ELwzu8GXswCr5REH0JEi6GuqEsDPP3htiPL+Oq9zm8LFAd7qR4FXE6dcVzmQwtTDNDeWsAeKl8yIFSEdUPz3dWQi2E51bHxchEqoxZHV1LonODBQKhHmugeE6MUJyZDyIGzAQdiFzyeXFQTf75+2zqqZeQiUlstuIIhpz37DAwynBTHK/IQrp0i3rtstwi56b6WwwMjZOYpJC7sSZytxYczXyYFTjtkTPScm0WJOGCcDtIiWsGhR4oCIqvt2pyYbRAGJsoG32kyQl42bvcxFwVmZY/iv3foJlCLWdluQ2mJbojSziWS8gW2GNKe8hFUP853hlrAJuKXy8wiAPuy2S8cRy0dl48R4vdDVc5rAvk8KMIQtRE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(9686003)(6916009)(36756003)(4326008)(2906002)(5660300002)(8676002)(66556008)(66946007)(41300700001)(66476007)(86362001)(6512007)(316002)(8936002)(26005)(6506007)(186003)(2616005)(82960400001)(1076003)(38100700002)(107886003)(6486002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?041T7W2fyxySvOrjgdeO3mMbRcXudDcqsdnJrACkUTG6aQ5+M+t4MBNCdMZm?=
 =?us-ascii?Q?05nNx8AFv2n3887n50eGVJb9Cc0yManRuT5CilTBeCghnm3bjUyY25gVVahT?=
 =?us-ascii?Q?TeYuvVnvre60cjB2jIdWfwBj73gma6RR7djdHO1OozciT/EoFcdPa8PBUuUp?=
 =?us-ascii?Q?CYYxhQJ/B/oNY89e1E9tKRl03ELFTOfFqYErf8x1ZE03SxlQxeCxcEcsnvta?=
 =?us-ascii?Q?kzS8AAgVY9XRmeJg19XYFq5WcPRe0ipDF75zPX+TJMCJ2S1ix4Yjd6HM8SWT?=
 =?us-ascii?Q?pWRrh3NR7C/gWEldrgtBQ8xQwA/7RDiNCGZk6z8oijvpHPQNOmNSYBPxwbwB?=
 =?us-ascii?Q?WctpzkMPNkYVuu8edclMnWiVi6QlYDYXpV3n5HFipfDlT8Lip+x3qDqULaJ2?=
 =?us-ascii?Q?HD1Sj+/v+JZGomKyRVeP09/Y2xmSsR3qvKNNwbNffbpeTl2hDcVOnALYRdba?=
 =?us-ascii?Q?34WciI2E/iiLUE/4kxNxDmO1WbGxZ1p3R0qB0c/mKrmvUJmNs9vcvQH09Bdz?=
 =?us-ascii?Q?6xOsyDDh5B3JLmSflPziloDeXcVWPQom878L3d9CedEOg4vrsaMfrFS7ujfu?=
 =?us-ascii?Q?GQnuv1T/OYHMc2LWh3JC9PbH1pUbuDpNkHcD/7WSQzvy2mnwLgXJYTu1rJ6A?=
 =?us-ascii?Q?DDinJVoaGvZxAuWoNNkRI76qlox6tJxySicgQEb0QF+fbZCCQFd4n7lm1j/I?=
 =?us-ascii?Q?5GGc/X4FuAT4XyJH/JdJiuo8V3v/pfIdd7iSaBsw3zsjjdiGHVLoBVnxLl8a?=
 =?us-ascii?Q?HoWakQ93fouA2ph8u7zMGBqgMtbMn9smYddL2FeFwP3z7CZ5i7tlBx+LAV2i?=
 =?us-ascii?Q?my/MQRCkbaqlv4DTK79Hvb6JythTz/dewMqXah26AImEZfJ4PQE1bD6mpH4L?=
 =?us-ascii?Q?OfC8LDknNM98SqA6MPqXC/6m/JYwDAOE47TDqD5LVmel3xbEzbESvoBCfcOm?=
 =?us-ascii?Q?fX+8HmeYnr+sR5W5cC97S8keyNBK5d5tMiImDaIGsPs2NuSFQ6i7bARpw5U1?=
 =?us-ascii?Q?WM4Krd1+6VQIV6af0EtX4IhOVPU1uOnOvnhIiM+ZD8WlwrA76rnybD0Ev180?=
 =?us-ascii?Q?t7Hhyq5QaLkKJWrOhEPOzZsizbEovtaEKRImb4AptfLUkDVUUWVqEI2JOWTh?=
 =?us-ascii?Q?OoO4c371chBMWw4vGSDMGtadytSMr2WldasD8QjniRWb6mFNx+TB42DXZuYj?=
 =?us-ascii?Q?p9uGUwIveOfqRtIn7fjYkHNbaDnKKuPanqFUtQ5rP5S8mR9rlsNomxiYA/ak?=
 =?us-ascii?Q?9sHbglhbMy5sZSwKuzTKOpJB+8xSmca7XQ+s3vRIeM68Q951T+OY8gbz/3XB?=
 =?us-ascii?Q?WrhA5q32zj3dAIb5CnJetVq7ppM3kIZeMndWya0fQCGZwWSRcSa5Mkhkydbl?=
 =?us-ascii?Q?WNwHYIsnRgfYjsIXCQN3EIN46BWg5Uw655bsndduNlvVb2sBEMRm4SOPdAKb?=
 =?us-ascii?Q?6bO4zsIO+gtcsh3qBZsaQGQFGjqShdLXvnIvpTGY0m6IbnTinkvgfCqPiJ9p?=
 =?us-ascii?Q?wV0n7beVRUCSGTTexJgl/MpaaaaagbFQZpMr82CCk3iXWjQvhCeEZsebr9O0?=
 =?us-ascii?Q?VnMyCixh6w9f4hMpcrylYNrvzoeQI40/DoLAbRTNfuVYia0RNQ7pjnVT5lvN?=
 =?us-ascii?Q?qw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c09db-e43f-465c-8af4-08dab5bb2ecb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:27:57.5886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NwZf6IVa3cJQebpq7RLsuukLnZsKlwDyiCtp+O0Ip31jfIlMd0nJyl8HoHo2Q2kk0kYpV7mTLOqBevugqUd1DeesS4GrAVdcXYa6EILV5H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:28:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9806

From: Sven Schultschik <sven.schultschik@siemens.com>

The recipe provides the possibility to create optee-os binaries for use ins=
ide of an qemu secureboot setup with edk2, rpmb, u-boot and uefi

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 .../op-tee/optee-os-qemu-arm64_3.17.0.bb      | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb

diff --git a/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb b/recipes-bsp=
/op-tee/optee-os-qemu-arm64_3.17.0.bb
new file mode 100644
index 000000000..3d1325432
--- /dev/null
+++ b/recipes-bsp/op-tee/optee-os-qemu-arm64_3.17.0.bb
@@ -0,0 +1,54 @@
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
+HOMEPAGE =3D "https://github.com/OP-TEE/optee_os"
+MAINTAINER =3D "Sven Schultschik <sven.schultschik@siemens.com>"
+LICENSE =3D "BSD-2-Clause"
+
+require recipes-bsp/optee-os/optee-os-custom.inc
+
+SRC_URI +=3D " \
+    git://github.com/OP-TEE/optee_os.git;branch=3Dmaster;protocol=3Dhttps"
+SRCREV =3D "${PV}"
+
+S =3D "${WORKDIR}/git"
+
+OPTEE_PLATFORM =3D "vexpress-qemu_armv8a"
+
+OPTEE_BINARIES =3D "tee-header_v2.bin \
+    tee-pager_v2.bin \
+    tee-pageable_v2.bin"
+
+DEPENDS =3D "edk2"
+DEBIAN_BUILD_DEPENDS +=3D " ,\
+    debhelper(>=3D 11~), \
+    cpio, \
+    python3-cryptography:native, \
+    python3-serial:native, \
+    device-tree-compiler, \
+    edk2, \
+    gcc-arm-linux-gnueabihf,"
+
+OPTEE_EXTRA_BUILDARGS =3D "CFG_STMM_PATH=3D/usr/lib/edk2/BL32_AP_MM.fd CFG=
_RPMB_FS=3Dy \
+        CFG_RPMB_FS_DEV_ID=3D0 CFG_CORE_HEAP_SIZE=3D524288 CFG_RPMB_WRITE_=
KEY=3D1 \
+        CFG_CORE_DYN_SHM=3Dy CFG_RPMB_TESTKEY=3Dy \
+        CFG_REE_FS=3Dn\
+        CFG_TEE_CORE_LOG_LEVEL=3D1 CFG_TEE_TA_LOG_LEVEL=3D1 CFG_SCTLR_ALIG=
NMENT_CHECK=3Dn \
+        CFG_ARM64_core=3Dy CFG_CORE_ARM64_PA_BITS=3D48"
+
+do_prepare_build_append() {
+    # $(ARCH) is the CPU architecture to be built.=20
+    # Currently, the only supported value is arm for 32-bit or 64-bit Armv=
7-A or Armv8-A.=20
+    # Please note that contrary to the Linux kernel, $(ARCH) should not be=
 set to arm64 for 64-bit builds.=20
+    sed -i \
+        "s/\$(MAKE)/ARCH=3D\"arm\" CROSS_COMPILE32=3Darm-linux-gnueabihf- =
CROSS_COMPILE64=3Daarch64-linux-gnu- \$(MAKE)/g" \
+        ${S}/debian/rules
+}
--=20
2.30.2


