Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.6])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.11271.1795689023333075748
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Nov 2026 02:30:27 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=HfnJkiSs;
 spf=pass (domain: siemens.com, ip: 40.107.130.6, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bK6A6Y5KCO9mEN1VHTV0v6RG91CBrOQ3vS047lRB9QwHCdJFAZwcAtMN79c5EB2q037ZTfqEOInln0QjIIcLsZTESfFHYOAioyhIt1aNj4WuvdwHr3gfUOvSAw081YtD4f0pq7KMN/hzsJmz27R5Y32bysiGLaHhpJ8nNdw/ZF5nTSPd85k1D+w86P44ikjLCFcHgpK1VNGQFXERneaG8n5VkWEJtj0NoGTgeah/rbW1NdPk2WbBmKtwhYUvTxntfrkI/NXbZN61g05vCqkp7JXcbVsQoHcKObjEU0OvqZJu2TakqRTjAsBTHXkZbvvIKLiLvdXrJD2n2IpJqoL/1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coVHr+ywkCnVls49bEOs2wDSJzecEr8YxUQe7kOJ5TE=;
 b=LnI7Sked/djRDih/e8qOR6rHbYVaOV3ep6ScCbBAkgkSUa3mjUSGCE/UMtyn8II/xh7tXC1FhAG2bF1tlPliJDv0f9n/spmhgmH6JyFDxNSj1L8enMTL66ZZXEaw+5y0kX13p8lDGgkpK15ZZBKJZFKTh9EI+onstHuNUaD6OcsnSaOiohmHLbqYG9Y0D36CyXmBRuEbDdb9OKp9HuTtBtoAIxD85IpGqfhukV58jhbByZT+h+EHyXyQA7CHIr9tWyEle90HnU79a43BQzr/gFio6Fhk8M8Km/7rieTX+5kkW8zhr9nZuQBf3ssOq4N6EoY/7GfcsOoedOJtmln4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coVHr+ywkCnVls49bEOs2wDSJzecEr8YxUQe7kOJ5TE=;
 b=HfnJkiSsuQC55XW4glvpSbKLvs3c4vVxRrqOSdcD2fzRThlN71YIkvFEJrLdz2hFpKRKHJiGQzrVi34vc+jGOBE9Xo0+tlizyfoT8ki7eX/G1cmhr8hlRaDzQZLmblU6UXkiNq/kYrzSe3pyktQKhs7GJrwdCcZoJthJfBFtYFmqQ0YGbOYyFQV8EYNPLl1BwxmPEDmMv+4k82GcWC4w6Dn+SGeIEvfYqkQQRxDktx7Cv8hdxEGKnPI755EeW+dJLGYT9b8t/LauNgOspvtl7ri5FIC8cQAC9OwuSNTzQZ0xHmcLU1DePP6PS9dQqLivg7IIG7qX0zxodsYpyePsMw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by MI7PR10MB209735.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 10:30:22 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0688.001; Thu, 26 Nov 2026
 10:30:22 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [isar-cip-core][PATCH v4 15/21] read-only-rootfs: do not install home.mount with dracut and encryption
Date: Thu, 26 Nov 2026 11:30:01 +0100
Message-ID: <20261126103007.2922985-16-quirin.gylstorff@siemens.com>
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
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|MI7PR10MB209735:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b1a9601-ee29-446d-ab45-08df4ba84683
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|5023799004|56012099006|11063799006|261022115727099003|261022105027099003|261022075727099003|261026140227099003|261021121427099003|261021123027099003|261028144727099003|261026121527099003|261102123227099003|261009223027099003|22082099003|18002099003|55112099003|3023799007;
X-Microsoft-Antispam-Message-Info: 5LjbcG4kP/O5jb0aZ8x8R98YIejGzWsSupptHpbFyc5bmSLHmRejnRh764TBWd3k3PEY+a5KTfLrP8pzBjVlfEe+RNKcL8/CSeMezBsTY7teR9Bh9+MKZWsK5zw4RaAe5j63qS5Ov2v7NyDAe3Z6s/NOuo6u6fkKWg/bg0hn6HPBxBUbziZB0x0pjcQMFCMQC45KLpHWSmeBStifWTLWPxiN4PIcGhQ9bQG750yxfCJRJInsFHTFLGwId99eigQguY4yLAdV8y5w1iOlahTcO6q8pHLwMuLIGO2NgJXgjUIqub+6C/BimzSBPAF8PkNg53s4mzOoaAprBE+lPQ2pjlBuCq8MWk0mEBP7i8vz18DjPVGtxcVPKQkTZUHiboK0DwfU5L2cWK0Rwr0E8dZpsP9pK0N9ts+JjYNuwtKfsKtXh+U8qfL4dRXnZsY2NtSq/C0lUWEnYhl0NlCg6YYbGZhYvHSWV4IwoWWADPmcc0jAenqnZVJoDHZewJx8ADGGtZ7c4oMCJvYAi6zqnRy+PDmNOFYyqYNNyjEvcDmzUQ6oLy4Z+VAQazlyR7lNECYBJQNEgGdMhuBhDeKxYsP5k4IDjXKdYA1j9gvH0IkRCIpvcxZNQdQqGu8mLKW2YYryniPf2zd1kS/+uA33nt5NDfNAy8mPfvXPvoiwkACzV5o=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(5023799004)(56012099006)(11063799006)(261022115727099003)(261022105027099003)(261022075727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261028144727099003)(261026121527099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sCyRBSu0dR3DprNSMg7sd01US4ZIIKWlG05xMneLIYYXTT8asEwrQLAL4CFb?=
 =?us-ascii?Q?ytAzArkymMFJEob+7UQg47FdLL9CdU82++H7EJd9SW1lwvofHoz33+UFNfIL?=
 =?us-ascii?Q?wYhTXG3vVCPBcjwp47PVtMXkD0htzUPYUbcsJYc2mlis7ImWqvs8uPMNRiUS?=
 =?us-ascii?Q?c0+DEc6ngeMRjdGjqv7zZRvw58mGj6vrWtFvqVz6LAIaqN3GF0vVpwrStLbA?=
 =?us-ascii?Q?GEGQbZSy8bRVml0i3+PhjtvKcX1JRMogYUvYsHde9SNc/QRJfgaqj43feeB8?=
 =?us-ascii?Q?KV8r3rdDatFR8o0BfUB2aA4zvq7hH9wN+IsVzu2jXRlqjq6D0Dh4HJS5+FhG?=
 =?us-ascii?Q?DwLjwICJ9gJCFQbM0MB3DoBAodRX7caiJd+2gafJfjsY5xBVPFRs16wGdGhs?=
 =?us-ascii?Q?xYi7WcWi9bG+nG8dlBFf0XIhOwE5PIHp+TMn/Wqv+K2xqmBYR3CqIRpUzYLm?=
 =?us-ascii?Q?R9838kPRXka7CGG0cTLIjrtPqnhIP7Y8FXdvdep9xjmzTW0xx5BY3curkGiP?=
 =?us-ascii?Q?jVuFVSBY0LfWLUxdReyFzMd44T/MX77uJnT7ouJuhd8YON2/CMtA+n5xwYni?=
 =?us-ascii?Q?nc6w+fbgcsnPtLUV5Zpeh8S4YkAMCal9p/TtD6t8cH8o0BBYLDDgL71F4yU8?=
 =?us-ascii?Q?r1DfVZwx69mXls1D5TejCqrK/aIqAJW3GnWHUq6b5/Bkli46j19ZJh2aPKmf?=
 =?us-ascii?Q?dSCtd9QFCPkxmMRBSrv8ahFmbLNJ+9PRJSXKs51h7Y6bDWnI4KxL11T2X9NL?=
 =?us-ascii?Q?lL7TzdPXveR4/1f+wquQJhyFMias6xzSyh918iBAyDkNm3S3ALn0oncg2RcB?=
 =?us-ascii?Q?6cKY4av/wRmYZYWSPKc6E+gBgFG2CsGUUVUT44Xfl15hW+Ojoa6G0NbpOutk?=
 =?us-ascii?Q?hJSXKOQLA3IauwDHfG9z2bmeoDvqmc+JA822tPDOjXYodDpoC6ANTVp4JbVz?=
 =?us-ascii?Q?d6PftYIhW+7eQ5blQl15WLHsv26xky5oAZ+mWZ/yYqmORvl+6WTzFGZgBLp/?=
 =?us-ascii?Q?6rm7Ci4CTWS/Hvt4+F86RCUTs6D1m9Hgk1kj1xShxxOkkBdh0opQSnd8vkr8?=
 =?us-ascii?Q?FluoC3Iin/IjxLy5Kk5SyWbNAzF7GL9mncsdGwfYs7pNW3AkZaea3TtX2Erl?=
 =?us-ascii?Q?Z+dqGWHRuMm3XpKk1Bi6VpuB8CsQOvjw1nv1n7AW7zMuzXCbEmOH5fAF1w6x?=
 =?us-ascii?Q?j5Bf51ewuGKK3dTbp518A2eQ3+RSJSoS8YlpjdvZY5Cq9+9Kwqc0jGm0A+pK?=
 =?us-ascii?Q?IKVrrBity4U5eU//gsPm9OwQhxwhjoR8xR4wv+uKJCP9CtgWB0BE3cZzm3S9?=
 =?us-ascii?Q?cHz+II5hqk6sGwgzXXUDR4RkjNAs1EAVolYEXPPdZrWuYC4hQKKq1cYemYTj?=
 =?us-ascii?Q?JyCA/+t1nghhyAckH1z1w1xDDdABEcrkQ14KchlOdWqCW3vXqACFcHi52lTA?=
 =?us-ascii?Q?/pxdAwYoAP/Wnky1T/vcroJnMymGrRpN9npgOMSQkVq4hNisu/cWsBloh/Xv?=
 =?us-ascii?Q?jNADpa4k2Ke9lSfXDRXHvKbVE/NS/z4jYiJ3R4OhHt+D8gRwNpWZ0I7NuU10?=
 =?us-ascii?Q?ZwsyWdb2+fOXkVQfYecawcWuDgx/0qDSilzcFGb0P/zNNXK5oDinvYBM8Fph?=
 =?us-ascii?Q?b20/oh8KARlrleAcey7209s0Rd85SjoyVb8dvY8Mtiping4dtQLdPgf3Zufw?=
 =?us-ascii?Q?0gzwdKAGszQlpKdS0uYdV2sViw0tZGQDfk+fg9cER3faKbX2VAxVHSC5HCV3?=
 =?us-ascii?Q?/B7dVYGHBuu02AQ6v8aAzjx7x24pnzg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b1a9601-ee29-446d-ab45-08df4ba84683
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 10:30:22.0537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHs5BkCF4tZJ9t4JW4UYab6gy/idxClopp+VS9bK6JuJC2SwFplBbspbXVn1KItDFTuc8v/CTquqpc1hgfaYj9pItvXt975V2AII/NXCUqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI7PR10MB209735
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Thu, 26 Nov 2026 10:30:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25097
Content-Type: text/plain; charset="utf-8"

With the dracut initramfs and a /home entry in CRYPT_PARTITIONS,
embedded-crypt mounts the separate /home partition before the switch to
the rootfs, like /var. home.mount mounts the raw partition by label.
With encryption this is a LUKS container, so the unit cannot mount it;
it was stopped about a second after boot, which unmounted /home.

Do not install home-fs in this case and leave the mount to the
initramfs. Without encryption, or without a /home entry in
CRYPT_PARTITIONS, nothing else mounts /home, so home.mount stays.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 classes-recipe/read-only-rootfs.bbclass | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/classes-recipe/read-only-rootfs.bbclass b/classes-recipe/read-=
only-rootfs.bbclass
index c92ec34e..d8c9fec3 100644
--- a/classes-recipe/read-only-rootfs.bbclass
+++ b/classes-recipe/read-only-rootfs.bbclass
@@ -64,7 +64,19 @@ WIC_VAR_PARTITION_FSTYPE ??=3D "ext4"
 WIC_VAR_PARTITION ??=3D "part /var --fstype=3D${WIC_VAR_PARTITION_FSTYPE} =
--label var --align 1024 --fixed-size 512M --fsuuid 96be3374-4258-11ee-be56=
-0242ac120002 --uuid 9947ed57-102f-4038-880c-9cf5cacaf153"
=20
 IMAGE_INSTALL +=3D " move-homedir-var"
-IMAGE_INSTALL:append:separate-home-part =3D " home-fs"
+# With the dracut initramfs, embedded-crypt mounts /home before the switch=
 to
+# the rootfs if CRYPT_PARTITIONS has a /home entry; home.mount is not inst=
alled
+# then. Otherwise nothing else mounts /home.
+# embedded-crypt mounts every CRYPT_PARTITIONS entry with a mountpoint,
+# including noencrypt ones (raw device), so the mode does not matter here.
+def cip_home_mounted_by_initrd(d):
+    overrides =3D d.getVar('OVERRIDES').split(':')
+    if 'dracut' not in overrides or 'encrypt-partitions' not in overrides:
+        return False
+    return any(e.split(':')[1:2] =3D=3D ['/home']
+               for e in (d.getVar('CRYPT_PARTITIONS') or '').split())
+
+IMAGE_INSTALL:append:separate-home-part =3D " ${@'' if cip_home_mounted_by=
_initrd(d) else 'home-fs'}"
 IMAGE_INSTALL:remove:separate-home-part =3D " move-homedir-var"
=20
 IMAGE_INSTALL:append:buster   =3D " tmp-fs"
--=20
2.47.3

