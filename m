Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AF4C83F03
	for <webhook@archiver.kernel.org>; Fri,  4 Jul 2025 09:08:26 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.64])
 by mx.groups.io with SMTP id smtpd.web10.8427.1751620096496515045
 for <cip-dev@lists.cip-project.org>;
 Fri, 04 Jul 2025 02:08:17 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Bvow5Z31;
 spf=pass (domain: bp.renesas.com, ip: 52.101.228.64, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MBBnkQp8MHfVd+k9E9PhJRWaOsYIO5gbGczqJ7rr4u2AhmEjWrYZ7/iyUshQGMY8xW9E+BDjyTI4pzdHoIWr4kjyiTCgmBTaT2L8lkGUdyu1xNM/tOq9clqArwG/1ryChnCm48BWx3FKqZF6INUXMKlT7czuKlu07Mjjuj8solCc/ftcZDltAGaA50bVPt6oh3taiGNJyV9Z71H/ITaac/tJuk6m73CNVByyrpSHpZovqixq6TU3FnNTJ4Fkccy1S6radqsUEJH2EoNfhGiMXAMXjuO51V8ckkZ5wJbnjUppHEieyLJnGc2e1OZrWPRKndOmsDzD2z2IUJB7D7FKJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2UKlXej0pkv33DKHx1CTKfJvYCZhVFwq1qe/S8QwLdA=;
 b=J1rYhQH+EBoE34VBcr1PXti3TbRfCDiuvJQJO1y7uJOkHkAI4u2luMthO7ymAzIl2VpFjGARaWsvKgAopt2TwJJx17Gc9CCzkm/yoGMSHlDN4garbKXBeEbXcljLa3st5fAS2seKmcZGtlgISVfxs7KL5PJ2rezBtJxS4+7c7cR4VgmCgA/wdkQCZMzz4llTALijLbWQKnkJODT6rgOdI5jEZljEqXhrQHNHwHHv1DhACL+zeXqZZ44qPClGlfeIvRwKb4cjXDGrVQ18T+MKGgy0+co3W+zO0jMSmCuI0CSBac/r9xGb5udIUA83LqTy34iQ18+pNEjtTa81HxvBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2UKlXej0pkv33DKHx1CTKfJvYCZhVFwq1qe/S8QwLdA=;
 b=Bvow5Z31PXSZCZEHAtqu50lbnCnyqMtG0JP0xNzQ4TTzfC7tvhjDegEVoXrorF5CKmOT+5an1Fidx0GWir0W+sVVJh5ThAGpWpYwgq0ANf6/DdMolzClxTySoNdn1ivqQKnOV1U94wY7KTeAF5QoFZskWKtQ/p8h21e9Izesiw0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY4PR01MB14451.jpnprd01.prod.outlook.com (2603:1096:405:23b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.21; Fri, 4 Jul
 2025 09:08:15 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%7]) with mapi id 15.20.8880.027; Fri, 4 Jul 2025
 09:08:15 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 10/18] irqchip/renesas-rzv2h: Use devm_pm_runtime_enable()
