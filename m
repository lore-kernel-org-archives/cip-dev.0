Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AC7C4332F
	for <webhook@archiver.kernel.org>; Mon, 11 Dec 2023 23:04:07 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.152])
 by mx.groups.io with SMTP id smtpd.web10.5906.1702335837423251067
 for <cip-dev@lists.cip-project.org>;
 Mon, 11 Dec 2023 15:03:58 -0800
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: toshiba.co.jp, ip: 210.130.202.152, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1802) id 3BBN3lfn600344; Tue, 12 Dec 2023 08:03:47 +0900
X-Iguazu-Qid: 2yAbi2kiAnXIVpFeQz
X-Iguazu-QSIG: v=2; s=0; t=1702335826; q=2yAbi2kiAnXIVpFeQz; m=LLQrrIqZYC3m/LmMJWJPZTt+85zeHlGFvM31nUqvI3Q=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1801) id 3BBN3jwS1867894
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 12 Dec 2023 08:03:45 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0LvMYjvfT6vXck+qZCAERm4UtohaVRqTNw2bbRMRqrD7AD1zd/lYfaVc3mRnFqAU4U6XcknwbYtf1fKvCzGP2MjMGuRUAcZvLnEtQssTOXNeZfujYT6lGwLZQzJ0cvZY472MBB1173ujFjN8E+SWMk0cOscwmRZtEtYGb1YwAabGbUgTcHWHUQRTwlcYbPyJLkEMxlb5ikjTnlmh9OqQxn4UFMP/T4qF9DvBvKJ3qXCmXHWs8rIMFc9bOTnv2Dt8qxkMjj+sKhNmFn4cI+rRr2Ipmx0Z/8ZK+ykZNLVNfPYeGrL5KmmZOJR1L52rV1IMfoLG/x8navTclWh32ttPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6lwyu6fTYyDvIhzLou6p0Y40WfZC+Uqr3+KQ/oxKzc=;
 b=CuoLzbzNKtPjDH3qyC/1QztsEq8SesVJX4f3pCHAFwzYId4KB22l3Wm1JyVX1VqM2MN698pQZoiGn2NLXL4JGyWGZK2QIgQ3oMMc4vo6FcwDeA4YyMmJZWZARalTA1qiCSHXkZeZ24Xk77K7tFJyOdqfABn9gsg5+wyLvLT4XfGzlKV2ZZDRCXO2l5acVDOovOCImVEf5V1CjO/FPFqwPtNuZL2p3iNK2H3WyQYqpKEq/fj/s+Ib+F1x0IL8k3O1DaP3Zz/PVwa87TCv20aDWKlAMps1EghfEioKyAAZ7Qyx5lgqzgb9jynNsvK4dRmnnRDMioxUy8JLx2U7UImpNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <pavel@denx.de>, <jan.kiszka@siemens.com>, <cip-dev@lists.cip-project.org>,
        <Chris.Paterson2@renesas.com>
Subject: RE: [ANNOUNCE] 6.1.66-cip11
Thread-Topic: [ANNOUNCE] 6.1.66-cip11
Thread-Index: AQHaLDZK5F3v9cdNT0W6ueAFMkr39rCks8AQ
Date: Mon, 11 Dec 2023 23:03:42 +0000
X-TSB-HOP2: ON
Message-ID: 
 <TYVPR01MB112454056777FD7EAE3AE1282928FA@TYVPR01MB11245.jpnprd01.prod.outlook.com>
