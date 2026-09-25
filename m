Return-Path: <quirin.gylstorff@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D2DC98321
	for <webhook@archiver.kernel.org>; Fri, 25 Sep 2026 18:09:09 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.3])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.4493.1790359740344310870
 for <cip-dev@lists.cip-project.org>;
 Fri, 25 Sep 2026 11:09:04 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@siemens.com header.s=selector2 header.b=ByrOX5uw;
 spf=pass (domain: siemens.com, ip: 40.107.159.3, mailfrom: quirin.gylstorff@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E90M4XpukXYwHDT4mU/KWOASyWPiDaUyyM5MsZLKd+WzaOyNyPa/k64i0DMPNXx15n8lmCuzfRl91MIUGc9mZwhbJblh095pQ7cJcM4ZAZXrBn+2rT68sdVQ7m6skHZ00Sbeeds9X2LPh7hn2NaxBqXS7hhbuzrtfkCxSlRdr7ZqS4enEGog/YfNQ6yScDstaHy8QH72gaiB03gehu40dpctFOsoZjLmH/Z3R3YZXQoFVTnSkh9dc2HDLzLQrmlEUNhjhmWSZKpuV00XmUHR3F/I6FO0Mp1bip8c82APBMM2Hg/UMgQOIxV3iOP2bFgYdi9yMhp0RVDl6JM3Y/5kxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=JwlraJl15/4dNePzrnDjWOYyWxqoAwLL8s74Ee36CInVDIU6QGGNJJOAKqTE+HJKWZfVFD93vecxN7VQ5Yn6/tEfS8qgK5e9daM4lZlndz9+p8ntRCqnZfI8+1E3CNLgoUWhrtOMjLRTq+I+xYmdFOsRpdlyszuqCM2p5y4m+ezPFCqn3L6keQT5CmSO9ZosD7VpG0I08Ik/LKAVP89MWq2a/ZGMsZcdsEJY3Wmt8u+0Lrb2Okt6ErOskS+915RK3Pq21Ud4RqvPdrk799VZQQxoW2ugtX03G0m6e0F58hAqYBcwgHxSVExvO2DkxQ4bxxt7YUfnbjzrPjK8A4qPbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lmFA9f9K5wQBAYCDiGEgz6WHpK1jSMzSJbFJ8nZankE=;
 b=ByrOX5uw9YwZNOabbUELgb5Zv72Sobrfg9rmvI1vNMFi9GK9fKuO0l71H4x9ZQFDQC3L8i6e5zlTrVmFD3fM927l6C7F4J+7GrW+ZmOac6WLUtkv5C5+O4XzCZ4Z7gLX0/OG+d6qx8bM8EeOxZEN7KX3oMXrFQhhdvMc/Fnn2QMuVBMmY2Do60rQCwWt2Bj/EWlse/vqUm+tYvfHy7Yu7P7i1vjudtmyYg3qrPLKn3agJjBYI09a7kb5+C+ATyo4nPQSL99GZCrnC7OPveOcF5c5lIm5UjRmKYi3ick4RUCs+M6e//UJ6dUlNAN8JcWK4/efK6aDJP6V/j3mqvHaGA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:113::12)
 by DB9PR10MB6378.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Fri, 25 Sep
 2026 18:08:58 +0000
Received: from DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001]) by DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ae26:d131:7cff:4001%3]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 18:08:58 +0000
From: Quirin Gylstorff <quirin.gylstorff@siemens.com>
To: cip-dev@lists.cip-project.org,
	felix.moessbauer@siemens.com,
	clara.kowalsky@siemens.com,
	christoph.steiger@siemens.com,
	hirotaka.motai@miraclelinux.com,
	dinesh.kumar@toshiba-tsip.com,
	jan.kiszka@siemens.com
Subject: [cip-dev][isar-cip-core][PATCH v6 04/14] layer.conf: use variables to control path of hardening config
Date: Fri, 25 Sep 2026 20:08:30 +0200
Message-ID: <20260925180847.622090-5-quirin.gylstorff@siemens.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
References: <20260925180847.622090-1-quirin.gylstorff@siemens.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::15) To DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:113::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB8PR10MB3178:EE_|DB9PR10MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: ff9bc981-7659-4a13-780a-08df1b3011c6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|6133799003|18002099003|55112099003|22082099003;
X-Microsoft-Antispam-Message-Info: 
	7Kff9ntcxkc8+8bSJjoSHjS3vYNjLPIXaffm8KDx/UxL9VMbyyWVw58Sqhv6R7/i/7BqUUUlwOg5L8nhj2WasH5GvtfsnYbDLgOksh/7Pa2oxGsSG92gcG9UCYPNEJugGe7T64NU2A9SVrPPxE9PdniZpXx1SQ01BfeQb66PGYbAcRBEP2C3ZAZ3vMsPfbLx2iiKl2FI676yqGqwfzASNapZqnmjf8KZ7Ay37Imh9M4t/GdA8c2BSLPO16VDyZ19gz+cIV50qzB//rclLbsphC9+OdSy9lg6sySltMdDQTl1xLe2+/gxaxpI5rbOpnQKbs1So59bD55FFROZCRVc3FAQi/4ZOx2GGBHNXGQKgf447W3MnoXLOH7ZqBt4GPDXiHQ4ZR4sr78HGeOjykzMaZj65R8n4QdQ6l39BIpXkJFh9GxTBRA2YgkgU+u2CSlzwiDs1kjMpJ19hEl84MREdk8elgbUOCP4/PsJqeUXBbELKtTBh1eVik7ThjphjJYKUEeTQwcfJ31SWhyoWcjTMQ76oATohXxg9l+T01ZmuXEJF5xrGZvizAGDc2sV1JAQuFVyCz3NK61ZAlhfGUQW5gO2kGLUfYyInI8ulXdhEegc9Xpe+WlA7hgBYdB1UTmwxQ7jU0EmdPrzrEEWIqfQzPy/j8/czJnSB3YEOaz4OB8=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(55112099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bVCgw16lPESWW+2cBhFS0x1vuuej6AGFPXU+Ot43zlabiCkIE7/3Y6BUo9YE?=
 =?us-ascii?Q?AyFr6rXMZyu1DjG1sN6+UzegCRLO79UsqoKnBar+HOKX60l/TPZ5qLgA/6zk?=
 =?us-ascii?Q?3SxTO/BklcSdPsV1o8OMOscSl6GHifhK0YpvrsOZTCbKxIOThOQgVMQLxJuB?=
 =?us-ascii?Q?jv1OYmP+Q26KBMcHQ0Tjoqn4t1lU655F+DWaoj8Eu8BX1qA1okmjTcwZN5Ku?=
 =?us-ascii?Q?OdrjQFhMednranbHC0Rjq5V6oGv/z+/46IvMOOVSuVLYv7MROZGCsmkiWuia?=
 =?us-ascii?Q?NKtIXuNEzLobrGrL03hEQrHWjq1kaJZznyk1Eeog8Oo1nwJiED6VnGWjHgXT?=
 =?us-ascii?Q?U+w9q3Xmlj6eyh8Hqlf9jDfLS1u8UpW2TYPT4oGtlaHHjiFihcs661MQkTI+?=
 =?us-ascii?Q?Ekl8Jfw837Lv05VJdcbWv9VQGpKPRGE1BxtulKxA1F6ES7BW5ZZXV2h5NioC?=
 =?us-ascii?Q?RC21nWfLygg7T7lpuRtj1ZVWwtqO0jITZCi24zm3IbOlHBb0qIXibCR9hArY?=
 =?us-ascii?Q?ARvB8r+5eDPfagRMtgfvOSg52ihmY5GLk5+jtOnp1CZaNp38/j0BCPkV7+7G?=
 =?us-ascii?Q?4vIfV1JpkdiSeCs4Me9KwCYMRCIlL4Nmx9pl0VCupV+80QsLq0hgaPFixqL1?=
 =?us-ascii?Q?vpi6o9nwmvpp8bzioWyIehIROl/FXNH8Revhtzd5j3kX3Jtgzxmy33eMtyVg?=
 =?us-ascii?Q?y1NYB6VzPtOFf3G18JUhvv4r1jgbo+0Y4oje2BmH3udBxF5FD0j/VbPcqjDc?=
 =?us-ascii?Q?xdXF1sYjgn/L/j6k5GCn/ZIPFu0AL+9b7RWSiZKcyNdg1rsBQieMr7Lr1AuQ?=
 =?us-ascii?Q?0fbSyv+KRVbPi5Vl9+bF77+hMfNythcY4jM/l0SMVMLsOfJ0G20p8PUZqER/?=
 =?us-ascii?Q?LvmHA655SswRiY1ZGO6ygStYbyilEVvwoGS89j02/MmQf7N7+8aKGtkX2dAx?=
 =?us-ascii?Q?mUOAoAjBN1ngiBynN3E4KJJSP8Jw1DGvQ9wAxBiVmAnMtjVrGHwYoSAm0PrW?=
 =?us-ascii?Q?PFKMH3C2FwdOSWSZ8wNjpnsG+L0Nlecj8vBSriE4SlSOHER+v4oDuu5CSSXl?=
 =?us-ascii?Q?I3p6c1nr3swkKL94CzBTjIsYOsoMfA4wLWVaK4mOLzAEkaF9CQh+jvr7hF92?=
 =?us-ascii?Q?W5SNVwWZd8iBVAnRb4vdK6qXMES3lfn/FTYI63YUPN6ODb8H1skxwCjvkR78?=
 =?us-ascii?Q?+FfALNrtRE6WNIsh94JEV7i0tkKop/8dopAJB0G7wR69XmbG7ONU9q+ceKqo?=
 =?us-ascii?Q?AqsdIXDpYh6roOu9qzded6YeRfS9DxH2VRdv4Vt8mpC2kFyOuMlCjT+F2WFi?=
 =?us-ascii?Q?HP8YJLscAmUoh/yTa8TRg5TZK2jHF8+Ug7AzY/MDMEoerzQyS0DWKpHg2knb?=
 =?us-ascii?Q?GzfeaR044NAMhabI583N1VKVSTgAnzlKrBnCQMkR2RgRQJyEfMti68qcMHe/?=
 =?us-ascii?Q?nmXl3kaZ5NfUiy+ynW2fX/isbx+19upultEY1piCw3PgxTFhVhZYcErK/m8Y?=
 =?us-ascii?Q?9ufhEUQ5o7/xoxvU00aiqwQ6dO3eWUlXNl1em42+eLlwmo23Fc90QGWnN0Kq?=
 =?us-ascii?Q?nwQK7mgG7vG4+C74jhJqcYRrsX88Aq2W+VkIfKkV3LdX9U7ShLUaEGtTWkz+?=
 =?us-ascii?Q?9EQQcuOlYJx+YCgljnB+OeSMm/rr/IXDCPjci81ZTM6bUkvt5EzfV2Z6K8mY?=
 =?us-ascii?Q?5MnjKPAq0duXou77KvDZNbNSlnAeaU4aN4OXPergypXAMY9HnDAzQo9+K4Iv?=
 =?us-ascii?Q?d9TYzicpcXTBYVhcFUFEgdYHr6sDe+I=3D?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff9bc981-7659-4a13-780a-08df1b3011c6
X-MS-Exchange-CrossTenant-AuthSource: DB8PR10MB3178.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 18:08:58.1384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6Ws6B+pdv5Y2b9+0vjS137NUDqzD1UxQ2nGhDlmSmlmGdqQsuyS2ZfQ0o30oXVTA+yzwXvHR61PspFT8/dYndwzC/ySg6tZoCe9BBrowJw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6378
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 25 Sep 2026 18:09:09 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/24356

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


