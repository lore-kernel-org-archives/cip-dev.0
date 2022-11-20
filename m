Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F6BC4332F
	for <webhook@archiver.kernel.org>; Sun, 20 Nov 2022 20:49:12 +0000 (UTC)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (EUR04-DB3-obe.outbound.protection.outlook.com [40.107.6.72])
 by mx.groups.io with SMTP id smtpd.web11.22475.1668977348123458741
 for <cip-dev@lists.cip-project.org>;
 Sun, 20 Nov 2022 12:49:08 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=LFpj+IEC;
 spf=pass (domain: siemens.com, ip: 40.107.6.72, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crBn/rFaXDZ1Jo9Qg5/Ok7MvWgP7E79xN9YrBY9xLN+//8dJLpEvj1fT7wevyiehKeqhTlFmVL7MS77YHKE2fLUwJJoLTwBiljkba9eav8NvL/Xxl7WZL1K9Vi4vpRwMHfZOHUeXatG5SXEN2LRwO/aaaU8yDqE3yqRDA9kE7eQSkDFciIG9yJx1X43+SzPA4qnT0I3hTamwWFGQ/KxVcs3uGYKg4xiTZI8btO10cXvK7vUoUvBBS35kbZ4+BzM8GT0fI8T1ep+RsfgVh1+h5Vz4gmZNad/JzK6Uc2mXaSZKMoZ1T/8kUQPZ69Q6+u8UQTMDz7ClNOp/L6W+aWgfeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OupTKXhYk9qDM1ix+oJWDCIw7U8jecNDIbZldGGWHDk=;
 b=ndaAxLEqXc8eJd12VZGYH12X05bm9ANMPsJtDY0GMkdfAbUnbp0/LraIwYE4S1YTFQNJszvR8g+e2t69EOFN/75mGPg8u086XF5Qak2SS61G6O+K5xmNYuIP30sm8L78Z7uz/JQcCpQVadxpjT4dNC4wIwZA7eav+4WY1XwYDrmRoJk7ISX6WGjlWJJ/8eIUD21wEtFEJOSDh7Z+pRJalxXJYLYS/ZLMlm0ypEv1zzTvnJ4q3ZuP5o2BSNznMZJoiCA/DePdPP9ns1WjzrcVZCh6hwPc5Qk7UQs1aBd2q3zrt2U8Pxr+oEJHscFY8GGFF92StOODinHgK4sEqVuh5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OupTKXhYk9qDM1ix+oJWDCIw7U8jecNDIbZldGGWHDk=;
 b=LFpj+IECnPT2Kzo27Sxs4axEfrursrkNRJSZypwDcSxQLH7yV3xeSYzJHab2KGOmCvyaV9fmY5pDqG+xDYvdPhXrvDB7kNjwYzBcdAQ5/OQdhvJlVe6cbbdhHCkf+dcwTR6NWtugzVgdCYYSyOFRjCsxbFO5KuzVkgWiBK/I1Dv6WxPD2XIOLOuvVAZYf87RAMis1Z0nDnO3c+3NYtTi8BEaSYzWw4X74oCo3D+dPxQfsQwOjmaB0DTTeesmTTaq/EML6ZzE1uhyoR5R7BfleZWx6x9urbRo+r47ffA+Iw1NC7a+VPo+pAyilMRZ94YRysxc/Xzw2MY2SB4ME9xHzg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by DU0PR10MB7094.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:42e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.11; Sun, 20 Nov
 2022 20:49:06 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::955a:f715:5319:7933%9]) with mapi id 15.20.5834.015; Sun, 20 Nov 2022
 20:49:06 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Date: Sun, 20 Nov 2022 21:47:06 +0100
