Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420B9CD5BDE
	for <webhook@archiver.kernel.org>; Wed, 27 May 2026 09:17:11 +0000 (UTC)
Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.0])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.16346.1779873424421558486
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 May 2026 02:17:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=aMiibs3o;
 spf=pass (domain: siemens.com, ip: 52.101.84.0, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlXx81HM+56/C2dFjxFfbLzIbBgWFFyodSX0Oh424HqVum7h/0tWANP4mTLRo90kXatYzmNWU3H2bX6rzGomNBEVptQoC+NUqH8m8KZbgpUwje7/c4q1B66DcArCA0B8VCQZLmZoLmyzA4Sr5M8WpSyw+6wE32g18C1Ro1N/1PjFptq89ZuBAB0NSQ2dWfuf11e+PyeJVJvXyELdBLYy7NOaY5m5W4QwSVLThDoiH3ds/hx/tMx3b3mue50TJYt315oH/RRa4+q4Yk5/V+IR6z9hJ30+880MuTCrBEfQfg3pyxwyzphONDd8nnwhDtJNrYDqvjXpm4tb3cK1L+dSWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAV3QvgwHI3g5PUQHaUlLIbF6p9C4xykALe7BmQGtx8=;
 b=qExyFUnT3usEjti9k+Ak12G4hO6NJPXzz2RTehpNBI0+HHBYV5rlk85RVt0w5GgVuAUyEZvP8TFvqNt2b85du6d3VLLYIZUZri+5qHB0q0jWMlMKN9oNjxcFMyLxOf8WMgAD+J6rqIVzicizMnElBcTymQFI5sZe8lc/jKWksLJBhAOyuAtMjTMBfrufXS7nNEVgJj7/ce6s62TE+snqXZtIaYOk9vXhoazPKw2t5DOhMjJIr2eIHlOPI17yqOxFVnL5exDpr7W2XEPKn4pGIlEsL474Rx7OU6ZJVa4utTexkvjujUF8Fo1oEIEhGTmJkLLljvzfDBWJ0nRApNX/eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAV3QvgwHI3g5PUQHaUlLIbF6p9C4xykALe7BmQGtx8=;
 b=aMiibs3ohOpt79/MHspshY+FIYYpB/7r+Qkprq71RVbEP7W/GCPX9D8BZTQgRytjWNbzHXfy3WB1yYJIpuG1+NR4N6TFF6FiTq17qwFH96Gt+TOgArENEk7QqPXlM4NOlklUvd3gm6cwT0DaNo+wsDbneOsk8O0NLcLjolWgo0WSuiVBs20FHBxJpqjyLZCS2GBumoV1pnNpS8ofoioUwYha6RvxW03s7HzN0rbn9KJXXB7q4ekf3LTJQV0pjGqUVHdub3hAbp64Im2MjJk9SUlUzTX0Dg3+XZfASw5BSUornYKgGFd1kTRQc5HJtf6//mjGEBUoueet0ojYPHfv5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:52f::15)
 by AS8PR10MB7110.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5ed::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Wed, 27 May
 2026 09:16:56 +0000
Received: from AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2547:a1f4:bf9d:cb19]) by AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::2547:a1f4:bf9d:cb19%3]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 09:16:56 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH v2 1/1] chore(factory-reset): make btrfs support optional
Date: Wed, 27 May 2026 11:16:48 +0200
Message-ID: <20260527091648.764283-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0311.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::18) To AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:52f::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR10MB5952:EE_|AS8PR10MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 129bc18e-88d3-4134-1f9e-08debbd0b2d2
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|10070799003|1800799024|366016|55112099003|11063799006|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 
	BFJfJCnagmWM8GPdACY+Ui8kPXjQLhu/nZKzAPL4g2Tm5QY27S2bxf+mEKNZMrxsaoyeJQLwzBgCINBU/fBiQTZy6doNy7IS0eGT+9HOvu123cVTwgafCGWF+jZW90XCVc9DxQEh/JWoHqSrMjpstxfPMJLYH5S9f/6FjD/SJKeHKzk1I2bPefrtqkV9iNAmWzbFz4gFhsC5pshfzZ9XYMnvSU2EZ6yiDDdOLCha6RoqNLNf8j5D9a1Kh9tnOLL6dRqRc7SjwXACMYYzqmCyg/49l7RitjKqgk8iz+gAUDVo03sMJgq+atYgTOva4yMiJH57V2LrKMw4vWDOo8VKnXi2Z9NkwkTwsnScZEcuLPYms7YMDl+/02NpHhkyHLyzrJS2/Yg2MKz5euPp3OK7hPAqZVzUM1G39nTtwerqoZ2hyvc9WuLxKu1XwQ6h/yfPS/MT3hQ+39XI0BzTG1qYzsjQ4MQgcYu+ETXI04UPeSBah+3Pe/0keTSqaYWojFgyRCQ2sxFXTGhcFUS5ZZUxJWOwkVF7CrBq1eAqmVDj07u4w7gerzqvPK4pqfT1UM7jkYBsJDleTK5b4EY+I12WhsR6vrSioQ1QYmZE/G3HeGUyuLiqi7f6FnQMTid+1Z58W8aiwTmCv6tuG3o5X35bsBD3LeisEclrTDzQVUFmEC+QNb186bqT9wkhHUIKORvL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(55112099003)(11063799006)(6133799003)(3023799007)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fcsiKRCCqb/xB3ARLAJEEO7kY+fYVw/P4D6mAsRuGuMc6oWqDrsHdoj4nj1w?=
 =?us-ascii?Q?N4VcrQDBwppJ50rS0Bbk+TTXBMYeCUk19DSYgy9Gdya4eFRqXAqmJVpS8LDS?=
 =?us-ascii?Q?wZ0gGn+3XHj84vhPOKVaUIeNBjAU12cs6C+1EXTisT9N43/ztDxo3AV8ceNE?=
 =?us-ascii?Q?RlLnRgUD+iYQ/jnfpj0q9I63qPHtovF2WXQ/2wbIQUFNfWFpJkXDJSf1vfWz?=
 =?us-ascii?Q?s1HD7HWRHTxXiMusUKkXKtA22oke62/1zgGh/cza5qsxEFS7FVaSdqzoVhCE?=
 =?us-ascii?Q?VUMFTE8iBWBFQ2Qii4t5guEAC+vak6z6SSDdK+eVzgZK8rcwqQRLD52whQQR?=
 =?us-ascii?Q?jePK27zytDdwUpBqiLcPQPdIR1WpdnQpLZCxgMN2+gQV44J9FORQQ9RV92ih?=
 =?us-ascii?Q?HvGNrCkjfLJ8quoUcA7UOjyf1UUsS1KziymjWOncbOIXTYzx50uDCTUsoxp+?=
 =?us-ascii?Q?61kmhjw7hLA1DedcKZNRYXg69X9v/9wCWgsFLVGpIGu7a8MTDEJdEDTZMxi3?=
 =?us-ascii?Q?XGq8tipN22bL27F2ZfHw1gHNPN2C7rKFzzQwfxaRS+Hp+C8Km0bmk19V4elM?=
 =?us-ascii?Q?gQECpjj2sD/QZaPDmN7pOK2Lp96tqbGCvscJNGM6J8kpcVq5/G9d93eWIMrV?=
 =?us-ascii?Q?E5n4X6rzjmsTu3Zm2cMHykymAu6aTq2vevo32Ps1vGAahDxJCbkLkJJDdyxH?=
 =?us-ascii?Q?M3g7gqpL0ELeczbGppsv26voOfUF2svA+xgH/ezzFaJCc/0/lxl9QMrV9YeK?=
 =?us-ascii?Q?dMHDAokbhpKvoVLYUt8YBcaw9Tb/gOedCWb74VdzdGNoyGu8gEButcJHksaG?=
 =?us-ascii?Q?2lfA7hnD6DmqyH+/CvlL77qagIdmH/yIYi8O/a47RUVel/eHfrhDrkSftnsu?=
 =?us-ascii?Q?u2k2qCOUSkEGR3vmwKoTEuh0L7TtpnkN/Ezzlx1bYDTsoOVgflETDYLsdqTz?=
 =?us-ascii?Q?vAkqmvWQ1y1VPEUxLBaeieBHgGV0G7plKTab6KCog2Ljf72HGRL09fqj2I4v?=
 =?us-ascii?Q?Z3PdVfxruszSip5vBKbNK1mUZQeyNJmYlX1FmKw88sntonxXAlQCBVrGaPUD?=
 =?us-ascii?Q?FUXltNMw9SldozBEYwWzUNmADtZsu4vlYtlSB8YNfPtOWTJzxc1a001N9nbe?=
 =?us-ascii?Q?PNdzPygAlBdjcNpbU4TfL9bC4jh/NvZQ+OATuNi9Spjt65LtbZoQD5Ch0uAd?=
 =?us-ascii?Q?+9DAG8sD0b+UjcsHavA8jtDsWOH36WWOzz9trcGeuEkzdWe2HWFTEZe1BSOl?=
 =?us-ascii?Q?RDVgdgf+mjoGtAufcR6+rfg9M8QuX7BbPGeqejXnWOUZozPW8M4NlnIoYZ7x?=
 =?us-ascii?Q?NLzl+aYb6sQJypI+4+Bw04L9dUoyU1MFF3ROqlNuM8hS00vIJGx0CS+EJxFr?=
 =?us-ascii?Q?vezYs4XrBFM25j80b9deO6Sa8NZn7PqClkjlTWTEvwOaKQfPklp9+/wPLy+3?=
 =?us-ascii?Q?MPjVzLn4P5FMx4h/cmesWHvq7jhhG5JIU24qLmxZDgJT0PMXIdmmzwZKhcQF?=
 =?us-ascii?Q?lRKr+tROorcoybwfg0v4pceAm9MWVEyQfvt8YNelQe5jqeQ7fKGgR2895po2?=
 =?us-ascii?Q?6KFTGz9bNh99rhNtSWwLvqpC4QOtF8WBZcN7hQo3/r9+AJQcanhe3MJLXHmd?=
 =?us-ascii?Q?zrgEh4X5p90yeGPnlVvqjaatCZOnp6IxCLApNzTrRgpbHEzSvs5JspyZ+iK5?=
 =?us-ascii?Q?hhFVVeXH+7S0HJc+tqSEIlZZdk6gvKXRN8bR2WQB20LWiJr16EX8OddJClsy?=
 =?us-ascii?Q?6x6JIAWOV49VbJ1fjZcArVdwWVf1Yz742rV712rBO7jRS7S1JE7rWabLczTp?=
