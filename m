Return-Path: <prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31BFCAC599
	for <webhook@archiver.kernel.org>; Tue, 16 Sep 2025 08:38:52 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.56])
 by mx.groups.io with SMTP id smtpd.web10.14257.1758011927021072926
 for <cip-dev@lists.cip-project.org>;
 Tue, 16 Sep 2025 01:38:47 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bp.renesas.com header.s=selector1 header.b=UnE5TaEM;
 spf=pass (domain: bp.renesas.com, ip: 40.107.114.56, mailfrom: prabhakar.mahadev-lad.rj@bp.renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Giiyktjr/dQdlTU9i+dbnp/i73mSvkL/WHcgy9d7QpQNJXZ3G0CW8M+dt2/AEnzBaiCJFdBc4WKtO6r6WFOrDhsBb2UgHypie565+8OYZZ+xWnhWaU/B94ROm2Y13jjKYkahuygm60mEWlF++0wZXvWxYJcsbohKemXRcqMqEuC9pRDqIFsI7QH9ReyPN9mMKTzV5t3VitXWeR4stGGPB7kVZih8OGa4xJHjZ4d4TrJPBADrTt5iEGV4wApwGRCn9j0wXCNJNh1iGUcSHovaRszHIFykfN0UizSpn+NXbjYacg0PyxuluDJA4WjNjcgYL1kHqDRxhq5Lh4K7hFHYyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scza+NIJh6jX8RBzrxc0pi+Vrbgf6W6Ek0ps5M0M5q4=;
 b=SRdCfDhKXdtXQJBwLEFkC4Mj1D5oJgPKMWBSbsQgPjCWj+5wF5IN+/KFNgQfJyxu/ZGdEp5lZB6qDSrNnJEDSVPjtxGsGTYLWqg0yp09MCje1s/vAtknY6wjrqz00mputecAjYiKPObWj3PQ91RdieCT6KR/UUevHEjAbxThGX73cO+4ujlOrZ7qv7G5L9iMHMQkFuJ/x/iQLYys7jbo1nyoBRjAmHJGoFp0dk/DDqDrfKGqeYx4qpL/tCLguPsRzLZVGivS/0CiR1SYozBpG0q7ai7KmHyY7KDKCUZhs43aXxWHjCfwLH27hLsiAPN3uP/O069omuTX7n1SXy13uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scza+NIJh6jX8RBzrxc0pi+Vrbgf6W6Ek0ps5M0M5q4=;
 b=UnE5TaEM4U74SQaMUHDdFwbVRbNhDWClIe5v7Jrnm51Kud0iVX9ad3Eo9keqGH9T6qWz43HfPjYmGeZ4UfkvKrJ5P6OcrxmNOaKctBcnVVTIEHYX2O14u3+ScFPZwtnArdJFS6nzQ0u9mluOWW1DzSP5TNO43aZTae2y11rlNUQ=
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com (2603:1096:604:13c::8)
 by OS9PR01MB16471.jpnprd01.prod.outlook.com (2603:1096:604:406::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Tue, 16 Sep
 2025 08:38:42 +0000
Received: from OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10]) by OSZPR01MB7019.jpnprd01.prod.outlook.com
 ([fe80::8a27:ee0d:d7a4:9d10%6]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 08:38:38 +0000
From: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: "nobuhiro.iwamatsu.x90@mail.toshiba" <nobuhiro.iwamatsu.x90@mail.toshiba>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>, "uli@kernel.org" <uli@kernel.org>
CC: Biju Das <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Topic: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
 notify_hotplug_work
Thread-Index: AQHcEdpAOtOsp6RkJ0itXKZdfyV4dbRuCnQAgCU21bCAAdCp8IAAlKNA
Date: Tue, 16 Sep 2025 08:38:38 +0000
Message-ID: 
 <OSZPR01MB70193D6B3A50C083F99C2638AA14A@OSZPR01MB7019.jpnprd01.prod.outlook.com>
References: <20250820135622.27414-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <TY7PR01MB14818DA61316867E1E352884BCD3DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <OSZPR01MB7019FA6A5FF05E33976274BCAA0AA@OSZPR01MB7019.jpnprd01.prod.outlook.com>
 <TY7PR01MB148189622558F21F62EF509D6CD15A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <TY7PR01MB148189622558F21F62EF509D6CD15A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB7019:EE_|OS9PR01MB16471:EE_
x-ms-office365-filtering-correlation-id: cc7d0ea5-86bf-4cfd-5d83-08ddf4fc6ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?E7R1dM6ggvqwQS8DSYr5sPXo27TqnWEQD3xSJhykJexLV0wMJONBIIYNRy5N?=
 =?us-ascii?Q?Its2/gCVEnk5inC2Ee97xNxpJ79U/XjrNpPHmiNNYFgodrF3N9AmxZ81b6TO?=
 =?us-ascii?Q?Blr75Zsupa+2eLfwIibdxx60Oh2AUK0dToTjQSzVXBYsyW/Ms+k/ZyYA4o4N?=
 =?us-ascii?Q?FkfRhwQFzqfebpHP/3RA9OANNBpUz+8WxZYo7PjGfyQ8LX7zPpvKOJ1GvQhc?=
 =?us-ascii?Q?PT0d+nHH8ZyOXmibyTfloAImEt4/+6lpFJ5QNyjuc55wctSqBZWjsg+VXVLq?=
 =?us-ascii?Q?yesTcZujs+Dy7A8ldSKUKftvruToMwpPHTLbNZOTkyTgdS2tW3NPJCRsDk+P?=
 =?us-ascii?Q?mqaErWwLGcBMPMehf9P+cpanCZvUCPwbfe1hkwM1BMuHLW8RI0pmxMGscsAU?=
 =?us-ascii?Q?kW/BAPSO46MFM/nWUtTbxy/FcHSZh5JT5ZacGAtYNl0pM95Ihd574TAOLFlZ?=
 =?us-ascii?Q?iOp+PvTwYKs1DGh828qqAgGXd2dv9RQQ7DFWE+7Wg6FrQWlStHWvehJiC2vj?=
 =?us-ascii?Q?EgSUZgVRVhly54cq3QqZaKJktKo9+IVi/AEeNuDwbSplsoIBOZc0B/nEzIN6?=
 =?us-ascii?Q?9GZjtdrHgqpyEw5xvVbWhb0W4ZpnMvReT13NU1ikDXDlXp+YSGlgVVaEpABv?=
 =?us-ascii?Q?hAw8pvZqFq5BLYQlOBeSECWK/dwvK/RA+3JohVs8on8F/yY8BTpJKkIMxwUc?=
 =?us-ascii?Q?/EImFItUdF8xbV0IRmAMaxTgg4oNYMvQ97liRSU+UZkar/B3l8VoBU7vdXaJ?=
 =?us-ascii?Q?MqgfXc9j979YcJMA4TQQaoxFHWYokR0WdMf9TvGQ8WPh1sDqfQ5WEYinuKn9?=
 =?us-ascii?Q?uFyKDoZiZdlzqI3tQ592wBI7ECVPOyKs0nFxYNpDosOC4c9xYNGvrRuPXQNw?=
 =?us-ascii?Q?f0ckxl0YvPFGvTAUnc4mGFSJNzDEXWWXvAF1i3iZ9VWrahnZjbRpD+dfHD4p?=
 =?us-ascii?Q?OztmSChoIPMSflg1acqbRtV2b25Df+ifQ0q4pyFbHgCdrsBFFuWZ/AMJnT+5?=
 =?us-ascii?Q?oEWzHOOELA7uGgTrD9DAJofZx/fZMJsfQDqJ9q4kAZpQTvmZlQi8JEnkjMZr?=
 =?us-ascii?Q?DlYZR5KZUKoQFHsFvlIfgbLMjexYFLqKln0Q40guOgPV0r5eUn1eQkHDhsbt?=
 =?us-ascii?Q?pOMKhAsGMrCe4YrtIfF/F4ubAXK8xF+DLCsRFUQ3j85ScascnvSvhgw5PxYs?=
 =?us-ascii?Q?O+ZrbwoddvTM9MjitTK04pG3Xk0wf5Gu9SmvdRzlioxi1Cyct3C0MxHss0zC?=
 =?us-ascii?Q?geLi84wu3vihgFa1gc0rsRVYdlE23EKIKzspWyKeOBbZ+kXtxBeMKxfuA7Ji?=
 =?us-ascii?Q?UgI9lR/xdKIbvdbPwdNnJgUWz31NJRiGtVobWuFf6Ee1/sku3IqsngN4uup9?=
 =?us-ascii?Q?6FT6CnF2FIUkVnBY11UlQUQqdRPkLta/yDBHjBW9CE3hgf+RCa5fY+vo8XZp?=
 =?us-ascii?Q?Qo/lNlmTAaY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7019.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?7oSctUZesqz0PufJjA/5KXxUZW8xZNZwj5J0OItdFdp2lOmOXXycQw0oyrR5?=
 =?us-ascii?Q?YGwgVz/2mrrrNbecbr6xq4d3b9BJ9KuHBGL99iBLlsXcvea8LyvNFovRYcjz?=
 =?us-ascii?Q?zyzEqheFLhHMfFXFAEM/ZempHi1c9uzB331DdoTEmDadO6g6S6J30sFW0GoX?=
 =?us-ascii?Q?3TwzFEnTyW9HsvRG3ykKtSerd6Q8HQEL1dhYh+0UbEU8no3epQNiiMvxfAqB?=
 =?us-ascii?Q?wTavsW8pZ4rhqQoHDgn2bBb4FbzG8B0xq85ma8aRL9sVxBfWRv1Cam+BL0NF?=
 =?us-ascii?Q?CzT/l/YbLUCPiJdxjbJUKVJxoj1VZnnHqkeQGJpve4ek9dGgxWN4MQRIWDO0?=
 =?us-ascii?Q?ArDjmiyoTQfOMCLGv3Mw++5ZRjv35m27pXHboef4pj6GgAfjnNLGsGsz0UE2?=
 =?us-ascii?Q?qQjDZOdX2fchH24sjFsKNdVP/6NiYgKIHSra9OZmontP/H+pbLpxvHoU2Xjz?=
 =?us-ascii?Q?fcYvCWR7adxhfX5X8MuSuDABLMbbQMNvcyOMUGKEkAmavRVLlwCy86cr6n3g?=
 =?us-ascii?Q?pvSjEkyyR8ToOfANT4u8tdH12QqxqbnwVIKCXisnvK9MJUfMKv97q7g45Iwi?=
 =?us-ascii?Q?eIuIlVS06DbTQ2/zDfofV0lrJsmlOwTce258bNLRyXC2iyON1tCkReEF8YtM?=
 =?us-ascii?Q?SSwQJP24d4M+FYHaAThnxFlxYe/l1+wvwCyHeo/9b5d/+RyC2DzsLjxyd25d?=
 =?us-ascii?Q?fB4zutuUMnhw4FGOmkuhrAOBrwFF4qlNPRSO7vWJtPj+BHvmR/y/bsMkPgcw?=
 =?us-ascii?Q?78wB6EMGrUPq1oy3Ajb+2aoZ/+D3WUy9RGxBHQKri43RVQB0iKsc02fTbszX?=
 =?us-ascii?Q?jO7KsoH273boKeWD4fDnmLwRp2oj1Va4OYfuuBAeKQNVFkZwUWisLXxHhRBl?=
 =?us-ascii?Q?c+VUxP4elQcalF9P/KHe0fzYukJjB1TzykbQCB1tE3umDRRV+4yItMY+hfyJ?=
 =?us-ascii?Q?ncvMXFZvQV3RYu4vcgi44pnRAK98nrbcssUqyTPevQIzLgZAwPOVRQu9lyJH?=
 =?us-ascii?Q?EKXKgQqEMZz+bL2E48pG6sZNkMiWM6zC2IsFANkd8t79iqqgUTW99kBtMUfm?=
 =?us-ascii?Q?RDfXEJzLPvus/fSe6M9RrKLZY3D0GgrcjB590vhU2/BTaJKBrK0H2IwDUUGB?=
 =?us-ascii?Q?+f7TnlH1/rU1QbbK66CnDK9T2yD06/YSkGTxmurxnCi2r+K3cFlHn6NaVCH1?=
 =?us-ascii?Q?yDIP1z3Fzu4/FbDwbAlqJ5mrQRkMi3l9IUS16iSI103/lG+9n6OEtSmLBVwe?=
 =?us-ascii?Q?CairIOFKJfv0Qa7xsJSyK+MxxjQx1Mis49J6m6QY4fWhCxyjVqVj/yfKw/O2?=
 =?us-ascii?Q?dTxjGdMgZSP2sGxn3oafxBnnqMihFQqvlr6/xsukM/G2bYLOzKQTMzU/AO83?=
 =?us-ascii?Q?DPIim1dvqVUK+FrKNokifGKdGAQhw720ownyV5p9jdOQlEG/cl8xWhFMFpvh?=
 =?us-ascii?Q?uA0eJek1Oy3aG9qYWPTBLT4Yx0U8UJXdNK8VGZQePAHZIDiFsCUaIIWgDMLS?=
 =?us-ascii?Q?lRocl0kGV3jUXK08qEmyKEfl/9/PaKqHLTDYGsTnNVz6ur8UX1EmqWZmGNpz?=
 =?us-ascii?Q?Ag9fgBcUAMIt1FgLNyBlA7wnXeQjgmBAMqfVUbB5aF9oxye1oMGi7yo/2yuW?=
 =?us-ascii?Q?y8TGkaEVC6uQIz0bpa+H6Y0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7019.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7d0ea5-86bf-4cfd-5d83-08ddf4fc6ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:38:38.2877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CsnLKH85WNq2zJnJyAwCScARlXVObnH8m5qrW6S7By8pakvQCTL1nLjewzx6/rRODJBtCr3UewIHfbzzQ829oeB6KplGueWlB9Dk1ir4sXyeIUgcrn/lB2RIc6YZSZOG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB16471
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 16 Sep 2025 08:38:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20055

Hi Iwamatsu-san,

> Subject: RE: [PATCH 4.19.y-cip] usb: renesas_usbhs: Flush the
> notify_hotplug_work
>=20
> Hello,
>=20
> This patch has been applied -rc.
>   https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-
> cip.git/commit/?h=3Dlinux-4.19.y-st-
> rc&id=3Dac8dc358d156923de6193967988f0741aeda8995
>
Thank you for pointing that out.

Cheers,
Prabhakar

