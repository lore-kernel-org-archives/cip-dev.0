Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3AC6CA0EE8
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 12:41:02 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web10.21639.1758112860249847469
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 05:41:00 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=I+2sRsIC;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.134, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1758112851;x=1759322451;bh=j3zcOHzFwUz0VRSdGbNZmpV5vNoecg7PfxZPP
	5yflKY=;b=I+2sRsICzf2gA6vgh6eE2WXqiUzjnDP+PgIcSooio6mo5TgYP+om2cuY2RSiSemOMne
	C+X1OH3bqgNx5y//oyfDn5j8PLe76mtwnnX4LglJ7DUFjXwZgoPlnZXLq2/L3GK5R8AJxU/S7H4NU
	03hFGj5R1/ifKX5oGyALzc6Q5qF+ngilPNqU3wBdg62R4FMpu8pwFrXKDMfbzElR35DZ/ABu9IP5F
	JRBkJ+GZlhAuII7wUFKUZV9aULNfo2hmWg/Jrxgp0dk6YJ1ti0Lk07cBz0wHE82X9ElGBGt9Kz2ml
	uyVk6fRB41SMMVyIFk6H1vUyaMRn0qNyba+91bl86MOQ==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 58HCeojt3435420; Wed, 17 Sep 2025 21:40:51 +0900
X-Iguazu-Qid: 2yAaUYdp04R8F61Ja6
X-Iguazu-QSIG: v=2; s=0; t=1758112850; q=2yAaUYdp04R8F61Ja6; m=0VPS49lmCzBpvZpIzsuVvzBHkISpWMZWjuzGUFz5W8Q=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cRdfT6LT7zyPQ; Wed, 17 Sep 2025 21:40:49 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iTtzPBTWcFW+1dVgZfMBypmssQPcs56Nn/CXgGpdrJwAKCmGv9W1tS7F0f7HAXluX+vRphz3hwazTT9kd/bCYGWYPT4dBRsXU4Ppz2aCcPrHtO4T8l7GOqA2Of47yixu7QurtLCvL6fLsUR/FzFi/0Vcv0N4tYtd0FdLl63U0nP66kuo9ukRFRR/D3yYfoveyyZg/8+rOwOpt8ZQm+fFazH+89vXjNCPNkav3mq7js6qzl6dSPODNMUqXRVPV/oJ/SLFIe8cc22+39KtxbDgG8QP48a5UXCXgLg4xx0fyLt4e/lK01sCZlNwk0iSuIAhL2+Hle5pn2K2p4pa0gUFWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmRVNaahyscsqdvALhywWJhqCRICr0jFwmP8BmPIldI=;
 b=khHNJUhoYsePBeNwwTvTq5SaSMe6/oJ9Q1nIhFaDC6m8hi1/N4++gEr+K5SI4GIoiFdoOau9+eyE4aABOWGKErEk3B+lehlxyUuxxZB9mc8QbQeh5hcfTBQMsLKKYOB5gC0Zs4d03Z6YW54sS2dGt4Dau8FHc8IYZkn0CFpAeM85w0NMmNnItSXTo2vjz2CwwODpr6+wuYMG5TtwR//Xdd9yop2NhWcR7KQ2u+ZiXnla71LnzQEgnMJuaL+0AB2MlgDpr50TVT4t9fx8xsJkMKFdXYtMUPEm66Mwexq//eG1q/jEHTs5xvKR+b7nlOpIoA9vluk43FCSPgTdKRwJDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <claudiu.beznea@tuxon.dev>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after
 reset
