Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90D4E7717F
	for <webhook@archiver.kernel.org>; Tue, 10 Dec 2024 11:58:48 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.8763.1733831920494129704
 for <cip-dev@lists.cip-project.org>;
 Tue, 10 Dec 2024 03:58:40 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=VN8gvIgv;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1733831914;x=1735041514;bh=a0qTo3vmSGGqp0gUKpmDz0tqjU6T1GRtR4oD3g8
	9KHA=;b=VN8gvIgvQjb/0Msa1rMHFFRQqvIukFtfgMvY6nft+jUMgXvaMLyFSCgeqaESOzDNzLKIm
	zkz+Os7fGeORPCXqeCDY69ia6tC4n5WxhtGmSY+wimZnDacyvMa8nlop+QLHRVJ19hDVI1MR9izyu
	deUoGhptX9InMl5WACgVkMvpCzj9hA0Mtt1A5JeSrpKy9noWVCRvDMJwSNscsy1FnC+iFiIKUrQht
	Nt/HkqrbDtjwWniy0JCkxQv3B2Go60VuLTrzJW50R/2xtJW/C+t4qMTkBGYs2SNZ2wmHGlC9ygJ5G
	gU4Ef3bHxWyuvyhTMmv/8OY7/6DBtrMoCEFzJ1NE0A==;
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4BABwX9j1081540; Tue, 10 Dec 2024 20:58:33 +0900
X-Iguazu-Qid: 2rWhEqwph6niPmN1ge
X-Iguazu-QSIG: v=2; s=0; t=1733831913; q=2rWhEqwph6niPmN1ge; m=uVPNHTF5u/Nn56Lx2kUiVqUYlg3F3O4ib3kT+XDoajA=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 4BABwW3s2031065
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 10 Dec 2024 20:58:32 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OskEz5zEWmQ8XUjskGOlkriMJcfrrdDI6qbOen3z1PVhpgEKEi8yrOKLwxtMPEqjciFuEUVwJFXo7fTds5mzOB83gmV4Pe0QhhAxdsdpFMeyObRKaEiZmeIPX27ww7Wp2KABx7xOZtg0v4S1jAe6VJG2q7RB36DIzRUARxgOi/lHxZQHruDi5qFG4OnfDEBz2Pdy0OfHG5f5Th3r4X4MokvGiA36McZlNT5ndEKSXBPs/bFFibznhYmzfXBpuIsLt7lmS6NBFeYy00/CIi4HEnRwqQ7Wl2K0KstN1sVXv0PjsQqq2RI6ZirIgGmfJa2TpwLIqCU9qtwljJ6sk9opIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFN17X1b26YL/q8uLV2I+v7H2FA7lATXL3pgazvE8Hc=;
 b=Kw8dyArwBLOp7iBRFNb3WzJlsxZWIP/4QVR0UPGi6UBqYIwEzuf4M23okuBp3+ovx6QcX0qJN6o3HN8w4sO1IChiB8qllq4CQxsO9rWuqgEX2sXTPPhIEfZfVgg8Sw53P+WRi8KHi2vECoJsIutOrSF5gGa8oPGq95qFi7Omm5PR2MnjTn6AtghpTZkBCp77uoAK35a+L4+q8HCwT16EJ7m6o35a6/9hlxELAcv/QhaJgjzqn8A8M5oXbjCBWwCosMwQUZ4xTCmYHs8caOBRNeIx30eolYO2kwacmpt8yhvYrqVE/wBRqXkkhciDEBq7EPaX7W4KTNEfpVebQMaPVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Thread-Topic: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
