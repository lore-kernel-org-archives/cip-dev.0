Return-Path: <michael.adler@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AEDE77199
	for <webhook@archiver.kernel.org>; Wed,  8 Jan 2025 10:09:00 +0000 (UTC)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (EUR02-VI1-obe.outbound.protection.outlook.com [40.107.241.55])
 by mx.groups.io with SMTP id smtpd.web10.15503.1736330934114922276
 for <cip-dev@lists.cip-project.org>;
 Wed, 08 Jan 2025 02:08:55 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=qfTaMQmB;
 spf=pass (domain: siemens.com, ip: 40.107.241.55, mailfrom: michael.adler@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KzdsX8hRR2r0KuValGZTrHCHcQRRUgtxFTBTv6+TUWgS7ons0QA5lXeLKYlLjs7+8A7+qRGZN6TpOaHpVqnObj/YKcHUnRsG/a79jIElb6DkbpFbYPPEwlA+VHtBVap7N8RXc4IokRFwsVbQvFf1H2TU60SGUrIKMOndJ1HVq/cS0Ns7MAGNmhtc+ybR8Yn1uVOlnr1QgbU1koCBQ/jp02RqODSq/1IagGSPOlXuADQZ8slnP3weWyAJBGlUwgxxVeDe0Jw4ig/pFBMxdfsHqFMryQ2MHEOc74VWmD31Plc6wb7+2OyxxFuLqzs471sNIEoZRxvUrN6wgRetmIJnDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cigmktpjkQXa0p3+Tmd5aVO+eq8O8GXaRr8w3SKJaoA=;
 b=NVym55wYsBsJF2MrJQY+jHiIgH+msfF+PbJ3fCdmLs6HM7c0BXuoW03JZKRaD2xnagTnLFdhzygarpOfXLIDmTM6K3jxSqWDiv8tYbEF0O1BfKGE0lyrQc8d392d1uhVG22o9htn6VPzgOeKqkKMATFIKIuYq1vQ6GYplS2ft/rdI4uGpixzqLdcmNWtxubEcPlTS9iAj8RF8+FOs0qb6TRmjYRp7gQAxE/7WeeeCF6t5018KmBRQIg4422QnHZ0RQK9uFJkKHar2a4dq7HVN3E336EhcrHbf1wsU6TJWCGegyoEbHGevQqdRm+QlQCjp0rxeK2R0eD5BNLSist7Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cigmktpjkQXa0p3+Tmd5aVO+eq8O8GXaRr8w3SKJaoA=;
 b=qfTaMQmBJl7nYbMdBaQixALu0ukNKrLGHgoLgN3leY42vUOgfO86Y0CaiCTBH3yW5N/LBnmMGUe9e+LN+NKD18ysVT38WFbXYX+DF/IqOsT3oI7jMbxwPJbz4GdukPdK/C7SCHOK18InJw/bjTeu5ZihUJbxBEfa3RlSqFoYp8XhX2+IfDNvwf2Fhj9Av/irCLgtNPh9H6EiauqzkTVQy1WlJq4bxQW6W5wg5kwDZdI6/4ZTxIJ5fdK1PUzm3E3qg4LtBUJZXrBaXfGGMBMrsaPJ76kY79xXxvB85bHHtwjjKSbQBTjUvof7VOymvuMb2fut0FgXTMYdP00MalicKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:12e::15)
 by DB8PR10MB3257.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 10:08:50 +0000
