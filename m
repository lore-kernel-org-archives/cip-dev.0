Return-Path: <nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06DE4C433EF
	for <webhook@archiver.kernel.org>; Tue, 14 Dec 2021 19:25:40 +0000 (UTC)
Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.158])
 by mx.groups.io with SMTP id smtpd.web11.30336.1639509937183048744
 for <cip-dev@lists.cip-project.org>;
 Tue, 14 Dec 2021 11:25:38 -0800
Authentication-Results: mx.groups.io;
 dkim=missing;
 spf=pass (domain: toshiba.co.jp, ip: 210.130.202.158, mailfrom: nobuhiro1.iwamatsu@toshiba.co.jp)
Received: by mo-csw.securemx.jp (mx-mo-csw1116) id 1BEJPQcA001116;
 Wed, 15 Dec 2021 04:25:26 +0900
X-Iguazu-Qid: 2wHHOe8oOu9aGFhuni
X-Iguazu-QSIG: v=2; s=0; t=1639509925; q=2wHHOe8oOu9aGFhuni;
 m=ArvrcGF7lTXuHCr2JSNvanTsPSm0sy60CMU6DtiIeVk=
Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1113) id 1BEJPObl010444
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 15 Dec 2021 04:25:24 +0900
Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 55882100322;
	Wed, 15 Dec 2021 04:25:24 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 1BEJPNio030993;
	Wed, 15 Dec 2021 04:25:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgL5NUgkIdITZqAULI14Et8YAWR9+t6zTWfFueSg132VcWRhP8c3r/TU8uouPXPIXtoxJFxkMdq+npO3VB1Z24HD3i+JULOPzQgxlUaYTANWHhxjeA9hj/5cC4A7XsmRW86nu5ueEXW7FQ7gozF4EUgfqAg/OW7FvX4EOQ2GXe7a/b6Cnb+e9Df/gX8Zk/dFE6tnTodh43jRamcxABMJJeQUfglNkeYHS8a+JDbYV1C4hXQ2o64mhMmpqZXxQsQR4BYEvZOm5enAnxSXja7rHI1JcKH59Hp6HYzLcXWzZI/IKCa+t3EvYNWj4DCPOTNhh7W2yMHaoWbV9X7gR9eqFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zqF1N2tuILMM/8kTq2yR/0BTYI2stUp5FRoTs4Di60=;
 b=TIpqa/0hWPQZXV3FO2uGg1EAQyDf3ejXWJzrIZn/+5FNZ+qf+EWhmktzsGYa5mjC4G8d1q81xeG3yCmy1oaQ9WY/4GIJHntIwfEFUKn7VGk8Iz+2610f+Js+z+SmQnce/yWcDAfSrGh3mriTeztPWb3531eK34TKRCH3Z6TZrL/5x2jLyKarMDf4XEPIql8R22BUpaapwX7ya+3P4rIJuplf8cwYGVQvMwrxTxXLI5ifCRKrvNPlB9Iqb4hxXiRWiXg6rYXPkBISBy+Gp07DZdrEOlApORqLvQ+slxTuoBGxD7uRfMlKWdQYKcePQ+bOBJcSmo7m9uXlFbSb+JCjqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <prabhakar.mahadev-lad.rj@bp.renesas.com>, <pavel@denx.de>
CC: <cip-dev@lists.cip-project.org>
Subject: Re: Renesas RZ/G2L support for 5.10-cip
Thread-Topic: Renesas RZ/G2L support for 5.10-cip
Thread-Index: Adfw5pxYN+H3x/1pQLW4IwD37ia0fQAOKeyZ
Date: Tue, 14 Dec 2021 19:25:22 +0000
X-TSB-HOP: ON
Message-ID: 
 <TYAPR01MB62524FB6DCDE6EC9C0B7C33792759@TYAPR01MB6252.jpnprd01.prod.outlook.com>
References: 
 <OSZPR01MB70199550B2B2D5D541FB59C1AA759@OSZPR01MB7019.jpnprd01.prod.outlook.com>
