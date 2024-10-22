Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37625D1CDC9
	for <webhook@archiver.kernel.org>; Tue, 22 Oct 2024 09:27:04 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.67])
 by mx.groups.io with SMTP id smtpd.web10.14399.1729589215136741462
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 02:26:55 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=Qd/rRGOu;
 spf=pass (domain: renesas.com, ip: 52.101.228.67, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z/YCWynMEgEIIMsvm5qs8U2nCp2LakGDpvUwTNiCPLM7EHt2IgdDaysPzk7dZ7yLDzKA1f5PBIod20W/1hFMaGTe2DDaTaCVlZ0r5MDzDBu6iH5jvO6NiR5d69f/oct8imEdMN4L0Jq4khfyLavfizeaO93/yzsWUvY8ce7apr9z0QrFndtI+bEDCWbihgBejKnvwdU0oN748xo4ugu00CxF+Wh39XuCnpE4MCQQnvE+M5L7OOIjL800Z/2kFmMPkv0om9ZiO7sWcpv62Aees77sUeY9d7TXT+1ew9rZACH9POLCE26HP3q7+l1Sb+z0oOQGAnlVey1JlsPOSmxuow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVYo0nPjYyZ548dZ7kuDmyCGzzRKJ163JYFYRMB5TCU=;
 b=Qv19D0xQsaT7yosS4tb4+V2NqrJqetX8ZaCsDOaFf4DT9xXSvhCq+8ahB7LMKRMPXHUWQ3QEKLbcssSNZFCoFtK6b3JmN2TQVULBJoq0FbFmf31T4tDefkWG7GzUsQ1BVepDxD/N63/6sGCG7sxfJoYuwx5i93yO+kbZK8FoWHBaDRRa31MbNuQAS9FX0Fjx2v1PEdIFUSCDsgtWk1FCKKvqo/uB6XawWKiXPT/K+NN19YEtsT3jDZljB0z4zmdSlZPySWpyC5iXzBxp17k9Vd5C96+EiyNJCSfeS8wevcR/jZd4xqoy2tl6m4GO30Hc/We8YMVklhdCiizwrtSriw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVYo0nPjYyZ548dZ7kuDmyCGzzRKJ163JYFYRMB5TCU=;
 b=Qd/rRGOuFAsjV2SOj4n6I+apbnS7XWIpNS9lkoXFWALKpgQPjzm6g8KC2L/+cy6bI+g2zjh6ecyo++zRoO6eeaLTDth4ysQ9gknkjWu84WnWTRue7p2SVjYU68DTg8Ud6OUfytXiIzYetkPQ6pNgkaN9ZkOotHJVGlfwEF27Cjs=
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com (2603:1096:405:fc::13)
 by TY1PR01MB10802.jpnprd01.prod.outlook.com (2603:1096:400:323::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Tue, 22 Oct
 2024 09:26:50 +0000
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303]) by TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303%3]) with mapi id 15.20.8069.027; Tue, 22 Oct 2024
 09:26:50 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Sai Sathujoda
	<Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: cip-core: Something fishy with qemu devices?
Thread-Topic: cip-core: Something fishy with qemu devices?
Thread-Index: AQHbIfrGAI1mkl/YzEexBUcObiQ0JLKQ0VWwgAAxtYCAAYBgYA==
Date: Tue, 22 Oct 2024 09:26:50 +0000
Message-ID: 
 <TYYSPRMB0010E7B364227D25124D5A4DB74C2@TYYSPRMB0010.jpnprd01.prod.outlook.com>
References: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
 <TYYSPRMB0010816199991F38C90CA81FB7432@TYYSPRMB0010.jpnprd01.prod.outlook.com>
 <1fb9c7f6-81eb-4f3a-941f-ccbe97112816@siemens.com>