Date: Fri,  4 Jul 2025 11:07:16 +0200
Message-ID: <20250704090724.669848-11-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250704090724.669848-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY4PR01MB14451:EE_
X-MS-Office365-Filtering-Correlation-Id: b572b47d-0708-42da-b1f2-08ddbada4f8b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?n9RxV+/PJ1V98iComO9nO7wlAzkw80n0hbOBRT7zmRpW7y147jzDenXDsGvB?=
 =?us-ascii?Q?gzkBAFCJwibggnuqLXtRit+sHkC9yK19zvTkaUErW31YLNNvL3+03SqHbQsY?=
 =?us-ascii?Q?RiEkdbugUI+LpDlaJbUqZVlghur/4Iec5d88wVfMTbZvWWHjwpsQMZ0Dz/AW?=
 =?us-ascii?Q?WFGpo2R59xlj2PQIlzMOKR7K9aAQNbi6CiSF8ZbB2MStIPaFHMNEv6mAIpum?=
 =?us-ascii?Q?jM7jcAbEP2/AqDzymXPygSpzvW0ygcQPFWLgZfeNuoc2rzkC+60u3VTvZEAK?=
 =?us-ascii?Q?4kSCtISoPzxsaIhNK9An2WK5SkTUufeOWE/0IZxepYt79xutc7+iGQNw014b?=
 =?us-ascii?Q?/EEbui/C0RGvUpRdRvQapYtooAWdQzWk6PsfN/6aGTwpwhr+CrmVWyAma0lv?=
 =?us-ascii?Q?g2VpwNFHs5vfNv+me6fZKa31hPZitw1KRp5q0QIPbv7lX37CJTKR5caUq7T9?=
 =?us-ascii?Q?FqdvdxTEO2wQ8Bl5ySfgFO/xa7EO25EMz7ztUTiSF0V/vPrxRe9GtRc548Ik?=
 =?us-ascii?Q?F1DIH5hUSP48qLmRRVBFog1ki0bGQhwSxgGwo8EvcN3k6G7MvAyOoZSUq+U8?=
 =?us-ascii?Q?u8d0n9fqVB2jQ1iRyoDbGWN+Y1/T+RJ2I1P2BZkGvbtMZOn4zvHV6lCIVnjF?=
 =?us-ascii?Q?6uKbgy81NqIUew15Aps+DG9ugfeyWAd+lwSJapjUb+LjKIspWwTKIK/4R/gV?=
 =?us-ascii?Q?cJsxlJ2I4BimIEo1sSkzfytmliVE8C4CW8WmC/tFf6wcp1a8y40//J5+OXge?=
 =?us-ascii?Q?4SIdsUjpe2wEutt14/4AFuGjy6HFei/1cVZcLtdj7AOwN+aGNQaQNqg8EAjz?=
 =?us-ascii?Q?vUT3/9T9cdVTvF5hkrzzk0MkBRzjDWMf53R7N1MPUNTufraUJnSuOemeXelr?=
 =?us-ascii?Q?c4uhZP51/Z76ETKhC1SJnsQDanTUeoBXXNK5Umrq238cBepjhHv50V1ISmqO?=
 =?us-ascii?Q?KbKAQeorDPltiUJgpUjDw7LifsjKDTz3u876AVIrRo3GM1xZloVCmx5ZTOUZ?=
 =?us-ascii?Q?c2mFTcl1PqLMxGaRfzmVQxVVTzYCorhmv3U4T5eU3uYeVdUu8F2KxNPoIqQm?=
 =?us-ascii?Q?bYf06I5y5mH5gHfcnmoRvTeS4AFq+nwhwRV9HyfqYVd6JeWz5jAKa0xXeQGM?=
 =?us-ascii?Q?GkjBKQMah4F1y6SVjUcNmROqEI9Bxq0XkUsptqv2JKw+NB8ofpsYOUmy5L1/?=
 =?us-ascii?Q?omgydkMvJRiHzIy2atIFAc1p3U4GznVK+0fl0UP0SqmREUrJXftc/tG2Wd6K?=
 =?us-ascii?Q?h0Ys+jL3OzO3ifTiz3sgc5efvhBUfs/n5q+h3pbDxrxh4TYCZb0GOn7z8/mE?=
 =?us-ascii?Q?m51ku37D80hovrYPWq+wlCmxOmUNO7RuTz2FOdLVzh+SPqirx3Ply1EBwr1l?=
 =?us-ascii?Q?Sw4RYJFpneCE0dcHNJ3yWr3nB60P0V8cDUo53jlzdzmVi5gtuGJMZBT9iXor?=
 =?us-ascii?Q?GAHH1s+hhJ9LM4xFsTPfkdOR7pc9jOwQb5DbsVtfFVAdlS0oIP9ER4hDF2SU?=
 =?us-ascii?Q?D8XZiDhq0TRNGTg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?nQHqvv0ls0mIcl5dF44/k8282ZNogTyUsCo4kkQKevjNGCG/UC0Z2offBr8i?=
 =?us-ascii?Q?S83zIHQRaV0c6EwwokuleVoeAJoLZ01bawtd6hhW63A1mTJoToIdofPoB2C0?=
 =?us-ascii?Q?R/IKLtO7LeOyOuSp7nZR72OlNohsWyrYT0lqvgb8GE2VaMS+1dm4AeOGw8Gk?=
 =?us-ascii?Q?7+5K8Ckve2IPfWwLaTwXZkw+myr7s9dceXz4naePUdKoygSdOM4PoemLrMjz?=
 =?us-ascii?Q?pejzSDqUV3Vgb+h4DHGPLboutNX1DmqURQCnYduKDOqjwL1PVZzRPYtE3FKb?=
 =?us-ascii?Q?gOwrnO1ElrALPAyOhwfQJyBqS0ahodQwZFqJeezkXZGjxJJv555DvKdgSXHG?=
 =?us-ascii?Q?zM+PXd0eUOmD6SN0xq70IxI9RiuICNTm+YGXSOUUr1Jf3VtMOFyTcCl2HsZf?=
 =?us-ascii?Q?QmLwuzoS8YQu5qe9LlFuabEdp6FOLQWsqQcCFaByA8k0r2xx/QZpbMm/eJ4k?=
 =?us-ascii?Q?WvurrfvmnBqChGgLiyykhwbJ1fVWAinOdqjSMLdJCRqwWDkWfkgztEsWqBab?=
 =?us-ascii?Q?eLBUuUUOvVaLvkDpM31ewbvn3O4Xrv1S+EpKmQsNlWr6Qto3eXQGHe5Qq23z?=
 =?us-ascii?Q?1xgddi3V+IG4bj4tj27kWc1IzA//f/pAZZnt6+ctlxfc/vbxN9KlCpjuK8Fi?=
 =?us-ascii?Q?BVYbogtjMPlXSOXa02xlnyFFg2yy+Nu+UVv9gyGzLY1x7MQTeU3sotc3ib3a?=
 =?us-ascii?Q?ZEOg0sehV88cyGCXBh21RuTv0vHLLiji1EQJ35Jo6UAIdZ9IOAkp5k6ulXwu?=
 =?us-ascii?Q?VnLfTBeU30vaMOg1gAEPZy/nO69faT75vrIfCtc2WWhE+i/TupjfktVMKC0I?=
 =?us-ascii?Q?wMOvktbVE3HNgnKtAjiFmB3AlwTVl1t7C2OHlThbubJEqi2Ng0RnR8O6gcYX?=
 =?us-ascii?Q?CsCSIkvK0dLpjzAekPMEBS7B+EYZvxT64ANBpvNSf2oGWpSh9bHaHFNpTK4W?=
 =?us-ascii?Q?Az+7zbR0L6i/5ASuwUx0YKdVBhARCp+N8BVuPIqu7myxjuJT/W6p3M9YIrXV?=
 =?us-ascii?Q?kGovBvX4bh45qS5mB2cezGJ8lgyJdCarAXcasFjZlkfZRk6n+34ZzHt4/No+?=
 =?us-ascii?Q?VBnl3JRPtya+oez03WfjfY+so7I4xhUrshZjTLPlgruXnJIg44U6UUrm8UcD?=
 =?us-ascii?Q?+pAL7qjrTD0zuAYNgtITqaL6yPJpxOBYIEd4GW8UOLy0lS2UNaw0siXPCfJl?=
 =?us-ascii?Q?04MmPeigOdT2E7ZHjM6eh26AejKEA3PxJWNXzNpNrVBbvWQqhkBM30t73Gy9?=
 =?us-ascii?Q?MIQ6yvxOsxnxbgaEzPgg+95q+HwqCm27U+oI/9SF7XsHeQPpPmPg7gavw1xL?=
 =?us-ascii?Q?Zko4WjxlCijJYa4B7E3ILLMTo2kvuLne5HdBcNp+IVAe6q0DUt1vc7JbWKtu?=
 =?us-ascii?Q?9hrJ8seoedCohDht5x1XbP6jVcmC/bhPCf30YIClvkdqkHhdUnqZwBpDXgu4?=
 =?us-ascii?Q?cwth3121h2qPtnimuXb8IqIhDbXlWd/iZ2iXo8G/Y6Jm7RvPODa2U4zmY9Sx?=
 =?us-ascii?Q?f3+V1A+2kcp6METnoKPUAnZ1vkiS96iVZe8Zddrd9k0fOdOmCzF0eO02Epu4?=
 =?us-ascii?Q?cZ2C67a1FnfDxgivxz2MncqSNzU72aBF1LiMCl3Tt6B0GgJQTuGPSY08ApHc?=
 =?us-ascii?Q?zjGo9WiKQRVAovWwLH7yrL4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b572b47d-0708-42da-b1f2-08ddbada4f8b
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:08:15.7855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T7Ele6OCplAZh7/aiUKrBhW2nynHR3zG/E6kAbgeUoIyq8pg/1RapPxKlzbGNqUGd2Avsih3EWgzBh69H2StIE4ZxUpKT8ayWkLTCWv6j39kf9EHupwL7iUFOZDLVqA5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB14451
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 04 Jul 2025 09:08:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19354

