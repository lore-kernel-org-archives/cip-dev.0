Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3897AC35FF3
	for <webhook@archiver.kernel.org>; Thu, 13 Mar 2025 01:33:26 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.27])
 by mx.groups.io with SMTP id smtpd.web11.34879.1741778851938565966
 for <cip-dev@lists.cip-project.org>;
 Wed, 12 Mar 2025 04:27:32 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=EstOBtx/;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.27, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt1TVC9S9d0lLxsEoQSFpuWe08C3XW9LiyYwA6vEf+izDwXwaRjii1ZgINXLHq3p/vfrEi+4eJdyS9r04puhmir93TrXKDG5VPDRj5LZIzkF+G2gyxmTshPnpbch7zUfkRY1TKMiaEJ41bd9RA5mLjUdse72Jon9VNZBRspuLJLNyKjdrw2RRfbQMsKZiWySVeo5NGogqxJVt4TAMhK6Wub95gbY/PUTBGUIy0reFtRKLQkI6uf11rZ/bTsXz80OwNqZCENsN6TW03fl6HYX3pF26ZcyB5uIXl5x/qt1UPYDot7l2VINB1RMBcw0ykjZ5/fnrr8L8zm05aUTZcwvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+l+JVqxFMUoRzEMTZ6FsjqI3HnFZ3EvT3ZJw09QLFg=;
 b=cgf61cOty0+3n4xV7od6mM3sEc36UxVcHQlp90wkSl36A40OK7sMMUAQutU68hi8Vu+HT18RbtavlD4h5HJYhQv7/cANUe9K+PZSCmPeIZc6ipxZuYWRFJM+b0xxQz4S8VD+kMHwlYg+u4DUI5fUhLWQD8J+SPxGdTvdIMJtvG0hsuMCMfXOlvVWkYsGqDJox2+8DF95FdhKQh9L3LY0X6TpHdDxXkrO54J67w5z3HG/WT9lHeLuVacKvtZhyHRHZnRI2NQ8mB/h9KDl6hRBPGIV60KOGI1/W4keRJ7tkXVDuBnswG2jwcW5wNjbcc4VYTeSKZ7XIcsktmhASZzFSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h+l+JVqxFMUoRzEMTZ6FsjqI3HnFZ3EvT3ZJw09QLFg=;
 b=EstOBtx/idfY9pOYVvTbb6IJ939RS1xp89XkW7hE2OCXlC56bYVf8cj9nldOTEaVGb6m4Vzb4tLaeKzup+fp6FQMGUh4ZiQ7xZnldUYJ2MdOEZIWqyK6QkAeuwxDcYVIQuVDlJPyd95RAMGHZOU5WslWsWhAmeIzuBmplfeUIlE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com (2603:1096:604:35e::5)
 by OSCPR01MB14981.jpnprd01.prod.outlook.com (2603:1096:604:3ac::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 11:27:30 +0000
Received: from OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3]) by OS9PR01MB13950.jpnprd01.prod.outlook.com
 ([fe80::244d:8815:7064:a9f3%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 11:27:30 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 80/85] dt-bindings: i2c: renesas,riic: Document the R9A08G045 support
Date: Wed, 12 Mar 2025 12:22:57 +0100
Message-ID: <20250312112302.1605750-81-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
References: <20250312112302.1605750-1-tommaso.merciai.xr@bp.renesas.com>
X-ClientProxiedBy: FR4P281CA0246.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f5::15) To OS9PR01MB13950.jpnprd01.prod.outlook.com
 (2603:1096:604:35e::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS9PR01MB13950:EE_|OSCPR01MB14981:EE_
X-MS-Office365-Filtering-Correlation-Id: be0a5cef-51dc-44ec-4b7d-08dd6158dfe5
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?wIwqoCLZPBvFxYvaTNWGQtUKHWjoA06/AvYNiIq0WyHJfm2M8BX/ao/opXJr?=
 =?us-ascii?Q?xV1vtbRvTXDCmIL8THhxBIXyPuPhtLYnQCjEuvLzxhMpzKpv5b/CHPDGyKOD?=
 =?us-ascii?Q?OEjGQq51olwmKSST1NfZTkShVEP2rxdyzvCIYxHh+VD9WeHcpW+YpcCm1Fea?=
 =?us-ascii?Q?EoTNZ5dx9tmtPCMKJm5fX4ceLcvg4WkojIuxAR6biLCVWUOxq37fH83p8k6n?=
 =?us-ascii?Q?1M1biqaigRTfA17YgVev/x3s1VxngDwVnaOX5i2PAJ5vAE54yGYTre6Hf1xT?=
 =?us-ascii?Q?Zueaong8jxF8c2IIYHAwHER6PYHX15Ie6+jWj+wUyi0SQo/6tMz6HtoFUOJm?=
 =?us-ascii?Q?l9vGO6dbv1vI7Zy2C3XjX0TwmNs6SXLw4dAgE6Q3Et/h8xbx2ZD2t2TZrPEV?=
 =?us-ascii?Q?eYaS6N/OEG0b+PMV5aTY83Q7D3s/gQm43BJYMMK1Dtg/XmVI88I31Wtimp2G?=
 =?us-ascii?Q?VJtkrnqicifGfvBvMG2NoTKmt3ppxyvpUWJkjO2E4Y6LQF7xfxzwpV4OlVYI?=
 =?us-ascii?Q?DPugUcRrE50qSVMx3m5X9lyZ3rMdEalTtD67/XbWZHAMI8y3u+HGpGNOtgmo?=
 =?us-ascii?Q?e4lbCj0o2UC1lCDENIhcZS+glNPhl9j3yBUczxTNMdSERLawnjoGWJG4lput?=
 =?us-ascii?Q?tLvnH7MO9/8hHpL7N+DEJFpmVLGEJsjlGDOUh6KkqcMafeOmtSdbTNO37/kH?=
 =?us-ascii?Q?t3dkA243agUwdkQV5dRUz6eM7bvdkhKs1HoKOqv20OC+S1wdLT7uPp4xGNWz?=
 =?us-ascii?Q?6no0MfqboyzBxeljYit+v8FhR18FWU5V7V+HWw1ovj1IHFH1s8yV4DFaRrg7?=
 =?us-ascii?Q?dFnKOjdIyfNbuFg5j4mKXZ6nljQl6NTepOorr7PsTfbYo3Xwr83A5OHwknwk?=
 =?us-ascii?Q?6z7P4UpYfqM2os75gNYyHoWMHMDDmjoXoXmPjuqE4TWyoH2dQhpAbpU3V7ie?=
 =?us-ascii?Q?jhnV9CE47e3FcYi5pbkf1s+YWl7yOvjdyrCk0nTbych+0tBLEbhs+Sl9ek9/?=
 =?us-ascii?Q?48Mn1J2xySMrBJHwXC63BltYTIBm2IWO68vjBRzZOiAk56w2XblyXoaLKOcW?=
 =?us-ascii?Q?lMQ63/CtfJOV6a2CCwJgTiKhvXDyjyqM5SKPkp/HnbkAdiwFRbzGfOP4DXqj?=
 =?us-ascii?Q?yUH0a4un4CPKYgrwQrBQMj02K2qWyj+/HOBpwfxktwlG5Ms9aCijB+i0ATE8?=
 =?us-ascii?Q?Z4/JmOR6oNiyGh2cAvoqAtNF6RUHSXikI5nQEsgXvY7ql6VfuLMM6AD6hF0X?=
 =?us-ascii?Q?YBsqMS3HevAJU/8ZdAGlpggGEX1SrE+TkZxoGQW5HKFG5BUwBzbBIJuuy8Sn?=
 =?us-ascii?Q?ev+1W3tCmmnAKLfP/Qq3luPbD8JVizXGcFsWs2bd1f8PJ73WonXC1wNV90TB?=
 =?us-ascii?Q?V9xmLQ5mkaQI7oi4wwRAPNNdeJaaSa98m7eWNyRC91wHUZNeSDBMPzSVBvkZ?=
 =?us-ascii?Q?uq5W7JzxKzNsn5ea84XkG51AoOw+/m0O?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB13950.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?smR3mB/b+e50Hd+d2ZlwiGEH/abfnb/hqydNL/Bt7AsmvHd5YXRnd3UV0Nkz?=
 =?us-ascii?Q?ntbGLNmvU/bDwXyLJ6FVkmKjUny6ItwtpQMrs2IW7Dh5f1R8GneY2Svzb513?=
 =?us-ascii?Q?hQRdvZA+dsYGxUpqXt5X97Qcdw6HKvXKwysGnWDavACZCAjP5FtGudEB9B9W?=
 =?us-ascii?Q?ETDV3V2oF9asQ/haTnLIDkCi1qWNc12kb0Rgb7y/E0kPulSfUPl7b7so+K+G?=
 =?us-ascii?Q?g4+QTYcb5mL5uqGDPlgy5p0WVNJzhJMuJawjjvlHJ9b/4ZWBanVCtAJdl12A?=
 =?us-ascii?Q?gKBU30BElW8m0wxrIjS8HFtmKTuXqIQE3o+14ZAoZnH+2H4MlpemyA338iJr?=
 =?us-ascii?Q?zlvJQSOGZot1CGKpLkfyLJCzP7nBA/NIaAVOvg9XX8PSxdHHpIlkGcgnim5x?=
 =?us-ascii?Q?yTK0zAE8X3ZS9ir7IHm1A0QYl3XNOXcN/mZJEY8rtZ4wq7PeZeaV5qsGtlJz?=
 =?us-ascii?Q?R16hZrQX8Ubew3U5/H/xiV/2ySFAn2T34RsgSGTQrllHGwYe3wBBNRmOZdJt?=
 =?us-ascii?Q?3bZdnPdoqB6O+3A68/q+ZhAOU5Zmq9uQ02yeFOKNdP6iFXKz7oaA7Hff8Ht2?=
 =?us-ascii?Q?UrqRQHDBS/FO848qhiJWyDnCjnfuhE+saTz9E3psEFa0pj0kr9pLu5Z6IFle?=
 =?us-ascii?Q?BT/bmLeaG2pUXdNVUm0kzyeRHt55DRwM2OhH5YmzOKglxwX1q/AoMlD43+pD?=
 =?us-ascii?Q?ZH37HYa943C4VeyCzLbeqq7A2mQYEb+68jF5mGYGF3Ab3aIvstrg4Gaw/YDm?=
 =?us-ascii?Q?VHH8Ldg2eoKHFFpo6YYfkJivB2WrecGuGCD/mRO2KvOk0GJgGsfS3oeuKCZT?=
 =?us-ascii?Q?+HTHuB6KvKr8D60dOHJKCGzHjNkeSVotkCmdcOw4oeiB3AscvE07SPwTJjg1?=
 =?us-ascii?Q?HtLFCovCT60SA6UUfWjy5mfUyNxVajLv0U1GnEEja0owbxrY7ac+aRWEZdsp?=
 =?us-ascii?Q?bWbEE7su+MjjXQMH6sT1b2BAGTTogz7QOEzgBT9N6wPMHdGvgQrJ5PrkaU7P?=
 =?us-ascii?Q?grRUBAcFLdc/x2dUdFOUMRbsuHL8VkavH+pLPIdkPa3Y0mchDcIuAyFYdWG2?=
 =?us-ascii?Q?lpxo5xa/K6Sqb9vZ1zZepddP1cTEKFdydbYOFC1mWywflbNBX1RHBMv4sWPE?=
 =?us-ascii?Q?kiKoR/80y8osmRIJjcdEck403EUEfPYy1DTA/2OodVccmfMvYhmDk9CVlQqM?=
 =?us-ascii?Q?AOliPzhVJKSmIwy5MKvEaG9v6Rdn9Vk/OlivJU7yhM644TgZYzaBW82Mifnr?=
 =?us-ascii?Q?pumNVP3d/u+pDumOxmWpxQtgdUcToGCVvLrhp/7vOsszprfwh1sK9Wsy9ypy?=
 =?us-ascii?Q?4sJMDNtpMl32on5AUJwrjWQNH39sXMUb7Hn+gfZLYEG1p0aXUnofoIp59/G0?=
 =?us-ascii?Q?AUfo19I4Au9KX1iwUdywY5PWncM0hHd75fL6+t1Nkw4t4VAckN83yzDpYk1t?=
 =?us-ascii?Q?OHDNya5Cx6jGD1aYdLhZBxKba2zzcMvMR0irm/SfCm102f2gmG+dkl/I/bsC?=
 =?us-ascii?Q?te2DHA0/M5OBvt8gV6c4crOCJVcTHMBYW6gk0Z2jXm44vre9J6OrcBdTv5Qz?=
 =?us-ascii?Q?RWTa9bjD5xKI8ZvCOaQ9fy0azBd1nwvP+pVLgAhU2NHPtxWIA7ZmSb7BgZfe?=
 =?us-ascii?Q?Ozyzblk9EVuIGTXfnAlEmK4=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0a5cef-51dc-44ec-4b7d-08dd6158dfe5
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB13950.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:27:30.1528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FoykJnVGW+Q+L5uzgt8PUJkwtKUnsqr9plonqF481wdt7eezPoyOitE4KyMBWw4DEdcLIBZ+DlUxGUdEk/mNcjoPgyfs7/8YzfTHZ7zS+bSkt05vgU3ZDEZRekfJ2hYR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14981
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 13 Mar 2025 01:33:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18172

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

commit caad8883e4202c4ba002b9b1adc62e123f739394 upstream.

Document the Renesas RZ/G3S (R9A08G045) RIIC IP. This is compatible with
the version available on Renesas RZ/V2H (R9A09G075).

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
---
 Documentation/devicetree/bindings/i2c/renesas,riic.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml b/Docu=
mentation/devicetree/bindings/i2c/renesas,riic.yaml
index 91ecf17b7a81..60578c3ad4b9 100644
--- a/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
+++ b/Documentation/devicetree/bindings/i2c/renesas,riic.yaml
@@ -25,6 +25,10 @@ properties:
               - renesas,riic-r9a07g054  # RZ/V2L
           - const: renesas,riic-rz      # RZ/A or RZ/G2L
=20
+      - items:
+          - const: renesas,riic-r9a08g045   # RZ/G3S
+          - const: renesas,riic-r9a09g057   # RZ/V2H(P)
+
       - const: renesas,riic-r9a09g057   # RZ/V2H(P)
=20
   reg:
--=20
2.43.0


