Return-Path: <sven.schultschik@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF8EC38A2D
	for <webhook@archiver.kernel.org>; Mon, 24 Oct 2022 12:28:17 +0000 (UTC)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (EUR05-VI1-obe.outbound.protection.outlook.com [40.107.21.66])
 by mx.groups.io with SMTP id smtpd.web09.18493.1666614490913254581
 for <cip-dev@lists.cip-project.org>;
 Mon, 24 Oct 2022 05:28:11 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=cRLHH+2O;
 spf=pass (domain: siemens.com, ip: 40.107.21.66, mailfrom: sven.schultschik@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DO2sjHmSJOyJ/xFTF/BF1iX3jGvOGCdwR8ZEnW9LUWY9E0rlKMuLN5/KhOSTOTvKIsq8lx41GJ80TIzRZW8S6aUdsMWWCqo9zMyMjoE4jJTgM9Y+ne3Hn3NimWFN5vL7L5Le6YrXRgNXsz99E4sZgEPWjAYD+aD941eoXydbFfS9SHXyOCt7C4wBr+55wIA5qvFJETFch7Y43Yd3Y+2HtciWdmBqV5EF3tu7/cNpSo4S+WBgdVzuqHu5j8kKmtQuFG/uujpm2GDC5fhi8XSPuEw+rxZ2IL3CQTi7HcPkv3Cqi6pPtr7s14vwtUGD4GpXkLkpi8eVMt5mes5dGlpUoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8zk+4yOUuu9+tFXxoxaaNbSnCi/N6nQp+Mg5hdZhRMg=;
 b=YtubpWKygN7qt+jQrsF5b7o4AXuZnW7JIJv0yckFZecJIV64/cKh6w1jPp8ebiOwGawh8dT9NPYE3hm3ntmbFNNdCxFh06nLMx9JGejwX7m6XV3qm5PrcYzXaIX9Us4inLybbKDhvkwSWv+LhzvY75ZTFkt797rZGP4tinLdlsRCiCbRMJguDPcNf6whCt1paUP2faiqOvZJwjmjdhTUxZx5vuuBfRG4xVvDfONUUiXPv6FVGFrcKJaiiljUZO5rwAudLcwTZrCrQRE8hDYiFG5pLrwMK904bGsJfYUTouWhzLQwCC2wsOQddtTYQPOFV/LAOAz6/Pdq0rpxQWC7MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8zk+4yOUuu9+tFXxoxaaNbSnCi/N6nQp+Mg5hdZhRMg=;
 b=cRLHH+2On2PhHnD2zhlIgEP+kX49J0dOKbdSfm0eB+wfnWkBZmB4UIVbA4sS/aqrw9oJgsbkVqKDYh+V4knEEOUevOWDqlqhf9qy1Oe6gB5/l0w1R6HQGHLqD6c7JQTCUi0T3r3yXJQ3J/c96wO3+eoXBXWZBI9Ybs4wFcB4lngYuViynKz8hqlZGZUllzKzb6OB0w6Haxp1mBevhMxWIPgJuNOelnzPbACTDwBRGabmkQoCoyBZ4ByqRURkAdcmXKOfa6Ic4jzC8y35ccdnyf4LDlAXSMRn+cj1Dm5WhqWOKvTKqWqME8bosF4ruF1lrZdfKlpP7qgaHflm1TYw7Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:210::11)
 by VI1PR10MB3565.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.26; Mon, 24 Oct
 2022 12:28:08 +0000
Received: from PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f]) by PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8f3:9a82:c9ed:6a3f%8]) with mapi id 15.20.5746.026; Mon, 24 Oct 2022
 12:28:07 +0000
