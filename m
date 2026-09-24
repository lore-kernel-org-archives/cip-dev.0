Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212F5C9831D
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:52 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.43])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2959.1790237567856386127
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:50 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GoZbZHKQ;
 spf=pass (domain: siemens.com, ip: 52.101.66.43, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zCZkii2cu9BwyJhzqF57cP2/DXNvFDjJrVspIJyCOve54/UlUYx7ebpH+8ceHq7mDtiFg1l9U9PPnPn1b0OCCzby5L9+zr7EwP0pTnxoe+6VDmK5aadd7WXV3eErh0pZcdHT2m++gWZZA7MVC40YYJUqc0uY9ji3vlvI2+FmXgMYlSbdLzgp5qtxutJxtJWRvewwur3Du4xU9QXhdL7IKVu4EU6EOeXZCQCE+CWuy0af7zK+gNhb98nASZuxbMNs/4ekt5KkX7sQ4THfP970BwrCK2vGg6s8I9P6RE/5vTR+PGS7TOYiRGDIEK2KRQGFaUy2oG+XoQRXuahtFvnBTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=QN6/lQtNxG64YYvZ0TsqOkWEV5m5BdTynlN596TQ76MuL+4c6F10IIGuD1Ar5f6n+2d+1851rf+NzwueTbNpXcxnr3L/gRI34GhF3rCDsXBBXcW5rkPBYbYrUWSPrGPW4uzHoiZRhu8sHXPIsPxFRgbm7knpf5YMH29zgBtSlnqX3NHrpmdgZfwP10biZIuTpEcXyalrtZZ59zbxE9wko29fBnznkodMUkYKl2eXyqgEjiUXhupABzgkzj3noiONMCJ9wXo3hRCoN2cuhZUvOGgdFLrR/hd8AibIhyp1Sr14O9W9YQ3Kcu8IjGM1ya54CrbEvVfV3dVbC3dPbr142w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=GoZbZHKQQp+U4q+BbaVb+ZhORkTlc/elIPM+0Ni7cVw2drljlvTsRachjiRJEYynkiRzu5S4dyAgDFyt8hqdLEeLrVJEHPbZT5PeHJGdRWOb+NhZ2cJzdWiKlxjonc2r0hCwLAUNm9ZbTgMO5v6nmlgV2tHxTQFRjggDlWO0ITV3DACyYLc7EUzdxUIGAASQMzAPg/vqlRk6XO4UVVvGZAGyZFh6MtxVRkfn75GEPe1SSExSqVUR4jiKwMmQg+TttARDM5XPpwXP+u+7OE7yluTjGv8c2j0pPSGKBeKeYXcS/81EnCKD+L8HAm7mFBCUAmFVxauvz6sVTPJk9Fugjg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by DU0PR10MB7922.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:312::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Thu, 24 Sep
 2026 08:12:43 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:42 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 09/14] Add class for validating the CIS options in the kernel config
