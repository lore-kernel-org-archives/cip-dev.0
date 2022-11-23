Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A13AC433FE
	for <webhook@archiver.kernel.org>; Wed, 23 Nov 2022 15:30:35 +0000 (UTC)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (EUR02-AM0-obe.outbound.protection.outlook.com [40.107.247.69])
 by mx.groups.io with SMTP id smtpd.web10.22975.1669217430360388794
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Nov 2022 07:30:30 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=J/aGFArG;
 spf=pass (domain: siemens.com, ip: 40.107.247.69, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6/0r4MkuyegVu18zjBmSUuFt2bdki8/D38CrWxUiXIuBIXHbLQN7AhjxewRav0fWAqb7Xo27VcLEcLQocrlxKXZ3fPsdhzmXNjt4uqDH+nJRYRcH7S9agraYrE3AnFTOveHKEKHh//Js7uSOGnj6+cmHNHbmJmtZ6hWvRdPa3iwX/7/uQDKioErOJ6Fo/CygDWMrIsCp4Xo8k5a9WICjOBM5ASZBKvp66+cnvjMmel9PjZfOB3cLH/Bv0zZ4sKpTsbfz1AcoNTj0VtlKjBP8+H876tnDJ2c9SG2TRZk+hMn6FhXCWWTU7mEpG1huSIf7Ke2DG0ai/yL0ENcv0kgSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKcrdAiNwufxGz2Wt6F0vWBl3Vvm+2Dsu5U007LIbfM=;
 b=YJcF5EA0lUz31H24J3QXFKa9a7PeP669o2QGwN6OfBkniWHC6L3RPMIYy9JLzkoDcZGUKwm61HqQg9eqpPTCIedVY0N1SC57t9uag6HNXYLa+7B1TXVpxkZgfKYmlbzq7nFfJVWlyLXnYdFR4kz8VlDBo4sRkcyJNQ/syyLvHiFo79pYZOZrKntLIC+2lsfUwvhvYygf1d0x3Kx/gOMDB4kR+1wkP5rIrqBBSCwcKBY/RIIJxRvR4Q2HXhQrJUZrTtZC1X3CcP3ZXw9v1geuloiqHl4q5gDY1QUZ3wE78Kq+qA594/cjTpzR8h4o1wn7dLpXQLDdCBuMO0zfYAjEGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKcrdAiNwufxGz2Wt6F0vWBl3Vvm+2Dsu5U007LIbfM=;
 b=J/aGFArGrAvCYT2MqnVtR//hIoDZgmsO1yTGZHLT+3H5Dknls+CcrQZZ436hnKSXDrcpLKJ43UfIywsCghkyK6NiN5EFNkli7soOGvaGZy+ZloA6zOUYLXg+jDwdP6FfrugXHgSKTaL6NWUp5hKaCwox8F82dMHnK/rjgJD489SArF6xGybMrOTrKVsFDRg8N5UKDWBA7s/E7Hw6gnMfnT0nxCAZuP2lwhFKutwBtDENk0pRoRPXDmkFGXSFHVHhzg0yOJTwbxHLK3lBhR92S4pUPwwSp3zg97xMEuiNB4EYjuTsnm20KHh1lNpwv/Y19TpQRgzMWfIrFf4b1jJ/rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB6318.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3b1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Wed, 23 Nov
 2022 15:30:28 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Wed, 23 Nov 2022
 15:30:28 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 7/7] Use of snakeoil keys for qemu use case
