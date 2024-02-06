Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF3C4828D
	for <webhook@archiver.kernel.org>; Tue,  6 Feb 2024 23:58:17 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.8935.1707263891049696444
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Feb 2024 15:58:12 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 416NvsBd820004; Wed, 7 Feb 2024 08:57:55 +0900
X-Iguazu-Qid: 2yAbQtsPwe1Vvbko9B
X-Iguazu-QSIG: v=2; s=0; t=1707263874; q=2yAbQtsPwe1Vvbko9B; m=fSC5ZbMchHJGaGilEJraEOy/+QaqTFo2yxUSh19gpfU=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1803) id 416NvqPa3987015
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Feb 2024 08:57:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U4mVerfjU/bpNFOU/1d7qFZaPpufdub6/VopmGBHH9eLiEvNMJGQUoR3UD2V/ejXkJfQYiwjX8HOPcDC2c1g+CDbxOeMz2zymbOyWKoIH8cfPONMJbTwSiGzSk3cwvt17hBTnPDs/rUBUFKo1lL+y9fzUtWMqlvc2ZWRy/8GEJC/P/XQb2LxwSWNxEggmwngLGk4ppqm7Yy5g1zS5ymjd6AbvsfbeTRrqe76apaQO5f+Z9WzhrJ1YlqNEpq412ZkSeUfLom8aliwRi22JEAMViWxHCZuYOgIBBNrlAApX5o7h7xfT2yUO6U4owaBKZgGzaU8QVodwkZNH0DByTgzIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Uze3qfOrpR+q569Ai7YRoPTPZrKzc5eEBJJJvOZRn8=;
 b=ftpmL4jpdpc9RuFpY4a/2Ujq7sADtqAVNLr3p7zpgVWlDEzC8tET6FG+/eHKmbDgh6UPSmFY+4AJUHISFhj0N2A4dHZeLtbjePUa3NhHH8Z6pLbfttgMQtXpfHPDptE4PTH/wqh5EIceQlZlT45/1fuwO9O4WOE1SVFjPLbioKko+Nt0Pj2tqGsat8+W5XSbU+nISSkDXYgrfJbNPW9+HX5bXwKLFVWbguUBiL90mtma5MwYl/KSojXVvFj4bo7HfD4P6TYqlrDhu1WUiBWD3EF3sLTKlTzDNOH6+h0/dMcnkZ8kSdvz4C7xcuxORwDPjpeZuH5vZ/RInMQ8875aTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <biju.das.jz@bp.renesas.com>
CC: <cip-dev@lists.cip-project.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <horms+renesas@verge.net.au>, <davem@davemloft.net>
Subject: RE: [PATCH 4.19.y-cip] ravb: remove undocumented counter processing
Thread-Topic: [PATCH 4.19.y-cip] ravb: remove undocumented counter processing
Thread-Index: AQHaWBIqimnLhGgSnEOQJ81NFOCEHLD9JVUAgADawnA=
Date: Tue, 6 Feb 2024 23:57:48 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB63888FB4C816903105B925E792462@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <20240205090303.34620-1-biju.das.jz@bp.renesas.com>
 <ZcIPsg+MWKdYHsyV@duo.ucw.cz>
