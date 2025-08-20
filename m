Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B00DCA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:08:34 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.52])
 by mx.groups.io with SMTP id smtpd.web11.1005.1755706106296778292
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:08:26 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=Ij78l2QC;
 spf=pass (domain: bp.renesas.com, ip: 52.101.229.52, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4HIm6ynEIGv7kjK+cQkAc7ymKhSgXLNG183OT76DQIxCOPYlLb7ZQ54vS6FkKVZ25OzTZMsefzKUtBEdPk2eKdqChdklPHSZmqaoCYm4t4eHySUrVpu15W7FmVk/uU/j3ssI3al99omoUm6wPhQbr/a0Yy8Eq2OA5sAiC5fgTd1QcbLycyovSBA6+mWDUBsfNl6Q6nWM8S4XH6G3UbKnodxg+A1NnM69Jl0s4vn/6cME9Dn+akYmcIPuhNaJn4hw0zvk2jMkEeRknxuCb+W0JuVYqI5VfA+ZTnVD7gdm8pcvNtaNi/Ijg+SZu2nwLs/g+kU4foUlvn33fMsP8pAKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CzIIbr1YKiTu0ZYeix8dcRQQPZV1Z74U0koVGTWOJOs=;
 b=aZsMHm9kplnSMpl69ovis2F5t6cUy+ABC7pbMzb3kD2xXhtNi/brLfx024iBe2disoLRRMFgZLprPAk73T3NDcRSoBkWmdAxawlUqOOd8HH/MbW4jcSIQRr7fuYIJnV+s9M3hp81sR436ikhaRiFzqPg2aNack0bbJh6RE0PyKftA45s3O/5/HUup3MDVjZ/bprnnxT9FfY1ZgV27bJSN/3skrbZ8BSFMDZUwekfuWALa1pDdOsBn5ElW872unZZWKN1CKdpQzF1S/MoJYMWaelhgRu8LISJ/6iSgSichO/HDXofR8LxO3CpufK3ksolBrcVrXB5A8dqFRvsvkPUNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CzIIbr1YKiTu0ZYeix8dcRQQPZV1Z74U0koVGTWOJOs=;
 b=Ij78l2QCMe7Mu+hjS9sgduPbhvlmWTJHzsNS7JI1qvDb0ajwk7eUEfsXucr+TN/hfRDs0NfuVtMD+ATadzFOGjPWeWH7YE39AvfgmCZBmM/miCAaczxwVZ+2NfToubPXCqzUe//psJDil+g5pVGajm6FN2IJZieETZ1u3+iMw4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TY3PR01MB12116.jpnprd01.prod.outlook.com (2603:1096:400:3da::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 16:08:24 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:08:24 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.12.y-cip 00/55] Add support for CRU/CSI2 on Renesas RZ/G3E
Date: Wed, 20 Aug 2025 18:07:01 +0200
Message-ID: <20250820160758.801813-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0122.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::11) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TY3PR01MB12116:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cc8f53b-61b4-4b0b-aae7-08dde003ca36
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?Zryxz8D/sIoQq8z4UzITBlGJ/AKwXsT8eIc0h4N39Yzhn6NZOxFrftz2Ursp?=
 =?us-ascii?Q?g2+rCryc2Y4Ijmht4GhUfnDF8T1ef/sFZUm2kLqaDrPZTZO9AD51tsoe56mm?=
 =?us-ascii?Q?6m79k2U26wPYHtN/pw5uQHKu7+uqoO43SpumlAgEXa7e4SkuGBdcVoNxPrM0?=
 =?us-ascii?Q?A3F26r2eO/CbDBDBct1x29vQWm5rnvs8sRaxYLlQaLwIUyvJZANiDia97aCF?=
 =?us-ascii?Q?43BJJpzntYIIh1kVGOJ0kHKrhETsrUiG+rUgcyamBWH8Fx5HFXODXZd5LWcd?=
 =?us-ascii?Q?qUUbBFlvMucJA+DAezVwUGSO9qVCrB8Hn7hQSbHxvR4gIAoKO1+N5tplDMrd?=
 =?us-ascii?Q?JQyAu3tciY3zd+Vl9rl8Q1ejG0GhIjn/ksIH1Cw7KQ7UO5J64wLYzrz/C40x?=
 =?us-ascii?Q?nsfRxcy7mNGAzgpqg2Gf5q1Bl72fl62LEApA7pr/bizKl/T7TrRPA3+emUGs?=
 =?us-ascii?Q?Y/P1+aUAWjCz0SI6cRKrpjKoImqwVGcB9H6XIzUhJybcGYBM1C7s4HI7iNsJ?=
 =?us-ascii?Q?jzGyFz6T95Mxa02eORN4WphN3nSTUy2bB/7SLTqDTLPjciUj+RTeqZIop9G1?=
 =?us-ascii?Q?Wm/fYQ1+/a6KVJRZJf5tDZ28uCaaG/6la7ghrvs7izJ5+o9aaNX8tdWqoUn0?=
 =?us-ascii?Q?LnKy240jHK9w0fhmuU1Me+t+Uut7V+4oCtQZum1ErVbk7Kl5Xikaib0fJ8LP?=
 =?us-ascii?Q?OjzaHNv5nRBdjwfdLnZ1mEIFcR7h9T6r2L12Ci95gTAuzL5+vUmrTGm7xfIy?=
 =?us-ascii?Q?V93zc9puL2RHZ1YWqmOAIEWxjOhHh+H7tiIGi1a+3ZBRIinWV/a9J2xDbGrW?=
 =?us-ascii?Q?epvCD42YfT+dc+mPLogMHTRWMmaof5G9P0SxfsR2MdktTdHXUQXGRfHk9yuB?=
 =?us-ascii?Q?0xA/gDgTbyP4N5HqVHqjRYl8XeJvG4Qeusf7d20CP4vfMGbPAAu2jKtF3Ctp?=
 =?us-ascii?Q?VAHOu8KTlDc3slpwjSyMrXYtzLbe8kpNZx+E2lA3XD9Uxny3Dq6Sgh9izMMF?=
 =?us-ascii?Q?l6Iqs479xKDFL+fNkj+dbzsSeQ6b3wG5hNfEn/Hap69ZkzX/NlCYrTS8qJTP?=
 =?us-ascii?Q?hHL9VLIPDNOhahnKDb6GXGQQRiXpXQg2V+Ick7Y1aPTzlPJmfQgSSNPIoLG3?=
 =?us-ascii?Q?8AGi+Vx/ArOvalN8Mt6ErZfTJbNYuxfapoTVsz3Bz76haVnS4FruuGrEy5aN?=
 =?us-ascii?Q?y3TKMQQEn7W5CL7svxQLYNrKMkgCZFTjrmT7s1X1mR0J50AcHqdxHBaFWJHn?=
 =?us-ascii?Q?ge9ImU5uA+TOb42Ehz2oMSrpMoZpzmizyOkTNAFiG4VMRig4o0Dr6zbE1rBD?=
 =?us-ascii?Q?Ue3IZTz8yAcKI/xY+EkhnJXIfuGzmXkR24aKZYcYaNV1yYsmpxXE4SXfmDae?=
 =?us-ascii?Q?tirOJxI45TDDTq8oPc5WEqi048uZnyd3RsDvzZzZukkuXiZSO/GNA2QEYPca?=
 =?us-ascii?Q?LHxqGuGKKQtE9YJlkinlyMCqewxPgadGy1hTesue1yoEFd0AqwpZ+rvh7qrm?=
 =?us-ascii?Q?hRq/LJfNK49x9u8=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?i7X9gJItxo7xzIGNy3E4wrf0TQoxjfm3q0+ADqgLoVe56ij+NLf/7XcepLMX?=
 =?us-ascii?Q?/w5vepbcS2KPzYlS3+RNoxROp/WqFICHSowPslY+8HQDdjc7Ar/UcfsrEvtx?=
 =?us-ascii?Q?cGm4NXKdO88e5Ln3yDmtYIm+1wxCR50QE2Ddt2/qtqQel/E95pTmo4FU1XnV?=
 =?us-ascii?Q?aSb/g2jzNDpHX/ciLk+akeXd1RHorqh5g3sJ0QS8MHASurGGLK3VAWwzl2i9?=
 =?us-ascii?Q?ANnpDbDUj8VdeHElRNWHYItia5g9+7bEjNHP6mEkZmmQRWNZVCrcyG6uzMmu?=
 =?us-ascii?Q?CH5xaqYzHz4zoGwH41LmQ5jYSsnZfARiZpY9qaWdSENeuUephwDnkp194MOs?=
 =?us-ascii?Q?VA2ZFQPgB7hPXC2Lq6aZLOIgtfCquaqrANx2FOASKeqTk09JOumwKBMKJ1J2?=
 =?us-ascii?Q?q3nJ5g8KOHKg9a2AiJAjY9HtZDc5VOPFHQDrI1z/2Ppy/jkhF/Z40jvHK1IJ?=
 =?us-ascii?Q?AQVvR5C3XYXFNuE6jX6i6+7iR7BbVbuYPTZbfjnKVFuuN3a/KbTqvao4mTT4?=
 =?us-ascii?Q?2X2gLYkoIPFYvAsjNPLHBMfZ5+MOnKHvPKK9wZ9J0PMd9EocuxfFV8u8LTqa?=
 =?us-ascii?Q?OEgfVXWK/xwdM175jPUxOTBROA3uNJQr5P9sv5DKhyE5SgR0XIm4fZ4HdYiV?=
 =?us-ascii?Q?vG+f/LCKz26YzUBVd8XJZt3RWHwtTS1i/ELTX9o1+AfGKGCDCTvFDxUDQh8m?=
 =?us-ascii?Q?Bss2udg7y1aQB9DX9VjYL6syN+3T8DY0lDssWK5uc+qDwziAlIGfC+uEz5WR?=
 =?us-ascii?Q?K0JP4CGL0oVjrdivy2cvQDV1B9vXe62hsFF+aLrs4LC4cl9NAb/TItNSNSI3?=
 =?us-ascii?Q?7oeNpBTuhV+HF1Jo9XPEPB5fGF+jitAV5+gb7rdC2mSTErikPtz+gOjfrEBH?=
 =?us-ascii?Q?Xxbizn5DqXcxaMBBI+Vr/nDXq2O1T6d6FM7dVgx4ZETye9VNH/D2aTxefLR3?=
 =?us-ascii?Q?IcZiSwcNmfdZdgUvK0JEWKmLq/Peupk41PE0dTIWMcC2bQ5mIk0oV/oiRRD7?=
 =?us-ascii?Q?DzXc5pl+1qsM9Up5SHXpJejX7mZcHDmF+xsOYxwhC+CMISdFB4JkA4vu5+3j?=
 =?us-ascii?Q?nMxI2qMlb1ynEtSVy8CS2A/ShROiXEju4HStNcB6rCbqLGziHbQM6m/mhAGK?=
 =?us-ascii?Q?jHxH5rWCqEFJ9dffdn49OlhrArzko3MQEUNJzgET/huOYbew3jHR7r1xHvPw?=
 =?us-ascii?Q?DLjJt2fvCS3WNxAVYTXTKWw6q57f9Al4kOJiq+FnWzhOv3m2AXDvCq2wZoah?=
 =?us-ascii?Q?D7BpwUjQ8yT3o3U1beu5WBe43EC1mKoTUtpT4K6dawcRqTt2vnl+ZfTEKriu?=
 =?us-ascii?Q?a9X1PvVXlxdZ4QaYGxfjKH7zEN6K5P/VXjFvtUxe4r4Rzc07/LSEcKDC99tq?=
 =?us-ascii?Q?Lj5wN40bQNRzKp7NVU8ZU0sZ61h5HFDQK2q+ENH5G1hpxgFajLuXYFBOXT8i?=
 =?us-ascii?Q?McZIBlPv/YLYmjQcuI7uZNNnb00BJiLN2a36HuPzFlQQuGzrwhhnpEAwYsqZ?=
 =?us-ascii?Q?UqBIJ5LPXBNss10yLWvVbI4zssW/3b6DOycMP7AqjZWlkXBFQKHdk4HNTX22?=
 =?us-ascii?Q?2spkwNFMqoh+wQzdUphFsO19CTynox4fvOkdH7qyqR++SY/ryO8bkfASjdeH?=
 =?us-ascii?Q?6g6IQedXz/t6jvs0GICUgXE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc8f53b-61b4-4b0b-aae7-08dde003ca36
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:08:24.1584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBLuDrh5dyei0Aqb/P2m+7heTxJXLPokRykh4H061kzkwBLntR+3YWkRu8D1RLLAl9V64fd1Zk7oESN/pXZWwACJGFiWLVvlX5GExLZWTJdLesuSy/LlmDH8bi2bmapn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB12116
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:08:34 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19881

