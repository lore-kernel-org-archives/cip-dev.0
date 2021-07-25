Return-Path: <SRS0=cxAl=MR=lists.cip-project.org=bounce+64572+6628+4520388+10495289@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E62C4338F
	for <cip-dev@archiver.kernel.org>; Sun, 25 Jul 2021 11:27:12 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E2EE608FE
	for <cip-dev@archiver.kernel.org>; Sun, 25 Jul 2021 11:27:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E2EE608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id cUzVYY4521723xS262CbfITR; Sun, 25 Jul 2021 04:27:11 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.157])
 by mx.groups.io with SMTP id smtpd.web12.16592.1627212428325244501
 for <cip-dev@lists.cip-project.org>;
 Sun, 25 Jul 2021 04:27:10 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 16PBQrR8026632; Sun, 25 Jul 2021 20:26:53 +0900
X-Iguazu-Qid: 2wHHmJkRoH1LoCEXRY
X-Iguazu-QSIG: v=2; s=0; t=1627212413; q=2wHHmJkRoH1LoCEXRY; m=+EwO3QAoTVn0ajLLNYXyvZIQ+WjPE8wupnvSxwbxDS0=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1111) id 16PBQqIJ026898
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Sun, 25 Jul 2021 20:26:52 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id 15F5C1000CC;
	Sun, 25 Jul 2021 20:26:52 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 16PBQpt2008152;
	Sun, 25 Jul 2021 20:26:51 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SXwQRVqH9YKWCsJznv//IbuC5U1IFXiw15oZrVCZ6Lth5rwG0iZuT5YGL6Dd+L5AM0GHhzG1bG5QdiUqgTj2Vxt5mGBuFMaWT2y+e2WsXqx7Jm3A6fPCHuQEJ0PL1MSV7DfkuLONhevkhuhibnvcQ6zPO4imzWGb053IOMw+lJsLiqX48p/zQ7Ro2U8MqVGnSModEafnw7iswsKBXRMqNfxhVxWPzW7K+cDL/10xl9tbpQhkbbRN6oxQ3rECgxoTmTjBeC0AHRfhZBPU7LjMlgKsqjq18L+I4uWumTXiwrbSBYZ7Jmkj2kUwwmCj4SVMljOEp0zV49WLLtUg66rwcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxjQlaJgeDPC7SFR904hbd/p1S7pFKw+96Q2pVmU6MI=;
 b=bI6MvWQLcbwCLwlaEAOFs27Hpb9TjCw27NlYM9RXSkH1u/7YbSJJJUDmbHu5RogHPWc/wDcjmGoibc0fzXWIN75QVZ0QSWedP7qkyICzyZqzYDYFfjIrQYfHoyOi/+9HJRBHVMUnj0Bs3vloEtzEs30FZPqdrZz+uR1BMoP2+wP8s3v497sDjYGRaYr/gUmLgr135zke7vhAuwEY5twj4l/9TtZmoAZOCdmHOHQ/b79JGz5EvNxr1ylscX5P5m9nCzVlSWniAhGQ//ZHuXwfm0h+hRf9De0lX0aP67PPb1QJqxsoVk+VRXEwy+7ImF8QX8WwFRa70U7w9KyXJXomAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <masami.ichikawa@cybertrust.co.jp>, <masashi.kudo@cybertrust.co.jp>,
        <pavel@denx.de>, <Chris.Paterson2@renesas.com>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.198-cip54
