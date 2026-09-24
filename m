Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09963C9831A
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:22 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.44])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5834.1790249777502329221
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:18 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=XCawGkyk;
 spf=pass (domain: siemens.com, ip: 40.107.162.44, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CqRb+8Z7x5nvjF1gBijJGBNdYRY0qxqiDsPekmGs1ItYRuToAsghtGbV38PLsy33hlAAMZSEnzrPSNrDVY1mA8L+pHMT+hJXfwcqLQ9agCbb0i/ffas4elUpNG30D/HxnOPXh/+DBLmem4/yQBiarIMTG0HB526EgCwJQHihKPKNGv70ZSgYTVSXDJ1Sagsw2N5ctwqZuBc9LY9VmQL+KXAcq95DIbfFi4ACuGNL3wAyy7J6eTNbuOon3Tz0ZphoUW6hsp3q6DVovSW/VVIKI/4xn2YcX4epMqfijkIKmewOfetcExvLSgCazq9cm2lkSRgaKcBQO7Jo30GdWZuy6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=Tn3ARtvHVLM7NXhbVB67nHUmmlHge6+ql0NhSIOKA2A20pxziZztHKjLWPCZVCBJG3i1un1+SUzS51m04O8ii3vqOrRKWot6S+M982xgqX1J/RINgAuB71HTj9MdngvKnFB2FFbTk10Ti6ufQhYL6URCdf4F3ALfAjLN2NnUMyyI/JVwF/L7JPlZJ1JR/Og78bNnHKuN6N3NaQoxNIRr7F5bqk1Er+HykHPHjthl4Y9FjnzOTGTjjBjvbcoYtzZfwEk6VoawpGBcV+iXPS3UfrnMYKYoEU9GdApONxEjJJneRAsq+LEQcF7v3QuqUFQi2k9vR8sfyA3i2inhYvG/Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIqzh/WKPzm8/YxTA8mrEdTKTxdxsZ5ocV08fxlqR0I=;
 b=XCawGkykTE0GnJAI4G482DgdBnLIYN+mrNTfpZhK0XShCOGXw5v4lrDo2uveKLxGP+4Y9UwgHZRW//TMTWuBltQAKSEFwBiyZzZFItUbU0nnio3abZrjVblGhY17OaU7oDVfwelTbBYVg91t6Vxf/vxku8idK8xhhNbuMQOWkktpB56Qjf94EtXOM84Ekg7B26aOEoZ+uxUAzvKquIa3NCZeL9y4uympeLRKmv+Iidn2FAaSWxVUAFjseYCZxrTxIhCS4llOcplkFqz0W3U1L3c8z+ZxtiRS9p0WwoYbktvNTG+d1zrqqhjFlcFJpkDeMjEO6tWaY0VuLCGxwPD/fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:10 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:10 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 08/13] Add class for validating the CIS options in the kernel config
Date: Thu, 24 Sep 2026 13:35:08 +0200
Message-ID: <20260924113557.3191996-9-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e5ad860-8098-4e6d-c223-08df1a3006f5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|3023799007|10067099003|5023799004|56012099006|11063799006|18002099003|22082099003|55112099003|20052099010;
X-Microsoft-Antispam-Message-Info: 
	DGBrPEaqpaeVMA/N77ku/K/I+7nMx98+Dj6wLeVkOhWxl4A9/2wrNlhaQJ4iwEz4jlbTxTd4jTn/6jsoMgGL5XI2qMVJcta9zM5gcidfmHb0Y3yYdmMTfRDrVN8dn1xDqiWTwbH3eCFMhiMPpfl2wPrkoXCUpMzqpYUZ6iTHHm7EykIPTpKrL+vTm9adzNGaVfyasbA+sFuzDRkgYfbvHQWBPOWXObZwIYr61WSj33m71y0KywMUZc9XXKtvMi8WtkrnvtbOVZEgymmEnoVTyIiBlQT6hl/bwvj++vaLT6vl4sUotmPCZCovHU5T7diidBjqreZ2iFIc1sasKNYJKxvT6iFJ/NoJKXRvg+r4kKrEbXLzA0noxwt+awAXs37SP9Y8iOkwgz3CjtjepzkqQca29iF50WS/YQOgDrBLj8M7tQbgptMr9xJwk79NktfMqkzQ5h254cm6n7LxvVCMROM3lnpIg3VB5C4pl7Uz0Hhd/cIR8NBVwFKmJ0rCGEI8JXMbuGeN+RcRnTTazBDhIMo95ZA2jnBO0d6tTRb9A/PuHcX2ZycznpiMr/RhPKMmFSUKOZJn9ik1z73zkpRoCWULuB1yLkGY+gUv69GdJ2AkQlCrFbS82PE0APLJkvyzntuIwpKmEaRv64GuoiDHGQXGpQZteoVPdtYnFfjqTrA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003)(20052099010);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tRn30eVU2k8JtDrXLp5smWwJ5btCCB3LRmO4gXVzGsXSUeBA2j4XsaZmYDyf?=
 =?us-ascii?Q?G2mw4JWKr5+OSmCq6p/i4dFA+oUQsWUS1xvKP3VYYhgDIAzeLekLwVmBVC0o?=
 =?us-ascii?Q?A87X7mG+jQ03FTtp/QeDSm1wNKL9uCeubOhl29kQvGZx/FUiv+GALMmCX9Th?=
 =?us-ascii?Q?xUY7PR1aMxG4ncLUAFpXQEGmkmCRRMGeU8C2Xu2STPgh8apqKyppYJQq2Ry9?=
 =?us-ascii?Q?9gUIBaMzTmmWxVsJ1YT6BIq0CfG1jCa8Gv7DE+PgeKl0e6UsS7l4jQM8+IdC?=
 =?us-ascii?Q?jSg2NiQd16idU35uqnJP7Fp4ZP48a9OT6pfPT0MhBVppse0Cy7lHBMKnAfDe?=
 =?us-ascii?Q?+HmOI14r4+c4JdPfDHnPDILOEjC/LGXAN1PWFFojNbyKKje0CefQfYQ95FMj?=
 =?us-ascii?Q?L/q83ZosWkuEHGMMT/5GORGL7uNZAwaz/RgmKuwgPgE5oelni0Mapfxx8Rg6?=
 =?us-ascii?Q?JLUGSABJSwbi6zvWT5Xia7zlJS3tuLlgXXK5tTNNrO2LF+Bgh1i8atT14q+I?=
 =?us-ascii?Q?Cy3ZY3Iqqx23nuCNOGsin4DaMRcRst3STgNenL6qjQlvBxr+8ukoIyLfHSAH?=
 =?us-ascii?Q?3UCeudDFWvPhVLhvJKJ7HrXLk2KtafTEC2zWx2GnayLQ9VhOFPkEAonBGEDC?=
 =?us-ascii?Q?3m2KpT0CgxRnRJdvyMBZq5MDSDbuObokIYzZUhlDMuHoAQu5pufnwZJ7jzZI?=
 =?us-ascii?Q?S4c0i8WVhMfSbTGxBpOaDlt2v2Y1sZVQ5pF+u3iBxf9RSwVbaeaRNTUQz3/e?=
 =?us-ascii?Q?VvwxfIc5UqB5eg5qBZQvJhKHxq86ERnvTDVrDbud4zW/vfK4xtKep+2UcyrA?=
 =?us-ascii?Q?xnsgZRTSzxFhB+Iz35I4dbK3ZCgQZeSewYJ384KrPp33nuMREcBoXRKwUJC4?=
 =?us-ascii?Q?ZrrS23gkxax4LClVo41V4bGojYLIkTmbsoFy6sLxDv22jei0BzMmwJkatLh/?=
 =?us-ascii?Q?+XrMIxyeo4FijIHMjDgZig74SKxvdNjFv5nT4B7CTPXOkAYozRa5/MMzjP6x?=
 =?us-ascii?Q?EADfgaDf7NZoo0tP13bs1T9l7JAVjVs468wO5xCi0clf32AdUo/SuC71FFkc?=
 =?us-ascii?Q?FlmOcirdoj4OgbLxPbnc2JhqNYySO2qozz5VShP+aokqBkcUtN3NgiB92pMw?=
 =?us-ascii?Q?v+XgmAR0GEjqI7ASwjG6lQy7h6Vg9LkZXN23ReJ5Hwg0I6fWG4P6QMrmco2S?=
 =?us-ascii?Q?FER/Yll7oylMQ3zAScnmxbi6Rc1p2/R9uj1YypNVd14ReQK6eJHW18X8FNRE?=
 =?us-ascii?Q?j9RJZI3d2K+HcFBicKzrQ5/xFwncMzxDFJxDAwYskU8AoJuryW6HmRB6dnzd?=
 =?us-ascii?Q?vme9U3qzbArtj9fCwSP1RqA5rDlo420LG1I8VXNO+xKQi8tVRa3oBgY544B2?=
 =?us-ascii?Q?yBsFSUbbQfxGuxNO4NreViwenWzaO2pup8C7P07/4a5ecnehiqY70WUUFMOy?=
 =?us-ascii?Q?in/OnbUd0dhpueUvMYthMZ/hIJKG2GGQ2a0631fsxjAgIrRdbwVtrlWAjnWF?=
 =?us-ascii?Q?m5fpE+okH+6ywbyBUO75bXIEYybN33S1eaKZw+1yiPpm1Bp+rQ2+KECQYn2J?=
 =?us-ascii?Q?D665IiqJw4fjnZzde2Q8Et+aF6HtOmjvrTCWrcIlOcb9ZEsS9WDx58LRLeLb?=
 =?us-ascii?Q?89hKj2AfADrqS8K+vbRqRPpWTNNNHqwR06kD2T82zbEH/0FDJal9c5j3Farz?=
 =?us-ascii?Q?q4h0N4mOsNG5v/fnHiYOVmITr45OZjN5w/J2PTWsIGTBlRkFVBdes/qxJkMU?=
 =?us-ascii?Q?z0F+Q7N4/ykhU2hJw1qxiWvQ9V7v+cQ=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e5ad860-8098-4e6d-c223-08df1a3006f5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:08.8458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wINBwLnkPoo2YLAUUeIE6tCGNxXNXZymY53HpVAy8t6kxnJncZ2GAqgbxlh+guJThVXTo2e92RdbB+0cfmzasB2SAKoq+WlnnwFkrJf5vf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24320

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


