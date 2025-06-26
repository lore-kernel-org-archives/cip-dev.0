Return-Path: <yoshitake.kobayashi@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705F9C7EE31
	for <webhook@archiver.kernel.org>; Fri, 27 Jun 2025 02:35:43 +0000 (UTC)
Received: from DUZPR83CU001.outbound.protection.outlook.com (DUZPR83CU001.outbound.protection.outlook.com [52.101.66.36])
 by mx.groups.io with SMTP id smtpd.web11.8753.1750946235496288548
 for <cip-dev@lists.cip-project.org>;
 Thu, 26 Jun 2025 06:57:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=zLkzA8ya;
 spf=pass (domain: siemens.com, ip: 52.101.66.36, mailfrom: gokhan.cetin@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iI0kN1l2zV46iGd8t3IJ2pdKkq/yaS3EOx7dNFmipM7veFCeXFoi/W+ncMIFaib/cNg9aDzlB8C3+3QYngnmfcrMdmIEMrlKyvF0uftyO2HFEjWjazUTkgIAzr8Wa9Z0ABNZzBa86dgE50FlUcFN7j7ROtxrxia+H3VvBalwpQyMz8Z7fBaV9nrsQ5HbFiwI5HR67FhOwYrL9ddT94SJMpQVt19n+SK81q0vD8oSic8NkcjssNKzG4RLvLwNyWxnw5mnIg/6RpjzOlGwceeIxPBa5BocPMZ9tRcYJRFmwYTYfiFLDYiZdNgupp7YCwtWCigoVBT09qaFuBo8KxfNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOEXqzZ+mC8stxe2991SExXR6ek5DkWLW2ZacS31kC0=;
 b=C0S6qCJ0uwDO3uqi7iCbLH66rbIiQdTJLXUINDuofAVou6wapkeaZzPPWldEZAaneXaDX35QDM3S5gx1ZWuIon+QQ+IVRjXRaULQjflpc+CFf8ABbl1yl3ERVvvVGKynBie1QVYfgGR1Dix2L9IpwF3yARrEW4DGHISCs3jUgaWjma4k2uIJSVu7nNghzgFS7WoFDmNOaWW6cixNLgYETNskddNCCROfJAt9PrfdYfJSBSfpbT1GY9rnqU48OE7sK0xIIWKlsMg9PbaAWPvuVAk5gLusiPY83EoJO+kfHL8yrTtiruJdHaBVl4eBXqyJu/SSldpeYwtBEBpdmrFE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iOEXqzZ+mC8stxe2991SExXR6ek5DkWLW2ZacS31kC0=;
 b=zLkzA8yaREcZOD+AJNoJuoj7+ELD+cPaXICivBCP9zhrEVP8Eb6qo9MZF65pVZP0JztTmbHHgUm+/u5AinD4p+l10efmv0zkM6v1++z3XWck4RFQT9VHgdQS6ZV3RYIiI/F8VEWNnsB1PKbsQ7Qc+ApF6GanrtIUy/vayO5rFu6MjHepuLYi09wxsK6r0CCjsg68sNQVoF5hL97LHM+Fq5Wq2CRqhGY94gI8I378XUNda3rEs18mEpqM2HkYCBfVwGtZFSFkMIGElz4EC4ub5uBFDQLvc5DEDp2YWbNKKgEGkiDoiuiy+ii2V+v3s4KIrzl6Cl+1azTFnwjpIfElNA==
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:27a::6)
 by AS2PR10MB6448.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Thu, 26 Jun
 2025 13:57:11 +0000
Received: from PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158]) by PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::1432:b18b:182c:9158%4]) with mapi id 15.20.8835.027; Thu, 26 Jun 2025
 13:57:11 +0000
From: "Cetin, Gokhan" <gokhan.cetin@siemens.com>
To: Claudius Heine <ch@denx.de>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Kiszka, Jan" <jan.kiszka@siemens.com>, "Heinisch, Alexander"
	<alexander.heinisch@siemens.com>, "quirin.gylstorff@siemens.com"
	<quirin.gylstorff@siemens.com>
Subject: Re: [PATCH v8 0/4] initramfs-crypt-hook patch
Thread-Topic: [PATCH v8 0/4] initramfs-crypt-hook patch
Thread-Index: AQHb5noMVx2wsRtg1UKxwNIBKwTTQbQVaK8AgAANdxA=
Date: Thu, 26 Jun 2025 13:57:11 +0000
Message-ID: 
 <PRAPR10MB5422D5E5947DB91815AA17AD807AA@PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM>
References: 
 <20250626-initramfs-crypt-hook-patches-2-v8-0-46f000788686@denx.de>
 <12d427d8-daec-4dbe-a91a-39783bbb3fda@siemens.com>
