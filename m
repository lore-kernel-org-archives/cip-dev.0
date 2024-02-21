Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE87C48BF6
	for <webhook@archiver.kernel.org>; Wed, 21 Feb 2024 11:33:16 +0000 (UTC)
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (JPN01-TYC-obe.outbound.protection.outlook.com [40.107.114.81])
 by mx.groups.io with SMTP id smtpd.web11.10884.1708515187940629074
 for <cip-dev@lists.cip-project.org>;
 Wed, 21 Feb 2024 03:33:08 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=WNLf2/jE;
 spf=pass (domain: renesas.com, ip: 40.107.114.81, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlQpVPhtb6YXxkSxcEZ0BFqyROofcpaR//2oUy1v6+VheQwGODrEAH3+u+YKR5bCXbh6ZpEF2IikNf5s+hmuCMxDKDuXdLw6olkJRKGQqKwVlhiec5raXnG6dx3OepQydGWFaeWJ1sPo7Mn63LUTM9mKbp6Gpc/3STX8qsSPeOR3JtJYPgvAhc/CvXZWQODBh4Hxyek1mEo822TBTN8UboaslT6NCCencIemawULKFQFiZ0sHFj5IN+b11aLm3DZ1NGgL+0/80i+RrZQqgpQxrLvrqjvHLng3GERVk9oSXg4fxjzNENHfrRf8A2gZpF2rWDw6kPpLycq19WAbEutKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ScpXnLJqDFCJfh7euZ7NK+lMwQH6YGSTrbbOpdC/p/Y=;
 b=LK3xbhjQXAdYgcu1UlX9pqFvI1rt0faxB34EJmq+TYKW0u0kQSdhqJlrlFQ+xh383QgeowbGE/Erra/lQFDerRehHMffHX5pLDeISSRTWdVFwmpmYEV1GGMpXbYIA5tZecFeUUN1Mp/IxtMeQe883wC75sjysbnK8ZAzTKgW0nJyMefV6tuM+kS+oflHJp+grRZlfa4If6FbI1grZH6rXx8Bc/3b5hwkKo0R+foQO/OIU6U/frS0Wsgeku0EBwG54YVoZOP92DjsJZRd7jPTsrUl+bDFORHrdaxnJ9iKjI33WfHADrWZIm+vtTLyzUhrzr2RhXx4l3KQapeEzAQPXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ScpXnLJqDFCJfh7euZ7NK+lMwQH6YGSTrbbOpdC/p/Y=;
 b=WNLf2/jEEimeLXwLCBqCLzJSEYZJNdMU75RIJ4bzu6YiA0LWx/Bv1ObHWydKLCApTAi3dV2ycEj8fJ/ZEDplSKxW8CkPoiOfTvtfZ7Jo1uvBiVQSY/2IPDbO04ZNiPHeY/Qyz4vYLwNDblOF/S5cEP01n99ACf4AIBWaIurrxzU=
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com (2603:1096:400:3fc::6)
 by OSZPR01MB9518.jpnprd01.prod.outlook.com (2603:1096:604:1d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 11:33:03 +0000
Received: from TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47]) by TYWPR01MB11862.jpnprd01.prod.outlook.com
 ([fe80::d543:aeea:6f7b:2a47%5]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 11:33:03 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "nobuhiro1.iwamatsu@toshiba.co.jp" <nobuhiro1.iwamatsu@toshiba.co.jp>,
	"cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "pavel@denx.de"
	<pavel@denx.de>, "uli@fpond.eu" <uli@fpond.eu>,
	"masami.ichikawa@cybertrust.co.jp" <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v4.19.306-cip107
Thread-Topic: [ANNOUNCE] Release v4.19.306-cip107
Thread-Index: AdpizBfukngTWstVQGyLm56ngN6pSAB7JwAQ
Date: Wed, 21 Feb 2024 11:33:03 +0000
Message-ID: 
 <TYWPR01MB11862F1E986F419E87A9B17BAB7572@TYWPR01MB11862.jpnprd01.prod.outlook.com>
References: 
 <OS0PR01MB6388B40A6EEE4574C0F76F1292512@OS0PR01MB6388.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB6388B40A6EEE4574C0F76F1292512@OS0PR01MB6388.jpnprd01.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11862:EE_|OSZPR01MB9518:EE_
x-ms-office365-filtering-correlation-id: 1f45cce3-afe0-4163-e018-08dc32d0ddba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 z2P/7xDGy7YQRiSQG/8Snmlk2PeTGHmjIvL0hVA5F5ky0dewqdLfdWTQC9iCFg6oV5jQjOeaL0CeMDMpdSOIPrFz6Nc57WwD3TzJEDQsPEHFKSQUu6+QwNqWS4aM6JHz0C1yKIDaClB3hZdVcvYtP7wbq0/o72qRUvXFoK1ViS1HPSfvSJdy80iRLfHWS8OvowHHQfNkxutU/INUP6TOv36WbOI8ouhES6Be/exTN7z00FixUQbGeN0p6RpVV0ph5jhJOwimRg9Zgy3GFQKUnqO3rgBSQgGEKZF6Mk7qLR/VvmgagWqNrI2XToWuzdGsPNJ/d1+SdHFMzuHdLlCvXSNWIw7jwQNbhEToLS6RIvSk41RrspAxmVAx4FMd7FKViObTrVanNtDtjyXyb/tUmu7ZJ2GwEbKtwPpEto9aRd96ak+CW89ScOAlFI5WHruVpkBRfPJycDwfHXa8+9RwEusZbfCuawaS3Gs6C+hSvfb8a84thkOlrgJVz4YcungqM6F+0ukC1MEMzPTVAXS8ZGV+d5N6GCM4tPjHcsURnT1h2x+muOT2Eh+4eU0BqAxpGz8Wdd8wDeny7fMDtZ9b9Op8zqOI7HbWzp2fdKIB0pk=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11862.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?rwH6xVJk4PwJctj/2WzWsnlYBEh58rMkO2sULSGY+PdeuQ0wfpaPF4G7?=
 =?Windows-1252?Q?5UNWiy7irs8j+/GCuUxJC5Y+QW77lsdHYqvPlOYwarnE8NsrpbYzBr37?=
 =?Windows-1252?Q?9kdyqY6z0T4Y8eiO1e5elLh76SgDnMnb3D+J+nBLTH19iYuQ4x7SFOQt?=
 =?Windows-1252?Q?KAOucwwGbSvo4BV/1pqRzvXfduyXWJnu/b1aTF7fEx+wwkSd8dF9WOgY?=
 =?Windows-1252?Q?7uuiDexlMGmydbB8LjN71RRWgRt+2Ks01BHr2cwzJYXLoniQ8qZX2wdX?=
 =?Windows-1252?Q?iGtJQqXo15R1+2Zetrzet5vzOzP5AoQ2bnuPfp/wE3YsoymPIVpaTUco?=
 =?Windows-1252?Q?DyZ3gqI8sqR8M9naENWJDsxfxpZedjjPIqfu/W+9Gtkv/nN6vsQ8FfBr?=
 =?Windows-1252?Q?r39ZPfUJoU5yXm70uSG5tnMmZ0YZ4OUdCbtRi4frG4/C6sYpi2sWMLTP?=
 =?Windows-1252?Q?SNJTA4mwuEFzJZx0+54JMSwfW68/VuqbtBbb547jW3GokbPfF3dCFnB4?=
 =?Windows-1252?Q?UQqlOkhGKKFvqemjo5/Qtxp7w6kiCFsaq7I/9Xvq/tdpVrz637rQqpol?=
 =?Windows-1252?Q?Mp/j2hx4x8FrexIde6raiwukCvYu2dCp5/J0QEOFFMmiJtB/pKujLlv2?=
 =?Windows-1252?Q?UC2dSc8omAEdNokGV5FH2KFlS6zS79pNv7YoE3kMRE6kBznnZpV8U3g8?=
 =?Windows-1252?Q?0bU4Lo3nFNNJn565YD2YGaMnoARS+wIBu+ZBmaw2Oxy/ZoCMYpByLltY?=
 =?Windows-1252?Q?6GKPed7yr5kxJR0He8SsoPiDIBoUUYjSY5/9MVMXBTMF6g4U9j9ndncc?=
 =?Windows-1252?Q?9U/Yk1V0NiOiyhWcJg2eBlwoCs6NYboUyZUOrXc6jEK1HUdsjb7rQ5Q2?=
 =?Windows-1252?Q?SNLDrVdCs2V45/NBXgg1/G/zxB+lROjINTJPzqhXPcKOsQGkyjX4d3hR?=
 =?Windows-1252?Q?v8oYamr6Zw2WJzeix7kWfMRda/XGV5ql4O4XCIuArv+QGbbYtUbhWZf1?=
 =?Windows-1252?Q?b2kxKQmpbdkMMaB/2fK7EvOjjyK70Mkb/yf3a4uHPZHKJXtkZXLJM4s/?=
 =?Windows-1252?Q?EigdS94SGT3ZA/e54r251kgUhQ+rORiUmU8STktIneTgVtJmBPQiWMBV?=
 =?Windows-1252?Q?16kALWZ6hu9xDoMK8l2Wp4CwFD8u3Sh6O99KeKSECxh9qX22Zi/FJwQ8?=
 =?Windows-1252?Q?EWjJK84SGMcSMghBkehqrGHk67vEXKvZotpPYC4CEJP9TtSA/w9c+fco?=
 =?Windows-1252?Q?jFjYgY9eEi5230IRQLDaUoLsjOKNo16DXXDSagYfZNhKT4po9bxFup6E?=
 =?Windows-1252?Q?2m8+PgKfS1QpggY65psNUBfIFVIhsZj5RgcOgFoaGAUJqpNoGUMA+uUv?=
 =?Windows-1252?Q?MUXyF52TvWPHm4nb0YXZNv+nuu6df4zyYIhC5E2Die/4x10wrG8vXaHd?=
 =?Windows-1252?Q?0sKdL5aTvRnadyFTJTD/tCZ2YZQmUtoRC1iLoh7U69go2qojMZZJ7ulT?=
 =?Windows-1252?Q?7PdhKmWXpHvVN+XPpnJIs++lZ66ZFCcBMmwquhQo4LSsSDXe0ojqPOJi?=
 =?Windows-1252?Q?nOzMa7zL7SGVFmMGAXc8IlVC9peIVwuK5R9J8eeZTxEgEPEjWDdS29xm?=
 =?Windows-1252?Q?cLER9EX9y06zAJOexLAQSVfs9/m5eybeDX3vOUpk9po0t6ZpY0Dvqo5j?=
 =?Windows-1252?Q?PrLAmLsbRWmn6a4JdVe6ZfvFBj/REmbx0sL0vDkr/2Eycss8kuvafw?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11862.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f45cce3-afe0-4163-e018-08dc32d0ddba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 11:33:03.3885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fv26wvSE5EzU2vCjJzzaiRg/um4hHDbKBT4iemULSGqv/2WeLHNF94l5CzqEMQW/1YjluKvfBzuCt/Ry/WctR8NkwKsjxeSm0yt+xCg7FW0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB9518
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 21 Feb 2024 11:33:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15048

Hello,

> From: nobuhiro1.iwamatsu@toshiba.co.jp
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Sent: Monday, February 19, 2024 12:42 AM
>=20
> Hi all,
>=20
> CIP kernel team has released Linux kernel v4.19.306-cip107.
> The linux-4.19.y-cip tree has been updated base version from v4.19.304 to
> v4.19.306,
>=20
> You can get this release via the git tree at:
>=20
>   v4.19.306-cip107:
>     repository:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git
>     branch:
>       linux-4.19.y-cip
>     commit hash:
>       800dfc28d1a90b195d50f75fa7711d00cc1825bf
>     Fixed CVEs:
>       CVE-2023-46838: xen-netback: don't produce zero-size SKB frags
>       CVE-2023-52340: ipv6: remove max_size check inline with ipv4
>       CVE-2023-6040: An out-of-bounds access vulnerability involving
> netfilter was reported and
>                fixed as: f1082dd31fe4 (netfilter: nf_tables: Reject table=
s of
> unsupported
>                family); While creating a new netfilter table, lack of a s=
afeguard
> against
>                invalid nf_tables family (pf) values within `nf_tables_new=
table`
> function
>                enables an attacker to achieve out-of-bounds access.
>     added commits:
>       CIP: Bump version suffix to -cip107 after merge from stable
>       ravb: remove undocumented counter processing
>       ravb: remove undocumented endianness selection
>       ravb: update "undocumented" annotations

Test results:=20
- Dashboard: https://squad.ciplatform.org/linux-cip/linux-4.19.y-cip/build/=
4.19.306-cip107_800dfc28d/
- Summary: No new regressions

