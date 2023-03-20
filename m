Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B046AC7618A
	for <webhook@archiver.kernel.org>; Mon, 20 Mar 2023 18:33:32 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.156])
 by mx.groups.io with SMTP id smtpd.web11.1189.1679337210753028691
 for <cip-dev@lists.cip-project.org>;
 Mon, 20 Mar 2023 11:33:31 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.156, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 32KIX650006080; Tue, 21 Mar 2023 03:33:06 +0900
X-Iguazu-Qid: 2wHHJG9eMHo31FGeQ4
X-Iguazu-QSIG: v=2; s=0; t=1679337186; q=2wHHJG9eMHo31FGeQ4; m=Ahh4QUTEWyhsMrmitEZV98KSNu+fP9LeuoL/Gqz2iMo=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1110) id 32KIX3Kr013080
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 21 Mar 2023 03:33:04 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaWITzZX7qZVnBOXFMAEXmrRz17d9HLrl4qxtp4tnKxEGKXeF5k+sakBJ4c9cO6JW3rRqnRL+swXTaXRE67kBqncPBGwe2vIjL7NKLuXqpwP8fixsMS4HRqrlQ1Nsfe/wLuT1kCW/6Hjy5n8z4RlttZzZOhKbS2Sej+2aHqutRd5DXwzWY/ceTl3A9RN1tXwokp5YPhTMyW3eJminbYHS/HxkswSmADltKbf7QmQequFkWXZnBrAOnCKvCpL+gkoEm9qOFcvPQP1bC78CfbqrnC4hQMEVXixRyPsyAP8zsPCess068J2oM3K2DSbplkANWPZ528ioffr+pTTjQwuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjWkMWFjiLhG/h8JGMQX9iwsAGs07+qunJrPKjfSs1o=;
 b=QpKDEYQpWVenEV9wmusWr44mKgYvFVkKzzRFrGEwa07OpER4cMYZMQ8ohMIWyttUbry2sU1zKP/0cngkfB62LxnPv7LoIH+7Dq5gdx2SXxWYy5gQ0kLJoJxeQ0shNHwgBnkzpEb++PrLAlYpGN5fZJuk7IQp6zT33+Rx7bPMX5PFOhF/hobKGh+2NGZkoCnc6QsV63cr9eEMqIyGk/UQa5W1LJ3hpAgsbnwFkpcvaB2nEGEC3eiKCXkfLKYNu4PHGrXp9J/NmDiyWI2AmGFgGZ2Q9/Jxb9UsELU/uD9WIu/F4tGNubgnhLZUzKAaV3R0SQeMrZO09w0jC9KoM5euMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>, <jan.kiszka@siemens.com>, <uli@fpond.eu>,
        <Chris.Paterson2@renesas.com>, <masami.ichikawa@cybertrust.co.jp>
