Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E4C88E72
	for <webhook@archiver.kernel.org>; Thu, 17 Sep 2026 16:14:50 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.43616.1789661685153000358
 for <cip-dev@lists.cip-project.org>;
 Thu, 17 Sep 2026 09:14:47 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=eKNF3CnL;
 spf=pass (domain: siemens.com, ip: 52.101.84.1, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lEAMYyRZmMh60qYqwkKe/QbqgKMdkTv9Ej/0ia0VSzvPP4A88m3iAwuQNZHqVdtk0gF5a7d93FujpNgVvwfE6iiCXAF3kqKuhpC0AD3TsZANwbjYk3ejy2jlGIVDdvNtqWaoSoGRspvFmTqxRAYImQviilGctesXlkfgVAFBf6PCP8cf34BGmcvVqkHjye1lt8vo3+DXKyIJupVE7EurpGRsly5yHEnGYLjJVFcZd24J13Q0JymNb6yFS1kDk1ydsLVs/2QMEKjtAodyPu/E9+6lH+PRRJBY0FmXbjVJyvnYGd1YW4Zihqlhait8vRxfKLN6y3Dhi/TksxfMS7M8SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nFzFUopTGEWpoCEGWXA2N4DiF1ZNgZh0nCBvCgNlxE8=;
 b=KEwpIt7iIBO62M4gvs0gSct7gzF5+wm9ymEwqMlSXXWfyJGQksTIt1TZZ2r7vIUbklPgVZ+GBE5n6Bp0+vhhuCGBs6kXhPFfmodtC/LhcQFoCgaPq22nmbXy/MTqnXrnk0ujcpAJ2hLBCpFGtaMAo5v9M/8lTyTsPGk/2NgUlLxQ9EabFBBuCpRwXEvZp7wjsDOUDv9N29v+a0k+E8ZiN8yIoAowLHJuuo1on9Rermyz6IhgyWiDii+bYQdlT7TpJZzosn7cQFL27uGZybL/4ATcEKYojfktOtOAVB+8SAwfvf4a5ngwyBgejwHCwARX9sOK9p5C/yw65Bs1O/PTTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nFzFUopTGEWpoCEGWXA2N4DiF1ZNgZh0nCBvCgNlxE8=;
 b=eKNF3CnLWB38jFD1dY8iLCQlvqeJ3yAERoIpoEb+by5wmlKxX31CyenTOq/5R5c+F1Ny7HE3MkDUPnHKZeYEo2QMSKNcYJBP4T8GIz1RGrd5RQO7zDvGt1UhQgL63PO+WI4nKKENk7Z5xRSRTzo7KBDumHPbDU2k5uO1iYGa7nXBCQSgTiKk0KZ8kcti9y7qjVIp79SLkTIBIAOsbZbqQXg0qe0HL0HO5zUlsPRC3+hKZYfqdmBuEyTZ+4MTfSOgiEd7/0Gb89lN+ZjVNqMSFPwcI+H4OwhwkpDuI0g5HtSmYeXXezssMX5biuz21RJHy8FBkitODfvEub8IzsWdHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by GV1PR10MB7598.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:89::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.12; Thu, 17 Sep
 2026 16:14:43 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0428.011; Thu, 17 Sep 2026
 16:14:43 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	alexander.heinisch@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 3/3] initramfs-factory-reset: Ensure that '0' disables the TPM clear instead of enabling it
