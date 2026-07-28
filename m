Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A46C54F54
	for <webhook@archiver.kernel.org>; Tue, 28 Jul 2026 13:13:01 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.47])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.11067.1785244370667933537
 for <cip-dev@lists.cip-project.org>;
 Tue, 28 Jul 2026 06:12:53 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gxScCUef;
 spf=pass (domain: siemens.com, ip: 40.107.130.47, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZ94Hhm39R+XdSK1OKtb65rphnO8LH2lH/eTWd/k0jyTdFRcFCz3Pmn2bkL8X+Z7lbelxVhXHOu73WIfG1G7ABpC1wFnsRZvTzEdQSKe/3NVMNLImA8EbELbY25/pKnT6+D7Bq16v1UUtVGGa0xfpnJjP3XFINJnPP8wx+M9u4LDYCEFejmcHg6VQkMHjbkqWmnYX5d7lI+IhVGnMTWunqQRkOCWQ+TAFXAKHXmDsWo1v2HClFTvrcuq2KY4VbZa7bqjrUoUL/ymoK/ekdeJYdEwB3fIpUzDnWFtPYyc/zFVpC07RDwOtVPPx6uWwajsymTGbkoIQKKXob0mngO77g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQZPhLfAPf44+VsCxN9nQVcwe7Os2XNmUcpj83dL4GE=;
 b=rHFBzeqZTBCQctCsCyOXmVhEElR627ypONFpLTngGMuJexPl4oQvTco6M1nMJPDkpKxR7QYER9Wj+KUAUeFzLuHMKb2/PEeaXoNn8AHz4OxZvOkEJZnrz+xKokBO3rUGlkmdWGa7eaWqH42kwf0zk0PL8Mvm08XtKOf3Nb7K52t8Iqpa6FcAWr+60kKitHnHGsrCpH+ZouGsbjWVYodS4MDHd+H321KZhrGhI3vnosO0+xbRaMo0mZoBe9C7V/PIN8JJlXmSuhw9Q/PgtHj592hc55pIxp6pfIWXxBLx2Eb/pQi93rDDadiN2Li9eCy6+1UvPppRQsNiztmf0yEp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQZPhLfAPf44+VsCxN9nQVcwe7Os2XNmUcpj83dL4GE=;
 b=gxScCUefVSuz3l2uhsq+ouEq6YNtXrnOhsG1ykTVPNLcpffeRc+84T9fKKWNvMXFHQeBJUFgjGSxji9jStQDtWj0z1YOs8yJRbPDp8dvlaQVN90GKnMLZIwF0+GaRBRfHjJzdkOO8LCpNlYOr/caYMkviW80gb/We9Y6nkmuRx5+PRwmGKmfGZ+u6UYVMnmvefQhnD7y2TE8ldxdNT8+cGZN0rolOKLw2VXwPp8LVSF89EauiprOieA7h/OsNSrqiAaZpM5q2oCl0R/qFQfPyxVHBD1GeFadUgrzOMWYYTPJ/tPlTKXpWwOt2JHNIfmggNB7QYWda91WySTugHuODQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DU0PR10MB6083.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 13:12:48 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0270.009; Tue, 28 Jul 2026
 13:12:48 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v2 2/5] update Isar to contain rootless changes
