Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 981FBC9832C
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:10 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=jvtOdn5j;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+jsyq0aA0kTMCEZmCG9gsc8B25LIo7LvAl/CkMufqYlE/iWYbKAKu+Hv1tf8NWap9C8YismVuRYQ+x9pHY9qhglFA/lM2FEUzLOfNlHjVlC8TeNYWyyWv7Qn8H+bPFjArWnIP5O/55jfyb9ZHgW2CPQPud19aBOdiaIaogdcMPuyZo4u9DMUtV0/jlBG9lWsixyDXz+lY4o86qDu82FJyppN3flgV4ke0rlTchWGgUp1igQ95gvdNz1xENegy/Ex/9/qrFmWhI6cHlYR6Lhbk2lPBp/HUKuUjFROtgTAwdPVpaS4iwn7+L9qKEpLXVEWbqvlkseai+EcylM6cbfgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=l5KL7esslvPAJQ+VDi/5DUYcAYQRn+As0eauqtWK6LDtV8/pzNAi+1Ycg1rpGsX298397SMRBS07vBtgGqW5prm7aTcf8QbDliJT58GMTOko16EBSURtUn5A7mCpQmVS/cx6qqt2Yuxo8b+9EHD9we4pPw1KxukZ+E4Zh72eq30rW0/KB+woqKmtK31v+jiD3h1HTsqOObqsVnbH4bvo38j9xx4xev/2QOiKUeuX2HVqBIjJKcNMdp/qPa6PK/ZlaFuHPwo/+NQRcgLPhN+wDwcFsTddWj8mNVOJzgnLQEE77I6qkMkLfdDSnZwJmXJCAkf8/dQOLgDlsZOEeKZg+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=jvtOdn5jaL3y5HWOJLhXGEzT92/ouVnWJko9H1LHR5sGuxL2tPsbXsR2PIHUzV58U4mhR6n1/k5jF25PS7PrMrGYtPtFUJmX0DudZAB8qbnUo4EK9XCKBAWC+IMYeIqff6cMp4wOgfnAkPBbrpsuwBri+zajyopwwT/N9cTToS5gfQaWBqUwvu9bsR6cKq6EaT3OJ17w+dZbdq8N99e3d2uFbNt7qg8H/7DhZauWNhZI+hhGdWnkn7qU9wcm5jhwxC6+LxslJUOxgWl9LsNsl6wo0k3m30AMNTvQ77uGi5CYA/tHAJS99mMFUMEkKwaPAZVaDp1+7dMAoqqdEjm8vA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:09:01 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:09:01 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 08/14] Add class for validating the CIS options in the kernel config
Date: Fri, 25 Sep 2026 20:08:34 +0200
Message-ID: <20260925180847.622090-9-quirin.gylstorff@siemens.com>
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
X-MS-Office365-Filtering-Correlation-Id: fc5a1713-65c5-4cec-fdcf-08df1b3013b6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|20052099010|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	McNUmdsX7B9+p7IwQ3FBCgVb9930LS6uEUuw664Odua4AvlY549PCq7sQJBq88QSl2pAiugC2t3w+laXdrqkDFJNNc5hbS4jISALXP1r26HR+/BxPFJ1dPv08jlwX+kr9ejbZZjrccVzgymFnmD/SThGgpvEtkVRObyhdNNzMhdCrYj6uHVTRQFT6r/lOghtqGrnvy0w8gH891d7xqK3XcF1w2hBFeWA2e555sW7MMRF4p20DStf3le5z53SIQDWey6sfwEE6hYRpw7vI/bWmumvK7WDaaNMMwveQ2MAaY/AustsSrBhmwthVX6CoOz4oVgqB2K9VL+z/+k2W2Y9mwHc9TEKCIoHAuSmxz+aCAeniI2ZvJhILrFq3ibOPL0Hzb8gpnnqcgmfB00ifhIIgFNBQ2pIiNTFPN8NtMcjp6zgzhrTTJ6SKVEPDTI1bOxG5EnfDeAsrvMZy1j3hmIdBd/EO59ep8rd7iIzy/OeUpx85E0udoRgYaxbqnPdZXmfHyPLHR/unZE6v9QgeqCXAjsSQcQu3og65z4j2eEXqLk+KH0vhFXf2SwuR9TNTULg5Bx6RCaqtI8r6lrm9dcDpRiE1m0wWc+Kom54n51iBK5J07xFctd8hupQYE7OUIu7Aeodv9VLWvO43AqdeYuMyfP9cLvDIUcdzedVsoHxvkw=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(20052099010)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?xogpUYZVBkBOoGXuRWh3BwRvx4bjLPTY2FloJ//IW1rO5vuguUHmhjxNECXz?=
 =?us-ascii?Q?fmqApnLnYvlVt4zYgh4OR51nZdLwigk3rxnzPKjznUgwa4Qj4zt1BJDWO9Jo?=
 =?us-ascii?Q?8IMx+6cSTPNQR14nAlN4qGxsUdNLVY1sFaztEc+WS+eYYRTjUdDWryAQcyhB?=
 =?us-ascii?Q?rM7MOEpMsQ4qjfY5fmH4/LGLVNqjQdFDl3IPWL4L8M7fTcqjaaOgsLR56YW+?=
 =?us-ascii?Q?/mn1rNMj0UvdtB/cV3qV8R3pEv+1r0oGTJPn+EGUmlQCfcJDully7BC9yIAg?=
 =?us-ascii?Q?mVUvy7PdnGacWKuW8u2L4Ka9pBxw3YoRZHzPOtepxnzpD4cJk4oQN4GvLYG4?=
 =?us-ascii?Q?pMIhfzDxOqclNnIT9tfkykoQZoW1IvuU2iONDJQWnJou5NjR74dCoVe+rXhi?=
 =?us-ascii?Q?8NjTOFW/TZvf7Iuj/novt44w145O2xB28XnHOsWAQ/Cnd9Idi1nwiXJhFmv+?=
 =?us-ascii?Q?XPRtUM+55LOt6DHuRGJkBNzc4HaQE0GqHTuPa4xFUHpIxHasrDvopg5L0IZ8?=
 =?us-ascii?Q?ov3uaUlPzxHSsCVeYsQUjH6RYOTjAwFJlE8+PqFbusc+4Rn5qn8Y3Lz201Ib?=
 =?us-ascii?Q?9kWaGE2rOe8l8nRT0uzQv96Y4lhhTbFhmEVkfM5wAGfZK0Jq2u0zF7heQH2E?=
 =?us-ascii?Q?nNtoaAeEfqdK6/gHyphAtju+D4KAtcrJFCGtskUjm/WeyKkO0dLFG24tKQBz?=
 =?us-ascii?Q?xNg8WAa8YDyWPeTfz0lUrtNgnbMfm86ahB3uZSjae6XibAAcAD8uxYeeOOB9?=
 =?us-ascii?Q?7diggCXeGLiYcv/mmhVs61SSOMJccTcxEwjfB45cPl+IbQT7hvcYj96sYFEA?=
 =?us-ascii?Q?v0O1BAjRs+x7mlozrGxMuBmHdafFS3otHsNvo/Hz2GcsZLyg/aU63eE16GoU?=
 =?us-ascii?Q?OQaMCDDI9z6bfnNCf6q9Y1DZX+Xre0eauPG75F5r01/yKBWhpCaxfIiENaA8?=
 =?us-ascii?Q?4Ux/A1NDgBccoJw6E45x7GsQPQezHf/j1MhVzs50XgojCM5dd8tNIjwwnt/8?=
 =?us-ascii?Q?uYeA/bnJXm9HcTiLU2KnRfG9dWagelR9QXJ1V4PsapOJZRcO5mG2JD/palLi?=
 =?us-ascii?Q?dUDDQWIrvTh3oDFj4IdLrC6t+hzd2CfM74Gs7G6Ildb6UUEIeObJIl7gqdyf?=
 =?us-ascii?Q?P19YoClixhyxDcJ1t3ULgzOQzl5pHPEqkuB4/uGFgoKsS1rVudczvgaZDD05?=
 =?us-ascii?Q?I1eqXQbczrb1UQ2kkdckgfqginv04Tp4yxJG8/K0LLLxXa9nWVqIl1NWxUpo?=
 =?us-ascii?Q?SYXohPvLdCpfiIFPbj0nnbMVHYwHi9rojaKlkD1evoAQne6L/Jni6k5dSmfx?=
 =?us-ascii?Q?sK+LV0l2N6nznYTMTgPYAoUK9GVQcgwBJ2pKnKpJmmnDgtBJarh7y6qtu+Rc?=
 =?us-ascii?Q?IhB8tk6BvN8Bijs3SU2/BbaooXfXrZYJuXDgErDxHdCn6O5XpTHTD2fASBBx?=
 =?us-ascii?Q?9wtrYRHFclvMq1aZBpoQVMeqUMSSwRgYp2F1Wq306vFNdWk7STA7e0jjrgBz?=
 =?us-ascii?Q?REaxu6lLdMbYTiAmKPv6YbygLvv5J1I/q+wB1D9Ev7nIKSh5k+z4kBKLBA+c?=
 =?us-ascii?Q?GZrUCMMfIVWIh0UUwNv+cXmX4dn3iFe14KyiJ1ycp8Ogw1OlsHDhZD81c7eG?=
 =?us-ascii?Q?s6j7AK5kHzRWUiELddOL6NdiQ61l4cplq2ukyNbJb5sxhpnAlrTnxvBMkcFT?=
 =?us-ascii?Q?WqKkKO7qiNbhImNr8sjvXNti8fCxWjf5h/4WVjgjYCKmV2r7D+LuLHVqEM1Z?=
 =?us-ascii?Q?StcSXc5ihHVR3cHaH0nxiYuibMSe77E=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5a1713-65c5-4cec-fdcf-08df1b3013b6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:09:01.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: odGfmXZIjcR4uKnMMsx5QrypBbaIQSO/bvRUt++eDs374EBsDHZZoWhyjRtBWuTTDbko56YAMnBO/Yj8p0PQ+cbGNMrt1dj+cBuLcO0k6tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24359

