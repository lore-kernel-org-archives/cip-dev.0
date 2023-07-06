Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6CCEB64DA
	for <webhook@archiver.kernel.org>; Thu,  6 Jul 2023 00:18:56 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.132])
 by mx.groups.io with SMTP id smtpd.web11.10674.1688602731567329121
 for <cip-dev@lists.cip-project.org>;
 Wed, 05 Jul 2023 17:18:52 -0700
Authentication-Results: mx.groups.io;
 dkim=missing; spf=pass (domain: toshiba.co.jp, ip: 210.130.202.132, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 3660Iek73838861; Thu, 6 Jul 2023 09:18:40 +0900
X-Iguazu-Qid: 2rWhi9UHc0tQxk6Qsq
X-Iguazu-QSIG: v=2; s=0; t=1688602720; q=2rWhi9UHc0tQxk6Qsq; m=tNW5Zmu3e9ajODv7CiCW4/eiPGxyGiEDKiEc1ntFOyE=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1120) id 3660IcmB2357771
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 6 Jul 2023 09:18:38 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mGsFyp35qkuKNkuqaf/D0PwCHJBKmqLxeaJCPm/jjxfaFvSa8+FJDFc+9lj8vBiNzFAtB4yD/F4uXk+LdbnBNx7AjebNDKpFv7X8hBonkDTcETfFYtn4ssg5iN+QXGYysYBTXn29eSkrtdhC8ILaeuv94e9yCwKYm6ILsAYeTNxhDnHqm4zfo/YEeY/NeZfGVWb51LXLHsyP/pgk5L2BI5gH40C+zVfdR9p96eZRUBF8GMH5A54dfqridM8SQkpgR+XJIyLiJ/OlquTTl3cw8tspkp1Gkg9w5MwM4mDGyTXAPFIRTSfBHG85HB7shYNLy5d2nMsYvoIM+HsbXjZhhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GkFPN5AcEqrAfmC1yMzPjf84H/DxX1gr63FArwj/shs=;
 b=XpzcuKxjy6DXD1ujrvXTsrdn4n+Du3C32FG9d7dnT0anr7O5XSmKsPKo2Xszb7l/NxFAF0GPyisA9+YlK2tvpafdnVaF6gFo1uHeMXLqJxWQtZG8gOmLnLh/MTcx4qQg4r550l6z3aq4mNRdFO9OXf+aZw0Ytw7EdrYbNxS5T2yc7O79WIg+l+3KsNf0uEiJ2DqsBMvjzTXws+M4NqiSWJvx/mfdRzPKhjySZCqeJfPYzDTGudAA9xUjI/DVotYvF7fR+yqPXmOLtZspP5QpbK4RISQ9oScLNVpBCbpIIz97OEdRunTtLNEWwW9wwUqAX/TWhdjge029Ab5KE8ft1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <biju.das.jz@bp.renesas.com>, <pavel@denx.de>,
        <fabrizio.castro.jz@renesas.com>
