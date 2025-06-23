Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A011C7EE39
	for <webhook@archiver.kernel.org>; Mon, 23 Jun 2025 14:47:22 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.42])
 by mx.groups.io with SMTP id smtpd.web10.362.1750690038621153973
 for <cip-dev@lists.cip-project.org>;
 Mon, 23 Jun 2025 07:47:19 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=AZaHLsIO;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.42, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bvzz6EFuHLouqIZFeXV8/QJyhV1Dw9ekHXFaJ8yK/R3yXj8ruaUKAORXHyslvVKUxpvQm9a8n7JGgUPEBfqN6BxuGwVYZggRQukJ5wPetnVxOVC8iQDU6nKEC3hzYmFxUjopIcVovsHYNeezh3MH7TJDeBHpJAXz2Ukfqe6630qsl17SCafW087mQ5uRjnT/XZyEQaBpwFrttLQLwRgrpvYAXHiefd+kAMv4/v953OdLERMtQ7mVz/y+uwhvmP/9yT84jOxnkB9QbULwSN4lpvVYVxs7dHqACYKMOwj4h1VuDiSDqdiV4TmOdGg8ph1vAghR2+GTFB7L4XVBPjyPgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SEoCHcdCI6O2+VgzEAKj8YJvsymY4HqZwo557e+XKIg=;
 b=jd+jvnLiYvTNurZx1ZxDOstWHrzJe2apYBsbbhORlx7t4SUDKYAzCcgoWg9yN/ssRz3EONw4b0TXII2WN1DTD5u9ovOYiMgIgJjPB4bvyt+0qzcddCG5FPetPYSZUFFyCuZ/7ZDFjhDIlWFflt1wrR6agP3amRs3ePuvHztydSBSYZiZ0D1yKl3dx302wSIrB8OtLXj10xMD0Et4+9LxFGtDaJ0XxVJ6gIp0+DQ1bOAw1HBm4WJpCCZs/yImjGM2U3hnZy6mAVV3BPxnqtyJg3eaDb7+vXYcvqYI0nfC74nBZmlWM18cQeLEB4iqWPGiKJ5q9ydBqtp0X5dNeZdPtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SEoCHcdCI6O2+VgzEAKj8YJvsymY4HqZwo557e+XKIg=;
 b=AZaHLsIOfMi1GpeNROoLtZidEvhAkaP8k6UFd6Jg4PChINIgQ1zkZ+njUMmgd+nud26mrOciVMXKcU6Q9Y8uMuULCIbz3ibzNUS4gijl4P74CG/S67JZgACl6Nze4S8uAWicxfquXYpTruKvhkI5VP0knedecm1lRWhC3LjQAgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB16379.jpnprd01.prod.outlook.com (2603:1096:604:342::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Mon, 23 Jun
 2025 14:47:17 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 14:47:17 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 04/17] mmc: tmio: add callback for dma irq
