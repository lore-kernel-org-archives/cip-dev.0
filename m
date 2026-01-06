Return-Path: <yoshitake.kobayashi.x25@mail.toshiba>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565BECDC19F
	for <webhook@archiver.kernel.org>; Tue,  6 Jan 2026 13:22:20 +0000 (UTC)
Received: from OS8PR02CU002.outbound.protection.outlook.com (OS8PR02CU002.outbound.protection.outlook.com [40.107.75.1])
 by mx.groups.io with SMTP id smtpd.msgproc01-g2.89304.1767704260896060665
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jan 2026 04:57:41 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@siemens.com header.s=selector2 header.b=gi7pwCF8;
 spf=pass (domain: siemens.com, ip: 40.107.75.1, mailfrom: gourav.singh.ext@siemens.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fved1xznIVFYAkXViG21edcK30eoEjw9kdl/BYF+Md2ulKyk55AF8vj5BngF+EQZjQKvpEWXV0SHxAQaBTW3NkI80j9LGjnsgwi5pcjQKj4+WOSpHP41FH+yRnceJYQs1VBYDWM7+Ys7XV39+bYAe9e9HpO5cfaWdvqF9fa6/ryba5MUTaSQ6H1QduWS1WYQ3ApdND/sLP8tOw2kyxrLQE3lZWzq+GK2XHM4GRmJ0rm7Gq1bK0LJnP1Uf5SxvPWEdHzG6OTTBA2s4hQnbUS5Wuzr6JkbQC7rCHiZCXuVBGnzgDUW7ynBOZXXPnFjJgA41ZtH24B1aHlasivDeX+sLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8FVavPg8D+2LY27jY7zgBVEngFBevwP1jrzKmIy6/Y=;
 b=Fn30hpeKDy+3nEe1mYdFDXkNO58+iOFL7GU9P4OJIWt0HB3asLApGgjf+hqf0UXpUQa6/ApaxrqX78d6fMP07rixtWmU8ldy6ovRUxxbxd1ObRqJ3Iton/0p/Rxv/1oJ0gA72qNTvMoJ4knRfpoGlRtUzUqZchM/DuvoZmxZ/XBANlvn8I5N7tlYfstQHOG9kxQ23XmikL0mOVn7mnjJPIIUcSdgphwG/alIcr8L/211zxdWSnBTuv4T/LjJhKF+skpOZMT/QxxsDzopZLe/hA1azejmMHQv22EDZboPLsaomRLPcSiFGQbVnwdRGrrZ+b7GqRP5mx3WcKq9QYirMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8FVavPg8D+2LY27jY7zgBVEngFBevwP1jrzKmIy6/Y=;
 b=gi7pwCF8aeCVB0qRIfzRKuffcDaUSyAF4YsKEfTAwaNCawF/Ef+ByCMaCTcZ1ZtjM3PpfEcxxdygVWmdPBSFQ26B7ciqBQgplef3JjETzK5eAU8eJF/oKccONvUhynIBYaqvHRXFXvot5AXnFLAMoJlhOtPflt9y0YIeffFmhsevjhfrzcBhiVEjsRq1m8mFxnNbADHfZ+YVSTNSBUzmxFR5PUvo3L81N8IjJr/ZNYPFC8waqMTf+Ls+Qv85GKO7zR3eFdzHG4pN1oXMTvqTI9ByvE8YfSX8/kmIIkjETnMZYcM/N4PMhuACL1u4h2mLwsfDM8Y6z802PzYFQKmkKw==
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 (2603:1096:820:85::12) by SE2PPFC90971D9B.apcprd06.prod.outlook.com
 (2603:1096:108:1::7e9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.5; Tue, 6 Jan
 2026 12:42:41 +0000
Received: from KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa]) by KL1PR0601MB4697.apcprd06.prod.outlook.com
 ([fe80::d8cc:5aa0:b437:a0aa%3]) with mapi id 15.20.9499.002; Tue, 6 Jan 2026
 12:42:40 +0000
