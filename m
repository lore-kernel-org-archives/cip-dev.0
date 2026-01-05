Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAC56C2A062
	for <webhook@archiver.kernel.org>; Mon,  5 Jan 2026 01:07:36 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.54972.1767575245955817392
 for <cip-dev@lists.cip-project.org>;
 Sun, 04 Jan 2026 17:07:27 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=iux3TRBk;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1767575243;x=1768784843;bh=4pC9r1sQOb5QtwuUogL3/ICIrNvmU8sPKTg1l
	dzO2Z8=;b=iux3TRBkc8lpRDuNqWE49knQ2IJSXm9jMrzgcSt7sPxUNTbaBatSJtn7gitBDB8uqop
	pd6V9x8j+CXI/kszx5jCp8a2Cjy4nRRUUJtBviQmCuvw6xyVD8mvi8eZ8ZpYR3vLxP7Vo/u9lHgSs
	rFXw6AvDOR66pSw0ovEh6OHth34O0oENSYW12BNb0yamgW8lEqoRHhpp1+pynTHFD+F773xMhrEHE
	/w2RuHVmByGdLefr8osRRu23yemFwUgfAVhjA9MlhXDsejQWXeCBZ9xTWVGYe5mFgVUetZOVWssBi
	f94dhM0joxI9i7fbl/NwQVin4Tnpyx5aCR8YzitTe4iQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 60517NOK1378135; Mon, 5 Jan 2026 10:07:23 +0900
X-Iguazu-Qid: 2yAauG5Cfe0RyO0pEM
X-Iguazu-QSIG: v=2; s=0; t=1767575243; q=2yAauG5Cfe0RyO0pEM; m=Rt7NdxR5KkmaV3wgz/yIX13vj3SksPjVgXSmYqug0YU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4dkx3Z549pz1xnZ; Mon,  5 Jan 2026 10:07:22 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t844M/sSJpcQWCEToplqxqB4VKcCt+6l7+DBzQJ0JA8b97thjMfjY0ktAds2pmi3VxR3l7CigaOJt+IvE8Z8f/mtQPzrWqr1Xl/IRFc5+rqLU9e/yrvl1agRumLZRZo81qrWNLNEEAJIO+SLQ/UttovcIIc8b17wbG49Lt6BAHhPHEysmToahJmJR1qt59UlZSsWfDg9i9GGm8Dk8+n33BMYcVK7BBEy4BcbH1e3XxCoYoA79N67N0j3LG7JUyrSbDOUo5bl90hZiXkrIOVWbJJPuyOMmU5NXTIHDcJ5UE0FtMOki+W8/+qeQmqW7dJkA13ZtuW6n4QK4BM7LGU45w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4pC9r1sQOb5QtwuUogL3/ICIrNvmU8sPKTg1ldzO2Z8=;
 b=GKxiY7bkA2Y9ZdyxRzg4EMv8oQcKUjmEMe7wbJcbMC1/9fH48mvLVVP67D53cV1gTYL6VQcmCq5dC3Cl8b6OHDsdWAILgIzIJjVRWYqdUwyMAlzQrho1zOsPffcLvoBdvp92UnLEHn0Mz1AqMxz8g+KHFLoXWooIw755XSm4jsGU58ghx3pCK0VC0nVHbt7EOuSdzYdgrdLwSa0ZHTMMMxN7nPmBNfz16h0LCthaI2oiBrxg4CE9lvMGcbhauA1+YJ5+0PapiAhlRlzo44MrWmkY509IvaAwD8IvT+eyOKdIyEUNU7onvCnglD0CHYqorhg+aKDsmiOr+VAH7nVwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>
Subject: FW: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Topic: [PATCH for 6.12.y-cip + 6.12.63 ] can: rcar_canfd: Fix build
 error caused by is_gen4()
Thread-Index: AQHcfd8KZ0N0yIOqxki80+6lHh+CCbVCww9g
Date: Mon, 5 Jan 2026 01:07:19 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148184F8D88C0BC3643171681CD86A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
In-Reply-To: 
 <1767574966-5745-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYYPR01MB13317:EE_
