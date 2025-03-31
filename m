Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88599C3600B
	for <webhook@archiver.kernel.org>; Mon, 31 Mar 2025 10:47:01 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.48])
 by mx.groups.io with SMTP id smtpd.web11.48829.1743418020672948806
 for <cip-dev@lists.cip-project.org>;
 Mon, 31 Mar 2025 03:47:01 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ui2lPEDX;
 spf=pass (domain: bp.renesas.com, ip: 40.107.74.48, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDJtXpeVqX35qNvkK/Gkhl0DapR320voaecpvTtwBTrfFsupF4TlupeSYEAaDl4BXx/9Q2ntgf9Eg6BHDYo0hVCZBRt02AaNxz9YsZsyzJbLh1FeXkz+Lxp+2k5nYpufvyqs/nrsXRM9iZ6XJD1MQmC/MGs781+VAz6UzT4OPsDrI49W8ALbKFjMDLylU0wnqTDUVjR/LQGnUyKF1wV9kbi38omJBflOWekBSBInfSSGlOzp67Vhf+Pn8ozDuhEGUVyad+uZGIxeP8fcZPd6Gusb+2v8GfOLSfxzyHsRIc27aQrMNkO6DqzU5G84h/d0Q85KSCwjMhCotSaVRucpig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kaqrf4NOmC9xNhh0HvQhc9B952nefh1wy0l1EBxWjF0=;
 b=pbMy4lDh4ONAzTnfw1Dy+trCtEHs+bKLiGikwyiEDu7FkuLbNAyn8fXwVROgnVuBu1lIxKQau6AcCCcPn8Pzw7GO2bTOHrlPJGup/bye6/EGJWm7x8ZWpLP6Jg3RwNVlhIaG1maGnhyLMcOEZRzNmE+pDP+rOxPnNfrut1KpV16k2kdP2ZP1eiFyekkZZGZFxXA/ulJd/+gzK6EX5hthdICuZuVoCnH+pK1SR6B+rrumiBposPedNt4orzaG70pBI/8QY7UyzEp6J7rfgqaM2EU5+zmSL2+lV0n49Yu1r3RSwWcKiIbXLewCxHP2N9zBsbAzGv+uqzp1PbOrGXq0Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kaqrf4NOmC9xNhh0HvQhc9B952nefh1wy0l1EBxWjF0=;
 b=Ui2lPEDX2/+Huy/dJcg42ENI1li9iM30ffFqlN0wvl2q8Eip6OWmCh/MKKLMgKIn0oQnrWZDd7jE3QB1YRFBZwGhSadjjZwuhNh2HRp0/9zGiTfX6wq7+Af/l9MzEdgcL5/4+CYjMqRMFpPyB1N7rlMk+hmdw7voinozVUW9Zho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by TY7PR01MB13744.jpnprd01.prod.outlook.com (2603:1096:405:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.33; Mon, 31 Mar
 2025 10:46:58 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8583.036; Mon, 31 Mar 2025
 10:46:58 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 29/43] mm/util: Introduce kmemdup_array()
Date: Mon, 31 Mar 2025 12:45:00 +0200
Message-ID: <20250331104514.79090-30-tommaso.merciai.xr@bp.renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|TY7PR01MB13744:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e1c4d6d-adac-4aa8-498d-08dd70415c81
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?P56F5MvmifE/yBOhNN0M74DXGkN57MaiuljsErfWNYbCcuwE8O9863KPSqZE?=
 =?us-ascii?Q?umDJavjj0IDms1xzPBaMYuDPe1FzGQg9DfguNNeU9/4NRxnMfNMes3yu6nbp?=
 =?us-ascii?Q?MJfZUfp4ZJCpb765RUVSt4+Pq2Y9NbipzI+KInCTm0gY0hzFsNdgUbL5XNVV?=
 =?us-ascii?Q?ScxSnlyhoFiRcxnqvF0Twy9ngJCO66BGOp2YNIOfoANa/3yVzbRtj20QVybF?=
 =?us-ascii?Q?q7Aq0o6AR81Jzu/E0gsYrQ3ZC04gGB/5S3qKuJqq5QHSF1v1bmAkTfRvdi4X?=
 =?us-ascii?Q?fxy6Mh8809K4JUs3T6CFBhgsLHXo6NfudUu1lypOau/rGQTLxb2npEcfxLRy?=
 =?us-ascii?Q?NgluIq9EMbk9A3F0mS1yudDDcyB1zoDihdZY1vrtgruIbLSQ6+CvEakUflEp?=
 =?us-ascii?Q?Sp6c/2t8b9ajv2P6t5XSHNFI9tReBpIjxv2BeVnZENuoQxV4QW4aC/qSo7CU?=
 =?us-ascii?Q?cgzABZuRK4UrNkDg/9uUeqwYdhCEPw0peAR0ncXtGnx9LlLBiYBibirhvdUc?=
 =?us-ascii?Q?RBX5GlpPu54EqNdv2D7t2iNvidbl2SCnrZXiQRvg2I6hWxrSOHiVHHE/XHw7?=
 =?us-ascii?Q?MxowAVCRS3VMwRKko6i73jYt6T+4RtA7WWEgwCtD8dvriVSAnM7axP0SMVgi?=
 =?us-ascii?Q?jZHhXnXFmy57cXtL7IOJ4o+SyR4eK/iZau6vR6Pj9b1ujq1I6ts82WvstIW9?=
 =?us-ascii?Q?zbOofbtX3aYUEzyKlWjQN3QbqUIJgAsyZu47j8Df9C9bk5/kyxSJNbF+cdlO?=
 =?us-ascii?Q?lZDLiIo2oCaHgHpAavs4vDKCinKVZpyt0unonC6hxD5KnqGrwfchEqle+aCb?=
 =?us-ascii?Q?Rceo7JOk10l5BDV0zuL5VRtzrbWrh+27L9gc4i0aXMAPQLZGZHg6jojfnv9/?=
 =?us-ascii?Q?Gmz9RpaZtJogdaFIldbR05CrwE9Mcs/yz3RTGOHtRtLA5W3y5ymZ1SQ0RL7D?=
 =?us-ascii?Q?MKEWZFQDRCz3Q5fo9glY5QmUO13gpNe0p5tNUAd5UARXo/2f6hCpBBjDa9tU?=
 =?us-ascii?Q?HFtLVWTi1vmLZqi+d7DJxqfHehaQ1HsfTibv5CFzwY6N5xwe6Lkl5pQQtmIC?=
 =?us-ascii?Q?TeKTxRN9A1532MSj9RsDf2tPHiFHnWkxJTKsl0nf3HokFPXPJ2S7WPbS0eHu?=
 =?us-ascii?Q?DSCJtlLfm6xmn657UR3uLr0jL7WPtx+hMNzN2ygWZ+2DKWKdQ0ft21cSwXJt?=
 =?us-ascii?Q?b1eF2Kvm9+yQgraqP4iQeVqZVjObFTIsrJj0RegNn7xXP4j52Ph7YE79F+Ti?=
 =?us-ascii?Q?kDg4oz3vv9hABb2TtNjUuLadRnF4Ev3mTfnKQBFdH8YRTEOXn0B7VtknnD2V?=
 =?us-ascii?Q?d4ZbOkVAaADiWdb/M7vC3j10lMazLcP2WUXgt1vC27GAWh6pZudfprsS4K7P?=
 =?us-ascii?Q?V08y5Znw0pvRKD/Ivtr7ZbbQeSU9UO9XaBqH+oGJlAHOrDES58+qFmuiNeFT?=
 =?us-ascii?Q?1WC6Pi2teEm+CsCYGA4SPHAtaBrjj4jC?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XFLvnNLewSd6sJNWUicskvr1c/vk3RjFvx2qjVdckdOLjb/PIK7PbMYfzVPj?=
 =?us-ascii?Q?rKdKeDLy9XFRL0VXKm/fwAi0kzUdDN0bQp4bSKc6Ef9XewzlWECUFtUzaPO/?=
 =?us-ascii?Q?mtodivj7JVY4vN6RfECkSVP+3BaSGLX6B8S3aa26CwjteA7nZQfZpMaivcXu?=
 =?us-ascii?Q?AitIEVWV4fAboUHcl1lBEJE1lk6gK2jzrkCewzmLYxnGl2n2YxlcbHjBeTg+?=
 =?us-ascii?Q?eVCpGzNP7HA6pjfBIq8k4wXIYppFUg3mztGW//bzB+KApnt8Zgf9nbgkUEfA?=
 =?us-ascii?Q?zOafpEam4Xkgiqjfkdk0mcP+hRal+uEDVsLiMi/ur36o0mPuAvvbt+PJ8EFh?=
 =?us-ascii?Q?dEzhBNHg7YggEqVFyyeScYpbxNS9L/uuFA7eGH6uXFKDeQ22Tk83dBjcoHHN?=
 =?us-ascii?Q?VsZ+CUNn53H1HayI9baRAUYYYp5tLvAruexuAaq3hH79tybZ9O3CkI6PQAga?=
 =?us-ascii?Q?XYSKIgS7HKhG9jmgEMNbcR7M9RjASQ0E7+qTtkuvL/RgGSG5gLjtMc5oefPl?=
 =?us-ascii?Q?JIa4whp6Sx3DrY8SHXvrw20qCGZOQzhd9INpC3XPtVjNY3Pcso8bIpT42UN8?=
 =?us-ascii?Q?iXSqAyN5nupEx9AY9UaM2FCpZYgbWaHMJwMcyfeb7U7pH2OXL8izFvV8xZ1L?=
 =?us-ascii?Q?koBOrKIgYOpdJbH0P6ADw0IfsuhCHr2wzZWBaxxGlsKuGp+JF4t9ADDBI1Le?=
 =?us-ascii?Q?J7iOy3ZhxGSriBEMYpBlCmVRO8hSiaOeIqArHuW1/kpPM4vNCGweReEAtRw+?=
 =?us-ascii?Q?rhRN1Bv5EKkcvNYyJwbsQdI7IN954U4jcD23/GemrqF4UV03bBzdPUko/b3I?=
 =?us-ascii?Q?vWGeAukxWL92jDDFdKNRcSOk8h99AuRBn2zMrqlj2YsxufdNGclkuxGuUOsT?=
 =?us-ascii?Q?VzAumMMmNY5KCBAiCZUqJwMfGVhpSOQjYkcecMdtecX4pDLRQhCYgTEa/yTE?=
 =?us-ascii?Q?Zr/RyS+aQJcjWAEyn8aSEquUBBSulyfGgQlisFvqF4qPllCNc0yDL1PDC7Qz?=
 =?us-ascii?Q?h8fKz3UbM13lgUeWYacs5Aivoi9+Z6E1Xm/I6TE//Kth1kOYBjcyU6D7IeoS?=
 =?us-ascii?Q?X4Qr/j7gWAtbcs6WSGThVYuyj1JIg8IPxb8J4cEvDFlPGaetGelf2qVyu7PY?=
 =?us-ascii?Q?7yf/LNYz2qoSB0q2TMVlXLa6g8AdnXjFGQKo9TEHZ3kv2RevpR0gWGvRMsQW?=
 =?us-ascii?Q?4ot6I9iG5hg896um3CXhQrY+L53P5BtB8sqMelHddbLwXuSe8eKT4AYpWs9v?=
 =?us-ascii?Q?//4GbtOH8Zzfp4A7kfc0RsNfnyYI+V3iwKTe0KWgKxEBW0GOU3eklmbvvEYq?=
 =?us-ascii?Q?tOlf6zho8zKIX8P8qb5uoRRKylLBitULx/mvVcAg37Kb1+bLvZU3o3iH/y2f?=
 =?us-ascii?Q?791JwANBJRDade2Eawm5IR4Fe0652ebvSiVEJ7uL8j1bj4J4gDreuqSAJB/P?=
 =?us-ascii?Q?vXjHYOFRK2tjSJl0MpvZTL98QY0axuDVAoLhKURoCzyMRGjT3Sc3jaYvTTaU?=
 =?us-ascii?Q?Pi/i4yTKUlPthlPerkMC/4DckfYY6OzzAJwDoyRJin2Mw9ZpoqfXF4JWO7EU?=
 =?us-ascii?Q?HVPTJJlCE6l5w7iJgAgM8CJZ2caFqV1iY+BOz/UpRLsSnjV5SMHJYNB4dO9V?=
 =?us-ascii?Q?+R2jQzJDXuYvll/ztSBaufw=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e1c4d6d-adac-4aa8-498d-08dd70415c81
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 10:46:58.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A4zDB1pz3gtLpWi/HUYXhTo/q5lJ59t/vrTwP/OtqT0jg/TGQAH/sT1McjVextATg2z13hG0TNGCmxMngfiwq+Yr29YI7ObUOt3aXMPzbyKSp4/Gzc5z/NNTxPdi9MEo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7PR01MB13744
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 31 Mar 2025 10:47:01 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18417

From: Kartik <kkartik@nvidia.com>

commit 7092e9b3bed1252c7d3f5812b9fb9d82375b73a6 upstream.

Introduce kmemdup_array() API to duplicate `n` number of elements
from a given array. This internally uses kmemdup to allocate and duplicate
the `src` array.

Signed-off-by: Kartik <kkartik@nvidia.com>
Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 include/linux/string.h |  1 +
 mm/util.c              | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 422606e98cc42..066203187c8d7 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -218,6 +218,7 @@ extern const char *kstrdup_const(const char *s, gfp_t g=
fp);
 extern char *kstrndup(const char *s, size_t len, gfp_t gfp);
 extern void *kmemdup(const void *src, size_t len, gfp_t gfp);
 extern char *kmemdup_nul(const char *s, size_t len, gfp_t gfp);
+extern void *kmemdup_array(const void *src, size_t element_size, size_t co=
unt, gfp_t gfp);
=20
 extern char **argv_split(gfp_t gfp, const char *str, int *argcp);
 extern void argv_free(char **argv);
diff --git a/mm/util.c b/mm/util.c
index d3a2877c176f9..770803ece7959 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -133,6 +133,23 @@ void *kmemdup(const void *src, size_t len, gfp_t gfp)
 }
 EXPORT_SYMBOL(kmemdup);
=20
+/**
+ * kmemdup_array - duplicate a given array.
+ *
+ * @src: array to duplicate.
+ * @element_size: size of each element of array.
+ * @count: number of elements to duplicate from array.
+ * @gfp: GFP mask to use.
+ *
+ * Return: duplicated array of @src or %NULL in case of error,
+ * result is physically contiguous. Use kfree() to free.
+ */
+void *kmemdup_array(const void *src, size_t element_size, size_t count, gf=
p_t gfp)
+{
+	return kmemdup(src, size_mul(element_size, count), gfp);
+}
+EXPORT_SYMBOL(kmemdup_array);
+
 /**
  * kmemdup_nul - Create a NUL-terminated string from unterminated data
  * @s: The data to stringify
--=20
2.43.0


