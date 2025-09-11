Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB77CAC58D
	for <webhook@archiver.kernel.org>; Thu, 11 Sep 2025 09:25:39 +0000 (UTC)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (JPN01-OS0-obe.outbound.protection.outlook.com [40.107.113.62])
 by mx.groups.io with SMTP id smtpd.web10.42037.1757582736264428078
 for <cip-dev@lists.cip-project.org>;
 Thu, 11 Sep 2025 02:25:38 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=ntv7k0ZD;
 spf=pass (domain: renesas.com, ip: 40.107.113.62, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mu546/RnyOZoYODwk0H1iFReRxVU57LLFqWK74gkKLZqmLjDL4n3ilIQcEs0pTTI8cBHpv2web05ewFy1MnQGyJriwYbEXvbswi8N/9eEL5eFV9h61fyh39xmGEQciiX/i9ozfDxFcE3j1ttEZCMoutKKmZOg81K07X+gUf9XKFsuJ9jkh53wAarx7+MrWgIb0UKtvTh9+JTqonWIr7WGciby2qAI9OacuDyUXLci11VSAptHsUbicZ935ICE3/vXJTVxnsigR/Q0I08YwxOGSG3AtIS3QmKucRnLnR1b/v5lnY4zlbMnQ+mVPTgoHSSUg5GrZY2QJNb+zf67pS5IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlsiP/69m6J216rSubLQfI9RGOwdWB1JsuaLhFoZSNA=;
 b=vSJ8OFAi4ZX+9tO3Tori3aasbuBjg3+ykfNddARqALb1SVO54hhT5pl0+F9mr5lCV25d6qLEbnpGxJN3lwuPsOMO/Uvvq0vKUbHUHcnz60egH55sQIFvoMSkYfK6qVJNtrr2DBnOhqJ0gbggruw+ftZKBu+8M/GYs6riqTpRhCFOfzmZ7mXFLF6oo+dTyL1qFJFfgJonlpxRDIIr4BZykUejIn57vI6sfu8rVj8mHDokL7N3t+j6IfEgMD+AdwtZ8Y+VZIXPYeeU9SaAOSIcPiwi/MQ7gOhvVNyVTEtaQojVo/KQU0muhIVSxPLI6y6rWkZlFqb8RGviwtxCEuraLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlsiP/69m6J216rSubLQfI9RGOwdWB1JsuaLhFoZSNA=;
 b=ntv7k0ZD53c3/ISEJjYlp7eIh+CC/bnFslC2F9fiQwl2cRW/EXZg6JhWROY15A2fPXih0Q50ntFyE/98Gu1SQbLVbqsbQoGjI+lZyS7WohfjAKl7Zv5/IPPI/3k00NMkPuE6xHO0BOguz1FHYXJNW+Q4nW0oUhCaIqcBDSTTwwA=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSRPR01MB11678.jpnprd01.prod.outlook.com
 (2603:1096:604:231::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 09:25:32 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 09:25:31 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>
Subject: RE: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Topic: [cip-dev] CIP IRC weekly meeting today on libera.chat
Thread-Index: AQHcItiU2bpZ2vkRY06S34qTK+kl0LSNting
Date: Thu, 11 Sep 2025 09:25:31 +0000
Message-ID: 
 <TYYPR01MB1513246D4B21C8C64DB256282B709A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: <7e64c5a9-ed92-49c0-98d6-18197ba24748@siemens.com>
In-Reply-To: <7e64c5a9-ed92-49c0-98d6-18197ba24748@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSRPR01MB11678:EE_
x-ms-office365-filtering-correlation-id: d6ac27f3-148a-4335-620a-08ddf115277a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: 
 =?utf-8?B?NmxaQXFZZ0NWbSsrZHk1c1RXMkR0Nm0xSEVyTnJQZDhpb3lWOHFDRC9RWXEv?=
 =?utf-8?B?NUQvR3RRVlBsam9yOWhJUHpVUE4zYTNoQlN5U21qKzkvUUhsS3hqbWkyQ3E4?=
 =?utf-8?B?c01IY29MdWFBUDc3cHFDSHV2d21LZ1lmU0JUeVZzN0cxK0hrNTEzamIyYUYw?=
 =?utf-8?B?LzczTWMvZE5kNzZ1VmM4KzdDcVJ4ZFY2aUdFSkZPS3dYV1JyY29vNGsvbFps?=
 =?utf-8?B?SlhJVG9LZkM0UnRqYTZJWTdNNHhiVWY2bU16TjNJbVhuSzkwUGtGN1NvNmpy?=
 =?utf-8?B?S09oYlQyMW1KN1ZJdWM2V2ZEZUx1VVFzZEhQWnhXTXpkZTV2S2hMVm5DSVhl?=
 =?utf-8?B?T1EwZmFHM2J2TStuSWdrQlRyOGl4QzZTenRxT252bFgwN0g4ZmlSSkdHZ3lW?=
 =?utf-8?B?dDVMZEZMZVJ4QlJtekRJK2xWRGdWUTVQeUZ4OUQ2N1VlUnNCZmZHcW03OHBo?=
 =?utf-8?B?THNMdXhGWDFMbmNubWQrRTdHVEtXcTBmY2FFNTZ4WitMK0pZMmVWbDdDZWFv?=
 =?utf-8?B?dFRpeENqdTlLMWMzdTQ0MWtrVmlkbC9PdVJSUHlpc21aVnQwb21ZdUV1eW1m?=
 =?utf-8?B?Z3k2REcyL0hqempybWd4UGlpbzlEWmRIRDNGa3RDQ3JZMVZ2TXk5MXBhWjFW?=
 =?utf-8?B?OTI0aEp5WVp5c2VvMEJsaGJKM1VrRFFVMHpCOThoTmtzU1VLeXcwVXl6Z3ZC?=
 =?utf-8?B?ckdOVTROcGcwUml6SjM0RXpVU1MzL0wwOUozeWJ1M21nVCtQdXpoZHN1ZnVV?=
 =?utf-8?B?bDNpUk16ZlJpbjFLaDZBNFNnL3NWUnlRVFVHRUIyaHk5cHZ2VXo3WVZtWFJ3?=
 =?utf-8?B?ZUIxcU1vbEx4NUkvamRXc2t4L3hsRTBOb3d5RHNLRG1mcjR3OEtaZjQzR2hO?=
 =?utf-8?B?NWdiWVR1akdLRnN0SUJVMXFoeXJ2M1h5R2RoallWeGQySlowTnJQekE1RXFq?=
 =?utf-8?B?bCtLTHI0USsxcGdMM0J1ejF2MDRoSjBQN1BVVzBMajFKMVgyZ3pwVFA3Zll2?=
 =?utf-8?B?Z2p1M3VEMW1YYUMvWEtMWGhZYitFek9vRDYyVWluK0VobW1lUnVtNHZWLzFP?=
 =?utf-8?B?TVRuZU9HMjdueUNSeDZWcnVNamxZa3dQRjBqRmcwSWxDVXRNSUI2UVVoZTIw?=
 =?utf-8?B?QmQxeWg4cE9EZEl0OVRSaGZkc0hEcVY2OXJ5aGhaVmNWbWhncXI1TDVrSnJr?=
 =?utf-8?B?c0hOaVFaN3BTdi9LWU0xeGhuZ2pOemtwSmVUWjRkZ1VmYTJ5aUFob2xkaTI2?=
 =?utf-8?B?Q0cvWjBrdlNkdHN4ZHRTV0h4THVJSUJJdDBRRTJSOEhSUkhXU0QvL2VBSHht?=
 =?utf-8?B?RXdES1RVUElZRE1YeW1sNmxvTXVRbmh3c0FaeThSS3d2WmMydTlHVFlodU1l?=
 =?utf-8?B?Wk5KaVY5NkNXNlRnNjhIMFYzMmpXZktNNlQwcHlzUXBLSjR1UDZYYW90bm9I?=
 =?utf-8?B?MGVidCtpYW9vdS8zdVNhWWJrS3ZIT2U2V1F4bU1WRXpxNi9xSWx0Ri9DQkdI?=
 =?utf-8?B?K3RjVzNWdGRJNTg1M0c4MCtXRkNmZ2tuQkpMVmp4ZStPQStZbmk4K1U3RjVC?=
 =?utf-8?B?Zy80c1pkRDh1eUxURFlObDlDczVrbVdvaU1mZDZjTGpySFBKbmpyS0kyVk5R?=
 =?utf-8?B?bVZKRVV3a0M4Y0YwTnBDZFh3TSsvdzd2V0o4bm8zOWtZOHEvWTltN3JQOTdy?=
 =?utf-8?B?eWU2TVM4RUloaFllZThFbnhTdlFTSXhrMGRpYWExdmRjNnNCd0RSRHo0cjRH?=
 =?utf-8?B?VXJpa0tnZTM2UUN0b3k0ek5WaG9USmRYK2dUMWdOSWhCU2FGYWNEbFhSVHJK?=
 =?utf-8?B?M0JyY1BHS2U2eGg4aUs1MFl3RGVtOWZJMDBlaXBHNHlSY1UzbE10WHdSa1do?=
 =?utf-8?B?a0tRbTNPdWRNNDBGOFZYdURTaU9JNDcrQXZrMVYyV2JSMERGd3JDdWx3ai9M?=
 =?utf-8?Q?WfEwdE1dSYs=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?WUhrdGJaTDJFMTlucG9qaXFFUGpuWFpDc3NZWUxuZHZ4Zk9KVW83YWQ3amI3?=
 =?utf-8?B?MUg1SGRiNnhyTmJnWkRyMUppakMwcThKNElsMFRxamtWT2x1VkphQm1rK0cr?=
 =?utf-8?B?c0FPRHA1WndDSlN0Rzg3dUF4WTlwTkpZNlhVT3dMWDVkUHdmb25TODhCNERD?=
 =?utf-8?B?MFlrbFJERE9oWHdXRlE3RWNkZ3ppRUluNy96WDFJc2p5b3VhWUdpc2lJYWEz?=
 =?utf-8?B?R2txUmRIdW8vRUYvQWxZaGtFTTF3ajFoNTZoa3BCL2FuWWRGNlE1VkxnOFRk?=
 =?utf-8?B?dEplZFJsUkxRVmM2WG9iWWFhU010RDl2dFhOTGQ2OEpOUE5sWjd1ZFNaQ082?=
 =?utf-8?B?SnB2aHdtRCtqMjF3dEo0bjZxNVJJcmdvQ3NKUXIybWtOZGVoeUFXUE8zVU5z?=
 =?utf-8?B?bEF4N3NlNTE4NEtkeXVjcWE3MG82ZEJJZTVKRGNiOEhiYS9hVTk3Slhzay9J?=
 =?utf-8?B?ajlvbEJzZ25VcnFXVGFaRHNSL3dtbWUzOHdNbTBWd01SVmJaSWM2V2llKzc0?=
 =?utf-8?B?eXlvcVd4cWFlRDRHQ241ZTNhK3pHS2N4RG9EckJtTE1JeFRLZlluTGdkbmp5?=
 =?utf-8?B?NDJZbUNjMGNXRUxLUTBHZkVMWG9tVVlqRmNLckVydW8zV3UzUEtkSlFNMHhy?=
 =?utf-8?B?bTBXcituNmZ0Vm4rZFAyTzUySlhkeHV4MTArRGV2SVV2cUtzSFN5T0xhRW42?=
 =?utf-8?B?c2hCWVkxaG1RRGhKQnZqaUV1ZlZJc2UxcUpLYnkrcWVJVjc1V0M4VEl3dTk1?=
 =?utf-8?B?dUZ6UjV6ckhrb21OVVRtVnU0aHNXelBjVXd0UDVadk9CK2dJTXBNY2wxWHRp?=
 =?utf-8?B?anZzTE5uSkVNTXdNa2NZUEhpdi8zU2FrSkVOaDV0dzB5WjRsTW51cGRZc3g0?=
 =?utf-8?B?c0UxUENlbldXNWtlY2ZKTFZFbmsyLzNtOXdsaEU1bnc1NTJ5MTJwblpUZlY3?=
 =?utf-8?B?eWZQR1dIeTBIOFZ3bFg0MkJrTzdsQlh3VHUxRXBKbWxwNkx5T3VLSGV3SlVS?=
 =?utf-8?B?clhIMWJFamJDa1dySFViTWxVZHR0SHhIUzk4M2pLZVYxOVhWR1MzZ01UNkQw?=
 =?utf-8?B?MTVTb3ZBZm1ibHhLL0QvN0Nic1pObzg1SmJaQVhrZmJ4MUtyaHlDZ0Z1cmFR?=
 =?utf-8?B?OGt4RDE0K3BBWW1TTDNMeU1HU1ZTL054OTBHeDlXRWpSeVlVRzh1L3lGbkZZ?=
 =?utf-8?B?UGk3Z3NVMlVrMlRLaWVYa2l5RnZvbXBIdVZDQ1RudzRranVmNWxaZFkzOEt0?=
 =?utf-8?B?NnpmL3hHNERYUjZmQVJ3aXNhT3g4ME5vZkVsRFp2MEJEZmZQR2lNQ2FabzJV?=
 =?utf-8?B?c2xhdHhZMDM0SHBaYmdlaHpYNy85NkV3UCtPc0J6dERJLzM0TDVLcnJKdEx1?=
 =?utf-8?B?Tlk4MHgvYm1KSmtuTWE0cnQ2em1zcU8zb0hPWFo1a1c5S1h2OGtNSTJONDRC?=
 =?utf-8?B?L095V2UreG9UQmJMck9EQ0NMTU55WGZTR0ZTRlQ2WDBkRnppTlZOK0tacjYr?=
 =?utf-8?B?eGFXaFJSTzdiOVczQitGc29lU1BnWDBGbjZLUy83SkpDUjBNekRvdmM4YlRy?=
 =?utf-8?B?VEgrZ2FsR1pvN0ZTTEovdU9hNGovZHpxZTdmbTg4NjhtbUNwRytOOENvUGth?=
 =?utf-8?B?d0Z4L1dDTlgwdDE2VGR6TGJ5VGd2dnZrb3N5bDAxUnZlZ2NkZ0FPSzJFZ0tV?=
 =?utf-8?B?b2ZCdlpwaU1kZDR6UFB3VTF4ZS9NbUxqcjR4Q1VUWW5uUkt1OW5xRWRiYmw0?=
 =?utf-8?B?eG5HRGdqd1dHdDJhOHJMOEhnRGFSczYvaStYNkJuYlNnRkM1cWIwY2hmM3kw?=
 =?utf-8?B?NmRxanV1VXFiekxibnlWTjhXMThONHo3ZkFFdExaNWZBNDZxMlZXRlJwZ1kz?=
 =?utf-8?B?eW9tYTNKVUlyZyt4VkNReUU5OG5XWlFKTjFpaXlhajlwVVV4REp4Sktlb3JJ?=
 =?utf-8?B?VHcyYzdLOFpRdXo1c1lPK0dYTXd4REd3Ynk3a29xWVNnRXFYdDMrMmpXaWpl?=
 =?utf-8?B?TExXNzJiN1RYQWZTTStFTHRWd2xBZWp5cllFd3dSVXhaTXpFU2FKZFh6bVAx?=
 =?utf-8?B?NHUvTERFUzlBbkJpR3hTVjBOYnhaVHRjTGM5c0Z1UENpR2I4TEdNNjBiOGNO?=
 =?utf-8?B?VkhJSTZUMGQzV3lhc1VJZUxNNFNNMW9rNmRzaE1HdVIrZkMvQ0hmMXQrb3lB?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ac27f3-148a-4335-620a-08ddf115277a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2025 09:25:31.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZrzCZKAEDa7fexjLDExkNtDEBFSwHTMMc9Rk1y5afJnSD73Oqi6wg4jvLvpzihi2mlAf1Q5LS5YEvpBlXddtra6+2iqL6BRkK4pJn9poFqg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11678
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 11 Sep 2025 09:25:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/20038

SGVsbG8gSmFuLCBhbGwsDQoNCj4gRnJvbTogY2lwLWRldkBsaXN0cy5jaXAtcHJvamVjdC5vcmcg
PGNpcC1kZXZAbGlzdHMuY2lwLXByb2plY3Qub3JnPiBPbg0KPiBCZWhhbGYgT2YgSmFuIEtpc3pr
YSB2aWEgbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFNlbnQ6IDExIFNlcHRlbWJlciAyMDI1IDA1
OjU3DQo+IA0KPiBIaSBhbGwsDQo+IA0KPiBLaW5kbHkgYmUgcmVtaW5kZWQgdG8gYXR0ZW5kIHRo
ZSB3ZWVrbHkgbWVldGluZyB0aHJvdWdoIElSQyB0byBkaXNjdXNzDQo+IHRlY2huaWNhbCB0b3Bp
Y3Mgd2l0aCBDSVAga2VybmVsIHRvZGF5LiBPdXIgY2hhbm5lbCBpcyB0aGUgZm9sbG93aW5nOg0K
PiANCj4gICAgIGlyYzppcmMubGliZXJhLmNoYXQ6NjY2Ny9jaXANCj4gDQo+IFRoZSBJUkMgbWVl
dGluZyBpcyBzY2hlZHVsZWQgdG8gVVRDIChHTVQpIDEzOjAwOg0KPiANCj4gaHR0cHM6Ly93d3cu
dGltZWFuZGRhdGUuY29tL3dvcmxkY2xvY2svbWVldGluZ2RldGFpbHMuaHRtbD95ZWFyPTIwMjUm
bW9udGgNCj4gPTkmZGF5PTExJmhvdXI9MTMmbWluPTAmc2VjPTAmcDE9MjI0JnAyPTE3OSZwMz0x
MzYmcDQ9MzcmcDU9MjQxJnA2PTI0OA0KPiANCj4gVVNXZXN0ICAgIFVTRWFzdCAgICBVSyAgICAg
ICAgREUgICAgICAgIFRXICAgICAgICBKUA0KPiAwNjowMCAgICAgMDk6MDAgICAgIDE0OjAwICAg
ICAxNTowMCAgICAgMjE6MDAgICAgIDIyOjAwDQoNClBsZWFzZSBhY2NlcHQgbXkgYXBvbG9naWVz
LCBJJ20gYXdheSB0aGlzIHdlZWsuDQoNCktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gTGFz
dCBtZWV0aW5nIG1pbnV0ZXM6DQo+IGh0dHBzOi8vaXJjYm90LndsLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWVldGluZ3MvY2lwLzIwMjUvMDkvY2lwLjIwMjUtMDktMDQtDQo+IDEzLjAwLmxvZy5odG1s
DQo+IA0KPiAqIEFjdGlvbiBpdGVtcw0KPiAgICAgLSBzdGFydCBkZWZpbmUgYSBDSVAga2VybmVs
IHRocmVhdCBtb2RlbCBbUGF2ZWxdDQo+ICogS2VybmVsIG1haW50ZW5hbmNlIHVwZGF0ZXMNCj4g
KiBLZXJuZWwgcmVsZWFzZSBzdGF0dXMgWypdDQo+ICogS2VybmVsIHRlc3RpbmcNCj4gKiBBT0IN
Cj4gDQo+IEphbg0KPiANCj4gWypdDQo+IERhdGUgdGhlIGRhdGEgaXMgY3JlYXRlZDogVGh1IFNl
cCAxMSAwNDo1NToxNSBBTSBVVEMgMjAyNQ0KPiBsaW51eC00LjQueS1jaXA6IGludGVydmFsIDMw
IGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJlbGVhc2UgZGF0ZTogTW9uIFNlcCAgMSAwMTo1OToz
MiBQTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRhdGU6IFdlZCBPY3QgIDEgMDE6NTk6MzIgUE0gVVRD
IDIwMjUNCj4gICBTdGF0dXM6IE9uIHRyYWNrDQo+IGxpbnV4LTQuNC55LWNpcC1ydDogaW50ZXJ2
YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBTYXQgU2VwICA2IDA5
OjEwOjMxIEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogV2VkIE5vdiAgNSAwOToxMDozMSBB
TSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcDogaW50
ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBNb24gQXVnIDE4
IDA4OjM2OjA1IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogV2VkIFNlcCAxNyAwODozNjow
NSBBTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNC4xOS55LWNpcC1y
dDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBNb24g
SnVsIDI4IDExOjQ3OjQwIEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogRnJpIFNlcCAyNiAx
MTo0Nzo0MCBBTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4xMC55
LWNpcDogaW50ZXJ2YWwgMzAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBkYXRlOiBX
ZWQgQXVnIDIwIDA5OjU0OjQzIFBNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogRnJpIFNlcCAx
OSAwOTo1NDo0MyBQTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGludXgtNS4x
MC55LWNpcC1ydDogaW50ZXJ2YWwgNjAgZGF5DQo+ICAgbGF0ZXN0IHZlcnNpb24gcmVsZWFzZSBk
YXRlOiBGcmkgSnVsIDE4IDA4OjE2OjI4IEFNIFVUQyAyMDI1DQo+ICAgbGltaXQgZGF0ZTogVHVl
IFNlcCAxNiAwODoxNjoyOCBBTSBVVEMgMjAyNQ0KPiAgIFN0YXR1czogT24gdHJhY2sNCj4gbGlu
dXgtNi4xLnktY2lwOiBpbnRlcnZhbCAzMCBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiByZWxlYXNl
IGRhdGU6IE1vbiBBdWcgMTggMDg6Mzc6MzUgUE0gVVRDIDIwMjUNCj4gICBsaW1pdCBkYXRlOiBX
ZWQgU2VwIDE3IDA4OjM3OjM1IFBNIFVUQyAyMDI1DQo+ICAgU3RhdHVzOiBPbiB0cmFjaw0KPiBs
aW51eC02LjEueS1jaXAtcnQ6IGludGVydmFsIDYwIGRheQ0KPiAgIGxhdGVzdCB2ZXJzaW9uIHJl
bGVhc2UgZGF0ZTogVGh1IEp1bCAxMCAwNzo0NTozOCBQTSBVVEMgMjAyNQ0KPiAgIGxpbWl0IGRh
dGU6IE1vbiBTZXAgIDggMDc6NDU6MzggUE0gVVRDIDIwMjUNCj4gICBTdGF0dXM6ICpMYXRlKg0K
PiBsaW51eC02LjEyLnktY2lwOiBpbnRlcnZhbCAxNSBkYXkNCj4gICBsYXRlc3QgdmVyc2lvbiBy
ZWxlYXNlIGRhdGU6IFR1ZSBTZXAgIDkgMTE6MzI6MjkgUE0gVVRDIDIwMjUNCj4gICBsaW1pdCBk
YXRlOiBXZWQgU2VwIDI0IDExOjMyOjI5IFBNIFVUQyAyMDI1DQo+ICAgU3RhdHVzOiBPbiB0cmFj
aw0K