x-ms-office365-filtering-correlation-id: d6332650-7a2b-40a0-9f0b-08de4bf6c640
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?cXROeG1KMU9QRmt0OFQyTW1RMUViSFJMQ0dJUURoQlhhbEZyMmdNZ3lnS1ov?=
 =?utf-8?B?RDNDeGtMNzJlSkprU3d4blEyN01qVjBidlUwR1FzTlIvQ3A1QkdVbVExTEpN?=
 =?utf-8?B?MEdEOXk5QjBGeU5JVmJSQ3hQTlRNZTlXM2x2NFFDanp3V1RCem00QytvOTN0?=
 =?utf-8?B?ZE56dnpMbWdJTEpJU01BYUdhRkxTdnRtZVFNUmVBL0JjUTMwWnliQ21oblRo?=
 =?utf-8?B?RGx0dkIzcGU4bUZhK0dQYzUzcWF4c1luUk4zOThLTjd6SlJFQUV1aUEyVWNn?=
 =?utf-8?B?am5sazFic09Sbjg1cEJ4WG9ucEtoRzdPNHA4djZ2NVpVbzlwTzNsWUNHeFF4?=
 =?utf-8?B?VHlzTTV2ZVIrcGQ0R0hGY2ttTWFMcDVmdGdPOWZTUzRYc3FpdTc1ODNTZXk0?=
 =?utf-8?B?UlVwVm5BNUZvOGpTYnFNOGRkamgybG5BakxzTzRkRkd3elhDTXUwNjRCNUJl?=
 =?utf-8?B?Zk9NY0ZQdjhUQTZJdWVlREgzV0hmTTk3L0t0UnorQnNoQTBieXlCSGNHRlhF?=
 =?utf-8?B?SW5IT3V6T1JoUnBKVFJsY2gwa250MW9qWGw4QTJWZDFkQ2Z5U2N1dUtuSkN2?=
 =?utf-8?B?YnMrb3JURW1nSDc2bldLSEhia1JxbEhCbTMyb042OGRkNkEyWElpVkhWRHVl?=
 =?utf-8?B?QW5pQTRDc1gzZXI0enU1ZGp2WnVUWEhkOWhBZ0t0bU84NzBTTnNsOHBYeS9F?=
 =?utf-8?B?bUVGdVJYSnN6Ry85MTlUQ2pIeTlPNmlMSmJxMG9MNUI0VmJIRzRwWE44MXlZ?=
 =?utf-8?B?QXZBZnkyQUlDdy9zcE1ybHZ2RkR1QkV0UlQ2aGFUYUlJVkpJcXJuNlgrUTB4?=
 =?utf-8?B?cjEvUHE0OVJxYjBrNW0vQW1SL3UwRmI4Qkt3WGhVbGNaZDduTk1YMW9wN283?=
 =?utf-8?B?ditHcjkza2NHRHFpc3A2Tmo2MGx0Q2VsYWYxRDVzelgxU050UlBnVTQ5RHQ0?=
 =?utf-8?B?Z0cvUTVOU0gybTYwWU0vNUZ2S0I5SWNFUmxZS1gxRTRZR20xS05QbWhJNjcx?=
 =?utf-8?B?M0pyU1ZMVkI2MFpRM2dxM3lQL0M4QmEyRnRrWERtdWRnZWJtaTNEdVFkanZl?=
 =?utf-8?B?WHlEUnJKYk0wUlZsb3V5YVQvRDBTd3I3cW5Nc0EwYnV2UHpXU1o4bWhuYVdZ?=
 =?utf-8?B?bms2d21JcGJmb3FObERBazdqRGJRRnJQQ1VwRzVKSHd2K2p1cGU2eGhROVlN?=
 =?utf-8?B?YW51dzhDTzZVQXpJVzVVQ2hYLzN1eXZDNktLKzI5L2xsSHM1WXQyZVhteXFq?=
 =?utf-8?B?VjJiRitnZ3M3MjFuMkgrZlNQeXhMN2o3MnVodVNOQ1VhSEwzZ2RSa3BvVjkr?=
 =?utf-8?B?cENZUTFiNGQ1a2V1U1VTOEh1NGswdnFUZWdUejVaTUJNbSsvSm4xOG1JSnRt?=
 =?utf-8?B?Z2xPZUdZcXlrMFROeEJXK2lkbExhRXhHREhXaHNObFdtTFFQVGYzTG9IWE0w?=
 =?utf-8?B?SjBtZDlRRHpZUUxOTXJKYjBVNXh5ZS9mSHNLTmw2SmMvZ1FxdXpFYktCY3dY?=
 =?utf-8?B?d0poOWN1WTBEWU1QWlcwaHhqYS9JUHovYnVzUWc5WUJBelV2bTl3bUQ1cXg1?=
 =?utf-8?B?SENVdmxPZFNBYUkvSXJ2NEZ2WjFxaERrMy9tQWNCL29rcVRUZmV3ZW1vTENP?=
 =?utf-8?B?NzVqYk9GMG9Dcm1XRXBVMWlyODFCaDNaZXoxcDBYS3VzMUxqUksya0cwQTgr?=
 =?utf-8?B?cnluRFhWRHgycFRFSTVQZXhoSTA0V0Y0RldGUDBjbURRd2xBcnJKSDdzcjVq?=
 =?utf-8?B?UE1qVVlXSjVPeEdVUDY1a1Mrci8xY01zamEvVjJUYWhyUnpoZkUrZC9TRmtB?=
 =?utf-8?B?UUFPUDRrblVvVy9xMkMwNUFpdFNZUVlCT1gwMTlXLzYvcExaeGdPTWxsMEtE?=
 =?utf-8?B?b283bmI3TmVydlJnTGdpYktBdjJVNGJxZ2RkcnY2Qm1uaGo1SmdjUXk4UFNa?=
 =?utf-8?B?dGhkTlF3MTQ0SUxOV2pXTDN2RkVtdEt4bXJCMUhoS1pVOVA1ZkloTlhzTVlC?=
 =?utf-8?B?RUlXOXQyWkEyalhIWVg0NHIybE1icllWaEFqbHFsRHBNRm9EcXh2NnZSTkM5?=
 =?utf-8?Q?ESf93x?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?K0Q3dHJBZ3o0K3l2UWZ3RkRYaVIwemJaNUMvN29hVG56emJVRzBEeGZsNHlJ?=
 =?utf-8?B?emJrMlNUN2ZjWlI5T3hETzBvNWh3TGliTTJmcWlXMnpEQnBzZW1USnErdU81?=
 =?utf-8?B?WERhN0N2YWxXS0M4TmM1eVF6eHk4clM3ejVRdG5GZXEvWEpINzlNR2dvbS9v?=
 =?utf-8?B?TWlpYVBGQ0JTZmwyVWljQzJWTUZHTTNVRFBTaDBUcUhsL1p0cDNXNG4rTTdN?=
 =?utf-8?B?QlVqQTlqOThPK0dzZm9GNTVKL3dQVDJtK01EK3MwL0VsVFRSODk0a2l3UERJ?=
 =?utf-8?B?d09vVG1vVVFIdWdHblFoOUFUVTlWbDhCTzRJa21yeEk0Vlh4Y1M4NUtwTWN5?=
 =?utf-8?B?Q0EvZUpsZ2cwWHdxYmRDbFNuaWM4cnBLR2RMdWdHRTQwSzR5aXFndS8waFIr?=
 =?utf-8?B?SkZLQ3grVnJ5SGcxOEFOUlpmYWI5RFd2aThDNGN5Q3VsVGZiT0pPaFFJTG52?=
 =?utf-8?B?M25IV2JYUFN4dEt6bnp4cXRBakp6RW5CNGF1eXk2SGYyRkFLdzZkQjF6azBn?=
 =?utf-8?B?OXJmQ2Z1cDFxcW9lbmtOVDF6bE5ta05rYzdSOU9sc25ZNDRkZjVpZ1ZjV09S?=
 =?utf-8?B?SGZ5NXQ0SFF6Q253eHNXRmxVR0FkUjl1b3FudmNNY2h2RFpIdXVOSkcxTFU1?=
 =?utf-8?B?eWxscElvbDRBMnVBSk9NNFRoTnlEYkZkcHluMTRjODZVSE1ZVklNNzFSaXBE?=
 =?utf-8?B?U29FYXpiMnhia0hVN3ZxWERPNWZieDk3QXBDTWNrZjNZZHdlUmRjMmJEaVJN?=
 =?utf-8?B?SzA1S0wyNURjeDBTYUZid2w0bzZ0YjZsVVRNK0VZck55VW1iTGNLMEo4RmZq?=
 =?utf-8?B?ZExNaFMxUVdyRGxtbUVjTFhNU2NLK3VCZ1hPRzdVNmtobURvajNud3phYzU2?=
 =?utf-8?B?WEpnQ3lIWEpKSW83U1UxdnJZTGRESmVxU1hreS9FbmRpQ0hkcmJOWjFYVXZu?=
 =?utf-8?B?TC9xaS9xb3ZCd3NSa2R2YThjUys0QldhZFpna0FnTTNPeEtDV3NiSzdkV25S?=
 =?utf-8?B?WXNDS1VQVXZ4azkxT0F4aWNMY0dFcVdDYWN3NGQ0WjdyNlVBMzNqaWx6VnNC?=
 =?utf-8?B?d2E2VlAzZFRUR1M0MkNKRFAwRURZNFh3R1QzeWlkOFhncTdIUGJPRXhSUERa?=
 =?utf-8?B?cjZ2WVNqSEJpTnNib2RoT0JUaHBQK3VNaHRydnJiZ0dldFZkSjFuZHJhRXhX?=
 =?utf-8?B?MDlOdEFmT1ltYkJPZGlwU0dYcVFWdEZIWU54VVJkVm1VMFFaODBNSWhFSzBB?=
 =?utf-8?B?MzZHUUJPc3ZtWWtMMVdmYlVUaU91V0ZPcG5KSndvWE1JWmRoN2o2aUlYdmZx?=
 =?utf-8?B?R2FlN0MyRWliUmJuVUN2Z0pJSERabWs0a3JaVUtlbjFWT2tKTGowVU1qVG1X?=
 =?utf-8?B?V0dPRlRqZmtLbmdDUHZFMFJ3bG5ZenBBZ2ZQSStOTnJYKzBoYkFDVCtXb1da?=
 =?utf-8?B?TGpSamxPVTl1SDFDeGdSejZJeXdwNGxjV1lmK3BEQTVVbjZNV0R1Sk1EdkFa?=
 =?utf-8?B?SnhEM0ROQkxTNTg4ZnQvWHc5WktoOEs3b0tiTjdZcGVVSEM0eUVSL3hLaDAr?=
 =?utf-8?B?NjZBNXhVblpvbXZLb2xITE14eFdqZDBuclprblpLMW1WQ1dBbjIvK2FRaHMr?=
 =?utf-8?B?dmpLODRSb2JST0FkN1hFQ2UxeEYrTVhiYitta2xwVmlsYmE3aFNkU1Nma21a?=
 =?utf-8?B?NW01M21jU0JuTmR2d25vVElJb1RENDhSKzkvV0JiVURMOEVMQjdCY1RKaFp1?=
 =?utf-8?B?VlFzZStQUUgza2xKbUlMWGErRmpWWlRTc0oxeUFTRXJBcTdwTS9hcHpPdWdm?=
 =?utf-8?B?ZnpUb24xZ21CMVBnbXdxbVdmN241NUxjUVdiQndXb1lla0J6U08xZGxWckNo?=
 =?utf-8?B?dXJMWFljNTZQWnh5NVJqU1grcXJoRGVyR1dlOXozWjNycEord1JxZ2lPRkZl?=
 =?utf-8?B?MmtaSTlaN01LdjhqTllkOE5YaFJSaDFPSDU0Y3NEL1I3V1hjdkhhZHlVWEhx?=
 =?utf-8?B?TmMyWlZacVdwUUluc2pGS0NFSUhqNnd4dFU2N2JpT3JpTVE0eDg3ZkEwdENl?=
 =?utf-8?B?U1htdmozbFE1My92Q210M3YvVHVCSnVFd01ONEMrWVJwaktDUno2THErUEZL?=
 =?utf-8?B?MU10dzlCT0gzUlN5MjFzMno2ckNnZE9idFZEb3RCUHJOQlVCSXpsd2dBYlJo?=
 =?utf-8?B?OG5GbFhhTmJzUWM3S1BHb0R5SjIwYmNjM1IwTWZNQjlzanVNc1ViS1NJS3N3?=
 =?utf-8?B?alFoUHh3akFud0FCV3dTWmVXUktCSDlHV2dNUGMycjNmakNvNDVEaHRCb2VZ?=
 =?utf-8?B?dmxVOGdsbDhjeHFDRnFObjQ5elpWdmt2RnBBUEhkMmNCWWJsMG9xNDF6OXhh?=
 =?utf-8?Q?FOj8eqbURHq2573g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6332650-7a2b-40a0-9f0b-08de4bf6c640
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2026 01:07:19.2953
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qI70MAj2yL1vzZJzOZsQ67WqqX0FihvxYi33ca5/k2xU2z+Q8q4CQJq326fiT4Lo7/Cf8aUF7p9jjPILoR+JC4KYLsCQFMGY3eUXc+IoTd1WT9K8Lj+d6sEHI8OFTjbT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB13317
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 05 Jan 2026 01:07:36 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21305

