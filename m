Return-Path: <stefan-koch@siemens.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76074C2BD09
	for <webhook@archiver.kernel.org>; Fri, 12 Jul 2024 10:10:41 +0000 (UTC)
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (EUR03-VI1-obe.outbound.protection.outlook.com [40.107.103.51])
 by mx.groups.io with SMTP id smtpd.web10.4544.1720779035509541385
 for <cip-dev@lists.cip-project.org>;
 Fri, 12 Jul 2024 03:10:35 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=I68asDRN;
 spf=pass (domain: siemens.com, ip: 40.107.103.51, mailfrom: stefan-koch@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dxvxl+8heTn6XjYpKvZ2yHrxY++E172eviGF3o4cD4Qq5QBeUiYmaKBPSxPg3srioT1YZStsWCJwc1CAeHXLoEvmHP/wpqh8vUuqywnOKFzrxQgL+jmaKDtEh+aIqAvda1zWLvZEZSYB/LXXoBdEAkhK5qZVL2Rnk7TG/lmJiKMaK39i8YuAsS+0ywMXfEzXi/SoHUTFKXaN82ZQ8CqvKdWADNVg4JPSlU7x2UfeGOwN17RKjgFOoYck+bmxNw6kvA02dsFGkiytmjOFaVw4nsjdZ141IKF5iHbuYKvxNxAL/q1n4FFkTl85sJ5tk/IhsuhKcVR/m5cxvyngwtyiAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpLv1pXagB1dv3p+Mh4F8igpFGMClfbVh9SG8TP4EPI=;
 b=Rzt1jxBlJtupW5oH53cVJBITvgjR+kx/QzthhRot1BDL5k7mZWKkEOGw49X5W+mPDCNIiZDmF7sNpAR3l0/VzyXZSks/q92yk/afQ3efmZXoWWEWMm+Jp1wb9eRtSJObTRj/mFPTSdRLld+nLt3+bJ4kUH8MOt/etzjOSZXBxz0+ealIVk2j1B0P1/EzPk0Y9zlQfDTkcDspBvz+psL/UY8L0QZQEIX2E7KmyJ9gigFwUXJy6KpsW+oNzJllItK44u7nKuRZNDehpcZwRz2Psq3kguGQbiexBvqm9qqgFNWgFKW8z7xIuYeS7z4gQcO5FUdELKwYRrxCvsaPjx1ATw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpLv1pXagB1dv3p+Mh4F8igpFGMClfbVh9SG8TP4EPI=;
 b=I68asDRN1v1xWpNJ8zhJp9odJd7IkTNeShxLzxxkX++tmGGp1Go7V0euWUuhIsx3FTYaqF7juw4QG9gPdLPKVald+N83PXdiHq0G4tvTErd8FEQ6S5HNrogzrAcYYL/T2x7JuiNlCIFkxLNWmmxiQ7hdDrX9UEjdjh96UzSe+BZV0ZPgzE/JSkUF77sLNH9dvhPiobEkyLEvEZlOazSsk5oI/xlaOkLXhxyTbL0my7Gml91z2fJSdDVlA2CZSoAPYk2U2T+9eWL743lAn9m27FsmU2W/ACfPhSchAt8l099iWzbDGh7dN5Gg9/2V3EmnnL6T8EER32klXWw5Xwbwow==
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:2c2::14)
 by DU0PR10MB6225.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3ec::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 10:10:32 +0000
Received: from DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46]) by DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::f75d:ad6e:d321:cc46%4]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 10:10:32 +0000
From: "Koch, Stefan" <stefan-koch@siemens.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>, "Kiszka,
 Jan" <jan.kiszka@siemens.com>
CC: "Sudler, Simon" <simon.sudler@siemens.com>, "Storm, Christian"
	<christian.storm@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>, "Adler, Michael" <michael.adler@siemens.com>
Subject: Re: [PATCH 4/4] initramfs-crypt-hook: Add missing mountpoint
 executable
Thread-Topic: [PATCH 4/4] initramfs-crypt-hook: Add missing mountpoint
 executable