X-MS-Exchange-AntiSpam-MessageData-1: HvInhLqhvUWBUe5ue3XYWnqVLzzHfVbIB9c=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 129bc18e-88d3-4134-1f9e-08debbd0b2d2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB5952.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 09:16:56.2850
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: byDJisENSw0a21Xai6EmIQ4vsVLnh8yt3M58VHvQdaZg1G8nhNmYTeqln3LsXzI9aMTmlRZtbFK9FmFM+6Yqc6AoPDnD0dhtFYu9uV/duLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB7110
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 27 May 2026 09:17:11 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23014

To reduce the footprint and attack surface of our images, we make the
support of btrfs in the factory-reset initramfs hook optional. By that,
we extend the interface to also allow support for further file system
types.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
Changes since v1:

Rename control variable to INITRAMFS_FACTORY_RESET_FSTYPES, make it a
list for further extension.

 .../initramfs-factory-reset-hook_0.3.bb             | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-facto=
ry-reset-hook_0.3.bb b/recipes-initramfs/initramfs-factory-reset-hook/initr=
amfs-factory-reset-hook_0.3.bb
index e962a51..670725b 100644
--- a/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
+++ b/recipes-initramfs/initramfs-factory-reset-hook/initramfs-factory-rese=
t-hook_0.3.bb
@@ -20,6 +20,9 @@ INITRAMFS_FACTORY_RESET_LUKS_FORMAT_TYPE ??=3D "ext4"
 INITRAMFS_FACTORY_RESET_CLEAR_TPM ??=3D '0'
 INITRAMFS_FACTORY_RESET_CLEAR_TPM:encrypt-partitions ?=3D '1'
