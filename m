Return-Path: <tommaso.merciai.xr@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9637CA0EE4
	for <webhook@archiver.kernel.org>; Wed, 20 Aug 2025 16:04:53 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.37])
 by mx.groups.io with SMTP id smtpd.web11.863.1755705887237728655
 for <cip-dev@lists.cip-project.org>;
 Wed, 20 Aug 2025 09:04:48 -0700
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@bp.renesas.com header.s=selector1 header.b=H+X5P2v2;
 spf=pass (domain: bp.renesas.com, ip: 52.101.125.37, mailfrom: tommaso.merciai.xr@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vaYlw0BOB9GETxZJU0oQJFEO0YMqoQuuDdRK6vo/AAhViJ8bwxpctwOvkq6mQ+rJIGbwyYAKA+IKv62eTNhdlZ74otd9zi5M3aRTH7xOndLmVzTYfEckwR/RdU3JvUHqHMw6jvGFMU4WowlM/73Fby4tdrNCv87G6IPuXfyeyjPEy7cOnxH7JZxx90I2wrct3LFntqEM8hCtmrslgfMQwIpD0kk/8qimcjLzzzs8cjZO2Eu2Z3Thx4l3z0FvTNhPGUdhb5AY/Dsdcdc2viBEbDKVSdgWWf/92AdNtnmL7A2xavzNW2GuUiZ7e+/qvHdNUB0f9rMW/0R6pHg5b8PrhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wpxT0LqIrjfhQhJHXk/o0eB6aguwtAkCIhtCkL5JnGM=;
 b=WITdKETZDOGMR/luRhJXjbUmZ14L//7436MPnxief8UIpB2l12Q5jiiFyssU5LrqtL6Y/KdDsPSjB+PO8fc1ryXZm8gxq9L/KwXTLRXt2jFzeab3TQUmfzkecTIy2j0re6L3r2gqN5/J7ydrorsk6pkHFkD4EaykYzU/TKAOXPecAcIJLVrdUVdX4QXaCjeP7nvyb6f+itE7Igsmp3f5dYwldOFInIp2oWKYTPSMq6avQQCow/e3h+B4Q3gpEZywRsaA+Ns0elBF09qkbJSCS/yNMVod7/GOwm4J0uMdhPdpZcJrEfMVbQIeLl57gWj/PRyOQqbmv8qDICxigy/k1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wpxT0LqIrjfhQhJHXk/o0eB6aguwtAkCIhtCkL5JnGM=;
 b=H+X5P2v2yjPZ6W2eCbDuMC8zjUu4kclwpH6GCWig+wsGHcdNJYDmzmsZiUY/qScqSy19S9i1IiA/bQQBtEiv8gTe73OYw4oSPH2t5Ccuxotx9nBw1oaVway0u3qqgD/sie8ELDVNw1Hl/qwOQwDCUBZzQ+mGZAA1eLuQUL0wrX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by OS3PR01MB7078.jpnprd01.prod.outlook.com (2603:1096:604:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 16:04:41 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::63d8:fff3:8390:8d31%5]) with mapi id 15.20.9031.023; Wed, 20 Aug 2025
 16:04:41 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: cip-dev@lists.cip-project.org,
	Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Pavel Machek <pavel@denx.de>
CC: Biju Das <biju.das.jz@bp.renesas.com>,
	tomm.merciai@gmail.com
