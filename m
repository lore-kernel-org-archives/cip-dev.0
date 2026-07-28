Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E8EC54F4C
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11067.1785244370667933537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=c4FH+gK/;
 spf=pass (domain: siemens.com, ip: 40.107.130.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i8RJ+Oc31Aw/9BwrBbIBo53xMHT+CD6nKt3x9xClN8W5ek4xHyzmotwKzE+W64QqXlJ9T/LVw2Gw4Dm4OWUsvSAa/Jy+Z5N/wk51IcfaXxUFMIlNIeJqb+zMV/eH0PlLTaG2/nvo2ONKj4QNTvKECk8QI/7AqAyHIGHWPqytbcvrylDCBZETYeiM6gOrKMXdrueMFC9cj51XJ4Xn/nTmBtfzmp3QQjJg72EmG+YfLQGtMPhMulWBU1yDk55f8MoifsHKAwI3Y5SWy4jNXuKcYc++gM2lhJdXAxibOviBd2oF5A7fe5wyONBdleBccD/nOOP+kGzs/jhJdQUDC28YPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1X2x+lXvuB5RE/RzCileoOdZBBY9M+1huxgAywXziq8=;
 b=l+2MKqTG5tiHZ0pPd86bmZNTalqrSM5fesbBtqfxysOq2pY/wOCstR5ZnjK3bh9M1k9p6lmYFZyoEeB7nkAcpBGQXxcbqpCz8QHxlBsGGHnWlK0/MWgjdKh5KNQxe0KiEOrKZNRAK/+lZW3s7j0EabVi74oFgFApUdHOd617Vh6IbQEECevpKzTLWws/EMoksnQAdsxa+9pgIz2kh8VB6cSoZQgNJPOqXx0AVtRQWzIUnyFjHZvWNeR08qJXwjuDdaNnVyPvgyo5sxxMGeIms5IHfQcjp4DIm/d1OjIdNiUSuSe903oWfEwGavNYUEwQiFGyL6NGSBHaqbnp63YMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1X2x+lXvuB5RE/RzCileoOdZBBY9M+1huxgAywXziq8=;
 b=c4FH+gK/IVd1UcskqPf07EVcsZuEvY53n8SWPtD3+tzy/6jLRj9expwMvxneqeZePYOtU8ssDYCzQ4uzdrusr4NXE097nWc8ogFpSNwkTHtheS1i4EeTiECrezW5xEFBfnU5g7w4Ac5ObDQFs8zDOJZz8KQH8EHTxrcFHs7RJqid6cTgIpZaOM16Am74vepKPuiZLwuvkM2cKN/D9s47Hm3r4w6iJrr5G+4BL0AMaXLdlOH1+5oZ/Lk3GU+6DvhqxIyHj3WlFIpNoVDCcgxTnWRk+gyM5Fvl6sQrUX7b1wA/JGMcgx7W3ws2rl1EHt5UpI39hYUsz9dWWdUAeBcOUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:49 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:49 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/5] use run_priviledged instead of sudo
