Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5448FC9832E
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:11 +0000 (UTC)
Received: from AM0PR02CU008.outbound.protection.outlook.com (AM0PR02CU008.outbound.protection.outlook.com [52.101.72.22])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4498.1790359747804930283
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:08 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=PmLjQOr0;
 spf=pass (domain: siemens.com, ip: 52.101.72.22, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvsO8RSybLeU6XHER4D1uhGNnNu5YCcGL3zuAlS+XjxHTg0L5PyTLXORyRK9Ed8SDplOLE83Vi6tsUEyYghtqNmHwayJXXZejkRqVRlHl8ma9c8P0hgI5k4UTHtv5+L4ekavr6yb5Wp4J6zWL4QLrX/SmzDcS67skrhe6ShpLlxGFRZ+U+CDi4d85SjZUizUTp3x3zhuHT8wnu0kP9asSA8/bU2XcwsalEBpBNpCq5DJ4I7RxUnSaBmQJyiVcpqzlwo/kpolD3xAisTzAGqkqAgaNBUwpunjTEwSR29jK2pLttTWhddNJ/3owo3oGBYjHWbwQGVdupavOm1mjpW8jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3b+vnMEpg9hpdfqj9wFRVfPygB5UntsfoXCbCiWvD0=;
 b=YGjhTeaIpzsYPuKrPdAnTE00dCjQy8cjF9sHiAnAkSUMvZJhaXyX3bkm2bXPk8VEfgspkgsOlEbpEfLoBWm8lLWalGNN/SD2IkUo6lyVmQCLEvcuYgRexiCSKDvfKdrkv4tXxH8mpyh5weKfXvKS0AP3KBSaFSiRn9K37MFH21OtZn9Etmco7bo8B7VdZH+CMCt0YxoPmk+REBy9+3P+QVJEXJV2/Ntf4cv7fa9D2/u1hU/eEWprVUQf3Z3Q9ZBiYeKPpKnWLvuUr29Uk59leB/VpWhVw9zDHxKVuURJ82DfmKYvuqd2QWIGHfrWuUkn39gc1Y41SXB2tTxkioW3WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3b+vnMEpg9hpdfqj9wFRVfPygB5UntsfoXCbCiWvD0=;
 b=PmLjQOr0UFUt5TxrKmQNo9wiNNKMSFipQFnB8IDlyTmE9w2RXl24SOe38J58D7aa0Imc9j/7Y0/IHMHNfBucYBC67E1i3S4LUgeaU/mZyCMUi7+7GnXdQM1KVXc0736n1+7ms731lxz8edn8gZzjfw5KWn/5taVl0CenOTOEfI0OkTktHK90CSxURKK1mui5w08E6pevSnitlR8TKFCcYGORbZFuzhiwICgsTKZuqiG900pcMPpCOFQy2MgrYeOlLKqhtlH8V4X1KIAhDCKqMiC+DF99//NBUFOak3g9jFuqL98/anrs4FfD0O3jDiZGr21BltJd33nFmBQTOKRjFQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:59 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:59 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 05/14] Add cip-cis-rules-config to configure the hardening according to CIS
Date: Fri, 25 Sep 2026 20:08:31 +0200
Message-ID: <20260925180847.622090-6-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: eec62f07-ea84-47b2-3847-08df1b301241
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|5023799004|3023799007|6133799003|20052099010|18092099006|18002099003|55112099003|17056099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	zUaae4lq53cO5xSnVADYDUgzjORKRCqyAJGqMjU1l0UjbYhASwDG6y+jCiqKvYV0vK+6HlURE5ABy6gSL1vO8b7NaHbjIUeAnz/0msAuF7Ymq/4xQxwb5+JqFdB8rjTMEx65kr0DQG473H+vceFhOYczqJjfbVBNViMOepkAo27AI2BkymNq7V8kW3Ea6fEsJyb1A7k897T/5tjEKlthig5w+PfXFelH1C68TRRpZJSPcbEW4NEsiGrlcWacU47IAvk3MwGSJLNK+TipQMq+kMWi2GG9SO9t8DlwmYjW5ZgPxic5Gs7LO0okkV+yaBwZmo4LxmZEMhPdb+R6idNWuOM/XkhQzJi+C3WlcKQDbVhfmS7JRG/1/GzvNYFu6sjkors5z/VyTa8PgT7DmdAz3vppOryg8GjmkeRNJ6T7oGyYc8J3Bi6koZQiRyYsAW0qJsD+p8ikZBcf7NxSSikMKXV+BFFGiSyZlVkUFLm2+YxGuZ/ejNp6u7Vwl2+L1htuyaHKosEey0XYtW+c4gQGEcyl5sGTnc2oXEjqT4wV8Ez8z8+G6WRm8jCMsOM7cxlS/Rpv5DvOVYJS/bt4QsT6q1oosjH4LmrPcRom9NqZUY0qjwA7fyXbSww9Hqgvqtfr
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(5023799004)(3023799007)(6133799003)(20052099010)(18092099006)(18002099003)(55112099003)(17056099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?FV0nbGL/qAlJ6MyXaFs0ZyATSAwNGqRdlT23SY/mFJyfy/QP3KbNPf7FjuNw?=
 =?us-ascii?Q?IVDYuTzj19kxJdYSWI9KH96zMxycBz5ahnIMohawhkYdofNnE+oid7ds+wJn?=
 =?us-ascii?Q?4QNcblDk4dWiy1+9Rbzfuwgg6Z8Y+MRmd3NdSUV5yGsRiwrAvcOjg9fBI3ri?=
 =?us-ascii?Q?kOpBLomrsh7Qd60aZGH/Yw/ZXi2hhcBcXhopRhGKWWFbwJgNpOTu89Lx7bPc?=
 =?us-ascii?Q?obzcZDBzUVRWJ4lZZjpXQ3KNU07Mva4Lh8DFx/FhzYYDLD3ylK14djzc+mH1?=
 =?us-ascii?Q?3VszgO/b/Fla1wMrno8sV63vd76i1sn/BrhnCWpgVIzyNCnN4R1feMAfZ4Ff?=
 =?us-ascii?Q?Feeqjxl8z6AqEpLfMCexXA1IpLxBDUUi6hchAT89KTJe22kpbylluoTGPOFi?=
 =?us-ascii?Q?LL7FGa2+FnCKcthYfxs8WTXTBbuib9cwL87zimY8yDqt6ESGyyFPa7ALXhRl?=
 =?us-ascii?Q?DFeChQBFvENehsY5uS1InnCre2kA/ZX9X63WDJanX1E1uYEqExLQKc5USe4G?=
 =?us-ascii?Q?l76RmzeY/kDVvid0agLQ0jisFipn0DAJH9UFCJH8LsnQwhS6GUs6XIascvLW?=
 =?us-ascii?Q?HtZhscS5hlsMsveQsDj4D08XME0TBqtUMU6GkxKbf1yGJz/khsW7G61uUxC5?=
 =?us-ascii?Q?2Ulx+bZDqZeucJtlne+XM5ib3XpOvwR4c+4hY/otnUoM4zZTSJ4Y9Y0cgXZj?=
 =?us-ascii?Q?14brVB3okfuTnYC5tNVh9KvFNoHzvI6vzl2LW2vZkNhOnpXBCXeR5xo4JIyk?=
 =?us-ascii?Q?7S9/pFKhOaJRFZAq+Ii5eb5S1I4Fe5v5SajTrEanTmgBd8F8cvl6Qw/IIJen?=
 =?us-ascii?Q?ND/kUzfVKpDqLh4zWkmoyXiveIWk0XhxmXCnYFmmR5lIcorFeIB7AQ89MslH?=
 =?us-ascii?Q?C4aJdailgpS3RjTEuCuwrAb1KTqqyT8dCv7vpZLGchROe7Rs78ogsdMB4ePZ?=
 =?us-ascii?Q?dypCZUqwBXlRnxJ+dF+GnWbQhbNOSjW3LDuUDXwJFpLEEaIrl0Q4oMFk5Rnr?=
 =?us-ascii?Q?0ftjwNbDcjhor8ByOVBgOdY4SaJA9o6iVG15gikQCq60rTqy+7GLjkcypKYL?=
 =?us-ascii?Q?Fvvh3xYAt4RH7MrXPjgWoijvVZZln+1z3F0CLVrqajhFcuEgpCfLvYC0SX0w?=
 =?us-ascii?Q?kBtoZZsS/B6O1hJNcsSxrnrh2njgWY70lseaFoZ7LPbUq9r9hRUwKBT3rk+1?=
 =?us-ascii?Q?bPZgGLpCFGbyF1/WSGT/4MdeCyWtaCg9mg9Rjwid5dSLSKUaxnCw8zn15sTJ?=
 =?us-ascii?Q?WZ2GoCGb01PcxNNNud8o0mZYdTy4wAJe13hA6B6Wnc6Sv7gEkmilNqVQVtVF?=
 =?us-ascii?Q?mVrOIO/2lCmhkLqrEST9xXJ6mqNqJcWPYoM69X/6r7j/6xNXtBz0sFlMj6wX?=
 =?us-ascii?Q?vnlQ2CggHB30i2rFUjyu4Q398icfSNFZ7QgrPlb9vX4nkYO+plSoqPMXTba2?=
 =?us-ascii?Q?/pSnZhy6Paunt6Iy1MJQZjZoSIj9DvSq9220fgvG250mOgXxvh/ZONMAvK7V?=
 =?us-ascii?Q?G7CCF5zdatZ1WlQHfi9j9UONtgXH5txLKZZwFmXk9dCpcKF9nahAyRoe5RlI?=
 =?us-ascii?Q?vYXExXJX7grTBOZzqpma9QkV0obevQ6Ji1kmH8hB2i9YOV/Ob5aMeW2bvBy/?=
 =?us-ascii?Q?vjnpU0dpxhLr52yQfCr+FzYNVq0UM2DKs5dh439+p/q01jHgGl/10ef1UZDi?=
 =?us-ascii?Q?UcZF+st4yjE7pXSJicOfuwHwc+MxejUFfjnAKmcTtzOP+ZxZswFFOl3MkpTn?=
 =?us-ascii?Q?QHC2hrHT0Kcc7ZBpR4Fkj5KywzM5s20=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec62f07-ea84-47b2-3847-08df1b301241
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:59.0570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmhQPdi51tR+l3DqZ66D5dhZsrSjnqQsuUYwUihKkMncfNnbB56kgEVcZgEnM45qS4vE3bvmBwFXb6EsD2JCcvcrr67hsNMO7yF8giP4kQ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24360

The `cip-cis-rules-config` recipe allows to create a use-case specific
hardening configuration based on the CIS hardening rules.

To tailor a hardening config the command
`bitbake -c menuconfig cip-cis-rules-config` can be used to generate the
hardening config interactively.

After the package build the generated config is deployed to
`${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_CONFIG}`.

The package also deploys a kernel config snippet to
`${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG}`, which can be used
to apply kernel hardening during compile instead of a runtime
configuration. If the user changes the config.json all followup jobs are
tainted. The code for this is from
https://github.com/yoctoproject/poky/blob/077627338ac18aeca34bfe0c52777fab3=
8e2e0c0/meta/classes-recipe/cml1.bbclass#L37 .

The Kconfig used by menuconfig is generated from the rules shipped by
the cis-hardening package (github.com/ovh/debian-cis).

Co-Authored-by: Clara Kowalsky <clara.kowalsky@siemens.com>
Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Co-Authored-by: Christoph Steiger <christoph.steiger@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../cip-cis-rules-config.bb                   |  159 ++
 .../cip-cis-rules-config/files/ci.config.json | 1760 +++++++++++++++++
 .../cip-cis-rules-config/files/postinst       |   31 +
 .../cip-cis-rules-config/files/rules.tmpl     |   19 +
 .../files/scripts/cis-hardening-to-kconfig.py |  350 ++++
 .../files/scripts/config.schema.json          |  124 ++
 .../files/scripts/enable-cis-rules.py         |  333 ++++
 .../files/scripts/gen-kernel-config.py        |  165 ++
 .../files/scripts/select-hardenings.py        |  616 ++++++
 9 files changed, 3557 insertions(+)
 create mode 100644 recipes-security/cip-cis-rules-config/cip-cis-rules-con=
fig.bb
 create mode 100644 recipes-security/cip-cis-rules-config/files/ci.config.j=
son
 create mode 100644 recipes-security/cip-cis-rules-config/files/postinst
 create mode 100644 recipes-security/cip-cis-rules-config/files/rules.tmpl
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/cis=
-hardening-to-kconfig.py
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/con=
fig.schema.json
 create mode 100644 recipes-security/cip-cis-rules-config/files/scripts/ena=
ble-cis-rules.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/gen=
-kernel-config.py
 create mode 100755 recipes-security/cip-cis-rules-config/files/scripts/sel=
ect-hardenings.py

diff --git a/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb =
b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
new file mode 100644
index 00000000..455c12c9
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/cip-cis-rules-config.bb
@@ -0,0 +1,159 @@
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+#
+inherit dpkg
+
+MAINTAINER =3D "Christoph Steiger <christoph.steiger@siemens.com>"
+DESCRIPTION =3D "Configuration files for CIS hardening"
+
+PROVIDES :=3D "${PN}"
+DEBIAN_PROVIDES :=3D "${PN}"
+
+DEPENDS =3D "cip-cis-rules cis-hardening"
+DEBIAN_BUILD_DEPENDS =3D "cip-cis-rules, cis-hardening, python3, python3-k=
configlib, python3-newt, python3-jsonschema"
+
+PN .=3D "-${MACHINE}"
+
+S =3D "${WORKDIR}/${BPN}"
+
+DEPLOYDIR_HARDENING =3D "${WORKDIR}/deploy-hardening"
+SSTATETASKS +=3D "do_deploy_hardening"
+
+HARDENING_CFG ?=3D ""
+HARDENING_CFG_NAME =3D "${@ d.getVar('HARDENING_CFG') if d.getVar('HARDENI=
NG_CFG') else 'config.json'}"
+
+HARDENING_CFG:ci =3D "ci.config.json"
+
+SRC_URI +=3D " \
+    file://scripts;subdir=3D${S} \
+    file://rules.tmpl \
+    file://postinst \
+    "
+SRC_URI +=3D "${@ 'file://' + d.getVar('HARDENING_CFG') if d.getVar('HARDE=
NING_CFG') else ''}"
+
+TEMPLATE_VARS +=3D "HARDENING_CFG_NAME"
+TEMPLATE_FILES +=3D "rules.tmpl"
+
+do_deploy_hardening[cleandirs] +=3D "${DEPLOYDIR_HARDENING}"
+do_deploy_hardening[sstate-inputdirs] =3D "${DEPLOYDIR_HARDENING}"
+do_deploy_hardening[sstate-outputdirs] =3D "${DEPLOY_DIR_IMAGE}"
+do_deploy_hardening() {
+    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
+        cp "${S}/${HARDENING_CFG_NAME}" "${DEPLOYDIR_HARDENING}/${CIP_CIS_=
HARDENING_CONFIG}"
+    fi
+    if [ -f "${S}/hardening.cfg" ]; then
+        cp "${S}/hardening.cfg" "${DEPLOYDIR_HARDENING}/${CIP_CIS_HARDENIN=
G_KCONFIG}"
+    fi
+}
+
+python do_deploy_hardening_setscene () {
+    sstate_setscene(d)
+}
+addtask deploy_hardening_setscene
+
+addtask deploy_hardening after do_dpkg_build before do_deploy_deb
+
+do_check_config() {
+    if [ ! -s "${S}/${HARDENING_CFG_NAME}" ]; then
+        bbfatal "Hardening configuration is missing. Please run 'bitbake c=
ip-cis-rules-config -c menuconfig' and include the generated ${WORKDIR}/${H=
ARDENING_CFG_NAME} in your SRC_URI and HARDENING_CFG_NAME."
+    fi
+}
+addtask check_config after do_prepare_build before do_dpkg_build do_genera=
te_kernel_config
+
+do_generate_kernel_config() {
+    if [ -f "${S}/${HARDENING_CFG_NAME}" ]; then
+        "${S}/scripts/gen-kernel-config.py" --config "${S}/${HARDENING_CFG=
_NAME}" --output "${S}/hardening.cfg"
+    fi
+}
+addtask generate_kernel_config before do_dpkg_build after do_prepare_build
+
+do_prepare_build() {
+    deb_debianize
+
+    cat <<EOF > "${S}/debian/${BPN}.install"
+${HARDENING_CFG_NAME} /usr/share/cip-cis-rules/
+hardening.cfg /usr/share/cip-cis-rules/
+EOF
+    if [ -f "${WORKDIR}/${HARDENING_CFG_NAME}" ]; then
+        install "${WORKDIR}/${HARDENING_CFG_NAME}" "${S}/${HARDENING_CFG_N=
AME}"
+    fi
+}
+
+do_menuconfig[nostamp] =3D "1"
+do_menuconfig[dirs] =3D "${DEVSHELL_STARTDIR}"
+do_menuconfig[network] =3D "${TASK_USE_SUDO}"
+do_menuconfig[depends] =3D "cip-cis-rules:do_deploy_deb cis-hardening:do_d=
eploy_deb"
+python do_menuconfig() {
+    isar_export_proxies(d)
+    isar_export_ccache(d)
+    isar_export_build_settings(d)
+
+    bb.build.exec_func('devshell_chroot_prepare', d)
+
+    schroot =3D d.getVar('SBUILD_CHROOT')
+    pkg_arch =3D d.getVar('PACKAGE_ARCH')
+    build_arch =3D d.getVar('BUILD_ARCH')
+    pp_pps =3D os.path.join(d.getVar('PP'), d.getVar('PPS'))
+    srcdir =3D d.getVar('S')
+    config =3D d.getVar('HARDENING_CFG_NAME')
+    configfile =3D os.path.join(srcdir, config)
+
+    try:
+        mtime =3D os.path.getmtime(configfile)
+    except OSError:
+        mtime =3D 0
+
+    install_deps =3D ":" if d.getVar('BB_CURRENTTASK') =3D=3D "devshell_no=
deps" else f"mk-build-deps -i \
+        --host-arch {pkg_arch} --build-arch {build_arch}  \
+        -t \"apt-get -y -q -o Debug::pkgProblemResolver=3Dyes --no-install=
-recommends --allow-downgrades\" \
+        debian/control"
+
+    termcmd =3D "cd {0}; \
+        apt-get -y -q update -o Dir::Etc::SourceList=3D\"sources.list.d/is=
ar-apt.list\" -o Dir::Etc::SourceParts=3D\"-\" -o APT::Get::List-Cleanup=3D=
\"0\"; \
+        apt-get -y upgrade; \
+        {1}; \
+        if [ -n \"$PATH_PREPEND\" ]; then export PATH=3D$PATH_PREPEND:$PAT=
H; fi; \
+        {0}/scripts/cis-hardening-to-kconfig.py /opt/cis-hardening/version=
s/default > {0}/Kconfig; \
+        {0}/scripts/select-hardenings.py --output {0}/{2} {0}/Kconfig".for=
mat(pp_pps, install_deps, config)
+
+    if d.getVar('ISAR_CHROOT_MODE') =3D=3D 'unshare':
+        mounts =3D d.getVar('SCHROOT_MOUNTS')
+        mounts +=3D ' {}:/home/builder/{}'.format(d.getVar('WORKDIR'), d.g=
etVar('BPN'))
+
+        if bb.utils.to_boolean(d.getVar('USE_CCACHE')):
+            bb.build.exec_func('dpkg_prepare_unshare_ccache', d)
+            mounts +=3D ' {}:/ccache'.format(d.getVar('CCACHE_DIR'))
+
+        termcmd =3D """{0} \
+sh -c "{1};cp /etc/resolv.conf {2}/etc;chroot {2} sh -c '{3}'"
+""".format(
+        run_privileged_cmd(d),
+        insert_isar_mounts(d, d.getVar('DEVSHELL_UNSHARE_ROOTFS'), mounts)=
,
+        d.getVar('DEVSHELL_UNSHARE_ROOTFS'),
+        termcmd.replace('"', "\\\""))
+    else:
+        termcmd =3D "schroot -d / -c {0} -u root -- sh -c '{1}'".format(sc=
hroot, termcmd)
+    oe_terminal(termcmd, "Generate Kconfig", d)
+
+    bb.build.exec_func('devshell_chroot_finalize', d)
+
+    try:
+        newmtime =3D os.path.getmtime(configfile)
+    except OSError:
+        newmtime =3D 0
+
+    if newmtime > mtime:
+        bb.note("Configuration changed, recompile will be forced")
+        bb.build.write_taint('do_generate_kernel_config', d)
+        bb.build.write_taint('do_deploy_hardening', d)
+        bb.build.write_taint('do_dpkg_source', d)
+        bb.build.write_taint('do_dpkg_build', d)
+
+}
+addtask menuconfig after do_prepare_build do_local_isarapt
diff --git a/recipes-security/cip-cis-rules-config/files/ci.config.json b/r=
ecipes-security/cip-cis-rules-config/files/ci.config.json
new file mode 100644
index 00000000..a6489ee9
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/ci.config.json
@@ -0,0 +1,1760 @@
+{
+  "level": 2,
+  "rules": [
+    {
+      "rule": {
+        "name": "1.1.10",
+        "description": "var tmp noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11",
+        "description": "var log partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.1",
+        "description": "var log noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.2",
+        "description": "var log nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log partition i=
s configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.11.3",
+        "description": "var log nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log partition i=
s configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12",
+        "description": "var log audit partition",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.1",
+        "description": "var log audit noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.2",
+        "description": "var log audit nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log/audit parti=
tion is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.12.3",
+        "description": "var log audit nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/log/audit parti=
tion is configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.13",
+        "description": "home partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.14",
+        "description": "home nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /home partition is c=
onfigured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.14.1",
+        "description": "home nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /home partition is c=
onfigured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.15",
+        "description": "run shm nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.16",
+        "description": "run shm nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.17",
+        "description": "run shm noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.18",
+        "description": "removable device nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.19",
+        "description": "removable device nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.1",
+        "description": "disable freevxfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.2",
+        "description": "disable jffs2",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.3",
+        "description": "disable hfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.4",
+        "description": "disable hfsplus",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.5",
+        "description": "disable squashfs",
+        "level": 2,
+        "apply": false,
+        "justification": "cip core requires squashfs for ro rootfs"
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.6",
+        "description": "disable udf",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.7",
+        "description": "restrict fat",
+        "level": 5,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.1.8",
+        "description": "disable cramfs",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.2",
+        "description": "tmp partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.20",
+        "description": "removable device noexec",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.21",
+        "description": "sticky bit world writable folder",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.22",
+        "description": "disable automounting",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.23",
+        "description": "disable usb storage",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.3",
+        "description": "tmp nodev",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.4",
+        "description": "tmp nosuid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.5",
+        "description": "tmp noexec",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6",
+        "description": "var partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6.1",
+        "description": "var nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var partition is co=
nfigured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.6.2",
+        "description": "var nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var partition is co=
nfigured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.7",
+        "description": "var tmp partition",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.8",
+        "description": "var tmp nodev",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/tmp partition i=
s configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.1.9",
+        "description": "var tmp nosuid",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: no separate /var/tmp partition i=
s configured."
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.1",
+        "description": "install sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.2",
+        "description": "pty sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.3.3",
+        "description": "logfile sudo",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.4.1",
+        "description": "install tripwire",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.4.2",
+        "description": "tripwire cron",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.1",
+        "description": "bootloader ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: the GRUB bootloader is not used.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.2",
+        "description": "bootloader password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.5.3",
+        "description": "root password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.1",
+        "description": "enable nx support",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.2",
+        "description": "enable randomized vm placement",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.3",
+        "description": "disable prelink",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.3.1",
+        "description": "disable apport",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.6.4",
+        "description": "restrict core dumps",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.1",
+        "description": "install apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.2",
+        "description": "enable apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.3",
+        "description": "enforce or complain apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.7.1.4",
+        "description": "enforcing apparmor",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.1",
+        "description": "remove os info motd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.2",
+        "description": "remove os info issue",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.3",
+        "description": "remove os info issue net",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.4",
+        "description": "motd perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.5",
+        "description": "etc issue perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.1.6",
+        "description": "etc issue net perms",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "1.8.2",
+        "description": "graphical warning banners",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.1.1",
+        "description": "disable xinetd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.1.2",
+        "description": "disable bsd inetd",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.10",
+        "description": "disable http server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.11",
+        "description": "disable imap pop",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.12",
+        "description": "disable samba",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.13",
+        "description": "disable http proxy",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.14",
+        "description": "disable snmp server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.15",
+        "description": "mta localhost",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.16",
+        "description": "disable rsync",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.17",
+        "description": "disable nis",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.1",
+        "description": "use time sync",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.2",
+        "description": "configure systemd-timesyncd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.3",
+        "description": "configure chrony",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.1.4",
+        "description": "configure ntp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.2",
+        "description": "disable xwindow system",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.3",
+        "description": "disable avahi server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.4",
+        "description": "disable print server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.5",
+        "description": "disable dhcp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.6",
+        "description": "disable ldap",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.7",
+        "description": "disable nfs rpc",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.8",
+        "description": "disable dns server",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.2.9",
+        "description": "disable ftp",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.1",
+        "description": "disable nis",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.2",
+        "description": "disable rsh client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.3",
+        "description": "disable talk client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.4",
+        "description": "disable telnet client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "2.3.5",
+        "description": "disable ldap client",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.1.1",
+        "description": "disable ipv6",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.1.2",
+        "description": "disable wireless",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "3.2.1",
+        "description": "disable send packet redirects",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.2.2",
+        "description": "disable ip forwarding",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.1",
+        "description": "disable source routed packets",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.2",
+        "description": "disable icmp redirect",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.3",
+        "description": "disable secure icmp redirect",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.4",
+        "description": "log martian packets",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.5",
+        "description": "ignore broadcast requests",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.6",
+        "description": "enable bad error message protection",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.7",
+        "description": "enable source route validation",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.8",
+        "description": "enable tcp syn cookies",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.3.9",
+        "description": "disable ipv6 router advertisement",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.5.1.1",
+        "description": "enable firewall",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "3.5.4.1.1",
+        "description": "net fw default policy drop",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.10",
+        "description": "record failed access file",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.11",
+        "description": "record privileged commands",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.12",
+        "description": "record successful mount",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.13",
+        "description": "record file deletions",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.14",
+        "description": "record sudoers edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.15",
+        "description": "record sudo usage",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.16",
+        "description": "record kernel modules",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.17",
+        "description": "freeze auditd conf",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.1",
+        "description": "install auditd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.2",
+        "description": "enable auditd",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.3",
+        "description": "audit bootloader",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.1.4",
+        "description": "audit backlog limit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.1",
+        "description": "audit log storage",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.2",
+        "description": "halt when audit log full",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.2.3",
+        "description": "keep all audit logs",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.3",
+        "description": "record date time edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.4",
+        "description": "record user group edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.5",
+        "description": "record network edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.6",
+        "description": "record mac edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.7",
+        "description": "record login logout",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.8",
+        "description": "record session init",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.1.9",
+        "description": "record dac edit",
+        "level": 4,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.1",
+        "description": "install syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.2",
+        "description": "enable syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.3",
+        "description": "configure syslog-ng",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.4",
+        "description": "syslog ng logfiles perm",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.5",
+        "description": "syslog-ng remote host",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.1.6",
+        "description": "remote syslog-ng acl",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.1",
+        "description": "journald logs",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.2",
+        "description": "journald compress",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.2.3",
+        "description": "journald write persistent",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "4.2.3",
+        "description": "logs permissions",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "4.4",
+        "description": "logrotate permissions",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.1",
+        "description": "enable cron",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.2",
+        "description": "crontab perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.3",
+        "description": "cron hourly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.4",
+        "description": "cron daily perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.5",
+        "description": "cron weekly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.6",
+        "description": "cron monthly perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.7",
+        "description": "cron d perm ownership",
+        "level": 1,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.1.8",
+        "description": "cron users",
+        "level": 2,
+        "apply": false,
+        "justification": "Not applicable: cron is not used on this system.=
"
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.1",
+        "description": "sshd conf perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.10",
+        "description": "disable root login",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.11",
+        "description": "disable sshd permitemptypasswords",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.12",
+        "description": "disable sshd setenv",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.13",
+        "description": "sshd ciphers",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.14",
+        "description": "ssh cry mac",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.15",
+        "description": "ssh cry kex",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.16",
+        "description": "sshd idle timeout",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.17",
+        "description": "sshd login grace time",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.18",
+        "description": "sshd limit access",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.19",
+        "description": "ssh banner",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.2",
+        "description": "ssh host private keys perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.20",
+        "description": "enable ssh pam",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.21",
+        "description": "disable ssh allow tcp forwarding",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.22",
+        "description": "configure ssh max startups",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.23",
+        "description": "limit ssh max sessions",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.3",
+        "description": "ssh host public keys perm ownership",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.4",
+        "description": "sshd protocol",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.5",
+        "description": "sshd loglevel",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.6",
+        "description": "disable x11 forwarding",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.7",
+        "description": "sshd maxauthtries",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.8",
+        "description": "enable sshd ignorerhosts",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.2.9",
+        "description": "disable sshd hostbasedauthentication",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.1",
+        "description": "enable pwquality",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.2",
+        "description": "enable lockout failed password",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.3",
+        "description": "limit password reuse",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.3.4",
+        "description": "acc pam sha512",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.1",
+        "description": "set password exp days",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.2",
+        "description": "set password min days change",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.3",
+        "description": "set password exp warning days",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.4",
+        "description": "lock inactive user account",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.1.5",
+        "description": "last password change past",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.2",
+        "description": "disable system accounts",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.3",
+        "description": "default root group",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.4",
+        "description": "default umask",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.4.5",
+        "description": "default timeout",
+        "level": 5,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.5",
+        "description": "secure tty",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "5.6",
+        "description": "restrict su",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.10",
+        "description": "find world writable file",
+        "level": 3,
+        "apply": false
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.11",
+        "description": "find unowned files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.12",
+        "description": "find ungrouped files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.13",
+        "description": "find suid files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.14",
+        "description": "find sgid files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.2",
+        "description": "etc passwd permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.3",
+        "description": "etc gshadow- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.4",
+        "description": "etc shadow permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.5",
+        "description": "etc group permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.6",
+        "description": "etc passwd- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.7",
+        "description": "etc shadow- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.8",
+        "description": "etc group- permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.1.9",
+        "description": "etc gshadow permissions",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.1",
+        "description": "remove empty password field",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.10",
+        "description": "check user dot file perm",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.11",
+        "description": "find user forward files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.12",
+        "description": "find user netrc files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.13",
+        "description": "set perm on user netrc",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.14",
+        "description": "find user rhosts files",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.15",
+        "description": "find passwd group inconsistencies",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.16",
+        "description": "check duplicate uid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.17",
+        "description": "check duplicate gid",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.18",
+        "description": "check duplicate username",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.19",
+        "description": "check duplicate groupname",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.2",
+        "description": "remove legacy passwd entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.20",
+        "description": "shadow group empty",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.3",
+        "description": "users homedir exist",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.4",
+        "description": "remove legacy shadow entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.5",
+        "description": "remove legacy group entries",
+        "level": 1,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.6",
+        "description": "find 0 uid non root account",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.7",
+        "description": "sanitize root path",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.8",
+        "description": "check user dir perm",
+        "level": 2,
+        "apply": true
+      }
+    },
+    {
+      "rule": {
+        "name": "6.2.9",
+        "description": "users homedir ownership",
+        "level": 2,
+        "apply": true
+      }
+    }
+  ]
+}
\ No newline at end of file
diff --git a/recipes-security/cip-cis-rules-config/files/postinst b/recipes=
-security/cip-cis-rules-config/files/postinst
new file mode 100644
index 00000000..4932d6be
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/postinst
@@ -0,0 +1,31 @@
+#!/bin/sh
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+
+set -e
+
+CIP_CIS_CONF_DIR=3D/usr/share/cip-cis-rules/configuration
+
+case "$1" in
+    configure)
+        if [ -d "$CIP_CIS_CONF_DIR" ]; then
+            for script in "$CIP_CIS_CONF_DIR"/*.sh; do
+                [ -r "$script" ] || continue
+                if ! sh "$script"; then
+                    echo "cip-cis-rules: $(basename "$script") failed" >&2
+                    exit 1
+                fi
+            done
+        fi
+        ;;
+    abort-upgrade|abort-remove|abort-deconfigure)
+        ;;
+    *)
+        echo "postinst called with unknown argument '$1'" >&2
+        exit 1
+        ;;
+esac
+
+#DEBHELPER#
+
+exit 0
diff --git a/recipes-security/cip-cis-rules-config/files/rules.tmpl b/recip=
es-security/cip-cis-rules-config/files/rules.tmpl
new file mode 100644
index 00000000..f2afa40f
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/rules.tmpl
@@ -0,0 +1,19 @@
+#!/usr/bin/make -f
+# Copyright (c) Siemens AG, 2026
+# SPDX-License-Identifier: MIT
+PACKAGE	       :=3D ${PN}
+CONFIG_JSON    :=3D ${HARDENING_CFG_NAME}
+DESTDIR        :=3D debian/$(PACKAGE)
+
+%:
+	dh $@
+
+# Copy enabled config snippets into the main package staging tree.
+# Install the rule-selection config and kernel fragment into the dev packa=
ge
+# so that build systems and validation tools can consume them.
+override_dh_auto_install:
+	python3 scripts/enable-cis-rules.py \
+		--config $(CONFIG_JSON) \
+		--snippets-dir /usr/share/cip-cis-rules \
+		--output-dir $(DESTDIR)
+	dh_auto_install
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/cis-harden=
ing-to-kconfig.py b/recipes-security/cip-cis-rules-config/files/scripts/cis=
-hardening-to-kconfig.py
new file mode 100755
index 00000000..cb579f6a
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/cis-hardening-to-=
kconfig.py
@@ -0,0 +1,350 @@
+#!/usr/bin/env python3
+#
+# SPDX-FileCopyrightText: 2026 Siemens AG
+# SPDX-License-Identifier: MIT
+#
+
+import argparse
+from pathlib import Path
+import re
+
+SECTIONS =3D {
+    "1 Initial Setup": {
+        "1.1 Filesystem Configuration": {},
+        "1.2 Software Updates": {},
+        "1.3 Filesystem Integrity Checking": {},
+        "1.4 Secure Boot Settings": {},
+        "1.5 Additional Process Hardening": {},
+        "1.6 Mandatory Access Control": {},
+        "1.7 CLI Warning Banners": {},
+        "1.8 Gnome Display Manager": {},
+    },
+    "2 Services": {
+        "2.1 Time Synchronization": {},
+        "2.2 Special Purpose Services": {},
+        "2.3 Service Clients": {},
+    },
+    "3 Network Configuration": {
+        "3.1 Protocols and Devices": {},
+        "3.2 Parameters (Host Only)": {},
+        "3.3 Parameters (Host and Router)": {},
+        "3.5 Firewall": {},
+    },
+    "4 Logging and Auditing": {
+        "4.1 System Accounting (auditd)": {},
+        "4.2 Logging": {},
+        "4.4 Ensure logrotate assigns appropriate permissions": {},
+    },
+    "5 Access and Auth": {
+        "5.1 Time-based Job Schedulers": {},
+        "5.2 SSH Server": {},
+        "5.3 Privilege Escalation": {},
+        "5.4 PAM": {},
+        "5.5 User Accounts and Environment": {},
+        "5.6 Restrict Access to su": {}
+    },
+    "6 System Maintenance": {
+        "6.1 System File Permissions": {},
+        "6.2 Local User and Group Settings": {},
+    },
+}
+
+# Maps ID of a rule and the additional Kconfig dependencies that it requir=
es
+SPECIAL_RULES =3D {
+    "1.1.6": "CIP_VAR_PART",
+    "1.1.6.1": "CIP_VAR_PART",
+    "1.1.6.2": "CIP_VAR_PART",
+    "1.1.7": "CIP_VAR_TMP_PART",
+    "1.1.8": "CIP_VAR_TMP_PART",
+    "1.1.9": "CIP_VAR_TMP_PART",
+    "1.1.10": "CIP_VAR_TMP_PART",
+    "1.1.11": "CIP_VAR_LOG_PART",
+    "1.1.11.1": "CIP_VAR_LOG_PART",
+    "1.1.11.2": "CIP_VAR_LOG_PART",
+    "1.1.11.3": "CIP_VAR_LOG_PART",
+    "1.1.12": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.1": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.2": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.12.3": "CIP_VAR_LOG_AUDIT_PART",
+    "1.1.13": "CIP_HOME_PART",
+    "1.1.14": "CIP_HOME_PART",
+    "1.1.14.1": "CIP_HOME_PART",
+    "1.5.1": "CIP_GRUB_BOOTLOADER",
+    "5.1.2": "CIP_CRON",
+    "5.1.3": "CIP_CRON",
+    "5.1.4": "CIP_CRON",
+    "5.1.5": "CIP_CRON",
+    "5.1.6": "CIP_CRON",
+    "5.1.7": "CIP_CRON",
+    "5.1.8": "CIP_CRON",
+}
+
+SPECIAL_RULE_JUSTIFICATIONS =3D {
+    "CIP_VAR_PART": "Not applicable: no separate /var partition is configu=
red.",
+    "CIP_VAR_TMP_PART": "Not applicable: no separate /var/tmp partition is=
 configured.",
+    "CIP_VAR_LOG_PART": "Not applicable: no separate /var/log partition is=
 configured.",
+    "CIP_VAR_LOG_AUDIT_PART": "Not applicable: no separate /var/log/audit =
partition is configured.",
+    "CIP_HOME_PART": "Not applicable: no separate /home partition is confi=
gured.",
+    "CIP_GRUB_BOOTLOADER": "Not applicable: the GRUB bootloader is not use=
d.",
+    "CIP_CRON": "Not applicable: cron is not used on this system.",
+}
+
+
+class Rule:
+    def __init__(self, rule: Path):
+        if "_" not in rule.name:
+            raise ValueError(
+                f"Rule filename '{rule.name}' does not match expected '<id=
>_<name>' format"
+            )
+        id, name =3D rule.name.split("_", 1)
+        self.id =3D [int(i) for i in id.split(".")]
+        self.name =3D name.split(".")[0].replace("_", " ")
+        self.description =3D None
+        self.hardening_level =3D 5
+        with open(rule, "r") as f:
+            for line in f:
+                line =3D line.strip()
+                if line.startswith("DESCRIPTION=3D"):
+                    self.description =3D line.split("=3D", 1)[1].strip('"'=
)
+                elif line.startswith("HARDENING_LEVEL=3D"):
+                    raw =3D line.split("=3D", 1)[1].strip()
+                    try:
+                        self.hardening_level =3D int(raw)
+                    except ValueError:
+                        raise ValueError(
+                            f"Rule '{rule.name}' has non-integer HARDENING=
_LEVEL=3D{raw!r}"
+                        )
+
+
+def setup_parser():
+    parser =3D argparse.ArgumentParser(
+        prog=3D"cis-hardening-to-kconfig",
+        description=3D"Convert the OVH CIS hardening rules to a KConfig",
+    )
+    parser.add_argument("rules-dir", type=3DPath)
+    return parser
+
+
+def rule_to_kconfig_entry(r: Rule, parent_symbol: str, levels: list[int]) =
-> str:
+    id_str =3D "_".join(str(i) for i in r.id)
+    id_dotted =3D ".".join(str(i) for i in r.id)
+    symbol =3D f"CIS_{id_str}"
+    applicable =3D [l for l in levels if l >=3D r.hardening_level]
+    default_cond =3D " || ".join(f"CIS_LEVEL_{l}" for l in applicable)
+    additional_cond =3D SPECIAL_RULES.get(id_dotted)
+    if additional_cond:
+        default_cond =3D f"({default_cond}) && {additional_cond}"
+    lines =3D [
+        f"config {symbol}",
+        f'\tbool "{id_dotted} - {r.name} ({r.hardening_level})"',
+        f"\tdefault y if {default_cond}",
+    ]
+    if r.description:
+        lines.append(f"\thelp")
+        lines.append(f"\t  {r.description}")
+    return "\n".join(lines) + "\n"
+
+
+def transform_prompt(bool_prompt):
+    """
+    Turn the bool prompt into a justification string prompt.
+    e.g. "1.1.1.1 - disable freevxfs (2)"
+      -> "justification to enable freevxfs (2)"
+    We strip the leading number and dash, remove leading verb, keep the re=
st.
+    """
+    # Remove the CIS rule number prefix  "X.X.X - "
+    m =3D re.match(r"^[\d.]+ - (.+)$", bool_prompt)
+    if m:
+        rest =3D m.group(1)
+    else:
+        rest =3D bool_prompt
+
+    # Drop leading verb ("disable", "enable", "install", "restrict", etc.)
+    rest_stripped =3D re.sub(
+        r"^(disable|enable|install|restrict|configure|use|set|remove|find|=
check|limit|lock|freeze|enforce|log|record|halt|keep|make|update)\s+",
+        "",
+        rest,
+        flags=3Dre.IGNORECASE,
+    )
+
+    return f"justification to enable {rest_stripped}"
+
+
+def transform_help(help_text):
+    """
+    Build a generic justification help line from the parent help text.
+    Strip leading verb (same list as transform_prompt) before composing.
+    """
+    # Strip trailing period
+    stripped =3D help_text.rstrip(".")
+    # Drop leading verb
+    stripped =3D re.sub(
+        r"^(disable|enable|install|restrict|configure|use|set|remove|find|=
check|"
+        r"limit|lock|freeze|enforce|log|record|halt|keep|make|update|colle=
ct|"
+        r"ensure|verify|deactivate|activate|implement|implemet|create|"
+        r"checking|allow|disallow|do not allow)\s+",
+        "",
+        stripped,
+        flags=3Dre.IGNORECASE,
+    )
+    return f"Provide a reason for enabling {stripped} for the current hard=
ening level."
+
+
+def rule_to_justification_entry(r: Rule, parent_symbol: str, levels: list[=
int]) -> str:
+    id_str =3D "_".join(str(i) for i in r.id)
+    id_dotted =3D ".".join(str(i) for i in r.id)
+    symbol =3D f"CIS_{id_str}_JUSTIFICATION"
+    applicable =3D [l for l in levels if l >=3D r.hardening_level]
+    level_cond =3D " || ".join(f"CIS_LEVEL_{l}" for l in applicable)
+    additional_cond =3D SPECIAL_RULES.get(id_dotted)
+    depends_cond =3D f"!CIS_{id_str} && ({level_cond})"
+    prompt =3D transform_prompt(f"{id_dotted} - {r.name} ({r.hardening_lev=
el})")
+    lines =3D [
+        f"config {symbol}",
+        f'\tstring "{prompt}"',
+        f"\tdepends on {depends_cond}",
+    ]
+    if additional_cond:
+        preset =3D SPECIAL_RULE_JUSTIFICATIONS.get(additional_cond)
+        if preset:
+            lines.append(f'\tdefault "{preset}" if !{additional_cond}')
+    help_text =3D transform_help(r.description) if r.description else None
+    if r.description:
+        lines.append("\thelp")
+        lines.append(f"\t  {help_text}")
+    return "\n".join(lines) + "\n"
+
+
+def section_symbol(section_key: str) -> str:
+    num =3D section_key.split(" ", 1)[0]
+    return "CIS_SEC_" + num.replace(".", "_")
+
+
+def generate_kconfig(rules: list[Rule]) -> str:
+    # Collect all hardening levels used
+    levels =3D sorted({r.hardening_level for r in rules if r.hardening_lev=
el is not None})
+    if not levels:
+        raise ValueError("No rules with a hardening level found; cannot ge=
nerate Kconfig")
+
+    # Build lookup: subsection number -> list of rules
+    subsection_rules: dict[str, list[Rule]] =3D {}
+    for rule in rules:
+        key =3D ".".join(str(i) for i in rule.id[:2])
+        subsection_rules.setdefault(key, []).append(rule)
+
+    output =3D []
+
+    # Hardening level selection
+    output.append('menu "Default hardening level"')
+    output.append("")
+    output.append("choice")
+    output.append('\tprompt "Hardening level"')
+    default_level =3D 2 if 2 in levels else levels[0]
+    output.append(f"\tdefault CIS_LEVEL_{default_level}")
+    output.append("")
+
+    for level in levels:
+        output.append(f"config CIS_LEVEL_{level}")
+        output.append(f'\tbool "Level {level}"')
+        output.append("")
+
+    output.append("endchoice")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+
+    # Other special rule menus
+    output.append('menu "Partitioning layout"')
+    output.append("")
+    output.append("config CIP_HOME_PART")
+    output.append('\tbool "Separate /home partition"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /home partition"=
)
+    output.append("")
+    output.append("config CIP_VAR_PART")
+    output.append('\tbool "Separate /var partition"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var partition")
+    output.append("")
+    output.append("config CIP_VAR_TMP_PART")
+    output.append('\tbool "Separate /var/tmp partition"')
+    output.append("\tdepends on CIP_VAR_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/tmp partiti=
on")
+    output.append("")
+    output.append("config CIP_VAR_LOG_PART")
+    output.append('\tbool "Separate /var/log partition"')
+    output.append("\tdepends on CIP_VAR_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/log partiti=
on")
+    output.append("")
+    output.append("config CIP_VAR_LOG_AUDIT_PART")
+    output.append('\tbool "Separate /var/log/audit partition"')
+    output.append("\tdepends on CIP_VAR_PART && CIP_VAR_LOG_PART")
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you have a separate /var/log/audit p=
artition")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+    output.append('menu "Additional options"')
+    output.append("config CIP_GRUB_BOOTLOADER")
+    output.append('\tbool "GRUB Bootloader"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you use the GRUB bootloader")
+    output.append("")
+    output.append("config CIP_CRON")
+    output.append('\tbool "CRON"')
+    output.append("\tdefault n")
+    output.append("\thelp")
+    output.append("\t  Enable this if you use CRON")
+    output.append("")
+    output.append("endmenu")
+    output.append("")
+
+    for section_key, subsections in SECTIONS.items():
+        output.append(f'menu "{section_key}"')
+        output.append("")
+
+        for subsection_key in subsections:
+            sub_num =3D subsection_key.split(" ", 1)[0]
+            matching =3D subsection_rules.get(sub_num, [])
+            if not matching:
+                continue
+
+            output.append(f'menu "{subsection_key}"')
+            output.append("")
+
+            for rule in matching:
+                output.append(rule_to_kconfig_entry(rule, None, levels))
+                output.append(rule_to_justification_entry(rule, None, leve=
ls))
+
+            output.append("endmenu")
+            output.append("")
+
+        output.append("endmenu")
+        output.append("")
+
+    return "\n".join(output)
+
+
+def main():
+    parser =3D setup_parser()
+    args =3D parser.parse_args()
+    rulesdir: Path =3D getattr(args, "rules-dir")
+
+    rules =3D sorted(
+        (Rule(f) for f in rulesdir.iterdir() if f.is_file() and "_" in f.n=
ame),
+        key=3Dlambda r: r.id,
+    )
+
+    print(generate_kconfig(rules))
+
+
+if __name__ =3D=3D "__main__":
+    main()
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/config.sch=
ema.json b/recipes-security/cip-cis-rules-config/files/scripts/config.schem=
a.json
new file mode 100644
index 00000000..74b020a7
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/config.schema.jso=
n
@@ -0,0 +1,124 @@
+{
+  "$schema": "https://json-schema.org/draft/2020-12/schema",
+  "$id": "config.schema.json",
+  "title": "CIP CIS Hardening Rules",
+  "description": "Schema for the config.json file produced by select-harde=
nings.py",
+  "type": "object",
+  "required": ["level", "rules"],
+  "additionalProperties": false,
+  "properties": {
+    "level": {
+      "type": "integer",
+      "description": "The selected CIS hardening level",
+      "enum": [1, 2, 3, 4, 5]
+    },
+    "rules": {
+      "type": "array",
+      "minItems": 1,
+      "items": { "$ref": "#/$defs/ruleWrapper" }
+    }
+  },
+  "$comment": "For each possible selected level L, when the selected level=
 =3D=3D L every rule whose minimum level is <=3D L must carry a justificati=
on if it is not applied (apply =3D=3D false).",
+  "allOf": [
+    { "$ref": "#/$defs/requireJustificationL1" },
+    { "$ref": "#/$defs/requireJustificationL2" },
+    { "$ref": "#/$defs/requireJustificationL3" },
+    { "$ref": "#/$defs/requireJustificationL4" },
+    { "$ref": "#/$defs/requireJustificationL5" }
+  ],
+  "$defs": {
+    "ruleWrapper": {
+      "type": "object",
+      "required": ["rule"],
+      "additionalProperties": false,
+      "properties": {
+        "rule": {
+          "type": "object",
+          "required": ["name", "description", "level", "apply"],
+          "additionalProperties": false,
+          "properties": {
+            "name": {
+              "type": "string",
+              "description": "CIS rule identifier, e.g. '1.1.1.1'",
+              "pattern": "^[0-9]+(\\.[0-9]+)*$"
+            },
+            "description": {
+              "type": "string",
+              "description": "Short description of the hardening rule",
+              "minLength": 1
+            },
+            "level": {
+              "type": "integer",
+              "description": "Minimum CIS hardening level at which this ru=
le is required",
+              "enum": [1, 2, 3, 4, 5]
+            },
+            "apply": {
+              "type": "boolean",
+              "description": "Whether the rule is currently enabled in the=
 configuration"
+            },
+            "justification": {
+              "type": "string",
+              "description": "Reason for not applying a rule that is requi=
red by the selected hardening level",
+              "minLength": 1
+            },
+            "value": {
+              "type": "string",
+              "description": "Optional parameter value for rules that requ=
ire site-specific configuration (e.g. group names)",
+              "minLength": 1
+            }
+          }
+        }
+      }
+    },
+    "requireJustificationL1": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 1=
 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rul=
e": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1] }, "apply": { "const": fa=
lse } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL2": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 2=
 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rul=
e": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2] }, "apply": { "const":=
 false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL3": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 3=
 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rul=
e": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3] }, "apply": { "cons=
t": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL4": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 4=
 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rul=
e": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3, 4] }, "apply": { "c=
onst": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    },
+    "requireJustificationL5": {
+      "if": { "required": ["level"], "properties": { "level": { "const": 5=
 } } },
+      "then": { "properties": { "rules": { "items": { "properties": { "rul=
e": {
+        "if": {
+          "required": ["level", "apply"],
+          "properties": { "level": { "enum": [1, 2, 3, 4, 5] }, "apply": {=
 "const": false } }
+        },
+        "then": { "required": ["justification"] }
+      } } } } } }
+    }
+  }
+}
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/enable-cis=
-rules.py b/recipes-security/cip-cis-rules-config/files/scripts/enable-cis-=
rules.py
new file mode 100644
index 00000000..adbd7a0c
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/enable-cis-rules.=
py
@@ -0,0 +1,333 @@
+#!/usr/bin/env python3
+# SPDX-FileCopyrightText: 2026 Siemens AG
+# SPDX-License-Identifier: MIT
+"""
+Package enabled CIS hardening configuration snippets into a partial root d=
irectory
+for Debian package creation.
+
+This script:
+1. Parses a .config.json file to find rules with apply=3Dtrue
+2. Maps rule names to generated config file snippets
+3. Copies enabled config files to the correct locations in a partial root =
directory
+4. Creates the directory structure that dpkg expects for package building
+
+Usage:
+    python3 enable-cis-rules.py \\
+        --config /path/to/.config.json \\
+        --snippets-dir /path/to/cis-config-snippets \\
+        --output-dir /path/to/partial/root
+"""
+
+import argparse
+import logging
+import json
+import re
+import sys
+from pathlib import Path
+from typing import Dict, List, Set
+
+logger =3D logging.getLogger(__name__)
+
+
+def load_json(path: Path, logger: logging.Logger) -> dict:
+    """Load a JSON file. On error, log to stderr and exit with status 1.""=
"
+    try:
+        with Path(path).open() as f:
+            return json.load(f)
+    except (json.JSONDecodeError, OSError) as exc:
+        logger.error(f"Error loading file '{path}': {exc}")
+        sys.exit(1)
+
+
+def get_enabled_rules(config: dict) -> set[str]:
+    """Return the set of rule names where rule.apply is true and the name =
is non-empty."""
+    enabled: set[str] =3D set()
+    for entry in config.get("rules", []):
+        rule =3D entry.get("rule", {}) if isinstance(entry, dict) else {}
+        if rule.get("apply", False) and rule.get("name"):
+            enabled.add(rule["name"])
+    return enabled
+
+
+# ------------------------------------------------------------------------=
---
+# Dynamic rule discovery
+# Discovers config files based on CIS rule IDs encoded in filenames
+# ------------------------------------------------------------------------=
---
+
+# ------------------------------------------------------------------------=
---
+# Destination path prefix overrides
+# By default snippets are placed under etc/ in the output root.
+# Entries here map a source subdirectory prefix to a different destination
+# prefix.  Keys are Path parts (as strings) relative to snippets_dir.
+# ------------------------------------------------------------------------=
---
+DEST_PREFIX_OVERRIDES: Dict[str, str] =3D {
+    "pam-configs": "usr/share/pam-configs",
+    "chrony": "etc/chrony",
+    "configuration": "usr/share/cip-cis-rules/configuration",
+    "conf.d-overrides": "usr/share/cip-cis-rules/conf.d-overrides",
+    "sshd_config.d": "etc/ssh/sshd_config.d",
+}
+
+# ------------------------------------------------------------------------=
---
+# Per-source-prefix file mode overrides.
+# By default snippets are written with the umask default (typically 0644).
+# Some destinations are rejected by the consuming tool unless mode is set
+# explicitly; in particular sudo refuses to read /etc/sudoers.d/* unless
+# mode is <=3D 0440 and owner is root.
+# Keys are the first component of the source path (relative to snippets_di=
r).
+# ------------------------------------------------------------------------=
---
+DEST_MODE_OVERRIDES: Dict[str, int] =3D {
+    "sudoers.d": 0o440,
+    "configuration": 0o755,
+}
+
+
+def dest_mode(source_rel: "Path") -> "int | None":
+    """
+    Return the explicit file mode for the destination of ``source_rel``,
+    or ``None`` if no override applies (caller should leave the file at th=
e
+    umask default).
+    """
+    parts =3D source_rel.parts
+    first =3D parts[0] if parts else ""
+    return DEST_MODE_OVERRIDES.get(first)
+
+
+def dest_rel_path(source_rel: "Path") -> "Path":
+    """
+    Return the destination path relative to the output root for a given
+    source-relative path.
+
+    The first component of source_rel is matched against DEST_PREFIX_OVERR=
IDES.
+    If found the first component is replaced with the mapped prefix.
+    Otherwise 'etc' is prepended (legacy behaviour).
+    """
+    parts =3D source_rel.parts
+    first =3D parts[0] if parts else ""
+    if first in DEST_PREFIX_OVERRIDES:
+        rest =3D parts[1:]
+        if not rest:
+            raise ValueError(
+                f"dest_rel_path: snippet '{source_rel}' sits at snippets r=
oot "
+                f"with a prefix-override key as its name =E2=80=94 cannot =
determine destination"
+            )
+        return Path(DEST_PREFIX_OVERRIDES[first]) / Path(*rest)
+    return Path("etc") / source_rel
+
+
+def discover_rule_files(
+    snippets_dir: Path, logger: logging.Logger
+) -> Dict[str, List[Path]]:
+    """
+    Dynamically discover config files by scanning snippets directory.
+
+    Looks for files matching pattern: cis-X.Y.Z-* or cis-X.Y.Z.W-* (dot-se=
parated rule ID)
+
+    Returns a mapping of rule_id -> list of file paths relative to snippet=
s_dir.
+    """
+    # Pattern to match CIS rule IDs in filenames (dot-separated)
+    pattern =3D re.compile(r"cis-(\d+)\.(\d+)\.(\d+)(?:\.(\d+))?")
+
+    rule_files: Dict[str, List[Path]] =3D {}
+
+    # Recursively find all files in snippets directory
+    for file_path in snippets_dir.rglob("*"):
+        if not file_path.is_file():
+            continue
+
+        filename =3D file_path.name
+
+        # Try to match pattern
+        match =3D pattern.search(filename)
+        if match:
+            groups =3D match.groups()
+
+            # Build rule ID (X.Y.Z or X.Y.Z.W format)
+            if groups[3]:  # 4-part rule ID
+                rule_id =3D f"{groups[0]}.{groups[1]}.{groups[2]}.{groups[=
3]}"
+            else:  # 3-part rule ID
+                rule_id =3D f"{groups[0]}.{groups[1]}.{groups[2]}"
+
+            # Get relative path from snippets_dir
+            rel_path =3D file_path.relative_to(snippets_dir)
+
+            # Add to mapping
+            if rule_id not in rule_files:
+                rule_files[rule_id] =3D []
+            rule_files[rule_id].append(rel_path)
+
+            logger.debug(f"Discovered rule {rule_id}: {rel_path}")
+
+    logger.info(f"Discovered {len(rule_files)} rules with config files")
+    return rule_files
+
+
+def get_rule_values(config: dict) -> Dict[str, str]:
+    """Extract the optional value field for each rule."""
+    values =3D {}
+    for rule_entry in config.get("rules", []):
+        rule =3D rule_entry.get("rule", {})
+        name =3D rule.get("name", "")
+        value =3D rule.get("value")
+        if name and value is not None:
+            values[name] =3D value
+    return values
+
+
+def package_configs(
+    enabled_rules: Set[str],
+    rule_files: Dict[str, List[Path]],
+    rule_values: Dict[str, str],
+    snippets_dir: Path,
+    output_dir: Path,
+    logger: logging.Logger,
+) -> int:
+    """
+    Copy enabled config snippets to the partial root directory structure.
+    Returns the number of errors encountered.
+    """
+    errors =3D 0
+    processed_files =3D 0
+
+    for rule_name in sorted(enabled_rules):
+        if rule_name not in rule_files:
+            logger.debug(f"SKIP {rule_name}: no config files found for thi=
s rule")
+            continue
+
+        file_paths =3D rule_files[rule_name]
+
+        for source_rel in file_paths:
+            source_path =3D snippets_dir / source_rel
+            # Use new dest_rel_path function to determine destination
+            dest_rel =3D dest_rel_path(source_rel)
+            dest_path =3D output_dir / dest_rel
+
+            if not source_path.exists():
+                logger.error(f"{rule_name}: config file '{source_path}' no=
t found")
+                errors +=3D 1
+                continue
+
+            logger.debug(f"copy {rule_name}: {source_rel} =E2=86=92 {dest_=
rel}")
+
+            # Create destination directory
+            dest_path.parent.mkdir(parents=3DTrue, exist_ok=3DTrue)
+            # Read source, substitute @@VALUE@@ if a value is configured
+            content =3D source_path.read_text()
+            if "@@VALUE@@" in content:
+                value =3D rule_values.get(rule_name)
+                if value is None:
+                    logger.error(
+                        f"{rule_name}: snippet contains @@VALUE@@ but no "
+                        f"'value' field is set in .config.json"
+                    )
+                    errors +=3D 1
+                    continue
+                content =3D content.replace("@@VALUE@@", value)
+                logger.debug(f"substituted @@VALUE@@=3D{value!r} in {sourc=
e_rel}")
+            dest_path.write_text(content)
+            mode =3D dest_mode(source_rel)
+            if mode is not None:
+                dest_path.chmod(mode)
+                logger.debug(f"set mode {mode:#o} on {dest_rel}")
+
+            processed_files +=3D 1
+
+    skipped_rules =3D len(enabled_rules) - len(
+        [r for r in enabled_rules if r in rule_files]
+    )
+    logger.debug(
+        f"Summary: {processed_files} config files processed, "
+        f"{skipped_rules} rules skipped (no config files found)"
+    )
+
+    return errors
+
+
+def setup_parser() -> argparse.ArgumentParser:
+    parser =3D argparse.ArgumentParser(
+        prog=3D"package-enabled-configs",
+        description=3D(
+            "Package enabled CIS hardening configuration snippets into a p=
artial "
+            "root directory for Debian package creation."
+        ),
+    )
+    parser.add_argument(
+        "--config",
+        type=3DPath,
+        required=3DTrue,
+        metavar=3D"FILE",
+        help=3D"Path to .config.json file containing rule selections",
+    )
+    parser.add_argument(
+        "--snippets-dir",
+        type=3DPath,
+        required=3DTrue,
+        metavar=3D"DIR",
+        help=3D"Directory containing generated config file snippets",
+    )
+    parser.add_argument(
+        "--output-dir",
+        type=3DPath,
+        required=3DTrue,
+        metavar=3D"DIR",
+        help=3D"Output directory for partial root filesystem structure",
+    )
+    return parser
+
+
+def main() -> None:
+    parser =3D setup_parser()
+    args =3D parser.parse_args()
+
+    logging.basicConfig(
+        level=3Dlogging.INFO,
+        format=3D"%(levelname)s: %(message)s",
+    )
+
+    # Validate inputs
+    if not args.config.is_file():
+        logger.error(f"config file '{args.config}' does not exist")
+        sys.exit(1)
+
+    if not args.snippets_dir.is_dir():
+        logger.error(f"snippets directory '{args.snippets_dir}' does not e=
xist")
+        sys.exit(1)
+
+    args.output_dir.mkdir(parents=3DTrue, exist_ok=3DTrue)
+
+    # Discover available config files
+    logger.debug(f"Discovering config files in: {args.snippets_dir}")
+    rule_files =3D discover_rule_files(args.snippets_dir, logger)
+
+    # Load configuration and get enabled rules
+    config =3D load_json(args.config, logger)
+    enabled_rules =3D get_enabled_rules(config)
+    rule_values =3D get_rule_values(config)
+
+    logger.debug(f"Loaded configuration from: {args.config}")
+    logger.info(f"Found {len(enabled_rules)} enabled rules")
+    if enabled_rules:
+        implementable_rules =3D enabled_rules & set(rule_files.keys())
+        logger.debug(f"Rules with config files available: {len(implementab=
le_rules)}")
+
+    if not enabled_rules:
+        logger.error("No rules are enabled (apply=3Dtrue) in the configura=
tion")
+        sys.exit(1)
+
+    # Package the configs
+    errors =3D package_configs(
+        enabled_rules,
+        rule_files,
+        rule_values,
+        args.snippets_dir,
+        args.output_dir,
+        logger,
+    )
+
+    if errors:
+        logger.error(f"{errors} error(s) occurred during packaging")
+        sys.exit(1)
+
+
+if __name__ =3D=3D "__main__":
+    main()
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel=
-config.py b/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel=
-config.py
new file mode 100755
index 00000000..285151dd
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/gen-kernel-config=
.py
@@ -0,0 +1,165 @@
+#!/usr/bin/env python3
+# SPDX-FileCopyrightText: 2026 Siemens AG
+# SPDX-License-Identifier: MIT
+"""
+Generate a Linux kernel config fragment for enabled CIS hardening rules
+from .config.json.
+
+Each rule maps kernel CONFIG symbols to explicit targets:
+    - y: built-in
+    - n: disabled (rendered as "# CONFIG_FOO is not set")
+
+The fragment can be dropped into a kernel build tree (e.g. via
+KCONFIG_ALLCONFIG or merge_config.sh) to enforce kernel option values at
+compile time.
+
+Usage:
+    python3 gen-kernel-config.py \\
+        --config generator/.config.json \\
+        --output hardening.cfg
+"""
+
+import json
+import logging
+import argparse
+from pathlib import Path
+import sys
+
+logger =3D logging.getLogger(__name__)
+
+
+def load_json(path: Path, logger: logging.Logger) -> dict:
+    """Load a JSON file. On error, log to stderr and exit with status 1.""=
"
+    try:
+        with Path(path).open() as f:
+            return json.load(f)
+    except (json.JSONDecodeError, OSError) as exc:
+        logger.error(f"Error loading file '{path}': {exc}")
+        sys.exit(1)
+
+
+def get_enabled_rules(config: dict) -> set[str]:
+    """Return the set of rule names where rule.apply is true and the name =
is non-empty."""
+    enabled: set[str] =3D set()
+    for entry in config.get("rules", []):
+        rule =3D entry.get("rule", {}) if isinstance(entry, dict) else {}
+        if rule.get("apply", False) and rule.get("name"):
+            enabled.add(rule["name"])
+    return enabled
+
+# ------------------------------------------------------------------------=
---
+# Mapping of CIS rule IDs to kernel CONFIG symbols and their target values=
.
+# A rule may map to more than one symbol (e.g. FAT covers three options).
+# ------------------------------------------------------------------------=
---
+RULE_KERNEL_OPTIONS: dict[str, dict] =3D {
+    "1.1.1.1": {
+        "description": "Disable Veritas VxFS filesystem",
+        "configs": {"CONFIG_VXFS_FS": "n"},
+    },
+    "1.1.1.2": {
+        "description": "Disable JFFS2 filesystem",
+        "configs": {"CONFIG_JFFS2_FS": "n"},
+    },
+    "1.1.1.3": {
+        "description": "Disable HFS filesystem",
+        "configs": {"CONFIG_HFS_FS": "n"},
+    },
+    "1.1.1.4": {
+        "description": "Disable HFS+ filesystem",
+        "configs": {"CONFIG_HFSPLUS_FS": "n"},
+    },
+    "1.1.1.5": {
+        "description": "Disable SquashFS filesystem",
+        "configs": {"CONFIG_SQUASHFS": "n"},
+    },
+    "1.1.1.6": {
+        "description": "Disable UDF filesystem",
+        "configs": {"CONFIG_UDF_FS": "n"},
+    },
+    "1.1.1.7": {
+        "description": "Disable FAT filesystems (FAT, MSDOS, VFAT)",
+        "configs": {
+            "CONFIG_FAT_FS": "n",
+            "CONFIG_MSDOS_FS": "n",
+            "CONFIG_VFAT_FS": "n",
+        },
+    },
+    "1.1.1.8": {
+        "description": "Disable cramfs filesystem",
+        "configs": {"CONFIG_CRAMFS": "n"},
+    },
+    "1.1.23": {
+        "description": "Disable USB storage",
+        "configs": {"CONFIG_USB_STORAGE": "n"},
+    },
+}
+
+
+def setup_parser():
+    parser =3D argparse.ArgumentParser(
+        description=3D"Generate a kernel config fragment for "
+                    "enabled CIS hardening rules."
+    )
+    parser.add_argument(
+        "--config",
+        type=3DPath,
+        required=3DTrue,
+        metavar=3D"FILE",
+        help=3D"Path to generator/.config.json",
+    )
+    parser.add_argument(
+        "--output",
+        type=3DPath,
+        required=3DTrue,
+        metavar=3D"FILE",
+        help=3D"Output kernel config fragment path",
+    )
+    return parser
+
+
+def main():
+    parser =3D setup_parser()
+    args =3D parser.parse_args()
+
+    logging.basicConfig(
+        level=3Dlogging.INFO,
+        format=3D"%(levelname)s: %(message)s",
+    )
+
+    config =3D load_json(args.config, logger)
+    enabled_rules =3D get_enabled_rules(config)
+
+    active =3D [
+        (rule_id, RULE_KERNEL_OPTIONS[rule_id])
+        for rule_id in sorted(RULE_KERNEL_OPTIONS)
+        if rule_id in enabled_rules
+    ]
+
+    args.output.parent.mkdir(parents=3DTrue, exist_ok=3DTrue)
+    with args.output.open("w") as f:
+        f.write(
+            "# CIS hardening kernel config fragment\n"
+            "# Generated by generator/gen-kernel-config.py - do not edit.\=
n"
+            "# Values: y=3Dbuilt-in, n=3Ddisabled\n"
+            "\n"
+        )
+
+        for rule_id, entry in active:
+            f.write(f"# CIS {rule_id}: {entry['description']}\n")
+            for symbol, value in entry["configs"].items():
+                if value =3D=3D "n":
+                    f.write(f"# {symbol} is not set\n")
+                else:
+                    f.write(f"{symbol}=3D{value}\n")
+            f.write("\n")
+
+    logger.info(
+        f"Generated {args.output} with {len(active)} rule(s) "
+        f"({sum(len(e['configs']) for _, e in active)} CONFIG symbols)."
+    )
+    if not active:
+        logger.info("  No kernel-relevant rules are currently enabled.")
+
+
+if __name__ =3D=3D "__main__":
+    main()
diff --git a/recipes-security/cip-cis-rules-config/files/scripts/select-har=
denings.py b/recipes-security/cip-cis-rules-config/files/scripts/select-har=
denings.py
new file mode 100755
index 00000000..1392767a
--- /dev/null
+++ b/recipes-security/cip-cis-rules-config/files/scripts/select-hardenings=
.py
@@ -0,0 +1,616 @@
+#!/usr/bin/env python3
+#
+# Based on the kas menu plugin
+# Copyright (c) Siemens AG, 2021-2023
+# Copyright (c) 2011-2019, Ulf Magnusson <ulfalizer@gmail.com>
+# SPDX-License-Identifier: MIT
+#
+
+import argparse
+import json
+import logging
+import pathlib
+import re
+import sys
+import traceback
+
+from kconfiglib import (
+    Kconfig,
+    Symbol,
+    Choice,
+    expr_value,
+    TYPE_TO_STR,
+    MENU,
+    COMMENT,
+    STRING,
+    BOOL,
+    INT,
+    HEX,
+    UNKNOWN,
+)
+
+from snack import (
+    SnackScreen,
+    EntryWindow,
+    ButtonChoiceWindow,
+    ButtonBar,
+    Listbox,
+    GridFormHelp,
+)
+
+logger =3D logging.getLogger(__name__)
+
+
+class Menuconfig:
+    def __init__(self, kconf):
+        self.kconf =3D kconf
+        self.screen =3D None
+
+    @staticmethod
+    def value_str(sym):
+        if sym.type in (STRING, INT, HEX):
+            return f"({sym.str_value})"
+
+        if sym.choice and sym.visibility =3D=3D 2:
+            return "(*)" if sym.choice.selection is sym else "( )"
+
+        tri_val_str =3D (" ", None, "*")[sym.tri_value]
+
+        if len(sym.assignable) =3D=3D 1:
+            return f"-{tri_val_str}-"
+
+        if sym.type =3D=3D BOOL:
+            return f"[{tri_val_str}]"
+
+        raise RuntimeError()
+
+    @staticmethod
+    def node_str(node, indent):
+        if not node.prompt:
+            return ""
+
+        prompt, prompt_cond =3D node.prompt
+        if not expr_value(prompt_cond):
+            return ""
+
+        if node.item =3D=3D MENU:
+            return f"    {indent * ' '}{prompt}  --->"
+
+        if type(node.item) is Choice:
+            return f"    {indent * ' '}{prompt}"
+
+        if node.item =3D=3D COMMENT:
+            return f"    {indent * ' '}*** {prompt} ***"
+
+        sym =3D node.item
+
+        if sym.type =3D=3D UNKNOWN:
+            return ""
+
+        res =3D f"{Menuconfig.value_str(sym):3} {indent * ' '}{prompt}"
+
+        if node.is_menuconfig:
+            res +=3D f"  ---{'>' if sym.tri_value > 0 else '-'}"
+
+        return res
+
+    @staticmethod
+    def menu_node_strings(node, indent):
+        items =3D []
+
+        while node:
+            string =3D Menuconfig.node_str(node, indent)
+            if string:
+                items.append((string, node))
+
+            if (
+                node.list
+                and node.item !=3D MENU
+                and (type(node.item) is Choice or not node.is_menuconfig)
+            ):
+                items.extend(Menuconfig.menu_node_strings(node.list, inden=
t + 2))
+
+            node =3D node.next
+
+        return items
+
+    def show_menu(self, title, top_node, is_submenu=3DFalse):
+        selection =3D 0
+
+        while True:
+            items =3D Menuconfig.menu_node_strings(top_node, 0)
+
+            height =3D len(items)
+            window_width =3D 60
+
+            scroll =3D 0
+            if height > self.screen.height - 13:
+                height =3D self.screen.height - 13
+                scroll =3D 1
+
+            buttons =3D [
+                ("Save & Exit", "save", "S"),
+                (" Exit ", "exit", "E"),
+                (" Help ", "help", "h"),
+            ]
+            if is_submenu:
+                buttons.insert(0, (" Return ", "return", "ESC"))
+            buttonbar =3D ButtonBar(self.screen, buttons)
+            if not is_submenu:
+                buttonbar.hotkeys["ESC"] =3D "exit"
+            listbox =3D Listbox(height, width=3Dwindow_width, scroll=3Dscr=
oll, returnExit=3D1)
+            count =3D 0
+            for string, _ in items:
+                listbox.append(string, count)
+                if selection =3D=3D count:
+                    listbox.setCurrent(count)
+                count +=3D 1
+
+            grid =3D GridFormHelp(self.screen, title, None, 1, 2)
+            grid.add(listbox, 0, 0, padding=3D(0, 0, 0, 1))
+            grid.add(buttonbar, 0, 1, growx=3D1)
+            grid.addHotKey(" ")
+
+            # Snapshot the active CIS level so we can detect level changes
+            # caused by the user action below and re-derive rule defaults.
+            level_before =3D _selected_level(self.kconf)
+
+            rc =3D grid.runOnce()
+
+            action =3D buttonbar.buttonPressed(rc)
+            if action and action !=3D "help":
+                return action
+
+            if count =3D=3D 0:
+                continue
+
+            selection =3D listbox.current()
+            _, selected_node =3D items[selection]
+            sym =3D selected_node.item
+
+            if action =3D=3D "help":
+                prompt, _ =3D selected_node.prompt
+                if selected_node.help:
+                    help_text =3D selected_node.help
+                else:
+                    help_text =3D "No help available."
+                ButtonChoiceWindow(
+                    screen=3Dself.screen,
+                    title=3Df"Help on '{prompt}'",
+                    text=3Dhelp_text,
+                    width=3Dwindow_width,
+                    buttons=3D["  Ok  "],
+                )
+                continue
+
+            show_submenu =3D False
+
+            if type(sym) is Symbol:
+                if rc =3D=3D " ":
+                    if sym.type =3D=3D BOOL:
+                        sym.set_value("n" if sym.tri_value > 0 else "y")
+                else:
+                    if selected_node.is_menuconfig:
+                        show_submenu =3D True
+                    elif sym.type in (STRING, INT, HEX):
+                        action, values =3D EntryWindow(
+                            screen=3Dself.screen,
+                            title=3Dsym.name,
+                            text=3Df"Enter a {TYPE_TO_STR[sym.type]} value=
:",
+                            prompts=3D[("", sym.str_value)],
+                            width=3D80,
+                            entryWidth=3D80,
+                            buttons=3D[("  Ok  ", "Ok"), ("Cancel", "", "E=
SC")],
+                        )
+                        if action =3D=3D "Ok":
+                            self.kconf.warnings =3D []
+                            val =3D values[0]
+                            if sym.type =3D=3D HEX and not val.startswith(=
"0x"):
+                                val =3D "0x" + val
+                            sym.set_value(val)
+                            sym.str_value
+                            if len(self.kconf.warnings) > 0:
+                                ButtonChoiceWindow(
+                                    screen=3Dself.screen,
+                                    title=3D"Invalid entry",
+                                    text=3D"\n".join(self.kconf.warnings),
+                                    width=3Dwindow_width,
+                                    buttons=3D["  Ok  "],
+                                )
+                                self.kconf.warnings =3D []
+            elif selected_node.is_menuconfig and type(sym) is not Choice:
+                show_submenu =3D True
+
+            if show_submenu:
+                submenu_title, _ =3D selected_node.prompt
+                action =3D self.show_menu(
+                    submenu_title, selected_node.list, is_submenu=3DTrue
+                )
+                if action !=3D "return":
+                    return action
+
+            # If the user just switched CIS_LEVEL_N, drop any user overrid=
es
+            # on rule symbols so the new level's `default y if CIS_LEVEL_=
=E2=80=A6`
+            # clauses take effect and every rule required by the new level
+            # is enabled by default.  Justifications and the level symbols
+            # themselves are preserved.
+            level_after =3D _selected_level(self.kconf)
+            if (
+                level_before is not None
+                and level_after is not None
+                and level_after !=3D level_before
+            ):
+                cleared =3D _reset_rule_overrides(self.kconf)
+                ButtonChoiceWindow(
+                    screen=3Dself.screen,
+                    title=3D"Hardening level changed",
+                    text=3D(
+                        f"Switched from level {level_before} to level "
+                        f"{level_after}.\n\n"
+                        f"All rule selections were reset to the level "
+                        f"{level_after} defaults ({cleared} prior override=
"
+                        f"{'s' if cleared !=3D 1 else ''} discarded).\n\n"
+                        "Per-rule justifications were kept."
+                    ),
+                    width=3Dwindow_width,
+                    buttons=3D["  Ok  "],
+                )
+
+    def show(self):
+        self.screen =3D SnackScreen()
+
+        action =3D self.show_menu(self.kconf.mainmenu_text, self.kconf.top=
_node.list)
+
+        self.screen.finish()
+        return action
+
+
+def _collect_level_numbers(expr):
+    """Return the set of integer level numbers for all CIS_LEVEL_N symbols=
 in a kconfiglib expr."""
+    from kconfiglib import Symbol as _Symbol
+
+    levels =3D set()
+    if isinstance(expr, _Symbol):
+        m =3D re.match(r"^CIS_LEVEL_(\d+)$", expr.name)
+        if m:
+            levels.add(int(m.group(1)))
+    elif isinstance(expr, tuple):
+        for sub in expr[1:]:
+            levels |=3D _collect_level_numbers(sub)
+    return levels
+
+
+_LEVEL_RE =3D re.compile(r"^CIS_LEVEL_(\d+)$")
+
+
+def _selected_level(kconf):
+    """Return the integer N of the currently selected CIS_LEVEL_N choice, =
or None."""
+    for n in range(1, 6):
+        sym =3D kconf.syms.get(f"CIS_LEVEL_{n}")
+        if sym is not None and sym.tri_value =3D=3D 2:
+            return n
+    return None
+
+
+def _reset_rule_overrides(kconf):
+    """Clear user-set values on every CIS_<id> rule symbol so that the
+    Kconfig ``default y if CIS_LEVEL_N || =E2=80=A6`` clauses take effect =
again.
+
+    This is invoked whenever the user picks a different CIS_LEVEL_N in the
+    menu so that switching level immediately enables the rules required by
+    the newly-selected level (and disables any that the old level required
+    but the new one does not).
+
+    CIS_LEVEL_N symbols themselves and the *_JUSTIFICATION string symbols
+    are intentionally left alone:
+
+      * resetting the level symbols would re-trigger us recursively;
+      * justifications belong to the operator, not the level, and would be
+        lost on every level change.
+
+    Site-specific string symbols (e.g. ``CIS_2_2_1_3_SERVER``,
+    ``CIS_5_2_18_GROUPS``, ``CIS_5_3_3_REMEMBER``) are likewise preserved
+    so the operator does not lose typed-in values when bumping levels.
+
+    Returns the number of rule symbols whose override was cleared.
+    """
+    cleared =3D 0
+    for name, sym in kconf.syms.items():
+        if not name.startswith("CIS_"):
+            continue
+        if _LEVEL_RE.match(name):
+            continue
+        if name.endswith("_JUSTIFICATION"):
+            continue
+        # Preserve user-supplied site-specific values (e.g. NTP server,
+        # SSH allowed groups, password-history depth) =E2=80=94 these are =
not
+        # tied to a particular hardening level.
+        if sym.type =3D=3D STRING:
+            continue
+        # ``user_value`` is None iff the symbol has no explicit user overr=
ide.
+        if getattr(sym, "user_value", None) is not None:
+            sym.unset_value()
+            cleared +=3D 1
+    return cleared
+
+
+def _find_value_symbol(kconf, rule_sym_name):
+    """Return the user-tunable string symbol associated with rule
+    *rule_sym_name* (e.g. ``CIS_5_3_3``), or ``None`` if the rule has no
+    site-specific parameter.
+
+    The convention is that a rule ``CIS_<id>`` may have one companion
+    string symbol named ``CIS_<id>_<SUFFIX>`` (e.g. ``CIS_5_3_3_REMEMBER``=
,
+    ``CIS_2_2_1_3_SERVER``, ``CIS_5_2_18_GROUPS``) whose value is
+    substituted for ``@@VALUE@@`` in the rule's snippet.  The
+    ``_JUSTIFICATION`` companion symbol is excluded =E2=80=94 it is operat=
or
+    bookkeeping, not a snippet value.
+    """
+    prefix =3D rule_sym_name + "_"
+    for name, sym in kconf.syms.items():
+        if (
+            name.startswith(prefix)
+            and not name.endswith("_JUSTIFICATION")
+            and sym.type =3D=3D STRING
+        ):
+            return sym
+    return None
+
+
+_SCHEMA_PATH =3D pathlib.Path(__file__).parent / "config.schema.json"
+
+
+def _validate_json(rules):
+    """Validate *rules* against config.schema.json.
+
+    Requires the ``jsonschema`` package.  Raises ``ImportError`` when the
+    package is not installed, or ``jsonschema.ValidationError`` when the
+    data does not conform to the schema.
+    """
+    try:
+        import jsonschema
+    except ImportError as exc:
+        raise ImportError(
+            "jsonschema is required for schema validation: "
+            "install it with 'pip install jsonschema'"
+        ) from exc
+
+    with open(_SCHEMA_PATH) as f:
+        schema =3D json.load(f)
+
+    jsonschema.validate(instance=3Drules, schema=3Dschema)
+
+
+def save_as_json(kconf, path):
+    """Export the current Kconfig selection state to a JSON file.
+
+    The output is an object with two keys:
+
+    * ``level`` =E2=80=94 the currently selected CIS hardening level (1=E2=
=80=935)
+    * ``rules`` =E2=80=94 list of rule objects::
+
+          {"rule": {"name": "1.1.1.1", "description": "...", "level": 2,
+                    "apply": true, "justification": "..."}}
+
+    The ``justification`` key is only present when the corresponding
+    ``CIS_<ID>_JUSTIFICATION`` symbol has a non-empty string value.
+
+    After writing, the file is validated against config.schema.json locate=
d
+    in the same directory as this script.  A ``jsonschema.ValidationError`=
`
+    is raised if the output does not conform to the schema.
+    """
+    selected_level =3D _selected_level(kconf)
+
+    rules =3D []
+    for name, sym in sorted(kconf.syms.items()):
+        if (
+            not name.startswith("CIS_")
+            or name.startswith("CIS_LEVEL_")
+            or name.endswith("_JUSTIFICATION")
+            or sym.type !=3D BOOL
+            or not sym.nodes
+        ):
+            continue
+
+        node =3D sym.nodes[0]
+        if not node.prompt:
+            continue
+        prompt_text =3D node.prompt[0]
+
+        # Parse "1.1.1.1 - disable freevxfs (2)" -> cis_number, descriptio=
n
+        m =3D re.match(r"^([\d.]+)\s*-\s*(.+?)(?:\s*\(\d+\))?$", prompt_te=
xt)
+        cis_number =3D m.group(1).strip() if m else name
+        description =3D m.group(2).strip() if m else prompt_text
+
+        # Minimum level from the first `default y if` condition
+        level =3D None
+        for _val, cond in sym.defaults:
+            nums =3D _collect_level_numbers(cond)
+            if nums:
+                level =3D min(nums)
+                break
+
+        if level is None:
+            logger.warning(
+                "save_as_json: could not determine CIS level for symbol '%=
s', skipping",
+                name,
+            )
+            continue
+
+        rule =3D {
+            "name": cis_number,
+            "description": description,
+            "level": level,
+            "apply": sym.tri_value =3D=3D 2,
+        }
+
+        # justification: only when the symbol exists and has a non-empty v=
alue
+        just_sym =3D kconf.syms.get(name + "_JUSTIFICATION")
+        if just_sym and just_sym.str_value:
+            rule["justification"] =3D just_sym.str_value
+
+        # value: only when the rule has a companion string symbol with a
+        # non-empty value =E2=80=94 used for snippets containing @@VALUE@@=
.
+        val_sym =3D _find_value_symbol(kconf, name)
+        if val_sym and val_sym.str_value:
+            rule["value"] =3D val_sym.str_value
+
+        rules.append({"rule": rule})
+
+    if selected_level is None:
+        raise ValueError(
+            "save_as_json: no CIS level selected =E2=80=94 set one of the =
CIS_LEVEL_N symbols"
+        )
+
+    output =3D {
+        "level": selected_level,
+        "rules": rules,
+    }
+
+    with open(path, "w") as f:
+        json.dump(output, f, indent=3D2)
+
+    _validate_json(output)
+
+
+def load_config_json(kconf, path):
+    """Load a previously saved JSON config file and apply it to *kconf*.
+
+    The file is validated against config.schema.json before any symbols ar=
e
+    touched.  The following is applied from the file:
+
+    * ``level`` =E2=80=94 sets the matching ``CIS_LEVEL_N`` choice symbol =
to ``y``.
+    * For each rule in ``rules``:
+
+      - The corresponding ``CIS_<id>`` bool symbol is set to ``y`` or ``n`=
`
+        according to the ``apply`` field.
+      - When a non-empty ``justification`` value is present, it is written=
 to
+        the matching ``CIS_<id>_JUSTIFICATION`` string symbol.
+      - Unknown rule names (no matching symbol in *kconf*) are logged as
+        warnings and skipped.
+
+    Raises ``FileNotFoundError`` when *path* does not exist,
+    ``jsonschema.ValidationError`` when the file fails schema validation, =
and
+    ``json.JSONDecodeError`` when the file is not valid JSON.
+    """
+    with open(path) as f:
+        data =3D json.load(f)
+
+    # Apply selected level
+    level_sym =3D kconf.syms.get(f"CIS_LEVEL_{data['level']}")
+    if level_sym is not None:
+        level_sym.set_value("y")
+    else:
+        raise ValueError(
+            f"load_config_json: unknown CIS level '{data['level']}' in '{p=
ath}'"
+        )
+
+    # Apply rules
+    for entry in data["rules"]:
+        rule =3D entry["rule"]
+        # "1.1.1.1" -> "CIS_1_1_1_1"
+        sym_name =3D "CIS_" + rule["name"].replace(".", "_")
+
+        sym =3D kconf.syms.get(sym_name)
+        if sym is None:
+            logger.warning("load_config_json: unknown rule '%s', skipping"=
, sym_name)
+            continue
+
+        sym.set_value("y" if rule["apply"] else "n")
+
+        justification =3D rule.get("justification")
+        if justification:
+            just_sym =3D kconf.syms.get(sym_name + "_JUSTIFICATION")
+            if just_sym is not None:
+                just_sym.set_value(justification)
+            else:
+                logger.warning(
+                    "load_config_json: no JUSTIFICATION symbol for '%s', s=
kipping",
+                    sym_name,
+                )
+
+        value =3D rule.get("value")
+        if value:
+            val_sym =3D _find_value_symbol(kconf, sym_name)
+            if val_sym is not None:
+                val_sym.set_value(value)
+            else:
+                logger.warning(
+                    "load_config_json: no value symbol for '%s', skipping"=
,
+                    sym_name,
+                )
+
+    logger.info(
+        "Loaded level %d and %d rules from %s", data["level"], len(data["r=
ules"]), path
+    )
+
+
+def setup_parser():
+    parser =3D argparse.ArgumentParser(
+        prog=3D"select-hardenings",
+        description=3D"Interactive menu for selecting CIS hardening rules"=
,
+    )
+    parser.add_argument("kconfig", help=3D"Kconfig file", nargs=3D"?", def=
ault=3D"Kconfig")
+    parser.add_argument(
+        "--output", help=3D"Output .config.json file", default=3D".config.=
json"
+    )
+    parser.add_argument("--level", help=3D"set the hardening level", defau=
lt=3D"2")
+    parser.add_argument(
+        "--non-interactive",
+        help=3D"skip the menu-config and generate a configuration for the =
given level",
+        action=3D"store_true",
+    )
+    return parser
+
+
+def main():
+    parser =3D setup_parser()
+    args =3D parser.parse_args()
+
+    logging.basicConfig(
+        level=3Dlogging.INFO,
+        format=3D"%(levelname)s: %(message)s",
+    )
+
+    kconf =3D Kconfig(args.kconfig, warn=3DFalse)
+    json_path =3D args.output
+    try:
+        load_config_json(kconf, json_path)
+    except FileNotFoundError:
+        logger.warning("no configuration found")
+
+    save_config =3D False
+    if not args.non_interactive:
+        menu =3D Menuconfig(kconf)
+        action =3D menu.show()
+        if action !=3D "exit":
+            save_config =3D True
+    else:
+        save_config =3D True
+        try:
+            requested_level =3D int(args.level)
+        except (TypeError, ValueError):
+            logger.error("Invalid hardening level '%s'. Valid levels: 1-5.=
", args.level)
+            sys.exit(1)
+        if _selected_level(kconf) !=3D requested_level:
+            level_sym =3D kconf.syms.get(f"CIS_LEVEL_{requested_level}")
+            if level_sym is None:
+                logger.error("Unknown hardening level '%s'. Valid levels: =
1-5.", args.level)
+                sys.exit(1)
+            level_sym.set_value("y")
+
+    if save_config:
+        kconf.write_config(args.output)
+        try:
+            save_as_json(kconf, json_path)
+            logger.info("Hardening rules written to: %s", json_path)
+        except Exception:
+            error_path =3D json_path + ".error"
+            with open(error_path, "w") as f:
+                traceback.print_exc(file=3Df)
+            logger.error("save_as_json failed =E2=80=94 details in %s", er=
ror_path)
+            sys.exit(1)
+
+
+if __name__ =3D=3D "__main__":
+    main()
--=20
2.55.0