If CIS hardening options have been configured that change the
kernel configuration, this class checks whether the expected options
are set in the configuration of the built kernel. The configuration is
read from /boot/config-* inside the generated linux-image package, as
the merged .config is not available outside the sbuild chroot.

A JSON report is deployed to DEPLOY_DIR_IMAGE indicating whether
the CIS rules for the kernel options were correctly applied
(compliant: true/false). If any rule is violated the build fails.

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cis-kernel-hardening-validation.bbclass   | 260 ++++++++++++++++++
 1 file changed, 260 insertions(+)
 create mode 100644 classes-recipe/cis-kernel-hardening-validation.bbclass

diff --git a/classes-recipe/cis-kernel-hardening-validation.bbclass b/class=
es-recipe/cis-kernel-hardening-validation.bbclass
new file mode 100644
index 00000000..165ec9c0
--- /dev/null
+++ b/classes-recipe/cis-kernel-hardening-validation.bbclass
@@ -0,0 +1,260 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Clara Kowalsky <clara.kowalsky@siemens.com>
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+# Validate that the CIS hardening kernel config fragment generated by
+# cip-cis-rules-config actually took effect in the kernel that was built, =
and
+# write a JSON compliance report to DEPLOY_DIR_IMAGE.
+#
+DEPLOYDIR_HARDENING =3D "${WORKDIR}/deploy-hardening"
+
+def cis_parse_fragment(lines):
+    """Parse a CIS hardening kernel config fragment.
+
+    Returns a list of rules, in file order:
+
+        [{"name": "1.1.1.7",
+          "description": "Disable FAT filesystems (FAT, MSDOS, VFAT)",
+          "expectations": {"CONFIG_FAT_FS": "n", ...}}]
+
+    A rule owns every config line following its "# CIS" header up to the n=
ext
+    header.  Rules that carry no kernel symbol are dropped.  A repeated sy=
mbol
+    within a rule, or a repeated "# CIS" id, resolves last-wins.
+
+    "=3Dm" is accepted for completeness; gen-kernel-config.py only ever em=
its
+    "y" or "n" today.
+    """
+    import re
+
+    rule_re =3D re.compile(r"^# CIS ([0-9.]+): (.*)$")
+    disabled_re =3D re.compile(r"^# (CONFIG_[A-Za-z0-9_]+) is not set$")
+    enabled_re =3D re.compile(r"^(CONFIG_[A-Za-z0-9_]+)=3D([ym])$")
+
+    rules =3D []
+    current =3D None
+
+    for raw_line in lines:
+        line =3D raw_line.strip()
+
+        match =3D rule_re.match(line)
+        if match:
+            current =3D {
+                "name": match.group(1),
+                "description": match.group(2),
+                "expectations": {},
+            }
+            rules.append(current)
+            continue
+
+        if current is None:
+            continue
+
+        match =3D disabled_re.match(line)
+        if match:
+            current["expectations"][match.group(1)] =3D "n"
+            continue
+
+        match =3D enabled_re.match(line)
+        if match:
+            current["expectations"][match.group(1)] =3D match.group(2)
+
+    return [rule for rule in rules if rule["expectations"]]
+
+def cis_parse_kernel_config(lines):
+    """Parse a kernel configuration into a {symbol: value} dict.
+
+    Symbols written as "# CONFIG_X is not set" are simply absent from the
+    result, which is what cis_check_symbol expects.
+    """
+    import re
+
+    config_set_re =3D re.compile(r"^(CONFIG_[A-Za-z0-9_]+)=3D(.*)$")
+
+    options =3D {}
+
+    for raw_line in lines:
+        match =3D config_set_re.match(raw_line.strip())
+        if match:
+            options[match.group(1)] =3D match.group(2)
+
+    return options
+
+def cis_check_symbol(expected, actual):
+    """Is a symbol's actual value acceptable for its expectation?
+
+    An expectation of "n" is only met when the symbol is absent from the
+    configuration: for a kernel we build ourselves, "=3Dm" is as much a
+    violation as "=3Dy".
+    """
+    if expected =3D=3D "n":
+        return actual is None
+
+    return actual =3D=3D expected
+
+def cis_evaluate(rules, options):
+    """Check parsed rules against a parsed kernel configuration.
+
+    Returns one entry per violating symbol, in rule order and, within a ru=
le,
+    sorted by symbol name:
+
+        [{"rule": "1.1.1.5", "description": "...",
+          "symbol": "CONFIG_SQUASHFS", "expected": "n", "actual": "y"}]
+    """
+    violations =3D []
+
+    for rule in rules:
+        for symbol in sorted(rule["expectations"]):
+            expected =3D rule["expectations"][symbol]
+            actual =3D options.get(symbol)
+
+            if not cis_check_symbol(expected, actual):
+                violations.append({
+                    "rule": rule["name"],
+                    "description": rule["description"],
+                    "symbol": symbol,
+                    "expected": expected,
+                    "actual": "not set" if actual is None else actual,
+                })
+
+    return violations
+
+def cis_build_report(rules, options):
+    """Build the JSON compliance report for the checked rules."""
+    report_rules =3D []
+
+    for rule in rules:
+        symbols =3D []
+
+        for symbol in sorted(rule["expectations"]):
+            expected =3D rule["expectations"][symbol]
+            actual =3D options.get(symbol)
+
+            symbols.append({
+                "symbol": symbol,
+                "expected": expected,
+                "actual": "not set" if actual is None else actual,
+                "compliant": cis_check_symbol(expected, actual),
+            })
+
+        report_rules.append({
+            "rule": {
+                "name": rule["name"],
+                "description": rule["description"],
+                "compliant": all(entry["compliant"] for entry in symbols),
+                "symbols": symbols,
+            }
+        })
+
+    return {"rules": report_rules}
+
+def cis_format_violations(violations):
+    """Render violations as an indented, one-per-line block for bb.fatal."=
""
+    return "\n".join(
+        "  CIS {rule} ({description}): {symbol} expected '{expected}', "
+        "found '{actual}'".format(**violation)
+        for violation in violations
+    )
+
+def cis_kernel_config_from_package(package):
+    """Read the /boot/config-* file shipped inside a linux-image package."=
""
+    import subprocess
+    import tarfile
+
+    try:
+        unpack =3D subprocess.Popen(['dpkg-deb', '--fsys-tarfile', package=
],
+                                  stdout=3Dsubprocess.PIPE)
+        try:
+            with tarfile.open(fileobj=3Dunpack.stdout, mode=3D'r|') as arc=
hive:
+                for member in archive:
+                    if member.name.startswith('./boot/config-'):
+                        return archive.extractfile(member).read() \
+                            .decode('utf-8').splitlines(True)
+        finally:
+            unpack.stdout.close()
+            unpack.wait()
+    except (OSError, tarfile.TarError) as error:
+        bb.fatal("CIS kernel hardening validation: could not unpack %s: %s=
"
+                 % (package, error))
+
+    return None
+
+SSTATETASKS +=3D "do_validate_kernel_config"
+
+do_validate_kernel_config[depends] +=3D "cip-cis-rules-config:do_deploy_ha=
rdening"
+do_validate_kernel_config[cleandirs] +=3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-inputdirs] =3D "${DEPLOYDIR_HARDENING}"
+do_validate_kernel_config[sstate-outputdirs] =3D "${DEPLOY_DIR_IMAGE}"
+
+python do_validate_kernel_config() {
+    import glob
+    import json
+    import os
+
+    fragment_path =3D os.path.join(d.getVar('DEPLOY_DIR_IMAGE'),
+                                 d.getVar('CIP_CIS_HARDENING_KCONFIG'))
+    if not os.path.isfile(fragment_path):
+        bb.fatal("CIS kernel hardening validation: %s not found."
+                 % fragment_path)
+
+    with open(fragment_path, 'r') as fragment_file:
+        fragment_lines =3D fragment_file.readlines()
+
+    rules =3D cis_parse_fragment(fragment_lines)
+    if not rules:
+        if any('CONFIG_' in line for line in fragment_lines):
+            bb.fatal("CIS kernel hardening validation: %s contains CONFIG =
"
+                     "symbols but no CIS rule could be parsed from it."
+                     % fragment_path)
+        bb.note("CIS kernel hardening validation: no kernel-relevant CIS "
+                "rule selected, nothing to check.")
+        return
+
+    pattern =3D os.path.join(d.getVar('DEPLOYDIR'), 'linux-image-%s_*.deb'
+                           % d.getVar('KERNEL_NAME_PROVIDED'))
+    packages =3D glob.glob(pattern)
+    if len(packages) !=3D 1:
+        bb.fatal("CIS kernel hardening validation: expected exactly one "
+                 "kernel image package matching %s, found %d."
+                 % (pattern, len(packages)))
+
+    config_lines =3D cis_kernel_config_from_package(packages[0])
+    if config_lines is None:
+        bb.fatal("CIS kernel hardening validation: could not read a "
+                 "/boot/config-* file from %s." % packages[0])
+
+    options =3D cis_parse_kernel_config(config_lines)
+    if not options:
+        bb.fatal("CIS kernel hardening validation: the configuration in %s=
 "
+                 "contains no CONFIG symbols." % packages[0])
+
+    report_path =3D os.path.join(d.getVar('DEPLOYDIR_HARDENING'),
+                               d.getVar('CIP_CIS_HARDENING_REPORT'))
+    with open(report_path, 'w') as report_file:
+        json.dump(cis_build_report(rules, options), report_file, indent=3D=
2)
+
+    bb.note("CIS kernel hardening validation: checked %d symbol(s) from "
+            "%d rule(s) against %s"
+            % (sum(len(rule["expectations"]) for rule in rules), len(rules=
),
+               packages[0]))
+
+    violations =3D cis_evaluate(rules, options)
+    if violations:
+        bb.fatal("CIS kernel hardening validation failed for %s:\n%s\n"
+                 "Report: %s"
+                 % (packages[0], cis_format_violations(violations),
+                    report_path))
+}
+
+python do_validate_kernel_config_setscene () {
+    sstate_setscene(d)
+}
+addtask validate_kernel_config_setscene
+
+addtask validate_kernel_config after do_dpkg_build before do_deploy_deb
--=20
2.55.0


