Return-Path: <chris.paterson2@renesas.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E05CEDD88
	for <webhook@archiver.kernel.org>; Wed,  9 Oct 2024 12:01:10 +0000 (UTC)
Received: from TYVP286CU001.outbound.protection.outlook.com (TYVP286CU001.outbound.protection.outlook.com [52.101.125.40])
 by mx.groups.io with SMTP id smtpd.web10.14453.1728475260659298123
 for <cip-dev@lists.cip-project.org>;
 Wed, 09 Oct 2024 05:01:02 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@renesas.com header.s=selector1 header.b=dnbd1DbR;
 spf=pass (domain: renesas.com, ip: 52.101.125.40, mailfrom: chris.paterson2@renesas.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEL/FK7ZlJnMGHKy31uuWmJcyJn1dak/HCkpBVSbSIgLwOMvFhggX/XPHTZ3q6Ezqqq3mQecIfPejQIAs1/mu+rKqnwkMw334Bo0wIr2ouCDr5Bx8dCY5MMUDBvGdsxET14eJcGf+9LouKzaDdozMuQmVNwu+7x7rywrzwcOXE1R3sQg3Awq7S+qNBVpbQUnTOHKmPSA3Sn0H/Dvh5jyii1Us6PaQBtXj8DRGz9uLc1B/29ywvbIRteUmF1DJFKVyCMbStEFYcWCEfPk16WFCdAdz2llNjKML9FL/M0xGzPLSLDtN/JfPLaitpJRzXe/cJHTX0IQ0Pgmv6iKBCD6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pDzZLh2UPjKLm6geYRs2nMjkhWqfNscLTbBcWij3xN8=;
 b=Qd4NFT8PoOo0qjzFuw4MK9ZCvzo8RvwQ/mFkrBd2/ZaFtk6AbXG1UDkZWvTBCAP/k/V7Sav/KS4T13P4oIpnK4xDoHwI1UdHnnOOpz/7sVm6KWeqXdAVuzmahIaB+I7NUhsurtmJt92hbNe6Pi/+xndaruxPe8NKjelEX8lTubs0mzgCv4iDeR4nBtuzLzcfPrqMqyW7nPu1rNV4EsthcoX8k9tX9PH4QdU11fWFmqqcZrzqOQI97ynS9cC0YFd2EQ/MWW+0YWkavzfZfss9G2V3xkAtSUKBP+AoFo9kqre2uzvEM6waeI4s4IZmUG2YktMqWMFMcKTNFqjaktr5bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pDzZLh2UPjKLm6geYRs2nMjkhWqfNscLTbBcWij3xN8=;
 b=dnbd1DbRaNxSfXSaSavrs1db2zjDMNba3weDWNDUrDNYzkVTeGVpWAezMtgSk/CWmVTKQT/711jOanYgdxd1mhOh1CPNUpFrS/9A/BIJXYtGY7id5Ow93o5nrTNmfONapMcaRUBqd9nZ+8IEBO0IVdxVFbNLpC8lhpChywZdwCo=
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 (2603:1096:604:2e2::10) by TYWPR01MB7170.jpnprd01.prod.outlook.com
 (2603:1096:400:ec::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Wed, 9 Oct
 2024 12:00:55 +0000
Received: from OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f]) by OS9PR01MB12389.jpnprd01.prod.outlook.com
 ([fe80::d85d:3169:70e9:6a3f%4]) with mapi id 15.20.8026.019; Wed, 9 Oct 2024
 12:00:55 +0000
From: Chris Paterson <Chris.Paterson2@renesas.com>
To: "cip-dev@lists.cip-project.org" <cip-dev@lists.cip-project.org>
Subject: RE: lab-cip-renesas offline
Thread-Topic: lab-cip-renesas offline
Thread-Index: AdsaKgOu1+fH4iYTQ/ipcTRm11rUKQAGNb8w
Date: Wed, 9 Oct 2024 12:00:55 +0000
Message-ID: 
 <OS9PR01MB1238945B29EF3F4A00C31B355B77F2@OS9PR01MB12389.jpnprd01.prod.outlook.com>
