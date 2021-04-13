Return-Path: <SRS0=pvbg=JK=lists.cip-project.org=bounce+64572+6359+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B7C433B4
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 00:47:50 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A6D61220
	for <cip-dev@archiver.kernel.org>; Tue, 13 Apr 2021 00:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A6D61220
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6359+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NLpIYY4521723xZ9W3NweoDA; Mon, 12 Apr 2021 17:47:48 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.155])
 by mx.groups.io with SMTP id smtpd.web08.2467.1618274866364958300
 for <cip-dev@lists.cip-project.org>;
 Mon, 12 Apr 2021 17:47:47 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1516) id 13D0liv7012242; Tue, 13 Apr 2021 09:47:44 +0900
X-Iguazu-Qid: 34trF5RVHU2H7vMXLe
X-Iguazu-QSIG: v=2; s=0; t=1618274864; q=34trF5RVHU2H7vMXLe; m=2ZkkVqgUPlkKe7d7qrXbG2o4+HbkJZGKsQvqTeirfrk=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1511) id 13D0lh6W034581
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 13 Apr 2021 09:47:43 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 65C211000AC
	for <cip-dev@lists.cip-project.org>; Tue, 13 Apr 2021 09:47:43 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 13D0lhlE010796
	for <cip-dev@lists.cip-project.org>; Tue, 13 Apr 2021 09:47:43 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ql7leJCkx+PSAfmFc1xWjN6UnwFwtNY3Hu17ivjtddzvpAJBHYhawsjuli32AN98bpKtCUY7Ak80H57/RnrVAyrk5RFCgRXn0TamQS+2kWp5by6NeuNItywON5iENejksvKX6dt6SMVbLOU1kSac+Zlj38gCkvUdTZMuKNMmwgaL8Yb9VrBFPnquec9CZ2o7INXvwH6UVBgrD5ztWqwl5lGhWu6lQ5C0J5vy02BRgfTqHx5mcGXq8z5ZaxG4oBt5A5XIvRl8IrbNTTzoh/oyUKP17Jnkfw3ufurpxn7pa3HDQKTKCh0pjtT9WSvByLGZBV/rk8poOPKKK0cAcXg+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BdPzK3X4lxhmrfAQQr9FkyGRdXfy0rdqdi6Xqe1FI8w=;
 b=cKsICKgYDbKYIjYrtfsbrV/jI1F/YdSGJBC+O1eIZpCq21bBjRlF1NvcOtJi1IVzViXG2+//C4GnDhkvDLdZa/sG9/Bg6RU4/riAieDZ2J6CWf91B6JJRahsGZjaMNjvVwFPfXRAx51b9nb+gvTkZmPR5gM5yPvvKInkRCUN0HJ2oj+LVNvMFkBczp8bj6T2tFOUsKHm3d0XYUNSWiaf2pHmxdJqx1ZNKDk3UJ7i/l/DgX+nDJ2ady4qBsVIpvyFPa5AEs2L4euHSsafCe6cE7LJXzxwhP2psl7qZ3EwLZ7h9FHVgatT+HSoZgtAsp8jdJS3fAvphuPHpSfRPrrMSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Kazuhiro Hayashi" <kazuhiro3.hayashi@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>, <daniel.sangorrin@toshiba.co.jp>
CC: <Venkata.Pyla@toshiba-tsip.com>
Subject: Re: [cip-dev] [cip-core:deby] security-layer: add bro package to the security layer
Thread-Topic: [cip-dev] [cip-core:deby] security-layer: add bro package to the
 security layer