Message-ID: <20221120204711.5826-4-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221120204711.5826-1-sven.schultschik@siemens.com>
References: <20221120204711.5826-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0083.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::18) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|DU0PR10MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: d91d028b-a7fa-4653-7a39-08dacb38aa2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ZHea6dKvm6uL88lqm8qoIJk3QyTxWptvAu2tfDJt4QxXJGhzRMjxqw3IJBKX9x5TbPtHrPsQKZdGFzEo1L/rGqN4cU2oP4g2ASgN0q+Se2tXVBdax4B8rP72Mq0eGRudPRNUQAtAR7awNcXbVYWVZV7NFukSkpnnkMYPmBBxb65HOR3KmcMExQdxnBKCrRJoCFFoBRmyIxR1R5pZ44cBqXA36aWqPblauJ0Z5K9mJZ1SCbgxdfAugl/y0oYR5LhH5BF2kCEZVWJaV+OKKUSSO3pqZmAgTAIfcn74nu3HOnGw+m8UyIgZDOZ4MAXonb2EaijBWPF33a1CINhVlC3dhlVT6yAIhaRwm0nSKE94BEsiD/hrf/5uG+oAzKRjBEyLZi9GVs9QmPcd28wQjm1DHque0z8fbZELnbWOALPmfJKF33sgvJbiiFKoBdCi8QNoGcGsitw7tfj1SsIfURoiJ7zCy4gJrKgcyWn3M59y9a/Ij8NTnc3fmMy1dAx/y8ZhknahacLg1vJ1W0mcp+J7Ehdc/lhL8CpeLVCP0Bprw3fFp/UrVOXIh20V13iBfnMBzj5R3TcOUb2TCPhr107/ArnSlHyLaZmJzl/iaHaXgQIZNmRscOOtWO8o9sdgAIsBu21JLEEWKDQ6hO+qCcoVVA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(366004)(396003)(346002)(39860400002)(376002)(451199015)(2906002)(26005)(83380400001)(9686003)(86362001)(4326008)(6512007)(8676002)(66556008)(66476007)(82960400001)(66946007)(38100700002)(36756003)(41300700001)(6916009)(8936002)(5660300002)(316002)(107886003)(55236004)(478600001)(186003)(1076003)(6486002)(2616005)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bXecD+bEhgxHMypXFmawqe6RTBAraw2gBqidXwZ+SwmynU/lHb++zT+YXs23?=
 =?us-ascii?Q?R2tt4pXwvQa9K2aXnSNPDF6lNE024HbwnRkdgdQCjW9UUwNBgUctCo+r4P9o?=
 =?us-ascii?Q?0wd1tfpt+JGCMwDKLxmEkzJtJCBpYgSrn9OoDKdJhjv/YFAd5ggSKfvUcIhz?=
 =?us-ascii?Q?55fFoOTBsbH4ibzLl1s853ZYrgnVFBqJAgZUdR6d4tmDS9YVyjOGo94IHVVL?=
 =?us-ascii?Q?W8+jg5cfFDbAnEB49DXF3ab5JewOQSGfnTnOmDgb6+au823OOSZpwCtMORaL?=
 =?us-ascii?Q?YuL5FE4K0I7lzW+1swXBxb/eVXcgJoMSrONJRdpKQAxa5bXw14MBhk6HwlRk?=
 =?us-ascii?Q?U06wWQ9qjWwIf33LNZLAJS3kLsixnGqQ09+xqgOU5Raf3uKpX6FgOOeSb7gQ?=
 =?us-ascii?Q?NS+EMK8mRtOTSS93NfeARxhuxqYRttMlcBGoWuLNa0dBlRA+Dyq/wYX0GRSk?=
 =?us-ascii?Q?stIVASyW/lSNtu6RQWaJFRj4bFi14Q0gNWTrsZG5uJfwQuOXXz/04UP44m4d?=
 =?us-ascii?Q?bLJdpdIM7veTm/XYCHlxKZ2bGp4HQjPlCsW7H4dnHMgN4TyAf67J5M1GkoC5?=
 =?us-ascii?Q?0iCnVRj07yu3+wG45xUMQ5Rc4mcGWOlvfNxpJA6Qqnei62c/gYstabtoU2uA?=
 =?us-ascii?Q?kRPwW+4i/uNDQkixd2Kr7fM2yyj70zcOb3JMTJsYQSJSB9XDJJlHzC83PTDj?=
 =?us-ascii?Q?TQ++HxW5TO8iwrbNHbgf6uMnamqAZFXf7zygWLykr/lt+AtQ0qM/6sYkCy9u?=
 =?us-ascii?Q?u8gyZAOuSodo2E6h7AAh69FU3yjH5nV2nokKe6K6FhzMi56DvBY7h/DeCYJ9?=
 =?us-ascii?Q?DGNZtw+H0AP2SJFY8VZtdgCLdXc9aKQ1H9OrQy9dK29eWXiTqroeqj3Sf5YY?=
 =?us-ascii?Q?188m00hI4p1y+CefiEGhkmrov2ryy5Yequ+zKWBH0gKsDjiFxwPPamhvZPRP?=
 =?us-ascii?Q?ppWEeiddEFa+MfqBYNgIsZ4bgduI0P5NL2TYapUDwYsPrUI4RDr8MbFxVwuK?=
 =?us-ascii?Q?cRMEml/ydgD1x+CpPbUwEkWRjB3nWoorRRgVS+4pweK0wUsShzNDnD4VY64z?=
 =?us-ascii?Q?xPyzXK85rDVoGVywyKAX6H56j4vAtQMIAWuUGEjiYOkE9erKLdmTPOxSf9Bb?=
 =?us-ascii?Q?nKZEQj1y5pbxoRtLuaWY/quOm0j6qlGKQu7lenA3BIEtw2EMBzH34P+Lq8ab?=
 =?us-ascii?Q?Qq7fUQs8a1UtOynbZmmuoTivSLQQm3dHNjJMarLzrDw4s29zQwZacjhndcRc?=
 =?us-ascii?Q?7WlsSBGO7BpropXtuwHeDqb6UpZORhxQjbqClMwOJKy5W8fGzxTLcBIAvZJL?=
 =?us-ascii?Q?SnI4rHzKD6dDTeSQB+cbRZJD4KPmBrjhvhDsJnNnfJ2o8sHSpdS54txO8urY?=
 =?us-ascii?Q?hLVsgK5SSntBQwF1a7e3ndwKzT9TIZgOgu6lOo27age9G6sdXYTo1wXZeAfB?=
 =?us-ascii?Q?skh+keJjLknT0hepbYkZvQxpsyCzOD05JrsFbSfbEVJqIUYny0WmkA73Y/l3?=
 =?us-ascii?Q?PQRx42zNiOJtPPssm1JnQ3hSuqFV4/9UJ7e3epqYVry99aaCZxuolDSo4YBr?=
 =?us-ascii?Q?kOwlnfnwMRI2lgT5dkN6jb49tqTUpzDLMSUZmor6U24ELwcgrnpYfpseizmN?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91d028b-a7fa-4653-7a39-08dacb38aa2e
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2022 20:49:06.1064
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tZqP180HoURcwTWkh98dD0i8aR4pfDG1iToQpqLOCgLC6Jfqo9rfrh/vzn0FCIUt/QFYpKRMy/Mk8QdH5gGtkum4Yt6eAq82LllKXltkF9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7094
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sun, 20 Nov 2022 20:49:12 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/10056

From: Sven Schultschik <sven.schultschik@siemens.com>

Optee is part of u-boot In the secureboot scenario to use optee and RPMB as=
 secure storage.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 9 ++++++++-
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 956dcbf..2b75988 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -2,5 +2,12 @@
 CONFIG_BOOTDELAY=3D-2
 CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
-CONFIG_EFI_VARIABLES_PRESEED=3Dy
+CONFIG_EFI_VARIABLES_PRESEED=3Dn
 CONFIG_EFI_SECURE_BOOT=3Dy
+### OPTEE config
+CONFIG_CMD_OPTEE_RPMB=3Dy
+CONFIG_MMC=3Dy
+CONFIG_SUPPORT_EMMC_RPMB=3Dy
+CONFIG_TEE=3Dy
+CONFIG_OPTEE=3Dy
+CONFIG_EFI_MM_COMM_TEE=3Dy
diff --git a/recipes-bsp/u-boot/u-boot-qemu-common.inc b/recipes-bsp/u-boot=
/u-boot-qemu-common.inc
index 0a9a15a..802fc50 100644
--- a/recipes-bsp/u-boot/u-boot-qemu-common.inc
+++ b/recipes-bsp/u-boot/u-boot-qemu-common.inc
@@ -13,6 +13,8 @@ require recipes-bsp/u-boot/u-boot-common.inc
=20
 U_BOOT_BIN =3D "u-boot.bin"
=20
+DEPENDS_append_secureboot =3D " optee-os-${MACHINE}"
+
 do_deploy[dirs] =3D "${DEPLOY_DIR_IMAGE}"
 do_deploy() {
     dpkg --fsys-tarfile "${WORKDIR}/u-boot-${MACHINE}_${PV}_${DISTRO_ARCH}=
.deb" | \
--=20
2.30.2