Thread-Topic: [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after
 reset
Thread-Index: AQHcJ8N9Lsn/0TaYR0Os46H+BY2tHrSXUElw
Date: Wed, 17 Sep 2025 12:40:47 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB1481859F96555ECC68F8091F7CD17A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20250917110854.326336-1-claudiu.beznea.uj@bp.renesas.com>
 <20250917110854.326336-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20250917110854.326336-2-claudiu.beznea.uj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12743:EE_
x-ms-office365-filtering-correlation-id: b0e62d81-0dda-4d1f-1bc2-08ddf5e76d67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|7053199007;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?MmlycGR1SXorcnRIVXdMNFVudTBQaWp6REtyRXAyUG1GMHhVR2pXQm42?=
 =?iso-2022-jp?B?V0ZVY1lNZnhUaE1Hd2Z1WWxGY0REdzJ5WEZ5d1hMczlTcnc5NVJDeGJ5?=
 =?iso-2022-jp?B?eVU3UUF0blU3SXRzckpFM2Z2eHhnS2gxc1lZWkQ4ODdTd2szamlEMXR3?=
 =?iso-2022-jp?B?WVZxNk5lUjA0d2hZSmtXbVZuSTdDTkJWczdWNmJUcEZZMEUxUDZvWmhZ?=
 =?iso-2022-jp?B?RkRnaDd0WWtWNnlKVThPMS9IR25oaDFiYmFGMmh1K2k1enpEWUc5c3hL?=
 =?iso-2022-jp?B?b0ZEV2hYSEt4Mnk3b0pqU2xlYmxwSXBjOGZ3bmpOc0w1S29hLzdPdnlV?=
 =?iso-2022-jp?B?dS9EcWZTb0hYb3BUSk00a2FDVGVGYllwMUpINTFMMXRPZyticnFvOFVq?=
 =?iso-2022-jp?B?SkN3Mis4SWp5RHg2TlRtU2VFZXdmR01sNVBXY25wZ0poNnJncnhHK2VD?=
 =?iso-2022-jp?B?TmlETDNPbUhWdXN0UlFNYkFka3hmaFNhSElubElBU1g5ZUh3WDlUSUhY?=
 =?iso-2022-jp?B?OGpEdEhiTkpxVVBBNjlBYndRbXFLZllvbnVpaGw1RzBRK3grRyt4dm4w?=
 =?iso-2022-jp?B?TC9jblBpWXpUZ0pnTEo3azlOWFI2Z0N1NHFkZlp2UUdtS1RjUy9DWlYv?=
 =?iso-2022-jp?B?QzdMbno0WG9TUVlDb3VXY3FralRKSEMycE15bU8xZk1jSVJRa3NXYVBK?=
 =?iso-2022-jp?B?aTAyNUtnU0xDU0lLL1Y1QS9RT2NWQUt2VDBuU05YaG0vUHhEMVprc0s3?=
 =?iso-2022-jp?B?bHErQkR5UTVKZXhLS2VrUVhnOTFzVmcwMzNER1JUYWZKbnQ1c2RGRTdC?=
 =?iso-2022-jp?B?RUNnc092WE9QeVhiR3duVFkrWVBDL2RzRnJkeFp0dVBhQWFQWHpIU3c0?=
 =?iso-2022-jp?B?K0MzZkNVYTM0WHNJUkNxY01ONWpVVUZMZC8yMXNZb0lxbUdBTmwwRTY0?=
 =?iso-2022-jp?B?RTZQZXRYNllIbXRKWUIxOHJIT2hEMU4wWVE2M3M3cklVVDBxYnR6TDg1?=
 =?iso-2022-jp?B?bjVWaVFNa0w0Z3lQd3dSTDF3VXhiK1dRRnc0TGF4ekVick92RzhDdUJy?=
 =?iso-2022-jp?B?T1llekhHd3FRVStjOXM3MVhSN1JtbjJWeXhMRmtscnR2enk2NkhCbklZ?=
 =?iso-2022-jp?B?M2dtVC9NeXhHcHMvRko3Q3JYMHlSZHY5N05VeGIxbmtTcUVWTUZiWllK?=
 =?iso-2022-jp?B?WVVtZ1pZK0U1TWZFZEtlVUt0YmhxZCsvcHBMbHAyeUlid0wyNmQyZVcz?=
 =?iso-2022-jp?B?TmlVellod0E0WUVpT1U0ZHdDajV2b1VSWnVXMmlCUk9Db0gxN2djNUpJ?=
 =?iso-2022-jp?B?Y3pNOEo3cHp2eHhtQjRDMDZoU0VSak9MOUtWRlVVL0xIZ1RDMWJSUVY2?=
 =?iso-2022-jp?B?OU1mU2NnYkg5ME1vbUtPU2Q0WkkxZExrdE5iaDZwY1k1K3JydDRYd0ND?=
 =?iso-2022-jp?B?aXkvS21uMHFGNWxCU1l2OVFPdXFKZUE4aU5wdktoUkhlR2VGRUEra2J1?=
 =?iso-2022-jp?B?dEl4MnoxeVFiaWRzdlNjUHVmTkJEd3Zud1lYenAxQ29WMkFCQXJtdTE2?=
 =?iso-2022-jp?B?V21XczAvaWtlNGxudTNUeEZBSTY1UVNTd3hxbW9sV2l1MGRjV2gycVo2?=
 =?iso-2022-jp?B?NWFQUTllY3htQ09ueFdzNEM5ZWdoU2RpUktESDRocmhLdlhJUnVCb3Bj?=
 =?iso-2022-jp?B?bWdPZS82cnQxK0NsTmwzYlZZaFNJZkNyY1NHYTNlSmJNT0pRYVdNR1Fn?=
 =?iso-2022-jp?B?UlhQR0NyQjBZN0s5QUhBODB5RFJ0dEgwNUxRZlh0TG4rZ0ZEdXVmOFlB?=
 =?iso-2022-jp?B?QTUwV2VYQkFTcEE5anVZYkcyd0phRktsNTJzSnFGaGx3UlVTME5xc0gv?=
 =?iso-2022-jp?B?bk40OFJVT2grSmljOFBxSWFwV0NueC9uUXNhYmFuQUpQU2NCUmhyamQ3?=
 =?iso-2022-jp?B?SGQ2K2NTZi83dzFXYWp4Z2xsVXNRYm1pakJBbnBPQS9NWUlGNjVWSVdL?=
 =?iso-2022-jp?B?RjV6dGxrZ1VkNXhxZVFXSkM5dDJNdncvQzNtQ0FXZm5pZEZRb21EazZ2?=
 =?iso-2022-jp?B?bkVzZDVIOFgxSnlPZ3FOUmE5VWxxWEE9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(7053199007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?VkZpY3R1U1NZWVUrN3Fpd0ZEVWtlYXNUbUZpS0U4ODRyNHQyM0FXNVVk?=
 =?iso-2022-jp?B?V0hNNTM1cXNVSnVaeTNOMExvT2RVVDBSbnFrRVl6eUR1SjhpL3F3TUlX?=
 =?iso-2022-jp?B?Ymx2S0ZQT0Z0Q1hGTEpFV3ZWck9nSmtEcS8zN0hacEhFWWc3MU13dWE5?=
 =?iso-2022-jp?B?SmlGMFRMcGhVcHhHQkd3U2J4ZndRejMyMTJpTHZwSVVlbGFvTnU2VStB?=
 =?iso-2022-jp?B?Q1BqYW9qV284aC9BMDNDMlNVc3BCRm5yeWRWZXhTcjM3d08vQS9lUnl4?=
 =?iso-2022-jp?B?dFNXVmprRWYxNmg5b3F1d1V3bTYydjJRaWFxOXJHK2I2VERsYTNKSkFH?=
 =?iso-2022-jp?B?NFpCdnpuODJxOGh5T1luOXRrVHRpMy9pNkw5MTZ0UFpBeWdsL2d1eFJa?=
 =?iso-2022-jp?B?VkZTcUptRVdaSytwTkR0ZllrSXV4a0hhNW9OTjdiYlJWcHNVb2RkTEhQ?=
 =?iso-2022-jp?B?R1p4am1sN1JKWmRDNlc4dHRRVXFlMlg2b0NRN085RTc4QUIrRlZqRUtq?=
 =?iso-2022-jp?B?M3hudUVJV2ZLUUFzbXd4cC83MjdHRzBtVXgrblB0ZlJxOS8xMHREeDUw?=
 =?iso-2022-jp?B?TEJyM0NlSzRHZXZMYTRpT0luSHg0eEVDQXBjWXE1QytzY3RNQ25DZUxF?=
 =?iso-2022-jp?B?Q0RMTjdZSC81YlhxVjEzTEZTN3pCb0hhaTdScUErTUIxalN2ajlCY2Iz?=
 =?iso-2022-jp?B?NDI0VlZwRjJXbkNsMzVZUzVhaTJURy9ZWlNzeDl5V0hNRDZ6YXlJaGNC?=
 =?iso-2022-jp?B?NEtNS3lTY0VTcFdpdXgxSFRJTnl0NlNKYnN2bEZTa0hKanNXam41Kzlm?=
 =?iso-2022-jp?B?Mi9pbW52eUNmek5US3dTZG9sQkcyaytBVUFITXZlMlhjWFJHSzNsclht?=
 =?iso-2022-jp?B?MWN3czVzYzh6UkRZd3VidVRGcWs5cjE0a2dERG84TXBpVTJwS2VuYkNB?=
 =?iso-2022-jp?B?ZEpWaUgvTkpOVk9Ca0tMQWFPckhnMjhGaC83TEpXUVFCSmJXVlhhSTJ4?=
 =?iso-2022-jp?B?b1E1U2JsN2M5Ui9WYnN5VnhtYmRhbHNBMFA2UElPVzNsTjE1elVoSjFa?=
 =?iso-2022-jp?B?bklQUmxXdVJTQksxallvL0ZCWkNxMHdxaW5GNUhFTlh6L3c1VDJRLzBv?=
 =?iso-2022-jp?B?MmNYcWU0QlpSYm14aFVwVGFXUFZxN0xGTUQ1akN0TFhTM0pKS3BpTEN0?=
 =?iso-2022-jp?B?ZElSazZld3FZb0VrdW1NREluclZBYTlYZnNoZWNYZnI2THFLZHdUeU43?=
 =?iso-2022-jp?B?TjZYcWducDZCdHBSendKYXNBL0t3UnluMUpoMlJvMkR1MVRTd2VaR0Vk?=
 =?iso-2022-jp?B?N25uWjlwK0pFZG5ucXhYU3JMb1h3WXRRMXRVRVJMenBHSmhFYXZUd2Nz?=
 =?iso-2022-jp?B?K2R2QkVWMENtV3FDU1hVM0lTVng3UDM0WHB1dHdkaERNdXA4T3QvcFR0?=
 =?iso-2022-jp?B?dWFPYlovaGE0NGh3Q0hSLytqMjMxSEk5SlJ4ME1WeWFDTTRSSTV3M25K?=
 =?iso-2022-jp?B?YWFPRlp5WGhEL0ZqckEwVlBaeFMrOW53TXVzMXhlMUo3VWZZc24xTnFU?=
 =?iso-2022-jp?B?YzlScTBYYTBYbHpwTFN2cTVkSDAxdXVBNndEZ1k4ei9MdTd6anBJZDVy?=
 =?iso-2022-jp?B?RDY2ZndQb0RqanJxSzZxalpoWWlWMTZzSHA0RDlLdFptdXNraUtOd1JQ?=
 =?iso-2022-jp?B?elVjRFBpeG9WSTg1K2pxbXF1d3BpL1AxRnU1ZVZWb1V3alFKVUZlcml5?=
 =?iso-2022-jp?B?Q3g4cE54YjZaVzZPOEZEUVh4ZXBETzlXM0wyL0FNY0JmVHloZDNrR09I?=
 =?iso-2022-jp?B?Ri94aWhqNTRuRld5TW1Kb1pySTEzRlZoeUtpMGk1S01sS2FUdEdvT2pZ?=
 =?iso-2022-jp?B?Umh3OW5SSHRCSTFzazExQlJXYTRaVWtVTG9GMU9PSEVjTWplNXVBbG41?=
 =?iso-2022-jp?B?L2llQmlrbXhSWE5nMEtXWVFQQ1JFWHZNNnZQZUFQMTIvV1JGMHN6bVlM?=
 =?iso-2022-jp?B?bmtMSnhuZ0REem5HdzYwTjB3bDJ1K2F1SmhMeDFRSGFTQkR3czI0VTlL?=
 =?iso-2022-jp?B?aUlETytDck1ULzVtb2NvMXh6L05yT1JKcXQ0QUR1U2pYUFFYbngvZ3J3?=
 =?iso-2022-jp?B?MndsOVkyUFVUWkZFWWJHcnJrblZKbldDKzY4QXlyZTZpeTBvN0YxKzQ5?=
 =?iso-2022-jp?B?UzltSVp0Q0tYbjdaQjI0bHN2N0d1NFhQVTZpUDM4MEVWcERsZnRmaDl4?=
 =?iso-2022-jp?B?NHM1cHo0SzZCRE9sUVZ6ZUpjZWlubjhoUGFyY0xseGpjaHltNTlLdWUz?=
 =?iso-2022-jp?B?Zm9TaUZyM2tZMnFpR2xNUzN2YXZKalJPa3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e62d81-0dda-4d1f-1bc2-08ddf5e76d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 12:40:47.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 92QOsB7gPF3nOte0kGjls9cbzgJxxuLtAiHgWA8dNZzuCCOQZT7aYEjGx5HbQY3cEfy8OmSFEFHlybK9Q4IfsdzC3ArnUCeIQAmKlq6+wj+f8747mlwMK8+Sd5xn83Xz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 12:41:02 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20078

Hi Claudiu,

> -----Original Message-----
> From: Claudiu <claudiu.beznea@tuxon.dev>
> Sent: Wednesday, September 17, 2025 8:09 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>; pavel@denx.de
> Cc: claudiu.beznea@tuxon.dev; cip-dev@lists.cip-project.org
> Subject: [RESEND PATCH 6.1.y-cip] mmc: renesas_sdhi: Set the SDBUF after
> reset
>=20
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>=20
> commit 68dbe38ed7ba9141b9329eb203fe9762a93b60e8 upstream.
>=20
> For development purpose, renesas_sdhi_probe() could be called w/ dma_ops
> =3D NULL to force the usage of PIO mode. In this case the
> renesas_sdhi_enable_dma() will not be called before transferring data.
>=20
> If renesas_sdhi_enable_dma() is not called, renesas_sdhi_clk_enable() cal=
l
> from renesas_sdhi_probe() will configure SDBUF by calling the
> renesas_sdhi_sdbuf_width() function, but then SDBUF will be reset in
> tmio_mmc_host_probe() when calling tmio_mmc_reset() though
> host->reset().
> If SDBUF is zero the data transfer will not work in PIO mode for RZ/G3S.
>=20
> To fix this call again the renesas_sdhi_sdbuf_width(host, 16) in
> renesas_sdhi_reset(). The call of renesas_sdhi_sdbuf_width() was not
> removed from renesas_sdhi_clk_enable() as the host->reset() is optional.
>=20
> Co-developed-by: Hien Huynh <hien.huynh.px@renesas.com>
> Signed-off-by: Hien Huynh <hien.huynh.px@renesas.com>
> Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> Link:
> https://lore.kernel.org/r/20240430093724.2692232-1-claudiu.beznea.uj@bp.r
> enesas.com
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Sorry, I missed this and 5.10.y-cip patch.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro

> ---
>=20
> Hi,
>=20
> This fix is already integrated in v6.12.y CIP.
>=20
> Thank you,
> Claudiu
>=20
>  drivers/mmc/host/renesas_sdhi_core.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/mmc/host/renesas_sdhi_core.c
> b/drivers/mmc/host/renesas_sdhi_core.c
> index 725bd37b8c21..30ceda915f1a 100644
> --- a/drivers/mmc/host/renesas_sdhi_core.c
> +++ b/drivers/mmc/host/renesas_sdhi_core.c
> @@ -603,6 +603,9 @@ static void renesas_sdhi_reset(struct tmio_mmc_host
> *host, bool preserve)
>=20
>  			priv->needs_adjust_hs400 =3D false;
>  			renesas_sdhi_set_clock(host, host->clk_cache);
> +
> +			/* Ensure default value for this driver. */
> +			renesas_sdhi_sdbuf_width(host, 16);
>  		} else if (priv->scc_ctl) {
>  			renesas_sdhi_scc_reset(host, priv);
>  		}
> --
> 2.43.0



