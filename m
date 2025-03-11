Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E248DC28B2E
	for <webhook@archiver.kernel.org>; Tue, 11 Mar 2025 08:03:57 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (PA4PR04CU001.outbound.protection.outlook.com [40.107.162.1])
 by mx.groups.io with SMTP id smtpd.web10.3146.1741676826339122621
 for <cip-dev@lists.cip-project.org>;
 Tue, 11 Mar 2025 00:07:16 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zeTZ6jRR;
 spf=pass (domain: siemens.com, ip: 40.107.162.1, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOYQ3Ge+2IK+8NSM60ygrBmTtMSQPB6DUANHgNaIrDRafH0epMpUy6xJtn5MrgiCg4bKfa2V2MriP63SRAt35W39QK4kSg7QpZeMVb8NKNfPHq1/L2EXViqXAqGbchD0FzVgVlJTI3dESvFQP/xtkhhGvn5YklHxweh7AmRdAoYGLzUilHYd9DWja+rsCNiKnwG2ZlFLL39sCDPCRFSHJdtiJ0c8AOKGMquXGpIX0Q7c/LuNnaBkU1cNEoo5SMDbiZaGwMrLYNELED8aiXY01cZDOE0sonuBpdzhBzqWit56MDh3JkkyPZOclKtv9YGLWx2dpLZ6781X58NmT73NgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUkXlfd8p4H9r8LpdAhwH345oqP7Ba5a4JLdxzfLf08=;
 b=cjsLi0S0IGlB4N2Ii9+Hbsa5Xa/o8bAunc7jVpYSPe1tGVpXHIn1J89+topxMJhUMkA7ewpqUdmyLrlYj2cToP+7iuRPLhzmz2DLrdIuDbqoWqhzIckW1PbBRUcL1Lsb+r79NOD1cJFrVnGP2x/T1RTasrN0I3617osYl+72DSS6ZfbA9yMGGOL+V+n8y8G9PySNBHRY4y1cZw3uCQWCaPGQT5wPWQRzro2iPHR9W7R/LpzJLInj+1oc0dxYh8SwMvzC1rGsR8GmbAoRgO6WD/yXT0OBtY1MNupeGjUaL2JfDPUbAShQ7RmEE8NkvS7ZludHPdboxHJj4ddflxCDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUkXlfd8p4H9r8LpdAhwH345oqP7Ba5a4JLdxzfLf08=;
 b=zeTZ6jRRk6y8+6x1BAE32bd4/lVkJaao8KXQwCZ0zMTOpit2VvoYZ5zJYTYOSFfVC7kO4sIf8uuPAi6kx/+yYdQsUG+x901ka1MrdfABrdY6m54RryZzzmI7O62QW4MnL8RFhDE739aTGEOsTHzhg2joNPaoYwZGMaRK9sGDl4dT45LDu+zOfrb4Tmdbx+6yHHfKuzlvcjpolupZT5LMjDgPPz6xP7Qpf3FuUS6EOxC6QsCrH+tvArDoyXnElw4OQG0UYvZO44cSi5eF8tMXhmaU4UDFJBkUfnU/U+IrR9fyWa/UFg/qNzaBcKflAp78Lyq2459uX+07DB7i6WDV8g==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by AS2PR10MB7501.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:593::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 07:07:03 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 07:07:03 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "quirin.gylstorff@siemens.com" <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer provider that hooks sign-secure-image
Thread-Topic: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to signer
 provider that hooks sign-secure-image
Thread-Index: 
 AQHbjns5YmpFem/SVkKzaVXtmh0o6LNl/UcAgAAA94CAABsI8IAF8QkAgACw7jCAACH4AIAAGHMQgACA1gCAAAf4MA==
Date: Tue, 11 Mar 2025 07:07:03 +0000
Message-ID: 
 <PRAPR10MB542215E52F990A4D26435D3C80D12@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: <20250306093516.3232063-1-gokhan.cetin@siemens.com>
 <3f756d50-aa21-484e-aa52-f91531451dc0@siemens.com>
 <87b88c83-3fce-4038-b8b6-cfe83056fb9a@siemens.com>
 <PRAPR10MB54225595622204A578B7E92880CA2@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <38368d3f-3c33-467a-8e0a-8fce11de6415@siemens.com>
 <PRAPR10MB5422A552AB83D38C445E1C4180D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <22f01b35-2d08-4b94-bb72-37d82f3b21be@siemens.com>
 <PRAPR10MB5422CF6EE9F9F1525D8F1CFC80D62@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
 <319c1887-9e1e-4b99-b122-426ae59148fb@siemens.com>
In-Reply-To: <319c1887-9e1e-4b99-b122-426ae59148fb@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=639b52f6-377b-4891-97f9-d7f086ed7ab7;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-03-11T06:20:40Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|AS2PR10MB7501:EE_
x-ms-office365-filtering-correlation-id: 21f9772d-0f35-463b-be08-08dd606b5356
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?iMkV/4uvSjnBuUNTted8jLywq4tr4kaW4yrhKgaKySVfPhnetPMCSYNU/J?=
 =?iso-8859-1?Q?wWFUkC00yw93X+ZQMJxcBUiYql/X7P+TNc/fgdbmcxXhFlvJAJWrZF0vR8?=
 =?iso-8859-1?Q?5fFej6mrh5LVum0qEN0M76l/sDaoH4kveNN2xmpvCSChK69GhkElofOWX9?=
 =?iso-8859-1?Q?Temfb0lbnDihUXjE/C7Xl+ghfgJ0nftE4nd62QIa6p7HaRauBtRHKaRDTR?=
 =?iso-8859-1?Q?zOmI6cPj6tJp+eKWCuPbZ4DsUG+dSa69HCJ/PazyuIL7qH7sOxd+c6MFEc?=
 =?iso-8859-1?Q?mgGmVIHj3keG/dH+20T3hg7PyQ+O5z9HrqCKB6s7ylmKS5fGLO3M1f2KF4?=
 =?iso-8859-1?Q?FdTHrzHT8S54zN+FidDNRMADwoggxpRAMybCIbApd93FNQLEIxhA142nix?=
 =?iso-8859-1?Q?6Gr4U65fBTscUZPD09BeknrDRjM/ngx0VXomvVSzt97ysJ6RZZ7BstQvL8?=
 =?iso-8859-1?Q?0OSQNHQH/b16kd761EYF7aO3M0rM64eeSzbbrxEzSFOF5WdETGjQQRZ7UW?=
 =?iso-8859-1?Q?nNsG0jtB8hxKYnNC67zOjMFQFX2BArGUntWp12vvRiVQyGVxNLVXfqSLzr?=
 =?iso-8859-1?Q?qIbp0sS1qZ8OLuSVy/jSbhAl6/Iu3Sx/IJwr0CcsVoPyUoyVhUQR2FEnU5?=
 =?iso-8859-1?Q?SqXylz4auZ02Mco4B1J/JTUCz36cz8c79yItigUxSJwQDLCC61qkE5jwz5?=
 =?iso-8859-1?Q?9hymojuLtn4YXME2I/Ua46EJFjt9opRBHH9Sa5O2iY/wWb4aEU1Va4ug1F?=
 =?iso-8859-1?Q?aOOfIZWLps+bBSEZh5V1q+sWCspmQzpKiN1BNDrmOYOlKOOqC1hD3CQZ3q?=
 =?iso-8859-1?Q?Cc4cCcYsb41Q7+vU8vAJCiTMdK/n3oPszv1iOY3KtAkqRdO/Y/2esctCeU?=
 =?iso-8859-1?Q?Tn8xGzFWKtx3ZRFywvrqFMadWnqHYjPeo8lYOUN/j7lSjXOst8o/VETD3T?=
 =?iso-8859-1?Q?8ohuTsZXY7uRH1lPdA9rHZLarvCijeaeIuxzkACM6GFRCBwRrkvCNZPdIv?=
 =?iso-8859-1?Q?1A+vbN1CGvX87aUOP9PNBe4OqMk+GISKnz2QskG3x/RccLhMxwwz6eN1Lh?=
 =?iso-8859-1?Q?TQRdPYrHeTrX+EokVh2SKd/IhVFfAsWkewM7YZWSWRNo/sM5gVFlfA7CW7?=
 =?iso-8859-1?Q?7NTqK41f597K8GrVBjj58JsSeDyjHmKZpnj4FFixzkpDzbDbTug6OdcEyt?=
 =?iso-8859-1?Q?NYaZIOVVxi2mQu8QVnBRB5shzbGmtZ86xAo1wLkUlmJxXhutgZPyA8ZVJq?=
 =?iso-8859-1?Q?61Bk/JPaQhdQLmhYciyL9wyF8FjAz/QpYT8V6hqv7G2ftWl/mjGIUI82uJ?=
 =?iso-8859-1?Q?Cnpxo322qFGh9YyiuEsQQPUm7mEKNa3YmtwX+hdxF6Wdsx0tSgJLsFrxgA?=
 =?iso-8859-1?Q?ZnIH7cKLYZrIodwR+yD6bZogxWpT8GnosKA5RI9cwqm4/yoQINVS7PPam2?=
 =?iso-8859-1?Q?gacX7jlxkl3A2Bj6Z1Dcv5/I9juD4yeKoYjR+2WbAP4W1G1SlTynmLZeNf?=
 =?iso-8859-1?Q?l1wlmlfceVAb4w6NQZEdAL?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?BrCE+95RJ9qZE64r2skUW6IAw3w10skQO5T/YR3yatwsi+410JIkxylOOp?=
 =?iso-8859-1?Q?uhGS0YglGmofeI05E44oKbT+mH7Pd/VqRJFvY0hqnIqmyKkmtvcX0TW1OD?=
 =?iso-8859-1?Q?OloX9hIko/ZEX/EZK037lAVhAUD04wcB2QKNjbKi7CEHXCyssAUoGWx7GV?=
 =?iso-8859-1?Q?jx8BefJhKrf9WiASdBwcL7UW+8rdNMtkijAeKHPG7HaC524AWMUBtefZhw?=
 =?iso-8859-1?Q?7AmTdCx2lczzELIl/Er8OLQ61QvX0y4JE9m12CaiEkH2UCkt57XstzDU/A?=
 =?iso-8859-1?Q?z57tG3IHYg8Mp1SjaCsmTVL3DeEzH5acrcI9oB3dLZIVxTppRDSlYVhJt8?=
 =?iso-8859-1?Q?xk+7doCA90pAVr9rzYcUCNhAnGe2BTxdsq+REwpiz9sSzFUDibhL1Bcqos?=
 =?iso-8859-1?Q?IZnGs6CMB/NWw+PHHjyMsZFLg081Hs/UGX1cY+23Z/l2ZmrnhN4ZIDLm/n?=
 =?iso-8859-1?Q?GUrkN0gPGzD+7vgOjBvOmejBhq8kNT+/XYZSBIJskPHnHlFcXYeWhwHBcg?=
 =?iso-8859-1?Q?eNwk/I3a2BvG4FU5PIyQA4crgG3RkjLyhVk7l53ol3dsZfgkhYClJJdM05?=
 =?iso-8859-1?Q?REirnNxQSL98hh9rcvXkvphT8eCUpivdXDxdLKCFapMYcHN1s9eS/WmsML?=
 =?iso-8859-1?Q?Kiuoa62M0lIHoPP8aSEzkaGhGIlLOMYIErvF30tsNgCqMyc5/WXCDpOxlQ?=
 =?iso-8859-1?Q?D0yiOVB+V643vSOVCHcaaYlHgjgK3AFiyJu+E8DloWuVhqEwPWaVn0WpL1?=
 =?iso-8859-1?Q?/sPcfcPhh9Gv4NVzFMiDUkHXuzjSTI50nP+/+UymkkQ/VpJL5j+BUpg2vI?=
 =?iso-8859-1?Q?FqRU0jxl+lYd4cJV9HXvrUoyBV4PrnmGjTnRHNmqB1gjB2xZ/lMOrGTVNR?=
 =?iso-8859-1?Q?C8ySeE+i3uMyKBOeTid9dknuKG9hvHt1VGBMVZk9NXf4cue8MQeUITS/jd?=
 =?iso-8859-1?Q?jt1O/W5l/DqL3ma209yqg+M+qYf1rjtcO2MYu7FmQHhvsLhvTP0ochvhU3?=
 =?iso-8859-1?Q?X8xPz2ql3eiSv1c+K8l8SQPXlra0HG8RGHvLlI0S1A40RkeOr5eW2bwItg?=
 =?iso-8859-1?Q?pxiv8zlJvh1mR67o4kGU8J9txRPhViRIoLPVv/V042WiX8+HnUpuYZBBp6?=
 =?iso-8859-1?Q?9EBOPFkBOv70leLbfBUegeEGHMtyTcBfh67s1rJQCtp/VI2tNKUT1onfXZ?=
 =?iso-8859-1?Q?JI5H6JshGUsGHc/eddDYjHyqJ4COoISYVzUTImScMMnkDh07+SoX8jbtU3?=
 =?iso-8859-1?Q?SsYNxSpevUuLpLca7gW3lNZYdwfuCV2u+cjWVbFndFN2BRkwaBhJuN6zim?=
 =?iso-8859-1?Q?ZSrDo6hlzNUoN/SX8pynq/q8Xgx30BomxtJHe2S/28SfiWVHG+cUn937C2?=
 =?iso-8859-1?Q?A9ihHoAJcQZSpTDB9drM1X7uXeryznow97OAIRzm1JCcFANF8NDXVqV9YJ?=
 =?iso-8859-1?Q?an7lL/n8dsEks2E4ZVaKyysS8jhX+CGT2FaeQ3WXQhiBDuzpXKG5rfU5kP?=
 =?iso-8859-1?Q?VVicMeS4RDGSuGOfcwV9+5WDyP5yDybqEf/KypF3E44y8/qmbPbbUeES8Y?=
 =?iso-8859-1?Q?6oKJW/n3oM6Ac+vKlpMKaZsJ9r/HqSGeYK3s6Vl9roJoH4ZLtR2D8hJ2p9?=
 =?iso-8859-1?Q?D50yHYr2Povt/0nDYS4pBMtrVz50PT+NpE?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f9772d-0f35-463b-be08-08dd606b5356
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2025 07:07:03.2280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjTN1DHbgRLU2RYYzrl/vektVy6BE0psNT4IX/ZeBjWp4EF3MD6Pg5VGLJmOUHC8aX4uQL2arS45SMG8zZHDELIZU6aT+LeF0tsgt2uqZDg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7501
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 11 Mar 2025 08:03:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/18084

Hi Jan,

Having identical signer scripts might a bit misleading since it will branch=
 in two different path inside.
As signing methods are quite (except hash function and key/cert file) diffe=
rent for both.

Module signing requires smime, and considering our project needs, to use sa=
me server side signer for this purpose, some hacks and tweaks need to be im=
plemented (e.g. configurable hash just verifies that if requested and offer=
ed methods matches). This might also apply to another use cases. That's why=
 I kept them separate. But certainly, common definitions can be generalized=
 as you mentioned.

To make the big picture a little clearer, let me show you how it is realize=
d first.
I believe it will be easier to refactor it iteratively and move it upstream=
 afterwards.

Many thanks.
Gokhan

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=20
Sent: Tuesday, March 11, 2025 08:52
To: =C7etin, G=F6khan (FT D EU TR C&E) <gokhan.cetin@siemens.com>; cip-dev@=
lists.cip-project.org
Cc: Gylstorff, Quirin (FT RPD CED OES-DE) <quirin.gylstorff@siemens.com>
Subject: Re: [isar-cip-core][PATCH] ebg-secure-boot-signer: convert to sign=
er provider that hooks sign-secure-image

On 10.03.25 23:14, =C7etin, G=F6khan (FT D EU TR C&E) wrote:
>> Now we already have two users of the same interface, and that needs coor=
dination. This can only be done upstream. So present your module signing pr=
ocedure as well. Did you patch linux/scripts/sign-file.c for that?
>=20
> No, but it may not be necessary since sign-file already supports detached=
 signatures.
> I've introduced a separate build profile for that:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgrou
> ps.google.com%2Fg%2Fisar-users%2Fc%2FQbSnth6G__4&data=3D05%7C02%7Cgokhan
> .cetin%40siemens.com%7C5474db07dad647f5e8c908dd6060de31%7C38ae3bcd9579
> 4fd4addab42e1495d55a%7C1%7C0%7C638772691336690277%7CUnknown%7CTWFpbGZs
> b3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DtrUSaBAvbA1Py%2BrgekiFqg
> UWPNcs9o5T6jYEB5v0hPs%3D&reserved=3D0
>=20

Too bad that this abstraction just talks about modules. The signer scripts =
should just be identical for both use cases - and it seems your solution in=
 isar for modules is already a bit more generic than what you proposed here=
: configurable hash function e.g.

Let's generalize that signing procedure in isar, introduce efi signing ther=
e, probably to meta/scripts/lib/wic/plugins/source/bootimg-efi.py,
and we can simply reuse that here for EBG as well.

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

