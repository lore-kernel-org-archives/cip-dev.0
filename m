Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE2FEEB565
	for <webhook@archiver.kernel.org>; Thu, 12 Sep 2024 08:30:21 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web11.43384.1726129811229252217
 for <cip-dev@lists.cip-project.org>;
 Thu, 12 Sep 2024 01:30:12 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=H6Wbl5Hg;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1726129809;x=1727339409;bh=qYlfodyJxUWfCHercaMuRjGwGm64YaAlDWR1Stv
	F5yY=;b=H6Wbl5HgjHVtE0pYnUcSXpKlfTMRoPKQvoNqpstYnV5UGD3GYdS724xC4GDxJZmaJw9Ca
	3JFO7iiGKU88MuO0HoGHW9ghGIbT3Fdts8VZ5YXNkabqqb6wBrourgCFgSDIZ9FKs0f5rEbR2C4c8
	QAR/01NOYLWy8d0prIlBltczMRi5Ojyh//pMfvzMffvCG+SPluqwHCvRAb09kCbrTcBkUbZpRn4mk
	iaUCGwZ4NXBXLp0YKRdyLFK7c9kUL/xlC7/eYOLkpTKbNWOt+ecNoJRhmdwNm9J3EZKvxAlI5ofoW
	T6/HZ17YuODgJjwpjKmbsWgV/tHbr/t3OoM6eF5+uw==;
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 48C8U8Kr3965013; Thu, 12 Sep 2024 17:30:09 +0900
X-Iguazu-Qid: 2yAawTGyOEYO8UhTbN
X-Iguazu-QSIG: v=2; s=0; t=1726129808; q=2yAawTGyOEYO8UhTbN; m=tLsnHYRXASE/eTT+Bitiy8DoldhgLCa5H/fTfujiHMo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1803) id 48C8U7We433533
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Sep 2024 17:30:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmbaxBBAYGra4R68BH0C40aRDI8kvHkhQZemNX0edk/vJ7gtWqdI0s2FYEUYfB1b1UJjTcfXytfbWf1kU1AU/NJk+ZsbU6ddHFPMcPWEE7eNXouX+rJxbNoXNYfEVXiUsvFo8zhAA1G7FcO7wltdw0XT/o7TUOCBLJnf3UU53sngwMKffIaA/AbZs9TCfmpyDs8M+prk+NEjprhAuysanxABCzLd11bHhwcKVHPQKnBRQVdQPLEVqOgoXSX2eZNZoVovWzKyeAEULT1I1m+KO1HTD42GN1oNr+wHlIh1SoQhWlzD3fze0WzHhdUCBh1IyIjCitgSIJ0poxds+VhjoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYlfodyJxUWfCHercaMuRjGwGm64YaAlDWR1StvF5yY=;
 b=UP5iOoWUjbS69OCT1TilBoXR1Tzjcm+qNIY9mZvuRmuDBmHbzmwiy03Ebotme1nGBNb6jfxa1ka4djMQfFUowbMpEAZTD0E8RXZFCg3TLHyk+xq7IzyOh5xE44N+ccZKctXLkV1817thuc2kfA06ThKGzODG4Bl91vc2bz07NcZBPL1VaO4hG5D6yY0nqoNLuHm+LGz35qcf650SuE4QgRScRQSa6lOIi96rnVHciT50oPjZWS3VxR2oZiuA6I8qN3OelRyW7JjsAgHO9932IMTj5KZKgX3CChhrEYUZZimvDpmB3HGxA3pzxBRo3mwfRE3r0x7moDyDaAbSJYhbeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <jan.kiszka@siemens.com>
