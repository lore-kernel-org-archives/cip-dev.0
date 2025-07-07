Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1C1C8303C
	for <webhook@archiver.kernel.org>; Mon,  7 Jul 2025 04:59:25 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.52277.1751864361609982400
 for <cip-dev@lists.cip-project.org>;
 Sun, 06 Jul 2025 21:59:22 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=Yq4HnMQi;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1751864357;x=1753073957;bh=KpZLwGWFTyEAmb9tWIO9P/KhoYf3MCiipBP0ns4
	+k70=;b=Yq4HnMQiGJC/VuKifYREe00h9w8kczOOqUJb/6qdJCBtEqbAWKsPbeKl66wG77ZttRUH8
	aYdJe69oACeF0q/uzM9IQwEurFIZTbMYZMNqYbdNHU/uiiDMJo4mF3CJsv07HIMuZF18+/kTI/1i3
	DOQ0pt1yoKOwAaebJ5qehqDaWLzqJGMDl8wAMRAvGraDfLpk0eJPdO07tzfDXW63ZnKpOa/MxicgO
	yiWCHSN3HPZG3TVynd9ZHpov9FCUtOuNrkdM+sXETAfdQH4nQOr3pnlZCsdtKHbATeF0UdMrBTgwM
	MWezSsmqP7K9+U8s9XTcxv8w0nBviHMRnb1l1CSLEw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 5674xHeA599959; Mon, 7 Jul 2025 13:59:17 +0900
X-Iguazu-Qid: 2yAbuzQy4m8z1bTSGi
X-Iguazu-QSIG: v=2; s=0; t=1751864356; q=2yAbuzQy4m8z1bTSGi; m=3+Iua/HAsNBLQdRZ1cNvXmOaszaQEiy9Fkq/Aacvhjg=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1800) id 5674xFSD2729859
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 7 Jul 2025 13:59:15 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y40LI2uQS4c1bpYMiV1vbQiuTwtbbvHpLHPqVdlovF/awJQ8UNpCIEgEhHH/WtZkbym0JsGXWc7fWG3CUmTNRTlOdP4laID6LAk7Q/Aow469aiyz76/nAdqgvo9khjS2Ahh5rSqtA8xBxVEDPdnzhfzHL6Kmg4pD10f1MB53t7sErXAl2qkkLf43DU9ZiLTC6D2gT94EB0+Th7VaZqJ6EIDjbU1nnsXEgE1JIWWvFzujgaF4ew24GJY+6sSflTM/IF8E2qA8rMIZcJ3gz1tKrs+twK4bqzNeOhSRMaWC1M1A0axX3HjICGaUfSkrxy0b6kedglK01Os1UXZxu62izg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejEEN9sHoK+MJA5eMmQaDv1B7egqz/Vj7F1IIhZmjfQ=;
 b=IQzcK6xMFwRvbk1W1T2yPC0ckqkxiJt8Nb4y+w0C2LFbF/appif9jskTv9++zhLxJMxemqdr8AbzyuljIoHChlxIfMer5froBOFIbr4t+KruLcuvgwt9095sFNqQWn+Eyi986H1kimYvEFJVoDtNpYTruoBcLme8sWO9whYpDD2yifBpE/nvTGyXEGJmrv2CG0g2VqJ83BqdDSqTTZ0cDav7tudeKoNpXuOgsWBS/EK5jW/XKx+f/3KKPJRnLDLVzQ7Z4m5FLFyWHEpnXRcjYTuOcMGEI8mLIePh7PohXvcqOQKI1dVhRLYtDVuKrfc6Qa3RSIWdyOohjB+zofZYCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <tommaso.merciai.xr@bp.renesas.com>, <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <tomm.merciai@gmail.com>
