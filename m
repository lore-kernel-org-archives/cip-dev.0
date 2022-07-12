X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web09.6773.1657614006586574801
 for <cip-dev@lists.cip-project.org>;
 Tue, 12 Jul 2022 01:20:07 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.154, mailfrom: shreyas.karmahe@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 26C8K36I003423; Tue, 12 Jul 2022 17:20:04 +0900
X-Iguazu-Qid: 34tIX98uy1B2WUTXZL
X-Iguazu-QSIG: v=2; s=0; t=1657614003; q=34tIX98uy1B2WUTXZL; m=Ib3y/BTb3jJM2RDMndGiEdjHJPdqd7KUBbRdfS1bOZs=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1510) id 26C8K2la019581
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Jul 2022 17:20:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Km2Nh/WdN3TK4jlyvXcH67JiZydh3BGmTGQp0ALfKsU+Lai6K1DB0HVfy5B/wKvN9lVFJXFlEBBoTJrkYc2YoJQGg5alfMDFYYS6plhnPgeSJKQUb51By1xvXjqpwLlr9eFfZNg91ALZ1uNlmtV7J0aVU8KAA5qjC2zuGgsWmwXNhLmuvm0eu+NPcn1gqqemRVoV1SN5azPRslCI5ffamhyDBX4iu/HXFDuSzHgwv1BmFLCg6xOX1nEczZwsf2/sEmXslUnc2lXU8/+jrP8B1wliZX8VtL2qN1ViqWDTb3gFuZvM/Hsv5ZIjfTl6uFLoSn/BwEkGCcimJUAm+5dxBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ja8QRUlWDT6rKFLLML8tnlAAHwgXObL0gkUIn7ZSN74=;
 b=eXXXHWxfWca7DQqRsEFw63hCO8eaOycT9X3Ki/1zS2Ut2ktZ5RoE9l++8SlKzp5bq2jQ5QzpuEimg2Eyn8iTswat0eevNKJ3OU+RR5Qw6cTFB/vjPfF8vfu8GeM2bWv77RTV/9a5yyziXoVnT6T9SSbkfEhZSO6vU/8AzNBed5DtBKkJHEizHd0v52USst41WO/pBFGwv5CAhPLRtWVp5smgub7vQEOjRi6w2aD9iC3u2X6wy9uWwQvWtPHQq6oAIHq8i1Uekz7mc3xyjFpkX5Xf7v87B2hgUsm3lifS6+z27kkrWd2H4JFefUT9OO6qSLzmlfV5WEvyXwUDCBoBDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Shreyas.Karmahe@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <Venkata.Pyla@toshiba-tsip.com>,
        <kazuhiro3.hayashi@toshiba.co.jp>
Subject: Re: [isar-cip-core v3] recipes-core/images/cip-core-image-security.bb:Add libpam-google-authenticator Package
Thread-Topic: [isar-cip-core v3]
 recipes-core/images/cip-core-image-security.bb:Add
 libpam-google-authenticator Package
Thread-Index: AQHYlREO+lwpT7Lryki4QS0uVeuQUK15AGeAgAFi3TA=
Date: Tue, 12 Jul 2022 08:19:59 +0000
X-TSB-HOP2: ON
Message-ID: <OSZPR01MB8877233D21690844A101A660DC869@OSZPR01MB8877.jpnprd01.prod.outlook.com>
References: <20220711102903.4088463-1-Shreyas.Karmahe@toshiba-tsip.com>
 <cd7d2ff6-d79f-01b1-e970-1b289587468e@siemens.com>
