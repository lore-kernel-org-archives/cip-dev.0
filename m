Return-Path: <christian.storm@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACBA109449D
	for <webhook@archiver.kernel.org>; Sat, 21 Mar 2026 21:01:22 +0000 (UTC)
Received: from OSPPR02CU001.outbound.protection.outlook.com (OSPPR02CU001.outbound.protection.outlook.com [40.107.159.26])
 by mx.groups.io with SMTP id smtpd.msgproc02-g2.19036.1774126873531993471
 for <cip-dev@lists.cip-project.org>;
 Sat, 21 Mar 2026 14:01:14 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=cG1PqDxA;
 spf=pass (domain: siemens.com, ip: 40.107.159.26, mailfrom: christian.storm@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=venWMc+vu6FT1oxcUxqqzRnsEoKENP0WRP/oRnXZluB5WK8fX9mOJM1i801Lf8qlBdSdc6DHEnZzTOJl+QkdMsZtxXG/EOuhhtSNXtQaySY53zx6ta9ywj6g9zlw82Gq976CUORHrJjCsyMwA61yUWAbyg4F2zPA4abV0JjVBVlud6mgjW+/bNSwVJmX6wKdOYVKtzyLJl83HcHFGMGsnfXEjZCGn44urML381hziXIltLHQ6UaJ/tiTW03LPiA6VF9bsiHzdOvUUQuo9tw3CNZttLdN6v2R+mZX4BvHfBcWtgUAuvIL6NBW/OagFE7UivRaz8Ney3d1VIvBPczUeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nPVBRfCnRRR1+JeihW2VK1h022UNtWhVAHf8VVrEpa0=;
 b=PnTKIMa36z/ziBaTS/YpLd/mlPTPOmDRWhDlNEZ3LAxlt/7keSZSWKQnGkkh+SE3W+W3PiimF75NR2oLvrXBwVwb+QNCz7qjoenfik9U4TjUBoUY0UDeowIUIxZaTB1ycsDgS/Rd1vcv1dLcW83+t1hCFSOEUt3AaYFSqaTaRsK+kXynbh/GjcaXPdirWzOIIXDGNm3TT/E38b4aKFXyhYsRXLl92y5pNAaB2+yzB22oFOx5/FKsZnkFiUX2folPncBTN+O0gKpJes7QeDMCrb8hhn4pjKwsSE6NLB0syvyX6lbdc6K+EJhQPocYRfFniRlhTQz3FS04WPnsy1IQCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nPVBRfCnRRR1+JeihW2VK1h022UNtWhVAHf8VVrEpa0=;
 b=cG1PqDxA2y+rWtxn8S2tdvmBCjgj38aJ7zzEosouKBjIyMW1ns0hJW5NcBfEcTWT449qm1DtPzgJmG0RTKn8SHL9PFPyeiU+MPQYi/etDgWT7g1v7Cl18uYQYLYBqwZWgiJSphpqbnxeL8H250aSqWAqI/A4bGXpHt5wxEwH5/WK5K2/b8wiT1AegMugDvwHy/azmpeEwmIzLf6wyNj15LtXHo7v7BFwpDAZkxUykS30FIkvRyS7Dy1OehWVjrXbb02NCpvGJdby2Ta3osepLQHT0QujHy7Besq+34FkbHSTOMdK9ogCUWPBkXynIIUTxcGHNDBzlHvJcfkbrcu3MQ==
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::17)
 by DU2PR10MB7836.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:496::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.25; Sat, 21 Mar
 2026 21:01:08 +0000
Received: from DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::212:adbe:f7f4:84f8]) by DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::212:adbe:f7f4:84f8%2]) with mapi id 15.20.9723.022; Sat, 21 Mar 2026
 21:01:08 +0000
From: "Storm, Christian (FT RPD CED)" <christian.storm@siemens.com>
To: "Adithya.Balakumar@toshiba-tsip.com" <Adithya.Balakumar@toshiba-tsip.com>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan (FT RPD CED)" <jan.kiszka@siemens.com>,
	"shivanand.kunijadar@toshiba-tsip.com"
	<shivanand.kunijadar@toshiba-tsip.com>, "dinesh.kumar@toshiba-tsip.com"
	<dinesh.kumar@toshiba-tsip.com>, "koshiro.onuki.h55@mail.toshiba"
	<koshiro.onuki.h55@mail.toshiba>, "kazuhiro3.hayashi@toshiba.co.jp"
	<kazuhiro3.hayashi@toshiba.co.jp>, "Adler, Michael (FT RPD CED OES-DE)"
	<michael.adler@siemens.com>
