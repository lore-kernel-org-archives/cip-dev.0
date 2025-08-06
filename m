Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A389DC87FD1
	for <webhook@archiver.kernel.org>; Wed,  6 Aug 2025 07:18:50 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.19531.1754464727603228516
 for <cip-dev@lists.cip-project.org>;
 Wed, 06 Aug 2025 00:18:48 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=V7lGL1yW;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1754464725;x=1755674325;bh=oAMo6piiqULfmBZI5BmOTBZGUaW/Z1hUXJjMF7l
	77Ps=;b=V7lGL1yWu/mTeK0nFhs9Gi7OxVTiwbCrl3F34k5lIR9Ey+BejjDUd/o83JploA4FZrs13
	ZRr7Agdjmw9tI349hyT9plFkEABXPFNJVar3ujJ3Njqtx+1aWfQX6x2MeAqXnhFaSM2O7ceCQkO0u
	Y8H7VZTnAtLntXRTHsNVHFxxrprZgL43sVrdCc1TM2v3DMSU2LpiJNW/8W7Iy2IJl/jnxstaJthqW
	hZlTYlLuuiQLIdP6DKwdBWULM5xHfWIKx28meiTJ5GMiZBuLkRXZlpw+T4NfUVvm5VIcw95rW+oi3
	EXWTAL7XNxdgpGlRSegPjKp4bzYSFYFlS+6if3hN6A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 5767IiKQ2189379; Wed, 6 Aug 2025 16:18:45 +0900
X-Iguazu-Qid: 2rWhqikyheKEMudYcy
X-Iguazu-QSIG: v=2; s=0; t=1754464724; q=2rWhqikyheKEMudYcy; m=Jt7DF7fmi8p+gR9YxBKT3X/t5SUTeWgEIkDBWZ2uyB0=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 5767IhKT1675499
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 Aug 2025 16:18:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fxx7TkQl3rLjYebn8YKLX5yWN3WKcWDizd5VqPN6rYv/BeZKLbe4jkZnZ7jH7NMMME87qtDUgzxA3ozs1SrNu3bNqXii8LnNztAjVzcQVguup7MMro+jJWoqd7FQG6hnx4tH3w/tWQ1Zhx3xmXDBWqJoSYxBcOTSskvD/26EtnDZgqSPgEU2NEMEnx317nAYEajT8Q9vlgRLFWFl+ysSGCR/pKSOxiblPDj1ptiopEzjIXnlCnw74OpmWMu1zDC6uiDWEZe/I0HEgqV3jJQkfgTTa5MygtcYdIY5u7QubmdA2vZGs7fV2e5az+jEu/h1SLJJlyIge3KDH4lxXmDC7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkpxNtwq0FwFE7mkLkyYnePYbkkyLN/sj1AK7uihIi8=;
 b=muufyzYo5OUbnCuilcDGq3KOeLdTlQgG/RWH71aefK11VGvCiiYXwpv1BxY36KvGOw18zr60cNPsfhaUMFu4Uw/oJnTu9zwAuizIhf4O/ckYr3kQ5Bqffi3ZqhxLCrKV3Lnl4LeUcULAlyISZcz7E83lUyPCoZLwhE6Z/iXhykL0fHE1FgrO0ME9RvT47tHKSl2Cmgwl8sPmGOPoFoHcBEa7Ta11/ZZm8woG32AxbGOXG5FOdVM+OAtqYZO6oaJbHuLCXVyIX4gY1Jvw8jjaDahsTj13Lap/Pu6j9WmFEoFIN/WwjsdhMcks2Nb9KkaXp/DSrKHXrUCwhpCTd906Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <nobuhiro1.iwamatsu@toshiba.co.jp>, <jan.kiszka@siemens.com>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [isar-cip-core][PATCH] .gitlab-ci.yml: Add ${no_kernel} to
 deploy-cip-core.sh when building swu
Thread-Topic: [isar-cip-core][PATCH] .gitlab-ci.yml: Add ${no_kernel} to
 deploy-cip-core.sh when building swu
