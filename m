Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54B4CD128A
	for <webhook@archiver.kernel.org>; Mon,  1 Apr 2024 21:57:16 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.131])
 by mx.groups.io with SMTP id smtpd.web10.4870.1712008625200533683
 for <cip-dev@lists.cip-project.org>;
 Mon, 01 Apr 2024 14:57:06 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.131, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1120) id 431Lusc32890874; Tue, 2 Apr 2024 06:56:55 +0900
X-Iguazu-Qid: 2rWgsWh2D0WxkocLeC
X-Iguazu-QSIG: v=2; s=0; t=1712008614; q=2rWgsWh2D0WxkocLeC; m=LxkmyfoXT6Cn3VV4dhB2TJ+mYuWtr4sPqyC9Xl2oIRs=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 431LurDY1825255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 2 Apr 2024 06:56:53 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X1GD9+UQ2Jr1rEh169qdiXvZrf8CFKv6pp7R1FEJr74ouZCMwq4y284xdrK1m0wtaIwJ9/r7AI0PpEAEdmQnh/YO5ZP4YOBvsQ2ojYyHeCjO2ztNY1666nZK0201egiugOwfklzMoTcmDa/FvtOQ34uW8uuDegXEb3VRL1/aMCb5ol4FSCKVxYdsonsX/H+V59XHNXHBIt9hsOm66lEPHr91uTbzOT2M8vTeo2zwQ/NJf/u1QnxJEmeya9gFXTx5i+ezLEg2dFgLTzHt+2G8nfe6AInZq/qN3UG1mCIxmMuruJXYH1zj2uMVok64usRiQlzVAO9rkerkgRhrpaJGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64KcSRXCctpL0xIkp1XsZH96Fp5EALQJq3pkhwGvhWY=;
 b=JQnJmv0L48JmE5SlNwP33gEHeQWDhyDOIOWuHextLfs4AOWT60pNPBG6V3LMyZ0OgJSw6nc8DU6OLlLK4XMS2KUtnj/XccgQ/lywSbQ4l1Ey00dT5XLLCTUOudlfNQG1jaVnEpBv3za+D9aKVmQCKI4oy7e/ZNQ3J6oqlzrzfPbDBkpyEkWADJ8IpQ5CEx7c48L5qqUq3A+Z1AwWQEPcXoNb1qnEHhmCCnz60oz+oXesJdQyY1w7oPb7+wm9cw7Ah6AQcBbNqZlVCvAc7XwoR+sZcmbqAJLYyO/+dZuNWabQE66zAQ+VNHmO3oAt4CmSJwINH90giUA3/9bYaRpiQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <cip-dev@lists.cip-project.org>
Subject: RE: 6.1.83, 5.10.214 would be useful -cip releases
Thread-Topic: 6.1.83, 5.10.214 would be useful -cip releases
Thread-Index: AQHagssn1FGQ683O2UyW3WrhvbmV5rFT+O1Q
Date: Mon, 1 Apr 2024 21:56:51 +0000
X-TSB-HOP2: ON
Message-ID: 
 <OS0PR01MB6388AD7CE5977F6F9494AD05923F2@OS0PR01MB6388.jpnprd01.prod.outlook.com>