Subject: Re: [isar-cip-core][RFC v1 2/7] wfx-onboarding-progress-client:
 Custom progress client for device onboarding with wfx
Thread-Topic: [isar-cip-core][RFC v1 2/7] wfx-onboarding-progress-client:
 Custom progress client for device onboarding with wfx
Thread-Index: AQHcsEalmq1tWtJJx06vvgYdyNq9uLW5ix+A
Date: Sat, 21 Mar 2026 21:01:08 +0000
Message-ID: <32CBE05F-35A4-443A-8985-AC0B64E559AD@siemens.com>
References: <20260310044554.990348-1-Adithya.Balakumar@toshiba-tsip.com>
 <20260310044554.990348-3-Adithya.Balakumar@toshiba-tsip.com>
In-Reply-To: <20260310044554.990348-3-Adithya.Balakumar@toshiba-tsip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB5404:EE_|DU2PR10MB7836:EE_
x-ms-office365-filtering-correlation-id: 14b617e0-f4da-4385-ba14-08de878cf975
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|13003099007|55112099003|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info: 
 jNAUigAtyGlSbs6+HDQZr3W7cjkSlAWa/beb/VqqBkS3HEb3QfYPR69ZUT6qaiKo3lDmlolddA5Sr+F7U4ZBVw1ZYgRrSJhTP0LOPdxvPVJtuNPoUUNtwKI37AjaTxaR/WELg1UlEXAA1pmGO99cmm5tNC+t5BWxdTGOvDn1ZeJRR0Ffh32DKYmZDLEJmZVRvYj9QTGy5c8kERji4Y9vHZoYdbM3LhWA6XO8yVbafivOYyBOW0xxi2289hGyNfO1m/EXmXFyPIkhg7b8ScYpXU/VeIw6eKWyBXFf8WnnHwhZm/CRAbtlOBjegrgnLGfa/oSpk63A4CqRL5yNEi358v7DuKYmmQ1odLK1PM+oXhHjmoVsbDhHvybJRAoXFjyiJn+BTJvLgMYj+WDvBXQ2xqRe/dW6kf7p1XbGGwGrJOZeEfVYMY7tRWSXR+jeRrtCcynVTAMHr/znCiOpUa+qbV4jsCtBvTQRhDVxrYS3ERn8Eg99f/H1x7Jd9lSDJGmN8HbBjW5QyHd+eKTq7NzaDR9hFrQzh+giIOBVOyNzO1j+dK9Tcwlo5P+qLf0oQ/9ZmryfsCcnA0qlZMUh645j8lLRVX9d6y+GbAsgkrdpTyOI71rBjMrcRiu7E1xoD62LGlDw5BH8Or8kUsWuApnuyB0JrZhuF4YmWYXbxYEIpFrVmYcbpogILtzeXyYSrTxsCDsey4Ma6gCorIK3Osg0/S1aOMlWAsPOH8aXBx8nitZuswUVwlnnl7TAMORcgne9
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(13003099007)(55112099003)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?UllzM1BIWko4bURNa2FNY3BieW4vdVpvRnhNcFNRdVpXUkVRa3FjUUpyaTd2?=
 =?utf-8?B?a1VyKzZUY29GZHhFKzV2N05pVXQ3dEpSUU9Ob0FseDI2N2FybjFXN2NVNWgy?=
 =?utf-8?B?WFZiNy9VWk8zVll6akVqN3NGSnNXZWlGN3NJUjB1TUllcXVOYURtamVqOEZZ?=
 =?utf-8?B?d3h6L0czTFNHcjA0RDhiVlI5K1JHQ1VvYXZXUm51d0luN1FRcU1XRm0rQm9L?=
 =?utf-8?B?ZGpLTmdmV3ROWUhTeU1Idy9KcFc3K3NDSlIxUGh1U0xtQlJBSUI2bHNZRjgv?=
 =?utf-8?B?OFhselh2a2FoNVBDY2RaRmNENlV5SzF2Qm9yVklGOVkvb1F5VVpnOHVjUDZW?=
 =?utf-8?B?WXV2dXIxTk1zN0lrb1cvdVJDcHZVR01hdEZCUzZYZE5YUlZDa2tpVGczYWV6?=
 =?utf-8?B?czdiZ2tLeTM3RzdKUGk1bGJRYnlBVkVPVndEQ3M1ekI0SGFPR1lqYTRGdmw3?=
 =?utf-8?B?V3VMZzlPVkJwUDAreGdld0pOQ1RWV2NCSzRuVHR3TkNaMm83eFZOengxUGVE?=
 =?utf-8?B?NW13N0ViSGQ3aUFLcE9BaDgrL09lK2FZK1QyNkZtQWVCcVRVVVJLbWREVkN1?=
 =?utf-8?B?dFZQdWNETnhwL1Y0NXU2Ujc5Vy8wRnJneWhkc2xTdlNoYUlQc2ZXWlZoRlpX?=
 =?utf-8?B?U2xQSjdUamJqZm1iejYzK3hsNjRSU2trejc0VUttZG1vQXZEZEJHOG5kR3pL?=
 =?utf-8?B?cHorTVpjdHNWeWtNRVV1MTJXOVd0S2tPb0l1SFV2SkZ2ajRBKzJLQ3ozcTBI?=
 =?utf-8?B?cTI3cmU1ZFlYY0pnSkEydDlqZ01qRitJVHhWbWhOcWVXUkp1NGpTK0R2cHlZ?=
 =?utf-8?B?UXVGanpyMUNvc2pLRmYwMG02N2tZcGQxd1BLL0JHZHc3OHUyMGVWTlRpTUxW?=
 =?utf-8?B?ZXdiS0NXR2RyTEJtcWZzR0xMRHZBbi9xNUtzbEZJRk42Wk5PMlRHRTFLL241?=
 =?utf-8?B?djNFZ2Vnc3k4MXgzZzFKY3diUG56VUtBU3o1cDNyL1F5SjRCUndUWkQ1NHRR?=
 =?utf-8?B?RXFFWjFjaXVRZkRpRElLWHppNkNFQmJ1M1J2aDB5VHpzdVhzdFZCNjJKdDhH?=
 =?utf-8?B?TXFURnJsT1U4bGpLN2tvUG1iM0J6VTZmYThud0JlQ2pub0Vxd1VvVm1wOFVj?=
 =?utf-8?B?bkYxcExkc3M1MDkyTk9PV25hWWg2NFRMMzJTa3RHR253QkJPbjRGZVR3WThv?=
 =?utf-8?B?L0ZnOVgvTmdscldGZEcranZxVVZNNUxDS0w4NTFUSlVtRE1lS01OL3M1N0Rh?=
 =?utf-8?B?UXpVTEtaaXhpNktORmdsOFhSMytTQVlvWk92UzFNSXovVTVNeEhmNm5URVhF?=
 =?utf-8?B?T3lVRVFZLysvcjduMFpGWjkrZ1pkNVA4SStBQUJmaVpiamUvL29TdEh5dUxl?=
 =?utf-8?B?eFpDbGJFaHQ3RlIyRjNSWU05YzQ2a2YyYnNGdm55NElsellKRFNKcWhLenZN?=
 =?utf-8?B?bWYvK1BNTGJqczFYOGdrVzFnWWdYRWpCVE13VSs2SnhIUFI3aUEvdnJRM3hj?=
 =?utf-8?B?eUY2MEZIVmxtby9jTm9ZY1NpT0s0TGJFR3NkWjRZb2FWYkMwdEdTeEp4S0JO?=
 =?utf-8?B?NDR4OWljMWpGdGZTRkc3WHl3MDYwdExUZ0VYbE9oRWZtUjhLR0hkNGZ4eGZI?=
 =?utf-8?B?cWI1WlhkaGhjdEM1Mmg3UldiMHBaZ0hhV1NhbVZlQjgvRGxXN2JaL3ZQWDlJ?=
 =?utf-8?B?Q3FhZmRRQ0ZZN1AzOFl4SFJQditPMjQwWUp1aHZ6Z2hnWTFGUVlWRXZMQ0h0?=
 =?utf-8?B?aWxQOEp6VVVxQ05RMzlaT1MxM0hoUXJ4OVU1aTJqSmRhSXpjQ3N3WUVMNGhE?=
 =?utf-8?B?YVFZRFR5cUxtV25qY3lybitVR1NCankwcS85R0MxVmx4QXRTUWZISkhScVNT?=
 =?utf-8?B?RlF4T2laU09WT3lGTXdiWFJnazF5Rzd1YWx2d3pXb09XUDM2NHVwa3Fab1FW?=
 =?utf-8?B?aVpKK3lZYW1UM1U5TVovMWdoNGRoL1d2K2RaSUoyMUcwRzNGTlNIdnBFMHJP?=
 =?utf-8?B?WE1IZEFXbGVjQUJwNU5laG1qK1I4MlRNV1BCaStCbURGOVg3aW1jeFpHSkNw?=
 =?utf-8?B?c3VXb0JYY2FrN1ZBeXdwNHF3bzlmUnFGZ1JmY0JBQVdjbnMrZmV0K2hQVm92?=
 =?utf-8?B?R3JhNFRCSlZ1OFBFeDZWVVI5QmNJY3J1aWs5WGdGSFlPMEovUlJoeTF0QzJ4?=
 =?utf-8?B?eGhYanQ3U1laMmZSODJDLzZjRTQwVkJWNisxMDBOUnFHczhiZTM4M3JUSFg4?=
 =?utf-8?B?M2dXdzdqcEN2c0sycmxtK1Rma1FQWExOdkZ2NVFtdDkrWC9DVFIweG1nRXV2?=
 =?utf-8?B?a05PU1FidkJ4cmo3T0Q0NHRvT1FvRDhoNVZoSDUrdEZKcTlqUU9aTWxHb0I0?=
 =?utf-8?Q?ibZCWnJLEQ7DWX7g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51C020AC60423C4F84CDD6DDDAB19C62@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB5404.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14b617e0-f4da-4385-ba14-08de878cf975
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2026 21:01:08.2910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxppBuy9RhNGbWEuAS7N9OoKzFkTbuAE9jxOAVZsbTrph4q/ZKpF2aRYujK7v0nFQp67IkpFvI/RUCA/SAXJyLrmvDeU7PyEqK5XInAhbSA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR10MB7836
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Sat, 21 Mar 2026 21:01:22 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/22521

