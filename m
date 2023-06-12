Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC9DC7EE43
	for <webhook@archiver.kernel.org>; Mon, 12 Jun 2023 08:21:52 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.154])
 by mx.groups.io with SMTP id smtpd.web10.53976.1686558102332067077
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Jun 2023 01:21:43 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.154, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1515) id 35C8LWkg010875; Mon, 12 Jun 2023 17:21:33 +0900
X-Iguazu-Qid: 34trKxHUt5VaqzkZGv
X-Iguazu-QSIG: v=2; s=0; t=1686558092; q=34trKxHUt5VaqzkZGv; m=KmfvFrDFtH9zpKU9lEom1dAtRofQuyPoZKEAndvmUhk=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1513) id 35C8LVB9011016
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 12 Jun 2023 17:21:31 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjuFqxPVThKdZ955Cw6MfCg8iBNK2fJpKt3/Cvfw6RsxA9bmgAj6vD+RU4sIoVgDrTDPWR2ttkrhKmtasrCwNXCrOIpsNF3xKgG5m+6qviUj3RsTBCm8/tysoI2OlIOoEzUVHuqi7FrSJ0jWGfabdUw89LCpdrd/+FnhYZ8sO1c/e0zjUPl/iOpKOPUNhCX0f5pGdmYYpLnWKYbmEoqzGI9XhAYp/F4S4q8K8WdrBIgtbonNAGeWvFN6OsWXNIjUybswKqnPf2NKLu4zxSELZOMH9oC2Q/uB2dx85ltTZ0a9NgOjwrU47jMqKEueNUMoYL9yi4cNayv4PB40yu1lYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSmpAUREqJl/hE5qigSFyWZ7bHJv4+GjdeY14fzFTpA=;
 b=NL+cQaF+QUJp2eusVCkLwFs5kOQ35xmdPPPGym5HQYXZQU0iiXWdWtvrdrpdY0exGhw46NTsXNutYFPWYlKAPPQ7dc048iJ/bB4ihXWbovJfOCtkzOt6utT6jeTwQzmP5mqzvesBighIQzDAK2PjISWrpERAA6k0Ox38P/+1bwQH04+tfXNCtI2bJSAaYmKdnvTdBp3YBVjPcMu4MsO4PEoSiOGbbe7qEobKGJTx+r6ksddjCsOIpdVCnT1fmUnFcn4OCRwXn/VlPTYDKbz7l0oBbWe/qb+XzRsInhZ5yxCWUrdpxtaTfasuJNurMlt7y77l0UyWMr7IOTnn4ERWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <biju.das.jz@bp.renesas.com>, <cip-dev@lists.cip-project.org>,
        <pavel@denx.de>
CC: <chris.paterson2@renesas.com>, <fabrizio.castro.jz@renesas.com>
Subject: RE: [PATCH 5.10.y-cip] dt-bindings: usb: ti,hd3ss3220: Update
 interrupt property as optional
Thread-Topic: [PATCH 5.10.y-cip] dt-bindings: usb: ti,hd3ss3220: Update
 interrupt property as optional