References: <17FCBD68B18E5703.22523@lists.cip-project.org>
In-Reply-To: <17FCBD68B18E5703.22523@lists.cip-project.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS9PR01MB12389:EE_|TYWPR01MB7170:EE_
x-ms-office365-filtering-correlation-id: 552366a6-7cf7-402b-2832-08dce85a07ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?Windows-1252?Q?QuqtI3QrO1Vilak23oMtVqxUo8CQpLU+OtHfGtkJi+YyadppTHfEO5/j?=
 =?Windows-1252?Q?f1bEiED02+0vQ5v8fpEpRQ9DXLldiUSATBTEsjL3FqBCnSq/a7+XuQil?=
 =?Windows-1252?Q?Y9EiNLZFQ5N+me99JvXSh1ldbcYxhR546OfQZkuM/AC8ebZ2o/XAIo3U?=
 =?Windows-1252?Q?SlTSFHY+Z+GJis725Z00K5xFavY0Hmh/JxH8y1j4MJA9HcoMA85ctM84?=
 =?Windows-1252?Q?PnsEHQ49wjXN1F0hwEEGYtO6cCtO5yJerHJd+4qOSRP0C3Q7x0GLfZDC?=
 =?Windows-1252?Q?A+vyuraSMBJeaR/soRSvwLpY+WAU/bKVDl6pLYM7g3I7W+Y3f5BdU4uJ?=
 =?Windows-1252?Q?PKlNOIrJoMV41Dn0+clXE86dxVAPOFFjU923zuybg6g+9xojUBurWVBA?=
 =?Windows-1252?Q?CVY0G8k5keX656vPVS2aJU5PBh+vmdbTapp7nf4XzUdHL4wfJS/132V3?=
 =?Windows-1252?Q?i2hZ57c0BgmBU0+QWyTFsOEWPeW6NMNovLwYMTk2p935P2lkKbu/05z7?=
 =?Windows-1252?Q?vDjexZs4+LLYfTWlqL7oT/bLSlehhok5cV72ksV8C0VrOmC/5KwZxZXA?=
 =?Windows-1252?Q?ufMaUzkDdXqg4p+rNErYeyIvUlViPSNIaTwoslCMlfFnjgHpma+w9mbo?=
 =?Windows-1252?Q?MrfXWN2eTgUy5kF4MCwU2M7JiCOJyWAaukl1GYwtWBUyaps8UwCGBJsk?=
 =?Windows-1252?Q?BohukRO7+CMPmMr3xv28g3se4/92yWt33L4CsB5FKmMKg1GfiQ/cMMpR?=
 =?Windows-1252?Q?AJzGl6+IanGuSD+HbCYi9j0nSmmN70fwr5rkDznSD2rgGa7YO+7kIhhZ?=
 =?Windows-1252?Q?dSB88Dp57wr8h2QQbOe3az7wPcFhNjzcmQyv/1qzGc4dycZH8vu68jHc?=
 =?Windows-1252?Q?0D/m8n7ZkciAmQwl392Xi1OzvUCe89AekuuDA8DFWQ92GQRUJVL2kV1g?=
 =?Windows-1252?Q?21PoNRGTOkuIIpT//+Xb99NK4vWZ9K+xvvjl82BpbCgPGKM6FUdg/NyU?=
 =?Windows-1252?Q?CsVHcMDaBWdl6X7JXb86eD5eCQK02z1kKCswzgsURzYsiwoQrI1S3fQz?=
 =?Windows-1252?Q?Zs3wx3vqNSDTMbqWd+xKGmKlh2zSrmn+4xTX2UJ6os5r7lD/duH6Mfil?=
 =?Windows-1252?Q?kO86I3a5bF8zmaZsHFLfoHHfHJiu90T67V+W4b4IpotSsoBte4KfNQf0?=
 =?Windows-1252?Q?RmQRCsP5k6orMVPphpMSfSIepkRWZp+r2eap/1KdeyABk4h/sRln4Sl+?=
 =?Windows-1252?Q?N5tY4oceS/JaerxH5OiW9gqe4eW7g/WvjqEah3HjdYmSpxARJJOCA1A0?=
 =?Windows-1252?Q?awZ2+osmpsJopEwb3Tuln0ogJNCFs/L9CMwazpNCMgxBfYgev3AtT/aT?=
 =?Windows-1252?Q?2iafApm+plFGHJ0rYk0MdnLlEWpUQKxTDrVyghBzkUs9eVaImjh6KKGP?=
 =?Windows-1252?Q?wPYec6TVPQloccdl+eFDtA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS9PR01MB12389.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?Windows-1252?Q?Afa+gGChCe+p8D+ZWgRZPb7O6gmgz/4ZgEriZMD+TANSSHiPat9RXIqz?=
 =?Windows-1252?Q?gYBGJ2iucNhVLMcaroRGqU3fwUgLMn3AkIyVfxyUSkx0veqzbDlQCRvo?=
 =?Windows-1252?Q?y76k/z9WJrx3JZrBU6v6ObbMkCaKj54G+40SpFRdlL7YhgXg3bj+F2i0?=
 =?Windows-1252?Q?EKhY9Nk+fHgificMxrBNNhaFAfTixxYuOPieP3aM7OGBt39cTzMjzymu?=
 =?Windows-1252?Q?IwAZTrTVc04Li4qL2izk4jUPIt9zi68bMMBSGNbMLuZGVKsc0Rcd8jAt?=
 =?Windows-1252?Q?dlGbwj40Zq/aNa0BQHznHwXA6Y47aAIuiJQyxPA9k3581nAj9rDNUOI0?=
 =?Windows-1252?Q?28OmaNhiusDp8ZqC72FImpRtSs5FiOGlmx8zQQvkXacI3L6R0QVDiK77?=
 =?Windows-1252?Q?Ioi3SvatIxIzOa+Sfr+pIugEdBGuSy7Yy3StmCWl4xfBS5b52mRlbNqD?=
 =?Windows-1252?Q?QQkznlgnkkZFqkq+jgD3Jd/fb0vQYvWCglz6qSk0Nf/qspChfjw0rewr?=
 =?Windows-1252?Q?goQIrHoqzF7XvPtFI2e3RmfOAHbAEHt8lGY4nC0JHYdMr9HHvaYW3AT1?=
 =?Windows-1252?Q?r1IXiDUS780982X0YKJKzwLxOtrVjIWQ7FIscBTgKv8+MCOcqqmKbiNN?=
 =?Windows-1252?Q?A8eMWLK4+9Ekictg97iXyImnDQC9sH+5ivNrvhfAV/rVqYHKH93YsNRL?=
 =?Windows-1252?Q?kMKdiacKVWPJj4rk5tdrNUvUn3XEOKsJSFbaqdCmTSE/JZpNAvuDbQqa?=
 =?Windows-1252?Q?DoVjzc17uLglalC9dJeoCeyZZmNIv1Mso1OBFs8GCkKxRypQ1GFioqvw?=
 =?Windows-1252?Q?oB23MD1Be2/MexhgihS2YQVIINFodgRxRgbytx7QUQW4Yk1/dFvCgDx/?=
 =?Windows-1252?Q?NBnMboXROKIApoOdA8yG4gGILsrCQFnO5ywZknd7UIlIXPfNp2zmvm/Z?=
 =?Windows-1252?Q?61fSSsOeJWs/TaG2AVijB3qLyDrpTX0ERAx+2Ke955j4qKWKCzBnkM/E?=
 =?Windows-1252?Q?/7ZfGd0i+3rkt0hVbnLMC5tY1LWjS+35XPQ9SwtQGF2nMi0F3d94BIEZ?=
 =?Windows-1252?Q?YNp8OtR/VFPscYF5heB3a64QEfFWHtUZryX6u/xHPBZS2kpK8FSxPYh3?=
 =?Windows-1252?Q?fCM+T7LUG3S7mhJgc6avVGMXZZpF0FloIbb5aR08V1gRFX65o19EB9Aq?=
 =?Windows-1252?Q?krdeELUSk9YSDbWp/b5yvhPdyjntmH7AC/402wf0nN7ylBmYSEHIx5Zs?=
 =?Windows-1252?Q?aDyQkFp+1P8bEkRgjN2pWc8tC0YnEsCmSREsOacNmKKwpyG5LWLlXNAW?=
 =?Windows-1252?Q?aaxfXQ1/StjV/TmtzB4jJT2/Wgre04fcJxEqsTf1qJujV7EGo1A+dPND?=
 =?Windows-1252?Q?ZPh+YYa7yNy40Vgu6G8UvuPr5SUYomOhX64EWHEteOIZLun1Ckk7DHhN?=
 =?Windows-1252?Q?QydazYfjuqEp+TU6afzMb2M06+qj9/XNv2k6rxprX4QLbrVSyXszTDNC?=
 =?Windows-1252?Q?Me0t67IXyFkx3JlzbgsU5nM4LO/HZv1Hn1/lLN0Dfb4J3fPPt/VJ01dv?=
 =?Windows-1252?Q?/oQwnvRHqdnf3a66VdsYnJKUZB50ihFfxwpmS/dl7iqIADmD/AWUyAKH?=
 =?Windows-1252?Q?gs1o8910I/rlRz0h0/QYNu8OdWPV8h6vs6lb9SeLpeF1QBh+QVKP5Re7?=
 =?Windows-1252?Q?CrLZoozkxO5Ri0TjOppCtW1qCeFCgrYjKpwMDyCxEujDZBLgiqnaqA?=
 =?Windows-1252?Q?=3D=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS9PR01MB12389.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 552366a6-7cf7-402b-2832-08dce85a07ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 12:00:55.2720
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reGzt/DKI1MgoQSGTJzZ7+mUElNeI9z2KdFPVLfFb7oPXn6tOYb/enjNu4E4SE8PBVwHQ7U1e3+vKvEx2CEMemgHtfbr+DR+zOCb9FBD2Vc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB7170
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 09 Oct 2024 12:01:10 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/17020

> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Chris Paterson via lists.cip-project.org
> Sent: 09 October 2024 10:03
>=20
> Hi all,
>=20
> lab-cip-renesas is currently offline (since last night) due to some power
> issues.
> Hopefully it'll be back online later today or tomorrow.

All back online now :)

Kind regards, Chris

>=20
> Sorry for the inconvenience.
>=20
> Kind regards, Chris