Thread-Index: AQHbR74HYoIJ6LXlFkaK1HJNJ376NrLdc08AgAHyuKA=
Date: Tue, 10 Dec 2024 11:58:30 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63887E17408ADB0B286F2A96923D2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20241206090524.66639-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB6388A745B37F08A131FD6DD5923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388A745B37F08A131FD6DD5923C2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB8575:EE_
x-ms-office365-filtering-correlation-id: 20779289-8ec4-4efe-700f-08dd1911f6c5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?SHBrVFBqN3hqZXZtbjV6d2JsTU00S2pFTXB2MkZpMmR6R20rQXgvNlRU?=
 =?iso-2022-jp?B?VmFTT1RLak1SaFQ4cUdBZlBlditGZ1lpK0xuc3Q4VG10Z04wTzl0L2Fh?=
 =?iso-2022-jp?B?UUFaZzY1MitNQ1haYi85TW03QWdpanBwdzBPUnp0ZjFpb1JMajdRN0po?=
 =?iso-2022-jp?B?WGJ0d2ZINFhhM2poZEthcldSYnlrVm11WFFSY3RqVUEwQlExTWZmQlVZ?=
 =?iso-2022-jp?B?SFhEeXVlVFlvUTNlVU15RUFnNjQ3cnZWeHVlOUxzSjRRakxGcmhscEow?=
 =?iso-2022-jp?B?SWlvQVRqMFdRSDJPWVlwVTVyd1JpdmdqQTY3T1k1RFByZjJpRVpXQjYw?=
 =?iso-2022-jp?B?RkpXaXZlN2lBT2VFU0V3WTgrRUVKejJzcXZxQlcxT0szKy9PcERydktF?=
 =?iso-2022-jp?B?N1BkYjNMSVV3dzc3MTlYTUx2Z3dTN1VOTTByOXg1V1Exanpld1FHUndr?=
 =?iso-2022-jp?B?cVNNaHpYa25LOVoyVUUvWkZDZE9hZ0YwYUFxNDdXRFRmWUIxMnNTNmtl?=
 =?iso-2022-jp?B?MEVKSk56VXlVVmFZamt1TlZCOFoydS9hODdqWktEdzZpTGpPZ3pxZGVt?=
 =?iso-2022-jp?B?enNKS0ZNL1NXK2JWdExtSWNscVFkYjJTZTQyOFVSVkdIeDF6eTdzL0Vm?=
 =?iso-2022-jp?B?eWIrTS9iM1BFblVnSkwzbmFFWkRBNEJRNXhUOWRDS2ZKTHByeVBXelVF?=
 =?iso-2022-jp?B?ZlY2RDhlNmtKNUE2YTBFSlI1TUZEU3Q3S2JoaXFBdXEzeEgzVmZRT20r?=
 =?iso-2022-jp?B?ZmI1RlJMaXNrMDErK0lhall1SFRNQ2UwMzB4Y2hqRVNGZWxlSXFrL3Nh?=
 =?iso-2022-jp?B?enZ6R2Q2WUl6cHRIRTBVN0tvaG8vNm1YLzA1dU1DTkhlUXNWY1VaRmhF?=
 =?iso-2022-jp?B?YzJqaEpDdSt6ODU4LyttaWR5RkQzNzNmYzV3enpBRGFNb1lVRlJULzJ6?=
 =?iso-2022-jp?B?cnc3OHZWcW5pTGdpOXJRaHpTbDRCZytBZUVMcEh0RjJrdXBtT3hNaVpB?=
 =?iso-2022-jp?B?M2F4SFZVZDVuQXFmcDYvbmlXT0dKeGdMRjBqdDE3MzJBUEhjWUIydnNa?=
 =?iso-2022-jp?B?RmxmTzVFN1gzQmYybWVCZVpTYjBMSTQ5a1VaaE1rRU9EQTZGV1ljUk5i?=
 =?iso-2022-jp?B?c3hPSUlVZkdROFNHVHdHTHllYmNBVXM0RXRSV1RsakI5ODVWY3dBdGdh?=
 =?iso-2022-jp?B?bFlsN0N4cHhNZ2x5OXptOU9HajVWa09tSU1hNlN3TnREellWZ0JJdkgx?=
 =?iso-2022-jp?B?ekRNSDJ4OTdNS09UeElZRTdBbWNtaXBXTEc3RmVWNmFTb1REbjdqSVFC?=
 =?iso-2022-jp?B?SDZRQ3c3UnJoZ2czSWhJalhHM0ppSDlDQUlWNGhKOVFuYWc0Qnkwa1JZ?=
 =?iso-2022-jp?B?cHhJdUQ3S2tTNjAzTVQ3S3R0bUg4eGxGWDZSRTZXR3o5M2tpUmtmcXZn?=
 =?iso-2022-jp?B?YiszdVhOcmFOVkFQa29yZ29XOE15cENXM0F4YW1iZnZlYUZqeTU3Mm92?=
 =?iso-2022-jp?B?eU0xbDdKanl4c01yaXVTNzdlYlFRcWRWZ21tYW9WTDhtbWRoL1ppSTVu?=
 =?iso-2022-jp?B?QmhNQjVwUXZCeVpoenEyTjVadHRKS042TnRNQnZObTRiYnVQZFpUNXpj?=
 =?iso-2022-jp?B?WmZUcXI4LzN1MUpQcGRUeCtaM1pDNC9nSWxXN3AxNEc5U09EZzZhMnZl?=
 =?iso-2022-jp?B?RVlUTWZTSVpsZlBhODA1TzJHTi80Slg1YmltVUt3MkRnMFZIL0hXZ0RO?=
 =?iso-2022-jp?B?N28zUzRnYUdqamlNTzRscm16dnJlcHp6Ly9WaFJFR3FxYXBDTGRLTFJN?=
 =?iso-2022-jp?B?VXhWdWFwcVU1TzY0bDRSdEhvREM2cWhlMkJsQzdsN01mSEFaWTFZL1g2?=
 =?iso-2022-jp?B?UC9GbVlzMG9EbkduRTErR3pIaEt0WmE3ZEFiZ2NmY1UwbmJkYnk4Sksx?=
 =?iso-2022-jp?B?Z3lpK29hT2ZLMjErY0srYngrejI2a3I0YmF2VStLM09XLzNyTzdmZDZl?=
 =?iso-2022-jp?B?bmVnRWRsaS82MmFVV2s3ZnBMU1JSTkIzNUxIUTAzT0w5d21pNS9RZTZh?=
 =?iso-2022-jp?B?RTRZWEtQbnJ0N0xFTFhTQVlWWTAyK3c9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?aGt4UzRBSEZUVWNwaUMxTyt0SjR0SkZTQ1hPaElVZGdiOWxGL2J2bG9C?=
 =?iso-2022-jp?B?VmwydGd4OUxPc2V4NmRzTEpBdUdUdUkyNUVFaGhmYWQxc013Y3BSZ0Rr?=
 =?iso-2022-jp?B?TTBwY2VBNmM1OUJ0RHpLNDlvWklmMnpTN2RrVy9ocWNQWHVENzdvdHpu?=
 =?iso-2022-jp?B?bzVpMFdYY0VIZlhueFphbHZPSFVjUElRT0gzNlF1em80QmMwY1Iwa1NW?=
 =?iso-2022-jp?B?VmdZZUY2a0s4VzVwcTJ0ZGtNVVRPLzFHc1QrWGhORmNiZnBXb3h3bTh4?=
 =?iso-2022-jp?B?eXVRTXR3aDFlRmhxVzNabTcwZ2NGQm9Vd1RRMGZTU2p1dG12ZU9OVTcz?=
 =?iso-2022-jp?B?dWwwR3oxaEtQUVpmRndLZSt6dTdHL2VSNHBidVZMTXVEeklMTVpPWTVJ?=
 =?iso-2022-jp?B?VWdxUlY5VXlNaWhrd05pc3pyYkN5dkhRbTJqc1ZkVDNERzJaZjM4QXEv?=
 =?iso-2022-jp?B?TDhFc0FCQjk5R2lIRll3QnNZOWNVUU1JUnNqTGpnMXhHbmtqb0F2WVhv?=
 =?iso-2022-jp?B?anhHM0hXd1JaMHhlY01aRkx1K05vUy8yMUJQZktTT21iTXkxQlQ4a3VV?=
 =?iso-2022-jp?B?MFJ3QU9MTnRqM3lBQzY2SHFNdjNPTkoweng1c1crbFY1b1NqWlduUHA2?=
 =?iso-2022-jp?B?cWMvbE9GdFVVSUpJWmxGcW4rbGc0ZkRFV3d6MjFnNUxsdDgzZ2luMGt2?=
 =?iso-2022-jp?B?d3NKZ3h3TEY3MWJGaDh6bHQ4YUU2ZmdjVk45VGtGWkZxUExkQkUyMVJC?=
 =?iso-2022-jp?B?bWRwWGNzdTJNd3c2TGo4OTlFeS9XTG9mUFdoMElkOXdKaDZBeW11TVY0?=
 =?iso-2022-jp?B?TGEwOWpQdXMyOEJhN3Bia2pUc3ZiZ1VuNGsrT0JmZm8wZGdiaGFNRjZM?=
 =?iso-2022-jp?B?OWFZYUMvSVYzTmlzeUtzKzFhaGZJazZlYlV1ZG5DdjJWWWtkUUZ1V3R0?=
 =?iso-2022-jp?B?djRKdDNuSWIvVStvbnBhRVRXVVVZMVVybUlaYkUrL29kNzVVTDgvNjMz?=
 =?iso-2022-jp?B?SUhIbndGWEI0RUdYWlFjeWxsaXgyb0NzSkhVenpxanYyVHcyVzlTTmJQ?=
 =?iso-2022-jp?B?RTlsNyttd3V2Q3RqTzJTWUxNalpTeitSZ0NUd2RZMkVIb3FoVTZ2OFBL?=
 =?iso-2022-jp?B?aWVGNXZ1Nzc0NHpSMDZjRElRWXg3WFZtOUhUNVM5NXhPelRJaWx3NHJi?=
 =?iso-2022-jp?B?bXp6anFHZlBTU1lZeCt2aTJzUDBJbkRZU3BZOUpFUWZTZHFrWFF2ZCt5?=
 =?iso-2022-jp?B?SnJWNENJck92TVQ3cGdQK2lqUHQzQmFyOGN6bjFjZ2FsZE5yYzJ4OEEy?=
 =?iso-2022-jp?B?WEhoMmgvVE5OcHEwbFBrUGlpT1NuSGN0cjh5QjhlZnZqSTBzdXhkbXIv?=
 =?iso-2022-jp?B?OUFpU3hTM0dRMHNibXJLYm8xdldBenBWSFVVKzU2Z3NYazUzMkduTng4?=
 =?iso-2022-jp?B?ZFE3Z05hMW9lWlZ1cENESTR4R2hHdTFjZ0xJakpvaENCclVJU1YrRkNW?=
 =?iso-2022-jp?B?TFJxNnhHY3krTkFaNXd0MzVCdXc4YStIU3JBdFlKbXFCc0ppV2JtNEI2?=
 =?iso-2022-jp?B?K0FOUzVOVnlwbkhXNDNqYktMRktvOUFpYXNqYVJRQjk1MmlieUpNZ0Y4?=
 =?iso-2022-jp?B?Q3VmZnU1dHhoVVNlY0MwVCtoRXZCNnFHbkVYM3c4TUg3RzNQdFRpVGhp?=
 =?iso-2022-jp?B?b3JIQURjSVFFQzQyaGRXL1p0U1lTYmNJNlpoWFB3eTR1L1gvbFNuMDVx?=
 =?iso-2022-jp?B?N0hONXpqSWZUa0pmUGVWREVwaTRjZGhJOFJXdml5djZUcTZCYXBnVHFq?=
 =?iso-2022-jp?B?dmdQcGtIOE5BQlVFcDRDdHFHbFBGeDl2aWg4U2FsUDFyczVrdlZjWFI5?=
 =?iso-2022-jp?B?S0N4akNaK0FuNWNDM2RnRCtBSjZqVjZ4MGRuYWw2V3IvT21rN2xMZXNY?=
 =?iso-2022-jp?B?RHJSUUg3VHE3aUZ3ckY2MUtQNk0wL1pNQy9sSTJUY2xjMWMxRVVLUEJq?=
 =?iso-2022-jp?B?NkxBOVZJbkVGNnBjWE5GUnhRSVM0YjRISmU5S3RSQmVOYlNRbkgyZkty?=
 =?iso-2022-jp?B?SE5Qb285WWlXMm4xbnpydHdoYSt1NDIvc0RtZFluZFBSRk1jUUFTalND?=
 =?iso-2022-jp?B?RWxIWUFCcm1Gam85VlVIMHI1Z1FMNlhLbCtQV1J3Wk5ScmwzcllhdjZ5?=
 =?iso-2022-jp?B?RDFmMktRUWRMRlU1RWtSYlRtd2N5S28xQWdCNWpaZXFQZVFkK1U4aFR3?=
 =?iso-2022-jp?B?Y1diL2IzTDh4TDFva2VtZGpvOFpNUWhTTTBHeTVxZXVNMm91cXVYL28z?=
 =?iso-2022-jp?B?aE1nUW1COHlWUUlZYm8vY2hmckFrRHhYdWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20779289-8ec4-4efe-700f-08dd1911f6c5
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2024 11:58:30.1393
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m51pTwU0irS7raZEQ3aV9S84FFZuZGGyBidOF7C0pTkHgVDfpc3+Rcm1WfjSBKmD/JDNU9Ce5bwCk+75hmr/OtAfwSCV2XhSi26AyAoBuX12mTtjubngaiz2dXIuqwGt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8575
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 10 Dec 2024 11:58:48 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17389

