Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80661C3600C
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:46:31 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.9])
 by mx.groups.io with SMTP id smtpd.web11.48807.1743417983379384922
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:46:23 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Nm6590v+;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.9, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gM/fVR1r/4HawgdCi5TmRs4Igo315QgPv06VeXxoMIRsKYaixtt8/NDzgA3s+R+vo+C6mhmmrijZKgYzPQ2EPyaVQihNURbongvfgFf9gpGpq1bGc1m6Djgn9KLEOyJkqi3MR5sBzCHMd5LfnHslT3SzvFPjnWIcKp9pNKQst6D5DP7TgVLoNt1RiitKwbTdDJxqUgA+hrlnbWQhaS8fMK29qLhZ2959WhbBQtXOtTPSjnGHcd49rUVDL4dORmwdWn9Z61J8CHUtMBcxBnkBCEYB9XZecExiCOHb9TlLywMWR1Oh9WGQI+Na2D3VnmYAQf6PrsiyzOm2DNUNk+hQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wt+Jr33Yvbx3mvimY5yJzPcVmmX6cRwV8swR6VL4gkU=;
 b=MgYwnKpZV4nFZWxoWX3QNRzPFB8aNglWV0ZkengqckECQyZrcoLX+ltNgfkaVr77VJfjgpEN3IxRChuyalZHc8T7pdmyOURsxDlb8SV7AeZfiPD/UoQFZVlk3nqFo6c/xCPrb2Sa6ArKkDcjYWFm2OpAXBtC0nEx9awm5DH+RXF6MxkEWtHlV53lEO3WlA2bhF1zXI0yiR76CF8F4flOtg51TdfZY/+Qos6NtyymNJAA92DSqkoma089sgfwIqGmvd3gKc5T9aETh3UsIUylFYJ+RCNvI/0DUsGc2YTEu9Og0MwhGl+o1mBAZ9yn7FBlA+WP6cnIv2LSKXd5Q3EdeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wt+Jr33Yvbx3mvimY5yJzPcVmmX6cRwV8swR6VL4gkU=;
 b=Nm6590v+y6JFtCms2GAhlqDH4VL+7KPKSpYh23DSsJ9OVe+tHcX5vp/T5RqANbjCHUrU3s9jvkIBdnt9V2nM2htfVCyOkc8dQATj/XcX4le405So3N/itPIUVi/MatyQjREYHbuEX7wZ4NJCmUegj+J0dQLc7RCJ3tGxsRXveq8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TYCPR01MB9796.jpnprd01.prod.outlook.com (2603:1096:400:20a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 10:46:19 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:19 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 16/43] pinctrl: renesas: rzg2l: Pass pincontrol device to pinconf_generic_parse_dt_config()
