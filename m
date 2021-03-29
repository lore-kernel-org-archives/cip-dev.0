Return-Path: <SRS0=+iet=I3=lists.cip-project.org=bounce+64572+6332+4520388+8129055@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329BEC433C1
	for <cip-dev@archiver.kernel.org>; Mon, 29 Mar 2021 01:00:39 +0000 (UTC)
Received: from mail02.groups.io (mail02.groups.io [66.175.222.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F10461930
	for <cip-dev@archiver.kernel.org>; Mon, 29 Mar 2021 01:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F10461930
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=bounce+64572+6332+4520388+8129055@lists.cip-project.org
X-Received: by 127.0.0.2 with SMTP id NxRFYY4521723xhdr2jeueX3; Sun, 28 Mar 2021 18:00:38 -0700
X-Received: from mo-csw.securemx.jp (mo-csw.securemx.jp [210.130.202.153])
 by mx.groups.io with SMTP id smtpd.web12.15616.1616979635723921435
 for <cip-dev@lists.cip-project.org>;
 Sun, 28 Mar 2021 18:00:37 -0700
X-Received: by mo-csw.securemx.jp (mx-mo-csw1514) id 12T106Xf025031; Mon, 29 Mar 2021 10:00:06 +0900
X-Iguazu-Qid: 34tMbaYFCEfa4IHQ09
X-Iguazu-QSIG: v=2; s=0; t=1616979606; q=34tMbaYFCEfa4IHQ09; m=Q49S7HAXtIiyaGzSpttFqTGmiirjXtVsYnWgDCxRJwA=
X-Received: from imx12-a.toshiba.co.jp (imx12-a.toshiba.co.jp [61.202.160.135])
	by relay.securemx.jp (mx-mr1510) id 12T103CR007659
	(version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 29 Mar 2021 10:00:04 +0900
X-Received: from enc02.toshiba.co.jp (enc02.toshiba.co.jp [61.202.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by imx12-a.toshiba.co.jp (Postfix) with ESMTPS id E802E10008D;
	Mon, 29 Mar 2021 10:00:03 +0900 (JST)
X-Received: from hop101.toshiba.co.jp ([133.199.85.107])
	by enc02.toshiba.co.jp  with ESMTP id 12T103Z1008507;
	Mon, 29 Mar 2021 10:00:03 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtBt0ha5tXZoteYnyKxZRL3JpXN84XSOgZEWOSCgT/FcNownbxnp4Wkpi7eicTnb50MZ/M+fJ+TUWPAYIipyjeXrKRjsQhEUug94Pm0k6BdrvKviJ0oXgafdxfMvdmL59C08GUHL8MluuexGeduOU4T5vMwcBmTN1yAz1y0RB7SXRzzSVOcJqyjDHS11vxlg5N6Qib+kNVJdDaNG1wLHvzYOZAGiZ03/GRDOaHE/i7evNHe9iAwou3w9RXccZ9hGK6Ch/QGUMoJMyJA+zuR8DVscAci4/GOBTGZ2uh86+rhtHx8bmn8GhCx/PVDDWM33Fc4D/FYu9MCyHviCWiXgnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UDQGr4qXhC9mfHLkgt/QYzklxcSnqURorYWtTGKaOGI=;
 b=Je7Hq6BWH+9jrihaohjLqH6jrp5iHqW2M6jyBjl04wIN8TBSiD65Iqo9HIpEdmqWyu3a5K7OfpHMqsZEOcR+6w7AOKmLzETi3JTrQv4dMumo28SoZoLMwozoa9MKbq9dWwJZOGJBTcBGSz6qtU01RJYIAp4tAllE5DiQmTQAdXXdy38fltBH3qCcTSN1s0Z8hRy1hrcCbhCUiHbIuDVSxLOlo4xPzxkKYUck7XN1Q4B0GMOSxyc6ybbJRCnAl/yoTa/V/CTZu3p02yXG9PqOdT+L0uXvcHwgulxYeNSz0ciEKjHkQRSUTRgzDiOR7KpNv67Ewvf4f9b7e/lMdhh1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toshiba.co.jp; dmarc=pass action=none
 header.from=toshiba.co.jp; dkim=pass header.d=toshiba.co.jp; arc=none
From: "Nobuhiro Iwamatsu" <nobuhiro1.iwamatsu@toshiba.co.jp>
To: <cip-dev@lists.cip-project.org>
CC: <pavel@denx.de>, <masashi.kudo@cybertrust.co.jp>, <wens@csie.org>,
        <Chris.Paterson2@renesas.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <biju.das.jz@bp.renesas.com>, <sudip.mukherjee@codethink.co.uk>
Subject: [cip-dev] [ANNOUNCE] Release v4.19.183-cip46
Thread-Topic: [ANNOUNCE] Release v4.19.183-cip46
Thread-Index: AdckNpZoQcX7Vm0VRRu1WweNqmTvcw==
Date: Mon, 29 Mar 2021 00:59:59 +0000
X-TSB-HOP: ON
Message-ID: <OSBPR01MB2983AEF66B7AB9DDA842DF3E927E9@OSBPR01MB2983.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
x-originating-ip: [103.91.184.0]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a9b435ef-6c13-4750-fb41-08d8f24dfa54
x-ms-traffictypediagnostic: OSYPR01MB5301:
x-microsoft-antispam-prvs: <OSYPR01MB530198D2CA19D89EA668164F927E9@OSYPR01MB5301.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: vLmy/5pCBQ/KDfUbC1QQBAuTCkYElrpgt/mj9rlsg07pV2tnWGovRyXYksX4ZkH71q7j+dJYa3qEQgoBPjRGtN6ANzcjhNhTwYaZEuqJA57/BJx5U2vCOWvseyCqbhFgEV121F7+fxbbKJ56w+P4t3Ye+b3XtqP1NUzW4rXYQajKxYqdpDI6Ghp6+VaK+HNoA26Wm5ubgipCMKd4GvnjGHK5Fkv/LE2EcyPEciT/9oy547g4jC6rCwOIn4s5rirgru9mt0wfLkUsbDmXTUdy1ycxeOd2j2jcmCgeO9fTngYKb0MirkQMZewo0h2aw9si9pNX7DlozemxhnY8oaeVibssuXs+D5YMyvGBSqVfDM5PHDHP4CUpH6cSTYmH9D/OWRKuibD+X7Wg6NcKB3wKIvDCICVIzOO8+hduDpqGZbN+ldHrydI8QGP9CkKBmSiO2mniTaw8AqVL55etG7uOJKOoB+cIWTMCi2BaVyTVhTzBPUjeBePv5AnSf5MH+uw7b8VBWkUmCF1ag+dnylAS3Cry/SVZb4qzIb7wDzsSx5jEq2opWvv+Im7KQzhfhHWSDpb1accZl2w4VmM4V4t4iTBTgK5R0s6xjhal1AITOHFxUiYdubRHtCZdgdB/Q9/6OhaXuM3KCSR/wJEN3/dQDg==
x-ms-exchange-antispam-messagedata: dcy9vvyG+rXkTqtPH4u4yjfcA5jw69i/JAuxtBTfAb+yT3+bEjxY5Rfe8o/cpt/5sJcQpDZzy9akT38TrEPEWoE9tyrtmoHRdDrW0KyQcoYtc89ew09ZJ9rjvlBl/mp/k1VpaS1OYYiNi/tCu3mzp0kvwFpgveGy+j6FBsrufqeIhbQjeXOT4fRhGl4cMclxJWxKIANViU2jqGfRe7d7wmAbA7s9Oj0NEvcAu7aWsthqWLzZ6tRnH8q0TSNomosyDFtmkLvCubnIQ1+1SrcWVBimo3152F+gUOPC28rQe1Li0dD1w8qXcK3z+jqjb0Me8ITv6udiX0u5GYw/627h5AJGtz9lUUuDAyUSaM45VRjj7VG4zvUEO62Owl4pDSleO4KfaJ4IQCO3xcP44drUcznfx4m6skrDmtJMBBjeNrktfHO0ZrNKmzLj7rNHIAb8z9DT3pcazxThOMKMtSytABxCEnv2ZpPT/ykTdvICVMxexivhkmiMwJSUUK1aAoZybASiHoPGI4Nbp0d4YEtAtb716ChPBC73rarXZ+UYOXOMMsOCkFR1wYzNKGDvN7+Xn2toSvy0wtRyU7AffSZVbs6E2+Z6qESkJzf7zJC/60snE+y+D1A5bMUj04RWeLEG0SKyJPAnDGdpK3xbhzK+x/QtVff3Of2gCjQGNNY39bGGKLaAwByjTdhjBFtIi127USe8/2dlubEUu9IV/Nd87A==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2983.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b435ef-6c13-4750-fb41-08d8f24dfa54
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2021 00:59:59.8792
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f109924e-fb71-4ba0-b2cc-65dcdf6fbe4f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MwqtTMCR1Hyxs0nq1/642fO31MjtNgLk5cIyfeh7a4UEqYUwaWoILEDR2GH6/8gt3jhDlPVewvisVOsfuGxQoMLNd7z+dsVLL0M2HwtoHZw0IM8+qTwEzqTH9tIawczI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSYPR01MB5301
MSSCP.TransferMailToMossAgent: 103
X-OriginatorOrg: toshiba.co.jp
Precedence: Bulk
List-Unsubscribe: <mailto:cip-dev+unsubscribe@lists.cip-project.org>
List-Subscribe: <mailto:cip-dev+subscribe@lists.cip-project.org>
List-Help: <mailto:cip-dev+help@lists.cip-project.org>
Sender: cip-dev@lists.cip-project.org
List-Id: <cip-dev.lists.cip-project.org>
Mailing-List: list cip-dev@lists.cip-project.org; contact cip-dev+owner@lists.cip-project.org
Reply-To: cip-dev@lists.cip-project.org
X-Gm-Message-State: x6zcNxH3cPq7DdqWmMn4ZQeix4520388AA=
Content-Type: multipart/mixed; boundary="LHRklJE64a4jziBpQLrU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=lists.cip-project.org; q=dns/txt; s=20140610; t=1616979638;
 bh=I5YjL41gQKLG34LjL6ehr508eehU+q69wciyHncc3d0=;
 h=CC:Content-Type:Date:From:Reply-To:Subject:To;
 b=FNIKI/CoGRnfWvbzDrJTGSuuBvWA2chXCXgP2Ucq6kftFojQl62CZnuzAE64VZCPS5A
 IqNEJgvE4jT2VfHm3ZXps9pOWEzKcgfo93LqZmKny+KGh/AAkkb0yEznL+MZTkUvaizOj
 dQl+QsjHdpO6jydfOZehj/7LexPnOU+CxTE=

--LHRklJE64a4jziBpQLrU
Content-Language: ja-JP
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpDSVAga2VybmVsIHRlYW0gaGFzIHJlbGVhc2VkIExpbnV4IGtlcm5lbCB2NC4x
OS4xODMtY2lwNDYuDQpUaGlzIGtlcm5lbCBiYXNlIHZlcnNpb24gaGFzIGJlZW4gdXBkYXRlZCBm
cm9tIHY0LjE5LjE4MiB0byB2NC4xOS4xODMuDQpBbmQgdGhpcyByZWxlYXNlIGhhcyBhZGRlZCBz
dXBwb3J0IFZJTiwgQ1NJLTIgYW5kIE1JUEkgZm9yIFJaL0cyLg0KDQpZb3UgY2FuIGdldCB0aGlz
IHJlbGVhc2UgdmlhIHRoZSBnaXQgdHJlZSBhdDoNCg0KICB2NC4xOS4xODMtY2lwNDY6DQogICAg
cmVwb3NpdG9yeToNCiAgICAgIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L2NpcC9saW51eC1jaXAuZ2l0DQogICAgYnJhbmNoOg0KICAgICAgbGludXgtNC4x
OS55LWNpcA0KICAgIGNvbW1pdCBoYXNoOg0KICAgICAgOTcwMWViYzE1NGE4MGQ4NzUyYjNmYTRh
ODFhMTliNDY3MTY4MjAzYQ0KICAgIGFkZGVkIGNvbW1pdHM6DQogICAgICBDSVA6IEJ1bXAgdmVy
c2lvbiBzdWZmaXggdG8gLWNpcDQ2IGFmdGVyIG1lcmdlIGZyb20gc3RhYmxlDQogICAgICBhcm02
NDogZHRzOiByZW5lc2FzOiBBZGQgc3VwcG9ydCBmb3IgTUlQSSBBZGFwdGVyIFYyLjEgY29ubmVj
dGVkIHRvIEhpSG9wZSBSWi9HMk4NCiAgICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IEFkZCBzdXBw
b3J0IGZvciBNSVBJIEFkYXB0ZXIgVjIuMSBjb25uZWN0ZWQgdG8gSGlIb3BlIFJaL0cyTQ0KICAg
ICAgYXJtNjQ6IGR0czogcmVuZXNhczogQWRkIHN1cHBvcnQgZm9yIE1JUEkgQWRhcHRlciBWMi4x
IGNvbm5lY3RlZCB0byBIaUhvcGUgUlovRzJIDQogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiBh
aXN0YXJ2aXNpb24tbWlwaS1hZGFwdGVyLTIuMTogQWRkIHBhcmVudCBtYWNybyBmb3IgZWFjaCBz
ZW5zb3INCiAgICAgIGFybTY0OiBkdHM6IHJlbmVzYXM6IHI4YTc3NGUxOiBBZGQgVklOIGFuZCBD
U0ktMiBub2Rlcw0KICAgICAgbWVkaWE6IHJjYXItY3NpMjogRW5hYmxlIHN1cHBvcnQgZm9yIFI4
QTc3NEUxDQogICAgICBtZWRpYTogZHQtYmluZGluZ3M6IG1lZGlhOiByZW5lc2FzLGNzaTI6IEFk
ZCBSOEE3NzRFMSBzdXBwb3J0DQogICAgICBtZWRpYTogcmNhci12aW46IEVuYWJsZSBzdXBwb3J0
IGZvciBSOEE3NzRFMQ0KICAgICAgbWVkaWE6IGR0LWJpbmRpbmdzOiBtZWRpYTogcmVuZXNhcyx2
aW46IEFkZCBSOEE3NzRFMSBzdXBwb3J0DQogICAgICBhcm02NDogZHRzOiByZW5lc2FzOiByOGE3
NzRiMTogQWRkIFZJTiBhbmQgQ1NJLTIgc3VwcG9ydA0KICAgICAgbWVkaWE6IHJjYXItY3NpMjog
RW5hYmxlIHN1cHBvcnQgZm9yIFI4QTc3NEIxDQogICAgICBtZWRpYTogZHQtYmluZGluZ3M6IHJj
YXItY3NpMjogQWRkIFI4QTc3NEIxIHN1cHBvcnQNCiAgICAgIG1lZGlhOiByY2FyLXZpbjogRW5h
YmxlIHN1cHBvcnQgZm9yIFI4QTc3NEIxDQogICAgICBtZWRpYTogZHQtYmluZGluZ3M6IHJjYXIt
dmluOiBBZGQgUjhBNzc0QjEgc3VwcG9ydA0KICAgICAgYXJtNjQ6IGR0czogcmVuZXNhczogcjhh
Nzc0YTE6IEFkZCBWSU4gYW5kIENTSS0yIG5vZGVzDQogICAgICBtZWRpYTogcmNhci1jc2kyOiBF
bmFibGUgc3VwcG9ydCBmb3IgcjhhNzc0YTENCiAgICAgIG1lZGlhOiBkdC1iaW5kaW5nczogbWVk
aWE6IHJjYXItY3NpMjogQWRkIHI4YTc3NGExIHN1cHBvcnQNCiAgICAgIG1lZGlhOiByY2FyLXZp
bjogRW5hYmxlIHN1cHBvcnQgZm9yIHI4YTc3NGExDQogICAgICBtZWRpYTogZHQtYmluZGluZ3M6
IG1lZGlhOiByY2FyX3ZpbjogQWRkIHI4YTc3NGExIHN1cHBvcnQNCiAgICAgIGFybTY0OiBkdHM6
IHJlbmVzYXM6IHI4YTc3NGMwLWNhdDg3NDogQWRkIHN1cHBvcnQgZm9yIEFJU1RBUlZJU0lPTiBN
SVBJIEFkYXB0ZXIgVjIuMQ0KICAgICAgbWVkaWE6IGkyYzogaW14MjE5OiB0YWtlIGxvY2sgaW4g
aW14MjE5X2VudW1fbWJ1c19jb2RlL2ZyYW1lX3NpemUNCiAgICAgIG1lZGlhOiBpMmM6IGlteDIx
OTogU2VsZWN0aW9uIGNvbXBsaWFuY2UgZml4ZXMNCiAgICAgIG1lZGlhOiBpMmM6IGlteDIxOTog
Rml4IGEgYnVnIGluIGlteDIxOV9lbnVtX2ZyYW1lX3NpemUNCiAgICAgIG1lZGlhOiBpMmM6IGlt
eDIxOTogSW1wbGVtZW50IGdldF9zZWxlY3Rpb24NCiAgICAgIG1lZGlhOiBpMmM6IGlteDIxOTog
QWRkIHN1cHBvcnQgZm9yIGNyb3BwZWQgNjQweDQ4MCByZXNvbHV0aW9uDQogICAgICBtZWRpYTog
aTJjOiBpbXgyMTk6IEFkZCBzdXBwb3J0IGZvciBSQVc4IGJpdCBiYXllciBmb3JtYXQNCiAgICAg
IG1lZGlhOiBpMmM6IGlteDIxOTogRml4IHBvd2VyIHNlcXVlbmNlDQogICAgICBtZWRpYTogaTJj
OiBBZGQgZHJpdmVyIGZvciBTb255IElNWDIxOSBzZW5zb3INCiAgICAgIG1lZGlhOiBkdC1iaW5k
aW5nczogbWVkaWE6IGkyYzogQWRkIElNWDIxOSBDTU9TIHNlbnNvciBiaW5kaW5nDQogICAgICBt
ZWRpYTogcmNhci1jc2kyOiBBZGQgc3VwcG9ydCBmb3IgTUVESUFfQlVTX0ZNVF9TUkdHQjhfMVg4
IGZvcm1hdA0KICAgICAgbWVkaWE6IHJjYXItdmluOiBBZGQgc3VwcG9ydCBmb3IgTUVESUFfQlVT
X0ZNVF9TUkdHQjhfMVg4IGZvcm1hdA0KICAgICAgbWVkaWE6IHJjYXItdmluOiBJbnZhbGlkYXRl
IHBpcGVsaW5lIGlmIGNvbnZlcnNpb24gaXMgbm90IHBvc3NpYmxlIG9uIGlucHV0IGZvcm1hdHMN
CiAgICAgIG1lZGlhOiByY2FyLWNzaTI6IFVwZGF0ZSBWM00gYW5kIEUzIHN0YXJ0IHByb2NlZHVy
ZQ0KICAgICAgbWVkaWE6IHJjYXItdmluOiBmaXggd3JvbmcgcmV0dXJuIHZhbHVlIGluIHJ2aW5f
c2V0X2NoYW5uZWxfcm91dGluZygpDQogICAgICBtZWRpYTogdjRsOiBjdHJsOiBQcm92aWRlIHVu
bG9ja2VkIHZhcmlhbnQgb2YgdjRsMl9jdHJsX2dyYWINCiAgICAgIG1lZGlhOiB2NGwyLWFzeW5j
OiBMb2cgbWVzc2FnZSBpbiBjYXNlIG9mIGhldGVyb2dlbmVvdXMgZndub2RlIG1hdGNoDQogICAg
ICBtZWRpYTogdjRsMi1hc3luYzogUGFzcyBub3RpZmllciBwb2ludGVyIHRvIG1hdGNoIGZ1bmN0
aW9ucw0KICAgICAgbWVkaWE6IHY0bDItYXN5bmM6IEFjY2VwdCBlbmRwb2ludHMgYW5kIGRldmlj
ZXMgZm9yIGZ3bm9kZSBtYXRjaGluZw0KICAgICAgbWVkaWE6IGRldmljZSBwcm9wZXJ0eTogQWRk
IGEgZnVuY3Rpb24gdG8gdGVzdCBpcyBhIGZ3bm9kZSBpcyBhIGdyYXBoIGVuZHBvaW50DQogICAg
ICBtZWRpYTogb3Y1NjQ1OiBSZW1vdmUgdW5uZWVkZWQgcmVndWxhdG9yX3NldF92b2x0YWdlKCkN
Cg0KQmVzdCByZWdhcmRzLA0KICAgTm9idWhpcm8NCg0KLS0NCk5vYnVoaXJvIEl3YW1hdHN1DQo=

--LHRklJE64a4jziBpQLrU
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-
Links: You receive all messages sent to this group.
View/Reply Online (#6332): https://lists.cip-project.org/g/cip-dev/message=
/6332
Mute This Topic: https://lists.cip-project.org/mt/81686460/4520388
Group Owner: cip-dev+owner@lists.cip-project.org
Unsubscribe: https://lists.cip-project.org/g/cip-dev/leave/8129055/4520388=
/727948398/xyzzy [cip-dev@archiver.kernel.org]
-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-=3D-


--LHRklJE64a4jziBpQLrU--