In-Reply-To: 
 <OSZPR01MB70199550B2B2D5D541FB59C1AA759@OSZPR01MB7019.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 669a0c1b-5f3d-2a4b-bd7e-6a9563104dac
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toshiba.co.jp;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e406c54b-d8cc-4640-d21f-08d9bf3778e4
x-ms-traffictypediagnostic: TY2PR01MB3593:EE_
x-microsoft-antispam-prvs: 
 <TY2PR01MB3593F5D021F32AE173F3377B92759@TY2PR01MB3593.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9BnHz1lTM9LgRemyIVWKwTX32Ai0sTe8+xIQ4j/qYwzRrqgW4CZOHNDfbmtrQi0E7TrRQlyH6vPHyoHwLdcm6LqmDTlIaMnxl5vI8KmFzf84a9nSMb7+wQH9IDn5LKbrNxjO6B4DeYKt0cCpiwD69G99NqPqVQ6n9hWbFeSI9Jhbun51KR4+i/7ACkYakebf8vdSFo6lt4/w3u+SExWpT7hkcvG7hLwXL2YpSj7bXp7HQPwIk5pjh1HN/6fNnTFS3poorsZ/HgO1Zg6+pn3HrsQpBfxIdt8kAG8Vmxv/zmPOexyz46hdUiKxK0UMZrQoRuOsS6n7D0Dbcd0fPgkVl7my70z4SYKzNKQmazz5bW4w7VjU8p9ysSJ2dc0f6dur3x7Wui3o0ta08BxfHnBH5kLfoLC6ma6H5gUmPPYRFKv8VyOdYBdZwJqanvk7E3UDb8b/4xNFwOO4bdxG7Ks0vinYOJb1co/CGx9QYnqKV0I9pQXF/Xi/h+SUwaUph2EkvPuT/35X4nUfFAt/ZhpQAyq/NfvK/Hy9283h11lOTB0A5APxLSUYBo9fyho8hCUtqAfoBkpTOtjrI5uWDJDoiid7iPR60G2+d+xORdmY9aIjhVk/YRg1iT1tCKzE6RHa4L64vhTp+AAYnlUuoBhlvvFbgO6iRzuwQ0qkbPtpa5bJjaZkuuYY2BkKhRhSiLABYzq4hFqpUjWSFaJSMHruZg==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6252.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38100700002)(122000001)(66446008)(66476007)(4744005)(66556008)(508600001)(64756008)(76116006)(316002)(71200400001)(66946007)(5660300002)(110136005)(4326008)(33656002)(6506007)(8676002)(8936002)(7696005)(52536014)(2906002)(186003)(26005)(38070700005)(55016003)(86362001)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?RHFVbEZKeVp4SHc4MkhqaGw0N3AwTDkwTUZOdmVWU3pvbTBoT3VwN1pB?=
 =?iso-2022-jp?B?ZlF0RFN1elV6QTE5Mi9tUlZHL096ZzkrSVZma1V0Q3Ywc3ZKbTZaVWxi?=
 =?iso-2022-jp?B?bTkveTB0U3YwaW80RG5yQTdNd3ZhRUViZjE1ZlBaTVB4NStCdDRjMWlV?=
 =?iso-2022-jp?B?VVZ1aWVLdll2UmcydnNTMlV1K011MTRXSEgrNlNzU1pvbmg0TE54VDdY?=
 =?iso-2022-jp?B?VUN3aTlOa2NNTHB6eklZK2RraXdkdmVZa0h0WkR1b1pqTlVaL2Vzdmc1?=
 =?iso-2022-jp?B?U1JFeHZJZEtUWHA1WU1zWmpodnA5SzZLR3hMd09tNy9YaElzK0I0eXNQ?=
 =?iso-2022-jp?B?SzJLVm5vekxrUjJNUWNUeUFsV2FkZnZ5M25QdFdQclN0cDFDcXJCeHRq?=
 =?iso-2022-jp?B?Sm93cERMbWp2aW5VWVBmQlkrY2Y1SXZUV21hTWZKaVh3dnlBN3Z0ZWll?=
 =?iso-2022-jp?B?eDAyRm00aDROSWQwUmpmeWs2enhLWlprQUtMc25TVkVFc2FWQlpCODh0?=
 =?iso-2022-jp?B?dWIrNklUUUdvTTBRV2lGa282OXl6SlVnUkF1VWE4eWhQRXlhY1R2OUZN?=
 =?iso-2022-jp?B?R1dXcDBqbkcwUDdjaWZVVitjRUdBalI0Ujc0VUFOTmZ3clNoYTl3QkhB?=
 =?iso-2022-jp?B?c1AzNnpscTlIMlpmaTZqR212MUxQYjVFajZWbC9lU2RyQSt0R09yM2Nm?=
 =?iso-2022-jp?B?TUkwY05uTk93TG1XMDBiSWF1N1R4bXV0Yi82MnF5UE9TWTRsRWdlTzd0?=
 =?iso-2022-jp?B?Z3Q5TjMxeFVrZXZPRXBTYkFTc2xEKzZSMVdjMnQ2VEMwWjBIR2FxUUpI?=
 =?iso-2022-jp?B?bFVCMExpY05ZdENiNDBoUExEVWhFMmpwSkFFdzJWZTFmVDBqVVhYMVJl?=
 =?iso-2022-jp?B?YVN1UVdXRmhURVFOL3pLRzVUb3BOY1JWQ0ZFdVNsZm51V0FoRDhxR25a?=
 =?iso-2022-jp?B?NXRsdUlKeEZvai9yZ29KVlJyWHMvVTJ2SHp2TFhVNURZVkdqMHVnbCtm?=
 =?iso-2022-jp?B?VlZYcTdkSktUMnFXMXVBa2ZxR1dlcWtFMUt6Q2dISmRXK24wWVBsYmRh?=
 =?iso-2022-jp?B?VXRyRlhWTTJZVVNWSmw5Z1hkSDhaRm9sWmZmM095Um1JVzRSV1gzLzRB?=
 =?iso-2022-jp?B?RGsrTjZCeDVLZHQ1WWx4R0VDRzFkYmNBN24vNkt5T2tWbGJmYklIUFU4?=
 =?iso-2022-jp?B?WmUyR2YxaW05VENEZ2RzYXprWnNDb2Q0WHJYRGhJdkZGTDBwcTRxM2ZQ?=
 =?iso-2022-jp?B?YkplMlpZK3JXdkZPRzE2c05QU3MzUkRJbEViRDcxc3llZ3ZZQk5Ra2xO?=
 =?iso-2022-jp?B?V0hSR3dDYXhPOFl4ZktkSlRiTWlUUkVUbmtBQlZGeHBGR2dBK2c0QmhM?=
 =?iso-2022-jp?B?V3FEUmFyc0pUUE1zSThnNk9NTXV1dWgrak52UndBYUdSeWtENlRuVnAw?=
 =?iso-2022-jp?B?NUNvNklwQUxLSVpCQ3QvTmoyMVBSdk5mTjFTeGZoMDE2OFdnUEIrNjR2?=
 =?iso-2022-jp?B?dFN4aFlWK2labjNZaDVFOVFNODdIWTBsTEFveHFMMUNXLzY2eGJmMFdL?=
 =?iso-2022-jp?B?TWhOeVpvbjRRcjdyN1FWVmtualVVUE1IVjNhdEpDcmpMYTZuQ20rRTN1?=
 =?iso-2022-jp?B?eEdmU1ZWc1ZrL3RpNjBBcHI2QkQwV0I2TUZ0VHQyenk5djB5WGkvaUhy?=
 =?iso-2022-jp?B?MHUxSHc3MHdaN2pka0NzQVBka05TbkN0UnNMbU9XakxDM2R5ZzVFL0sy?=
 =?iso-2022-jp?B?aWhRU1lCRG1aaVVDVC9yRG9PdmVrNzZyMHRETDh0a1FEcG51M1VQS2xa?=
 =?iso-2022-jp?B?dzNLY1QrVTAvNTdhQS9lSUNvaThTNm9VNm80SmgxTWwybWh0M0Fwenlw?=
 =?iso-2022-jp?B?WjdWQVI0VWZPRVRuRVdCUkoxUFR1cHJDMDV4enB6OExab3g4WlBzRnc2?=
 =?iso-2022-jp?B?cUgrWE12dmxRaUtKVU5ldWRtdkZpdjJHWlFFUlh1enZPY24vRGszVXM1?=
 =?iso-2022-jp?B?TXNFeE9KL09XdDVDSWc1ck9xa0pldUZwZTZFbHgvL1ZoWW1LaXFHNlN4?=
 =?iso-2022-jp?B?R0RvSmE4U2swR2NtbXVKeUN2V3Eya0lMK0QvUjJRb3U2cldZWWpJNHlv?=
 =?iso-2022-jp?B?NzdOS3JQNGtrRWt4d3FpVXgyK1hXOWdLUEE4aU5oS1lDTHVrNDFtdHE3?=
 =?iso-2022-jp?B?RUpjVXFhMGdGbm9lL3AvMnhhdnB6Uld2ZEp5bjZvYkUwanZLZWpIR3VO?=
 =?iso-2022-jp?B?TlNGRzBCS2RRdmRLdmM1Sm1zMWExT3RLbDRpSzFLeUFiMlQ0dG11OW5h?=
 =?iso-2022-jp?B?UEJXM1JrcDNuMVprWDN4N0EwUTZDWTBERWtFMFBNWWNvWi9uT1RpQjBk?=
 =?iso-2022-jp?B?U1dITC9XYVdNWElLSEVtSFBkazhlM0E4bWc3elVzb2FhazcvL2xTZ0Jr?=
 =?iso-2022-jp?B?M2d2WG9Zb3hPTUdjaGxYSmtQZWtyVUdRaURvOHNKenB4UnR3SWhDWk5V?=
 =?iso-2022-jp?B?MFdwMFl4?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 e406c54b-d8cc-4640-d21f-08d9bf3778e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 19:25:22.1066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 
 mwB8U1jR1MqqqKVfrl6sp42UTEO2oeRNDiCRPIE8Hkjjp6xPVIenWNr1O4PdU2+i7tSy4cU6vFUgHvkbn0JDiPCnukpoBcIzqMvmJwOYZlbXByH5x5wtb5h7hhvvECLV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3593
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
List-Id: <cip-dev.lists.cip-project.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <cip-dev@lists.cip-project.org>; Tue, 14 Dec 2021 19:25:40 -0000
X-Groupsio-URL: https://lists.cip-project.org/g/cip-dev/message/7098

