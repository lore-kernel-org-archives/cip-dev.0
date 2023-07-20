Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DAAEB64DA
	for <webhook@archiver.kernel.org>; Thu, 20 Jul 2023 10:05:45 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.9409.1689847536436785353
 for <cip-dev@lists.cip-project.org>;
 Thu, 20 Jul 2023 03:05:37 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 36KA5TQx262425; Thu, 20 Jul 2023 19:05:29 +0900
X-Iguazu-Qid: 2rWhc6jYwXmdE1Kw2o
X-Iguazu-QSIG: v=2; s=0; t=1689847528; q=2rWhc6jYwXmdE1Kw2o; m=62kQG8dfbZ1uzprQm5E5oxFmlB5EjPtrOQ5kNzekO30=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1121) id 36KA5Riv3565561
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 20 Jul 2023 19:05:27 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOjrRa3Ph7SqoikITBhkvDetkQ9nWZZSS/PPFcartt0TiyiKDNhdcAAe87pr0Viz0aEaHcNeuJX6h7L2vsy+CrmK5ZQJGLqiqaZ/CrAdG0W4U70iFMdtuDTTu5LNaC7xBrYMSTdmrh2IYGJRZB1HgFXF4i4ZCrQd1ZP8jX6R0oxG/rVix1Fw9xiZU4P/CdHcw1zham0ynjezLIvw/IA9paoPq/xGn68Ca0OqF1MpRzTUCauBzrQ9LnP7MpN3ZwRxzpiaYwYFpMQ97uPGiIM023MI0UOU3jXfxetdfYvkraosy8/5K6L8Rv9HQ6lBi8sLWDWY7zDNiBDiUVjDXzgyJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nj30zMw0PquTw2URG7IWXM3Nl0XkbbD1lO9p4awV0EM=;
 b=OQIPkIv5czbYnKJKzj7X+0saeX5fy9ClcP7Go6x+cMHh9yYglW0LPmZDYMBt4sFcX3EOYs4vKUHaPh0od2bHbK6Kzqve90g6CWbN+uxRxSOftvxEpV6istxRSPHwtzGEbIEaW/jrSXw8gdSn1xnKxhTbYBbpP3mpHW76fVLcJWwf8SvUo7v83FpW4ENjQ0I8W+3JNMeoKj0c95J68wfm8oG4f9kPeyHTYvObWA4CgI0DFqSyb/v/vorZJjaHDPT0kMzySAiHypnfbXtVfJ4zj73mtLmxPH1JtwJXQzWUpLrhP5GCwEVml4icKY0S2ZZhzMSaibzG3sr5xj4NCG6ISA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <fabrizio.castro.jz@renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <biju.das@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH 5.10.y-cip] pinctrl: renesas: rzv2m: Handle non-unique
 subnode names
Thread-Topic: [PATCH 5.10.y-cip] pinctrl: renesas: rzv2m: Handle non-unique
 subnode names
