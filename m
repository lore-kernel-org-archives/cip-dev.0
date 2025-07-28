Return-Path: <felix.moessbauer@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280B4C83F17
	for <webhook@archiver.kernel.org>; Mon, 28 Jul 2025 11:55:37 +0000 (UTC)
Received: from GVXPR05CU001.outbound.protection.outlook.com (GVXPR05CU001.outbound.protection.outlook.com [52.101.83.44])
 by mx.groups.io with SMTP id smtpd.web11.79676.1753703733737812671
 for <cip-dev@lists.cip-project.org>;
 Mon, 28 Jul 2025 04:55:34 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=rNgTdt3x;
 spf=pass (domain: siemens.com, ip: 52.101.83.44, mailfrom: felix.moessbauer@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1t+nUAKvAzTcXCUQkCTH5UOdIgPqtgMV+RzrEntjq+VMcxI10BVSvdlBIIRJXLJrlat95xKBKyDu6WHK3I/BmQq4fXp5uRXaLNCM8EfOgWy80HHqXq85l+gj8x3zADWE4UvuzN2OAAAM7XbjJFN8aKAmcD+bVv8XkYFjBl91wfy6NqIvusFSceWQliDbd8BT7ZxViRqVmlzTYIQHOjp4Ne6wf75JmIe2b+/hx3O5HSy3bEhrLrjJGogcQB4hAY0AbAxeSeYlOSWrcCjUcYjMHxBdp+lTtso0/qdU3hklmMtgPfAbjCryskpxAGQGMsev0Od4SkW+UUUFc4jrE3kFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbxcNXRu0JFoE8njNiMY/bD5Pj65I/q50YrimTQGZ04=;
 b=rwuTarOiBoqT3wYgwanmK3R22Dw0lYe8ZMhPXUAbG80yDyKveRgZMOCihFWYg6YgaNknosZtFAlx8dJYB6lcYyxSDlBqMV5okwlB2k7FwJWo7GvLnViE4Uni3PbmA0Ka7HMkD1cjAtdVP7Sn1mldDbjbtQaO5v81V2fTXynkdtSBJ29nD0EuiojzkZV3MYXznmhvz9Kg32WtDCrRk3zau83UWLDb9KpPsFqbFTIhRXJx5CFDLc4GqRW8rSKbMqWghyJxOkHEDSsjUVy7b4aWph7DL01gcz3A8f2YcgqKadZ8O7N0j14HdRuF+fnN78mNVpg5nnQhLfn8B1DOm7Qxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbxcNXRu0JFoE8njNiMY/bD5Pj65I/q50YrimTQGZ04=;
 b=rNgTdt3xMCKO888chkhKg5MUBtNJDGl5r4ZSaQIOANSWln2BtjT3XhYKRCexua5Noy3wHbq5amf/7O8+cx+5vOBaSH6ZWWyuQK16ROBUr+pIXfX4z7wKH9N60QGkRdCQRkvpOuANlmM3VzGQCf8wJ3lZkBNxnrzpk2Ig60BL5RFQPNrpNhs24161CvuKsTXIuCW58uXACjGhKQAd88ztZ+k76MkPsT1AM+LW3VNWy2MrUVJ9RY8WInKH65lbTM5mjShjoDejdsZXNf06xbMxM70tVvc47WnJHuVJ2kh7dIxWPryxoQfTGfwqrLRStLc/7iyO4x838sUd/8LBl+zkwg==
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47f::13)
 by DB4PR10MB7447.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 11:55:29 +0000
Received: from DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe]) by DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8198:b4e0:8d12:3dfe%5]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 11:55:29 +0000
From: "MOESSBAUER, Felix" <felix.moessbauer@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>, "Kiszka, Jan"
	<jan.kiszka@siemens.com>
Subject: Re: [cip-dev] [isar-cip-core][PATCH] Switch bullseye-backports to
 snapshot.d.o
