Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8199C35FF3
	for <webhook@archiver.kernel.org>; Fri, 21 Mar 2025 08:14:58 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.16233.1742544888073636149
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Mar 2025 01:14:49 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key3.smx header.b=plwRA9Mv;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key3.smx;t=1742544886;x=1743754486;bh=AHyK6u4IULWhR+7TdmCjEAnCEggi/D6nG4/Wwby
	8JHs=;b=plwRA9Mv4TdgML4eIqkkkPmTgzKmTf/w+39cIXQu/8B7lJdB8u9Md5ClOnT6T4qqHUVVm
	mqmELDmXo34OqOZsPXRpyfIp6St7X21nvX4yyGkp041LUeJsJwkxBDVP5fgezR42lsZH7aBS9RyMr
	hUeVePCLrUz2+f7l2v/ba+crrK4W6yATwljUHTHuTqfE9EyY+ruGeloRLmcPWkEKX8UG8x2ncPcn3
	2Jvncu0IRAokVJ4Y2tYtVUGKvkmS4oknBPfbrUmZJQR8/HkKEri4M2j9mJVdGc1Q+aFugqCmM7utt
	ZGM+EPQdXIBwMw/ayLLV3eSkoVcUTtiiHkKAUW1zzw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 52L8Ejs6684416; Fri, 21 Mar 2025 17:14:46 +0900
X-Iguazu-Qid: 2rWhBFYKJj5VYCHb58
X-Iguazu-QSIG: v=2; s=0; t=1742544884; q=2rWhBFYKJj5VYCHb58; m=xIg4ymJMgHnAXE7vFtThQGyrNmECIUIUlC/dmB+TE3U=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1123) id 52L8Eh1Y1552308
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Mar 2025 17:14:44 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hprvyFzIN6JoHceq2ytSLd59ZVWpnhHpgwjZdfl7RaLQ1eHAoqCUAJ/qJNdcjSZtQtI0iudKSOK4lQocBXVySWjMYz7xLJvbdmkd/CfmUFI5XpfMA9G1z9Wtd9nEvp4gvA5FkM7g1kfQpzPuaZIwInl/Lx+lpC7ZGaMMxg63FfXGE/RVSxdVmffuzwXmFhv7skpeVEGd0L/8MhfPPregPm2gmra/nQRdW+LovEETJnKmsLKxTvm2soihGAEkBB2bYEkeWMTSx+F8VcFDpA/tCKrfRVerYtcNT4gNUdKREW4TaGmVAHRaOmh19ppITdNfiZl4u8vLCVIVHx3EppSawA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHyK6u4IULWhR+7TdmCjEAnCEggi/D6nG4/Wwby8JHs=;
 b=aPf3ywjW31CnPwy360tMJQK7biVVhWZ5y24Mpx1p4NCGz0IseylsH586uu5AvYM0sPx7zvuoa0qVSFVYK2r6yq/dHzD7I6Y3GgEJW51wMXp9g1wT/GyAIkq97g83BNZ+1nxSvmTJC6Qa9JYD059/eTItr2fnj9E6H3+K6lOlCUDzUwfd9MgGahRmXi5+gllPkYl01X7xGFBS/ldr8IoIYcTEitnb05gxrzLhBmaUuqD+Zdncz6ZOV0kZjumUBp61nJl5Sxf2cQWkAhI9kQMRrt8k++rS0DG908LWVbg+MDg3wdrBODZ/4hpwfFhmoCZ8xwOUfLl9wJqqDoceqjNZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <felix.moessbauer@siemens.com>, <cip-dev@lists.cip-project.org>,
        <jan.kiszka@siemens.com>
Subject: RE: [cip-dev] [isar-cip-core][PATCH v2 1/2] kas/opt: Add option for
 not install kernel
Thread-Topic: [cip-dev] [isar-cip-core][PATCH v2 1/2] kas/opt: Add option for
 not install kernel
