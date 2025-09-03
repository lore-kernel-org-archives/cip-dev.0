Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14403CA1009
	for <webhook@archiver.kernel.org>; Wed,  3 Sep 2025 14:49:03 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.29])
 by mx.groups.io with SMTP id smtpd.web11.14532.1756910933181753190
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Sep 2025 07:48:53 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=N7647y2+;
 spf=pass (domain: renesas.com, ip: 52.101.125.29, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t92j5kT4uYQNnZmo3JAxbBkG68qH/yYydb0aCpfCk6xQnTVImbxu40Ys4RrWGSInAi9SCb5X4P/MhAlfSHygXkgNj8o7aygc/uBVF3M6AfFi+AL4Zn1Rd+eUIutfXfFt7IofjAQWZ6z4FSxO8CDys/cbDQ3Kn0BDmo6euDS9OsgnNhtz3X8Bk0PjkRgN7zNVXOnrwBcUVgtrZxBCzYpQX2CfQaj5+9Kv6RIqmiWMaPAso08OomUMmEI3Smolknw0uRPqriS7UHje8YO4JGewzyaweNLJ/1eNUgeB44S/4JdRVMtsRjH8oGdQ2RJZQxwNlhWoZVKmBhB9In0T72jG5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+pbb7cPjrLmCXjJLotml4aDViFwLL+k/FIwTRnsptTg=;
 b=L7BB6WysZ0KXjuwkzx8UwnuUudR/0SLchPSeAmOSm/6IVFxoEHnofe2q2TKluqfidZX9oJDG/mHkPW/VbltQVRxTpGa7oRH8Lxeo5CxrGVuVciYdSJPQkhbO4KRpI8ionLOI7Ieq468DaiN8XS/aB4JUc/UvEdars85bRVDGI9lbSD4F23Gh4rf8o7PgIpgSPHXOsdoWA65vuaUHa/MEoMwTlHOWY0bDC/Oh7W11yGToctsxU4/Wc/wB1zMe1E0B5d1YPsIWZSGJ50i6O/c8pxur63mTReUYtK4aSmNLhL/iFto7efH9pFY//qdZsKxr/L/Y95ds+mQYG9hE0EfzXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+pbb7cPjrLmCXjJLotml4aDViFwLL+k/FIwTRnsptTg=;
 b=N7647y2+ew7jZk9tcry+PtJwSHF6HaRntBHEGEe5Xcrees+pWxPq5V6kAidG4qohAlylxH9Hggozk6PBQEUGEmTtJriN5vXheK3WS9MIzLfJHvD5U+/GnSQ7Eo1VQtQpV5T/iJNqTA7ApmV39tIY5tYg9LDIgJDYX6PqkJHcIjE=
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 (2603:1096:405:1a1::10) by OSZPR01MB8896.jpnprd01.prod.outlook.com
 (2603:1096:604:158::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 14:48:48 +0000
Received: from TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6]) by TYYPR01MB15132.jpnprd01.prod.outlook.com
 ([fe80::3fd9:f47c:79c7:a6c6%7]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 14:48:48 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: cip-dev <cip-dev@lists.cip-project.org>
Subject: LAVA server down for maintenance
Thread-Topic: LAVA server down for maintenance
Thread-Index: Adwc4bhQtXrmWA6oQiqKli5dWAE2+Q==
Date: Wed, 3 Sep 2025 14:48:48 +0000
Message-ID: 
 <TYYPR01MB151321B65010CD1F4EA7FFDF5B701A@TYYPR01MB15132.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYYPR01MB15132:EE_|OSZPR01MB8896:EE_
x-ms-office365-filtering-correlation-id: b69414ff-53ee-409e-ad10-08ddeaf8fda6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?iso-8859-1?Q?h4RxucdXgTaPanEyTHwz2uwl8XILjLsJHeX+EoZQCDRF3n4n5AkzePsAbL?=
 =?iso-8859-1?Q?CSNg5KzlC9gXbSB8Na5z82ETMXYIo/K4z4HQyzp761wUlKOrtmE/d0KE5n?=
 =?iso-8859-1?Q?J2LLJdArCiEZSV2O7iyTZT1CEu3s5YLgmh1eiyHn5BXlPAwACBwmBd+xZB?=
 =?iso-8859-1?Q?gPpm+OBb/PEQl9OvlZzGd0/eW5NMzV3jC3IP5d9H5yoG2UKhERnCRUm6F1?=
 =?iso-8859-1?Q?bqqnNw8skMRt08lNZclIDV8HUqUTKEN3aPJwyXFeD4PrY0qJ7uhwxxeSL2?=
 =?iso-8859-1?Q?KDuVawLkImUvCQqHIBCDX/prd2mIVPw1Zf2hHwjX0jjOTffRtxPwCZtVw1?=
 =?iso-8859-1?Q?MOHtH7Jd5PYkaHxjuWakVTcLy/o/ScYsACfnaRVFYsOj2F9ZRH8XuWLrXE?=
 =?iso-8859-1?Q?ancc2kYgIBxuAHf+jS5CWysyz+8G4wwouinDP1kKM4WDF2kU/M8ly1EO2e?=
 =?iso-8859-1?Q?qre08PYqb5DAlvwe1CgcpACs2Rx6QgLXl5QkArJFIYFll5EfzT8jKfhXdq?=
 =?iso-8859-1?Q?alHnUlpkuRuaH3pxXnBKoZ8yZROJY6MvnevWZEqmY2mhe39ad+qbQHvY/A?=
 =?iso-8859-1?Q?0kP/dhfRUmX7hD2KvUGqF4tbUqb1zvOpX4BrCRGUsingJ3CzgCKVDIDLj5?=
 =?iso-8859-1?Q?tRXr+BV5usqHlCGo2v7U+wzlDquxZXr+NJFrPqlVfyvLtM/0DybbfFLGHi?=
 =?iso-8859-1?Q?9BQigduCO1hjgp4ndPXNjtzESHuLjzbOvH9N/rbwuKglYeHU9/vjyzw1iQ?=
 =?iso-8859-1?Q?zSifndiC42bfGK6JheBpgNtxlzT5EwTmRakT1xLwmUw2zgX3zyilhbp4pv?=
 =?iso-8859-1?Q?9YcOtNEkpS1X827NQec99oI1GNHRIA4lBb/TluzWrsMHZ6NdpBW/LvDZhZ?=
 =?iso-8859-1?Q?vonXTdWQFS8xesZuUchcQFjT8ed84HhgS9snUtTvWLprWzWG/K5q4Q/JyM?=
 =?iso-8859-1?Q?LYKaR1USSIRvyCjodgmCWMy1z1foWb1iQJoinHshEgD67UEp8TwiX4vUFO?=
 =?iso-8859-1?Q?DYAiXzfSj2L7fYphd23AK0PqzABYfwjYVL25vvjkLMstmHE+HWVC8ZGwp1?=
 =?iso-8859-1?Q?68eXiBZdzLmRayRz8SJDsqnRsTj4XxmvD5rBaTPmyg3Uz/8mPulyHQZYQs?=
 =?iso-8859-1?Q?SKOaKvqYQufYeLbp4mVJ26ya7rgNSZRYwOBbYVBkNtFgmjGJ3yxazc3T0i?=
 =?iso-8859-1?Q?ljBByQfHhSXId7M23Dx8cRMImeSMSxIlrZTscuJG/xrHuDVoghv7Yucr9G?=
 =?iso-8859-1?Q?+gZPTjH3yUS44EXLS4SjINW6zQNiNJyYydSOzg1Xe1wa6y/O/ngdJs+6r4?=
 =?iso-8859-1?Q?8SppZSLW4paL8UFsy2FozBH8mzebeZHJoRDlz4Ul5Va7AbmkShlWLy08ya?=
 =?iso-8859-1?Q?wO/BubeZKHfabG4ZTqo0/ko6BHT10LzYAZa3LToaD0KQRjNNfm8fww2qz/?=
 =?iso-8859-1?Q?bdd64DBho5974CjsQgBOwPXEZMAjWliXmZyAfmwhdQSQqBd+MJXAxmhZyM?=
 =?iso-8859-1?Q?cloLsbqSG082fspW2UZ5uDkiOvJwUzTeubTwU7/4DxOw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYYPR01MB15132.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?o/QwIzhOqwpme7sYGFrIOEomHRUbbmAOmeYVIJngG42ajeLsADRmw4HFbB?=
 =?iso-8859-1?Q?nm+26hBlrF9xN4iMgSyPWHXnSFkbBttqckqEWWfVVcbsDuDCi1EQF3io0T?=
 =?iso-8859-1?Q?QJSvkUZCpzwXKDa7duHqyrLEp5IhtFx/VstPB3Vj+56JqP2zRLMg/Va7BJ?=
 =?iso-8859-1?Q?9CNc5PUIOHTZZGCgRM3Y3SYNKncf9KQu34lqNFWr3Ohw8z97E5AkfWlE2T?=
 =?iso-8859-1?Q?7OV6frubKraglzxiGPkhEu61lpU9OZiJsvRRU9at7J9c+Gj03hL9VHJKLA?=
 =?iso-8859-1?Q?lDk5qdn2B+Z4wz6//fXzZTsXFKqUWYZxbYvRger4WKKR+ApTbrxsOrZ6DU?=
 =?iso-8859-1?Q?RHIbEFocSjiAJjJtCjid+U1kDLkddwqSLOe0rT4byOo9IOQ7/Y/09EHjl3?=
 =?iso-8859-1?Q?OdAXqC5BRIj9sEm8+MVjnLoHwooSD8xDh/giWmAId/DcHEOtG9VKfZ/xqa?=
 =?iso-8859-1?Q?ZgUpRyWnJcOthdHhdKMPapJMcpjfTbxNd7zYK0Sb/NsdlgharMKwu9JLOn?=
 =?iso-8859-1?Q?p91RA5RdFAElP1PCr5E5u8h1OMibalR8T2++3sgDnc+vjuZBNsJiAYo/cN?=
 =?iso-8859-1?Q?2YRjlx425OtvwGJKsrHirxMbVJXmvXguZK+VVMZCcJyqje/PV2PxDAUKh4?=
 =?iso-8859-1?Q?12ZTP9NaV5dnGYII51wGHSsnLhb2a2/XQ2SoUQXLPdJT/RZIySqSh0RLz0?=
 =?iso-8859-1?Q?HOQ6YJZ/sk3wYo6WpLADMuvbaOWo6kNAKm3WidIXb7A5FRkNsQxTrY+TXS?=
 =?iso-8859-1?Q?Cn0+DXE3CipnuG97ppfVMC8qnIEExC79ifQYvHcq4AtNeP2iQmde1yxNxv?=
 =?iso-8859-1?Q?zakhGsCVfYvuOnozWimboXDApGy3zAUFIcj3wyL284TsJdz/twJet3ev7B?=
 =?iso-8859-1?Q?e2vuDpBXaqWJbfY/XobMcK1imnnAmMAgPgeAo8iseWZKK48wKrDMHXS548?=
 =?iso-8859-1?Q?yEQOvBhNQ8QSL6NSjFXWq8aGZouY0QtlL2w15CP1v2T84UNy+4sZ1mRBHN?=
 =?iso-8859-1?Q?6g3weLmJn13Z4LzKMQki4g+GkZeThOJoZ1U3TxjTjJgCdse1gELEa0UQNY?=
 =?iso-8859-1?Q?0Ao2+UrRD7rGBSbPbjsXY/AAq5S01Ja3nFlkFDDCv0DdNoOYk132TfSS+c?=
 =?iso-8859-1?Q?3+IPFXTwGJHazX4RmyznOmWEEISp6oWOw+dkCarkIV4J4fvy8TsM/lVFIk?=
 =?iso-8859-1?Q?hGk0oT06iNUncoi4ekNSNP1QobUbbCi8Jym1BnGMhFg9dAsK9O22RuMzQn?=
 =?iso-8859-1?Q?+/u1p5jFyrqopstaeMdvPECjzQvmfETbKnhvbdTEHmdIVHc56adCjqBXCz?=
 =?iso-8859-1?Q?zSwM3V3oiHjplp50K5jiUMN6IE9Xb06+ukjArw+JEveReuMka4C07lJyJY?=
 =?iso-8859-1?Q?+qWKeK5CPKJzJHrt3VRe8H0/XyNv/OQZdtcK4wi2NL0vc+kL8pkGae5nP7?=
 =?iso-8859-1?Q?MTuKVyV02RRRlo8cA8AVYll7oGmE9TzdwQvjZN8852VPkHg+w6NSh3toL8?=
 =?iso-8859-1?Q?aF+fdo6e51/nPxYc9ZaApvHkJNBrYFXjGxh/u3EUL2nSNfBQo6sZglLAdF?=
 =?iso-8859-1?Q?AvOyRwrKdmPxoPPZX5eSO4T24QfE3x4IWYIzMy0byqjHoCc9tIx7BjOjsT?=
 =?iso-8859-1?Q?GZF98LgUAj7A/e+T1lZnW2oujDAT35BSSlNnMIbP83wZt9hdOOOCs1AA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYYPR01MB15132.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b69414ff-53ee-409e-ad10-08ddeaf8fda6
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2025 14:48:48.4340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 789FQAxaxylXFYaYbMDtk3lb5B/msXOuLsxGXmFmz62+pymSkM1XsTvCYqAkTYs5qorC4/fvaJx0KopZbRI5TAZQH0dLRHwrGSoOe5gS+U0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB8896
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Sep 2025 14:49:03 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/19999

Hello all,

The CIP LAVA server is currently offline for maintenance.
It should be online again within the next 30 minutes.

Testing may be impacted for a while as all of the LAVA workers will also ne=
ed to be reset, and this is dependent on the various lab maintainers.

Kind regards, Chris