Received: from PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89]) by PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::7499:8576:c129:4b89%5]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:08:50 +0000
From: Michael Adler <michael.adler@siemens.com>
To: cip-dev@lists.cip-project.org
CC: Michael Adler <michael.adler@siemens.com>
Subject: [PATCH 1/1] linux-cip: add kernel config snippet for container compatibility
Date: Wed,  8 Jan 2025 11:07:55 +0100
Message-ID: <20250108100755.55673-2-michael.adler@siemens.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250108100755.55673-1-michael.adler@siemens.com>
References: <20250108100755.55673-1-michael.adler@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c8::17) To PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:12e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR10MB4734:EE_|DB8PR10MB3257:EE_
X-MS-Office365-Filtering-Correlation-Id: a2332ab6-cf5f-4a56-ef3c-08dd2fcc7270
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?i8qxIkgLHZoTFzVJCcLznzKbjksw+gkz3cv0NaNsRp/Htwy+p8GW7XR+IcdX?=
 =?us-ascii?Q?iFE3sGwU3ffz70j+djr18q+V8nPH35DstDlTrZtjkJyGcW/p2jQ4RojGciut?=
 =?us-ascii?Q?Z+XAb4o5IywZwtzSHycoILI1Woq+qpm5hngouRGAg/i2J8C1xoTEWRSnQ/2w?=
 =?us-ascii?Q?0UuU+UwRVHJbcUECgPu9EHGREAjaG5UHGnk8q67NMC7N7bwJvIm5RuX+581m?=
 =?us-ascii?Q?aWHVzrhEMbndbd0O+0v4LUXNBaQG+R8ZXhlGbF8iXRk5QQV7R5idGgG2iFd3?=
 =?us-ascii?Q?uze1Atq0MWG65+3tqTdUWbcCzlk0/vUSejTxbeXPvfPe28AN24Ulrd5O8MkE?=
 =?us-ascii?Q?7nYM0yNfgDmB1rqBHqPbQjHCIT8gwg1RtuJC+Xsd8XESLsauhAgzYO2qEanh?=
 =?us-ascii?Q?chpnjpuBThSFCny2NS7qlTlwfqSPg4R+magJLwoDTCoMLd6Ysh6D+Vl1iOfB?=
 =?us-ascii?Q?MujDVcRETxhJVJTa0rtDwPZvOkIGW1jbTLlR96lCNRkv9hrmqKHa8JDOhadE?=
 =?us-ascii?Q?CB7qCWoZMNk3ZxBeBeDN9Wb8KHvrvycbtILkZywTCjamWPGl1MiaW+5b3+ee?=
 =?us-ascii?Q?Jb1OlRT1TucoVcH1qZZRvKw9cS+TWU2TmcD6cUb2qtNTnzw3kBjuIKvNdMC1?=
 =?us-ascii?Q?MyWuI1J+4dufPAqWUVJGAB4Vy5grb6rCh8UWznLrp97tCYdpZlkTu2udyiV9?=
 =?us-ascii?Q?fnIb7USOy2emt2gMRUYTBfMztOc4SMBMU7rmPvq3qbKhCu28bo22ZN9ClDan?=
 =?us-ascii?Q?5FlXgcIfkmVAkGTn0QxEdKaZ7nceBbqAA/9BNlCrMGN3+lqY3CjG2vF5BKhC?=
 =?us-ascii?Q?wJfCcl8IrsPYs0h+lWkwcRIqVbjKx8JFucetlLmIdlTfEDPEhJvqokDO01QN?=
 =?us-ascii?Q?FRsWrtar+T/5Z8grHLpEx9vVN6Xyvm2xp+5lA6IfVL3IttETcasgNf+zVIKI?=
 =?us-ascii?Q?xoBrfxqXRajVoYNj9+dpib0mevPKKrFQSjTKPpGOhhkis85GpETnKI6nCAqx?=
 =?us-ascii?Q?KUBHnWngqMwnyLc1Z3K0Vi69MRtRL5aq3n418nRtFYbQunwCZRlFgYHyU7bd?=
 =?us-ascii?Q?LzSRs7wX/eyFIJrt2tG4X0A1QkBv1VPpwbcFuN1rglbsBqQVagBcGJt/UgGm?=
 =?us-ascii?Q?BH9owO92S4r2z6JqwrZcwPhwoZkVIWvd9RPSXIpWTu9tbXxFnrJn3+9bksgZ?=
 =?us-ascii?Q?JgWcaIleZ9EdRRKNKaXNK9e9sK6w2bvqFgwmCERUF+t4lxe5UEwvAo6fladK?=
 =?us-ascii?Q?tjrgg+wU6lL/7nrx9KG3ObgosrScKOAaEaQANfswOxrwNJVTzQWsxXxhkle7?=
 =?us-ascii?Q?/KdPjogR7sr40/BonzLGHPZgrYtYtwOW4SkbcYywpL/GRiYeg0Ps7dQxMc0o?=
 =?us-ascii?Q?c435IYG5jbUAFXHAcMQhA2VOqI9R215RtQwDJQ9JYHOhmD/4AQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?lsu9FZ/HcJS6MnohmSBKjH+TkYFRtrZO0IIocjTt1LfXeyKEOjFJn0WKfrdY?=
 =?us-ascii?Q?qujPhjoqVSfY9d16kHlGWRzlL4n5O30Ae+vq6pd03btFZBDYLusWMLBLumXM?=
 =?us-ascii?Q?gNjpV50h9l2azdAP2wcd0smF6QHtFZzo/JOin19zlr98C4bn6dUd2M8wvzai?=
 =?us-ascii?Q?P9rsU0b8n/sYOOYV/pnpO2PpA5GDUeJfRkRo2TbXU5Zf0nOVVlfEld8/q8kn?=
 =?us-ascii?Q?QoMbeNSgibdL+lNNMG4qeZBv1naxTk4Fb319i4KSlWtDG3FSDdXvPPWa9okN?=
 =?us-ascii?Q?3tzhHTsst24lQkZMDnp+Bjwnf7ni0TLbl9e6tt6FMbyI0GMKn28oJfb2xA84?=
 =?us-ascii?Q?3Zc3vwaT7iEHNPA+wLiskR1vIeI9mwJ0qCqOE2iJCtfmXp7rlbsYEQ4z1t7f?=
 =?us-ascii?Q?obfMEAl4BaFcciMZrU1x3X++Wu7f049WV4Ib2C/sGnB37Sx/geGshbeS66Nn?=
 =?us-ascii?Q?vk8bc7E4RD3sXQr5PgotLD0z7ZRFO4I5WAYTKpifLK17GvHpzadAf5TwMldD?=
 =?us-ascii?Q?QdapU1avm4sjLI3RWWPI+mG3l8RZkxiBSqQxnxEls0I1FLhqXBQvL5OTQvIq?=
 =?us-ascii?Q?ZQPNQPy3k2eqzIP5pDMon34GKCsGxUEGfnqa/hVVsT1jWXULBEnST0Qk/JiH?=
 =?us-ascii?Q?v/f2HJCZ4y5p9riBM7RjYf/82WPlAAbQGyMFbzQsNuGbMTjL3pZomMv4sWI5?=
 =?us-ascii?Q?yxlE0FU+ptyN2D/cLH1vDSQ6kxK+IP3iUVhph4qaBY997AYz9N4LfOt2+5tj?=
 =?us-ascii?Q?TbV/RTi970x+GlrdWd6A3lpljwgq4bF1Cu7ztFsg6UXTQ7Ow7isy54+HAgnY?=
 =?us-ascii?Q?Qy2wcwnhIuKMHQjlQvKZ6U/q2wnbop3uydPR0dKY80vLECIwwGBxgL7+UUe8?=
 =?us-ascii?Q?kf3qyNBezdCJRqVYUEQEtU/GC5Lu9Hwd/h8huj/LFuHbR2ONWXdjScad+YdD?=
 =?us-ascii?Q?i7wpbHzSupjC+O/9CmwSGbJm5RCSZRfVZtXfTKL2sxZcpbD9VgqyaIPAmGsR?=
 =?us-ascii?Q?rL5URq78TepAywdAn+uJmpRowD0PPTgUgO8Wf0zPheDV01Re4Lpaa8+Y7jGk?=
 =?us-ascii?Q?CHFDAWL8YLvgx1M6y2Jev4o1AogKgJ+UUkE5K67qn1b1nYobTO6KTEs5NbBm?=
 =?us-ascii?Q?29Zsb7CY6R7WiRQ2qBwLzi5R74I2lILz8h3BIPdlrziQvJII8pfkOumdmiHX?=
 =?us-ascii?Q?UF07SeEq7B/7XnR0L8L6J7FbGK1R3KU2Dl+ZvDWutsiQYt4fSsrhQfUit48r?=
 =?us-ascii?Q?mLQMqj67LyeVQWKiiRmC0X57V0Ok9tDds+5Db5x+PIi22B8zHzfyBBCj6Y6K?=
 =?us-ascii?Q?DemrMmu/AUPGFPFcawstTF+v0b7v1oqR37QKvVpdM+QrpBKukGRMQEryCH4y?=
 =?us-ascii?Q?XrnawpnquZIrNvhHvktlSZJRxpRCXFjDlWdVBKUsef5eKbmZ8k+e5/9UBoRN?=
 =?us-ascii?Q?wk57ZQ1UbggswACw8hplQwR1PIi/tOqwpfCW002HylOD7EziyT174SmQpn/9?=
 =?us-ascii?Q?//N1FXGA9zTEaDWaqtEDogbR7d0wQ/iSp2vE0C08ceCp0Uo2jwT30kDGKo1i?=
 =?us-ascii?Q?3lKthc/C1PAnK3+a9oixFolj3m85BuBsDthPptSaQaCBMkyOkcWOZzyG0HRB?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2332ab6-cf5f-4a56-ef3c-08dd2fcc7270
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4734.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:08:49.7664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4/NkvaSc3RgaIfhxy6O2Qvp+RwcST/GHBKMwy/2yZ6txshoFPzE/tKs5GBW/0jPnw2TnjoehFopiS7CJBHYHN/0LzVEqyJzFLFbHhMdaTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB3257
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 08 Jan 2025 10:09:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17506