Subject: [PATCH 6.1.y-cip 00/55] Add support for CRU/CSI2 on Renesas RZ/G3E
Date: Wed, 20 Aug 2025 18:03:16 +0200
Message-ID: <20250820160413.801341-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR2P281CA0073.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::15) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|OS3PR01MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: 02881e99-f97c-4c41-b024-08dde003452e
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?K74eWSm+XUXn/ZdahyrdGiSzAh5IkM/u36DedS8nbndTo3dHsnRtLu7Wy5qk?=
 =?us-ascii?Q?+bs/TOY52FFr0cebs4qJl2obHMVQwxer9cGlZii6q9sqA9E8KvGp33S11xpn?=
 =?us-ascii?Q?YsXIaaCdXhxG/OBToU34xtwfFnAtJWYYqsgyaeX2vuLzI1t7F9sHZnWpM+5B?=
 =?us-ascii?Q?2mD8GJPS048iAWq+30pW8VULerFB6BUl/kbTtWdxS55MABHDbIZrr9mwpgho?=
 =?us-ascii?Q?CxM+yKJGZwFdVcE+fWrFTJaoZNZl2vUxmzy/MTHlVNNWLvI7boKPjuD3AFmv?=
 =?us-ascii?Q?dreqVSEaOdYnrSEQkYP2jmA0mCWhSH/0XzzJROC5dpOQvhjxaekWbL9xQbzT?=
 =?us-ascii?Q?drQrsDVQXwSB7SErB8FRfcIUUZ/SZNY8vXuFn7HpoBqKm/8puSBZDx9LlkNq?=
 =?us-ascii?Q?3yl+PMxaXti+cW2tRR8odQgvnpD1VJyQ6/cRrVqdjqkDUcIl+BmxZEbBAyRA?=
 =?us-ascii?Q?IfvVhBD4iTbIblgCBIjPvkTsoBRIYwUpw9HoClvrkfXD0uxivsKcY5QHtU1T?=
 =?us-ascii?Q?bEV/OxhQdS2av81lmty81gaVT74suiNm4y6pHBo1UZko1KozbHbM7juW9G2H?=
 =?us-ascii?Q?tl70SzCUoz7Pm1KqCN/WhwuZE54LLMCYRBUsx8hMiS2POVFoOuEbAM1xisaR?=
 =?us-ascii?Q?xqHTTgPCgSG5U2om4ZbgpjjuFfOQl28LkYHsu0pdNHv/RxDQcv2Gtb25dkSl?=
 =?us-ascii?Q?uv52wE98uJFJEm4Om1BXaahV8NiT6nriVwEAvgegmQtkUCcsyl0c9JtWp9Xu?=
 =?us-ascii?Q?lXo4X0tRBPRswmabEUGoSY0JQYBA+hgxknpvaKW2cwFeEQkowcOf4aNbpuZ+?=
 =?us-ascii?Q?v6ocUm/ipdaSFd14n0jWOcFSSuqFPs3YBVnINKT+Mne71HJTmo56Ir26s5Lf?=
 =?us-ascii?Q?x/eLt/+dbTH6nwN2gBj6B7LyaoYCEADDZWKeUrXgodBEEVo8Z0WLicI5MRzf?=
 =?us-ascii?Q?Yb8Vg6F6RTpyAiCoikY4h6OV+vShdBlmwTBiRzVIaNWfrUWPS6ehnpURQsYq?=
 =?us-ascii?Q?VICjwmEINGiwnNwXpgMpyvaFwFmdJRkhhRrlK24OiLA/2kB7czk+3ty9fmzU?=
 =?us-ascii?Q?gpTTYnKhgQXNoglkUnv47tR0C3gHMl86BN2JmLx3Bwm8IwjuCrjwDhMLVeOe?=
 =?us-ascii?Q?wxgit1yD6tLHfp8usCf40fQlNWZuANHV4Fj0LR13CiQpmEr3+An9M0i7UVoY?=
 =?us-ascii?Q?fffnClDVpdi8ptR/nG06EZHmlGiKyu8MRg40O1IMbls8tiSETGBlnUts0+H6?=
 =?us-ascii?Q?znhlVlHV02D57HJ/cosDHHupF9wKQcjhL6m7A42mr5vcV23WxAvvh1R26MDc?=
 =?us-ascii?Q?X2jh75Z78qjslMjYQXP21PdD6Rm7Wb7knvv1/lYY9/WG7S8liRn/o26u2Obf?=
 =?us-ascii?Q?yqzjJVnkmNx7iLlmoZ7fzZ90B+IX/plMQkh05oajI5Ti6BQ+u2fFYonc5pID?=
 =?us-ascii?Q?rPt+GGdfZN8EaX9pCyDFZNEQ8aztn16Woe6tCkGZbYMLyuWfEiB6Zdbh643s?=
 =?us-ascii?Q?hKdMh4aV51q71Es=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o3ONCy3sEF+fwIOBMhKaqzLVKJOhY2MZuCED4UiwdBOLojwGrXoszsiUb723?=
 =?us-ascii?Q?Oop+VHmIjoq4Gps2vXRD3dgveqnf2PofttN0HS039ZMRZMnckfNqMCMRQY/S?=
 =?us-ascii?Q?5/SMFhtoQJxyPTX2rZg7xSO4zv5TPcHBXaP86ZP1K0TFjSCO5mVj5vksx5uP?=
 =?us-ascii?Q?oh7Pi3gjgaN/HJdSy2PYyXRoodlqJTyCSfJS78NIXTFBd6oi83RZHmifakMV?=
 =?us-ascii?Q?K4uuq0T9940Uxd6LyQtDRcqS3gQcAclP+co+paKmBXZQKnTeY6mSOWxuemmC?=
 =?us-ascii?Q?7NDZsgGL72lcLoavwdSw2eAFx7+CVHvu8iyqavMeZL62t6XLqmewKuRwPv7Q?=
 =?us-ascii?Q?KskQ1AyTMG8HOf3zItP6b0uPJtTSlRgUvGVczuRpIuDRg/ywdDb6HI2nnil4?=
 =?us-ascii?Q?69/IOalPUvnoFkZxc9b5nj4ZJJxw0LGmoi/1kkRIluDZVEfjesHnlUTdy0Y7?=
 =?us-ascii?Q?n9aVY9q9n2FYAMw6sYZHx+qdz2ortMwR90zVHoyh1iW1EXl1vev/aBwMqvN4?=
 =?us-ascii?Q?PK/OH44QNOUBrKO0T9HvPrZIMRXWdnmyc9wAcHDgpv5AY4HwiKUO6uMuFMYp?=
 =?us-ascii?Q?6N5Fmi3fHWhwGm4kLtc+ll/RBSNAvd41caAeh254e+mS3uE/ymkSpau6aDrE?=
 =?us-ascii?Q?r7CZooo6rxTzcp3OgXrRXYOLCEPWBy1JfbASRPjNZ1AyXB+qnpjcfsF3FNjN?=
 =?us-ascii?Q?+JZfQO0B55pZ4jt2zU+zu4tlsUIORJ6+Q2Vn+QDaP1U4anGaun7Hb3rMMBeP?=
 =?us-ascii?Q?HJcEAj3NShcFadrmWjrrdFTy0D9GN4JZoJItPLFD3AVV3GvimhMVCMykJRBA?=
 =?us-ascii?Q?K7mRscQwP7+w9UvSf87/Uld03uJs0L9p+ccf4Mdv7aSkhxklyUGoVrdHoIj6?=
 =?us-ascii?Q?x9kOcq9kvktt8Edr83VLppfw5LTITG0AdvhXNOK7b59+ALIWCJ4HBqBahgYk?=
 =?us-ascii?Q?KcnB5Xh/ctQxFbHlvp//jMniajm1cJGSMlLvIZ3AdGl6py5U1XkQqS6b99B2?=
 =?us-ascii?Q?eSFiFP51M2QRVMNMNRB7+zSDbHlqvZspHCNtFxUqhvmcKboVC+ZRHKF2X1hx?=
 =?us-ascii?Q?6r6Qs9HSBylLhXAOZ93bpx4VrsXtuUcXivx2cf7pVMg/zgB9HRStyGE31a4i?=
 =?us-ascii?Q?YUiAE9v7LkFz490ZWPPmL6CYRK5Zrv9YkRDoJCMeIsVNtJhfwglvhRBRLyxs?=
 =?us-ascii?Q?zCXTsRD7BOeMDsEYN856YEyqL8QW8cdxC556+bc1D1TGswCKStLIUtVAEK0T?=
 =?us-ascii?Q?MNyi0b+jVjSFKz5JF7JS7okVZc5Qz4zz65rRPPPDZXyhLH7plzD10V4V0Bxk?=
 =?us-ascii?Q?cGN4+GIBDWUk81yu+X2T8TOpVhUCKh8fTrhKJR4frYflgCoBDCMEtj8ih3Tc?=
 =?us-ascii?Q?He5zYsfbYqcgKfHoRS7eOwZvhTxb1GBljnHPvLpCd9bANJtZozU1o0euETk7?=
 =?us-ascii?Q?bX+UmTs6s727XTKmZtGiVFHVSAU4SvQ13+hAq0FNR0hQ2h7vyi+THdfSIrT4?=
 =?us-ascii?Q?sV6eB7/UeotsGarWSEWORmFzs2wdhNWx/6jjDB4ENAFI+XvhyDj3yshj2lCx?=
 =?us-ascii?Q?oI1Cj/pwdPs+VUsm9EWJWvSL8bO0lg2FuE3fwkD1F01ZT7etwePIz09uEf+u?=
 =?us-ascii?Q?GJZQ6P8Jq/xzYwAEwP1usxE=3D?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02881e99-f97c-4c41-b024-08dde003452e
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 16:04:40.9769
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+uDoad9aNdUGvkGP7W/0qhp8zpGUi1jiVZ2YetvKLj97FUbI6qYqGn+28exmvULkHy/4nPQyObSL12QtH61twzD1MWvmjtZcsw2RpLnMlgvf+bR2gSA0VwbOt/EIwNp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7078
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 20 Aug 2025 16:04:53 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19825