In-Reply-To: <1fb9c7f6-81eb-4f3a-941f-ccbe97112816@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYSPRMB0010:EE_|TY1PR01MB10802:EE_
x-ms-office365-filtering-correlation-id: ccdca7a5-85ec-4fa8-966a-08dcf27ba87d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?c3g5OXJnVDFRK1h2NWp2bklaWStaL2NWRmZpTUJsSi9ZQStDTmlhdUYxTDA3?=
 =?utf-8?B?VTI5WGVTZkZFeFNHQW5kVjJYd295N0pPY3dGSWRSQzd2a0xUeklkbUtwZnFQ?=
 =?utf-8?B?dzF2N1dxT1FEZXVHU2xTMXRNYmhwUVdhUEEwQUJlS1JIU2R4SEhnVURZaGw4?=
 =?utf-8?B?T1RqOElkY1d2N2VQZjV6NWtiMnlaNG9seWI5S0pqbzlwVmhScHB4MVI0WFlu?=
 =?utf-8?B?L3FJSmNuYlU1N1dIcit1SnhYOHVITExidzU1Nkd1ajh4VG9qaUo4SUlkbEtZ?=
 =?utf-8?B?WDFIR2xOQ1BXbWpQWFgxVzAyWVRzenFIZlNPQUdIeHN0S1ZHS1Q0UzVFdXU1?=
 =?utf-8?B?bzNkaWVDcFJUK1dKRHh6VDl6RmFRZTJQSVhPS2lHa2N6VUt1QjRTSHE3MUdj?=
 =?utf-8?B?WlJxR1d4RlpLaXE5S3MzbUR5Mjhuekt4K2RnQ0hCTGF4QTFMeUtwbU0rVm12?=
 =?utf-8?B?UitWRjNVSCtJSTY1YXd1alRxbGZMV0pGNTI4dDNTZEcvdlVJaG85S2hPbjRB?=
 =?utf-8?B?OWZ3U21ONEFCME1UMzhXU2VBc0xCcUN6aFRJYWUxTzhLa0JDL1NVRXJFTk1S?=
 =?utf-8?B?RC96OFpJOW5DcnVGQjErRmQxM3ZSMzBMUENLVXRDMXdVR05DL1luUnJSTm1L?=
 =?utf-8?B?Zkhud3I5K3F0cFI3V0NWTzMvekszOTU3eXgyVUo0eUx2b0lNaWcvMkhjMkVa?=
 =?utf-8?B?NVBpNTVXeDhxajRFc0o3bzZEOThmWnJ5bjlnL21RQW40N0FjNW9ObXhUU1Fk?=
 =?utf-8?B?bGthN3RuSlM4Rk12dGlJdS8zWnphRm5QSFQ3SnRrSTdYem44Wko4TzdPbUtu?=
 =?utf-8?B?N2lzQUZUTDk5US9zdkJMNGZtNkxyNjRsQ3JnS25oODczVEY0OFcxWFJxNUVZ?=
 =?utf-8?B?eHAxdzdScksyYXNJbk5HSFQ0a1RTVHgrT01PS1poVlhXcWtmU1czMnN1R3k5?=
 =?utf-8?B?NVp2OVNuSmJOTkRmUXUxWnFnRG1KNG1FLzVGRlBQRnRBK3dzNGJzVm1sVW96?=
 =?utf-8?B?bEJMY0JrN3JxMGVTUEVnRE14TGhYSTE1amNJY1hSbUtWY2Z0c0ViSTBZQTdN?=
 =?utf-8?B?NHRlUzJ2TzVhTjdKdE56MDZ6SC9KTURWYzc3UVZDVlhvNEczNnEyOHVtYkZE?=
 =?utf-8?B?cVBwdFpoSjlSSzU2NmdPQ3RYWjVWeENEU0RGN2NaQTZiN3dLUS9NaFlGdVIr?=
 =?utf-8?B?WCttQ0FGZUxlZlFHMTloc2R4YmhUeUZ6ZUZwdTd1bGpNQ0RxeEF0bkNYTFRQ?=
 =?utf-8?B?dFBjaUgyTXAwVDY1MFdhbHRpSS8wOHJvZUl0anlGeXR2bTBXdmVHRldIUUw3?=
 =?utf-8?B?bmRKcUlwU1AzSC94WWZZODZrVm9lSkgvZC9zZHlQbk9YMGhzanFnQ29FSnNI?=
 =?utf-8?B?SVpLZUhZVGJ5dUxOVmVYWXpmT1NYZllCUmlEby9kNE9ic1BGZEl1S1UrWVZh?=
 =?utf-8?B?MXNpQlBPbGthcmF2UHF0ekh4WDVjQ0pYbS9QQ1pFemgweVJOR0JEZi9SK1l2?=
 =?utf-8?B?MDRvTFlVcFdQTFl0cURLNW5GY2EzOEo2YzFQc0UwazV3UTdLWDJjVGxQaWxJ?=
 =?utf-8?B?OGJUbERmWG5VeHhVUTBST0xQL01BTExtNnYxZWMvYVk5MzFZRVM3bjFyVEJm?=
 =?utf-8?B?QWkxSldicXlzYkFhM2NobzkwalJsZ3Z0WWIwTlBBL3pZaWlzTHJWVlZLOEl4?=
 =?utf-8?B?US9oMjlTaVdtOHhjeUFuQlliR0UyYmdodk52MGEwZnAwaVg2VlhSa0gxN1NV?=
 =?utf-8?B?SDVKRTFWOXUzTWF3b2h4L0N4eEhORkU1RmkyRzRRUmRJa24xOGJRa24xVVVG?=
 =?utf-8?B?UnlJc2pBZ3lJQ0U4bXRoZ1ZkMUU3WWVBSVUwM0ZMYm5JeGtEdEdYbmtGL05N?=
 =?utf-8?Q?bsCWCwg9akbwP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYSPRMB0010.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WmEwY0ljZWdrRGpyYk1nWVRwU2tlNElsVXhySitHakp3dmF0WnBNUHBoUXpP?=
 =?utf-8?B?T3V3UlZXVWh5eGNYWWVqK0J5bkNZYUhMSGQ5ZnptNldZQ3VRN1E0KzcrWDRH?=
 =?utf-8?B?YXN6Wk5ZNFNhM3IzdndGMFIzNnJWYlFQaG1HZzFsNkppMHY4cHZFcWwvOGNQ?=
 =?utf-8?B?aUx3Y0ZjNE4zVFVKdUtZYWgvWjZLckIvKzRTaXdxd25iV3IwaWRwc213cmNp?=
 =?utf-8?B?d2hDSDcxTDJJZ052WnBsb01QM003YWxucjFneURpYWw5WFBERUNQcmFqdEN5?=
 =?utf-8?B?U1hxQzMwdk5sRGMybFlrVjI2WW8zRGU2aWx3VGkvVjFlVEdFcWxEUFRheHB1?=
 =?utf-8?B?amcyOGdQZ2REcWxjYlpHQkdmOTVUTXJMWXVEQ3RVbTMyK0dXTStqWU5RYkNh?=
 =?utf-8?B?Z2FUaHBMLzlDR2RpUXRXcVE3ZWNyV0RIUVdxU0daYVdwb3lLenVvUzFKSjlM?=
 =?utf-8?B?d0t3QjJtaTdHSlgxOTBFZWlHTW16Y21sZGJSeWpHcUFhaCtoT2dnL0ZmSHVH?=
 =?utf-8?B?MVM2SEcyVGMvYU9tcnhsSEFsTzdEUHBxb0R4UW8rb0N5QU83SEdMdWpqbEZB?=
 =?utf-8?B?djhhWWtOT2hiWXFUZ09ETlZlT2FnWHNjUXdheXJjbDRWQmk3bi9pcWZrNUsv?=
 =?utf-8?B?VEhZeFFESUdhbEdiRk9saFdYQWRSZzFSRmhYclhXaVB1SXRYNXFZSWgyamsz?=
 =?utf-8?B?WHVVQWwwZnhxZEorWVh2RlI2Ykl6bGtGNHBGdjFXcmtlNHFLUU1aZEI4dWJL?=
 =?utf-8?B?RkRsS1pwems5ZVhiWEg4di8vVGNYRFNQVzFxZTJKTHZaWURzeHhoRUpKbmRG?=
 =?utf-8?B?TmVpNU04ZkxBRm5WMXcrVzJiSDI3ay85d3NyK2p2WWVmUnZpRzRTT0tqTDJC?=
 =?utf-8?B?VklqekRIaDJ3NU9JSERCdVRIeWxYdS9BY3lVMnhTUnI3UDkxVUUyeEp2Zmd2?=
 =?utf-8?B?V1VlaTBOdWE2R3ROZkxYbzlnU0o1czhFT2MrUXRYZDJlUVlMTnNsT0J3RmQv?=
 =?utf-8?B?WGM3dytrQzJRQUtGNFBoTHFZWXlsR2hjMXdRRDlBRFZRcXZsRDFqTWZ4TDUv?=
 =?utf-8?B?ZmRjckl6OS8zVm1RNUovdkxmdXdIMEVmY2c0VGlESDJhR1JySVluWEtZNnFN?=
 =?utf-8?B?NS85em5KTjU0MWFCUFY3M2c2MGhjY29nT3BzWHl6dUF2NVY0YTRNeS9Ldk9B?=
 =?utf-8?B?cm1ic2IvYUpuQjFDZlBic0ZKNloyelIza0VSSTZIRURxZmJza3VPMzVrRk1C?=
 =?utf-8?B?RkpEcGVqeENqZk1aMmxOUlkrd0FFdWsrK0ROelZpZ3YzNFBicXpTSTdsMnFj?=
 =?utf-8?B?bW5yenl4SmxvaFN4YXFQUDdtYUhVc3FsUHB3TTBBOCttR3l2ajVRTkRDNGlS?=
 =?utf-8?B?RktWZHJCOWZLdEVFRE5HWCtoVzBCSHA4VmdITXR5N2crRVFsSHI0eUxiVnNP?=
 =?utf-8?B?dVFTV0YwU1ZFQnJnVTJhR3FwTlFVQlBpTEV4MWhlY2g2MHg1eHlGMzZKWTNu?=
 =?utf-8?B?a2VyOG1idXpaLzM3SHlxNUVXTHdkS1BVSk5lRWljMG1RU2YvbDNpb1RoUjVE?=
 =?utf-8?B?byt3U0VuZjZnYmxqeS9NWXR5dDV4NWN1aGlwZ3VyUWhWRTErTkNFbU9aeEJj?=
 =?utf-8?B?YmZGUDFyRG90MjNwTzBDZUhnZDV6eG0vVnlmakU4V2NLRTgzdGFwekUrNlhX?=
 =?utf-8?B?T2VEb083eG4xUUJnUHBtekNJTGFUNW9jLzNGZjAyVkd5MVN3bFdQMzlEOTN3?=
 =?utf-8?B?eEVFNHNhNmQvaEJ6ejQ0RzNHeXBtRUpLWjNsTXNwcTZPS3FDT1BLamN4c3hG?=
 =?utf-8?B?Z2tpUVdDN3NuWi9jbGh0alYveDNUdjQ3bUFleEpYNlNnL09vSU1mR1gvNGJh?=
 =?utf-8?B?NGEvWDJweE1XbnpmVmFEemdlVFBaaGdQUjBPUGZFOG90YUhlWXlVYllhSElH?=
 =?utf-8?B?QkxxZGtIVUVoNXB3MEQ1WU5ZeWJIcTYxSGRya0tqVXBJd3pnVEd0aEZLd25L?=
 =?utf-8?B?QkR3ZGw0Mkk4cVdmc3BDeUgvR3pPSmZYNWJyNXROZ3pHZ1dtL3ZHWnBmd0ow?=
 =?utf-8?B?dHlmemxiVWRhSmVtYlIxWGFvNEdwb1VRbDc4c2xsRDNnaGptSWZBZkZxVTBJ?=
 =?utf-8?B?UmVsb2EyOHhtTEFDQ1U3OGhkdllvdFU1VmdFV0pWbVZUQzFERWlZUC9qV2VB?=
 =?utf-8?B?N3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYSPRMB0010.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccdca7a5-85ec-4fa8-966a-08dcf27ba87d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2024 09:26:50.1454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PHVfzWC30CAxrJiaqbE02pfcWgu8N6NJtBudU0TgnC3zJ7GRsN5VkDzY2Jcu7xcJi79v6G+0dnWhq43wHvnFNmEtbYqg6BGqvpE6yoG0bxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PR01MB10802
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 22 Oct 2024 09:27:04 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17064

SGkgSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IFNlbnQ6IDIxIE9jdG9iZXIgMjAyNCAxMToyNQ0KPiANCj4gT24gMjEuMTAuMjQgMDk6MzEsIENo
cmlzIFBhdGVyc29uIHdyb3RlOg0KPiA+IEhpIEphbiwNCj4gPg0KPiA+PiBGcm9tOiBKYW4gS2lz
emthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiA+PiBTZW50OiAxOSBPY3RvYmVyIDIwMjQg
MDg6NDUNCj4gPj4NCj4gPj4gSGkgYWxsLA0KPiA+Pg0KPiA+PiBJIGhhZCBjb3VudGxlc3MgZXJy
b3JzIHdpdGggcWVtdSB0YXJnZXRzIHdoaWxlIHRyeWluZyB0byB0ZXN0IHRoZQ0KPiBsYXRlc3QN
Cj4gPj4gY2lwLWNvcmUgaW1hZ2UsIHNlZSBlLmcuDQo+ID4+DQo+ID4+IGh0dHBzOi8vZ2l0bGFi
LmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy84MTI5ODE0NzY3
DQo+ID4+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVjdC9jaXAtY29yZS9pc2FyLWNpcC1j
b3JlLy0vam9icy84MTI5Nzg2OTQzDQo+ID4+IGh0dHBzOi8vZ2l0bGFiLmNvbS9jaXAtcHJvamVj
dC9jaXAtY29yZS9pc2FyLWNpcC1jb3JlLy0vam9icy84MTI5Nzc3MTE4DQo+ID4+DQo+ID4+IEFm
dGVyIGhpdHRpbmcgcmV0cnkgb2Z0ZW4gZW5vdWdoLCB0aGlzIHBpcGVsaW5lIG5vdyBzZWVtcyB0
byBwYXNzLg0KPiA+Pg0KPiA+PiBBbnkgaWRlYXMgd2hhdCBpcyBnb2luZyBvbiB0aGVyZT8NCj4g
Pg0KPiA+IEkndmUgYmVlbiBzZWVpbmcgc29tZSBjb25zdGFudCB2ZXJ5IGhpZ2ggQ1BVIHVzYWdl
IG9uIG91ciBMQVZBIHNlcnZlciBvZg0KPiBsYXRlLCBhbmQgSSdtIHN0aWxsIHRyeWluZyB0byB3
b3JrIG91dCB3aGF0IGlzIGRyaXZpbmcgaXQuDQo+IA0KPiBIbW0sIGhvcGUgaXQgd2FzIG5vdCBo
YWNrZWQgYW5kIGlzIGRvaW5nIGlsbGVnYWwgdGhpbmdzIG5vdy4NCg0KTWUgdG9vIQ0KDQpIb3dl
dmVyLCBsb29raW5nIGluIG1vcmUgZGV0YWlsIGl0IGxvb2tzIGxpa2Ugd2UncmUgc2VlaW5nIGEg
bG90IG9mIENQVSAic3RlYWwiIGZyb20gb3RoZXIgdmlydHVhbCBtYWNoaW5lcy4NCldlJ3JlIG9u
IGEgc2hhcmVkLCBidXJzdGFibGUgRUMyIGluc3RhbmNlIGFuZCBteSBndWVzcyBpcyBvdXIgbmVp
Z2hib3VycyBhcmUgYSBsb3QgYnVzaWVyIHRoYW4gdGhleSB1c2VkIHRvIGJlLg0KQXQgbGVhc3Qg
dGhhdCdzIHdoYXQgSSBjYW4gd29yayBvdXQgZnJvbSBteSBsaW1pdGVkIHVuZGVyc3RhbmRpbmcg
b2YgInRoZSBjbG91ZCIuDQoNCldlJ3JlIGdvaW5nIHRvIGNoYW5nZSB0aGUgc2V0dXAgc28gd2Ug
Z2V0IG1vcmUgZ3VhcmFudGVlZCBDUFUgdXNhZ2Ugb24gV2VkIG5pZ2h0Lg0KU28gaG9wZWZ1bGx5
IGl0J2xsIGFsbCBiZSBiZXR0ZXIgYWdhaW4gYnkgdGhlIGVuZCBvZiB0aGUgd2Vlay4NCg0KS2lu
ZCByZWdhcmRzLCBDaHJpcw0K