Obtaining a fully functional kernel configuration as required by popular
container engines such as Docker or Podman can be challenging. By
setting the Bitbake variable USE_CIP_KERNEL_CONTAINER_CONFIG to 1, a
kernel config snippet is included to ensure compatibility with these
container engines.

Note: This feature is designed to be separate from the cip-kernel-config
project to allow for custom kernel configurations.

Signed-off-by: Michael Adler <michael.adler@siemens.com>
---
 conf/machine/qemu-amd64.conf              |   1 +
 conf/machine/qemu-arm64.conf              |   1 +
 recipes-kernel/linux/files/container.cfg  | 114 ++++++++++++++++++++++
 recipes-kernel/linux/linux-cip-common.inc |   5 +
 4 files changed, 121 insertions(+)
 create mode 100644 recipes-kernel/linux/files/container.cfg

diff --git a/conf/machine/qemu-amd64.conf b/conf/machine/qemu-amd64.conf
index d786646..dad6504 100644
--- a/conf/machine/qemu-amd64.conf
+++ b/conf/machine/qemu-amd64.conf
@@ -10,4 +10,5 @@ DISTRO_ARCH =3D "amd64"
=20
 IMAGE_FSTYPES ?=3D "ext4"
 USE_CIP_KERNEL_CONFIG =3D "1"