Date: Tue, 28 Jul 2026 15:12:16 +0200
Message-ID: <20260728131231.117214-3-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
References: <20260728131231.117214-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0072.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::9) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DU0PR10MB6083:EE_
X-MS-Office365-Filtering-Correlation-Id: 58f5371f-b2f1-4e8d-1df9-08deeca9eb97
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	yHhGlm75bZnXtAIlSKQvvUgfVG3lMTRluUnw5O4ZPl3UyvKLOAx7RvgYvEn9pGtHzVAHXtwQjybhTY76QUZVWDmUTMazppImT05KPfgUeurUv+xDSd7XtUVkgYiZxPiay9DYR7BREJ28tNj1OMYtlo10og09nD7AXTb/6moljLdj2kga9S2JBCRBhkLQ0UyMcF909pPCvwXDb6kVI4eTyyC/aIq5SAusMQmAvPRD95OtWY6FjVkARZbrAhXaQZHzRBgzeZotXomx/QdVei4rwS+gkfJIpVSUEFpMv+wvTc58VES2J0Zfn8zXSK9yOjDy979Tzyx2mp+JA44KMQHfQzXt2o/F2dBtzkn4zTnVa6sfe52G+oV0G96DmsJA17jTmhCf8K3cwvHBKePtXeB1xk6yzvOTJ/osMy1n2NLrC1608VK6Z5wjGQrX3LntI4bJLn1kTHsc48ODb0v0pMorJg6GMva0lhWsksQlSu1sKGNKEEITAUdvqXw6lVxb5ykH2ueIYPRUQVgbxpJdD9nyjRXF0lYJOIppcuDXV2+FX9u2mkzUowHZz5G533VPakaCnK70LeuDjYDjQG+Ji+4wao7kMW7BaBr5HazRa3dYqMwhIE0pFj/Q9rQug/NMQuPyMFM1qqYUtzw6Vj2XfBLMIqfk5eP3LXTLteI8ebGnlts=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6SiDDXQpUEgug49cvZwSS0WLxze+FBJPR51Wd7TDQASqSshDAGfT2hBBmkJL?=
 =?us-ascii?Q?s3RRMPBNMNeUIbUy65u5oJINHtUqrghsoSGE5dlVo72Fxigl8hmrs7fRCXae?=
 =?us-ascii?Q?WgbR3FVTJvTbrZ9R4L2l+zTYuRKp3uVrx5Jzgo5bllO0MO/MVMmM8fcZ8KaV?=
 =?us-ascii?Q?YyLR3yevzbP8Gx0t+MnAm7N+XpuyAX3YyixRvvMlsYlNB699XlagasnKO8/f?=
 =?us-ascii?Q?8uPFOcQjv7LQTJTkfafn2t1NZ3vHaRnSv5O8SJlWJBslnlqvidjA7NAdlju2?=
 =?us-ascii?Q?FOho2fmR5+QNxuwyOjG5eKQzP4iDhHxBk1hyo3+UdQeTXyzKUtfoRIGNT++y?=
 =?us-ascii?Q?qlp3gvZkd6kbGo98lu8KpcfiUdZ2jIDeZXrYQrmUCbKvvLtSEYfUjAkt0gjr?=
 =?us-ascii?Q?G1YTUYU5EShAwebacO6wzaNz2jvHSRtT5GpAT16UHfOTDVKGVAv69kkowqMB?=
 =?us-ascii?Q?p8Pk3Ox6+Y3HqP2mQPGAdiRlEhIZbhPWsKPBH36E2k/p26ccvf0sTb4XAHcr?=
 =?us-ascii?Q?5uXRAe5WUAIZ8GmDlXe5kY/DhGyCUWaOleq6UK+NEFBxj1lryTly4ATH+0p4?=
 =?us-ascii?Q?eul/j/+Z9/xs8fXc2yVfvuUB3jzJEXwS/YGzjIB0OEqr4hLMxHacq4nDLgFZ?=
 =?us-ascii?Q?Ri/NMOQpAxS2c3i2wd6m7a8ZMZ/+LjNFG+8bnyCrIAsG1WM7hWua0nTw2CYf?=
 =?us-ascii?Q?90clidjTkmJSYpDIne6RnuL6Up+wD5aQTVM/uJsIXGsjpxzG4S3zGtitca78?=
 =?us-ascii?Q?VLG51ivAbYnLoBTWgDI+VM4lAi/c1iY755ZFqZ5BJh92po3WXbNEZsOFmnem?=
 =?us-ascii?Q?oeKWBPpqpIYBWTpJkiuTvjOzfpw2OJc7+PH2imqIFSRw/tmKO6PFOrkO4dZ4?=
 =?us-ascii?Q?KDRfL80qoYFinX3Bd3YqFT5rC7yALA7NLjGA0PWQ7R6CzhRTw1CZb9lUSVHS?=
 =?us-ascii?Q?GYRX4QvDD4S0gs7s2aHFhNYkesLEQoUkbTLS+KyLEsIh0KiSQVft0yJAv02f?=
 =?us-ascii?Q?Wy107PYVdUKEeWGOxxZn4K3yXTW0MAytxM9NgbygQ6DMX+Qre0Ut9NBlJm+p?=
 =?us-ascii?Q?8DD+0ZJy43HjiVqV7C8zhcHhdr/Dm3gP6S6oM6pWazzU3iuuijPVACxAKpbI?=
 =?us-ascii?Q?0+gCfdOtPDkd03BtGs6TxMZ0yIDDFzdvrhezSGpUgMd3nAGnxJlB2V9SpQUz?=
 =?us-ascii?Q?wmmQGNs5lbajTMnGoNQ+6cCtcQoX/sy51F01Qjldkn3EhG+r5qulXKjRDnoh?=
 =?us-ascii?Q?IPOn9kpt030paWyRM1aXhRpWTRMBi2eJ4pH5FZNXl1a9TsDDG/xQklMeGOHu?=
 =?us-ascii?Q?ERiuNQSYcpHNTseoG6nnOZh4jOc8119BxeQtlbOCrOBaSiNYNLJqNONalYYq?=
 =?us-ascii?Q?zn0hLM4QpaLhUiSSt5jIFqIUfsb+Uhw3smkmQvMvLjH76FimoOWKu6igWlt9?=
 =?us-ascii?Q?NFNJ+v76eLByReoMdf2uf7dR88pFhNCCHY2baf26Tw9rHjAErbIeERUatXYB?=
 =?us-ascii?Q?3UlOIXrwEbNS7xZZou5lJakg+zJALSJ6js5hELd91L+zxKcGZ1UJj7TkUfqg?=
 =?us-ascii?Q?Tr6a4vyH/MIMmWzIjW7Qmv/XsflMp7Az36dDJZiG+SpA+briy3dhlC3DdvBj?=
 =?us-ascii?Q?+HS0h6LeVVrBXsOHlK/m8Lke/qXhyN88taBZJ4AwsOiOizPG5pKJalafww5+?=
 =?us-ascii?Q?8PeoinGR9lKyjZi6PnMVT6AbL5L4lUormechCyruYemg6pcXycIR33QGy332?=
 =?us-ascii?Q?nEflvkfFotAjGxTtuWfoqvjP/zMdwlI=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58f5371f-b2f1-4e8d-1df9-08deeca9eb97
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 13:12:48.1810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VCEIakZujINGEFt6uNHVZhWBHCYmvyTg1bWAqVLjJ2/skzlRISHz40NnARBDlCd+UsVbtdNem2QZZxh11ih08QqjyE/uZzv45MAB4knQoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6083
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 28 Jul 2026 13:13:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23799

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index 6badc7d..cbccf63 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
=20
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 3c645ee8dcd3d2161b93a3b2f9808fe1829850e7
+    commit: ea319eb835aea545f23266ba15358bad029a56a0
     layers:
       meta:
=20
--=20
2.53.0


