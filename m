Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0082EC98320
	for <webhook@archiver.kernel.org>; Thu, 24 Sep 2026 11:36:23 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (MRWPR03CU001.outbound.protection.outlook.com [40.107.130.38])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.5832.1790249774285293082
 for <cip-dev@lists.cip-project.org>;
 Thu, 24 Sep 2026 04:36:14 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=gpV8tJAq;
 spf=pass (domain: siemens.com, ip: 40.107.130.38, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuVU1JW5UnIIdfF/YDuAMvzrYdVSPd4x7TXSFTQ4RBUh8YmOOvM8iFHdL2LFwvU14pOIJgHl3dlcM25HcWAYtp8X1lAHShcuEFrl2IA9Kdx3G/jTMexSh+mX+JW21FrjCVbbUKqwO7IPa5kACxUlFy+ze0/ET4b4SU83fmVVH0anWjlFVHbEHKuxY0VpNCfjk023paMfzKemv2PS4SKsJ2t/bwYRlqds8QHepa7+Udev5pznS67FrfvuL6Yd9UZJla8BgYWxNvDp8xd4lwD0vIwOfX7RMv8mgaE74b85EMTpXyFO0Alaw0A2hzBoriHq8N5I4GOjE9YCAmBvIi/5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=kWOXgrdWSYEUSQ8x7cyISrDS79NTiCNVTE3BbTeN+p6PFNiG60hlt71RfOgk85D9tldBviOP1BS6hDqM/CF2y0KCzs/+yvqj4/MVm70tUtVQ+iwRATADc8l1fCt9mnxygU5+beuomzBtIaXuSkctufSUidcsmEifpgbuD0MOIacwkWwO3flX8Q0o/MobA5ZpnfFno9enpDqIbWml2Dx2kTzCKFOwTofhjJjsET3OxqXYZN9WPxEM8sKpkpVi/PJI3M9Io6LggTlsvnqwHVqJSyXeJCX9JIu89IOUz/WOLLUIkY4RSrVWUYtMq0sJpnz0gvZScVx/h0hO6lnpHX+HZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=gpV8tJAqBpt+gk/yBlCoNSoNqxHyV4F4Y8f+69N3CDqh9AV5CYyswYPTzZldub1sZSmlfr41E3O3FzCPmEee07GQ7A+c6F0Q5EfZrj7XvacZPXhtbnJj8ngg7t3ykX9ELr64YL7BqSocAQDUHjUFERT4qqVu+Qg/TP5mAKYGP5nsN5ue7hfwZ4uLO5kWM3TieZzdJoHWjVq17sdfxv02PuS76nsLL8IhkCTbXo1rSg8ZkGmI5B60mFo4R6bfhx4ZLNP49iwUO9rRw4GjS8ndQlkrd06i5E6ZneNwo9DXJh0n/a+59Kg9omnD9TIjg7AiZvzW5+AiJoQGGZk3bGzwYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17f::18)
 by AS2PR10MB6374.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:555::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 11:36:07 +0000
Received: from AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914]) by AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5511:7126:a2d7:f914%4]) with mapi id 15.21.0451.014; Thu, 24 Sep 2026
 11:36:06 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: jan.kiszka@siemens.com,
	cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v5 04/13] layer.conf: use variables to control path of hardening config