+USE_CIP_KERNEL_CONTAINER_CONFIG =3D "1"
 KERNEL_DEFCONFIG =3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/x86/ci=
p_merged_defconfig"
diff --git a/conf/machine/qemu-arm64.conf b/conf/machine/qemu-arm64.conf
index a2c5e53..8fd824c 100644
--- a/conf/machine/qemu-arm64.conf
+++ b/conf/machine/qemu-arm64.conf
@@ -10,6 +10,7 @@ DISTRO_ARCH =3D "arm64"
=20
 IMAGE_FSTYPES ?=3D "ext4"
 USE_CIP_KERNEL_CONFIG =3D "1"
+USE_CIP_KERNEL_CONTAINER_CONFIG =3D "1"
 KERNEL_DEFCONFIG ?=3D "cip-kernel-config/${KERNEL_DEFCONFIG_VERSION}/arm64=
/cip_merged_defconfig"
=20
 # watchdog is not yet supported in our QEMU executor for this platform, di=
sable it
diff --git a/recipes-kernel/linux/files/container.cfg b/recipes-kernel/linu=
x/files/container.cfg
new file mode 100644
index 0000000..18f8b2b
--- /dev/null
+++ b/recipes-kernel/linux/files/container.cfg
@@ -0,0 +1,114 @@
+# Copyright (c) Siemens AG, 2025
+#
+# Authors:
+#  Michael Adler <michael.adler@siemens.com>
+#
+# SPDX-License-Identifier: MIT
+
+# Kernel configuration required by container runtimes such as Docker.
+# Based on the following scripts:
+#
+#   - https://github.com/moby/moby/blob/master/contrib/check-config.sh
+#   - https://github.com/opencontainers/runc/blob/main/script/check-config=
.sh
+#
+# NOTE: CONFIG_SECURITY_SELINUX and CONFIG_SECURITY_APPARMOR are intention=
ally
+# not enabled.
+
+CONFIG_NAMESPACES=3Dy
+CONFIG_NET_NS=3Dy
+CONFIG_PID_NS=3Dy
+CONFIG_IPC_NS=3Dy
+CONFIG_UTS_NS=3Dy
+
+CONFIG_CPUSETS=3Dy
+CONFIG_CRYPTO=3Dy
+CONFIG_CRYPTO_AEAD=3Dy
+CONFIG_CRYPTO_GCM=3Dy
+CONFIG_CRYPTO_GHASH=3Dy
+CONFIG_CRYPTO_SEQIV=3Dy
+CONFIG_KEYS=3Dy
+CONFIG_MEMCG=3Dy
+CONFIG_CHECKPOINT_RESTORE=3Dy
+
+CONFIG_OVERLAY_FS=3Dm
+
+CONFIG_CGROUPS=3Dy
+CONFIG_CGROUP_CPUACCT=3Dy
+CONFIG_CGROUP_DEVICE=3Dy
+CONFIG_CGROUP_FREEZER=3Dy
+CONFIG_CGROUP_NET_PRIO=3Dy
+CONFIG_CGROUP_PERF=3Dy
+CONFIG_CGROUP_PIDS=3Dy
+CONFIG_CGROUP_SCHED=3Dy
+CONFIG_FAIR_GROUP_SCHED=3Dy
+CONFIG_CGROUP_BPF=3Dy
+CONFIG_BPF_SYSCALL=3Dy
+CONFIG_CFS_BANDWIDTH=3Dy
+CONFIG_RT_GROUP_SCHED=3Dy
+
+CONFIG_HUGETLBFS=3Dy
+CONFIG_CGROUP_HUGETLB=3Dy
+
+CONFIG_BLK_CGROUP=3Dy
+CONFIG_BLK_CGROUP_IOCOST=3Dy
+CONFIG_BLK_DEV_THROTTLING=3Dy
+
+CONFIG_NET=3Dy
+CONFIG_NET_CLS_CGROUP=3Dy
+CONFIG_NET_CLS_ACT=3Dy
+CONFIG_NET_EMATCH=3Dy
+CONFIG_NET_SCHED=3Dy
+CONFIG_NETLABEL=3Dy
+CONFIG_INET=3Dy
+CONFIG_POSIX_MQUEUE=3Dy
+
+CONFIG_NETDEVICES=3Dy
+CONFIG_NET_CORE=3Dy
+CONFIG_VETH=3Dm
+CONFIG_BRIDGE=3Dm
+CONFIG_BRIDGE_NETFILTER=3Dm
+CONFIG_BRIDGE_VLAN_FILTERING=3Dm
+CONFIG_VXLAN=3Dm
+CONFIG_IPVLAN=3Dm
+CONFIG_MACVLAN=3Dm
+
+CONFIG_NETFILTER=3Dy
+CONFIG_NETFILTER_ADVANCED=3Dy
+CONFIG_NETFILTER_XT_MARK=3Dm
+CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
+CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
+CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
+CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
+CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
+CONFIG_IP_NF_FILTER=3Dm
+CONFIG_IP_NF_IPTABLES=3Dm
+CONFIG_IP_NF_MANGLE=3Dm
+CONFIG_IP_NF_NAT=3Dm
+CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
+CONFIG_IP_NF_TARGET_REDIRECT=3Dm
+CONFIG_IP_VS=3Dm
+CONFIG_IP_VS_NFCT=3Dy
+CONFIG_IP_VS_PROTO_TCP=3Dy
+CONFIG_IP_VS_PROTO_UDP=3Dy
+CONFIG_IP_VS_RR=3Dm
+
+CONFIG_NF_TABLES=3Dm
+CONFIG_NF_TABLES_INET=3Dy
+CONFIG_NF_TABLES_NETDEV=3Dy
+CONFIG_NF_CONNTRACK=3Dm
+CONFIG_NF_CONNTRACK_FTP=3Dm
+CONFIG_NF_CT_NETLINK=3Dm
+CONFIG_NF_NAT=3Dm
+CONFIG_NF_NAT_IPV4=3Dm
+CONFIG_NF_NAT_MASQUERADE=3Dm
+CONFIG_NF_NAT_NEEDED=3Dm
+
+CONFIG_NFT_COMPAT=3Dm
+CONFIG_NFT_CT=3Dm
+CONFIG_NFT_HASH=3Dm
+CONFIG_NFT_LIMIT=3Dm
+CONFIG_NFT_LOG=3Dm
+CONFIG_NFT_MASQ=3Dm
+CONFIG_NFT_NAT=3Dm
+CONFIG_NFT_REDIR=3Dm
+CONFIG_NFT_REJECT=3Dm
diff --git a/recipes-kernel/linux/linux-cip-common.inc b/recipes-kernel/lin=
ux/linux-cip-common.inc
index 5d1b8ac..437ee17 100644
--- a/recipes-kernel/linux/linux-cip-common.inc
+++ b/recipes-kernel/linux/linux-cip-common.inc
@@ -23,4 +23,9 @@ SRC_URI +=3D " \
     https://cdn.kernel.org/pub/linux/kernel/projects/cip/${KERNEL_MAJOR_MI=
NOR}/linux-cip-${PV}.tar.xz \
     "
=20
+SRC_URI:append =3D " ${@ \
+    'file://container.cfg' \
+    if d.getVar('USE_CIP_KERNEL_CONTAINER_CONFIG') =3D=3D '1' else '' \
+    }"
+
 S =3D "${WORKDIR}/linux-cip-${PV}"
--=20
2.47.1


