Return-Path: <sai.sathujoda@toshiba-tsip.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF484C27C4F
	for <webhook@archiver.kernel.org>; Tue, 18 Jun 2024 04:44:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.78890.1718685876728774032
 for <cip-dev@lists.cip-project.org>;
 Mon, 17 Jun 2024 21:44:37 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba-tsip.com, ip: 210.130.202.131, mailfrom: sai.sathujoda@toshiba-tsip.com)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 45I4iZT4655483; Tue, 18 Jun 2024 13:44:35 +0900
X-Iguazu-Qid: 2rWhGbqYjXbzl2tSPy
X-Iguazu-QSIG: v=2; s=0; t=1718685874; q=2rWhGbqYjXbzl2tSPy; m=LkiNn7wMV9GgxumrS6K6EfNCUVDHY/jZpYgVyZXkUcU=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 45I4iX5H4067163
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 18 Jun 2024 13:44:34 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGgOrGEXyRPeabhtSjlHSTjWnn+0GuxoEBXkqdotW0PFJr5lEoz7pQDzUw2PXxAJCL7/KWl1a4S/0hLLeX64hejabUshsY1kZve2sPdKhB9DuIKrU1UJKW5FZ+g0gcl3HouRHckzDAMFNC3pyTWkpaIQmQyZeMBRV/AiUd9f+nndEWH56cMLhb0bbXClPV6V9Mt8PUClsrkSeqsX4++oSKh3HzeVOB8dVL1r0N4wRvpGmJscvQUBiejmwfIadXQTyVLe3Rfi4W52VM/aQtO4w5FYPsuisykoCyY4iAlLbNjl0IOabzKJpIkSgxvkbq07kEBu4dv7QXsNWoO/At1ecA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eW1+vOtK3meZkFDY/X3TW/EF6sw6QbwZolTKv/d8SNg=;
 b=AigsVABy6VVo8it6lqR+I66MBKbULQL9JMJmYdYfFciNnRWTlSnVuUulJDs6Con8B4+XY6cuYuJKw4rokA/Bs5Hyfxyj0dx77pE6MJ14ATvIJARQRqERt8o+J7Eosm/nWWnoxWuHYHRuqukc2w2/9FnVk0UeGNv6JQsSvpM1HylVWJqjc5dvzj/0fzN4ko1azIJM+JhzSW5OmQdvrjiXje2AhZ/3G9sOJi7q9vkKISH+JIl1vWq58yXkizzuzivWVGNbBYb04qpfvmnA6lCEr/ZaNrNm6okEzEdYEd2FJW5w14bO4VF2UE9DXVWnWHVepZJxaeF4ZEjBJcFXOGa+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba-tsip.com; dmarc=pass action=none
 header.from=toshiba-tsip.com; dkim=pass header.d=toshiba-tsip.com; arc=none
From: <Sai.Sathujoda@toshiba-tsip.com>
To: <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>
CC: <dinesh.kumar@toshiba-tsip.com>, <kazuhiro3.hayashi@toshiba.co.jp>
Subject: RE: [isar-cip-core v1 1/3] .gitlab-ci.yml: Break current test jobs to
 run one LAVA job per Gitlab job
Thread-Topic: [isar-cip-core v1 1/3] .gitlab-ci.yml: Break current test jobs
 to run one LAVA job per Gitlab job
Thread-Index: AQHawOM610NW73ZuB0OP6Q40BwMIqbHM8QIAgAAAr1A=
Date: Tue, 18 Jun 2024 04:44:31 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB6103E9C32A8270E82EB6C588C2CE2@OS3PR01MB6103.jpnprd01.prod.outlook.com>
References: <20240617182147.1724078-1-Sai.Sathujoda@toshiba-tsip.com>
 <20240617182147.1724078-2-Sai.Sathujoda@toshiba-tsip.com>
 <2116c973-6101-4be4-923d-6f143ee6ad7b@siemens.com>
