Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A04AC3DA42
	for <webhook@archiver.kernel.org>; Mon,  8 Jul 2024 06:41:26 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.134])
 by mx.groups.io with SMTP id smtpd.web11.74110.1720420870476564420
 for <cip-dev@lists.cip-project.org>;
 Sun, 07 Jul 2024 23:41:10 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.s=key2.smx header.b=cgNsi9RB;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.134, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:CC
	:Subject:Date:Message-ID:References:In-Reply-To:Content-Type:
	Content-Transfer-Encoding:MIME-Version;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=
	key2.smx;t=1720420864;x=1721630464;bh=hIJ67rEybnX8qE/WI20JYN5AmBDAhP50ejM/YLV
	k7K0=;b=cgNsi9RB6BRH+RJ+9WdNsLrXtiYebWAPGSFkMFoGohHQVr2UrUBe9/R7jKkL4C26LEK36
	C2aOL8inZ4lE88Nztkz+IHeWaAxeNTa3pupwnhq2PZ/wqK6iZt1IwbRr2Mh6aZbQqTdqaKudq1K7b
	fcwtkOrk9jBA4DYyF02vpplJjXizbcv/UbQkbDL4uxemGa1pA3qk8pi1F3RUwx1a32Lh1Fb4OPKz6
	Sh7DeChENvBjTgUkLqwxPmuoXOZdnCXTflFyTmGD9LfM9QkwLx50EhV5X+DTb8KftrGL5MyqQ0RlX
	kKp5HRPIrklA77j0Xv7P97gB61MqAFItelKgaTomEA==;
Received: by mo-csw.securemx.jp (mx-mo-csw1800) id 4686f4CC4051608; Mon, 8 Jul 2024 15:41:04 +0900
X-Iguazu-Qid: 2yAatxQ7oesj8RLVU2
X-Iguazu-QSIG: v=2; s=0; t=1720420863; q=2yAatxQ7oesj8RLVU2; m=bfQ7Q0Oq2HqKeIUUP1xgqyog0XLero5/WYUYtCDdcoE=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1801) id 4686f3lK1296000
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 15:41:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cjcbGBC4WZ14o8FxXntWwdfamx4+ErtUtSbJRXBE8TtXpzOcrFtes3iN3ZNLmzjWPtBbRbSmE0/y/VaqbzR0jZBHlcz1n6DmF1ShkljTf5Q0bqRNe1+UMO0abk0/+afA2KoBROyblf9hjOE2+tTber/wbMoS6TOOkZyQtOR4WK2rBayLxhehPGYbYVRy3gGZTXiRyMpz64Yi9418efYGQkppA26dtIL13j22akByM5tcctVqLIdLxwL7w4X6qrG6eqQTeeP1ow5TyPbsg2tts6w3HoWkVXXo+lIAxTRp3ikdTU05bmSEiSoHFJwB4hvDAeoEmFrkiLWz1zMlRixKgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D2Sdt2Ox+jhpfzswoBiup5RlQOPYmKLf1qbxRy6xIo=;
 b=nQCoyC0HkIh9nft8gxjqmnQLdSa+JC1l8/sf/onmqo2y23VnbgUmvgZGmyRVET70r+YBHcT3NziMjJGG/U5xK2eqyLQPatZUzA/JMiCAdbaArMLQyYR/greN1huasZ0KKN8R9kzWuWtdhFP21zTLDF97pmV8Mii6aOEIqBNNZTROm3WQoU51IRmhDAVkyF1swu/sY0PQQJ1B1djnvFfugXqrcJ/8yBIhLEjd0M+DSi5eFBjJXtIEk+dIrSWo46vUEewM6D4Y42yJ9Wkza1aUBJl447gDnZ8It1jUPi/zRTkU4pe1KXlxLtqiYlNElMRhMvoZ7uz+epQvU86YBbl7uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das.jz@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip 00/10] Add IRQC support for RZ/Five SoC
