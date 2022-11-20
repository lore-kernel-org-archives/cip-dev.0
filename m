Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C76C433FE
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:50:42 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.88])
 by mx.groups.io with SMTP id smtpd.web11.22517.1668977432520165781
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:50:32 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=uFhjXs6d;
 spf=pass (domain: siemens.com, ip: 40.107.6.88, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fJPNVIA3sZRbR9YLyMRrULQmoB8SlzHFUVvEgVCeZ1GmtQ78SVuFjPINahSLN4V5u1Dco9f44YS1J/doKW0a20+tWX3cg8p7Kb64g+xbNn4nvKrQCj69itAwHyN1IMT7mIVNfDbPCluQGO+Ii7fwNF+WnuqyUxMKWkOK1sshUm+Snv46WfhzIvHcwOq4WHFJVIp2Cib0yeu8//kpoeYLgFhI/0JnOIbVStbsnWAdpYXwcre+PEdf/613Hdxf/igG7jS1vHZrIag6LLNGSGBhHtcZzGLXRMXTX2fJjgkPdwGXKBku1321GhGUqMcLCBV3ImVIVlYQlw5tvLFoHxUvJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8Fuky/XBhRaTNoSeTJD7CL3vYvx6YZSJzfGFV9DHHo=;
 b=Yt6iXYKWswa4StAMH8z4WwEW3ZRo2RLovyFn0kcWebXnsdjimeRWzaBMAMemvKp4WQktJogs7IUGj609nR7L9nVjuFSVHTwNp4BTyYcxp10OZHqSEu5M4nUoIZFxSumEFj8yBq5vKszfWrlEZS2gCFwO9p09vCeBUuv1zgvwzu7owh1zbqdNTbw/11HRjsHJ0soEqA99fKAc9vgTDX6ZvqN0Ix+f7KvumlDvu0cIJDWh6eMWMXoWw39KHgvCtTgIsoeWU8N1NmBspOJTx4Sb7b3yrgYw9Fbd/aEi/6Ayjt0F811I470dZs4N8Qw1mA7yhIKPo3PEq04azJ8WSGY00Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8Fuky/XBhRaTNoSeTJD7CL3vYvx6YZSJzfGFV9DHHo=;
 b=uFhjXs6dlr3Cwlw08oDNfBgduWYIUuPxuzp+0IeNuDj3Ry5SKEg+7ejiC8r3m5SlQPlKM+TiCuj1NbFlDcWr0xENe5dBXC+I9R17qx2dOz0K5kIjJx3Rno/WavECKBYSX5XOrK6mnVKTRjmeHU3y7+5KZNnzZqsQzPnMtmQFbujA4NSDaiOIWoTAh0gDttmexrF3sFYQ1+hQx3be3hY0ev2h4zz0AOxS+wz9GqJ3w23rw4aXFGnvln1OBfL0ISDb39tC4wQwLiBBtaTTbH9E0qku6CPECCvn8o1Tpagh97D/+uWGaTB51+SS64wpi6yMw/bsJ0YMfPaknRVrQu9+Vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:50:30 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:50:30 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 8/8] Use of snakeoil keys for qemu use case
