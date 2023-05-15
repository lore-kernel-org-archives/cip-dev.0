Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F33C77B75
	for <webhook@archiver.kernel.org>; Mon, 15 May 2023 23:44:39 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.133])
 by mx.groups.io with SMTP id smtpd.web11.6838.1684194272831542720
 for <cip-dev@lists.cip-project.org>;
 Mon, 15 May 2023 16:44:33 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.133, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 34FNiU4K005363; Tue, 16 May 2023 08:44:30 +0900
X-Iguazu-Qid: 2wHHyxo6zMg26WAneh
X-Iguazu-QSIG: v=2; s=0; t=1684194269; q=2wHHyxo6zMg26WAneh; m=UKQHy21SGizLiRYYbfy35JcPlB0mm8nkGILE/e534+4=
Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 34FNiSrD017697
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 16 May 2023 08:44:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdZR2X9gY8SurPDPl6MXFLLDOAaMjCO9ttoxXeDDVhM0YcOhiCHqh5c/bLeA0Y643zMHt32fcgERH2l+1FkEnZvd/XW181aM5x0GzPbYmTMaKAQcuEU0UkQOKUyHm6ZgcOusifjy2WWhQ0P0vZNZ5otXC3OohSCPEUyXCbdE4He3BtnQ93iqQ49iUnrh4bfl1GNQyVTCmcAjQ9aH/dyiuwNZLwFvTZQPZWu1UDhi55QE9vnb6B6HdpsOZn2THtq0/Fmz4d4nb4UB3glNz5X13ckumZUiqpb9ogu35p/HxzOGzXYMNEwA5wr4gk/OWjvJKu/b7b8BBnwUVjZ3lg52Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+cTJHkcbPON7UyQOtbCLnOuCDPwaDV7DpReynqwYFYw=;
 b=jkXSu/YgF6s7b3EJGJ/4USwhT8gjhbCd2qlSVovLgrjAWFl77CfCVR8eeN65bfFUC6oVL2AppGSvwPBsoyTQuqBeT1WdGhioDjdiVMTLcJILaRwtA4qCpquqStVmTF2NJPe3Y/KVfwp5BOPos79/17jSMIK5XE0AIe9JZ3ZYzArg/9DKmDM6ydgvDSObdv1abIvDyYBttStFwRtihm2aXYklKwG7xvNPDf9c4e3XqlpTNBSOOb42a2VrnZiKb5A/aa9RRlwZboTlwN3MMBebsL9IyeYWnljaYtFG+sig01n/6pvVxKEWyronp3Z88JsA70amEQr9AH2EtjISItwCkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <Sai.Sathujoda@toshiba-tsip.com>, <cip-dev@lists.cip-project.org>
CC: <Sai.Sathujoda@toshiba-tsip.com>, <dinesh.kumar@toshiba-tsip.com>
Subject: RE: [cip-kernel-config] 5.10.y-cip/arm : Add audit and nftables
 configs
Thread-Topic: [cip-kernel-config] 5.10.y-cip/arm : Add audit and nftables
 configs