Date: Mon, 31 Mar 2025 12:44:47 +0200
Message-ID: <20250331104514.79090-17-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250331104514.79090-1-tommaso.merciai.xr@bp.renesas.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0148.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::13) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TYCPR01MB9796:EE_
X-MS-Office365-Filtering-Correlation-Id: a95d44a7-ef5f-4c19-0fc2-08dd7041452c
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?RtbGLgv9b/TnLVQI3cuDLgYYOqdLPskFb0UqGdNVstjYbBhQQVesIeVsie2i?=
 =?us-ascii?Q?F8sXEXGHqHd/5hokTJjTRKt6HcQMT8591mtL7BW1kFLTfyHq153PBMPkYFwP?=
 =?us-ascii?Q?aCFtSCiQDKHQ8345fyCkh137zTyxQKIWRFW9ijm0YGx9o9IrNQvFzmubqdFh?=
 =?us-ascii?Q?YAoyvoxfu5dkaNjRulP7Q3lOXGjyZ2KuaMexJCgoG9Kj4NbQZbutv0VZReUx?=
 =?us-ascii?Q?COFHGwanyCb43N2al23bc1RKPcF0FCAUbBQIYgRIqZAJN3RF1gaWNJ1AmyEt?=
 =?us-ascii?Q?0jBUZYrVCdhS7JxVSW9ue1xMQSjMjYsxsSRuiTmBs5oioVhv0wLGI/TptjDB?=
 =?us-ascii?Q?ciula4QfIfSSeBKWG5gheMCUWKxktPhrBBFmBXl4YvzNG3gdX7XoazdKvK2k?=
 =?us-ascii?Q?1SLlQyCQeIDJI+U+M+dKxNf8BjoV9L10ofSSflfpLXwZ1W7WO57AuJHheBv+?=
 =?us-ascii?Q?FOdupLgUX4STErkmRe+QJAS5Ykl3/DuDdDFESLxC4yYYBTvxQfqeL8igS6aB?=
 =?us-ascii?Q?raZ9oumHDy7lZLuAx5JJ5PlejKwaPTNIpV2nqwhdO5xydr05u08bvoN2F6xC?=
 =?us-ascii?Q?C6c4oNaPGumk++PnlhIsX5oC7Z6xGFM2Yc5JIju5upiKFoM5Is6TW77emRh9?=
 =?us-ascii?Q?Lqwgip/GOFXKwTPiiAIedX44buXUl7rEgmrKgAFr4HpP4Lz5pFUzcmbhoLuG?=
 =?us-ascii?Q?yPGf0K3o6Nz2C2S7PYkHlHYlc1x141NcXuDlXemAzL4HaPDv663pkFAbVsQS?=
 =?us-ascii?Q?xTLqylBCyAEzN0rf0kT8fLz3gfwsXOefEYEuk3QrXPlwhO4AIrpiiWFX/Hbr?=
 =?us-ascii?Q?28AT30u44u/oW1/kCOwkZBtCMQlJ4lVbBe1tEyLlLhiuii6xKIQD3a4gnPw1?=
 =?us-ascii?Q?DZ0hzXC1k2OiNvaRXQudmyWJ4b1rIqhRuBsgXn14tQ0J4q061jp3dZGAFkcI?=
 =?us-ascii?Q?3XSGYF6fUJqPD5hf7kawb0nXyocErJM5d+0i3uonsILTMAzeYfhd5aeTNxvx?=
 =?us-ascii?Q?64zfuqnqyFtHYWPzkK4frEGcWRK0pnDJS1PjGKUYAW6f+c+T2FKHDyBXdnku?=
 =?us-ascii?Q?4UA64so0aKytNg1oJAiBSqqvXAs3n68oenciVztHEp9QiwinsNRmJZ+BzhqG?=
 =?us-ascii?Q?5izogpcAYZ4tp60TSrUFKq6wnzY9TNHIyb+gPwhMDR4nhPr8PDyBcv6EvSPo?=
 =?us-ascii?Q?BvDwA6tFpK5bmWaybRXh16vRLUXAN93kmRdruqHWVrtCPP7Sg6S0Asne43q1?=
 =?us-ascii?Q?9zLDRUQkDZBzuR7rx7d3tkwfmUn5qnein4I9qPPVMpLIpey14361XPCTRZKg?=
 =?us-ascii?Q?11zUq9LPFK+1q38zpij9j9RM2ZDgYwOQgFM7FiHGHiNNziqRTKhxdbJzEhGz?=
 =?us-ascii?Q?1wzRWFZgbVjK+MzllsU7NhJzRmrShdaENQIBQPZuOueO9Z/Jy2O74DMEdm/n?=
 =?us-ascii?Q?YxJtQJA558NGLm4xyYvdTBCnUQAD7Od1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?mzkKDd+di/zLqe0kkgoR8YN0SnzpXVX6A5gP++VxDnVSY2uhB4AuT1UZcs+g?=
 =?us-ascii?Q?dFh4bBXoDfS0R3sj5vpYrbmvxaVWDMhH0+CQ04qi2/xdGhncD9oddO7AApNG?=
 =?us-ascii?Q?ovri548nyc8YXTXjkhUSBsKxmUQtt5kCK5OOBFwIBpjQUfz+3wzkBrSD9av/?=
 =?us-ascii?Q?tiErHgPzGeXlFH6KXREr/ZvCInhbH/TtnQF2B6YJwXtsiNrH5hiY/elqEC6o?=
 =?us-ascii?Q?kVhFFuAuNrPidlie7sxiSN9oKBoWY4LwXpwqFkXKWytT74MM4zI0c3G5hAZf?=
 =?us-ascii?Q?7RQPWU5FwYjUOAqkwoKPfNi5OM9RlAd6Vku2ec2V5nWFYjY37z8P8KEENIhO?=
 =?us-ascii?Q?FNX4OcKVZi7lWeenGi9vDAEKgzclBe0jcIBLD5UKeEURKRu84t0Q7QKXhzTA?=
 =?us-ascii?Q?vOuBu61BYUNqmaiVEIlDn9SYO6IRZcYIE8+jJPGpIRaf3C2SaigyzHJbgRtq?=
 =?us-ascii?Q?QcvTHNdpta8gatwBBimReTyCr3ua3ImTQo3FUS4/Fqr58W/Lon7q+0ZQCi1n?=
 =?us-ascii?Q?l55aqPU8o1KkcYuU30zY72jsyHiLjyTptJpMFYyLXQMBuzfyLlQA3V+cskOm?=
 =?us-ascii?Q?SI6nEuaR3b+sr1gpbFz70jubTsifVtfkimd4Vy+AqPz8aL+7t3pnrBPVm0RJ?=
 =?us-ascii?Q?AoDcaC+5npl9N0DPVyGK/1W3HtYxH6k5b5m2ziIR9UgILznUQdaF8AwWFdzo?=
 =?us-ascii?Q?HxuLV3qYKtJ/okf3jrz3O1AtwjNoN0G3hsBIjjlLzfKE6dByVPD/USKfbsyU?=
 =?us-ascii?Q?mhdgrdYWthPtci1bU3ZgHuVanIOMOzpHezchCLWukEC/6I6A5u6tI7g/LfBF?=
 =?us-ascii?Q?ush5W0QtpFBlWKG2/8PdYNtgeB2awhajCblghNXrl/Md4ao2QGKHnNiCUUWT?=
 =?us-ascii?Q?wNkNQUimZdbOz9nD2fwBQDQB6Q1r7EWKe7ZxfHcP0ihvOmUpwowGEEZco1mZ?=
 =?us-ascii?Q?V87/2UN7bo7txIHu9QNbnAWP6+zXwEkwMFaV5HAiKet66pk5eqvO8ofo9yfz?=
 =?us-ascii?Q?bc1UArrWTMln4RTrN5/Ud9OZnTCtZ7NLZ7nLL5jv6kSdC39Cf14nkpPbqdJE?=
 =?us-ascii?Q?/n0AsUqS6ai7V50afAXfYIn7prfiCLjnMdBqYX40w/0ZSCHIJ+dVRGR8PIda?=
 =?us-ascii?Q?PJHEhfwx+XuUe5IAca6WE2WKCnRWE9bW4R5UopA6rkMl+cebprSksFYX8Yrr?=
 =?us-ascii?Q?PE/QUz/Sd9huFq2KJHB/zyvWpdSSRR8NfDS06/Ojmy0VhblZcbjFmGh5qH5H?=
 =?us-ascii?Q?2Ohrz1SPA+NG2IUtVhhhwr6V5VmMauVFU97m2VhXVHEOCEVHNPuGj6AY2nzv?=
 =?us-ascii?Q?Gmy7n0s7td4llzkGX4ag5neiVnq0LNdYgoCuD6gfl0WinXWiZNf9a2QGbcCC?=
 =?us-ascii?Q?9e6ucFTO/YbbOsl6zAuDyVGjsMcDFbkff5qlzEc7piaiwWdmzM1t2Ey90pBk?=
 =?us-ascii?Q?fNRewYWdhVRpFzXbw0fQ/JgPF/McZBozrCmAyAh99h5OMmFXPm4l0lt252wc?=
 =?us-ascii?Q?JpDb62L/dK8YT9s0Nz8CQScZTBb5Hc42L5htBaIwgU4EDV+WYvyIDz4enAXh?=
 =?us-ascii?Q?aTB3T/6lnbWY6p6DcZfrXqPDTkv6t1MUJ15CbP9Xww1dtbpIeJouc6Zzy8wD?=
 =?us-ascii?Q?D7/2FYcw7znAYVRuBnBAElE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a95d44a7-ef5f-4c19-0fc2-08dd7041452c
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:19.6208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8HP9HutQt9Q3kPnjvg44FbZ0/R+QKZXDkNzrf+F6wKGkn2WGbm6CDvoFHECwSyPZBbGdnOPH60Hvwss9kfr1O32MS/oxu4wt11zRD+AV4YFYOwg85Rr7NswZ0+chEGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9796
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:46:31 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18404

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

commit 6f38a02ad8e0335dd4dda2c42dd599e254cdd91a upstream.

Pass the pincontrol device pointer to pinconf_generic_parse_dt_config()
in preparation for passing custom params.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com> # on RZ/G3S
Link: https://lore.kernel.org/r/20240530173857.164073-13-prabhakar.mahadev-=
lad.rj@bp.renesas.com
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/pinctrl/renesas/pinctrl-rzg2l.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/renesas/pinctrl-rzg2l.c b/drivers/pinctrl/rene=
sas/pinctrl-rzg2l.c
index 33c96661092bf..9c1f32f6e1e46 100644
--- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
+++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
@@ -531,7 +531,7 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev *=
pctldev,
 		return -EINVAL;
 	}
=20
-	ret =3D pinconf_generic_parse_dt_config(np, NULL, &configs, &num_configs)=
;
+	ret =3D pinconf_generic_parse_dt_config(np, pctldev, &configs, &num_confi=
gs);
 	if (ret < 0)
 		return ret;
=20
--=20
2.43.0