Subject: RE: [cip-dev] [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Topic: [cip-dev] [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvements
Thread-Index: AQHZq2sXQFmFKTN/0kK3O+d32Y+Bzq+pGB6AgAD34QCAAdcFkA==
Date: Thu, 6 Jul 2023 00:18:35 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYWPR01MB94205ED17A65B0587C970301922CA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
References: <20230630155352.584589-1-biju.das.jz@bp.renesas.com>
 <TYWPR01MB94201C9E1FC1A2DF030AA86D922EA@TYWPR01MB9420.jpnprd01.prod.outlook.com>
 <ZKR8cHWQHc6QPv6k@duo.ucw.cz>
In-Reply-To: <ZKR8cHWQHc6QPv6k@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYWPR01MB9420:EE_|TYTPR01MB11001:EE_
x-ms-office365-filtering-correlation-id: b283a3b0-3c1c-46b4-e162-08db7db689c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1TcziX3qsdUNovkh0f9X6UhTOFe3JubHrVQdqOv/8x/ncWLZ3juBczuRjcmHRuy4xm36vDsfTEWJ+LAmNQFORWGjQHwh/+6Hh145QJFtNv9Uin6npuYg8ZnDKZlHjvrmD/3lmqMaobPgg/QpJj15uQ5FNAWUJ6JLhzloyenNZ7ilFyH9o6P0YETnwZQKax0Q8m1uSI9eDEp4+3K9S0hoqmU4jrYmnRUTdJHVMR+HI/nuRxp9HfX6WMf+jwIYOiIO1Z4AeK0bHsQ4dkZjAzmbALwL/QkVqlFvGYhGeK5Q4UZV6lef6wkflDUfZ6R5WyQ8up+ls+IDtQQ4OanEsz1pZYH/oc+UFBuvqavK2EAwO5P1uxRq0wJ7TALevjr2gJ1u/sBP+wB2d0LXpAX1LoLkl6H9tWJ1ym+eaT/docNUis4y9G4lrrXUgBl8WhKO46T/2EKELjtJSbPjV4TLZLLRpSbI/yJMVz31e7OetidP1tUUI4XzDVxoaOVT3/CTeewYalCUdYQocuFaMhfeai3UxeLBssYwoAc/BRBq/YXgdiUF4hs1bEQ+8+Oe6VFqOMcGQUPgSbnXEnGXKCV+ADhV77M2z2eiGYG0aME49mOtGHhwBHkF8vRWGq5dOIqtapjEWY5YkjtmECq8M24QCLK7Zg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB9420.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199021)(52536014)(2906002)(8676002)(86362001)(55016003)(66556008)(64756008)(8936002)(5660300002)(54906003)(7696005)(71200400001)(478600001)(33656002)(9686003)(966005)(186003)(26005)(122000001)(38070700005)(38100700002)(6506007)(83380400001)(4326008)(76116006)(66476007)(66946007)(53546011)(316002)(6916009)(66446008)(41300700001)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?c2tXeFR5Q2EwY3VkYktBL0NFQmRTVjk2TzhON01KeUVFR2R1bkFZRDdl?=
 =?iso-2022-jp?B?cWJBT3I3VUQ5TENyeU0vYmx6THhDQmx3TVQ2amp0WXNIRHk1RkZ3anE0?=
 =?iso-2022-jp?B?YzZXR1U2aVA0S0plV2RKN0RJdFo4TU52WktrS2tDUkxCNUFOeWQzcWhR?=
 =?iso-2022-jp?B?OE1yVG0zZDdqTUZrQm15THU0T1p2WUQ4V1UvRk9TcFZaRmNJTERUVW9q?=
 =?iso-2022-jp?B?UDVuWU5kaTFFanJUOTdDRjdTNENuQkhOUlkvaVZES1dTcjVEUnZyeHRT?=
 =?iso-2022-jp?B?bXBJaThxZWNwSmp2d0UzWElLK2M4czlqNXpRRUpXbVMxanI2ZFUvSW0y?=
 =?iso-2022-jp?B?SHpyN1hoZ3B4QUJLTXVvMWR3WW0yakk0cGFKNDNXWnRDM2N6T2JqbEt0?=
 =?iso-2022-jp?B?VngzS2pjRW1DZjh4U3QrV3FHQlJRNU4veVFCelQ4eHUvc3JSQzNpQXc0?=
 =?iso-2022-jp?B?aE9Ba0k1UUJUc0NHTTFJWE54VWVyVkF5d0xmbTIvSk5sQnpGanZJMXNj?=
 =?iso-2022-jp?B?RnNEVXRxNlFyKzdqd20zU0Q3bVN4VGdJMWV1d2xuNmFtVE5wNld2SXBF?=
 =?iso-2022-jp?B?Yk5FUFNwWjJZTHZPYXFuUWdyNytCZXBDYitHb2htanlQNlhrOXB4UG1S?=
 =?iso-2022-jp?B?VDgxdWN3UGt6Yk82UFpWZVRLZ3Y3cnRpaXlqYTJiaDZpMXRPQmJYaUpC?=
 =?iso-2022-jp?B?MXNETmtXL0ZoQW1HdUg0Z09DU3pJYUFkSTVXclI0b1FLQi9WNmR6V09G?=
 =?iso-2022-jp?B?Z3VHelUxcWFDVnk0b0ltczI1NE9ETXY0Mk1nb0UvWk95amlYSzkvMktr?=
 =?iso-2022-jp?B?d3VZMytVQVhWcFo1TGtBeUlrUDdtOFVINXNEUjMydERLbFFqQ21nSHY2?=
 =?iso-2022-jp?B?cTFmMURZM1dCaFZnTk9VNEQ5VHc0RGp4M1FGUG1BMDlVQmFwY3dGaDlm?=
 =?iso-2022-jp?B?UTZZU0FlaW90NEZRQXBQOWhkbEtYYUVxNDdmNFlxSExtZFBxRkt3Tml0?=
 =?iso-2022-jp?B?SjNHSlpudU1WenEwNjM4a2hMSjhrQVV4dEZ1blVOdEVrL01KaDhyYWo0?=
 =?iso-2022-jp?B?M1lFdGFkQzNMOTg0SzB2YVVXM2VNd29NUGxPSjVnSk9mL3JIb2dETjU4?=
 =?iso-2022-jp?B?M2QyU0dTOWM5WU5rMGdUcEduVFl0UFhPT3NmMmY3cjNLNWhoVUhaZkxz?=
 =?iso-2022-jp?B?VlVjZlVHSUFIMFU5bzdmTC9rcHZxYmZ1ZHVYejdHbUJaMjZtaWkraGVm?=
 =?iso-2022-jp?B?NlRUc3N0aWlNbzBodWxqTEpmY3ZLeENLSi9nUlpkaWtOUHdFcTh4cDNL?=
 =?iso-2022-jp?B?eDJBRFI3WG1NOTZudnN5QVFoMEx1YTB0S3hPazJXL0UzTE0wSS9WVEpv?=
 =?iso-2022-jp?B?TXI4VWQ2dGEyY0RSNkR3MjM4ZGtEUlZick9iNU4wVU80dHNKZWpIZjd1?=
 =?iso-2022-jp?B?NXhsVGVvcFUxODJFVHZaN3JLZGk3N3ZpS3NpZnZES2ppOFlGRlozR01I?=
 =?iso-2022-jp?B?OXcxL3RaeEpUWlRYYTlxQUZxNE5DUDRHWU5mcW5WZVdCOXNDZ0o3OWdZ?=
 =?iso-2022-jp?B?NmhXMlRVVy9kU2dkbmJjZnJnR3Jpa0lFVVRoeEthY2VPRTlvNGdBVktV?=
 =?iso-2022-jp?B?V0xWaDVwR2xlNWd0REtGVzdmNE9iNFpRZllwUExtdWh2YzFTQTcraWpU?=
 =?iso-2022-jp?B?ZVppMDZIcUdVTW5MOVZyeVhIeERqaWtFYXNPWnZWMDdreEZ4eXJZR3Q2?=
 =?iso-2022-jp?B?UTd3aDNhanVjV2RKSmxNdGZES2RIMVFJdmdScmlNTXBPUEtwWVY5UkJU?=
 =?iso-2022-jp?B?eU00NWRlSVozaWEzOEw1eEUvMXdhYm5SVktHOE01Y3RhaEdreUhpOURF?=
 =?iso-2022-jp?B?RVhPQTBhYUc5TXNwekVqRkk1TmNEYWV3WDhTbHpXQWhkOE5CSlRBbkFU?=
 =?iso-2022-jp?B?cHhmUy8rdHZ1MHhBdmVGU3gxYlF0eGNNdnNJZDNrZnRvNTZHeTZFUThw?=
 =?iso-2022-jp?B?VUx0Y0I5a1BUZUREZWtTVks5a1k1aTlLV2E4UktyVFV1QzdyKzBsWW1N?=
 =?iso-2022-jp?B?ejNRaCtJRllOeXZReWdGZ2krcGYrK3oxTEU2b2FicUQrYXQ5a3JhelRs?=
 =?iso-2022-jp?B?OUVZampaR0JlWCswVC9tdlN2Qlk0ZHFZOE1zMEhYNUhGdG5QQzZ3d2g3?=
 =?iso-2022-jp?B?aXVYZDBaQnRzaTFwUVRoMTl1WThkRjFDTGpJOTlMQTNtNTd0L2FNMmlT?=
 =?iso-2022-jp?B?UFZGR1pYSTcrREFOeWFCMkR4YzIyWHpINS9oNjdFRHBxeTNXNXl3eWtE?=
 =?iso-2022-jp?B?WXZrVEY5V3VnZjNtcWpBWmxSWHlSRlJ3THc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yahMNmWvSc6ywrF3HsmeGV7OE2JwMJ4GVFPR7MtM2qmuDvoF7kJbTLVou+x/0//+rp5KAXKY6Bje2Jugvn9yYnV7EaUOMdOCuSUA/q2Jwjri+KT3PD31ijNFH9vgcdcKfj4FBc0nnwc0ZX+GL+uIE/9OYBkcOjdmmi/GkV4HeEmDo0XBiWMaC5XZcEpzh0h3oj3wp7G50qeoJWEYKaThGb5yVwjwdvayyDwJpUX+lip3vlGcPadV+47SffIOxot3avjTdAGJrk+p4tQyaNCVAGqJ/Rt1WGQTR49d/twQV5kIIzc7cdXjhRPialg9P9UEl6TYdgYebj4HNkoA8RBCZPYmZ7N9ZSkiCEzY2EjXOCgl/O1b/dJgfw9SgmChZQ7d/sGsb0FmszvP1k5iUIrFnFn6mNpivoQ8jnwtL/4A9nphVzlhmqqd8cRtGBlAF60aaPHIBKo4bd/ybMgW0JevjWWZnDgcDfqKXrro9DXxS4AVSJd9ZpuxWHWELMsAMSKiR+c7nuIOoomCcYr3Nfd/dh9tsvbimkonHEiqYpzd9nl8HhzxuzSrn59bFONm680BjFGA/DBqOpXF4Gn7aXxH+KM9VVWPjESwcOF0vzUpbkzYzXOr6/wM36mTjlZERtfQ9NMhlea4xR+sAlSllO2nUwPjVSdKo4zdvXpaxJGHvgwdhw8sdK4nbAKZpiLrf9pd5+20OO0WaxEXFx/Ae1LxL565UoZqMgh+MFlaPxOdDYOSNQNOiHNgkQYXagkO42+N9Ky9aIS4QzQzChUZ7msmmEZD3iLF0SMaLCZZhkZG/idtXR41nu8jlIocTpGtFBJThv9gY/WfjLA/YBgM3X8SLxQNEVE0+X19yN2OlP2JzQ87qWYYa29q78dTReCH9CnqNypZs1KUSmI4o4HR7uaY6g==
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB9420.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b283a3b0-3c1c-46b4-e162-08db7db689c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 00:18:35.1758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ifLIz1Rr57RrseU3PFa/4QK/Z8VRjZfCur8yA2NA0WqudEoVFqI6G5RrUlth8DwgAX5KtauI5O+AI0iWiQbX12RCtmuSrOCyDCfPFc15ZSWIjjdkBgDxIiESNpsQH1Bj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTPR01MB11001
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Thu, 06 Jul 2023 00:18:56 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/12237

Hi all,

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On
> Behalf Of Pavel Machek
> Sent: Wednesday, July 5, 2023 5:09 AM
> To: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B!{#D#I#T#C""#D#I=
#T!{#O#S#T=1B(B)
> <nobuhiro1.iwamatsu@toshiba.co.jp>
> Cc: biju.das.jz@bp.renesas.com; cip-dev@lists.cip-project.org;
> pavel@denx.de; fabrizio.castro.jz@renesas.com
> Subject: Re: [cip-dev] [PATCH 6.1.y-cip 0/3] RZ/V2M I2C driver improvemen=
ts
>=20
> Hi!
>=20
> > > This patch series aims to improve RZ/V2M I2C driver, based on the
> > > feedback from Pavel.
> > >
> > > All these patches are cherry-picked from the mainline.
> > >
> > > Biju Das (3):
> > >   i2c: rzv2m: Drop extra space
> > >   i2c: rzv2m: Replace lowercase macros with static inline functions
> > >   i2c: rzv2m: Disable the operation of unit in case of error
> > >
> >
> > I reviewed this series. Looks fine to me.
> > I can apply, if there are no comments and issues.
> >
> > Test:
> > https://gitlab.com/cip-project/cip-kernel/linux-cip/-/pipelines/919964
> > 303
> > Reviewed-by: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
>=20
> Looks good to me.
>=20
> Reviewed-by: Pavel Machek <pavel@denx.de>
>=20

Thanks, applied.

> It also looks identical (or very very similar) to 5.10 series. In such ca=
se, I believe
> you can just do [PATCH 5.10, 6.1] and we'll apply it to both branches. (I=
t will
> likely be a bit easier for us, too).
>=20

I think so too. The same method is used when I submit patches in LTS.

Best regards,
  Nobuhiro



