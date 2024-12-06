Return-Path: <adithya.balakumar@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E41D2E77173
	for <webhook@archiver.kernel.org>; Fri,  6 Dec 2024 12:39:10 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.35743.1733488741821983915
 for <cip-dev@lists.cip-project.org>;
 Fri, 06 Dec 2024 04:39:02 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.132, mailfrom: adithya.balakumar@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 4B6Ccxqw654163; Fri, 6 Dec 2024 21:39:00 +0900
X-Iguazu-Qid: 2rWhg4sxyrwCFjOk8f
X-Iguazu-QSIG: v=2; s=0; t=1733488739; q=2rWhg4sxyrwCFjOk8f; m=yT7XmOxDIG1smk0krRdzT5JYCdnsYFMPrj8vZtLL06Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4B6Ccwm03997948
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 6 Dec 2024 21:38:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e90OlOGlca8mn+Ey45gPwL8qOeQiTduOZvlsBBaddHj3RtxAGs+ZnW4e8us5r5IbNGWC1XL7/tKhVHkxHykkgB/yGxQ25b5xLQuAZ9TqcbCTKaop0RcG0MgaOPRSzyh+3L1ibB2cBAiuuQRjZpXI6YSouO584rn/BhHawhcHviGbylgk6r0/Z/nkFPrauYY4Kmmv/YRecA2kOux7/6yyI7kkgjUmU51PApelJ7HnddZgyRLXvckx0BataIfmWYGvx42iydFWkrBeL+z4pfko4D0b8rEyXyGyFgj8DElAFh/JvmRxrD66cfApmeZikzOddvuCf+OxAIbwUX2KjhZUOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EuNiLuuaWX+9N5juqCi0ObtoBlQAYk0us/QaBTCebic=;
 b=Al2f+WNdI3IKZUR65h3irz0D2D2xaJwPWMecyiWwVdjwjJrNrRe7U9uSal2ycSWSep8jMbkOqf/n5Vu+jGCjkk6HUkNppXtVNHmI5psJc9MhmmB/q0RjKDoqCbp8ILmlQsUtxa6SIYufjuAPboXzQRJTrKav/OnCMtfwNjdSZXFycrJXCRls6y42BlRTbwvnRqWm/yRlAd7XHyvdxM+YtbMdcjkvHlVVZNzhAOVTsYGw7/PMR0khj3+iOvPW9bzS7eShtszUUTVZsfVerbcyuqHXPT9a3KPOUB+OcKmjkKQgzuXCHLyEM6dOFi5rH64oCXpJp1BnDb8tFIXS2uzBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Adithya.Balakumar@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
Subject: Re: [isar-cip-core][PATCH] Update isar revision
Thread-Topic: [isar-cip-core][PATCH] Update isar revision
Thread-Index: AQHbR8QCsCavDUjcnEuwFBF+g/9NRLLZJTus
Date: Fri, 6 Dec 2024 12:38:56 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYCPR01MB9669290CAB5E0F4DC7E468FBC4312@TYCPR01MB9669.jpnprd01.prod.outlook.com>
References: <155e2bf8-3a8f-4760-be0c-fefdd0bba180@siemens.com>
In-Reply-To: <155e2bf8-3a8f-4760-be0c-fefdd0bba180@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB9669:EE_|TYCPR01MB6688:EE_
x-ms-office365-filtering-correlation-id: 5a5c6efb-ba88-468d-2400-08dd15f2f34a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|69100299015|1800799024|376014|366016|7053199007|8096899003|38070700018;
x-microsoft-antispam-message-info: 
 =?ks_c_5601-1987?B?eXlsc01UaS9xd3BnQXBYYTJQN3ZtdFhVTEtvbUJIN1RLTmF2cVpv?=
 =?ks_c_5601-1987?B?WXhLUkJrKzNPNVQ3YmxiZGVBcUgzM3pZZ005WWg4TmkwcHJ6M1Rr?=
 =?ks_c_5601-1987?B?TzBTcTRUTTBkc0xhd3dJTERlK3l2VHRwQzlpWXprUkFhanBXYmp0?=
 =?ks_c_5601-1987?B?S1pZN3ZDNVRMdzBvUVBQbWNoL0l6UHVOR2ZDSzVRRTdQVWlXczQv?=
 =?ks_c_5601-1987?B?ZkxVcWwyU1gzTUpXR1puYkJ4TjZibDVnU25lRWQzVERkNFp1cEJE?=
 =?ks_c_5601-1987?B?RlcrTUl4SkxXdXptcW5kSHc1NTBjK2grYkxiZUNQcCtKL3BnaC9z?=
 =?ks_c_5601-1987?B?UldUQlBPbjRtTnJ1bE8wL2R2dldQV015bVFIVHVWdDlnQ3E4NUM4?=
 =?ks_c_5601-1987?B?VUhsUzRGSnNodktFN3l3VDZJUjV1cFp3aFdzZ0Z0NnBjUWVQc2Vv?=
 =?ks_c_5601-1987?B?TnJSQmpEa2RqR2tHSWJtVXAxSmt3QTgxQ0I0aEJ2L2NhSk9RdTRr?=
 =?ks_c_5601-1987?B?eHZCNWhpbmJwbzJVSGM3VC91aTFHUUFDa2NxZzZwZHFETWh0YU5R?=
 =?ks_c_5601-1987?B?VG11RkJJOW5qQ08xVFRpTStrWGp6Wi9QQk85UkdIbTB3SkhiSnJS?=
 =?ks_c_5601-1987?B?eHVIQmZhbjdidTQvZlRVNThvZEFSdUE3Zm9NaHAyM1dXV1Q0Zy8y?=
 =?ks_c_5601-1987?B?UlRlODVNSS9mdkgwenZrVzBzemdlYjdYT1puNlNLQzlKckpYUGh4?=
 =?ks_c_5601-1987?B?TWYyMjlmZ2NpUVZTR3lXK1hScG1MM21ZUTY5SnQrUlRSc29lYloz?=
 =?ks_c_5601-1987?B?YVRGYU55SS83U24rTFdDS3VDZEk1RkFnOGhjZSt5VGRaUXRIbnNh?=
 =?ks_c_5601-1987?B?ajIxcDNXYXNvVTBtNEpsYjRsc1h1eU9ybGtldkF0SmdkWjVrclBO?=
 =?ks_c_5601-1987?B?bnJ6VG84TjNNYWhhWW1YOW9sQWx2Q0svUVorQ1lCZUVsK2pqc2Rx?=
 =?ks_c_5601-1987?B?M01CMEtoSzdMZ0xQM2FveWY0dW9oVUdFcE1IdUV6d3YrUDU1bzU1?=
 =?ks_c_5601-1987?B?MDJaTlM3OU1DOUFVRDFXQUVmbFU5NnV0VHh4eE1aTUVZenpncW41?=
 =?ks_c_5601-1987?B?K1Bodit0OGR4S241WmpWeC84YUtkL1NNeVcvWHcrUFVLZEtKNUkv?=
 =?ks_c_5601-1987?B?RjN1UlJ1YkVrTXFBU3dVU1JjK2Zta29yamF3YU9TWVRuaFczYmgv?=
 =?ks_c_5601-1987?B?a1YvSzJsMkpDbHE3dlgwZXN6b21taGlKV0ZvZW1EMWMwaDBySmVZ?=
 =?ks_c_5601-1987?B?RXlKeE5pQjQvdHhXbk9yZkJZVVIzUWpENFFQSkd4dkZRV0kvcVFn?=
 =?ks_c_5601-1987?B?YlFyL0NFZ2M4Um5oam1ib3h1TWRKTTVWR0g0NEczNW9pUDdnNlZu?=
 =?ks_c_5601-1987?B?VFhEcVNOZlkxRlc4TWRvemc2WUpvODB5UTVCNStPcUhZTTBxd2Ji?=
 =?ks_c_5601-1987?B?VEh3cFBHMDk4dG1iNjNFM01nbzBScEV2TjVFVmRUN1QrTlI1S0lm?=
 =?ks_c_5601-1987?B?Y3RLcFI1TXBxQWJUb2cwcXlrRmVISk1GUGhUbmo2eXM3YlZhbVox?=
 =?ks_c_5601-1987?B?ajJzelpSZUlDSTN6aEpzT1ExckpvUlNCNWwxTzNMdmFaRW1weEFj?=
 =?ks_c_5601-1987?B?eGxQL21YclFuTEZVaFZrRWk0RHNHZ1ZWMlFzc0FaWmV4eit1TFpt?=
 =?ks_c_5601-1987?B?Y1NVS1AwZkJlNEJwYzBXblF5aWZ5SnY1eHZrZDF4STF4MStsVU1N?=
 =?ks_c_5601-1987?B?WklzSFNMZFhJOEpRYzNUdDZQM3p0eE5leXJwKzBFMG1DdGJGQ1V6?=
 =?ks_c_5601-1987?B?dW9wcXlHaVd0VHVmaWI5ck03amsxUTM3YjQ0bEQ3a0RaTUJDOEs5?=
 =?ks_c_5601-1987?B?Tjlzd2xjOUQvZUxpTWEwR0JxUko2NnF5SUF0RkJ2bkZVSTVLMEJM?=
 =?ks_c_5601-1987?B?bmVmOURlRERsYVBEeDkrWGFQYlFhbFQ2VUgrS2FnRFlZbThhK2oz?=
 =?ks_c_5601-1987?B?Qmp6cHpEcEtUMkZHT09ISG5QZWJINVFyUG1TajgzZDA5UnBZQ3hz?=
 =?ks_c_5601-1987?Q?HArFwZgtQMNOv9W0wLHv8Q=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ko;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB9669.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(69100299015)(1800799024)(376014)(366016)(7053199007)(8096899003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?ks_c_5601-1987?B?SWVTYVJ0c3lRcTQ1VDMyK0JvVDlNWUN1NnhLRjRnRnJVZVVwaEtl?=
 =?ks_c_5601-1987?B?VWsrUUJEdE5KOVBUVmFBRnJuV1R1a2lXWDBoaEo3Skp3azV6Snlt?=
 =?ks_c_5601-1987?B?SGEwS0l1SXBCOFhOWDE5OEpWdVlidWp3TXNCeEVVUGFJZUI4OUp0?=
 =?ks_c_5601-1987?B?QzNsdWIzUWY5b2hQc3lVTjlTdUJMSFM5TXRPRkhwUTROTTc2a1Vu?=
 =?ks_c_5601-1987?B?U0ZXMENDNmZUTXdicW51LzZEZ21NOVMxOG9ZazJtTFJQSjdLR25M?=
 =?ks_c_5601-1987?B?Q2F6V2IwejJJVkE5U3IvVXZCSncrRFN1bFRzU3RYM20vdUNId0Qy?=
 =?ks_c_5601-1987?B?Vks4UUVLQjJlZk5ERXNubFRCckdpY2cvL3VjcXJQdmJWWUdIZnRs?=
 =?ks_c_5601-1987?B?b1p2Q2FCekZOMFFnTnBaRXd5dmRpTXkyUk5OT2xKcENWVTRNS1Y0?=
 =?ks_c_5601-1987?B?K1J6ak0zTTA0ZTMzTGVzbldJSTIwbUxnVEFUTFFtSGduTVpIUkd4?=
 =?ks_c_5601-1987?B?UE9PTjFGaUpORFZFcjlaQWxMNWxMMldEYlhEZURvZlB4TXJYYWFI?=
 =?ks_c_5601-1987?B?OGRXWFh3aHk5dEFYL3NzenFQTFFFTnl0cVpaQkhqVThkVUNWTXJ2?=
 =?ks_c_5601-1987?B?K3Fac1lFWmgzOTVLdytJNEppS0ZSdFBla01xNndxQ29Hd0NuWGda?=
 =?ks_c_5601-1987?B?QzMzTU0vejZEaU5wOTgxMzJrUkpKblF4VE43Z2R3OGluRlFOR0Yx?=
 =?ks_c_5601-1987?B?cGpkbjc4ZmM2STJLbEdtdWZFd2xSR2RzaHU4MDhRTHplNG51TEtJ?=
 =?ks_c_5601-1987?B?TlFHQ283cENBNnZpV1JhVnNpNldqT2pHNnFXVllTdDYvK2ZmOEQx?=
 =?ks_c_5601-1987?B?cVBRam50K2FoZXpMSTBKRW5wMjhxcXV1bWJGZlo5ZXluenMvbTRW?=
 =?ks_c_5601-1987?B?c2hIYkNJOEY2YlNpeUhaMUVFdVJoQ3hQSEswUmdxRUtBeThLUUtQ?=
 =?ks_c_5601-1987?B?YnBnbFZGdTZVakgrYko3UVgvaXFxOTJaOFBoSnQ1ZXdWV3NnU1BC?=
 =?ks_c_5601-1987?B?eDd6bm1hQVM5SEwwSHRvOEVOZE9yWEdmZ21nckdINGhHbEFIRHRV?=
 =?ks_c_5601-1987?B?dzRWVGVGY2tsK09GeDc4R0F5UXI0L0M3eDFNRFNiV09KbENPTysr?=
 =?ks_c_5601-1987?B?N1hYRG1EY3hvaUlBdTVOTDg0aGtYTXZ6WCthV0Q2Z0ZpSWVROHBl?=
 =?ks_c_5601-1987?B?dWJTaTNjMGpSdkRGSEhEQXNhNWI0TForM21jamFPVnhpQk54SmJ4?=
 =?ks_c_5601-1987?B?NGpwdW9MaFV4c1o3L0ZwOXZaZ0JnUlNmdFo1NUUwK1pub204KzQ5?=
 =?ks_c_5601-1987?B?YzdZeU1XYUp3Qkk2ZG9SYlVJZTYvNXd4N1BVQWxzWlF1dmo5TDJl?=
 =?ks_c_5601-1987?B?NGVaRTMxeUIvcXNIK0NxRUFQVllrakdNaGR2dGtsdlVYcUViSml2?=
 =?ks_c_5601-1987?B?VTdtZytYL0Qvblo3a0FzTmw1WGJpbC93bTg2dVQzbTlMNTBtTzFx?=
 =?ks_c_5601-1987?B?QW5qWXg2aHpPMW0wTlhWMFBVU1prcFdvdlpBbTYwd0ZNMHRGZFEr?=
 =?ks_c_5601-1987?B?K0lOMmRHTWVXNFdqQ2ozeDFhdmhDa3phU255NVRpK00vK3ZrNEVr?=
 =?ks_c_5601-1987?B?eFR2dlVqNlNKTGhjYmo1Y0xXVlNMSUpid0c4V2VySHB3amFpTlZs?=
 =?ks_c_5601-1987?B?eGF3TGpYQ3A0V204by82MVR1RGF4U2lCMVhGRVJpZmpVODJmRVQz?=
 =?ks_c_5601-1987?B?TGxxM21XMkJoTktqU21TRjVhM0xVOWtkSDh5UjNMWGo3R1haTDU5?=
 =?ks_c_5601-1987?B?bnoyRUkrLzVvOTdDNVJGRE9mZXEyQXJYOXE2dGNyZFhjV2RYOGdk?=
 =?ks_c_5601-1987?B?MUxTUjZoQkFLak9JNmp5Mml5dlNOdWY1M2ZoV3Z3ckNzZHpTZHda?=
 =?ks_c_5601-1987?B?VzN5elVXTGR5azhJelFCTWdiSFNUdXprTGIvazVQb1diTE1RbUlv?=
 =?ks_c_5601-1987?B?TkttNVJxQUxkY2NWb0ZlY1pNY2M1cDZ3U0FWeHdhQ25mYVFhWjRy?=
 =?ks_c_5601-1987?B?U3N2VUlCOGs4V1J1QVN5RkJiM1M0eW5DY1dycTl0NHNxTysyM1dL?=
 =?ks_c_5601-1987?B?UFBqbWtiSTJ3UEFjaFI4RWZVbHZzUitWRzlsNEdLRTRMaUFENW04?=
 =?ks_c_5601-1987?B?QndsWUtPekk1R3pQODRrWnlJKzJvOFV5eTJOOWNtclZPcWpOYnBJ?=
 =?ks_c_5601-1987?B?NTdaalRtSlhkVFNuTlhjcnRxSjFRSXNPNmY5UWo3UGtnMXE0WjNt?=
 =?ks_c_5601-1987?B?N0lXOEtpbEYyQmF2UTYwZ29SQVJNWTFJa2RGc2Vwbi9ncVhaRUZB?=
 =?ks_c_5601-1987?B?L0FSdDJObkxvVXdjbXFXOFdpMnNjK1VqWmtNdVJDWFU1ZU9NMzk4?=
 =?ks_c_5601-1987?B?U3U4cDd1dVJGclJ3a1VXODRlWHROdHc9PQ==?=
Content-Type: multipart/alternative;
	boundary="_000_TYCPR01MB9669290CAB5E0F4DC7E468FBC4312TYCPR01MB9669jpnp_"
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB9669.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a5c6efb-ba88-468d-2400-08dd15f2f34a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2024 12:38:56.4270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q3JxcpFbEPGMCl5csCC6YjyR/mwgjiX2cF00so5yCiOIjxDdMoRSYKELtB0gh+PlmA6PLvC6SljVzM6bXJQU/TvlRJf79u18lJJjKqTBLc8T40K18ic9wdb/50BK2Dbe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6688
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 06 Dec 2024 12:39:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17365

--_000_TYCPR01MB9669290CAB5E0F4DC7E468FBC4312TYCPR01MB9669jpnp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

SGkgSmFuLA0KDQpUaGFua3MgZm9yIHRoZSBwYXRjaC4NCg0KSG93ZXZlciB0aGUgcmVjZW50IHJl
cHJvZHVjaWJsZSBjaGVjayBwaXBlbGluZSBydW4gaGFzIGZhaWxlZCBkdWUgdG8gYSBwcm9ibGVt
IGlzIHdpdGggdGhlIHFlbXUtYXJtIGltYWdlLg0KaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9q
ZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9waXBlbGluZXMvMTU3NjYyODEwOA0KDQpUaGUg
cWVtdS1hcm0gcmVwcm9kdWNpYmlsaXR5IGFsc28gZmFpbGVkIGluIHRoZSBwcmV2aW91cyBydW4g
KDEtRGVjKS4gVGhlIHByb2JsZW0gc2VlbXMgdG8gYmUgdGhhdCB0aGUgYXJtIGtlcm5lbCBpcyBu
byBsb25nZXIgcmVwcm9kdWNpYmxlLg0KaHR0cHM6Ly9jaXAtcHJvamVjdC5naXRsYWIuaW8vLS9j
aXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy84NTY2NDg1ODI3L2FydGlmYWN0cy9jaXAtY29y
ZS1pbWFnZS1zZWN1cml0eS1jaXAtY29yZS1ib29rd29ybS1xZW11LWFybS53aWMucDIuZGlmZm9z
Y29wZV9vdXRwdXQuaHRtbA0KDQpJIGFtIHlldCB0byBpbnZlc3RpZ2F0ZSB0aGUgcm9vdCBjYXVz
ZSBvZiB0aGUgcHJvYmxlbS4gQnV0IGp1c3Qgd29uZGVyaW5nIGlmIHRoZSBwcm9ibGVtIGNvdWxk
IGJlIGJlY2F1c2Ugb2YgdGhlIG1vdmUgdG8gdGhlIG1lcmdlZCBrZXJuZWwgY29uZmlncyBmb3Ig
YXJtPw0KW2h0dHBzOi8vZ2l0bGFiLmNvbS9hc3NldHMvdHdpdHRlcl9jYXJkLTU3MGRkYjA2ZWRm
NTZhMjMxMjI1M2M1ODcyNDg5ODQ3YTBmMzg1MTEyZGRiY2Q3MWNjZmExNTcwZmViYWI1ZDIuanBn
XTxodHRwczovL2dpdGxhYi5jb20vY2lwLXByb2plY3QvY2lwLWNvcmUvaXNhci1jaXAtY29yZS8t
L3BpcGVsaW5lcy8xNTc2NjI4MTA4Pg0KUGlwZWxpbmUgoaQgY2lwLXByb2plY3QgLyBjaXAtY29y
ZSAvIGlzYXItY2lwLWNvcmUgoaQgR2l0TGFiPGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vcGlwZWxpbmVzLzE1NzY2MjgxMDg+DQpEZWJpYW4v
SXNhciBsYXllciB0byBnZW5lcmF0ZSBpbWFnZXMgdXNpbmcgQ0lQIENvcmUgR2VuZXJpYyBQcm9m
aWxlIHBhY2thZ2VzIGFuZCBDSVAga2VybmVscw0KZ2l0bGFiLmNvbQ0KDQoNCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fDQpGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1l
bnMuY29tPg0KU2VudDogRnJpZGF5LCBEZWNlbWJlciA2LCAyMDI0IDM6MTggUE0NClRvOiBjaXAt
ZGV2IDxjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZz4NCkNjOiBiYWxha3VtYXIgYWRpdGh5
YSij1KPTo8mj0CBURVVSKSA8QWRpdGh5YS5CYWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT4NClN1
YmplY3Q6IFtpc2FyLWNpcC1jb3JlXVtQQVRDSF0gVXBkYXRlIGlzYXIgcmV2aXNpb24NCg0KRnJv
bTogSmFuIEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT4NCg0KQnJpbmdzIHR3byBpbXBy
b3ZlbWVudCBmb3IgaW1hZ2UgcmVwcm9kdWNpYmlsaXR5Lg0KDQpTaWduZWQtb2ZmLWJ5OiBKYW4g
S2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KLS0tDQoga2FzLWNpcC55bWwgfCAyICst
DQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYg
LS1naXQgYS9rYXMtY2lwLnltbCBiL2thcy1jaXAueW1sDQppbmRleCBhYmRmOTJhZi4uMWM4Njhh
ZmMgMTAwNjQ0DQotLS0gYS9rYXMtY2lwLnltbA0KKysrIGIva2FzLWNpcC55bWwNCkBAIC0yMiw3
ICsyMiw3IEBAIHJlcG9zOg0KDQogICBpc2FyOg0KICAgICB1cmw6IGh0dHBzOi8vZ2l0aHViLmNv
bS9pbGJlcnMvaXNhci5naXQNCi0gICAgY29tbWl0OiBhNjE3MTg1NmRlODRkYTNkZWNhMTM1NWRh
N2FhOWMwOTU4OGU3ZWEyDQorICAgIGNvbW1pdDogMzdjYjAxN2EwZTYzZjljYzI2YzVmZjE4MDUx
OTBhOTVjZDBjZmFkOQ0KICAgICBsYXllcnM6DQogICAgICAgbWV0YToNCg0KLS0NCjIuNDMuMA0K

--_000_TYCPR01MB9669290CAB5E0F4DC7E468FBC4312TYCPR01MB9669jpnp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Jan,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks for the patch.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
However the recent reproducible check pipeline run has failed due to a prob=
lem is with the qemu-arm image.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://gitlab.com/cip-project/cip-core/isar-cip-core/-/pipeline=
s/1576628108" id=3D"LPlnk">https://gitlab.com/cip-project/cip-core/isar-cip=
-core/-/pipelines/1576628108</a>&nbsp;<br>
<br>
The qemu-arm reproducibility also failed in the previous run (1-Dec). The p=
roblem seems to be that the arm kernel is no longer reproducible.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<a href=3D"https://cip-project.gitlab.io/-/cip-core/isar-cip-core/-/jobs/85=
66485827/artifacts/cip-core-image-security-cip-core-bookworm-qemu-arm.wic.p=
2.diffoscope_output.html" id=3D"LPlnk138670">https://cip-project.gitlab.io/=
-/cip-core/isar-cip-core/-/jobs/8566485827/artifacts/cip-core-image-securit=
y-cip-core-bookworm-qemu-arm.wic.p2.diffoscope_output.html</a><br>
<br>
I am yet to investigate the root cause of the problem. But just wondering i=
f the problem could be because of the move to the merged kernel configs for=
 arm?</div>
<div class=3D"_Entity _EType_OWALinkPreview _EId_OWALinkPreview _EReadonly_=
1" style=3D"color: inherit; background-color: inherit;">
<div id=3D"LPBorder_GTaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL=
2lzYXItY2lwLWNvcmUvLS9waXBlbGluZXMvMTU3NjYyODEwOA.." class=3D"LPBorder48765=
0" style=3D"width: 100%; margin-top: 16px; margin-bottom: 16px; position: r=
elative; max-width: 800px; min-width: 424px;">
<table id=3D"LPContainer487650" role=3D"presentation" style=3D"padding: 12p=
x 36px 12px 12px; width: 100%; border-width: 1px; border-style: solid; bord=
er-color: rgb(200, 200, 200); border-radius: 2px;">
<tbody>
<tr valign=3D"top" style=3D"border-spacing: 0px;">
<td>
<div id=3D"LPImageContainer487650" style=3D"position: relative; margin-righ=
t: 12px; height: 160px; overflow: hidden;">
<a target=3D"_blank" id=3D"LPImageAnchor487650" href=3D"https://gitlab.com/=
cip-project/cip-core/isar-cip-core/-/pipelines/1576628108"><img id=3D"LPThu=
mbnailImageId487650" alt=3D"" height=3D"160" style=3D"display: block;" widt=
h=3D"160" src=3D"https://gitlab.com/assets/twitter_card-570ddb06edf56a23122=
53c5872489847a0f385112ddbcd71ccfa1570febab5d2.jpg"></a></div>
</td>
<td style=3D"width: 100%;">
<div id=3D"LPTitle487650" style=3D"font-size: 21px; font-weight: 300; margi=
n-right: 8px; font-family: wf_segoe-ui_light, &quot;Segoe UI Light&quot;, &=
quot;Segoe WP Light&quot;, &quot;Segoe UI&quot;, &quot;Segoe WP&quot;, Taho=
ma, Arial, sans-serif; margin-bottom: 12px;">
<a target=3D"_blank" id=3D"LPUrlAnchor487650" href=3D"https://gitlab.com/ci=
p-project/cip-core/isar-cip-core/-/pipelines/1576628108" style=3D"text-deco=
ration: none;">Pipeline =A1=A4 cip-project / cip-core / isar-cip-core =A1=
=A4 GitLab</a></div>
<div id=3D"LPDescription487650" style=3D"font-size: 14px; max-height: 100px=
; color: rgb(102, 102, 102); font-family: wf_segoe-ui_normal, &quot;Segoe U=
I&quot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif; margin-bottom: 12=
px; margin-right: 8px; overflow: hidden;">
Debian/Isar layer to generate images using CIP Core Generic Profile package=
s and CIP kernels</div>
<div id=3D"LPMetadata487650" style=3D"font-size: 14px; font-weight: 400; co=
lor: rgb(166, 166, 166); font-family: wf_segoe-ui_normal, &quot;Segoe UI&qu=
ot;, &quot;Segoe WP&quot;, Tahoma, Arial, sans-serif;">
gitlab.com</div>
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend" style=3D"color: inherit;"></div>
<div style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, =
Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr" style=3D"color: inherit;"><span style=
=3D"font-family: Calibri, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);=
"><b>From:</b>&nbsp;Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
<b>Sent:</b>&nbsp;Friday, December 6, 2024 3:18 PM<br>
<b>To:</b>&nbsp;cip-dev &lt;cip-dev@lists.cip-project.org&gt;<br>
<b>Cc:</b>&nbsp;balakumar adithya(=A3=D4=A3=D3=A3=C9=A3=D0 TEUR) &lt;Adithy=
a.Balakumar@toshiba-tsip.com&gt;<br>
<b>Subject:</b>&nbsp;[isar-cip-core][PATCH] Update isar revision</span>
<div>&nbsp;</div>
</div>
<div style=3D"font-size: 11pt;">From: Jan Kiszka &lt;jan.kiszka@siemens.com=
&gt;<br>
<br>
Brings two improvement for image reproducibility.<br>
<br>
Signed-off-by: Jan Kiszka &lt;jan.kiszka@siemens.com&gt;<br>
---<br>
&nbsp;kas-cip.yml | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/kas-cip.yml b/kas-cip.yml<br>
index abdf92af..1c868afc 100644<br>
--- a/kas-cip.yml<br>
+++ b/kas-cip.yml<br>
@@ -22,7 +22,7 @@ repos:<br>
&nbsp;<br>
&nbsp;&nbsp; isar:<br>
&nbsp;&nbsp;&nbsp;&nbsp; url: <a href=3D"https://github.com/ilbers/isar.git=
" id=3D"OWAc322b097-8d3c-688d-3f23-16d979f774f6" class=3D"OWAAutoLink" data=
-auth=3D"NotApplicable">
https://github.com/ilbers/isar.git</a><br>
-&nbsp;&nbsp;&nbsp; commit: a6171856de84da3deca1355da7aa9c09588e7ea2<br>
+&nbsp;&nbsp;&nbsp; commit: 37cb017a0e63f9cc26c5ff1805190a95cd0cfad9<br>
&nbsp;&nbsp;&nbsp;&nbsp; layers:<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; meta:<br>
&nbsp;<br>
--<br>
2.43.0</div>
</body>
</html>

--_000_TYCPR01MB9669290CAB5E0F4DC7E468FBC4312TYCPR01MB9669jpnp_--