In-Reply-To: <2116c973-6101-4be4-923d-6f143ee6ad7b@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba-tsip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6103:EE_|TYCPR01MB9520:EE_
x-ms-office365-filtering-correlation-id: 2435c89b-020c-4f4b-adb4-08dc8f515852
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RkdDTEJDT1ZNQ01QWHllZEZDbUxsZGxCbFRSd2ltdEhTSDAyT2laWkNUdGNi?=
 =?utf-8?B?d1B4bzh2aVFaSFY1WTA1UC9tYmxVQ05kME9CZEw0Qjl0ZGs3RW9sNFFaQWd3?=
 =?utf-8?B?aXU1NjV0dWoyYlFvMkVGSWVzelF0Q3FjNFhSTlhrMy96ZTdIRlpQQThGTUtM?=
 =?utf-8?B?Tlh2WWtZb3VtbDZKNjJpdEFZNzRsMHlDV1F0UDRQM0NqR3IxSEc5cXJTL1dk?=
 =?utf-8?B?RmIrdmZhYnFHRXpQc1pDTFVWQUQ2eDljOVdwcEtmVjFVU2FuNVVDVE40aTBw?=
 =?utf-8?B?U3p2c3Bzby9WZHk0d09rUUlVaVVPa2JzUi9qdWY3TkJ4ZE5NQ0lyUmNvd2Qw?=
 =?utf-8?B?MFhjVUhuQlFndkFlU1F4RHNKNm8rdnBQdC9lM2xZSGFDVkNYTlV3dGFIQXEr?=
 =?utf-8?B?QmlZMDFXUXQrTHB5NWEvaVZUb09Yb0xtbGVQcHV0MjRSMEtxUndkSFZ1RTUw?=
 =?utf-8?B?MHZMTGdzZHFtVTh1MnRiT1lvVWhNMnQyRUxza1FsZGZGZlA3WkVEQWV3SjV6?=
 =?utf-8?B?OUxHZUdZN29MYklsVFFaa3lDcjlReCtOZlMwOVlEeXJCaDZLUU00Z1Examcy?=
 =?utf-8?B?R01CN3NsUW9CMGdpL2xlL1o3cGE5SFJ0N05vckRGTHBvckR5eUFMbXpVc2hV?=
 =?utf-8?B?S1hLWDJzRlkyekQ1NVZyc1RCbVAweHhvemwrS3FIODNqQlV1dmI4blFlL0Z3?=
 =?utf-8?B?YnVZaThtTjZDWUR1K2xCL3RTSXJzRHlJVGpjdFRINGZBeEttQWhPaVI1Z3J0?=
 =?utf-8?B?TCswQSt2eGZFQmVjLzJxanc4d0RnYzNQbmM2TUJXOGFqUWtSa05iL1N4QVMz?=
 =?utf-8?B?eTZrS1FZcVJYVjl2Z0s3SEN3cVJMZ0dITFI1c3NBNGRPSWhwWXVqYzlIYThl?=
 =?utf-8?B?N3JCWjRweHVrcW9iN2N0b0xOWnNXdU5QRDZQWWx2ZUxuUngwMit1RkF0dlQ3?=
 =?utf-8?B?UVg5VE5wanlYUjBoOE5rN1NsL1hMQ1JtN3NyMjJPa0dxMGhmNk5xK29UajIy?=
 =?utf-8?B?NjZVYUV0VUNVS0JIM3J0ell5SlU3V3VYSGdPTlBOQWl4d1kxSjdoV2hZbS82?=
 =?utf-8?B?cUNFTGRuWUE2M29MR1pqMThpd2xBMVBXSHZhbjZIYk92amYrY0dJd2V3aGx3?=
 =?utf-8?B?SENGRXBuUFIrN0dRenJhRlZpL0VqNXBpeFhlaUgxa2xTd2xUczNEbFp4V3ow?=
 =?utf-8?B?REtGMUhCbkx5RC9hZkFMWnVvTnlUYm01bmxnU1h5bFdNb1ZxNWxYZXpYL2dF?=
 =?utf-8?B?V1BabE0wb0t5VUNLODFlYWJWcGxjSjN4dWovVzFDQ3BMYit6dyt3Y2NKeVl1?=
 =?utf-8?B?L3E5SnJwdEFsaDRDSllvbGJmTitmS25la0hjRlhYY1pvWGpoT2lobmFodEk0?=
 =?utf-8?B?b1FRVStKWjgrcFFyK1JQT2ExbnE4L0F5d2tpTzQvbzdqNVZUZ01oR3FHVG53?=
 =?utf-8?B?RjVVOWdvRml5emNWUit2ajV6V2NyY3BWYkhzNVFHKzU4S1hqM2ZtaTZvR1cw?=
 =?utf-8?B?ZFpqTFdoaEtYWWJ3SmQxUEkveEljZHBjNmxhZWR6ZVl3Y2tZZ0lOOHc5dk51?=
 =?utf-8?B?UmdtMXdiV01PR1hFaGE0aUdOUlkrZk9MU0pBbTJHenp6RW9tMXpoOTlLVG8z?=
 =?utf-8?B?M2xtRExhMUVOc1RCeU90K2xwbldndWgyampHbzNmSnlocjVSYjFwN0t1SFow?=
 =?utf-8?B?M25vZmJBUDRVNjEwR2s3K1JWNEN0b3VLTU5zWC9sQnVmakgyVzg4eWVVVUEw?=
 =?utf-8?B?YWp6RTVESTB4YWhwTlFCOWl3OWFRNlkvZDFzelJ6ZTg3V2FVVnpyQnRHT0sx?=
 =?utf-8?Q?M90iO/7juFbE41mY0V6U6iqVBFaAWB4D0aN7o=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6103.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UitHOEhWaGVyN3ozdmRpazIvU3I3MWIrK3lrUUhuTHN3M1Y1NVRLaUR6MFJZ?=
 =?utf-8?B?a3BSaUswOHRvMHZZWjlGYkZ0SjltczBiWmd5TE1IYnMyUXFyNmh4OHFVb0l4?=
 =?utf-8?B?bjU2VldxM1pNNEFyazFubG8wQklyOWUrSkVkTVdjQ05sWDgzUUtvRVUrRGl3?=
 =?utf-8?B?Vmc1QmxzOGNWcDRpdWNkYzcrN1dkandJUk8yTTVtdjNybGFTYVZSVmRJa3B6?=
 =?utf-8?B?LzVZa0tyZm1EMUtnNGRlRERJZGRzSU5sNXpRd0pKWU9oWk43VkZRcjJYY3lQ?=
 =?utf-8?B?VStac3FlYkZUTHovd0NEazNSZGpQZEdTQ1VRSVRtRGVTZXowWTBTNVY3aWdF?=
 =?utf-8?B?dFRHU0hJa1lULzdSdUc4VER2a1RlV09QMzNYalFkbHkybGVVN1dJczVjcXl6?=
 =?utf-8?B?Smk1aTQvYzh6V1FSbW1SamFYd3d6dXVQSUk1d1g3eXMxT05NRkN4MGJSSmlM?=
 =?utf-8?B?Z01Jb2M3SXRjcEhYR080aDhETVBlZ1NWdUY1aGxOQnhkWkx2QWxIUUhtTU5F?=
 =?utf-8?B?RS9yUlJvbzJUeUU2YlAraVo3NTNlYnI5Qzd0YnByM1VJMHpFN1g2N1R2c2p1?=
 =?utf-8?B?ZEhZYitNR3JYQlQ0UFVaeFFqS3k3bW8yUzFTWDdpd1FsZ3FueFBEOVQvd04r?=
 =?utf-8?B?ZStCNVA5T0NFNFk1MERqL0hVNEU0emFic3ByS2gxTnZYckxVUkEwYUZuQXZj?=
 =?utf-8?B?RjFJYXJ5NXlMb3FLdnFUTVdVRUh3TzRPcjEzeHllWFVGa2tDVW5UWjJwWk1D?=
 =?utf-8?B?Si9hU0J4TjVRdUl0S2lXd0JQeHFRZWw1enJESytUd0pXMnY1R0hoTmVjZG1M?=
 =?utf-8?B?UW9xOEovVUN2S1dCVXBNT0dpSmZEbHpINXNxRHAzV2VBRlgwdThvbG41TXNE?=
 =?utf-8?B?K3VlS2MrMTQ1YkxUVWpXbjhaUmpDeU9rNEk3T3I1aCtKK25INWxjZTdQL3BL?=
 =?utf-8?B?c3BtdndscUlZQzhnajFSNU5HckY2ZkowSHZwWHlZMzRjTnBFQ3NWMHE0LzYy?=
 =?utf-8?B?NE5rYlp0WHVZSGU0WEs2ZmdMLy8wMW5HOEZsMERQN0VSclBtZ1pWS0NjcEIv?=
 =?utf-8?B?Zml3RDVVQ2daS2pXS21SaWpLeGVmRHhST01YenJueDhWZm1ZWUY5NmQrZFJo?=
 =?utf-8?B?d1JJTnNqeHliY29mbXhuWisvc2Y4ZTFUQVozSERwdU83OUthYTJJVXUzcEkv?=
 =?utf-8?B?MEduTjRDZ3ZlVU1iWFdsL3JWVG9YWHFBcWNpbmROcnB5empZQ09OWXJVTm5w?=
 =?utf-8?B?Qk9IMHpjdnc2TXhrVmdPSGlXM3B6RGIwR1h6L1lLdE5nazIvWVlmTjIzODRV?=
 =?utf-8?B?UjBJd0xxQzVNZE1MQ1dkcERtVmN0d1JZei9mT2YyRThhYXBnWnB1ekVMVVgy?=
 =?utf-8?B?NzhmY2dJbEFldHJRZ1BOVmREREpBdnZLRFd6QzdneTNWSUxGNUw4ZzVJaXpx?=
 =?utf-8?B?SnR1Uno3aHhBVFdUWWl1QngzUmVVTzVjcTVmdGFQaDJnbElMUGFLSDRVdm0x?=
 =?utf-8?B?WTFhZkxMVldwTVRmN3pTVkJRaEhtUEMwK1M2bUxwMllmNkRhYkJkeTlkNmxZ?=
 =?utf-8?B?U1lYWmhKOGUyNkVDN3ROclUrRThWZTVRZVZxcEZNaEVaYVlmZjJuVUdPamdw?=
 =?utf-8?B?SDhPUHRCWk1ITDdwMnlJeU43U0gyZHlmNnUweDBwdUtEaFZrYjZmSnhmNkR5?=
 =?utf-8?B?Nkd1NGtOeUhWYUU1ZVN3aXBnQS83SEZaOHpmYXNDaUdyN3hvV1orN1NyOUI5?=
 =?utf-8?B?ZHJ1RzRzRW9IYi8zK1BWNzhyNnVkMzNiY25GUmc1YjJwcURaRWlmOGVlVVRn?=
 =?utf-8?B?ZXRtMXNtcytRT2hFeE5EV3BTWWVHZ2Z5bDVTT3VYdWxZWFRTb01IREpxMnYz?=
 =?utf-8?B?dW42VW5WNVc5NFRmc3NLMmhRQkxBbVREQ29Pb0RCRTdseDgreVlleDlsVFFL?=
 =?utf-8?B?NWo1M3ZZWnl1Mkc3ekptNS82eGpSKzkxWDI4YXZES2JTdGFMSXdPdGs1a2tp?=
 =?utf-8?B?eWl0MDhKaldjc0QzV0FVdFBiRldMOVpNZjNiSi9ETUtDNGJkV0VwNlRHS3Ns?=
 =?utf-8?B?eGZLaVMvNWZ6M3lYb1d6Znh3cEtmRHFSd1BMK0lERDhIaWIyUkZXRjBYaTJR?=
 =?utf-8?B?ZGpoVUlZdUlURkl0ZVgxZzNtekRFRnJkSmtKamVxVzhDUVFUR3RtdnpwSDZY?=
 =?utf-8?B?K1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: toshiba-tsip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6103.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2435c89b-020c-4f4b-adb4-08dc8f515852
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 04:44:31.6579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3Vcv/4R+ZgKBGxWRHnNBJufXlslhWf7h11dFaW0rZml+yoqKz4vLVrkzgUDi/ThAT+ZOH4qbl4GBcbV1AV3FBOolb2Oxpf/THO1JJC4FYw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB9520
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 18 Jun 2024 04:44:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16272

