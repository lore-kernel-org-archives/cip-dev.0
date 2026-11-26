Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.25])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11290.1795689093383602819
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:31:33 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=fJQVONB/;
 spf=pass (domain: siemens.com, ip: 52.101.83.25, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRaBmku0AE7PfZy287AZvHx+jNIQo2GPJw3sxd+EQcMAEJ5hlOkZ5nENFXj2hmpJoOm8K4Jg6Sb2Sy+0943AveJwsQ6Jk7wymDBUVVjcuPV4NTQPULJQDsG1O6IBZnCnxqrSo+GJRWnU1bNPmi4p24iBXxLSu2CZq3RuP3a7OI2sewcFQIokVS9iMfZjhzro734GAmDd80oNr2oiRwRJ1ELPO/bcnxof8rYMZ4Krh8DG42ma/l3FqHrcB902mWgW0XQO4b3MxdJT3GulioB503NHqbTLhJl0AEhKz/RkK8dsQTHCfME9vZS5xxD59sHVwbVG2CxpAccDGyQ3C3XHZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQTazlofKjT/v8B61ji7L16VSquqPI+aECKL9IKjLK0=;
 b=tvkPQf4obHXOwH7LaWdzn4BhvUcAzwkOhCHASNq3g+2zDkoGjh/HTX2TYbq+oMYTS/xQYw6kJ8LMSUJsDoy85eFf5t+NtizdQTFgT0eRaV6H21b20BMgmvlK6BIUkAQ8J0TrOFI4kOtdV8o42cVRe9B+a9fFyfbUseX7EJ9xkOpt+K5P/01eoygiVDSUZV5mAuiBdv4QCkg46Dc7P+1buMm04TFlHl6/pSGez518Qvv+imUJTAxtUpWkP6Uah66fKBFWmb4an9wCQxMm67nj3Q7UrKRV9xImP2p7/LaEQgIDEGcY7MjpBzNCRwxXkqnrLyqsN3VLycNdAnKDR2FRDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQTazlofKjT/v8B61ji7L16VSquqPI+aECKL9IKjLK0=;
 b=fJQVONB/L7aunAxcMWEIypYCXbuHo86TGXWb2Ko9BkHNoUXxWllLHScMKcANX3T2SOrR0StEAsAS1N6E5XRB5dSVZUuwzoJExMGgTYARIz+G7MDRPuYmGU/CFvv3Y5D/RCjXc+qlLDuf4fw05YIif/CBapoKT2dps07kAzcSIcJ/2V5b0zYZkxo4yT08j5HLJrH+pHcIAZNyvTc6//NHyqpJhz1+M5kes0BUHXlfq8TwalCP3EQgo66nxv6f6f9tYDOKreCAwMwXXKIbtp3vAz5XSFK6Oq/Zi5WOQpSZ5/qL2+kDvV5dSnbst64ICb5p7OlmS2SWs1FTpMcUvsz+wQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU4PR10MB9591.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:61a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Thu, 26 Nov
 2026 10:31:28 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:31:28 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 16/21] ci: Add dracut build