Thread-Topic: [cip-dev] [isar-cip-core][PATCH] Switch bullseye-backports to
 snapshot.d.o
Thread-Index: AQHb/TGg7Jdxtewr7UmuZRdm+FY6mbRHcqIA
Date: Mon, 28 Jul 2025 11:55:29 +0000
Message-ID: <d1df84334320653076c9e0d4f6637c29edddb42a.camel@siemens.com>
References: <d413c4a4-f672-4005-92ac-bb991ede978e@siemens.com>
In-Reply-To: <d413c4a4-f672-4005-92ac-bb991ede978e@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.56.1-1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR10MB6828:EE_|DB4PR10MB7447:EE_
x-ms-office365-filtering-correlation-id: 5302cf2d-354b-4426-d19f-08ddcdcda613
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|4022899009|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?Y3MvNkNwU2haUVgxYW9HM2NISzAvNHlXSEdrdHl5d0lNY004YjV1bGFNUVBt?=
 =?utf-8?B?TVZjUGJWTjAxZ3IydkMwWlUxSUwwd25xV09CYVBHNTZBSFVsa29IbVJ6Z1pk?=
 =?utf-8?B?azRvY2JmZ25kRHpIVnJFU1dYQnRGUy9TeUN0ZVlLTjkrSEhjWHVRSWJZMWZj?=
 =?utf-8?B?YXpRSHRka0pOK0t0a1lYc3YyeEltMVBtWFZGODhBOGYrUmZNUzBWa1ozMWhl?=
 =?utf-8?B?MWxPOXFJN1ZYVVcwRUs2akxObnFoY3FBOVlsVitBTFRuTTZncXFiM1ZVUnZW?=
 =?utf-8?B?YkxFNG5tNWxIMHB5TllmTndCdWk3RWE5cE5WS1JuV3NVdy9EQWxNaStGUUto?=
 =?utf-8?B?UkNKMEZ1eWhTSUZjbm5BRmZGdWt3aERnejl3S0RRZ1RWSWtMRXlGMnMvek8w?=
 =?utf-8?B?OUs3OFNLNEpQL1dOdHYvODRCN096SHBKQmRBWHBlbmlEaG1OL0Z3MDMyUWFC?=
 =?utf-8?B?VGtYUktiblRpWFlvZkRaTnJxSmJmM3FzMVdiQmFySElJSFE4b0l3c05VYWN4?=
 =?utf-8?B?YnphZ1dMUkliQ0RsVWZWVG1oNHg1bVdVTFUvNUkwZS9CU3ZBSWNNVkxlZ2tl?=
 =?utf-8?B?eUtNeEpKU2E2N0x1MUFBMWpxbk1tYms5N1RDUER5NHR3ZmdORGVqeDFlbWFI?=
 =?utf-8?B?RDdLb3FJc1ZZM0tVOXB2M0xNUGNZN0cvYlYwNDBGaFNWT0ExSlJvMjA4RVNu?=
 =?utf-8?B?MlhuOUNJYWthNXJvYmRWRlNQVkVQNUdKdkpvS1docTZ3MENsSGVRMVYrdFlE?=
 =?utf-8?B?MDRCYzNPOE01bDVzY2JiUGtTTGEwVW83ZTdSRE13d0hMbTVra3VDU0N2RE1m?=
 =?utf-8?B?K0RReGdlbGhhTXdvVURKZi9hTk02d1R5UGowV0g2T3JUK2MrSGh0Yy9CTGgx?=
 =?utf-8?B?a3FFVUdGK0VWaUNJQnNHZTJuNUZzcU5HbmE0SzM4REdRSFpvNzRRM3BtZWpJ?=
 =?utf-8?B?MGdMbk55a3NsbDVxRlAxQVYyL1FGbmhaMU5aaDFROGFWd0puRnNkclZiNWJl?=
 =?utf-8?B?cnRQM3JmS05rNHhLc2FraERsRS83WTFtZ3A2V0lXbVhwVUdKQWxLTGhBQUVS?=
 =?utf-8?B?OTF5Mm9jOXEyU3c2UzB2YkdjTUdQYU9STmJVM0ZjY0U5L0h4ZEhteVB6eW1r?=
 =?utf-8?B?enlyVUt0c0N4aktjcU1MZ0lwY3VZWk5CR3FXRVp6YnJ0NHZnNmZJQVFNclRV?=
 =?utf-8?B?eU1qM1g5bVZXd0x5MDErYlJqcTU1SjFKSHA0dUFOTkxNUnNsc0ZBZExJcHlH?=
 =?utf-8?B?YkIxcCt6aXFFUXErVEM4eFpHZVdjQitYOVhVYTQvUEVpQlJQcXpiWm9uTlJ6?=
 =?utf-8?B?WXE2bnRQbDhYZ0ZETzRZRWxkTDhWdXRNVWhFdGlQUnZjc0JXRG9QWnlVTjVl?=
 =?utf-8?B?R0o0OXh0Nmd1SFptV2FrcXFEZFJCVWl2cUhLaGJzcWZXWUordTk1Ym92b0oy?=
 =?utf-8?B?L0Y0d2NMREZjUXd2aWxFUmtyb3o1UzJGc0xQR1Ura3dwTWxWbGxCaU1FUEEz?=
 =?utf-8?B?Sm5LYmZ0emEyRFcwVFpRMnNwTFZQenQ1Z0YrQVRveUR3dFFyNlA2d1JpVGdu?=
 =?utf-8?B?TTNGRDZENy90RDNyOEdrWmF5WjFkdkxrVk90b25ZbVJnVHlZRFR2c1ZTSWxD?=
 =?utf-8?B?QzF3bTlOT1k5bG40clVZVVpnMVZrUEZySmMwMTJPZXR0K3dhRWl4cnU1MG1p?=
 =?utf-8?B?ZFVBVWxXcHJFdEt4VncwME1tcnNKbGFEY3dqYXM1TXlGMnNYUEt4MlptVHJt?=
 =?utf-8?B?UnN1ZXhhbnN6eFp3Nk11NXNMYldNWGlzWHpINDJES2NVcHVoQlI2MlBNZlNK?=
 =?utf-8?B?TTNVYUFBT2o4QnJkNUdjUWNOVHhXN3R5dFM0RVdhUndIdDBVejRGdVhUVDZa?=
 =?utf-8?B?bmh3SzY2dU4reTJnbFlURmVvMktLY1A1NWw4ajZuSnVNQy9FYkRUSTYvZmRi?=
 =?utf-8?Q?rdRwMNG9uEU=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(4022899009)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VW5vb1hWd2puRVppbEdhVC9zS1ZwaG5aTllJcU01eCs5eElsSUpMT2ZBclRX?=
 =?utf-8?B?dVpkRThiSFpRRXR5WXFoZGtJaGpnaGNOMEduQVJRa1pQMzd3eEMrZDZWM1lE?=
 =?utf-8?B?ZmtkaWJlcVZiQ2xzQ1RJVXA3YzY3cittcTI3L3dzalo2Mm50bW93SXg3QnVI?=
 =?utf-8?B?cmtjYThiMGlpU3JvVktDT2I3dW4rKy9wUnlCczU4OC94UnJybktlVmgxRUMy?=
 =?utf-8?B?Q214ejZDSFlWVGtaSDBIYThFYUlldko0NjlqZ1RzZWhVVHQrakJnN1pvZFlJ?=
 =?utf-8?B?Q0U5SUMvdTFxaFlhbHZIb05HV0g3djA0N3I5T3FIVERhbHlqMlIrK2YyNTVF?=
 =?utf-8?B?MGhzZ0EzZmFlaG8waG9rWVJ2UjRUVEh0djFBRVYyakJoWkxQWEgzQUdsQmpJ?=
 =?utf-8?B?MmI1aVpUb2gydzR1OXBBQW5YQWVhQWxpcERZK2lpUUFKbDdWZHp0aG9uV0xu?=
 =?utf-8?B?WVJIaStad3lMb2YweGI5WUtDdE8vVm9BYlJZMGl1NktKc3h0UjBVV1RwellT?=
 =?utf-8?B?d3F1OUpSRjI2WGpZY1lHVVhId0M3SVRTdW5iM1QzNGQzdHdtL2dFdGVjeGZl?=
 =?utf-8?B?eDdFUGE5YW1vNkpoRk93bUJ0WUpTbDF0ZDR5ajBSbEk5ekdwdnBDaitIdnBV?=
 =?utf-8?B?QW41SkkyWXpmYm1La2FrOTdWTnRKKzVocWdXN09QbEJsVWx6aDZBRlk4ZCtY?=
 =?utf-8?B?ODVwcDg5cmJDczRjZllqVHUxVzlEc0pUeWxKWXFncGRySlJ0S2N3SHY3aUhs?=
 =?utf-8?B?M2lGTGhLTTR0dW9jeFN0eUk0YzAyOUpDOHZDdTROZXp0QllCaWVraDRDSDZr?=
 =?utf-8?B?SFBtQk1JeTVWU0FYbjJMU09OK0VrSHNUUDBZZHpSL3R6SVRKTjQ5TFRJdHFz?=
 =?utf-8?B?SE44WEgvZENZbGowVDBwMDI0YTVtYWpnK1A3TXJITW1kU2NsMzFoclo3VERF?=
 =?utf-8?B?eUdncStmZ0VaeUo1UW83T3p5ZXBDWHh1bFZkMWlMQjFQREI3MElSbi9oMzZY?=
 =?utf-8?B?Y2FuOEJvNVE3UWpRTGgxd3VpNXc1dVpQNXRpUHlPdFgxSmE2VURBcnM3Y01M?=
 =?utf-8?B?aGYvSGZreWVBUmQ4NWp1U3BaeWx2QTJzMzVlbFlCS3RLSlFFc1g5eVZYbll5?=
 =?utf-8?B?NGRJaW9xemVGeEFrTkNQeVY2MTZBOEFXczJUcWhVYWZLeW5tZ2JwNlhzZnA3?=
 =?utf-8?B?emJBTHBDZUNjaXFxU05BVFF5Uk5ZUEpmbE5HSVFHWEZNc1k2eUN1YStYMGkw?=
 =?utf-8?B?UjFsY1NyRzBWeVVCdzNqdXp5YzhmQ2t3eHdBczdVeEdXWTIxT2xHcjI5SzJH?=
 =?utf-8?B?Qm5PajVEMFpHWGtUeG1Zb1dqZmFJUzdwcXU2MS9RN0EvaTc2V1RpOG9wMDFP?=
 =?utf-8?B?dC9OYlIyZ2VLM1dUSTRTTlh1TEx3Q1ovbHgrcHlXbzdQRVdldlRvKzA5N1Ir?=
 =?utf-8?B?b0oweWM5ZDlyK0tROVZMelJtVzlBU3N6QS9zL20zZ0dHZGFnM01tYUhZUGox?=
 =?utf-8?B?QVBJVVVGMjJDYXpkYjk4dWNxbkJQVm9Rd3RUWnlBeTFaL1JIeS9Eamx5bDZ5?=
 =?utf-8?B?VEppYzBOTlJvZlRVaEVmQzdqYUZ6c3prR1plVGJIanJwUXVoNHVkaGJkT3gy?=
 =?utf-8?B?cTNNQ0Vxd0IxUUxBUkpDb0M5cEl1M2ZTZkJHeW11VHZmazViM254eWxOaDY3?=
 =?utf-8?B?dE53UkRxNGM2ZkUvVklNQ2hpUWk2eTdBdEt2YkNENkZKM1RscGFNQmpHOUh6?=
 =?utf-8?B?cHkyblFTTC8vVlNIa2ttcW9Fdnh4TjlHa0ZqTkFJQXZnZUUyV1BFR3lGVmRE?=
 =?utf-8?B?Y0E2OWtwUWM3UG5LQnhDcnFUS2ZydEpic0lRbTA5ako4WGpOTjBMWER4ZGJl?=
 =?utf-8?B?b3NvNnBEYjVBZUlQckFydmNHKzBaeEtRYWZYdHV5OXFLWEJ0STUyc25nRVJH?=
 =?utf-8?B?WU5nUGgxLzY0eXNJUlJVanRCa0xHU0MvOWpTMUVZcnBNazVueDBoVWpUL3Rp?=
 =?utf-8?B?R0c2KzBlTnl1U1NPaUlMdWxlelhZbmxoaWRDWlRCUGhaczlmaFVzbWpNRmhx?=
 =?utf-8?B?UW92MlNIQVJKUmJ1ZmtTYXJqcVFzdkhmeUJjWjFaT21XWVk1OGo3SmJKeUNB?=
 =?utf-8?B?d2pLOEcvT05waTdtSVovM1NmQXlrS2R2NlRDU1NyQW83SWY0SGc3ODZGVGdR?=
 =?utf-8?Q?QNdkArNx+GnYEYIX92/l22s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF033E90E862DF47AF346064E5EC30CB@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR10MB6828.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5302cf2d-354b-4426-d19f-08ddcdcda613
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 11:55:29.4373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bs4f+x0pLLG/8AnTFLLdGJrwUeuIWmvhcGqQcazYH12vdVffht3so8UeRjG2PYt5IPQ2p+wViyuWIzyhEYZcVuSL1yFTlFXvycNNqUcGfF8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB7447
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 28 Jul 2025 11:55:37 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19598