SSBhbSB2ZXJ5IHNvcnJ5IGFib3V0IHRoaXMgSmFuLiBZZXMsIHRoZXkgbXVzdCBiZSBzcXVhc2hl
ZCB0b2dldGhlci4gTGV0IG1lIHJlLW9yZGVyIHRoZSBwYXRjaGVzIGFuZCBJICdsbCBzZW5kIHYy
IGZvciB0aGlzIHNlcmllcyBub3cuDQoNClRoYW5rcyBhbmQgcmVnYXJkcywNClNhaSBBc2hyaXRo
IFNhdGh1am9kYSAoVCBTIEkgUCkgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPiANClNlbnQ6IFR1ZXNkYXksIEp1
bmUgMTgsIDIwMjQgMTA6MDkgQU0NClRvOiBhc2hyaXRoIHNhaSjvvLTvvLPvvKnvvLApIDxTYWku
U2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+OyBjaXAtZGV2QGxpc3RzLmNpcC1wcm9qZWN0Lm9y
Zw0KQ2M6IGRpbmVzaCBrdW1hcijvvLTvvLPvvKnvvLAgVE1JRUMgT0RHIFBvcnRpbmcpIDxkaW5l
c2gua3VtYXJAdG9zaGliYS10c2lwLmNvbT47IGhheWFzaGkga2F6dWhpcm8o5p6XIOWSjOWujyDv
vKTvvK3vvKUg4peL77yk77yp77yn4pah77yt77yw77yz4peL77yt77yw77yUKSA8a2F6dWhpcm8z
LmhheWFzaGlAdG9zaGliYS5jby5qcD4NClN1YmplY3Q6IFJlOiBbaXNhci1jaXAtY29yZSB2MSAx
LzNdIC5naXRsYWItY2kueW1sOiBCcmVhayBjdXJyZW50IHRlc3Qgam9icyB0byBydW4gb25lIExB
VkEgam9iIHBlciBHaXRsYWIgam9iDQoNCk9uIDE3LjA2LjI0IDIwOjIxLCBTYWkuU2F0aHVqb2Rh
QHRvc2hpYmEtdHNpcC5jb20gd3JvdGU6DQo+IEZyb206IHNhaSBhc2hyaXRoIHNhdGh1am9kYSA8
c2FpLnNhdGh1am9kYUB0b3NoaWJhLXRzaXAuY29tPg0KPiANCj4gU2lnbmVkLW9mZi1ieTogc2Fp
IGFzaHJpdGggc2F0aHVqb2RhIDxzYWkuc2F0aHVqb2RhQHRvc2hpYmEtdHNpcC5jb20+DQo+IC0t
LQ0KPiAgLmdpdGxhYi1jaS55bWwgfCA4MCANCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3MSBpbnNlcnRpb25z
KCspLCA5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhLy5naXRsYWItY2kueW1sIGIv
LmdpdGxhYi1jaS55bWwgaW5kZXggYjNmMWZjNi4uYjU2NzU1NiANCj4gMTAwNjQ0DQo+IC0tLSBh
Ly5naXRsYWItY2kueW1sDQo+ICsrKyBiLy5naXRsYWItY2kueW1sDQo+IEBAIC0yNiw2ICsyNiw3
IEBAIHZhcmlhYmxlczoNCj4gICAgZGVwbG95X2tlcm5lbGNpOiBkaXNhYmxlDQo+ICAgIGJ1aWxk
X3N3dV92MjogZGlzYWJsZQ0KPiAgICBzd3VwZGF0ZV92ZXJzaW9uOiBkZWZhdWx0DQo+ICsgIHRl
c3RfZnVuY3Rpb246IHN3dXBkYXRlDQo+ICANCj4gIHN0YWdlczoNCj4gICAgLSBidWlsZA0KPiBA
QCAtMzU1LDYgKzM1Niw4IEBAIGJ1aWxkOnFlbXUtcmlzY3Y2NDoNCj4gICAgdGFnczoNCj4gICAg
ICAtIHNtYWxsDQo+ICAgIGFsbG93X2ZhaWx1cmU6IHRydWUNCj4gKyAgc2NyaXB0Og0KPiArICAg
IC0gc2NyaXB0cy9zdWJtaXRfbGF2YS5zaCAke3Rlc3RfZnVuY3Rpb259ICR7dGFyZ2V0fSANCj4g
KyAke0NJX0NPTU1JVF9TSE9SVF9TSEF9ICR7cmVsZWFzZX0gJHtDSV9DT01NSVRfUkVGX1NMVUd9
DQo+ICAgIGFydGlmYWN0czoNCj4gICAgICBuYW1lOiAiJENJX0pPQl9OQU1FIg0KPiAgICAgIHdo
ZW46IGFsd2F5cw0KPiBAQCAtMzY0LDIzICszNjcsODIgQEAgYnVpbGQ6cWVtdS1yaXNjdjY0Og0K
PiAgICAgIHJlcG9ydHM6DQo+ICAgICAgICBqdW5pdDogcmVzdWx0cy9yZXN1bHRzKi54bWwNCj4g
IA0KPiAtdGVzdC1xZW11LXNlY3VyZS1ib290Og0KPiArdGVzdDpxZW11LWFtZDY0LXNlY3VyZS1i
b290Og0KPiAgICBleHRlbmRzOg0KPiAgICAgIC0gLnRlc3QtY2lwLWNvcmUNCj4gLSAgc2NyaXB0
Og0KPiAtICAgIC0gc2NyaXB0cy9zdWJtaXRfbGF2YS5zaCBzZWN1cmUtYm9vdCAke0NJX0NPTU1J
VF9TSEF9ICR7cmVsZWFzZX0gJHtDSV9DT01NSVRfUkVGX1NMVUd9DQo+ICsgIHZhcmlhYmxlczoN
Cj4gKyAgICB0YXJnZXQ6IHFlbXUtYW1kNjQNCj4gKyAgICB0ZXN0X2Z1bmN0aW9uOiBzZWN1cmUt
Ym9vdA0KPiAgDQo+IC10ZXN0LXFlbXUtc3d1cGRhdGU6DQo+ICt0ZXN0OnFlbXUtYXJtNjQtc2Vj
dXJlLWJvb3Q6DQo+ICAgIGV4dGVuZHM6DQo+ICAgICAgLSAudGVzdC1jaXAtY29yZQ0KPiAtICBz
Y3JpcHQ6DQo+IC0gICAgLSBzY3JpcHRzL3N1Ym1pdF9sYXZhLnNoIHN3dXBkYXRlICR7Q0lfQ09N
TUlUX1NIQX0gJHtyZWxlYXNlfSAke0NJX0NPTU1JVF9SRUZfU0xVR30NCj4gKyAgdmFyaWFibGVz
Og0KPiArICAgIHRhcmdldDogcWVtdS1hcm02NA0KPiArICAgIHRlc3RfZnVuY3Rpb246IHNlY3Vy
ZS1ib290DQo+ICsNCj4gK3Rlc3Q6cWVtdS1hcm0tc2VjdXJlLWJvb3Q6DQo+ICsgIGV4dGVuZHM6
DQo+ICsgICAgLSAudGVzdC1jaXAtY29yZQ0KPiArICB2YXJpYWJsZXM6DQo+ICsgICAgdGFyZ2V0
OiBxZW11LWFybQ0KPiArICAgIHRlc3RfZnVuY3Rpb246IHNlY3VyZS1ib290DQo+ICsNCj4gK3Rl
c3Q6cWVtdS1hbWQ2NC1zd3VwZGF0ZToNCj4gKyAgZXh0ZW5kczoNCj4gKyAgICAtIC50ZXN0LWNp
cC1jb3JlDQo+ICsgIHZhcmlhYmxlczoNCj4gKyAgICB0YXJnZXQ6IHFlbXUtYW1kNjQNCj4gKyAg
ICB0ZXN0X2Z1bmN0aW9uOiBzd3VwZGF0ZQ0KPiArDQo+ICt0ZXN0OnFlbXUtYXJtNjQtc3d1cGRh
dGU6DQo+ICsgIGV4dGVuZHM6DQo+ICsgICAgLSAudGVzdC1jaXAtY29yZQ0KPiArICB2YXJpYWJs
ZXM6DQo+ICsgICAgdGFyZ2V0OiBxZW11LWFybTY0DQo+ICsgICAgdGVzdF9mdW5jdGlvbjogc3d1
cGRhdGUNCj4gKw0KPiArdGVzdDpxZW11LWFybS1zd3VwZGF0ZToNCj4gKyAgZXh0ZW5kczoNCj4g
KyAgICAtIC50ZXN0LWNpcC1jb3JlDQo+ICsgIHZhcmlhYmxlczoNCj4gKyAgICB0YXJnZXQ6IHFl
bXUtYXJtDQo+ICsgICAgdGVzdF9mdW5jdGlvbjogc3d1cGRhdGUNCj4gKw0KPiArdGVzdDpxZW11
LWFtZDY0LXN3dXBkYXRlLWtlcm5lbC1wYW5pYzoNCj4gKyAgZXh0ZW5kczoNCj4gKyAgICAtIC50
ZXN0LWNpcC1jb3JlDQo+ICsgIHZhcmlhYmxlczoNCj4gKyAgICB0YXJnZXQ6IHFlbXUtYW1kNjQN
Cj4gKyAgICB0ZXN0X2Z1bmN0aW9uOiBrZXJuZWwtcGFuaWMNCj4gIA0KPiAtdGVzdC1xZW11LUlF
QzoNCj4gK3Rlc3Q6cWVtdS1hbWQ2NC1zd3VwZGF0ZS1pbml0cmFtZnMtY3Jhc2g6DQo+ICsgIGV4
dGVuZHM6DQo+ICsgICAgLSAudGVzdC1jaXAtY29yZQ0KPiArICB2YXJpYWJsZXM6DQo+ICsgICAg
dGFyZ2V0OiBxZW11LWFtZDY0DQo+ICsgICAgdGVzdF9mdW5jdGlvbjogaW5pdHJhbWZzLWNyYXNo
DQo+ICsNCj4gK3Rlc3Q6cWVtdS1hbWQ2NC1JRUM6DQo+ICAgIGV4dGVuZHM6DQo+ICAgICAtIC50
ZXN0LWNpcC1jb3JlDQo+IC0gIHNjcmlwdDoNCj4gLSAgICAtIHNjcmlwdHMvc3VibWl0X2xhdmEu
c2ggSUVDICR7Q0lfQ09NTUlUX1NIQX0gJHtyZWxlYXNlfSAke0NJX0NPTU1JVF9SRUZfU0xVR30N
Cj4gKyAgdmFyaWFibGVzOg0KPiArICAgIHRhcmdldDogcWVtdS1hbWQ2NA0KPiArICAgIHRlc3Rf
ZnVuY3Rpb246IElFQw0KPiArDQo+ICt0ZXN0OnFlbXUtYXJtNjQtSUVDOg0KPiArICBleHRlbmRz
Og0KPiArICAgLSAudGVzdC1jaXAtY29yZQ0KPiArICB2YXJpYWJsZXM6DQo+ICsgICAgdGFyZ2V0
OiBxZW11LWFybTY0DQo+ICsgICAgdGVzdF9mdW5jdGlvbjogSUVDDQo+ICsNCj4gK3Rlc3Q6cWVt
dS1hcm0tSUVDOg0KPiArICBleHRlbmRzOg0KPiArICAgLSAudGVzdC1jaXAtY29yZQ0KPiArICB2
YXJpYWJsZXM6DQo+ICsgICAgdGFyZ2V0OiBxZW11LWFybQ0KPiArICAgIHRlc3RfZnVuY3Rpb246
IElFQw0KPiAgDQo+ICBjdmUtY2hlY2tzOg0KPiAgICBzdGFnZTogY3ZlLWNoZWNrDQoNCkRvZXMg
dGhpcyB3b3JrIHdpdGhvdXQgcGF0Y2ggMj8gT3Igc2hvdWxkIGJvdGggYmUgZm9sZGVkIHRvZ2V0
aGVyPw0KDQpKYW4NCg0KLS0NClNpZW1lbnMgQUcsIFRlY2hub2xvZ3kNCkxpbnV4IEV4cGVydCBD
ZW50ZXINCg==


