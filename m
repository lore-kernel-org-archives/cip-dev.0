Received: from DB3PR0202CU003.outbound.protection.outlook.com (DB3PR0202CU003.outbound.protection.outlook.com [52.101.84.47])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11270.1795689018322784349
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:23 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ikf0Srae;
 spf=pass (domain: siemens.com, ip: 52.101.84.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H/e22t1xghDEbe+SRURz2qhVRtE8Yle0D6QL+A4ECjzk14dDfSW//NZ/I3dNndh1lNXsjxrMYoYod8EcSqD7dlIUIzqQ7fDKhxi5PCl3AxqBimAeT+H9YzQF6e2KVJc5/k7Bff9Oa/S+arBeTVFbi3GnzKDhM6umQxVCYNZe8huLez3meOxNd4knuaUCX9ovrgXV/TCViEi4pohP6KDjPafTNu26JK59mSwADJ5Lu2DbCn2VL9igy2v3UrIX6+xuq+PFlcexbG2KhDI5bvqV9FV8iu4B+pnnbmilyF9/yeh6oKsSFJz+QUA0ABViMZlYX+rt6N4LPD6jSk3ALraqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xQ0pvwvopatmah6gc6E3ajIRAkB6Vx7S+mMqIJeDikM=;
 b=JK3ba9o3FU4cc6MJfLCEcRuUVls0StmNrCYKxW+eCJG4O7Gs24m0YTGAlAL9OzBP1sBwIJqeIEidLbteCLmWwaqXdqb8GgM11VS2YCv3l5nlwaAh19fHy302F7VySHNG2/r3AQznOTJf0lWVGZjCe839BAqtePgX2AqHi4yC6YWdryyUe7Q5ohtoeEx8oqdmQdY6VzN/EMc1LVrztQvB6wtVoyvF1dUSOAwEnLJsaoowPIbo6C8eSpvCtBo/5ZrwF7ZMdNWnmnhwPC7acNn9WdE/9S6CB0wHCZzEuXcfN3dOHkhae2VoPsoE3m8P3gqa21gMvnNihnhm6mcbaxTObg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xQ0pvwvopatmah6gc6E3ajIRAkB6Vx7S+mMqIJeDikM=;
 b=ikf0SraeQ35EsXWu2PgNkDebRiLstGHY01cIiGqX1hZUv6a50MiTtC3uzIWlw/MTqpWTHPJhPGrRII0sp7gzH14iicPveVoLnwUi3km1EWuGjlMKsVtUsTvfnSWz7g0zQBN5UVel9ewPywV84gW5NrMdnULugkomoaT60/doVDQF1+XAUTAWJQacUr0/zDtSD7FdFTXUr3rE7BoLW6r9nTP8TbhmPktqsM+knevych6Ky5kLpzUJJkj8V+T+sLJOOMaRfG4MzDGXAeZUlJS/l1pqw3IxFdeiWvgvZUADND2HPHJ132EbtuhwMsOWsJMjv1Sg4XwP9aovt53i2bw2wA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PA3PR10MB9258.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:4d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Thu, 26 Nov
 2026 10:30:17 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:17 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 07/21] read-only-rootfs: do not mount LABEL=var from fstab with dracut