References: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
In-Reply-To: <ZghRfAeHw2i7rdjF@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OS0PR01MB6388:EE_|TYWPR01MB8837:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 EXbQUi2jiPMvY3+SnrOq+ke/dMLT/c8pqzRI6IsV0Cd6FiyKMEJsXWhMVpCn3YmRKgnthIBEV/IGs+Xao3CbdkHgBho5ACDEGu8dY1LmMmDMmfoeMupg2a1AINR7eG85d0Y5x+2ju9bMOXKnYdCEp0vy7l+/8zCAcHHN0zyZdzN24MU692+jKr3VGVWSt6OiWSbjMxptDIxgsnHAgtqWY+p5tddf6XlWrv7YrnSw/H/Qok3JnYXl0Cl5LSIkuwC6VJZFmvCZzdSWEJRYI3Ht5+u1UNx1nJaphew9g2O06HQPhJoG2WQPd42vJRULdeMblVtpECKonQJSdAaL/+JtxLQesNY1D+ei25Us3zpPcsTz+2Qt1/Ztrh7dJ6qpnww+xxfqdKCzTsOaOVTAlmIHZqA247oSDtbZ/ajAI/YsoYpatwG2kFmHwKOcdDNLeV7QAtHsig6Ijw51Fw0T7VEryDQY7tWwDcjctg65HUFKO+ayEWTJPbZ2uy5kqm/fNyMrBaYi58k/YhYc5xhhzgiOhznVKjkp6B9mdxlAEwkTqpelfsqRa1NUSGObxGFdf3qMPVbr9DgAwZabInjQoVd5Am6J+tMocjPXKzMC9ZN/evI5VAzvTPBj5fy+NQElT8dFXajZ/pd4ahNjnhUIoACA5k1nE7Jq/tB8ebfRczgK3FWw4E5UxACPu1T1i2ZlMtFLKLcWnnfrwA9Tmm9JsYw/dw==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS0PR01MB6388.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(95630200002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?V1dXUEJKMzN1Z243Yk15M0xRMllmKy9lbWRROTRNR05LWHNXQmR6TjNu?=
 =?iso-2022-jp?B?cVlJaUt2UGsyV1NHZlM2Um1NV29GYXcxZDdUZ1RjNGNlUmFlRjBjTG1i?=
 =?iso-2022-jp?B?S3dWZjh0Y28xVmFKeFY2blRFamE3Y2NJQU0yTHdTN0hqOGRQVDIwNDJS?=
 =?iso-2022-jp?B?VUhWU3FXRFBNSVAwWVBwNVM0S3c2dlBwOEN1Z1pvZHFrcWdhOU8xVWY3?=
 =?iso-2022-jp?B?VStoN0FQelJydU1ldEZxczlabUZDc3JseEZESUVydFNINjA0YTB6Y2Yv?=
 =?iso-2022-jp?B?SUlTbXp0R1NQMzhjTDhVQTY0YzhJYTh4N2FnM1JrbzdER1pVYVdWNlVC?=
 =?iso-2022-jp?B?MnFUdjlSTjlBcE5CakQzajdFbk1ITXdubE0wYkpTSkZZOC82eWN4YWJJ?=
 =?iso-2022-jp?B?Qi9GVEtPNTFKdktvS0RqVGZoUkNoZGpzekwyano3RGQ0RGZNbGw5MEpO?=
 =?iso-2022-jp?B?UVpKbVAyclpyT0x5R2laZVlzajZXck50anN0RmhYUHJtOVVFQVQ3bUtC?=
 =?iso-2022-jp?B?UEZXSUo2cGt2bFNuQ01SaktSd3MzSVBEYzY3MFNRRkE3bzJ2OGNiWWQx?=
 =?iso-2022-jp?B?cHB4SGlacTU0MlBYVHgrYkdubnpYbGhBbmpuQlhOY2s0QUNQdU81NFNF?=
 =?iso-2022-jp?B?ZlVybTArQ2M5MTlXMVlLOG9JUTE0bVRnTTMvbFNuUTh3V0J5enRUMitU?=
 =?iso-2022-jp?B?SFJ2QjI4ZUpJRWE2bHNVR0pLQ2Q4TUVJSnRrdFRoRjBEVnpUWHliT2ti?=
 =?iso-2022-jp?B?cW1DVERISk5OeWJ6bGRrejl6RWR4UWlMRktpMDNiMXlWOUNIREcvSHV3?=
 =?iso-2022-jp?B?aDhHT0VNTU9rQ2VaN0E1bjBVakxrSGNjd3pOQmFuZ3phMTBwMnM5VW0r?=
 =?iso-2022-jp?B?NUtWdE1Sd1VrSDhPMXFxMVdFZ2VlUkNWY2FuNUxNWEZycEpGbHVnMVNq?=
 =?iso-2022-jp?B?OGZGc2xaWW8rSG9mVGVYc2tWL1pWZGpMZnBaQkd1RkZ1UThsZEh1NDdo?=
 =?iso-2022-jp?B?ZTV4cXJ6ZzVlWmNvNmpMd1dNQXBjNjVYakNLSjc4NVNZQ0FjY3NQb3Vk?=
 =?iso-2022-jp?B?TUhFY09GWUZHd1VSem5wUGpFMWlBMmFRTGhTWE85ZXRFa1VRbG14LzAz?=
 =?iso-2022-jp?B?K0p2VkZEOFJOZWFneDNyTlZhR0Y5NEVGR1FIOGE5anozay9PR0hvd0ww?=
 =?iso-2022-jp?B?SE1ZbUhXU1NFT0hUOHBLNXROUnJFemFqVTVybFp2OGROY2l5dW43SjhG?=
 =?iso-2022-jp?B?Z0JxK3pES0g3UDlmVExWUmFnM2JEQTFlbjlOcElKT2J6T1RnSEVUYTBq?=
 =?iso-2022-jp?B?dkt0VkJQcmJGUzkzcmV3MUhEL3YrWmZwdExwZi9lMml1dENKdEQ1RkxO?=
 =?iso-2022-jp?B?MVpYS2o3ZFZtQmpjVnFRV0Fyam9wNlRxcGJiMFpLODZ5aXF4RlduSkta?=
 =?iso-2022-jp?B?M0U3M2tjd0ZnbXBIeFpGZHUyRHlvTDFETUtyNzZ1bnU1bld0MlFuRmJZ?=
 =?iso-2022-jp?B?NGhyWDN3a1NqSDlwcmZBdHRHYVFDSkhIdURxRngyc212bG8rUFN4WlRv?=
 =?iso-2022-jp?B?UWRzT2taWlZuQ0pXUzVpNlQzdDl6eUc3cWFLM21sSUhQODBzYlcrUXk4?=
 =?iso-2022-jp?B?ZkM5T2kzazNwbWVUUEZJMStSUGtkNEVsa0NINUZKakpyM3pvUHFNQUN1?=
 =?iso-2022-jp?B?T0dWYitmYzhqem5KVnRMQnhLQWhtR2VDTnR0Q2VCek9aWHFyVmVoTGdJ?=
 =?iso-2022-jp?B?aUpScGVIZ2wzaHRRelhyVFZKcTM3WVhGTTBWK2F6WkFIUjYrMUUvcVdk?=
 =?iso-2022-jp?B?aXZqSEczWE5RWFBqWEYyeGhJNGRkUEoyNnIwNFBsNk9mR2xwS044RllO?=
 =?iso-2022-jp?B?bDNFQmRDWTVpU1BhZCt3RWJkdFM3WXErcU03dDhNZGFKb0ZNQlRZSVBF?=
 =?iso-2022-jp?B?RlEyc2hmV0NyRlJtRlZySm5SMlV5RFEyNUdObmVXOFJGalZMSDJYNmJX?=
 =?iso-2022-jp?B?eFNGeVgwUHZoTXVPL1J0eGNQSWR0WlZabUk0VXFKeVdYeGJpaEJzUFdP?=
 =?iso-2022-jp?B?elc2T0Z4ZVpKYUt1Tkp1NytqVWw1a24vcG5VYmxrcmROQXFJc2J0aitJ?=
 =?iso-2022-jp?B?WFo4UjNMWDF6cmFwNGoyN2xWSU5HWHRTVzVtL285WElHaXc0SGg5SXc1?=
 =?iso-2022-jp?B?WGs1bVNhRzlaOWpydTZSd0lmdGQxQ0ZSTkZBTVo5ZXdUclZqNG1iVVJK?=
 =?iso-2022-jp?B?M3Q0aXdVODY3OEJmUkJOQ0VUcG1saFNsUXRLMHg1TUtjbHY0REZkamR5?=
 =?iso-2022-jp?B?UUlyd0dQbFdQeG9za2VIQVpYTEd4UGcwdnc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OS0PR01MB6388.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eecab67-6d8a-4e71-f652-08dc5296a314
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 21:56:51.3974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YPhrkZxBmHTySBBZMxgLylPRG3pDRrnow27NPm+KYO4PBIOlpsUtOaF4X9kBrZ2CKqXRlCwIV/XRFG5u+4x5wfqqXcvjnqTEEqXZZA7on7fR6OL9k6dbDXWCJv5TOIV9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8837
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 01 Apr 2024 21:57:16 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/15481

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Sunday, March 31, 2024 2:53 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>; cip-dev@lists.cip-project.org
> Subject: 6.1.83, 5.10.214 would be useful -cip releases
>=20
> Hi!
>=20
> 6.1 and 5.10 -rts should be released soon... There is 6.1.83-rt and 5.10.=
214-rt is
> in the pipeline, if we could get matching -cip releases, that would be us=
eful for
> me.

OK, I prepare them for release.

Best regards,
  Nobuhiro