Date: Thu, 17 Sep 2026 18:14:07 +0200
Message-ID: <20260917161425.666709-4-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
References: <20260917161425.666709-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|GV1PR10MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: 2947134f-5b81-400e-0fd8-08df14d6c896
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|23010399003|366016|376014|1800799024|11063799006|56012099006|22082099003|18002099003|55112099003|10067099003;
X-Microsoft-Antispam-Message-Info: 
	RGB6MMGjSZQLVO0afDxwM+9U7YO2EjBuSKOdGK6ej9NnC1jiDcF6nm74Qn7ESr3+0H6wH/Qywl07TuBHjy7kWlBs0jp3JDPfBpvw3Csnd6gUjdmQehOqCohNJSNHcBTtQS46ajc37+mUnRN6D9SIkTdfVPNFEPfTPTP27tufhM6exmDkFrAOS63fGnjbASaHOVsG0cOAkthJHSYgIIKdaGz6m9dz9XDOq/9/Jae871XYpOsr6hMMmgdyU9IE6W5Mce17KCVTcOfQTaZXP8V+07LBEp2OEYiyjd7TheIG1ZyqDNzTh2niDGdbexYxPYPnFl4Pigy82xtugFQGbWpMQ5Kas7HbqgVaqqkzmNkblYHXNlBCsH5jd0pnWgUK7tvbKMGkaWFhltGQ8nq2PpVOIU/+4a4j97jwwd9T2YcQLOa7uateiPJANura93SS3WP03SPgiD5xavAdnCfd5HcL4+BKnTMBiNwqtEfkPmOzKcW7L4C+5AwEOOLCvpdS8ceUGFlzdEBSxviRRI9vTJJQDx23fxnR841HM1fRv5gxWIVMgUqN5ZlMqoA54UQnOf9rz9Kogka4dVAbpCpOoesEpFZXbDWf+qURFnil8g8j7n+maiyAmO0vanagT6ONUTE67lVXA1nPHuN1PbAi/+0YtA9zQmsnZu10IcrXhc1BbeY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(11063799006)(56012099006)(22082099003)(18002099003)(55112099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Sx5ky+Kcc+KpWIZ5MHiyUZ7sTZO0pkxNV5rH2v9vDLlfrAIEffDvq3tgo0k2?=
 =?us-ascii?Q?jaozYov4m6TszeGK777JyQohur1xMhVrfWTD1wnCP/yPW94wZ1ul9IwryADo?=
 =?us-ascii?Q?XvRZSKPqhjqgxcskUuuOwz5GYiApsgwPkkf24redqxY3l7omSYUwq3Soz+Qj?=
 =?us-ascii?Q?9hukqMUneO3/si7gj+btphbp26bB445kFb8HOMrM0egqJOwBR5rWRBXsVpEw?=
 =?us-ascii?Q?tZ0SY6rts54pUiRknXZ2HlNDMYc+/1oavRw05JQd3uCKkR2f6rWjrRekD3oH?=
 =?us-ascii?Q?ybeSlBFPRYAY1UFKKFLrOwmQHo2yoY/0fOJKpSL5B6RXVepd7vLx5uNkgWcl?=
 =?us-ascii?Q?3O8Tgw525jeweZrIeqUf1W58qT39wi1DP/XNBe2JIOUh6lH5lyLIuvE6QQUr?=
 =?us-ascii?Q?2ir5h7gCCTwgFkmID9jALMkE8jmFi7KKyW4cxE6nA5UOyrSjB1t184/XAjxc?=
 =?us-ascii?Q?qQESlPp9A1O4l+K6yJL8uxjoQGEbx/3dNeS7twNUW7v0OxfbIW1cXow+YALM?=
 =?us-ascii?Q?+XFQCfAq0wFRGTTvOdbHBbtgcKReYMgc/F52aJHA+vVlZpW1xmx5dFD12eBf?=
 =?us-ascii?Q?yPZKvrmOCbjcvHYgfT2vExjl4zxKAHnkeBGtZqrVdWqlKriY4J4grJsQEB+9?=
 =?us-ascii?Q?X+MZhVWcAT/uFPahf1zpmDiWuhR2WcQWUvXeKBssaB/7dWAkabPgFfl+TmEj?=
 =?us-ascii?Q?ElAvoZiT2QLwyonQ577ChApWQCchIUzn7+CHewb+HXJzuNQLtD1Sc18Wo6gA?=
 =?us-ascii?Q?3KVZc737Q/OBDMX6yYDoRovEfiEi2DCK91Hca5tl/3Si1kW35LTHgiXxrnz3?=
 =?us-ascii?Q?e8ms1T/LzzFvArdGQk8VV+9hswrag46Qd5oOyACK9NtXUn8+g3AUq3s4MKNr?=
 =?us-ascii?Q?FJhGcCY05FCb2C7EHkPRJVkyUbxCzLJrmc5mwlqZQWPN2SfqrFL1N05A8FLb?=
 =?us-ascii?Q?FUgSXEzQs8VVdngyM2juOWfLMkWdnp+/dZZn22eO6UFrYjL1RLPMbBAPXq60?=
 =?us-ascii?Q?gvVp2J6yWOO85k0F1lijrYum6dtVcgFAz3kWatGqrl33ukXdD7PN0evT60ml?=
 =?us-ascii?Q?a6+hPAwb3I82VFcP6SG2ko+AdDEXOXko96DBQ6HfSnIX27gpGmjKtF0BWX0k?=
 =?us-ascii?Q?tqCQvlVkugIjx17gP2k/TF3zySGLdGy62EpkVCZoCx89HFyKHQeSa8sQ51cK?=
 =?us-ascii?Q?vGk0fSksCFz17yKgpctzCMB4f1EhZc7K4lEaKhAl4d0IBUihpDfilFcsai4i?=
 =?us-ascii?Q?0I3JwgUXHP5JDiIP+pQ80enkNbdIm9qJUTvZCiIVtlVg+2WkqujpxRXtq4LU?=
 =?us-ascii?Q?ZNNQLOjPE5PiYROwzAZWKyABxHJ65qVZNHagllXQedRJfRLS9rH9NowCdtc0?=
 =?us-ascii?Q?hnh3ZDC7UXLTdiHqgnINXg0dUYISeeOZs27oqaRywGrT5WHFzRUR3YuC1o2d?=
 =?us-ascii?Q?UY5ZW7kEauADAdAnbSyNxj8cSYYUIKrIYSeLIqv/lLj1DANxpaKtMbOjPeLi?=
 =?us-ascii?Q?OwvzYkMcpD3huIUV9tkYLfL2yUAlWeN4lFWfSmAIdMME5SfuBK4kax+nFiAT?=
 =?us-ascii?Q?wYb+n7oc8AwFl7/IjmCSsgaPJCU/cCTrl8bOgEek/Ni47vRU5RZVYGqVQTMk?=
 =?us-ascii?Q?vcxGqG454GlZ0Wghmo01LvsnPf/jZc6g0PmxZ2dcFaAbVwU8ObagF8yKrnbn?=
 =?us-ascii?Q?xJTQs54RzdVfQy2R0vVzK5xh9v1haSdXsR4/c7JDg9NRg9QReN2aPw/zyXTe?=
 =?us-ascii?Q?2iIu+OwPDk4sVzzu9NXtcBULCsYjj24=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2947134f-5b81-400e-0fd8-08df14d6c896
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 16:14:43.3285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eg//dFdAG/irnoaibvMioPFCbgnV6LWk+JuMRHb0HQ4XUmoDkzXpAVSrBr9Ff79ITKjlkMT7klzGYrnCgpLNG7LHZOd4lM2W+0JYxAT/Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB7598
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 17 Sep 2026 16:14:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24227

Setting INITRAMFS_FACTORY_RESET_CLEAR_TPM to '0' did not disable
clearing the TPM: the generated script tested the variable with '-n',
which is true for both '0' and '1'.

Normalise the value in a separate variable and compare it against '1'
instead.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .../files/factory-reset-script.tmpl                            | 2 +-
 .../initramfs-factory-reset-hook_0.4.bb                        | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-r=
eset-script.tmpl b/recipes-initramfs/initramfs-factory-reset-hook/files/fac=
tory-reset-script.tmpl
index e58b5460..e8d85e64 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
+++ b/recipes-initramfs/initramfs-factory-reset-hook/files/factory-reset-sc=
ript.tmpl
@@ -53,7 +53,7 @@ if /usr/sbin/get-factory-reset.sh --delete | grep -q "fac=
tory-reset"; then
         esac
=20
         if [ "$fs_type" =3D "luks" ]; then
-            if [ -n "${INITRAMFS_FACTORY_RESET_CLEAR_TPM}" ]; then
+            if [ "${INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR}" =3D "1" ]; the=
n
                 # after this the data on the encrypted partition
                 # is inaccessible
                 tpm2_clear
diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.4.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.4.bb
index ccb8a72b..e3951cea 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.4.bb
@@ -21,6 +21,7 @@ INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D "0"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D "1"
 INITRAMFS_SETUP_TIMEOUT ?=3D "600"
=20
+INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR =3D "${@ '1' if bb.utils.to_boolean(=
d.getVar('INITRAMFS_FACTORY_RESET_CLEAR_TPM')) else '0'}"
 # to support factory reset on btrfs, add 'btrfs'
 INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
 INITRAMFS_WATCHDOG_DEVICE ??=3D "${@'/dev/watchdog' if int(d.getVar('WDOG_=
TIMEOUT') or 0) > 0 else ''}"
@@ -35,7 +36,7 @@ FACTORY_RESET_HOOK_TARGET =3D "${@ 'local-top' if bb.util=
s.to_boolean(d.getVar('IN
 TEMPLATE_FILES +=3D "reset-env.tmpl factory-reset-script.tmpl"
 TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
                    INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE \
-                   INITRAMFS_FACTORY_RESET_CLEAR_TPM \
+                   INITRAMFS_FACTORY_RESET_CLEAR_TPM_VAR \
                    INITRAMFS_WATCHDOG_DEVICE \
                    INITRAMFS_SETUP_TIMEOUT "
=20
--=20
2.55.0