SGksDQoNCj4gVGhlIG9uYm9hcmRpbmcgdXBkYXRlIGlzIHRyZWF0ZWQgYXMgYSBjb25maWd1cmF0
aW9uIHVwZGF0ZSBhbmQgdGhlcmVmb3JlIHdvdWxkIG5vdA0KPiBuZWVkIGEgYm9vdGxvYWRlciBz
dGF0ZSB1cGRhdGUuDQoNCkJ1dCBpdCBkb2VzIGdldCBhIGJvb3Rsb2FkZXIgc3RhdGUgdXBkYXRl
PyBEaWQgeW91IHNldA0KDQpzb2Z0d2FyZSA9DQp7DQoJYm9vdGxvYWRlcl90cmFuc2FjdGlvbl9t
YXJrZXIgPSBmYWxzZTsNCglib290bG9hZGVyX3N0YXRlX21hcmtlciA9IGZhbHNlOw0KCS4uLg0K
DQppbiB0aGUgLnN3dSBmaWxlIGFjY29yZGluZyB0byBodHRwczovL3NiYWJpYy5naXRodWIuaW8v
c3d1cGRhdGUvc3VyaWNhdHRhLmh0bWwjdXBkYXRlLWFjdGl2YXRpb24gPw0KDQoNCj4gQnV0IHRo
ZSBhY3RpdmF0aW9uIG9mIHRoZSBvbmJvYXJkaW5nIHVwZGF0ZSB3b3VsZA0KPiBuZWVkIGEgcmVi
b290IG9yIGF0bGVhc3QgcmVzdGFydCBvZiByZWxldmFudCBzZXJ2aWNlcy4NCg0KSXMgYSByZWJv
b3QgcHJlZmVycmVkIG92ZXIgcmVzdGFydGluZyBzZXJ2aWNlcz8gV2hhdCdzIHRoZSByZWFzb25p
bmcgZm9yIG9uZSBvciB0aGUgb3RoZXI/DQoNCkluIGNhc2Ugb2Ygc2VydmljZXMgcmVzdGFydCwg
d2hhdCBhcmUgdGhlIHJlbGV2YW50IHNlcnZpY2VzPyBJbiBodHRwczovL2dpdGxhYi5jb20vY2lw
LXBsYXlncm91bmQvY2lwLXdmeC1vbmJvYXJkaW5nLWNsaWVudC1wbHVnaW4vLS9ibG9iL21hc3Rl
ci9vbmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudC9vbmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudC5j
IHlvdSByZXN0YXJ0IFNXVXBkYXRlIG9ubHkg4oCTIHdoaWNoIGlzIGRlZmluaXRlbHkgaW4gdGhl
IHNldCBvZiByZWxldmFudCBzZXJ2aWNlcyA6KSBJbiBvcmRlciB0byBub3QgaGFyZC1jb2RlIHRo
aXMgYXMgaXQgaXMgbm93IOKAkyBhcyB0aGVyZSdzIGFsd2F5cyBhIHNlcnZpY2UgbWlzc2luZyBh
bmQgd291bGQgcmVxdWlyZSB0b3VjaGluZyB0aGlzIGNvZGUg4oCTIEkgd291bGQgc3VnZ2VzdCwg
Zm9yIGV4YW1wbGUsIHlvdSBkZWZpbmUgYWNjb3JkaW5nIHN5c3RlbWQgdGFyZ2V0cyBpbnRvIHdo
aWNoIGFuIGludGVncmF0b3IgY2FuIGhvb2sgYWRkaXRpb25hbCBzZXJ2aWNlcyBzbyB0byBtYWtl
IHRoaXMgc2V0IGNvbmZpZ3VyYWJsZS4NCg0KDQo+IFNldHRpbmcgdGhlIGZpcm13YXJlIHRhZyBp
biB3Znggam9icyBkb2VzIHJlYm9vdCB0aGUgc3lzdGVtIGZvciBhY3RpdmF0aW9uIChzZWUgWzFd
KQ0KPiBvZiB0aGUgdXBkYXRlIGJ1dCBhbHNvIHVwZGF0ZXMgdGhlIGJvb3Rsb2FkZXIgc3RhdGUg
d2hpY2ggaXMgdW5kZXNpcmFibGUgZm9yIHRoaXMgdXNlIGNhc2UuDQoNClRoZSBib290bG9hZGVy
IHN0YXRlIGlzIHNldCBieSBTV1VwZGF0ZSdzIGluc3RhbGxlciBjb3JlIGlmIHRoZSBhYm92ZSBm
bGFncyBhcmUgbm90IHNldCB0byB0aGVzZSB2YWx1ZXMgaW4gdGhlIC5zd3UgZmlsZS4NClRoZSBi
b290bG9hZGVyIHN0YXRlIGlzIHNldCBieSBzdXJpY2F0dGEvd2Z4IGlmIHRoZSBgZmlybXdhcmVg
IHRhZyBpcyBzZXQgaW4gdGhlIHdmeCBqb2IuDQpTbyBhbiBhY2NvcmRpbmcgLnN3dSBhbmQgbm90
IHNldHRpbmcgdGhlIGBmaXJtd2FyZWAgdGFnIHdvbid0IHJlYm9vdCwgc2VlIGh0dHBzOi8vc2Jh
YmljLmdpdGh1Yi5pby9zd3VwZGF0ZS9zdXJpY2F0dGEuaHRtbCNqb2ItZGVmaW5pdGlvbiBhbmQg
aHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMvd2Z4L2Jsb2IvbWFpbi93b3JrZmxvdy9kYXUvUkVB
RE1FLm1kI2pvYi1kZWZpbml0aW9uIGZvciByZWZlcmVuY2UuDQoNClNvIHlvdSBjb3VsZCBzZXQg
dGhlIHNvbGUgd2Z4IGpvYiB0YWcgYG9uYm9hcmRpbmdgIGFuZCBubyByZWJvb3QgYnkgU1dVcGRh
dGUgd291bGQgaGFwcGVuLg0KT25seSB0byB0aGlzIHNwZWNpZmljIGpvYiB0YWcsIHlvdXIgY3Vz
dG9tIHByb2dyZXNzIGhhbmRsZXIgYWN0cyBvbiBieSAocmUtKXN0YXJ0aW5nIHRoZSByZWxldmFu
dCBzZXJ2aWNlcyB2aWEsIGUuZy4sIGEgc3lzdGVtZCB0YXJnZXQgYXMgb3V0bGluZWQgYWJvdmUu
DQpXaGVyZSBpcywgYnkgdGhlIHdheSwgdGhlIGRpc2FibGVtZW50IG9mIHRoZSB3Zngtb25ib2Fy
ZGluZy1wcm9ncmVzcy5zZXJ2aWNlIGRvbmU/IE9uY2Ugb25ib2FyZGVkLCB0aGVyZSdzIG5vIG5l
ZWQgZm9yIGl0IGFueW1vcmUsIGlzIGl0Pw0KDQoNCg0KPiBIZW5jZSB0aGUgbmVlZCBmb3IgdGhp
cyBzaW1wbGUgbW9kdWxlIHRoYXQgY3VycmVudGx5IGp1c3QgcmVzdGFydHMgc3d1cGRhdGUgc2Vy
dmljZSAgZHVyaW5nDQo+IGFjdGl2YXRpb24gb2YgdGhlIG9uYm9hcmRpbmcgdXBkYXRlLg0KPiAN
Cj4gWzFdIGh0dHBzOi8vc2JhYmljLmdpdGh1Yi5pby9zd3VwZGF0ZS9zdXJpY2F0dGEuaHRtbCN1
cGRhdGUtYWN0aXZhdGlvbg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWRpdGh5YSBCYWxha3VtYXIg
PEFkaXRoeWEuQmFsYWt1bWFyQHRvc2hpYmEtdHNpcC5jb20+DQo+IC0tLQ0KPiAuLi4vZmlsZXMv
cG9zdGluc3QgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNCArKysNCj4gLi4uL3dmeC1v
bmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudF8wLjEuYmIgICAgIHwgMjYgKysrKysrKysrKysrKysr
KysrKw0KPiAyIGZpbGVzIGNoYW5nZWQsIDMwIGluc2VydGlvbnMoKykNCj4gY3JlYXRlIG1vZGUg
MTAwNjQ0IHJlY2lwZXMtY29yZS93Zngtb25ib2FyZGluZy1wcm9ncmVzcy1jbGllbnQvZmlsZXMv
cG9zdGluc3QNCj4gY3JlYXRlIG1vZGUgMTAwNjQ0IHJlY2lwZXMtY29yZS93Zngtb25ib2FyZGlu
Zy1wcm9ncmVzcy1jbGllbnQvd2Z4LW9uYm9hcmRpbmctcHJvZ3Jlc3MtY2xpZW50XzAuMS5iYg0K
PiANCj4gZGlmZiAtLWdpdCBhL3JlY2lwZXMtY29yZS93Zngtb25ib2FyZGluZy1wcm9ncmVzcy1j
bGllbnQvZmlsZXMvcG9zdGluc3QgYi9yZWNpcGVzLWNvcmUvd2Z4LW9uYm9hcmRpbmctcHJvZ3Jl
c3MtY2xpZW50L2ZpbGVzL3Bvc3RpbnN0DQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4
IDAwMDAwMDAuLjBkMzllM2ENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9yZWNpcGVzLWNvcmUv
d2Z4LW9uYm9hcmRpbmctcHJvZ3Jlc3MtY2xpZW50L2ZpbGVzL3Bvc3RpbnN0DQo+IEBAIC0wLDAg
KzEsNCBAQA0KPiArIyEvYmluL3NoDQo+ICtzZXQgLWUNCj4gKw0KPiArc3lzdGVtY3RsIGVuYWJs
ZSB3Zngtb25ib2FyZGluZy1wcm9ncmVzcy5zZXJ2aWNlDQo+IFwgTm8gbmV3bGluZSBhdCBlbmQg
b2YgZmlsZQ0KPiBkaWZmIC0tZ2l0IGEvcmVjaXBlcy1jb3JlL3dmeC1vbmJvYXJkaW5nLXByb2dy
ZXNzLWNsaWVudC93Zngtb25ib2FyZGluZy1wcm9ncmVzcy1jbGllbnRfMC4xLmJiIGIvcmVjaXBl
cy1jb3JlL3dmeC1vbmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudC93Zngtb25ib2FyZGluZy1wcm9n
cmVzcy1jbGllbnRfMC4xLmJiDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAuLjk3ZDU4ZGMNCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9yZWNpcGVzLWNvcmUvd2Z4LW9u
Ym9hcmRpbmctcHJvZ3Jlc3MtY2xpZW50L3dmeC1vbmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudF8w
LjEuYmINCj4gQEAgLTAsMCArMSwyNiBAQA0KPiArIw0KPiArIyBDSVAgQ29yZSwgZ2VuZXJpYyBw
cm9maWxlDQo+ICsjDQo+ICsjIENvcHlyaWdodCAoYykgVG9zaGliYSBDb3Jwb3JhdGlvbiAyMDI2
DQo+ICsjDQo+ICsjIEF1dGhvcnM6DQo+ICsjICBBZGl0aHlhIEJhbGFrdW1hciA8YWRpdGh5YS5i
YWxha3VtYXJAdG9zaGliYS10c2lwLmNvbT4NCj4gKyMNCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IE1JVA0KPiArIw0KPiArDQo+ICtpbmhlcml0IGRwa2cNCj4gKw0KPiArU1JDX1VSSSAr
PSAiZ2l0Oi8vZ2l0bGFiLmNvbS9jaXAtcGxheWdyb3VuZC9jaXAtd2Z4LW9uYm9hcmRpbmctY2xp
ZW50LXBsdWdpbi5naXQ7cHJvdG9jb2w9aHR0cHM7ZGVzdHN1ZmZpeD1jaXAtd2Z4LW9uYm9hcmRp
bmctY2xpZW50LXBsdWdpbjtuYW1lPWNpcC13Zngtb25ib2FyZGluZy1jbGllbnQtcGx1Z2luO2Jy
YW5jaD1tYXN0ZXIiDQo+ICtTUkNSRVZfY2lwLXdmeC1vbmJvYXJkaW5nLWNsaWVudC1wbHVnaW4g
Pz0gIjU3MzJiY2U4YWUyZDFkNzQ0ODI3ZDQyZTAwY2MxM2JhMjUxYmY3NWMiDQo+ICsNCj4gK1dG
WF9PTkJPQVJESU5HX1BST0dSRVNTX0NMSUVOVCA9ICJjaXAtd2Z4LW9uYm9hcmRpbmctY2xpZW50
LXBsdWdpbi9vbmJvYXJkaW5nLXByb2dyZXNzLWNsaWVudCINCj4gKw0KPiArU1JDX1VSSSArPSAi
ZmlsZTovL3Bvc3RpbnN0Ig0KPiArDQo+ICtkb19wcmVwYXJlX2J1aWxkW2NsZWFuZGlyc10gKz0g
IiR7U30iDQo+ICtkb19wcmVwYXJlX2J1aWxkKCkgew0KPiArICAgIGNwIC1yICR7V09SS0RJUn0v
JHtXRlhfT05CT0FSRElOR19QUk9HUkVTU19DTElFTlR9LyogJHtTfS8NCj4gKw0KPiArICAgIGRl
Yl9hZGRfY2hhbmdlbG9nDQo+ICt9DQo+IC0tIA0KPiAyLjM5LjUNCj4gDQo+IA0KDQoNCktpbmQg
cmVnYXJkcywNCiAgQ2hyaXN0aWFuDQoNCi0tIA0KRHIuIENocmlzdGlhbiBTdG9ybQ0KU2llbWVu
cyBBRywgRlQgUlBEIENFRA0KRnJpZWRyaWNoLUx1ZHdpZy1CYXVlci1TdHIuIDMsIDg1NzQ4IEdh
cmNoaW5nLCBHZXJtYW55DQoNCg==

