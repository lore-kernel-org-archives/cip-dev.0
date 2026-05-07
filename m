Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D6BCD343F
	for <webhook@archiver.kernel.org>; Thu,  7 May 2026 15:02:35 +0000 (UTC)
Received: from OS0P286CU011.outbound.protection.outlook.com (OS0P286CU011.outbound.protection.outlook.com [52.101.228.68])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.14136.1778166148873323428
 for <cip-dev@lists.cip-project.org>;
 Thu, 07 May 2026 08:02:29 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=JbujttXL;
 spf=pass (domain: renesas.com, ip: 52.101.228.68, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUVOFnuWdPSPpZKgISxk2sx1I19+FK1Tsc3zn1cB8qMXJAoCiUk/rDwZy6EVf816U+Y+5sdcYzj7wb2sLNeXEX9iTct7BYUKOxW2h+UeZ3rCMJnCh84Q8SBKxU8WF0mOSKhiNNqYVKdT8jtZis2vxRE0crok0jGhO0AFmvS1pKpLaSasw4zXxJ5DAnm82BjAv15xWxMrhixhUZqjho5/CYIlUKKR5ZzVGOzEQSLV3iiCTvF+8zEutNbc+KlfKGm1vVnyd2d1jMDZA/6ghsvOlYyQO6PixeduqXdAmxH0PFYzfaTiQp922B0tKsmlXZ5qNSNVl9AXr6yffzAtXPBlGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Wcx+fN0Mfz/1y8BQNQIYCeuG9d/sgjlYfIiI1By5NI=;
 b=V+6tdtrYZdYu3yAedg8WrQzIiVOGxYcS0QprISxwhr2IYQ0yLWfj9WlG6kfvGaAEQTU2P/JGji7wQIShl9pht+NdVZux+3+3Hmxkh/yI73XCsgNC5s2ho+Bsgl6X2Zp/EFHZGHVBOynOZAK31LjBGvugdOs0T8XLwFs02iQBSkpiHHxUF+XC3ZRqDyn3rvbv2CeeDObMfMJT/Wc86JDrES67F0CbwaE207YCC91FmOCY83Iylman3UeYiHWWvE08qJnAGXem9+AndZrkRaI1jUPlRzQksOFQK/dK3rVNMop53tpA7LkxICD9pQN8OjaFbj3IQoVKHYNvHQFe4KgD5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Wcx+fN0Mfz/1y8BQNQIYCeuG9d/sgjlYfIiI1By5NI=;
 b=JbujttXLsj1xRs0xHtWpVPIRjPjo9dvU8TlCRRk43o442JLlf3rGuc+U5AR1jSOdz50wIBUMQih2X3D6mGPlWk12nbVRC2MVt6icjSBpyKuoo6dqR0iCeOB67VwA1dCQgRNezd4ZwXZDN8s2w3xzrsZAoE2tT2zD2Bg+/FJ2luw=
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com (2603:1096:604:165::7)
 by OS9PR01MB17158.jpnprd01.prod.outlook.com (2603:1096:604:458::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 15:02:24 +0000
Received: from OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a]) by OSZPR01MB8123.jpnprd01.prod.outlook.com
 ([fe80::f2ff:7635:979f:c31a%3]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 15:02:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>
CC: cip-dev <cip-dev@lists.cip-project.org>, Quirin Gylstorff
	<quirin.gylstorff@siemens.com>, Ayman Chaudhry
	<ayman.chaudhry.kc@renesas.com>
Subject: RE: lava: qemu-renesas-01: "client version 1.41 is too old"
Thread-Topic: lava: qemu-renesas-01: "client version 1.41 is too old"
Thread-Index: AQHc3jHgGGfxck70YEONkNxr8QVLa7YCqE/g
Date: Thu, 7 May 2026 15:02:18 +0000
Message-ID: 
 <OSZPR01MB812395AD76B1F7402C19B32EB73C2@OSZPR01MB8123.jpnprd01.prod.outlook.com>
References: <e4be98a1-10f6-4b0f-9e5f-b990be2204e2@siemens.com>
In-Reply-To: <e4be98a1-10f6-4b0f-9e5f-b990be2204e2@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSZPR01MB8123:EE_|OS9PR01MB17158:EE_
x-ms-office365-filtering-correlation-id: 40103ff2-452e-4ff8-4c73-08deac49a1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|38070700021|56012099003;
x-microsoft-antispam-message-info: 
 GOVGzyimLcUIvkrahgQDqsWW7wcKksqC5YaAc07Q/ru4Rn76ABdgXrZSVhR55iuNi36zIa5052M2jfhPEkOIznW8ga3suVVPRaoxbIopYVq4eYbRkPNBiNiMFvf9jZ9+q9fuRoxdBNLngFpcIabvfn4yqB7WNO60IO2GfMUhLhrA6LsFf8htVgWClP8TlTtlVmUWD3An+E6HStQx3RV20csSEP21KfC1qTM4gAfTUvhKEOdP5laIPZhmfLB1rTAKme/x7q1yGHQug1Q54XI08G2AGhGjWiaRwXQhq/2/TA1FOUSCh75DWix8SLW3tDwKTvYqGAPFzXTa81C+PgXnzLwjsvNd0+Vd7nzX6hrIQQVUJId+oxUSGhroE7ha3ER8K18lXsVW8dGdVqHOMPH4Bl6UYASktzHl5DLh2reOJItxflQ3DncVcpTgqcoGK9e07q1FnvA/rR4cKDYSpBysieLYcVCv14c22kWTBx/VSeaNkpIowEON08eYbZUYGNXZz3ar4svl+vsumD3YvClBpoMH4C07fzU6Aa7T20w1PBQf0AeUGYhWNPJGc92eMJ+yLjZ6jTCJbNfUrTK5dtZlJUn+JhAaMaFZIOl3NvSh2aPfP9LvDKxq2ypVi3Ot7L2i2CWZXLCNXw5kYKITIQY5fKaSNPPkQD4MxIv1C+duvqlxaQDPYsYNN+mVQ+jeUSvwimZ6SV2eWWm9a+QoXXdH/w==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB8123.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(38070700021)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?TXBHd0c0MU5GRjQrcm1ZbDFReTZvcUxkOG5NV3J4QUZ3T3hJaEI1VlNmaDcw?=
 =?utf-8?B?T2J1VzI1RlBTNTkxNm44Zm9zRk52ZU01dmpFdnYzQnhRTlpUTURBZ1FET25B?=
 =?utf-8?B?MVRudGtjNlY3MG9PcUVncW4rSlV1KzNJeUVxcXIzRStHL25sSElpL0oyMFRl?=
 =?utf-8?B?aWNPVFJhY2pxMkJxNW1meXBheUdCWTVKcFJKUVFId1g2RHNnUkdVcU9iOXRW?=
 =?utf-8?B?SFFWbWkyTXFRT2lnNVJvcGJ4OVBvTTk3TDVmV1pCSU5wT09iaTcrY2JzUndE?=
 =?utf-8?B?Z09vQVJnZ2Q3dnZJMGdCUW9sdTA2c2dLQk1iU0kycFBaL1l0Qkt0RE53VFh2?=
 =?utf-8?B?T3NBQXlKZkpCdGZGSENpNkN5NlR6RzA3VWEyQzFlZG54UElsQTdPWUpOeWV1?=
 =?utf-8?B?R2RRR2NWallya3ZMQll0ZzNtOUZTRXdrcjhPRGxGTysyWkx5ZTQrZUtDUlYz?=
 =?utf-8?B?Mit1MzBaQ24xQUdJQWliRG5uODlmZkp6YzFZd0FtSjhNa2lGV2lKRUVGLzJD?=
 =?utf-8?B?aWl0bGJ3Tnd5VUR2dGxlTnlaUGxncFQ0WEo3TTgwNjM4UXI0NW8xWFhhSGc5?=
 =?utf-8?B?NUtkL09yakRhYTZtZzgzMjB2blliU1VRMS9IeWRrVHBiMTBuTFFvTUZVdW9E?=
 =?utf-8?B?UDk4WXlOcUdvM2dmaG4yVzM1bzFHWVNaaEh6Y3R1ZVFOTElrTVNnRktMWWN0?=
 =?utf-8?B?VS9oMVpPM2lvbm9OMWtocHNjL0hXVWpNSUhSTCtQTWVkSVJoWmgzOW5vL3pV?=
 =?utf-8?B?UUtlZGpUZnYxUDNLdFYzdit0SnVrTTBDQU5lSlhwQkFrUTh5K1JxTFdqWUlG?=
 =?utf-8?B?bWEzUm9QMzc5bk9TaTBLNFFrdUUvYm1WdEJRdjlKOGxNZmNndGdlVEMxUWcr?=
 =?utf-8?B?S1dMMnhZS3lpcjEwaWNCTlZJdE1uYzJVUjZ3VHk0Z1BUYVRKZDZmYU1aMzJs?=
 =?utf-8?B?dElZMzBOQnU2U3lyek9HY2pvWEIrcGlXZU5SUG1yT21hNjhiSCs3aDFLWmdG?=
 =?utf-8?B?VFBpSGw4bVRRV1RGdzNCcktyUk5FdjNmZmJCZGpOK3F1UENjVE1idVNGQkdx?=
 =?utf-8?B?NEpuelI4bzQrRERrd2VVblFxei9QZU1aajY0V2J5bVlHMjFyMTljRVFZWU5S?=
 =?utf-8?B?eVlIK3c5U25HcUhvRkhSRStaSW5iRTV2eUFUelFPU3phRHdRUVVrTVV5UjlS?=
 =?utf-8?B?L3dEczhvdXZQNmdOcW10cVRzTFBhcWNaeXdPS3E1eUJSL205djRFVWVrZWJo?=
 =?utf-8?B?MUt4LzM5YlFPTitKRFJYS1JoTDZUMCtYQjZGQzFIZFpwWVFhWjBhZDRDTlov?=
 =?utf-8?B?Kzh3OFNxU2N1cEw0RllvSXprQWtsUzJWTlVpb3ZJVkVlcEFDUHdNZ3FPTDFZ?=
 =?utf-8?B?UnVacHpHRllOb3F6V1JUbFV6TEpzYXFmK2xYU1pmUlVBWGxqYW1BNWQrTllr?=
 =?utf-8?B?YUNwcW5LZGczWW4rb0tnS0lLWVZhejNVY2UwVUpPRmh1V3p0Y2lhRE1mbHhy?=
 =?utf-8?B?aFFlRFBFL0lhckdVU21Pck90ck5OMWRKcjFvM1RZN2JDTDVKc1ozSXlwdGhp?=
 =?utf-8?B?VzlkTlZJYmZJMlNrQzJqVjZ6SzJTWlB2Z0tCajFKMStRSUFtREI3VFB4ajZo?=
 =?utf-8?B?VCsrbWlvb3FIVEJZTmhtK2FYTVJhcU52WEtvU3dQK01kdktkZ2pxWWRPcmpH?=
 =?utf-8?B?TmkxeFdKY1RnM1daSnYwVkJWcHZHYWN5MVM3cUQ0WkxPSE9Dd0lSS0tZZDN5?=
 =?utf-8?B?bUk5MHQ5T1k5enNCaFQxejlBM2V2WmM4OXRUblkxKzZIekF0OVloanh4djVY?=
 =?utf-8?B?R0thR1JMNXJrR1hkYWc4V3NMVC9DamhyZi96ZnUvNHRsaG91YURPVjFvclQv?=
 =?utf-8?B?NFZDWjJDcWc1OFBjVkVwYUQ5N2t4a2w3bld2L2pLWkV3Wndtalc2dll3Nnd3?=
 =?utf-8?B?cXJiSU03SlVjUVJGOXdTei8rYTh4SjEzUmdIOFQ3eEt2Ly9wb0d4TGJmUFZV?=
 =?utf-8?B?c1plMlMzK0MzSTBtdUtKWUFMejMzQmx6T2RrVUlBTmVSVktTeVhXcE4raVJr?=
 =?utf-8?B?TUptZ2R2bEVNZHdkZXhuTGhXam1TcW9XdXdFdmRTelJVaUdlcVFnNEhiemd2?=
 =?utf-8?B?RWtVNHdFTkt4bXhOdzJjVEViNWN1ZnJmWEpYeHNLTjY2RjdwcTIrQktvbHFx?=
 =?utf-8?B?b0NxUndHRTZjcjI0UVg3WmlLYitFeTRJSGIybU5sOFBBbGpMcDJqVFZUU0lr?=
 =?utf-8?B?MVFlT2RqTlNRQ2JndUZFbXVYWDkvNFJFd3NDWXZwUHFZMUFRNXRXUGpwZkJJ?=
 =?utf-8?B?ZnAwOEt1ZWFjSU5hemFGT3JNMDVrcFZnN1BFVXRaZ1MrY3VUUmJHdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB8123.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40103ff2-452e-4ff8-4c73-08deac49a1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 15:02:18.3134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6njs1OSRfu3TzqcgL9LUgYq8R5KGWH0CyhWmE+/rXT5yToGi/e2Uc+NG4XOJNs2kXRQkAFUGed4bUBtzSjr1F2shIQvLIDNiYHZ/OmH0EBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17158
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 07 May 2026 15:02:35 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22909

SGkgSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IFNlbnQ6IDA3IE1heSAyMDI2IDE1OjU4DQo+IA0KPiBIaSBDaHJpcywNCj4gDQo+IGlzIHRoZXJl
IHNvbWV0aGluZyBvdXQgb2Ygc3luYyB3aXRoIHRoaXMgcGFydGljdWxhciBydW5uZXI/DQoNClRo
YW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuDQpJdCBsb29rcyBsaWtlIHdlIG5lZWQgdG8g
dXBncmFkZSB0aGUgaG9zdC4NCkknbGwgcHV0IHRoZSBvZmZlbmRpbmcgcWVtdSBtYWNoaW5lcyBp
biBtYWludGVuYW5jZSB1bnRpbCB3ZSd2ZSBzb3J0ZWQgaXQuDQoNCktpbmQgcmVnYXJkcywgQ2hy
aXMNCg0KPiANCj4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTQz
OTE4NyNMNTQNCj4gaHR0cHM6Ly9sYXZhLmNpcGxhdGZvcm0ub3JnL3NjaGVkdWxlci9qb2IvMTQz
OTIwOA0KPiANCj4gT3IgbWF5YmUgc29tZXRoaW5nIHNpbWlsYXIgdG8NCj4gaHR0cHM6Ly9naXRo
dWIuY29tL25leHRjbG91ZC9kb2NrZXItc29ja2V0LXByb3h5L2lzc3Vlcy81MT8gUXVpcmluIGZv
dW5kDQo+IHRoYXQuDQo+IA0KPiBKYW4NCg0K