Thread-Topic: [ANNOUNCE] Release v4.19.198-cip54
Thread-Index: AdeBR77ncmcYuabETyK4F9obXYMvpg==
Date: Sun, 25 Jul 2021 11:26:49 +0000
X-TSB-HOP: ON
Message-ID: <TYAPR01MB6252489B9771DACF7221DD6492E79@TYAPR01MB6252.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a66afe99-7527-41c6-cd6a-08d94f5f182c
x-ms-traffictypediagnostic: TYAPR01MB3311:
x-microsoft-antispam-prvs: <TYAPR01MB3311CF673600C24808B5F5AA92E79@TYAPR01MB3311.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:393;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam-message-info: UowSkdk/IKyCijAcSW943BuUoA7+5Kpi+tsrqWIPB4s/DckYR68ck/9UNn+haIlla36DxBO2B2nh0L86mV7ZURLwA4ekYG02XaMDg4DmZEyOVZMBiCJ7Eo3pxk0uLARQDnjm/+PgjBHDTv8duPlTxGK2FTEREqfEAvToRQtsI2esgZqZvfA6MOlWemryJT52Ub4SjVnkxqAR5eizI1wX30LEj/I82+w3Ui2PfuIc0kzReur80qsRXNp8/srC/75hTlQN4lhA100KeIDRk2mHxR4J1UopbTr77kE6Nv8uZXIF/TLwqXaR+p/CR8+JpOZV2Kq9T0MOteXHuHmSPzf20rUgJX4MIgiQy/15WnXVz5verYWrGc1XMPvoe9+qF4RSwkfBNdbghJD4w+t2Bq2X1U4z7jsOgLn9vrehGfgkxenjjGzazGZn+oKEakppMUIIQ+UT7Yk2b1OEfGT3EsIxIktcaVQdBaO63H1YiPjZ6Y5M5fWsY3Fa+WFLAzD2oQHpvZL71OzBSonmHjgH6plAWrHmTQv+RRmh9by7KjDFJi0SLsW7ukPhpRbvjh5F0ii5td7fc3vQr52BCeqc5TxkmoBpdyPPFlGRlm88OFx9LCZOcCvw8BA6wOgb3oSFATGBKQFNLdC+nCLz4KRoKSz2tfwRe3HxEXyuwbH3JXs3ZTIc1JoLQTztRXwWVNUOWoeeqA5+ukppvAEDecjdCZXFm05GXg1IlctM8Gex1Wng8dA/dA26W4505oMORYdBbctDlmDD7RCnbz/9Ns7kopvba+Fv8q4ztBGgu52sQ0jwtVg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cDVwMlRqaENkWmxObzYrN0Y2Tzd1U1RvSi9UcWZwMmtFdDJ5M0ErRkxaZ29E?=
 =?utf-8?B?SkcxYTVuWm11RUVqZDhNbzUwRXlhOG5lSHpKOGJzWjhmMVNlaWZyOUk1UGRU?=
 =?utf-8?B?a3RCYm5GcVRJejNEeXM3WVJhNGdUUjI0RVBITTBrVVpsUDE2M29lTmZVQ1l0?=
 =?utf-8?B?dDhXK0JYRWxuSHk0UEplenRmeHkrZ3IyOWwrVU9RbEpxNzgxcHVZQnBZQzJE?=
 =?utf-8?B?ellCV0g5emxQd2hXRFNVckY3Yy9neWRqZFowVEdxNDM1VWhic2FMUjd4QWJY?=
 =?utf-8?B?aXZPTTdObXVyblRWbjZ3U2RHWGpreXkrMm9naVQzeGllRVNya21PSjN4aEZv?=
 =?utf-8?B?VzhzYmVoRnVlN3FTSlc5cDYxd2pqK0FRc3o4eXU2MWtiU3psZTVpaWQ0L1hj?=
 =?utf-8?B?Um9YU2NvV1praS9SNzNmRWEvbXB3WUs1Y1dzd3lqOFZ5WndtUmhIV0FGSUJj?=
 =?utf-8?B?S2J4TnYzTHV2dkVQKyt2c3FNd3RRUWhONWVzTDd2bEpFdTZPZUJ5anRhUkxQ?=
 =?utf-8?B?blVnVk4yK3liM0FqQmZkK3RuTi9EYW1KMTdIaHMwWjI0NzFUcUhGZXUxaVZi?=
 =?utf-8?B?K1ZEQmNENzBlZTZyb3g3cVM2RGttV3hpdTVzQnQ2ckxkZ01Vem5DWURXUVR2?=
 =?utf-8?B?TE5LUmtTeGt4a0crUmVJK1JTVDBqb0lReWxXTkJHTlIyekQ3SWhoVzdjK3NP?=
 =?utf-8?B?TFY4VDNyTkFJUDJIa0tLdUIrQVJTUVN0UkkxRG9veHNWc3ltYUx2RFZ0eFpX?=
 =?utf-8?B?UXVVR05Ic2JmRlN6dGVtUC9HUENkQVUrSEUvbzNReWo1NFBMck8vd0hoVHBX?=
 =?utf-8?B?U25lc3FzbFVUemVscHBFd1hJU0dXVkltWndTUzNXd3RYclY1QWNnUlh1bzha?=
 =?utf-8?B?eDllckU4dWNTL2FjbFhXMDJ4VzBCLzM3OG5UWEtSWVNxQ3RKUmltWTdhT3dr?=
 =?utf-8?B?VlV1UnJHVEVHTU41QzZJTFhqS3BlbnQ4OU5UdW9yUEU0MXFZM0xoMVpONDZF?=
 =?utf-8?B?RUYyaS82SzdJL1lILzk3Tmw2Rld6OVgzZFJaTGZxQjd6U1B5ZWprd1dCU2xU?=
 =?utf-8?B?VHNZRmY2a2xQNFJXeEFGdG5Ia2ZNOUlrdERHNFBkUUo5Yy9uTEV6enBuYTZr?=
 =?utf-8?B?QXlOb2FURTBmTUM4LzF5cXN3dDhYRFV0R3FKVWFoTTBQRUF3eGZTdkZmejdz?=
 =?utf-8?B?UEZUOGZiNjlGd3c2TFVkT1FnMzZPM3lVOTU3SGlLSGVxZTRlZXBIK2dOY3hF?=
 =?utf-8?B?TDc5dlhrRk5MZENPNFlSaHJJSk5JUmlnMllQSEFVZStxRzRmRFFJVlpVSkVG?=
 =?utf-8?B?YnJJejFRZnZ6Wm9waVArOEQrRE1RODh0clFFVHRUTkNLWEtHYVdOTHk1VzJL?=
 =?utf-8?B?K01vSlQ1WURrNTl6VlVGNFNmdld1Skh1dGluQjVGTEYyMjF3UXlid0YrMHl3?=
 =?utf-8?B?RUhFWGRPNXRxdkhUcVFFUHZzUG9zK1QxdXo1YnVyK2g4aEUrQVl3MkpTNytV?=
 =?utf-8?B?dnRzQnErTjI3MnNMSUd0VjNCOVhxVVVlV0hhZGRENE8wTko0NE1DZUFLT0FJ?=
 =?utf-8?B?ZEo3QmNMOFBHdHYxdmpxM0cwMXpiVTN5NzBHKzJoYW0zRlhFdW5qME5GVkY3?=
 =?utf-8?B?UW5nY000YVUxdXM2anp0OHhWRTlyWEhvSEpjejNOSkFnRVNManY2SDJGb3Bn?=
 =?utf-8?B?bTFhMCsrSjNrd0tyV0p3azI0Nm4vSEpUK0xKMitiZVNhb2hpUFp1cmRwQ09s?=
 =?utf-8?Q?CXeUQXB6bhAYqI/HYk=3D?=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6252.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a66afe99-7527-41c6-cd6a-08d94f5f182c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2021 11:26:49.4468
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sOcAnVA1myjlvmVG1TmoSblyKnIIWD3PCzaKatdfvWuspMaR4pnk3GBZtO7I/BNpVl0vENc1KMN4YMZwpnRbAy/riWlAv4MiUxuqkYZlKKrKjvsLJRCi45Igsfp3nuqG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3311
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
X-Gm-Message-State: C2zxXlAwnxCUBzaHCaoOtwnDx4520388AA=
Content-Type: multipart/mixed; boundary="6vbvYoRBCFlqUzAI4vfw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1627212431;
 bh=utqFP3ZVzLWElRRL5Y+JjDYkUP5PcqEvOGxQC3YjrDg=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=X5DS4RM9bDLk5zI6LMUaZtBTvxuaijQPBlZFeJq7iRXY17CVJyRcA+wlXZ2RXIficWR
 z8YDDmzOMhahKh5y9VntX+9MP+sBXnJLcZL40oKsyACMt/PuEITL9O+KPX6oxDyKd2BDB
 7jqHV6PJ3jJjRzgGBXFLmNkXZ0P3pOnknaQ=

