Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E546FC7EE2F
	for <webhook@archiver.kernel.org>; Tue,  6 Jun 2023 23:58:06 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.2173.1686095879763449865
 for <cip-dev@lists.cip-project.org>;
 Tue, 06 Jun 2023 16:58:00 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.157, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 356NvnZh030289; Wed, 7 Jun 2023 08:57:49 +0900
X-Iguazu-Qid: 2wHHJG9eOQkwq41zOA
X-Iguazu-QSIG: v=2; s=0; t=1686095868; q=2wHHJG9eOQkwq41zOA; m=CFdiwljNus4FUCCa4SEzZtuIojLEaC166IVqUXMeIQ4=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1112) id 356NvkWx015181
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 7 Jun 2023 08:57:46 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOeN+pBOGNlkwOgKfaR7PPr4yn9YgdXomKLgZ3riA7THaHjet5TWSFeLOSDWZKbnWIEl0+hno4fNdXltRTA3pPUvtg2b7OWWzhhSLTkBlH4U+OXaveeO0uyCegPdlafcwbLe6IdCBncOrwCZj5xGRgwfm88mtYONdf1/rnWXN2GMjoozxZ1Z2DLAVpRw0Xr3ecVWg0NVffg2QQs3FVFkPKZTlZbC6O6BYw1BCCi3rQakn3x+CrxykuDoV3rc18GTeLzyxSqMLhtJbwBdLVvSlRlmy3pn+qHumoF2LnSkWzakhbkigOFwmNWSLQpMKyZuhJGEpXRUY6GqJC/768lDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFze8NjbIJ3xf8AC/vdoRtQLW8uSORzZEaKUlsITc9A=;
 b=NGOrbFSPOiswD9iRAvdgqm1xfeZIt4mI2lRw3rHNYX+cNW/cJMWQ04povrfv2gJp5L4JChN0gfXd8tA9Ps4/ek9Uthj0gbHO8NryVpvyVW1Ic/Ueiusyd/cgYuTRJfa8WPWHZQNGYeznRFIv93rsWQoujWnzoQelNOSPyEhaFR7F3/VvjX1DsHIP61OTi7Y7b08mhdre7AmV3WSSWou35OezvQ9t7I/UCiUSwmd1x6ZuWSg0oO9YMAZcddKM9RLzW23420jMRb2wk2A81ZWw7W56lsV4yYCtBmJeVHPFiiEspkh1DwI6eeDDEvfM+8qkKQRYeg9feN+cWw3vhlm/YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <Chris.Paterson2@renesas.com>
Subject: RE: Additional configs for supporting RZ/V2M and RZ/G2UL
Thread-Topic: Additional configs for supporting RZ/V2M and RZ/G2UL
Thread-Index: AQHZmH1xq8zsPGJ1M0m62iFMvHvNS69+dERg
Date: Tue, 6 Jun 2023 23:57:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420922AD21132E042D46CE59252A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <1765D9D28CD911EB.3349@lists.cip-project.org>
 <ZH5K91uDzLaJ1MMr@duo.ucw.cz>
 <OS0PR01MB5922BAEED36FD47B0E4BC3DF8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZH8RSUqIcbd35Dmx@duo.ucw.cz> <17660D31D9770B92.16722@lists.cip-project.org>
 <OS0PR01MB59227A222C00760C832B9B9D8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OS0PR01MB59227A222C00760C832B9B9D8652A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|OSRPR01MB11726:EE_