In-Reply-To: <cd7d2ff6-d79f-01b1-e970-1b289587468e@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f121019-c8ee-4d4e-2a13-08da63df4fcc
x-ms-traffictypediagnostic: OSBPR01MB3637:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dhdGnBDOf/mhzMvv1z4DjFPADhnF46aSsHEIPrJ8q9w0ZMHxKOCOrsjxG8GXQJqDnwSpzv8L3KLiFS1EoxpRRyLZ1E9ocCV8l3STX35SfxMWJ8v860gvzi9JqW06bVd0kGj56wqylqjR4zbpzoowNGUHMGCRYnhwo266TxWwRm3NSyIsENUU/XdctPz3LHDU68a11MG4JFB+eAQGXnVoZ4yTMu3rq8tvKIpEvoctd2tJ5MVkpm3srdvCrSDzkQmeIIxrp9uBA4XmIZeu/d2DYufDYUAmQfxveq7vvguf/H/CWtlOg/Z3rFV+5j3taoCLqpE6BlGC+DQER752gTey/047yZ/mlTsToET8vfDmKzfh6dDrVIsjLddCKzj+Vjcgy0QVeXleMupq6BFJFAaCcN46SeVdynNHZOQw9nhXKfdCSKjZbqIoTEky9YPBLEkWJE68fIjinyQdD3YIoKVrKqDIA/pl8tukLjF/rTaEOPd+/j6DN6BVq2o+gaBRSsEq9Qh3+zbJ8A3yaMg4QvV+NM+h8fqBDoEP6x1GwLPrQWBeINYQfWS2I0T6CqgVu+kIqLV1uWmfT2B68oj+6DxiJHAbQwhEKMDFecte+Wibb7XU+OxYB57b2iA31tw8Tiqg7d4twaW4N1dyCPof7OX9x4AJC5QCXaSfbU6xHQTjC96gRJouyOzY88pVdo/5wYCyGU8v4aRLhcPYleZf1/21C5JLkfmxz+8WTBYB5CeTNadylgJfXURb3qNXqt57oZYWndBIlPmhsXi70UoMAJFNO+GHMEtlzQIPgZ66OOlJro5XiLXZPrULCHw4KukEWTYp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8877.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(15650500001)(478600001)(38100700002)(55016003)(33656002)(110136005)(41300700001)(122000001)(52536014)(8936002)(2906002)(107886003)(66556008)(66476007)(8676002)(186003)(66446008)(7696005)(4326008)(53546011)(54906003)(64756008)(316002)(76116006)(66946007)(86362001)(71200400001)(26005)(9686003)(83380400001)(6506007)(38070700005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c2xhR2tELy85RExIMEJoMDFBK0x4R3gxZzEzYnl3YnZvb2s4M3JBZFlaV0c2?=
 =?utf-8?B?QVBaZEZtWTRaVTUvellzdXNxcGd5VVZ6dHJXVUdXVGVmK3hSZ2tCR3ltNTVv?=
 =?utf-8?B?QURSdm00MEFYWXBiYTAyTUppODI0enBUbXhMbE1saDRPVlE4L3JHeFhnSWww?=
 =?utf-8?B?cU5lb09GaWNlRFJOY2dBV0hobDNyZXdZZGdjNnI0dVR2UGl1cHFBNm00amtL?=
 =?utf-8?B?MURUdnowNy9lVmdXS2JLNGhFVWkvQk5xL3Y3WGtXQ0NFdlU1UHJQaHBYNFE5?=
 =?utf-8?B?cC9ycDlZcHFBY3E0bXpMU1U0cE5uOG5ZeDRYcm5WVjJpeGx1RHlnTGpWTnZh?=
 =?utf-8?B?U3JjZzlMbFowOWlsWU5UMGFwMDUxQm1RM0pmVHRiKzdRYUJXRUVsN2ZZNlJB?=
 =?utf-8?B?MXJWUVdnaXFoclNwYllCOVEyZjlOMjdvUXJJd2tiRVUvbnNtenNOMURrb2dO?=
 =?utf-8?B?ZTR5YXo3OGNBR2VEOFB3dXl1L1JqU2dNNUg3UWRTOHZBSU4zeUhNLzU1N0Fj?=
 =?utf-8?B?VnphRGIxTVhIWTFOQlE4QnA0TGtNZDVXUWZkdWdMTEJGK2VGUWhXaDNYbno0?=
 =?utf-8?B?RC9mU0lTelpSSGVTeFZJVEx6ejE4ZkgzTTMzZCs3MUUzcDdWRXVpKzF6SXgx?=
 =?utf-8?B?Rk5qaG1zQ3N1VUNtMGJVNlV0TXByOTFTL09oVndPZFhGdTdSRHRJS3FKNjFH?=
 =?utf-8?B?RHRxQUJzQW54NW9ZTW1vY0hRVjBRVlVQaGovUVMrZ3lRc245N3dsTVE2aHp5?=
 =?utf-8?B?a2NiZGpKZVU0SmQyVGdYRmxIcnRJSnh1b0xhYUtBOUlhZEREczNEemllYThR?=
 =?utf-8?B?TnVSdGV2Wm00enR5QmJqREtwaHFpcHRpUURGM1pjbUQxdjEyQlhIK1crbk1p?=
 =?utf-8?B?ZmNpSE1SdVMyR3BqSFRvQkI3SWgvWnk3Z2YvVGNCNzlhOVV4akU4VFlpOUM4?=
 =?utf-8?B?Q0prWWdWbno0OXlFcFRPTExGZy9MUHdneFIrbkZZcnhPN29nclVITE9zRlFz?=
 =?utf-8?B?eVlYaDIwa01yQWNuNDhCWWJVRng5S1VydHd4WmdNUmFXT1Z4NTJiQUh5Vkg1?=
 =?utf-8?B?Uk5vb3pqekZqMEZ6Qy9kRjZkZzArZ3pYVTVPc1UvQW9Dd0ROMWNScmU2bmg4?=
 =?utf-8?B?ZDl1ZnZuNzcrelJnSkJ4NGxCSFZ6Z3EzUEp6QUx4QTRWUm01U2E4VDBBNHpo?=
 =?utf-8?B?Q0RMRXhsRGtHVFdlZEsvQXVGSHNxNGNrc3FQMEpGeFk0MVE0d0dTRW14WGRh?=
 =?utf-8?B?OGRlOHZLK1Z1Rm5UWjFPS3pnMXNLMFVEaG5PZHoyVXIyL3VVeXV4YU1hRmh0?=
 =?utf-8?B?ckticTZRTWdOSEg0ZE9UcFpJY2s2SGFzWFZrdjNhNE9TU25kYW92ZDBwWXJt?=
 =?utf-8?B?ZjlIR3RuYklYYTNPSWJiRDhXcUVHdE1rZGQ2RHRVMmlGVzk4aERJdkN3WE5J?=
 =?utf-8?B?azhJTzdZbmdxb2Y2ZmQ5RWxuazVtWkE1ckNNamFFTTZUekRxNE90bzh1b3Y3?=
 =?utf-8?B?OHRlSFBKTlkvb0tra0I4NUJ4MXI2VHhwQ0w5SU9KMER1M3J5QVdsZG1UanN4?=
 =?utf-8?B?Z2lGaUdGb1RLNnNva1FUQUdzalJUVTAxQ0Erc28rOWFCYkpIUHZxVW1lTHZH?=
 =?utf-8?B?aTBtNFFweEJ0QVRjRGdNTm9Vd1BUY3dJcGVhcGtWcVFXc3BOWHZ6NGRMeDdl?=
 =?utf-8?B?Q1hHOHdxZ3I5U3BJVXh3RW1jSG9IWDlvUTV1TjlPS2pIazJuREJ2MzRXYjF0?=
 =?utf-8?B?aUtUTDltcUR3K004YjFTMXNoZ2FEMG56clpKOXI1YUUrbzFYQkoyRkxhZ21V?=
 =?utf-8?B?N0xCYTBvWktQU1Q2YmsveURGNk5RRUVZZ2xaSyswWkFLYW8vQkRJd3VqRlFl?=
 =?utf-8?B?aERpMEpmTXg4V2RZcDIrLys3T0ZxaDk0K0VnVkhya3hjMXpLdFdYOEp4a240?=
 =?utf-8?B?ZCt4bWRXNlhIRVRkN21udHlLUnZhckFkUm85WWt6WGpuYkRHRlhMNHVPL2NM?=
 =?utf-8?B?T0hNdjQ2S0NsMC9EQU85TUxVRmN4bGZScDFzRW9CbnJaWFJnZmlLUjlQWCs3?=
 =?utf-8?B?UldJLzVsWVZXV3liZUl2M3l3bkJDbU9KVEpXRTlMNE9SekJremFGUmNia21N?=
 =?utf-8?B?eFp4YTFzUUc3OXBoMWtJc05ka05ISlhEM21nTUpPblVBVmNNZG91aUVhd2Ri?=
 =?utf-8?B?ZEE9PQ==?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8877.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f121019-c8ee-4d4e-2a13-08da63df4fcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2022 08:19:59.3671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: In71IE+nnmz7Uv/f4uH6Mdr2SXkrYBduXtf1HYa/1DCqtE/7xYy1W3fa/16CROs47zHYhnrCJSA1CYNVdseBgSLcUomNTpGng6xsEZrttLj5smA0Xs8FV3vp58gefz/E
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSBPR01MB3637
X-OriginatorOrg: toshiba-tsip.com
MSSCP.TransferMailToMossAgent: 103
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
List-Id: <cip-dev.lists.cip-project.org>

SGkgSmFuLVNhbiwNCg0KSXMgdGhlcmUgYW55IG5ldyBwYXRjaCByZXF1aXJlZCB0byBhZGQgbGli
cGFtLWdvb2dsZS1hdXRoZW50aWNhdG9yIFBhY2thZ2UgaW4gY2lwLWNvcmUtaW1hZ2Utc2VjdXJp
dHkuYmIgZmlsZSB3aXRoIHYzIHZlcnNpb24gDQpPciBpcyB0aGVyZSBhbnl0aGluZyBlbHNlIG5l
ZWQgdG8gYmUgYWRkcmVzc2VkIGFsb25nIHdpdGggcGFja2FnZSA/DQpLaW5kbHkgY2xhcmlmeSBt
eSBxdWVyaWVzDQoNCktpbmQgUmVnYXJkcywNClNocmV5YXMNCg0KLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCkZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+IA0KU2Vu
dDogTW9uZGF5LCBKdWx5IDExLCAyMDIyIDQ6MjkgUE0NClRvOiBrYXJtYWhlIHNocmV5YXMo77y0
77yz77yp77ywIFRNSUVDIE9ERyBQb3J0aW5nKSA8U2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNp
cC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9yZw0KQ2M6IGRpbmVzaCBrdW1hcijv
vLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5lc2gua3VtYXJAdG9zaGliYS10c2lw
LmNvbT47IHB5bGEgdmVua2F0YSjvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxWZW5r
YXRhLlB5bGFAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDi
lqHvvLPvvLfvvKPil6/vvKHvvKPvvLQpIDxrYXp1aGlybzMuaGF5YXNoaUB0b3NoaWJhLmNvLmpw
Pg0KU3ViamVjdDogUmU6IFtpc2FyLWNpcC1jb3JlIHYzXSByZWNpcGVzLWNvcmUvaW1hZ2VzL2Np
cC1jb3JlLWltYWdlLXNlY3VyaXR5LmJiOkFkZCBsaWJwYW0tZ29vZ2xlLWF1dGhlbnRpY2F0b3Ig
UGFja2FnZQ0KDQpPbiAxMS4wNy4yMiAxMjoyOSwgU2hyZXlhcy5LYXJtYWhlQHRvc2hpYmEtdHNp
cC5jb20gd3JvdGU6DQo+IEZyb206IFNocmV5YXMgS2FybWFoZSA8U2hyZXlhcy5LYXJtYWhlQHRv
c2hpYmEtdHNpcC5jb20+DQo+IA0KPiBBZGQgbGlicGFtLWdvb2dsZS1hdXRoZW50aWNhdG9yIHRv
IGVuYWJsZSBNdWx0aS1mYWN0b3IgYXV0aGVudGljYXRpb24uDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBTaHJleWFzIEthcm1haGUgPFNocmV5YXMuS2FybWFoZUB0b3NoaWJhLXRzaXAuY29tPg0KPiAt
LS0NCj4gIHJlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgfCAx
ICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUtaW1hZ2Utc2VjdXJpdHkuYmIgDQo+IGIvcmVj
aXBlcy1jb3JlL2ltYWdlcy9jaXAtY29yZS1pbWFnZS1zZWN1cml0eS5iYg0KPiBpbmRleCA2MDYw
OTc4Li4yNGIxZjQ2IDEwMDY0NA0KPiAtLS0gYS9yZWNpcGVzLWNvcmUvaW1hZ2VzL2NpcC1jb3Jl
LWltYWdlLXNlY3VyaXR5LmJiDQo+ICsrKyBiL3JlY2lwZXMtY29yZS9pbWFnZXMvY2lwLWNvcmUt
aW1hZ2Utc2VjdXJpdHkuYmINCj4gQEAgLTMzLDYgKzMzLDcgQEAgSU1BR0VfUFJFSU5TVEFMTCAr
PSAiIFwNCj4gIAl1dWlkLXJ1bnRpbWUgXA0KPiAgCXN1ZG8gXA0KPiAgCWFpZGUtY29tbW9uIFwN
Cj4gKwlsaWJwYW0tZ29vZ2xlLWF1dGhlbnRpY2F0b3IgXA0KPiAgIg0KPiAgDQo+ICBPVkVSUklE
RVNfYXBwZW5kID0gIjoke0JBU0VfRElTVFJPX0NPREVOQU1FfSINCg0KV2l0aCB2MyBvZiAicmVj
aXBlcy1jb3JlL3NlY3VyaXR5LWN1c3RvbWl6YXRpb25zL2ZpbGVzL3Bvc3RpbnN0OkFkZA0KY29u
ZmlndXJhdGlvbiBmb3IgTUZBIiAobm9uLW9wdGltYWwgbmFtaW5nIEJUVywgd2lsbCBhZGp1c3Qp
LCB0aGlzIHBhdGNoIGlzIG5vdyBvYnNvbGV0ZS4NCg0KSmFuDQoNCi0tDQpTaWVtZW5zIEFHLCBU
ZWNobm9sb2d5DQpDb21wZXRlbmNlIENlbnRlciBFbWJlZGRlZCBMaW51eA0K


