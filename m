Return-Path: <SRS0=CHW1=NT=lists.cip-project.org=bounce+64572+6709+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE1C432BE
	for <cip-dev@archiver.kernel.org>; Sat, 28 Aug 2021 01:19:03 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C735A60F35
	for <cip-dev@archiver.kernel.org>; Sat, 28 Aug 2021 01:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C735A60F35
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 7bDZYY4521723xy2L7JJfizP; Fri, 27 Aug 2021 18:19:02 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web10.1555.1630113538724225898
 for <cip-dev@lists.cip-project.org>;
 Fri, 27 Aug 2021 18:19:00 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 17S1If0t005278; Sat, 28 Aug 2021 10:18:42 +0900
X-Iguazu-Qid: 2wHHhCFII7oRGaNrzU
X-Iguazu-QSIG: v=2; s=0; t=1630113521; q=2wHHhCFII7oRGaNrzU; m=D5CSahbWX5kp4vxlgikH+4Yl5hQ0e27JVzLJS1cUUhk=
X-Received: from imx2-a.toshiba.co.jp (imx2-a.toshiba.co.jp [106.186.93.35])
	by relay.securemx.jp (mx-mr1110) id 17S1IeXA027696
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sat, 28 Aug 2021 10:18:40 +0900
X-Received: from enc01.toshiba.co.jp (enc01.toshiba.co.jp [106.186.93.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx2-a.toshiba.co.jp (Postfix) with ESMTPS id 2D70F10014D;
	Sat, 28 Aug 2021 10:18:40 +0900 (JST)
X-Received: from hop001.toshiba.co.jp ([133.199.164.63])
	by enc01.toshiba.co.jp  with ESMTP id 17S1Id5C004942;
	Sat, 28 Aug 2021 10:18:39 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxyxv236iwCvZuNEb5WW202k673fmZuQ9zQOZFXjVe5wC6k7nHrBPSCnJM5fA/dHO8rQBg9ylh2jLxwEnZFsi/3LJoCeOqjKalH6Sfi3nsR8ITMrY6c5kknVBG5Fh7FS4rKG6xVrDDPHcXcKMk5+c/fziiKg206n/Wh+UCQqvpYr+YeSe5RL/xxk4QeJ5ybdALd5sDF0vaolTMeGDEI/mYRy0oMmBYPDHYlVIbcWSICI9eP7UFxbj+4tYj7DpNfpHVPpCtsC8yh2OkpK9Ig5lYJCm782LKgJwbp76+zEYcE2OcoQS/h93O1Acn5IlR8Q0j1nMfXxBrNoLO8gZZifZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6xbIi4wmDl3INoU4rIca4LXJPqpQnO03FioCG4UEKg=;
 b=Z1DK1OshAC3fRTh4PxhCzVpgu4yKxlIN6f6YksfSmXQKxHOdnfw8iQcFT4O77nOzQF1nJX9l2mbSYPxjUoRK87i1Eypri3lUqiBNjCbwATLIKCOECu83CknFlZMuA384GqR+sTmoo42prdQvbR3MkKMM+z+a+W2D8LWRlW45yGD8u0fAOY37kvKf8n5wlF5jlCLLog2lGymFki9BPn1gFtrvzLrDe0eaEYikfwfFRvzxtnbwwHUSeZQ/RsuCd5gRI02Q58crpO01EOcHNpIcJXsUGhMC+1xjIjr4c3XN6YPHsygAzlaG6/+pknzx9rLtRdoGy7hHYwkAibJh8dj5lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masashi.kudo@cybertrust.co.jp>, <masami.ichikawa@cybertrust.co.jp>,
        <pavel@denx.de>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.205-cip56
Thread-Topic: [ANNOUNCE] Release v4.19.205-cip56
Thread-Index: Adebqnld+FiRKG+9RZG42kott4k/Ag==
Date: Sat, 28 Aug 2021 01:18:37 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB62524DF3E7738764DE57BAA092C99@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5d5ce4a-de4d-489b-b2b1-08d969c1c38e
x-ms-traffictypediagnostic: TY2PR01MB2602:
x-microsoft-antispam-prvs: <TY2PR01MB2602D33362653E29A0D714C092C99@TY2PR01MB2602.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: bmRfklg6b5aRB6/wHDMUWQiK5hZdahV1lCU6WyFMKRPtYdeiEIhXNxUrGEHMcbrLZN9UYUth7yJAwZtAa2jIZk0lKluompUdxQcOH7QCUBfVnBYZJy1YPljhRAn7HTJeZ8OGscx7uDIOTvkX0KF7ByvobcbX48R8vC+17sFEfOWvOYgdFZl1fuTANGvW/rM/sy3Tl5pVPuaR8QR+cKzVygGLjoc8e+IJwKQvFUEt4GNzJ4GO4aEfoN/I/9eQNI/ASraQczqFX33T2EjORxMyGY3Gskrr6XBYGfA9UzE6x/FD2Ncm8jnEop9OKE4jPe7VV1o9XLMBE/hqK9nvVfJgo6OIFLCR6FFEUhW4uAv9u23no17T2ubzOKjCoJb+sQoM5ZXWTdKCCgIEDehrjs/2gQkJznRReAqjKQ7xxt5+vEhZ7kXqF/WGWPm+3mUT34JLn2oWYy0AA7lhovi9UZ2jPKhs4M52sJVv0zKCR9uxhfZrhuiJn611PuLPFlSfCmTXNoMOFskb49RDiFMfhiaEn3kj2H3DZQncfA05HYsOPsD7n2Wy6xHS44j4d5jA0OFkI1chREwp+ovOVSHtm9H/kN0DOxYGOxkvGeYUCFz8aG5o3j77Tj+mwJvKC/YLNKMY7O+dkzP7ixOxtga27AtI7TiLqSbt795USLdog351T/iYvc0OQpNPsaVgY+z97vG9KwMGmiNnxKT5XfT5PfuVXhsT8MTeCRHtxugE+sBWvTuwgFqBcJpBH0Scc90ZS/DDjr4D2zkLIJDgXveXVBmpxIjDIkOj0+WphLtw3jGIZDg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUk0bktzbGF1c3E3dHdCMDlNNzIyVDhuWXlwZTNsSG5HNHpSRHVIQy9Fb29Q?=
 =?utf-8?B?Qml3eEtxc0JsZjV4R1B1YXc2eENYek1OdHdpTG8xbFVXd2JaeEVXdlJZK2dw?=
 =?utf-8?B?REQwcENSYm9DN0FkSzJ1UTZKcm1Xb3BPbGxHWmJ4c2JKZFlJcVdHSEE2Y1Ir?=
 =?utf-8?B?QmJKMk1nbXJqdzdIS1FHM21LMDBZZ3U3U0E1LzRzSm9GTW50Y1JFQXFGUnNx?=
 =?utf-8?B?a2plY2I3RTdaL3prYW1odGpDTGhUNmk2Z0orMG5Yays5REp4MG5pK1BDTlBu?=
 =?utf-8?B?S091bTNKRjQwQzZuSUp4SHd4YzVESU9UaVhIU0RTY25SZWhRSUNDV3pTaDBu?=
 =?utf-8?B?QzVLM2MybTFDOUI4VGR1S0dLY0dMV2grbEc3a3YwZUJXZWtPVUx6My9GR1Nv?=
 =?utf-8?B?eTVrWmZ1RnBYRERrbGZzT01TSytQZ1NiYkVmcnEyaThEWERXU3R4OHFGN1Nj?=
 =?utf-8?B?VVp6YWQxSVQwdld0c3dyNEZCcnczd08vQnpPb2JuN0w4UXlnbWkrTzZPZ2hU?=
 =?utf-8?B?aFpFQjArMG9VZWpWL1ZNV2R4ell2ZUdqQ1ljTkpCRlc1ZnBaMjBHYW90NUdj?=
 =?utf-8?B?Y1F0U2pxSW1WWWVVR3E2YXNoNkVScGx2VHlSNElIRjhvdzdlSG82ampkMTFX?=
 =?utf-8?B?YzEvMlVEOEFGQ3NtZkQ1akRlMlcyUEl2Y0dHOTRTNEVycXllVjdPckhnR2Rx?=
 =?utf-8?B?djRZV3pROUJRVWR5bU16c1RWb01YbW4wdUdTSzNndldPN3BLSXFZR3ZDR3hn?=
 =?utf-8?B?c1RBd2c3UjZWMXM2RFloVFE3ZEM4SFZ6U3JrNTJrWmF6ek42YWlhZGM4dGc4?=
 =?utf-8?B?dDJ0a1pLckJNTitPQ3pVL1lZcEFxYlc4QzBFS09temtmd3d0MldJcjFTU3Nq?=
 =?utf-8?B?U3ZKQm1YL3czaStQWlZIbFNraUk1akFROXhWN1Z4TGVTWWg2VFRxZWtONDh4?=
 =?utf-8?B?djAzd3JVNncvRVNKS0NkcUxKaEQ5WmhyQXlDOWNUS0VsR3p6TU5vY3Raa2Ja?=
 =?utf-8?B?RzdLZm5FKy9yUEZxem9oeE93S0lUSEZSUlB3RHJHbHF2WVJtMnovamxyS0ty?=
 =?utf-8?B?L2ZxY0VXRmJmSlZsd0ZIOTZWcUFWVERUYWxBdnhFTXlGUzFWRW11bUlFOTYx?=
 =?utf-8?B?R3NFVVRGQ2xxUWFzcmcxYjFrVDhSVFB2ZE5RMnd0SFJnL3BKbXF3dGV3d09Q?=
 =?utf-8?B?YWpsd29peGlYZWJ4Zlh1cURkb2VnckNlLy9ZVzZCWW5RR1VzZjUwU3hUNUxw?=
 =?utf-8?B?SkpjWmRoUkNBUWRVR2dlcVJyRHpIOTh5MWdOQkJJNHd4NytPUHlkOURsSGt6?=
 =?utf-8?B?OXh0dmZtcHZMSjJkaDI5V1lOUExxY20yNmJzUzc0WkJlZGhQd2krYXBGeWNQ?=
 =?utf-8?B?V3hqL0RjUHpKMm1mS2laazJTTm1iWk1BVUZhTnFEZ0d4aEVnSEZ5NHE0Sk5N?=
 =?utf-8?B?M2pZVkR0U0VIS2w5NGxMYnhRTXpEWTd6bEcrWE5zTXpIOGY3NmRVek5LMmRI?=
 =?utf-8?B?cmlXQVU4NHpSRE9Xd0cxdVdNV1dGZjEvc3ZteVp0VGxhY0VXN0RlbFlBSjVE?=
 =?utf-8?B?UjUxTk1GMjVEVGE0NnZ6a0xKbzZxSlY3U1VxNXBrZ1BLVVBvS1FyWXRDWTBi?=
 =?utf-8?B?RTVOb2lGeGFHV1cwSFh0U2I1aVcxeXkxenBjcWY3VHBmNVozc3hFeXd5MlAv?=
 =?utf-8?B?NXRTNFVQWGRsVFI3TVlSNFhJc1VPS0Q2WkVIR3BFVmg1bGhWUENxSG5YaG1J?=
 =?utf-8?Q?4oPIwoKz2qSESaDEAtrcXN+PjTReDVjJyo2dmWd?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d5ce4a-de4d-489b-b2b1-08d969c1c38e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2021 01:18:37.8566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pvmgc8NBQ69+k86jpqOKmjOhqwZTH3gwXVCHLZQ0K1Oyl30vbk/lfv0qJgNWlV7YTBEuZ+MOkGXPj8uFvjh0FWH9xXYr+8f9kXHR4Oqh10DVYDgSjrp2Ie34BD/PGHEG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2602
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
X-Gm-Message-State: iOmMzgqe0wKdAYoiXCbdv3c8x4520388AA=
Content-Type: multipart/mixed; boundary="47ffnFlXSOOLtzOREYpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1630113542;
 bh=PVCgOxo/d/1/vBFgPAs4WTzZaKbg92ozcKAfn/G0SZU=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=efKU0/pfU+iMx0ZyiFw0VS9dByhO184AHDw9baIxsthzQe8nkFytPgYL4Ctm0mQWTxm
 K32klWbF0oZJOEyWh99WsBDfiRAHe1UTSMDgbnzFZx3XEe1VzOUSKkFEm//oSkjSIiPye
 qQ0qIP6u0R4uDKIwbBXkw0ibYYmv8yuiPHM=

--47ffnFlXSOOLtzOREYpl
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjIw
NS1jaXA1Ni4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4yMDQNCnRvIHY0LjE5LjIwNS4NCg0KWW91IGNhbiBnZXQgdGhp
cyByZWxlYXNlIHZpYSB0aGUgZ2l0IHRyZWUgYXQ6DQoNCiAgdjQuMTkuMjA1LWNpcDU2Og0KICAg
IHJlcG9zaXRvcnk6DQogICAgICBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC9jaXAvbGludXgtY2lwLmdpdA0KICAgIGJyYW5jaDoNCiAgICAgIGxpbnV4LTQu
MTkueS1jaXANCiAgICBjb21taXQgaGFzaDoNCiAgICAgIGFkMTllMTMzYWViY2VjNTU4MDY2ZWEz
MzhmODk2ZWMwYjczMzgyNTQNCiAgICBGaXhlZCBDVkVzOg0KICAgICAgQ1ZFLTIwMjEtMzY1Mzog
S1ZNOiBuU1ZNOiBhdm9pZCBwaWNraW5nIHVwIHVuc3VwcG9ydGVkIGJpdHMgZnJvbSBMMiBpbiBp
bnRfY3RsDQogICAgICBDVkUtMjAyMS0zNjU2OiBLVk06IG5TVk06IGFsd2F5cyBpbnRlcmNlcHQg
Vk1MT0FEL1ZNU0FWRSB3aGVuIG5lc3RlZA0KICAgICAgQ1ZFLTIwMjAtMzcwMjogTm9uZQ0KICAg
IGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVyc2lvbiBzdWZmaXggdG8gLWNpcDU2
IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQoNCkJlc3QgcmVnYXJkcywNCiAgIE5vYnVoaXJvDQo=


--47ffnFlXSOOLtzOREYpl
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6709): https://lists.cip-project.org/g/cip-dev/message/=
6709
Mute This Topic: https://lists.cip-project.org/mt/85200740/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--47ffnFlXSOOLtzOREYpl--
