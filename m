Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3183D2CE17
	for <webhook@archiver.kernel.org>; Wed, 23 Oct 2024 00:16:43 +0000 (UTC)
Received: from TY3P286CU002.outbound.protection.outlook.com (TY3P286CU002.outbound.protection.outlook.com [52.101.229.48])
 by mx.groups.io with SMTP id smtpd.web10.8723.1729642593074117089
 for <cip-dev@lists.cip-project.org>;
 Tue, 22 Oct 2024 17:16:33 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=QLl9Q6Dd;
 spf=pass (domain: renesas.com, ip: 52.101.229.48, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX99ajfzYL/M86Mpzz3uU+maqFJZcIQyOGwdI5+6+grqzWddvK9hiiWQNmtIxTuPncrXLRqlz6vXDD/WtDuup0GgrjLucFD5Dx7Au60RW891kWBRe5rIH+urvDeB4K+3mYsDqe3O3aljOmtVoU33SCbY2NMzmscIn6CL/8xh1plRYh+hzP4ufL/N2Gg+vZqvOzNadcvVspOeWD/MXhojvSouHpE4SnVd+tG1pFgLJanxF9eLsSo97lVe+FxZE94ojsB8dUZBQ6ekIJ8SZTOremoGl3X5a+3zfWi13DR3nsxl3kMaO5/3DXCDhD3povG4rjwLpGEK37O6T455+In1dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otTsq/oniwj39flZ934dfFoR5G+qul3fBZLWi3rRgmM=;
 b=lQw18i2z1FrrWYGr6p86Ms/NMRuWJ1gYt6PgHRESUVn8RFyydUjj1nS8NIFO9QivI1Qi56HAzjfHej/T70xn5vgOyfd4lDdgl6DWOL/+1mMmRiTEv0dGvFx94+F2culWIxdqV2A41TxJ0iay69A6h3TlC9zFaVWnBCYGWO1EIc50pYEMEL7ZoCRCtHGYDwANAz3doSAgqUP7TXyNB6I7vLUY8mOJg1WEAxU/Wtz3OmcbiP9lXM6Pf3WOgiJqxfnnwpiPsR/KM6z4zEG6NF5ltSIEGExhCXAW+7zd0M/Vq3BoaeRwvnlvsrV5gZ2vgZ8mWel83fzritXMN1djg6ckpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otTsq/oniwj39flZ934dfFoR5G+qul3fBZLWi3rRgmM=;
 b=QLl9Q6DdF+KskyyQWI13VsDhXL65G4dwHhZdTLk8eT25e6/0k2rxWi9TtwgnMpDFR/rpVgpUM9vjRqZloamZqYWVZ3lO4aHPNMNyz4f5Wn2snr9VGicYwvk0t4Rf77zmaPIoay6nfrWZxgvPfJExiEu5VAKMUbEtjR43y5aIJpU=
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com (2603:1096:405:fc::13)
 by TYWPR01MB9711.jpnprd01.prod.outlook.com (2603:1096:400:225::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 00:16:28 +0000
Received: from TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303]) by TYYSPRMB0010.jpnprd01.prod.outlook.com
 ([fe80::f790:8fc7:6cea:6303%3]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 00:16:28 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: Planned LAVA maintenance
Thread-Topic: Planned LAVA maintenance
Thread-Index: AdskuXeAB2qSQwqCRu6Ppi1fWn2KlQAJx9sA
Date: Wed, 23 Oct 2024 00:16:28 +0000
Message-ID: 
 <TYYSPRMB00103C4D66121D3BA620A00BB74D2@TYYSPRMB0010.jpnprd01.prod.outlook.com>
References: <1800DD750A00A2E6.11329@lists.cip-project.org>
In-Reply-To: <1800DD750A00A2E6.11329@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYSPRMB0010:EE_|TYWPR01MB9711:EE_
x-ms-office365-filtering-correlation-id: fe65faa1-27ff-4f5f-4ab0-08dcf2f7f043
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?xQOeOlEuLUqVQwpRi1dojE1XEZ7ogvfsLTRYfK0O+vvKOhiJw6RwzeUR?=
 =?Windows-1252?Q?3aSl5Tp/ZxX0VGYnfk2hNqRclFPHLBJy8CIGXYMXkYYlGidVb7n0yp0x?=
 =?Windows-1252?Q?5ZUn2lwGFFf21HsQVdIu7ZwexsvJ1VxV8YUfKZEU6CqXdVxMLpADc4tL?=
 =?Windows-1252?Q?sselPC+nk1NoNqPWFpzqCmDpt3yDQerei85sN609DTcIJDN7KgkhxT1E?=
 =?Windows-1252?Q?fT+xBpkAOMvbyb5ogqSe8NR9zIskezkFdwcRyVk37Ji4mmdikdDuh63a?=
 =?Windows-1252?Q?mTdtZ3czubnh4nBe15gT72ASPeYZjlrCDnGWXO/gAXu6bdWCVWgvtSW/?=
 =?Windows-1252?Q?8vNNGnDKPQbmZQvtJfBHISjxoKcPHhNfH1vby6Fx1ZEioC/NTVWXZ5Po?=
 =?Windows-1252?Q?DxOEmM7BXJN+jDbf7BxauIzPsK6xlsYOxvIJywAQ7YD6+BaT8iFtQG/1?=
 =?Windows-1252?Q?9nJ6SnNnOkA6l2GqsbYhJXJPclQZLJa5IRMraEnnPeccjFGe9FN4qTHH?=
 =?Windows-1252?Q?Gl8x+voXLVITRAfViz+mbT+NwDTV+1cX9660/j3dgo2uDIHboUVctZRS?=
 =?Windows-1252?Q?3NkXSYiUbKkNoAj5KhPKgVc8cYXfdRmSVNAfzff9BB2mB0k9ihV7Hslt?=
 =?Windows-1252?Q?HMf9DniX8gV7rgZjvN3YZenGcAzDGJ8mEinxaLcMaEBz6u48/YGkGFO5?=
 =?Windows-1252?Q?nAHc8KI11MUHsMQGXyRhqD1mgBjWDQcLWPd7D/NJcqCMPbZMinvJugAR?=
 =?Windows-1252?Q?Fv7ANwByl1IPJ6rvqNoWP8Of5pPuExZ0LLm1wcHIqVGhIJ0uPeykHLGJ?=
 =?Windows-1252?Q?6jr2QIE4F/Ksj38Arg85I6lxkLglqkqSoQu8ZxNjv+OtNM3QOp4HO0ZI?=
 =?Windows-1252?Q?l7DpVCUQQrJj/k5AXKbDFXdlX5OU4XzUwJg6rV0NxiN8x9//WGDdlZ2h?=
 =?Windows-1252?Q?xpDE+/eKxxD5w/nPHNal5Ab384YIjy5URsKXisiHcr51r+H1x8GUHSoF?=
 =?Windows-1252?Q?961z9NPlRSgJUzzbkG2S8GLZfCdu4FGfBNrRqFt2KTv+m2qNvQ+M4Xn/?=
 =?Windows-1252?Q?hP9ezZVdPQaeZmNCgtBTECTC3KyLuK+q7OEXNz3g/gaGESeJF1jbxXtO?=
 =?Windows-1252?Q?YalPePnN/lXgz5n0++qdoPp4UmfiQtn4jlUdPIIIiIj45TK7dU0ZHVY9?=
 =?Windows-1252?Q?uEYe7eKT6ZoiWQ2WxAMXjtYcC6DJkpPyiq9OCEIaw9TkpAjHq49NKAdf?=
 =?Windows-1252?Q?5QbaM1Tqin+Vs+QmIRFrov7VerQ0kQVXg3SkeRPvEeXt8tgeIOyETEXu?=
 =?Windows-1252?Q?gBIe7rjm1h/ZJbGxUFnu676F35aT1CDFWzDNwBIuqevILtiL9Z1QSvcU?=
 =?Windows-1252?Q?rB2NHZLnGzXLWAk865qMkb5fPteqeEmadriM18dAyjqGXpuYvGawVVH/?=
 =?Windows-1252?Q?qH0T8yul5DSlJysJxg31+f8GXoZx0tIZtinC3oJwXyw=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYSPRMB0010.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?znIpgk8A3GvED6t/UPxM9UCc6nYHBKR0wZ8UAg02tUISTtIeok08upHs?=
 =?Windows-1252?Q?Cykg7coeHm8caO3c+rfP/6W9Sco/Z2BqRu7s59tH6f9stsjpJajX/c8g?=
 =?Windows-1252?Q?vjJayDJDHshVY1rDDVuesZvoZzp6QlJZWIX0SUEwJzy2mfTQRRpLQcHJ?=
 =?Windows-1252?Q?uDiOsCu2ELPL66KdgAXD8WNqlpuTSkzqN8bnPsF1Jqy0dRILdx94/0JV?=
 =?Windows-1252?Q?eMItSnhxDL2qz1jD82oxm3ZHqLpIHsFvwl2xfWh0zmVR1u2FzDdzG3vt?=
 =?Windows-1252?Q?2kDkZ9OTOt4/im1Gr5rXiUrrm66k6N8iBn3oziOmyT26ErMBhR72l1SU?=
 =?Windows-1252?Q?mHZJvr4lgRa34/KFBxN2hfZVblsgFXIyUyjwxUL+GJWPLUvKVHeCGYgz?=
 =?Windows-1252?Q?jfWXGgWPOIJxvDOi0avZEFw/rNZCmOXCevVkmiATGbZT/+QEdEuUlME3?=
 =?Windows-1252?Q?Bkn5Ac2ZmjtdHsKF6Al8fNmQYTv44OSlX7RZCXNUyUI+ttFfeZL3JdU7?=
 =?Windows-1252?Q?OWppVmor/vYhoPu1b/kTfRKlvCCsxdepleAVxsDFge937hZVOZ/Zhh27?=
 =?Windows-1252?Q?aQ7pVfVgIICjfeVSiK9uqgNgP1rT+g7L7xeSyIm3LZIIWkYxXfnpKuH/?=
 =?Windows-1252?Q?DLJCes0Cd5OwqEStN/Rn38JM8p2eoFtUya9o49N40yH69FIMhUn1t+2z?=
 =?Windows-1252?Q?5cJCPrSsF2ehanUcF3+F9V6Xnd8uZQECEmzWWdw4xXyiBCDisQ+SIY3j?=
 =?Windows-1252?Q?+CtZrSKRSVWdYaorEC0GoNd54fCbE+x3feuCKmI1+iPo+wxHBl9yN5/k?=
 =?Windows-1252?Q?ZZniYA7ldsrBbKX0eFtjxh4c9kwzvRzMMRXF4Vwyp3XEsIsLUd4B7GkB?=
 =?Windows-1252?Q?UmQw+pYiSRGkCt2cJ1JOlK2A1lwO436uYCK/2H2vPnBJsBZOnNM4NWcg?=
 =?Windows-1252?Q?7d8rZgOuCU69iOPFEdbVqOy4gd3R/uCR4wY/JQH3uUxJIqLpWto3MoP5?=
 =?Windows-1252?Q?hzJM18FARyEiImpNNV3FGuUAy62UFfKQCVIf6DjqbFxoDSN7saG/s2ig?=
 =?Windows-1252?Q?rptN7+aLW5yw8/82sIBrbstyfO+HzbMiFedePxInazeyt4GtLx1q1ccF?=
 =?Windows-1252?Q?JvhC9E2Z9yqG1Wlg9l5b92D7WWAnnXsyckpfZ1F5bbXQHpNRJMxQlfLO?=
 =?Windows-1252?Q?Hb74w+iwz1j8bdnmQvi7vibgO7g7iyFRqgeD6BMkxOtLmI7zEmlhQiL+?=
 =?Windows-1252?Q?FOCfWYYFoeQA7VYVAf/vmZndJiHD8Ctcg3BX2RGPe1AweJQDSsoky+Ex?=
 =?Windows-1252?Q?sRKLt5do03M1phaAHtIa/0+GVsI8yhc/EkPH6f7A8WYUwaX9QSPu+AuE?=
 =?Windows-1252?Q?FvyP4G/3U7mi5Kn1WPJJa2E4lBE9Lbyme8Gh9Sp93dfd2OFPzPaNbEBi?=
 =?Windows-1252?Q?MqdQoUqNJTQJtFrVEz1U4G+mmRLALUvsR+0ObOWEXN9LmtMgH6e5ROdU?=
 =?Windows-1252?Q?iJdV7B27tLwn/Sj2hPGB29AKK6rsZ6YgsgZetvLmxWKUlewuCiDrR2sn?=
 =?Windows-1252?Q?MjKZ2CcqHTP5xnDOH7s945fO5wG1LTf+8/+DSsGrfbLJEaWlgQFd5TJa?=
 =?Windows-1252?Q?zyu35XFzAq9bFClgks3wTUtd/dYaFpMZspwQ5GSfQh8cYGaVHB/qII2h?=
 =?Windows-1252?Q?FUXukeUvQpOWSDD/es4noRTQvYXbVsYPGdG/Eys9/WQcm2rFDOzD6w?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYSPRMB0010.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe65faa1-27ff-4f5f-4ab0-08dcf2f7f043
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 00:16:28.1240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mTOd2GNUhnWonx09v790bLD27HnIBEN8l9Q39bhCHO6Y/47sDTu7z40yYCaDvrOEh7pLof6WKu41sLxe6xQmBlxPEzQmuTUCMNA2yGIilj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9711
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 23 Oct 2024 00:16:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17070

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 22 October 2024 20:36
>=20
> Hi all,
>=20
> The CIP LAVA instance will be going offline for some planned maintenance
> within the next couple of hours, for 30 minutes or so.

Upgrade is complete, although it wasn't as smooth as I would have liked.

On a side note, lab-cip-renesas is currently offline due to a local network=
 upgrade that also hasn't been flawless.
Hopefully, it will be restored tomorrow.

Kind regards, Chris