Date: Mon, 23 Jun 2025 16:46:26 +0200
Message-ID: <20250623144639.2119707-5-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250623144639.2119707-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0066.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::17) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB16379:EE_
X-MS-Office365-Filtering-Correlation-Id: ff39f9af-6695-4570-da14-08ddb264d9b5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?j0YjvfMUuJov3cz3j2DtNp2KM7J7FjkviWIjXDY0+bLu9sqlJ9lGIx4hR8sh?=
 =?us-ascii?Q?mNWqjL1rN9f2D2gN17t2caW4K7NF1plL+5JajznumBr+ANa4v8cVYX1jQkA0?=
 =?us-ascii?Q?5YNWckZiqieGM46DDm14ktfRXhdNrodq3n2SouBAjSPwpuyAePu78YmZcnC/?=
 =?us-ascii?Q?SnWZyawAsqxeaEUy0WHr/vKLwi1q+g0q5Qk5DyQXjcgBSKuXvuScdPRvRnGh?=
 =?us-ascii?Q?DEyjGgAtLpdfj4eAwQbN2kXdsRwaOp9LsvWo2h99D/XGyKUkQEKQIq6aM1oM?=
 =?us-ascii?Q?QGTwBNh1KkBQgDEuCJmSk5ZNZtV7n6JGp8GsqlgbF+wk6ZftzrAXz9CB+Dtg?=
 =?us-ascii?Q?cPuiGDce+kfp/kPMCp+/efX75w/kLs7lqP5LXl5fYX5TofnJRhguiQScHzE1?=
 =?us-ascii?Q?XQnurE/L3kNXm14q4GsxoVh5nTsjbfy5T2fQTtWM7kqfUnwX3+fz7x9G8f9C?=
 =?us-ascii?Q?WN+EiKWUibZU4yPNEpHtQZreqHgJMqoSOXIg2W/id4gVVXLsYAKAPWEr3FAU?=
 =?us-ascii?Q?ot7mlhCRvEeyLiS0tcmAA5nrH1xIkjJn/9/V/myYhEijjdRjOqzOrGU8kpDY?=
 =?us-ascii?Q?EEZ7P/qj9Ypg4XHDq1l6smC9TufHucLeV1LfpUdmUZa803Kmb3J78zbR3tpN?=
 =?us-ascii?Q?f356lcE89Dzx8wmzai/sPPoLSbja4YCsOKd6kTJn+1gQQonvM6zZ6dC5qndJ?=
 =?us-ascii?Q?6CsWcxFhdwXUoX0SH8Z//4JcmCdDuYxZq9x65dMzur2qt6pxlzN5kLOiLYmN?=
 =?us-ascii?Q?s2gpsxZwGzvbN0N+Oz3UnDjTktEkW/jqt00dqrcoIQxEP0KZEaz/bsyZh4Dj?=
 =?us-ascii?Q?O88vVwthDqVag7yB/7kiyCxqWq/1+1uVI5TLaykirGk14XfpqdM+NHxvnWUB?=
 =?us-ascii?Q?LngNNVvCi0EgxyxUi0gJnqjYPK2KiBTr90UO7Llv6caPNsR8OLT3P+vGC5fK?=
 =?us-ascii?Q?UX9+aQtDvUYtflwY85+26wu72ogAWrzWaKh9ObVH1bKeCbOzOUKE2vmMQAFV?=
 =?us-ascii?Q?fHwp0B7FJuIrkPgF+NIyYUrwG5XHoFtT6wIMbVYUUSW0a0VfMNpd0al7gAMK?=
 =?us-ascii?Q?khKI/0DiveNeQkbX1M+GSaKdi8cxd5+TBOIAO6mKtnWNBHtBKaJKZ9otsUy7?=
 =?us-ascii?Q?hJ53hX7owcF3OisrlJj67CBk0CWULK0PrvbOQB/wTuZUJyJv0EZZtcs/3gyo?=
 =?us-ascii?Q?IsNT4aJrWwhEWmKvvNYX6mE8i/+Gkg8J+1bE9huo/vEnwPyIZGq+sf9gnXH8?=
 =?us-ascii?Q?YzKY3GuM/Smm9MIpdUxtnese4ylccNKisISwwSn+YJjqBDWR/CJG7Hov8sdV?=
 =?us-ascii?Q?yHej1HmWRAhD8ObvkZDLDOSfcL25Yy/XOA1uzTvsrP+kN6kEun6Z2gLxJORr?=
 =?us-ascii?Q?dUWaomykMw1o5CN+468DCBkHwwDv+2uFspllZugOGKzR5BulE1+aBNN1LIgz?=
 =?us-ascii?Q?knZwnacOwTAFylMmaO3yburdQUaXY8jMY2FArxdVvhu/NQ/K8nMUsDPhcSng?=
 =?us-ascii?Q?cqCmmJHqCRHy2uk=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?X57xk92B58vK1N+HhT7m4YrXCURwYdd8JnDt/+xsV3rDhcLATk7Y/RJ4UujU?=
 =?us-ascii?Q?cFEphr+jvjXGXId7LTaNVp1WKCCjwvZFjdZ6FRGSpORN4UOkf6d9oIxkgb1h?=
 =?us-ascii?Q?lxwK1mWsO2pcLwUkKGgpsd9bqIE60/A9BLCTs0SUhLJhAJ0DRJ7ZmWJjSOwu?=
 =?us-ascii?Q?wlJXd/ACLRtRSCqpxpL1AHYNiqjlFokmXYZkIHKbw1mPP0iX0zWhycYKN/YZ?=
 =?us-ascii?Q?TIKOU+ue6YzZUft5MxKMitROTZVzngsqF+zEWqUv023WoWlNF46NTrwCvS4Z?=
 =?us-ascii?Q?uoAIsRmaDwm4bPGfbxQ7UzerINPrDFBWZuUbVvuzoAPCsJEEMEpEknFfiJAl?=
 =?us-ascii?Q?kKQgkdWheNt3pIhgIKMK9IrG3SD706biDPYJp31Od4TrXxdCkMJM+qntri5l?=
 =?us-ascii?Q?tkawQfpR1PkpwxWeqWvLWUdPmUswW8VSEIKIicYz11OP1rcKaV7qvVMu1zRX?=
 =?us-ascii?Q?8VSr7U31iC8aqqTunlzB8juRJv1/KAl7eHdGcZlTc+W5bQYnkMVFkdpvEVrq?=
 =?us-ascii?Q?cTXkQbitcpBLBO7RI0ZpkPI9Mu8uxbFdM+A9e6QtLwTPffjVsgLV/tFfv5QB?=
 =?us-ascii?Q?c8pli6pMpRlO24LJ/1sYb240Hmt8o2WylnpVoPA9xMPXumzIBwqql2Lsn8cR?=
 =?us-ascii?Q?GSHxr+ea1914j7J9r5jJVoDCu+ucwUNfon9SsTJ0d144ZKZ00VI7EHe26aU6?=
 =?us-ascii?Q?qMbgd832THHIWO4Eclgp3YuMhun3T9lVAGa867o1WHbJPWYUkRAFGNxkJygP?=
 =?us-ascii?Q?ugusoeKybKnF/7vXTThg15uT28EZ/qE8qLAzQx7uXo0DK9u//Ros3GLgVc2W?=
 =?us-ascii?Q?YgVgVKn/rXvBzi8mlwBvXyghTE95QGjrYawvd8MR3j4oLr5r5n90EYLEoLSm?=
 =?us-ascii?Q?QpJXfLUco3ZiTuOyWWER+VaGERDzrBj1/rG2CyhUR5EsUEgN975jb1qpyg6z?=
 =?us-ascii?Q?IminEKXwbZcX89weQqHX19nXKQGSYo0+m1JjnBJJgMkBXY2MfKaOb8xlSAoN?=
 =?us-ascii?Q?0D3xxQDNRwy2N40rNOE2mYyloNlsYJnPthTOuktHDGp/CWThKP1Hw1zt1PWa?=
 =?us-ascii?Q?3cvsSBG0UgttuApAdp29uJ4qzBDgsa2QQzoGbyS2OKLEuojqV6kHeYKXkYtg?=
 =?us-ascii?Q?3+ZuCNJiubtv3aloJlN77Y+W1zM1jUdl/wguT9v+EQ6Zzl6DVz8Rz5Z5SwEA?=
 =?us-ascii?Q?d/DlqJixfaBPKIbqYA5sfzjpl4fx8ZlRpitkSnF9chLONRYqS0qGMchOW0Pu?=
 =?us-ascii?Q?oy83jO3KSyQV8paBe8z0MFa6bPQVgKw9seBknwqvO9AJOALi9b5OCn2Dt4L0?=
 =?us-ascii?Q?P16nV/ZCecRbmsFhtHnyrg4rRwrzbiL60n+aEAg+vYQx5wjkRAEBg80kH5u0?=
 =?us-ascii?Q?2CkOrH7Ql9KlENT1oCwMQvai4xRcMo+fDbt/nWnHAukaTU20KHFWKtkKE5Os?=
 =?us-ascii?Q?cHBYMflut4KWWUjBHa9AnmYAt/bxLcaieiz1VGToVf3O4O9+PvWLY1P3nVwa?=
 =?us-ascii?Q?a9dsitMJ0bJxN8iPqPAiPs5oipeMsaTC91CqqB81qoPW4ZcCTKoUp/JxqpTR?=
 =?us-ascii?Q?t3Yb2AlUvHkcXrpvCd3fEc3NN7NBAg+LBPxCXnltTW7hIdEqh+apcLjfvyJn?=
 =?us-ascii?Q?WF0SuvqiwuTf0SWsTbmM/Wk=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff39f9af-6695-4570-da14-08ddb264d9b5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 14:47:17.6234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jI0mc+7vQ/PgLepemdp/EXJnjMkhQMyjWmBuyr5nBh3GQxq7+tpRxFwDv1jVRzT2cq+4FmXbY8UN6x7hclsmg7tr9qo1WD6d+NkG0NJX1y71cNnWNRRNdB6XdiUlfJsD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB16379
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 23 Jun 2025 14:47:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19191

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

commit af728d7ae20483add9f8d3c81280dc6298a0aa2e upstream.

We don't want to rely only on the access_end irq in the future, so
implement a callback for dma irqs.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
Tested-by: Duy Nguyen <duy.nguyen.rh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Link: https://lore.kernel.org/r/20221006190452.5316-4-wsa+renesas@sang-engi=
neering.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/mmc/host/tmio_mmc.h      | 1 +
 drivers/mmc/host/tmio_mmc_core.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index 501613c74406..873a06a179c8 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -128,6 +128,7 @@ struct tmio_mmc_dma_ops {
=20
 	/* optional */
 	void (*end)(struct tmio_mmc_host *host);	/* held host->lock */
+	bool (*dma_irq)(struct tmio_mmc_host *host);
 };
=20
 struct tmio_mmc_host {
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_c=
ore.c
index 5024cae411d3..7283252aa07b 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -672,6 +672,9 @@ static bool __tmio_mmc_sdcard_irq(struct tmio_mmc_host =
*host, int ireg,
 		return true;
 	}
=20
+	if (host->dma_ops && host->dma_ops->dma_irq && host->dma_ops->dma_irq(hos=
t))
+		return true;
+
 	return false;
 }
=20
--=20
2.43.0