=20
+# to support factory reset on btrfs, add 'btrfs'
+INITRAMFS_FACTORY_RESET_FSTYPES =3D "${INITRAMFS_FACTORY_RESET_LUKS_FORMAT=
_TYPE}"
+
 SRC_URI +=3D " \
     file://factory-reset-script.tmpl \
     file://reset-env.tmpl \
@@ -35,14 +38,18 @@ TEMPLATE_VARS +=3D " INITRAMFS_FACTORY_RESET_DEVICES \
 RDEPENDS =3D "factory-reset-helper \
             initramfs-cip-functions"
=20
-DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, btrfs-progs, awk,=
 \
+DEBIAN_DEPENDS .=3D ", coreutils, util-linux, e2fsprogs, awk, \
                     factory-reset-helper, findutils, initramfs-cip-functio=
ns"
 DEBIAN_DEPENDS:append:encrypt-partitions =3D ", tpm2-tools"
-HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp rmdir basename \
-                   mke2fs mkfs.btrfs awk blkid rm get-factory-reset.sh \
+HOOK_COPY_EXECS =3D "mountpoint findmnt mktemp basename \
+                   mke2fs awk blkid rm get-factory-reset.sh \
                    chattr grep find"
 HOOK_COPY_EXECS:append:encrypt-partitions =3D " tpm2_clear"
=20
+OVERRIDES .=3D "${@':btrfs-support' if 'btrfs' in d.getVar('INITRAMFS_FACT=
ORY_RESET_FSTYPES') else ''}"
+DEBIAN_DEPENDS:append:btrfs-support =3D ", btrfs-progs"
+HOOK_COPY_EXECS:append:btrfs-support =3D " mkdir rmdir mkfs.btrfs"
+
 HOOK_ADD_MODULES =3D "efivarfs"
=20
 do_install[cleandirs] +=3D "${D}/usr/share/factory-reset/"
--=20
2.53.0


