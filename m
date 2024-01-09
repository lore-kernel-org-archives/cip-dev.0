Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3082CC3DA6E
	for <webhook@archiver.kernel.org>; Tue,  9 Jan 2024 01:21:57 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.6917.1704763308394619457
 for <cip-dev@lists.cip-project.org>;
 Mon, 08 Jan 2024 17:21:49 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 4091LS9A774481; Tue, 9 Jan 2024 10:21:28 +0900
X-Iguazu-Qid: 2rWh7AKPbdQj6T0ijT
X-Iguazu-QSIG: v=2; s=0; t=1704763287; q=2rWh7AKPbdQj6T0ijT; m=7C+d6SsIdmKI1LXjIE7ypNeLcGnts4bKOnqdByfX3gQ=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 4091LPTk2372375
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 9 Jan 2024 10:21:25 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbXz8gD2PzXeurjL4c5OO9Sm5oOc3owIPYPMSNpx5HNdJEaWmIctNwb5iI50Kq1vMSTF0N8kpjZ1HykvI3Ka7AVeT/1EZdV2fVkyWj3Dvk9PWrA518ZDrOh6S2igwcZcMI9ZDSjl65QCFcn2JyPJUs+9y+HGEuVwQ2VU2cECwNJp584OGSY8+sN1JMiX2UgkV13sKkAqAZtdWiIhnEy7pPF8xZKhalXnl52wb0dYiVFWKjJK2xK34OcJLG1OHo0cOUNVSAEmP1chLt9fRShm6XESZqJ44VNQd8JGj2ELb4JRb12Bjow3WRCwogVNbKD/7qtO/yJmW94kqf3hFGaE9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQsV/8nnoBil93cabLTPvFM4LfW8zDtu9Tvdik4azDw=;
 b=V7l3ruz37P5pa2TmOHJWXzPqD24fZ3rSKQXk557m/2+pUvNShhqOcur514vv9oKZvGEQ5SR+ofQYoKcBJSl99+GPjfrXDLFPa0HxjrvErozaTo6IRSg9lgKpSG9GOCRNi9DFEd+0asrj8D3+nkbD2cu8Ywm42o1VXr5BDcQewQ8E4D8qfy/c6d0Md1GdkQz137qP4a9FdVAZCdblhiF1s8afqnQ+MyoqBfVrgoAI6UFPpv/lgX9+vz0xYDBAofXiR3z04HYohvL7AZr1XPyaIwjl6EZjOcau4R9EUfSXKkQzl9+XyS76adVaOk4TZlQNAt3qO8YyPfLdUgZJGlX94g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <jan.kiszka@siemens.com>
CC: <uli@fpond.eu>, <masami.ichikawa@cybertrust.co.jp>,
        <Chris.Paterson2@renesas.com>, <cip-dev@lists.cip-project.org>
Subject: RE: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Thread-Topic: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
Thread-Index: Ado2zbDnlkS4H5FTS6qAkmMKGmF1ZQGwYx0AACg1uQAAEJGegAEJ4SMw
Date: Tue, 9 Jan 2024 01:21:23 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63882FA76BDEFC9D9D30D9E1926A2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: 
 <TYVPR01MB1124522792658D6523F2C04C39299A@TYVPR01MB11245.jpnprd01.prod.outlook.com>
 <77cc26df-0e6d-4415-9f06-6916643ed05a@siemens.com>
 <e6b43450-52e5-4529-8006-de503c30df7b@siemens.com>
 <ZZWmz5ZxB10Suz2T@duo.ucw.cz>