x-ms-office365-filtering-correlation-id: b03195b6-6b92-44d7-4f72-08db66e9d15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 SMIHo9rtcAGPgcldQhvq8LrLzj8yzrSWsO3A+XXOy+sDwd0pWSzcnBYvTMgykoaxRlsPjpEzvAHFD/eGGsLBux0hDmrkk4Exd0YqG5QTpYlcdDAyu64XVOlKpjkL9LKJ0xw/RSLI1VbMCIyhHfYZCFbZtoo3Fxg+lvzs7Vbo7BB44CjxtTKE7MhQXahNxKpWmx0dXpfKhHyzyp8LzIun14jzSfzEIacDU9bLiuFkOUV5WUtizra8oSmq3pFE6enpoOT2MUtN/Msi+e3f62/NxA30v7AAOq1wNz6+Q5aNi+iZBe8esSzXiX+d1MZVaK18haGNUNFf/WuEPJdex8eImTyyekIqI+4ij+m3YxCoM07bl7LKQ/laECrHax4YSMYk0nx3LJ6XP0R2zn+Sohi3jIXGWTu/pvvjQD5lKvSkz0nFUJSLqUYxauQtamDq6UEaAAcbMdRtvh6BT15mOQW5N45uzqciJbWyDSEB0ytewdL8P2yv8FLVeFty5NXY3s+/9IhPKM35h3m7JJ8f7nG42WILqCjvCX44dE3KN3vFNn6g8cd6fgrydwfOg0BdFnvxEz2xT0GIgEG5iXHc/S1HWDwtk+ynYO+VPLDughkUNKZdm0BZfNaimbSSXz8Y4pDV
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(39860400002)(376002)(451199021)(966005)(316002)(7696005)(41300700001)(83380400001)(86362001)(38070700005)(53546011)(6506007)(9686003)(26005)(186003)(2906002)(33656002)(4744005)(122000001)(38100700002)(55016003)(5660300002)(52536014)(8676002)(8936002)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(110136005)(478600001)(71200400001)(4326008)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?WGlVbEhPdjFCOG16NE9qVXY4UmNoa2lWdUp2dmhTb3RDN2E2YkUrcFIy?=
 =?iso-2022-jp?B?MDhRVFM1UXE2VjBIdEgyZnNNTlh6aVd1amtJbkJlQ014OVRhM21ERHVt?=
 =?iso-2022-jp?B?WmdrVG45WHF6MnE3WGZ5aGs4cHJzbjdxdGRiTndoVFZXRmlLZGdjWStl?=
 =?iso-2022-jp?B?V3pVNTYweE1nSkZ2bnE4T0RjU0RjTkRjVHpyd1RGVThTZnh3aFZ6YURk?=
 =?iso-2022-jp?B?YjVkQUgrbEJzWHRnQ2Q3MjdiQW4zY2MrNkpqN2crZXJlN2RiRk9vSDRr?=
 =?iso-2022-jp?B?SkJwNHlqbUNva0RjaCtNelhxeUthVkowWjM5ZGY2emhwaTB2NHF5WGhm?=
 =?iso-2022-jp?B?d09iSTJIc083QkJJUTM5emxzaS9HcU5QTEJtUGtZcm1haFRBcysweEFG?=
 =?iso-2022-jp?B?VHQ4a3A0cmZUMW0rUC9aNmdCY0pCR3BJS1hiRUo5eUUyUzM4cWFNN1E0?=
 =?iso-2022-jp?B?TEJkd3l4QTl2UXdxbDZlQlFsWEY4aWxiV1FkVHQrWDJ2a0lPV29UTmdF?=
 =?iso-2022-jp?B?OTkvWkx5UkRnbENJaWZON0h6WGowYUN0ZVBxOXE3R2UySFBYWEFWWUk1?=
 =?iso-2022-jp?B?c1lvM000NGZ4YkxLVVdxNTdMT1k1UnBUa0JxR2F5NC9KV0Q5Q29SUlNX?=
 =?iso-2022-jp?B?WkRYNUNhNDBzWWJ6OHozREI3VEV2ZHRDZmlIKzB3TjNLZ2VKaHB6bGFN?=
 =?iso-2022-jp?B?ajhtQnZsZDR3SXQ5UmNZVFdGODBpdFE5NjROclZoOWtwdlFsWUVZYllQ?=
 =?iso-2022-jp?B?bE95Qy9JNmJ3dzdSdTNOLzBQcXdSZW9UYU4ydWtuSkk5VDR5TUt0U3d4?=
 =?iso-2022-jp?B?L2h3VzFGU1VjUndkTmFIY21Eejc4WCtDNi82aGZWNFVEaENiczZaOWI0?=
 =?iso-2022-jp?B?Zyt2UHZ2RTAxQ2pFcE9NM0x3RktKeTNFeGFaNlZVc0xybzhZUitPdjQ0?=
 =?iso-2022-jp?B?Q3hGTjJ4dEMwWVZjdHBDUk5acDc1L2c3TUd3LzZxOEQrZUNCYmlsUFho?=
 =?iso-2022-jp?B?UnJ1UHBoM2MwNk1SWGxCdVBTbHVRQkJMWkZQNjdxNExZMjlGYkw2aVZp?=
 =?iso-2022-jp?B?eHVqQ0YxTUloZXptZWFiVzNNemxUVXRpcHQxVUZMK0pheWU5ODFjTEtF?=
 =?iso-2022-jp?B?T084eWNicHltK2FZc3h5czlsUUhHVVNtT09zbTJtbXBybVNQeENWYzRl?=
 =?iso-2022-jp?B?RE5OaHJWWEd4K05oRm5Tb0lTNDdieS9UL1JsNFdzYi9KTEs0SENOOXBH?=
 =?iso-2022-jp?B?ZDRRQkVhWHNJbkhEdU9hTmN4WU1TSU9NcmF6ajY3aTJIa2NLYTJLNWc3?=
 =?iso-2022-jp?B?Mk5UNWZwdjVxVFZqQ1pleXBiNnUyQUVCekJDU0FUSmw0ZnpySGlNSjMw?=
 =?iso-2022-jp?B?RzRkQ21peUVjNm4zOVpVK1VhUlgxeG5FZWRNN001dE9IK0lPbUJ3akVu?=
 =?iso-2022-jp?B?eTFNd1gwN0hTMHlIZ3g4VTFpMzlqR080ZzU5UW1LVDZTenNOajVTUUFQ?=
 =?iso-2022-jp?B?RlgwSk1TalNDOEpFT3ZlalI0d2srNk11MTRHYWpwWDVUeHF3cUxGWUsr?=
 =?iso-2022-jp?B?RGNpbmxLcFY4b1F0L05Yc1E2d0dFUGdIVnNRenNsaGIvUG5PRisvYm01?=
 =?iso-2022-jp?B?Ky9BV2tuNFRTaXJ3N3FxMWgyd2RGRlB1RWliSHlmRldsU2o5dEdXS0lo?=
 =?iso-2022-jp?B?eDF4bkoyVHBhNTZ5VTlHTEpvV1A4TnR1K1dtd1dhcm44cS9ZeHB4UzhW?=
 =?iso-2022-jp?B?Q3UzaFlub2dYeklBeDh4UXBZbG02NTR1d1N0amgwSzhrMjVtZ3QyaFI2?=
 =?iso-2022-jp?B?Q2FPcWF3a3AxQXUydTdkbDR3L1kvallRQ2REcHhxWVpMUVhmNTdtT3Rt?=
 =?iso-2022-jp?B?eXFNZzJaZzRxTzdCYVUrVUtjSDd0RDdRQUlGbFEwNVZFNE1QMmI4RmJa?=
 =?iso-2022-jp?B?REh2YjFRWVd2a1oxbDRiV0hyN00rRDFLTytnTHRONXBWODhGSStyNlQx?=
 =?iso-2022-jp?B?SXQ0cXZqVlJRY1VRWGFDUTQ3T2Fma1RxcktuKzdLSEVxSTQxa1ZvdGdU?=
 =?iso-2022-jp?B?Z3IxRFI4dVZjcUprTnJ5aUZQaEdIeVZ1R25yZVlLRHFOWGlzK3VGekJY?=
 =?iso-2022-jp?B?RmkxMVB3RlVYL0VvUjZ1NFNNaHpwR3F1MUVmQVN0NWxQUmFSSnZzc2dD?=
 =?iso-2022-jp?B?M0R2TGRBWjBjanRMbVpOeGRFR3RtQW5rRUUrVlN5dC94aFY3cWR6RWF4?=
 =?iso-2022-jp?B?TVE0TkxMYTUzZTAvdzVBSmhhN2ZFTkJ1Y01lTCs0YTBJQlZXbjcvZGJ0?=
 =?iso-2022-jp?B?TFlzNHpHZm4yUHM3QmExZXdPTjJSUmQrZlE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	K+CYUMkqPpKvsAz73jOD8NoHH4nIGabuJXSoh1mx50AFlb/6OZvrdtCTonGDOHdvaaTjfTjgp+iUTDpgKbV2EJQOXqUx2nEonZjg0QhWX/gam3aUu7vw3Tq0ZIEEx+XO1rXF2/0jnAZ1iskK0Wt6xMbwgY1eWg3009bdXTMvcrtUMn/g8VlHE0etXgloyCHc6+ANkChmXlkdsuxVpa2cQvHpKIzFMejqDiuAl6XfEt0DZeBXOf+SpODKmrPlqfaGHTX2/1R5LJV7Uld9EhK7bikmm5deAMZ+hwmoZcZclu61/dhkofcz6rSNx5aMPU08VJdtFSnxgwp7bWi/+Te8qdmJmLB/y47Dt+Bx0U+7c31hy2/2+/D7KKAoUsgMGJkTVew0nmi8I+7V63UKHtg9+YSCGyhr45yiDDwzqWEuw5FjOjNmvekY+T8C+ucOJFKSAu5njFBJwT8wytqOlrF4TdaepMpTRUQLI2k0zfRBjkOBTGkYYmekLxiDNakH7j5irdTEBK7l+WPQOlT4QLV4QkHU+IkrDfl7S/HkNQMyrgki7F6WvNMpu7vjzu/8wOIFKwEAWLR57Li8IPM8FpEShdOGjuADwJ9nMqAQLi1vDJEivZkhm36sTOd4nKJcdgLrd0VAjEb+Wtvrjgp5Jqmr2UET4//s/xZa0/84CbUArqBH2SJdezYuifAyOUV5GPKyLW5/TXQTcysxo1R7K+ZstDshcAkXxy7ejckIm7JGqKImgvuCNICcsdkJKzh8mSywaJ6kKnP00aZR8ElXh1jj6R3MnwEqKhSIDqt33HebxJd3wPOdt9VPSuEEQ2LfZU0QWynOm+Z2qmvt4QlwUdhqSIjwvdlyHuKVPRBH7PPg1a0bXicIxbfVCIt8K+dQ6gdYvTeyMlhuCJsx/fchAy35hA==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b03195b6-6b92-44d7-4f72-08db66e9d15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 23:57:42.8850
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jYfYZadNExNNDRh0AVvxswhjXSC3kd0bNYKudoaz006Bw7Csw8bIOrelo+vKU+l664ruKOByLrwXyLwKsQ4Al9lnlaVBoR6/Dbuo+kc8nfpDpiuWMwjJYMCO6sd3b+fK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSRPR01MB11726
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 06 Jun 2023 23:58:06 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11901

Hi Biju,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Tuesday, June 6, 2023 10:47 PM
> To: cip-dev@lists.cip-project.org; Pavel Machek <pavel@denx.de>; iwamatsu
> nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I#T!{#O#S#T=1B=
(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: Chris Paterson <Chris.Paterson2@renesas.com>
> Subject: Additional configs for supporting RZ/V2M and RZ/G2UL
>=20
> Hi Pavel and Nobuhiro,
>=20
> I have created an MR for adding support for RZ/V2M and RZ/G2UL SoC for
> {5.10,6.1}.y-cip*
>=20
> https://gitlab.com/cip-project/cip-kernel/cip-kernel-config/-/merge_reque=
s
> ts/81/commits

Applied, thanks

Best regards,
  Nobuhiro


