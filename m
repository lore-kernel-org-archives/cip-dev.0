Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69411C5DF69
	for <webhook@archiver.kernel.org>; Thu, 13 Aug 2026 10:39:49 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.41])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16113.1786617581341459718
 for <cip-dev@lists.cip-project.org>;
 Thu, 13 Aug 2026 03:39:41 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=JjoCHwzC;
 spf=pass (domain: siemens.com, ip: 40.107.162.41, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=awd27ycbWV861MjNgxG84MjrRIlRDma95paTvGFpRxXNmzQyamdIyc/5tVP8DrPcIYTR5zGpJh68aFokdVW2oYUim21x+S6yN4ILnLV+2mW7GwZhgz14VEUp/72t0AeHr6KAj6lrBodgzP4SqMSxUpRfa/uN+epfI1Mt5cyQnwMxG5yqGW6TILEUZHWEnA7ZjUPp9puwNpMPLYnWzZghv7O2SjmTwSz1PFFiexx9s8Ad3MEn/iRCsfyDQk38xmge5KtHEAXLuKVgH5SEL9lDdJycchQnoBGyozgP4MgAmI92TuvE5CwDW/ggJYaH2Frb4SsG0XxzwV4qjn6s2zafsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zG1juqiC8l5uRKPgWN2OBatvxjBLJxOn2C2ckVrVf+0=;
 b=dWq8plVNFlmFQRieEyi3kVOJmfnvwrTHJpvBMbsZlfmS6EWWM5z3q7hW3dzh6JpMU07ZDfiMmpM70IwIUHpC19umJ+0KlyScS5VpaYYopSHxWDy8URLMg/x/5PoT25afrVh/wiC8NosUzupC3+6+WWT01KnR6e0tf5I53OVzs94T9ij8VRUVtybvYjT8iGOf66q6buNHFUrQ5wn6C6iC0hCpQzudmZUvQ7uzXseZ43FikMyBX8gBp4ySQbcKsDFmxDkszCL0vKfkdZbKgA6dTl7hbckuQAWzHPXNTMLaTLMuxO8S53eHitERwhdlBVsyFXuuznHJLIyysddxO6MM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zG1juqiC8l5uRKPgWN2OBatvxjBLJxOn2C2ckVrVf+0=;
 b=JjoCHwzCXSEQ3ctumBrRC51P3BzDT80Oc3eGE6uvcCYc0gDo3P0rrgEV6h2AZ78XFyEjsFE1NgQHfT++fDBR0ktQcEURKqdH8i3DoJCq8Z4LGHQrFTl6YEF/qmXxAMnxKxXUMBFNSTNM8ps/eXfJuhaG/8dGoilQsHHIj3SuahXxvmmCn7PywMJbTiiNGVJtqjpBedCx3JIMuK9arO0tOJ2kiKhRa2+KQh+cnMFcT9Gtm+tkhKPKudx6elC9yfhXBfo6mZxgfI09jR9JmTYpaSYHjhJBpoN+TBcWU7cGN4wPxgfAGqMqkVZegEOBTWvi+v9Iok+n59N6fCfSgxK23Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB8693.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:23a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:39:32 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 10:39:32 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	dinesh.kumar@toshiba-tsip.com
Subject: [cip-dev][isar-cip-core][PATCH v2 07/12] Add class for validating the CIS options in the kernel config
Date: Thu, 13 Aug 2026 12:38:57 +0200
Message-ID: <20260813103919.184402-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
References: <20260813103919.184402-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB8693:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f185845-6b07-4412-90ee-08def9272906
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|6133799003|20052099010|22082099003|18002099003|55112099003|56012099006|11063799006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: 
	ymOkm88s3Dx1IVs8VC5TXW2RYdwXAdcgjYgNSOemCy5GYs1151Qilw25YIEIx0r9Uw7+SiGzXo9toZicvYaH8eIih0V3MElVEd95vUF5deL7TTIrQankulFYpjspPgGeAYFX35Sv9MG1rvJLUYewNxRsNnYhJYnZoxb+fwOJODaf4CR7XoblZOF7g8Vv4x5oC+A9hH9rBQbhRxqDIauNTpID9aNZkSTw2ZNe0fN9fEpcH0xb7Otm9Zh2ZF88NgB60Jc/lMlyBpJE85bLY9K2WplcUjTPvgu+QDL7Xkepf1B5DG8X3zBPbWlKrTlIBcIvaQISOAMV5iRslc4aeyWG1oNzfJtTSBN1ID6YkRuh2yTKTfW1cZ4XVGRSKUCCopvb8Gwd5mgNsdktkffitHZZAWBG33rIoC5Yl8wbCrhIY6CETSys2gqOoLqGRHKq8y77Qj/XE/u1KvwA+25kghwECLc267uGGvMm5ADk8PISrEExLWlApZOLj1E7vlT7+XAN3k3tIRORvtiWYp60bm6OwYoswGCkRkqpwZw32njiVjvUxEt9+O141IWjDzVhdW6ZJoQufw9VRMXtllZr6gaHDGMsac+15fLNIrZXVNfS8CfGsb65Rpf1MIcuO5LsEGQEbi4AJVxZySYpyIlEvabb1YUgqcRbY/qg3tlyh7qhrwc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(20052099010)(22082099003)(18002099003)(55112099003)(56012099006)(11063799006)(3023799007)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xyZ9l2E5vkdntEqqDFDsWSuWa+9ikVIehYFZOPgjQAHXzqZzcjac8RRfwO36?=
 =?us-ascii?Q?BLqwyAzWtF5VCrXspXY+jJx8XLzJyifbXqhHLFmVtsoZ2RmxyA2Qt5lLUGtp?=
 =?us-ascii?Q?tIR0kx6Cq56Qpp/aDj0XaAGHTOilYSwEY2d9FQ9CVr0reTKBMfcNypG+zah5?=
 =?us-ascii?Q?P/PhRHgdvBDr4BOTZksO9T9kqILqDmJee0cZGz3CcFaJEDIwRe/BkXEkq/DK?=
 =?us-ascii?Q?9osFfQNUAtjHGFKLnkUObeQ1e3I/aOLMG1AoeYJ1wM4sE99bjaHlar37tZhL?=
 =?us-ascii?Q?qaNCDT1JJ6TBTclgwx0/q/XrnQLH+XIUwoQ44O1Bq8n/a3JUZQ1Ir59QleqT?=
 =?us-ascii?Q?nM+7875RxWzW5krJVhpl1m3ZJflpaq9LAyA2H0Gz8ee59cxrtoPoP8QaLAdj?=
 =?us-ascii?Q?3DPSp7jP4csM7xIbXjH1nT2tAdVF0wVGB9Yf9lOzu7bcRDW0RkIpBMgVPI+G?=
 =?us-ascii?Q?vKbrmRv+ABhzS9Y6YutxofBDyK9bc8WT4bKTu5rui1UHueLs6X6bQv7ozIbo?=
 =?us-ascii?Q?fGo7AH9uaHb7yb7LXENbs28ScejqtJ0vvKC+c3qj47qeCoMyb1rNKmAekQKv?=
 =?us-ascii?Q?1HAKZ8DdIM57hYU7xmwzp50s9u6pAMh/GY6CttL5OK7y/9KHepYLFKmHE2fb?=
 =?us-ascii?Q?HdLHv4nIUfyQcuUqURJwdJjy/TsykJq7ua7JH15Hy+dxeRWg+jWLH3zdqOU1?=
 =?us-ascii?Q?+YBM7LxHDuO6JyejqplNvYZ1/KYKwKSCcCRIOMXURridm7FoPM5vkxOxHVvI?=
 =?us-ascii?Q?toaaEB2rcSHWePVSgHv22CNvlh6AOmXgYmiS0awumE5XWWC92/K5sUGYeaGh?=
 =?us-ascii?Q?yHZ5JKXF1LQVPwUrjXNXE6lPeLZappuZwA/j9PKdjZFZnXeuXqF7w7EWHZtJ?=
 =?us-ascii?Q?mt9QqFubRx5MwNgJYCUmno1rDbAc+2WuAIJUK1YqMoJdDceNUm9Ktdf+rrnb?=
 =?us-ascii?Q?zZjjG7VAjsSY1F7Sy49NsxilQUDSkFqQKpIIogm1qaEkqqiXnMhj1TOXAGWC?=
 =?us-ascii?Q?pmWiSb1fHj1yy7em2EI7nA278YTzGRKBQHYLmSSE+KkXTqI8Dm053wrhv7Rm?=
 =?us-ascii?Q?JC0rqxa7NccBoVM6hJmLrBPXmfL15eabDqDKug0Fs4QfGlN5i5fV/p6+G9B2?=
 =?us-ascii?Q?Ex4glkULO6F7HUboaGnfuS9AABMejDwrZe9T6G51et6GkOoduNP77fQxuzc1?=
 =?us-ascii?Q?EPD+FoYtHrp4XNq7vzdt+Dw6gQhH4NAOOhPiKns5DGSsHr1WYQ5Asm75yWiX?=
 =?us-ascii?Q?E4f31hmLbJJ7I8ovEQGEINcO7yXzJZznhdCibp+zrSTm/XiDT0GHGcn/b4JP?=
 =?us-ascii?Q?4FWS2g3lDjljeeT/9eQWpgbl5TtqcLn7MJoQYaTWU3MiS8GqACQN44VbLe4E?=
 =?us-ascii?Q?uSBfHGX0PjUuA/JKwKrlZskQOAlh1QVvbPx3BzCNSk0ZE1mvEf1oeYJi2pt4?=
 =?us-ascii?Q?sepF/cZhzwfKg4qG2PohTE/pHbQfamFi3q7aseH6UrWWBAXDYHrUle97cywq?=
 =?us-ascii?Q?14N7Xuh0GArew82G/L6WhfSoUyOwzCkbFHzsJ2/aAo+EfxBEBp0Hl5/xJmgL?=
 =?us-ascii?Q?UGMnvC3jPS/AJH+4l74yt/lXeD+EDB0EVKx0g2zHfKFZotr6ASC2flU+mwpf?=
 =?us-ascii?Q?N09VWvh/o9asmrSblpud/1ZLnBHSEeS0p03hf1RuItnEq9OMMC0f0UqEnb1h?=
 =?us-ascii?Q?GP9EKVkdtTrIn2nRKSDIg6JViYk38sxhxNLylnMj2Hxay1Mc+sDlPrpMvRro?=
 =?us-ascii?Q?2RSLAC+rUF96t0D+ZAKaOE1TvegODGc=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f185845-6b07-4412-90ee-08def9272906
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:39:32.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2HxYzcYLaerTWrPa9UlWrjEnrgVtMfXi07TGuiledBFkBW1riWxj2VaziSb1VwV9cKJjb6WIQSr+QTTlYg4USjdBRAb48V2hQDMA5fTkiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8693
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Aug 2026 10:39:49 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23926

If CIS hardening options have been configured that change the
kernel configuration, this class checks whether the correct options
are selected in the resulting kernel configuration in ROOTFSDIR.
A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
the CIS rules for the kernel options were correctly applied
(compliant: true/false).

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-kernel-hardening-validation.bbclass   | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass

diff --git a/classes-recipe/cis-kernel-hardening-validation.bbclass b/class=
es-recipe/cis-kernel-hardening-validation.bbclass
new file mode 100644
index 00000000..184da7fa
--- /dev/null
+++ b/classes-recipe/cis-kernel-hardening-validation.bbclass
@@ -0,0 +1,110 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# If CIS hardening options have been configured that change the
+# kernel configuration, this class checks whether the correct options
+# are selected in the resulting kernel configuration in ROOTFSDIR.
+# A JSON report is generated in DEPLOY_DIR_IMAGE indicating whether
+# the CIS rules for the kernel options were correctly applied
+# (compliant: true/false).
+#
+CIP_CIS_HARDENING_REPORT ??=3D "${DISTRO}-hardening-kernel-report.json"
+
+DEPLOYDIR_HARDENING =3D "${WORKDIR}/deploy-hardening"
+SSTATETASKS +=3D "do_validate_kernel_config"
+
+do_validate_kernel_config[cleandirs] +=3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-inputdirs] =3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-outputdirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_validate_kernel_config[depends] +=3D "cip-cis-rules-config:do_deploy_ha=
rdening"
+python do_validate_kernel_config() {
+    import os
+    import json
+    import re
+
+    deploy_dir_stage =3D d.getVar('DEPLOYDIR_HARDENING')
+    deploy_dir_image =3D d.getVar('DEPLOY_DIR_IMAGE')
+    boot_dir =3D os.path.join(d.getVar('ROOTFSDIR'), "boot")
+    kernel_config_path =3D None
+
+    if os.path.isdir(boot_dir):
+        for f in os.listdir(boot_dir):
+            if f.startswith("config-") and os.path.isfile(os.path.join(boo=
t_dir, f)):
+                kernel_config_path =3D os.path.join(boot_dir, f)
+                break
+
+    if not kernel_config_path:
+        return
+
+    hardening_config_path =3D os.path.join(deploy_dir_image, d.getVar('CIP=
_CIS_HARDENING_KCONFIG'))
+    if not os.path.isfile(hardening_config_path):
+        return
+
+    report =3D os.path.join(deploy_dir_stage, d.getVar('CIP_CIS_HARDENING_=
REPORT'))
+
+    kernel_options =3D {}
+    with open(kernel_config_path, 'r') as f_kernel:
+        for line in f_kernel:
+            match =3D re.match(r"^(CONFIG_[A-Za-z0-9_]+)=3D(y|m)$", line.s=
trip())
+            if match:
+                kernel_options[match.group(1)] =3D match.group(2)
+
+    report_rules =3D []
+    with open(hardening_config_path, 'r') as f_hardening:
+        hardening_lines =3D f_hardening.readlines()
+
+    i =3D 0
+    while i < len(hardening_lines):
+        line =3D hardening_lines[i].strip()
+        cis_match =3D re.match(r"^# CIS ([0-9.]+): (.*)$", line)
+        if cis_match:
+            cis_number =3D cis_match.group(1)
+            description =3D cis_match.group(2)
+            config_option =3D None
+
+            if i + 1 < len(hardening_lines):
+                next_line =3D hardening_lines[i+1].strip()
+                config_option_match =3D re.match(r"^# (CONFIG_[A-Za-z0-9_]=
*) is not set$", next_line)
+                if config_option_match:
+                    config_option =3D config_option_match.group(1)
+                    i +=3D 1
+
+            is_compliant =3D not (config_option and kernel_options.get(con=
fig_option) in ['y', 'm'])
+
+            report_rules.append({
+                "rule": {
+                    "name": cis_number,
+                    "description": description,
+                    "compliant": is_compliant
+                }
+            })
+        i +=3D 1
+
+    if not report_rules:
+        return
+
+    with open(report, 'w') as f:
+        json.dump({"rules": report_rules}, f, indent=3D2)
+
+    non_compliant =3D [r["rule"]["name"] for r in report_rules if not r["r=
ule"]["compliant"]]
+    if non_compliant:
+        bb.fatal(
+            "CIS kernel hardening validation failed. The following CIS rul=
es "
+            "have kernel options enabled that should be disabled: %s. "
+            "Details in %s." % (", ".join(non_compliant), report)
+        )
+}
+
+python do_validate_kernel_config_setscene () {
+    sstate_setscene(d)
+}
+addtask validate_kernel_config_setscene
+
+addtask validate_kernel_config before do_rootfs_finalize after do_rootfs_p=
ostprocess
--=20
2.55.0