Subject: RE: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Thread-Topic: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
Thread-Index: AdlVZA2aNCFzX31xRSu7khQE2pchWgFIMPUAADUk30A=
Date: Mon, 20 Mar 2023 18:32:55 +0000
X-TSB-HOP2: ON
Message-ID: <TYWPR01MB9420097CC9A29DF57C4005E392809@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <TYWPR01MB9420840010270BB35057B68892B99@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZBdAiL2EPlrQ02rd@duo.ucw.cz>
In-Reply-To: <ZBdAiL2EPlrQ02rd@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYWPR01MB8840:EE_
x-ms-office365-filtering-correlation-id: 99a41785-2940-49ab-9bbf-08db29718605
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JcGB9igaD8Ew59bb65odNhpyPhJzqRzj+ZPwN4gNwz/FDs/VPjNHEJPAeRA8V0RlQFjqwbKUKyzUuQ6q3gtov0TJcf3LzsmNN4A+wwD+d4+F8bj34jATfAljyn7mu0Azt39hXbYAf+6pQGv7vi6SojCDpaCY+h81W3fx386892EtyUA8PCBzjc452Al4D9632puIoUOrNYHe14n/ArLWg2PuJoywer4AxbWQ31kRfEhgzoWv0ZPV26GIFZyeyUK97WK4yJ7j04C4EgpAnxOBPzcbvleN8geMxPOxccvYB77zCPZKBm3dLIJ8TuFtUV9+ZGSLmYboeFGxirTDW+eg8IVgKBHmMLF6bWW91RS7LTRwTB22f9a6h434p+eVW4/PTLe0dG84aY0gK0/7NluRsywqtceryHlE9c7dFZ6z5zaQlwVp+jqJT5PPwg+Jcaa1AKbgDqkGCmBaAoCAAbutDftEEsWHFu5gXwv6KFUE0GpKxNEWkxb/Q6s9bqY8cM5t3NlO+rGvpkks0m1YPgBMxr3FTMitMZgOTACblq0wreK8+nHEmSEh8ajUh1ci0P4XJshrzPx9WQOK0umJ9LyKzYKQfKM+i7eIVoT4XZZXgdRKUpQqempJYLb3CdM4LBcJwHtA1oDtwIAwVAClWhpJqnsoPOAgeXx1qV1dsJo1Xn/qR3EYBsSmDXMX+xF6Wnap
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39860400002)(376002)(366004)(136003)(451199018)(38070700005)(6506007)(186003)(53546011)(26005)(9686003)(71200400001)(55016003)(7696005)(38100700002)(86362001)(2906002)(478600001)(83380400001)(122000001)(8676002)(33656002)(54906003)(316002)(64756008)(8936002)(4326008)(6916009)(5660300002)(76116006)(52536014)(41300700001)(66446008)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?bm91bDY1WXljdGlLd0x4anc2SkdobEp2SmhvSk1iQTRrUnRHY0ZkWkFm?=
 =?iso-2022-jp?B?UzRwSU56OExVd1hLV3pCRFJadVI2L0kyR0lyVSsrQjByK3pzNmRyejRY?=
 =?iso-2022-jp?B?cEUwZlJiMEREK00wdDJIWWEvSFZQUjMraXhQd294Skk4SURuelJUbFF2?=
 =?iso-2022-jp?B?TVYxVHFYK1BHRWtGeTRTTkswbXY1WUt4d3hNMUM1d1RQMExzbUxGMURL?=
 =?iso-2022-jp?B?d3VHY3puNXA3QXVoYndMUzlFY3UwYVduZ09ZSDdBMUVUV2E0Z09IdVZX?=
 =?iso-2022-jp?B?bkFFdVVxL09JMDhTZkEwdXVoODZMLzZkcGZ1RWNwNVd5cStyUnZzTmJ3?=
 =?iso-2022-jp?B?TXNKUUlGUTVCZXk5WExXbWkvMkdBVEhjeHFUTXZlaDNRMjk4OHJpOG1j?=
 =?iso-2022-jp?B?Z09SKzBoVWNkdXlTMVhQOGkraGlCa3pOR1lNZGVBMnE3SUZ2WlNBalM2?=
 =?iso-2022-jp?B?ajQ1WmVkUEowNnFuUERiUHBQOWpEUXBTL0Z6RjJsRXVITDAzMmJtQUpL?=
 =?iso-2022-jp?B?Q3JnU05LZkxvWGNXbGlFOE0yQjZmOXdmREo4dDRGRkxEcVJLc0srTU5u?=
 =?iso-2022-jp?B?cklJK1NrTkM5TVpzVlhuaVdKRElycTR3N0xDOFN5bEcxYUNYVDc4RWJj?=
 =?iso-2022-jp?B?dWkyb0M5QS8wbjcvNm1Md20rcnNSUlNydm84VnJQbjJ0NHhmOFVVK0V4?=
 =?iso-2022-jp?B?VWx2QjdxWWwwa0s3S3Yxb3IzRXdYdlgzazl6cG5OQlFPaS9JL0EwOEE2?=
 =?iso-2022-jp?B?UWYxRWo2OVBWdXprSjEyQlNJUERTRXM4dXdxS09HOWtERHdzQmlPaW9i?=
 =?iso-2022-jp?B?Qjl1T1IyTFVUeXArczB5UnIwc05IeHRudFh3REVTSUtiQVhRaDNqRlRm?=
 =?iso-2022-jp?B?dmdBMjNaL2tZb0ZlamxqWXR4eGRPNlBlUGdmOElQQlBQZHlxYjZESGM1?=
 =?iso-2022-jp?B?SlEwWmVxNXNubFMrU1Q1N0c3Zk9pQ29INkxnY1RDQXFSVzhwcHRpY1dy?=
 =?iso-2022-jp?B?V2NkQ3FUSTZLQmt6UzdWUTlIQUNvYlhGcFp6V1Fxa2lNVjcxQ1dKanZN?=
 =?iso-2022-jp?B?ZnJtNEt0UVhNOFVMUUxXc3NqejVMV0VJQS9OM3VqQUFYWGhWZGVySS9D?=
 =?iso-2022-jp?B?QUxOL2NNeE5VaHE1OEE3dGxXaFRSNkVTWldnbW95anhsbnRpQUpWZzJV?=
 =?iso-2022-jp?B?Skg4NFBVWDJlK1J4R3d4azhjZjBVM20xZ0lEUjlkVGxtZ2V4TStITWF4?=
 =?iso-2022-jp?B?Z3NpTjRmZElNazV4MVl3QlBDVGZ6L0xGWGpTRVFOT2VhUDNhNDcwQ0xR?=
 =?iso-2022-jp?B?aTJzQ0R2NWpDVHdLR1pVTFp4eXJjODZHdWNsVkt1bHV0ci90ZldGTGxU?=
 =?iso-2022-jp?B?dUNPdHFKN0tCSFFWU29Ga2Rna2owNGFoZy9JYlFMVGJTc3FDcFFlMSt1?=
 =?iso-2022-jp?B?YXcxS04vVEF1cE9DZHNueFRJY1l5VU0ycFFJRXdDTnN3aCs5RDB6Qk01?=
 =?iso-2022-jp?B?OElMUG1RZVhkUDdBNEZOV0ZZcGt1S3JCVjNqVEM3Zmw3V1Z6aVYzS1Jj?=
 =?iso-2022-jp?B?bDZOVDV0MDE4K3VhRVVUY1RuNHk5VGtxTFdNQSt3MU9qUlVDcytPbnVr?=
 =?iso-2022-jp?B?ZEZOTTVoV1RnZndpRCtNYUxjWkRJT2lUSi9aNkdid1pQOVM0c1ZPNldJ?=
 =?iso-2022-jp?B?UmZpQjR3Vnl6ckJUSi8rK1hPaW9RaTFId3lzWEc2Z3h1OW1pMmZJWGc5?=
 =?iso-2022-jp?B?aGU4SWcrVXFOS0p6Q1JVZ0R3YmU2dFBCODNlK0NMN1E4WndWa2VaYUhK?=
 =?iso-2022-jp?B?NXJCM1A5dEJPUHFOM2tJbk90YkQvd0VsZjRWbURWNjV2NDFJcnRBV1d2?=
 =?iso-2022-jp?B?Mjdqa1JMZlZrS093SFovajZZaFdBaHlSVnhUbURYVzUzK1EzN2lSb0NE?=
 =?iso-2022-jp?B?RlVUYVEwanlmV2g0eC8xbDBPcDg5U3d4R1ROTWpaUkpwTnBHemE0dFd0?=
 =?iso-2022-jp?B?QkROUURNaE9zcW5aZnIxSmorVGpTVHI3aVhtZU04S1I4ait1cHJYQldp?=
 =?iso-2022-jp?B?Z1ptN2dmYlo2cUkyeUZJSXpoRFJRMmRZeGV6dGVaK1pvVnJvc2wzU084?=
 =?iso-2022-jp?B?WDdsQ21kRWN1ckN1dVF1d1hZc2lOa1VCeHBZR2o1TVQzVVB2M0VmR2ZO?=
 =?iso-2022-jp?B?ckR6Nnh1dmZnVVdESnV5SUR5VlJaOG84Z09pNXUwbWk4WkdYcS9DNUVz?=
 =?iso-2022-jp?B?TldQMy91di9yU0ROL2V6S294cm85by9SWHlvNkt4cndFS3dpdG1xY3Vs?=
 =?iso-2022-jp?B?b0wxVVJteFJOMHB4RnVSYVFyTHVaUmJIREE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99a41785-2940-49ab-9bbf-08db29718605
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2023 18:32:55.9301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /GnTR/Q5qpzZIITGkN2JW1eIfU6uvhaZ8FnRzIzCRfRyXbkSMw9/Q8/gBluz3+Iux4IuNPFcGhp2n7f55kkNuEHwnVVsKcnd8ZrhemLP98RD5/g3pvCK5yCVZ7xQWQcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8840
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 20 Mar 2023 18:33:32 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11037

