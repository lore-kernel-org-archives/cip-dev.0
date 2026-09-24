Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B312CC9831C
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 08:12:51 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (DU2PR03CU002.outbound.protection.outlook.com [52.101.65.37])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.2975.1790237567831070922
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 01:12:49 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=tf7+mRan;
 spf=pass (domain: siemens.com, ip: 52.101.65.37, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7mLfNSNnJak09L4qSE+a4W6G2x4NIIzfsDT0rMjzLl+mfbK+jywypIIafbL9qYyugah0+LLUh32jP3PZaG8oz9h9XrvZXXOLDNY+w/Pkvw7lnrqrrnx8NPMK/CI5k7v0Rcf9IclQEhMMfdsucReLBV9jOnscwXsxqgy+QWzz6q9yHF6iyT2wI0o4SpHtm+XVRiOiwtdI1MlPYQRokg1DTOK1ArojXCXMuUYNgAUf9Ts9vs58PmY+3q4utu6NlElvNPUP3Bs4CEgwibhzVO8Nf7OXU0DkQQtkfKDe5gxOLNQgCbtyv0wAf6D8BtrnbkzZoYnKfqISbt1WSKv8kDjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=awi4jsg0SDqdyKZ3Wk1uxe+ixedbz9OoxE4RGNIutbd0JRjUBpWrpeHb5W6lD56/H7FOb/4DJN8da4A+14E31bwurN2nW33/Vlr3MegURE4cizocu/I3JIgzAJKPl5HFjI1+RITuDIc9rlkH0gI70/JXZEBhXwpOyzXdzTM5zVd+6QtJvvHhea/kqGege7yCtFcKAuQ1RveksNt7+Z8VoeVLLWnpshVljROM1KCI1Kr1qWEtcGeadQlj3uqn32rf9pTc+iFkD2+BzQL+DVAxcwBKbt3Z1uhujW7kb0xGgN9mGdaKFrKJKXTcIs5ItUjozo+rmRdj4IWr0ZoE5gD89Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+olIPPeuv1gGYwKHAAEq4zX+rGVxYfP9+SJ/39ejY/U=;
 b=tf7+mRantboK8PcpF8Bc+u58T5FTcdHg4DyemJkxbw5xxoW6o6hSJLy9YTAve0bBt0Cj8Lqc0E2lC4wL6pq1RsLV5LmRjoEV3/o2tm1v1e4Vc+tUmxa4p6CrM8AGhuRRPQaMR9BKoaygFEIw0K1pNKc9WfKePKrnancBNst93u8eW1cQc3kapHvsT/Whu6y2mYt2QHathKXof/NE/ePyS1sakGnnimZc0zL4OJMrZ58puZuthJBw9JLnsccV7xpxSeNHoKwQcc1T73HTqrn207Rt2DSXLtpi6NjRXwvGD0S/Lbk2TdezruyciAiCt1bMMtRpn6RxfU2+VsIZ8dbHag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS5PR10MB8055.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:650::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 08:12:44 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 08:12:44 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v4 12/14] Integrate kernel validation into linux-cip
