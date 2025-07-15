Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F38C6C83F17
	for <webhook@archiver.kernel.org>; Tue, 15 Jul 2025 13:48:27 +0000 (UTC)
Received: from OS0P286CU010.outbound.protection.outlook.com (OS0P286CU010.outbound.protection.outlook.com [40.107.74.24])
 by mx.groups.io with SMTP id smtpd.web10.9129.1752587298613353769
 for <cip-dev@lists.cip-project.org>;
 Tue, 15 Jul 2025 06:48:19 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=iU+uDvxU;
 spf=pass (domain: renesas.com, ip: 40.107.74.24, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqRRhKVgoUx4lrPsGbNojN+wOVyTHn3n6YqMpP1eLj+8bmN7hL3155jViEvDDZGjsy7XJ4y51C13uYWDsQCxII3oJPeZSQS83qZLTbxFEJ0i3rQCBfTNI3Cr2WxOnBKOthm0d+wKtIBceIrALb6sMhHKGz5UXnyVe8uIrEiNenBdOsVn/9b6hfJJF+rJnm05S0ExUlMnsSq6U1U1Bf6171uakEm9uzHGR6c2vGJM55eGOZg2ZEfxI+JoZpGCEH0rEdxoNwHrRPDrvN3Gtez6BzaMTIHIxxW9AgvuUGS1K36Cldem0RuysJQSmJJE98hFTbtHZfaO2GiZWg35/evd+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atB90tjyuOH/754/FwZ5sD3gMziatMWffX6YanC2q3w=;
 b=d9eY+Se9N124WcoR9QIkkYCYSgawVhJe0/Hnym4iPcQcVMJumLKUIvrcZBq04Ujjxo5WvuxOkqzT7n4Cfgn8L5z70l1SiwShXE8y21w62EhrZZM228bW87vM4nkux/M0B8CJgmyqA2+6x6FS6I8+tw6JEcW4lmpwtsa6l7tUYJnjQUPwUCpY/2uNFn29GmISK+stobD/ZwYm+zDsx9IIHaAcMlda02V/yyFrkHotCTWLmuUN+0S9DAwzyLeuBYDCPUGANplHDtPKHMSV0jd6htvErQqtIysdaDAFYRYM32yjMi4x2o7+CB/0h4Vlwx9EHQ+pRD0ojp0liB/HnCWNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atB90tjyuOH/754/FwZ5sD3gMziatMWffX6YanC2q3w=;
 b=iU+uDvxUqBJoTuwCk11YgF49C7sZhN4w7gyywf4Lm4zo51SLdqjGQeqFGXvISLy6ltjGGXU1dwvlA74BJ/nA6aqRAINmHGTB0KcjnFKT8ykZGxn5XT9BnT3aBMvZGr+UutUzr4BArcVifZBtgKe01/HL5O1vT0LqAVv7JNLRQBA=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by TYYPR01MB14132.jpnprd01.prod.outlook.com
 (2603:1096:405:20e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 13:48:14 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 13:48:14 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Jan Kiszka <jan.kiszka@siemens.com>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "pavel@denx.de" <pavel@denx.de>, "masami.ichikawa@cybertrust.co.jp"
	<masami.ichikawa@cybertrust.co.jp>, uli <uli@fpond.eu>
Subject: RE: [ANNOUNCE] Release v6.1.145-cip44
Thread-Topic: [ANNOUNCE] Release v6.1.145-cip44
Thread-Index: Adv1Xy1UoXCELFAwR9m2r1kNXnVaDAALny+AAABS+qA=
Date: Tue, 15 Jul 2025 13:48:14 +0000
Message-ID: 
 <TYYPR01MB151320755E491F321A34CCE67B757A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
References: 
 <TY7PR01MB1481892C3F332A8DD99DBE2989257A@TY7PR01MB14818.jpnprd01.prod.outlook.com>
 <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
In-Reply-To: <be2c98b1-61de-43ef-b86d-63a17ee578b0@siemens.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|TYYPR01MB14132:EE_
x-ms-office365-filtering-correlation-id: e2f328cc-f15e-4d79-1f4e-08ddc3a63eec
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?MjVWa0Q0UUtFaWEyZXQ1cmdUc1IwcnBFWkg2WXNYQVFyNzl2T2tmWlBmSG9V?=
 =?utf-8?B?UTZ3SnRxdi8yRVpnWWFjSmxIR3ZFTmZYZks4eERkUkdpRjZOMmhrMWcyOXZ3?=
 =?utf-8?B?OE9HMm9hN3puRGt2eE5jT3E0ZUJ5bHR0VGF3NXcxbW5FdFlKeDVJNUFyWks0?=
 =?utf-8?B?UDVSOFRqOUk0bEs2TlRJWVdvYitEamJaYmVVbG93ckxEcE1rbFBhVXloVkRB?=
 =?utf-8?B?TGt0dGhMRk0yempRb3JZWk1VZm1UOVVnUm9pdDhEWDJqRHVMNzVMWWxIU1Vk?=
 =?utf-8?B?THlrenFTdm5WTGNIUUN4cE9hTkdWY1Uvb0crVm1oaEhrYlEvTlJYUm9VN0Ns?=
 =?utf-8?B?U0Ivb0xUaGFvTVdiUDlZbnBLWDMwS3JRcTI5YmpqMjRDTlh3b09kQzE3YlZ3?=
 =?utf-8?B?RnlOQVlRcHBOTklxRHRaVGhZaHZ1S2tkOWVPakZqcmpGcnQxYmcxZ2hhbU1D?=
 =?utf-8?B?SEFJa3dVd2s4Q0xCNEVmMktKclFwMnFwR1l4NjdmVTNodUxJOGhlMDhqZmhi?=
 =?utf-8?B?cGMxZVVINFRzYUg2OXk3Mng4bUNmcGp4QW5JU0FycHcrWnpBeHZKUVhBSm9Q?=
 =?utf-8?B?U3lseExXdTNsZzA3a0ZPZ2lKdWZCRzJKTVU2QWF5cTRFa0Q1U2RQci9CN3Vr?=
 =?utf-8?B?cDdLSUNDdG90NFlSUXVXd0J4eVM3SWFpcWErN0Vyam02aFN2aXZuMklpOUdq?=
 =?utf-8?B?WW9IL1U0aGdZOVJxTWJvQVZiTmFMTEdCcjZkejRZL3hROEpkN3gxY1N3blFG?=
 =?utf-8?B?blVuUVNRb2NVbytIVG9Xc2xsWUkvMU5NRVRKYXBqSHBLUlN4bkxNNHBFZDFh?=
 =?utf-8?B?NGdLenhYS2JOOEk1aVdwYTdmVzgxa05NU2RWTlcvR1ZuZmJsZmFHYmV6V1RM?=
 =?utf-8?B?czhwa0ozVFdsK0pTMVJiSWxzY3dJZVNGeHk5WlBjUjY0UEJTaTAxem1ObDNv?=
 =?utf-8?B?UFZ3cjBVRzZwd2dPRlpqanI0UGZkV014Z0ZKdG5YN3ZhcThFamVnd0E5QmM1?=
 =?utf-8?B?RTlNSmszV2J3WFF2RWdFQWIwTjY1dUh1eTdXaWtjODZRMlJ5M3czQkFmajJD?=
 =?utf-8?B?TUtyZHhrZWFJdENLMWZLajFtQy91WGVNdXphTlBYeWZpT0VyVGNSRFI4K0M4?=
 =?utf-8?B?RWovRDh4MitjYVJpbDJ0R0hSeW1hZDZMOHpFVlo1UnppanhDZVkvbU44OGtE?=
 =?utf-8?B?dzE2QWtXOEJLek5wcDBwRGtsQm5xMlAwY3NsOVZNOVo0M2ZtUlRoYTNEVThP?=
 =?utf-8?B?NXg5VHdDRGlyemtrTVNMaFY1b0FwOFdYbG13K2Npblo0cVkrUEJwMmNNUWFq?=
 =?utf-8?B?OWZOM0lCbnpvU0JiY25EV1h2OEFUUEVTbnV6ZSttT1NaeG0rWUNlSDNMeHZW?=
 =?utf-8?B?SW8zSE14eS9xRzhqWCtxWDhXTE8zVytkTnZSK0I4MHFqZ05OS1NhRkhoaG5Y?=
 =?utf-8?B?RCtUYTdqOVFEYkRwbU9lVVk1S2NpZFlpRncxNjNvSVJVMHBkRW51MnkxZTcx?=
 =?utf-8?B?UXQrWkpUbm8xcHdqclNpWW91dkt0MnFuZ002VWdOenpUcTZaTFI3cjNwTTJZ?=
 =?utf-8?B?dmtSNTZsWjBmdi9sdnZKdGlDODk5amovT21ObXcwTTNnU1kzeE4yeWRjTWFK?=
 =?utf-8?B?ZUtKRXRUMnU3NmZMWWNtZlppU3c3Y0V5OHkzdmkvT1daQlJOVWppWElLbk1E?=
 =?utf-8?B?RnJsaXpiMmcrcmE3cWhNT3BFQjh3c2g3K2pDMEw0bU9ObGhINGtmc09ON3ZT?=
 =?utf-8?B?UkFkYjZ3WVdKYWxvR1FGZ2x4S05ISDQxeXNqS0ZnN0xWVDc4OGpxdk1MTHl3?=
 =?utf-8?B?eVl0ZnhEcHdJN1FMSVN6VmxWRmR2d2NkVjJPK2ViUkczQ3NvMTJ3UUJiay9l?=
 =?utf-8?B?MU5GWFNCZjR1d21Ja1pUck0zYXhkSFZWZ0JDUmQ0K1lwdFNnb21Zdkh5NUlJ?=
 =?utf-8?B?bytObVRrMHozZGYyZmFOVDhzajJhRnBUMFY0RTJqa0xYQ2xhMytBT2lWODNw?=
 =?utf-8?B?UDhGdDQvcUhnPT0=?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?KytyYmw4elZuZnpFRUJ5NHZQOHJOL1IreHU0MTcveU1rSENRay8wRHZlUVhn?=
 =?utf-8?B?d2RqaXJ0NlZkaVljY1hxWU90ZkU5SVBjUjh3MGVyaVVPUElJU2k5bVYwaGVp?=
 =?utf-8?B?Q1ZveWdZTWpQS0ZwdmtwaW5YenlVZndzUXE5SWowdG9Pb0l1d3JGZU53U0px?=
 =?utf-8?B?akpwekhjNjVYTDdvUlhqWjBaRmFpZkxBS0VKbEVRc3dHYmxhaVpXOUhaUExn?=
 =?utf-8?B?U3lRUm0yT1ZOSk83YmdqakF3VDhXUGVyeEJJb1pnTWFqZmlWYWhDTUpiSFpr?=
 =?utf-8?B?VTRLQmtvdDUyRC9vUHNwMmFjMHVCTjdJWEQ4OEd1ZlJpc3BSaXVObVhjdjhr?=
 =?utf-8?B?MzhOM1FiL0hSdENvcjFYTTZiaUV3RnJpakgwVHhZNlZBcGFvOUJsMXZNZGpv?=
 =?utf-8?B?RUhhN3VtRmk5Nm92elJ2Y2VJeGZwcjFEcVJrVTFmRFFVZWJmUmt6Z3lmNFpM?=
 =?utf-8?B?Tkg3YzJoY0laUEY0OGsrZDU2VVg2SndPTWhUR1BSUkUvZmduQXBDcm95QmR6?=
 =?utf-8?B?OGlsMExLUnMrWXpUTDdhSC9ZTnRyZUdodzY4QjJBVGNTcVF5Y2lzRkV1RDk5?=
 =?utf-8?B?eExuODR0aXd0L3hVbEhoZzNXelFTbnlCN0JhODZOYU5HWm9Cb2p3b29QRlo2?=
 =?utf-8?B?d2Y4eURKVk5jSVlSdHpJS3NQYzdKYzFLMUtqUHc5WW9ld2U0amt1dU1Zck5t?=
 =?utf-8?B?Z0FSY0pmdlZWUnpUc2prZ0NaNmV6UEV3N0U0dmV6cGZpc3JJMmVTS29sOFJy?=
 =?utf-8?B?NDBzWXZITkY5L3YwbzNnOW1pUVFPUTFvY0lFRGs5K2hOdXBWK0t4Rzk4OC94?=
 =?utf-8?B?SlBOeWhRdEZXd2FRZllSU0xZbm4zK2tlRVFDVEM0cEpCWm1ldTlPYVlyYzVr?=
 =?utf-8?B?Y0ZhbGlhQ3lzUFp5eWd3Qm1Zc3FhTWhMc0hSeWJHNXFzRXFzSDNqKzZ4aVdU?=
 =?utf-8?B?TGhQVHpBd3c2YTFDUHBmQ0poUnlGODV3VzBtNUtIdHp5MlRrRjNVVWZUTjVw?=
 =?utf-8?B?cTRlTkQ2T1BBdFovUDlQdnUzSkhKSDQ1bk9INFVYOXNjR0ExUjZZRGNRVzh0?=
 =?utf-8?B?bUVHVlVPcDFwbitTbUEyb01mdnpwbml5eC9MNFFwYmtmWHB3OURGdTFvc2k3?=
 =?utf-8?B?cXRDYU1BRTVuY25TTUJhWUhmckthZitsZVUzYllXeXcwV1gzdXNvbFVRTi9w?=
 =?utf-8?B?Vi9uT2VkUkE4OFBJNTlDRC9WOWdlUlZ1QXZJVnF2UjRnMEFNdEdyV3c0dXpH?=
 =?utf-8?B?UlRqM0JHY3FDVURmRWlVTHFKWWpJWnc4dVh0OXRoZnExM1JvZ09LNGlTQ3FT?=
 =?utf-8?B?S3NVSmVIbU4yaEkvcjlVV1YrSXVJTk5yY1Q4eGtHUG52QTdXWmFNaWYvN25L?=
 =?utf-8?B?ek9aQ2tLeng3dU0wNkVpOWpYWnJlZTlCeXNjZytZYkdvaC8wVitBb0FmTXdh?=
 =?utf-8?B?aHpZMk1rbHhXZExIemVQN1FNNXE0bVdRMFBLbU12OWcrYmp5THVqWnZ4TmVO?=
 =?utf-8?B?QmR5R1FNWGI1OC9EMFdHVkF3OGpocHdkNThDOGEwYWVuOWNybHhXOU5WbHRz?=
 =?utf-8?B?RTJleVl5TUQwbjRTWUNzaWtNOHlsVHA3dnRLWHQ2bFVISXBlWTdlQ0U5K2Z6?=
 =?utf-8?B?Qjh6cW5uY3BOejNxZC84WUMxdFRsaVJsQ3dFVkhEelF4azJBMlZLMHNoYnJ6?=
 =?utf-8?B?LzJzcHdrWmJTWmwvQzNjVFhJenJiN04yd3pJNVhSZTJrQitHdHh6NGpFcExs?=
 =?utf-8?B?L2RwSlNnUWNXYkdPMWs3eE50SDhmRGdRaVBSWGNsc3ZudzNjZkZaVUhYTlhz?=
 =?utf-8?B?cWtxaksrNWNlRmVMdU9nbHhERnN0TXhsRjA1L1FZc0x1S0dLQlc0dHIxL2xE?=
 =?utf-8?B?WHJ0VjJSN1JEK1FiMDQxUGtydm5wQkxkRUZnTWtRT25ZNmt0a2dsbm1YL3Yz?=
 =?utf-8?B?SWVnaVUwOTRzSVZiREQ4ckRuUTN5Z20yS2NnU1NQeCtOUXl5QWNoRmdlbW9q?=
 =?utf-8?B?QStkSHR2eFhRY0hISCt6dlJhQ3VIQzNjbDRWL3hieEg2SkVpVXZ1by9FYk1i?=
 =?utf-8?B?SzZneHB0QXpyRkl0QkczT0FEYys4aWRwK25sOUxqMzUyQzhZRStMM3JGc1Nh?=
 =?utf-8?B?TE4yaVo3YS9EcDJqdWFzekJOMlZyMGNGUjlqMUEySEJBcFc1M2dnRXAwM3Yz?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f328cc-f15e-4d79-1f4e-08ddc3a63eec
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 13:48:14.3867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KVPkIPayy/l6YbHIg9ZGaTM7KeeFiR6Wy3rbLNHwcELvBJhQjTYzxDtO0n4avIDFEhoFR+/JPp06xDtGVVJJqnWNtLZC9O1Mw8TOgA1w7Ws=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB14132
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 15 Jul 2025 13:48:27 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19541

SGkgSmFuLA0KDQo+IEZyb206IEphbiBLaXN6a2EgPGphbi5raXN6a2FAc2llbWVucy5jb20+DQo+
IFNlbnQ6IDE1IEp1bHkgMjAyNSAxNDozOA0KPiANCj4gT24gMTUuMDcuMjUgMTA6MDYsIG5vYnVo
aXJvMS5pd2FtYXRzdUB0b3NoaWJhLmNvLmpwIHdyb3RlOg0KPiA+IEhpIGFsbCwNCj4gPg0KPiA+
IENJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY2LjEuMTQ1LWNpcDQ0
Lg0KPiA+IFRoZSBsaW51eC02LjEueS1jaXAgdHJlZSBoYXMgYmVlbiB1cGRhdGVkIGJhc2UgdmVy
c2lvbiBmcm9tIHY2LjEuMTQxIHRvDQo+IHY2LjEuMTQ1Lg0KPiA+IFRoaXMgcmVsZWFzZSBhZGRl
ZCB1cGRhdGVzIGZvciBpaW8sIGNsb2NrLCBtbWMsIGlycWNoaXAsIGFuZCBkcm0gb24NCj4gUmVu
ZXNhcyBBUk02NCBTb0NzLg0KPiA+DQo+ID4gSW5mb3JtYXRpb24gYWJvdXQgdGhpcyByZWxlYXNl
IGlzIGFzIGZvbGxvd3M6DQo+ID4NCj4gPiAgIHY2LjEuMTQ1LWNpcDQ0Og0KPiA+ICAgICByZXBv
c2l0b3J5Og0KPiA+ICAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQo+IA0KPiBJcyB0aGVyZSBhbiBpbmZyYXN0cnVj
dHVyZSBoaWNrdXA/IEknbSBub3QgeWV0IGZpbmRpbmcgdGhlIHRhcmJhbGwgb24NCj4gaHR0cHM6
Ly9jZG4ua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3RzL2NpcC82LjEvDQoNClRo
aXMgb25lPw0KaHR0cHM6Ly9jZG4ua2VybmVsLm9yZy9wdWIvbGludXgva2VybmVsL3Byb2plY3Rz
L2NpcC82LjEvbGludXgtY2lwLTYuMS4xNDUtY2lwNDQudGFyLmd6DQoNCktpbmQgcmVnYXJkcywg
Q2hyaXMNCg0KPiANCj4gSmFuDQo+IA0KPiAtLQ0KPiBTaWVtZW5zIEFHLCBGb3VuZGF0aW9uYWwg
VGVjaG5vbG9naWVzDQo+IExpbnV4IEV4cGVydCBDZW50ZXINCg==