References: <ZXcPBNau3KXVGYj1@duo.ucw.cz>
In-Reply-To: <ZXcPBNau3KXVGYj1@duo.ucw.cz>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYVPR01MB11245:EE_|TYCPR01MB8503:EE_
x-ms-office365-filtering-correlation-id: e4201625-7fad-4f26-e117-08dbfa9d6b78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1guF0WeT9zlrYt84BDxAr6M3dLepUfCJWrKq/jWYayQ11V3PAWHnRrrZtbq4+mBYAp0SHitgJcvY+7Uex47AWB5Xd3atpGzt/jn7dN2WFyn3FilrFUWUKIuOyczYhw6rE2BYLft2bvJQoRseyfsfWI6ZbKy4PQD3PSF0ZeLij486z/lYGr5X27MHodN4YC/Ej12h2SIcxKflzs1NB6aAZbfvGwP/WYhtSwjrbIEMVQxijBWIgBJxnUfoWKoBmDuehdBE4JzAiKSbpcQ7ZR/AXxld11YPbqJlAITXzxo/EpHLHqYPpk+LImTda+zhuAjd5pYKqz3PN/mBjDv1pvcOPOIN94v4V9ho2o1Za/6EyhJknCPF11an/xnbBIPvfygVFxmslOAHV0wfVSZ+z6y744qtpjQ3U+nLzjYAYzq+uJG3Avx0rj5QEzlsQNsQtQrXOV84ylXi6xWeeR3We85qqKRVqC3M4I4FMTrwUx06wK053ZLEIrl8cqA2VPP901CcnvDG7bwqNgzrCKIdt4RD70A4EHYpSHWWezaHMbfeFaB3lPiEaluKooa7VzJg84zLBl5sisKgtTVPkB1mStuov9L7RpIodWwVlfAXLEa5eFV5JzYLu95aEfw+I9MxiNRv
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYVPR01MB11245.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(55016003)(38070700009)(38100700002)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(33656002)(86362001)(122000001)(83380400001)(26005)(6506007)(9686003)(53546011)(7696005)(966005)(2906002)(316002)(110136005)(71200400001)(478600001)(5660300002)(8676002)(8936002)(41300700001)(52536014)(95630200002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?SEZVeG5IN1d3T3lxZ0ZicFA2Njdid0xmZ2FyUXhDaGhLUnQxekpJRng4?=
 =?iso-2022-jp?B?VmhERngyZHMzc0MyU3FzNnRNVk5NcmRlem81L3NhcHNud2VkVWxXZkxQ?=
 =?iso-2022-jp?B?czFJTHpxNm9vOVpYV3RSOGpZNmU4VllKa05ldnFYMEc5MEtGTDl3MVBn?=
 =?iso-2022-jp?B?YThQdFltRTczQ3RaTTJDNFFTT3FLTEg1anZJWE5iclRUMDNOWlBlSXlG?=
 =?iso-2022-jp?B?UDJObjRRVVd0azJoOHE3WG1GNVB0RWpSVEF2dEcwTGgzMm1mNzlHa2sy?=
 =?iso-2022-jp?B?Yk5ySlZBME93UHZScEx4SGxENWJnMnpMSkRVREdHRlJBLzNMMFdjblpv?=
 =?iso-2022-jp?B?ZjVQNVo0YmFZRURsOWY5VDNmb0xMT1hQWWxpR0t4NVVvMGkrWVBrY2xG?=
 =?iso-2022-jp?B?MUx6MDhYTm10Q1VvdnBhN1hBeVRqQVoyYzd3OFdDRnM2SDVnZ01VWGRF?=
 =?iso-2022-jp?B?dURPTk82c01teE5vcWYwZk4wbmpmU3krOVZjbktrYk9lWk5ka1Bmbzkv?=
 =?iso-2022-jp?B?eG9qTnBIbUtWTHRaYkNyWDdTbEZaNEZmQzMzcE9pTFArKzlneWE3WjB5?=
 =?iso-2022-jp?B?Z0pXQlRMTGlISGxVVGU5L0J3QnllcXBFb2NEbzdvYmdLL0ZiV3JnN29E?=
 =?iso-2022-jp?B?MkVyVDF0U0IrcDVTakl2TndoN3BBWkcwM3lEYStURTlLbkFGcUZFRmJw?=
 =?iso-2022-jp?B?RXVjYmtoSVJXU2QyMHdXTW9tTks1R1JlZHhvK1pGeDFycy9udmdQMTc3?=
 =?iso-2022-jp?B?SjNXczBJWnFHanJPK0Fxa0tTbk14L1NhL2ZINWlYRjh4MDJKakNtV1Na?=
 =?iso-2022-jp?B?TmRBa1d4Mk1WcUtjbGt4d0gwVzNwTlI4eFU3ZEZNM3plaFJPZ25nN1lN?=
 =?iso-2022-jp?B?RWtrSVRYK1NEcS9DTnVNMnBiSXRBTzVNZnc2VzlqUmhtN1dtTDhhTlpG?=
 =?iso-2022-jp?B?NWI3RmVJTVVnSWwvWXZvREhOT0I0N3FERGhscTVhajBwZjllbDhJOXlG?=
 =?iso-2022-jp?B?NThlUnh5ZEYyanZicFIweU9MbXk5N1pVNWU2R2VJYm1wcWNxNzZ6c3c2?=
 =?iso-2022-jp?B?NXZrS1hYMjVCYk43NkZaVSsyZ0JhbjU5MUdQblUyb3hZS0gwQWtucWxJ?=
 =?iso-2022-jp?B?NFg1WXpDN3hXcjZmR3FIWmNtUWVqbFNQblhYWUVQM2RzeGFqUTVXamo5?=
 =?iso-2022-jp?B?bUtRL0w5ZHRDVHE3RzE0S1JmTkIvZ0FmVkxxTnAydk5aNUdHK005eEll?=
 =?iso-2022-jp?B?WWxrWUo3VlhtRTFVc1psOUJCSVVYNDdrT0lvNXVBQnlid0xwRXJybjdU?=
 =?iso-2022-jp?B?WVdjc1EyYkdxeklkOHpnS01LL2I4Tm5xRlF3RDhDTkk1cEFWRkJjSytV?=
 =?iso-2022-jp?B?ak5MSjd2WUJvQTVRWERCc2RybE9JMkZjcG5yclNTL1VHcVg2VkpRN08v?=
 =?iso-2022-jp?B?ZXBHcTVRdXFkNFF3ckxGMmNMYjgvNDQzdDNnZjl6S2Y0WGR4aTd2eEg0?=
 =?iso-2022-jp?B?a1dJeWZLQVFvbGhiVVl1Qm5xcEdVZHI5QXRWMURiZFgrWFZxcnh6WFRV?=
 =?iso-2022-jp?B?RktFVHBleHFBRHJSdXJRMEV1SkFId3M5TU1SRkE4MkJrcCtndjFiTDla?=
 =?iso-2022-jp?B?eG1GL1dLS1NBQWdndE9LWDJRUWVZcWR2YzlBaVpEbURKQVFnQmtrTjNa?=
 =?iso-2022-jp?B?NE9hQ2pGb2tMRlVHUy9PRXFzWUFsUVZ6TU9rcGhhSVhxUGpqREM1czFJ?=
 =?iso-2022-jp?B?YXAyRzZ3ZElLT0tsUTcraEE0T0lnMmRnOVo5YmNVQ3dmay9Oek9GWFpI?=
 =?iso-2022-jp?B?Z0pPc3dwNUwxWVpncWlZWnFsQk15OU9KVDhHSXBIWDJ1OUlHbnZZMXRw?=
 =?iso-2022-jp?B?bUNPdGlYZVAvc3lyRmE1SnRhOCszYnZjczhGTFljOWFkN2tRVHhDQkk2?=
 =?iso-2022-jp?B?dXdldGY1RDMza2FXL3NmS0pqYytDWjY5OU5WMnZFSllCcTlkMnZiTnVZ?=
 =?iso-2022-jp?B?MEJ5Z291cjVRN0d2M1ltbUthcWFrTmRUeTluUjdoMEdtTEdWQVkxdlQ5?=
 =?iso-2022-jp?B?cEc0TVN1cDd6ZzJKZ09BeVhvNkJQRVRwc2VRZnBvRmliMWVpeUVKMmx0?=
 =?iso-2022-jp?B?ZVhaR0c5ZzhmRTBVT3B2RWEwQXNVV3BZVHcreW9Jc0UwVzBpWDNMTXRP?=
 =?iso-2022-jp?B?VE5hOU1XS1FLeXFWWU53VXgxWGJpaDkxQko2NW8yOWU4QXhnMlZPK1Vv?=
 =?iso-2022-jp?B?WUFWaEEydmdlSm9JbnUwWGp0THZlQTczV2lJWC93RGVpM0srbThad1No?=
 =?iso-2022-jp?B?WkQ2VXdyR1BhUlRrRFBiUS9oLy80TkFvUktIQTY3UE1oZDFKZFMzcXdT?=
 =?iso-2022-jp?B?eHU1MmM9?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: toshiba.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYVPR01MB11245.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4201625-7fad-4f26-e117-08dbfa9d6b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 23:03:42.2904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G+aeOkExv5F9baVAFCIdKdyPqV6WxpJfJpORUPMMEmUQe4k7/AAk9p7q2h2lhW3w8fS7Gs/x3Rm66HG5lZMftMTRVetB0UIT5b3f3DMg9BxTz3dAcuDXdhOVf79GChpN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8503
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Mon, 11 Dec 2023 23:04:07 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/14040

Hi Pavel,

> -----Original Message-----
> From: Pavel Machek <pavel@denx.de>
> Sent: Monday, December 11, 2023 10:31 PM
> To: jan.kiszka@siemens.com; cip-dev@lists.cip-project.org;
> Chris.Paterson2@renesas.com; iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=
=1B(B =1B$B!{#D#I#T#C""=1B(B
> =1B$B#D#I#T!{#O#S#T=1B(B) <nobuhiro1.iwamatsu@toshiba.co.jp>
> Subject: [ANNOUNCE] 6.1.66-cip11
>=20
> Hi!
>=20
> New -cip release should be available at kernel.org. We seen cool number
> combination, so we could not resist urge to release early. :-).
>=20
> Ok, no -- so there was regression in 6.1.64 affecting ext4 in combination=
 with
> O_SYNC and O_DIRECT. That sounded a bit scary, so we are doing release
> soon. 6.1.66 should be fixing that.
>=20
> Trees are available at
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-6.1.y-cip
> https://git.kernel.org/pub/scm/linux/kernel/git/cip/linux-cip.git/log/?h=
=3Dlinu
> x-6.1.y-cip-rebase
>=20
> And their content should be identical.
>=20
> There are also tar archives, at:
>=20
> https://mirrors.edge.kernel.org/pub/linux/kernel/projects/cip/
>=20
Thank you for your quick work!

Best regards,
  Nobuhiro