From: sven.schultschik@siemens.com
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Sven Schultschik <sven.schultschik@siemens.com>
Subject: [isar-cip-core][PATCH 3/8] Include optee into u-boot
Date: Mon, 24 Oct 2022 14:27:20 +0200
Message-ID: <20221024122725.383791-4-sven.schultschik@siemens.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221024122725.383791-1-sven.schultschik@siemens.com>
References: <20221024122725.383791-1-sven.schultschik@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: AS9PR0301CA0039.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::8) To PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:210::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB5037:EE_|VI1PR10MB3565:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d22f9f6-7d03-4f20-e0a4-08dab5bb34f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	XP/6ChrIrVf8nwTekGn5is/+QSklNXziMcgmGxWqfia/XR+lpwqaMN466oKZBq/F1dlnNK/F+G8Gmhgt3rux6qVO1DjszEGFcyqqXkNZhaZOX3lyRk2ZVNpRtSRaAVHBTtEjkRVEKOiBNLe50ahOiP6uc4iwPIvchAWXNCcHUKcq49e763+P5vA6/e2FDvzXoJwuB9/RjmllGG0rYR42trA2bxIoLVLfJiRoiPJr6sASLFrPPN/sUfwA/4JWzhZbUjlMtKP+v5deLn9Er0YR50r2pxKV0I5wchhcHf/0qZlbHNGXwvk19JBxqehrSWfTlsUs+rEv0QXhxBlXzIbEWRlNWgCZfuEYsMMPOrSMlHY2RefKWOj3gvj8juLb5SNELHM7LrP6iZvfAr+6hTR9xmOHa/ymwaptZUYp840vsmaAdUzZn0Z7RDNyyTBzx04op2jOv/Pne5oO+ygeR7Aw6lJCkUEL9MaIUNKZWpniDmFuqkzqprHDiv6lP9ie1TpL/EKk8bYS+Ktuf1bFw8lWTrbCpK1C0/ka2daCHIGas5dAbt66Ps4K2cEPQ8FA08xybIjZ20r2Ln6g/1Ba1xSod1fEuonBJJv2uvRUV34TkW7KBgNg/mdbtt4TgX7o+nk1S/OoUjX7UZFY/1r4xsIMr6pde9Ss+QRYw4xw2DNW/KpuGk4ZXM+9lX4GD6bfzVfXAsROrlfZoREhE6UvFAJgBw==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(346002)(136003)(366004)(396003)(451199015)(9686003)(6916009)(36756003)(4326008)(2906002)(5660300002)(8676002)(66556008)(66946007)(41300700001)(66476007)(86362001)(6512007)(316002)(8936002)(26005)(6506007)(186003)(2616005)(82960400001)(1076003)(38100700002)(107886003)(6486002)(478600001)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?caBoRHuW2kdflHs37UPlBJXvXSFT+wlvJ7sjik1amkXJWM0GrOpzGDPSc1u+?=
 =?us-ascii?Q?h2tk6uuNtZtD9pESklOV6GAR7Mmb6FUW4AGMN+TYaKUztfQTrqSJSVMQ/u1E?=
 =?us-ascii?Q?+QUdvXZdXM1EWrCBGCCDp+mge+FaxDXuym3wrmzUr3T7m+FMRGlAXQEb7rWZ?=
 =?us-ascii?Q?f8LV74Qy2bfnQTiM6WgO6Uu7su0cze0T1W1iJ4Yp/4r/lB3tZtev8aR/CQzd?=
 =?us-ascii?Q?OESrFhIPbdgsMNJptJUwbn60HLd57QPFBDI/4Cv/g6vnLjwXdVavdeI5IF+Z?=
 =?us-ascii?Q?UAbcaFLV1hMQaYDixG50MrsveHfTivJQ3YESQbLkS+ThpE6ZWbGrp+Dx+thM?=
 =?us-ascii?Q?3SpwJBRVISrdydjjRKNLD9zlpyBLMpT0vyr9db32LcCAYLc0YKuxm2mFZ7A1?=
 =?us-ascii?Q?yn1X5do8vIJt4WCF6ffqUPLSZ6wcVPEw367JNWsplaisDH/SRafG7NEbCmXP?=
 =?us-ascii?Q?S89cIPQyKBmsmQQZZrIpj9ONM2LKjPUIxQNKrLW2CnE/UwOIXd35UIPKk2NO?=
 =?us-ascii?Q?aguS9Xu6MVeRmQUvF2iQnRIT04TYvq45OYRgBc4A5fHnacllasDZmgXaUZA2?=
 =?us-ascii?Q?89zEysTDHcDDu7OQhySoGVkd1rMUxJ2ifmYGINenS3ycLFcnbQh1Q92QIaLA?=
 =?us-ascii?Q?Y7E5C3+9terJi3J64urlZz/ABONMR0UpGUevSbeq6D4iy3x5T3C6XDzV5uQL?=
 =?us-ascii?Q?9jUS3+RR210UgYS1xgl3/6GcIWFVZ4C7AHonGuCH3RDSMeseBzVLx2gSmpmb?=
 =?us-ascii?Q?oZTIKdBbQF0MyPJNJ8RZcayxhwu7xIh5qGIqLz42E+Vd08ggLRv7n39BB64l?=
 =?us-ascii?Q?j/wq4boduMs6l/9OfVAsR6SVzgkTdaUxSaCE70Ct3vMd7f8IQD7LK4Xj7vCj?=
 =?us-ascii?Q?sCDg+0t5rGDHHgYWDSNvMgM2DAOgCz9Y8xioE+90j6wGaI7Fs9yiTCMSlJ7G?=
 =?us-ascii?Q?JEiGxpaa9kBV3verGwL8wQx+ZfElwei7E9ChHv/eIFewKinDWkZ/vJKJAcjv?=
 =?us-ascii?Q?jiXV5aj8wXEcDsxXsETB+2XVmyrbJb1fv5GNrjLmaM/Ww7jyl07sovYu4921?=
 =?us-ascii?Q?LT4snR4ZD0pw446BVolYQ7kGj7ujhMDuh2YlEo2hTyj7pR50xqKw4ZRKihL2?=
 =?us-ascii?Q?MYNIEFiNNbDYoswDDMPWhAvhDZJUeh9kInhDw+bwXy2PKUXsAIHs9V80gjlX?=
 =?us-ascii?Q?urjQzkWaKRGVg0xpqHT5a9zNimc/xianl3nGvN36cLqhadkwkqTFGrpFiOoB?=
 =?us-ascii?Q?S97SlvwSOlgQbbS0q0bkpG7qeUna7ybMROvCi2dNGUiplJtXXqfFjyzjmrUM?=
 =?us-ascii?Q?7pcP14IukhaPHru/uXTD+Y7qjUHMsDR5B8SamsHy1nbANPczMrn57+CWcY+/?=
 =?us-ascii?Q?PdWHAzqBOgHLfMWlr6axCpSbsrED3vRAXMnYdkMU74fftYGkDiCHoGrbtiLU?=
 =?us-ascii?Q?/4F4RnhYeGBKXf4DUVw7/6u0mHpRVNaDxMD5fTVpCsJP2bAG38/Yn0Un8QD1?=
 =?us-ascii?Q?4Pjl8ELgEu8z8avvZdcJO9jfR8l0QHYpXHDXRri8qQln2ZOD8ZT2G3XQOSok?=
 =?us-ascii?Q?6mi2v3xfC/WBul0Y9PxOMwvp3yLrR3FTFcLXcRZ+muEwE/GFEsdCH6+NhEXA?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d22f9f6-7d03-4f20-e0a4-08dab5bb34f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5037.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 12:28:07.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYiBBbYoZvUY1o3hWnQexKALjFlLHFxbFdvcppOONxW6oTS26C1ceVL6MstsAtiwyvy3y99B/gLTCqM6ZFzdF3lUJGHo1U1yaXgujIiLt5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3565
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 24 Oct 2022 12:28:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9807

