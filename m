Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFC9FEA839
	for <webhook@archiver.kernel.org>; Wed, 25 Mar 2026 09:23:48 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.64])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.18493.1774430626481476095
 for <cip-dev@lists.cip-project.org>;
 Wed, 25 Mar 2026 02:23:46 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=GhuMo6lj;
 spf=pass (domain: siemens.com, ip: 52.101.65.64, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ajr6eEXQQNXiPMYWE8PatxaUkkLPkT3bPVDn1D2XUeXRfmFSCeZOSjXdTQiek+7V7MnON/MUqD6JyeK4Kkhl56z7NpCX+5Jz8MJpMdLnuEtRnHHOPxZUqcSQOaSfX+BgePoCI7EjfRlTSgExEKVEvOWICT8v27/ehVAZJnUyU5IYvWVZD9KJYOz2bdFaNPbHm/ISBNBzNyg50TnpnWCDmTrmHf1sjGNku8elFW+Qx8C8srcQyHKGfQCekGhJoVxRex4uz5S803DSYKI0Bplzj6uF/NE2jdv4i9P6Ezy/V10Dldfq6ye5AyocZp4wycJVssyFWA7h/OaBKIGpbGfAqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VapziRwGCN2vFhIr2hK8X6LkSIyvNX6XjU2yGtV1ZZE=;
 b=YFcYCNog4RcnAubPwO4mVaJw1fjh51ROHWtUQcZp9x4REluXTjWhVXLbs2MpTLjAvEGc9YusaOmYI95qw8D/960X2rOQZgRCWA3i8HW8S4Evq4xG3rfY3AH/qiQQ1jFs9HagmE9yJDkQ2QPJzBNWQzZKMMLjqBiqmgJaFzmAMEVTzLOOv9t6Hik0HjJ0zESFC3NdCKhH0RcRRV2SfY4CTZnM6aNqeXLC70hjpt8nHgMI69bGSjExJ40mjRJEfzQmcvU5hSimm2+lMjMjS+EIbHPmpMP/Jn5onDuasjs448MhKlgyH9r6UcTNR93Y5gAvir/0/6phwpUU/IeIFsIolA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VapziRwGCN2vFhIr2hK8X6LkSIyvNX6XjU2yGtV1ZZE=;
 b=GhuMo6ljNvrXIXO8YdUmP6NrB2lqB77TTB6VFEEI+qlKAF/rOoO1J0UFb749ADsf1+EKJbLhNpvTsZynPLKFUh50y1/O3vu2HS0vz5TdpPwn41s/49Lftw4BInT+UxJMn71Q9WRJyvHOdZ8+XJkewh4JJ5a8astiIge+92RgE2KvRFxKdxFZio5D8qiCAJi7Nue9sNOP+qat8a1fwvN2LiBe7XLL5WRvSQjecIpcKefsY9r1aFXipfNRqQKFLLOJoZ7GjBeyRuMW+k1lVhtut3PG+zfUZs2/OzmKBlS4S2IXNwn9U/1WdYq+Y8Jwpl/8ct5BeHHmsdJr/A2W/ID0Ag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5f6::12)
 by DU0PR10MB6932.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:417::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 25 Mar
 2026 09:23:42 +0000
Received: from AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5]) by AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::349d:731e:a849:b4a5%6]) with mapi id 15.20.9723.030; Wed, 25 Mar 2026
 09:23:42 +0000
From: Felix Moessbauer <felix.moessbauer@siemens.com>
To: cip-dev@lists.cip-project.org
CC: jan.kiszka@siemens.com,
	Felix Moessbauer <felix.moessbauer@siemens.com>
