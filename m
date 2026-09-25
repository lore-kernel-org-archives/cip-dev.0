Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBA2C9832A
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:07 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=QHOrwwKP;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WkvrGNhJD9sJS4Pj0RdJijudy3z1y7NsEvvhD/XxV6ZpQNzWcoh1qgivNyzIvLd6JAzQMHgRoxrO7lHTSmUiU2ihQYAwSWEK2a5HI+Nb62QW1soAnGiN/ni9tsFzE1vf+KYobBjRu5RGoSV2sdFOJAupp90I2BvwrebgZbdQNKWKkG+kS2//jm7m84DEOqK9TUDARIPPYV7a+EsKpH510v+TPnAPwBTkNyi5dmEn3RcPxudzIBOpEdKmnNrVTKoTr9zouWWL3Ql51H/thd3whdPSCPXKAywPX9ElY6duSjurSJ1yMkB9KGl2SHbu6iGrd+rSDtPgG1QWat9nozE6yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=VHBhossf1W9ylwMhCnextRqLtLhjHcOKrNo8W6igPbKhj78cau+A2zzxzmKeyl+B6om/5VNjxAsyDJlicKwPhHZ/V8XOHbwnY+NDvUBPh4jz8r3tCQ73LcqfOTI8oPgcph1Z0HZ0RoF3E9SqPyYEwSe0O8Ng+HSlRl6+YMLTbV4SkGbHDLGunv90dkegGjENy3oHLEWfOH1mwrywPuEfrpbPlp7KaWhZMCLi7jNiFLXc+2y1PGu6kk9fX4KV2jlQ519x4WbQ0Gl79FrrXGRWtM00Tqk/h6gUjrO0+hQ55896sMRAnswk0wxETGK81lTxqmxJzYAQGBENOQX5MYSdxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywh+sIj0TmsZOkcGedOzRCTaaLO+AyumuaqHTWYSv5I=;
 b=QHOrwwKP7B5DIjYyig8qHS1HvNnk72ql3aO2yDwPtnu95fyXeRz/oipERhve8qjpfkFywgD20Z0zAANI6ZxWT00qSY1ubnINm5d8c67hQxv+5KozQoGXJ/92NMZeI6ltDiNuQ466yWzUHBOqJ491n6LcwREI0ekzTpLokpeJ5+SpeOYC5YIgbLyYIaYhIUR9F/qTGu7uHttC8NBuerAu67v7iEdA9WzBtTMVDmnKm/f0zWaev0WTEaBhGXL4uDOC2NSJWTxgk5F8Et661iyH9GXLY2L1h4ITmUH0l6DVdK0M8HQtT2IqLJ9wwwERjjdkWEqux0f/NpqatHM0ko1orQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:00 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:00 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 07/14] Apply hardening configuration to the kernel
