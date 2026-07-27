Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA628C54EFC
	for <webhook@archiver.kernel.org>; Mon, 27 Jul 2026 13:14:32 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.57])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.30484.1785158065588134612
 for <cip-dev@lists.cip-project.org>;
 Mon, 27 Jul 2026 06:14:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=bX+04GBI;
 spf=pass (domain: siemens.com, ip: 40.107.162.57, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pyISYbP0HjJNsdUXDb49K8d3pzJ0moWF0rdkk0ZbfQ/5KLzEeAASL8nZOpK1ji7s7ur+xQn+pJSPaeC4kPfYftm7nOoylj5ejUTk4PVG0xkMBZLl3CH6q39/mshGuc7+yPGbmKJtNCdVtLj7xqUjD6e3e8Yts+djYRiUWkNBNj0GgwhtedKjeslIOgU0+9X6b+7Wlq/Q5xo5liVqh6K89sCRY2a+Sn3VOXBxH2UBxEBJmlfB/QH5u/0tMy2ZSJJ7iPRVLZtvcHdKgc18hHbc3Kfuqk4NzjRCyzgh/YdsNm2pmtM5/nmD6RuoFdUppT1ngiumNYZvDuCTNhTRXdU4PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/uG5vZb7Xmb/1reOO7Fv+kphSWkXKVtBBPRgcnn1NI=;
 b=u+VBw0DCkqN75sFWz9tu269TjFmAY+tGzT/x5J5YRqUDcI26K6DLBbJL3nzMwSY0lQYvFaUqQBlMl+3WeMU6It+kHnl8imSCiCihtjMSRs4miMb/fyB9GLZko0UuTyY0AKuGJfo1dyOOg4LuFavqENtVXnkSd+43QdPRgD91BjoQ/AzAp/YTTIBrWhJXNbD2sTQpyCuWM1IAUPdduoRAbPZ/iJR6C4YgVCdIxCkNcbywx2jA3w2rioCfgpLqrWpZJUSKA8iQImsxTcn3iRE8K+arZ9lyWY9qIKGn9JDyAb+wrio31YexfuSowPpSc1iPy5V/9o9UhdUExcPo4KoHXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/uG5vZb7Xmb/1reOO7Fv+kphSWkXKVtBBPRgcnn1NI=;
 b=bX+04GBIjPEZ54mvY7alXFVfvNWTYfNfQ8OUHejDROAk49FAKrRMsQkqkfdc6+l7o85WyCXCrFz8HdOiGUelpnn8VCQPpsCsrVOOEm4n/pEW2Vtnt0qfMcsAJnTP5GO9VGyUVyhE+Af9KpWaaVe52qadOH0lmNhNpjGMxT7bVA3WViluApFnmPfGtlsYit2EBjoa7m1db5W01VgVn9M+Wl1XzX/nNrWEfTZ/WOBaJpH/qTZyveJvkOUc46tNF7WyEUH9Gtsp9aTMqAAOawKEoPbV7OQITVlvGXN7Jg1z9ZLWbqYwiOff8W3RK/F8B8p7VU129zfJHSl0VYy73040VQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by VI0PR10MB9835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:14:21 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%5]) with mapi id 15.21.0245.012; Mon, 27 Jul 2026
 13:14:21 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	jan.kiszka@siemens.com,
	felix.moessbauer@siemens.com,
	christoph.steiger@siemens.com,
	clara.kowalsky@siemens.com