Date: Thu, 24 Sep 2026 13:35:04 +0200
Message-ID: <20260924113557.3191996-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
References: <20260924113557.3191996-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::10) To AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17f::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR10MB3172:EE_|AS2PR10MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 3de7142e-9818-462e-ee76-08df1a3005c8
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|18002099003|22082099003|55112099003;
X-Microsoft-Antispam-Message-Info: 
	YahR8yVnE8q/Y5zzLX5OVjsY/FACIuX4cwotlCc4jwWFuWJE5wbyjHrWLKfxa/GWozVLw8WfPS5q2hdeqb1qsb7KKrBdu9rnUmwv3ww6MGd8lOcfNHJdliT53AyRPOLyoB/hCSnwFfuRsXofP0LLiSthzkbKNnruqcDg6IcQmfzV44O3zpbvgj+xkum+Cw6ZgEUG7thTavvXE2+3qQKL5FNlLgqqD0pKiJ3T3zThD9WdRMj40YVtpLGiVxGtn+1Pct992j5sKrJcdZ0emw48AVhBTKNmvFtAVzOlGfnvQujpNRbmpLuoKi4upiYp1uXUR+uHsLE078z9uclyYHLagaFoKKH03PMveArJCStOSC7iY5X4aDMwp5Q7tXK9fmZLmslmXZEBpgsdNDIsFNLHlBKyNfCwEchSn2EoUq99QH/T7WZSaBgXB7bh+s/Y2s0SsNdeYcDn5kc2F1NxuL/e45PnFfGwhy/fFDwpgidswG7DZvTdrDIKJstC2Br6O/Fcw6W6JOELs1/H3upPhDWBgCPNfJI1lAnhgR3zscwDeASECoP7q0YIdzRScdV48QEvcPoFfXZXsT+Ix5dLBXRnuQxkntb8SDU+vobN1H/PRqmxHxMdwc2ICqOjo/tggf4qq+MhCsDh8cUjZjW79Vsty8xCJ8Y9PNLOlIHkZQAvluc=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F01eFg2OxEJztqMzyBr0VE0HO9xAWbYJU45EaUkZdhJ8lYOamkfr2dJom6Im?=
 =?us-ascii?Q?sOU5Z134nB4Tew3b/XRb+0g1yUjH7z2hcAnHUAcUzabFOhs5h2WNK4tQ4W3/?=
 =?us-ascii?Q?fldeFGQBOhnlf+7o+vufHBSk4vdgOnHCvBKAf0L5cfw1pTjtf9sSS17AQ3HB?=
 =?us-ascii?Q?74iKzp9vOZzVIlWInxT/bwssUfJbYf3R/geBxqypJRmRvhqlEDc80CSu4gHJ?=
 =?us-ascii?Q?DyEz5/S1kOM6ofWccKSIg0d3MVlKBpNyJoeb3HYnCEnJSmZs7tKwHMuuINgJ?=
 =?us-ascii?Q?grHqk2nqiGJzC3UehyIZhBlibaNdJYhj2vzBZ9ZQtdCxBfyOMQhGJDR+C758?=
 =?us-ascii?Q?VK0E1ZJzlILRUL4x+xZzFyxjg5nu6kGDReBb+MAGMmNJUXFMCJcMrbjXEhL6?=
 =?us-ascii?Q?d+BiLSFoIGNA137/VM+7V0w6fqTHOxtFmZbz/iNiZPaA6NfXID+POZZbaxk+?=
 =?us-ascii?Q?4Zbm9WXz6cBquavEKunlOeA03qnHP2jltBgddjQrAD6UxuPXzHVN8pCZ/6CP?=
 =?us-ascii?Q?8/2ah+/2VWg9KEfLSYUMWAAC6gy7bgfDLYwNbouqAGsDY+4nZ3+xDu4WCmHN?=
 =?us-ascii?Q?m6WHDcYeeMflN3GbkillZwkXTJsGji8B8ZdexPi8u0r2s4uB7o6aG5pIJofm?=
 =?us-ascii?Q?bvNpW/uBwHQLWivjjHvggF9NmN3o/Xx5ga2ckJoOlgVZVBbjkDOhUcN3OneI?=
 =?us-ascii?Q?aaeknCZK6y7NlxsYD+jDAkRnt9wjytjRXtmpQUGMFXobmKbX9d0njYki+ocQ?=
 =?us-ascii?Q?K5t6PJ3U4PbNLdmUq6YeP7rZhhQEzxCh28iOEV47BY9kHnTUki7icd24If/l?=
 =?us-ascii?Q?9YEVu2wJ7NByy+KxWhanQrPm/G79yOtwRkb0Vx75OnRnX9qb81JxyHU76gne?=
 =?us-ascii?Q?zcrSYqYvuhxMno2I3XjwvDoMMIpK3vUJGRYiqXzIHzOTxbfzO7VKKTVDEejm?=
 =?us-ascii?Q?0chN3AQRD/AmvihyaXjGhNhlhb4kfH9mFxJgyKMITYzZh3UntckMb65DMy8K?=
 =?us-ascii?Q?2DrSBJmGWgJyggcMZMnatZdmSrCnMl4WnC0/qM4SZTSKsk+c0LFmRr77oRD+?=
 =?us-ascii?Q?VOX3rVf7ucv0PezTNewcR4O+HLfOGgm9KqAQx0O+00FvnpLcEP47e7W7w3KU?=
 =?us-ascii?Q?00WB5uZ6JtFf5IsWDGbr/1PnQcc6+0QtXF444TLWQ7B5zwyvsA3lVPqEqx18?=
 =?us-ascii?Q?+NjBNxFUqFQu40LIHo9+WpwgHncooYfzMnXugeNAfRoFsOE05Qk49a4f9Igu?=
 =?us-ascii?Q?BDQEYTyyWxVWH4liAErm/y8ZDT9mQIdsWDMauICnQ6Lxma+xbpK0+4dhWlmv?=
 =?us-ascii?Q?Cu2JGeztBpO0/jgk9iK2LtlZBj8w3rrUmw+W48YO/NXFh0M5psMTOvgChUaM?=
 =?us-ascii?Q?BjJ8rlJ1dBbC9hxw3xeIC6OXGb1KvEAHbgpcOhv+0x4jN+U0QdHFW/XU9lME?=
 =?us-ascii?Q?JoWVNmbD4fcjOHnn2uzWQiWyM9Y483vRx8m60OE0JLR9iQP7XM9ECow3Cx9O?=
 =?us-ascii?Q?VC8+tsOh5NtpJr26TQu79rrRhN8PzR69z9+s+Vsbk0qtUkXPB6L20J234dwz?=
 =?us-ascii?Q?ADblwdvm/tuPeEkI2b8DI12Xwq0VRfcwMCyrmfB5cj8yLMxSHxs4oU/Y2WLM?=
 =?us-ascii?Q?PijPeiqomqrXt8kJ18FMenkiB2FXpvoi8cw9z8NY3T3yTgZWxj0PwztTNTui?=
 =?us-ascii?Q?2vBP3ZqrvEi7X+Z/+ijGIp6jw0kx5hkxFEmK9ApfdfITTi+mn43nh3CSoU1J?=
 =?us-ascii?Q?DDZBXZiamwJsNOH8eClfITs4ZJQR/Zw=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de7142e-9818-462e-ee76-08df1a3005c8
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB3172.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 11:36:06.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bIyBZzosvidg+UvIhVAZTJLN73jcmUNH+mHKaQQ/zwPw4KndS3S5+04QiiakCI39agJ69pknigHY8t5ETLJxNvJ9xOqX/qFr9FXBYne+ikw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6374
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 24 Sep 2026 11:36:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24317