From: "Singh, Gourav" <gourav.singh.ext@siemens.com>
To: "Kiszka, Jan" <jan.kiszka@siemens.com>, "cip-dev@lists.cip-project.org"
	<cip-dev@lists.cip-project.org>
CC: "Shivanand.Kunijadar@toshiba-tsip.com"
	<Shivanand.Kunijadar@toshiba-tsip.com>
Subject: Re: [isar-cip-core][PATCH] fix(security): install systemd-cryptsetup for LUKS userspace support on Trixie
Thread-Topic: [isar-cip-core][PATCH] fix(security): install systemd-cryptsetup
 for LUKS userspace support on Trixie
Thread-Index: AQHcfwHCgNHHEV4TvEu3NZFEm44QArVFB8mAgAANnsA=
Date: Tue, 6 Jan 2026 12:42:40 +0000
Message-ID: 
 <KL1PR0601MB469719F76050D3FDF48AB808D587A@KL1PR0601MB4697.apcprd06.prod.outlook.com>
References: <20260106114331.924611-1-gourav.singh.ext@siemens.com>
 <3c563f73-7800-4b95-8dc3-b7e4025773c1@siemens.com>
In-Reply-To: <3c563f73-7800-4b95-8dc3-b7e4025773c1@siemens.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ActionId=2d91df8e-23b1-42bc-875b-b279e167429a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_ContentBits=0;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Enabled=true;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Method=Standard;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Name=restricted;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SetDate=2026-01-06T12:40:59Z;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_SiteId=38ae3bcd-9579-4fd4-adda-b42e1495d55a;MSIP_Label_9d258917-277f-42cd-a3cd-14c4e9ee58bc_Tag=10,
 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR0601MB4697:EE_|SE2PPFC90971D9B:EE_