Thread-Index: AQHZhyaNEoA2DAUZV0e86dI1SyyRTq9b/+hA
Date: Mon, 15 May 2023 23:44:26 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94200113BE18ACF7D34FA13A92789@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230515121238.14356-1-Sai.Sathujoda@toshiba-tsip.com>
In-Reply-To: <20230515121238.14356-1-Sai.Sathujoda@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYVPR01MB11244:EE_
x-ms-office365-filtering-correlation-id: 7f14ed2b-0efe-485f-aa23-08db559e51e1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 DZKFzIpLM0l1waZrvx95U9BLTN6waRnWAsJLU6oTJZVKU7XFCDP8v15r9lM8BstS3dbVcfq8dsIKnRdLu42tpaAgilokiTe2qTuTYQgP3onR25K2obw7SdSs5MO/06WGIymqj/S6i8nM4sr0FgpBb1zJehuA7ucbP4ztzW90ULApmn6OmWjHrduc0xg+h/Iz9SD3Ese98sW1DGE/WIQ1C324xH4axnAXQUcwOtV3aKcVbyhyoYG29S08yB4FsIMBxuOo3cM+paJqNLefn5elRjUqWLtriqLBusVXyGE80pCVeFN1C6QHOIgy5qhiDRWkgWc19oMy0VZhhElq8VsvNXc6jfmZALwv6ry8xFZbTt0UeHNE0i3j2g+Ua76P+kPezyj7mgfldDKJTh1zfSX022mdR0sAZboDuAHJ7YLlVJvAvIKH7UnJWEOS4VV0PIfOaja6D3e3HWkAZS5Uw61btkD1u0w4nDmF6QOOFa48jno0wngLR9xdjC0prEjzLZ6KVZCLDElcp8IWuCYQUMCYaCI29b0rn+lR8QbnXK/zV10UQ2FEqw2tO/ALhrimGqeZudTaD3D+9xUEh4c1mI0nc1iTkFhVTStSqhlezGTT8DcmCsQq3c7xm3MfBZqCXFvl4/nynUr1SNtpuGac+bbvxg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(136003)(39860400002)(376002)(451199021)(55016003)(8676002)(53546011)(9686003)(5660300002)(6506007)(26005)(8936002)(107886003)(33656002)(86362001)(2906002)(4744005)(83380400001)(4326008)(76116006)(478600001)(7696005)(41300700001)(52536014)(316002)(186003)(110136005)(54906003)(66946007)(66556008)(66476007)(66446008)(64756008)(38070700005)(38100700002)(122000001)(71200400001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?NmNwTUpXYjdQSFVhclFEMjVSZXhSVmlCdmJZTkx5S08vaW5VcndEbmY1?=
 =?iso-2022-jp?B?MWZuNVZVRGtVWEphN1A1aDJ2MGxTeVNhWDZKK1RYOTRaUjcvcVdhdFlj?=
 =?iso-2022-jp?B?anBKVTRsNXZ0bFNON0hBSzFOc2tlc1AvVzd5TjR2TjU0USs3SHkrUmRv?=
 =?iso-2022-jp?B?L09xelU1aHU5Uy9hNldCTVFMNC9hcXJKL3BJL1FZaFNUTXNIY2daNmNy?=
 =?iso-2022-jp?B?d0JuVGcwcmloNG9JVit6MWZDUkxVN2VWRmVyYmJVNld2QXZPczdkMjBS?=
 =?iso-2022-jp?B?bERmQkpUclUwczR6ai9lMXEvaEVPakdCak1QZHd2dzNsOERzdVA0WVB0?=
 =?iso-2022-jp?B?amFqSlpEaE10Wms2RkFUaUExZk1FR3VtYm9oa1FKM2Fxc2lyay9mUGFY?=
 =?iso-2022-jp?B?VGZNZEZvT244SC9sOG1ieVBpS3hpNEtPdTVOYlg3Z3NIMzY4ZG01ekZk?=
 =?iso-2022-jp?B?MnBpdWk5SjRpa2hVdFJWUlRjdU9SaTBYN1NSeUNOTCtWODFYUStwMGxQ?=
 =?iso-2022-jp?B?NVhYTmhWQXJCOVhrd3M1RFZNRVhqSUxSd0JiTGprWjVzekVPWUJGTzVx?=
 =?iso-2022-jp?B?TVVZcFhjS3lCa3p5OFNLRWkxMWJWNitkeVRJZjByM2ZHSzZwUlU5Ky9u?=
 =?iso-2022-jp?B?ZEVGRmJzSmJWeHR5YXdCV2VqMmx5WnJTalRObmQ5YU8yc2Q3K1FHbGtM?=
 =?iso-2022-jp?B?VVhua1pkWjFsNjcyTEswT0cwUU5kcUNJblJyZXpVam90RTZzYm1kRHFS?=
 =?iso-2022-jp?B?cEZrQ1VLLzBtaHJjdmwxWGJpWUJMMjJQSmRHRkF4MDRSV0ZIV0RBazBn?=
 =?iso-2022-jp?B?UHVIK25uRmVPVHVmWmlsckh3enVDZXVyWW83OEtwZllQRVFLcU5MUFRE?=
 =?iso-2022-jp?B?NHQyemtvQVRMcndlWnhoWGl5U3ZWQU53UWExcDNBRlllc0JUK0xUTXZs?=
 =?iso-2022-jp?B?T2I1VlBxVDlldW40aXBwVWozckFobnJPWnBtVy8ydE52Zk01NnlTUnA0?=
 =?iso-2022-jp?B?dERCZWJ4OW0wdDUvdWVCeWFIWGNqcThHeTlCM1J6QkVWQ3IwbmNkMmsv?=
 =?iso-2022-jp?B?cmFZNXF3ZUh1cXROUzA1a21NbitJNS9NU0Y4clF2K3hTNGZuaFloVnQ2?=
 =?iso-2022-jp?B?SEtwc1Vsa3FxdU1RR2FscVFRaVhWRDRZaCt5SEpWWTJJQWk3QzRoamF4?=
 =?iso-2022-jp?B?U1FOckQyb0ZpaFE5aFpDWHlUcUd4UWlrWjVKU1ZTcDdHSkpoVTBxTnpq?=
 =?iso-2022-jp?B?OXIwaVFqUUo4cXVxKzUvSXVGODBsZmNaeWhpelZ4NE4va3BIWE5VV1h1?=
 =?iso-2022-jp?B?UzdUUHhWQUtSVmdielFwdVZvQ1ZlM2RBTzhXSFBBT2dVTnE5MUtYZUJ6?=
 =?iso-2022-jp?B?MWtjeVg2YmM3bmdoSENUUTFBbXZva2FFWk1TUTQwVlVHT3dPMG1sSWVo?=
 =?iso-2022-jp?B?Z01zM1F5a1R0VjU0QjhLWUNSVmFPc1dkRVZsNnVZT002WkkvclR1Z25R?=
 =?iso-2022-jp?B?cmpDRUtISTBzRUpxV3oxclJkWW1FWmRnU2pmU0dmNW13NERta290c3dI?=
 =?iso-2022-jp?B?VGE5ZG1xcmNOdlRNZ1ZraUdJWUhDK1c0K1FjZHl4U1p3VS9jM2tIdWRp?=
 =?iso-2022-jp?B?TGRFdmI5N3J4UzVKNDNpTk5mODNZeXdkUUxtQXpXK2lST2hWbDBUc2k2?=
 =?iso-2022-jp?B?Q1dsakhhendXcWt3Sm5pNlRXVHc1RElBSDZhN2F6a1VzQThrdU4wZWZj?=
 =?iso-2022-jp?B?dlB1M0lVenhKczlrdTVQWktEZy9kc2FLV0phdkhiUGVvQlM2MHRhNGJD?=
 =?iso-2022-jp?B?K29Zckp0RjdKaTN5QUtNY0pmSDlrdm1GV1ovdVUxdlk4dGNsTE1HWUgv?=
 =?iso-2022-jp?B?SHRaenVCYU90ZXdtamxJUnA1Z3ZJUWhESnRCWGpRcnQ0eUQzbXRwWGxK?=
 =?iso-2022-jp?B?YTdQUm5rSUZTbnhCQmpBUlNxWUgvcWc2NjhZd1UxVnBWV2lFMkVGczVO?=
 =?iso-2022-jp?B?dUlzODhWSkN2ekdQbi9Xd2Z3QkRMcHhZWGpqNExYSU5nRFAvaTE5MTVv?=
 =?iso-2022-jp?B?ZElZWlRDVkd4UmJ4c3VDV2FEMWJiYVNiaHJRWjNWUnE3UHlhYnp5SW5s?=
 =?iso-2022-jp?B?NlNxb0JrbDlQeWtMMDl4KzVCNTl2TS8zN00zQmhYNHVJa0hPUWZjdENo?=
 =?iso-2022-jp?B?ZjdQSkpnV0oraTdXaXAyQlM5TUFWbXpNbDIzRUo3L24xWEhQSml5MXp2?=
 =?iso-2022-jp?B?ZU43dnF6M1FDMVpqMmNacXU4MlJYQUFka1RsanhxWmpNbGpyVGpsUWp6?=
 =?iso-2022-jp?B?Qm93c3crVkcza0J6VnZuMmF0c3BkQnQrQkE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GiSLDTTjfBEoNnGrvwUFITbYPtFU9CZZl4k7D3iQpwfU5GhX/FzIQRPmyqPT7mHYRGUcy+p0PVA5kRS5ynWl2ZtQ8tp+6J64Cu0mxgB6yrnOmL26tK8RH1/HEbFxzhvnXVJXUz4eooi/FcCW1bhkNfpM5O6R2HpJy+gJrVimjPXaCjaoirPWjPrSREuFjDT7ISpucYKPT18dwWS40EMRdAx4lqmEMYYhycP93x8lbpuP5BJKwRlsjHnvR8ehOUAs+sizf/oKRnlw3MqM5r/MYzHXs+o0RSozgrwtcffsFn4M42GZV9pqFTg83t/IOgGJ41TAYXrorkd7chSscJ0MXuibosD+fnkaaZE5uaL5uZes1bS0Uvifk13t0fIbAI+7gP+OhtWhNV34jeNoRhl44PAuWva2XBzLJ0GHsu3/fKhuCiSRd53TnfSBpoieYMPRymtqqMxoQOcj1acrGgkIwVT0rcjYlx772Csw2eq7/c/udC/B+/09ANgIJPwdSf+uANVI2rxFN4OcjlisNMWW7mmFsV5pq6EwNm/E0A7HXk5LjIB4wKmXr3v9bjLqCe41XEwHSpxmLPUEkjse0bEIqFFqfin12ZIOS43ieviWnCb6oS8RYgEE0ffs6uA+U/j4qe66+ofP1NNCCl2gprSDwaWhUJ/ZGVWHeusnS+J4+KYtHhPhUFx267lu1IOTaBcaAB5cI6DPZWrDcXc+fUSCa4yVriPyVCFHkqWljOtLD/q2aJP7PkYL5g65v3D2HsvnHByg4GBRX7nd4dAphBHzEK/rpD96gFcslNia4qGeENNOIzUuTbzFnBdKi+IiDSfb
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f14ed2b-0efe-485f-aa23-08db559e51e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2023 23:44:26.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BgF8nhtQzfBoZ0pOIjGz26kM3UrzsIcFOUm078fLhcaYULCKlYhr5paLgQCqCi3bVCL+ej07mO3ADVWcCi5zKTM8MxOtdWBLyS5uPJMbV7TWCjsNbBBSh9R3T/+gXE0F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYVPR01MB11244
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 15 May 2023 23:44:39 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11461

Hi,

> -----Original Message-----
> From: Sai.Sathujoda@toshiba-tsip.com <Sai.Sathujoda@toshiba-tsip.com>
> Sent: Monday, May 15, 2023 9:13 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: ashrith sai(=1B$B#T#S#I#P=1B(B) <Sai.Sathujoda@toshiba-tsip.com>; din=
esh
> kumar(=1B$B#T#S#I#P=1B(B TMIEC ODG Porting) <dinesh.kumar@toshiba-tsip.co=
m>
> Subject: [cip-kernel-config] 5.10.y-cip/arm : Add audit and nftables conf=
igs
>=20
> From: Sai <Sai.Sathujoda@toshiba-tsip.com>
>=20
> These kernel configs are required for nftables and auditd package to work
> which is used for IEC-62443-4-2 evaluation.
>=20
> Signed-off-by: Sai <Sai.Sathujoda@toshiba-tsip.com>
> ---
>  5.10.y-cip/arm/qemu_arm_defconfig | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20

Applied to master, thanks.

Best regards,
  Nobuhiro