Thread-Index: AQHXIHCGnyZeeTh430CxDhT6m/axKqqxvBQA
Date: Tue, 13 Apr 2021 00:47:35 +0000
X-TSB-HOP: ON
Message-ID: <TYBPR01MB5502B85E2AB00928DB8790C0E14F9@TYBPR01MB5502.jpnprd01.prod.outlook.com>
References: <20210324054458.1753-1-venkata.pyla@toshiba-tsip.com>
In-Reply-To: <20210324054458.1753-1-venkata.pyla@toshiba-tsip.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6afba945-f0eb-4f92-450b-08d8fe15ba9f
x-ms-traffictypediagnostic: TYAPR01MB6169:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TYAPR01MB61699A31DFF91E77AF7C0252E14F9@TYAPR01MB6169.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2582;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CE2gY/3SWHn1rdOpLysGXusD3RFjdgJeVsOKRVUKqMXv24XPIUfl60eBXDdy1Hpa9kpoO7FHqbp+r9xYeRIVoDkh+ewb4ylrJmEqV0OnBvCtj5DpjcBJYsV9N7y3Sas3BBkvE5HBl/mUFY3zBYjomuCH26wpeN9qwTojADdVYGSoClUtakb3vy9viOCgk+aFvPNJbfXs5UEBFbLtcCrP38xb3acWEqN4njGb9hX6NUAT5MlJ1xNhkv03s2ua2EyaLpUR9ol4Flo0Y0K2aqvxuZ36Mo5q3i/YbeTqtnJuzhzZKVBFrEW/7XiUrbLsaKllHxXfMKVT6bJmB2yFVEeT2W2tyGV+BF6Uws/aVf+lQKCKg3bQEqh1qBZDaB3eFOFr2IhYBkcwvxE34Bw15WDYjYjHpzfdi61dQHYXiYZi2jVI9dzQVNob6UiZpBWAgGu7Z9QU5ytcmfAl8GM/iz/05zXU9nwR1lhG3V0VDDnbdl8vHnEAT+50StYylZljn39eFcz2T+GsD/iFP9fCGs2lQgyR6w4ym4fKUbRDovIfIxrSW4H1JCroGnl5hGGwuFJ1N4s6l4hAo00htqZXprX7TEaWvszJNC4HxH5BdQy9bxE0kxgUWkYXikIpyumA0HUEqQy0o6HQHq+8U3g04W9CUsDf17ZMdFPFwNVNLcEIb+ylrxq/dHdctwpQB4lIoHqY
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?cmJXR1p6NHRDcWlHcEl5ZUI0U21XVlZ2Rkh3N2JqMEtzaTd6NlBhMVhK?=
 =?iso-2022-jp?B?UXFWc3E4QWh4YVBFYXFOMXdscnRoa2F3SGtsZHBtR09KZ3R1cGM4bE5D?=
 =?iso-2022-jp?B?VFp1NVV0REwvK0RFd1RBY3B2Ylp6OGthTE5YbzgyQ0x0WUMzOEExRXFR?=
 =?iso-2022-jp?B?eUkzeFBBcjA5Tjk0Wjgvd09uZVFYNTljQzBMa2UxNXc2d3pValIxMmJ0?=
 =?iso-2022-jp?B?WDhoZTA2UG5GbSs2ZDQ3U1FORHFzUFFkZWd6K3FDWlFJa040b0d1elU2?=
 =?iso-2022-jp?B?ZVpGSEkwdFZEQkdCeVpwVjFhSThUTWtvNDVOd1gzUGloZEVhYXZVQ3N3?=
 =?iso-2022-jp?B?NzgwTFdWZjVVdTI0cnlGY2xLNG9mVnA4eUlJa0dRbGdHNHpzUEVoYWtn?=
 =?iso-2022-jp?B?b2EyMzg5eG9IWUh0U0hZejFJNXdXRVQ3bU0xSUpqbUF1aTRudUlYSU16?=
 =?iso-2022-jp?B?QzVPNjNNOWdMb0ZBWGVpYUNmd1VMSWRTeU00QUVFZlI4ZElQRU1zd2R2?=
 =?iso-2022-jp?B?bkhTbWRVNFhpZVN2R1FNZ2thNmxZMUJlTVRWeUkxTXdhSmIrN2pCUERz?=
 =?iso-2022-jp?B?RE1mT1ZHWDlRSExkRVd0TnBsTmJZQ3B1VmNUWEtsVGw4T1NTL3dWN05Q?=
 =?iso-2022-jp?B?anZsVG1GU29Ka2lMQlZ5ZkJOZTFJeXIvQ2hoa1RFUlU1WFFYdEoweDBP?=
 =?iso-2022-jp?B?dGVNcDFzVUNTT1RnSlZCeStoMnFQaUNmZ0ErdlFTc1N2S1dNSldwalIr?=
 =?iso-2022-jp?B?WmlWd1liQlAwR1pFNXVUakR1bENEMlErWVNiUk5ud0YvT2o5TVZxN1Vt?=
 =?iso-2022-jp?B?b3hjZzdxZkJTMExpRTZjQ3NOcmp1UU13Z1BkU25zaVhid2tHSm5zeHF1?=
 =?iso-2022-jp?B?eTROd01KaUlSZU9PRi9zOWNjQW9TUDlCZWVQcUZaQVlIZVJlMkh2REJ0?=
 =?iso-2022-jp?B?bjBnZ2Y1SUhsdjRQQTlCdmNPRjI3elJEa3dTOHN3Z0djV3pmRHRvY05R?=
 =?iso-2022-jp?B?dVZBaEcvNHRtS2syTVUxU1ZPdk14ZHM0eUcvM1YzbENxc2hXQ1gzMFhu?=
 =?iso-2022-jp?B?c0dNWTY0MyszNmJmOWlrQ0tHUHdYdHZ3ajVMT1NtK3dKaU1VaS9KYXJI?=
 =?iso-2022-jp?B?VWVaQjFkSGVqYTBDNmdONGM4aFNudEUwTzNXZVByZWk3THNsV05jeFhm?=
 =?iso-2022-jp?B?ZXRhTWdYUXZ4QVk2MGZIbmhZdGlNV1FwN05qWGtNbDZxRUFXMzBxeksy?=
 =?iso-2022-jp?B?SlRUcm5nNXhFS3JmMmxOL3JlVVZ4blNuOEN4aFJCa1pRU09lQ1phZ1FX?=
 =?iso-2022-jp?B?UkVVZllQOHhsMENqSCt4RHlib0c1TGhYbUZIU1MxbWpFT3NlY1Y0VnJB?=
 =?iso-2022-jp?B?RXRDZDhLekpqVDdpRFMyR3N4VTZYTml3cHU2ZElOdkxxLzFkaWVjM1cz?=
 =?iso-2022-jp?B?YWxRQmtHeUVZZThpWkJ6V3ZMYXVycStrRGtCaUhLR3dJSWtGVE1jZlZQ?=
 =?iso-2022-jp?B?UHA2NEtRTVNMdDhweDYwT3RCNUl1cUtYYXBQYUQ0VllUQ3NkaEZnR2c1?=
 =?iso-2022-jp?B?dklzOUQyOThjSnI0VTZQcTJ6VnU2RVI3aXk4ZlpTallnQ0NUVTFNTjVI?=
 =?iso-2022-jp?B?MkcwWTBBRHVVSjNWYUpGMnZKNll3NzF1UlIwSHZqYWk5NnVYQmdSRzFh?=
 =?iso-2022-jp?B?aXowc3VkNTRxS09zYlg5aFd1QXp5bnZ5SnZZUUpaVTFTYUZnUklaYncr?=
 =?iso-2022-jp?B?eUttVGtGN2Uvb2syVXVRR0ZPUmVWWVM0SzRoY2JoWmU2aHdvSVNBU3hx?=
 =?iso-2022-jp?B?Z2E4SlpvU1VabUpBdmZhN2pzcTVRL0RwZ1F6YTc1Tm10RW5LczFSWjJ1?=
 =?iso-2022-jp?B?VmVkd2N2UktwdVBqcWQzSXdJaU9FPQ==?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5502.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6afba945-f0eb-4f92-450b-08d8fe15ba9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 00:47:35.1126
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UvqgdOL5dSsmQZyuRzCtgZqzBFgu6IRZLRVwq3/AOtdBTZg2Y1AZgcKPCU1lS62diPHMqBNFniw8Iw7XZx6G+8vTDAGCJbfOPPAf0UtPOYs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB6169
X-OriginatorOrg: toshiba.co.jp
MSSCP.TransferMailToMossAgent: 103
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: essvWw2gkKAxdY7uJRK0m9sZx4520388AA=
Content-Type: multipart/mixed; boundary="5a3qYK6hWcjeyCBV2Uag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1618274868;
 bh=swEZRsK0EXUlj9uLoh0nW706qxxi6AZNe10Yi1TjFg8=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=tQoa3UqOlO0Q/bhjLq8Z/t5NbVy0MnS5WRfEQV2rvzqnOzQccR6+sl/wuQmPs9BbOGJ
 8Ys5JEilM6ebpgCPI5SaDdZPuF5mC/KXdsxw8tQIs60wQ4LL9PDhwUkNILstB+yynoif3
 ZThy+sezxFgmUQCbeU4efXJAMeuMGOE8c0Q=