From: Sven Schultschik <sven.schultschik@siemens.com>

Optee is part of u-boot In the secureboot scenario to use optee and RPMB as=
 secure storage.

Signed-off-by: Sven Schultschik <sven.schultschik@siemens.com>
---
 recipes-bsp/u-boot/files/secure-boot.cfg.tmpl | 7 +++++++
 recipes-bsp/u-boot/u-boot-qemu-common.inc     | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl b/recipes-bsp/u-=
boot/files/secure-boot.cfg.tmpl
index 956dcbfed..8e6428238 100644
--- a/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
+++ b/recipes-bsp/u-boot/files/secure-boot.cfg.tmpl
@@ -4,3 +4,10 @@ CONFIG_USE_BOOTCOMMAND=3Dy
 CONFIG_BOOTCOMMAND=3D"setenv scan_dev_for_boot 'if test -e ${devtype} ${de=
vnum}:${distro_bootpart} efi/boot/boot${EFI_ARCH}.efi; then load ${devtype}=
 ${devnum}:${distro_bootpart} ${kernel_addr_r} efi/boot/boot${EFI_ARCH}.efi=
; bootefi ${kernel_addr_r} ${fdtcontroladdr}; fi'; run distro_bootcmd; echo=
 'EFI Boot failed!'; sleep 1000; reset"
 CONFIG_EFI_VARIABLES_PRESEED=3Dy
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
index 0a9a15a0f..802fc5056 100644
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