In-Reply-To: <ZcIPsg+MWKdYHsyV@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYYPR01MB8200:EE_
x-ms-office365-filtering-correlation-id: 407788b7-371a-4613-4f1c-08dc276f6c3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 NGABTeA8NZ4TL38wF3S7K3QFlkmjME+2irorHBvVG2cS5CzhNWz/oFHrJeOu4ffeQP4J+rPFgGNNOxQsfJJW4QWmKEBszyVhfkPPpVaPOwdJ5fMFNhny1W3QmEtJR6ml5VqXOtg/+CnQK5ZUpdN/1FpSQFg3sW6g9w7o8mDN+5hC9KTbFQpCQ6sexOKYRFAaJOWal9L2SrDSsOB5Buz7WBmIApVqiP87fcG9seVw5fcjDPKy0w/O46VFrJm1zTY7KvyfnOvuCPkqTeZqfAU/bnDqKptFRc/A6tKB+ly8gasSxuy4Ko/JjXMOSkSsFzStv6KjzE5wp57DWNC9jvpdjTT+aJlhkmr/DyITpc2s3oTq+UwUhTwgMIk890YNrSPWm2CTPgv98kotgJ4482qnvFMuIs4AS47MaKAXJDhlV6/rFeFA9wsBI9nIc+iylSpFwVzGducAxnSzJBCBTf7P5BWOpKQDlazj4grU1tS5ifKMQWvbF3IlsNLg25OjqMhloD0HwDTtQvdO8p6PF/Eh7WbbYOlRrVkCNdSPAzjZI6kgaWKIJ4/xARRwcdzRpOb7k1FLLFlGHm5d+0pspX5tTxy+4RVz+WDcS0SWjsb0lYo6TUJnSdHwMEIdzPLFMo9nwba2jw6/L9FIe8VPtBsW+A==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(376002)(396003)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(122000001)(316002)(33656002)(6506007)(53546011)(7696005)(38100700002)(83380400001)(86362001)(26005)(41300700001)(8936002)(8676002)(4326008)(52536014)(9686003)(71200400001)(76116006)(478600001)(2906002)(5660300002)(66556008)(54906003)(66476007)(66946007)(38070700009)(64756008)(66446008)(110136005)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OEg1VnlRQnFncndnVnovZ3pEdkhNNHRJQzRHbU1XY1JOczN4NEZDYTN6?=
 =?iso-2022-jp?B?TTdoMytESWtWQUtnUzJkTEVRZVZjeHlSUWRTSm9WQ0FHU3oycjZQazhy?=
 =?iso-2022-jp?B?aGZmYU9ZdU1DbndJV2NBUnZzeHRGV2hXdkUzT1VBSEI4eEp6N1Ntd2FN?=
 =?iso-2022-jp?B?dE9ET0d1Z3FSa0k4YWorZlRrVDB0MjdFc3FVbEtEaUZvL2YxeHlvVEdw?=
 =?iso-2022-jp?B?bGw4V1VVcGx6ekN6dUJyRC9Kc2taRjg0S08rdzUwT1FwSWRWWGNuMlJC?=
 =?iso-2022-jp?B?Q2dIMTVQMkROWUNNSTN3RkVvZU5KVzMyMzZZTGZPTHVsNDE1VXdxUFJl?=
 =?iso-2022-jp?B?WnlndDIvSWk5S0tKb0V6K2d1WXREWXh6SWcxM1dnZVAyQmlHcTRxNG9N?=
 =?iso-2022-jp?B?bFFkWStBYUVsWW44ZjcwZExyUStUZndlUm9aK0VWeE9XMnZHMitQOFVP?=
 =?iso-2022-jp?B?ZVVtM3ZqTjFTYU1YRm81REhPVWpCOWhuME1qWUpQaTEzQ0U4VUZHOGtM?=
 =?iso-2022-jp?B?bzVoOERUNm5pdk44ZW9SemRzT1J6d2EwcS81RVpwbVF3M3pscDdKVzM5?=
 =?iso-2022-jp?B?dlBOalh1cnIycmJsYkRIcERBSlNBVmhEZnlaMzFhbTFCVjlWQTUzK1VR?=
 =?iso-2022-jp?B?R3ZmQUUwQjRZdW45MW9ISmlzWHhjRDZCUDQ5UkZyVWpDQ3phSnBZVUtX?=
 =?iso-2022-jp?B?V21EMVc1Y3FQdVJCa2VROW10ZEYwdjZMOHNzSG1Wd0tkTXhFeTRGZ3ho?=
 =?iso-2022-jp?B?WHNsUENRcmpSZFhxM1dVNE5MZHRMalVQeUhKNHJsME9XQ0RINmhYZFY3?=
 =?iso-2022-jp?B?NHhieHNZeFdMRFI3djAvdzh3ZXdUTXJ6dHFKKzQ1bExhQ2tsV2xwSzV3?=
 =?iso-2022-jp?B?dFVvY1cxZzNKM0dWNHZmaEtGRmNMaWtFSnlVdHRGWnF4em1vZGxVcWo2?=
 =?iso-2022-jp?B?ZWNLby9ER1RuRCtjU3hLSyt2ZEpRM0d3dzZKWXloeWNBWGs1UWlYc3Vp?=
 =?iso-2022-jp?B?Q3JVNWdIM05aTmVCbGg4MnQ2YUF2NCszcWlxbC8vS2dLOUFVYVhmeW1Q?=
 =?iso-2022-jp?B?L1dMTlNmaFdBNWlTQUpLeFdCN3VlUnltTkVIWitYeEFselJtT1IveDk1?=
 =?iso-2022-jp?B?L01STmcvMWViTFFmZWQ0VEpFNFBxVHhNajJ2Y09wK1FDWXpLUExEVGl0?=
 =?iso-2022-jp?B?RlRtQml1NUwxOXRoM2UrVElzblE2a1BBMnFORnhvMXhoN08rSDJzaE56?=
 =?iso-2022-jp?B?cDl1ZmdoMEtzU2lpUHhkMG1zMHQxcXpOWlVKSS9rR2NPQ04yaGFmc2wy?=
 =?iso-2022-jp?B?bytiTkZ4UUNZdVl3RkJUYUhjNVFFY2YwOUROZEZ0VTBKc0JjeDduYnlk?=
 =?iso-2022-jp?B?Ukh2UDZ6VnlaZW9RcTcydXJOWE5DdU1WVmhrR05PaWxoME5iU3JCNmd2?=
 =?iso-2022-jp?B?bG01N0tYSkVDcDRVRCtHNHh5UVFNUHVhSW1lM0FLOFA2aHQzYWsvUERV?=
 =?iso-2022-jp?B?Z0JXSmthdWZmWVpCMTA3Wm1nQ2R6QythS2xTYlZDbVBvUlRRdFkybWxu?=
 =?iso-2022-jp?B?NmRmZmVTTk9XS1VreUdYUDg0VUZFTG04WFFBcldBOXJNbllYVzY1SFVu?=
 =?iso-2022-jp?B?T1JwemRBTENLRFhnZkNHSFk5ZGpPdTJiZk4xcFlhNG4yaldscWtKVGVo?=
 =?iso-2022-jp?B?UzJ4SFEwUWJUN1V1VFBsR2h6YSsrTGRqVExJeEJzUWlUZTc5UHZkbTNS?=
 =?iso-2022-jp?B?bzhzYmFqNkNvYU5yZXNseHVXRDI2WU9wQUJ2c2VnUmZZV2ZCUmNEVEdk?=
 =?iso-2022-jp?B?UDk3WWIxOFZTSTl0Z3Rjc2pGVFhDUU9VbHZYazU3dWtLK3hGSVgxYkxy?=
 =?iso-2022-jp?B?UlRvY3huUUtOWTRzRTk4S2lKcTNIOGc3YnFxTVFvTGVXQTc1UStOakpX?=
 =?iso-2022-jp?B?V1VUNGFnMENhaEx5V3Z5c3AyZmZwamRoT245U1IwWjJrUEE0L0JjQVNw?=
 =?iso-2022-jp?B?R1dNVXNoeFhXY1prRFZpSC9nQXU4NkJwZWVYd21Ib0x3dXNyMkJNMEkx?=
 =?iso-2022-jp?B?VkNhM0k3cDMyVVNsdWVQUW1sT1BzVHI0YS82azZ5djdZQ2F0cGo3L1N6?=
 =?iso-2022-jp?B?SEtqWU1uNm42cEVCRHVVcFVjNEZxZ20wWTdYUk9XTE9rbHRERU1NZEtP?=
 =?iso-2022-jp?B?bk14OTdKdjNPWXVUYUVFMkNqUDlVMkVNb1VHMkZDOHVNQXhXb0EzOXV2?=
 =?iso-2022-jp?B?ZXI4SGROcnhxbDR1NWlFV29DamJnUkEwVWNmRTB0MFZOLytOaFR0SDNE?=
 =?iso-2022-jp?B?akEwem0zQURyV01VeWh2d042cWRlUTVzV2c9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 407788b7-371a-4613-4f1c-08dc276f6c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 23:57:49.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /KBfE5feR53Nay10zVRlhUKV9+h5v9/oJZ5Uz0ZyuLtgOGrVuhD06eTrutPCZwU9+ff5zic2xo4pQAHLIa9uszgUCrEYzxwgW/ghf2gp0IBDdE3xEPN7R58Zb1AIkEXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8200
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Feb 2024 23:58:17 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14845

Hi all,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Tuesday, February 6, 2024 7:54 PM
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>; Lad Prabhakar
> <prabhakar.mahadev-lad.rj@bp.renesas.com>; Simon Horman
> <horms+renesas@verge.net.au>; David S . Miller <davem@davemloft.net>
> Subject: Re: [PATCH 4.19.y-cip] ravb: remove undocumented counter
> processing
>=20
> Hi!
>=20
> > From: Simon Horman <horms+renesas@verge.net.au>
> >
> > commit 009a470365b37106bbd66f1e1a53bc6c3c0072bc upstream.
> >
> > This patch removes the use of the undocumented counter registers CDCR,
> > LCCR, CERCR, CEECR.
> >
> > Offsets used for undocumented registers are considered reserved and
> > should not be written to. After some internal investigation with
> > Renesas it remains unclear why this driver accesses these fields but
> > regardless of what the historical reasons are the current code is consi=
dered
> incorrect.
> >
> > Based on work by Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > Signed-off-by: David S. Miller <davem@davemloft.net>
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>=20
> This looks okay to me, I can apply it to 4.4/4.19 if it passes testing an=
d if there
> are no other comments.

Looks good to me, too.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