In-Reply-To: <12d427d8-daec-4dbe-a91a-39783bbb3fda@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=bc8fec6c-4466-48a6-bca6-78d29c82839f;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2025-06-26T13:52:26Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PRAPR10MB5422:EE_|AS2PR10MB6448:EE_
x-ms-office365-filtering-correlation-id: fa5a5343-8203-4c0f-c11f-08ddb4b95916
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?5m0NcbSkidjxfMY0Y4+3+Fu3UBf5wtBmk/++oHj3cZ8shZVYw2cky0Azxk?=
 =?iso-8859-1?Q?9e8Oue6Qv00YCyfI6xyxAlmEdhZ+WIa0Jo1XRXpKx55Fq5jR+GdjZqEIHt?=
 =?iso-8859-1?Q?fJqZKVH2dBvmhIdM73+IQwbhpHgpUO99uKjzsz56Yr5xB6oiYRukxJ05L7?=
 =?iso-8859-1?Q?O7zelD/hHqpYZT4dl87tZxHBwycCQJ1sy9wgO3zJx6Bes4PR941ivVVwof?=
 =?iso-8859-1?Q?LApYHoUUoqls6C3ESkllj7XgWCwmto78I3+UbzUvXJtFjALV6wwO6JM79G?=
 =?iso-8859-1?Q?j9Q6ek1vweMf9f4WJNFT0e8xlmDF9/UbLzhNo4j5qkKmbqs/wJT7LF79GP?=
 =?iso-8859-1?Q?T9us1kS1UNZmJPg94uCPA0qAMJEydPeDe8owggA7VdJ8HorAXGnTGX6/XH?=
 =?iso-8859-1?Q?nK6DM7MyZVmNyLSMao3zT0QlSnlToROrclauTZptobRW/oCe1s4wJMj3o5?=
 =?iso-8859-1?Q?D0ElSNkxNQOMuWD0u/cCw5lmFHJoG26auqO5uxkXk7jin3feS86ZSWRfOq?=
 =?iso-8859-1?Q?Fod2CqrmsHeMwiNjlbOT2ppgfMJHPE+hRMkPJeKihEQjaTgzOHE4q9HJ39?=
 =?iso-8859-1?Q?3uyXvqqbx/Ggkr5Dm+FM8YPTII7+lt2JRqTvl5kAaM3tCdaCxklnG2zYXg?=
 =?iso-8859-1?Q?xKAy7h9+UMBYUP2Jm9S2dVTBRl/8nFnVkWecGA2fKE5Ij5414CDleG2Ptk?=
 =?iso-8859-1?Q?O3ymG8leGkH/RzVvL+GmouUdWYTqsBa+00JLsF9dL+9Rln8dUI33y3LYLk?=
 =?iso-8859-1?Q?eBDzp4g3U3nejtRDxlZY9JgE95KRhNWIuuNrfQv7Cof38+ITm/jiE2E4C+?=
 =?iso-8859-1?Q?nGWHoPoAyg2fwKWAfjL6C8mjbMSEPPRkLfOEercv7IA3MULCgPeeiN4i0B?=
 =?iso-8859-1?Q?soyMrHgO5tMPgZ10rf0wCmvh6FZJ0tpJPHqF5kRQCZQ2Zqw/drDC82Kkrz?=
 =?iso-8859-1?Q?WeTpqWbondkirH+9UgOKihYbHrYnq95aifyIqTps5ztD/mpD3wsvJ9Byr2?=
 =?iso-8859-1?Q?cHpS0P38QDgvUipC5QdbFJhi3uw7t3pm0PVeJHQ7XocgIkUPQ5Uxg6sdq1?=
 =?iso-8859-1?Q?EvoOYj4a503VeRFlGaFYOB9ZK3IC3BCxbJGTl7q3VIqq37k+kCHlQ6jXFu?=
 =?iso-8859-1?Q?8vRjlBlyoWBPacxD+6XQCEXyHH+7lg9tr/J4OaGE28L5Ksu6PeaV3QUe5/?=
 =?iso-8859-1?Q?+QdoQEVSaPvrYvpCnQqTMlNU7RdboXvXbwRg6bKO6HFArBdeTq+cisMXPb?=
 =?iso-8859-1?Q?8yQFoKEffOq88H/OE5tGDool/KgsOJY4fO09ro2E6144n6gm3UMnMz82rU?=
 =?iso-8859-1?Q?1QO8iY34keSa8HMDy51AEygb17HJ/kqT7gpqzoXxyj37ejrQMo1I+Iwreg?=
 =?iso-8859-1?Q?GggwzzHIcv8lF2nuE7UwvGvqU7t/ODiSso6VTDta5LUfW/6bBcB64ChL00?=
 =?iso-8859-1?Q?z9LfgByztSAS4EXkfy8qkYhUlkrVBo8VTVZyUO8GYkR2EBVmG0U9VD8n5t?=
 =?iso-8859-1?Q?oHJmMZRWQ0yI92Ye5tHscH0tzZ+23igU0gFKDlnAIvgw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?MoF5j+m6IHSSkSWWNml9XCGJxgeoG9s8+BPV+hi5O0P415v4t9ZcKFY3IC?=
 =?iso-8859-1?Q?ykU40qXcd4RVX/yq5yUY5+XHn7yW1rJjGdBkrCLF0EXvU602IJ0c/97vjr?=
 =?iso-8859-1?Q?8EJYCJlrlTD6jcPINcfsQbmq1q5TPi062+C3bDxHGT70hp/UuulAtgAwx0?=
 =?iso-8859-1?Q?toJXDCKDY/2TlgsvcaUNh9PRIIouESjBpjHkuWQAnxCkoiNy4F6NwhUNdt?=
 =?iso-8859-1?Q?+ilMAbGcwgVamb97pS2gZ+3YCpVQu3MfV0nrgNuLis/e8+98zF7y5+e6GJ?=
 =?iso-8859-1?Q?L1r2XzQw+gpyEpE7CyaIDLqw1n3s41bmL/Xizb3bn/YWbajDYsbh+odS2g?=
 =?iso-8859-1?Q?a8Zz+9wOLnHO2e8Ul9Q5S2pd2yPwHHo7WhAxnHm+u29HVLdqrfDBGyAJQ6?=
 =?iso-8859-1?Q?++tJhN9jNmYbX2N3ki+z3KhHZufhBJ3iq39a7KKVf/M0j7bS2S9IRyI2G/?=
 =?iso-8859-1?Q?eVwnA6PZ+VAJ1RfiE1e0VkSiEdXuvDgXEmHd1I9Az9rOCgW0b4sXyc+tSa?=
 =?iso-8859-1?Q?ccLvYhtXCWGSm6WeeDmn6aUlDcuKxM0eOoRs52Ban6KVCSLbdGZyM4pKGw?=
 =?iso-8859-1?Q?pl+HloHag4/pMeSEwtD9vk4WLLdLeI0iH7RtSPLOaszWXBD9bmKbsHjRGY?=
 =?iso-8859-1?Q?IsT04/Kr2Vg5m6R78OUfDlo8vuIlZvG/+atxOJtAka9FGJetQOMTHuQmZB?=
 =?iso-8859-1?Q?mhnBO+fvsWI4EP/Sy5qQNxsEtLkcXBLW8ocBvvREhsr/3UU/2LlJx/wbb+?=
 =?iso-8859-1?Q?CED9qICvBoRskUra7ihGjTHOuPaRmhVtR4fYX16vCRv4bKme+7aemJqrgm?=
 =?iso-8859-1?Q?1ZWWQoloxMRiQmg/jbp2p8eXfr+8uo8VwZ5adggiFgtXSo+naJS3MfD/6w?=
 =?iso-8859-1?Q?Y+G6FPf2DfwiH5KhjdeUB4IqHkic5ySYz8pRLcyp/MACoPHSIg3qiGP5ms?=
 =?iso-8859-1?Q?4DLQxwJRA4UoYnlCeqn2zvU76KtgpnJftGDzBOV/wqPBEBpS8U3C54mrq+?=
 =?iso-8859-1?Q?OdvvHWnzmscxWcSEmnPr4qWz0y/1BHG8rMcPLegVXbGqyVKRKmaKi43LY7?=
 =?iso-8859-1?Q?h1QC1LGUZHbv6fcMY7ZUfsNZo9sNAuhFPUp7G80ItJlRuNjA3i7w3U5xVj?=
 =?iso-8859-1?Q?7AAtd2gqNLGzGstKMvpBPDIqYP34GJ86F/eEllLYhCRbhbny0j3En+V6h1?=
 =?iso-8859-1?Q?rebHX5FPIEpo6IDQEhnW1SDWpQJQv+Rwh6SMRxiWUAv9z3RpykLz7k806q?=
 =?iso-8859-1?Q?S/moD3e6FtJ4BD1335fGFVZkyB/+WceYXua4cElF+gVMjXgoXoYrOPobPl?=
 =?iso-8859-1?Q?wmc5leh+6vPsxJEMQMHkA0NTTMfBKYD9wIh9W8d76fjGyBqgM9L9buTysH?=
 =?iso-8859-1?Q?IVigJ5gySyA2L6iisQbOqtz0Y92DlmmgR9PCB7hzTky+zagxTiNVHYf4tf?=
 =?iso-8859-1?Q?lskX1YhyBBt/H+sA61ZDTrdtN/+XAKlDI2YiCJS7PTHDxyh7RvUKRrD1P8?=
 =?iso-8859-1?Q?AhDGF+QmA/AXvFFOnBZV8B0JybEXnZW4J5Qpc45lfVG+Tkeb3wvHLtGjoU?=
 =?iso-8859-1?Q?2XK63mYurvOhwOheK/bIwCwMfYtVM9BsaqV0LR4h8YlqPJt1ODF6yD1kju?=
 =?iso-8859-1?Q?6yLRJrR+MKSB8Qvwoj6pmhzqSCHDeFcN7C?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PRAPR10MB5422.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a5343-8203-4c0f-c11f-08ddb4b95916
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 13:57:11.2730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ea1uNLq3hCChKXc/8GOl9E2KWuT4qWhf0sMADS6y7QI96ve0ylRpKNpxh6lGYxx/mg1arrZkMqZDk+rFycds8mcEjEyZLFu6AeNHi43LQyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6448
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Fri, 27 Jun 2025 02:35:43 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19246

Nothing to add from my side. This will definitely help us. Thanks.

Gokhan


