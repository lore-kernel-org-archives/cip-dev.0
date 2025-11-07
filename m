Return-Path: <nobuhiro.iwamatsu.x90@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9EACCFA1B
	for <webhook@archiver.kernel.org>; Fri,  7 Nov 2025 12:17:30 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.9840.1762517839733632693
 for <cip-dev@lists.cip-project.org>;
 Fri, 07 Nov 2025 04:17:21 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro.iwamatsu.x90@mail.toshiba header.s=key1.smx header.b=BdsmMxMj;
 spf=pass (domain: mail.toshiba, ip: 210.130.202.132, mailfrom: nobuhiro.iwamatsu.x90@mail.toshiba)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=mail.toshiba;h=From:To:
	Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro.iwamatsu.x90@mail.toshiba;
	s=key1.smx;t=1762517824;x=1763727424;bh=XDOVCCXDJPAru3GMi71MjtWK2h/9j17cMmMek
	N01PT4=;b=BdsmMxMjO9WXsnC/KKSw5h7kICV5dHsq+20t90xfsEBV2KWMKOC393Ej2BHEr1Y8iZo
	aE1HZ9dxza8LLs6BLkvDrlVw4n+05Svx6xmtFjAwMmXuLvvXVM+shHkDbDNfg9SYlEvjN+6g8214v
	0G9C8citzvnWkoccMvTqTj30DMUJQH7mQdAyCuB43iBIlAubwAcxVA4IVFi1n59vH3O0lOTeBG1Cf
	VU+WwV06mdzg2FkhE9NZxpCGNejApHTUPOaRbxSPlkP8Pi06hUDFhidOVlKFE+mALDKw8KflzgkEb
	7uHX0cgVywwPKzot/LVau4xUG0rwyn9e2NeODF//xYog==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 5A7CH3qS2946177; Fri, 7 Nov 2025 21:17:04 +0900