Thread-Index: AQHcBqIVTvHWDijX9U6njFPcGNbkKrRVNwgg
Date: Wed, 6 Aug 2025 07:18:40 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481874D90261A27CCA98B8E4922DA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1754464295-8426-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
In-Reply-To: 
 <1754464295-8426-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB14629:EE_
x-ms-office365-filtering-correlation-id: 2afa682f-bfec-462d-c41a-08ddd4b97820
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?WUhQU0t4ckU2WHN5Y3BUNUd1MlhvMXordTZQenAvWi9BL2FtZTREZ1o0?=
 =?iso-2022-jp?B?TFFPN1J5ZUJyN3krT1ZHcEEza3VoTXRBTVdBRTJTU0JvTW9mSkhQZzds?=
 =?iso-2022-jp?B?Y21OY3BoMWNuVDFMajFnUUZaWktUSU1TNHFWUzBSUmtENmc2NTVidmhW?=
 =?iso-2022-jp?B?U2FMZUhZb0NoV1g0SXdvNUVydlYyQWMxb2RsUXRzVVRhQjQrL2lxck55?=
 =?iso-2022-jp?B?bG9rYlVLZmppbDBpVzFubDBKWnJQVm9UbXVLT3dYcDdtQTA5UXByZDFC?=
 =?iso-2022-jp?B?TVU4cDZ6RkZucndzUXVmMEJ1aDc5TysybVlrenIzMk5yRlB1U3JNZ014?=
 =?iso-2022-jp?B?TTVXNWI4dVloZDhRUGl2YlVmVnE5SzExVmIxQWh3SDRFR1F5ZUJ2RGFn?=
 =?iso-2022-jp?B?L21sNU8zeC8xWWdsUUNxZ1M4Yy91Q0NPcENTblNtdFJHUmxIS1NNbWNn?=
 =?iso-2022-jp?B?eVJvaUs5K3B3N3IvUUFGc2RGSi91bUxydTViMEpQN1MrcXZQNjVPdHl4?=
 =?iso-2022-jp?B?WEVkVHpoNkcweXovUG8ybnpzZlpxSk5zUHhPY1F4UllwZjRrWGUrY2Jm?=
 =?iso-2022-jp?B?QndUeWdwL2lTSWFuMktOazVwY0d4aUZ1ZDBER0RrUHlFTGpwM0JRektv?=
 =?iso-2022-jp?B?MndZOFlNS01hR0xZS0RDMFRnQ1RYS2JmMzlBYlQwcXBCOUhOd3NSRTU2?=
 =?iso-2022-jp?B?a1pWbXlHSFhEdEFvQmtMc0w3Y2ZKRW8rSEhRbkdwYktzQmFTaU9zU3Qy?=
 =?iso-2022-jp?B?djUzTVI4MmpvOXVTU1JvaGgwRjZPU05LZHppMzJCckU5UEFCZ0RSRmxP?=
 =?iso-2022-jp?B?bFZXWTJpRTZyckRDMVZHSGZScEpqSnlkSnRBL2Vyek1GU2JvRjcrWkpq?=
 =?iso-2022-jp?B?aDM1dXRuVWEvL0tMQ2tEUFNrNWs0dVF6OUFQSkVILzdsRmtnV2FnWnVr?=
 =?iso-2022-jp?B?dm9DTjJpTVNCNnJDMEdUYk5MeVBVSm1DUFFpTXZvMkdweUxpZGduaGYv?=
 =?iso-2022-jp?B?dCtZS2lVWnZHQXl4K0ZpaTJhWWM1NFR3T1VxMHk0UGdFaVJObjdqSWR4?=
 =?iso-2022-jp?B?VS83VndUZlV6dXk4LzVqVElGd3pOeVFwVWM3a1lEV2s4S1ZEVFZiRDBH?=
 =?iso-2022-jp?B?RGp5dWZCdGJtY1A1Z1RBNEg1cWFCOVBTVHZsYm1PRkg5K2dpT3FjcEho?=
 =?iso-2022-jp?B?RTJUTXVIOWkzWVlSdVFBUCt2akh5TXVTZHRNZ25nbjFWNG1Nb1QvdmQ5?=
 =?iso-2022-jp?B?SmNFWk1DeFpJYkVYZFViOWtnaXpLcFl1NlB6dmZqdmpuditld1NPOVpx?=
 =?iso-2022-jp?B?YThBVFN3am9vSVFyQlplcTBTeDZ0M0lpUzVSUmIrVlYwQVowRUNBc3FR?=
 =?iso-2022-jp?B?YitxaytLYmtralc4RFhsSHZRcnF0QXpscmRqMnBrVGRLdW4xcmtQRkRZ?=
 =?iso-2022-jp?B?bVBnVEFUMVFKU1F2eGwreWRiQWFOWkJYVWh6YTJlSVlOQkFaVG16SGtI?=
 =?iso-2022-jp?B?NC9qQlIxRlNKOTNyUW9jN1g0dTk0cktaL1lxaTl3akprTzRaTWFoTGtG?=
 =?iso-2022-jp?B?VE1zSzRaeVptKzB2akRRRXhjUnUycnZrbjd3SEIxQ2ZEWXV2M2tCdDZl?=
 =?iso-2022-jp?B?VXlodjd6dXU4WDMzT2JvRkJ0Qyt0WXV3SFRZQzVrbWNEcTEya2ZrK1Vm?=
 =?iso-2022-jp?B?cTVhdzdKUzNuVkh5cEx5ZUF1OUFmZHB1SFRZRE9KTzNLa3pjNnkxQUxk?=
 =?iso-2022-jp?B?MStiekpuVXQrVEhvdFRXUDByaEZMbVB6WFE1ajhxSnhySG4xTEF4WTdF?=
 =?iso-2022-jp?B?YjhZSWJoUi9tcnZhaHRJNHJIajR4UklydStjQ1dGVElqZ093cjhWcHlD?=
 =?iso-2022-jp?B?bGsrNFp5aHdYK3MyRnlNbDdjYWpNd2IwWDNZbEV4ZitLUGdtSCtkbWsr?=
 =?iso-2022-jp?B?bTFDK0lNZlRXS2JCMjRuY2xBRUU1aHN3QmJta0ZmV0p5clF4S3EzNUpN?=
 =?iso-2022-jp?B?SFRsQTNPa3RpaklKV3lWeGcwRzJwVkUxVHRGWVU0NjhSMVlzcWZNcndE?=
 =?iso-2022-jp?B?Sko3bEl3NURUclhuQVM5d3d0MkhMTXJPVG54a1FNb254VkpjYktQbGZ3?=
 =?iso-2022-jp?B?YXRocHpXZTZCWitKcTBJYzJmNy93ejR3L0c3WHdvN1hPYkc4Qjl2U1p5?=
 =?iso-2022-jp?B?SmJRPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WTdwOFZaZ2pmZ3huRU4veTdhZVc4NDJYOXBNVFFEK01KeHR5UHhCSita?=
 =?iso-2022-jp?B?bE03L29ha1Eyb0FGYnQ5N1BNOVNzWGg1T252ZzEzNGpnbkZYdHd2N2U3?=
 =?iso-2022-jp?B?blBzQlc4UzNYNkpYN3NwMUcrbGpPNGQ5MkpnUHF6UWIyajR6VTYwNEtS?=
 =?iso-2022-jp?B?TFMrUElic3R2TmhFK2JoZlZidUFvUExjc1VleWtWeGdod0xONE5GZisy?=
 =?iso-2022-jp?B?amcrSUNOK0tIR2FmWGQvTHVoc2V6NU1wSzE2NjJFaHpEbUw5TEthQ3h1?=
 =?iso-2022-jp?B?Yis1UUxWYjRjY3JvZUZURGxmcmhXQjgvRlAvb2RlbGhuaW80VXAxMzhn?=
 =?iso-2022-jp?B?eDZqbHJVLzc1QXcwTmlMOWFZMm85UXBPU05aNDZ6d282ellkQzZCWTNl?=
 =?iso-2022-jp?B?eDNHUUJVQVRXV1llNDhlZDBsdi9DOXhEcU5rTkZveFlZRi9DQTIyK3Aw?=
 =?iso-2022-jp?B?WldMS0IrcCtYTVhZMWFQSHVoTTJncThXNXloOTIvNG82bnRpZjFTZ3Ez?=
 =?iso-2022-jp?B?aWU5SUxZS215bGhNbnpQVDNzZmRiRzVwLzljSXpHOGQzY1BQT1ZWVVRX?=
 =?iso-2022-jp?B?TE1YcExwYXh1MzVydURweDZLUkJyWmpiU0hGbmFYM3ZCanhiWmlaZlRF?=
 =?iso-2022-jp?B?K1p3cm9iYlBXQ01ncGEvSzFaaVFyMjJXLzl3cS9XUzRNSkRDUC8rMXVM?=
 =?iso-2022-jp?B?d0cyeEZPYzAxNnBmVmVEdWtMaUwwVjVsYUF0ams0NmVMTXpNbnI1Y2s4?=
 =?iso-2022-jp?B?UXp6Z1FidnNNMjVEWVJxQUpXYU11SmV2UjRYNy9oRnk4bjczUEVwUXhV?=
 =?iso-2022-jp?B?UXY5VzhQekdvWjlBRWszQUZqYjN6NExNWjNXMThOY05GZWsrTS8wUEx1?=
 =?iso-2022-jp?B?WWVKVW9LSjR1TG90dDBlTmFBQU5wMGw3VFkvelk0NEpNVkZua2RtNnNr?=
 =?iso-2022-jp?B?dFFkOHlZNVFvckRwczR0enBHZU05eFBGQXBCNXVOR3BRTU1POFRSdEZC?=
 =?iso-2022-jp?B?SHV5bVFpclNvNUxsdDZ5K1UvbktkT0ViTE5FZnBmSm83SmhvQ0RMazB4?=
 =?iso-2022-jp?B?OENieDZPZDNndWxybHJGYzNxSnVKY0ptNnp5dnRyQmlJYzIvemFHVnF6?=
 =?iso-2022-jp?B?ZTQ5Rm9HTzY2UDdWdnpqbUVTY0k0QzVEOUI4RmNNZWJkZ0NiYXZmS0JU?=
 =?iso-2022-jp?B?bjVtM0pqZURSSWNPUHlnWGRRSno1M0x1SHNJNjc4NkRvYjFDNkJDUjQw?=
 =?iso-2022-jp?B?bzRyNFlEOTJFUEpZaFN2K1Y4UXFzS0FHT01SRjhETmV0TkoxUXNqdzRj?=
 =?iso-2022-jp?B?KzJEZ29YdlY5TnMyQ1JnTGhadkVpMmRTOEZwSGgrN2lNZjMwaHh3UGpz?=
 =?iso-2022-jp?B?UWtqTTFvVkozNUVlMnhjdDhNM2ZSYTRFa3ZBZ09hczZXZjRPVW9Md2Rj?=
 =?iso-2022-jp?B?eDgwcnpZYkhwcnlQdC96MDZEMmQrbDN5T0cyUmlHS2wzMnBYZTA5MnBl?=
 =?iso-2022-jp?B?NHZjUlppTnpyV3hRT25zVCsxY1hIeG1OV21uelpBSlF5OURGSlhiVVQz?=
 =?iso-2022-jp?B?RUdHWkVSdEhQMWlyUzBZUysrS2R4NFozM2c0KzFVc3FGckp0RGpjN3dV?=
 =?iso-2022-jp?B?NGh0MVlNS3VESCt1c3lPYU5UZDJvUHdLS3A1aldFYVo2RDUxZTIzSUoy?=
 =?iso-2022-jp?B?ZXB6RnBEU1JQUlN4Yjk4Z1kxdm1RVTBJQ0lDMXJBcTBmUUgzNU5HaCtS?=
 =?iso-2022-jp?B?VTlBVThmZlZGQzRNL0hsUGtiSGlJZlNCWTQ4SU5uMEMwUkVBSUduelB6?=
 =?iso-2022-jp?B?RC9jSEk4UUh2bjJaWk5Xci8xVFptcWFLMmRHUUhOYkhEdnBzajBrRkF3?=
 =?iso-2022-jp?B?RENGWFRPOUVTU3dCaWxZQXpIUmZlbFRoVU8xYTArRVpTT1ZNYlh2Wkpu?=
 =?iso-2022-jp?B?bkRrMFBBMjBTalN1NWF3L0NrTlJKSFViS25iS0NTeDdCSEpLWER0alY3?=
 =?iso-2022-jp?B?MFVNU0g4M0xWNWs4ZHVYc2R1d3FmRDNpT083cU54NDdjREY2Q1hQemJ4?=
 =?iso-2022-jp?B?Y3RmYkZrOUM4enZvMGZObG1LUU03SjJBTkRVdkpuT1VNSGk2aGk5NHNz?=
 =?iso-2022-jp?B?Y1RxVGZRZm1IUStyZDRtdVI3N2V6MFhuWjBLcXdERUdiTjV1STBza3dh?=
 =?iso-2022-jp?B?MVJrNWJxU0VZQUcvcEc0bUNoU20vT2g2STA3c0N4elJuU0I2dVNhYzNk?=
 =?iso-2022-jp?B?bExTSTZ2M0k1VEhmZ3Y5aEZ1bEZrZStTaGNyVFhxWi8yeTlaQzNGWTNO?=
 =?iso-2022-jp?B?Y1ZNNXVVcEJBQWpDc1BYNFFBNE5LNHdueFE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2afa682f-bfec-462d-c41a-08ddd4b97820
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2025 07:18:40.5351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kiE/nbe2r7oMeVuLyv36PWk1i3N3CU6V8de3ecNw5NkGHVMMawW9KN5jYr8sVUHmStfvf7Gj/0R31MS06oEHV1SzCzshSwZ/ihQQYenGa8jbA9TAq4htdUtprDLWB4a2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB14629
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 06 Aug 2025 07:18:50 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19689