Thread-Topic: [PATCH 5.10.y-cip 00/10] Add IRQC support for RZ/Five SoC
Thread-Index: AQHazto5H21sm2+Fe0qDZjg9xiv7bLHsZanw
Date: Mon, 8 Jul 2024 06:41:00 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS3PR01MB639155A8B996D8592E224FF192DA2@OS3PR01MB6391.jpnprd01.prod.outlook.com>
References: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240705125230.125392-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS3PR01MB6391:EE_|TYCPR01MB11898:EE_
x-ms-office365-filtering-correlation-id: 24044cf4-6c78-43bc-6409-08dc9f18ee0b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018|95630200002;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?NHhTWitEMjZVb2lFZzcyai9VTzk3OHQzWktsRkc4ejcxNWNWVTBEWFla?=
 =?iso-2022-jp?B?Zkx2L1B1bFZ2RHZmbHZadjBVMS9jd0JwQ2NxaUE0RTVuWmE2cmIwby9z?=
 =?iso-2022-jp?B?Ujk5M2FPS3FQMzk3Z3M0U2dUNWhLNG43WkkzUDlpbjFtWGw5aXhEUVdY?=
 =?iso-2022-jp?B?eU1aMEo1eUxpSmZ6YjlrS3pDd2QzQnBSTW1MTHdTUldBTFNUWDBuSHl4?=
 =?iso-2022-jp?B?QU9lT2RCTTE4eWhYb0VUa2NUN280K0ZPV0NJMEJmeFJCd2dueUlKYkVk?=
 =?iso-2022-jp?B?Nkh0b2Z0aUw2aWRjcmdZKzVrUjUwZ1Y0dWoxVWhNZXprcWxOUDA3MDJM?=
 =?iso-2022-jp?B?Wmp4R3M4SERSQThUTXFFS3dQbEg1NmpITWVXRWtCMklyMFJwMVJ1bXlD?=
 =?iso-2022-jp?B?bGRDd0hQR0VCQ3lFaXFVWjB6MEpmRk5KUUI5YUY1QUFxS2ZZbUhWMlVa?=
 =?iso-2022-jp?B?NXNpUGNpSnAzV3pYN2EyKzkrVnRxNnBnUm9oeUhkUkNreVM4MEg4c0Vx?=
 =?iso-2022-jp?B?QlRxVnZ3NmJZOGRNQTRFV3lEN1huR25Oakl0a0ZlRXBOR2Fkd1NCSmNp?=
 =?iso-2022-jp?B?NDRZcnpoenRVZDFlVGRmcDhlTnFuajIxWEV4b1VZZWhLNDcyN3g1blYx?=
 =?iso-2022-jp?B?bjNlbTJrN2hGdkMyTy9pbzJXTWxrdGo1cit2azZNTXhiNzBZNnNmRFY1?=
 =?iso-2022-jp?B?NGIyMTJkaFVmdXNlK0VyNW9wczZjZkRVOXVtbEcvR3pUK09ObExuK0FX?=
 =?iso-2022-jp?B?NGhQd1A4dlJUQ0pBNkRjK0pSUG1HcVQxYXdCU2JHcjZkZEVtSEZ3Wko4?=
 =?iso-2022-jp?B?R0dabnpTUzVCUzFNdHozbjJlNk1xUWtSOHNPNTA4WEs2b3pXQldDMWE3?=
 =?iso-2022-jp?B?QWIwcDZjQUhmenB1bW5ucEJ1VnhrS3dtOEJiM1I4YVVWMGZpQUtPcThi?=
 =?iso-2022-jp?B?ZUdqT1dtR2psSnB3S3ZZbTlxdW9NTExZZnV3S3owYzRDTElTM1prczBH?=
 =?iso-2022-jp?B?NUZhajNBcFNpV0o4UjgyWXdUS1ZPTTNuU25CaFpFdHAwaHU3NzY2K3JV?=
 =?iso-2022-jp?B?SDNNN0RQdXRQbGhHaGZYZW1BYTZsTk5rY3ludVhpWExrYlBCbnA1dmth?=
 =?iso-2022-jp?B?TVpBZ0J5Y1pGbzQzZml4YUNSQXBXeDdycjVicDZKZ096dmN3SEtCRjY4?=
 =?iso-2022-jp?B?L240dGJvaTBQejUxRW01ZkVqY2c3bHFGWlRQUFV5d0NyMlVVK3d0bFpz?=
 =?iso-2022-jp?B?SlhEcTNBcVdSTjZRYWNmQklKWTRkNTJkNlNDZW9qRldwZDdHYzBHeHo2?=
 =?iso-2022-jp?B?Q3Q1cEVMSXhlSlFwbC9wZDBkbVFva1hXb252c1djd2krK3ZxM3BHYjI0?=
 =?iso-2022-jp?B?dCszT0FNcHV6RkJwMDgvME10K0VHSmt0MXlOeWxxVklOeFdudnliYXZO?=
 =?iso-2022-jp?B?TW9pMHdCQjRQdC9VWmd6dG9kdzd5UjJYblpYSFJlQ2E0U01nYlBvaHlv?=
 =?iso-2022-jp?B?MEN3V1JRd3NScTVVTXRNMU5acnBrUFdrM2xxWUN6VmVhVFgvbmVwMHRL?=
 =?iso-2022-jp?B?UW9uYUw0S0R4cnNOTEtTMkhla0RtZDN0TkJmY0xQcVA5Qk05K29FNmQx?=
 =?iso-2022-jp?B?a0NIa3F2RkxrV2ZvQVZBRUNlR0Z2UnE2RlJERXdrei9wWFJlTW1VUTBo?=
 =?iso-2022-jp?B?TDR3TThNazBZTUZ0M2lmM0pqZkVDRU5yTWdaOTFTNlRoam5QTkp0MWFR?=
 =?iso-2022-jp?B?VzFEZUg4ZEpCMFlMV2owZE9WRThIT293SnJlK3NrSC96U1ZLUGovWXBX?=
 =?iso-2022-jp?B?WTJ3bnNSa3JLcWY1TWxFL2NLRGRPQ3V5S2ZvcWFwK3pzd3FrTWgyZ2k3?=
 =?iso-2022-jp?B?RUtmWFFPTitiQmd1SDAvaEZSSkRQb0dxUGtEcXp2czlKMW12Y0s5aG9U?=
 =?iso-2022-jp?B?VTNiSUYzZlR1QWtqVWwxcmZVa0kyeFg2Mi96MGxiY2dGSFc0ZEwreW5P?=
 =?iso-2022-jp?B?YzcvQlF5aVIxY25JSTArWFNsUmZJcU5xazhjc0djZmpnYkJJTlk0aXFi?=
 =?iso-2022-jp?B?UEtIRDFIcUx0OGpaeldkdEFwVGVoMDQ9?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3PR01MB6391.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MkhDbEV3eGZ2Wi9hUDB4YkdnS1pNR0xnNVBIaUYraHBkRUZFNTQ3cTVB?=
 =?iso-2022-jp?B?N2hGc21rQ3R2YVZMSkdyL0ViRXFKUDR5MExFRVVOK3FHUHdsOWlVK2U5?=
 =?iso-2022-jp?B?ZTVqZDBBNEhwMm9RUlYwUDRHTFZDenM3WEFnZmE3SnZCb0dCZTVSb3BP?=
 =?iso-2022-jp?B?d3JZdnpob3pGMEJkV0twaXBkWVBueTE0dThBT1c0TXBvcUY2K1VVYzYx?=
 =?iso-2022-jp?B?Tk5WditRYXdLOFAxNTEvU2t0RDJHM3FITkV3eTNmLzA0N1p1bk5LYkIv?=
 =?iso-2022-jp?B?R1RSSitDU0txMVpzNElHRGxqVS9HcWQ0ankrYkZEUEZBMkJWZmhuNFkr?=
 =?iso-2022-jp?B?TTRDSXVXZmg1bW5YYTk2MDc4OG5uemIzS0VvTitTVHdJY3c4NEp3aDQr?=
 =?iso-2022-jp?B?Mm1ldlYxQllnNjBsazNCeWtmZEwxVEI2UnBHYld4eWFTVzdGYTZIYXI4?=
 =?iso-2022-jp?B?ZXVwaWJUT091bk5EWStIQWx6VW8xNWU1dkZMbkxKTUwrVnlPSnZRdUdo?=
 =?iso-2022-jp?B?MTFOSDhsVUxDZlVDM0NpUkRnZVEzMTVSL1VwRDBtUFpRK3VMbEozcU9B?=
 =?iso-2022-jp?B?L1VBOVh3d1FPS1dGUUlON0JwTmlNdnJTQ3FIVkVCdldPeFRxOHkwVWJV?=
 =?iso-2022-jp?B?RVhhM3MzaCtnWnVrZlI2NllUN1U4NkZNeFUrMVZDU25PT2lJWjJGdWRl?=
 =?iso-2022-jp?B?Zk9CVEJNZU9ZWkZQRlVQNmNsREVoL2EwMFJYbTJ1NlJpWUxtamhyUzZ3?=
 =?iso-2022-jp?B?R0FxamhhbnNRN2JNb3NtTFpWM24xRms1cUFnTXpHV2pWNE1YN09iWVF5?=
 =?iso-2022-jp?B?RkU5cHBBbmxJMWV5dHRRSitxMlB4dFAzM0FIMGxFak1oZTNkYi9MVEoz?=
 =?iso-2022-jp?B?eUs2MnlyeGx0RkZKbkYwZ0dMdjZUeGJrTklFMFE2UEVUQWI4a1lnQU9z?=
 =?iso-2022-jp?B?Zy9SVXJYc3lySWpKUFBDR3hENFFCTXFtRXJ0R3N5SGhRbFQwa25DOCto?=
 =?iso-2022-jp?B?enlmeDBEQmtCYTBDZU1pbDZJRGhLSFBqNU45dzNrV1ZXa0IrcVFzUG5D?=
 =?iso-2022-jp?B?dmdDQzlleFhqdlZITFNJVEVsYzV5akVKT2swMWsvMFNJSmM0SkpYM255?=
 =?iso-2022-jp?B?U2IyaXRPeTU4cmIzcDltQ0VSbmUzRTBaTE84bDVpaWMvbFRvSjlyaXpn?=
 =?iso-2022-jp?B?NTFuT296d3gzUzY5SjR0L01lU1g4TUJLNjJacXc5ZGMrWHE2ZjNEMHov?=
 =?iso-2022-jp?B?Sk5LdEExcnFpbUZHeWhqK3BTOVdudGVZbGRTSnJYZDFYUDNjaUxXNzVl?=
 =?iso-2022-jp?B?SWYwSHNhM1U2ZDd5VUtoQVNYQnVvM1M0bFgxVUNKVGw4c0VIWTVWN05W?=
 =?iso-2022-jp?B?eXN0Ri9pTjIrMUpCSFJwWllkZlJETElYYldzY1hpdW5vY1BoVFdkVzlS?=
 =?iso-2022-jp?B?aEFlUUVWRFg4Szh1TjIrMm0yOGEvY3g1VUhUS1Q5bGY1U1d0VWdQeTk1?=
 =?iso-2022-jp?B?UVBQWUlCTGFKMkFxZGlsSVhMRktZblVqT0JoamtadEpDWE9WMmlEdGJC?=
 =?iso-2022-jp?B?R0ZxYXlEYnhJZnB0OFJUNDhjQlpXRGFmMlg2a2xTckorNGZUclhZL3Mr?=
 =?iso-2022-jp?B?emtTSVFZMTBBVjIzSmczd1dzMk1NZUdwUE5XY0p4WnNxbEkyc2x5aTZm?=
 =?iso-2022-jp?B?MkZjSWpzblNrVWE0NFg4YTFjUHRmbDBESmxtNWtkWkhTSlBFU2QxUVlj?=
 =?iso-2022-jp?B?b1o4bnV4djdtemZXYVdBTktjSGxrRk5hYkpzL0lWSjhaa1dJb0ZYT0JH?=
 =?iso-2022-jp?B?dkxlWmRnNGZFS1EweDU1VXZ2NHBXWUwyQUNoS0tXY0xFMlovQ21xYlZU?=
 =?iso-2022-jp?B?QndjdVVqSHJuWUszMkdOblVoUDhCbk5oMElQc3dDZ2ZnQTFlQVFYc01p?=
 =?iso-2022-jp?B?bDU3WVVWK0p4M3B4RGlWRVM1RGM3SU5SdS9TMmo2T3BpNTlJMHpIV0t3?=
 =?iso-2022-jp?B?M0xPcGE0M1NybkxSa21TUnVVU290WGdTc0JjekNuTWV3VjMvQ0pVUDUx?=
 =?iso-2022-jp?B?bVJDTjZiS1FhSkR3WVBxdTBiUnFleUU3MXFPNnFoSXlKWHhTeVlMOWJD?=
 =?iso-2022-jp?B?OVVyNFJLN3RGVlRKZzZqQnYzMmZCQWRyRW0rcHFYbnBIZGdxaDkvdk8w?=
 =?iso-2022-jp?B?QzNYT21TK0p1YjFKY1NIcDdSRUMybFZjYklhMXJGT3U4NkJ1VmZjbU5v?=
 =?iso-2022-jp?B?akdONFZrcTZ1TjczbnVXZGFUeWdlL2VrQkUvM2tUNnUzVm83QkU4S0Ux?=
 =?iso-2022-jp?B?UHh0ckpBNENJakJ6RWF0eVdaK0dicDVodWc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS3PR01MB6391.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24044cf4-6c78-43bc-6409-08dc9f18ee0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2024 06:41:00.1498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhudVj8J0LHEMNMZknkhR42N81KhjGbtoub1uGEUHd3kxUivfd5JJFp/0HdU0T5oXujjnfpf7np7tgcUVvvcocAM6uHHfaQq/qzYGLnL6KQduomtk8lmqtF62aiTwUks
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11898
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 08 Jul 2024 06:41:26 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/16426