Date: Sun, 20 Nov 2022 21:47:11 +0100
Message-ID: <20221120204711.5826-9-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: f4278706-c464-4dc7-ba21-08dacb38dc84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	SATdCG7OhxK9F4DnvWv1677xRrNwp6DgWPPo9+wx8cS4Z4hNFQQ7fwDJg0QLIglyplzt1dQHa3Od/H5v/4kBTuYyz47zuBpDYtR6ACv+oFoNiMIKcF3b+EXKa04tsOKfqf8ILjVyBbcl+rtXa8yRPVxgXa29AAg81mqmsEjdXHC/gPgwhnBrAUEtyu7QuYpn0H/XLVKxh5Tvw6iO91QBahLyVJem992gmxHlno+FlcS8rKcxAeyMvrSdGxqYRmQcQnQQn0lF6kiPRDdADD80EO0gMrjOqx/c6Jr7l+HSaj2uNv4V7GWqs6lSzVQm9/V2e1tt3BR6zRdm4W6HUt4uFLldZMxNlNs5tIpResEZxnHYO2YhPeb1NbpS/26Wjr0f5sMexqzUCdrT43Fx/Wz1/qhzgthcccHYLIiLdzSpHzROBQE9sY6EcHZUBhmqKWHM6Cdoo4NU5b73fwZcD0TJJw0mncOgbD2HXT3In2GDs6Yg0aRqXtRq1FeWo58DkxyVU6Ovq33hIWxGXUCge8piD2kJng0x2Kfpt2Ya5lXHlOye9rt2om1iWX2B/yD28K9nFs/xxnHs7Q1XUPj48HCfmddJrmf6bNmTAduiZyRTkal4g4kjyKveovkl27swVQ1dps6MIoSzIbpPTEerblL1iw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(6666004)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?v584TU65xakZhv4/qp5Jw4RYf+s4GAxXW5g/YpMRmjoWbNZg1JKX+60ydGvq?=
 =?us-ascii?Q?Vucw3EYK3tY1vCrcw12CPUpQbmpWQV4R7p+H1nUddf12JusG4OAjqlwBQRMw?=
 =?us-ascii?Q?9zhXP8+rtA5v5SO6CbKAGr7Klj2KdbBoKrpsUtUB7kC4KZeTt+8z1vyzHv7g?=
 =?us-ascii?Q?C73/e4Cj2W7NnMjaHV080Ww5ufYMv9go5twtmvBkdEKmXaJURvkciAJ1mDjm?=
 =?us-ascii?Q?ka3e0Z7NbmUxe565KFilsNupNNp8sOEB1/Yx04Cw8UyCufleMWHsEwQiTJJK?=
 =?us-ascii?Q?+jbDf2qtUWbzA0WWhYlSqim9pbODue4z2hWtRb1p7JdniiINhW5SN1LIUTjC?=
 =?us-ascii?Q?g7fX9/OMVE1l+0JgpKYtE3JiLnPoE7hKiEFsFuwyZwD/zBsj59du7nzyV/IC?=
 =?us-ascii?Q?qSutIwGbraQYgcrXLzvz/yuahd9GsEPZS4SKxupfsZ6RBffWNmxzPd2o3rv+?=
 =?us-ascii?Q?lTCBuJOe9GSmZFt1up8RGMPBIVBWcVcGp1nHUxzhwooXB2XktQxctDbMBqfl?=
 =?us-ascii?Q?4e+IbN3IQeY6wmoq2oBuNLzqVEfz/eHH6LCloPQxABYlD2NOYGTIm6WUg0ai?=
 =?us-ascii?Q?lgfl+YD+VSL1i39wyebsY7hwv5E/9c8tV5yFV4k9UER89kV9eb5sewqGSmVd?=
 =?us-ascii?Q?8eUpMF7rFwAhdrG1eTIFINIbdeHx3g9Jpjp88k89jU/afJEwOnUjMXcI1/9f?=
 =?us-ascii?Q?GT+30ePbqSBikHxCpP94fONBTvKrJpTiKQuJTshcMOar0JDbAHYfJu010EXw?=
 =?us-ascii?Q?f/auOHBl/2HxrcopMipM/KvyJzCBOY3oyuxFBwHYYL2RuogCLw530LyIMzvI?=
 =?us-ascii?Q?O5zEysFkWItZJLZnJn+J8hMI+YQFNm1BwK848Le3pwpbxHnDBSon/0Ev0KW5?=
 =?us-ascii?Q?o0B4bjCuy531lbbi58oesG0UPMQQUG35H2mRCOKyN1bJj3hTXOB+P31eLJcP?=
 =?us-ascii?Q?ijfVo62H4/vFp41EzE0A4UnYkSGBZspCPo5Jg5qSVIqzf/74Pklj2xoHqiAR?=
 =?us-ascii?Q?CtpC9SmUVLz5WrnXXFNoOK3jsPxboEXirEgyAtBUrlvRrlamzX5jqbgDS/Pv?=
 =?us-ascii?Q?eduUQjJCtD0TnYgxr2rguAZqwSEBX7SbAMNL2lnvxn9z9qfGsFEFFvx5cH2h?=
 =?us-ascii?Q?aIFhZApgWGSN+KzZQiKfuJYN7Zfki/ulIaaV+UZQQoW8g4TGO9Iblsnowfal?=
 =?us-ascii?Q?JtJ1rgIuZkSCDXvIjMoZmlz4gpUXLq8T1ErWxtjgWQ0RYzanegEv+HL3bmLe?=
 =?us-ascii?Q?GUt8DxngPwR2+kOch/4iRI63a46DsB8TJonce8/cZqeGbC5gYaoG+WN4JVCy?=
 =?us-ascii?Q?Dj5Bg/JUxmmyI+L9AaYCC9bv7I+FAcKmarPMZrBsug3JmcDBWDaIht6drGK7?=
 =?us-ascii?Q?St9nlcLsAwV7J6wkTTzCPuomtsIIRAuUBi7L2M/bQF9FE4CHpwdqrgPx6gDc?=
 =?us-ascii?Q?xGBBlm5k8JD9ZVt+gACEgDxxpj9nYk+x96C9B6MEPSTdC0twnYXBM4orjp/n?=
 =?us-ascii?Q?+kQoxcMRYEdGrU+xT/rSDHwFqLied9NNrfIshj97/mSETOqgkECACXErCTI3?=
 =?us-ascii?Q?8MiM+nDzuUnIprrsLrjFDMxEhtlBn0qkIs2Hkx1iPPRs7nvZEyGBIGqcoAqU?=
 =?us-ascii?Q?IA=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4278706-c464-4dc7-ba21-08dacb38dc84
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:50:30.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SEoPKLIk5UJqFx6LLqWMlOkWuM2RGsRBX+oPXhlQrfcqtZRpHf1K94X8J0sHSer6OGqCYd4KNwwIJ8Weu/QKfbbbWWyu4dVF3SGal3fPQZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:50:42 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10061