Date: Tue, 28 Jul 2026 15:12:17 +0200
Message-ID: <20260728131231.117214-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 14b5b25e-a2bf-48ee-4d99-08deeca9ec38
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	eeTnum3oMgTmxQTkEcllUa6/KOnPYeCYhBSzLX7WfRnAMP9VyRQQs1uyzIr5kPqZ3MEmH0YCvsevHHEf8nP8rnF7CNh6+r3DLrPJ/yccrqYRyd9XyYyf07Sxm4RMN9EKGGDXf3Vp7+nrHCiuROx85I0+KqJp1cXU8ll2vN6bLrUJSz0uHcxEoFsztvhoN1v9sOH+ck9MAhyc06H2424VMuSKrJK7K8WbClAutVdI2WWBgNbfrdNuW/G6516nXFyqPsjKAEUUagXygU04Zx/2J3MyfjLiOAsAeUe1Q+hD8nqJ8I3RV6ObzgBQPFHtLuCffb/W0Ambu04ycatPHB0QlbgWNsLyjIztu6ChGhuvM82V4XugJqd+4u1qCelgFkuAjz6gSE++Lal/4zhxk8VZLcSqOD2YRhUBi+rCVfb1dsv3FVT6qh+eh0ZbIB6wbUtIn63n1Hci/tM4RZdUFAnMOcepSdyo5SJGFV9694GDhhX0Xd3TnI6oKkpYRS3sY6AKGILQabhlvEf372MJb8mcI34EheH9jxUJp1laPVlXATgjnWZUmJeFBNeBsDDsg/41hKJuSCoEXGfoz0CZvklwfxSGLwX937wW4xhrzZ+nSnoXGOVFCuMr3HmwQG7vYN4oOOA06ge2XzRep9hgEgGA5dEpQcjx/X38i9dQFUpvOLQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Ik0sqK9vjPLU9qJRBxUUyal2MT+GRb13iy4WzqF4LXffw83Bb/KGbIdgQUFB?=
 =?us-ascii?Q?qXl+QRcAcnGWxgsJgF9K2zRp2BpX0hgR8gJBNqCPVsLbFaOng10Ip5eC4WKK?=
 =?us-ascii?Q?SJKde+5AVxoLXTvkJvVen0nEVm1n1vdy8N2oVkZHh2Z4sG599s87Ftbcncdd?=
 =?us-ascii?Q?RQeYbFuYyu1EMvFZWarBVeIvLaEn/P7UApevq5T5nFxiq5U8xEgpr8UNL5Qu?=
 =?us-ascii?Q?FdvTXR3XwsOFRk9NAh2uQEYDIoRp2CvRc4QYjBoX0g4mPEU7sWK24wek59BS?=
 =?us-ascii?Q?Vf+yKLRZ2XyC/4vl9hc8HppBTZQcP4v4/i7o/b2qH+KhXdlDB7ZehL51ZMQ4?=
 =?us-ascii?Q?/SsNbk3IDKKJnI4F1WUX7gtc0y6QmbwmTAxIILE4T1psP5WZ6pdhhBrCvYT1?=
 =?us-ascii?Q?/aRrz4DdqaXnuQGniTT8nsjvnOx8Hgp1s+0bAwx534shgNAXjVkvcy680IM+?=
 =?us-ascii?Q?Iregw2EdG7JFx+Dg8slKU0YqTSWcv8UavxyLAJVI9Ccp1iz3sm/PWX36PeyG?=
 =?us-ascii?Q?sJGjMyPMgKpLUfnqDp4bhX4HcIx3ApSkicJyC9akSkWM48fEZR9DL8BSD1r/?=
 =?us-ascii?Q?7zp8vwIkobzGnQgW5lTh5phfti42GXt5Y+KorJ3k8ck7SFfD8PBe27g4dP0j?=
 =?us-ascii?Q?eYS0SRGOY7jVeEfrUprt5iBstTd4SVjLQx+Rrcktsh+nWPpcaUwc7vzWGeMR?=
 =?us-ascii?Q?vHl8AXn9YbIt84KtT7NhUA+pjxIwVRgQTxTiUwE2MmmHYQ7QSifMZtmNjTje?=
 =?us-ascii?Q?63NSAQuog0S3BHV7wDPyQZy59SkEmoCnXyT75gPv/KWEfBkwn0wZGQ0aXk4J?=
 =?us-ascii?Q?C3XlCwcENwBrFV/12J+HrDVUbOrvY55vGnztMcoPJu1+yhSGeSkl/eqsGrya?=
 =?us-ascii?Q?0SyDkoo1jjbWCjicqFZjwCgipsDM8aYMP/cS7vFtuw2lY8XlkOAniZy2cXCE?=
 =?us-ascii?Q?mCsj5T0qnlIfCd5KqcqTJhzRI9XNyQwRjrp5g2xVMwcv9LatbQqJQqZ6Kuz7?=
 =?us-ascii?Q?NYzpb5AwnTIbm6O6eDeC1uY0OQYwS+DErqg+PsEdY1NJh4vZ4UqlV4kS6sy0?=
 =?us-ascii?Q?9psDArxuQZXVduEmdzOrUAxM5vIaTxRBOZPjNbZtUvFlV2iCdmBzaHZOu+Z8?=
 =?us-ascii?Q?S+9sMG1vzsDlEFf7USY486oJ8/iZ2AWHDdnYGMNQcsDOLmoE7omWVBZUtSHP?=
 =?us-ascii?Q?W8dJXAsY2XKwh2mVF3v3h3LOudiRpWvzyuOfQVXVKIBnCTzaGBIzLjv2+si+?=
 =?us-ascii?Q?CBFm0szS7w5V8VHeNtslElFjjfLQt+wfQHeqdgRq7h3UgGks9h50fQzJ8WNI?=
 =?us-ascii?Q?iPmwPU+9tH31m9NYRsHjB3+qx5/1jvhPUxTGniVHZgJ+07MMQuMNFsDA0Pla?=
 =?us-ascii?Q?PqPKJ+LfNPDxIOMbxje/Z4XceG0+NnKkwEOSMjWxssrgety2CNOx/VWYQFO5?=
 =?us-ascii?Q?ZZipzZCuE6zx8fbPdKthFvrSZTwRVWbYI/r1k0G0zpuf1ueKfruYiNKOBLxE?=
 =?us-ascii?Q?cBOAcGiNB1AN1sbnhnNaKh0d2ju3MGfsARhj5LqdZZWDFJiNhO0WfA5Iya3f?=
 =?us-ascii?Q?dWfqDPofmFenEtMYns0aHrSdXCQ5HeSngNYYWTdKMfTMSdzi6DKBXNo62L8F?=
 =?us-ascii?Q?z16mYyFKPYdhapRRfCea8mfZS90XbQkVliAAD6dWarUeI93+nRKY43zJWPXf?=
 =?us-ascii?Q?KmfYyk88Rn2dOuOJr1fmR/fF8pbaec1yiDGFNY8v4NCZtVwwXC6gDHsSRE9C?=
 =?us-ascii?Q?IQU+1wOhKqSDj8ueechBMmyOs2LXJOY=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b5b25e-a2bf-48ee-4d99-08deeca9ec38
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:49.1496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPHOPJQvag7stG9e8rvYUKimAE/Ux9E0qZvUpExBs5aHDEVz635S0g9pYTNDB2xzi/urCD1wPa2PU64NQk3Y8mV5qVxV9jgNehPWEmbgf04=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23800

