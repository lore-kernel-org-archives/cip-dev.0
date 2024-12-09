Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 404A3E77173
	for <webhook@archiver.kernel.org>; Mon,  9 Dec 2024 06:14:00 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.94838.1733724829868248977
 for <cip-dev@lists.cip-project.org>;
 Sun, 08 Dec 2024 22:13:50 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=p0VffVke;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733724824;x=1734934424;bh=ItOvRPO3P3cDMYPku8Qf5xvuwvk6act77pXXHb2
	ldb4=;b=p0VffVkeJn+24BBF2s/qvWLNktgb3tlFMUPwpykEyZLB9bSj5MMcZdw1ycw4ziAbG27qC
	Vja6DDqXx8qtk7mvitAKakRICdnVQGtSNfg30e2qUC9me3o6VxJ1JfUNUkw1Fi/W5m9z+HCmDjU2g
	wUF880/dDPjpjVc5XslsiG+frVMvJAKZza25URLCKABZ7zqWHZxBeZ+gfYMxvdcwyQL4ZK6Vh4ZWU
	K04osVyrDBjIN2BnjoLnGvSjRTJ2v6lC9ehyKupqNFQhFCTwBF3/xlX4QjPYD8pdM0V6eR7qiJiIb
	XHnCluOGHnriNRICv9BrIbRw2mttznvnO5MSum79Jg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 4B96Difq526915; Mon, 9 Dec 2024 15:13:44 +0900
X-Iguazu-Qid: 2yAbaKzOe6iLQR2AY7
X-Iguazu-QSIG: v=2; s=0; t=1733724823; q=2yAbaKzOe6iLQR2AY7; m=UHBIXhT4Uc9KT7k25UHM7HA9nLTv+E4PzmnaGreExS4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 4B96Dh0T2231902
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 9 Dec 2024 15:13:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfPr2licyBnT4SG0mDaJ89KAAiMiWQpTpzac33CXX2WnMKzilNDEhk0CatzYhycI7/wm15y1i8LqrvLeh3MSndVHdoB5BgjBNBW3UL+n1oWueoUHytdtotzXk+6H7prNEw2SvbQ+zg6UDt7wk43+VGRxTIOFiCqnFreKdO8Ceoik4DZ9fJ4pvFbcHirvESE3d02sQ29Gv3HQ/lA1qi9+LUvSJ6mNEeuxjqp7Lpv5JhkVVDIkzrgWrQGJnzXtISUEqxjYIaF8GRzWbrpxxCw1ROlthkqSP0HasuxaI9qjgT8W57rMHei7QmhVhNtQnKlr5r2H6tI2CrLGmc2EkVHd9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjOUx84KcVFaw7vpho3mJ8B5LhrrEYeE9EOQOZLiQL0=;
 b=WWXmlK3nzJ9H2VyOzWy9A4nni3FmN3sX0MhOWpWdfdseO0WiNq+MhhPusLxkBwThDFkm3qELtHEJwDEe89ikYAQqv9JUtyMi9OVJwBC3msjiQDV/UL60+bvGU+fbqnuKyI/y+IM865gKSrnfDGjb54l/HWQL8ghFLUXxpw04+42PTSKWatlYA6QoyDDFwg/yM22cFde0TpfgavWddn4RK/F5LRAL5No0rS8AzD9IUpirVAlH0HwHmmgj1pXfAuwn0ya20XWJA64bgMZSH/J63M1ZJmFk2BBaRzAMuUxyaKRisMLY7NFl1OzWdSUTqb/ROv37zDHXHTua7gFCPTCyaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Thread-Topic: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Thread-Index: AQHbR74HYoIJ6LXlFkaK1HJNJ376NrLdc08A