Hi Pavel,

> > CIP kernel team has released Linux kernel v4.19.276-cip93 and
> >  v5.10.173-cip28 The linux-4.19.y-cip tree has been updated base
> > version from v4.19.273 to v4.19.276, and linux-5.10.y-cip tree has
> > been updated base version from v5.10.168 to v5.10.173.
>=20
> What are the plans for 4.19?
>=20
> 4.19-rt is due around now. There's suitable -rt
>=20
> Date:   Thu Mar 16 08:05:18 2023 +0100
>     Linux 4.19.277-rt122
>=20
> . Could I ask for matching -cip?
>

Yes, I will release -cip to match -rt.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, March 20, 2023 2:04 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W#C"~#A#C#T=
=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: cip-dev@lists.cip-project.org; pavel@denx.de; jan.kiszka@siemens.com;
> uli@fpond.eu; Chris.Paterson2@renesas.com;
> masami.ichikawa@cybertrust.co.jp
> Subject: Re: [ANNOUNCE] Release v4.19.276-cip93 and v5.10.173-cip28
>=20
> Hi!
>=20
> > CIP kernel team has released Linux kernel v4.19.276-cip93 and
> >  v5.10.173-cip28 The linux-4.19.y-cip tree has been updated base
> > version from v4.19.273 to v4.19.276, and linux-5.10.y-cip tree has
> > been updated base version from v5.10.168 to v5.10.173.
>=20
> What are the plans for 4.19?
>=20
> 4.19-rt is due around now. There's suitable -rt
>=20
> Date:   Thu Mar 16 08:05:18 2023 +0100
>     Linux 4.19.277-rt122
>=20
> . Could I ask for matching -cip?
>=20
> Best regards,
> 								Pavel
> --
> DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