Dear All,

This series adds support for the CRU/CSI2 IPs found in the Renesas RZ/G3E i=
n
Linux 6.1.y-cip. These IPs are similar to those found on the RZ/V2H(P).

In addition, it includes patches required to successfully run the v4l2-comp=
liance
tests against the OV5645 and the entire media pipeline.

This series has been tested on the following hardware setup:

OV5645 image sensor (Coral Camera) =E2=86=92 RZ/G3E CSI2 =E2=86=92 RZ/G3E C=
RU

The series applies on top of [1].

[1] https://patchwork.kernel.org/project/cip-dev/list/?series=3D993368&stat=
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

Lad Prabhakar (39):
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

Ricardo Ribalda (1):
  media: i2c: ov5645: Refactor ov5645_set_power_off()

Tommaso Merciai (11):
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
  media: i2c: ov5645: Set V4L2_SUBDEV_FL_HAS_EVENTS flag

 .../bindings/media/renesas,rzg2l-cru.yaml     |  65 +-
 .../bindings/media/renesas,rzg2l-csi2.yaml    |  62 +-
 arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  69 ++
 .../boot/dts/renesas/r9a09g047e57-smarc.dts   |  18 +
 .../boot/dts/renesas/renesas-smarc2.dtsi      |   6 +
 drivers/media/i2c/ov5645.c                    | 116 ++--
 .../platform/renesas/rzg2l-cru/rzg2l-core.c   | 151 ++++-
 .../renesas/rzg2l-cru/rzg2l-cru-regs.h        | 111 ++++
 .../platform/renesas/rzg2l-cru/rzg2l-cru.h    |  73 ++-
 .../platform/renesas/rzg2l-cru/rzg2l-csi2.c   | 202 +++++-
 .../platform/renesas/rzg2l-cru/rzg2l-ip.c     |  98 ++-
 .../platform/renesas/rzg2l-cru/rzg2l-video.c  | 612 ++++++++++++------
 drivers/media/v4l2-core/v4l2-subdev.c         |  22 +-
 13 files changed, 1223 insertions(+), 382 deletions(-)
 create mode 100644 drivers/media/platform/renesas/rzg2l-cru/rzg2l-cru-regs=
.h

--=20
2.43.0