Subject: RE: Please enable CONFIG_PID_NS in cip-kernel-config
Thread-Topic: Please enable CONFIG_PID_NS in cip-kernel-config
Thread-Index: AQHbBOxdcFD+QVcV1EesYa0Z2ph9jrJT0IUA
Date: Thu, 12 Sep 2024 08:30:05 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388B9582DD63F3AAE3C4C7D92642@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <d2aba9628d363afe28efc0ffcb6596c4fa0eed33.camel@siemens.com>
In-Reply-To: <d2aba9628d363afe28efc0ffcb6596c4fa0eed33.camel@siemens.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|OS3PR01MB7407:EE_
x-ms-office365-filtering-correlation-id: cb34da64-805c-403d-bc72-08dcd3051a93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?THBmRlN4WWJPclRUc0dQNlJtUDY5Z1ZUTGo2dGxQUlI1aTZLSVZ2aVlrWEdL?=
 =?utf-8?B?M2VUYlVqTVA0VjNISWxHWmp4aTRvdEE0QllnV25tYlBpNi9pbXVvVTE5NkEw?=
 =?utf-8?B?akNXbVdJY1VPNm1GMzBJSTNtL0RJeTYzdWNGYnB2THVVVGU0MWFJVFpnQ0pG?=
 =?utf-8?B?VWRmU3ZhR2ZSTHhycjlUMXVRd3dodVJYZFNBbEhNcVVyc0JMMTVzSFZWRVk3?=
 =?utf-8?B?TnJWWEhqOUduT2pPN2FYUGdVR3AwT0FsOENLVE5LdmsvSmR4alBRODhaSnUx?=
 =?utf-8?B?aFhUUTYrdUZrQkpKbzZxdmd5emRjRlJoRTF2cDUzd0hybysvQ1h0OVI0UnlW?=
 =?utf-8?B?aTlCSFI0VC91bXRxZ0ozWkc4SWxZREpHY3pQYktoMnYrdG5FcE5QWTdZY0Rp?=
 =?utf-8?B?c2RaVUNjS0dCRmlHVUtmM3FEK0p3Wlh4UExuWjZ5OE1tR3VBcE01c0RwRkNP?=
 =?utf-8?B?MFJCakhnUW9iVUZjNkxsSnZvNVFTSTEzQUluTDNWR0w4NXdzK0R2Yk5Vc3NK?=
 =?utf-8?B?cXNsZGE5c1IwbytJT1FXSzBKZzFNWlJPVW9IMjN6SlN1dytKMkFYS29lSDdY?=
 =?utf-8?B?LytGa1BOdzdyNFZaL1ViVjE2NS9FZi91dDVFZlEwQlV4Ty9VSXVoSUl2RlFv?=
 =?utf-8?B?ZUVoQnZXZHJ5SmVORFkzTGJHeFR5TFU4K1l3ZG5OS3JGRDlqSU5nbFR6bjlh?=
 =?utf-8?B?Njg5aFAwTHJLTG15S2c3d0E5VVFrSHYrSUxkNWVjMC8wZjdWYTI3OVAzZG5Z?=
 =?utf-8?B?Q2pRMDU4RUg4NlRhVng4YXVmMWU4ZVN1SFN2VlpxdTc1aDdwMTcwRmVjd0xi?=
 =?utf-8?B?VEVjeDFsNFRFakxuQ25GcmZDQXN2REhBYXQ5YXZIa2YwSnJ2YzVNVHVLQURH?=
 =?utf-8?B?MGdrWkU1MmxXTFFRQ2U2ZFh4L1B1d2l5ZFQ0VVE4Wnk1eVlhOW1TcmI3YWkw?=
 =?utf-8?B?bHpjbFdXcFh1SEVaaUtNVXdycGpzL1daS0ozL1FSOGtGWmNDbWtCNGx1QVBU?=
 =?utf-8?B?YWpqOGZLRkk4WExnRStKWldQVnRQMnlMYVI3bE5adWZxRGJlWWhScEh1Rk5z?=
 =?utf-8?B?bkdGTTROZkhONDF4ZnRmLzdoNmVHZ1p0M2w0ZTFNU3lQb2NoWjlPZmxMd1hz?=
 =?utf-8?B?cituUVVQdFN3eEljQmNScFBLRVY1R0ZaK0d0M01QMTBQQXRvNHFNVWZXeVli?=
 =?utf-8?B?VEdSdmJabTFoZDVHakF6VXUxZmxoVW9pcVZaeENyZ0hzYktkL0h4Qjg0TjBD?=
 =?utf-8?B?c1F3NWF3UWZwd1JMYWh4MWtiK3FacGhaQXZBY1ZGaXR5aENjaE5Jc2xmT01k?=
 =?utf-8?B?d3VyVC9MR29XbmhPMzU3SW1ndlJJZlBteU9vY3NueEN0T1RiSytBWW83NUJC?=
 =?utf-8?B?Nno0NG9DVUs3RmdqSkQ0bTRuWVdMZzh2SGQ3V2dUNUtVU0xUTi9RTllLTkU3?=
 =?utf-8?B?UGlCb2xiU0N1Z3RubkxmT3ZLM2RVOGhQN1Z2cktJNmhNcG83S0pQUisreG9p?=
 =?utf-8?B?U3V0UDk5RXQ4VmNZNURrN3J0WnZmc1FyR3pHakVNb2ViczBINkt3MTRod1d3?=
 =?utf-8?B?RWpvaXRkWDJnaHJEVXNadzJwcG0wemQ1LzFZbnB4L0YxUjNQWXFNTlpUZGZn?=
 =?utf-8?B?Y0VWS0dKK290Sm9DejIrV0tqM0g3cWMybUprMVNQNDE3bnI4VUJCT2ZubGxD?=
 =?utf-8?B?SC9IVjVobk1vU1RxYlN3ZjJFbk5UbXcydHRXOVlQemtGVUZHMFF6Y3FIU0Vu?=
 =?utf-8?B?K0VSYzdzVmRWVTNwbjBBcGhnaEVNMHp2QVdsc1o2YW43VTYyQ0tkQkVEQ1FV?=
 =?utf-8?B?aXUrMjRtTFE0NCs4K3NOV1hwYWNqajVmN2E5VHJsWlFFdndwOUlkZFZlRnM1?=
 =?utf-8?B?b3hPMFNLY25FVVBkeFl3RnJYS1dwNkJBQWluelM5SGNkRkE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NGVUOWx4QlduRXo2TTRvYTYwR3RWbkhzYTRiQVlONXhEYkhyQW1IaWxKTmM5?=
 =?utf-8?B?R1JpYSsxOWxVV3YrZXpjblhHeHRwNXExQUVraEJBTytGMk8vSnFZUDVnZS83?=
 =?utf-8?B?Y2ZhSUlseW1RNUxlZGhXY2dJSVRzM3gyRWNzZEl4OURlRnllZ2ZaUklKcnl1?=
 =?utf-8?B?N0szQnhyZVNjV2MvODB5a3Y5TFA4QWVUa1AwU2NnUGw1Y2FpaHc3eGI4cFg0?=
 =?utf-8?B?ejlVbUNmY09EQ21uTGVHdUJ0aWZFaW0xZkNnVm05VGg1YlVVY3JQcUlIUFdv?=
 =?utf-8?B?R004UlZBaUMwbEZ4VzhqRElsR05wTXI0ZVc1UDVoVlJadWR2ZmhqaDRLSnlY?=
 =?utf-8?B?cVVMbUswa2M3SjhobmVRTE1lbWRHdHZSUnZ3cVFiVi9NTk1MZnlBcEU3dzl3?=
 =?utf-8?B?Nkp0N29aK2RKZExyWk5tcVZvcE1PSksvUDB6Wjd1Q0lWSWRyMjhlV3N6L0Fv?=
 =?utf-8?B?S0oza0dFMjE5RENDSG5Ia0ZiNld3Nlg3MEJXT3lCVnpNR01WWTRmWDBEN25n?=
 =?utf-8?B?a2dVWkJPQ3g5dUgzSjV5L0Rkc0ExWGZOTTJnV21JSDdSMVBDeXdZR25kejkx?=
 =?utf-8?B?VmloRXBITFpVeUZjZWRpcU1FWURxOTBTMzF3WXEyc1NTWHJUbC9Pb3hRSStD?=
 =?utf-8?B?TzR1aG5nd3NyNkxYV1RURUFrQ1VpRHI5c3hNcGJzd1RHczRHK1Y4cElwSFRa?=
 =?utf-8?B?bG9CU1N3SGJlblZVMlYxQTI4REk4WGVrV2xCbVJKdnJoeHo0dlJmRnhRK1M1?=
 =?utf-8?B?cUVXMko5RWNJd25qNjFqQk5lMTBzT2hKZWorMS9Lc25pckpqcTIvcXFWRUto?=
 =?utf-8?B?dDlzZlV2N3F4OFB2cGw2UXNhNi8wZ0pWVFRsUnZEUjAzSUhocFIyYWdjbjlU?=
 =?utf-8?B?dE5OQTlraHEzOHh4c0RUWXE2UnN4bmV4bzNsU1NZR3JpeTVWQTF3QXRQbkhC?=
 =?utf-8?B?cXFYVFpQTnFBajhJL09ERXJuNTNxbFkxYUxpUmw5ZEdHQXpzZmd3Y2JkWE5U?=
 =?utf-8?B?cHhqakNkTVY3N2J1ZE1iRWh3WW1uZEVEMEsyRXMrUVdnK1Zidk1iNEFpZTlK?=
 =?utf-8?B?TlRSZ3paSVY3UFh6RTM4OE0vUkViTTV6bnVaWFlwdjFjNDJub3Vma2xRbXVZ?=
 =?utf-8?B?UnJIYnhobnl1aUhhL1Jtb1VnNGdzN09CSnA2ZndKZkRhd250QVVLcGJOaks4?=
 =?utf-8?B?TStJdUtzYXZDMWJ3enJNWElCU080RlZNUldJVnU1Tm9qeFJ1NTF4VTZxZkFv?=
 =?utf-8?B?aEEwMmlCZ3gyOEFkOG5yUWFzdGNOVys1TVBTTFFDVEpDK2ludjVJamFrdVo3?=
 =?utf-8?B?SmNSYVpBSWRJMWRNSkxoL1VBaUt3SlFFckNEcXcrek0zTkhqNGxlNUk3U2g0?=
 =?utf-8?B?dkNoaW1hZ0FaajdXTTk1c2tnVit0SDZza210eGdnK0NuWnRYSExjMVQ0a3d3?=
 =?utf-8?B?L1Z2aWxOWmlpNHFFVmRDWFFIeU1WekRXUkRZZW1kY1dwSnE5bVRQQkozK3BW?=
 =?utf-8?B?OS9YYnVXZFdqdHBQRW50dHdkTmVUMVlrTTA5ZzRGN1hYU3BPQ2dWQk5DdmxZ?=
 =?utf-8?B?OUtzZjBZdWlOYkQzcFRTSm5tNXRSRGtDcmFpclZsTXFWVzBMQ2VEWGFQVkdE?=
 =?utf-8?B?WTVjKytIRGVTaTJVTmFpM0k4T2g2Wmc3RklhTEJoSkQrRUljbWdrTm1mbVNX?=
 =?utf-8?B?R2lHZjVEOTA3dy9mcGU2RnE1S2NOMDVIVkFFUmRqUjc0VmM3c1NudkszWGlZ?=
 =?utf-8?B?eXdIeHcwWk1iQ21URkxEWkRKTmxKK3ZiUmVFVjUxcm9Fc3pPR2hSeUM0L3U4?=
 =?utf-8?B?aXNHWjFxaVFpL09VVWdKMzNtK2ZzYkdxNHUwTzlEK3lJaXFUU2ZIeHhOd1BR?=
 =?utf-8?B?bHJqTXZzSTRpRTV6MlgxL2lHZzdSREVFZ0c4Vzl6REhqeDg2S0U5SXFnOVBv?=
 =?utf-8?B?NlFjZ2ZBc1FJN1FEWGc4NnpwMlMwY3pYSW9rQXNYYVVhVkZsUWNzU2tQRm9p?=
 =?utf-8?B?M3lzRVhoWEp6bWdJbEIzanpsN1I2YUFVQkVoUVRCNHZtcXk0VmY5QXFjcHZn?=
 =?utf-8?B?ckFYL0FFUVJDOXdvR3ZOWno5M3hkYlhIc3puNG5ESnpycHBjYm03WmIzdUFs?=
 =?utf-8?B?dTUxaWM4TjRvWkR2SS9qUXhsMkxLZi9ya1JlUWVRdmVPdjlyZWxIdmlMNlFJ?=
 =?utf-8?B?OXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb34da64-805c-403d-bc72-08dcd3051a93
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2024 08:30:05.3809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfHlGySDDhHm9XTb8tQOBU1vyXyq/ooJJmGxYEcH3WS2HMzgcfYMtEaQAdMwGV6VqggdafYkK9M3BTQgSw6CHc4jzgt1vK2UobvF+ME8iG6pVXGcFk/d+eTU26b/zzgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7407
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Sep 2024 08:30:21 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16890