Dear All,

This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G3E i=
n
Linux 6.12.y-cip. These IPs are similar to those found on the RZ/V2H(P).

In addition, it includes patches required to successfully run the v4l2-comp=
liance
tests against the OV5645 and the entire media pipeline.

This series has been tested on the following hardware setup:

OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G3E C=
RU

The series applies on top of [1].

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D993372&stat=
e=3D%2A&archive=3Dboth

Thanks & Regards,
Tommaso

Biju Das (3):
  media: platform: rzg2l-cru: rzg2l-video: Move request_irq() to probe()
  media: platform: rzg2l-cru: rzg2l-video: Set AXI burst max length
  media: platform: rzg2l-cru: rzg2l-video: Fix the comment in
    rzg2l_cru_start_streaming_vq()

Daniel Scally (1):
  media: rzg2l-cru: Add vidioc_enum_framesizes()

Lad Prabhakar (41):
  media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/V2H(P) SoC
  media: rzg2l-cru: Use RZG2L_CRU_IP_SINK/SOURCE enum entries
  media: rzg2l-cru: Mark sink and source pad with MUST_CONNECT flag
  media: rzg2l-cru: csi2: Mark sink and source pad with MUST_CONNECT
    flag
  media: rzg2l-cru: csi2: Use ARRAY_SIZE() in media_entity_pads_init()
  media: rzg2l-cru: csi2: Implement .get_frame_desc()
  media: rzg2l-cru: Retrieve virtual channel information
  media: rzg2l-cru: Remove `channel` member from `struct rzg2l_cru_csi`
  media: rzg2l-cru: Use MIPI CSI-2 data types for ICnMC_INF definitions
  media: rzg2l-cru: Remove unused fields from rzg2l_cru_ip_format struct
  media: rzg2l-cru: Remove unnecessary WARN_ON check in format func
  media: rzg2l-cru: Simplify configuring input format for image
    processing
  media: rzg2l-cru: Inline calculating image size
  media: rzg2l-cru: Simplify handling of supported formats
  media: rzg2l-cru: Inline calculating bytesperline
  media: rzg2l-cru: Make use of v4l2_format_info() helpers
  media: rzg2l-cru: Use `rzg2l_cru_ip_formats` array in enum_frame_size
  media: rzg2l-cru: csi2: Remove unused field from rzg2l_csi2_format
  media: rzg2l-cru: video: Implement .link_validate() callback
  media: rzg2l-cru: csi2: Use rzg2l_csi2_formats array in
    enum_frame_size
  media: rzg2l-cru: Refactor ICnDMR register configuration
  media: rzg2l-cru: Add support to capture 8bit raw sRGB
  media: rzg2l-cru: Move register definitions to a separate file
  media: renesas: rzg2l-cru: Add 'yuv' flag to IP format structure
  media: rzg2l-cru: csi2: Use local variable for struct device in
    rzg2l_csi2_probe()
  media: rzg2l-cru: rzg2l-core: Use local variable for struct device in
    rzg2l_cru_probe()
  media: rzg2l-cru: csi2: Introduce SoC-specific D-PHY handling
  media: rzg2l-cru: csi2: Add support for RZ/V2H(P) SoC
  media: rzg2l-cru: Add register mapping support
  media: rzg2l-cru: Pass resolution limits via OF data
  media: rzg2l-cru: Add image_conv offset to OF data
  media: rzg2l-cru: Add IRQ handler to OF data
  media: rzg2l-cru: Add function pointer to check if FIFO is empty
  media: rzg2l-cru: Add function pointer to configure CSI
  media: rzg2l-cru: Add support for RZ/G3E SoC
  media: i2c: ov5645: Use local `dev` pointer for subdev device
    assignment
  media: i2c: ov5645: Replace dev_err with dev_err_probe in probe
    function
  media: i2c: ov5645: Use v4l2_async_register_subdev_sensor()
  media: i2c: ov5645: Drop `power_lock` mutex
  media: i2c: ov5645: Use subdev active state
  media: i2c: ov5645: Switch to {enable,disable}_streams