From: Sven Schultschik <sven.schultschik@siemens.com>

The snakeoil keys are copied to the deploy folder if machine is qemu-arm64.=
 The RPMB qemu workaround is not persistent and for that the keys need to b=
e provisioned on every boot of quemu. Therefor the keys are copied to the d=
eploy folder, mounted into the qemu as virtual memory and the boot command =
automatically loads them on every boot.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |  4 ++++
 .../secure-boot-secrets.inc                   | 22 +++++++++++++++++++
 start-qemu.sh                                 |  3 ++-
 3 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 6e7158b..51dabac 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -18,6 +18,10 @@ SRC_URI_append_secureboot =3D " \
=20
 DEPENDS_append_secureboot =3D " optee-os-${MACHINE}"
=20
+do_prepare_build_append_secureboot() {
+    sed -i 's/CONFIG_BOOTCOMMAND=3D"/CONFIG_BOOTCOMMAND=3D"fatload virtio =
1:1 40000000 PK\.auth; setenv -e -nv -bs -rt -at -i 40000000:\$filesize PK;=
 fatload virtio 1:1 40000000 KEK\.auth; setenv -e -nv -bs -rt -at -i 400000=
00:\$filesize KEK; fatload virtio 1:1 40000000 db\.auth; setenv -e -nv -bs =
-rt -at -i 40000000:\$filesize db; /g' ${S}/configs/${U_BOOT_CONFIG}
+}
+
 do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}=
.deb" | \
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b=
/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index 2a30f1e..0fcde72 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -53,3 +53,25 @@ do_install() {
 do_prepare_build_append() {
     echo "Provides: secure-boot-secrets" >> ${S}/debian/control
 }
+
+do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    if [ "${MACHINE}" =3D "qemu-arm64" ]; then
+        DTARGET=3D${DEPLOY_DIR_IMAGE}/keys
+        mkdir -p ${DTARGET}
+        cp ${WORKDIR}/${SB_PK}.auth ${DTARGET}/PK.auth
+        cp ${WORKDIR}/${SB_PK}.crt ${DTARGET}/PK.crt
+        cp ${WORKDIR}/${SB_PK}.esl ${DTARGET}/PK.esl
+        cp ${WORKDIR}/${SB_PK}.key ${DTARGET}/PK.key
+        cp ${WORKDIR}/${SB_KEK}.auth ${DTARGET}/KEK.auth
+        cp ${WORKDIR}/${SB_KEK}.crt ${DTARGET}/KEK.crt
+        cp ${WORKDIR}/${SB_KEK}.esl ${DTARGET}/KEK.esl
+        cp ${WORKDIR}/${SB_KEK}.key ${DTARGET}/KEK.key
+        cp ${WORKDIR}/${SB_DB}.auth ${DTARGET}/db.auth
+        cp ${WORKDIR}/${SB_DB}.crt ${DTARGET}/db.crt
+        cp ${WORKDIR}/${SB_DB}.esl ${DTARGET}/db.esl
+        cp ${WORKDIR}/${SB_DB}.key ${DTARGET}/db.key
+    fi
+}
+
+addtask deploy after do_dpkg_build before do_deploy_deb
\ No newline at end of file
diff --git a/start-qemu.sh b/start-qemu.sh
index 5617a2a..f29b57d 100755
--- a/start-qemu.sh
+++ b/start-qemu.sh
@@ -183,7 +183,8 @@ if [ -n "${SECURE_BOOT}${SWUPDATE_BOOT}" ]; then
 			${QEMU_PATH}${QEMU} \
 				-drive file=3D${IMAGE_PREFIX}.wic,discard=3Dunmap,if=3Dnone,id=3Ddisk,=
format=3Draw \
 				-bios ${u_boot_bin} \
-				${QEMU_COMMON_OPTIONS} "$@"
+				${QEMU_COMMON_OPTIONS} "$@" \
+				-hdb fat:rw:./build/tmp/deploy/images/qemu-${QEMU_ARCH}/keys
 			;;
 		*)
 			echo "Unsupported architecture: ${arch}"
--=20
2.30.2