This is in preparation to support rootless builds

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/image_uuid.bbclass       | 4 ++--
 classes-recipe/read-only-rootfs.bbclass | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/classes-recipe/image_uuid.bbclass b/classes-recipe/image_uuid.=
bbclass
index 2cd8459..da54625 100644
--- a/classes-recipe/image_uuid.bbclass
+++ b/classes-recipe/image_uuid.bbclass
@@ -45,9 +45,9 @@ do_generate_image_uuid[vardeps] +=3D "IMAGE_UUID"
 do_generate_image_uuid[dirs] =3D "${DEPLOY_DIR_IMAGE}"
 do_generate_image_uuid[network] =3D "${TASK_USE_SUDO}"
 do_generate_image_uuid() {
-    sudo sed -i '/^IMAGE_UUID=3D.*/d' '${IMAGE_ROOTFS}/etc/os-release'
+    run_privileged sed -i '/^IMAGE_UUID=3D.*/d' '${IMAGE_ROOTFS}/etc/os-re=
lease'
     echo "IMAGE_UUID=3D\"${IMAGE_UUID}\"" | \
-        sudo tee -a '${IMAGE_ROOTFS}/etc/os-release'
+        run_privileged tee -a '${IMAGE_ROOTFS}/etc/os-release'
=20
     echo "TARGET_IMAGE_UUID=3D\"${IMAGE_UUID}\"" \
         > "${DEPLOY_DIR_IMAGE}/${IMAGE_FULLNAME}.uuid.env"
diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index a67bb5f..1690ecb 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -44,15 +44,15 @@ IMMUTABLE_DATA_DIR ??=3D "/usr/share/immutable-data"
=20
 copy_dpkg_state() {
     IMMUTABLE_VAR_LIB=3D"${ROOTFSDIR}${IMMUTABLE_DATA_DIR}/var/lib"
-    sudo mkdir -p "$IMMUTABLE_VAR_LIB"
-    sudo cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
+    run_privileged mkdir -p "$IMMUTABLE_VAR_LIB"
+    run_privileged cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
=20
 ROOTFS_POSTPROCESS_COMMAND:append =3D " copy_home_to_immutable_data"
 ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part =3D " copy_home_to_im=
mutable_data"
 copy_home_to_immutable_data() {
     IMMUTABLE_HOME_DIR=3D"${ROOTFSDIR}${IMMUTABLE_DATA_DIR}"
-    sudo -s <<EOSUDO
+    run_privileged_heredoc <<EOSUDO
         set -e
         mkdir -p "$IMMUTABLE_HOME_DIR"
         rm -rf "$IMMUTABLE_HOME_DIR/home"
@@ -70,7 +70,7 @@ EROFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
 SQUASHFS_EXCLUDE_DIRS =3D "${RO_ROOTFS_EXCLUDE_DIRS}"
=20
 image_configure_fstab() {
-    sudo tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
+    run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
 LABEL=3Dvar	/var		auto		defaults			0	0
--=20
2.53.0