Add CIP_CIS_HARDENING_CONFIG, CIP_CIS_HARDENING_KCONFIG and
CIP_CIS_HARDENING_REPORT to define the file names of the deployed
hardening configuration, kernel config fragment and kernel hardening
validation report.

Co-Authored-by: Felix Moessbauer <felix.moessbauer@siemens.com>
Signed-off-by: Quirin Gylstorff <quirin.gylstorff@siemens.com>
---
 conf/layer.conf | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/conf/layer.conf b/conf/layer.conf
index c51c3af1..800f31f1 100644
--- a/conf/layer.conf
+++ b/conf/layer.conf
@@ -23,4 +23,8 @@ LAYERSERIES_COMPAT_cip-core =3D "next"
 LAYERDIR_cip-core =3D "${LAYERDIR}"
 LAYERDIR_cip-core[vardepvalue] =3D "isar-cip-core"
=20
+CIP_CIS_HARDENING_CONFIG ??=3D "${DISTRO}-hardening.config.json"
+CIP_CIS_HARDENING_KCONFIG ??=3D "${DISTRO}-hardening.kernel.cfg"
+CIP_CIS_HARDENING_REPORT ??=3D "${DISTRO}-hardening-kernel-${KERNEL_NAME_P=
ROVIDED}-report.json"
+
 IMAGE_CLASSES +=3D "squashfs erofs verity swupdate delta-update qemu-emmc"
--=20
2.55.0