Hi all,

> -----Original Message-----
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Sent: Friday, July 5, 2024 9:52 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das.jz@bp.renesas.com>
> Subject: [PATCH 5.10.y-cip 00/10] Add IRQC support for RZ/Five SoC
>=20
> Hi All,
>=20
> This patch series aims to add IRQC support to RZ/Five SoC. While at it fi=
x build
> warning for RZ/G2L CPG driver and fix for ax45mp_cache driver.
>=20
> - patch 1/10 new patch
> - patch 5/10 and 6/10 have been cherry picked from -next
> - rest of the patches are have been cherry picked from v6.10-rc6
>=20
> Cheers,
> Prabhakar
>=20
> Biju Das (1):
>   irqchip/renesas-rzg2l: Simplify rzg2l_irqc_irq_{en,dis}able()
>=20
> Lad Prabhakar (9):
>   clk: renesas: rzg2l: Fix build warning
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Update
>     interrupts
>   dt-bindings: interrupt-controller: renesas,rzg2l-irqc: Document
>     RZ/Five SoC
>   irqchip/renesas-rzg2l: Add support for RZ/Five SoC
>   irqchip/renesas-rzg2l: Reorder function calls in
>     rzg2l_irqc_irq_disable()
>   riscv: dts: renesas: r9a07g043f: Add IRQC node to RZ/Five SoC DTSI
>   arm64: dts: renesas: r9a07g043: Move interrupt-parent property to
>     common DTSI
>   riscv: dts: renesas: rzfive-smarc-som: Drop deleting interrupt
>     properties from ETH0/1 nodes
>   cache: ax45mp_cache: Align end size to cache boundary in
>     ax45mp_dma_cache_wback()
>=20
>  .../renesas,rzg2l-irqc.yaml                   |  61 +++++--
>  arch/arm64/boot/dts/renesas/r9a07g043.dtsi    |   1 +
>  arch/arm64/boot/dts/renesas/r9a07g043u.dtsi   |   4 -
>  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi   |  75 +++++++++
>  .../boot/dts/renesas/rzfive-smarc-som.dtsi    |  16 --
>  drivers/cache/ax45mp_cache.c                  |   4 +
>  drivers/clk/renesas/rzg2l-cpg.c               |   4 +-
>  drivers/irqchip/irq-renesas-rzg2l.c           | 158
> ++++++++++++++++--
>  8 files changed, 274 insertions(+), 49 deletions(-)


I reviewed this series. I don' t have any comment.
I can apppy this series, if there are no other comments.

Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