From: Biju Das <biju.das.jz@bp.renesas.com>

commit 5ec8cabc3b8622f95de973c1a245245c65e3337b upstream.

Simplify rzv2h_icu_init() by using devm_pm_runtime_enable().

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-7-biju.das.jz@bp.re=
nesas.com

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-rene=
sas-rzv2h.c
index edae54f9f5da..10b9b63a1f09 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -468,11 +468,16 @@ static int rzv2h_icu_init(struct device_node *node, s=
truct device_node *parent)
 		return ret;
 	}
=20
-	pm_runtime_enable(&pdev->dev);
+	ret =3D devm_pm_runtime_enable(&pdev->dev);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "devm_pm_runtime_enable failed, %d\n", ret);
+		return ret;
+	}
+
 	ret =3D pm_runtime_resume_and_get(&pdev->dev);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		goto pm_disable;
+		return ret;
 	}
=20
 	raw_spin_lock_init(&rzv2h_icu_data->lock);
@@ -493,8 +498,6 @@ static int rzv2h_icu_init(struct device_node *node, str=
uct device_node *parent)
=20
 pm_put:
 	pm_runtime_put(&pdev->dev);
-pm_disable:
-	pm_runtime_disable(&pdev->dev);
=20
 	return ret;
 }
--=20
2.43.0


