Return-Path: <SRS0=G3bi=G6=lists.cip-project.org=bounce+64572+6145+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB20C433E0
	for <cip-dev@archiver.kernel.org>; Wed, 27 Jan 2021 23:45:33 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F05DB64D99
	for <cip-dev@archiver.kernel.org>; Wed, 27 Jan 2021 23:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F05DB64D99
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cybertrust.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6145+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id G2LNYY4521723xhc0oReNfTe; Wed, 27 Jan 2021 15:45:32 -0800
X-Received: from JPN01-TY1-obe.outbound.protection.outlook.com (JPN01-TY1-obe.outbound.protection.outlook.com [40.107.140.118])
 by mx.groups.io with SMTP id smtpd.web09.17239.1611791131007315411
 for <cip-dev@lists.cip-project.org>;
 Wed, 27 Jan 2021 15:45:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4XxGwp7eutRBh0+6uGCd3Bg76ixFYUnCqkHyYBy7L4rNNIs+usBdKVdaatrMG+SiniNJZ4PvMgvm7pqufOFkni6AdQ09TbRPsMFj0KC8VEIs9yH6zT6M5fUcm2lzhL+zNiGmCQqcddSVnM6jMi3AR+vmoonBgCZlEGFFJ7zzbevpYsaZtD/WDV0G5aEX2dEP89tVuWQIbmEZUXx6hK+OSB8GIzLpA7O2Ktob2FS0IVsRmOTA+4MJ5drb+TMhgBwL9amWvQWX5ErLkIptriqdARbLiNszHBBDx56JPjBpeMGhXWAJ5MPVjugr/klHREmUH0ukddPoTHTXMmxInWMwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYaKlBApdw6TKa1Y41NMIliSwnUqAN1SAlTk25+XXf4=;
 b=ZkMfxfRW6AUMBnEpX6XQrh61hkPAEkPDsSpLXAJY7sPa2kTNPpEmQLKjXX2CkvCNBLeWE97xUvGlOlcYuhEdZly+YhoDG17zZsGlUrSEc7qojJCPPKCTe37FqnFgSkbJ+IqXZruWgmUtrOy8ndCUD4+ohF+eZ6DobChFRVuIfZVgNPeRtqlG8NVyNR7pU2h9coj0UCXq26c3AxN3is2JXY25yvqfZ9TczU/oxgmawWNlcdyBRDr6UJHsHx/42MgGW2nUKJF7eLOoitQ+mGN8pJsZ+B8ucfpuk81TOeVpU3Ic+Gwjcxp7oiEfTy9S9daqeJ+gPrn2h+oqVigkzJn5wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cybertrust.co.jp; dmarc=pass action=none
 header.from=cybertrust.co.jp; dkim=pass header.d=cybertrust.co.jp; arc=none
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com (2603:1096:404:11c::20)
 by TYAPR01MB5183.jpnprd01.prod.outlook.com (2603:1096:404:128::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Wed, 27 Jan
 2021 23:45:12 +0000
X-Received: from TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325]) by TY2PR01MB4972.jpnprd01.prod.outlook.com
 ([fe80::fc16:7286:28cc:8325%7]) with mapi id 15.20.3784.017; Wed, 27 Jan 2021
 23:45:12 +0000
From: "masashi.kudo@cybertrust.co.jp" <masashi.kudo@cybertrust.co.jp>
To: <cip-dev@lists.cip-project.org>
Subject: [cip-dev] CIP IRC weekly meeting today
Thread-Topic: CIP IRC weekly meeting today
Thread-Index: Adb1BnPu7KD+DnInTbmi/gfLB9W53w==
Date: Wed, 27 Jan 2021 23:45:12 +0000
Message-ID: 
 <TY2PR01MB4972925DCAF8AC749A40A3B2A0BB9@TY2PR01MB4972.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [122.216.27.145]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 84b0c6af-e324-425d-30fe-08d8c31d96a4
