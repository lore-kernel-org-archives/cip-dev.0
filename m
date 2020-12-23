Return-Path: <SRS0=4jK0=F3=lists.cip-project.org=bounce+64572+5974+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F373C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 23 Dec 2020 23:58:46 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D29F224BE
	for <cip-dev@archiver.kernel.org>; Wed, 23 Dec 2020 23:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D29F224BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+5974+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id 8pIDYY4521723x1FZLOmmFbe; Wed, 23 Dec 2020 15:58:44 -0800
X-Received: from JPN01-OS2-obe.outbound.protection.outlook.com (JPN01-OS2-obe.outbound.protection.outlook.com [40.107.141.133])
 by mx.groups.io with SMTP id smtpd.web08.4152.1608767922648201689
 for <cip-dev@lists.cip-project.org>;
 Wed, 23 Dec 2020 15:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7Cle7mXCY58qPArYOnmOVxpHcklZyvQq5OuzFxuHJ/Pmd0wUv2XDcgpGD10IVoTx6HjzCT3BKAvzT7joo3x6V2NIutrb2WJIP+jyUfupLu+sl8ItL/QQobSGH0Eejdjwixqv6jDjmnKXXxqrWMnQTZ6Be16Y66ItCDdYpaDCi7m3QBZIPIHcqXBbzo/VrZp+hwQzc+knFqVmzrWGMGk4zHRo6WPGW3MOwF0Y7kRzukNNpkpcl42bnx0xaUWxzkhW2WeF/zZ7NDdFsnh6ySqktY5W0mVco80lvczd2v7kqINk4cNzDO/Cw3Id389zgGAYYQNUsxTFDQzAgO2jvae5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJ8NLhWQ7DhUvAOACV347vrcENbGajPhA/rIOUSYiGo=;
 b=mn/33uf9sygO2PbUXmY5Z9WuSASYldvvygHZeNgGIpZPwC19qf4wrO20lsCEx6Da5jvN5+cahhdsIXb1Fqc4ze9IsE2Muw1uYGOqIQUfFBVCZgLkFx2Sz+7EB7n+TRjtEj40gbnSmVlJTvvWduf+ZIjqU211OnQ5eh51qAc6xfGOPMD+0zs3LJPyOX5MeNkBzbUN2gVmRJb1HtWF768HYvOxDaZ6fKEXwUszn8yiWGcV8ORTK3PD0Eg31Pt+upR+Ei0GgGFJ3VDMAGszKpM7bpAlifaqN6IFO28zee0hnR1vVxbqEgRmgH94IUllGPafTPmXoKK3Qy1o9T55cldIHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5929.jpnprd01.prod.outlook.com (2603:1096:404:8054::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3700.27; Wed, 23 Dec
 2020 23:58:35 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::caa:c807:5f07:795e%7]) with mapi id 15.20.3700.026; Wed, 23 Dec 2020
 23:58:35 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] NO IRC MEETING TODAY
Thread-Topic: NO IRC MEETING TODAY
Thread-Index: AdbZhytq026ZjuV7TAaJTsf6827lLg==
Date: Wed, 23 Dec 2020 23:58:35 +0000
Message-ID: 
 <TY2PR01MB4972F0E4BB9F6A01A53AFB82A0DE0@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 775045ff-6697-470e-039b-08d8a79ea939