Thread-Index: AQHbmjfPlFWGNiUn5U2Yj7ulj08K7LN9PZ2AgAAATvA=
Date: Fri, 21 Mar 2025 08:14:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481869628DF813F5CE8410BF92DB2@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1742544230-24109-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
 <f5ac43e225b54f7d40f585ea8c76a2b23a0e06f2.camel@siemens.com>
In-Reply-To: <f5ac43e225b54f7d40f585ea8c76a2b23a0e06f2.camel@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OS0PR01MB6435:EE_
x-ms-office365-filtering-correlation-id: a01c4d28-c877-4997-9ef0-08dd68506ec7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MEtKSjVKSEs2K2lZTHVtZlJDVEFSa21zd2I5aFlwUVpicDBva0VnZHZVd0Vr?=
 =?utf-8?B?S3dYSjJTaEJXZzBOekcxTXVJZDhBRGpoVEVVVmxaUWdYVE96WmRYamd0cWtx?=
 =?utf-8?B?TFpQUGRHb0pacExxL0Fna1JEZitwT1FCcG1Fa3NGRlA3TndZOTdvbG12ZE9H?=
 =?utf-8?B?UVpxNlpDQ1NDYjEvR0Z5S1p2MStscXZzSHk5ZGhaUzk2SjJmTHJvZkswNFht?=
 =?utf-8?B?a2V0SHJGVWtMWEdiL1FGTDZTRjJVRkk3YXM0bThaYTNEWFJCRDZzOWxmTWlU?=
 =?utf-8?B?S2xuVktTdlFUcGR0Ly85QUUrTGpjT3MrWmZQL2kvN2xIV1JQd2VpQjMzaGE1?=
 =?utf-8?B?UkNrQ1Z1UzFIQnFlVHdvdnRvRmRlSXFzUlVZM1ZMdVVVUkRjR2JXMS8yMk42?=
 =?utf-8?B?TkNTd1BpQjZTaVhqelYwL0Z1MkpoRWhTazdZMkd5MUszN05vRnliUGdJbURa?=
 =?utf-8?B?em8yVVNpTUhjNlVrRUxXa2NqRnF5b1ZoQXpTUmx0SGtiY1YyRWVlT2YyQmpZ?=
 =?utf-8?B?WDVweEpuRnZZcEhFbTRqV01Lbm94cWZHTHU5bzEwRENOQzZjZ2h6VVhnbEp3?=
 =?utf-8?B?S3dmWTFjZ1RqYXZ2TnlOQnNpQStPNXpjOXpmS0p6U2Rsd2xmVmxrT0lMbnlP?=
 =?utf-8?B?SGdDeXJ5ZXlacGZyV3d0QWVFckM5TmVoM3B0ZjYzVnFIOXVEQ3k0aWkvVlFa?=
 =?utf-8?B?M2I1d1VXRjlKZ1RPTGtCYU1Wek1nR2ZDVmUzUkY3RWt0Z05lMGNyYjFZd0h3?=
 =?utf-8?B?aHQ1ZnFBU0s0TUlvZ0RSR25CeGZGek0zZTJqZkNJV1BDbkx6VDlUSzdVdEpl?=
 =?utf-8?B?M2pQVGFwb2UyZTFCcWRTQjMzLzY2dEEzeURWRTFnYUNMdVRIMW9GWGJwTkJ5?=
 =?utf-8?B?T1NISXZ0dVFJY1E4SG83UFpvbEMxdzVWaWVlbmJQRCtGRzB0TU5ML0tPOXB1?=
 =?utf-8?B?K2IxeUpyNHlHU1dBcXVXU2tvbm1FWUxjbTMxUThZenRWQ09mSlNwd0I1RFZC?=
 =?utf-8?B?U2N4Q24vL0pIdjFNcHQrdy9sUlFaZkFVSnp5T2hQSlJlOWJ6anhiUGlzQjQ3?=
 =?utf-8?B?UG9kOHZybTRjVzhWRzVhS1kzS2IydjBvY3RQVzR5RSs0WFIxaTBDZjZJL2lQ?=
 =?utf-8?B?SmFBVnNOMFNVY28wTGp1TXhneGlncTljWW9PVEhhOEpaZWZGWUVxUUZtMjl5?=
 =?utf-8?B?Y0ZrdmJRazNjR1Eyb1ZWSDJnYitCT1M0SzVWWjY1b2NCRFJkYlB6eGIzZTFz?=
 =?utf-8?B?TmsxUnhCcU5tVHpaUURFWXBCaTFQRGFWcGNVejM5ZVRJRVF5VHByN0hoV1lD?=
 =?utf-8?B?d1UvS2h5WFB3UXdObStYNmhiWmlyUGEzanZXMnFCalNTM2Z1OUZUZlZGenZC?=
 =?utf-8?B?bUVuRFNnbCtrRHk0a05xdXFiWm92ejJrTlEwbDFuNEpnL0xIdEY5MDROVDZK?=
 =?utf-8?B?N2ZEa1VmTXcycWxGOHZFa0duZDZ4N2djSVZNZWphN1hMbm9LUlB2bUZ2Tzd3?=
 =?utf-8?B?TDJQRDlBWTh6VmtWdHpjdUVRakQzNVczbmpxMU1SVEVPVFFndGZDUUR3Zzk4?=
 =?utf-8?B?SDFPK1labnBxQmVtWDZsenJmTEJDNWRtdmlzOVVCMmUxNHRnVzZFV2tielIv?=
 =?utf-8?B?QzZHMTJXL3V6VStPajQ1QjdzMHBOSEt4cEdyWXg3dk5nYXB3S2FiU0NRajZB?=
 =?utf-8?B?M3c0RlZoclFwSnRFb3FDZGcxSEs4eTNFdjZhYTdwZEdkQ3pDdlVSbzA4Z3VJ?=
 =?utf-8?B?NytiSS9jZlhTMHhLQXpHUldVZzY1SW5LdHBEVzk1RTVoYU1SS29LbW11b0Rl?=
 =?utf-8?B?MkU0a2drUkdWeWVXZlJUZzNVUXVaN3VJK3Y3RVBnb2lPVS9zWnowb1FJaWNq?=
 =?utf-8?B?Sm9nK3VhNGlUQks2QVhRRVFvVWxaWHZ6OFAzZTBBSGUybjc3a1h6eHFOaVND?=
 =?utf-8?Q?Bd8gpoKDfSdrmofKh/qDjK2dLJbj+lb4?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?RnVpMXZFdDVSMy9aUnkxY3JsRW5LNmNPaGM4Qlo4d2RVd3RLSXppbXhCTFNU?=
 =?utf-8?B?Q2QzSGw0MEJieURqOWRyRnZSUlRCZzhtSldnbkN0MW1Uam9KUUxseXFSc2lL?=
 =?utf-8?B?b0daZ1ZPOThaUFg3d2dKNkVBaTBjT201VlpSeUFHT0l5WHZYeGZybVF2bmd0?=
 =?utf-8?B?VnFQY2ZSUk9Va053VE4rZEV2YjJFSGRNYWpOSU52aitZdi9zL2IrM0xYcURL?=
 =?utf-8?B?Q21VdXB2amZMdFIza0ZLQ1hDVDJFNXp2Yyt3NzFmTHdsbFhBZ0Z6dUhINlZk?=
 =?utf-8?B?aEpUVUNtbUhONVFRanl2YkV1RTlieENwdCt6T1d2NFVMM0pVVDJNTWFkYmlx?=
 =?utf-8?B?VmwvMlBNbWpCVUc3QlRwNUlhbXdhbXlnNUNQbHpsT0h4SnhlREUrTUJ5eXo3?=
 =?utf-8?B?d2JPN0hNdlBlUk8xa3hTUUlqRVJMRnVZUEh2bWdYdzdrSnQzcWtqQjY5d3Qy?=
 =?utf-8?B?dVVYVDQ4Mk5LZGNGL2NPczdDZ1BRS2crOE44d3YvcUtTQkd0NERvMTNCTVli?=
 =?utf-8?B?L0M5TVFiY0lzRTVhbkZVbnpzampYUmY2MWlMQUlCQnZ1cnRpUnhoTng1TnpN?=
 =?utf-8?B?dmdqemZTTWt4K0FuTjlQbE1GMHlBNHRuanREaHNFdUt4K2VjVTRUZXlYY2hK?=
 =?utf-8?B?OGNHdE4wUEpTUzNzdmphSEpVL0lpd0s5aDN5MklTRDFuV3psVno4Rlc4dGJX?=
 =?utf-8?B?RmhETWFZY2k3dnJSTS9IeTFTY3ZGcDU0Y1YvYVoyQTlXcFR5YTdDUkJSZ0Jo?=
 =?utf-8?B?RVBXcDBGTHNYdjcyYUgwMDBOdnBnMnAvMGRudzJESkI0b0dFWFRlNnRBSkRQ?=
 =?utf-8?B?dnRCbUcxdmIyMFU3ZmxPSThtZEgzbHNGTXRRUDFMQ3U0UUdOZ00zMDdnVUdL?=
 =?utf-8?B?RG1WS2RLR0hjNi9HTElXSjY3SzdCMGg0SVozdDRuMDBGbVlVYkhiT2luejJm?=
 =?utf-8?B?ZzRoQUJCK2lYWHZibC9iU1l5Y1lhNXErei90YTR0eWlxWUh5T0syZkVDY04x?=
 =?utf-8?B?SE1RRWRqdVZSTWYrdGFPSUZCVGRIWnFlbUY4bHlFL3ZKT0YyVU9lTXEvVHdC?=
 =?utf-8?B?OGVtV09YTTRYemtEdlJyMktSYW5vMHJweEJ1dHBoRmw5a01saCtKVHB1blMy?=
 =?utf-8?B?V0hvd0tZY1VQcEkzTDR3Vk5wb0NnVitaSTM3SkdFeUc1VFFFcGdmektVek5s?=
 =?utf-8?B?T3djb0NvTzJaU1kzN0J4ZzI5cURBekZzWm1udHJKckRVdnVQOE11UFVRZFFX?=
 =?utf-8?B?a3lPa3FsN0NlSFdzVTZRYlFWS25jMk8zWGpNN0Y2ZkF0TlZhUDB0eE91Zzdk?=
 =?utf-8?B?QW5SK3N6U3FpWTVOczR2NUhENXNXOG16YWVmUnFscUQrK254eWgwcUs1TGJG?=
 =?utf-8?B?bDlpZHo0UlFaZVU3ZWp3U3puMjFXbVRIM0NmTmlHV05QQ2ZMU1dUYVg0aFlm?=
 =?utf-8?B?bWsxbERobFc5ZVVyNEs4THc0WUpLZWtNcFlqMzA5SGFxOXM5YSt4YVpnd2JX?=
 =?utf-8?B?TjdiZXVLeE5oYXdiN0h1K2tSMExUV0xZdTFjMnhlQzVsM0NPVnUzZVY1MHFn?=
 =?utf-8?B?WTk3UmNYcnI4bU10eEtPdm1RUkZ5S2J1KzFRUjhTSWFzVkl3bVlJRVVBRzc1?=
 =?utf-8?B?OU1NTXN3QXllOC9RZ2lNL1ZKNzhiSG5FYVRkK1puOXAxL0xxT1BhV056dG91?=
 =?utf-8?B?Y1R0UkpvalcyMkpISTRSUkh1TEhUcDZkbjhzK3YreTBjM0JjQk0zMzNoSzE4?=
 =?utf-8?B?dWpaa01LYUk3dHhJTDhSdFJyR2lPQURSc1Yyc3FoclQ2RnpBN2pzbkFhWE14?=
 =?utf-8?B?Q2FxVzhqZlVPZFhXT05YRk9Pb2phZGs4VS9ZVG1BMWdrMU1hZHVaNVVFS0ZX?=
 =?utf-8?B?OW9uZjVUM3lWZkFCMHlQaGo2aDg4MG0zcU5RY0g5YUF6bVBlZlhpTEUxd3lW?=
 =?utf-8?B?RkVpMkg3TDVUdHBwb1pGYXBxVUxtNS8rRHVYaE9tb2Yxa29UaDRyK0FFUUJw?=
 =?utf-8?B?aWlVZHhVOU5LbHRCWEZ0b1lEa2g1OXg0RWo0ZGRkNUROYnpkN0J5bk4xNENp?=
 =?utf-8?B?VFR4bGk5S1ZoNUsrU0FRTDk1djdQZzBYOGtUdWRHQURJMFdLeW9NMXo5OEtX?=
 =?utf-8?B?QmVnd29VRFEvaDljbDk5SG9qczd2ek9pR2tXa2QyNkdMUlNHTDFxMUZOVFhR?=
 =?utf-8?B?TFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a01c4d28-c877-4997-9ef0-08dd68506ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2025 08:14:42.1357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KquCnMpiikIbNRzMa3kj9jdojW8GqnUWZPEEi9WSWcA6oD6MAYRJcCCL6Ed+TDhwg+CQZnObCK6t2vpIHsmHE3VSrTtbukHHnU51toXk07R+pubtVFVikAcqviU3h1fq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6435
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Mar 2025 08:14:58 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18306

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTU9FU1NCQVVFUiwg
RmVsaXggPGZlbGl4Lm1vZXNzYmF1ZXJAc2llbWVucy5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFy
Y2ggMjEsIDIwMjUgNToxMyBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmc7
IEtpc3prYSwgSmFuIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBDYzogaXdhbWF0c3Ugbm9i
dWhpcm8o5bKp5p2+IOS/oea0iyDil4vvvKTvvKnvvLTvvKPilqHvvKTvvKnvvLTil4vvvK/vvLPv
vLQpDQo+IDxub2J1aGlybzEuaXdhbWF0c3VAdG9zaGliYS5jby5qcD4NCj4gU3ViamVjdDogUmU6
IFtjaXAtZGV2XSBbaXNhci1jaXAtY29yZV1bUEFUQ0ggdjIgMS8yXSBrYXMvb3B0OiBBZGQgb3B0
aW9uIGZvcg0KPiBub3QgaW5zdGFsbCBrZXJuZWwNCj4gDQo+IE9uIEZyaSwgMjAyNS0wMy0yMSBh
dCAxNzowMyArMDkwMCwgTm9idWhpcm8gSXdhbWF0c3UgdmlhIGxpc3RzLmNpcC0gcHJvamVjdC5v
cmcNCj4gd3JvdGU6DQo+ID4gVGhpcyBhZGRzIGFuIG9wdGlvbiB0byBjcmVhdGUgYW4gaW1hZ2Ug
dGhhdCBkb2VzIG5vdCBjb250YWluIHRoZQ0KPiA+IGtlcm5lbC4NCj4gDQo+IEhpLCBjYW4gcGxl
YXNlIGVsYWJvcmF0ZSBhIGJpdCBvbiB0aGUgcmVhc29uIHdoeSBhbiBpbWFnZSB3aXRob3V0IGEg
a2VybmVsIGlzDQo+IG5lZWRlZD8gSXQgYWxzbyB3b3VsZCBiZSBnb29kIHRvIGhhdmUgdGhpcyBp
bmZvIHNvbWV3aGVyZSBkb2N1bWVudGVkIChhbmQNCj4gYWRkZWQgdG8gdGhlIGNvbW1pdCBtZXNz
YWdlKS4NCg0KU3VyZSwgSSB3aWxsIHVwZGF0ZSB0byB2My4NCg0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBGZWxpeA0KDQoNCkJlc3QgcmVnYXJkcywNCiAgTm9idWhpcm8NCg0K