Thread-Index: AQHa1DMpHDZYHmtl80aOjEIaoZYea7Hy090AgAAJ4oCAAACSgIAAALyA
Date: Fri, 12 Jul 2024 10:10:32 +0000
Message-ID: <a453411c8f9534b918b9c3a644dd1d5a1bd78699.camel@siemens.com>
References: <20240712081143.1376952-1-stefan-koch@siemens.com>
	 <20240712081143.1376952-5-stefan-koch@siemens.com>
	 <9e19021b-d2d6-4319-aab4-e9153bead57e@siemens.com>
	 <6a3b533913e5f116cc6f402bbdd298457ca00b97.camel@siemens.com>
	 <dbcb5097-d3e6-4a9d-ba45-67b9ff908fda@siemens.com>
In-Reply-To: <dbcb5097-d3e6-4a9d-ba45-67b9ff908fda@siemens.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR10MB4953:EE_|DU0PR10MB6225:EE_
x-ms-office365-filtering-correlation-id: 7671bf55-fc5a-41b0-7529-08dca25add35
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?RzlxTG5yY0xIODVGeHFzdWpsSzdIOGpGNkFmZ3p3MFlkbXVUcm5YMngrdkR2?=
 =?utf-8?B?UXJJaEttT0ZtT0hDcGxISy9VQmJ0MnF5dTZaQjVxc0dRR2cvNEY4eU1nYTJ6?=
 =?utf-8?B?cVFvWkthN055QzNoUXN2VlZIOXZDQU13em1RWWRuMzB3by9uQnM1WGhBUk5O?=
 =?utf-8?B?bmprOWxMeTcwc01rZHY1b2E2a1JJWUV3WXArTU5JeXQyL0ducVpVS1VGdkNE?=
 =?utf-8?B?eVNyU1FiWmE2aDFPTmUxbmNjUHM2cVk4akFiVzBhTVk2bk1oQmljM1VkWGVO?=
 =?utf-8?B?UFVjbklQZ251czZJc3JaM0hFQzRwZzJoQVUrV0FDckNBQnMvYWdGbnpUeWdE?=
 =?utf-8?B?K29XVUU4YUhQemU5dHMvcWNEcHRKMHgwbll3emx1dkZ2M2FiRGIramFKQm5L?=
 =?utf-8?B?aUVTcldWUVB1WnFwa2x0QmRFRU5IM0lpajJ6MkZnOTZzOEJJbE9Jd0pTZ29t?=
 =?utf-8?B?ZnhUM2x6U1VDVDNUN1NES282ZFdKVHFlNXV3RXhlWkNidWFlRjNSK0d3bnUw?=
 =?utf-8?B?d0YxL1ZlZzF6anp3cVhZSnRYL3ArQ3Vjcy9RWHdsR2NSNTdxcWU2M2xJekZ6?=
 =?utf-8?B?Yy9WNThmZ0hqYzVPRWRDcjFBaVhaMHZpWHdLUmRBQVllR3NScFVIQ2t0bUF4?=
 =?utf-8?B?b1pEdVFNT3RjM3lncU9HSHE5UzRmTm0wV1RkM0R1TzF4RkVIMEMrcnBGOXRp?=
 =?utf-8?B?S3kwaDJUVFBrVEt2c1NsbDZSZTNESExYeEc1ZFZ3SnNNY0luSXFhVWU3cUpy?=
 =?utf-8?B?MFVGZ05QZU9VWjgxOW00cUNNM3dCNHp0TzV2bHlzZkR5aVR3dnl2cnVhd01U?=
 =?utf-8?B?WTVMdVh2RXVSU1N4Y2xsQWh2YkRTZ2dyNm9HM1FZbFc4TldhckFCTnZiYTc3?=
 =?utf-8?B?TkpaVUlnWk5IZjRwK2dXdXVBSWtMb1RQZWZlRExhYjR2V2s4TkVEcStmdG5K?=
 =?utf-8?B?UCs3T1lnNCs0MWRqZmtOKzBIaFNPQTVnZFFORGZsWFo1US9DQU9EeUdtb1dX?=
 =?utf-8?B?dFRxN0hFOEJ5S2V1U2IyYjZmSHZnZGNDbG1MNzFpUFV5N1lxTC9wRUVuRVF3?=
 =?utf-8?B?Ym0xckUyN1Y5Z0ErSXJOdURJUitQZi93b29RUGZPeDlDUFc1dHJTL1h6c0NU?=
 =?utf-8?B?bWFsaG5jRFJsWnRKb1lUVGtMQmp1bEM0RFdZdkwrVlowVUtYV0NmYUFkSGxh?=
 =?utf-8?B?MkUreGJVY01nQzZkaDBXUHlYTElnam1KRkI2NFZpS3VQbDladWg1aHh0ZnlN?=
 =?utf-8?B?TFBvREZoRVFiQXoxcURhUHZuS3FseE81QWlHZFFOMFc0ZCsrcnNLeHhSQllK?=
 =?utf-8?B?eml1U0FxR1ZBTVhqWGlLd0UxckdvOURXdzVWYUlhY2NqM2E4MEtuZStyUWRm?=
 =?utf-8?B?L042NEg1QzdBTE9TZmp3UGJxTWV5ZjZmdUE1VzBMWTBRZ29tMU9uQ0xicVRi?=
 =?utf-8?B?aE14dkxaNlNvWVJueS90L3hCVEc1VjQrblNUeS9PQkUyWHNqUWFLU1YwL1ds?=
 =?utf-8?B?aWs2QjZBclNvRmx2cnpFZ2dCZ0dYTFFzSGh2SGdyNEMzTnl3TWJxTHpRbVdJ?=
 =?utf-8?B?ZVBYNHdDZXcydVBQWFl2QUZGdU1HM1NxWUdjTUpyRlh5T2dVdjc5SnNEK3Vq?=
 =?utf-8?B?QzVYMndhYnhVYTdCN2dWQVQ3Mnl1S2ljck1wTSszUXpuazJqa3B5b0wxcGIz?=
 =?utf-8?B?NzZQM1M4Um9zZkp0WTNsNk5FRThxT2JaRVo3S3NLR29nN3JkNlpyTG50eGNG?=
 =?utf-8?B?NGdJa1pEODBZaVNlNEhLVG53U1BiVkt5NlQzOTZoQ0pjMXB0Q3JMRys5bEoy?=
 =?utf-8?Q?kapyyheXtufsIxXVsyoOp5Yr+crqiBXkBPL/c=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?eC9sb3R4YUREL2oyNmZQMHhwOUlhWEJsN3U2TEdBRlVjNno4eGJENFpaUFUy?=
 =?utf-8?B?eEs3LzgxUys5ZTJlbVAzUkJrMjQzc1lVdGcxd3RJUTVuZnBmV2xLK3RJUGdi?=
 =?utf-8?B?L0Njak5sR1VUUmJiSXdpN3dSeTN6ajR6YllkajFKUmxTRTJBZ1d4TGpUQm0v?=
 =?utf-8?B?VjFyZzBCVkhNU29Vd1NiSnU4RFNhMWVlK0lqZ0FXVjV1Y1hzMnIzbjVqWFRR?=
 =?utf-8?B?WnFsWnpYSGdvNCtxRnNxb0xsMUh0OVNIZTQ4UCs3cFkxQmY1VEZxc1FDVEhV?=
 =?utf-8?B?WG1oWkFzT0dpaHdldmorRHZLMGxHTTkzNTRTUzZBMEh5WGxHMVQvMmc5TDdD?=
 =?utf-8?B?V1lwNlBNb2xMZGc1NHVDRlBkSTJGSUVjUUxBSTh2WWJKRnZOTkEyK1EvZ21a?=
 =?utf-8?B?ZG8zSVNwa1dOUjlId21PVHZydDVOVHBsL2xtNHBEejZYQXVkOHhGMHB6eElN?=
 =?utf-8?B?TEFocjhrYjBIZlBWM3MrVFlTUHU2VXJMbEJQNGk0UW1tMkFJeTN5UzRKMUI0?=
 =?utf-8?B?RTAvMWdZQmlPV2VOYW9jRVdmOC9janhBTWgybDltM1REeFNOcm5SMCs4Q01Y?=
 =?utf-8?B?OG54ZGV3dFZjY3dWZmxIdTROVElJZmthOGZzbVprekVTZG5CalA3aE1DVkxB?=
 =?utf-8?B?RXZ0NHpDaklEbVUwTjZvZ1UxM1FIUXE5bEZKSThLemZicnRuajB6bkFVZWV2?=
 =?utf-8?B?UzBKQWtyZUsvRS9zKzd6V3NFbHEzNkJXRTFYdElFSkFPY21TYW9LTmJ3ei8y?=
 =?utf-8?B?NFFVL0tuaURsYWFXUWRtTlhTRUJ0aU4zNnVobFdndksvbDlFZjNpcmZVV0ha?=
 =?utf-8?B?eW8ydEpxbzRDT0JVSW5hOW1QaWNnd2xzY202allRV29xZkdid1VIZGltV2FQ?=
 =?utf-8?B?b1lJcmNXRy8wWkZRWStiWlBhZWNIL1p3UWpqNHJOc29NbHI5N2RmUktXRlF4?=
 =?utf-8?B?YlVDQlpWenBNWi9IdkNiQWEvOUNRUlYyL0hqUlgxU2RIRHVQVitGdXQzakR5?=
 =?utf-8?B?VTQ3Tjg1QXVhWUJIOUlLTWh2U2N0bmNqOVBUeElzKzdDYnlnNXZYbGhraFZk?=
 =?utf-8?B?UGRwOXRXWit5NG92S3dwZzVsNzJoZnBOSnpLYS9kRjRXNFVJZlhGdDl6eGti?=
 =?utf-8?B?K3lnTzJPaitmQVNtMTFTVXk5aGR2NHo1WVZnUUE4SHFOdzJmMjA3UVN4T1N5?=
 =?utf-8?B?UmtTRjgyaVFZRERQcWFQNVZkZk5Zb1hrY0RjcFV4UmJYM05NeWlqWDk5Tjll?=
 =?utf-8?B?eHVHWjhIWlJWSmVNM1hFSnVCU0FJZ2diU2xvS1BSS0VIYklhRXNlNmhWZ3BF?=
 =?utf-8?B?dWM5SlN0RE1Zd3FFRXZvRFlGWXRxMmloS1ZKZVpMNEV0RXNzaFlmRDBUQWw3?=
 =?utf-8?B?TVVKWmg1L25JOTVsZ3VvSU5xdGhqSVl1RklCU2xlYTRCK3FldlhqRU5lYXdX?=
 =?utf-8?B?SENwRWh2REVOYVVETldEeDU3UlUycXVEM0QyREpvWVpqMEtodmtwN1RzTFJv?=
 =?utf-8?B?a3d0dis2dFFaS0V2azQ4TlNJWGJDakVSK3hTQU9zT1JkeWlhQ0liejlIcUl5?=
 =?utf-8?B?VVV4ZDVEQ3ErdVVsTFZ5WUVXb0laT21jRGNlaVl0dmV3UUZKQTkvT2FZS2RO?=
 =?utf-8?B?WlR2WEM3MyttRy93Z0toMVdWalpHVGFHaGhzOFBUMTk1VUk1MmhnK1lPRUZs?=
 =?utf-8?B?elFndmZsWmpvSlhRNzFxUE9LTlJiL2M3SkRFYjBhQisvNXFTQ0JCN3ZRMXAr?=
 =?utf-8?B?dTVXVUxrcmZ2ZVlaaGR4RDdwL1k2SjU3ZU15c1dYQlowVUlwbmlHZ0toL2dp?=
 =?utf-8?B?M29uTVEvREl6SHNKakV4bUttaC92Q2tIVGRERXAvVzZZcU5HVnY5Q3Y4M0hH?=
 =?utf-8?B?WUR1Wkx1U1dGQmJITE1vZ1M4SU5wRDQvQlk0RzFpVEJPMllXbW9nZEwxQ0Q0?=
 =?utf-8?B?K3I4eklZaFdvS3ZlK28zRGhyZmo5MUY3YkFpM2l3QVBQU1I2TWNVRFNSM2ll?=
 =?utf-8?B?MnM4YUt3MDJjUzEwMkpvMUJ3dlRVbzBDMFFHT3Y3cnQ0Q2l3bzhHNWdScWFs?=
 =?utf-8?B?OW9TMUl2aGIyT0JUNkl2NkFpVjFUSVRjUXZtZFdENWpTR1RGOHBtaHZHbE53?=
 =?utf-8?B?a21yUW5pOXhBOEZMNkpCSFAyUkFRR1FwZ2dKcWlqanpqcnlYR3VMVWhId09w?=
 =?utf-8?B?dVdORkE5dVAveFZrbWFOYnhXdFhNRVp5bTcwOWM3aDZWM1VwazEwbzg5Tm5L?=
 =?utf-8?B?M2diTzJ4cGIzbmEweEd3VDBodGZBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA4E8DA636E78C499DB9D94A5532C79D@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4953.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7671bf55-fc5a-41b0-7529-08dca25add35
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 10:10:32.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fv3CbiDjLGU3x5pO12A0AhnmWInufdm+wkfIJhHxctYhvSK3r/QbPaQ+fFkB/UtABFoI6Hxgu0sxrM4cG5wpZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6225
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 12 Jul 2024 10:10:41 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16477

