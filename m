Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4833FC83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 01:16:20 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.4141.1752542176542785531
 for <cip-dev@lists.cip-project.org>;
 Mon, 14 Jul 2025 18:16:17 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key1.smx header.b=ZQ+4aF+d;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key1.smx;t=1752542164;x=1753751764;bh=66SRzsPsqkEBRhPi50rhe1yQXRT5Ta3dI5n1rWp
	P6v8=;b=ZQ+4aF+d/e84IgoOsI4kbJr6jhaqmnV2PkMO8DntQhovTmwJnNv7MreDN9ywO91NTkaUc
	FG5LqoBG3mt51JnLc6D2y7W33EKwckJ3a78XIkq/FdcxO215z0B6I7qEHx16/JMEOA6OJYwdSOFLa
	8yKNE4NfH8RSqHEE/2fZPew/LYmXuApl32sNOzfGJgsi0yxTKXNncCuF3dgCJLYVAkWKI6eMN6kqF
	GBFzfPt8tTTuo4PfXwyXjy8pNK8TDYIBFCNCW46iU6tpxrsuibFUzDXXPmiPVw8S8gy70su/DdI+n
	vWP8BQms1EVFk9VamsIA5KhVgxaFbX2ttdgM6Gv42w==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 56F1G3Px3125256; Tue, 15 Jul 2025 10:16:03 +0900
X-Iguazu-Qid: 2yAbuzQy4zTdXBG5qK
X-Iguazu-QSIG: v=2; s=0; t=1752542163; q=2yAbuzQy4zTdXBG5qK; m=c8Lw5Yb9WTwljk3L/Nzv5OHDhg/EGdNmN7dO+3Ggycs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 56F1G1iL2209475
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Jul 2025 10:16:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSFD8ol+Ctwz2auQuxiIyd7Un2om4pV390cRyNpWqECvFVtqR+TZ6U8qQXNzEtFzg7L46cqxUuzP6oR3gf9HA58bpzNNBNLKwdPSdXinjntpXRwGNEiZKFAps5r4k590C0pSOpmx4T08sBwrhYk9a0Ohi18AqpjFa2fGzzoeVA95n9ovbl2hp018EmgcKdj/O1q6H5X7uE7QpzBxSkHHwRyk3vlUwLVc+Pct31Hf+2MqHYAMAUrAmxFgbBRmsypzVO8r4zPVA3uknBzwd5ZbF3qCl1C6fU7XAi8MBWvmtkB7xLl01ro0jHV8eJZYx1ypK/HObPLYWWKptqwxuaD/9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBlmUIxoVZVWBcgihNe0ujWvbBbdpAugk9viX634iD0=;
 b=hJK5WwE80YEuucv8huHcjzy5jqJwsW/me09gTK7mQtq8tu/SuG4h2MlwuHOdvhD8aGIuJrvTfXdCrhkihrFyLjQ4aZXTTSRghVgZjruRP91F9LnzPhNTiC7gkjWTw7HV9uZITQcH2XXVQqTbZfQ090OiGjv+Mfp23W5E74tevsCxd/u4EfIiFqYToHxpJjL1bAUY9GsaW2bFOandjwFgqYIu+UsfVfVHMqD1uNqymHz7dxoHvggNd4EDsSWO3GZlSzIaBjSv2X/sgXg9F5KWPYQ5qQ4EDBLWBw8Y+WzZd68dGjenf6cTPypRAZmMELz4DJXutdnhn+BiT7FUNJZ2jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 0/7] RZ/G2L DU enhancements
