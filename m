Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E3D29FBC
	for <webhook@archiver.kernel.org>; Thu,  7 Nov 2024 00:55:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.61742.1730940904439539695
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Nov 2024 16:55:05 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=j9LJlnok;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1730940895;x=1732150495;bh=n6+T4at0T/zfObj5I7/JxsVtMvbjZ8ARLUdRTzR
	J6mY=;b=j9LJlnokdf27QX2SFrTAMiwAqPilvdAF7uso2uy4QRfnWPzVxQnbjSRdgGfsd5cRhnUAz
	UuwzwMAosnmgsRir3y1lS6rj2/KX9o3/yNjv3Wn9mEWTX9ap9ey3FS3UM2JvvZ7H8IK3pRwaKNSpk
	CRjPP6AUC92bQSYDfVjYvKC7WMbNUEzi9/zF93xfw9pO+hs8P2mhzorsNayn7k/NewnxupuvtGO/l
	onSOLTpou4h6cEW9qu1U/+NpiutuXGLBpHcZmYNIBL4tq6nqQlb3i+oMvmtnl43aEfob79EPoY4l1
	B8Q5sswgUxmXYTny3d8mFemg4NABqP0xqyXSQUy5/Q==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4A70ssDG882317; Thu, 7 Nov 2024 09:54:54 +0900
X-Iguazu-Qid: 2rWg67yetYtzIrJBdn
X-Iguazu-QSIG: v=2; s=0; t=1730940893; q=2rWg67yetYtzIrJBdn; m=IS6aQRX8VRiFloYp62dDhna/uow0MrdkygUPS65ojTA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1121) id 4A70sqfR3013278
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 7 Nov 2024 09:54:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvQXUqQqJ3bCXJnngLU4wnRBagedDIhduAq1ZBW7hPV11bV8rfBiW/S0yDy5DUuSoAbTeaYniMUgCCVVOW429hsytbEPMgzE//eXDnA+J0zCjyxPGwP7Q/xmYYu9WQ2vlg87YhTTINrGbJchl4G48KML0GOoqeft6j+jX/spvXwGxrNZ+svbjElIphlZOtYYCYvhNSje9DrJPkCBC8tjOOOlmP6xCZ7H+HqCb4W8pXMXOiadT1fAXyzFDopgXH3LIZqFDPfkS6EIbWesVwUtNg+Kc9HfSxotAhhjivpMtFdlKfNRefvK3uO0p8OHY+16jyYXeWH9sKwe1hi8tUVZSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKFxQaxOBiFToGEyZ7VPaFAiqxz20GhlMam96LNwnIo=;
 b=WJUP+oC443c+4BvTYOTa5W4t5BEegMYjuK7iUZTy+7H4s0wNyasKkIZ4V/8Sm7A1uIEW18PLpiu1X/kx0GFXB1Nflg8Qyy7oI8hVnDSCYOycwkeV+ceXdX9bR4A5QwC1b2/axDQglTTVGtIfwcLaql0kP9+tsYvpQ+Kv5skSADvL0CgHTqeF8vs3tM7T+SSo2Us6WZq3Eimxxpfcb7NjqVpOsQ37tbUoOOCWj6KKryUBjqNshvo6mIadCWJaADhZdCf6PrwjX4EEtCRiJbBGmIkF4uEpCHSPyjoefpV4ySvMsCyUtmIhT/p5A8JID3gR7Darap89KusC48C15PhhmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>
CC: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC, G2UL}
Thread-Topic: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC,
 G2UL}