Hi Prabhakar,

> I have prepared ~105 patches adding support for Renesas RZ/G2L on 5.10-ci=
p (all patches cherry picked from v5.16-rc5). Is it OK > if I bulk post the=
 patches or do you prefer them in chunks(maybe ~25 each)?

I suggest splitting it up and sending it by feature if possible.
In this case, we can review each feature separately.

Best regards,
  Nobuhiro

________________________________________
=1B$B:9=3DP?M=1B(B: Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.rene=
sas.com>
=1B$BAw?.F|;~=1B(B: 2021=1B$BG/=1B(B12=1B$B7n=1B(B14=1B$BF|=1B(B 21:34
=1B$B08@h=1B(B: iwamatsu nobuhiro(=1B$B4d>>=1B(B =1B$B?.MN=1B(B =1B$B""#S#W=
#C"~#A#C#T=1B(B); Pavel Machek
CC: cip-dev@lists.cip-project.org
=1B$B7oL>=1B(B: Renesas RZ/G2L support for 5.10-cip

Hi Nobuhiro, Pavel,

I have prepared ~105 patches adding support for Renesas RZ/G2L on 5.10-cip =
(all patches cherry picked from v5.16-rc5). Is it OK if I bulk post the pat=
ches or do you prefer them in chunks(maybe ~25 each)?

Cheers,
Prabhakar