Subject: [RFC cip-dev][isar-cip-core][PATCH 11/14] layer.conf: use variables to control path of hardening config
Date: Mon, 27 Jul 2026 15:13:05 +0200
Message-ID: <20260727131414.76760-2-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727131414.76760-1-quirin.gylstorff@siemens.com>
References: <20260724124038.3633611-1-Quirin.Gylstorff@siemens.com>
 <20260727131414.76760-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0088.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::14) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|VI0PR10MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1b3604-f6c4-4940-04fb-08deebe0f8dd
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|55112099003|22082099003|18002099003|56012099006|4143699003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: 
	kNEjBxjO4VEso2h8XtcJaKDhiHyF6DpnGd5w6ZsOymmPbZsHo/DidCnTjDXtMg9M+0nWRU740TsgnjeaR9HUrJrYBOruYSZLeSnPrLXBDs0rQaok3q2CjT/8dYs6cR2bBQ54N42YbmH+lAlyC0TChz7S8GNeB01HNatub/+K3TftpLJwk7MR/AKRObOuXw5hGBCF7ExKgt0SUkbHyYEDdKLzoc/rNXBdIXDDdaqz/PLBaUJRQYvaHaAt7k9CNVclk1N3ql+RiVhH2cwNKa/+tiaKZaC+yWixRhIKY8ucdKGndPF/puT9IWt8ZyFt5Hp5NAaVe2sRWPUPSbqmZ05HERbHJTFWQ4g+UM7l1sNtGjPUl1RYywkqO3DVPcJtfyrOY8Ryh4a+b/EL7EVHfxrEqfieP5ZB1Twd6GZWbGLq/9yz37yLf3zi90NC10KRU+khokLVM7yhOiUedmp+6XnuFO/audb1Q8nnIH9tuTSbturYdN6+xrum8g3CvdQjtl2yWgJWP5mj8H1TqUpvQMoUc20NQDHD3kk1cUQAkG2UIN/kw3hSmWp0SQnYWhuUCLCFBUP0UGGx6BCvS0rI5UTav1koI7Bx0HLFfeH8MT7NngfEDQo9YGu57LV4UQmoLnmWquX3mITw8voGHH14mgTS9NEGr3YZVT1fixy42ZibrKQ=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(55112099003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?6oE7p78jpYOmRdxSO5ve+NK7yHjfx4tufpK4bscdMLFG73KPfEjgWg/QcsGX?=
 =?us-ascii?Q?O0JDb9XXb9lIoPXy9iZ+jjl+U3V89RO0mdWRU7jsTeRgl+oIVSLVQvMkfjeT?=
 =?us-ascii?Q?ZUCeB3TYtLn555naZQ7itgQrFbeFuGU3htHDQ7lvhHkppJJKEPAA7Xsz8GjH?=
 =?us-ascii?Q?qJPRDZLjfPCii733wkJa5XToopFNKVBMyaGylRsZYhJkoLnSQyDt+aHDnTkA?=
 =?us-ascii?Q?ss7RCU/gT/xTvhUqvDHJl8Llz8acwf26mVfISJPbiDkynIuLSaLk7z+CCEoU?=
 =?us-ascii?Q?bXwVuvdVX8ftFQP2UCjFx1+MGfNEPRt+iYCtt7LZQwmhDNfbKqLGs++5EZUN?=
 =?us-ascii?Q?eGBke/0VeLJcYV4rKC2ZWgKI4sVwQSN8OfEBuMKhr5TxdhusbpAF3UDuWLsi?=
 =?us-ascii?Q?lhIaEDrw8RvWoxCYjidpkDTXX+BfMVtidGRRj1pMkIrqqEvosLE6kOCyydls?=
 =?us-ascii?Q?1utrHJHz01BBYuRCYfrg3osfLElTzIHGj0lxoH/5HsFmxTkuOqduKV4OaQn6?=
 =?us-ascii?Q?xNduSuxn527XsYiP++5BnpnRo6t0Ztmm8XVpvCDVFQhT/UYRuCnoonL4Vs+o?=
 =?us-ascii?Q?sbtR4PQql+oRssKtt6TGwE0hNmtEScVJp4tHg4yNDiyT+kaixI4neM/8UiXZ?=
 =?us-ascii?Q?QH8IUP6FtiWpmOdJLIwGIuCeqEhgZX3lisiM29B51odteH5Ki4C8iFXjXi9C?=
 =?us-ascii?Q?W6KX8t9QrpU8l8joxJNf2lsn7IHa2QArg+sLc+9GjVqagDfXtmXWNwQmQBvo?=
 =?us-ascii?Q?m1CvFaZrchGj6qCLdU51LygtZjWQpsjkMMc+KoUXyFR0y7Kivyr6/z2uBNCZ?=
 =?us-ascii?Q?YKJ5wZ4XHb+HNgsHXaRRyG9pLQdYRmKpsZEfIMCduiN2SlQ2g3NcNKOqmlGE?=
 =?us-ascii?Q?VDnE2fwoFqdAR3qMAcUnJQP5oN2E+wH+yYSQ0fmDJd8+69WjsfoOvNCCY42e?=
 =?us-ascii?Q?qQftHFmqhWBhjUzzpovaeZ1Iw5ei21Mb4jSvmvbbY3lf1TSkFyn0K4HPYyrL?=
 =?us-ascii?Q?K+Xs3lOfYphN2nRve+gmzMnvDS+6MShuujBqzNDvG8sYb/2IME8Zs16UG1LP?=
 =?us-ascii?Q?6w0uxJ3pEdg5TgMYIYWpYPHR8YPMauOIRc90RJ8oJ56loC45nYrzTlez76PK?=
 =?us-ascii?Q?5yYk8WYR5CsaRt8gcLjJxNlwfN0Qxqh2tSwZrkrLdAxcpjdEebjjhYnHe0Il?=
 =?us-ascii?Q?xL2D//YUdBDc+QJ7xz7Tp891WZLd0W41FaUTpi2FWjpy5jrBBZEb3DKbaLIV?=
 =?us-ascii?Q?o8btaIzkr/Mo9X5VnQeNrzcoy2/LSO5cgAkHjq2KTzaGwAOSMHaTtEdqsE6Q?=
 =?us-ascii?Q?3HxKbNUs+lWqXG3Mn2zHU2R22OIr9LeltKjve7/4s4zzjp/N86JHLWPmza8n?=
 =?us-ascii?Q?9uklXwGayWCe2bUlc1v7174lBZqPGJHXWhhJEM5EiVpsVABa1S3Cyceo2shW?=
 =?us-ascii?Q?8iN5+ONLb8GCd7P0pDbEgrOCb3uuOk0DcaIHV+jzf6Xa+pmm1X8v5SqHKklW?=
 =?us-ascii?Q?9cZNaKAdn/H2fMqfO4EGqHdUouADw4KY4PYZ6MoBROYkVuT97oEGStOOmrsb?=
 =?us-ascii?Q?k0hu8uCucmZ0VvrTK9KWyso54nJrqgsaEQxqgf6W8VxmwfIGNdP9ZxA0ouY+?=
 =?us-ascii?Q?lzt/USlEk9rkstoVVESHYCNuBDF73yPVyJHJklCtW5i+oaLF03GW/0aJx/ts?=
 =?us-ascii?Q?/tMvVOP6YjvwxKVtPk0vHWgsyjOTgoKMMCoUrg6Eks7EfzoQN9NZz7ZbLyhd?=
 =?us-ascii?Q?Lmt03XfWtgjMqTFd6SH4BDmTywj9gAg=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1b3604-f6c4-4940-04fb-08deebe0f8dd
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:14:21.5311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vV0LyxJISW2DKyVV1jQscNIbJl6lk4xU6PUOap5DflGOXcNKt4ha37gw3Q0hOzOW8aa08b5TrukNNw2qjy0qL3zwDEiSixF2Q2kh9qmaolM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB9835
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 27 Jul 2026 13:14:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/23763

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index c51c3af..61e25b2 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,4 +23,7 @@ LAYERSERIES_COMPAT_cip-core =3D "next"
 LAYERDIR_cip-core =3D "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
=20
+CIP_CIS_HARDENING_CONFIG ??=3D "${DISTRO}-hardening.config.json"
+CIP_CIS_HARDENING_KCONFIG ??=3D "${DISTRO}-hardening.kernel.cfg"
+
 IMAGE_CLASSES +=3D "squashfs erofs verity swupdate delta-update qemu-emmc"
--=20
2.53.0