Subject: [isar-cip-core][PATCH 1/2] chore: update isar revision to latest master version
Date: Wed, 25 Mar 2026 10:23:32 +0100
Message-ID: <20260325092333.1651628-1-felix.moessbauer@siemens.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0138.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::12) To AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5f6::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS2PR10MB6823:EE_|DU0PR10MB6932:EE_
X-MS-Office365-Filtering-Correlation-Id: cafde811-eeb5-4a4c-9289-08de8a50348e
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|10070799003|376014|1800799024|56012099003|55112099003|18002099003;
X-Microsoft-Antispam-Message-Info: 
	CEwFjb4C4gqTP7z6vxbq/t+bneAvEkO1R1Pa3ylHlmhkHqY+Vy4+5rHq8p+TbM9wVN9O8xXSi6TuaDt2bgaISrfsJ4TV4Fq8zwe6wSTvT8hAJhjVgROKtrpGa2+AHCoDuOIJYO5g17MvgQGemI7tS2xIDPOLxg0VbRYTmJsHPDE36VgJGiCogBdxpBu9hCTPGJmujd7M2HWrFOdXqfxR1XMi6VyP+siM6hpXDITAHdwgM21FEzxwb6GF6NHr1NVHC2RghyiV5Fdy/gWHju6u9Y/XCaxTxQExnq166A99vDHtuC00kF6BYWEgMwrL3KSeArtG7ZWcZ0A0v9OHwDiDMbfftfuZxT1d7VylTnOBLS7EwkJU1K9xSwBeLB661qAUBN4+08NZPLSVyFyZpDXQUgkB50OLIGuHTnU2n64VyGXY82PXRJVoTJ4OEV87IGnvkyo2sg3AVGKQt64MOOVJW2/GD3UxcYtHlptw1v0Lotq1N0/5SyZx7/pvJZbP5cZrDdHQbfAvDIHez+VXmWPUUnKTpprQHPlpwAjQvzlSlg76MUd1+jEHhGXYEXDjvbWkSGDt81ftl0lutgOAs73jVkUDm5BPhB8gVPEzQTQRqpEF+Xtjz4/clA5iB5IwezAJbLzfHItq8F5IJVc0+fz9y2trFaPGiHac6Wm7P8EjaqvPAxIKsx+qV+0lhglRTyUEiE/IWWPO8tbAoy26sFUcqrmOrfnoJTQnTj8pyJIiMFY=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(56012099003)(55112099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?saJcZ56eoYTeJdBcu2FPl8nCeXV0AHmgdi7r/YBwwZjxkVEhOKwliKlkwUbK?=
 =?us-ascii?Q?Pgys/GbMLGTa+gh10SmDTRaeagVKDalgahQVLzxCeA8oQ1t2VCx9/CzTLvhn?=
 =?us-ascii?Q?C2VixoHUTKBtDfpwM2by7EYE4bOfxi9DRLBeyUM96kuhiXu/RPp1Spg/AeTW?=
 =?us-ascii?Q?gfrKLhpNr8T+KqfGrd+jvKAtroic0758Rgzo885rj1Tj7cp+jUICpEkEWuMi?=
 =?us-ascii?Q?Qtwu+u1GeQFWj69+Gos+f9Yc5aV2/xs17ic+SI1jHVZYLQ8RQp7WcKTWNyBp?=
 =?us-ascii?Q?IavMNN28ecDIa7e4bO6wLSnJuHNk2mIwqZ7Prp7+PDzz1Iq5pKttPEw0aZ36?=
 =?us-ascii?Q?LRTmGGSC/sgq8JpP/sCSO1iZJQIw5zuG1rL1A18QoX0nu8QLmReAmONe+g6B?=
 =?us-ascii?Q?dfFOiNaQ897nEmWPQkryE8ev7xrb7SVBxURCxEC1n2Urb/aGXcl3thHe5J/6?=
 =?us-ascii?Q?ZYo7QLO9xKUIuSMQC14waIylsl3+A64liiiV7tpmRBDMB/yb7EhIzabCAh/m?=
 =?us-ascii?Q?j7MySk5XjEaVy046zdGf5siUUnr+S6exusJF8374GQbyDX9O3MTRSzjSxBMw?=
 =?us-ascii?Q?eX+05JSUiRGhA96KYxuhFAANGrdQkNvh5OxrgR4H0B27pK/W+8hOLTycotZV?=
 =?us-ascii?Q?LgLOBvVpAxCm7w4YrqOpI67EyMiP+eVkSnux67YYW12B1bSk2qaCv+WSz6t4?=
 =?us-ascii?Q?/5TL1+a4Z79EPtpJq57yZp5z358gNxq1b8HtM0balqaet+qyIqi/ZGpMZvwc?=
 =?us-ascii?Q?fuAfSYwQLJCPRsmV/C/AaOHX77ZGaFG87/6908mlIIMEV87xR/0AbVo/PmFP?=
 =?us-ascii?Q?r6oHMJf1GaR7fa3lqU02m0+2IWwhvt3Od/Zhzs4077G4Ck70vN3mSTg5pbAr?=
 =?us-ascii?Q?I0W7dosHw1ybAktt69oESmWNi0wxTHugBJbM7e/PjPT51G34HpO6uB/dyts7?=
 =?us-ascii?Q?vDK9FHO9Aux/Ggv3mQncUNAZzbEaiaBiRNFJ2ROWVV1NUgse52X8ahjYVbiN?=
 =?us-ascii?Q?qL/TalcMg2yUfw2f9gjIcVVG5NbAqWJI517FuJyMsqXeekleVMYbkF0c3hdA?=
 =?us-ascii?Q?fAOb22OwvSrVPLGxQHgKpxREeiP3OT0r/VPuX4bpvO7Hkcy3QxfZxA7k5JuM?=
 =?us-ascii?Q?+UCJYlDjIZlwlrLpB/GBZaVagbKmQrM7T6SuJ439C2QvWexaXpwcQ2seegkL?=
 =?us-ascii?Q?jYud0cm88k3ADD3SYj5K16Mj55nY4AK1Aqx/uyKn/fblLuQJGHpVsOFO/52m?=
 =?us-ascii?Q?H6+fsRwJfiS8UoKG7BCZTAxnOCNBnRbTZ1yAzV1Ptnqfcx3CSSFvCJduppMc?=
 =?us-ascii?Q?Vo9sKz++qCV5RnEolLgF6AmZzGTMBB9HzmNiUUKqhi3+wOzheEl/33QOUKBN?=
 =?us-ascii?Q?Npd96qPLoZxmOApq/ejXtpkP5rfsqt1Cv6hfxEQBVUoPbQL3h4J5OwllrROm?=
 =?us-ascii?Q?glwBxVUvbP8KCdDphPAOO0p753f045TfqjIlxTx7popKwiJyduACQbsaLJ7/?=
 =?us-ascii?Q?p+Bc4y2Yy/QzYiYH7Mos1WpCwNPyAHzBItCPxH5VxHsmmun0GUsLOxgErTeA?=
 =?us-ascii?Q?zUOt3Zdg5M1ushfnzyDXslqciijxjproeGCGnqGmkdiVwkahyMeHpj3xUl0w?=
 =?us-ascii?Q?YsP5Lo82yqSZ9HeYveeciR6LACSGoGq9X3CMBcUlUWDvbQBF9kVrYqvcBk3Z?=
 =?us-ascii?Q?RVplIR9j3i/a56+cXPys8+JPJRiWeFqro3TBzGaLolmlBAyW9OJFItMDsd/7?=
 =?us-ascii?Q?EDt0HSu02eksPx3ZUZFUuiBcsqiG9kDVzEvXiDwVvFaLYCaKLegJ0utnB1Jy?=
X-MS-Exchange-AntiSpam-MessageData-1: qvrg6qXwrXwwgMzmo2Z5xcvLBeO+Rsrh5WU=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cafde811-eeb5-4a4c-9289-08de8a50348e
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB6823.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:23:41.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1nZrHwCdSAW74aZgRz9h1zb4Gag51V83S+kr8I2DJTpztMQVWPL40zAFSbe85hodzQ9qbfcRHzQlMthonrrG7xQMPsKO21RNiM/brngwnDo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6932
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 25 Mar 2026 09:23:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22561

By that we get support for the imager-bom feature, as well as a couple
of bugfixes.

Signed-off-by: Felix Moessbauer <felix.moessbauer@siemens.com>
---
 kas-cip.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kas-cip.yml b/kas-cip.yml
index a3e9b24..ca865ed 100644
--- a/kas-cip.yml
+++ b/kas-cip.yml
@@ -22,7 +22,7 @@ repos:
=20
   isar:
     url: https://github.com/ilbers/isar.git
-    commit: 33ca03c711e34d38d303ca38c1259cb6c5fe55ef
+    commit: 34c3cda51b46a2a2a405e472a3c4b88c820c765e
     layers:
       meta:
=20
--=20
2.53.0