Thread-Index: AQHZuZND0e4Z7Za0EEu7gox8KGi/ga/Cb8ig
Date: Thu, 20 Jul 2023 10:05:25 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94209BD1F4EB07C57774E533923EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230718161639.431910-1-fabrizio.castro.jz@renesas.com>
In-Reply-To: <20230718161639.431910-1-fabrizio.castro.jz@renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYAPR01MB5801:EE_
x-ms-office365-filtering-correlation-id: f7a75367-103c-4151-6a44-08db8908d6d3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 GXxcXI85bKNj4wuPXEz7M/kVzOgvwCGlptq1H4DPaJ7nBtX7g51SNRtqMOVGrUYeKWyQ2HbQ+iDb/wRXgpiaQbTK6GONHNp7Rvxs/PzImgNcC5MAtXAuppe31magevYSQa+WK1BTiokLjrj9SPgLCF9E/brqFPD61CVyJ9zYSMy2yBr9t0qoNp67Skt41R2qSLeuriKWtbW/G4KvwM+ii0Kcl7uWaQF7AvlX31YBJVbSfhMjSEOS8/U2RfAepWW/wH8FefHuAlKXmrJ5KeXPqXRFzDCOoO/Xygy/2Ufa7EweTAAK0NKV6iVfebRiAjEFM7HwTQD6SLELR/1zFbc8jLMTe4IsGqYIgnDRoFz0ajcEjYfmLv1XXPX+P2445qBlcb5vSd0xJon6zyTafbqrTU6aTBSsXvzxgp+IchBkXqP9nQJ/6N5TYBDJM/vzcvwU3V3fwalkdnFyVTfkCGgz5ExSzO8Ng1cycBDNx7TAuu4atm/ch3Ee8Yy6AkBZGdrt0J8eK0Ei4HBmqSd1a7Cas1T9O8Qn+hWG4vc7Uxn7+NqHnMOjCLXagMJ3jZGbaqGjoWbvvvggvVrIPkNumZkJ+z5PiYXHiS98Jy+qcX3LShic3A+WVaSX1X0fUzoPuWPcbx+NbtVGWWfNjecTLLESzg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(86362001)(38070700005)(33656002)(2906002)(55016003)(53546011)(186003)(83380400001)(26005)(6506007)(966005)(54906003)(7696005)(122000001)(110136005)(38100700002)(8936002)(4326008)(64756008)(66476007)(66946007)(76116006)(9686003)(66556008)(66446008)(316002)(41300700001)(5660300002)(71200400001)(478600001)(8676002)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OEFsWVVjd0dUcjI5ZEc1bTExaDNxbW1FelV4T3NhbkczdW5nTnZheGgr?=
 =?iso-2022-jp?B?clU1Ni9ENE1PVDhBRDVoRzdjcm9MVysyNWI2NTBKQXpHVlM0Vk0rZXdm?=
 =?iso-2022-jp?B?WDZVNU5wbW9CUG5lOEdBLzFTM21KWEhENVZGT2pFdjJjZEVvN1BqMnpN?=
 =?iso-2022-jp?B?YlJxVVNPaWd0VGdEWllVQjdLNWhkSTljNGtFa3RobTlibkwySzI3eTFh?=
 =?iso-2022-jp?B?SndZb0Z4UWQ0aTQxbnhudEZiVVlldStpTHdhWFdFeEJ2ZDR2QVFOdHhI?=
 =?iso-2022-jp?B?aytMM1lmaFI4bEV4dyttLzNaT1F5c1JOdjZ6b1dCcUNMNmc2cEVGdEJE?=
 =?iso-2022-jp?B?Y3h3a3VqREJublp1WllBNFQrM0h0UVVPUWhuZ2Uvd1RoVDdqRjNhd2sr?=
 =?iso-2022-jp?B?MUJ6MnBKRko1TUxVWWk2bE1kbW9UZ09QTGlTWnNYRG5JSFArMVc0N0or?=
 =?iso-2022-jp?B?Mm5DUDRtS0pXSlVpanBUUS9mREdZVEcwYXJaaHlIdGpmTGd5OHN3YUtW?=
 =?iso-2022-jp?B?R3puQkVmR09jZmUrOHZjWUY4SnFKbXBQZWZjY3FRUFBtQllUYXlyQ0Fm?=
 =?iso-2022-jp?B?S1V0TjlZblAvS284cEFUV0FmR1N6bkVlb3dkRlJMOWJvWlVBYWYySGd2?=
 =?iso-2022-jp?B?SUFkQ3lZUGxQVkVSZFZWdERMd3Yvcm5MNzBiKzJWdVowYjBSOWRPT0E1?=
 =?iso-2022-jp?B?a3cybmZMd0ZPWWdSUHJ0MVFHMEEvcFVKT3VhWDJHVGt3djBCTG1nMUtF?=
 =?iso-2022-jp?B?MXE2dGpOZlVWcitaeVNidkNvRVR1ZlBEY0VwanFhbnIvNTJVMytrYTl2?=
 =?iso-2022-jp?B?aXRxWlVuaG50ekhzNWFsb3pVYUNhUnFERWk3YTdkRnFFdEx4MnFhaUtI?=
 =?iso-2022-jp?B?M2xkcmhlTno1L1BseWdnOGpVN3lzUm83UVFjRU5IdFl6L1RQRFB6cWtx?=
 =?iso-2022-jp?B?K3M5WVFWRkJQNlhad0NHU3liY1Q1Mjk0YWRXeTQ5bUpzUmdnU0Y4WktR?=
 =?iso-2022-jp?B?blZhdTJtL3NoQWh0RllZWE44aUlwbVpCMndCTmpsajBHb1doRDJpYlZ5?=
 =?iso-2022-jp?B?YmcrWEdlemsvTVQyWGV2SVFaYm1GeHBQU3dHM1VFbEIyckFYZlB1Nlhp?=
 =?iso-2022-jp?B?VU45T0pIU0RxK0pxNnY2c0NOY3BjdVErQUJ4U3lKOFgybGNOK3Q1NHdr?=
 =?iso-2022-jp?B?T2RpVk9QYnJnWVk2cE5jYW9UT3JuNkdwb2VUMGxlTnZKcU5wSW1CeG1E?=
 =?iso-2022-jp?B?b3JKaVVGbkRTY293UVRzeVc3RjRWUWhnNm1zeno1TEx4SStNeEFaVWtO?=
 =?iso-2022-jp?B?UlRVMzhVY3lyRXZMbzRjY3U4NjVZMXk1MlZNRkx5cEM5RVdhWjh5cjlS?=
 =?iso-2022-jp?B?YWxPalVobGl6MWEwR0g1UW51Slp4Y0VSbkgxc09BTThXaTlzeFEwUFZ3?=
 =?iso-2022-jp?B?OTRpYkx4WncyU3hvRU1LOEtDMktOZWwxUUF1NktoSWQ0dy9ZRk1JaFBa?=
 =?iso-2022-jp?B?TmxQTkxOS0pBNnFvMzk0T0htMWRwVDgvK3dqU1o2eitidy9CYTlzbFdD?=
 =?iso-2022-jp?B?VUw1cmt0aDJ3eDZkQS9HcWloQUU3U1VjVUNDTFlMNXovbWs4bEltbnRu?=
 =?iso-2022-jp?B?YVRsUDZxZ2JhVnZwTFVTQjI1ckFNQnoxRkVHNGMxS0JvM1ZTMUwzMCtY?=
 =?iso-2022-jp?B?NlVhQlFQSDNXUlBUcjFlS1dGVXBSWjBCeGNtekRIbWdkbTRJYVJvZ0kw?=
 =?iso-2022-jp?B?Q0ltNGxSd0FFWFZweGtMNmt0VzFsbkFtamR3Ry9icU45VkY0dGJxZ3Zp?=
 =?iso-2022-jp?B?dlMzSnVLV0tNTmhBNVFYc3dZNHl1aUYrYzcxQjhjSG1uYmFiQnRxZVND?=
 =?iso-2022-jp?B?WHlnOGRDTVgwQnRKVGQ1R1ZlR2RHUVY1Y0d1aUNxMzVmZzdjOWNCblBt?=
 =?iso-2022-jp?B?ck1mSjBoeFVCaVZ5ZHduTGtpT0JOeG9VdnBmZmRsV2hIY0o1TnVCdXg0?=
 =?iso-2022-jp?B?NXV3WVJ0OXFNaFJmTWY5Y3FqbHBmbnpscElPdTBZd2xhYlhkcHZmNW84?=
 =?iso-2022-jp?B?eDlMYXgxYVFFa0dmczFrYlBjQVBQOGJTdmpIUzA2Y0lkV2VVUkpGcGkw?=
 =?iso-2022-jp?B?U2tiM0loWjRYZDRUMUdZZG9jd2xrZEFqVVFSS09hdzRwM3phd0tzQ2xl?=
 =?iso-2022-jp?B?Njlic3R5UVBMVUNHay9oWDVWZE9ndUhkcTc1RHdOWElHQk9nS2Z5dkdD?=
 =?iso-2022-jp?B?TU12MFZva2RVVkJHc2RnYkJBeVA3d0d0TkE2c1FldWo0M0t4NWRHaWww?=
 =?iso-2022-jp?B?bVZTdm9rS0QvK3VhcXI1QklvQThXdUw3OEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wTQYW7f6R6TqaFPonCFLLvjfTiLLWGG3Knlgffwv0MaG4+9UZdRabUEHOrw9zZdfkpWSxYegSypKS2YvMM/O3R5Vwd1F6O8Y6iNgLvwUq60Z7UAlCot34xCQLI7oaInzHIKDrwKaAdRl2varYLg8pWN01kiG+fxXTZgRPNTqid1e4da4eOl+x9gXMmOyoV0a9gbF0YridPtb1wWfKnOirJcJrFK8/dy7B/6m44uT+DfWGwMhX4fXvAXsb6JhJ3d1FZ1dDeBOJt29Oz3ulJbRrm15u//Gf8wJ5SeGueLyHTdpwGI8vb89UhHWCsLBDYV89og3zUYsNzX62ktZvjqo+4UVtW7KXgIXcPoiS/GDPqUY/Y4BECL/q68FGSVnxR84iuLGMf6X2UMmlGW3otmZxxHqYbrbD2jRNybjFoXsh5X1x+HjTy1M7rXaPWjVE1V7SFfqn/qAb86TjhUB2TcsY7L6yMu32wvD+JAm54snjlVrpYKccHZVmSl/Bq/e5be8AVXDR97J9lYTxFQOHZUYmuXPsvn3xWoE4JSsfG2tCH7ujRSLvItFvp1mJpZ5cIgO10mSUx1kpdjWRQdYb/BBw76tvfvSkDLZjdfyIzOovE703bf5kYULKmr3nqu4mpCWiWP20Z7gm6scdVwJWE3yQUwO+PPpokaHmR/sPZbIm1m1y7N4tuOJiVDMR9L4tYpkmnKExjTuJ8C+njUd5Wi0uQDjsHs/Frd9XUYBgJZNNX+VwcAZF6Q2M8oQDKHTXeOauAlCKszoTJn+FKRjJdjJLs2x/iJdkcmeomDGqtlEe4R2KoCnWq0m3ScuKXXBfeLjIdXOmyIySRxnhHeIJqKSxy3KStnfLAMJjic0nW7M4GDDA/0wdTnTa1osz/JQLbWDiaijg036LTkkJ93j06U6kw==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7a75367-103c-4151-6a44-08db8908d6d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2023 10:05:25.9424
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K+K1+2vbJ4Fohm7866iwhRKnsHyydYUefawdswCIcWE+sWoA/kNmp5Gs7KdxH3aZLOfeeah+Sg6/NjrDbnTJ1aExa/DNlIr1VNeeeANU+tfp9LG2arnZdgcExgzLXMKq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5801
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 20 Jul 2023 10:05:45 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12459