x-ms-traffictypediagnostic: TYAPR01MB5183:
x-microsoft-antispam-prvs: 
 <TYAPR01MB5183DFA3D6B8C9FDD4CDFBBEA0BB9@TYAPR01MB5183.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 
 oQKwTM95J0QTXbwTCjppUstmpRJqte2MNI4TWF6i3chAmbtQTN7pEPKfn3GhAsGQXZWMPexHGWkrpTJqNPKNr7Jz6Sk717Qi0Dec0AfDqQxwxyHUX0FkIGjsyC0bEq9m33DmH//HfA+ZsNyJg+0MmTfrH/ULVFDy1wKIdVWtwp38x+Fznc0CX/zXpcftLf9GH/PmHSUbpgMEsDHQ3qFOaZpdP9e70svw4+8IOBLNdU6BclHLR2sl9Gb8ozhGkIDXp1IdyqiGqV8wpLFE1ZptCtnsY7bM10C1gCEzOrxxZEsHMm9kul4xbwCQSdWq/s/mZfNvf7QrAb0r8WqFmf9OEcc8/CnxuaFI+eyWtxsQ7LbZDI/l09dnxBTzUdwcksUytqprhVdOEuqFeRpJnUa9WrDUBYOHh78crIrSaaj2rmvFfNoypgN6387tJymbTDAYEjL28cEAgEXOmWVy0nC3Yw==
x-ms-exchange-antispam-messagedata: 
 =?iso-2022-jp?B?SHF2UWFTblZNNHY5Yk5zY0d0VUJ0ZUdWVmlsZDZTYVM0OGttNE1GMjJU?=
 =?iso-2022-jp?B?TUM0K3YrTTIvbVNlNkJCL2ZYalB4QXcvNE9LK0daV0pzNkdxdUk3VUR3?=
 =?iso-2022-jp?B?RXRMajE1bm43MTRoUE1BZHR2dWdGeVVFbS9XRzluVDJTeW1KbmpKczR0?=
 =?iso-2022-jp?B?cW55bUhIN0ZJVFR5QXJZOHF0Y3Q4VW5oTHBBZ0dkcldoalpIZWtZZ2dq?=
 =?iso-2022-jp?B?eElxQXRVa0Q2VEllNnlMbG1PeEl3Zi9BVk40MmVXWmdLL3F1QWJ6eXFN?=
 =?iso-2022-jp?B?a1FpdDZzT2FsQmVkTGRRNGhVc1BiT3lQRHh3RHFTSDVodlRJdmpTMmlp?=
 =?iso-2022-jp?B?cWZ3OWQyVkxnYzcvSUdIeU9LTGwrVGdYa0M0aEExREV3dmtjQ2Z2dzdq?=
 =?iso-2022-jp?B?OGZVK3JneEQ4NzRtNzNkY0pJQnViY25UT2hTT3BpZUlYR3F1c2ZXTVND?=
 =?iso-2022-jp?B?MkU0aGx4QmRBS2UrWndIU3RyeFhSVDVXZFplMkt5cGM4UEFHMkhzc0FV?=
 =?iso-2022-jp?B?cFNiOGIxQWNjVnp1aDZHOXp1Y2xFQjhJM3Bsb0VRQnZxM21mdVdaQ204?=
 =?iso-2022-jp?B?TU5EWXpjeUk3bTFVS3Z0cXl4c2hzd1FtVWp6akp1N1lnWldkYWJidXVx?=
 =?iso-2022-jp?B?Uy9BYzArUU0zeFVVYjZDMTZGdVVVb0Q5UGFPV3VvWlVLdnNUMEpHSHk0?=
 =?iso-2022-jp?B?c2tnNmJ2YlVuK3l2VUs1MS9PSWk0ajFZeGRVZFYwb0ZWY1ZuVjhiZ2JE?=
 =?iso-2022-jp?B?azhkczZOdy9lQW5ZOWRIbmc3bWR5Y0FLMGU3blIwdllNZTRjM2JIbkg4?=
 =?iso-2022-jp?B?bnFVVkQ0VFpkY00vU3dBOXFnalh0ZUs3eTZWYldYbTM5VHVoN1JVUy9q?=
 =?iso-2022-jp?B?N3R4UEVkRGNrL3lmZmg1a3g5NVFLa0w2dWlhRHRYSlY2ZlZDbkkzRjdv?=
 =?iso-2022-jp?B?U1R0TUtJN2N4U0pvVTF5Y2FsS2ovUVNtZEFYeGVwbDJEYXg0Vm5Nbkpm?=
 =?iso-2022-jp?B?NGxDTkxlMVpqaDFlNjlPUkp4MlhsT3lxSUlXcVZ5ZGFWVnNqMG43dEFp?=
 =?iso-2022-jp?B?VUZwZ29vV3l1WlJXV0w3OXN0UzNjb1lFdkM0dTVUdTYySEpJdDB5Z01X?=
 =?iso-2022-jp?B?N25HQjNwMXkranYxajVKcGRWMEllM2NLZXJsL1ExOUkzMStPYXFkZGNN?=
 =?iso-2022-jp?B?bzJsdnUxWDJ2VHRySzRtbVRlTnUzUXJ2ZFlneUtvL3UxSXJHa1NQd3RP?=
 =?iso-2022-jp?B?VHZocDc3RkE3dEsydW8rdWIrZ1pxdzhDWklMcTdhMkJJSllsVDZOYlVG?=
 =?iso-2022-jp?B?aEJzUnQyMHg4bVF5SU1oTVNRbW1hbUFIL1ljY1hiYVE4VU5VRlhGQUlM?=
 =?iso-2022-jp?B?RW8wK2NCenlZVkFSWjNFT1hPTVhNM2ovQitrdVA3YnBvSHp3ZkV2dnRi?=
 =?iso-2022-jp?B?V2hIUS9SRFpZdkM1SVRwNm9TakZsY1ZNMXFrcGowOXYwby9QVS95bU9v?=
 =?iso-2022-jp?B?OVl2S0hxbTZnV1VLa1cwTWo5Ty9KRzJZd25nVVVuK25aeTFIUGQ=?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: cybertrust.co.jp
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4972.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b0c6af-e324-425d-30fe-08d8c31d96a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 23:45:12.0736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72cc4624-32b4-4dab-b80a-8563e559bd82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OrLj+Y1sD/Np0B5+1RzTRDSk8xqfpyaGgtSrzkXZEg5Jp8xSa4QBhceKlzmV/hxZ2k9am5b7ibxs0pXoSJ/DZfEVME6a2x841cVYj/nmJv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5183
Precedence: Bulk
List-Unsubscribe: <https://lists.cip-project.org/g/cip-dev/unsub>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: sk3GHhBWcJP4Av1D37d6zdaHx4520388AA=
Content-Type: multipart/mixed; boundary="phYmC7pxGO1kWxXhKFBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1611791132;
 bh=GKKjb9kAmjDYTkRz4BRsYTVDsPwXIVRi4ueeUB7xoak=;
 h=Content-Type:Date:From:Reply-To:Subject:To;
 b=i7EK08e0z3bwj5z8wn6auAdscmtxphwNRxt079h+tZcWUXgPpcS7ZkgqKJ7SagzbmlO
 uVRcRhC9sYkwrTQYmOYgPeIQQzb9+L1U2YVsd8m/Y29T2PgVxaSFnZHXPQJxdCVFFsdtj
 EeDUQ6PElCtPNyC4eLGIMuRaaAmhWZqX+io=