In-Reply-To: <ZZWmz5ZxB10Suz2T@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYCPR01MB6030:EE_
x-ms-office365-filtering-correlation-id: e21941b4-86b5-4e04-4432-08dc10b14af4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NVOegizPGzi1Ltv0Xmj8IqIumVhIPCQxNG+SlAvsHmEIdTHVD8BIofR9JFUfh0OKSPRqTlFI1XHWkafUYtvPPo4ZvkiQKyKgduRA9KjJISFrgdsEu7i5XfXqn79yH5E8vWiV871e0H9oq28bi20HXcKIr8RyzwVCu+uZVjZEQvj4BxcgDAtOyp6MPGa3n8SkR72iLd1i7hRJK8eLH5sQSeVSHqRBsK1M9y7jQx6G6S4sEI2uZDD0EKoLhxFMU7l3okmsEreTSvCQKAG+r3tb+uR987ctXyKdRsJq5hTlur9Gpwvk50IOUofVSiPFQZhVZi8n00q3GOyJH8v0OTm2r3244SZR1MNMmJvhjXlXBbCXfac+aDGwn6q8s2GUZRmlWWTBTP6Wfg6TsFJ3vJnmpa+QZgzt0PYRMXENT3uQbIbK0E3FfkoBPbfTf4PLt/Lluu/0HCgM49dwPQ6oxNWdevcFma09AMcq8J8T5YiS7e8yoHVpG9KVm4HE5M6xWlbVq2MYdFWxFh81PEiLaeGgzF1AJF+O0Pi1mSY7sGc6zOj+3XMh7lSTS5lHnxeip0PXt412DUS4M56893gWl/XGl8ZUSdDYcsIWrspd2gIH8fwLJ26uLypT7pdkMVXuyw+F
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38070700009)(55016003)(478600001)(8676002)(52536014)(4326008)(966005)(5660300002)(83380400001)(8936002)(53546011)(9686003)(66476007)(64756008)(66446008)(66556008)(6506007)(71200400001)(66946007)(76116006)(26005)(2906002)(122000001)(54906003)(316002)(7696005)(110136005)(38100700002)(41300700001)(86362001)(33656002)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?MjZTdy9pSXUvbThiSFVxdlVGaytrYjk2OElkU0NrQ3B0MGhCYlZSb0ZR?=
 =?iso-2022-jp?B?ZFRaS3M5dzBtM1EzbXBUTXZSSTU0L3VrNEQyRW5UN0dnRDAvOEs3a1Uy?=
 =?iso-2022-jp?B?bzdZOTRkYjg2SEcxeGNQSm9pZjI4S2JYVW11Mkl4NkVCdEFOQnVEaTBV?=
 =?iso-2022-jp?B?WUw4SjFMY09TUjdxQk9oS2xIUE9NQVo0NGQ1VEVDUWVRb3lIUEhaOEt1?=
 =?iso-2022-jp?B?R2VDcVFnNDJ5TzhpRVYzR09sOGdReFd5bURJNlBFZTVLcFc2c3JRenJF?=
 =?iso-2022-jp?B?REkwN1NqUVVQR0NhQ2VjR2FIVGRYQUNlL1FRdEIrYVorcldtMVFlYU5q?=
 =?iso-2022-jp?B?bU9VZHhlTlV0elhIdW9xdm1kNTRFYUo5cERCZ1NEWHQ3UElmZit5TGRJ?=
 =?iso-2022-jp?B?UExKQ01IMnZNNmVMeUVVTzBDM205enpOT2dWU05ka1hnZDhXZHZmUzln?=
 =?iso-2022-jp?B?UFNhb2pzQml5anJFZVlTZHc4WHJpYVRGVncvaTVkRm5rc1pSUks1RW5D?=
 =?iso-2022-jp?B?a3cvRUpQU2doUGdqM21TeURaUWVzR1VKWEQ5aVd4WHk4OXJMNEVNZHN5?=
 =?iso-2022-jp?B?N3FxRVM1bDlTckp4bTc1N25ScTZSdHU2Mk5kQlkzaktBZ2pVeUZYWkJl?=
 =?iso-2022-jp?B?S040V0pWd1d4UWtXUjdTSmZpQjdTTW9rRnBWcHg0b3gwb1pTOXdNQmc4?=
 =?iso-2022-jp?B?MGhMblRxZXNuOVdueDIxWFFIc0M0Ym43UXNFbUJjSkd4SlQ4U0xhcXk2?=
 =?iso-2022-jp?B?S1h4Q2Yra1Z4YWlJRzQ2eG9kd3UydTIyOW41UzlLbjZNbEZhYzlZMXdr?=
 =?iso-2022-jp?B?V0REY2NoUkNYVlJMYWhBMjAwWHVGcUdqU3R0Sk5sdDBBLzQ2QTBYVDhK?=
 =?iso-2022-jp?B?V3dudjkzOW9WK0pLZjNwZEgzZysvWUNpNlRPbVpoRm9SWkdzS0tZWUV0?=
 =?iso-2022-jp?B?U3E4b29yczBqclRZNG05Nkw0b0VxMk5IMk9KT0llN3Yvb1NTWFhtWVJQ?=
 =?iso-2022-jp?B?Yk84RkhZVGtzUWFKVDNSNStJMmlDT0tVNGo3V1VEZ20rRWVoNGR6WEpJ?=
 =?iso-2022-jp?B?VkU0RjBzQW9pM01sc3oveGExMnptTlNNZGpYU3ZiNUhUZUVvN1ZUc3Nn?=
 =?iso-2022-jp?B?YTJiVm02eEJtTmUzWTNXY1RCWE1aN2NWN0NPOWdMcWYrODkxZnFQSndQ?=
 =?iso-2022-jp?B?WmMycHB4TEFRVEVWSTRQcVkwdXp5Y2NZVXZDMWk2RTR2T0Y3SWlzVFlD?=
 =?iso-2022-jp?B?ZkF0T2E2bWxXYTd3L2ZIT29LVjFGektDNXlJR0QxYmZDa25ubE5nNHEv?=
 =?iso-2022-jp?B?Y2tETFExVWpZeGJwclExbUgvUlZDM1FSOHR5SERCV0ZWZFJGUHl6ejlW?=
 =?iso-2022-jp?B?Z1Fva21XMUp1dGJDMjFrRUdybFFtcGlCTDh0NDBIM1RmMDJtdUtUb2I5?=
 =?iso-2022-jp?B?ck9XcHdPT0JCQVRCZUpXYzhTZVlGWHdRSGdGdVM2cEtpcnU4Qkp2SUNi?=
 =?iso-2022-jp?B?L3kzZFpHOUladzdFSjVQOTVxTzQvcVZZSWE3RmV4bStHczV3Vlh4YS80?=
 =?iso-2022-jp?B?dmxsTVZ6NERJK3R0Ry85UzIzcWVmODc3b2d4RzlYK1lDQ0JjVklEaGJU?=
 =?iso-2022-jp?B?YmdPcE9YRkNlYUsvRmxIL2g3T2RvZXAxVUFvQ2Ezb1JNeUcvWktoTDMz?=
 =?iso-2022-jp?B?d0thZmUzamwxTkFBUnY3bmVMMStkaUIwc21DSDdDd2YreWJId2daZnRi?=
 =?iso-2022-jp?B?TEowd1VMbnZ6cGxId2xVcU5RNFlPUnkvdkdFbUo0QVhkR3o4VDJQQ3VR?=
 =?iso-2022-jp?B?K1AwUGFvcFdWR2hRUzh3Zi9xc2lkbVFTNzlKcmlxWlowM1QyL1g3a1Ir?=
 =?iso-2022-jp?B?L29RSFg0YmxCMTRqcEFiamxtdEx6d3VDeHR0QTRRaE81Q3MrYWVGQmVJ?=
 =?iso-2022-jp?B?VFhuYTg3dHdMNlpYRGE5Q3lac0xMcDFmNjdaczF2S0hxL1RhRU1UVEQ4?=
 =?iso-2022-jp?B?UExsYlJFMWswOGNSdlF6cVlWTmlwbG5qWGh4OGJaK2lVeHBJM1QwcDlX?=
 =?iso-2022-jp?B?bVFsS0ZTWjdBKy9HNVVSOUx6Y002clRzZEpTK2N3cVQ2ajlncW04WjVB?=
 =?iso-2022-jp?B?aEdRRTNuV2QrL1liNTRma01GS1I5SXYveXhmQmc0MG1EUEh6em1rdVlK?=
 =?iso-2022-jp?B?RjV4UnlJNFVGSHMyV2NlVGtNcHQwakZqNVhtSUg1d3hUWmVoNG1qbE1a?=
 =?iso-2022-jp?B?MTk0QzVCem9malhrYTRSSFhKTHZUTjV0SDRpV05WRzI0SlpWbUV5NGM0?=
 =?iso-2022-jp?B?eVJXT2tTWi81SnBmQmhFZ1VSeFNEN3Y5aUE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e21941b4-86b5-4e04-4432-08dc10b14af4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 01:21:23.2102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /pRKveR91R4hmsp84K+Lq1ar0xFwmofBiTR5ECdYsnUZaRv5ToZas2I1I8pakJ2EFzrP9lIkIXLXBpMxjIn44+yyVh7kGywcWbd0G3BYSaNmelNxeKoppudlDo/e2tYo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6030
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 09 Jan 2024 01:21:57 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14319

