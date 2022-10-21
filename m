Return-Path: <florian.bezdeka@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5DFC433FE
	for <webhook@archiver.kernel.org>; Fri, 21 Oct 2022 08:05:46 +0000 (UTC)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (EUR02-DB5-obe.outbound.protection.outlook.com [40.107.249.54])
 by mx.groups.io with SMTP id smtpd.web12.7723.1666339539979133036
 for <cip-dev@lists.cip-project.org>;
 Fri, 21 Oct 2022 01:05:40 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=hHWMjXW/;
 spf=pass (domain: siemens.com, ip: 40.107.249.54, mailfrom: florian.bezdeka@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkAKkCxLqWvH+2Mh5cSA+Lc9TRVAjMWOPy7502ff1PvC9uV6+ydQAkL42S1kV7lt4wtSrc6H/M44oAnoUzVw63jhhovGRJgtGFprGDPT4XsEWu3OBM1u9FKaI/kLEQABlLfp84o/7ZFfBoSRaI6a9I+z6wgzjE5+oLI482BWy3BKYqup6pDgGhRuFJlp30OS03H1e/uiwgpmYZyJ+deuo53++AZUuNzZGtBD4Nk17adFrxKoPQdPnyPIzxS/+h1U4brpp+j54TbP9TfCEPB8Vpphi+ohNIyxDlKp2Eu7O8sDl6y/fjuVbdssHZp0YbZbNPkkIwLh0XHAT8x3/6i1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4CfBLYmKRjPj8Imz4GOnh+qtUEl9KDYSJPc+mVd1O6A=;
 b=i/ywaCtuI00qjR4Sz2f4pDbrCuEYZxXEYGE66vzcLnjfCgc3YLUnxD8oWnjG8Lp8YguyFkLUwdfz+jfD7ZEZDOgapLTk6t9YpDw3E6XLltm6I6lRzA8RKB9rcuDu8RRK3CBM9zw70wF0j2NbWCpe8zjjJKKrNX7e29fUld4vPzIwz5J7S/JXSGYcZE0tCVS4wUDjdWQ7wsBqVxO7mMhU5xzExfub5VKLrMkwGu3k8ezhZG1+19lUzHbYLNjIO4OTI6a+VSkIoU5YeVvVIXkXDT4vd5FBF1Is8FXS63Em+6gDadVrW41Si2210KBfmpwJJki2hRFheyBzVkxCM2QF9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4CfBLYmKRjPj8Imz4GOnh+qtUEl9KDYSJPc+mVd1O6A=;
 b=hHWMjXW/vIvKFoCOWxFdcsdkoOAQQyMnCfKwxEcTfVBxX563nElmmBRxr6hNgDvRQzIbvdY3odb9E8k3TJ70aJ/7n8KYEKF9jWy66FIqy1TlVmnLLrmX5SlpsQC6n2ntOOz7vk69rPU38rzyV4aySArp1PWtTnkRk1EnVMX7IWwKBSl982Pemb2aTKYNzSPrgNsRW1Vg3cz2RF4oRdCc+whON7jRB1+CvcnUr/hbkeRQYOldpI1QmBaawFaFpMGNMn7efkC7SE3BpJVMb3DRo+YHF5R5M8qQzGP0UqZHIdI0un8QIapDB4ge+ZR+ZRWht2qynmDo4yGZkWMd+fxnPw==
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:248::14)
 by VI1PR10MB3471.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Fri, 21 Oct
 2022 08:05:36 +0000
Received: from PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::18f5:54d5:ca97:5a8d]) by PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::18f5:54d5:ca97:5a8d%7]) with mapi id 15.20.5723.035; Fri, 21 Oct 2022
 08:05:35 +0000
From: "Bezdeka, Florian" <florian.bezdeka@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>,
	"pavel@denx.de" <pavel@denx.de>, "alice.ferrazzi@miraclelinux.com"
	<alice.ferrazzi@miraclelinux.com>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Chris.Paterson2@renesas.com"
	<Chris.Paterson2@renesas.com>