Tommaso Merciai (10):
  media: dt-bindings: renesas,rzg2l-csi2: Document Renesas RZ/G3E CSI-2
    block
  media: dt-bindings: renesas,rzg2l-cru: Document Renesas RZ/G3E SoC
  media: rzg2l-cru: csi2: Use devm_pm_runtime_enable()
  media: rzg2l-cru: rzg2l-core: Use devm_pm_runtime_enable()
  media: rzg2l-cru: csi2: Skip system clock for RZ/V2H(P) SoC
  arm64: dts: renesas: r9a09g047: Add CRU, CSI2 nodes
  arm64: dts: renesas: r9a09g047e57-smarc: Add I2C0 pincontrol
  arm64: dts: renesas: renesas-smarc2: Enable I2C0 node
  arm64: dts: renesas: r9a09g047e57-smarc: Enable CRU, CSI support
  media: v4l2-subdev: Refactor events

 .../bindings/media/renesas,rzg2l-cru.yaml     |  65 +-
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  62 +-
 arch/arm64/boot/dts/renesas/Makefile          |   3 +
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++
 .../r9a09g047e57-smarc-cru-csi-ov5645.dtso    |  21 +
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  10 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   6 +
 drivers/media/i2c/ov5645.c                    | 278 ++++----
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 151 ++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 111 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  73 ++-
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 204 +++++-
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  98 ++-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 612 ++++++++++++------
 drivers/media/v4l2-core/v4l2-subdev.c         |  22 +-
 15 files changed, 1301 insertions(+), 484 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a09g047e57-smarc-cru-csi-=
ov5645.dtso
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs=
.h

--=20
2.43.0


