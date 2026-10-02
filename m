Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A5CA5FE8
	for <webhook@archiver.kernel.org>; Fri,  2 Oct 2026 11:20:06 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.53])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9457.1790940002646661841
 for <cip-dev@lists.cip-project.org>;
 Fri, 02 Oct 2026 04:20:03 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=I0kna80k;
 spf=pass (domain: siemens.com, ip: 52.101.84.53, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=poOUigK7fDP/Z7RsAfENHfKU+iP8/fmQIcUoekd1fBcN2IPWu2hWGRqDh2nFVUhETETXKstrPXvcpqJK+Dk8BGbERoWdvYhl1T4d5v6XV7PI7BmoJmjl4DzedfWODjJPtC90z/aWgCxZDuwC65fXLWL0IG9n4vK9X6AV9sy7aF5DRNmLBKOjvDkUz4hB86RI0pC75lNCjsmqsv86Dg55h+9p1z8VRTkY0Ofx2A6YlTDtgil8CfumyvPaQFf92N8sAW5J4qfzsmTVhSE0dE9HhPfOr+0KaIt8+hcJgMloi7UlLUAADaSSoiCWUhDs5MLYGK1enBKzN2jp8+zCQgFgMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b+j1wn4iLGbHT6ha7PMtwygCU4K1bQlPpkMJt18PqQ=;
 b=pfDmUMAs/dLmLLkX9c+wblsP96xc1kGS1XPteHQqgKySc8S3S6NzyDRMlmx7VhCa6buJm16cZuvAvK/tQpz5ec6WVa0cpdif5RpTYC8+ayczn2w6TgYOaAPjSSnHBOpwJtdgZk9OO0LLyRsEm40521ROE6dJjh1Hydbkxo6Jg5Fmmoxfpx5U/qkGNc4pDb3N7tWMzi08yPruPt8aq0TGbNvk4H/3d7Zl/8QV7JBPwuNr41X5nen6mxNZ7dco/vXdBSDCRkiu+lD25ZaECFO1ERA1sEj8kUTtQVszjT6NdAjdb+dasSta1j43DFEvkLzCn12o9rvzKdXQo2pLKG0r9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b+j1wn4iLGbHT6ha7PMtwygCU4K1bQlPpkMJt18PqQ=;
 b=I0kna80k6EE171UIkrpLJgXKBX7pn9OIaj1myaWQ8bO0x9h80lv/RS9sRnbo0zc4nW5+8Cf0EuGtAJ/f82/0ri3DodDjJ5f3apWk8PjZNqEvVjndOB6B9BGRWxxX3mL+wTv2uUTQESDXVKpGK02jlY1ln6j88/Lzd7/DEawaJ1a359aDx/uqf5QfGW+xeqmiAWVaw252rxM633RQiwkSYAaxe/OWB/qnY+bIXCeloLlJ3yxyTZ9ZrwX2RBvOtn0efKoewvZNQcOCHKPR+F3G9s0P0A7vxpc2b9MK7Fds2HRqTAVU5ZDs+PRUCwVdbb6t4jGbwHg4bz4GAKjoGgMF1Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9311.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 11:19:51 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0472.016; Fri, 2 Oct 2026
 11:19:50 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: felix.moessbauer@siemens.com,
	jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	cedric.hombourger@siemens.com
Subject: [isar-cip-core][RFC 06/11] dracut-config-cip-*: add build configuration packages
Date: Fri,  2 Oct 2026 13:18:53 +0200
Message-ID: <20261002111938.3600786-7-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
References: <20261002111938.3600786-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c9::17) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9311:EE_
X-MS-Office365-Filtering-Correlation-Id: 671491a7-1daf-47d5-8717-08df207712b2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|6133799003|3023799007|10067099003|11063799006|56012099006|55112099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	W0tTZmXQWqUR1IYtnZWB2qZRn0bjpyIYStN2b+EnymZEulKnaixUrh3WSqkkfit6/3leQ87LMUTnQRp03UqkHoQmXi9cbdLRyxTdebWIGvtc9faiFLjfV0SEnx+0XRlQGsEhb6F31WW9uvrhFiJyMr9mfgM+glIsLKVjBG2p6XYgRMfu1qqlCKJ+u7lnik3R9cHPUxeyR6+dqT2yJYed7mIl1rqnVDjpmbpTZOS91f6x9dgkzCJm9AqOu0divSLrEQdp5BZ4EbTzUWTre9ojYnWaKrAr9wx0XRGVgH5acIS7lGhO/7xQF6ivSpJFQD0AyjBw8twppd7gGWtOqtPmqAimWBfykSuIc79GRVfH8NTnw6eGSjEH0pbW+EfeV/jP5YqykdL02hx/Bm00zJ0mNjXkHS6uRoNNiSXQGMRooxJ6b6mAdzA4jTQtwKI6Mq/IX/AvtsJSkLGC8zT/i6JqE87bDWrQWyiUdNfZqGOg+WgvHQoJEOZ3QDBkg62b/CQg4lSV4uAGBVaN48czwMQmREYlJa7lLJthLHIpqZzhwHoqtpSLlBLPczdi6ws+MFIhsTVtefVJ5IQW/sPASsPc6rGcUE/QAGfmT/9HAcsF3gY83UOO5lTXKWRvClePte4HtKHsqssriQn/kJ+CIixLw5LBac8+oe3qouFtgAhWr2s=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(3023799007)(10067099003)(11063799006)(56012099006)(55112099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rn+HCuPRei2hRxymq/p1aQCyCHd2/uurUmpqSfQPZvPXMYabDXn26FxuNpQn?=
 =?us-ascii?Q?2b6hJsu4xm8S6bskoEL92VKJwCy8vt4TXm2LUy5YAsPRBQVS4a48wpAd244q?=
 =?us-ascii?Q?bDW/F+gxTK0YDXXl+mT6WODyhvrUohFcXBsd16711j6VcU3CwzoyqwCalVyW?=
 =?us-ascii?Q?O8iJOpWHVGEoQ3yAN3kxjR3a15O8bjEmv9v6s4RP6rNNC69BLcBeLPsZo3N1?=
 =?us-ascii?Q?eplyxvvao83iwdeEQRqB5dicxEtLzFvAMU+yuMt2hWNRp7XwBbnLGua2plNu?=
 =?us-ascii?Q?3rZWcIu8a8FPalpeCwV/310sKtxq3LWb9iQyz/bqgKRyI4tu8nhSsRFdA79+?=
 =?us-ascii?Q?x+z/V7S2tjtYuLizR5gztfT0agN8Wt9IJuj7cag2VMqwN6OW4pXylq+Elrus?=
 =?us-ascii?Q?PjRoriPYF1qOxWOTJrB5dlchSVqhQGPBVjVIgl+TQFBOLBA6m7rRAfjKy8i0?=
 =?us-ascii?Q?DZbhmlc12a8SRgsepKJNBu1pD1mMSP1ef0Qux4n//OB8H5i6rsYm6xS1PONb?=
 =?us-ascii?Q?e1dN0Y1ZeoFoM5F7Ng4rw9zrdrf5x0RlCxx21QHT76nqUO0xQA0oilIxRAaM?=
 =?us-ascii?Q?hoef5BCzAzUoUy3nM7xsyzTV2wgZ/atCAAzXH3c2gUyZyZH4ImXwG5obz5Hl?=
 =?us-ascii?Q?EP/GhYMevLZApBQ/0+aPFFLal/+G1FlHJcgcBHFiIowHkHhAWdRGHkFoAZlC?=
 =?us-ascii?Q?iPrVVF3h4MprxstQ4oomrFpRcgJPSPDHrAQS3xmayt+xsxZTxUiZx8VWFZFB?=
 =?us-ascii?Q?WoAuUuMT1WxYFx7RSYnhkBtd5JhguHq5oIa11D8RTVw/7ISUC5RG2lr1WKfO?=
 =?us-ascii?Q?Ph+WJa+lLHAzqdVaWW+siUE9qbkebMO4idJBW1dEqrf0aoIBXxRaQvN2nQNS?=
 =?us-ascii?Q?g506OEhRykr7JIfXbDs7qEYzNJzZOdy4ovUqjkX2QN8XLJOnO0DYy1CU5qCz?=
 =?us-ascii?Q?+GxMTotsZrNgRYhpkshn5Bz7K685QG8jKuRDGTOYe+26efFheIQaF7gbAu/+?=
 =?us-ascii?Q?pfKLs83ntjcShVdhd8MKyOyqtu+CstFoFCXO5Hom4WUaBDfTbjXBnlKfjhl5?=
 =?us-ascii?Q?3GgUwU3p/NLrrsqZVkC1FyR12J1Qp1M7X2DJqsnUIuQg/0adBZ7aDAeMTv2G?=
 =?us-ascii?Q?bY2UTvnGuG56WTP/kisPNwyhUV+QK+j2HQbLU8iWkTxcT/Fvy3BB4prLHoI9?=
 =?us-ascii?Q?7IUyxXOrW6+SZtJgOyAj1HKHB+qUf+T8J6BicuvcyNniV9Vn1VUWzYXwt0Ut?=
 =?us-ascii?Q?X3gxBl1xtMKQ8zuUWzAIHTrUIMYkoInjw51R2UyNtFLPsdw6TUQIBdNUbNYe?=
 =?us-ascii?Q?XqqU8qk/RlC2AOUNg4nPQFWmclIyI7nW7qlhkIhcRIHS8XHtjMCJ5N/Z394j?=
 =?us-ascii?Q?zUNhDfY+eRrmltY2ZY4dek0KRzcHuPgzXyKUJHz9gOdB6li2e4noJUoEOXj9?=
 =?us-ascii?Q?bYeZACE3GdWmOFMOu75OqNwdEx7KVmu1qKwedZUwL/cUIVnQKuWJfAFyskw1?=
 =?us-ascii?Q?hJp9MvGYHcQnYVNQXrcVUpoxB2nyDbmknQBunJGebf9QjdslXmOGH0BWJZ83?=
 =?us-ascii?Q?3SgXmg9zPFuPuDd7VoPhbbfofv2CWjqkGjWy23tYAlnF/2jpzuonlbUwOyXV?=
 =?us-ascii?Q?BgwSQrOpPvrOaKiEub6YGT0GUrniujodsHpuUynxFkPOGUW+XRkJ6QZVNgiB?=
 =?us-ascii?Q?cB71ObkXWIHQYEdWufqRHzgTH+Pa4lE861X9QQKJcwEqen15tS4DbypL2Dwv?=
 =?us-ascii?Q?t3DKexPo8rGkEj9FwSqCxmWe+a4hhu8=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 671491a7-1daf-47d5-8717-08df207712b2
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 11:19:49.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQ6D1FJjZuCa7B/mWy8n/e5W6zBmmzDLvSqE0R+TEFlsqCbv5GyYp/Ph4c717eS5ZLb90DMaD97hFdZ0eo6PKt2Ao7DN+jCQWadIgQDQ9Ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9311
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 02 Oct 2026 11:20:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24410

One package per dracut module writes the existing BitBake configuration
(INITRAMFS_OVERLAY_*, CRYPT_*, INITRAMFS_FACTORY_RESET_*,
DRACUT_VERITY_DEVICE_TIMEOUT) to /etc/dracut-cip/cip-<module>.conf and
depends on the matching module package. Values are validated at build
time, not at parse time, so other configurations are not affected.

dracut-config-cip-crypt also generates the crypttab for
CRYPT_PARTITIONS and installs it as /etc/crypttab from its postinst,
as cryptsetup already creates that file.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/dracut-cip-config.bbclass      | 54 ++++++++++++
 .../dracut-config-cip-crypt_0.1.bb            | 86 +++++++++++++++++++
 .../dracut-config-cip-crypt/files/postinst    | 10 +++
 .../dracut-config-cip-factory-reset_0.1.bb    | 49 +++++++++++
 .../dracut-config-cip-overlay_0.1.bb          | 44 ++++++++++
 .../dracut-config-cip-verity_0.1.bb           | 23 +++++
 .../dracut-config-cip-watchdog_0.1.bb         | 30 +++++++
 7 files changed, 296 insertions(+)
 create mode 100644 classes-recipe/dracut-cip-config.bbclass
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/dracut-config=
-cip-crypt_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-crypt/files/postins=
t
 create mode 100644 recipes-initramfs/dracut-config-cip-factory-reset/dracu=
t-config-cip-factory-reset_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-overlay/dracut-conf=
ig-cip-overlay_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-verity/dracut-confi=
g-cip-verity_0.1.bb
 create mode 100644 recipes-initramfs/dracut-config-cip-watchdog/dracut-con=
fig-cip-watchdog_0.1.bb

diff --git a/classes-recipe/dracut-cip-config.bbclass b/classes-recipe/drac=
ut-cip-config.bbclass
new file mode 100644
index 00000000..2714243e
--- /dev/null
+++ b/classes-recipe/dracut-cip-config.bbclass
@@ -0,0 +1,54 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+# Writes CFG_VARS as KEY=3D'value' to /etc/dracut-cip/${CONF_NAME}.
+# CFG_VAR_SRC[KEY] =3D "VAR" takes the value of KEY from VAR instead.
+# Recipes validate values in dracut_cip_validate and extend do_install
+# with :append.
+
+inherit dpkg-raw
+
+MAINTAINER =3D "cip-dev <cip-dev@lists.cip-project.org>"
+
+DEPENDS +=3D "embedded-dracut-modules"
+
+CONF_NAME ?=3D ""
+CFG_VARS ?=3D ""
+
+def dracut_cip_cfg_srcs(d):
+    return ' '.join(d.getVarFlag('CFG_VAR_SRC', v) or v
+                    for v in (d.getVar('CFG_VARS') or '').split())
+
+python dracut_cip_validate() {
+    pass
+}
+
+python do_validate_dracut_config() {
+    if not d.getVar('CONF_NAME'):
+        bb.fatal("CONF_NAME must be set")
+    for v in d.getVar('CFG_VARS').split():
+        val =3D d.getVar(d.getVarFlag('CFG_VAR_SRC', v) or v) or ''
+        if "'" in val or '\n' in val:
+            bb.fatal("%s must not contain a single quote or newline: %s" %=
 (v, val))
+    bb.build.exec_func('dracut_cip_validate', d)
+}
+do_validate_dracut_config[vardeps] +=3D "dracut_cip_validate ${@dracut_cip=
_cfg_srcs(d)}"
+addtask validate_dracut_config before do_install after do_patch
+
+python do_write_dracut_conf() {
+    path =3D os.path.join(d.getVar('WORKDIR'), d.getVar('CONF_NAME'))
+    with open(path, 'w') as f:
+        for v in d.getVar('CFG_VARS').split():
+            val =3D d.getVar(d.getVarFlag('CFG_VAR_SRC', v) or v) or ''
+            f.write("%s=3D'%s'\n" % (v, val))
+}
+do_write_dracut_conf[vardeps] +=3D "CFG_VAR_SRC ${@dracut_cip_cfg_srcs(d)}=
"
+addtask write_dracut_conf before do_install after do_validate_dracut_confi=
g
+
+do_install() {
+    install -D -m 0644 ${WORKDIR}/${CONF_NAME} ${D}/etc/dracut-cip/${CONF_=
NAME}
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-cr=
ypt_0.1.bb
new file mode 100644
index 00000000..981c1ff7
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/dracut-config-cip-crypt_0.1=
.bb
@@ -0,0 +1,86 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration and /etc/crypttab for the cip-crypt d=
racut module"
+DEBIAN_DEPENDS =3D "dracut-cip-crypt"
+
+# CRYPT_PARTITIONS elements are <partition-label|uuid|/path>:<mountpoint>:=
<reencrypt|format|noencrypt|format-if-empty>[:expand]
+CRYPT_PARTITIONS ??=3D "var:/var:reencrypt"
+CRYPT_CREATE_FILE_SYSTEM_CMD ??=3D "/usr/sbin/mke2fs -t ext4"
+CRYPT_SETUP_TIMEOUT ??=3D "600"
+CRYPT_HASH_TYPE ??=3D "sha256"
+CRYPT_KEY_ALGORITHM ??=3D "ecc"
+CRYPT_ENCRYPTION_OPTIONAL ??=3D "false"
+CRYPT_BTRFS_SUPPORT ??=3D "0"
+CRYPT_BACKEND ??=3D "systemd"
+INITRAMFS_CRYPT_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+
+OVERRIDES .=3D "${@':expand-on-crypt' if ':expand' in (d.getVar('CRYPT_PAR=
TITIONS') or '') else ''}"
+DEBIAN_DEPENDS:append:expand-on-crypt =3D ", cloud-guest-utils, fdisk"
+
+CONF_NAME =3D "cip-crypt.conf"
+CFG_VARS =3D "CRYPT_PARTITIONS CRYPT_CREATE_FILE_SYSTEM_CMD CRYPT_SETUP_TI=
MEOUT \
+    CRYPT_HASH_TYPE CRYPT_KEY_ALGORITHM \
+    CRYPT_ENCRYPTION_OPTIONAL CRYPT_BTRFS_SUPPORT CRYPT_BACKEND \
+    INITRAMFS_CRYPT_MOUNT_OPTIONS"
+
+CIP_CRYPT_UUID_RE =3D "^[0-9a-f]{8}-([0-9a-f]{4}-){3}[0-9a-f]{12}$"
+
+python dracut_cip_validate() {
+    import re
+    if d.getVar('CRYPT_BACKEND') !=3D 'systemd':
+        bb.fatal("cip-crypt: only CRYPT_BACKEND=3Dsystemd is supported (go=
t '%s'). "
+                 "Use initramfs-crypt-hook for clevis." % d.getVar('CRYPT_=
BACKEND'))
+    if bb.utils.to_boolean(d.getVar('CRYPT_BTRFS_SUPPORT')):
+        bb.fatal("cip-crypt: CRYPT_BTRFS_SUPPORT is not supported")
+    if not re.fullmatch(r'[0-9]+(s|min)?', d.getVar('CRYPT_SETUP_TIMEOUT')=
 or ''):
+        bb.fatal("cip-crypt: invalid CRYPT_SETUP_TIMEOUT '%s'" % d.getVar(=
'CRYPT_SETUP_TIMEOUT'))
+    uuid_re =3D d.getVar('CIP_CRYPT_UUID_RE')
+    for entry in (d.getVar('CRYPT_PARTITIONS') or '').split():
+        label =3D entry.split(':')[0]
+        if re.search(uuid_re, label, re.IGNORECASE) and not re.search(uuid=
_re, label):
+            bb.fatal("cip-crypt: UUID '%s' in CRYPT_PARTITIONS must be low=
er-case" % label)
+}
+
+python do_generate_crypttab() {
+    import re
+    uuid_re =3D d.getVar('CIP_CRYPT_UUID_RE')
+    lines =3D []
+    for entry in (d.getVar('CRYPT_PARTITIONS') or '').split():
+        fields =3D entry.split(':')
+        label =3D fields[0]
+        mode =3D fields[2] if len(fields) > 2 else ''
+        if mode =3D=3D 'noencrypt':
+            continue
+        if label.startswith('/'):
+            device =3D label
+            name =3D label.rsplit('/', 1)[-1]
+        elif re.search(uuid_re, label):
+            device =3D '/dev/disk/by-partuuid/%s' % label
+            name =3D label
+        else:
+            device =3D '/dev/disk/by-partlabel/%s' % label
+            name =3D 'encrypted_%s' % label
+        lines.append('%s %s - tpm2-device=3Dauto,tpm2-pcrs=3D7,x-initrd.at=
tach,nofail\n'
+                     % (name, device))
+    with open(os.path.join(d.getVar('WORKDIR'), 'crypttab'), 'w') as f:
+        f.writelines(lines)
+}
+do_generate_crypttab[vardeps] +=3D "CRYPT_PARTITIONS"
+addtask generate_crypttab before do_install after do_validate_dracut_confi=
g
+
+# /etc/crypttab is created by cryptsetup's postinst; shipping it as a
+# conffile would trigger a dpkg prompt. postinst installs it instead.
+SRC_URI +=3D "file://postinst"
+
+do_install:append() {
+    if [ -s ${WORKDIR}/crypttab ]; then
+        install -D -m 0644 ${WORKDIR}/crypttab ${D}/usr/share/dracut-cip/c=
rypttab
+    fi
+}
diff --git a/recipes-initramfs/dracut-config-cip-crypt/files/postinst b/rec=
ipes-initramfs/dracut-config-cip-crypt/files/postinst
new file mode 100644
index 00000000..24c38121
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-crypt/files/postinst
@@ -0,0 +1,10 @@
+#!/bin/sh
+#
+# SPDX-License-Identifier: MIT
+#
+
+set -e
+
+if [ "$1" =3D configure ] && [ -f /usr/share/dracut-cip/crypttab ]; then
+    install -m 0644 /usr/share/dracut-cip/crypttab /etc/crypttab
+fi
diff --git a/recipes-initramfs/dracut-config-cip-factory-reset/dracut-confi=
g-cip-factory-reset_0.1.bb b/recipes-initramfs/dracut-config-cip-factory-re=
set/dracut-config-cip-factory-reset_0.1.bb
new file mode 100644
index 00000000..84eec1f6
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-factory-reset/dracut-config-cip-f=
actory-reset_0.1.bb
@@ -0,0 +1,49 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-factory-reset dracut modu=
le"
+DEBIAN_DEPENDS =3D "dracut-cip-factory-reset"
+DEBIAN_DEPENDS:append:encrypt-partitions =3D ", cryptsetup-bin, tpm2-tools=
, dracut-config-cip-crypt"
+
+INITRAMFS_FACTORY_RESET_DEVICES ??=3D "/dev/disk/by-partlabel/var"
+INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
+INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
+INITRAMFS_FACTORY_RESET_TIMEOUT ?=3D "${@ d.getVar('INITRAMFS_SETUP_TIMEOU=
T') or 600}"
+
+OVERRIDES .=3D "${@':btrfs-support' if d.getVar('INITRAMFS_FACTORY_RESET_L=
UKS_FORMAT_TYPE') =3D=3D 'btrfs' else ''}"
+DEBIAN_DEPENDS:append:btrfs-support =3D ", btrfs-progs"
+
+CONF_NAME =3D "cip-factory-reset.conf"
+CFG_VARS =3D "INITRAMFS_FACTORY_RESET_DEVICES INITRAMFS_FACTORY_RESET_LUKS=
_FORMAT_TYPE \
+    INITRAMFS_FACTORY_RESET_CLEAR_TPM INITRAMFS_FACTORY_RESET_TIMEOUT"
+
+python dracut_cip_validate() {
+    import re
+    for dev in (d.getVar('INITRAMFS_FACTORY_RESET_DEVICES') or '').split()=
:
+        if not dev.startswith('/'):
+            bb.fatal("cip-factory-reset: device '%s' must be an absolute p=
ath" % dev)
+    fstype =3D d.getVar('INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE') or ''
+    if fstype not in ('ext4', 'btrfs'):
+        bb.fatal("cip-factory-reset: LUKS_FORMAT_TYPE must be ext4 or btrf=
s, got '%s'" % fstype)
+    timeout =3D d.getVar('INITRAMFS_FACTORY_RESET_TIMEOUT') or ''
+    if not re.fullmatch(r'[0-9]+(s|min)?', timeout):
+        bb.fatal("cip-factory-reset: invalid TIMEOUT '%s'" % timeout)
+}
+
+python () {
+    overrides =3D (d.getVar('OVERRIDES') or '').split(':')
+    if 'factory-reset' not in overrides or d.getVar('INITRD_CMDLINE_STYLE'=
) !=3D 'systemd':
+        return
+    provider =3D d.getVar('PREFERRED_PROVIDER_factory-reset-helper') or ''
+    if provider !=3D 'factory-reset-helper-efi':
+        bb.fatal("dracut-config-cip-factory-reset requires EFI variables: =
set "
+                 "PREFERRED_PROVIDER_factory-reset-helper =3D "
+                 "'factory-reset-helper-efi' (got '%s')." % provider)
+}
diff --git a/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-=
overlay_0.1.bb b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-=
cip-overlay_0.1.bb
new file mode 100644
index 00000000..a8bf1d37
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-overlay/dracut-config-cip-overlay=
_0.1.bb
@@ -0,0 +1,44 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-overlay dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-overlay"
+
+INITRAMFS_OVERLAY_PATHS ??=3D "/etc"
+INITRAMFS_OVERLAY_STORAGE_PATH ??=3D "/var/local"
+INITRAMFS_OVERLAY_STORAGE_DEVICE ??=3D "/dev/disk/by-label/var"
+INITRAMFS_OVERLAY_MOUNT_OPTIONS ??=3D "defaults,nodev,nosuid,noexec"
+# File name in FILESPATH; empty uses the script shipped with the module.
+INITRAMFS_OVERLAY_RECOVERY_SCRIPT ??=3D ""
+
+DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH =3D "${@ '/usr/share/dracut-cip/overla=
y_recovery_action.script' if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') =
else ''}"
+
+SRC_URI +=3D "${@ 'file://' + d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT'=
) if d.getVar('INITRAMFS_OVERLAY_RECOVERY_SCRIPT') else ''}"
+
+CONF_NAME =3D "cip-overlay.conf"
+CFG_VARS =3D "INITRAMFS_OVERLAY_PATHS INITRAMFS_OVERLAY_STORAGE_PATH \
+    INITRAMFS_OVERLAY_STORAGE_DEVICE INITRAMFS_OVERLAY_MOUNT_OPTIONS \
+    INITRAMFS_OVERLAY_RECOVERY_SCRIPT"
+CFG_VAR_SRC[INITRAMFS_OVERLAY_RECOVERY_SCRIPT] =3D "DRACUT_OVERLAY_RECOVER=
Y_SCRIPT_PATH"
+
+do_install:append() {
+    if [ -n "${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}" ]; then
+        install -D -m 0755 ${WORKDIR}/${INITRAMFS_OVERLAY_RECOVERY_SCRIPT}=
 \
+            ${D}${DRACUT_OVERLAY_RECOVERY_SCRIPT_PATH}
+    fi
+}
+
+python dracut_cip_validate() {
+    paths =3D (d.getVar('INITRAMFS_OVERLAY_PATHS') or '').split()
+    for v in ['INITRAMFS_OVERLAY_STORAGE_PATH', 'INITRAMFS_OVERLAY_STORAGE=
_DEVICE']:
+        paths.append(d.getVar(v) or '')
+    for p in paths:
+        if not p.startswith('/'):
+            bb.fatal("cip-overlay: path must be absolute, got '%s'" % p)
+}
diff --git a/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-v=
erity_0.1.bb b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip=
-verity_0.1.bb
new file mode 100644
index 00000000..4c90bcea
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-verity/dracut-config-cip-verity_0=
.1.bb
@@ -0,0 +1,23 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-verity dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-verity"
+
+DRACUT_VERITY_DEVICE_TIMEOUT ?=3D "30"
+
+CONF_NAME =3D "cip-verity.conf"
+CFG_VARS =3D "DRACUT_VERITY_DEVICE_TIMEOUT"
+
+python dracut_cip_validate() {
+    import re
+    t =3D d.getVar('DRACUT_VERITY_DEVICE_TIMEOUT') or ''
+    if not re.fullmatch(r'[0-9]+(s|min)?', t):
+        bb.fatal("cip-verity: invalid DRACUT_VERITY_DEVICE_TIMEOUT '%s'" %=
 t)
+}
diff --git a/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip=
-watchdog_0.1.bb b/recipes-initramfs/dracut-config-cip-watchdog/dracut-conf=
ig-cip-watchdog_0.1.bb
new file mode 100644
index 00000000..1fd1a87e
--- /dev/null
+++ b/recipes-initramfs/dracut-config-cip-watchdog/dracut-config-cip-watchd=
og_0.1.bb
@@ -0,0 +1,30 @@
+#
+# CIP Core, generic profile
+#
+# Copyright (c) Siemens AG, 2026
+#
+# Authors:
+#  Quirin Gylstorff <quirin.gylstorff@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+inherit dracut-cip-config
+
+DESCRIPTION =3D "Build configuration for the cip-watchdog dracut module"
+DEBIAN_DEPENDS =3D "dracut-cip-watchdog"
+
+INITRAMFS_WATCHDOG_DEVICE ??=3D ""
+INITRAMFS_WATCHDOG_SEC ??=3D "${@ int(d.getVar('WDOG_TIMEOUT') or 0) or 60=
}"
+
+CONF_NAME =3D "cip-watchdog.conf"
+CFG_VARS =3D "INITRAMFS_WATCHDOG_DEVICE INITRAMFS_WATCHDOG_SEC"
+
+python dracut_cip_validate() {
+    import re
+    dev =3D d.getVar('INITRAMFS_WATCHDOG_DEVICE') or ''
+    if dev and not dev.startswith('/'):
+        bb.fatal("cip-watchdog: device '%s' must be an absolute path" % de=
v)
+    sec =3D d.getVar('INITRAMFS_WATCHDOG_SEC') or ''
+    if dev and not re.fullmatch(r'[1-9][0-9]*', sec):
+        bb.fatal("cip-watchdog: invalid INITRAMFS_WATCHDOG_SEC '%s'" % sec=
)
+}
--=20
2.55.0