Subject: Re: [cip-dev] KernelCI, gitlab testing notes
Thread-Topic: [cip-dev] KernelCI, gitlab testing notes
Thread-Index: AQHY5J5DPdwjtZeCIU+lw/moHEOi0q4Yfo0A
Date: Fri, 21 Oct 2022 08:05:35 +0000
Message-ID: <eed3c2ab1786ac3169e127e60d468dde743766b6.camel@siemens.com>
References: <20221020160844.GA19694@duo.ucw.cz>
In-Reply-To: <20221020160844.GA19694@duo.ucw.cz>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB5712:EE_|VI1PR10MB3471:EE_
x-ms-office365-filtering-correlation-id: 3164990d-c1ca-4870-2d2f-08dab33b08a0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 d8x1OhAdpXJYZ7nrruvRu1q/MzsZ0WfPgCBOD+dsnMqfU3podcTNmVN2xSWjbG4eWcBR3lNyqvkCr3oWy2KjVQiUAR/vIOnUSlebeXmncH7Gclqk+oeEN+AFp6E67tWgEwL2weB7xVwhO5VuhfkvLfO/FRfo0EpcnwH7gBbePMb+q8ZuYNzjYyhJ3Mqf1mHmjlA1/z2DoePNmGk2BKkT/hiKwFbgbZf3OKtDpJ6NIZy1p624aBUNa5av9Z6Wphz+ldveNWD4Q0YAddOZBBtBboe66rtyhSxb7IMoO6wh4mylcCLPf2VxB/ZAdNiTE/loRvBWTWgLZd3WS1LjtHa1iC8ZLtaLB5tBKGiZmF9HntaBVYw5DReN+yfi8L5IMR7rYugBy4R65oh1EwqIVbToGIhOjyd/fyz3QW0N7e5JXnjjmmkbCMapTOJr6PTjKpsuXvuKrRTNUNvDSzNJuLZF5k1YZwfeuu7N6AhBWf0bm06T5t6RXvcDoVTfMEaDzCno8TP2T7/rQAxv1dsDiIeuYrMTT7/Mib+T4GB7RwgCvIyJ/yaprmvHQCS6EG+PkRppNtr5IEXIl6cF92CU0orWsFjGGuHbmUcJY6Wjo1r7x9pzqax2Mxzu23lFFH5ohgQnFVCJC6414yHRjAx3WBg0xqJeCkAUtOfPcO32WpSw8MCKI02ocQBYAFkpDDJ2gazKc5k19jOGFaDzaY5+mT7zRhPKI9EA+bqvHpwWFnH2FgJxJbR5BDoKrcfIdkddvpn3c9O3H2oZb/pb39lkUR+phybVky9LjPMP+Hb065THS5U=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(366004)(451199015)(2616005)(966005)(6486002)(186003)(122000001)(2906002)(4001150100001)(478600001)(38070700005)(71200400001)(5660300002)(54906003)(110136005)(6512007)(86362001)(316002)(83380400001)(6506007)(36756003)(4326008)(66446008)(66476007)(66556008)(66946007)(76116006)(38100700002)(64756008)(8676002)(91956017)(8936002)(41300700001)(82960400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?a3hMMlZiOHJway96VEZhdmJZMkYvQ00zUEMvT2ZyWFYvc2VhaFI5dkRWbGRI?=
 =?utf-8?B?cHpPUjcwK1FjTERmR285OEtQOFRyaGZoL2pKeWhtWDE5Q0hQU3BzRm1hc01F?=
 =?utf-8?B?YXI0VVRybHF0SDZvZ2szclREb0JyZzZVWjR4alhvL2lZM2ZicnFUWVB0WmEv?=
 =?utf-8?B?NFVGdWZuQVFrK2lKRHFOODJlNzRLTlUyc1liZW1RQVo4VldSVG12a2hmY1ZX?=
 =?utf-8?B?UDNlSW5wRDZqT2JzRDEyZE52V2lHY1M2dlQxZ2FvY1BuTWdWQW43OUpackJN?=
 =?utf-8?B?bUJLZDUxK3poVHZCMWc5TWJLUDA0VWVJVVU5V0EyU3ErTVBObUpFS1dYbkZl?=
 =?utf-8?B?RkpYOGZ2WG56ZnVBeXc0cEU2c2hraTdWQlRBNXczTG5kVWN6elZ0bFZXVk5T?=
 =?utf-8?B?Z2U1a08rQmFaa010MDgyakU5dWFUZWNsM21IamRMUWZmM01pTVZ3Y3NIV3d1?=
 =?utf-8?B?eEdiNm52anQ4TDc0Yll3eHBVWkd0dXpSZHByQ2lZZXVhcnp6WWcrdndSOXAx?=
 =?utf-8?B?ajZJeldTcVgvc1hLOE54YkJpR0RmUjRKTUF6UjFqS3U0NlhSa0VzNWtxZnRB?=
 =?utf-8?B?d2dNRE9VbTRXeVpyZ05YbkZobEFoSFV4MEVPMjNocE5jV2ZRQ2IzWlBaSG5U?=
 =?utf-8?B?dHJSNnhSTmovSmg2NkNHQU1jaDIweEVWN0dpYWxzdHFmYmtJelN0WmhPMkJI?=
 =?utf-8?B?aUhwVTBUUFZLSWpTeHQvRmgzb3dxNER2QlBjc3E3SW54MWxTK3lvalAvMFdh?=
 =?utf-8?B?YW5ER2xlYjdYVUlZa1N2dDlUSlZtWCswOWMyT1d5ZW1xTkZPNHZLTFpWR0ZJ?=
 =?utf-8?B?c05SVVJoZkJ2d3h1V3RhdXZwd3BGUWp3S1NvclgvK01pbEJTdGh6VEQwOE9F?=
 =?utf-8?B?MUZxQm5XbDZPR3lJbDI2V3NaT2dDeVJWRkdDRTdTNzhEc21yQ2orWlRuMjAw?=
 =?utf-8?B?dFdQTHpGM09FMXFHcUxRSEV1dTNiT2VySUVwdHhFVnZoWDFUbFhaS0N1cXNG?=
 =?utf-8?B?VDNCbEMzS0tvWVQ5WERJMm0xR0h6eGtUMHpTaklZYlR4YU5sRUNDT1JOYUdo?=
 =?utf-8?B?Z1VaSmJndURmbW84ZHBUN1p0b2dCdmdiTEJab212WTJEczNPY1Nta1J2Q2Ji?=
 =?utf-8?B?R3VzN3Jid21SSEFIcjdySDUzV2E1Zzlxc0FKaTFMSTFGdkxaZkw1djFiZkVr?=
 =?utf-8?B?ZFNBY05yZkdvWWgwK2VWN0xoemlZK250a3A0SmdjL2xjcTZpbWQ5Y1RMTTNl?=
 =?utf-8?B?VlBRVFBteG4xem81c3o0ZUgvYStJMkNzak16Yk1FOG15eW5xLzZwWDBybS9C?=
 =?utf-8?B?UkxSTWZDS29iMVlnWlVGNDJiN04veG9adkdQZTluM0lXdUNTVjlsWC9BR0Z6?=
 =?utf-8?B?MFRQbFMySURoRDZGeUEzTHBkY2lGMDA5MEN5QzM1N1V5UnB2aGxBUDhBaXJ2?=
 =?utf-8?B?UGtzSmh1R1dhaENZWDFzSnJzL1NiWmtXYVNTMnVmQ1dXNHlsNnJ0OWpIRHo0?=
 =?utf-8?B?V0ZKY0JXMkI3QXhOYkRoL1l1cGcwWTQyWk50MEFMaTg0KytuYWZKZ09xQWEy?=
 =?utf-8?B?N3N3dGxRRnprMnhodExIYmFQVkYvQUp0b3h0djJlRVFtL0R4ZkoyTWpJWmRo?=
 =?utf-8?B?VEt5amJBVzJaMmlxOEw5V2FpN29IaWZURTZ2Y1N1SDgzdjNycEg2YmllemI3?=
 =?utf-8?B?SVVzUFpxaCthMC90TlYvV20zdW0vL0l3K1liTmZ0bGdNYlBvMUh6NjlWTStG?=
 =?utf-8?B?R1JWdWpXSU1ETjREcGNoZUJvY3hvZ1FWL005Znp4ZWZ0b2tpSmY0TGdvUlJM?=
 =?utf-8?B?ejdUcTRmOEEwMmpWREphbjg5YzhKMGYyOUVCOHd4QW96NFRwTWQwYjV3dThF?=
 =?utf-8?B?cUNnMTFOUmx5YXBtUUVMSWlNY2dsQjRjcTE5Zkh6YmtOUWh4c1U5alR5dnBx?=
 =?utf-8?B?ekMwaG1ZZ2xROFlRdWhwSENWdHg5cTRvV3pTdVFWMGRqbjJaOGpLNTBBT09n?=
 =?utf-8?B?TEo2ZlBKWW9OekovTTZvWDdLWXhpNlNjVTkzS0k5SXlqTFhqYkRSMzZFOGlv?=
 =?utf-8?B?Rmc4MFJRMHhSVWNoT0NPU21nbXg1RlZNUkc5Rk9tcjlDaSttVUVRdzhUZXRu?=
 =?utf-8?B?TldFMlZuQVo5YXN6YWJzZzQ0VllDellmQVNEcFNhaFl6MU1HLy9EUTF0ckpP?=
 =?utf-8?B?OGMzVm85Q1JxMHN2c0FOL2NXL2F0Q29sZFQ4UXAyRElqSFRwWkJSVnY0WURT?=
 =?utf-8?B?ZUV2TkxlWEs1MGIwTE10Z1RyZzJnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ABCE7D653FF684284A55FFA3C69BEDC@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB5712.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3164990d-c1ca-4870-2d2f-08dab33b08a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2022 08:05:35.5191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vl+B6PJsbf5XX4lUWdTB8FSVSZxYWML8JlDTQ+yGvd8PWY4Ck7NiTiwCVRkgtE1UajXzrZsxOtIuDQJGOUSdeNZNVYUmmLxzI7EJUATO+uQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3471
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 21 Oct 2022 08:05:46 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9801

SGkgYWxsLA0KDQpPbiBUaHUsIDIwMjItMTAtMjAgYXQgMTg6MDggKzAyMDAsIFBhdmVsIE1hY2hl
ayB2aWEgbGlzdHMuY2lwLQ0KcHJvamVjdC5vcmcgd3JvdGU6DQo+IEhpIQ0KPiANCj4gKiA0LjQg
a2VybmVsY2kgd2FybmluZ3MNCj4gDQo+IGh0dHBzOi8vbGludXgua2VybmVsY2kub3JnL2J1aWxk
L2NpcC9icmFuY2gvbGludXgtNC40LnktY2lwL2tlcm5lbC92NC40LjMwMi1jaXA3MC05OC1nN2Y3
ODM4YzkyNzQwZi8NCj4gDQo+IFRoYW5rcyBmb3IgcG9pbnRlci4gVGhpcyBsb29rcyBnb29kLiBN
b3N0IG9mIHdhcm5pbmdzIGFyZQ0KPiAibmV0L2lwdjQvaW5ldF9oYXNodGFibGVzLmM6NjA4OjY4
OiB3YXJuaW5nOiBzdWdnZXN0IHBhcmVudGhlc2VzDQo+IGFyb3VuZCDigJgr4oCZIGluIG9wZXJh
bmQgb2Yg4oCYJuKAmSBbLVdwYXJlbnRoZXNlc10iIHdoaWNoIGlzIG15IGZhdWx0IGFuZCBvbg0K
PiBteSBUT0RPIGxpc3QuDQoNCkdyZWF0LCBzbyB0aGUgZmlsdGVyaW5nIHNlZW1zIHRvIHdvcmsg
YXMgZXhwZWN0ZWQuDQoNCj4gDQo+ICogU01DIFFFTVUgeDg2LTY0DQo+IA0KPiBodHRwczovL3N0
b3JhZ2Uua2VybmVsY2kub3JnL2NpcC9saW51eC00LjQueS1jaXAvdjQuNC4zMDItY2lwNzAtOTgt
ZzdmNzgzOGM5Mjc0MGYveDg2XzY0L3g4Nl82NF9kZWZjb25maWcvZ2NjLTEwL2xhYi1jb2xsYWJv
cmEvc21jLXFlbXVfeDg2XzY0Lmh0bWwNCj4gDQo+IE9rLCBJJ2xsIG5lZWQgdG8ga25vdyBtb3Jl
IGFib3V0IHRoZSBjb25maWcuIElzIGl0IHBvc3NpYmxlIHRoYXQgcWVtdQ0KPiBydW5zIHBhcmF2
aXJ0dWFsaXplZCAtLSBLVk0/DQoNCkFjY29yZGluZyB0byBsaW5lIDE3NCBvZiB0aGUgcmVmZXJl
bmNlZCBqb2IgbG9nIGFib3ZlIC9kZXYva3ZtIGlzDQptb3VudGVkIGludG8gdGhlIGNvbnRhaW5l
ciBydW5uaW5nIHdoYXQgdGhleSBzZWVtIHRvIGNhbGwgInFlbXUNCmVtdWxhdG9yIiBhbmQgLWVu
YWJsZS1rdm0gaXMgZ2l2ZW4uDQoNCkRlcGVuZGluZyBvbiB0aGUgY29uY3JldGUgaGFyZHdhcmUg
dGhpcyB0ZXN0IGlzIHNjaGVkdWxlZCBvbiwgaXQgbWlnaHQNCmRlbGl2ZXIgZGlmZmVyZW50IHJl
c3VsdHMuIFRoYXQgc2VlbXMgdG8gYmUgYSBnZW5lcmFsIGlzc3VlLiBJIGNhbiB0cnkNCnRvIGFk
ZHJlc3MgdGhhdC4NCg0KSXMgdGhlIDQuNCBzZXJpZXMgbWlzc2luZyB0aGUgYmFja3BvcnQgb2Yg
dGhlIG1pdGlnYXRpb24gZm9yIHRoaXMgQ1ZFDQpvciBpcyB0aGF0IHJlYWxseSBhICJjYW4gYmUg
Zml4ZWQgYnkgbWljcm9jb2RlIG9ubHkiIHRoaW5nPyBJIGRvbid0DQp3YW50IHRvIHNpbGVuY2Ug
YSByZWFsIGlzc3VlLiBNeSBxdWVzdGlvbiBpczogSWYgd2Ugd291bGQgcnVuIGEgbmV3ZXINCmtl
cm5lbCwgd291bGQgd2Ugc3RpbGwgYmUgYWZmZWN0ZWQgb24gdGhlIHNhbWUgKHZpcnR1YWwpIGhh
cmR3YXJlPw0KDQo+IA0KPiBJZiB5ZXMsIHdlIGFyZSBiYXNpY2FsbHkgdGVzdGluZyB3aGF0ZXZl
ciBoYXJkd2FyZSBpdCBoYXBwZW5zIHRvIHJ1bg0KPiBvbi4gTm90IGdvb2QuDQo+IA0KPiBJZiBu
by4uLiB0aGUgInNvZnQiIGNwdSBpdCBydW5zIG9uIGRvZXMgbm90IGhhdmUgdGhvc2UgYnVncy4N
Cj4gDQo+ICogVW5kZXJzdGFuZGluZyBnaXRsYWIgcmVzdWx0cw0KPiANCg0KW3NuaXAsIEkgZG9u
J3Qga25vdyB0aGUgZ2l0bGFiIGluZnJhc3RydWN0dXJlXQ0K