Date: Thu, 26 Nov 2026 11:30:02 +0100
Message-ID: <20261126103007.2922985-17-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU4PR10MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: a9113683-7d6f-41c6-cc63-08df4ba86e20
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|6133799003|22082099003|18002099003|55112099003|11063799006|261022115727099003|261022075727099003|56012099006|261102123227099003|261021135927099003|261021121427099003|261026121527099003|261009220027099003|261009223327099003|261021123027099003|261009221227099003|261009223027099003|261009221727099003|10067099003;
X-Microsoft-Antispam-Message-Info: fFkAfNJ65/Z5Gscn3xXuC+ipRb7Nb4rjGanD+mwcnO2KaZDxWxwOOQ483NF33Y7KAR9F4YYuKEfAU5woRzhc3+sxO6yVnbVhIYG43tke7n6OWu6cmPZcVEUn1fEmCt4NLykF4P1wtUj8FezvkWky70vViIu6V2qYGWTEhkBvr93WPfJYDQbihUlmMf62WYY6Sx02mOn7MUOC0aSzXknZ4+R8RWMGio+o6eBCKj1Q4Y1se+xpU6fj4p2DTO76/B+SggmEXBM/k/Sc0v/b5U6tBP/wbW+/1EAil5Qh38wv/OIFbDYdGoZukEhmfgvHtGV2pvMbwkyXA4yw3Z0dIZWccfI6ZoXLYrr3oU0NRBWcujKH1oCR1P37Nf5cCVoL2D0tzzXbuFdAtGVpQ5NlgMyP/6fX1TkeCVYm08rz8Y0woQ423eCxbu5xR9MVRQYuOf05l4aZ2BpVI5EcVJMrF2seRPE8LQfqT+fH9elqzMYS5IGI+TL0tu3quouzPp9fS1Rhn+Qru/7YObXzsT1em8P5m9p83l8G3QGe9UqOkk/YpqoIZTaj1qAxTkhToTTfsMyBon/BBMdz4s2wNYntAJ+fXL4vo8Vo90fmaeAy8J+hFK8Xk8RVCNqLBa1BJTWc92YH00qvw3rycTlQJ2AzxMxn3immaYJ5s073rG6ivOqlZ30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(55112099003)(11063799006)(261022115727099003)(261022075727099003)(56012099006)(261102123227099003)(261021135927099003)(261021121427099003)(261026121527099003)(261009220027099003)(261009223327099003)(261021123027099003)(261009221227099003)(261009223027099003)(261009221727099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h/SfRMid1RxGkD+aDUnenpklQXW1aU9LaJxQHtP0HRhg81DZgLHcmTByy8Lh?=
 =?us-ascii?Q?UKtaAF8C5akDhpxqvO4nXr0TmLwQJS4QVPykYZoXMH9sz+fLXcdTIwKkhy1L?=
 =?us-ascii?Q?k3AwGvKRZ6CGPJxD+MFIQyKN6N7KwrvP4t01gE71mwu1/uZYPePzkvpOwP1s?=
 =?us-ascii?Q?KfzJh9qQOvO9HP40STWcCOP/GMSVqEBltGzKWPbBm3af//YnXqZ7o1hsCsum?=
 =?us-ascii?Q?tE6SAGtkos460Z+TJFWzBQrPueXKLRwfp5DvGIHVq03e8eIZUVjzpdLBpQWm?=
 =?us-ascii?Q?WbYE9I80fGZriCFgHP8mp+zvSY35S+8j2cgZR2sY24O+FOlD5mOU2p+/K0Ah?=
 =?us-ascii?Q?ZRrHa2dk1Vr9vHF52b1SPhhzz+CaMAReqSqEjZKw+D1CYm14nOnYvq7GEHDo?=
 =?us-ascii?Q?qZWGLQRiNNEgpF5ntDxPVQ8ULkRxUa/UmpgfmmTEOoXcNbjkYDNujsFRXglV?=
 =?us-ascii?Q?up9OyFG2oXwD35eiS75t0IEkrxQUydBGiPsWM2hILs6wPRPIM+hRmK1Wxge/?=
 =?us-ascii?Q?GWPmr5V7v1v1VeZsals2Xs0GSrK/tb29h0S/CmyZKTwuxVWTUkkoBG2i3Mvu?=
 =?us-ascii?Q?Oqy3dJH/CslovmgCoThBI5ocUP/4CE0T6wmFGEyfNiZHT5dZGLasGlbhF+18?=
 =?us-ascii?Q?HypUP7v8YVQ2DZbm56jILp8nHFcmBshF4uvANFZrix70up00u2vV3wXFNIrq?=
 =?us-ascii?Q?XFtcWwC8MyZXM3CyJqQYOcgYXKKvugCCuh4+BzZdXvtkxcMGq5RuXOFN812h?=
 =?us-ascii?Q?vHXWgWG+1H+e+4lRtRh8+TmREjO97SMeYijW6vYvatxMdC0+vWa45N+5B5LT?=
 =?us-ascii?Q?sd7OgG/MlNqn4gd8faRnxGJzsIUStBw1QvRxfNRhDHCL5tlSFw594vcTiiyl?=
 =?us-ascii?Q?wdrOZ1rHhAqs8sx94D71jhd8gA3SSmyaBDSkl8s9wOBGulCWbkDhc6YD68Ot?=
 =?us-ascii?Q?cXetC+pk745irq0HC/Jo89B8vvpeSC02/btLXHAZou1hivoSkxc2nSWQJ3Wf?=
 =?us-ascii?Q?uhwHaeBhQdsFjlR8Uh/Hbu4znyeg5R4voZIEVJk7U/zGLFh4DoZKMtKaynRE?=
 =?us-ascii?Q?FSPjZbgaRLysyAJUwAwlakRR9ZVOl4RMlXQ5rZjwz0f39HyPCE29MgO0F0UB?=
 =?us-ascii?Q?xqJnCz1oIkLAainbYTAXd3/8xL2r3u8YTmEhqfmnjHsdvGO13MyQxj8PVTV8?=
 =?us-ascii?Q?sozJoMikHL2j0Tm+C04/9dZk6q/sOO3SAT0R4NXwoR+xmVFA9QHNPnknz6C7?=
 =?us-ascii?Q?4U77dnLlcoCRZ38lzV5dCxwVpbGZ7kjHy2TB7s9Hz3aWxhMmDbr35toysIUV?=
 =?us-ascii?Q?wVFeJkLxZWQBvcrmej72iF2oZAIahxq7KckXvTK8s8tuM4fujPkA18MIFIhR?=
 =?us-ascii?Q?LFXqSVDYdeJJ4jOOVrqa6bbHXJPvY+d8GuVF/tzqf7hyDep3DIr5RGfF9bVG?=
 =?us-ascii?Q?Rx4L41qVrlsd4D5T1kU3e5NXXYA4JgxHgSedpEvgeVrlxtXGCNO4RqqyhdN3?=
 =?us-ascii?Q?zPZgeRJJeLqdVaQF2LWB3tiw+ovXa+EyNiGu5TNeCgX2Ub9vHN6McXBIqqtu?=
 =?us-ascii?Q?dZzvdFKAH3NDYrfgSo7xwaAn+/mhbts3tAjsrzMkSM7sMut9C9Y91Gj7uvbS?=
 =?us-ascii?Q?oI16+nsvEg9l8GO6M0kAlorsSG0T760N2Kglaxk/0cItbBBSKFk4T4x2L41o?=
 =?us-ascii?Q?QmtGS9cmQBvv3K/OHrKpeEWq9EeC0dn/ZQ74g3XNal/8QDC2MRV/BDkFvENN?=
 =?us-ascii?Q?LWgsYesscIdJdE3c4h6DwWMitORFp6I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9113683-7d6f-41c6-cc63-08df4ba86e20
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:31:28.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BCPG5SZy6Ag79X6Mea4ptadJjyDxvD6eS31lJRGbLVE9KJlAuiSbZMWl0PozTJS8fAPkJiRFRlAMEOWCtetn6/dkKX8nCDrNxPohUZihsKc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB9591
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:31:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25098
Content-Type: text/plain; charset="utf-8"

Add dracut builds for qemu-amd64 and qemu-arm64 with the security
extension, separate home and factory reset, and run the secure boot
LAVA test on them as a simple boot test.

The dracut images are deployed under <pipeline id>-dracut (via
deploy_suffix), so that they do not overwrite the artifacts of the
initramfs-tools images of the same target, which the test templates
look up by pipeline id. The SWUpdate tests are not run for dracut yet.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .gitlab-ci.yml | 69 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index bf21e744..4a386083 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -27,6 +27,12 @@ variables:
   separate_home_partition: disable
   factory_reset: disable
   no_kernel: disable
+  dracut: disable
+  ftpm_stmm: disable
+  # appended to the pipeline id of the deployed artifacts, to keep variant=
s of
+  # the same target apart
+  # deploy-cip-core.sh and submit_lava.sh only use the id as a path segmen=
t
+  deploy_suffix: ""
=20
 stages:
   - build
@@ -66,6 +72,8 @@ default:
     - if [ "${release}" =3D "trixie" ]; then base_yaml=3D"${base_yaml}:kas=
/opt/trixie.yml"; fi
     - if [ "${release}" =3D "forky" ]; then base_yaml=3D"${base_yaml}:kas/=
opt/forky.yml"; fi
     - if [ "${release}" =3D "sid" ]; then base_yaml=3D"${base_yaml}:kas/op=
t/sid.yml"; fi
+    - if [ "${dracut}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas/=
opt/dracut.yml"; fi
+    - if [ "${ftpm_stmm}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/ftpm-stmm.yml"; fi
     - if [ "${encrypt}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:kas=
/opt/encrypt-data.yml"; fi
     - if [ "${factory_reset}" =3D "enable" ]; then base_yaml=3D"${base_yam=
l}:kas/opt/factory-reset.yml"; fi
     - if [ "${watchdog}" =3D "disable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/disable-watchdog.yml"; fi
@@ -74,7 +82,7 @@ default:
     - if [ "${no_kernel}" =3D "enable" ]; then base_yaml=3D"${base_yaml}:k=
as/opt/no_kernel.yml:kas/opt/targz.yml"; fi
     - echo "Building ${base_yaml}"
     - kas build ${base_yaml}
-    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID} wic; f=
i
+    - if [ "${deploy}" =3D "enable" ]; then scripts/deploy-cip-core.sh ${r=
elease} ${target} ${extension} ${no_kernel} ${dtb} ${CI_PIPELINE_ID}${deplo=
y_suffix} wic; fi
     - if [ "${build_updates}" =3D "enable" ]; then
           mkdir build/previous-image;
           if [ "${extension}" =3D "security" ] || [ "${extension}" =3D "eb=
g-secure-boot-snakeoil" ]; then
@@ -93,7 +101,7 @@ default:
           for swu in build/previous-image/*-broken.swu; do
               mv "$swu" build/tmp/deploy/images/${target};
           done;
-          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${n=
o_kernel} ${dtb} ${CI_PIPELINE_ID} swus;
+          scripts/deploy-cip-core.sh ${release} ${target} ${extension} ${n=
o_kernel} ${dtb} ${CI_PIPELINE_ID}${deploy_suffix} swus;
       fi
=20
 # base image
@@ -271,6 +279,43 @@ build:qemu-amd64-swupdate:
     use_rt: disable
     factory_reset: enable
=20
+build:qemu-amd64-dracut:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-amd64
+    extension: security
+    dracut: enable
+    use_rt: disable
+    separate_home_partition: enable
+    factory_reset: enable
+    deploy: enable
+    deploy_suffix: "-dracut"
+
+build:qemu-arm64-dracut:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: security
+    dracut: enable
+    use_rt: disable
+    separate_home_partition: enable
+    factory_reset: enable
+    deploy: enable
+    deploy_suffix: "-dracut"
+
+build:qemu-arm64-dracut-ftpm:
+  extends:
+    - .build_base
+  variables:
+    target: qemu-arm64
+    extension: security
+    dracut: enable
+    ftpm_stmm: enable
+    use_rt: disable
+    encrypt: enable
+
 build:ti-am62px-sk-secure-boot:
   extends:
     - .build_base
@@ -479,7 +524,7 @@ build:qemu-arm-base-forky:
   tags:
     - small
   script:
-    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_=
SHA} ${release} ${CI_PIPELINE_ID} ${iec_test_timeout}
+    - scripts/submit_lava.sh ${test_function} ${target} ${CI_COMMIT_SHORT_=
SHA} ${release} ${CI_PIPELINE_ID}${deploy_suffix} ${iec_test_timeout}
   artifacts:
     name: "$CI_JOB_NAME"
     when: always
@@ -553,6 +598,24 @@ test:x86-uefi-swupdate:
     target: x86-uefi
     test_function: swupdate
=20
+test:qemu-amd64-dracut-secure-boot:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-amd64-dracut"]
+  variables:
+    target: qemu-amd64
+    test_function: secure-boot
+    deploy_suffix: "-dracut"
+
+test:qemu-arm64-dracut-secure-boot:
+  extends:
+    - .test-cip-core
+  needs: ["build:qemu-arm64-dracut"]
+  variables:
+    target: qemu-arm64
+    test_function: secure-boot
+    deploy_suffix: "-dracut"
+
 test:qemu-amd64-swupdate-kernel-panic:
   extends:
     - .test-cip-core
--=20
2.47.3

