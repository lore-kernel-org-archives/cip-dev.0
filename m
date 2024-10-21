Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3581D3E1BE
	for <webhook@archiver.kernel.org>; Mon, 21 Oct 2024 07:32:06 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.18])
 by mx.groups.io with SMTP id smtpd.web10.40973.1729495900837595316
 for <cip-dev@lists.cip-project.org>;
 Mon, 21 Oct 2024 00:31:41 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=HB2NnY6k;
 spf=pass (domain: renesas.com, ip: 52.101.229.18, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cNq0vLzNpegY6Apsm2kshA6mRWJtabGYph22fXUe7XjU464CNp0io5WiF/fnCx2m+YvUhCiwGXg9gwGtyevn3Gufts67LURX44xNJ0fOZ6nXeVSJUxU380kizuNyT/q6KwrmBpn304HwlzIQpyfMnISZuqTj6GQ1KuJcQel71WPKlW1mwNBbXnZeqUBuvbnC5S4d7NhrTMZnrpAKT3xLZS6edn7gC39qskG53OUYi/IxU7ys5CQe8zIYi/VEY6IykKwVbK0dU5EAAXpEvUC0lxV11XOKBhciblzJnbc2cczAvQZrBmuQdQEoRBdXB39CfCPYfa5kZEriL9kcdesexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bnXkKqVtaBKwIF8qUUoM910zUtx4tORHKEMsX3K0/g=;
 b=dcA1WBULzZs09LIxLfFH+sCLfdhbqE1VZ8I4rs0PhPgZn1AGhQa9i/L9uqvhAQZtfK4y2rfWuouRQYnWcXnEcVe3KNq2MU8mcb6d7nRDO6JQkaTVA4X9WDFDevAP417JYlFsw8ThKM0qMW1An+1aGaG3VDne9YsqzcsUQuZ4NXycnsqB7BLo1HruiRjwaJIJiTjug99eDiQ1iI9hX++XxPN35hypGQLB6kgUmMkjN9LA6YVUlUQKibitg7dBo3/L7lmwNbkVYw8b5qTkLgq9ORG80m/czAjzp4vKliht+Mvdsjh6Hh+uyNIpwyDCTT4wBK9VTO+IaueAozOMq0QoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bnXkKqVtaBKwIF8qUUoM910zUtx4tORHKEMsX3K0/g=;
 b=HB2NnY6k13rpa81mWY/OaqcejFSsKvyRWp7Sbrr60xfWV44wcqkhTL5dU6BBat4qZtJ8LVN6HETh4MBFEaIxZ9tlGh5wL6QXU0ji1sVKHVaZVQFzhBEoAZnCJCoixW54yZH2Gv96GuJPbNw8jxAXSLBYTnNGFxgiSIpEKQ1uOkc=
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com (2603:1096:405:fc::13)
 by TYAPR01MB5897.jpnprd01.prod.outlook.com (2603:1096:404:805b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 07:31:35 +0000
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303]) by TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303%3]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 07:31:35 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, cip-dev
	<cip-dev@lists.cip-project.org>, Sai Sathujoda
	<Sai.Sathujoda@toshiba-tsip.com>
Subject: RE: cip-core: Something fishy with qemu devices?
Thread-Topic: cip-core: Something fishy with qemu devices?
Thread-Index: AQHbIfrGAI1mkl/YzEexBUcObiQ0JLKQ0VWw
Date: Mon, 21 Oct 2024 07:31:35 +0000
Message-ID: 
 <TYYSPRMB0010816199991F38C90CA81FB7432@TYYSPRMB0010.jpnprd01.prod.outlook.com>
References: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
In-Reply-To: <88ea7ac6-a855-4b2e-92ae-0698a91928d1@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYSPRMB0010:EE_|TYAPR01MB5897:EE_
x-ms-office365-filtering-correlation-id: e60f9e6c-6279-4f23-5963-08dcf1a26479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?R1dRaWI4WFB3TkovMU1QVFJ1VUJkL1ZUemVzVEt6bktZWGltRi91d2p0KzQv?=
 =?utf-8?B?Z1psQTlicUVNL2k1Q0ZwYVJ3Wm5CalduRGJZbDlSTUZoYVJuK0VZK1AxVWdK?=
 =?utf-8?B?R2xFa3M3cDNBYWFHQzkxVS93cU5CYW9oeW4yNHB4QnVON3NubEdyRVNKdWxS?=
 =?utf-8?B?dTFHaDNVaERVN0pCSWxSRUhEK2NxamZBVXk3RXJVTXhqSHI4dzhkeWJlRThw?=
 =?utf-8?B?OGJoZFQzVVdCMThHUlFWSTBET09uK2pjN2JNcG9aRFhCT3c0cEo1Wkd0cUlP?=
 =?utf-8?B?Y2x2MVRjOStBeTZMQ0l1MGxuUnp0cklKa0FnM2pZS1VMM1B3dWpzeEc4UllE?=
 =?utf-8?B?b0ZUb3hNWWFjRlR4VVlVMXZDS0k2MkZvWWU2dVhrOGlGR2xkZkY1a1pEQm0z?=
 =?utf-8?B?U1dEeit0Ry9WeGR6bzJZN2JJU2xESE1Ta1NQcE1EdzdhVDNXbFZBZnc0Z1cv?=
 =?utf-8?B?eXBaM09Uaml1elBMcDNRaVE1enNUOGRqcHJlSFk0cHVDY1lPdkRYSDhMTGRy?=
 =?utf-8?B?RFhpTEdpd1ppNGFYMVUzejQ3VldROCsxcHRSOFk2b2hxRHBBMkdzS0V3NkhG?=
 =?utf-8?B?cjRRMXlkeTluNVN3TnVibXVKc3M1MVdQNmhDWUVJUVBDZk9XbjVWeVZTSDgy?=
 =?utf-8?B?czU2N201QUlEbmEzS0FnVGNFNEQxcTZFbys0SkN5NDJwbnpIMnh6ZmNjNzVx?=
 =?utf-8?B?SVFvUkVFdVlFTXgvM3IrWUxmSzhVejJ6SkdXMjB0VWdCT041Wkc4MjZCalE5?=
 =?utf-8?B?S0duZ2JHb09idW83Z3ZFYkIyTnoyL3JCbmVQaGxpN0pHdTQ5cDkwYWcrQzZr?=
 =?utf-8?B?Yit2VkZxNmVZQlRyNE5xRGgyMXQ4UVdDdmovVWdlbmpQamtib0xMZ3UyNEpx?=
 =?utf-8?B?alBaRE1ON0dZZlFBQVhIbFZMWk83UnZKd3ZuOURUWUdYYmNiVnAyQSszY2Q4?=
 =?utf-8?B?Zk1DYWhUV1ZTeDVwTXZpVStzUDcrUWs0TmxaR3NVbWlHY0lXR2kwMjdSTi9C?=
 =?utf-8?B?cHllNVNNL20vcXdhNHp6M1Z4S05POGZjazEvbmRlWHdOWFNYYW10Vit6WEJR?=
 =?utf-8?B?S0NjTFlOUFRIR2pxVVdEWm0vdHQxQjlBckF5cGJLUjJ5NDBkcVU4RFdiT0E3?=
 =?utf-8?B?YnVQaXRWNE1EUUVkZVdqTlhDTlZDcm9qSFNIbVp3OVNXSHhGVWtHenlMaE5Z?=
 =?utf-8?B?djliVVB1eTA3Ym9Id3BDSGJJVk1vOU1WbGRnMWxpT2RNQTJBQUpuUG14bnhQ?=
 =?utf-8?B?cGpNWFBoRlB6TVBBMDliZWRBWFRQZDJram5Uam5pVFdwU0xzek1IVHdnT25U?=
 =?utf-8?B?L0xsMGU1UTUvTkxvVFNHVGg4RkpNREtVcVc0dTdlQWpKNUFJem9mSElkRk9Q?=
 =?utf-8?B?blNEdHRjNUwxZERwVk4xL2tva2hCZklFclFyalNKeXdwdkdNMlNpdGNMTWU1?=
 =?utf-8?B?S2JZUTd1Y3hMOW1ROFl5T3B1ZzlKSktjVnFZZFNvdXk3MmFyMUNVWDJ0SDJK?=
 =?utf-8?B?ZHFtN0FERDVQQVBRazl1KzBNOXN4VWhxWTNNY2hyN3doY1dwZGlVRmR5bEM5?=
 =?utf-8?B?T1E2OVBqVGFqSDNqMzdFV2p6RlZ0WS9CNHN4ZFB1RXc4R2dQbGk0MU5pL0hN?=
 =?utf-8?B?M2ZWN0oxT3N3cG1IcGwxZnQzTGF3SmdjWW10NDBQZHFoM1JVUDNjQkNuTjdX?=
 =?utf-8?B?S0h4QTFVYzQvTktZUlJDZ0xuSW54bTlaZGsyUk1Hc0t1TCsweEkxQ013R2hk?=
 =?utf-8?B?MnFvd0VJT2M1aTBjbWI4QVJVWFI0cWN0RUx0NnZOd1lrWDNZT0d0WlQ1N1pY?=
 =?utf-8?B?YVVOckRPcURFZCtKbXYzZi90TlRpbm9KZzdpL2xzalI5VkY0R3BhS1daU0l4?=
 =?utf-8?Q?/HfUwAYo4qH7V?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYSPRMB0010.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?c3c3dm9UWWhXYkN5OG9YKys2R1NhUkdvUmZqZnY5TjAvbGZneExENWZUUWtY?=
 =?utf-8?B?SG5uVWZjdlBmckpXM0RoZEx6TkFVcHlHelh3dzgzaUJzUjZ0dEhqZ2k4cVdV?=
 =?utf-8?B?Qyt5TjJuNS9XOG9BaGNpc2JMOWZUV2s4dEZMWnJ1bE1DbVFLeXdlM3VQRUxI?=
 =?utf-8?B?ZlViMzFMMDJMd3k1d200YzRJMXN0SEw0cHZUemYxSXhTNVp0NFlibHc1dm5Z?=
 =?utf-8?B?czJmR2RIR3V0WWlSQmJZM2JnZENZSEZwUkRMMXBudHo1eUtUY1F4dG1qOVRs?=
 =?utf-8?B?STVuMlBvSm5OcmdFZktoVGxvZTZ3eDh2NzdjSW9HK0NLN21PUUZLeGFKblRq?=
 =?utf-8?B?TVgxbFFuNzVkQ29HZGsyczVRNXRnZ2xjSHUzQmdCREVGZEg5L3dKeGFleGlO?=
 =?utf-8?B?VUZSaG1mRW1zUjljeHpnMkZBSy9Ob3N3YUVDak1QYXZ5MWZyS1hEVVRnc0lR?=
 =?utf-8?B?aDR4NTVaUlNaZTNsUFJzczlXdlJRUEViMFRhRnZ3WFB2SlNsVTRXS1RKRjVC?=
 =?utf-8?B?Qlo3UHErT2FDbnE5cnBLMjhFMFlWMFNmVCtBQUM2clZRY2ppQ3YyOWxYQjVt?=
 =?utf-8?B?ZWlYUnNVL3drSU9hbmMvaExadDFIcWJ5K1l3bElSM1NzVHFyZjhtdldxaGNs?=
 =?utf-8?B?Yk4wQi9Db2NKRk1IWVhwWElLd2l4aWpGcFJKeEFoclhuLzlzaVVJeHUvcVdI?=
 =?utf-8?B?bVJYR3YzU1dlSndQUzBoaUVYeUFkVjhWTGRLbnZOclFCTmk4cDc4ZysyeDYy?=
 =?utf-8?B?K2dRMk1hNlpSM1lMaEJ1VW1RWHQ0REF5VnY2QTNpVWZvaWFUeEUvVDhxOFRj?=
 =?utf-8?B?ZDJBcEMwTVlJNXlvNExWOGMxeFNVWWM4UWRIVEhUYkNmaW9GdEoyc1AwYVR4?=
 =?utf-8?B?b3NhMjYrekVTcy8yYm9SRFdwSStZQTBmeE85Smw5dXpXYXJrUUFsbjQxcHZW?=
 =?utf-8?B?TmlZdHdoVEtRQmUzNGtTNHo4RENyNzFMVUNGbFdsandoUFYrbjNkdU45TndQ?=
 =?utf-8?B?a0NvU1hKbVF3d3lCU2JZdzVITG9QVVh1b0htL0tSZ0FieVR4U0RqbGxwamk1?=
 =?utf-8?B?dHAzK2s2WHhRaTlIOTMvVzVwdmd1ZG1ZdDBnNmpIamlic3V6YVFBOThaWktC?=
 =?utf-8?B?NHFlYUlnTnZmTG9qRGR2a2g5eUYzbTVWKzc5bmtRTVRmeTl1WTByeTJzTUhQ?=
 =?utf-8?B?OWE3c2N1NXZTSnlOZ25TR0JNeXFFanE0OURyVzlwT21xOENqaTAxSTdrajg4?=
 =?utf-8?B?WGw4WmsrRTdwWElXcEI4SEpqWWlqUWM4TVpLYUV4eHVmSnczTXpCakNHTS9s?=
 =?utf-8?B?QWJONVBIR0lxWkZiVi8vYUlPL04rcWE1RzVqbkJLM0ZsUjd4NnhBd1IrZUNZ?=
 =?utf-8?B?ZFY1T2VIY1l1T3krcVJrSlRlQ3ptVUVqL0U1TWVZVmlhdjhvZ1hybHpFanov?=
 =?utf-8?B?YmFEcldramFoMjNCYnJTT3JYcUFXYXNUS01YU1MvRGVQS0o4VzJiNm5yU0NX?=
 =?utf-8?B?dkplTzJUdVVFbUVrelR6SlU1UjdWOEl6TmNQeTE0NlJndE9sbDZ1bDZQWjB0?=
 =?utf-8?B?NzA3Y0tNTW9kTGdqcXhYVlpCRmRMaWlGQVlOQ2JuWGZjUEhNRU5jVVdvUGRu?=
 =?utf-8?B?TmZnWTNibWw5Z3ZRcTZ5OEVIeXBteDdDRURFSk85QnBkNDF6MkFYVURSU1Ba?=
 =?utf-8?B?N2tzYTJKZVZyZG5McytVYThsWGsvNTZjdmljYkpKTER5RHBXU2VsenRBeTlN?=
 =?utf-8?B?Z3JxVGtHS2pwYkIvTmgwRzQyU3dlaW9pUW94TmFOQnJrRkZYeEdYWEFQRWt0?=
 =?utf-8?B?NEIweWhoaTlGbDc5b3l2S29MV3RLMGpnOFlMZ0JGYlNKNGNrMnZIUGN2NVJo?=
 =?utf-8?B?UlkwOXEvaEE3TkJmOTl1eGlHYy9ZQkxxNU9KY3dOT2tnMUxLYTg5TWgxMk9k?=
 =?utf-8?B?NnZnNDdmR3l1dTJiYVAzeElJaTgzZk9kd1RCUnRpSm9ITWNwTHhGbWorSkdT?=
 =?utf-8?B?U2RwZTFReVF4ejhuRTRvQWpQN2UydmFlNjVQV21RTG9YRjZyaEhFRjgrZUNw?=
 =?utf-8?B?RXd5aWx1Mi9yRHF0NmlEUXVHYkdaMEF3VlhzS1oyZ3liaTBmRmc4VEVpdmti?=
 =?utf-8?B?Z3UwN2YxWFdwaUFQUXRyUnRnZHFMTlhrRVJYN3JXcU43WW5NM0xSYTY0NzNH?=
 =?utf-8?B?aXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYSPRMB0010.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e60f9e6c-6279-4f23-5963-08dcf1a26479
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 07:31:35.2246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YF7gop/lFALL6J0w/jt/NjWdKpn5hkMLz8kjFNyRcJQwS/6NEKheLbPOwBkTGXsHmpncJr68j6FyVUO0BaxdM6zYTnQbbxTysJrdi7Nc2qQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5897
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 21 Oct 2024 07:32:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17055

SGkgSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IFNlbnQ6IDE5IE9jdG9iZXIgMjAyNCAwODo0NQ0KPiANCj4gSGkgYWxsLA0KPiANCj4gSSBoYWQg
Y291bnRsZXNzIGVycm9ycyB3aXRoIHFlbXUgdGFyZ2V0cyB3aGlsZSB0cnlpbmcgdG8gdGVzdCB0
aGUgbGF0ZXN0DQo+IGNpcC1jb3JlIGltYWdlLCBzZWUgZS5nLg0KPiANCj4gaHR0cHM6Ly9naXRs
YWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzgxMjk4MTQ3
NjcNCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2NpcC1jb3JlL2lzYXItY2lwLWNv
cmUvLS9qb2JzLzgxMjk3ODY5NDMNCj4gaHR0cHM6Ly9naXRsYWIuY29tL2NpcC1wcm9qZWN0L2Np
cC1jb3JlL2lzYXItY2lwLWNvcmUvLS9qb2JzLzgxMjk3NzcxMTgNCj4gDQo+IEFmdGVyIGhpdHRp
bmcgcmV0cnkgb2Z0ZW4gZW5vdWdoLCB0aGlzIHBpcGVsaW5lIG5vdyBzZWVtcyB0byBwYXNzLg0K
PiANCj4gQW55IGlkZWFzIHdoYXQgaXMgZ29pbmcgb24gdGhlcmU/DQoNCkkndmUgYmVlbiBzZWVp
bmcgc29tZSBjb25zdGFudCB2ZXJ5IGhpZ2ggQ1BVIHVzYWdlIG9uIG91ciBMQVZBIHNlcnZlciBv
ZiBsYXRlLCBhbmQgSSdtIHN0aWxsIHRyeWluZyB0byB3b3JrIG91dCB3aGF0IGlzIGRyaXZpbmcg
aXQuDQpZb3UgbWF5IGhhdmUgbm90aWNlZCB0aGF0IHRoZSB3ZWIgZ3VpIGlzIHZlcnkgdW5yZXNw
b25zaXZlLg0KTXkgZ3Vlc3Mgd2hhdCB5b3UncmUgc2VlaW5nIGlzIGEgcmVmbGVjdGlvbiBvZiB0
aGlzIC0gdGhlIHNlcnZlciBpc27igJl0IHJlc3BvbmRpbmcgdG8geW91ciBhcGkgcmVxdWVzdHMg
aW4gYSBzdWl0YWJsZSB0aW1lZnJhbWUuDQoNCkkndmUgYXNrZWQgdGhlIGFkbWluIHRvIGluc3Rh
bGwgc29tZSBtb3JlIHRvb2xzIHNvIEkgY2FuIHRyeSBhbmQgZGVidWcgdGhlIGlzc3VlIG1vcmUg
KEkgb25seSBoYXZlIG1pbmltYWwgYWNjZXNzKS4NCkknbSBhbHNvIGxvb2tpbmcgaW50byB1c2lu
ZyBhIG5ld2VyIEVDMiBpbnN0YW5jZSB0eXBlIHRvIGdldCBiZXR0ZXIgcGVyZm9ybWFuY2UuDQoN
CktpbmQgcmVnYXJkcywgQ2hyaXMNCg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFH
LCBUZWNobm9sb2d5DQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg0K