x-ms-office365-filtering-correlation-id: adc8b90d-ff5f-47ce-deaa-08de4d21149e
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|1800799024|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?S4UCo1l6tXEVRNZDESj2v8pzri8yYY47dzRn8hN/FH3Oh43VumAwDcBijKV2?=
 =?us-ascii?Q?mqgypepHHw9zzBz8OqqP0C60hfcyTIu92SHLenlzZRX6QAs5A8nquOm1xnPI?=
 =?us-ascii?Q?1r+u5sz8FaA7Qj3qpj+eGnA9vP607zVdPwmNGuk+Pp2mss5peE/nzXg4HgWf?=
 =?us-ascii?Q?tLGNTCTioOqw86vxBhw7IS1UNrowQW7cZP0UPGhckqc0DpMmlTSjGsRwPRjI?=
 =?us-ascii?Q?eKR5Cp27ZcrBRWox4S3mk3cC4sLskz3TFUekndiySdqZh46aJExYblsjKiIv?=
 =?us-ascii?Q?kUdx9x+xYjSrsq33UxtMjh0rc8hcb847A11pt56Xsh6ESeEHuJpnTjBi3eP4?=
 =?us-ascii?Q?4nl7Uvq4MdCFbXLWD2wY0P5F1wIlUpZJbKqiw9rso1X6AF3SAeSOjMXdyfsg?=
 =?us-ascii?Q?cExOWs2r2eyzePGwkw59zQ9YTe+dUSUDZVtyZLYOXo0iBj/Y5mGYaWsgMc5R?=
 =?us-ascii?Q?Nsh+aslFVuUqLK9gN0fCkr1KVXimXKSswfrvrQasH5N0oDutEwALwCPdhrWT?=
 =?us-ascii?Q?IugF8yaWR81kGb+XXSKpDJplSoJTDAjgvFHJFV+YcQijnY65hsX4xvrZgz+/?=
 =?us-ascii?Q?lhFCRcg41WEHT1yQtoNO9m/STbyW+Cq9w765Cw87Sxa56K096FHMDRzDIyxA?=
 =?us-ascii?Q?Gl4RHavMi0my5/K99Xdz0dKly2azEHd4QO9sYIJxGxV6T6fpB/ArAPtHpBOH?=
 =?us-ascii?Q?J9XtfkSee+vdksujxT3ixYMc7ww+lWDc4nZaeFOFjmcIoE8q7y3Zaq3nu1hl?=
 =?us-ascii?Q?TUCl5sp35sYv7MBVXY+zBDrDuyFPuz0Tj9cSoUBkgoHtklXKgKWOXs2taLk1?=
 =?us-ascii?Q?X36N2PmEweULNuMPRXXX0ASaHaiDY9xjy6jjstuQZc1yMpIZls3TKEEWn/i2?=
 =?us-ascii?Q?+j56dY2atND/phzNWhCTsQy0SetY1Jo0DsjrTrveVOd3rOL/donM+aDQXGLH?=
 =?us-ascii?Q?YajWLwxEsvfqHsJeYaQZkwelAhs5wb/kFwprT5SA0Vp4OiYBCnxk+Iw7Y2bY?=
 =?us-ascii?Q?gN9aZH11lOGSnYvg8nHxfj5oLqpxVWoqjmVnop3Er6E9JLN7mCX/bOiuhb0j?=
 =?us-ascii?Q?2QvfD7HdTTTh1qBiIE/E6/MI4dFEtTfEizBJWb7whBQkgiE3W1I9009v+L3/?=
 =?us-ascii?Q?65QiJy7glxFiDpmiAir2N0PcnB1eyhXywhMjgj6ZRryAP2ePbggp4eEBF7WV?=
 =?us-ascii?Q?e8ecmmFwpQ9n3G4LZZB/tEbaeh9uvLcpGTiMxUxSk/Qw/9tyDQdmv5OScnL9?=
 =?us-ascii?Q?aDi6QFE2sjjTFyUPzoHF/TGkPRus3iSvRZ/WW4VSz/hnaOL9hwMYNoExPKtM?=
 =?us-ascii?Q?wNdVC2Hcp6xRMqPgpJOw30uL9pB6SokNcdgOTOy/kIeic8dZdxJOd2B1r+GN?=
 =?us-ascii?Q?GHmejtRY/cG7KWoDFdtCRnkuVsiYavr2meLqyQvjk2LOLvs25ZSw8Ek8W6ol?=
 =?us-ascii?Q?6slIx8/O/H8ymyBNmuk9hGJblapestPZU+5kXHbn2iyJM9fC7z62l/7KdD7l?=
 =?us-ascii?Q?FjoI9fst+ZbsN5y/SaKKFz64G+OZHPy8NOlW?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB4697.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?OldIJlU0yrEClELITw3gBeIOyhlIWZd+me5VXr5AaiWJC44FsRHwy4kGmJ+W?=
 =?us-ascii?Q?hX9bkzI3wIFDPUF09HvooSusMG2IxjZDBzq0lZGm4o0pXiXy66XHfbB4LDRV?=
 =?us-ascii?Q?uaFIPE4W5fGLjp6CP/ObptpFUtPIxltfe6PQXx6OtoxvN9ELqw3HMn/SdaB7?=
 =?us-ascii?Q?Z8Kq2BnM+jKmPkQiF7dIq3rW6SbAmvr1V7b2+SSAnZuxnw7jE49Kb8ej9voH?=
 =?us-ascii?Q?rJqY47VOki9f7OVyToEtK+NDfeXkqjeBgLa+/pdb6zAbEJzUWPbMiYWnuiV+?=
 =?us-ascii?Q?Zs8iHwKkf1WrRfPyu7uQMTplRoxePH4qA68GYhAg3No+KfUSxYK2fnFqaX5/?=
 =?us-ascii?Q?CSMeIt0LrJ6TvCWYuqayLegiZbMh8Bg1EhFX9nh8WDs8EqSdy9+rmchhroO+?=
 =?us-ascii?Q?2V8cd995XvZV0UZavpfePcWORkt369+2Tk7UwVsJu9E/xlDM7bJCJYrAxIzK?=
 =?us-ascii?Q?45FUApgEcqGX+8FS4ojXgmRQsdMx2PkHGSIdlNJYmvAwdfhtf/DufW1QEAV4?=
 =?us-ascii?Q?P1Lsxxn1DLhqW/I+jVqWItWbC138IRIVtGOYsQ429z34IHn0ikX8jwHKEvLd?=
 =?us-ascii?Q?8Mw/1PBnFjZPYxJVw+6+5D+SCurEq9LwG0Rd/jtPhx7U+pyxJ1zVZmAgENst?=
 =?us-ascii?Q?lU1/v01Ijt9aFDk3jFmuc1NjxVsxOS59x0c3AXrUoNuR6Pl8lGMzokfgqpVQ?=
 =?us-ascii?Q?SBEoIJ9exsCvBQuklliQA+itAOPZpCxzth6DE9ulMg8zmqbnWGTsoxmdP+6n?=
 =?us-ascii?Q?v4CMd5FskRnLR/mUguhJOiFUYz/PqM3tmeKQl9sL38lW28MFt8/f+6zSI4H+?=
 =?us-ascii?Q?ME0FUScpYu7nDTA1xEiyG600pR37vW0OgIzaWWt6/OcwNMcekq6Pjq+Oa+mr?=
 =?us-ascii?Q?4fKBxyd/t9qECqvv4hFo/rBkCQhHC5ADZJ5pArFaf3KXBhH2p+L04j6ywz7v?=
 =?us-ascii?Q?Lo88eOEB2YxmYJyrPvb8THMf0qLsaqgL2FhHGDIHnCfhFYjx0abSOsjstxwS?=
 =?us-ascii?Q?DS+Q2eQQIQS0zPzsktgslzDTN2y1FPoImAy14xHW1iz5m894Vle6+ThhFK1+?=
 =?us-ascii?Q?2tsavCYu8JW0C97ilUTuKecqoav1vpyxDdJqP2T/8Lm28HgtBR5o0smQyc2p?=
 =?us-ascii?Q?/6oi5uY+q+xJhSkHFPZKOtiXbbxUtr1niArEX8LxDntx95UKI7DKBikY0Nuu?=
 =?us-ascii?Q?fDP3m8sc4nX0oafsTrjZwnn6B6y239fwlXrDHwBKkDZuU305Tp3NLun/TXvu?=
 =?us-ascii?Q?ic6Z7WXCmQFCXr6zRT/OyYnMeSK3hPnp/i2LS/EuAfQxBw0f16KfeYYwLP54?=
 =?us-ascii?Q?+aLFf93yxS5Ev9CR4JXz8NOWHxsIb5+4Z+2gR3ZSGFB0wWf9m2J1uABc7DgS?=
 =?us-ascii?Q?K05g+SwZrT3Je4JA8bchkZY2s9zXd+G9aSRwCCbF29jXvWd5yuLLe9kjvI7D?=
 =?us-ascii?Q?kmk5JBOUymD9qEcx8qd3FZRLZ2j4/AayCBP/Lt+aPGbbwkmIwc3FSZEUcTq5?=
 =?us-ascii?Q?AWuOwJZrkHIKedlCWMJ6Af0cGFGBVXkdXgyM98MN22IuY2AWIEN8ApOqljR4?=
 =?us-ascii?Q?A2cEaCiAf0ufRILzhc25OiyBGjNwScPfoqRlbyeICkpOYLpGaNPBcvxRJZVV?=
 =?us-ascii?Q?NTUDz00rvN6I3ySbk3B8Ld6bQfdXk1qizlNJgTd8sSwQZsoC/eAnUmkolEx4?=
 =?us-ascii?Q?gbQJYIxySILIKGY3chWmmPxVTuwmx5E6Y+mG9h2MdplpqsBIQdQUPAi2Q93K?=
 =?us-ascii?Q?n+7wcioZC3H3abv0RlXa1+8u2YWNQs0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB4697.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adc8b90d-ff5f-47ce-deaa-08de4d21149e
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2026 12:42:40.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /3gXuUP/UOGasaE7QOr37H+na3GFXjHKjWZ5olCIWg68jwrZy2KMQO5AAN4rJilQdhcRgZPU0cmzfYKmiXvXZN08oE91lHaSfrqvyAD4Sdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE2PPFC90971D9B
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from 45-33-107-173.ip.linodeusercontent.com [45.33.107.173] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jan 2026 13:22:20 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/21380