Thread-Topic: [PATCH 5.10.y-cip 0/7] RZ/G2L DU enhancements
Thread-Index: AQHb8pFvwLquO9sFxUmpQhHexRsjOrQyZttg
Date: Tue, 15 Jul 2025 01:15:58 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818DD82B7AAC58BA8B40F649257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20250711182705.346314-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TY4PR01MB15953:EE_
x-ms-office365-filtering-correlation-id: 25a3a83c-5ba8-4133-997e-08ddc33d2816
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SkhLcHRSeUlJb2Q4RDJwdjRSdUppa3pEbmsvamtIQ1VjQ1dJeW1ESzFS?=
 =?iso-2022-jp?B?WWIvSVpweDViNUNPT2hKZmFHbi9oQjhCR09KU1dpekZLRE1uUDMydUpF?=
 =?iso-2022-jp?B?ZzFOV0Vidk5OMlg0VnFQRzNDL21WbjFhbnFmWXhDRDRzV0EzemVCM0hD?=
 =?iso-2022-jp?B?cmxMNDI5LzIxYXdvQmF2dmFtSW9RWWg0M2ZSdVR3Y2liWjMzaExTZHVF?=
 =?iso-2022-jp?B?YWRxMjhheHBrOFZZdGNPUTl1QVJzWG1qdTJDZExHRU1FLy9Ec1l5bHI2?=
 =?iso-2022-jp?B?MS84L1JvRlk3U0FzalRRNnlYNkx0a1ZhOE1vZFZYbkNsYnJWOWpBMTI5?=
 =?iso-2022-jp?B?UmVvY2k3RWxublQzMXk3elljTWZBU2ZhSUlscEY2MkN4aWRqRzF3bkhz?=
 =?iso-2022-jp?B?UDhoTW1SN2hRNE9zcjBrU1htNDU0YVJsUW9LbWRPM29wN0QrZ21PYytH?=
 =?iso-2022-jp?B?YVlqZ01tU25HanlkQlhHOG8ramt2YXkvZGZnMVN3Tkh5QThDQ3FLMmVS?=
 =?iso-2022-jp?B?dWRwdFArajJ4MUdhMVY4TWgzU2cwbkxFUUdIVXd1cTcyVENEbDZDajVi?=
 =?iso-2022-jp?B?MXdYNXN0Uk5WbmVyS2tjczJ5QzgyNWI3ZjRtSE1uU1VMUUdrdUtUZTJT?=
 =?iso-2022-jp?B?cDNJNlNqOEtKRUVraGd5SnR1YXNkdnNkdlNwVVJLc3ZEZ2ZQb2s3em5p?=
 =?iso-2022-jp?B?ODFmNStxNEZodk90R2Q2SWt0a1BrcWhrQitDNGIrRzdoaTkxSEwxU0JQ?=
 =?iso-2022-jp?B?UHpxb3dGT25EMTZwL1Rpd0pWU2tYVVJkeHFDTzRCMjJDbmZDQ2Y1NXpr?=
 =?iso-2022-jp?B?SkZMcnlFQXYvcWRhWVlxV2pMR05jdFlHbkM5cVBKdkh4ckNCZld2Ty9U?=
 =?iso-2022-jp?B?VnFaRkYrdUQwOFg2YTdoZU5hZmYzQkJhMWFEQ2ZCdlAySU9iVGgzQito?=
 =?iso-2022-jp?B?WUEwTXpJVklrcFJsSXc4RUVYMmx1Y2NxQ1dHKzV3NDhXYmFBS3NKMTNi?=
 =?iso-2022-jp?B?UjV1M3VvWEdFY0FaT0ZaZHN4VVQwNEp6QjBzYlV3UklsYStCcmVKSGVF?=
 =?iso-2022-jp?B?eDExczBuTVRpZDh0OEVvb3p1TFJyQThJYXczMEtCSkZOcE5YdnIzMno2?=
 =?iso-2022-jp?B?bHZjZkgwUlZGRlF6MW4rcDV3Qkl2dzNoTWM1K2dnWlhWMFB2MEVxVSty?=
 =?iso-2022-jp?B?d0lKZ2VXd3NhVzB0Uzg2UTlWRm92bVI4VnU2Q3dUbjdHQ3hGbFlvMksy?=
 =?iso-2022-jp?B?YkRBRDBoUkZ3Z3A1cVFDNnUvK2kvTGlRSnJDcEhhei96QTE0bjhQYnU5?=
 =?iso-2022-jp?B?Y1kya0p5QkdpbHBqS0REYmFzRmlPYW9lKzBITW4vRHA3SHMyQ2J3eGhh?=
 =?iso-2022-jp?B?SWYwOHgzUklqUVAxbE1IRUk2Y203Q1hxR1RNZ0Rpd3FxZnhIWGo3eGJi?=
 =?iso-2022-jp?B?NThEbkxZNW1Gdi9xdXVqc1JOR1Z6T3h5aFVlMHdrTmluK1A1NTZhSm01?=
 =?iso-2022-jp?B?OWNFWi8xWlhRc3cvNk5VQmxVSU1ZbzVhWjFGVWpudUpLYWM1M2VIKzVZ?=
 =?iso-2022-jp?B?ZWVnVVJML2kxT3A2TG12bW1lNG91NEdJSDVoZjBYd2pZeFU5VkE0cmZR?=
 =?iso-2022-jp?B?ZEVuTWsvaDl0T21sdlVsUk5PRWNldFBxU0t3dUFCc1ZwZ3kyWWhtSmtZ?=
 =?iso-2022-jp?B?dnJFYm5yTlBmWmIxYURzR3BFcGxOMng2M3R2WVUrVUdyVWplU3lqR1dj?=
 =?iso-2022-jp?B?b0x0WlNRTUJ2MkxuTHNVUHRjejZ4V255M1poeXhNVkJoSHV0OTJQa3oy?=
 =?iso-2022-jp?B?NVM1Y0p6OTFYaTJEZFRjS2ZQTVNDS244WXBWWTRqU3AvWk9lK3BmbTIz?=
 =?iso-2022-jp?B?Mjl3UGxFNGhrWWtsUGx6MEpScGlraDNXYzgveFJFaXFhdngxaUV6ZkJq?=
 =?iso-2022-jp?B?cnB6ZzdmTnJiOWNyU1llVHcxYWVXQ1lpS2tOQVkwSVd3VHNlSEVtdDBT?=
 =?iso-2022-jp?B?blRUTkVvK3lPYUxhR2RCWG4zWVo3YXdnL1NlMGFyVm9najA3WEFXUkVQ?=
 =?iso-2022-jp?B?SnRJcEZrS2I1VXlHSU1JbVdwa1dET0FOMVR3eFZDdlM4WWVkT1p6NjhC?=
 =?iso-2022-jp?B?cWZ0bnZiZ1dWdHNNV2N2TVJIdk0zdUlBPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Y3Zzbit5WFptYmxRRXllV1AwWEdnNHhRaEJhTXBNdGRmZk05bjByZTdI?=
 =?iso-2022-jp?B?U1Z1MEFXUFczQ3h4NmNqemtQTndOQmxIOTkrczVnWHlHcHJVQ204Tk9F?=
 =?iso-2022-jp?B?ZzV6aWxsZXhIQ0U4dmlmcHo1YytVQkVuUGZUdHVydDdHYXJNMWZjNjA0?=
 =?iso-2022-jp?B?dzNUc3FQM1JpY1F1aFMyM3Bta0dHWlVZMzh3L1RVTENvdXZMWnZmU0V4?=
 =?iso-2022-jp?B?Y0M3eXJsSGlHeFdYVlN4RndHVmdDUkc3b25yZ1owUHRrWk9kQlVVV013?=
 =?iso-2022-jp?B?czVjOXVDeG1FbkpSbW9rUjVJemZpVFNlTW05QmU0bUtySjVScTcxRTFs?=
 =?iso-2022-jp?B?VzRKYkR2Z09Gb0ZUc3J1VWo3L0d0OEFCNzlmTVFUbnpOYWxMQS9BTHlq?=
 =?iso-2022-jp?B?Zlp2a0svUHhGZVVmMWNDdExJRDdTd3ZjQkQ1MUNaM1p0REt0MlNIbW53?=
 =?iso-2022-jp?B?SGtzbDZ4bUlkSUgycnd1N005NXhZSW9nbklPVGQ2SUlpQ0I1dFhvOWp5?=
 =?iso-2022-jp?B?NG5NUVBCUFJGd0o0bzVjZ1ZqY1MzU1J6cmtXbmVZTjdGS0xOa2hHOHAv?=
 =?iso-2022-jp?B?eGI5Yi8rMDZhSUo5STgzaXBXTUdJaXVYN1BjR2JEYVNFSzVvenB5dTg3?=
 =?iso-2022-jp?B?T3EwRnJtV004eVVJSjd2Y1pMbGJQeFcwYjlCNTNEbVVoMXdLMWxjU0sz?=
 =?iso-2022-jp?B?d0RNSUlBcW1mU3Q2U01ZdExtTURmckdTbGRtcTJia1JhVVpDcTZLN3Nz?=
 =?iso-2022-jp?B?ZXFRcU5WNlgxOTRiUjJCNDZnbzh4aHBxVHJXYS83ZlE2bDZkVVE5S3hV?=
 =?iso-2022-jp?B?OGtIa2tTOUlzN0ZrZGVUazdURGdlMXlGa2tzSFNZaWdFQ24rUXFZYmNR?=
 =?iso-2022-jp?B?Q09UTFJ4aWVVMTBDclJmaHJ5UWFLRE5HNGFvUlVoS0UyelJHR1RRelYr?=
 =?iso-2022-jp?B?K1kvWk5xWjM3aC8xQmJiUlBNTUJxSjFlRG9RMWZIa285aVlRS2piSVBG?=
 =?iso-2022-jp?B?QUgyd0kyaEtCeHhCOElhYjA3YUZrUXZ1d2RVaVlMWEIyNDBla2xWU0ZI?=
 =?iso-2022-jp?B?Si9wVkR2ZEo0d3Fkemw4TmIxTGowYlBPeEw5bnhST3BvYk1PN2ErSmxE?=
 =?iso-2022-jp?B?M2pBNjhkQUFnQzBGeC85bjFZczczeUhTMHdwV2ljUHJRQ3cwRFl4eVRw?=
 =?iso-2022-jp?B?SFMxU3cydWd6d0Z5c01aUEIwSnhEbHViSVVDQlp6b1Y1bFhrWFIxSmw1?=
 =?iso-2022-jp?B?bUxSQ2E4RE5nVjY2U3VSazNobmZBRkQwTUFtdktOcnJDamxvcE1oaDJy?=
 =?iso-2022-jp?B?UGFuQkppLzZ1VUZ6N25td3QzK2JRVWtCM0NqOUl2elhpU3NKZmdqdmVG?=
 =?iso-2022-jp?B?Ykd1N3FVL2tmSTlxaHZqT1RyQkhJSGxrMDB2c3RvN21qS08zTk1KeDRE?=
 =?iso-2022-jp?B?V2dUMmRYbkJDMDJBc1dySXBLdjNBZ0loTXBvSTIrTU1JVUtyeXBVQlhq?=
 =?iso-2022-jp?B?SzExUGxYNmdnTXE4YTdRTUNjTnBQOWdaaEYxd1BpalNFZnBkdUZXbmtP?=
 =?iso-2022-jp?B?aUllcFBmN0l2VFFQYkMyYXZ0YS83N296cGFSUmVjNEg5ZEZrODdXSm1C?=
 =?iso-2022-jp?B?cDh5ODVLdTVUeE83WEdZZWNxenliTVZGTm9KbTRCT3JDQUx5Nkl6RFl5?=
 =?iso-2022-jp?B?bVVFc3NhT2s2enhvZjZLZmU3UjR1Tzh2cXNDZFN0NWlCMy9GRG5FNGFm?=
 =?iso-2022-jp?B?R3BRZHJVVDROaTRVYXN2aWZqbWlNdUtwSGN6aExqQmlxNHdhcUZDenNT?=
 =?iso-2022-jp?B?NktLeEVra2puajlSUUFCK2Q1ZFlkL3lRaXFvZDMxY2gyWWlhYlo4NVcy?=
 =?iso-2022-jp?B?ZTF3QzhiMXUrYWhQOElqZnRCTldwVlJvKzRWcUQ2Q2o5UGVvVGo3U0l5?=
 =?iso-2022-jp?B?TVF4RWQrNUxBSlVPTkh3ZXJvQldVRzlKTnI5cWliQSt6VkJmNjE0T1hr?=
 =?iso-2022-jp?B?UHFQcXFhbjlGSDJkRzVpaEJBVGZxdkphdm1ENVl4L2NyMlozN1Q2d2N4?=
 =?iso-2022-jp?B?N0JFS3RwN2xlSlBDRThlNkdqZG5USkQyVDZPZjF4QUgvc0xFWHFSdVJk?=
 =?iso-2022-jp?B?ZVN4QmxKZllXQXNkWFdVYWJSYW1tOGNTZXpJOUJWd2V5WlZLUnJtY2Zn?=
 =?iso-2022-jp?B?MGFENGIzNHc2SXc1SFozTnZZU1daVUU5MWlCbWpMM2xZNjdvek1SMU1K?=
 =?iso-2022-jp?B?azR6SjdkT05XS3dqNmFydVJtazhlOXRMWUZSMTVnUXpsMEkrVDgvMkll?=
 =?iso-2022-jp?B?MmlJNlRyRmROS2tBTitKY1VwdG0zYVBVVVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a3a83c-5ba8-4133-997e-08ddc33d2816
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 01:15:58.9289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PKPYruF4bpDc3L161kY6pwos9iq5G4SZCFDMeLE7Qj75ZIrBGOF9YZrTxeqTRRfEP9xHS7kh124EZGpcj4UspeBKGLUluk3N5deIU0RPeuj0O7KWN0DTLFncdY1qz+7a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4PR01MB15953
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 01:16:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19527

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Saturday, July 12, 2025 3:27 AM
> To: Pavel Machek <pavel@denx.de>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: [PATCH 5.10.y-cip 0/7] RZ/G2L DU enhancements
>=20
> This patch series for enhancing RZ/G2L DU driver.
> All the patches are cherry-picked from mainline.
>=20
> Biju Das (6):
>   drm: renesas: rz-du: Drop DU_MCR0_DPI_OE macro
>   drm: renesas: rz-du: rzg2l_du_encoder: Fix max dot clock for DPI
>   drm: renesas: rz-du: Add Kconfig dependency between RZG2L_DU and
>     RZG2L_MIPI_DSI
>   drm: renesas: rz-du: Drop bpp variable from struct
>     rzg2l_du_format_info
>   drm: renesas: Add zpos, alpha and blend properties to RZ/G2L DU
>   drm: renesas: rz-du: rzg2l_mipi_dsi: Update the comment in
>     rzg2l_mipi_dsi_start_video()
>=20
> Kieran Bingham (1):
>   drm: renesas: Extend RZ/G2L supported KMS formats
>=20
>  drivers/gpu/drm/renesas/rz-du/Kconfig         |  15 ++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |   8 +-
>  .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  18 +++
> drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.c  | 120
> +++++++++++++++++-
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_kms.h  |   1 -
>  drivers/gpu/drm/renesas/rz-du/rzg2l_du_vsp.c  |   9 ++
>  .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    |   2 +-
>  7 files changed, 152 insertions(+), 21 deletions(-)
>=20

This patch series has already been applied, but since
I have reviewed it, I am replying for the record.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