Thread-Index: AQHZnP7wq31qvMdUEkuQ44UGWeTeeK+G02Gw
Date: Mon, 12 Jun 2023 08:21:28 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB9420071DF2F491A9844B6D509254A@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230612072422.75636-1-biju.das.jz@bp.renesas.com>
In-Reply-To: <20230612072422.75636-1-biju.das.jz@bp.renesas.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYCPR01MB5902:EE_
x-ms-office365-filtering-correlation-id: 537b92d1-952b-4282-fd7e-08db6b1e05a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 23ZqJk8tvbghmb8PooZH8GnCx4qAU139dP2u7qt1PO+niuhDTfAqSZzNEFaH3AYN3zYRGqSJ1AzBukE4CiLet0TTdmQQU6JJPFSGPMeX5iRsVDbwQZJGp5DADQ9KM6EkyzP8Z/rpxUuLfBw7yeUn75F2peKV96aB7r7wbwmoq0ex1bRd2yUxArXGkVdy1P94thsEJruu58jE6K3ybqQyNHDQ4Z7HLkXw/kQ2LvPut/uQ8mu+cX1riteNvNCfHHWD9muC5ceNnyLemjRb7dvEo6hbSycY+fIr2HSTwK3buAy9k2E5HXQMLKpQ/s665yU5DVltxIuMOVnJlKDr/qowqFeKS0yssVLXIznHwpelyHPOBUErsEs838g46E/BEeweG4ACy0HlNyG6ug+IWr3n991L6lFesESeDpc7KvDtTLvz/Dp1oZTtqWiJm9OfCU7NWvHg44TbR/f/Y6KKTpd7ldSSwmCleyax7kyYB48ApxeL1cMQ2ih1QRl1T3FFI1slXXIl1T6R3tb5kJkmfQr5KLuOx80s9ssKBEBw2IT+V+jxwYoCPIHyIJ7ahN1CtyNDKG2O+JyVbo7GguTMi3uYwgP2yj1Ofq2l4gKBSax8V5BFvyqiOAQ5oZTzRxnZtXDgZ3qhQExT2aMmgq7R0U6roQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(451199021)(66446008)(66556008)(66476007)(64756008)(8676002)(8936002)(5660300002)(52536014)(66946007)(54906003)(110136005)(76116006)(4326008)(71200400001)(478600001)(41300700001)(7696005)(966005)(316002)(38100700002)(122000001)(55016003)(9686003)(186003)(6506007)(38070700005)(53546011)(26005)(83380400001)(86362001)(2906002)(33656002)(15650500001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c3VnTGp5TjVKWGpTd2MvckdXL3dWcmpMRlhXRkRDR2hodFpibHpZdWZT?=
 =?iso-2022-jp?B?Z3hVb0gwYzg5RmNYT3g1ZjVhamt5amVIbDJpYzIrc2wyT0szL091d1BW?=
 =?iso-2022-jp?B?RE9uMjY1OG9GVm9PRS9vL3QyUktDcHVNUU05VjNEdmIrb1FjT1dLN1lz?=
 =?iso-2022-jp?B?MTcvem1vb3E0V3dOQmU3UXFXVURkUTVUeGFCZVBidHUvWFJJNEtQNUoz?=
 =?iso-2022-jp?B?Ky8xWGluZkczelhzeTFIKytIcHpGT3cwai8yN1Jaemk3dThWYlgrcU5P?=
 =?iso-2022-jp?B?MHpnMXFMYkZmc25oZ2Myd0NNK0p2dzd0WCtiMmlFY0VCYVY0Vnl6eXFT?=
 =?iso-2022-jp?B?ZFBvbm9BeHhUYmZFQldNRFkvMi9vczV2TXJWcmNOWUc5M3dDZ0VWVS84?=
 =?iso-2022-jp?B?dDh1eDlkUTdCeDdjcVp3bzdGY1ZBL085SDlMeElvVVQrVmlPSm9mZHd2?=
 =?iso-2022-jp?B?TC92UUswaXpIVktrQjhzUkRUYjd3MUxBREJVM1RXcmYxYW1iOXR0d2tI?=
 =?iso-2022-jp?B?T2RYbnR0NVh5LzRxa0NiMGM3ZnQvY2tEUjhqM1pnMXp2NDJMa0IxNU04?=
 =?iso-2022-jp?B?TkMvamROTURENHM5c1RYSElDT2ViR3NqMnorV2syODdOSGFBVjRxcU4r?=
 =?iso-2022-jp?B?cG5EdEZQTEtTUCtieXVoQ2VyY09kMWZTMS9WSW9TQkwyNVE3NWRiZHQw?=
 =?iso-2022-jp?B?V3NWUXBWUk85WW0zUkRhMVJTMjRUUzZzNUZ0RUNrMjBxTzBBWnJXYkpx?=
 =?iso-2022-jp?B?dWh2emtld2RFRnFaV0VqVzdPOXVhRHlJNHFQeHNGbUpXVW1rb3FkU2FB?=
 =?iso-2022-jp?B?dnZHamhzMkM1ckRlUVEyNjQ4b3g3MitGOXU2SjdKbW40cmVoOUxTWktC?=
 =?iso-2022-jp?B?aGdoUGllampWNlRCSFQ3T2F5bWFKclowMUtoMno1MG45V0QwK2hIbHhj?=
 =?iso-2022-jp?B?bTJuNlkxM2ZFTll0L2FiT1lmTjhzVWxTQndRSkF1QW1jY3lwNEhpU1dY?=
 =?iso-2022-jp?B?NFpFdFhxYzRNM2R2SG1oc09ZeElZZ3VHbEs2VTY4K0M0ejNhNEMwdHNz?=
 =?iso-2022-jp?B?YlhlcThUUGgxSWc1UDVROHNRLzlETjk0OHRiN1dmYmdyNlowSkkvUTUw?=
 =?iso-2022-jp?B?c3dIeUxTT0YxQlI4cWFaaHFyK3lPcDRCQTFYTDhocE5jREQyajBlZzlN?=
 =?iso-2022-jp?B?eFhuN2RuOUIydW01VUhPV2ViWWJxbUw3NzRBY2N4ZjV0TmNpbVROVms3?=
 =?iso-2022-jp?B?U3RMMVhEa2lyY2U0SWJPRk13ZUlacHZMVWFpSStaVVN5UWNMcHp6MnNH?=
 =?iso-2022-jp?B?VDFod1ErcERHRlpLd20rcVcwMVdKZXZwN2xpYWNPbjFjWnZVWTdiZUIx?=
 =?iso-2022-jp?B?MklwZXJzSDlLS3lvWnZ3RmdLaGdZVXBwbjRDUHVrdkR5UWdCRWQ4Vnh1?=
 =?iso-2022-jp?B?U3RhQzRGME1ZcXZQNWttM3Z6TkdwTGJBVTlibFdjcC9wR2N3UVMzZ1JP?=
 =?iso-2022-jp?B?MmlPeFd5Q085TVlNZ0dVM2xXWjU1REFJM0FqYUpDenUyeUlGUGhaQkVy?=
 =?iso-2022-jp?B?MmVCU0ltK3JlRGZYZGFXUldYVGh0cWFxNmhueWxuMXo5OEY0b1NPdjVU?=
 =?iso-2022-jp?B?NUY0anVMWStRRy9OYnBGaFhkTWZXUGllVXBiQ2hXeXdiNVF4QVQrckRp?=
 =?iso-2022-jp?B?OTBrRk5UK1gvSDFNZjRiK2JWbXFpWUIybi82dDdXTmlHTXpOdHp4MTlJ?=
 =?iso-2022-jp?B?K2F5a2ZUT0ZHNzhFaDlyZko0TFZKNGxXZHcwVGtTVmphNGN6OSt6UHV2?=
 =?iso-2022-jp?B?dFViendPVnVWeHlabjM4YWRidng4b2dtUjZUQTQyM0NEYnBLZVFocGNC?=
 =?iso-2022-jp?B?YytMa1VsSUdlTnlicW9XR2t6WEl2cFJDV3Nsd3EvNlBrbUx0NGJ5cXZk?=
 =?iso-2022-jp?B?RXhqL0VPeDRoNDEySjcvMFBWV01Da0VZRVhYdVFZajJOMEhjSzNoWUdH?=
 =?iso-2022-jp?B?Q0dUTEtMbW02c3VQZFEwYzgzYkxMZWx6SlB2U3NtUWJndy9YM3kyZngv?=
 =?iso-2022-jp?B?bEVNNXdXajF5R0RYUzFGaHYrdzRjelEwdWFLYjRpZm9ocHU0cHZGRnFk?=
 =?iso-2022-jp?B?NEdMekREVFY5MTRCUEwxVGxrVTE5K0lGNUZPNkh1QzE1MGlGR2lRNlVp?=
 =?iso-2022-jp?B?UDlmY0FjOXcwdjhSQXB0bC9ER3Bvclo3SVBXdUh0WHdPRWQ1ekhMbnVC?=
 =?iso-2022-jp?B?KzFTak41dGdGV3RSSnl2QXI3cEpWOXhGQ3BpaHBnOEFhQ2FYOEpQVVpr?=
 =?iso-2022-jp?B?dkVRQ2JiZFFPYXhmZGhveWR2YUpVZjdJOEE9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	966ODY+N0A7/yFu6Cz81+YuCG7g8W4MGJbg6fWBfQGAdAOV9qiwoJmphfJKsLz/6mjC5OVLwfJs2a1SD4y8X7i6owUHIfAyqpVJhykjQClKEiDohE/dhcHevf9WN8F8k4NcoaRCtmNxLmD7XnMrlOsBeK/3Du3+BpqnooQvETFerZxY59LN/aC8DyXk0v8oQdstXyjkYYGsgLoYvggRtzgjNp8Lee4fxjZmD+TPEMYEgMaI8XkCr8kwUR3jzyCqqEk3eFrf/bnO3TtgpDmWSKtd4bxkXCp6Fivr3gi+4QA/P/6a4ZLixoZE154u6EKOs5D8vcl0c7JrQA3FnWwf04bNoa/4GYupZJipewSxbZ9GTs2d1hdJ83LX1NLj5cGQlVTxQlJZPnv7BOVfN+8Ggpll2hLGPOAstKdt+Dk+9iJLx5Fkav2bEkpKWQgzoOTJ+wsPYIwRsHQW6TvA6yh79n3plAfkg5NfGX7cMqQVZggQr1ottL94Ys0U88eeYfVDs2toiBDsLzwHNhBolUWMMBC8iM2ugxMP042mxW0wB3sley9J4BkQLJI8onF27NsoH/dnUSsIo9UEA56ZIv7/caZIXkuLpPjOXJfYBCLGguhvT5eoFAiRpaqyfkQLdKnRoUZTac4/qmPb5QyC2vowXSq8dk59w37evYL7pngOX107rTJVUQadS0y0jH84PmB/C7lRhALpey+NIPr65wDfb47PaGiyK8qmvoSPpD83RyQ0Kr10iB29nzPwiMAAWAUvJOsgHd9PCtA2QcAGegUCep8+KDcRIOjw9J1xx6SMd0dhkp12kyr/f/cDGlkuAfR+UaA4i/Muv00Q7TEpPygtEp6PdFEt2gEncNFwynOjrdbRQz8sjU7Bfev37vWSEYPrk5XfMucUbiBulONejYdaqbg==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 537b92d1-952b-4282-fd7e-08db6b1e05a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2023 08:21:29.0536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F1gqp+mucoPJM09E8PEbFR7nJkpjTA0nVIK4mKs+ljLhxh1nARdiaxhwI9RmM8xE8LYHbyx+yQmOk2BsILn3Sp1R9sxW6kE66pAOmQTwA99b1Xik4UmA4OtES3NgeONt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5902
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 12 Jun 2023 08:21:52 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/11975

Hi all,

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Monday, June 12, 2023 4:24 PM
> To: cip-dev@lists.cip-project.org; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B=
?.MN=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>; Pavel Mache=
k
> <pavel@denx.de>
> Cc: Chris Paterson <chris.paterson2@renesas.com>; Biju Das
> <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> <fabrizio.castro.jz@renesas.com>
> Subject: [PATCH 5.10.y-cip] dt-bindings: usb: ti,hd3ss3220: Update interr=
upt
> property as optional
>=20
> commit bf58a687db232e738105244e34a85d21f5e2598d upstream.
>=20
> On some platforms(for eg: RZ/V2M EVK), interrupt is not populated. Update
> the binding to make interrupt property as optional.
>=20
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Link:
> https://lore.kernel.org/r/20221209171836.71610-2-biju.das.jz@bp.renesas.c=
o
> m
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> index 52ceb07294a3..f9734fb7f0b6 100644
> --- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> +++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
> @@ -46,7 +46,6 @@ properties:
>  required:
>    - compatible
>    - reg
> -  - interrupts
>=20
>  additionalProperties: false
>=20
> --
> 2.25.1

Looks good to me.
Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>

Best regards,
  Nobuhiro