--phYmC7pxGO1kWxXhKFBn
Content-Language: ja-JP
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable

Hi all,

Kindly be reminded to attend the weekly meeting through IRC to discuss tech=
nical topics with CIP kernel today.

*Please note that the IRC meeting was rescheduled to UTC (GMT) 09:00 starti=
ng from the first week of Apr. according to TSC meeting*
https://www.timeanddate.com/worldclock/meetingdetails.html?year=3D2021&mont=
h=3D1&day=3D28&hour=3D9&min=3D0&sec=3D0&p1=3D224&p2=3D179&p3=3D136&p4=3D37&=
p5=3D241&p6=3D248

USWest	USEast	UK	DE	TW	JP
01:00	04:00	9:00	10:00	17:00	18:00

Channel:
* irc:chat.freenode.net:6667/cip

Last meeting minutes:
https://irclogs.baserock.org/meetings/cip/2021/01/cip.2021-01-21-09.00.log.=
html

* Action item
  1. Combine root filesystem with kselftest binary - iwamatsu=20
  2. Do some experiment to lower burdens on CI - patersonc
  3. Check hitachi_omap defconfigs wrt CVE-2020-27820 [drm/nouveau UAF] - H=
itachi-team

* Kernel maintenance updates
* Kernel testing
* CIP Security=20
* AOB

The meeting will take 30 min, although it can be extended to an hour if it =
makes sense and those involved in the topics can stay. Otherwise, the topic=
 will be taken offline or in the next meeting.

Best regards,
--
M. Kudo
Cybertrust Japan Co., Ltd.


--phYmC7pxGO1kWxXhKFBn
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6145): https://lists.cip-project.org/g/cip-dev/message=
/6145
Mute This Topic: https://lists.cip-project.org/mt/80172073/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/7279483=
98/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--phYmC7pxGO1kWxXhKFBn--
