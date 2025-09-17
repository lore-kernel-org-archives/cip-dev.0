Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98FCCAC59D
	for <webhook@archiver.kernel.org>; Wed, 17 Sep 2025 12:37:22 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.21541.1758112632444320000
 for <cip-dev@lists.cip-project.org>;
 Wed, 17 Sep 2025 05:37:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=kpU0sUne;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.131, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:CC:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1758112623;x=1759322223;bh=aQNgOtR/jCKzakAbBP3Fe+pkQ9UZm28yf1J1V
	U7nZ4I=;b=kpU0sUneg+CBCBHNcgulRkBUqL9TXHKBceNHFqI9DXcg3IRTMfn1tG6HaqbCvRZAh4R
	uCD7aa6QLIvFICry1T7EBynZFeBqBLseZP3fKcuZ3HhwbhPbE45zEtWtH4lxxgeshRb5SUtEyiAAe
	CjG6ejEcnf83j/txVF9Qmaz2ZxofCCjT5LbQrJsgH5V5+Mbl12zUtbX9MBwBPnniU/NZc3vfKcf4/
	F9VXhsEisblOZQn3nlevwxhvnkl3AqvM+mmNhN2WrAaxILzOhfYGKLkrY6VTlwDiDBmtcPolIf2cH
	2cGLq/LtqfUMibt4mvexOVvs/lIHajpWyxHYLpUU2HGg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 58HCb3EZ724724; Wed, 17 Sep 2025 21:37:03 +0900
X-Iguazu-Qid: 2rWg3ixn45ARnOmcqo
X-Iguazu-QSIG: v=2; s=0; t=1758112622; q=2rWg3ixn45ARnOmcqo; m=ZX2jzBroVxyGmDC1IeNwOQbn7aGzG/CtGiDjUapefgE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4cRdZ633Qhz1xnZ; Wed, 17 Sep 2025 21:37:02 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NyeRYy1PadrY7695A1c7YuD8MRNshOZyUhhNhyem3CqeC5XMyHbJlKE5FCn2yid0bIxFFagQxs5MONdrRU/ENrDqkeddFtcNfYJVXCYsBT5Ne7jCZIcNiToR/8TZGPzN9jEP475OveLwps4B8N1rLJqaogR5DjrWUXamzLajL/R/lpgqgPMKelEMIKyr7LtgZa67ddGAB7LshXXT3ZRAusS6QpNRS31CfhprQq2tDGnDsrK143LF4+RyFEizEKZ72Eary7KPZb50/G1bf/hL9xt5CjtS2LdaFjjPL//62QFRXZWn9i69UyGM96FbF35WmqK4Kzk/uKDqp4qBfCCkQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6oXIjXka8fxvMHckpKx4oex53Ej+gfxEdZqpC6/nH5Q=;
 b=F94JrlJQhgVHqBWqZ+0uuoNsamWW+yn1wnikJqT9qrUH2ZPcpQFF4hJ25HbPWQzC5/vYNQ1J5eZYOXckOl9W051befWWURf2jZGB6yWJ2QbrPbFdVVQaWHIirZs/saQfDi6nxMkla4UAYnvD5XFzqN2gDLe2YftWbk/9+I2HD2PjjQaFTiIrea9YHZJU6Kt0BpohNdIyW5GHYkiMvlQ6jy0BqDwp1CJUrx1wLKjRZXjabOw5UjY16NqIJdsoa7/VgK3iFekY6xomoe0j19ZoSWD7SH+iuSnq6UD7boiTDVxkU4U9t5nMks1tAUpXRP6F0m3t1SExVIlBZ/Jl8GhnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: RE: 5.10, 6.1-rt
Thread-Topic: 5.10, 6.1-rt
Thread-Index: AQHcIjDbySaL1Q57l0Cja2xrKqVl+7SMUD+AgAreHgCAACxGsA==
Date: Wed, 17 Sep 2025 12:37:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB148186F86C90266479AAE5CE0CD17A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <aME9OVprzmQL4E/A@duo.ucw.cz>
 <TY7PR01MB14818A575FEA1E5F9C91B705FCD0EA@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <aMqF3GAHMqMD8wba@duo.ucw.cz>