Hi Jan,

Thanks for the review. I will update it and send the new patch (V2).

Warm Regards,
Gourav

-----Original Message-----
From: Kiszka, Jan (FT RPD CED) <jan.kiszka@siemens.com>=20
Sent: 06 January 2026 17:22
To: Singh, Gourav (ext) (FT FDS CES LX PBU 2) <gourav.singh.ext@siemens.com=
>; cip-dev@lists.cip-project.org
Cc: Shivanand.Kunijadar@toshiba-tsip.com
Subject: Re: [isar-cip-core][PATCH] fix(security): install systemd-cryptset=
up for LUKS userspace support on Trixie

On 06.01.26 12:43, Gourav Singh wrote:
> systemd (>=3D 256-2) split cryptsetup tools into a separate=20
> systemd-cryptsetup package which is only Recommends. On minimal Debian=20
> Trixie images this causes LUKS devices to be unlocked in kernel space=20
> but not exposed in userspace (/dev/mapper).
> Ref:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fsals
> a.debian.org%2Fsystemd-team%2Fsystemd%2F-%2Fcommit%2F65e0731d3a0360fe9
> 816a24be459fc2d2b8becb3&data=3D05%7C02%7Cgourav.singh.ext%40siemens.com%
> 7C8147614f7148403d1ba808de4d1a09db%7C38ae3bcd95794fd4addab42e1495d55a%
> 7C1%7C0%7C639032971422435065%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiO
> nRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%
> 3D%3D%7C0%7C%7C%7C&sdata=3DPZqcjrRdLWcbXJvzQNqGieTZ6xZ4g5fCqWd0jlgoZt4%3
> D&reserved=3D0
>=20
> Installing systemd-cryptsetup will restore expected LUKS behavior.
>=20
> Related to issue:=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgitl
> ab.com%2Fcip-project%2Fcip-testing%2Fcip-security-tests%2F-%2Fissues%2
> F8&data=3D05%7C02%7Cgourav.singh.ext%40siemens.com%7C8147614f7148403d1ba
> 808de4d1a09db%7C38ae3bcd95794fd4addab42e1495d55a%7C1%7C0%7C63903297142
> 9342573%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMD
> AwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sd
> ata=3DL4VLFrEqaNn1Hbv2wnplUn%2FzTXzFgWx2%2FOdtQDoGT9U%3D&reserved=3D0
>=20
> Signed-off-by: Gourav Singh <gourav.singh.ext@siemens.com>
> ---
>  recipes-core/images/cip-core-image-security.bb | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/recipes-core/images/cip-core-image-security.bb=20
> b/recipes-core/images/cip-core-image-security.bb
> index 8a8c695..1d62273 100644
> --- a/recipes-core/images/cip-core-image-security.bb
> +++ b/recipes-core/images/cip-core-image-security.bb
> @@ -34,6 +34,8 @@ IMAGE_PREINSTALL +=3D " \
>  	login \
>  	util-linux \
>  "
> +# Ensure LUKS devices are exposed in userspace on Debian Trixie=20
> +(systemd 256 split) IMAGE_PREINSTALL:append:trixie =3D " systemd-cryptse=
tup"
>=20

Better invert this (remove from older releases - when needed), or we will p=
ile up additions when looking ahead (forky+).

Jan

--
Siemens AG, Foundational Technologies
Linux Expert Center