Date: Thu, 24 Sep 2026 10:12:18 +0200
Message-ID: <20260924081226.2844456-10-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|DU0PR10MB7922:EE_
X-MS-Office365-Filtering-Correlation-Id: ee802016-2043-45ec-249c-08df1a139acc
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|55112099003|18002099003|22082099003|20052099010;
X-Microsoft-Antispam-Message-Info: 
	LUxO20K8cnSiR4Y3gPQgRWlCpFSfj+bECiDmtXUp7GIY3WwKfhpHgAbO+3et7xKfSu33TrEWLfbMC2BPt2ZlPjmHcD65k4OerhYrKFF619zmc6OkG9Xn8wVAxzOtCoS8WJhFDLQl8O9rCl2WkXPw6vSm3YTluE5JoDOrgJ65HwuGXKltYSMLs1ZxVijJ1jBrzOpJ7txeMF0/b7OoikQSUNQZHIDuFJT/hAVMl8JWLeZ3DR8QQ/yYiA6rFhHeanBN/Rv7naHTjXCKNncfOFGVv+EOeaLN9eldIbBJc0NvhE1TclZ+7LxMHn8iE1oPTl4GIyDnSDg1hyPEiLxFgG+ZcfJ8rickuiqRiDMPGhshYvQPmWuHQMGSQ+7Z1le6R8g4RHBShceXOBSCBVP1ZSDvHc7x7FQINRl62yicyzHclhkSokpYPZk+2NO+g23fZACpwsGuanPE69ZSDWd8pQOkSrubR1yyxxN6JXCA3gIbeMo5PukjbIge2X0G0ldgmE/O8PiIu6kLpHNKz2u/G+FzxhS/fT7pdFc0X3QivURvcVf3zsx7HsbQYRfx12hTe6HkEdtSfGLLXL4OQN2bOTW1Nc4WaPnFQ4k7QrExVGzt40TfTGAy+FqmVxyw7e/MR3nu9qV+diHwELNXRHaGByHbXeseHpP7dJTZeB1V0oC3asM=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(55112099003)(18002099003)(22082099003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?InESS6KvRySy+/19rgaj9x3uizV9m3gdCYYZFXGGxbomV76MNGYHA6ZNLdnl?=
 =?us-ascii?Q?vFONp/+6vy20ME8srazFr/8I2Lwum+q4W+VwqCzEZ79y7avy/0RScSPfQoMO?=
 =?us-ascii?Q?gbHqArkTv5DmI0KPUeDueyFKUNG07gGk8LkbEMg87GWzIhq8UhWzd4Lmvrgx?=
 =?us-ascii?Q?PP9NiaJfha5Hc+pEkSHb6rtjZ4EI53Jmj38BVJiRI10RcxzE2rbX/Z/8YnJp?=
 =?us-ascii?Q?aS7rMTaVdMkn6VS4zilgR20ZZnAAKIV5CHiLOI5fworM98c3LiVI77a+wt/s?=
 =?us-ascii?Q?lCYlL6nUF2sYEY1LwmPj5f0HYD3gXQLBcEBu8Teo3iauY/SFiRn3gkXvLSff?=
 =?us-ascii?Q?ppatJAeaSLUZ9C+v7a7rUPKn8SxqVGT18K0DGqX5TbuHcWWl5b6RGThmV8X1?=
 =?us-ascii?Q?gr8D3oYJIp90w6VKmTupKTQYPI8BkRzvGVbDOF+xPoAZHu1T43LSn76WdKd5?=
 =?us-ascii?Q?xbUM2y6aFR7uTyp+lqRYstn7jWQreYVltax1ypjgVSkpA6GBt4ClsqXvAP+U?=
 =?us-ascii?Q?UAbhvDFwS3cqVEByXpmZqEWlhalD7he0E000L6TFfFCDCwXQH5sCVMaGR6gg?=
 =?us-ascii?Q?6pkDr1jcsoqdMm6V39BtFZfVNG1Ac71gKTCUtIQ5iBoYClybYe3hGFmmUXF0?=
 =?us-ascii?Q?LRaxtP4zlFKBH6ZfcdPsRlT/gpmPysUCLI80msBq9mbYu3bDhBuX82+t4LIw?=
 =?us-ascii?Q?IflKuHCIpdaJGZ6qaunhWvVxAiNNGM0jyhWDgwJpCjMtdynp5ZOWsJrm63G0?=
 =?us-ascii?Q?sD8P9cyUitimVBqKKd3B2jKOFrJZNLpq5t4flQWWTsZDlslJLOXXQuYuqwfn?=
 =?us-ascii?Q?0r14st8p2lk1G74PGSOk9Rd0lG0ZFoPrjCQpPpSeOQqGkVQ/xlXMXwe9CFvg?=
 =?us-ascii?Q?WP3oBnM/VOnAa54V9DIbaVr/zIE61zpMJOOyf2RldU0kJ0L9BsUBAWaRSmIs?=
 =?us-ascii?Q?3k4ULKB3whi8ytTZ66gX0R7gDSCuM3aen1bYcVcIxkdrvZ8gsNpp57eiaFfV?=
 =?us-ascii?Q?B/qjU/NdOGo/XtdwloHepcBbT9ngFYdBIHXk64WNqw9bl5qQjIuh+OF39/Pp?=
 =?us-ascii?Q?fJLv90t8vkoRbJtS+yqGayKWViWYZe12AOk4QQhKSsSq6eccZAEMovrFGu2y?=
 =?us-ascii?Q?/7/SbF6/DhjAcZS2YxptWbDl4qXuBgMgX1PYAkkUXlxTpOqcoRQfv5BYgYLF?=
 =?us-ascii?Q?xHbBp+afhIbIvnV6NblF96eUwb4CVxc9Upk8WhBpqHXnUTET0OXDjkhwvOKH?=
 =?us-ascii?Q?BGd+P73ormVit6j0RtPajzfKEdjXyjE32ZZ4kQ+TJBBYhLcWoqDKEaMb/0bh?=
 =?us-ascii?Q?nUdcS6++xx6PftlotSuoelb5HAO+fRXcPF5FsHCo0z3cZ+/J660vJoyEC10l?=
 =?us-ascii?Q?B3z8E1TWz9J0qeqGZHLo8/g7Zgnjw/sxWISM5ZsJlQGL5a7aMz+dU/LprpFs?=
 =?us-ascii?Q?P9U67VygB3A7jlhJ1fvCVoMpXkXpnAeur8KpEMpSEF9JvT8u8NHh9NNqUkST?=
 =?us-ascii?Q?DP3F8gS7i4tiv0uS8A6y8uR1tTTTDRWV4Y9Bf5jNpVGKjkTXseK9a2t5t/EM?=
 =?us-ascii?Q?BNRqW+zRKVCktnid4uurnzSGnPSEId1xzjK+/pLa3EwLe4hTA60K0KI1ulxE?=
 =?us-ascii?Q?q4X7YRqVweWAEqxaWgVAHqU1MI/H/nJvw8aPsPRz2UPlu/7qS9REkKif1bXB?=
 =?us-ascii?Q?xdOhmcqLxFA97EkzIwgq/Z/CdOXySP0EVodPEKQYkCVlwONpBARkpuDegxQD?=
 =?us-ascii?Q?yrriZVvhtO5qZtNQY759uMaluxVb3Uk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee802016-2043-45ec-249c-08df1a139acc
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:41.8047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kleZ5W0CbiikQswNywbYZG8ZKD4o+JkrkBiKnkL1ENeSn4D1LOvWI7TJ7U0sN+5vnUHCQnCUuaZJjkbtSbyjr8AgNVYT5BqFD3PTE/uA3SI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7922
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24299

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