--6vbvYoRBCFlqUzAI4vfw
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGksDQoNCkNJUCBrZXJuZWwgdGVhbSBoYXMgcmVsZWFzZWQgTGludXgga2VybmVsIHY0LjE5LjE5
OC1jaXA1NC4NClRoZSBsaW51eC00LjE5LnktY2lwIHRyZWUgaGFzIGJlZW4gdXBkYXRlZCBiYXNl
IHZlcnNpb24gZnJvbSB2NC4xOS4xOTYNCnRvIHY0LjE5LjE5OC4NCk5vIENJUC1zcGVjaWZpYyBw
YXRjaGVzIGhhdmUgYmVlbiBhZGRlZCB0byB0aGlzIHZlcnNpb24uDQoNCllvdSBjYW4gZ2V0IHRo
aXMgcmVsZWFzZSB2aWEgdGhlIGdpdCB0cmVlIGF0Og0KDQogIHY0LjE5LjE5OC1jaXA1NDoNCiAg
ICByZXBvc2l0b3J5Og0KICAgICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvY2lwL2xpbnV4LWNpcC5naXQNCiAgICBicmFuY2g6DQogICAgICBsaW51eC00
LjE5LnktY2lwDQogICAgY29tbWl0IGhhc2g6DQogICAgICAxYzU2MDQxYzExYThlZmNkMTM3NDU4
ODUyNWMwOTZiODljMjFjZTQyDQogICAgYWRkZWQgY29tbWl0czoNCiAgICAgIENJUDogQnVtcCB2
ZXJzaW9uIHN1ZmZpeCB0byAtY2lwNTQgYWZ0ZXIgbWVyZ2UgZnJvbSBzdGFibGUNCg0KQmVzdCBy
ZWdhcmRzLA0KICBOb2J1aGlybw0KDQotLSANCk5vYnVoaXJvIEl3YW1hdHN1DQo=


--6vbvYoRBCFlqUzAI4vfw
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6628): https://lists.cip-project.org/g/cip-dev/message=
/6628
Mute This Topic: https://lists.cip-project.org/mt/84435989/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/10495289/452038=
8/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--6vbvYoRBCFlqUzAI4vfw--
