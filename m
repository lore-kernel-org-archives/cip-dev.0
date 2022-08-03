Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E4FC19F28
	for <webhook@archiver.kernel.org>; Wed,  3 Aug 2022 08:07:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web12.6116.1659514041575187365
 for <cip-dev@lists.cip-project.org>;
 Wed, 03 Aug 2022 01:07:22 -0700
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 273878jt019682;
 Wed, 3 Aug 2022 17:07:08 +0900
X-Iguazu-Qid: 2wHHJKjbEH011uSU7M
X-Iguazu-QSIG: v=2; s=0; t=1659514028; q=2wHHJKjbEH011uSU7M;
 m=74xvILgmDazO3PUGP/n2j+GsFUH3CVwSfAVdj8VNA8Q=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 273876Wf016811
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 3 Aug 2022 17:07:06 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMMFOR/fXooAXZvDyug2z0aZmFlTa7hgQpqaYzJluBxMlcstmI1FHH1sL9G/MGr0R0n99vJV0mfVXwUDJiTGh8QAEGVs2ZJsDI9eLvjsTQbuDZjyKRb/NHa2r4Lw05wWpLv5Q8sasV7lh3DYou6R4oHrm4ZRfhEeHupNQxI0EOs+C9jYIAwPPSQhyUf5tedun3T8rBN/mAVOV2K2ha7L5yyC8MphzMRXMA3Z6t3YTDHcQ1gvfL00i33GKRc5yyAVWbszhJ7+8vDhTgrE4Wf70awmzb4Jx1yCEeoeWzJzmZNgOC4dYDBUkWE7ASYAfNb6nwARkjN/HpucwJcJrpoktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gDY73tYbAdSVEYkP+nwY5YkHFY3EjgEh72CbniphrmQ=;
 b=FzBtiXbp/fwI070t6ZPoN8O0Zv0g3oza9o55wHmmq9Z8PuD3EcxLn1aeiFCTeU5h6yXW5HNo4GEDL8bgW5OrWxOx5Wnf92xBrdw5/gIJFFxk3rRzjvvyDEINmBlhmqL3zz1m112aQ2C8BueRiy0fepqbYTBQwiECBTn6//5sUFtyj7YZ0dfhufYjwLfGn/qjhMoz6wZP40QyBu7rFWuAXOWe/0zU5c5C/qfp7vpmevJdWfwS4PyAhDJoRcDPOSZyBqdvTVvawoXgDsa8xWOB28YmRqshJ46jjwWB6RiZnlkt15d+LQg+PB9dgilgKIH2thF/7HNxTJQWKEY0Clp5+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
Thread-Topic: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
Thread-Index: AQHYpmBKiBM11Y5u50+YO6AJM0oJo62b1OWAgAD9yHA=
Date: Wed, 3 Aug 2022 08:07:04 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94208C220D2FE64530969868929C9@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20220802110850.1496057-1-biju.das.jz@bp.renesas.com>
 <20220802165635.GC9523@duo.ucw.cz>