Date: Mon, 9 Dec 2024 06:13:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388A745B37F08A131FD6DD5923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYVPR01MB10668:EE_
x-ms-office365-filtering-correlation-id: e806acc4-cd49-4396-1864-08dd1818a098
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|366016|376014|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SG05cElIQ2JGUjNVcXR4K1ZabzlJMkFqT2pic0tmNkdtMXA1WDZES0Y3?=
 =?iso-2022-jp?B?YlFySlR5ZE9IUTRjU1FlUjRaSVdCYkVCd0N2Nm1Od3hsRjh4Y3VvRHMz?=
 =?iso-2022-jp?B?QXYxcXg5bm5FT0VQRVhYSHVNc1NqZFZvc0VvRGtnRlVoMnNheUljZnl3?=
 =?iso-2022-jp?B?dGNobmVuS1J3bjc4SHp2Vi8zb0pXb21CR2JPQnh0eitSQ0FMNFltV1J4?=
 =?iso-2022-jp?B?cDVzanJnMTZvVVpRQzI5cWp6V3RIS1RaVktXZUtZR1pZMmt3SU5XQzQy?=
 =?iso-2022-jp?B?K2h4RHVScTF1cWIxMnlFbG44MllYeHMycENUM1VrWHIvTW1mQVZmdTJG?=
 =?iso-2022-jp?B?WEhPSDFWdjQ2VUExZDd3c3pjbGpkWHA5UWNxR05LL0lIUWYveEpXYTRl?=
 =?iso-2022-jp?B?OG9jQlpsTVFYalh2Ykcxc1hMOXE0VmViVEN5bU9oYzVMTCt6dUN4R1c2?=
 =?iso-2022-jp?B?dHp1NU0raTg1VXZPZVFPYTUvVDFDLy95amIvYmVYcTZ6YmtLaGtMU3ZP?=
 =?iso-2022-jp?B?N1dHa1dBLzF4VU5ob1JhU3lTTnYwMXZndnptdXhlV2Q3blZwRS81U3d6?=
 =?iso-2022-jp?B?S3VodFM5eEJzZ0E2QzlTUVNQYWVjRmRGZUZaenRmZWFmOXNKcXpZaHpL?=
 =?iso-2022-jp?B?SUFZNWlPVU9TZkxMeW5VVDB5QzVOTlc0QXFwUFJ6UDhoWjBLTTF6VnNZ?=
 =?iso-2022-jp?B?TENpa3lLR04yMS85bi9SRjRSMXNScGcwR3dxV29TYWt1K0VDd21za25C?=
 =?iso-2022-jp?B?Q3lMQS9wV0IyRk1WR2JVRUIzaWgxc1FKTmlVZFRzTS9kWk9vNGgzbEt0?=
 =?iso-2022-jp?B?eC8rVEJ2L1FpZU5nOU1NVXdVRmNMMk9mRWIwNklDVW9KVVNHZ1IzaVlm?=
 =?iso-2022-jp?B?WnRaSkloY3RuNDBLWkpWRE96SGNkbE9IZnVOMTJxbGZpNGE4WEpuZllj?=
 =?iso-2022-jp?B?ZFd3MFNtS0NLcmdMaUFDQkNsVy82TW8xK0l4c05mRUpRY083clFZZGJ6?=
 =?iso-2022-jp?B?VjdmMjlucm5EOS9SVUw4L0hKczQ0bUNiS1Yyc1psWk43OUNSaWx6dlpk?=
 =?iso-2022-jp?B?MUVSVTllNG9jUFYwelB2ZFNKUnlYM0hXZmJQK0N4eFVlUks4SGJTUVFz?=
 =?iso-2022-jp?B?dW1nQmpjQSs1Ky9hQXBGTlZGMXdtekNhaDFGc3hldkVJZk4yK0kwMFo0?=
 =?iso-2022-jp?B?M0ZvWjYyQ3NnQkIvdzVvNHU0RHVicWgyMFI3Um5IQnVHcElNd29nYUJT?=
 =?iso-2022-jp?B?dHVRYkYvU2JObC9tYWlZRCtRUmxod29DMlFPcjJDZUMrQVFBR09UUGNB?=
 =?iso-2022-jp?B?c3RBSW9aNmZWMkJTcFViQnpIUGVNN0FodHM1TWcrbFI5OWFxTStDOVJs?=
 =?iso-2022-jp?B?T0F2L0xva0dVZ2JnZmZWUGNsYXA3K0VmbEhxaVg0T0ZIbytZYVZEYXhD?=
 =?iso-2022-jp?B?dDZOdEFhR0d6U0huU0lhd2syU1A0ZXNWL2VYM3JQZktnVzBZN2o1Syt2?=
 =?iso-2022-jp?B?b25jdVMwSmdQcFlyYk8vYjdRN01TVktGcXZJSFhuY0xyNUR3bHVRVHpx?=
 =?iso-2022-jp?B?aVBLRWpTMG5FZkFwRmE5c3Nad05IdEFELy9qMjJsdC95ekp1bmJmS0xT?=
 =?iso-2022-jp?B?bGdLZDBmcGc1dzlPY2R1My9HY09tUWNZOUEvNDVzUXQ2Q0FsOXIvbnBD?=
 =?iso-2022-jp?B?UWRZaTI3dWV5V0V0anU5dlFQZlVUUWpzODRVbjBsRUxFN0JXZ1pFenc0?=
 =?iso-2022-jp?B?YlUwNWlGME5VSGhYa1o5VW9zajg2SEZnemd1YWNkdzNYRW5Dak1OMEFr?=
 =?iso-2022-jp?B?T01pV2tnajhqTVUvS3ZPVU1MUGVIeHJtTE1VSEtZd21DMytucDNaZnlE?=
 =?iso-2022-jp?B?RXhHbGhoZy9IODRFL2F6TWo5cEpDaXpUNUVsbDZaNndSeThDNWhDcW96?=
 =?iso-2022-jp?B?ZVUydVR4WGxUWUlORjFzVHc1Zk1YOHQ0SFkxQkNCb3h6TDJKMEJPc3Y3?=
 =?iso-2022-jp?B?M3RyL2c3VWhUaHlKYk5TTEJHcnJFSVl6OEU3N1JOT3dKNDZjRm8xSkxV?=
 =?iso-2022-jp?B?U3Q3b2tQV2JMZXEwMThpeHdhODRVMGs9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Yjg4VHd6Nmt5YjdZQ3BWZy9jL3RZaEI4K0FpMkNkZUdyTm1pQXcxNm91?=
 =?iso-2022-jp?B?NjJrb0VjQzc1bThWSWZaeGd1ZU1CM3JJUnliaFhiUE5wSUFhbDJ2cEt6?=
 =?iso-2022-jp?B?bkVldHkrTHAzcHN3YzdDUEVFS29HM3AvK3NkbFQ0anRXMWFnSlpSNzZM?=
 =?iso-2022-jp?B?UGVnczRiSUlFV2dKaU1hVnJ5dDAxZExCRFNiVUl6TjU0UXFsaHlQdzlJ?=
 =?iso-2022-jp?B?UE5HMW9VQXE2Z3hjWXRoTXZ6MzQ2T0VDNUJIRFFQQlFIZ0ExVlRGVVFW?=
 =?iso-2022-jp?B?MStiWE1tQXlQM2JWdnppaEV6K3ZxeUg0RjJwTWl4U0xJZ0dQWnNpME1i?=
 =?iso-2022-jp?B?czBjeS9lOGRlbGxuR3Z4a0kwdGdnYk5sZUcvUC9WTk1uTVFEY0lBVytE?=
 =?iso-2022-jp?B?dFNOc1l5RWFVc2MydWV1ZmhtQjJsNW8rRm1hcmlUem80SGVjYjVkbFNw?=
 =?iso-2022-jp?B?cU5zMDlHZVp2K1Z6SGdSUzQyLzNZeUpLcmk3czZFWHpxd0VRYWR4a2pG?=
 =?iso-2022-jp?B?VDFkQTZvTGtEazlZM0ZjWXc5eEs4dllWMUF2ODdhZUVqWHdaQmVGSXF5?=
 =?iso-2022-jp?B?MG9yWGRjQ1VveUMrTzJMVHdmWWJuWEZvcmJtd1NrcGE5RVFRdHJUYlQr?=
 =?iso-2022-jp?B?UGUxelUrZGtxejUzWm1zSUNIakk4bitmWUx0R3VzV1JpSkJOZFVyaWpT?=
 =?iso-2022-jp?B?UjZsenROMkQ5alVyOVMzcnE2dXRhVEV3Yks5cEErRjk3YTk2VnhtL2w5?=
 =?iso-2022-jp?B?UVVkQit0U0NvamlYZEg2QlR0ak5GL2I0L3VUM1NFaG9LbWxWdUxoL2Zi?=
 =?iso-2022-jp?B?TXF6MDBpYjdHSFNUc21wNDdFaURDczJTWG5nM3F4SkoyRlVzaGRuVkJ3?=
 =?iso-2022-jp?B?UnBydHEvS2k5YXdEUUJrMkE0UThQVjJvVUVLSmI5S3QyTnFoUE5ZUElr?=
 =?iso-2022-jp?B?SVNOaExBTEU3RGthNmZMM0tPQjc4RTF3ZStvc1JqU0RyaElkT0NDMVUx?=
 =?iso-2022-jp?B?Vi9pakVkU3d5K1ZyL09vb1dvSEE5UkNJVzNWWjFPNDlaeHppWi9YNzMw?=
 =?iso-2022-jp?B?bWM2Ym5BMzlKTUNVWjV6anhKbktCcm0vNlFBdUJyK1lPSkhaUk9tc2xl?=
 =?iso-2022-jp?B?VkMxZmVUSDhoRytCeFdtNFpPdkhMc2N4dUpSa3JjN055Y3NSU0RxQmFw?=
 =?iso-2022-jp?B?aDZvSzZQTFppSmZMaUtYL1F1YnVTTWl5MG1qOEg2RzJCLzdaY1VEUDRE?=
 =?iso-2022-jp?B?YnVYdDBTMlRsYk9VMDRGWG5qTXU0UnNNdDQyamVaRjBjV0Uva3hvMFhI?=
 =?iso-2022-jp?B?djExSHd3Q05ZTDdxWXc1M3RORWhWbXl5Zm4zdVpxK1hKd3F1ZHBlbUU4?=
 =?iso-2022-jp?B?NVJ2QURNd0NIeGVLTUZSZHRidnljSFRJMytJMGl6K2dBV1VuaWwyZUcw?=
 =?iso-2022-jp?B?NDVpUDJ3N2ZOaTFNR3RsWHp0aU15QmJKL0U1M1l3TC9rRXdzU0ROWVph?=
 =?iso-2022-jp?B?aC8vN293Z2plbFU1eHZmV294QnFGaW5uQ0Z1ZTBiOXZWRzRSblVzYWFW?=
 =?iso-2022-jp?B?Zk1yWVJQcmIyWFBhRll0RHdMTko5REYyRTdEWlN2c0ZvMUVyUzdNMXZJ?=
 =?iso-2022-jp?B?MU1ESEw1TjdsMVFFWCtrNCtlZm80a3hKTUhIUHp4aGlKd2J5aGNSU0dY?=
 =?iso-2022-jp?B?TUNuR2tZVzRlUlNzRG9KQ3NSRTI5UElGUkh3bUVkN3kyQXp0YUs5bG5h?=
 =?iso-2022-jp?B?K2VUQkJWRlM1a1Buc0pxMXA0SEJlUklwdFUyT0EvTGl0enJjbmx4NlBZ?=
 =?iso-2022-jp?B?SjVCN0RMOTR0UWQxOTdwZ3hrMXh4T0tsNlMxcXRDZjVRU2VYRlo2TWVj?=
 =?iso-2022-jp?B?TGxJU21rM3FiTGZVZDJnNGdubXY0Q3I3ZnRyY3ZOaEZkdS9EbUd5MzRY?=
 =?iso-2022-jp?B?d1VSckhCMlEvejNlblBNQytvNVh2dmw4Zjg5eWg2d1laYWJ2QVJRc0FG?=
 =?iso-2022-jp?B?RUFPR2R3Q1lscmRjRlFQeEZkWjRrN2ZGMGpKd0haWEVjUGNueWMwa2FZ?=
 =?iso-2022-jp?B?aHdCS2JOYzhQb3hTeG5RNXl6SWgzakQ0Y3YvK0R6Q0RXMWRLNE51eGVF?=
 =?iso-2022-jp?B?Z3V3VFBFWm9pcHN4RUNmZlVHU3NmSEM3NzgxTDVlb24vQ1ZyWmhLdkhz?=
 =?iso-2022-jp?B?L1REYWg0NkVjNVhCZFFPbUI4Nkd2UUVweWUxcC93SjByaXZXRm0vUms0?=
 =?iso-2022-jp?B?T3p2WmIzZGM3cG9BNk5Tb2pXZXduT1drRjZ3UUpmQVEveWhhdG5sR21Z?=
 =?iso-2022-jp?B?U01TRE1tMW5oV2xLQWtSb2N0L05hUE5yTnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e806acc4-cd49-4396-1864-08dd1818a098
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 06:13:40.8942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7I1akgS3j8IPWszGEKuRPcZxhFX/BV6RxtVphXO+RLSGfXunzSXjO4QTusbDPaBcslxEwrXxyb6nZ5R0UlNz+r/VTk15gGIx2zr57NBo9KySo3rPsfn6qVnuYKMC6KTO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB10668
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 09 Dec 2024 06:14:00 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17378

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Friday, December 6, 2024 6:05 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
>=20
> Hi All,
>=20
> This patch series aims to add RPC-IF support for RZ/G2UL SoC and enable i=
t
> on SMARC platform, along with enabling tx width to 4 on RZ/G2L SMARC
> platforms.
>=20
> All the patches have been cherry picked from upstream kernel apart from p=
atch
> 1/8.
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (5):
>   spi: rpc-if: Add missing MODULE_DEVICE_TABLE
>   memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOVF
>     pins
>   arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
>   arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
>     for spi-nor flash
>   arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
>=20
> Lad Prabhakar (1):
>   mtd: spi-nor: atmel: Add support for AT25QL128A serial NOR flash
>=20
> Miquel Raynal (1):
>   spi: rpc-if: differentiate between unsupported and invalid requests
>=20
> Wolfram Sang (1):
>   memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
>=20

I reviewed this series, looks good to me.
I can apply this series if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