Hi,

A similar fixing was made in next branch. Please ignore it.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Wednesday, August 6, 2025 4:12 PM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: [isar-cip-core][PATCH] .gitlab-ci.yml: Add ${no_kernel} to
> deploy-cip-core.sh when building swu
>=20
> CI fails because ${no_kernel} is missing from deploy-cip-core.sh when
> building swu. Add ${no_kernel} to the arguments of deploy-cip-core.sh to =
fix
> this issue.
>=20
> Fixes: 228a7b17903c ("kas/opt: Add option for not install kernel")
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
> ---
>  .gitlab-ci.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml index 496a56d..a494911 10064=
4
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -83,7 +83,7 @@ default:
>            fi;
>            echo "PV =3D \"2.0\"" >>
> recipes-core/images/cip-core-image-security.bb;
>            kas build ${base_yaml}:kas/opt/delta-update.yml;
> -          scripts/deploy-cip-core.sh ${release} ${target} ${extension}
> ${dtb} ${CI_COMMIT_REF_SLUG} swu;
> +          scripts/deploy-cip-core.sh ${release} ${target} ${extension}
> + ${no_kernel} ${dtb} ${CI_COMMIT_REF_SLUG} swu;
>        fi
>      - if [ "${deploy_kernelci}" =3D "enable" ]; then scripts/deploy-kern=
elci.py
> ${release} ${target} ${extension} ${dtb}; fi
>=20
> --
> 2.50.0