In-Reply-To: <aMqF3GAHMqMD8wba@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYRPR01MB12743:EE_
x-ms-office365-filtering-correlation-id: fee981e7-1487-403b-1c5f-08ddf5e6e602
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NFRYNmNvYVFqdnM3VHN1ditud0pwTDJFa04vbjNZSkRtOFJ5NlFyQU10?=
 =?iso-2022-jp?B?ZXFuN2lvN2JoVTZHRDhDQ3BNRGRzQWp0Z0xUUFBUWGIweTlVTXdxa3ZW?=
 =?iso-2022-jp?B?MitMcEdJTFlLV0ZwL0tFbzkrUHl1U1daWFJqWEp3WkZsaHFLK1JkWUho?=
 =?iso-2022-jp?B?cU1RUlNjNFJkcUdLOHFBMjZwZHBDVFA1dWxONWo1d2JVejBqbmNDK0ZC?=
 =?iso-2022-jp?B?eENVWXRBeUNxdVpxS0pwWUtCWVFvKzNSY1cwOGV0MlRZR3ZhVWhUZmVX?=
 =?iso-2022-jp?B?bGRKdHRzWkh5a1JtUXVnTXJtSE1PWjg4K2VaMVlXSVMyUmdBL1pJa2xG?=
 =?iso-2022-jp?B?MnJvTjJHYzJRKys0Ly9aSEhJamsvTGxDcWY4TVVRSHdrVVBLcU5ocnlI?=
 =?iso-2022-jp?B?S0doM1BsNTl0bE1RWmE2NCtPOFRFd3YrRVFpLzNCdUxPYjE4OWx2dnd3?=
 =?iso-2022-jp?B?ejNPcytzb0VHRVhmSGZ0ZXNGWVNqcS90WElZUU5jOVBRK0tFSWl0Zkdy?=
 =?iso-2022-jp?B?dDdFVnd2ak9QdWxIbVRESzNYVG9MSkJrNFM0dDladStCOTVJeTZlSDBj?=
 =?iso-2022-jp?B?ZXB3cFQ1TThwRGFpUWtjbzFMTy9tU0RhYTA1RHVxeHJidnIrRklKSDRD?=
 =?iso-2022-jp?B?UUkxVTI2ZnBySDJzQ2kyVDBRVWYzY2ZsV1VwUjVYbGdPelZFYXJZQ1pL?=
 =?iso-2022-jp?B?UGZpdmhrVyt2VDkvb0dBWXFhSFZKb0FYOFNmMU8zM2tzcnhqaGI3NlIv?=
 =?iso-2022-jp?B?TUlqMHA5azY4cGZpZ2VjRW5hWnlGdHJxdFVycEJEck9LQXlDRVFCemhs?=
 =?iso-2022-jp?B?ZWVMNkQ3UXQ0WnN1K3R2K2kzV3BLRjRyYzFRcHpzOEdVb3Voc1VaT2Q3?=
 =?iso-2022-jp?B?Z3ViVUNBM0ptaFo4aWx6bXdEQjNyNEJIajFqd2laR29acjNseWxzdXJ6?=
 =?iso-2022-jp?B?dGZnNVRtR1dwRUtva1FhSzZSaXpsUkJtazBTbjE2eG9UTW55VDd1TmM1?=
 =?iso-2022-jp?B?OXlvRytCNkhYbDl5aVRLbXAxSzRZZTZiMnRGbE1HUSt5bis5VDRyT0F3?=
 =?iso-2022-jp?B?Sk5kUjFIMkgwVWFOU0d5R1lBVDBrWjFJQTdvUVozandRaEljSUVGY0xw?=
 =?iso-2022-jp?B?NkJ5K2JYa2xCcGFWWVJVbjJrcCtPR29USjAxZ1NBS0d2NDNIa1p6c0Q5?=
 =?iso-2022-jp?B?alJBSzRpQnVwZHRSbUxFcFl4TDc2MVJLVXk5Z1JjL1RpUFl4dXBpSWU2?=
 =?iso-2022-jp?B?L281N0Zzbi9GSWp6K2pkaEV6dlNieWlFL01jR2QxQi8rT1BWYVZOMkNw?=
 =?iso-2022-jp?B?ak5DYno3QS96aG9hVWZzNVZRNFREaUlrM0VWR1d2VW9sSVdHV2ZaWlAy?=
 =?iso-2022-jp?B?T2lpMmRlc0YzUXpMcGZKcnJkeTFOQ1h3c0dISHc5a3JzTXpRSGNyNjN1?=
 =?iso-2022-jp?B?QVRwUjlhWlkwcERQYW5rQ09rZjFtK2R3NHNWTHI2Nk1XbXJ1UXZMVitm?=
 =?iso-2022-jp?B?MWdycXVkUEhLNXEvaXpYcmllRUcyZmlDZlQ0NjdiYXpIbzRsdTI2cy92?=
 =?iso-2022-jp?B?SXYweFo5S0FuZ1MrZVp4Q1p6S3Q2ZkRjQXVqbzhjRU0wQXgxTmJ6VWVn?=
 =?iso-2022-jp?B?T3lCbG0xUUpDcnZadG5aWmZYaGZ2V1FzK0M3cDkrMlJhSlptQ1JEV2Yz?=
 =?iso-2022-jp?B?VytwSVcwMlR3TFhtcWsxT1dkVXljbGVJZk5PZDEyTlZwcDBWMDllWUNj?=
 =?iso-2022-jp?B?N09lelJNUG5uNThZZDZtSi9RTmk5Q3Jnc3E4YSt2QUlEcXZNRy9GTFNZ?=
 =?iso-2022-jp?B?NjFzUXUycUpyNnBiSGliTWFQdXVaMW9FZDFSMVpvUHdtYk5HcHBVZ1NT?=
 =?iso-2022-jp?B?eldYTmZNeDlXM0JjWTlqOEtJcU8zMzJGT3M2S04vQm1SYjliU1U3aVI3?=
 =?iso-2022-jp?B?YkR5UElHUlYxOUdXRTdidXU3NDg1NEV5Zm9iNGsxWU5xQkI0YzFCaTBN?=
 =?iso-2022-jp?B?TXlqNjFBUnpKd2MrdjRmWHhPNGp4Z0Z6Y0FQVDZSMkJVc3pmNXFaekRz?=
 =?iso-2022-jp?B?ZE56MnI0MDNWMUhQQnpWOWhkVXcwZEpFV3p1NVh2bFNZSE9lWlphRCsw?=
 =?iso-2022-jp?B?cmNOdnVnc093Y0VUNkUyTkVEWTR2aWx3PT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?Zk83SmNWM2FtUUYyeGczK05NOVp6cEFkM2h4eTNvQ2F6cm43NHFtYlZ4?=
 =?iso-2022-jp?B?RmVjNFNDL3RzR29vSXVwdHdOdGRpMmx3aWtER3RGVllaejZTUllNdW1B?=
 =?iso-2022-jp?B?WTQxTkY3cy82akVLZ0RmWkFic0NKQzNBWkc1dkN6NXpRTnVxWXY5S1Az?=
 =?iso-2022-jp?B?NUtYTXNLSVhMREVaZit4WkhzY01ld21BUHhuYXc3VEo5Z1ZiVW5NUVZZ?=
 =?iso-2022-jp?B?OUZpSlZVSDVXZlQ3U2ZDL05TYUpwS3N3SUNGTnVMbEs2Si8yNkVzRXJN?=
 =?iso-2022-jp?B?TUk3WkNFZnQ0ZEZVZVBNUFhKOHFrRDI1SGxneDRDeUVWWUpWUEw4TFN2?=
 =?iso-2022-jp?B?Q094ZVI2NU5ZdHdpUlZwZzBxcVI3NnRZeDFWNnY0dk85N0QzbG5kT3No?=
 =?iso-2022-jp?B?aVJ0MzJ3WGpSWStWOHByZ3hKVmswOWo2MmNkRkt4TmJnODZqSTBDclpV?=
 =?iso-2022-jp?B?a21UWnFaK3RiemV1RzY3RmZtbWN3WU9vQ1htOVI2ZktVdzZFdVBMQU1K?=
 =?iso-2022-jp?B?dFlYY2RSTjBoSmJlUkxpQUwzaUtjbVczeWpJU2NXSXB2STBtYmhTK09y?=
 =?iso-2022-jp?B?ZzllVGJ5YzViYWozSzBwMUlrQ3VoVlVoajFvanRPaXhBU0Zxbnhnb0M0?=
 =?iso-2022-jp?B?TWpabHJON3VZamd0cDJoeExlRHVDNWp6MUY1SDZGb2hlSVltNjlPWDZj?=
 =?iso-2022-jp?B?QlhBK0ZjY3ZMWStVd3l2OUVBbU1nYStoU0lIQW43d1NFN0pyVGh6WW5Q?=
 =?iso-2022-jp?B?ZXFEWEdFMURoN3l1M1l2N2ZvMlNxNmc5c2lUYUhkUGZ1aldlY1N2RG5M?=
 =?iso-2022-jp?B?K1JXTG1ZQmFsQjdlZkkxdzVJQVp6cjhDYTBJTW93cjRQZVlUWFkrKzRU?=
 =?iso-2022-jp?B?YWhOSFpZR2FjTHdwTS9tUk55NnZpSitSNE9weEYwcFdjM29wVzR2NlBs?=
 =?iso-2022-jp?B?Vm10Q0VvM1poc21pbmZvV0s3amthTGIzYXNvWlppNFlHeE9ScDAwWDZB?=
 =?iso-2022-jp?B?WE9jbjRxZnJwSEJqbWNxRXhPZmxLUUFNZHhPZDBybkliREZ6c0syMjZu?=
 =?iso-2022-jp?B?QWVnQ3gyVUNaRXdpWVh4cWs0QXMvZDRhK3BqdmJTeWlxVnFHaVkyMXVS?=
 =?iso-2022-jp?B?cnNhUFIzRHVZWmdsVUJyMzF3KzJlMk9NbnZZQ3RzOEY0Z00xWGJqMFJj?=
 =?iso-2022-jp?B?TC9vN2N2WUdVeDBmWVhDaTBiTjlSbVJjamtoM2laV0lieit5RnVLbGN4?=
 =?iso-2022-jp?B?eVZXM3ljdFhvcVZoTENXb29aSklWVE9ybkVSVjNRTnQ4dFdBdHRvVDNE?=
 =?iso-2022-jp?B?WjFscVNVRXE0Nlc4bW52bjJzSjd0T0s1VDBJUWhHQVNqL1pHNmZhN1VH?=
 =?iso-2022-jp?B?NEUrQkkxODQ5azdwdDlHcW83MVV3UE5uc0lubXEreGU1MnN2MklrQzZB?=
 =?iso-2022-jp?B?cHVBWi9rZDBtRnZ5MXpRS20vMzVGdGV4Tkk2TEV3S3NTUDFOY0x2L3Ux?=
 =?iso-2022-jp?B?QzdtWDRsdXZneTlsRC8wcTBTMGxlWVcyeFhRaGNKTmlMdldoRTBlc2ow?=
 =?iso-2022-jp?B?aDNoQ05ZZ2VXQU8zRFZyNDRUaGRMRFg2R1pjY2VEZDFGTHBBTGFRZk1s?=
 =?iso-2022-jp?B?K0o0TVI3TE85NXF2eURaM1RrZ0F2QVRmSXJQajNiUUkvVWNycWtwSU1m?=
 =?iso-2022-jp?B?L3hOczhBb0EzRXRKWUNPNEZKenBLNTlqdlRUemNab3pkQ2JVRDdjc0ta?=
 =?iso-2022-jp?B?ejZrNlVhQURpellLSnArQUxWS3kyYUFlWkw5blFIZUNIMG94QzRMaFF1?=
 =?iso-2022-jp?B?UDkxUmpLRHZyS3d6a3dDYTFwMUhoRFlBc1RKeUV6RTRKYzhvdHNoR1NF?=
 =?iso-2022-jp?B?UzZsN0d6VXhjYVpFczZ2d3p4QlRRS1k1SHRndHp2RVBBZGo1a0pGMGRW?=
 =?iso-2022-jp?B?K1JrcXRKMkVJb2JJeW5USVZFSmtTUzFZZURlNEt6RTNoZHp5VzYyQ3JP?=
 =?iso-2022-jp?B?cWp1aHFCRGZyclZCQWFLNC9qYWMzSko4bTNpK3BDNFl3SXVHRDUvejlo?=
 =?iso-2022-jp?B?UTE3Sm5jTDhGRWZkc0h0ZXlkYmJLOXBMMm1aT09WQ0FaRG0yZk5nSlR5?=
 =?iso-2022-jp?B?VVMxV3ZGOTBDcjFRZ09NRHhjTmxiOGNpaDhKZmN1aW9TR1VFb21BUkpP?=
 =?iso-2022-jp?B?YjA5ei9hdTdOaDNaNDZRMFJOcnlpclo3WkVlVWxaVkxQdTVDV3RLUWVq?=
 =?iso-2022-jp?B?cnQrbXc3eXhJOUZuTmlvT296bFBNOGR1V3RyNHRselgzdEkyTkw3akl4?=
 =?iso-2022-jp?B?K2FnQm0rRVdUa3psRTZmTGRRc2E5SkEwVkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fee981e7-1487-403b-1c5f-08ddf5e6e602
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 12:37:00.6479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UC8nup8qSBDjKpACNJy36gtTFJS+V1ikZMHfuFDzgJM/m5FquGBX15PKuWHhJhPSzm+/0irnTOEgpOpN5aveu883mlq2nx2CQvAvH+LAtdOZ9nwPobt1yNJY8AUdPffO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB12743
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 17 Sep 2025 12:37:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20077

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, September 17, 2025 6:57 PM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#D#I#T#C!{#C#P=
#T=1B(B)
> <nobuhiro.iwamatsu.x90@mail.toshiba>
> Cc: cip-dev@lists.cip-project.org
> Subject: Re: 5.10, 6.1-rt
>=20
> Hi!
>=20
>=20
> > > There's 5.10.242-rt136 out. Could I get matching 5.10.242-cipX, or
> > > is it okay if I create one?
> >
> > Thanks, please go ahead.
>=20
> And it looks like v6.1.151-rt54 is out, too. If it is not a problem, I'll=
 create
> 6.1.151-cip release and use that as -cip-rt base.
>=20

Thanks, It's no problem for me.
Please update and release linux-6.12.y-cip and -cip-rt with 6.1.151

Best regards,
  Nobuhiro