SGkgRmVsaXgsDQoNCj4gcnVubmluZyBjb250YWluZXIgd29ya2xvYWRzIGlzIHF1aXRlIGNvbW1v
biB0aGVzZSBkYXlzLg0KPiBUbyBhbGxvdyByb290bGVzcyBjb250YWluZXJzLCB0aGUgQ09ORklH
X1BJRF9OUyBuZWVkcyB0byBiZSBlbmFibGVkLg0KPiANCj4gV291bGQgaXQgYmUgYWNjZXB0ZWQg
dG8gc2V0IENPTkZJR19QSURfTlM9eSBmb3IgYWxsIGtlcm5lbCBjb25maWdzIGZyb20NCj4gPj02
LjEgb24/DQoNClN1cmUuIElmIHlvdSBoYXZlIGEgdGltZSwgcGxlYXNlIHNlbmQgTVIgdG8gZ2l0
bGFiLg0KDQpCZXN0IHJlZ2FyZHMsDQogIE5vYnVoaXJvDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiBGcm9tOiBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZyA8Y2lwLWRl
dkBsaXN0cy5jaXAtcHJvamVjdC5vcmc+IE9uDQo+IEJlaGFsZiBPZiBNT0VTU0JBVUVSLCBGZWxp
eCB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIg
MTIsIDIwMjQgNToxOSBQTQ0KPiBUbzogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcNCj4g
Q2M6IEtpc3prYSwgSmFuIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiBTdWJqZWN0OiBbY2lw
LWRldl0gUGxlYXNlIGVuYWJsZSBDT05GSUdfUElEX05TIGluIGNpcC1rZXJuZWwtY29uZmlnDQo+
IA0KPiBIaSwNCj4gDQo+IHJ1bm5pbmcgY29udGFpbmVyIHdvcmtsb2FkcyBpcyBxdWl0ZSBjb21t
b24gdGhlc2UgZGF5cy4NCj4gVG8gYWxsb3cgcm9vdGxlc3MgY29udGFpbmVycywgdGhlIENPTkZJ
R19QSURfTlMgbmVlZHMgdG8gYmUgZW5hYmxlZC4NCj4gDQo+IFdvdWxkIGl0IGJlIGFjY2VwdGVk
IHRvIHNldCBDT05GSUdfUElEX05TPXkgZm9yIGFsbCBrZXJuZWwgY29uZmlncyBmcm9tDQo+ID49
Ni4xIG9uPw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBGZWxpeCBNb2Vzc2JhdWVyDQo+IA0KPiAt
LQ0KPiBTaWVtZW5zIEFHLCBUZWNobm9sb2d5DQo+IExpbnV4IEV4cGVydCBDZW50ZXINCj4gDQoN
Cg==