UmVzZW5kIHRvIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2FzLmNvbT4gLg0KDQotLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTm9idWhpcm8gSXdhbWF0c3UgPG5vYnVoaXJv
Lml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+IA0KU2VudDogTW9uZGF5LCBKYW51YXJ5IDUsIDIw
MjYgMTA6MDMgQU0NClRvOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IHBhdmVs
QG5hYmxhZGV2LmNvbTsgdWxpQGtlcm5lbC5vcmc7IGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY287
IGl3YW1hdHN1IG5vYnVoaXJvKOWyqeadviDkv6HmtIsg4pah77yk77yp77y077yj4peL77yj77yw
77y0KSA8bm9idWhpcm8uaXdhbWF0c3UueDkwQG1haWwudG9zaGliYT4NClN1YmplY3Q6IFtQQVRD
SCBmb3IgNi4xMi55LWNpcCArIDYuMTIuNjMgXSBjYW46IHJjYXJfY2FuZmQ6IEZpeCBidWlsZCBl
cnJvciBjYXVzZWQgYnkgaXNfZ2VuNCgpDQoNCmlzX2dlbjQoKSBpcyB1bmRlZmluZWQgYmVjYXVz
ZSBpdCB3YXMgbW9kaWZpZWQgYnkgY29tbWl0OiBmMGIzN2YyY2IyMjQgDQooImNhbjogcmNhcl9j
YW5mZDogQWRkIHNoIHZhcmlhYmxlIHRvIHN0cnVjdCByY2FyX2NhbmZkX2h3X2luZm8iKS4NClRo
aXMgcmVwbGFjZXMgaXNfZ2VuNCgpIHdpdGggJ2dwcml2LT5pbmZvLT5zaGFyZWRfY2FuX3JlZ3Mn
Lg0KDQpgYGANCmRyaXZlcnMvbmV0L2Nhbi9yY2FyL3JjYXJfY2FuZmQuYzogSW4gZnVuY3Rpb24g
4oCYcmNhcl9jYW5mZF9yZXNldF9jb250cm9sbGVy4oCZOg0KZHJpdmVycy9uZXQvY2FuL3JjYXIv
cmNhcl9jYW5mZC5jOjg3NDoxNDogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0
aW9uIOKAmGlzX2dlbjTigJkgWy1XaW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dDQogIDg3
NCB8ICAgICAgICAgaWYgKCFpc19nZW40KGdwcml2KSkgew0KICAgICAgfCAgICAgICAgICAgICAg
Xn5+fn5+fg0KZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jOiBBdCB0b3AgbGV2ZWw6
DQpgYGANCg0KRml4ZXM6IGY4OGJhNTA5OGU4MyAoImNhbjogcmNhcl9jYW5mZDogRml4IENBTi1G
RCBtb2RlIGFzIGRlZmF1bHQiKQ0KU2lnbmVkLW9mZi1ieTogTm9idWhpcm8gSXdhbWF0c3UgPG5v
YnVoaXJvLml3YW1hdHN1Lng5MEBtYWlsLnRvc2hpYmE+DQotLS0NCiBkcml2ZXJzL25ldC9jYW4v
cmNhci9yY2FyX2NhbmZkLmMgfCA0ICsrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvY2FuL3JjYXIv
cmNhcl9jYW5mZC5jIGIvZHJpdmVycy9uZXQvY2FuL3JjYXIvcmNhcl9jYW5mZC5jDQppbmRleCBi
NTg4OTUwODRlYTJhLi45OWQwY2JlODYzMjEzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvY2Fu
L3JjYXIvcmNhcl9jYW5mZC5jDQorKysgYi9kcml2ZXJzL25ldC9jYW4vcmNhci9yY2FyX2NhbmZk
LmMNCkBAIC04NTEsNyArODUxLDcgQEAgc3RhdGljIGludCByY2FyX2NhbmZkX3Jlc2V0X2NvbnRy
b2xsZXIoc3RydWN0IHJjYXJfY2FuZmRfZ2xvYmFsICpncHJpdikNCiAJcmNhcl9jYW5mZF93cml0
ZShncHJpdi0+YmFzZSwgUkNBTkZEX0dFUkZMLCAweDApOw0KIA0KIAkvKiBTZXQgdGhlIGNvbnRy
b2xsZXIgaW50byBhcHByb3ByaWF0ZSBtb2RlICovDQotCWlmICghaXNfZ2VuNChncHJpdikpIHsN
CisJaWYgKCFncHJpdi0+aW5mby0+c2hhcmVkX2Nhbl9yZWdzKSB7DQogCQlpZiAoZ3ByaXYtPmZk
bW9kZSkNCiAJCQlyY2FyX2NhbmZkX3NldF9iaXQoZ3ByaXYtPmJhc2UsIFJDQU5GRF9HUk1DRkcs
DQogCQkJCQkgICBSQ0FORkRfR1JNQ0ZHX1JDTUMpOw0KQEAgLTg4MCw3ICs4ODAsNyBAQCBzdGF0
aWMgaW50IHJjYXJfY2FuZmRfcmVzZXRfY29udHJvbGxlcihzdHJ1Y3QgcmNhcl9jYW5mZF9nbG9i
YWwgKmdwcml2KQ0KIAkJfQ0KIA0KIAkJLyogU2V0IHRoZSBjb250cm9sbGVyIGludG8gYXBwcm9w
cmlhdGUgbW9kZSAqLw0KLQkJaWYgKGlzX2dlbjQoZ3ByaXYpKSB7DQorCQlpZiAoZ3ByaXYtPmlu
Zm8tPnNoYXJlZF9jYW5fcmVncykgew0KIAkJCS8qIERvIG5vdCBzZXQgQ0xPRSBhbmQgRkRPRSBz
aW11bHRhbmVvdXNseSAqLw0KIAkJCWlmICghZ3ByaXYtPmZkbW9kZSkgew0KIAkJCQlyY2FyX2Nh
bmZkX2NsZWFyX2JpdChncHJpdi0+YmFzZSwNCi0tIA0KMi41MS4wDQoNCg==