Subject: RE: [PATCH 6.1.y-cip 00/14] Add Support for RZ/G3E ICU
Thread-Topic: [PATCH 6.1.y-cip 00/14] Add Support for RZ/G3E ICU
Thread-Index: AQHb7MLsn4iec7Y4bk+RQMGKxXpO57Qlv32Q
Date: Mon, 7 Jul 2025 04:59:12 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818EB0CC35194105AFFD671924FA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
In-Reply-To: <20250704090556.669652-1-tommaso.merciai.xr@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|OSCPR01MB12816:EE_
x-ms-office365-filtering-correlation-id: 5663b955-5d57-4830-3dcd-08ddbd1303e9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?N3NORFJXa1ZQTTNHZmplUTFFa2hQVlI1bytMTmU1ZG5IUXA2RG82MzlT?=
 =?iso-2022-jp?B?TUhsaXkzeWhHRnVnMUtLQnFxK0FXZGRkRFpzaFB1U3VxOTZHMFZ3ODJs?=
 =?iso-2022-jp?B?Wkt2NEllSklKaTZMME9ORmZmTXZlblRkU0xaVE9USnlGd1VmMzczcTJ3?=
 =?iso-2022-jp?B?WExkRUxsRm4wQUs0NG9ad2FoaW9YaWFSTzNwS1plaXV5ejZ4RnIxWHYv?=
 =?iso-2022-jp?B?a28zSDZMdEgyaVRRYXZLTC82WXRWZkJYRTdGOXVhUytRdTh2N0t2U2hV?=
 =?iso-2022-jp?B?NG10QlVGRTdUVFhrdVRRWVdabG41Q3pyNitPcEd6V3VEZXpwNzAwY1oz?=
 =?iso-2022-jp?B?WUd5cXpoWmpUQTlkc1F4UlNoZ2daUUNTYjBaQ3IwaGliM1ZTdThvWjVK?=
 =?iso-2022-jp?B?bnBDdTNxR0FHMzVOUldMTzhXNDRRV3VXbjJpQVFHTWlSVXlQT3QrYUJH?=
 =?iso-2022-jp?B?TWFDWCtwdUt1S2FYQVBtRDV1YmJLVkZ0dzNSOXZGeFM0MFE1bGJzUlBm?=
 =?iso-2022-jp?B?R2Y3U2xCdmRoYjRaVFJOTXpRN3IxVCtpdjBZR1dXWitUV0IycWhWbEh2?=
 =?iso-2022-jp?B?d3dPRjBDeTUraFNvd1Nzd05uMVQyWG5FeUl4RWE2REtrY1ZVdldHVWZx?=
 =?iso-2022-jp?B?TVR2bzl3bUxZeXhYTHVKdnVKQ0lvVkFSK1NvQzdXejFKRURaRUtVa3A5?=
 =?iso-2022-jp?B?eTRyUlpSMnhtYmV1eU5ya1pTdzRwV2p5d2l3azNOZzNQTDlvbDVzVk9W?=
 =?iso-2022-jp?B?S2NyZjFpNUpQNkVnanpmc2NqenY0dXJ0V29VbEZ1bTI3MFFOcEV6bVds?=
 =?iso-2022-jp?B?SXVWYVIyZUhBeHpRdUZBNXFaUGJ4NmwyKzErSFFoVm1ZVXVsMTQ5TDZz?=
 =?iso-2022-jp?B?RDVyV0RoWGxKU0Q2NlJuTW5JMU9EcVNuVGtRYzRGd1p4M1dlWFdhbFNq?=
 =?iso-2022-jp?B?NVNPb2ZKdjJFbjN1em5ZMkZzRE1QeTZDNFdvL1llTVYyZEpES21VRk84?=
 =?iso-2022-jp?B?RHZmNGYvcy9mVnowdnNONjMxdG5CckdDbHljVmJydnYxVkt3RGljejVw?=
 =?iso-2022-jp?B?TlVjQWUvdXN1Y3p6K2Y0TjQ2eFErelVHZlNGMHRhM004cGViYlA4THhR?=
 =?iso-2022-jp?B?d0JjVTdKUjVDb3dUREhrSS9IY29LWU9VL3RnSTZXMDUxWDFmcVNNUXlw?=
 =?iso-2022-jp?B?VUNpZTBjTUtwaFdlY1lYbVR2WkR4ZU03d2pHMXBZbmZmZ1dXWC9FclJ0?=
 =?iso-2022-jp?B?S3NBYWFsT01ZTCsrb3p2SXkwa3ZLMXhHRERmZU0yaWx5RXJZWXRoVGNV?=
 =?iso-2022-jp?B?dSsxNFZMamdEWW11Mlpwd2pqVnllTzkxUjRmOE03QnkzOWVIcWQvbzlu?=
 =?iso-2022-jp?B?NCtSTjV1ek1iQ0ZMU3BrZTltS0dXSk04WGNaSldrTW44bzlaSVl2aGx0?=
 =?iso-2022-jp?B?UVBsb2NXUHFWUjJITkxOcnE5UXJVaGFTTG5TN1VRSVR1djdmZ0NpSDk1?=
 =?iso-2022-jp?B?RWkwODFycXByUEtTbm9kbW84cUE1YmUyc3g3WFNjTjVpODIrZjJTakZi?=
 =?iso-2022-jp?B?UHIwYmVKbmtwK2Q5eTU0WlNsY3JhSmxkQ0ZlNTBYeTkrajFPdDc2NDll?=
 =?iso-2022-jp?B?dzdjUlVVY00vRlJVNEJVVjh4a21uTDZmVFkxN2lRL3FPeE1LNVlYd2xi?=
 =?iso-2022-jp?B?bEFNZ3VZK3B4OXRhMWF1K2NIaDRSZE1pUTFvVy9aR2NYRVN4VUpTUFJD?=
 =?iso-2022-jp?B?ZmROeDdPbTFUOGZhWkRRQStnTDhUWk5yN0szUlVRcWlkMi9EZjNOVmNa?=
 =?iso-2022-jp?B?blNabTcvMEZ4WHB5Z285bDNUcy9SeUkvdlozTDJkM3IwcVgyNFhDdjRm?=
 =?iso-2022-jp?B?WE5QZWd1K2o5ckhKWitDQnIwelBKWk5TS0hVM3FKOUlNemQzeGpPMmZU?=
 =?iso-2022-jp?B?TnNqZ3A2dHhCTWtlZUhjekpNbXJQZTJXL29nS0l6T1dXYWw4UDZiNGNa?=
 =?iso-2022-jp?B?d1NSVE9BajZ1VlhldzlrUWhwV084MVpWQzJMZStOUENzZHpYQ0RNSU9h?=
 =?iso-2022-jp?B?STNkdVYzc0oxREJDc1JRakNpMXNocUVNdTdOa0lrZVhhaGt5dWE3bWNH?=
 =?iso-2022-jp?B?dlJUdHE4Ry9sSG9ycEliT3R4YzJLUFZtVm9aNXNqUCtwalIxV0lXSDFK?=
 =?iso-2022-jp?B?Q3owPQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ckxxN2E1OHJOTVBFU1ZOT1ZXVkwvaXJ2b0RrMk45TGhCTUlNeXhIZEdh?=
 =?iso-2022-jp?B?azdyVVcwWEhpSFpsZlNFNmJueXZZMTJ2Q0ZTZGVTYVR2cHJrQzQzcEkv?=
 =?iso-2022-jp?B?aWdiMXhuWE01dTNTWXIzTE1yOTlZcmdWZzc1bmNUalBOa3R0N1p3UnI1?=
 =?iso-2022-jp?B?VlZmOWZjcEFkMEhyTWNacFNZT0d0dXdYWFhaMWlkUTJiNm9VSTJ3OG9K?=
 =?iso-2022-jp?B?RnNPVVNXNlpNYXBialQxRmNRREw5UXFYSUMwOCtSUGRPM3Budzd4Mnk5?=
 =?iso-2022-jp?B?K3J3Ukl4MVlnaWtNOHU0OHpLVG1hQW5jVlpoWmczVG5HN0NBTDF1WE03?=
 =?iso-2022-jp?B?eVltUzNDY05rZGdwSktaaVhPM1FzZkI2SEZRK3BubHBUVXptUjNUNGRC?=
 =?iso-2022-jp?B?c0tBV2hkZEtieWtWeUV5YUxxZkRMQUVuN1JJZjdJYzZ1Q0dPREpzc2Nx?=
 =?iso-2022-jp?B?OW1aSmU5SCtzblBFMGtLZG5jNG1rWkdsd3lqYzhLWWRLbWZRcERmOVJz?=
 =?iso-2022-jp?B?bDVYQzNnU3BxdjJQQ1h2dUVreUZraVVlVjlPd3U2elJUd3hZZmNVZVc0?=
 =?iso-2022-jp?B?RzdBRFdCQzZidFJteFlYSkxTeXpmL3FJUkJwUTNTZmFDTUtCZjZxTGVW?=
 =?iso-2022-jp?B?cTgwR21haVJXZ3F6Zk50Y1lrZkt3UmxuaTE2UE51dW1zVUs4QkJtYkdu?=
 =?iso-2022-jp?B?MzgrUUYxOEdOZUFMRnRiR1JCOE5OMUtOZ3pYTENIUHlQMjJiREZLeWJr?=
 =?iso-2022-jp?B?SkQzNlJkL1dtNkRJOUxwOG8vYmkvTVM4SnpUNXZJR0tORWtmK3N2YU9O?=
 =?iso-2022-jp?B?KzRYR0lyRFlURmZIcmpaSllRbXAwODRpZDBERXBYdzJNVU5YcXpXbTdC?=
 =?iso-2022-jp?B?cHJxMGFRODF3M21OWjZxUGdYUVlQclVrRXFlZi9sNUxyamtGcGpFei9E?=
 =?iso-2022-jp?B?NjV3RUlTUG9RbzZzSDFNSmVvUTVEWjJQdWNncktsWEdCbUViOHNSeHRq?=
 =?iso-2022-jp?B?ZDNEczZRclhOdFA5V0JYUmk0SHUxRER1WEdhQ0IxQ2s3b2dvbVFYZjZs?=
 =?iso-2022-jp?B?TmVwMTlXMUJ1b3hEU2NsQURjT0NmYnZKbjlPMysxVUZHYmJZQXBvODQr?=
 =?iso-2022-jp?B?ZUFqeCtMRW1DZlpmLzRhcHBBYkVkenNXTDAzZXErSFJNNmNSN1dDWTNl?=
 =?iso-2022-jp?B?OXVrSzNTdGxBR0pUeVVqTXlwNUNEVllUOGZqL1dQQ0hNSno0R3BZM3Bi?=
 =?iso-2022-jp?B?MlVBSlJiU3VaUUZLNElHaGkyUElzaVhuYit1NHN4SGEvZ2cySitqWTFC?=
 =?iso-2022-jp?B?OFpXZUdWNnFPdklaRWd6dzB2ZHJ3bWUxdVdYbDVsMEdzUmJXQzNYWG1H?=
 =?iso-2022-jp?B?NnJBUnA1UEJxZXdKTlE4cmFETURZWFVjWXo4Nmx0N1J0bGlqRUtXRFlU?=
 =?iso-2022-jp?B?VDh0UmVmVkFnWGNvRWxvMTg1WnVKTVE2MEtITjRqc3VjWitFcHF4ZGtu?=
 =?iso-2022-jp?B?Q1Q0d3VHNmNvZlVKc3MvRnZTbHYyai9wanBseGViMlE5QlBoZlZwMzdE?=
 =?iso-2022-jp?B?cFJzUTRmZjI1eTRiVmNJYSt2cGJrWWM2cjFTOEVjQnpXaStVRkpEYjJP?=
 =?iso-2022-jp?B?cVZXSHRGUzljV1dNWU5Ka0NvdTkrS0FWck1mdDBBV1U3V3pxZnpoNjlE?=
 =?iso-2022-jp?B?TEVaOUppQ2QvVGhvNS9TMmZURGNiamxZRFpBby9oV0pVVFZXZUFtbG9l?=
 =?iso-2022-jp?B?MURuOXByNDRkdG5IbXJzQnhEejlvMFJMK1JHL2l5dVdpS0dFR21ESnlN?=
 =?iso-2022-jp?B?VXhJRU1jME9TTzk2dUwwcWNxdzF6WnhUbEgvU3oyblhxYkxrbytxS1F5?=
 =?iso-2022-jp?B?dE5SNEdXeGFXdENCZFhZZzI4YU0vRXlQYUY1WW5Ha0dPalRkbmhWV2Z2?=
 =?iso-2022-jp?B?RWEwMVhBbmxtNW9YWXZOUzhSb25CckR6QUJmZW8yM2dJaXFKYlI5OTZL?=
 =?iso-2022-jp?B?aENnSXJ0RjNQNkp3RVBRUlhyV1ExZ0U3Nmt2VzQ3dXl4WWphSjhkNldQ?=
 =?iso-2022-jp?B?MlpJWmlOTGl2RnNKaTV3WG1ES0d6czU0TUI4VWQ5d3dwdXAvZUtZNlhB?=
 =?iso-2022-jp?B?KzcwUkFoRG9pM1Q0SkZMNmtjRFBKYzNqeXRSUWhkQ0RiVG95UHFWQ3Vl?=
 =?iso-2022-jp?B?VDZ2TUk1d0ZPMkxDLzRFTHJESUZTczZORzAwZXZXRG1QVHFjUXQ4VktG?=
 =?iso-2022-jp?B?aXdGZTZOazVVUHFDUExOeThES1A5elJ0amQ1TWRrSWQzei9MbEVyOE85?=
 =?iso-2022-jp?B?eVBqM211WkY5UXdteDVlSXQ2Q2Z4UDhmeVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5663b955-5d57-4830-3dcd-08ddbd1303e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 04:59:12.3914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TYS0DIJURYjg0YFQQz0wzeKm4ClpofezAOWWLatjFm9X/UyDWZKHBPUfDKqjbhJcBji9JqSUPTbtsSp8PRy+ec37zUT7hm/q7aeVch6l4tBNRTQ+ANRt+LzsZQ0Dwa5x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSCPR01MB12816
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Jul 2025 04:59:25 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19366