--5a3qYK6hWcjeyCBV2Uag
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hello Venkata,

Sorry for the delayed response.
I merged the patch through GitLab MR, thanks!
https://gitlab.com/cip-project/cip-core/deby/-/merge_requests/8

Kazu

> -----Original Message-----
> From: cip-dev@lists.cip-project.org <cip-dev@lists.cip-project.org> On Be=
half Of Venkata Pyla
> Sent: Wednesday, March 24, 2021 2:45 PM
> To: sangorrin daniel(=1B$B%5%s%4%j%s=1B(B =1B$B%@%K%(%k=1B(B =1B$B""#S#W#=
C"~#A#C#T=1B(B) <daniel.sangorrin@toshiba.co.jp>
> Cc: pyla venkata(=1B$B#T#S#I#P=1B(B) <Venkata.Pyla@toshiba-tsip.com>; cip=
-dev@lists.cip-project.org
> Subject: [cip-dev] [cip-core:deby] security-layer: add bro package to the=
 security layer
>=20
> From: venkata pyla <venkata.pyla@toshiba-tsip.com>
>=20
> Signed-off-by: venkata pyla <venkata.pyla@toshiba-tsip.com>
> ---
>  kas/board/kas.yml    | 2 +-
>  kas/opt/security.yml | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/kas/board/kas.yml b/kas/board/kas.yml
> index 51c7a84..f1ff202 100644
> --- a/kas/board/kas.yml
> +++ b/kas/board/kas.yml
> @@ -20,7 +20,7 @@ repos:
>=20
>    meta-debian:
>      url: https://github.com/meta-debian/meta-debian.git
> -    refspec: 8dc5105b7e36e253093f8103b1f812535bac24a9
> +    refspec: 1d746eff6256a16809e47c846dd9514ab43a28fb
>=20
>    meta-cip-core:
>      layers:
> diff --git a/kas/opt/security.yml b/kas/opt/security.yml
> index e68d2e0..02db4c9 100644
> --- a/kas/opt/security.yml
> +++ b/kas/opt/security.yml
> @@ -28,4 +28,5 @@ local_conf_header:
>                                   acl \
>                                   sudo \
>                                   auditd \
> +                                 bro \
>                                   "
> --
> 2.20.1
>=20
> The information contained in this e-mail message and in any
> attachments/annexure/appendices is confidential to the
> recipient and may contain privileged information.
> If you are not the intended recipient, please notify the
> sender and delete the message along with any
> attachments/annexure/appendices. You should not disclose,
> copy or otherwise use the information contained in the
> message or any annexure. Any views expressed in this e-mail
> are those of the individual sender except where the sender
> specifically states them to be the views of
> Toshiba Software India Pvt. Ltd. (TSIP),Bangalore.
>=20
> Although this transmission and any attachments are believed to be
> free of any virus or other defect that might affect any computer
> system into which it is received and opened, it is the responsibility
> of the recipient to ensure that it is virus free and no responsibility
> is accepted by Toshiba Embedded Software India Pvt. Ltd, for any loss or
> damage arising in any way from its use.


--5a3qYK6hWcjeyCBV2Uag
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6359): https://lists.cip-project.org/g/cip-dev/message=
/6359
Mute This Topic: https://lists.cip-project.org/mt/81570399/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--5a3qYK6hWcjeyCBV2Uag--