Date: Fri, 25 Sep 2026 20:08:33 +0200
Message-ID: <20260925180847.622090-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: e017d758-0731-4078-40bd-08df1b30133a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|3023799007|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	qCz7oSktP/wTLOCwAcYRoWoXbsmpMX0pgSn3aBO+zxmoZE3newdA6NAUxC8sseHJUgw5mEybTSYwDuANMzfmHUE53p5Lv9cUj3sdgGyUHkKA4473kCOyV51JBEb1rrPzVsT3/QV+1o72V4xnH6lBt9kdXNOKeWnAcYnDxz4E7Du/K4+/VCPUX2rm3KxLVE7RDcwTK0NPLgEqI4SXtlnvtTLV/40rDYEa5IuRZJMXkbcuBFxEhlWQIQbJKAUosxCfL3lyNl1srphPZ3BEz95raA+HI9U+z/z2Qx82aMadyux6D/gaQ/E6/JX0aVzK80khfsZ8QaytibLNuc2Xy3h1lSYIScWw35mECzPviKUbtrdlAEtPatkH4avQD1wzt1A/9GOcUnoePZe/9tUyTeRFP9vT8vRN82cyLGzYa1sT7DPX0NFj4lqZ7cKBGFSK3iOAqUAM/gVMepOyO4XJ4YyVwPBIBTctxgF3ZtZst54TCUowqo75mS6a+m02WIIGM4OUMu5khEUM3fIeudZ0gwRvngageRm7OGEjVjmzUeGZNTZx/j6ng9rCdjiukyJBztR1EkCSl72kSPMstOt+nPc+Kp5YcSuXJBg6U4EI/iytGwMiqR7txEQEO4vBPnEE1DSyKU/XA6QkdzYLN2ZYdt8FtfwOerJmmfxbVUJ44dyPhGo=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(3023799007)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bZgCzaoIgAebKDOy6irEzkvloDr+t+wnCVyG9eVveQiAUlpZoIRQ3u6+Zo7f?=
 =?us-ascii?Q?sxGi1s8U2QyWGzgy8xZtVg1ngDEgoZXusK3dMEb2b/Lt+53jlTlvrSPVeb98?=
 =?us-ascii?Q?Nl3ljAjefgC51js+V+oSidbiyI8/IBNcB/CL8+R/o/QrbPaYK++lv9tL0Ypr?=
 =?us-ascii?Q?0hqYJIda8y/16VgwKwDtIn+IgF/y+u2A8x7Xnz2NG/YLwqMl45vYJegHvrL+?=
 =?us-ascii?Q?soJZ9xeHlFziZivm2NXkWWgV1awWweoGxncqMQAgTHhmkDYRcO6xo4Tg5Xdt?=
 =?us-ascii?Q?6GoO2wJ+neWEz4LdUlfKYdXMoMsNAKAM3NBZ0I+IDP3yBA4uNesQpWF8PG32?=
 =?us-ascii?Q?nVSD2PnVJG3h9Bz2gCqxlpdT3QM9pzSKQszSFrU2a4Dle4CzaI+pcCGSoV6n?=
 =?us-ascii?Q?rwvAJSpMA2VQQpOzQhhLn/QfakKQPGgdbBX71H1kAS9J4BlmIGv0eqHDhv/r?=
 =?us-ascii?Q?9Oj09Vk1ihhVJGC0WXuM3G3+zuNnBfqsoYZba8sA3wpFPHxDL6Do80CX0L7Q?=
 =?us-ascii?Q?RjKEXTIXTpA9QoCANgItuR9AtM9+5Ii9lwmALMxZaZDDVyjVNCgK8w87FaZW?=
 =?us-ascii?Q?uNWb8KozIj5rXoceHF9zb+qMAHdfl7sHTflN+m868SMwz0V5M12EaAFWO38q?=
 =?us-ascii?Q?O386VMABECHSU3DyEqT7SGDh58I3UR95e93sSXj2jLYnMwIlWPG0vGpz5Krs?=
 =?us-ascii?Q?76PAIDLFs07dMa4LofUGQPLGxlW04I5LTiZ2oEaNE4FM4so/qiMGmh79zia5?=
 =?us-ascii?Q?xXZgjyD9Sr87lJf6fbQQHiFKKgcPA6Hu6DNGIlcQj1W5Zrf8oiAmMil4vWTi?=
 =?us-ascii?Q?Q4yyvbmwqlTZ6I00ir/4BSFdwC+Q4bV686Em96Xke2+3VV/346a590YqN0m8?=
 =?us-ascii?Q?2YWkeBxO0hUgx92xpWHt9C6YL3vkyEX0BsTvDzdcK8hMNEFNTNAkddMdpgGU?=
 =?us-ascii?Q?hpM1U1MzsM7bnJN9uizMtB7TYWEnPusKjhJXS3mIuindC39W4PkTFH7N+3PY?=
 =?us-ascii?Q?OeCSz/8bPn0GSX+sdf7aYap4egwZOZzVX16dCKOVw22It+O/HgOGhGHqKhFx?=
 =?us-ascii?Q?NkZ7bteWk/YT4HP4JEqJpa8K0qbTwQeyB+qBVnyo74F5fCfaczRTX0Lltbme?=
 =?us-ascii?Q?h13eygdoY0B23awiaEOIfO1q3O1nuKuKPy8jjxQEIB7NWEBV5BiAa1hDblxD?=
 =?us-ascii?Q?ZKBqz6GT0JtqEGZY8Ej01Wi6/n8La7TOIIPpBOPSi030WM+Tp+WXX+X+VcgJ?=
 =?us-ascii?Q?A5ZmmpRIjPD/tIpq53XFUNajLq6tlCV/DB9h3iACsksv2750+oKR07wPmzsH?=
 =?us-ascii?Q?IAXqPcmZ/VfS4J8BcY0ZybOU5LcwFQx1iG0NJBB1emlBsD1kWXPW4C6s8x82?=
 =?us-ascii?Q?OI1t4pUxGyu0XuKVe+7YvS33v5zwZBXvw4IXhVc9UIxErJxYGU2LCvfiEP/v?=
 =?us-ascii?Q?v/2dMfG6Ce0frMnWIPo2O3TEFer5zoxI9E5z5AXgHvFJ0Umlex58cxzd1V8k?=
 =?us-ascii?Q?AYe8GtusoXsK5tC+8mn96nOC5C2DjeNXqWtmuuI1xr2hNtombBFyRI4XF9aN?=
 =?us-ascii?Q?eej44stR8fa4cflkF2C6CjvoN+K0IKFF7I2G0ajjP5/JzOCYWCp3PRJlskbG?=
 =?us-ascii?Q?FQkBpxL3bAgFg3qCVRJSVIEPvZ8LglDBJYktLmyaH3qka1A/IWSQF8yCut6M?=
 =?us-ascii?Q?ZRoO7lqmP3HmNkfZB0rlEy1AjToxaWYhDM+fsSPZIgn2ek1tD+goEHznxPis?=
 =?us-ascii?Q?PWrbDEc3U+LNCIk8rrE2K4uE7p1cKEk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e017d758-0731-4078-40bd-08df1b30133a
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:00.6171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yBQ+Cmfsd7n8rYtmLWp0DzNnVhiwlslUpmsoccnvuc/DDC817cH12MXYW/e4lmBo1Qfs3JfLdkuOGQO4csvlMjTNGE0drZ8prP+miuLZshw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24358

Use the provided kernel hardening configuration options in the kernel
build.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 recipes-kernel/linux/kernel-hardening.inc

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
new file mode 100644
index 00000000..9ad8f080
--- /dev/null
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -0,0 +1,16 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+OVERRIDES:append =3D "${@':kernel-hardening' if bb.utils.to_boolean(d.getV=
ar('CIP_CIS_HARDENING')) else ''}"
+
+KERNEL_CONFIG_FRAGMENTS:append:kernel-hardening =3D " hardening.kernel.cfg=
"
+
+do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do_deploy_hardening=
' if bb.utils.to_boolean(d.getVar('CIP_CIS_HARDENING')) else ''}"
+
+do_dpkg_source:prepend:kernel-hardening() {
+    cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
+}
--=20
2.55.0