Date: Thu, 24 Sep 2026 10:12:21 +0200
Message-ID: <20260924081226.2844456-13-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
References: <20260924081226.2844456-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::22) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS5PR10MB8055:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ae99719-0ba7-4542-c34a-08df1a139c2a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|10067099003|56012099006|11063799006|22082099003|18002099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	EIxXs22GJwouEpLgiBPHyfL6xDsdpDPRpq/cxzQHunb4SoCzk1jsTZeolvNbG4J4G9cjvj+AS9uR85pvfry5T2VAA5g4NsIqGor0JTFekH6Jo7oH4ZL79oCKEQ3kYzMiPn1FtTrWIuOmjpfPnoSUP2C1xwQbhmw6gMrhhmyvGyiTsf0LqX+DFUFzp2FNwiD/3JdqLdJRH8WevTDBSAxGceiY6gtZzGCq7BVZyzW3XXb284nduOmfInWTrGMJUyrSQU0DagwuKvW1g/+e26QYJN12KJ37P80B00PqJ3RfVJpm+8+vnULDTZC7nJ8VPHBMFX1Bfkkl1tQ5xgp6a8osToRZXK9Xs2IYfj9vWFJYoochVWw8KwkHziiKGddaRjlz4Zgvm6uoio2dljVJoPwsvevK5mPgbK8zNQWJBFtS/7bgX2QwqCLz+8niRhwfdhBPY30fESww09iTkQdx4wHPgh9HWw/jREZttdA34wThuE+1/2erHWI0P0LSAjwQ0A2Yuuf+LJB06RkiyxqxZrA3/JxnYlwe+cF/ugxIuhvAhTjNivxi1ZW3lxJS5aO+cZQJyTNUczgT/ZVUKAhRk1fJv0DRP/oj2XcalFvuQjH5aPlZrWmWWQMz0ng0dipg6xMyK9i4jktrTSU4OV1Jx4RQ0AYnHvrr4VPGACVWGmQp7vQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?CF8rO5mHfkILNr2lB/4AmGViP3zQ9BFx5o7R7/yS7hIIXqAbWo1VIxyXinJ9?=
 =?us-ascii?Q?FFeD/h+RV3/uKg63NwPXqyMncX9d8eQstk3Bk47l/eq+fRA8sPHIJ3Mk5bBA?=
 =?us-ascii?Q?TjTWhDqnAJoVrdQ03sAcH/W0RZE6MnjrJvosIc940m759k++YVpuUQ6vaqOe?=
 =?us-ascii?Q?Tnm7aHCBlMjE6UW7dpTYO1vJ/rDxmKsC0WZjjMsOvfwQSao6tYGQLo2CP/YT?=
 =?us-ascii?Q?suYeuGhEtoZ91foNWHCcHvPbP/IAzTqhS7O4QQ1yRnXj+WP0zcVbEHWxHt4R?=
 =?us-ascii?Q?FkhhU1I9nrCJs4QiY2m1NpvW+SSST29PuuNeJOwTYT0/X4v8soYPFRtgd9VL?=
 =?us-ascii?Q?KycptoN/4XBNTIEf/6GVkrnd7R6hu5w5xExnL2fdti1vpyz6pIE7liI8hoev?=
 =?us-ascii?Q?A1jmpmODmJnCr9A3ttEvv0jYLPBVifMKbL7BXPoxSePa6LQVkmGHy8FXjWBo?=
 =?us-ascii?Q?bskEC5Ae8o8+q1St/5iZw0+6VIT8SbUTBTYAJIkeFmWwfuQyOEIl6C3RdPUA?=
 =?us-ascii?Q?iMrqUWn299MN/uJMCMXM2/7eP5boXtBEAVMAP4N/GZDsVV8yMtoi53cuZx7q?=
 =?us-ascii?Q?pZR0qyI+FTBB4NS9RPl6GafNTg0x2P/DgPV7C6k8VWCv+CKQ0P/xqO4O7K31?=
 =?us-ascii?Q?BLWH/8IFvVrmmCmoGB81Fkc+BV/8CiXDfy2PyRKe4H/K30GVRhmQzsKxkEqD?=
 =?us-ascii?Q?cejEFNPFhUbb5b4qROBTh20irsEJ61G8Xk7K0bcA61qJXznV+seMAAJWkEh5?=
 =?us-ascii?Q?cKIjMpMWd3GwrhgrSBVnpn4t7zFF41LBFsR/DFYi51vsJ6nMeZBDyhweEGX1?=
 =?us-ascii?Q?asZQjgEenlAyBfgGQNQAQ8OYIwJLgQJCLNMBeJupbNyHdVBm4gla6btke1Bq?=
 =?us-ascii?Q?T1BKa6gJt7jBQl8zwSmgIsOWAahUaTi4zfMr1yaNmlmq7ABuMbWIY4Vjr13J?=
 =?us-ascii?Q?1GjbqNcg3jm6dV7w2LQ2Zn+AGLJ4ZMKsjY18Pigt8gjw5O8Tr1TjUPAV8NdB?=
 =?us-ascii?Q?xi7MrGuKFDRkqHn0wRQ/lQs5xSmIbPO7XM4tVbWQxgwJ7Im9q7bjLMKjd5lO?=
 =?us-ascii?Q?ExhZfmvwevIFm3MgQECde35Dq437gsCbBNvMfBW/b3z9NoHFfyCtJ0tlSwNu?=
 =?us-ascii?Q?QkJWTNsmGLmW7j8Oq5q/xJRHw6YoYZLHYRZnIIxWq9m6B5r/k4E+yHfqzpic?=
 =?us-ascii?Q?8ROM5WMKY4YqfpSVdpo+fYSSN82oLpLSKjz2skHUTKZHkt3ihM2nnKvAiFQB?=
 =?us-ascii?Q?1+G8OnmE1dCGxVwcWaZ4CRMPAbANqRI7OXnxVfJirbnP2i5diOLPW2aX+h+N?=
 =?us-ascii?Q?BoREi8Ff8R1DqrR/3E2RI1bs2BuPxk6C0LpVJca5bcdfocavX5AseAylTYFA?=
 =?us-ascii?Q?hVfZhfLxaH94vehWoPgBo7PiGjDXz8LZhV8M7ccxTYtNqtueDhnpguaMf92I?=
 =?us-ascii?Q?ETR6zXDuxXB+XsYskQlGBWIzEBJM7nfk1e/8C9VyI17DYX0XFjbjkziG1qtC?=
 =?us-ascii?Q?9a806d5nF1v6yZIfUPEttKaX7spV9/wJkx26GNCrlLeIfmwaR9QWQHaZnp4+?=
 =?us-ascii?Q?xbh59wOGzzFOTxp+1ooLeQ32ZSJsYS5hStXEbzvTCAfq5TTOzN3xrnawMnxb?=
 =?us-ascii?Q?u6CCbwwKFmvuPQHQU8taqCl4Zx4NKpTm5RSkq1PC9LHH+oK4H7rI9mkpNhGI?=
 =?us-ascii?Q?YikrcXkXqMjymerp9JVanAjnXOKYIyC8mMflEr1bbaUQWYMvmZO+Ngd1+sj1?=
 =?us-ascii?Q?t2KA/kg66rRwr00Uo4Zh33c9vnEkALk=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ae99719-0ba7-4542-c34a-08df1a139c2a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 08:12:43.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uLiqv7icySwqmrjnCvbJtfO4VNjZtyz5XQ3Rh0UWGQayMNgL2c74Dva0RIZ3Bx9QgOcyO3ZS92QWTkl/BZgrNb1VprVM9RQUFw4IiQReg/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR10MB8055
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 08:12:51 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24297

Inherit cis-kernel-hardening-validation for kernels built from this
layer if both CIP_CIS_HARDENING and CIP_CIS_HARDENING_VALIDATION are
set.

Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 recipes-kernel/linux/kernel-hardening.inc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/recipes-kernel/linux/kernel-hardening.inc b/recipes-kernel/lin=
ux/kernel-hardening.inc
index 9ad8f080..027598a2 100644
--- a/recipes-kernel/linux/kernel-hardening.inc
+++ b/recipes-kernel/linux/kernel-hardening.inc
@@ -14,3 +14,5 @@ do_dpkg_source[depends] +=3D "${@'cip-cis-rules-config:do=
_deploy_hardening' if bb.
 do_dpkg_source:prepend:kernel-hardening() {
     cp ${DEPLOY_DIR_IMAGE}/${CIP_CIS_HARDENING_KCONFIG} ${WORKDIR}/hardeni=
ng.kernel.cfg
 }
+
+inherit_defer ${@'cis-kernel-hardening-validation' if bb.utils.to_boolean(=
d.getVar('CIP_CIS_HARDENING')) and bb.utils.to_boolean(d.getVar('CIP_CIS_HA=
RDENING_VALIDATION')) else ''}
--=20
2.55.0