X-Iguazu-Qid: 2rWgRWki8gNBVHiJuL
X-Iguazu-QSIG: v=2; s=0; t=1762517823; q=2rWgRWki8gNBVHiJuL; m=9o33uc+IGIchftXKYK2KnSS9gMf88p3ZLqIa2Jgp0Xo=
Received: from imx12-a.toshiba.co.jp (unknown [38.106.60.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	 id 4d2yjW0zDTz4vyh; Fri,  7 Nov 2025 21:17:03 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GHDuHs6VYpikhpf74ryz9szFGvgx2D3BcXb5IiCiqSo6DbmnPgJUAUY+CEVQpj0hM5vICDEQGVRMbKlf1n8m3XI1+I1M94B6wnSAwPCzWtCq2SaJiy9pP15jWjdZIMjv52jy20B3o/WpFDysVhEwjlT8roKTIMtBZwdjcx+dTaletPEWv/FTfgn3P9MPWMdOnFZA4K2hZ4R8HrNiuIiZePPVCqwf6G6C4sbsHREn6jzq9oatWHx6MQCMi8LcJZQqgdCLYPdEodRp5Tj5VGwUMSKw8ZKvLd4/MgyNRh+UJuNSJt9jCkqDfm5lHXZE5PfcrM/hq/CwaB6DsGDe9Xr71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pt+y9WVjso4IYokwfWg30oBTtxEEptZj5373vD87g88=;
 b=ru/ZXh9MZi4HA9wvz4JKS09dDPbXumYP3pv5At7CXZwc5mnIx4tsxYZAYomV9lw2fwrVYMH8zm4Jjs8/Ny8eUYQfw5edF+PB29QXa7XdhFUWerpLR40suMxX7k63s4Mb2sOHloqscCDwBIQiu5laELZWbpr6NdOLz/dDKOSFrbQL7lGlyebtEL30M7h6eFIAm9kShEeHbmS2jzzOQUYxr6KZqKhCKu65IqwmvFqvb5OOPY/dooV9Lje+XP+VvcsDDAFHF+04bi2MRJCtvC0d+JEE4ot+WcIsZg+TMXpq5HPTJmrePn34TkgptWApWSl6K6E6YMwbrsaskY+gTxpGcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mail.toshiba; dmarc=pass action=none header.from=mail.toshiba;
 dkim=pass header.d=mail.toshiba; arc=none
From: <nobuhiro.iwamatsu.x90@mail.toshiba>
To: <ovidiu.panait.rb@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
Subject: RE: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
Thread-Topic: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
Thread-Index: AQHcTwnJyomUo2iWn0qx8q/A5CZL5LTnIlPQ
Date: Fri, 7 Nov 2025 12:17:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TY7PR01MB14818E6DD3F60EA38F0D79E44CDC3A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
References: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
In-Reply-To: <20251106104024.28947-1-ovidiu.panait.rb@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mail.toshiba;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY7PR01MB14818:EE_|TYWPR01MB7331:EE_
x-ms-office365-filtering-correlation-id: a76395a8-b729-4328-1ac1-08de1df78dae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700021;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?bEdPWEU2TkJYMFdieVVXb09sdVlYUEVpQjlteVlpRDI4MTNoV3FkSUhO?=
 =?iso-2022-jp?B?ME5zUHFtaW8wbG9ScC9SMlJoWE5KV01DbWV1UXR6RDVZRXlranRzQi8y?=
 =?iso-2022-jp?B?TzBDYWQrN09ZTzVJRXlrck03azNQZnFCenY3TW43eGZPMVlsTjZONCtr?=
 =?iso-2022-jp?B?MkFLU3lHNEJoVHZsYVNOdExoek5ZbDFNOTdjdFdyQW9haU9CTnh5UkZP?=
 =?iso-2022-jp?B?NUhVK3VWZStDV2RnLzRvTkIxNVlxMUxmWWl6NHZMNHNzUE8xLytDblZX?=
 =?iso-2022-jp?B?VmEzNkZDL0k1Vy9BNXVHWGN3Yis4eTU4TnR3QzZBR0loYTZQYkN3U3dj?=
 =?iso-2022-jp?B?ZzE5YWFlVDBjUGV5aDVPUXJzWXFIdGtHTTVQYTJSd2l4UENqV1NYY2l6?=
 =?iso-2022-jp?B?cnc5VjFkRXpMUVZPc2tlNG1DVm5SK0lYSzU4ZC9NKzh6OU5qZEZ6MUNO?=
 =?iso-2022-jp?B?NG5TV1VkbCtrbk1pQU9zT3hzaUlXekdad3NyS3lLaUV1RWxITi9OQXVi?=
 =?iso-2022-jp?B?TkNodHZpRGl0c3VxQTFTZVo3VU1zcEN0aGxyYXErN2NnT2l5cy9FTVRz?=
 =?iso-2022-jp?B?dFZOc0Joa1hSM09UQXhzUGxTdHQ5aXFBWnRUMEtVMnZTbzZjYUxJaStN?=
 =?iso-2022-jp?B?WVF2cDJSQTREdm1GamlNcTdoL2lkSGFBbTQ4K0tiNFVtM2hJcmZEQnpS?=
 =?iso-2022-jp?B?UDBTYVFIOEc3ZGtqblhaQjhIbkhTUHY5eUZTSTdZRnlncWx5UHRqejFx?=
 =?iso-2022-jp?B?QU1EeUJibmI2MHdROUY3NUhnS3A0NERlYTNtbmxVbnQxd21BUmwwMnVG?=
 =?iso-2022-jp?B?ZnhnOWtEUU1zZDdrdytLTi9KbHEzR3EwdEdPUC8waXBjR3dqNndlRFBV?=
 =?iso-2022-jp?B?M3JCelZFdkVYV3ZnTysvWDg1TjlXS200ZVM3ZEJtS25uV0E5aER4UFlM?=
 =?iso-2022-jp?B?M0pwU0dPb0RqNFY5eVFsbithOXRwaGI4WXYydzduVGtReUNNbjFYSVIr?=
 =?iso-2022-jp?B?QkR6OGRQMHZvZ1FlVVVweEE4bUVOeDVtN2hDZ3JwSnZIQlZodE8xcjNR?=
 =?iso-2022-jp?B?ZGlDZGJ4OVRCaFRJUGt6NFF6MnU3c0pMWWV5NHhPVCtjQXRwWG1nbjFU?=
 =?iso-2022-jp?B?cHY5UVAxQnErZFQ3ZWtjeENYL3NBUWFBZlNqKzExMUxVNUN2RDhpYUFw?=
 =?iso-2022-jp?B?MDNqNGdBUllnZWlIekZEVWVQZWYrUUpnS0trS0FlTlpnV3k3bEhpQTh2?=
 =?iso-2022-jp?B?ZktranFiODNTR2hCS1VIT1gveVZKYnlFNmZlckkxWTgrN3MxUERhNExY?=
 =?iso-2022-jp?B?TVJjMXZXTWdzV3FGb25hUEJmckVWbWFRYmZFMnRCU0lld2UzczdlNDUy?=
 =?iso-2022-jp?B?ZnVaWDltSkQwaVZGbWhtaEdoVFJIeWp2YUtvSVAyV3VYU3JqOEcvVEJp?=
 =?iso-2022-jp?B?bzg2V29iblluSTJQZ2RrN0tQV05DOExweGY0QllWclZhMXZNOW5Qaytl?=
 =?iso-2022-jp?B?NHRtVkZaZ2VPWVFOamJFWnU0NktMdXY0RDM4NElBelVBbzBCNGpnSnpq?=
 =?iso-2022-jp?B?bmtHaEw0KzRtM3VmVG5LUHM4VEl6Sk1xMEd6UTROMVpBdnZ3RWs1V2Q0?=
 =?iso-2022-jp?B?cHZRRkZBc2g5bWY2cFR1YnFqcCtidHhpYTlGRlNaWE4velB6QmhPSEd1?=
 =?iso-2022-jp?B?aTd6MTB6VnhzQU1yVnhWczRSSy9ubllZVWFldFY0QmoycFdvcHFSeDJr?=
 =?iso-2022-jp?B?YzNXSWltL3kycXRIa05ad0FZV0gxUi8rejEvcFl1dVVyMGNqM1FsNHFW?=
 =?iso-2022-jp?B?Unl5OEVRM3hJZXgvRFRJYWpQQ25SSVNNUVpmc3JHSEx3MHlvR1VVY0Z5?=
 =?iso-2022-jp?B?WW1VampYWGNQMzFNZDU3UGdiWjZtZHc3L0VFN1VQSkNRVzdIUHl5ZUl1?=
 =?iso-2022-jp?B?QkoxSzFYT05GdTZpWGFRamIrMG1vVmpuZmM1ZDFFZlFoZXhIdkkrQk1q?=
 =?iso-2022-jp?B?dlVvQ1d0a0hId1pNMEYwbFpmbW96WVpsVzlaSFhyaEUzbUFlOVF4U0dM?=
 =?iso-2022-jp?B?a21WMHdGd1BhOXpOMm5wcEtJL2dOOUIyZE1PSmNHTHAwQUtlSFNGVjEr?=
 =?iso-2022-jp?B?UVF1QzVtdkFubGlRQ25obW12Q2FlU2J5MHNnNEoxWFp6NmZsYVoxZ1B0?=
 =?iso-2022-jp?B?b3crTHhGUnR0QzJtemYyVGh1OXVyMFd1?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7PR01MB14818.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?M1VjRktxYnhTTzI3U3k4L29WRXhCSHJiQ2pkaGE0ZmdRZmpKdHJWYi9M?=
 =?iso-2022-jp?B?YU5vaVUzMEFwUGtxOEwrbDB5STZFazVaUGVIUEEwZ3V5ajhJd1RTaWpV?=
 =?iso-2022-jp?B?ekFZVDkzeVVENXZhQU5NUUpCWjhwVzNwaEtiUExSYjRTTllqdS9mNWIr?=
 =?iso-2022-jp?B?WnUvbjNiRmlZYnJZQk5zbEtxQi9nU1JqSGhJbEdxcWZIR1dQbkxReEVX?=
 =?iso-2022-jp?B?MTFjanNGQkw2MGpXcGJmbS9DYllNdzhJR0xTRjlBakg4Q2E4OUovM3o5?=
 =?iso-2022-jp?B?Q0hpd2NLa2EyNE9ob3d5TktkVDRFOVh6YUtpK0d3aStDazVhYnM0WUhs?=
 =?iso-2022-jp?B?OFBnZkEvUU45Mk1UWFJaNjNZaWR0Wm5LODU2QlpSZm1nTndyOHFJTGVw?=
 =?iso-2022-jp?B?ZWlDWmp6YUxqYjEvNGZKQnZkRDJRZTVKMmNUUlpyQTRTTk9sKytJMnRk?=
 =?iso-2022-jp?B?cU9vUnpjNTRoczhOU2hiejg2WUlqZTNpcm5vTVJWeDVuVVp1amZCNDRn?=
 =?iso-2022-jp?B?SGNxWFZOelBkSHA3K2xObmcyQzM4MmZwQWdYQWpJem44bWNteGZFYVRI?=
 =?iso-2022-jp?B?Q0lPclM1K1BvV1hKTHRaQ3JuVkp6NXp4akhNZUxWUnMvdGtLL0F3c0NH?=
 =?iso-2022-jp?B?Qi9vRDZpa1o4MGJJMkptOE5xVnBVUGJ6enR5Yi9iUE9GalpweEVFS2dy?=
 =?iso-2022-jp?B?Myt6R1dDcDFJV3lmaXNRNld3R1cvYjlXenUzVFpFcFgxUnNpbUVESU1i?=
 =?iso-2022-jp?B?cFNZczdueURsMWNRQS9zdVlTOVR4NXcvejVlUS9jREx2NXVGc0tVa3h3?=
 =?iso-2022-jp?B?OUJQdzduNGk2QmhmUXA5b21veS9aU0tQb2pRLzNyYk1wOWVJOGt2a2dK?=
 =?iso-2022-jp?B?T1luQ2ppU2tQNFBNRCtkSkx5SVN1SEVZSnBBclR2bUd1V2VlM2xubE15?=
 =?iso-2022-jp?B?UHFIVmxPUHNlQ3ZsSWY1K3VuMS9lcE5UY0Mxd3oxL1ZLMWw4SmYxWmVY?=
 =?iso-2022-jp?B?a3hscTkwNTQrUFB0Umd4U2NzRTVVZWhnS3pwMFp1MmNqWlZoU1g4ZU9S?=
 =?iso-2022-jp?B?YzZveGlSZk5BQU0xTDI0OHFESjZiTkl4VWNBZ0F2UGw2SDc1MnZ2ZHRh?=
 =?iso-2022-jp?B?VU45Z0N0OWdGOFZnMTloekhreVlYeTgvYzAxUFJJRWhucGZuRTlWd1Bl?=
 =?iso-2022-jp?B?TUVmcjQzVytyU0g5RTUxd3dGYjAxb0V4YlNZNkZydFBMVmtNVktuY0lv?=
 =?iso-2022-jp?B?ZHNtL0U1Q2VNdTY4RzZEalZoeXJKYTZhczVsR3gwWWR1Q1NCNElScWFT?=
 =?iso-2022-jp?B?YVB1NmhwZGJZcThtZDFJS0ZYbU1yR3FxU2cxYTBlQmozT2k0VWtiVWZR?=
 =?iso-2022-jp?B?L0xYQzRyVWFZK2FWbEI2VzV2ZktkUUJjQVhCb0d0LzYwalRENU4wTVhP?=
 =?iso-2022-jp?B?VEdDVlFuUTBBSk80djBNenBlWDJ3aU1YZVJmOWhBVi8wME8zc1VYdjBm?=
 =?iso-2022-jp?B?ZFM1ZVRuZFI3cml2bXR0TzZXODVUajdydDc0emR1TzRJZ2QwOTdnZFRs?=
 =?iso-2022-jp?B?ZGhiREZCcEh1TDFVK0xwS2xiVHMzekczdkZJQ01pQ3dzUm42R3B5NVhJ?=
 =?iso-2022-jp?B?NTFMMnovTFdFeXBwYWlieG05OXdZeUg0aWVkUndoQUtPOCtXV2VkVmpC?=
 =?iso-2022-jp?B?UTRlN1NIUGJWdDJOb2JrVWlXR0g0OEFBRkdzS2c1ZVlCWklEVDE1Ykd2?=
 =?iso-2022-jp?B?Zjhpcmh3OVJObERIOEh1ZlNLVjNaUDBlYUx3OHlJVm9vVjhURFFqZ3ND?=
 =?iso-2022-jp?B?TkJVYmdJSjdRTjhjV0VqeHJ0REZOYURIS3BKcHVTUVZSdnFWT21JK0k4?=
 =?iso-2022-jp?B?QXJ0dDY4QW9EZE00VHdGaEpOMWVNc2Nmckdnbm1JODROQ05jRWtPekkr?=
 =?iso-2022-jp?B?SEdJZWt5QjZXaXU4V3pMRWh5S0pHUTlEOWZFR3lzalJvUFZnNDg1WVNE?=
 =?iso-2022-jp?B?Qld1b1RoaTVQbFRoMmdXbHE0cXphYVduNElOYm1PV0I0VU1qQXNtK1JG?=
 =?iso-2022-jp?B?bGxtTFFkWnhKR2Y5clBhbDlZNzF3ckFZZ3dSTnFkUjR3MzRmbjZ0N1FY?=
 =?iso-2022-jp?B?MXRwSTdqY21taGF0bDhDVUdVNGExUklNaDZmVXVvNEdQeEduQ0RKNlA4?=
 =?iso-2022-jp?B?QnJDejJKY3NrMENYd0kvUWpETGJZZ0U0QTRNYkUrd2s3S3RwT3FmZ1Z3?=
 =?iso-2022-jp?B?VS9jcFVaTnI3d3Z4QkxSZmM3cUdvUHBpSjMrL3dMZUlJRnN0enRQcGJq?=
 =?iso-2022-jp?B?a2xURVhKUHZMcW1WTEdmQW42OWxlKzBad3c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mail.toshiba
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY7PR01MB14818.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a76395a8-b729-4328-1ac1-08de1df78dae
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2025 12:17:00.4244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n2sHz5irz++DDjS/KB3sSO8cImHcrWrUnMdDWD7wOrmFVQr909QfITBc75xxqw4bGaILitxLegNUmmjllIHDhn9XOB4nAOH726xOUXJ4fW47Bs3ouLvDEfoFKSmdNrQF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7331
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 07 Nov 2025 12:17:30 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20470

Hi all,

> -----Original Message-----
> From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
> Sent: Thursday, November 6, 2025 7:40 PM
> To: cip-dev@lists.cip-project.org; pavel@denx.de; iwamatsu nobuhiro(=1B$B=
4d>>=1B(B =1B$B?.=1B(B
> =1B$BMN=1B(B =1B$B""#D#I#T#C!{#C#P#T=1B(B) <nobuhiro.iwamatsu.x90@mail.to=
shiba>
> Subject: [PATCH 6.12.y-cip 0/9] Add RZ/V2H GBETH support
>=20
> Hi,
>=20
> This patch series adds GBETH support for the Renesas RZ/V2H SoC, to the
> linux-6.12.y-cip kernel.
>=20
> Patches were cherry-picked from mainline kernel.
>=20
> Note: this series depends on the following RZ/G3E series:
> https://lore.kernel.org/cip-dev/20251103113817.36331-1-john.madieu.xa@bp
> .renesas.com/T/#t
>=20
> Best regards,
> Ovidiu
>=20
> Biju Das (1):
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Replace RZG2L macros
>=20
> Lad Prabhakar (8):
>   dt-bindings: clock: renesas,r9a09g057-cpg: Add USB2 PHY and GBETH PTP
>     core clocks
>   clk: renesas: r9a09g057: Add clock and reset entries for USB2
>   clk: renesas: r9a09g057: Add clock and reset entries for GBETH0/1
>   dt-bindings: net: Define interrupt constraints for DWMAC vendor
>     bindings
>   dt-bindings: net: dwmac: Increase 'maxItems' for 'interrupts' and
>     'interrupt-names'
>   arm64: dts: renesas: r9a09g057: Add GBETH nodes
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Enable GBETH
>   arm64: dts: renesas: r9a09g057h44-rzv2h-evk: Fix pinctrl node name for
>     GBETH1
>=20
>  .../bindings/net/amlogic,meson-dwmac.yaml     |   6 +
>  .../bindings/net/intel,dwmac-plat.yaml        |   6 +
>  .../bindings/net/mediatek-dwmac.yaml          |   6 +
>  .../bindings/net/nxp,dwmac-imx.yaml           |   8 +
>  .../bindings/net/rockchip-dwmac.yaml          |  10 +
>  .../devicetree/bindings/net/snps,dwmac.yaml   |  24 +-
>  .../devicetree/bindings/net/stm32-dwmac.yaml  |  10 +
>  .../bindings/net/toshiba,visconti-dwmac.yaml  |   6 +
>  arch/arm64/boot/dts/renesas/r9a09g057.dtsi    | 209
> ++++++++++++++++++
>  .../dts/renesas/r9a09g057h44-rzv2h-evk.dts    | 102 +++++++--
>  drivers/clk/renesas/r9a09g057-cpg.c           |  84 ++++++-
>  .../dt-bindings/clock/renesas,r9a09g057-cpg.h |   4 +
>  12 files changed, 447 insertions(+), 28 deletions(-)
>=20

I reviewed this series, looks good to me.
I can apply this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>

Best regards,
  Nobuhiro