Hi,

> -----Original Message-----
> From: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D=
#I#T!{#O#S#T=1B(B)
> Sent: Monday, December 9, 2024 3:14 PM
> To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>;
> cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: RE: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
>=20
> Hi all,
>=20
> > -----Original Message-----
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Sent: Friday, December 6, 2024 6:05 PM
> > To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B=
$B?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> > =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mac=
hek
> > <pavel@denx.de>
> > Cc: Biju Das <biju.das.jz@bp.renesas.com>
> > Subject: [PATCH 5.10.y-cip 0/8] Add RPC-IF support for RZ/G2UL SoC
> >
> > Hi All,
> >
> > This patch series aims to add RPC-IF support for RZ/G2UL SoC and
> > enable it on SMARC platform, along with enabling tx width to 4 on
> > RZ/G2L SMARC platforms.
> >
> > All the patches have been cherry picked from upstream kernel apart
> > from patch 1/8.
> >
> > Cheers,
> > Prabhakar
> >
> > Biju Das (5):
> >   spi: rpc-if: Add missing MODULE_DEVICE_TABLE
> >   memory: renesas-rpc-if: Use Hi-Z state as the default setting for IOV=
F
> >     pins
> >   arm64: dts: renesas: rzg2lc-smarc-som: Enable 4-bit tx support
> >   arm64: dts: renesas: rz{g2l,g2lc}-smarc-som: Update partition table
> >     for spi-nor flash
> >   arm64: dts: renesas: rzg2ul-smarc-som: Enable serial NOR flash
> >
> > Lad Prabhakar (1):
> >   mtd: spi-nor: atmel: Add support for AT25QL128A serial NOR flash
> >
> > Miquel Raynal (1):
> >   spi: rpc-if: differentiate between unsupported and invalid requests
> >
> > Wolfram Sang (1):
> >   memory: renesas-rpc-if: Fix PHYCNT.STRTIM setting
> >
>=20
> I reviewed this series, looks good to me.
> I can apply this series if there are no other comments.
>=20
> Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
Applied, thanks.

Best regards,
  Nobuhiro