Thread-Index: AQHbMGVr7F+7KsSgHEmfV1HS9lamtrKq8ZOQgAAMb5A=
Date: Thu, 7 Nov 2024 00:54:49 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388FEA218E9FE28B1791DCB925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241106160307.10263-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB63881D35836D698E201DE3A4925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB63881D35836D698E201DE3A4925C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS0PR01MB5842:EE_
x-ms-office365-filtering-correlation-id: bdc54883-7bb1-45e8-c902-08dcfec6c874
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?M2VZMnJUNHFCUDFnNGNJNFZ3OEpWL2VNRkFnQkpENi9ubS9wdDB1OG4w?=
 =?iso-2022-jp?B?NVZmRFhLcHFBejVkN21zM0dBaTBrQW1SODVzYk8zZ1dzQ2lqSGw4TzNn?=
 =?iso-2022-jp?B?VzJnQTJqSlk0TlB3Um1oY21QUnNJUEIxMm5WWGZ3K3J6eXpDVFQyZUcw?=
 =?iso-2022-jp?B?U0J1MGZKS0o5NjJva1hFMTRacG11dGRjdWJKdzUydDVPdlptL1FjaEho?=
 =?iso-2022-jp?B?WWk3blNlKzdVRjIveWpzWmZ2Qlljb3IvcmgzN0RTNWU3czIxblJpeTBj?=
 =?iso-2022-jp?B?QkpaY3EzMldjRHgwWGx2SE4yZGZ3eTl2MzJRMWM4bnVnbTJuMlVkUEJ2?=
 =?iso-2022-jp?B?U3VwcEVJRXF5TjI1ZkJMUzVPTXpsSXhGc21JVXo0REIzN0NwVVgzUnRL?=
 =?iso-2022-jp?B?NUdNYjJtcUV6bkp6aGxkcHk4NVdpN1gydVc4a2EzbXJOYlU3OEhxZmRZ?=
 =?iso-2022-jp?B?UXJEakg2OEliZTI4QWtySEhCQnNoRmZWUzIxRkI3aVpRL0FzRjJxdytS?=
 =?iso-2022-jp?B?cW51b2F5emY5RXlneFdldGw3aXFLSzRBNlM0TUlaZUNHZDNITzdBdmx0?=
 =?iso-2022-jp?B?ZGxxRW1yOUZkdjltSTZ6MnNTY3htdGh0aDFvYW1SMkRSZFJEc3c3NkR1?=
 =?iso-2022-jp?B?R3duemhRTGxKbGpIcTdxaVBxSldxTzMzT2tQcWM5RHRlSnJFSWtmYmV4?=
 =?iso-2022-jp?B?bElnOEtvUlFlejNpSy9ua2JpVDQvN3RsalZaTGlYU3VKdVJNZi9zYmhq?=
 =?iso-2022-jp?B?L2hsalhBaHlQaGpQN0IrV3A1elpsbU1HbW5DZG1EZ05iZTlkL1FRdjQ1?=
 =?iso-2022-jp?B?SE1NM1pYVGp6NFRvT2U4VEg2cFBGdWRnTElCTXNXN1F2MEN3bmlzOFRw?=
 =?iso-2022-jp?B?dEpMOGNrN05jNWE5ZG9rdTVNZitlU2FZRkxiMHorbEI1bXJrZ25QYzNo?=
 =?iso-2022-jp?B?NXdQaXpkS3hZbjJtd01WT0Z1M0duaHA3QUI2ZDNiMWE4S0xLcU1zZnlh?=
 =?iso-2022-jp?B?S2VsdDhYYTl6OGNHVU5QMDVxMWI5b285Y1h5QzVtRE05NCtwUy9mMmN1?=
 =?iso-2022-jp?B?ZkkxMm5nRUQ1OXF3NEtRWXEzWjY3TVRuanhOc3BEeVQ2MUsrZHNvOVpB?=
 =?iso-2022-jp?B?OWkzZUh0NWpneDgxZjgzVEZmK3dHb2IvNGVkSUZoaWlRcWlObFZ4Q2FD?=
 =?iso-2022-jp?B?UjNqcVluL2NwUXhmSDFCcXZNaUZ6b2JtT3lzSWkwa3NvcTkrc1N1L1BF?=
 =?iso-2022-jp?B?WjZZVU9aNTRMYWtaTDlvV2RzN2RjMGVteWMvdk03TXA3YTQ1SE91RjlT?=
 =?iso-2022-jp?B?eE9iVTJ6bStaOVVUQUdOUS84OVJZdFJxWlNZL24wVkh2UmdxcmEyTkl1?=
 =?iso-2022-jp?B?S2tZKzNTWjJiOStzTFRiMndsYitQU1FuTXVMUUtJTFY5Q1VLL2tIYk95?=
 =?iso-2022-jp?B?VmZSajVUM3cwazZyWUF5UTJBZTNHTmNHcEM3RGkrdEFRSU5kQWtPbjlZ?=
 =?iso-2022-jp?B?ak9SNWsyczVTeERjZFJUR1NaRGZMYU9tZ3RrQU95cjZ5MjZ1SlVoUm9P?=
 =?iso-2022-jp?B?TytUTEVld2xueEc3S01uQUNpdGNERkJKanhFbjhEMzRad1RmbGtzVXQ1?=
 =?iso-2022-jp?B?UVFtWnloR2NTVEpYR1JnSnZvNlJWNWpOOEN3blJFQldGUnMrZDhKaXFt?=
 =?iso-2022-jp?B?dndSRDJIcmYwZWVnSGQwY1A4Q292Nkl3bnlIQTBWNE1pQWJtS0hHYTB6?=
 =?iso-2022-jp?B?bTRSSmQ4RGZCSnpudzMybjYrOENEOExvUGxtQU5ZbnhEQmhERFVtdkVY?=
 =?iso-2022-jp?B?eHF4MzN0azQvZkxrUGhBOXNHSmVsRzdMcytqbjNqQ2ZrU1I1Y2hNc2lB?=
 =?iso-2022-jp?B?Wmx4Q1owemovOW5UNVBibWdyUjVHK0Z3a2N2NCtoS1YxNE9nME9BdWZu?=
 =?iso-2022-jp?B?amNSRDlLK2dvVG0wU3BFWHNDdkd5c0oxQnJ4Q3B2ckx4RVd1RUNhdWR2?=
 =?iso-2022-jp?B?TG02QmJzQjlMY2p3QUhlaCt5ZWQxS2NveUpYeGRGNXh4VGErSG5RT21r?=
 =?iso-2022-jp?B?VWdkKzYwUU1JZ3g2bjZ0dm81TDRVR2M9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZWlGZ3dsLzVjRU82U3NudUhOcUdzcnFaTDViWTdRcWJ4eUxkbHY2MlAx?=
 =?iso-2022-jp?B?KzRwZW5WaHVWUENaMHUxd25wbDYyZklHZWw2MWR4SENCRk1WZ0FjbW5J?=
 =?iso-2022-jp?B?c0pJL3BOYS9iQmdBUHRmTURtbGFqYlVBNG4ydVNkODhDN3J4YWNCZG00?=
 =?iso-2022-jp?B?eWRzME80Y0NSb3g0WGlYa25FbU5qajZMQk1Xc09wUENYVnhWYXg5QlFC?=
 =?iso-2022-jp?B?a1RLTFNhd0RhMS9PN05wSmZ3ckthREdsdjRwRnRMV1RGSk5Kc3JjWXMy?=
 =?iso-2022-jp?B?S3dGL2pSUHJCMUZNUXA0L2dXVHZqaTZTUTkxVnNBdmNKdEMyNzRCbXVF?=
 =?iso-2022-jp?B?US9lWjU1Umt2enBmbnM2eW5kMWZzRlZybFB3V2ZsRWFBTzI0R1o1ekZB?=
 =?iso-2022-jp?B?Rm0xWVd2Q2NoQkJZNGNUSzQyRzkrL0dKZ1ZIZmN4RWdvdlRoRmNhQWU4?=
 =?iso-2022-jp?B?b2dybUs5S0hsNU1Bd2dEUE9aVmV2Z1RsSjJTS1Y1eFIxRkF0SVE4VmJ4?=
 =?iso-2022-jp?B?Z1FSSVlGNXExWmR5dXVmZ05FZFdQMStFNkdQZTdQUEJwL0ovYStLSGhl?=
 =?iso-2022-jp?B?YWFWSmVoNnJ4cFg0OWkyenRiSU9NNE9YWG9kRTlMNGY1Ui9abGJhQTVU?=
 =?iso-2022-jp?B?Y1Q4emZacnk5enlCdXdMbmRLYTVrNEpRMnBPWC9paGkwZjBSVDdNMWxl?=
 =?iso-2022-jp?B?VkZaYjBFcTdlTFlPS2x5WWVOdjFGTm1UQXBtbXovNHJMM2l4V1ppeEVH?=
 =?iso-2022-jp?B?VGFrcVpxeEVUTW01T3ZXT3hJb25TcW04dmJ3VmR0b2V2dTFDODZLZ0Jw?=
 =?iso-2022-jp?B?RytKclJEQndtL2g1K0FPeXZlZTladXdpS1hpSGpTMTRvN3pPLy81c2gy?=
 =?iso-2022-jp?B?TVF2TG1NVjN3dlJwbkxaK0VIV2tWcWFrNXF1OTYyUmZoQzlSSkprWmlP?=
 =?iso-2022-jp?B?YXJCU05DV0ZhRHR3dnFGSW1kQzVzb01hdHZ2ZEhtRnBsMElVRFJqUUlI?=
 =?iso-2022-jp?B?eEdYZkJWZ05oU3lJNWZpZUx1a0swcHl1UE9vTElNaUxORlU3V0laVkQz?=
 =?iso-2022-jp?B?aEtvcU1iblZDN1JCRUsxeTRJVUlYYStmUUFxM0dXNEs5RVp4aVNJdDdm?=
 =?iso-2022-jp?B?RG8rczAvNlBwZGpUeEd3ZktSdkZnRlFTbWhCWXJXWGVoaDBZVUwzTnZi?=
 =?iso-2022-jp?B?S1ZHRFEvWjFZQXhiekVRV2xrNjN3VklJTitEbDV3QUhkVjdXbTNzOGlF?=
 =?iso-2022-jp?B?N1ZXV2puMUJvQXBkdjVKUzhraUJwVVJtT1ZFNHBQQkZDdDRjLzdSTVVr?=
 =?iso-2022-jp?B?TUhrMHYwYW1LWlgzcHM4dE1oc3JFZzJ3cFFmTnAwUkhwb1A5K3QyYkFS?=
 =?iso-2022-jp?B?UXNQTDIyOWlJQXFHNW9vNUJYTHZ6R0QxWGp0dEpzb2pyQ0Jub09KWDRs?=
 =?iso-2022-jp?B?TU1OZS9IZXZsL05SaXBETGRiUjhyM0hlRVVIQ2pqMWMzbXVnWjNJaG1h?=
 =?iso-2022-jp?B?Y1JoM1dUQ2laU3NJRGhvRjJwWDhweTQ2REY4aTNzSGRxODdOMmNPd3VW?=
 =?iso-2022-jp?B?QU44eDdvd3lCVEJLZmlXSEFoUW1CU2pBMjJGOFlIWlFkRVlUR2p4T3Fk?=
 =?iso-2022-jp?B?aXZRaWNTWXpXVHhZbTJkWHJjeHFLS2ZqclQxRndOYXhWbjlrT3BFQUtE?=
 =?iso-2022-jp?B?MnkxZmdCUGF6SW5oVFIyY29IU1NHaFpBczQ5S3pQYjgyWjFDV0Rwczhx?=
 =?iso-2022-jp?B?VTdzZ3cxN1JaMmhKUGxHeHZhL1VqZEthSXlUZXhJekZIZjFyMGJuU3lO?=
 =?iso-2022-jp?B?NHVraVpSMEVBdU0wRENSdGtkUU9HUHF5VTJuRm5seEFoc2MydWVYTmhX?=
 =?iso-2022-jp?B?YUlqUTZ4YlRMYVZJZzd0ZEhpZ2FoNlAxVHRvazFVL2poS2JzL3REaTVQ?=
 =?iso-2022-jp?B?V01PSmgzb3ZjK1F0Zk5WcXNyN0RxdjRhL0lTMnlsT0tSM3Q1Z1ZsZ2ov?=
 =?iso-2022-jp?B?QVNIVGlqOEl0OTVKL3JNWjQ2T3Q5TXlrR2Q3OGNDLy9KanpYekpmMFcx?=
 =?iso-2022-jp?B?R2w4MGQzMjZ4U0pWcmFzU2FGTE8rOGtXMFZSS29FZEZGRDlVdmJmeUFV?=
 =?iso-2022-jp?B?OUtFTzc1SU5wOVZndld4enV4dVZBU1p4dndLR1NBWUkyUFc0SzUxaTRV?=
 =?iso-2022-jp?B?RkFrR0M4Rkw0Y1lwckxQQVU1RHl0eU52VXdWWGovaG1xT1NkMlRPQnBj?=
 =?iso-2022-jp?B?N1dzOXIzM0VuSGF4Yy9HSm82Z0JRMGZUNks4RlRMSHJwb1hSMXBOTW95?=
 =?iso-2022-jp?B?clZ0MEMxVzdiR1dvdUJZTlBQUTRRMkZwSVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdc54883-7bb1-45e8-c902-08dcfec6c874
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2024 00:54:49.9272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RoevIP97/ISlj6nyJmXz+gXtZCHbz2PqqbuqTFHdPQ8EG9MFBG9fIYA9OSRomCRIfOSz4cKtBc/1JVSyXEIyjcUCUxQbpgmKZ4NCZ1/7e4AvnspIGjCQm11XNyvpW4LX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5842
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 Nov 2024 00:55:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17194

Hello,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Thursday, November 7, 2024 9:15 AM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 0/5] Enable CRU, CSI support on RZ/{G2LC,
> G2UL}

[...]

> >  .../bindings/media/renesas,rzg2l-cru.yaml     | 35 ++++++++--
> >  .../bindings/media/renesas,rzg2l-csi2.yaml    |  1 +
> >  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   | 69
> > +++++++++++++++++++
> >  arch/arm64/boot/dts/renesas/rzg2lc-smarc.dtsi |  8 +++
> > arch/arm64/boot/dts/renesas/rzg2ul-smarc.dtsi |  8 +++
> >  5 files changed, 117 insertions(+), 4 deletions(-)
>=20
> I reviewed this series, there are no problems.
> I can apply this series, if there are no other comments.
>=20
> Test:
>=20
> https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/153062924=
5

Build fail on RISC-V.
  https://gitlab.com/cip-project/cip-kernel/linux-cip/-/jobs/8290354547#L26=
30

Lad, please fix this.

Best regards,
  Nobuhiro