Date: Wed, 23 Nov 2022 16:29:06 +0100
Message-ID: <20221123152906.75323-8-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221123152906.75323-1-sven.schultschik@siemens.com>
References: <20221123152906.75323-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 19ac3a55-264f-48d0-536d-08dacd67a65c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	AQVeaErf42Nn4zoMwHxgJwglrZ14oIS86CUSsjTAm72My+RBf2lN/Msfv+y7vZfTL9tdn6t3cHywmZ+UoBYFQIBWf+tLCOzTBPMK1rqAWOj8BnT3p9Imyg83PaDmw4B4EkDCXBzm3qZm/j6F/OIdCPY9o5xja5a++IEYi5vQz+EIFAcwMWbQzFTuxc0Yk5wmPFga7IcIakZp0fNOifE6llPTOo3JI97mMvMAtzeGul5D4H1lvz6ghi/FUffOQVaxD6c1ZBqtHjQLI+HxIzcwlD8wzAFoWOyFyS1ijo7yD3F58DpOfShbU77UHDRJeIGiG7tKkLmacmhtQene9uT1tOqcdRhsYYP8f73wUtZZBho8h2ape6zd2Jmo95e8rggrvIZelhMa+QTTUdj6kmzwmwaAI6z+6FtOme0ZSeQCG8gC6q0TlBcvk9Oc8y2obpy1zELlPMOayqFT8bcpHjwhZl6Bwd/NJ10a+aC4dPhkUR7vGH03+hA0hpeRkf4DmLdh8CbvmgkcUNx3gc33ozApqfcyW4xDTjp+8TLR4XiCKaypmonGkvZvNPylXnUWlDUi4fb2iwI89SLWM+n1DcPGHEeYuZoFtGYvZZNFhwMZgFBRn50kI4c9QodY04uoqa8xbSfc2Q7pLWHzL4yx2b5T+A==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(366004)(376002)(39860400002)(346002)(451199015)(6666004)(41300700001)(107886003)(478600001)(6486002)(9686003)(4326008)(66476007)(316002)(8676002)(1076003)(8936002)(26005)(66556008)(66946007)(186003)(5660300002)(36756003)(6506007)(82960400001)(6916009)(55236004)(83380400001)(2616005)(86362001)(2906002)(6512007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vwqQJPBZ6pMPnA8W85cDGuKrt60t9OMgcTm2sm62yHw6aZJoSizfFDwjMerE?=
 =?us-ascii?Q?HZWBeUgBRlKuoOnZEdbTc7WPQsogoabnTAg060dcmccEw7DwvUYGFfii9imV?=
 =?us-ascii?Q?DU9jsHdekNuX3Vo1mybVj2goSWYHTugTPppzyLSmiy1uksTHHaYADMbLnBDJ?=
 =?us-ascii?Q?VuMJ4OziEho0B/Zq+mfnqQXNTdIL6esBt/h/Ye+A3UsUhAWMMFuIbCtUHYzT?=
 =?us-ascii?Q?RgmPawilhMtFs4Uqki/bjigaj0pNTDTlvtxg6qpeaG/J13vf/a2BepbDDPT3?=
 =?us-ascii?Q?ir9MN13ptCydvBtP2YltBbVVf207ai9Vmr01Vee1XUt67Z61a90vM3S67qBB?=
 =?us-ascii?Q?pKzYnCatbjZ7ZcB0Mc3DzaTmoK2wJT93yye0syb+NlP3KrSgz7D8Gm9XLgEl?=
 =?us-ascii?Q?mpuumifrRjuVy/YmUgZ1w8a8sMmyexCbj/7e+3MFKEJV5nAlGtC2HVZNGfcf?=
 =?us-ascii?Q?gDB6Efx+KQUP8MnHxqOEYJTpCam2OMzNWyn+7wHZi3RwCJVMkm+7DlRYDKx1?=
 =?us-ascii?Q?UndExVwL1jGer1SYB8MMy0gJdGCT5aLBlW6/he/1UZ8gQ0ZxQYxCJ+dJciR1?=
 =?us-ascii?Q?Cp86YUldy2dnIuL6QOgQqWOa6LGDTiMEn1xYe7dY8CQ5wvE6n61YaZVzsNPH?=
 =?us-ascii?Q?mcfy+2empstEQICqYn11vIJZjGpKjUxQvZiXJ7J3CwoybLWKRBbpO2GRlhiA?=
 =?us-ascii?Q?mmd/KZ2BgpumS7T7MXaU+6cMpVYudS4kOAcfU+RiRyTWlNmKCCTFawXGHaWy?=
 =?us-ascii?Q?Cbf8u1jVAUe2PdP0SEr7OOIxb8/DsoRCZInA6dlE46x/0NA1SmI4XakKkfMV?=
 =?us-ascii?Q?OKYWkwn3NuXIPOhQH13yIFJiRxZJn8uhhLtHu+6TdfENGVcwVloaccqEySXQ?=
 =?us-ascii?Q?5VCz/mAbpPACnKoT0qXqwz69Aj7Qmx8C0zKlngpY2GDc3IH5s3uxUDzfwF6D?=
 =?us-ascii?Q?5OWXrO593CnfETfRJPTUBNbA63AXuXAY2I1/jSqJL3vGRz7kyGYlVH7tuESR?=
 =?us-ascii?Q?x1o+vD65mqf0YOlroNux0FwnkhdwTfisoxqfOkiyUxgkg8OnWwBEMBwbjJZk?=
 =?us-ascii?Q?e8Wd0R8XKKNh+MySyej4opIkJO9kAXZPc5RUJHqGVFaurAwtpM7bJIBbd/vr?=
 =?us-ascii?Q?BxeH9kYruNBZDAQvFU0E+hK+t8wvZ4Lm3oHBVGbcEA1A+d8GARZ3PEkoPpZv?=
 =?us-ascii?Q?da3z6hPUp+7xtnkh0wsJJ5hqJRSpcrHW21jvF9N9w82vXVrFculy/lxwjoHF?=
 =?us-ascii?Q?12X7OMSwq2C+YWESv+omG3C+9ED8MlU6/X+WPdpr/ov2+4IxH/3dNF6vUJTu?=
 =?us-ascii?Q?uHYrX16zOhtL+ixApUAHkc50ehHrOt2U8NTIxXY3u/nOp1J95wjajWTCBGqI?=
 =?us-ascii?Q?MxW6TjXsYYXsHXIUeRqF190Lr/tXY43sks1IWgd1sPuGta/4BsHjqfqnlliU?=
 =?us-ascii?Q?oZ51n1Jb2N83naZvrOviS3cuKQyXkj/Ge9VYxECd5cH0lBi0XbU60KXZZvcK?=
 =?us-ascii?Q?pR4+9MNClpZgY8AA6q6Q+XxyU7FEJ6CSKjWcEzT3vkXSPA3BuqLQPTpfw2sa?=
 =?us-ascii?Q?s7gsXZX1PIp+dHF3q6J2/Qxhqdv1labTuOY7ah/E+C+TKNvUcsANhsqUkBWT?=
 =?us-ascii?Q?KQ=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19ac3a55-264f-48d0-536d-08dacd67a65c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 15:30:28.3521
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2ShkzeYh6+NzRUPb9X/ThboUfLH2nLMUjDkBFeMCztvlnIRA5GYjO6rwkVFFEtsUxm4kUhs+0Ec2IZ/avVJAkeYCVQw3I/P1YxVW/gS6MbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6318
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Nov 2022 15:30:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10097

From: Sven Schultschik <sven.schultschik@siemens.com>

The snakeoil keys are copied to the deploy folder if machine is qemu-arm64.=
 The RPMB qemu workaround is not persistent and for that the keys need to b=
e provisioned on every boot of quemu. Therefor the keys are copied to the d=
eploy folder, mounted into the qemu as virtual memory and the boot command =
automatically loads them on every boot.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/u-boot/u-boot-qemu-common.inc     |  4 ++++
 .../secure-boot-secrets.inc                   | 19 +++++++++++++++++++
 start-qemu.sh                                 |  3 ++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 6e7158b..36e4dbd 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -18,6 +18,10 @@ SRC_URI_append_secureboot =3D " \
=20
 DEPENDS_append_secureboot =3D " optee-os-${MACHINE}"
=20
+do_prepare_build_append_secureboot() {
+    sed -i 's/CONFIG_BOOTCOMMAND=3D"/CONFIG_BOOTCOMMAND=3D"fatload virtio =
1:1 40000000 db\.auth; setenv -e -nv -bs -rt -at -i 40000000:\$filesize db;=
 /g' ${S}/configs/${U_BOOT_CONFIG}
+}
+
 do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}=
.deb" | \
diff --git a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc b=
/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
index f53435a..196d798 100644
--- a/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
+++ b/recipes-devtools/secure-boot-secrets/secure-boot-secrets.inc
@@ -32,3 +32,22 @@ do_install() {
 do_prepare_build_append() {
     echo "Provides: secure-boot-secrets" >> ${S}/debian/control
 }
+
+do_build_append() {
+    if [ "${MACHINE}" =3D "qemu-arm64" ]; then
+        cert-to-efi-sig-list -g 11111111-2222-3333-4444-123456789abc "${WO=
RKDIR}/${SB_CERT}" "${WORKDIR}/secure-boot.esl"
+        sign-efi-sig-list -c "${WORKDIR}/${SB_CERT}" -k "${WORKDIR}/${SB_K=
EY}" db "${WORKDIR}/secure-boot.esl" "${WORKDIR}/db.auth"
+    fi
+}
+
+do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy() {
+    if [ "${MACHINE}" =3D "qemu-arm64" ]; then
+        DTARGET=3D${DEPLOY_DIR_IMAGE}/keys
+        mkdir -p ${DTARGET}
+      =20
+        cp ${WORKDIR}/db.auth ${DTARGET}/db.auth
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