T24gRnJpLCAyMDI1LTA3LTI1IGF0IDA4OjU4ICswMjAwLCBKYW4gS2lzemthIHZpYSBsaXN0cy5j
aXAtcHJvamVjdC5vcmcNCndyb3RlOg0KPiBGcm9tOiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNp
ZW1lbnMuY29tPg0KPiANCj4gVGhpcyB1bmJyZWFrcyB0aGUgYnVpbGQgYnV0IGRvZXMgbm90IGFk
ZHJlc3MgdGhlIG1haW50ZW5hbmNlIHF1ZXN0aW9uDQo+IGZvciB0aGUgdXNlZCBwYWNrYWdlcyB5
ZXQgKGRoLW5vZGVqcywgbGlid29sZnNzbC1kZXYsIGxpYndvbGZzc2wzNSkuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKYW4gS2lzemthIDxqYW4ua2lzemthQHNpZW1lbnMuY29tPg0KPiAtLS0NCj4g
DQo+IFNlZW1zIHRoZSBsb25nZXIgdGhpcyByZWxlYXNlIHRha2VzLCB0aGUgbW9yZSBvZiBzdWNo
IGZhbGxvdXRzDQo+IHN1cmZhY2UuLi4NCj4gDQo+IMKgY29uZi9kaXN0cm8vZGViaWFuLWJ1bGxz
ZXllLWJhY2twb3J0cy5saXN0IHwgMiArLQ0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbmYvZGlzdHJvL2RlYmlh
bi1idWxsc2V5ZS1iYWNrcG9ydHMubGlzdA0KPiBiL2NvbmYvZGlzdHJvL2RlYmlhbi1idWxsc2V5
ZS1iYWNrcG9ydHMubGlzdA0KPiBpbmRleCBmMTQ2MWFiOC4uNDViMDQ5ZjAgMTAwNjQ0DQo+IC0t
LSBhL2NvbmYvZGlzdHJvL2RlYmlhbi1idWxsc2V5ZS1iYWNrcG9ydHMubGlzdA0KPiArKysgYi9j
b25mL2Rpc3Ryby9kZWJpYW4tYnVsbHNleWUtYmFja3BvcnRzLmxpc3QNCj4gQEAgLTEgKzEgQEAN
Cj4gLWRlYiBodHRwOi8vZGViLmRlYmlhbi5vcmcvZGViaWFuwqBidWxsc2V5ZS1iYWNrcG9ydHMg
bWFpbiBjb250cmliDQo+IG5vbi1mcmVlDQo+ICtkZWIgW2NoZWNrLXZhbGlkLXVudGlsPW5vIHRy
dXN0ZWQ9eWVzXQ0KPiBodHRwczovL3NuYXBzaG90LmRlYmlhbi5vcmcvYXJjaGl2ZS9kZWJpYW4v
MjAyNTA3MjFUMDAwMDAwWsKgYnVsbHNleWUtDQo+IGJhY2twb3J0cw0KDQpUaGlzIGhhcmRjb2Rl
cyB0aGUgc25hcHNob3QgbWlycm9yIHRvIHRoYXQgZGF0ZS4gSXMgdGhhdCB0aGUgaW50ZW50aW9u
DQpvZiB0aGUgY29tbWl0PyBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8gcmVseSBvbiB0aGUgSVNBUiBz
bmFwc2hvdCBsb2dpYw0KYW5kIGp1c3QgcGluIHRoZSBjb21taXQgZGF0ZSBnbG9iYWxseS4gT3Ig
ZG8gd2UgbmVlZCBtb3JlIGZpbmUgZ3JhaW5lZA0KY29tbWl0IHBpbm5pbmcsIGFzIElTQVIgYWxy
ZWFkeSBzdXBwb3J0cyBmb3IgdGhlIHNlY3VyaXR5IHJlcG9zaXRvcnkNCihieSBkb21haW4gbmFt
ZSkuDQoNCkZlbGl4DQoNCj4gbWFpbiBjb250cmliIG5vbi1mcmVlDQo+IA0KPiAtPS09LT0tPS09
LT0tPS09LT0tPS09LQ0KPiBMaW5rczogWW91IHJlY2VpdmUgYWxsIG1lc3NhZ2VzIHNlbnQgdG8g
dGhpcyBncm91cC4NCj4gVmlldy9SZXBseSBPbmxpbmUgKCMxOTU5MCk6DQo+IGh0dHBzOi8vbGlz
dHMuY2lwLXByb2plY3Qub3JnL2cvY2lwLWRldi9tZXNzYWdlLzE5NTkwDQo+IE11dGUgVGhpcyBU
b3BpYzogaHR0cHM6Ly9saXN0cy5jaXAtcHJvamVjdC5vcmcvbXQvMTE0MzM0MDczLzY4Nzk2OTYN
Cj4gR3JvdXAgT3duZXI6IGNpcC1kZXYrb3duZXJAbGlzdHMuY2lwLXByb2plY3Qub3JnDQo+IFVu
c3Vic2NyaWJlOg0KPiBodHRwczovL2xpc3RzLmNpcC1wcm9qZWN0Lm9yZy9nL2NpcC1kZXYvdW5z
dWLCoFtmZWxpeC5tb2Vzc2JhdWVyQHNpZW1lbnMuY29tDQo+IF0NCj4gLT0tPS09LT0tPS09LT0t
PS09LT0tPS0NCg0KLS0gDQpTaWVtZW5zIEFHDQpMaW51eCBFeHBlcnQgQ2VudGVyDQpGcmllZHJp
Y2gtTHVkd2lnLUJhdWVyLVN0ci4gMw0KODU3NDggR2FyY2hpbmcsIEdlcm1hbnkNCg0K

