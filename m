Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.48])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.2110.1795163166724666808
 for <cip-dev@lists.cip-project.org>;
 Fri, 20 Nov 2026 00:26:09 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=zfVUYp8M;
 spf=pass (domain: siemens.com, ip: 52.101.83.48, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EBqyQUlVYfuP9Hkzw9Jr0fZRb5Rlt519b4RjbbIsjdc0KapeH6lo95aJW3nn6Wv38K4WKAIMjKhNEiZ5aBLMTxk/KJbZtMSsXGt2eg1ugBugrCRO+6FnDXqoZi2GKQlMgxPmfARG8I42BX5X2Q1frFK715qKBTVjSDyQf+kd6qBblugq5akaAH1qf3bXeFrqTgpn55yN9h+dW1PFsrmIwLsSYKmVc/JrQKQZwacABwcDtus42ruzT0ECQ6vUQV3l8+O6GMFjx8DAx46hYpG40gzk/mnAvwS0bCU0F6E5RqN/f6t/5nfmhAss6o4aKIZ6Z1OpIceV4418Xa/CRxwSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I3lowCLCLFmAq2JP+N2v1YgxCiQRm6E7N0zVmQ8prm0=;
 b=h7lLjEkrTXyRlTWbbTYqPvmAN3KBQmBWGcAEFgsT5ANVqSFZqUZr9OJhgNfLhhs/iZQl1GvGcBTDOT23XIK8DEVNnAQUlkqCWcNARP4/0gWgLED3TlWHS7YX2AOvalc91Z6ri28wiy92zWN7IyFuFAxhDyeKVdbbr2DBqNbGPD9oxxC/xqDJcMUASJTnrbTYAJrmQJV1zCrY9iFwEz30s1tScLgwzcbptxKNtCHfoNRWNt1QDXE0EpjcrK8EWkKZQIANnajhbNHliotp6LujwGhRUd4oWRPqbeRSlEDODuHv9Vys/5bzlvlodjMDoZZGilcex4q5l5wnf8JmPFJZNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I3lowCLCLFmAq2JP+N2v1YgxCiQRm6E7N0zVmQ8prm0=;
 b=zfVUYp8MOQlxnZLOYzK96s0EtOc3PbwhIQKa3ezWOZKksuAcnvb/SpjlMtMhcOAW88mwyO+3X6s1TH3kciBbUiTlzCssnnrM7nljo/NXl7nZ1V4vptKA+zYGOKHi3/tLV3DGfP92Uq5OM1GGBAiepHXnY7WbNLRVgpho80hle1mrQrt3b+4P2w/ZjSVnHZ5ZhAgVpaxYi1ncDNm3jKxcAOC+KkBxPqC6zmtUG4nIiBiS3MgmBUT0dp7jbtz6VVnFmHZQGv5pKzqNq4Vds8oxEqoNyxF7yoU+IcQdCiRm4rC/8RFE+p/KztSQpN3sF1YZpBwrhLvbjsc91L7Dho3nKg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by PR3PR10MB4077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:97::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.2; Fri, 20 Nov
 2026 08:26:02 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0662.001; Fri, 20 Nov 2026
 08:26:02 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	chris.paterson2@renesas.com,
	nobuhiro1.iwamatsu@toshiba.co.jp
Subject: [isar-cip-core][RFC PATCH 2/8] ci: install zstd explicitly in the reproducible build check
Date: Fri, 20 Nov 2026 09:25:48 +0100
Message-ID: <20261120082554.375548-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
References: <20261120082554.375548-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR5P281CA0019.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::12) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|PR3PR10MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c913ca7-67ea-4547-f7c3-08df46dfe9ee
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261009223027099003|261022115727099003|261022075727099003|261021121427099003|261021123027099003|261102123227099003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0jfzoRctfK8jLzUL9qaZR2IDFAt4YOwvig3bHYtTF5z6+dJrZqUZYnDQfJncNFlrOEefmz1ETAjXXygyKz+SujpwcAIE6iV/gbtAgpB+5l0uITpWmjIaPUUUwd1K02d3RJDJse242Fm1LoQ/OqPiE71uVhGgP2BPcfcR5mmTdy9C+u8virZx2Enm7d3LgjfUnT/++AV+h6o05t/jQnNLyOL6pIjW/hqWX04V7NFCu7NJ+V3ckzkeznPRE83HYTety4cwS2+FxOsx5sNg13qx96wTdj9jhVXCaDAA9crKz2+ahN7bFm0oA8Y4+NnIBFclQ1uNB2q1y55Rdts2kUDZLLhxqwHMGa5hHoLbMlboCDAin3ndSzBCtmqH21UkdPzaM7RwvCchWGLzbcDCAj10pJWulNegSVuE5fQ9FMDNSWG4MrG8JB1XG0Tfbk9mBJ6v71VGpXIeu3r+COWJUw5OiTnOYmwPagjdjFSE7+5TBhkXBz1yn8bxI58azc7ejvc/nbi2hz3RHd2I9c/X6Em6Erme1pBrP0pu/hkd/YFwwkB4Ko+w6lWKGTTv4zrlPW8cyLCLAjNR7O2Cc6qQPzYQIL3lC6DiGPHqbjyBwrDo48sxonoO9804rRYhidvF77bKm5VPKwWM7PTy2dT+gkIbLYpaYmAQiQo3XV+aXZlrO1U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261009223027099003)(261022115727099003)(261022075727099003)(261021121427099003)(261021123027099003)(261102123227099003)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bOmBE4MRtguyyQRE/riIGD2NUTWGVSwvFHCvZ/LSlqH/rF8Z3wg8R5WTQ8SR?=
 =?us-ascii?Q?g+Ty3+5LXhE9oVOiKrg42qYzxhFzdW7smuOpeO0WD8lHq1NIeK98qhvaTIlv?=
 =?us-ascii?Q?Cl7Ug9zU6H72djiGabhPNJ0whKO5CrzfCz7oki2o0BuPISsjsZdEB+Eap3Vh?=
 =?us-ascii?Q?+sNFH7UVT6cWDSk5+G8zFo7fmvMu0IYEoIuakOy6Zwi+BTeUPXxmw1gLO3N3?=
 =?us-ascii?Q?3ehLjoxdP0jXO0rXJmgwXTuWxg9jpkMsfIDfIUK8G8zen+T3BgN3K9JQNXgp?=
 =?us-ascii?Q?dGT+DXi1HOg/3uv/AdpHpGb7Wehstxm+aZkhM8nebKpoZ5L9UxnGZwIe/ZEn?=
 =?us-ascii?Q?lJ8NEDBZxRgFyuWzp+YkHLFZrbNYp+DSqJinytk+GRN4wwh+WJrvSizUWu8q?=
 =?us-ascii?Q?o3yfXhjcMQXXRjjsilhl8IkS5x9MDd3vO5xEPfI11rI2ImM6DnzxVMG/O/KY?=
 =?us-ascii?Q?zDF005AmNf7NwDphlnI9ZuyavdrSoQ5zaXe59oI7tNgGCd0XDIn9rp/5mh/h?=
 =?us-ascii?Q?pjr7JrMHqiKpvugJaZIST7d96Lp8ha84x+JV+wHCxgAS+Y7xEunSh4fIKSM4?=
 =?us-ascii?Q?rHqIcVJR/kKxb3yjQUiorZvpxqtXbuQlrN6lqnrPCuTn84l0htwF4lp8aKxa?=
 =?us-ascii?Q?6XM7TZdXnHw9mOOhSqGnpYGZCwPGemC6vRtfLyn5yiBPM7yJSZ1mi2afnbc1?=
 =?us-ascii?Q?vqBLLwIwuw5cmifqrUgilcGqq7GPtf9i0XujkbJC/qh6mDwiLWWerjVbbB1U?=
 =?us-ascii?Q?nPv0LOtojRz4AvKfzlvRaZZHWRWm83C3Zq5PHmDeenjxIjCFQxqxUk5cmWr+?=
 =?us-ascii?Q?1TBwmy1g9wts8hjwYM4Dpg2PxlwvW+u1NlKYQ3ZZnxwx15PAhXhFEZ1iLxc6?=
 =?us-ascii?Q?5kgOOQTaSsp4VT5crUxFY8qRisq6b4ys1w2gLUTIbgkRlBy0Oi242j4jmNKa?=
 =?us-ascii?Q?hSPinQ0guq/qe/k688kejhsYwR7PKYUYp8kxSQl3lAwniiYWODdZlNMiuBPH?=
 =?us-ascii?Q?bbEYqZTDf01eKBlxpsoQTUJyelmG1yWLEiNdv1mw+cu+uuESmKAjiHB78xdm?=
 =?us-ascii?Q?GD/e31y36itvvaxr6570rgRtb1gP7LPd7WV70cRWYF4yvynzNfBgcqTeL0RX?=
 =?us-ascii?Q?tlf5X+V7UlLWCWDq0YHK46EjYrp4HilSk4QryhJKQVEQyLHD2po9noSv++eF?=
 =?us-ascii?Q?skfza2gKQAuBR3t9D9TpWSADPCilnYlvcf+ntVDUwiuEshJ32pmXJdLMLtuI?=
 =?us-ascii?Q?ikPVSHEhmb7JDzRNJ2wjHmsVWNJRUycsOWAKHIvIXauNkEapUUnRTNi93K2G?=
 =?us-ascii?Q?Sp/raAb+UNYVBbKI1QOegIUrZBeXAhJTbpOIh4V204peVuKae1TRPfp8IjcK?=
 =?us-ascii?Q?fO25mvlwTl4Ebk7mlP1dPjN3PxZXbz1Uw4MLwXc/lYazDDGBFJ9iIHxH0X43?=
 =?us-ascii?Q?AtaffvR9K5/1akc0YKt4PF31QyZOsmT44eVXr4cb7LXcAdDr+VoCLkVYoMcy?=
 =?us-ascii?Q?Z4riSRy8TaqS9kEix4JP3ysMiBRA1UgVk94HBlAXfCitoOiSG/rJctxKBd94?=
 =?us-ascii?Q?kTXIpa2N5AKvIcP5AciDjb492MLrqq42AjMxF8Wn7GeCr0UgiwhgCV3+D6tG?=
 =?us-ascii?Q?N1hNTni1iGP4Kjz19j0hx5nQm+kB0ngy7vUk8pZGmddtHaXvSuWBT23GBcA1?=
 =?us-ascii?Q?mNsyvrpotTr9SsATfA4kXsIMDBoHwlenssWCzMoiLtxzKiHOShq6CqMUNMje?=
 =?us-ascii?Q?5wt2S3xJbUliZg1Kc2pON5ZdKDQibCA=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c913ca7-67ea-4547-f7c3-08df46dfe9ee
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 08:26:02.7769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qZZcc3MKmxG8LA6UhD8sWmlwQ27n4Sh3JCIHgqD1MkX0iFzGK8CgTyqHI1CY2Jsq9nFu5dDlQ/2SNB+pQWQU8VC93sVxadV1XGX+y7EiARI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB4077
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Fri, 20 Nov 2026 08:26:18 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/25029
Content-Type: text/plain; charset="utf-8"

The next commit switches the deployed wic images and partition archives
to zstd, which the reproducible build check has to decompress. zstd is
only installed as a recommendation of diffoscope so far; install it
explicitly.

Also use apt-get instead of apt, which has no stable CLI interface for
scripts.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 .reproducible-check-ci.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.reproducible-check-ci.yml b/.reproducible-check-ci.yml
index f8a79527..72089685 100644
--- a/.reproducible-check-ci.yml
+++ b/.reproducible-check-ci.yml
@@ -64,7 +64,7 @@
     extension: security
     image_base: "cip-core-image-cip-core"
   before_script:
-    - apt update && DEBIAN_FRONTEND=3Dnoninteractive apt install -y diffos=
cope wget
+    - apt-get update && DEBIAN_FRONTEND=3Dnoninteractive apt-get install -=
y diffoscope wget zstd
   script:
     - if [ "${extension}" =3D "security" ]; then
         image_base=3D"cip-core-image-security-cip-core";
--=20
2.47.3