x-ms-traffictypediagnostic: TYAPR01MB5929:
x-microsoft-antispam-prvs: 
 <TYAPR01MB592908062E099B54D219D8FDA0DE0@TYAPR01MB5929.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 owuxLWck8LH51nTFOb9cm330lIaSS3uVC1g4KMu/fliwwkCVTwcwN9k5Yg04F1X/NrHXwQsQOnt3dYs8CIl2pZxSYKRintBMXXnLWCxpFEMbydU2Ct0O93mFf3Q7sZYQp+3k7a9Cu+LwF/2KCrMXshg8/OFbIhD34/pfBiAuuoiKS9egbZAHLxy6HDqyCCm21XDbdkzftS8qBHRnrp2rwgckrZcxTN6AtdLaHDVsEdv/onfcnpd2FyTQw+ISBK54MnLDtkc/RDT+Am16TO3Lek3YdzWm24efm/Vy5vRinBCXn2SZdsobf25/sun/EFPT7IRQ0fToYUlEobzvMQjxYUYG51mty2FGRLOTlD4xFoXXpFUIRtnSkVkkjzR2bO27fD9W6yvdslN4dErlKjfif1ZJ66Hum6vfB3FGHCBjm/NDxj6Tgi6dLLzM66RWJ+Ib2GkpA4SXtY4ceqbeqZWZvw==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?OVdvN0NhVEkyUmVpME5JNlFBSVNsNjNyMGZZcWh6UlBkcXByb0ZxbzAy?=
 =?iso-2022-jp?B?cnZxd3hWTXN0Zy96UFZnT1c1WjVxSlVTSmg3U3NodUtZejJrYkNCaTl1?=
 =?iso-2022-jp?B?OHg3TjdMaE9oUnFFWm0yQUlOa2tUVWRCb0FZUjJPZmhac2IwelFqcE50?=
 =?iso-2022-jp?B?NUVHVXN3Y3BmZjJaWEw2b0lnMXNIREsvdU1vUm1PNFpUOXJEUHNzS3RK?=
 =?iso-2022-jp?B?c1JWQUJTUzR6MEV4NENFSnlNOU95Q25pMUtKYzBLU2VYbHlHekM5aHRm?=
 =?iso-2022-jp?B?ZjdoZ3dTR0owVGVFeTdkOWFHTzNmYmRhckVPQk5iV3JhTjNhSklMM1ky?=
 =?iso-2022-jp?B?aG1HWDlrU1JQdm5xaXVXTjBCVVRvUmZRZ1dRV013TmdlZW9YRnF5dU5S?=
 =?iso-2022-jp?B?RG8vWUdLcVJVS0FieEp5V2Z1RGp3ODAxZHpiZSt3U05GOXVsdUV6dkM4?=
 =?iso-2022-jp?B?ajZ3aytXSlB4cktOQjEwZU1nK2tFZWRya25iS1E2cXR5cGZyYmJ2RlBs?=
 =?iso-2022-jp?B?c0pnbmY0Q3Z3Y1Y2ZGpmem14Z3JSWFErYnp3aGFjOEJqNXFrcU1NYWFy?=
 =?iso-2022-jp?B?SmVtYWhJK21SZDBSVHZsU1pLeDhpQmszbEVLOXNMaFpNWXlhVXlZTDdJ?=
 =?iso-2022-jp?B?OElUazM0a2M3eW1KeUY3QUY2dVpkL2swMU1wRDlOTWhPWlFPQXltS0Ju?=
 =?iso-2022-jp?B?aVplMWlLUi9ZYWVhTmg0dHlYTzhCZGluNVorVmFPaGpUalkvZDVYNldt?=
 =?iso-2022-jp?B?ZWkvaisvWG90c3hnS25LSkkvVG5TbjZQOHBhOFgzeEk3Q29weXYybCtG?=
 =?iso-2022-jp?B?WTF0OXdyV0VWM04yckt5dU1PVFNsYlN2RHluS0l6bm1QUzQxR3B2a2tG?=
 =?iso-2022-jp?B?ZWdPcFJTZEtDUktsV3hmZ2hiQ0R2ajl0akZnRWVRNm5NazA5UERYcCtl?=
 =?iso-2022-jp?B?Tzkxc2RPbE1BSkV4MFV6dlh6eHo2bU9zUVM0bllpR3hRTExjdTZQSkVX?=
 =?iso-2022-jp?B?dHFIRHpmaUFmQzdxVlNvd1N1ZFZKa3NodVUyK284TldFdnhYdVlmaDA0?=
 =?iso-2022-jp?B?ek9KOVpIV3cvcE84SnJWRzZRalpuOE5vTXJTa3hvUlBLQUNMUjBLTUVI?=
 =?iso-2022-jp?B?ZUtCN0JBNExHODFQZ3ZYaERUc2t2SkFQaGtDRC9vM3Y2VUQ5V3NydHFK?=
 =?iso-2022-jp?B?MXZSckNDQ0hKYWxsTm1tZVNaY1BGK09ZTTRFQm54WmQzSjJmL2pGUkxY?=
 =?iso-2022-jp?B?SjNqc1U2ZXZCeWVTdE1FWUFYa1p6czNUbmZYWjdvc0dFUTBoUkRwRFIx?=
 =?iso-2022-jp?B?SHlHVXlmUUV5Vm5yQ0dVTDRsRkpTSEhiaHd5bnBlSlBHekJDTG0zRnJ5?=
 =?iso-2022-jp?B?d3FEWGJ1djVPb0x2VXQ3OFhuQmJ3cTFHQ1lNVTlqbU9oT1BQYz0=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 775045ff-6697-470e-039b-08d8a79ea939
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 23:58:35.7043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o81m7knAmQjEO1wIcOSbVb6XJHOdKFkhctJMLV8uQuPZ8m6AEE5CF0uofblEI2qSkiHwIhl9Fp0/RLRcR5gmqzGNw+lZxFZNrMeZeHGT7FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5929
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: xLKlfrIjRVdbq4kLBWjV7M5xx4520388AA=
Content-Type: multipart/mixed; boundary="o8kUUytwixP9coGJpESK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1608767924;
 bh=CW/jX7N5++tBA+HGxQ6WpzKjxeEajEXfSorkT28dygI=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=eY/++IHL0IXzBBfWqTL4GCWYK3pbxXJMBfapMasSI4nZFdALWFzvvMEzvI5HSecRZ/d
 iHE5A9Af3PwZnk9JNF+bS4bcxvzABSH2xEpVQ5fSEuEBq7o/XMZT3FO6WcXmcLjnq9LyR
 s6EySldE/iBWyjB6AKX24c6JZRyJvEHpsVE=

--o8kUUytwixP9coGJpESK
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,=20

There is no IRC meeting today. The next IRC meeting is on 7th January.

As a reminder, the following are the last meeting minutes and the latest ac=
tion items.

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2020/12/cip.2020-12-17-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team
  4. Discuss an open issue (https://gitlab.com/cip-project/cip-kernel/cip-k=
ernel-sec/-/issues/8)=20
      - the necessity to track issues that have been retired by distros - K=
ernel Team
  5. Decide the timing to branch 5.10 to start CIP development - Kernel Tea=
m

Have a wonderful holiday season!
--
M. Kudo

--o8kUUytwixP9coGJpESK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#5974): https://lists.cip-project.org/g/cip-dev/message=
/5974
Mute This Topic: https://lists.cip-project.org/mt/79193076/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--o8kUUytwixP9coGJpESK--