T24gRnJpLCAyMDI0LTA3LTEyIGF0IDEyOjA3ICswMjAwLCBKYW4gS2lzemthIHdyb3RlOg0KPiBP
biAxMi4wNy4yNCAxMjowNSwgS29jaCwgU3RlZmFuIChESSBQQSBEQ1AgUiZEIDMpIHdyb3RlOg0K
PiA+IE9uIEZyaSwgMjAyNC0wNy0xMiBhdCAxMTozMCArMDIwMCwgSmFuIEtpc3prYSB3cm90ZToN
Cj4gPiA+IFRoaXMgZG9lcyBub3QgZXhwbGFpbiB3aGF0IHRoZSBpbXBhY3Qgb2YgdGhlIG1pc3Np
bmcgZXhlY3V0YWJsZQ0KPiA+ID4gd2FzDQo+ID4gPiBzbw0KPiA+ID4gZmFyIC0gb3Igd2h5IGl0
IHdhcyBub3QgbWlzc2VkPyBBbmQgaWYgaXQgaXMgYSByZWFsIGZpeCwgaXQNCj4gPiA+IHNob3Vs
ZA0KPiA+ID4gY29tZQ0KPiA+ID4gZmlyc3QuDQo+ID4gT2ssIHRvbyBsYXRlLiBJdCdzIGFscmVh
ZHkgZml4ZWQgYnkNCj4gPiA5NWU5NTI1NjliNTk2MDJkZDA1ZjQxMzhkZTk2MDJhNWIwMzk4ZjBh
ICJmaXg6IEFkZCBtaXNzaW5nDQo+ID4gbW91bnRwb2ludA0KPiA+IHRvIGNyeXB0aG9vayINCj4g
DQo+IEVyciwgdGhhdCB3YXMgZml4ZWQgaW4gTWF5IC0geW91IGRpZG4ndCByZWJhc2UgYW5kIHRl
c3Qgb3ZlciBjdXJyZW50DQo+IG5leHQgYmVmb3JlIHNlbmRpbmcuLi4/DQpOb3QgZ29vZCwgYm90
IGl0IGp1c3QgcnVucyBldmVuIHdpdGggZG91YmxlIGNvcHkgb2YgbW91bnRwb2ludC4uDQo+IA0K
PiBKYW4NCj4gDQoNCi0tIA0KU3RlZmFuIEtvY2gNClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNv
bQ0K