In-Reply-To: <20220802165635.GC9523@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6ea1d34e-9a89-4404-542a-08da752726cc
x-ms-traffictypediagnostic: OS3PR01MB8458:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 qKAa4D1au9P3H5kkOAq/gigN7bel0m+l3PHzCwePps15KlBpWX0rJyq+ad+60KZniXTTcnExL0bfNgMS6jxDwxvQ6WsYxUVGFDl9w+PrzNN75s3sa2Z4rN1raO1xHbEK/DUYAIChL6dTxffSJQZHoLz++wtgFTGwoU+MbBN6PnNkUG1bgQ+pNOPGna/5YuArZTw3FmdgmgFi2WWOraqCfuCRMK5mbWx73gBZod7NUhfSj8jLpy5cMjBD+JNq/36+h5b7FvmwAJ/Y41i3ieMcmZCDJXILk1e1MEOEaluKHhC3A7GlGnGJBqw/ds+/W/cE1h9Wvud4uGbQ26NL0T6IGRUynNRr8sEFIjVM4X8e6UPHtQlDq2bywXpgMGOi8lepXnqLu3sPRpUoWCbchaNXXLB4LNSBRU+SoaiVk+f7u/rmTUBfIaXfXpYX02UPjCPOxfoLGkROOF6OvYqo2aaU/NCoil09poFeeiHPeOrivSOOIWglKwXAt41hy1WKp45HN6xUuMEDQnCoHeOtZ662MSvLtSte9ZqajZMRqREpwqa9SuQfDElBy9qmgnERkgooctfX5hVc7s/2uaniZSzIzIDJL3SRnQdhgBCZhj9H3lzMhLUR1mZcW1YrvChFI3Obf6gRSxgPUM8DWFObnGoXSTrCRnj6+zVXZx/u4ORF+1IxSL7LxEdOYnKFl9bXm2XElNwotHfUTdoC6MjNN+/XRRPr3DWkPvibhegAhJ3Wm6t+6tQtbay2w1r4MUUvzDLE5Q7+JuNXeF9kTgSNOV6ZsgCT7A9Iv8wkqjsQcH4hU7M=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(41300700001)(5660300002)(2906002)(186003)(4744005)(122000001)(7696005)(38100700002)(6506007)(33656002)(38070700005)(26005)(53546011)(9686003)(316002)(54906003)(71200400001)(110136005)(55016003)(478600001)(86362001)(8936002)(52536014)(83380400001)(64756008)(66476007)(4326008)(66946007)(66556008)(66446008)(8676002)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?TmtFcVNmSWV0WHVCN2RWN3RucWN0YklqdDdCU3ZYNVBCVDhSeW1xRTJw?=
 =?iso-2022-jp?B?elNoalEyQ3M4UGh6V1o2cHZ3ai9pQ3IzbUtqNUo4UEdaMExKRDBxYWx2?=
 =?iso-2022-jp?B?OUNQUzJHM0l3NG5jSlRqcmNDeHE0YSs1SmUyRTFkTzNrTXgrRlZ3c0pV?=
 =?iso-2022-jp?B?d2FtTXcvSGdVRjVKeGV2bFZ1bEN6cHJLMHJLWjhUZ0l0MnZxVUtHWWp4?=
 =?iso-2022-jp?B?M0ZDUE96YnRmcDdIbG4rZW9MNHhhNVNENnE0ajlrOFdDRFIveHZQVWpk?=
 =?iso-2022-jp?B?bEN6ZWFnWkdpcXFzNXpucmFDTnVpbThiazdiL2ZsQlhhRXU3Tm1JNEhl?=
 =?iso-2022-jp?B?dEhibjFVOGhvdEYraHZBaGtjaU9XT0Q3RkJ5Q3VmUHpJU0pBaDl5ekNG?=
 =?iso-2022-jp?B?c08vOE1uNUVNaWY3M2ZDUW9jZUNNUitjbFZZaGZPM2FmazJIMHBsYUpY?=
 =?iso-2022-jp?B?U243NjFzdFA4MUNQUTc0Zm5RcndFTTdob0YwSTNhNnN2U2xXM1Y2azQ4?=
 =?iso-2022-jp?B?cVJiL2tSMTFzektoMUk1RWZ1TGk1QTcvNi9QMDRVcEFTRnpRbUFjQkdW?=
 =?iso-2022-jp?B?OGpITkp4Wm00VVdFb1lZSUFTU1gvTGhkRjg1cVlUbHF3VjhNYk1KaUZD?=
 =?iso-2022-jp?B?dFNjNVR2bldWMWtrNzNXZWlMR2dHWUo5WVkwbm1mTDF5QjVBOWhEMjg1?=
 =?iso-2022-jp?B?SU83bWVmZVBDZDJob3FhQlhFZXE5R2FyZ2ErVUFDcGNHTlBGWDV6WnVD?=
 =?iso-2022-jp?B?TUg0QmlrOUlDTVVRL2p5akVsd0ZTNmx6aVJ1MG1rYzRRaEdPQlNrUHp2?=
 =?iso-2022-jp?B?dHZnRFB4SnRGZ2dzZEl1TnJiTThRVVRoUzE1cnFpa0NNMFBiWTgwTmp0?=
 =?iso-2022-jp?B?U1V2ek1SZTE4eHlVd3VEcWNXODJWVWVxdDVnRzVNUGVvUDhmdTZLcVNI?=
 =?iso-2022-jp?B?N0JESThwQlowZE1OZ3NoR2xCUGdUREpxeFp0R1VJcC92Qnc4bnRSamdx?=
 =?iso-2022-jp?B?TVVKaHRBUTBiZy9aR28vYmRCVjd6U3lYMmI1ZWowVGZsV2tISXY3aThD?=
 =?iso-2022-jp?B?YmF1RHJuZXN1WWZmbC9TYVJ3WHhaNWM1Mm5EdjdPeXhlR1J1WEdVc2Yr?=
 =?iso-2022-jp?B?bkk1VDd3bk96bHFibEFNdm9hMkRrcVZHUFZ1THpuNWZxUVZpNkJia2ZC?=
 =?iso-2022-jp?B?ZWJwN1VCWG9IOS9tV1dya1hqTzNwdXFaWEVMbXVwQVdQRHRoamdDK2JM?=
 =?iso-2022-jp?B?a09ITFEwbkZTQ0QveXRnVksyQSttdXQ2ZnZuZ3BiQU1nenFDMjlQWG16?=
 =?iso-2022-jp?B?dnQybmhJSW1FL01MZGNEcmhwdUFkUFNOMWJtS1NiR2RnSWN3ZzR6U293?=
 =?iso-2022-jp?B?U3NjL2tvNGw0cS9VNDZRRjJHRDVFL0s5TmdxdHIvVlpSR1dpRE9kVXZ4?=
 =?iso-2022-jp?B?bjRyLzNhRTFZNTRhT0FING9LaGQyVWUyelg3ek1hMHp5bEg0VmhaQ1J0?=
 =?iso-2022-jp?B?Y2IwaXNNajI4a2V0QzBKNXhwMzJnYXFEUmFTNmVvQ0tsM2tYbE9mMDI4?=
 =?iso-2022-jp?B?Um5aTDhweW02c3V1SlVlU0ZnWmRIdlowTyt5TmZTcm12aDFaK2toOTh2?=
 =?iso-2022-jp?B?V1puTmt5TThMTTFGdE9nUEc3dzBwWFNrdUFoUy85MG9GNWNBYUVoTEdN?=
 =?iso-2022-jp?B?QUl6NXZpd09kUlNVdzhackQyaC9obHA2L1RQZjQ0NDY0VytkSUJuZ21j?=
 =?iso-2022-jp?B?VTdwenR2Y2FiOU9VemhiaXFIckc3cnhJck5DVHJjNEljbVRpb2RaK1lK?=
 =?iso-2022-jp?B?c25mc29kUHl1OG9UNE9vdVdzRXhqRTlCeG40YnZUeFlXbVg3R3FqSjl0?=
 =?iso-2022-jp?B?UXAzVGp2d2puZ094aXZ5ZHU2ZTJkaHFGTlp6Z21WVmkya0tlOGx1alZD?=
 =?iso-2022-jp?B?RHU2Z3lEWWRtTDlmbUdycEFBZmRvME8vOG5nQmU5VHRORXh5alRvUGJ0?=
 =?iso-2022-jp?B?cXJKdmlRRHIwVkJna2YzV3BqQVBvRlUxY1JxSXFuUFVTeENlRWdORkY0?=
 =?iso-2022-jp?B?MFVvaEl6S2d3TEc3Y0J1QUtvK1I4dUY4Tlo2dkI1YTBWUkhiaFRnTU80?=
 =?iso-2022-jp?B?QUFoVk9HV0lQdm1ObWFUM2tPb3FQWXlrR1UrbjIycFB1RzNYdDg2TFNU?=
 =?iso-2022-jp?B?ZlhZRmRQZklyVnBsMnBMN3F3TC9XaGV6ZWs5NGhLSmJKVFlRTXJHaCsr?=
 =?iso-2022-jp?B?cS9RZTZvcklDdDgxNWpwc081bkRzWTA2QmlqbldCQ2RkV3pwYlNpQnFy?=
 =?iso-2022-jp?B?Nm1jWGlwclFHR0hqNmRSbTVOc3lKVUozQnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 6ea1d34e-9a89-4404-542a-08da752726cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 08:07:04.0977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 6hi1RL3t4D97zNSYTXNvH5D1gIBwg7wW6LXxOwgMbDNvrZB8/Cacvj99rd8lrXSbdB68gJnATvsMLeeC5D5Dkif0QURzGVKWgl0auL70lWX61v7N60eMPTQKXnOygDYN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8458
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Wed, 03 Aug 2022 08:07:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/9039

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Wednesday, August 3, 2022 1:57 AM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Pavel Machek <pavel@denx.de>; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?=
.MN=1B(B =1B$B""#S#W#C=1B(B
> =1B$B"~#A#C#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; cip-dev@lists.cip-project.org
> Subject: Re: [PATCH 5.10.y-cip 00/24] Add RZ/{G2LC, V2L} support
>=20
> Hi!
>=20
> > This patch series aims to add Basic board support for SMARC EVK based
> > on RZ/G2LC and RZ/V2L SoC. RZ/{G2L, G2LC, V2L} share the same SMARC
> > EVK board, but SoM is different and pin mapping of SoM module is
> > different.
> >
> > All these patches are cherry-picked from the mainline.
>=20
> Series looks okay to me. I can apply it if there are no other commands (a=
nd if it
> passes testing).
>=20

I reviewed this series, LGTM.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Pavel, please push to git.kernel.org.

Best regards,
  Nobuhiro


