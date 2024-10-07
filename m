Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2026BCFB43F
	for <webhook@archiver.kernel.org>; Mon,  7 Oct 2024 11:56:33 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.7])
 by mx.groups.io with SMTP id smtpd.web11.51176.1728302181803212123
 for <cip-dev@lists.cip-project.org>;
 Mon, 07 Oct 2024 04:56:23 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=d7VUVm1u;
 spf=pass (domain: renesas.com, ip: 52.101.125.7, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eV+1LGEgZh7bk9i72Ber+A1xZFL5RPHYlEXX/VzdGbS1gJsNrWw+paG1H81szvM3r5hmWegCjEdcBFFrLyqAytj/t+qBcVRZ6SYDPn9eMFn8hXUkd5rP3UUCi/ghIx9prFulfxHWvEbBDdaKUjdMHSglh9ub5lM5i3LPDM0obgJ7aVbfkbh0dRrGuXfcJlEkob0rNfSeKfHY/TsaTSxqhjPIDSUxoVWWE7EPgH/6bThsGrvsNeasn7UjVJMHvBJ3wwvg54F/aT7R41cuvDpay69+JqSAXDnPOWum57WTv5R8uL8xLY8Vw/Q5AeQ0bQ6yEqHpvB4vMXFSVxuqVUzHag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ydH3y0oZiDZ8n7Yty4Qj3tqfD7w5lOFT9BDnJKRDsQ=;
 b=agcNwjGFnWChDlR/jBZgTiG8RfCi+A1zQ3CChZWq2hSgp6Tz8eTmxwbaEH+9efVxgAgv+dKfGd2MgW2fjsmye37GNKJYbKj3ejnK3pMnRtym2uvjI5pqD+dkN8CMxTK/dk5E/3qeuF/pTpHxKbvT6BvfxwxU84xrQTZC+RoHQEkDAK3iv95huBxwAuaesaV84N3zaRMY7Tsb5FzQrnIRY6mBcUP9aRIQx9kkQs+J/gZq2vzxkvOeMVOp/+3v781WwGgNX4g/StZnZ/hb5iqzhoKtXWdrXPr/wgdDFhL3PxtpQ+kB+rTiNJhS+ZSBOZRDXAxCa7ZoOabld6rSIcFxsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ydH3y0oZiDZ8n7Yty4Qj3tqfD7w5lOFT9BDnJKRDsQ=;
 b=d7VUVm1ujOUKYUcmQxby5Jrc3y56y+qqBAgGrjvyTC0KJVkpclnaYCH/j/p4J/rcVCmQBaZgiTMIpF/43KQl+/M11BMv8PHSUmOWzYVwlfqbuj8duL5lN7oddbiXibokSTMUJsNcWHaOtKatWVnA1NzKNWdaGBfhB6QADQBNKeg=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by OS0PR01MB6529.jpnprd01.prod.outlook.com
 (2603:1096:604:104::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 11:56:18 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Mon, 7 Oct 2024
 11:56:18 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: Pavel Machek <pavel@denx.de>, "nobuhiro1.iwamatsu@toshiba.co.jp"
	<nobuhiro1.iwamatsu@toshiba.co.jp>
CC: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: -stable testing
Thread-Topic: -stable testing
Thread-Index: AQHbFZL/wx1Wcc1WUky+/bpYJwlDlLJ7M7VA
Date: Mon, 7 Oct 2024 11:56:17 +0000
Message-ID: 
 <OS9PR01MB123890EF41652A158A7413EB9B77D2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
In-Reply-To: <Zv6TWPUWmre9eyXh@duo.ucw.cz>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|OS0PR01MB6529:EE_
x-ms-office365-filtering-correlation-id: 0f2ad2eb-3eba-4c5c-9f6c-08dce6c70d8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?PZMFYKAgCR+R7d35FV708vqmYDwXO8DVIn89v6v+rwrp/E2OsV3surg+?=
 =?Windows-1252?Q?XJDTOpfZhBpgPHROjJNyFuYyGMKnOQkBFLenVNo+RMvtr/OcC75raj0X?=
 =?Windows-1252?Q?w6NmNkEJZI8+GxcPQfAYgj+rGrEHZkYSEzBamH2Zjw7zSQ/kCVgr3wjc?=
 =?Windows-1252?Q?eY6pO1ZVg7wcMSOGnsYCNpCG2EX8E2isLyRO5+eOzEYqrlZ0QudYcY0G?=
 =?Windows-1252?Q?YzeU5AW039/oOgGAtDGgfYmCoOPH9gFwPsVJXHn6M/S0rvlhrVAyEu6H?=
 =?Windows-1252?Q?T89ZAnQaiCee33Xwm6rDYgtlNan8N5Ob0UgRg8prilfJK185LgK58YB5?=
 =?Windows-1252?Q?ZuDyxAx01nueazzwh2KQNByasWZyO8XRpGebtO557/CPkexkuhB5zzxS?=
 =?Windows-1252?Q?bkeOFGMMXQ1Qoe3nzJDaaRAsM+0IdHSwjRpZylok8Rfyn688NgP+lblj?=
 =?Windows-1252?Q?J4PTKWM8G3Og/2FZ7CswDpCZOwu3qA2Q3O4wwSuA7O5G2rZx1+cXTdpu?=
 =?Windows-1252?Q?yBSybWX4VoUXKohASHbCsPloq4IiBdRDhQyd20jceMNs+gJXWpD21YRB?=
 =?Windows-1252?Q?WOogKDuA1dGOeGCdmVgQ2ZnIiRER0ngzZwBC4It6yBriX0YaH6zqCKlk?=
 =?Windows-1252?Q?Qnm0FBO5OOPEFQySjyotN0zByXRuweY+4GrjsTeAHanVgcACytwyPv5Q?=
 =?Windows-1252?Q?/9QZ54C98+XYq3X8qvaFNdSL2V1LAhvfe88B46jiuKF+EdtEMs+/TtFW?=
 =?Windows-1252?Q?ZzqydxjBfDbXU3cUIrYKN/WeA29n84dCcOORiaYh7/NE/hi3X0nECmvQ?=
 =?Windows-1252?Q?4QyoF9CmDS/BdbZpCDJ06iGtDzp8izjE8aNB45H4PEL8nBq+ZH+0I+MX?=
 =?Windows-1252?Q?qoFQwtFFWXSeSGBOeV8NJJkOG1i6WfuHCz6JB9byouY/sliBz+q6JcFS?=
 =?Windows-1252?Q?40dCn91S+8i+ymRNqe5cwBW5Qy4lKF7CrXYi6rX3pdoMCzzAo9iQUEIT?=
 =?Windows-1252?Q?GavPubD2yBpHjMSUWrbd9RTlmFKxmGOAJq1lJWSXJvLm8BzDvkcahjF7?=
 =?Windows-1252?Q?EDyopsVtSIbY9vfk+EElnth6CQolqPcXWRY3rBnA9pC1wtyDec24/Cwd?=
 =?Windows-1252?Q?myQytbwIlrzOYQ5KQbK1peaKkDn87airX+K1rkcq8XkAJNRUTROxnZAz?=
 =?Windows-1252?Q?MZ1xKNahgJWmpHF5u79NsRIzwk3nKnqwa9ggyIeiZVTX+HGARzdeOzq8?=
 =?Windows-1252?Q?UvWi4tY8JBEU1/AJ6x0TQcaffX/od2X/hYoGgGfxjV2Eum6LeyvYnd5f?=
 =?Windows-1252?Q?Nhwudbo7lljQ6TUOpzlqKWqWI85Yi/PWsdQOS9wIb4yG8+bct6HKcsMy?=
 =?Windows-1252?Q?GDMOCy8mGPpNCKtrC2ML909xcwgQDGQjkw11Y36I7dMCYphgS6oVqUdu?=
 =?Windows-1252?Q?XFFniJcCMe0JtgZavKkPmg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?HerK+9yRnE3aCX1UO6THhWssueW03zqr6HXpVQzxcYuoEhvzb0/NE30R?=
 =?Windows-1252?Q?YeEQMX3z3vTEpwOOSqI0UqSJciAjKNAfK2R+T1DUX+s0n7ieLXwtuFig?=
 =?Windows-1252?Q?Hbo4QiMpt8zELqvak1iBjIYkrNpiMERH0IDG/YkOystzP+L6Z0xzAtTP?=
 =?Windows-1252?Q?qZn0BMz8FRs3x0rz57tfI3Wt55l2b+PcK+OTmiejfkVeJhNoBE1K62Qb?=
 =?Windows-1252?Q?DC3g6R+ue0PZ2luauSnF/Fyp4O06qXU415dDiwHiln4UsSVvol99+Gkk?=
 =?Windows-1252?Q?KuS+Szr97GVpKgDHxB+ZinXuE4gFO4RNuloI2Q9rkCWkOXm6TEQW9rCj?=
 =?Windows-1252?Q?MrgV8fPflySOg83AcfHHX128Huaks/NbkAPv5gEoy2fvPs4VcqkAIKfd?=
 =?Windows-1252?Q?RPG0QVPwv3UBneUIUqzYJms2t8wKYn3hEwZ3ZlkJkVxJAu0b5U8HjyVp?=
 =?Windows-1252?Q?yUJ4ietRoxJaYNYQv69jzGNoD8NAdWsSsG6TFk4ktb3OUUfjqg9kqfXC?=
 =?Windows-1252?Q?vp3f7F1jmiDI5zQm0QfP5C/5GXBq9e/yb5X4w7u9HwbxB8vGolBCRlq8?=
 =?Windows-1252?Q?LSJiNXtR4uPrwxN4Uv63TljeXVPqaaepJGDNFnsI2JDrE7v0MarvRY8B?=
 =?Windows-1252?Q?RalnVaRIJE+pb2swSZbWb31cwK8FOpoGqIiMzTWR6pHWY/jI4HGzVR+m?=
 =?Windows-1252?Q?fUgb3YgSuoHc9sOaMlrtHlDY2BcQDEVT7LXwH43axdTw37Y1uow13nhE?=
 =?Windows-1252?Q?nR+yjELI0hqqaKrbtFwAfeBjtfOjeXik1OFoF0sSomFzcHVuG5K9nx6U?=
 =?Windows-1252?Q?9dOSxl1Emq7FZN9q39/ORvgZrkyo3fZQ/3cFAb6/ofv5wvTplyY/5lmz?=
 =?Windows-1252?Q?/WF7vFIubJ9ZNJrq25qXo5X3Ckh5ipNmdrmPxKbfJctLkOBcjUye54jl?=
 =?Windows-1252?Q?CVzfpr7t5knU1u0QoqTtQZP2wLDqOGBPxv8oXVY/dxwCdTOx04gYAokF?=
 =?Windows-1252?Q?AFJbO8YVbHi/3XFocvI5CahD2DXTF3mnw3g7ju4yaV7AyEupP9vCv935?=
 =?Windows-1252?Q?cp6s+pookC8MS1l9Y28xw1qug/Wn52yC/T0ux2EA+1Y6BSdBeXWVgj4M?=
 =?Windows-1252?Q?zgkMlC5OQh7N4Qiom6NjRmz/bpHN3qZnzhzMNbIeBGPONuESx3o3wfIT?=
 =?Windows-1252?Q?oXcBGVGZhMqBl1RBgV68PV+hkV1JTbsWt1TApq51tPN5WANHdso0n/EQ?=
 =?Windows-1252?Q?Qr9/kmdFDtmLRmHHRYPD/tHTukbPD+IhmxuCPEsVQGJhphxmM4f/w5KL?=
 =?Windows-1252?Q?Hoo6BP1ohrSQHMo7ifA7ItnjaYgKzKIrZ3i83M9fr+AoXfhZ69n4NfV+?=
 =?Windows-1252?Q?VLeS/V1TfDEIqKPIqaxNHEKPQenHQm1/ahFgpHpQtokmNMnsATxrshts?=
 =?Windows-1252?Q?nfZoqxorshdx29ztN/qByVFTq8r1B/Ys0ZhF15JNBKFY7eWo4ytabwbv?=
 =?Windows-1252?Q?UMlCLwh/a2+mn2DhrXZvhBU92M2aNiqBXIV7FbqHxsvT1R13JgZRs9Wk?=
 =?Windows-1252?Q?lSqnOhtQx+RzKLGDh6FPZb64+4B4v+RuJ6K1WK8aNUICjnsZ4V4sfZAX?=
 =?Windows-1252?Q?U8+DPgZvC7lSansTRFevlCg54lxZWM9vFZFoG+nAQTAnIyopmPdAEC/N?=
 =?Windows-1252?Q?sTA+AqhTUTzEN11UiTuwwKU3H8DA2UldKCqRu8Q8/mht63f8YeMF+Q?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f2ad2eb-3eba-4c5c-9f6c-08dce6c70d8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Oct 2024 11:56:17.9418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YpqOgKkXpWg4lcP6uI8+1o+ownnC0wfmAJEZZIdP2qdayCL6SQf9FsMnoyJiza0Q78oOLQZkzOyOEMIZCrJgKBwcNEDgGElAsJw+G6z9YME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6529
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 07 Oct 2024 11:56:33 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17010

Hi Pavel,

> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, October 3, 2024 1:52 PM
>=20
> Hi!
>=20
> I'd like to test 6.6.54-rc2, but it does not seem to be mirrored in
> gitlab, at the moment.

Our gitlab setup only checks for changes every 3 hours.
It ran shortly after you email, but I assume you've seen this by now.


>=20
> Plus, would it be possible to start testing 6.11 and 6.12?

I've created an MR to add the kernel configs here:
https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_request=
s/104

Once merged we can enable 6.11 & 6.12 testing.

Kind regards, Chris


>=20
> Thanks and best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany

