Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0382CDB465
	for <webhook@archiver.kernel.org>; Thu, 12 Oct 2023 02:43:28 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web11.3185.1697078600728337284
 for <cip-dev@lists.cip-project.org>;
 Wed, 11 Oct 2023 19:43:21 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 39C2hAoH3692469; Thu, 12 Oct 2023 11:43:11 +0900
X-Iguazu-Qid: 2rWhnZe9p7AJ3paYjd
X-Iguazu-QSIG: v=2; s=0; t=1697078590; q=2rWhnZe9p7AJ3paYjd; m=XGu2/f6Q0s9/wPRlc6lZPX3iHvT41ZSuihm5lQPwJ0A=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 39C2h8hU1619988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 12 Oct 2023 11:43:08 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAP90Wg6WDLKKxvdvsFBNExdimtrFKYkkGESlf1O/o+/wwpn8S1jR9r/zbQJvkNTQBChflb+LyR4SNbBChKqQIBHoMzr9Gw4n8Zf3YKkzdLmwyyUmEyKNA9LkedByhNA1iZ58+LXY+jDH5GiPsNyDeEEkEfYGKASo3BOnr1yt/WLYm5VTBKxnKA0w/JpJabC33ArvmoXySsinpr7XIQc/ph0cQdXeeGjELprASj1It/o5jEUP+RffMTnKc9v545WIJQkAWPhS1JuVJT+VI3pxf5KP5M12fy9TMuTsoXCohUg1WnZ00eiMkW0BkG9UmqFEWy4BpWM4wrPvT6Udl/k5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C98+XZVcy1I7GMe7c2XqKJWi6v2LbLwxesMw17yXCcA=;
 b=FqcmzhWB9Ma7C7QWSui87mKI2jyGLWPgGrDFfsgrGOhL+GaAlwVzfejTbNOZGnhYwkZzFzEwtDpEtvSjlaclwlRFC7lzVYHEuQ/A3HCM0SJLoExI+WGZvOKQM64hv1AtexzlsLW+ciD98AD3U9TlK010DZb62ZInV1GKX9hMB4YujmtfuOdVi8I2Xvq1C4OaKtdyMVtoONQ4m61XQa6XGfNt7OEKrfmsoS3bWBqC5io2T95Cg22jI+QJlxyoTR3mTrMFjp5gHuS95c3v0Dxn7tdNRfJOnEqOhtQ24RxZ3m0NssNLcuz9iE1iNSS+LG4ItXhbawNIzQJ9+w7Tm1FqCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 5.10.197-rt96: could we get matching -cip release?
Thread-Topic: 5.10.197-rt96: could we get matching -cip release?
Thread-Index: AQHZ+1kn9aFizdL2WUGa+XybfT2bSrBFdHyQ
Date: Thu, 12 Oct 2023 02:43:06 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB11248862DF02D9F762386477692D3A@TYWPR01MB11248.jpnprd01.prod.outlook.com>
References: <ZSUUJkXwCr1i3hUG@duo.ucw.cz>
In-Reply-To: <ZSUUJkXwCr1i3hUG@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB11248:EE_|TYWPR01MB9611:EE_
x-ms-office365-filtering-correlation-id: 8d946e37-e4bf-4469-52df-08dbcaccf6c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 kqXCdmFoR08PvCG2zOIhdf5zuSI7J/y2yVerdYtBz4Z+/9vLVOak8uYcDDZtoyWkpOWXjcq7q+X/cf0cDYMZCARMC7qPQWEZIsdpnfdyONBkUxG94tnL28RfTcifGyFEIhcQtbRyFVmgnH0D6aTeE/zNNYvYPrGIjAl/+4azyYEiNkRlFQITsrqhf2a6LxI+l+0hm1uQhwaHMEKNu3MidnEz++Tz45NBIDWTFFenK1Av66bqwpyCftbCoKxBaLYWhqVkIymAwVfQvvv290ElEkHNMwiXQOCbVmKlh96c0B0wfq+ZpmXD0msLSbtTvndWBd0Nd9nKC8W190DtC3IXcD7qeWeh2SjTudN9M7NUWd1qlrem8GhoRMVObaM9CIBf0OkwkcYVEp3/rCH10ZXUNQPR+xTKJ/Osw8/iw6eIGLyTsTHBShZgWcBzmRj2wD2QJ/On0b0s0TZIVoXzvPqViBxLY6ZKLXw9EntbzdZE6Nlg9WNUSrz9UdOmce8rlClHtwSLk6Cl8tM3hcYR7IT+ZPkRGiz4VvICPZTPZBUE0eMZI51lsz9HiORD1lNawgnR3u5cm2lnv7EWXXUN2vGh8sbcvZwmDrbrUHJoAJucHRup+JizxzfoMr8snv7ZKnu0cTofcg61FxUmH25sbaMCoQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB11248.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(2906002)(8936002)(316002)(66476007)(64756008)(66946007)(76116006)(110136005)(66446008)(66556008)(478600001)(8676002)(5660300002)(41300700001)(52536014)(71200400001)(7696005)(6506007)(9686003)(26005)(55016003)(122000001)(38070700005)(38100700002)(86362001)(33656002)(558084003)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?ZG42bXJNeFFQSTJYRzhiSU8wK0wzeW0vQ3VQSU9acDlVUFpJVElYd1hY?=
 =?iso-2022-jp?B?dXo4RTdJTDd1MHBDMnlmQ1MxRlVPMTFyaDJJUVZ1Y3VzdXBmempsQ2lv?=
 =?iso-2022-jp?B?SFhISDVvTkU4UlEyeE1UTmZtQlhVV3M4ZCtTcG5lNW1wVCtTbDVIWFNh?=
 =?iso-2022-jp?B?cHM0bWRKdG5qdnNMbkRURWVkU043VTR0WXVhd1dnV2FCV2FGQlpmVE1H?=
 =?iso-2022-jp?B?MVRnVzJUTEdxSzJBNGRGSFN0WFFqSjJERkRta29wRTl3YllmTzB1d3VS?=
 =?iso-2022-jp?B?RWdZRHVQSTd1cW9DUzJQbTVDazVaaGpReGdLZ0JkRlRNL0tJNUIwNUNt?=
 =?iso-2022-jp?B?Q0wyVGxFQ0hQSTRFZGFMUmJjZWlkYmNySkhCSkliREZXdWo2QTNJT2NE?=
 =?iso-2022-jp?B?VklsR2thYi9aNTBmQ3lUTU1DcEY0NExFSGxNcmNKVGRJMjZCdlRtZCsw?=
 =?iso-2022-jp?B?NkxXU01NbTZrYmhQYkNRbERCZFdiRDVMbmczRllSa3JRQU5OR2RYM1ZF?=
 =?iso-2022-jp?B?UEp4c0toWGRCUi9ZSGp1MnBNNkFUYUNhV3BLZ0Rzd24vWEw0R3dYdmpS?=
 =?iso-2022-jp?B?S0U4cnhNQXl3QlphQ1V5aGVZRERzcWdLOUlpcE5wSnJQQ1prTUJneFk2?=
 =?iso-2022-jp?B?bjd3Um5ZQUFZNmdSNVRXMSs1NUJCSkVId21ISmpZeHRmK3NVblhtc3pF?=
 =?iso-2022-jp?B?TXVtdThaM0NBZFdsb1orN1hxaDg1cFg2VFVlUHBhaGM0NFQ3SmdTdFdQ?=
 =?iso-2022-jp?B?TjhvMXRnNVptNFpqM2Y5S1hKbUk0alR2OVNvSG13c1BOdU8wZDIwMVZp?=
 =?iso-2022-jp?B?Um9pVm1NR0w3OSs4aGxqUmsydGZ6ZGNINXl6WmIrTEZyVlVpc2lJa2hw?=
 =?iso-2022-jp?B?STB0NzM0a0lnbFc2MHF3TnVSQnBIUGhndS9GbUp2UTFrZ3JJUDY2c1BR?=
 =?iso-2022-jp?B?V0RiaHZkTzJHbllHb3BtVnl4ODFMdEZ1clVmMVRTSThnWXc4SlA3M0tP?=
 =?iso-2022-jp?B?Wm9zSmE3dDZZZ2VhZVJId1pGZ0tCNkd1SkxiMkJBS2FnaS9ERFNVNVRw?=
 =?iso-2022-jp?B?TmNKNnk4eHVablk4eER0Z2pFM1BUM1BkcFUwNU9LcWUvY0w2NmMvaUtK?=
 =?iso-2022-jp?B?d0NDaGJ4L293K01QeUxXUE1iY0UrclNudWlmMTdUbXp5WXBVK3ppbTIz?=
 =?iso-2022-jp?B?V3hsM2RrNnlMRndGRFBZYWxCTEduUW1udmRzdHVEbVFyVDNrcFJOZjFh?=
 =?iso-2022-jp?B?TjR0UGRFeFpHK01JUTFoWGhra3lqSytLZ2VGWGhsbWtqOGhOM0NFdklU?=
 =?iso-2022-jp?B?YzYvMy9wZXUrQUxtTklqWDgyZitUdnZHaklselJvZVBuTHlzRTR2K095?=
 =?iso-2022-jp?B?Y1M4SkZvcWNMSllmSm1pWGdiRG9UMllFVkJLd1kyTEl2OG1zRTlFZGNR?=
 =?iso-2022-jp?B?S1VpSWFTRkJNVmV4Z3F3UnFCWVZpZkJ3alh4MEk2K0JuWWhsbTVxR2dW?=
 =?iso-2022-jp?B?UU5aSWY4b3dVWG82a240T00yajR0aFBwdXNtSjlqSi9CTUFwajNtOFRX?=
 =?iso-2022-jp?B?SS9zUFNWR3VRNStVaW03NHV5MlduTDZvMnJSaGtWYXI0NEttclRSNmV2?=
 =?iso-2022-jp?B?d3BpNjhQVTRWeWdIRnZocFdPWHRLTXQzZDZ5S3BSa1pNVkFTbjQxbnRo?=
 =?iso-2022-jp?B?MTg2MFdBc0hHVDNnMTRMZjNqUkVBbnlmMDlQNFYrVTdCSmJyaFNyWVZN?=
 =?iso-2022-jp?B?MlJ0UldXb0xsZXZSUG96cnVLMGFGbW1Za3AvV253UXp5OFd1b25WVjFF?=
 =?iso-2022-jp?B?blFYeW9pOG1QZGdFY1FTZHpobHRteHlSeGorUldsdGdoN1BEWVhJUUQ2?=
 =?iso-2022-jp?B?STlCMDhoZ3I0QzRYd1NBK1QrejlMNzNXTTljZ05PaW8xeW9mazJjd0RR?=
 =?iso-2022-jp?B?VHpPRU1PanRoV1B4aXkrdkRtVmFkY3pFUmROei9PYXZBUkFxOVdSY1ZK?=
 =?iso-2022-jp?B?OWRTc3ZOWGhVK0ZMaU4xaXhoTXV0K2VJdGNqWVh4Y0JQWlU4cmxaU3ZB?=
 =?iso-2022-jp?B?b21VT3duOEMxYVVUd2pDcTgwWUJMZUdrb0VXMDkycGl4MEY3ZEVBQnVs?=
 =?iso-2022-jp?B?Tm1yWC9jS1k2M2ZsenJmNHRzVTdGUHB2c0VERVdYbjg3aC9YYjdJNSta?=
 =?iso-2022-jp?B?V1EyVStZTHp1Y3VJOE9jS2RBaVh2TnNDNC9WVkJWT2ZrKzlsNldMRnMy?=
 =?iso-2022-jp?B?K2V6emh5TWU0MzBLMnBUWVdBdUhlNnFVeFYxVmtRREoxc1J1Qlp2SlYv?=
 =?iso-2022-jp?B?eUJwcllETGVpVEVpMy9ZNFFQRmgwOUVKUVE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB11248.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d946e37-e4bf-4469-52df-08dbcaccf6c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Oct 2023 02:43:06.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UPKUXNejrge+pII9nKg5BlDslQ+s7jNNK+QePHr3z2GsNHorcjcjdUxnm9YqMWnOPYRgBHC53+AhmcnQh1HBubOBSyVvkkiDXSUSM1BaYHxr7Gp9X4epLsuak8UluIw2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9611
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 12 Oct 2023 02:43:28 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/13389

Hi Pavel,

> Subject: 5.10.197-rt96: could we get matching -cip release?
>=20
> Hi!
>=20
> 5.10.197-rt96 is out, and matching -cip release would be useful for me. I=
t is
> time for -cip-rt.
>=20

OK, I will prepare for release.

Best regards,
  Nobuhiro