Date: Thu, 26 Nov 2026 11:29:53 +0100
Message-ID: <20261126103007.2922985-8-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
References: <20261126103007.2922985-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PA3PR10MB9258:EE_
X-MS-Office365-Filtering-Correlation-Id: e978b9bd-99ac-4fb8-c6d2-08df4ba843cf
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|5023799004|261022105027099003|261028144727099003|10067099003|11063799006|261022115727099003|56012099006|261021121427099003|261021123027099003|261009223027099003|261026140227099003|261022075727099003|261102123227099003|18002099003|6133799003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: UOimBRX0lUIKTUOiraGyIIPS2/sj5JQ35zz8Mb8iTSa2OObwxZF2pbNXxA7/wKwLb9PW+S9VQ/27i3t8QjQzA8GbnhhOYMQXSwqcKjigY8Tc8FzPqC2IH0916r0znYpar1HLpMSbehOaZK91yxt65SmPmU5eIhuKEWr+UXxP6u1RO27kdK9fA9AFwTCOGqvMgJRYGj6CWkLiIqYn3gG67+7e0a/qvuB6Tot7qpwYv6zuJcq9uORU1roKvKquGjfAN+wFxFBhtgAZF5svqo1SPxcBduB5k+4YOAMFNfcIMELaC+nyyM4Wgke+MOM+UhtMCd4PQgY/N4mBWj5dIOnRh4SwP8HouDrtytEeoWFxW8jtdjcoUQRdD8Iz4hkU5N7KvUsFZZYfP7TaSZYIYzKhCtRO0F8YJOOZOlDigUruBlhBzyncdyQtcMFjd4WN4BB27WPJbs1O8+rLJ8L5z8FL8G1ElUTfvAf3E52V0XFq/JJ6udByuatROm0BuLMLQBAlVooWKtSlFnXtx2Cm4+AAXdHaAE8vw9I2sdl60fDjKoGSJNwwFxrkkswxhmp9J1MsxdDh5KNOHBpQNQIA/QFXzeRu0orJxohm+5eb7M4ZdGK7eYbekYFwhJIFtW7AUo+Ms7DIHKyBgb0s60+fKLXxo/BeBueUVaRizTqC3fLeTfw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(5023799004)(261022105027099003)(261028144727099003)(10067099003)(11063799006)(261022115727099003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261026140227099003)(261022075727099003)(261102123227099003)(18002099003)(6133799003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rGlF+fSbNzE24IqPqmV8tvYMk+D2FhRCT+CRgcMF6gvOQ3YjLJZ/pfcOo4m0?=
 =?us-ascii?Q?ltxomjCjb7aw3VWYbpNlmM7ffo+g49rZixRB3jWkc9xxT3qUJkH83Eet1X9J?=
 =?us-ascii?Q?Hq2ieOuM0gtrEZVVJQYWOkMXZqXGX1G4iRNwJkePG4QulsR1GfyPpoTuNxyz?=
 =?us-ascii?Q?6uH3CN8QQtPTStM0L8/YoxjnLN3qA9hLXAhgKrpTJj7nyI5z8ZW52W+Vch5s?=
 =?us-ascii?Q?2+gedf73dnLKv28Tw8LtNAnW1nve67z0SNETWrowA0fwLJpxNJRqRXYj2yIV?=
 =?us-ascii?Q?R8JHL545Jx8upUu2iQYyjOZqK04GUD6mLG01ea/6kjyGpOWJ11tNG7QTLWwb?=
 =?us-ascii?Q?elfhl/AgYsSSQncQ7WWpoEhjSqev+bEZtas5rvJZMGy88e/oCQmFQUgqMrDB?=
 =?us-ascii?Q?kGlp5qKsiz0SpaIKJIRDPiR28DBfpqhnymkq3zdMkFNQe4weUxOsy2YMuZE2?=
 =?us-ascii?Q?KmahGy+NPHqCm9gLM6/ItUByp/q7+sYRNGvk666yyEsjmh0u8JWjKG2xyjko?=
 =?us-ascii?Q?RyqZ/gOueWUJJWJokza9hYTSAn+zQucYjkFtlTIsLq+SoMyOJo+sUZ9GcTTY?=
 =?us-ascii?Q?8aN64xBSv0lUmBMu/Q0jE2cqHTHZIRHcXPD3KWrR9VbbV25k8Bj1wynEYxwn?=
 =?us-ascii?Q?/YNNx/PlryUUraSu2+Z5eQ7mE1WEe/2yrX7w2P4OuBUv1og6dHI3gH5MPIot?=
 =?us-ascii?Q?nCrUcI1wsluN1MbjFywNUo1a7qEQuUHzhRqbyRuyiTLJK8/bFxZ0MqNjIZtD?=
 =?us-ascii?Q?23f/P1LEIJKwlgnGhHj4f12lXMbfjt9qlQmkhJ+wsmeownfA56XXhs1ecm9q?=
 =?us-ascii?Q?GjCDAgohlhOI9nEDyd+M2uJm2f+u0VPVdl4xGBPn6QzSM9+aOe/r2+QQJJ3L?=
 =?us-ascii?Q?Dw7NDEoGawNKnJl5Zatvv1Jne49IeFQsDkkkHvh/zgjcFEgb5dc/pcTxA72/?=
 =?us-ascii?Q?oUP1supjYvh40+Y+GiQtbBWwBslwvSMgLC24bKIV3RLm8CLmvdmJxFeeQnp5?=
 =?us-ascii?Q?c9pzZPujYn5rSPx+ZYtQu8MiaDK0WJHW/Ln+3inIwp9ez0D1NVB1JiJnriPY?=
 =?us-ascii?Q?7onZy5WYnXi4iPHYtJzlLWzDI44gn61rfB/YfHvJYgAAxP35AVv5WODNeA0F?=
 =?us-ascii?Q?KhdiJ6iAWo2GggqxFiMI/u1cApVQQ5TtomyS21ZDdFuEURM1qtVZuJgM9Qsi?=
 =?us-ascii?Q?3FHKnWnN7Hd5RfapE+sM5pc4LPiqYsTbukWt+CPhO1Y9CZkN6o0tJSTYFADD?=
 =?us-ascii?Q?kaf2O88sUyJ+rsMiaq8Xx7hTG9D8nf3lMyh6jg24l4E+It2iXg7MRVhUWEHk?=
 =?us-ascii?Q?9lMkR5EkCVV2N2g+CfdweMFX4HrMSzk4eSOjXpIyiqY8RVIcUvtLfIBWsv5a?=
 =?us-ascii?Q?3TAoCEKNe1RMn2Jgwh/VvM6AxVLcBDJKFyhpN7Sp+JuyvjugJXkpHMHDdibh?=
 =?us-ascii?Q?mQDr17CyeWAEljI+umOOFqOvDcYi52m8bKkbQAtfPiqiD3t+ZCGhlP0cqKjp?=
 =?us-ascii?Q?tjMiLvaxwwfYA1GUzY7IqJ9lMDa4uzci1Jk/PiXOSpp9Zi4fidwiVe7KTt0w?=
 =?us-ascii?Q?BFjtTpOXkm9CBaChC+rjjU3VlqWCoD07zSboo0iMbLg74WQ2wMchq1WC8buI?=
 =?us-ascii?Q?bRpEpXJhadEb/7aU+1tP1aTCwC9C8qiTMUYoFmMurBL2Byi3adkVaNOkjEYk?=
 =?us-ascii?Q?ceq+mRLCa8ZArXx0NPSt5XU6jsqmieu3ySYSv1PB+ugZQKtYxXQx96BJzan8?=
 =?us-ascii?Q?ZESuIiDcbU29D7hgxDknua1Wl0BDxG4=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e978b9bd-99ac-4fb8-c6d2-08df4ba843cf
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:17.5404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j6Xq6bxKrZTvrkTRNNTEodOIDdsCXGltDVyRqtDCiD2dyYH0vmIoDLIKpOvemSeBBKZVamjD4kZnwdRbe5p6J4nS0Ggw66AuHgkAUnp50Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR10MB9258
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25089
Content-Type: text/plain; charset="utf-8"

With initramfs-tools the additional LABEL=3Dvar line in the fstab is
redundant but harmless, and it keeps /var mounted for setups with a custom
INITRAMFS_OVERLAY_STORAGE_PATH. With dracut it fails, as it is incompatible
with how the initrd mounts /var.

Drop the line for the dracut initramfs if the overlay storage path is
below /var; the embedded-overlay module then mounts /var in the initrd.
For a storage path outside /var, keep the line, as nothing else would
mount LABEL=3Dvar.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index 945976a3..e9a31dbe 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -84,6 +84,15 @@ copy_dpkg_state() {
     run_privileged cp -a ${ROOTFSDIR}/var/lib/dpkg "$IMMUTABLE_VAR_LIB/"
 }
=20
+# The initramfs mounts /var. With initramfs-tools an additional fstab entr=
y is
+# redundant but harmless and covers custom INITRAMFS_OVERLAY_STORAGE_PATH
+# setups; dracut fails on it. The dracut embedded-overlay module mounts th=
e
+# top-level directory of the storage path, so keep the entry if that is no=
t
+# /var.
+FSTAB_VAR_LINE =3D "LABEL=3Dvar	/var		auto		defaults			0	0"
+FSTAB_VAR_ENTRY =3D "${FSTAB_VAR_LINE}"
+FSTAB_VAR_ENTRY:dracut =3D "${@'' if (d.getVar('INITRAMFS_OVERLAY_STORAGE_=
PATH') or '/var/local').strip('/').split('/')[0] =3D=3D 'var' else d.getVar=
('FSTAB_VAR_LINE')}"
+
 ROOTFS_POSTPROCESS_COMMAND:append =3D " copy_home_to_immutable_data"
 ROOTFS_POSTPROCESS_COMMAND:remove:separate-home-part =3D " copy_home_to_im=
mutable_data"
 copy_home_to_immutable_data() {
@@ -109,7 +118,7 @@ image_configure_fstab() {
     run_privileged tee '${IMAGE_ROOTFS}/etc/fstab' << EOF
 # Begin /etc/fstab
 /dev/root	/		auto		defaults,ro			0	0
-LABEL=3Dvar	/var		auto		defaults			0	0
+${FSTAB_VAR_ENTRY}
 proc		/proc		proc		nosuid,noexec,nodev		0	0
 sysfs		/sys		sysfs		nosuid,noexec,nodev		0	0
 devpts		/dev/pts	devpts		gid=3D5,mode=3D620			0	0
--=20
2.47.3

