Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.52])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.9846.1793708045045636283
 for <cip-dev@lists.cip-project.org>;
 Tue, 03 Nov 2026 04:14:07 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=BhJWKPjb;
 spf=pass (domain: siemens.com, ip: 52.101.83.52, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fR9ZQID1HvikPb2pHPy9dCA6Ttcw+6J7O5opmQRUEVCpTf0lEatEWo/l6iLYK06Fz95p7FbreNv19GlnOBrSnU1HByCaNrNCuV/cIBkLH5ggnBNCjLb+jzWsvAWfjvxuG0Q7vV68zFQDdIygc1phtWRGwgZSHYIIHUnCB4HyM+RfbVpmk50ujCUzHZQNzW1TRjTWRkRcE6Hdr7xDfrxylVNiCEHZvZ7sba9VPwDvwMe0k59Ev8qjqkHqgZTcegnF5wkAvAztpdr1po0+GQzyfa8ifOrbKH+mq8iey8Y5HqNI5fZQhtmSVs1SaHHiGhGjvP1Za56K3dLL8uH8iD9yBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1U3vJtvwhV8rV7yUsiyy2WrJsTTabdZaIsckWJQnkQo=;
 b=hjTWVHx6wEiiRtrfmn8xaFFmnNa2i9it1C+I5Vln3uUUGnj+Ak2+/RXYd0J1TiIuUwMM84FxAdjdFr8HoOYBxcSzayqEgmAZ7b8R0Jmk0A5jbXvjIcsnP3in982Ruya3id/cc0o7vyN0IwAfs3wCDIVwLdwf6ZcVlasMSdYPCoySJsrBd8srxy0m5j8ggp50o9dv9/Fq9LRrhJuDuyOmnjSjQOmmZehsmZkmUNGqNb09s0iwXeUrfSDfDopAxQPjzaRVkfkrCg9SsEj1suzobrMsjVb4kAmq0BsKBrWy5LEOTfKNtkn7s3IsXPUMGq3mh3Y9QMNk0L+DHrAZ81DevA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1U3vJtvwhV8rV7yUsiyy2WrJsTTabdZaIsckWJQnkQo=;
 b=BhJWKPjb7TynuT/SOpMu6XP9N6LQ6/gpnZDKzkGrtP0BLbpG62kWGlS/86I1OiyyTSrnsoPkEaSEJhHFtJ/6NgmQjG0bObBSzuemW3POpApXbCtvOjELPn05Zzps9L6/TX27pe0X9KYIdDKJLDVSFWqp4byfCnoY15GnC8SmKMY1LgpqdPZvwYEm3rojo/nAUUZ0qMT/+WTztAAzFLRdJw8X2bm2AwrbXu3JG7g5fmStdy5fnaRJzdorQXCqorwzC+q4sDp9no+xEDsdexj7wyQb+wf8CsBBFL+/KX9ehTvLb09a689dJBvQeD7cToQ/2mQc4RAXGgZfw3uIUS405Q==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI1PR10MB8064.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 12:13:54 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 12:13:54 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH] fix forky tests adduser is not installed automatically