HI all,

> -----Original Message-----
> From: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Sent: Wednesday, July 19, 2023 1:17 AM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Biju Das <biju.das@bp.renesas.com>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip] pinctrl: renesas: rzv2m: Handle non-unique
> subnode names
>=20
> From: Geert Uytterhoeven <geert+renesas@glider.be>
>=20
> Commit f46a0b47cc0829acd050213194c5a77351e619b2 upstream.
>=20
> The eMMC and SDHI pin control configuration nodes in DT have subnodes
> with the same names ("data" and "ctrl").  As the RZ/V2M pin control drive=
r
> considers only the names of the subnodes, this leads to
> conflicts:
>=20
>     pinctrl-rzv2m b6250000.pinctrl: pin P8_2 already requested by
> 85000000.mmc; cannot claim for 85020000.mmc
>     pinctrl-rzv2m b6250000.pinctrl: pin-130 (85020000.mmc) status -22
>     renesas_sdhi_internal_dmac 85020000.mmc: Error applying setting,
> reverse things back
>=20
> Fix this by constructing unique names from the node names of both the pin
> control configuration node and its child node, where appropriate.
>=20
> Reported by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
>=20
> Fixes: 92a9b825257614af ("pinctrl: renesas: Add RZ/V2M pin and gpio
> controller driver")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> Link:
> https://lore.kernel.org/r/607bd6ab4905b0b1b119a06ef953fa1184505777.1688
> 396717.git.geert+renesas@glider.be
> Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>

Looks good to me. I can apply if there are no comments.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