Hi all,

> -----Original Message-----
> From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
> Sent: Friday, July 4, 2025 6:06 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B""#D#I#T#C!{=1B(B
> =1B$B#C#P#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Machek
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; tomm.merciai@gmail.com
> Subject: [PATCH 6.1.y-cip 00/14] Add Support for RZ/G3E ICU
>=20
> Dear All,
>=20
> This series adds support for the RZ/G3E ICU driver into linux 6.1.y-cip.
>=20
> The ICU block on the RZ/G3E SoC is almost identical to the one found on t=
he
> RZ/V2H SoC, with the following differences:
>  - The TINT register base offset is 0x800 instead of zero.
>  - The number of supported GPIO interrupts for TINT selection is 141
>    instead of 86.
>  - The pin index and TINT selection index are not in the 1:1 map
>  - The number of TSSR registers is 16 instead of 8
>  - Each TSSR register can program 2 TINTs instead of 4 TINTs
>=20
> This series applies on top of [1]
>=20
> [1]
> https://patchwork.kernel.org/project/cip-dev/list/?series=3D978149&state=
=3D%2
> A&archive=3Dboth
>=20
> Thanks & Regards,
> Tommaso
>=20
> Biju Das (12):
>   dt-bindings: interrupt-controller: renesas,rzv2h-icu: Document RZ/G3E
>     SoC
>   irqchip/renesas-rzv2h: Fix wrong variable usage in
>     rzv2h_tint_set_type()
>   irqchip/renesas-rzv2h: Drop irqchip from struct rzv2h_icu_priv
>   irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
>   irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable
>   irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info
>   irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info
>   irqchip/renesas-rzv2h: Update TSSR_TIEN macro
>   irqchip/renesas-rzv2h: Update macros ICU_TSSR_TSSEL_{MASK,PREP}
>   irqchip/renesas-rzv2h: Add RZ/G3E support
>   irqchip/renesas-rzv2h: Prevent TINT spurious interrupt
>   arm64: dts: renesas: r9a09g047: Add ICU node
>=20
> Fabrizio Castro (2):
>   dt-bindings: interrupt-controller: Add Renesas RZ/V2H(P) Interrupt
>     Controller
>   irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver
>=20
>  .../renesas,rzv2h-icu.yaml                    | 280 ++++++++
>  arch/arm64/boot/dts/renesas/r9a09g047.dtsi    |  90 +++
>  drivers/irqchip/Kconfig                       |   7 +
>  drivers/irqchip/Makefile                      |   1 +
>  drivers/irqchip/irq-renesas-rzv2h.c           | 602
> ++++++++++++++++++
>  drivers/soc/renesas/Kconfig                   |   1 +
>  6 files changed, 981 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/renesas,rzv2h-icu.=
y
> aml
>  create mode 100644 drivers/irqchip/irq-renesas-rzv2h.c

I reviewed this series, looks good to me. I can apply, if there are no othe=
r comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