Date: Tue,  3 Nov 2026 13:13:39 +0100
Message-ID: <20261103121347.278803-1-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR4P281CA0087.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::11) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
Return-Path: quirin.gylstorff@siemens.com
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI1PR10MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: b96b3886-b27e-4b2a-fedb-08df39a3eda5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|6133799003|18002099003|55112099003|10067099003|56012099006|261102123227099003|261009223027099003|261021123027099003|261021121427099003|261022075727099003|11063799006|261026121527099003;
X-Microsoft-Antispam-Message-Info: yW0FaePX8chMtku9d6GPF3IP9R2nDkod9zQ8hgI5oUl1GkNDVm19j4Cl/XX6J9OqtZlcJcOzr7sexg6gLXkSnSjRHTODIttoyUJJDku6jRLXSNMgjEareknTd5DMZrg8BKvddrjmXnCwWlaYzvNBSvN3H0tCnHc7o6/c6zwCTN558aFGPu04jnamSzLInvDbvZDDtErpFup+xpsbbKqt/Pji2DugKXqTlqbrGWGD2HPSAGCD/m6ivcaP4no7XXnh+lT54dxuLTZasv96x36O0wJCUIEVVeCrErsyINrhthqqKHtvbcLGrLbevMYd5u3gPlN5qIk4/S+WZ6LbP0m+FCmwv+2YNJOb7GYkUis0FZaT3qAuf6NqfqpRzD1eJ5mGANqM+/3f+iJN5Acg/f9Nd8XWu/9m13C99UTCiaqUlEMuSrgR/e05485WDeOwxqQsgcgvgrkfM5vfT8hBqPwz9h1KDrzrCbT64llVIn4aqkZbAGpa6QzT2JhCp9Dwm0dPoyThEVuP8xSrPQxZfDm1NTT210zX5TNXUpvpZeh1u+6eZUvNXXZOQwwa1wBizoCNSnpekRkJ5wBFcaGe3dJYswHgkwzppWpklLxS6DA19PM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(6133799003)(18002099003)(55112099003)(10067099003)(56012099006)(261102123227099003)(261009223027099003)(261021123027099003)(261021121427099003)(261022075727099003)(11063799006)(261026121527099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yrIrsd3ao3t5/01ZCUbCxrMdTj49w7f/3wgOCSJtlpJbSR+fqgO38H+bfEvL?=
 =?us-ascii?Q?1TFTHYLi9RiKhXLUXF//0h+KbwNcsd8vU4W4X56Rmxqw53/Cc/XmrDGc7LbM?=
 =?us-ascii?Q?3X1frggqoPh0FbhwjzpYUbtwagxGbo1ATIv0mgO3ER3kJobWcpD6003DcvNN?=
 =?us-ascii?Q?RcRhvEjkrBBwPwnDP0aMgeX7Bgll7jy6Mdc/4txVQKF95N7XItgOyv42edBN?=
 =?us-ascii?Q?+ZdPzeTcKVVA/qZH+3pZJJQ+G9WRXUJl1F7Pk7DtC056RRsyEiTZU2MQGqe9?=
 =?us-ascii?Q?3GmeLZUc2EgI4+dcglUxwR5NPVeeCcbqvynqPQlptbiIipzgrAg8ydHbELe6?=
 =?us-ascii?Q?Tj0T6znu6t8TQPF69dFWPGwYI+zRRN8wckWIbR603HJq3ftcO3dIe3Kem3yr?=
 =?us-ascii?Q?NLDBih6h5wqgVKesEQOecFaTO/VFfE8enNbavNw7a8k62E+Ngw5qfQ7ctegV?=
 =?us-ascii?Q?rkRD9nj6irt/xv/0J/LwzPXdwWcq1byPWDlZ/mLcErmOJUdLXXf37Guz1UyL?=
 =?us-ascii?Q?FvsE+JJTrc4rwlq6KCVcWA0rtTbZ41wc5dYxDpC/hZ0mT2oQmssoDZOs9xgO?=
 =?us-ascii?Q?YIvTJCsZ0qKpiottIsAwCIwl4OiAyP/VS90cGzzW8T8W1g/jGCLu8QaNYNsF?=
 =?us-ascii?Q?RAl9W6YANiVEkSWZKVJGUKftQzf24wRkDG70h5ezMzbkaUNixtQW7Oerv7h/?=
 =?us-ascii?Q?LmAdZWguEkcjYtCZIY1Xeyg9yUNWwgvmJR1kNRmB3gg4r5s+PpWiRqC3dRKD?=
 =?us-ascii?Q?y3D2+kDySHFlW3Zd+nrcdgd8IvLt39AOKIDrwIpgyfl9jLr1gv8qaFvldZ0q?=
 =?us-ascii?Q?rT/ZlgpRha0ny/NsU4G6BNCzvwEYrHN3hGlj+Tl3f3He1r+BbOoP36krXihp?=
 =?us-ascii?Q?paRp1Awkw32vtSTskGktZsnwvFhvXL/qp03NbzDvzzVv3jwU5QOzZMsaz3TQ?=
 =?us-ascii?Q?4/QLRDvKz8Fn8INxhCv89YshZ0iucguklHeoTlkf4m4x+7bBZ0UjxOfpy9Wd?=
 =?us-ascii?Q?BDwcUhECrrkUzEgQwsmC9aZBsqa9RMNC/YFlMVixjUsqcgfsOFAIN+dRV+gz?=
 =?us-ascii?Q?dtLrXA/Febo6JY1FODV1D0DNDp+Z+75y+YzP6ZrSPSk9wmWtxRHDyv/xZDfO?=
 =?us-ascii?Q?/rUxAQZkS6TFf3Iuezqx8sHmu4x0Sa1ThfxrJtnkB+Y5yHLXoTwqMu4FCA5G?=
 =?us-ascii?Q?wQv/wSIBLulLY8U2OoUlOY2gzKkuB7eqwdbFLNY8/QD5LqEZhaxovwsJhOUx?=
 =?us-ascii?Q?hF8c7H6Cx0FJ0x7L6PxMgZeF0kLJXYYhIKtMnFPuHUFT9nGI0iPgvdaeSpWW?=
 =?us-ascii?Q?SCpH/gCQkZCGC4yoOybEe583i6CgJa/dhVLIoID5yOXD1q2CAU5YdLYhS9mg?=
 =?us-ascii?Q?5JIqQLvn3vYd5tbpjrEB9N+L7ZAwS9eK3fy65eMg5qEiLJHYVQ3oEIMxHpBX?=
 =?us-ascii?Q?JMAWcj8KzBcp+0L4stX2mJJuWZrhyvPuQ7asbWgTqx8gJXNJseQ6s4h4X+zY?=
 =?us-ascii?Q?vZIXBa9nCKhg7Au47bGU2DlSr4CTW1vmRvyP94BS6KjGfORbfYRAWMCJu8UN?=
 =?us-ascii?Q?UZNkFHQ3LqzOHv3SEscZRgr1S75RuUc0lEoI1fTZ0q3gbOZdSgXkq34BvNin?=
 =?us-ascii?Q?30AaSO4HtSNo5zuRTdPbnG03AukXeOULLazhL8/1iPQJRzz2qDmGmwc76iJB?=
 =?us-ascii?Q?SnS1wQ76jOrAzrSBqnJXlJQ4xk3CBKOdbKb06Wj52aduvBRmO3McitvFlajp?=
 =?us-ascii?Q?6YlsHDoCT6JMiQNoUGzfaH/ZvWs7rUU=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b96b3886-b27e-4b2a-fedb-08df39a3eda5
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 12:13:54.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9EtsU3VXnfwcV3FLhR+C/7li/eO75PiSXeg04cPWNwmw3HjzXiPGpIRLRWYGgmHF4Ma2PMwYCOFFteE/iSyGsEpzWR63X+FkUwzTuPpXz/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB8064
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by lin-tor-korg-lkml-alma10-1 with HTTPS for <cip-dev@lists.cip-project.org>; Tue, 03 Nov 2026 12:14:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24631
Content-Type: text/plain; charset="utf-8"

This adds the pacakge adduser to common to run the forky tests[1]:

```
<LAVA_SIGNAL_TESTCASE TEST_CASE_ID=3DTC_CR1.1-RE1_1 RESULT=3Dpass>
TC_CR1.10
preTest: TC_CR1.10 Authenticator feedback
INFO: openssh-server Package  is installed!
INFO: openssh-client Package  is installed!
INFO: check_user: 'user1' exist
INFO: Deleting user 'user1'
../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
ERROR: del_user: Could not delete 'user1'
postTest: TC_CR1.10 Authenticator feedback
INFO: check_user: 'user1' exist
INFO: Deleting user 'user1'
../../lib/common-lib: line 93: /usr/sbin/deluser: No such file or directory
```
[1](https://lava.ciplatform.org/scheduler/job/1538035#L1072)

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-core/customizations/common.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/recipes-core/customizations/common.inc b/recipes-core/customiz=
ations/common.inc
index 0fd3d4f8..7f0e8a0c 100644
--- a/recipes-core/customizations/common.inc
+++ b/recipes-core/customizations/common.inc
@@ -31,7 +31,7 @@ TEMPLATE_VARS +=3D "CUSTOM_HOSTNAME"
 DEPENDS +=3D "sshd-regen-keys change-root-homedir"
=20
 DEBIAN_DEPENDS =3D " \
-    ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh, sshd-re=
gen-keys, \
+    adduser, ifupdown, dhcpcd-base | dhcpcd5, net-tools, iputils-ping, ssh=
, sshd-regen-keys, \
     change-root-homedir \
     ${@(', iw, wireless-regdb, ' + d.getVar('WIRELESS_FIRMWARE_PACKAGE')) =
\
 	if d.getVar('INSTALL_WIRELESS_TOOLS') =3D=3D '1' else ''}"
--=20
2.55.0