Hi all,

> > Nobuhiro is probably on leave right now. Could someone else help out
> > in fixing this? I'd like to update our recipes to the latest releases.
>=20
Sorry, I forgot to run it.

> I ran the script to generate/push the signatures, so the tarball should a=
ppear in
> few minutes. It looks like v5.10.205-cip42 has corresponding tarball, so =
no need
> to do anything there.

Thank you, Pavel !.

Best regards,
  Nobuhiro

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Thursday, January 4, 2024 3:26 AM
> To: Jan Kiszka <jan.kiszka@siemens.com>
> Cc: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; pavel@denx.de; uli@fpond.eu;
> masami.ichikawa@cybertrust.co.jp; Chris.Paterson2@renesas.com;
> cip-dev@lists.cip-project.org
> Subject: Re: [ANNOUNCE] Release v5.10.205-cip42 and v6.1.67-cip12
>=20
> Hi!
>=20
> > > Seems v6.1.67-cip12 was not pushed as tarball. I only find the
> > > corresponding -rt release there:
> > >
> > > https://cdn.kernel.org/pub/linux/kernel/projects/cip/6.1/
> >
> > Nobuhiro is probably on leave right now. Could someone else help out
> > in fixing this? I'd like to update our recipes to the latest releases.
>=20
> I ran the script to generate/push the signatures, so the tarball should a=
ppear in
> few minutes. It looks like v5.10.205-cip42 has corresponding tarball, so =
no need
> to do anything there.
>=20
> Best regards,
> 								Pavel
>=20
> --
> DENX Software Engineering GmbH,        Managing Director: Erika Unter
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany


